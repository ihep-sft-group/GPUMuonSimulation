#ifndef SERVER_H
#define SERVER_H

#include "mpi.h"
#include "nodeAgent.h"
#include "../util/threadPool.h"
#include "../control/internalComm.h"
#include "../util/MFSHash.h"
#include <boost/typeof/typeof.hpp>
#include <boost/thread/thread.hpp>
#include <boost/bind.hpp>
#include <boost/mpi/environment.hpp>
#include <boost/mpi/exception.hpp>
#include <boost/mpi/status.hpp>
#include <boost/mpi/communicator.hpp>
#include <boost/unordered_map.hpp>
#include <boost/optional.hpp>

namespace COMM{


class Server{
public:
    explicit Server(NodeAgent  &node, int, Util::MFSHash &);
    ~Server();
    //获取客户端连接的端口
    const char* getPortName() const;
    //打开端口
    void open() throw (boost::mpi::exception);
    void open(std::string filepath) throw (boost::mpi::exception);
    //关闭端口
    void close() throw (boost::mpi::exception);
    //退出
    void exit();
    //运行服务器，handler用于处理收到的消息
    template <typename H>
    void run (H &handler){
        open();
        accept(handler,m_nodenum);
    }

    void run (std::string &filepath,Ctrl::InternalComm &intercomm){
        open(filepath);
        m_accept_thread = new boost::thread(boost::bind(&Server::accept_svc,this,std::ref(intercomm)));
    }

    //发送数据
    static boost::optional<int> send(const boost::mpi::communicator &, const std::string&,int clientid);
    //用于退出框架
    static boost::optional<int> sendCtrl(const boost::mpi::communicator &,COMM::MPITagSet tag,int id);
    //接收数据
    static boost::optional<std::string> recv(const boost::mpi::communicator &,int source,int tag) throw (boost::mpi::exception);

    //断开连接
    static void disconnect(const boost::mpi::communicator& client);

private:
    int m_nodenum;
    NodeAgent &m_node;
    std::string m_filepath;
    boost::mpi::environment *m_env;
    char port_name[MPI_MAX_PORT_NAME];
    boost::thread *m_accept_thread;
    Util::MFSHash &m_nodeHashMgr;

    void _accept(MPI_Comm &comm){
        int err = MPI_Comm_accept(port_name, MPI_INFO_NULL, 0, MPI_COMM_SELF, reinterpret_cast<MPI_Comm *>(comm));
    }

    void accept_svc(Ctrl::InternalComm &intercomm){
        int err,n;
        MPI_Comm comm;
        int node_count = 0;
        while(true){
            try{
                err = MPI_Comm_accept(port_name,MPI_INFO_NULL,0,MPI_COMM_SELF,&comm);
                if(err != MPI_SUCCESS){
                    boost::throw_exception(boost::mpi::exception("MPI_Comm_accept",err));
                }
                BOOST_ASSERT(comm != MPI_COMM_NULL);
                err = MPI_Comm_set_errhandler(comm, MPI_ERRORS_RETURN);
                if(err != MPI_SUCCESS){
                    boost::throw_exception(boost::mpi::exception("MPI_Comm_set_errhandler",err));
                }
                boost::mpi::communicator client(comm, boost::mpi::comm_attach);
                BOOST_ASSERT(client);
                std::cout<<"[master] get new node "<< node_count<<std::endl;
                m_node.client_dic.emplace(node_count, client);
                if(node_count!=0) {
                    m_nodeHashMgr.addNode(node_count);
                }
                intercomm.sendMsg(node_count);
                node_count++;
            }
            catch(boost::thread_interrupted& ){
                break;
            }
            catch(boost::mpi::exception e){
                //
                std::cout<<e.what()<<std::endl \
        <<e.routine()<<std::endl \
        <<e.result_code() <<std::endl;
            }
        }//通过中断来退出
    }

    //接收客户端连接，handler用于处理收到的消息
    template <typename H>
    void accept(H &handler,int nodenum){
        int err,n;
        MPI_Comm comm;
        int node_count = 0;
        do{
            try{
                err = MPI_Comm_accept(port_name,MPI_INFO_NULL,0,MPI_COMM_SELF,&comm);
                if(err != MPI_SUCCESS){
                    boost::throw_exception(boost::mpi::exception("MPI_Comm_accept",err));
                }
                BOOST_ASSERT(comm != MPI_COMM_NULL);
                err = MPI_Comm_set_errhandler(comm, MPI_ERRORS_RETURN);
                if(err != MPI_SUCCESS){
                    boost::throw_exception(boost::mpi::exception("MPI_Comm_set_errhandler",err));
                }
                boost::mpi::communicator client(comm, boost::mpi::comm_attach);
                BOOST_ASSERT(client);
                m_node.client_dic.emplace(node_count, client);
                handler.run(node_count);
                node_count++;
            }
            catch(boost::mpi::exception e){
                //
                std::cout<<e.what()<<std::endl \
                <<e.routine()<<std::endl \
                <<e.result_code() <<std::endl;
            }
        }while(nodenum-node_count);
    }
};

}
#endif /* SERVER_H */