//
// Created by 易培淮 on 2019/10/8.
//

#include "taskMgr.h"


Ctrl::TaskMgr::TaskMgr(int clientnum) {
    for(int i=0;i<clientnum;i++){
        m_task_queue.push_back(new Util::BlockQueue<std::string>());
    }
}

bool Ctrl::TaskMgr::push(std::string task, int id) {
    if(m_task_queue.size()<id){
        return false;
    }
    m_task_queue[id]->push(task);
    return true;
}

bool Ctrl::TaskMgr::pop(int id,std::string &str) {
    if(m_task_queue.size()<id){
        return false;
    }
    return m_task_queue[id]->try_pop(str);
}

void Ctrl::TaskMgr::exit() {
    for(int i=0;i<m_task_queue.size();i++){
        free(m_task_queue[i]);
        m_task_queue[i] = nullptr;
    }
}

void Ctrl::TaskMgr::remove(int id) {
    m_task_queue[id]->just_remove();
}
