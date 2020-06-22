//
// Created by 易培淮 on 2019/10/2.
//

#include "slave_handler.h"
#include "../com/comm.hpp"



bool SlaveHandler::isMStop() const {
    return m_stop;
}

void SlaveHandler::setMStop(bool mStop) {
    m_stop = mStop;
}

SlaveHandler::SlaveHandler(COMM::NodeAgent  &node, Tpool::ThreadPool &pool, Ctrl::InternalComm &internalComm)
        :m_node(node),m_stop(false),m_pool(pool),m_internalComm(internalComm),m_lock(m_mutex) {
}

void SlaveHandler::run() {
    m_pool.execute(&SlaveHandler::work,this);
}

void SlaveHandler::work() {
    while (!m_stop){
        try {
            if(!m_node.parent){
                boost::throw_exception(boost::mpi::exception("MPI_COMM_NULL",-1));
            }
            boost::mpi::status t_status = m_node.parent.probe();
            if(t_status.error() != MPI_SUCCESS){
                boost::throw_exception(boost::mpi::exception("MPI_probe", t_status.error()));
            }
            handler(t_status.source(), t_status.tag());
        }
        catch (boost::mpi::exception e) {
            ///@todo 处理probe的错误
            std::cout<<e.what()<<std::endl \
            <<e.routine()<<std::endl \
            <<e.result_code() <<std::endl;
        }
    }
    // std::cout << "[Slave]recv module close \n";
//    while(isMStopSyn()){sleep(0.1);}
    m_condition_variable.notify_one();
}

void SlaveHandler::handler(int source, int tag) {
    if (tag == static_cast<int>(COMM::MPITagSet::MFS_TAG_DISCONNECT)) { // 断开连接
        COMM::Client::recv(m_node.parent,source,tag);
        COMM::Client::passiveDisconnect(m_node.parent);
        boost::mpi::communicator parent(MPI_COMM_NULL, boost::mpi::comm_attach);
        m_node.parent = parent;
        std::string msg = "";
        setMStop(true);//关闭接收循环
        mfsToSniper.push(msg);//关闭数据循环
        m_internalComm.nofity(COMM::MPITagSet::MFS_TAG_CTOSEXIT);//通知守护进程
    } else if(tag == static_cast<int>(COMM::MPITagSet::MFS_TAG_STOCMSG)){ // 正常通信
        if(m_node.parent){
            std::string msg = COMM::Client::recv(m_node.parent,source,tag);
            // std::cout << "[Slave] recv "<< std::endl;
            ///@todo 放入阻塞队列，与sniper通信
            mfsToSniper.push(msg);
        }
        else{
            ///@todo 报错
        }
    } else if(tag == static_cast<int>(COMM::MPITagSet::MFS_TAG_DIAGNOSIS)){ //心跳信号
        ///@todo 收到心跳信号，处理
        COMM::Client::recv(m_node.parent,source,tag);
    } else if(tag == static_cast<int>(COMM::MPITagSet::MFS_TAG_STOCEXIT)){ //退出信号
        COMM::Client::recv(m_node.parent,source,tag);
        std::string msg = "";
        setMStop(true);//关闭接收循环
        mfsToSniper.push(msg);//关闭数据循环
        m_internalComm.nofity(COMM::MPITagSet::MFS_TAG_CTOSEXIT);//通知守护进程
    }
}

void SlaveHandler::exit() { //仅外部调用exit，并不能退出，只是通知要退出
    m_condition_variable.wait_for(m_lock,boost::chrono::seconds(1));
}

