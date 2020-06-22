#include "client.h"
#include <boost/mpi/environment.hpp>
#include "../util/file.h"

COMM::Client::Client(NodeAgent &node) : node(node) {
    //
    m_env = new boost::mpi::environment(boost::mpi::threading::multiple);
}

COMM::Client::~Client() {
    free(m_env);
    m_env = nullptr;
}

void COMM::Client::autoConnect() {
    try {
        connect(Util::getServerPort().c_str());
        //连接成功后开启另一个线程监听消息
    }
    catch (boost::mpi::exception e) {
        ///@todo 客户端连接服务器失败
        //随机等待一定时间多尝试几次，然后再彻底退出
        std::cout << e.what() << std::endl \
 << e.routine() << std::endl \
 << e.result_code() << std::endl;
    }
}
void COMM::Client::autoConnect(std::string filepath) {
    try {
        connect(Util::getServerPort(filepath).c_str());
        //连接成功后开启另一个线程监听消息
    }
    catch (boost::mpi::exception e) {
        ///@todo 客户端连接服务器失败
        //随机等待一定时间多尝试几次，然后再彻底退出
        std::cout << e.what() << std::endl \
 << e.routine() << std::endl \
 << e.result_code() << std::endl;
    }
}

void COMM::Client::connect(const char *port_name) throw(boost::mpi::exception) {
    MPI_Comm comm;
    int err = MPI_Comm_connect(const_cast<char *>(port_name), MPI_INFO_NULL, 0, MPI_COMM_SELF, &comm);
    if (err != MPI_SUCCESS) {
        boost::throw_exception(boost::mpi::exception("MPI_Comm_connect", err));
    }

    err = MPI_Comm_set_errhandler(comm, MPI_ERRORS_RETURN);
    if (err != MPI_SUCCESS) {
        boost::throw_exception(
                boost::mpi::exception("MPI_Comm_set_errhandler", err));
    }
    const MPI_Comm &c_comm = comm;
    boost::mpi::communicator parent(c_comm, boost::mpi::comm_attach);
    node.parent = parent;
}

void COMM::Client::passiveDisconnect(const boost::mpi::communicator &server) {
    try {
        MPI_Comm comm = server;
        int err = MPI_Comm_disconnect(&comm);
        if (err != MPI_SUCCESS) {
            boost::throw_exception(boost::mpi::exception("MPI_Comm_disconnect", err));
        }
    } catch (boost::mpi::exception &e) {
        //
        std::cout << e.what() << std::endl \
        << e.routine() << std::endl \
        << e.result_code() << std::endl;
    }
}

void COMM::Client::activeDisconnect() {
    try {
        node.parent.isend(0, static_cast<int>(COMM::MPITagSet::MFS_TAG_DISCONNECT));
        MPI_Comm server = node.parent;
        int err = MPI_Comm_disconnect(&server);
        if (err != MPI_SUCCESS) {
            boost::throw_exception(boost::mpi::exception("MPI_Comm_disconnect", err));
        }
    } catch (boost::mpi::exception &e) {
        //
        std::cout << e.what() << std::endl \
        << e.routine() << std::endl \
        << e.result_code() << std::endl;
    }
    boost::mpi::communicator parent(MPI_COMM_NULL, boost::mpi::comm_attach);
    node.parent = parent;
}


void COMM::Client::send(std::string str) {
    if (node.parent) { // comm not MPI_COMM_NULL
        node.parent.send(0, static_cast<int>(COMM::MPITagSet::MFS_TAG_CTOSMSG), str);
    }
}

//发送控制信息给主节点
void COMM::Client::sendCtrl(boost::mpi::communicator master, COMM::MPITagSet tag) {
    master.send(0, static_cast<int>(tag));
}

void COMM::Client::send(boost::mpi::communicator master, std::string str) {
    master.send(0, static_cast<int>(COMM::MPITagSet::MFS_TAG_CTOSMSG), str);
    ///没有1,只有0
}

std::string COMM::Client::recv(const boost::mpi::communicator &master, int source, int tag) {
    std::string str = "";
    if(tag != static_cast<int>(COMM::MPITagSet::MFS_TAG_STOCMSG)){
        master.recv(source, tag);
    }
    else{
        master.recv(source, tag, str);
    }
    return str;
}

void COMM::Client::exit() {
    //do nothing
    std::cout<<"comm module close\n";
}





