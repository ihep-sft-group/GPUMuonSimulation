#ifndef THREADPOOL_H
#define THREADPOOL_H

#include <boost/asio/io_context.hpp>
#include <boost/thread/thread.hpp>
#include <boost/bind.hpp>
#include <iostream>

namespace Tpool
{
    class ThreadPool
    {
    public:
        //Default Pool Size
        static const int DEFAULT_POOL_SIZE = 3;

        //Constructor 
        ThreadPool(int poolSize = DEFAULT_POOL_SIZE);
        
        //Destructor
        virtual ~ThreadPool();

        //start the pool
        void start();

        //stop the pool
        void shutdown();

        //shutdown after jobs are done
        void shutdownGracefully();
        
        //do the job of F
        template<class F, class... Args> void execute(F f, Args &&... args)
        {
            ioContext.post(boost::bind(f, std::forward<Args>(args)...));
        };


    protected:
        //I/O sync loop
        boost::asio::io_context ioContext;

        //Thread container
        boost::thread_group pool;

        //Worker to inform ioContext when it has work to do
        boost::asio::io_context::work* worker;
                
        //Pool size
        int size;

        //stop ioContext
        void _shutdown();
    };

}  //namespace Tpool


#endif //THREADPOOL_H