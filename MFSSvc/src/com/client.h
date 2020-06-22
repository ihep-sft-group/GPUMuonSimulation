#ifndef CLIENT_H
#define CLIENT_H

//#include "mpi.h"
#include <boost/mpi/exception.hpp>
#include <boost/mpi/environment.hpp>
#include <boost/mpi/communicator.hpp>
#include "nodeAgent.h"
#include "base.h"

namespace COMM
{
class Client{//slave
public:
    //init node 
    explicit Client(NodeAgent& node);
    ~Client();
    void autoConnect();
    void autoConnect(std::string filepath);

    void connect(const char* port_name) throw (boost::mpi::exception);

    template <typename H>
    void run (H &handler){
        autoConnect();
        handler.run();
    }

    template <typename H>
    void run (H &handler,std::string filepath){
        autoConnect(filepath);
        handler.run();
    }
    
    void exit();

    static void passiveDisconnect(const boost::mpi::communicator &);

    void activeDisconnect();

    void send(std::string str);

    static void sendCtrl(boost::mpi::communicator,COMM::MPITagSet tag);

    static void send(boost::mpi::communicator ,std::string str);//

    static std::string recv(const boost::mpi::communicator &,int,int);//

private:
    NodeAgent &node;//nodelist = master
    boost::mpi::environment *m_env;//


};

} // namespace COMM

#endif
