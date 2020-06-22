//
// Created by 易培淮 on 2019/10/10.
//

#include "sniper_handler.h"
#include "../core/masterContext.h"
#include "../core/slaveContext.h"

SniperHandler::SniperHandler(bool isMaster,Tpool::ThreadPool &threadpool,COMM::CommManager &sendManager)
    :m_isMaster(isMaster),m_enable(true),m_threadpool(threadpool),m_sendManager(sendManager) {

}

SniperHandler::~SniperHandler() {

}

void SniperHandler::run() {
    m_threadpool.execute(&SniperHandler::_work,this);
}

void SniperHandler::_work() {
    while(isMEnable()){
        std::string str = "";
        sniperToMfs.wait_and_pop(str);
        if(!str.empty()){
            m_task_count++;
            m_sendManager.send(str,m_task_count);//发送
        }
        else{//准备停止接收sniper消息
            exit();
        }
    }
    // std::cout << "sniper recv module close\n";
}

void SniperHandler::exit() {
    setMEnable(false);
}

bool SniperHandler::isMEnable() const {
    return m_enable;
}

void SniperHandler::setMEnable(bool mEnable) {
    m_enable = mEnable;
}



