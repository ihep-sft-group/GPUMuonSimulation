#include "../util/threadPool.h"
#include "../handler/master_handler.h"
#include "../com/server.h"
#include "../com/comm.hpp"
#include "../control/internalComm.h"
#include "baseContext.hpp"
#include "../handler/sniper_handler.h"
#include "../control/taskMgr.h"
#include "../util/MFSHash.h"


class MasterContext : public BaseContext {
public:
    explicit MasterContext(int);
    explicit MasterContext(int,std::string &);

    ~MasterContext() override;

    void exit() override;

    void run() override;

    void setEnable() override;

private:
    void _setEnable();

    Tpool::ThreadPool m_threadpool;//线程池
    COMM::Server *m_coreserver;//mpi 服务器，底层处理收发消息
    COMM::NodeAgent m_nodeAgent;//节点列表
    MasterHandler m_masterhandler;//处理mpi-》master消息
    SniperHandler m_sniperhandler;//处理sniper-> master消息
    COMM::ServerManager m_sendManager;//发送管理:任务分发，错误恢复(调用COMM::Server)
    Ctrl::InternalComm m_internalComm;//MFS框架内部线程同步
    Ctrl::TaskMgr m_taskmgr;//任务持久化
    Util::MFSHash m_nodeHashMgr;//哈希
};


