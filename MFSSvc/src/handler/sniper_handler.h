//
// Created by 易培淮 on 2019/12/10.
//

#ifndef MFS2ALG_SNIPER_HANDLER_H
#define MFS2ALG_SNIPER_HANDLER_H

#include "../util/threadPool.h"
#include "../com/comm.hpp"

//阻塞队列
class SniperHandler {
public:
    explicit SniperHandler(bool,Tpool::ThreadPool &threadpool,COMM::CommManager &sendManager);
    ~SniperHandler();
    void run();
    void _work();
    void exit();

private:
    Tpool::ThreadPool &m_threadpool;
    COMM::CommManager &m_sendManager;
    bool m_isMaster;
    bool m_enable;
    uint32_t m_task_count;//for hash
    
public:
    bool isMEnable() const;
    void setMEnable(bool mEnable);
};


#endif //MFS2ALG_SNIPER_HANDLER_H
