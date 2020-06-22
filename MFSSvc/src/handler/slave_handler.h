//
// Created by 易培淮 on 2019/12/2.
//

#ifndef MFS2ALG_SLAVE_HANDLER_H
#define MFS2ALG_SLAVE_HANDLER_H


#include "../util/threadPool.h"
#include "../com/nodeAgent.h"
#include "../control/internalComm.h"

class SlaveHandler {

public:
    explicit SlaveHandler(COMM::NodeAgent &node, Tpool::ThreadPool &pool, Ctrl::InternalComm &internalComm);

    virtual ~SlaveHandler() = default;

    void run();

    void work();

    bool isMStop() const;

    void setMStop(bool mStop);

    void exit();


private:
    void handler(int source, int tag);

    bool m_stop;
    COMM::NodeAgent &m_node;
    Tpool::ThreadPool &m_pool;
    Ctrl::InternalComm &m_internalComm;

private:
    mutable boost::mutex m_mutex;
    boost::condition_variable m_condition_variable;
    boost::mutex::scoped_lock m_lock;
};


#endif //MFS2ALG_SLAVE_HANDLER_H
