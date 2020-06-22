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

    Tpool::ThreadPool m_threadpool;
    COMM::Server *m_coreserver;
    COMM::NodeAgent m_nodeAgent;
    MasterHandler m_masterhandler;
    SniperHandler m_sniperhandler;
    COMM::ServerManager m_sendManager;
    Ctrl::InternalComm m_internalComm;
    Ctrl::TaskMgr m_taskmgr;
    Util::MFSHash m_nodeHashMgr;
};


