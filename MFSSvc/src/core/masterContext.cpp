//
// Created by 易培淮 on 2019/10/11.
//
#include "masterContext.h"

MasterContext::MasterContext(int clientNum)   // 与slave通信（clientNum）、Sniper通信(1)，线程同步(1,wait)
        : m_threadpool(clientNum + 2),m_taskmgr(clientNum),m_nodeHashMgr(1,200) ,m_sendManager(m_nodeAgent,m_taskmgr,m_nodeHashMgr), m_masterhandler(m_nodeAgent, m_threadpool),
          m_internalComm(m_threadpool, this, true), m_sniperhandler(true, m_threadpool, m_sendManager) {
    m_threadpool.start();
    m_coreserver = new COMM::Server(m_nodeAgent, clientNum,m_nodeHashMgr);
    m_nodeHashMgr.init();
    m_coreserver->run(m_masterhandler);//服务器接收线程开始执行
    m_sniperhandler.run();//开始接收sniper消息
}

MasterContext::MasterContext(int clientNum, std::string &filePath) // 与slave通信（2*clientNum）、Sniper通信(1)，线程同步(1,wait)
        : m_threadpool(2*clientNum + 2),m_taskmgr(clientNum),m_nodeHashMgr(1,200) ,m_sendManager(m_nodeAgent,m_taskmgr,m_nodeHashMgr), m_masterhandler(m_nodeAgent, m_threadpool),
          m_internalComm(m_threadpool, this, true), m_sniperhandler(true, m_threadpool, m_sendManager) {
    m_threadpool.start();
    m_coreserver = new COMM::Server(m_nodeAgent, clientNum,m_nodeHashMgr);
    m_nodeHashMgr.init();
    m_masterhandler.run(m_internalComm);
    m_coreserver->run(filePath,m_internalComm);
    m_sniperhandler.run();//开始接收sniper消息
}

MasterContext::~MasterContext() {
    free(m_coreserver);
    m_coreserver = nullptr;
}

void MasterContext::exit() {
    setMEnable(false);
    m_sendManager.exit(); //发送通道关闭，向子节点发送退出信息
    m_masterhandler.exit();//接收通道关闭,flag = false
    m_coreserver->exit();//MPI通信器关闭端口
    m_internalComm.exit();//解除MFS主线程阻塞，停止响应事件
    if (m_nodeAgent.client_dic.empty()) { //关闭线程池
        m_threadpool.shutdown();
    } else {
//        m_threadpool.shutdown();
        m_threadpool.shutdownGracefully();
    }
    // std::cout << "[master] finish" << std::endl;
}

void MasterContext::run() {
    m_internalComm.run();//节点内部事件处理线程开始执行，并阻塞本线程
}



void MasterContext::setEnable() {
    while(!isMEnable()){
        m_internalComm.post(boost::bind(&MasterContext::_setEnable, this));
    }
}

void MasterContext::_setEnable() {
    setMEnable(true);
}