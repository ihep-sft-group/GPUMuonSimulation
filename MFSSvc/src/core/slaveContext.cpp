//
// Created by 易培淮 on 2019/10/11.
//

#include "slaveContext.h"

SlaveContext::SlaveContext()
        : m_threadpool(3), m_sendManager(m_nodeAgent), m_internalComm(m_threadpool,this, false),
          m_slavehanlder(m_nodeAgent,m_threadpool,m_internalComm), m_sniperhandler(false,m_threadpool,m_sendManager){
    m_threadpool.start();
    m_coreclient = new COMM::Client(m_nodeAgent);
    m_coreclient->run(m_slavehanlder);
    m_sniperhandler.run();//开始接收sniper消息
}

SlaveContext::SlaveContext(std::string filePath)
        : m_threadpool(3), m_sendManager(m_nodeAgent), m_internalComm(m_threadpool,this, false),
          m_slavehanlder(m_nodeAgent,m_threadpool,m_internalComm), m_sniperhandler(false,m_threadpool,m_sendManager){
    m_threadpool.start();
    m_coreclient = new COMM::Client(m_nodeAgent);
    m_coreclient->run(m_slavehanlder,filePath);
    m_sniperhandler.run();//开始接收sniper消息
}

SlaveContext::~SlaveContext() {
    free(m_coreclient);
    m_coreclient = nullptr;
}

void SlaveContext::exit() { // 子节点不必主动调用,由接收线程通知
    setMEnable(false);
    m_sendManager.exit();//发送通道关闭
    m_slavehanlder.exit();//接收通道关闭
    if(m_sniperhandler.isMEnable()){//如果sniper接收线程未退出，则主线程因没有收到消息被阻塞
        mfsToSniper.push("");
    }
    //如果收到了主节点的消息，则接收通道自动关闭
    m_coreclient->exit();//
    m_internalComm.exit();//解除MFS主线程阻塞，停止事件响应
    if(m_nodeAgent.parent){//关闭线程池
        m_threadpool.shutdownGracefully();
//        m_threadpool.shutdown();
    }
    else{
        m_threadpool.shutdown();
    }
    // std::cout<<"[client] finish"<<std::endl;
}

void SlaveContext::run() {
//    m_condition_variable.wait(m_lock);
    m_internalComm.run();
}

void SlaveContext::setEnable() {
    while(!isMEnable()){
        m_internalComm.post(boost::bind(&SlaveContext::_setEnable,this));
    }
}

void SlaveContext::_setEnable() {
    setMEnable(true);
}





