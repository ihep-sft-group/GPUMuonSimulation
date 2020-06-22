//
// Created by 易培淮 on 2019/10/2.
//
#ifndef MFS2ALG_MASTER_HANDLER_H
#define MFS2ALG_MASTER_HANDLER_H


#include "../com/nodeAgent.h"
#include "../util/threadPool.h"
#include "../control/internalComm.h"

class MasterHandler {
public:
    explicit MasterHandler(COMM::NodeAgent  &node, Tpool::ThreadPool &pool);
    MasterHandler(MasterHandler const &handler, Tpool::ThreadPool &mPool, COMM::NodeAgent &mNode);
    virtual ~MasterHandler()= default;
    void run(int);
    void run(Ctrl::InternalComm &internalComm);
    void work( int ) throw (boost::mpi::exception);
    void _work(Ctrl::InternalComm &internalComm);
    void exit();

private:
    bool isMStop() const;
    void setMStop(bool mStop);
    void handler(int source,int tag,int client_id);
    bool m_stop;
    COMM::NodeAgent  &m_node;
    Tpool::ThreadPool &m_pool;
    mutable boost::mutex m_mutex;
    boost::thread *m_handler_thread;
    boost::mutex::scoped_lock m_lock;
    boost::condition_variable m_condition_variable;
};



#endif //MFS2ALG_MASTER_HANDLER_H



