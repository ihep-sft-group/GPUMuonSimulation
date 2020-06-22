//
// Created by 易培淮 on 2019/10/2.
//

#include "master_handler.h"
#include "../com/server.h"
#include "../com/comm.hpp"

bool MasterHandler::isMStop() const {
    return m_stop;
}

void MasterHandler::setMStop(bool mStop) {
    m_stop = mStop;
}

MasterHandler::MasterHandler(COMM::NodeAgent &node, Tpool::ThreadPool &pool)
        : m_node(node), m_stop(false), m_pool(pool), m_lock(m_mutex) {
}

void MasterHandler::run(int client_id) {
    m_pool.execute(&MasterHandler::work, this, client_id);
}

void MasterHandler::run(Ctrl::InternalComm &intercomm) {
    m_handler_thread = new boost::thread(boost::bind(&MasterHandler::_work,this, std::ref(intercomm)));
}

void MasterHandler::_work(Ctrl::InternalComm &internalComm){
    while(true){
        try {
            int client_id = internalComm.getMsg();
            m_pool.execute(&MasterHandler::work, this, client_id);
        }
        catch (boost::thread_interrupted&){
            break;
        }
    }
}

void MasterHandler::work(int client_id) throw(boost::mpi::exception) {
    boost::mpi::communicator client = m_node.client_dic.at(client_id);
    boost::mpi::status status;
    while (!m_stop) {
        try {
            status = client.probe();
            handler(status.source(), status.tag(), client_id);
        }
        catch (boost::mpi::exception &) {
            std::cout<<"[master] client "<<client_id<<" lose."<<std::endl;
            m_node.client_dic.erase(client_id);
            break;
        }
        catch(boost::thread_interrupted& ){
            break;
        }
    }
    // std::cout << "[Master] client "<<client_id<<"recv module close \n";
    m_condition_variable.notify_one();
}


void MasterHandler::handler(int source, int tag, int client_id) {
    boost::mpi::communicator client = m_node.client_dic.at(client_id);
    if (tag == static_cast<int>(COMM::MPITagSet::MFS_TAG_DISCONNECT)) { // 断开连接
        COMM::Server::recv(client, source, tag);
        COMM::Server::disconnect(client);
        m_node.client_dic.erase(client_id);
    } else if (tag == static_cast<int>(COMM::MPITagSet::MFS_TAG_CTOSMSG)) { // 正常通信
        auto msg = COMM::Server::recv(client, source, tag);
        if(msg){
            mfsToSniper.push(*msg);
        }
        else{
            std::cout << "[Master] a task recv fail. \n";
            ///没收到数据，需重新发送任务
        }
        ///@todo 流量控制
    } else if (tag == static_cast<int>(COMM::MPITagSet::MFS_TAG_DIAGNOSIS)) { //心跳信号
        ///@todo 收到心跳信号、处理
        COMM::Server::recv(client, source, tag);

    } else if (tag == static_cast<int>(COMM::MPITagSet::MFS_TAG_CTOSEXIT)) { //关闭接收循环
        COMM::Server::recv(client, source, tag);
        setMStop(true);
        std::cout << "[Master recv] close ack\n";
    }
}

//必须在接收到信息之后调用
void MasterHandler::exit() {//仅限外部调用
    m_handler_thread->interrupt();
    setMStop(true);
    m_condition_variable.wait(m_lock);
    free(m_handler_thread);
    m_handler_thread = nullptr;
}

MasterHandler::MasterHandler(MasterHandler const &handler, Tpool::ThreadPool &mPool, COMM::NodeAgent &mNode)
        : m_pool(mPool), m_node(mNode) {
}





