//
// Created by 易培淮 on 2019/10/8.
//

#ifndef MFS2ALG_INTERNALCOMM_H
#define MFS2ALG_INTERNALCOMM_H


#include <boost/asio/io_context.hpp>
#include <future>
#include "signal.hpp"
#include "../util/threadPool.h"
#include "../core/baseContext.hpp"
#include "../com/base.h"
#include "../util/blockQueue.hpp"

namespace Ctrl{

    class InternalComm {
    public:
        explicit InternalComm(Tpool::ThreadPool &threadpool,BaseContext *context, bool isMaster);
        void run();
        void post(boost::function<void()>);
        void nofity(COMM::MPITagSet tag);
        //彻底退出
        void sendMsg(int);
        int  getMsg();
        void exit();
    private:
        void block();
        void unblock();

        bool m_isMaster;
        BaseContext *m_context;
        Signal_Exit *m_signal_exit;
        Tpool::ThreadPool &m_threadpool;//操作线程池
        boost::asio::io_context m_eventHandler; //用于事件循环
        boost::asio::io_context::work m_overwatch; //守护事件循环
        Util::BlockQueue<int> msg_queue_acceptTohandler;//线程间通信
    };
}



#endif //MFS2ALG_INTERNALCOMM_H
