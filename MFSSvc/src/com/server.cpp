#include "server.h"
#include "../util/file.h"
#include "comm.hpp"
#include <boost/typeof/typeof.hpp>
#include <boost/mpi/communicator.hpp>


COMM::Server::Server(COMM::NodeAgent &node, int client_num,Util::MFSHash &mfshash) : m_node(node), m_nodenum(client_num),m_nodeHashMgr(mfshash){
    m_env = new boost::mpi::environment(boost::mpi::threading::multiple);
}

COMM::Server::~Server() {
    free(m_env);
    m_env = nullptr;
}

const char *COMM::Server::getPortName() const{
    return port_name;
}

void COMM::Server::open() throw (boost::mpi::exception){
    int err = MPI_Open_port(MPI_INFO_NULL, port_name);
    if (err != MPI_SUCCESS) {
        boost::throw_exception(boost::mpi::exception("MPI_Open_port", err));
    }
    Util::saveServerPort(port_name);
}

void COMM::Server::open(std::string filepath) throw (boost::mpi::exception){
    int err = MPI_Open_port(MPI_INFO_NULL, port_name);
    if (err != MPI_SUCCESS) {
        boost::throw_exception(boost::mpi::exception("MPI_Open_port", err));
    }
    m_filepath = filepath;
    Util::saveServerPort(port_name,filepath);
}

void COMM::Server::close() throw (boost::mpi::exception){
    int err = MPI_Close_port(port_name);
    if (err != MPI_SUCCESS) {
        boost::throw_exception(boost::mpi::exception("MPI_Close_port", err));
    }
}

void COMM::Server::disconnect(const boost::mpi::communicator& client){
    try{
        MPI_Comm comm = client;
        int err = MPI_Comm_disconnect(&comm);
        if (err != MPI_SUCCESS) {
            boost::throw_exception(boost::mpi::exception("MPI_Comm_disconnect", err));
        }
    }
    catch(boost::mpi::exception &e){
        std::cout<<e.what()<<std::endl \
            <<e.routine()<<std::endl \
            <<e.result_code() <<std::endl;
    }
}


boost::optional<int> COMM::Server::send(const boost::mpi::communicator& toclient, const std::string& str,int clientid){
    try {
        toclient.send(0, static_cast<int>(COMM::MPITagSet::MFS_TAG_STOCMSG), str);
    }catch (boost::mpi::exception&){
        return clientid;
    }
    return boost::optional<int>{};
}

boost::optional<int> COMM::Server::sendCtrl(const boost::mpi::communicator &toclient,COMM::MPITagSet tag,int clientid){
    try{
        toclient.send(0, static_cast<int>(tag));
    }catch (boost::mpi::exception&){
        return clientid;
    }
    return boost::optional<int>{};
}

boost::optional<std::string> COMM::Server::recv(const boost::mpi::communicator &client, int source, int tag) throw (boost::mpi::exception) {
    std::string msg = "";
    BOOST_ASSERT(client);
    ///@todo 超时机制
    try{
        if(tag != static_cast<int>(COMM::MPITagSet::MFS_TAG_CTOSMSG)){
            boost::mpi::status status = client.recv(0,tag);
            return msg;
        }
        else{
            boost::mpi::status status = client.recv(0,tag,msg);
            return msg;
        }
    }
    catch (boost::mpi::exception&){
        return boost::optional<std::string>{};
    }
}

void COMM::Server::exit() {
    m_accept_thread->interrupt();//关闭节点接收
    close();//关闭端口
    Util::rmConfigFile(m_filepath);//主节点删除配置文件
    // std::cout<<"comm module close\n";
    free(m_accept_thread);
    m_accept_thread = nullptr;
}



