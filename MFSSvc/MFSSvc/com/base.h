//
// Created by 易培淮 on 2019/08/30.
//

#ifndef MFS2ALG_BASE_H
#define MFS2ALG_BASE_H

#include <string>

namespace COMM{
    enum class MPITagSet : int {
        MFS_TAG_STOCMSG = 0,//任务数据传递
        MFS_TAG_CTOSMSG = 1,//任务数据传递
        MFS_TAG_STOCEXIT = 2,//退出
        MFS_TAG_CTOSEXIT = 3,//退出
        MFS_TAG_NEWNODE = 4,
        MFS_TAG_DISCONNECT = 5,
        MFS_TAG_DIAGNOSIS = 6
    };
}
#endif //MFS2ALG_BASE_H
