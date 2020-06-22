//
// Created by 易培淮 on 2019/10/8.
//

#ifndef MFS2_TASKMGR_H
#define MFS2_TASKMGR_H
#include "../util/blockQueue.hpp"

namespace Ctrl {
    class TaskMgr {
    public:
        explicit TaskMgr(int);

        ~TaskMgr() = default;

        bool push(std::string task, int id);

        bool pop(int id,std::string &);

        void remove(int id);

        void exit();

    private:
        std::vector <Util::BlockQueue<std::string> *> m_task_queue;
    };
}

#endif //MFS2_TASKMGR_H