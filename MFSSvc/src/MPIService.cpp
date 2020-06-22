//
// Created by 易培淮 on 2019/10/8.
//

#include "MPIService.h"
#include "core/masterContext.h"
#include "control/internalQueue.h"
#include "core/slaveContext.h"

MPIService::MPIService(bool isMaster,int nodeNum, std::string filePath) :m_isMaster(isMaster) {
    if(m_isMaster){
        m_baseContext = new MasterContext(nodeNum,filePath);
    }
    else{
        m_baseContext = new SlaveContext(filePath);
    }
    m_thread = new boost::thread(boost::bind(&BaseContext::run,m_baseContext));
    m_baseContext->setEnable();
}

MPIService::MPIService(bool isMaster,int nodeNum) :m_isMaster(isMaster) {
    if(m_isMaster){
        m_baseContext = new MasterContext(nodeNum);
    }
    else{
        m_baseContext = new SlaveContext();
    }
    m_thread = new boost::thread(boost::bind(&BaseContext::run,m_baseContext));
    m_baseContext->setEnable();
}

MPIService::~MPIService() {
    free(m_baseContext);
    m_baseContext = nullptr;
}

bool MPIService::isMaster() const {
    return m_isMaster;
}

void MPIService::setIsMaster(bool isMaster) {
    MPIService::m_isMaster = isMaster;
}

// bool MPIService::probe(){
//     return mfsToSniper.probe(std::string(""));
// }

void MPIService::exit() {
    _close();
    m_thread->join();//等待MFS主线程结束运行，运行时主线程由overwatch守护不退出
    free(m_thread);
    m_thread = nullptr;
}

void MPIService::_close() {
    ///@todo 关闭MFS
    post(std::string(""));//关闭sinper recv
    if(m_isMaster){
        m_baseContext->exit();
    }
}



