//
// Created by 易培淮 on 2019/10/10.
//

#ifndef MFS2ALG_INTERNALQUEUE_H
#define MFS2ALG_INTERNALQUEUE_H

#include "../util/blockQueue.hpp"


extern Util::BlockQueue<std::string> sniperToMfs;
extern Util::BlockQueue<std::string> mfsToSniper;

///@todo 流量控制

//线程间通信
extern boost::mutex g_mutex;
extern boost::mutex::scoped_lock g_lock;
extern boost::condition_variable g_condition_variable;
extern bool g_enableSafeMode;
#endif //MFS2ALG_INTERNALQUEUE_H
