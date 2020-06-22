#ifndef NODEAGENT_H
#define NODEAGENT_H

#include <boost/mpi/communicator.hpp>
#include <map>
#include "base.h"
// #include "../util/forward_list.hpp"

namespace COMM {
    struct NodeAgent {
        NodeAgent();

        //与服务器通信器
        boost::mpi::communicator parent;
        //自己
        boost::mpi::communicator self;
        //与客户端的通信器
        // Util::forward_list<boost::mpi::communicator> clients;
        //待处理的请求
        // Util::forward_list<boost::mpi::request> requests;
        //客户端的通信器
        // boost::unordered_map<int,boost::mpi::communicator> client_dic;
        std::map<int,boost::mpi::communicator> client_dic;
    };
}

#endif