#ifndef MFS2ALG_COMM_HPP
#define MFS2ALG_COMM_HPP

#include <boost/mpi/environment.hpp>
#include <boost/mpi/communicator.hpp>
#include "client.h"
#include "server.h"
#include "../control/taskMgr.h"
#include "../control/internalQueue.h"
#include "../util/MFSHash.h"

//用于标识消息类型
namespace COMM {

    class CommManager {
    public:
        explicit CommManager(COMM::NodeAgent &node) : node(node),enable(true) {

        }

        virtual ~CommManager() = default;
        virtual void _send(std::string str) = 0;
        virtual void _send(std::string str,uint32_t id) = 0;
        virtual void exit() = 0;

        void send(std::string str){
            if(isEnable()){
                _send(str);
            }
            else{
                std::cout<<"[error] send manager is close "<<str<<std::endl;
            }
        }

        void send(std::string str,uint32_t id){
            if(isEnable()){
                _send(str,id);
            }
            else{
                std::cout<<"[error] send manager is close "<<str<<std::endl;
            }
        }

        void sendToSelf(MPITagSet tag) { 
            node.self.send(0, static_cast<int>(tag));
        }

        COMM::NodeAgent &node;
        bool enable;

        bool isEnable() const {
            return enable;
        }

        void setEnable(bool menable) {
            CommManager::enable = menable;
        }
    };


    class ClientManager : public CommManager {
    public:
        explicit ClientManager(COMM::NodeAgent &node) : CommManager(node) {

        }

        void _send(std::string str) override {
            if (node.parent) {
                COMM::Client::send(node.parent, str);
            } else {
                ///@todo null server error handler
            }
        }

        void _send(std::string str,uint32_t id) override {
            if (node.parent) {
                COMM::Client::send(node.parent, str);
            } else {
                ///@todo null server error handler
            }
        }

        //返回给主节点ACK表示正在退出
        void exit() override {
            if (node.parent) {
                COMM::Client::sendCtrl(node.parent,COMM::MPITagSet::MFS_TAG_CTOSEXIT);
            } else {
                ///@todo null server error handler
            }
            setEnable(false);
        }
    };

    class ServerManager : public CommManager {
    public:
        explicit ServerManager(COMM::NodeAgent &node, Ctrl::TaskMgr &taskMgr, Util::MFSHash &hashMgr)
            : CommManager(node),client_index(0),m_taskmgr(taskMgr),m_nodehashmgr(hashMgr) {
        }

        void _send(std::string str) override {
            ///@deprecated
            ///哈希到指定节点上去
            while(node.client_dic.empty()){
                sleep(1);//等待1秒，等子节点连接
            }
            if (!node.client_dic.empty()) {
                int id = getNextIndex(str);
                // std::cout << "[debug master] _send to client " << id  << std::endl;
                if(g_enableSafeMode){
                    m_taskmgr.push(str,id);//存储任务
                }
                auto item = node.client_dic.at(id);
                if(item){
                    COMM::Server::send(item, str, -1);
                }
            } else {
                ///@todo null server error handler
            }
        }

        void _send(std::string str, uint32_t tid) override {
            ///哈希到指定节点上去
            bool isSuccess = false;
            while(!isSuccess) {
                while (node.client_dic.empty()) {
                    sleep(1);//等待1秒，等子节点连接
                    std::cout << "[master] waiting for client connect" << std::endl;
                }
                BOOST_ASSERT(!node.client_dic.empty());
                std::string idstr = std::to_string(tid);
                // int id = getNextIndex(idstr);
                int id = getNextIndex();//just for test
                // std::cout << "[debug master] send to client " << id  << std::endl;
                auto item = node.client_dic.at(id);
                while (!item) {
                    m_taskmgr.remove(id);
                    id = getNextIndex();
                }
                if (g_enableSafeMode) {
                    m_taskmgr.push(str, id);//存储任务
                }
                // std::cout << "[debug master] send to client " << id  << std::endl;
                auto clientid = COMM::Server::send(item, str, id);
                if (clientid) {
                    std::cout << "[master] client " << *clientid << " lose." << std::endl;
                    deleteNode(*clientid);
                    m_taskmgr.remove(*clientid);//删除该任务
                }else{
                    isSuccess = true;
                    break;//发送成功直接退出
                }
            }
        }

        //通知所有子节点退出
        void exit() override {
            if (!node.client_dic.empty()) {
                for (auto item : node.client_dic)
                    if(item.second){
                        COMM::Server::sendCtrl(item.second,COMM::MPITagSet::MFS_TAG_STOCEXIT,-1);
                    }
            } else {
                ///@todo null server error handler
            }
            setEnable(false);
        }

    private:
        int client_index;
        Ctrl::TaskMgr &m_taskmgr;
        Util::MFSHash &m_nodehashmgr;
        int getNextIndex(){
            int temp = client_index;
            client_index = (client_index+1)%node.client_dic.size();
            return temp;
        }
        int getNextIndex(std::string &str){
            int temp = m_nodehashmgr.getId(str.c_str());
            return temp;
        }
        void deleteNode(int clientid){
            m_nodehashmgr.deleteNode(clientid);
            node.client_dic.erase(clientid);
        }
        //主动删除子节点
        void active_deleteNode(int clientid){
            m_nodehashmgr.deleteNode(clientid);
            COMM::Server::sendCtrl(node.client_dic.at(clientid),COMM::MPITagSet::MFS_TAG_DISCONNECT,-1);
        }
    };
}

#endif //MFS2ALG_COMM_HPP








