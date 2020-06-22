//
// Created by 易培淮 on 2019/10/10.
//
#include "internalQueue.h"


Util::BlockQueue<std::string> sniperToMfs;
Util::BlockQueue<std::string> mfsToSniper;



boost::mutex g_mutex;
boost::mutex::scoped_lock g_lock(g_mutex);
boost::condition_variable g_condition_variable;
bool g_enableSafeMode;