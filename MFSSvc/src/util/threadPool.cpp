//
// Created by 易培淮 on 2019/10/5.
//
#include "threadPool.h"

Tpool::ThreadPool::ThreadPool(int poolSize /*= DEFAULT_POOL_SIZE*/)
{
    size = poolSize > 0 ? poolSize : DEFAULT_POOL_SIZE;
    worker = nullptr;
}

Tpool::ThreadPool::~ThreadPool()
{
    if (worker != nullptr && !ioContext.stopped())
    {
        _shutdown();
        delete worker;
        worker = nullptr;
    }
}

void Tpool::ThreadPool::start()
{
    if (worker != nullptr)
    {
        return;
    }

    worker = new boost::asio::io_context::work(ioContext);

    for (int i = 0; i < size; i++)
    {
        pool.create_thread(boost::bind(&boost::asio::io_context::run, &ioContext));
    }
}

void Tpool::ThreadPool::shutdown()
{
    pool.interrupt_all();
    _shutdown();
}

void Tpool::ThreadPool::shutdownGracefully()
{
    _shutdown();
    // shutdown();
    pool.join_all();
    // std::cout<<"thread pool close\n";
}


void Tpool::ThreadPool::_shutdown()
{
    ioContext.reset();//先重置后停止。再次启动还需重置
    while(!ioContext.stopped()){
        ioContext.stop();
    }

}