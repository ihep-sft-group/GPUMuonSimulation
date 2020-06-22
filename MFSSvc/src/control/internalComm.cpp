//
// Created by 易培淮 on 2019/10/8.
//

#include "internalComm.h"
#include "../com/base.h"

void Ctrl::InternalComm::run() {
    std::cout<<"init finish\n";
    this->block();
}

void Ctrl::InternalComm::block() {
    m_eventHandler.reset();
    m_eventHandler.run();
}

void Ctrl::InternalComm::unblock() {
    m_eventHandler.reset();
    m_eventHandler.stop();
    // std::cout<<"MFS event loop unblock\n";
}


Ctrl::InternalComm::InternalComm(Tpool::ThreadPool &threadpool,BaseContext *context, bool isMaster)
        : m_overwatch(m_eventHandler), m_threadpool(threadpool), m_context(context), m_isMaster(isMaster) {
    m_signal_exit = &Ctrl::Singleton<Ctrl::Signal_Exit>::instance();
    ///@todo 连接响应函数
    if(isMaster){
        ///@todo 主节点通信
    }
    else{
        m_signal_exit->connect(&Ctrl::InternalComm::post,this,boost::bind(&BaseContext::exit,context));
    }
}

void Ctrl::InternalComm::nofity(COMM::MPITagSet tag) {
    if(tag == COMM::MPITagSet::MFS_TAG_CTOSEXIT || tag == COMM::MPITagSet::MFS_TAG_STOCEXIT){
        m_signal_exit->notify(0);
    }
}

void Ctrl::InternalComm::exit() {
    ///@todo 退出机制
    // std::cout<<"MFS event loop exiting\n";
    unblock();//解除阻塞，停止事件响应
}

void Ctrl::InternalComm::post(boost::function<void()> func) {
    m_eventHandler.post(func);
}

void Ctrl::InternalComm::sendMsg(int value) {
    msg_queue_acceptTohandler.push(value);
}

int Ctrl::InternalComm::getMsg() {
    int msg;
    msg_queue_acceptTohandler.wait_and_pop(msg);
    return msg;
}


