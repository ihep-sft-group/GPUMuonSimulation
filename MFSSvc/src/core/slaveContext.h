#include "../util/threadPool.h"
#include "../handler/slave_handler.h"
#include "baseContext.hpp"
#include "../handler/sniper_handler.h"


class SlaveContext : public BaseContext {
public:
    SlaveContext();
    SlaveContext(std::string filePath);

    ~SlaveContext() override;

    void exit() override;

    void run() override;

    void setEnable() override;

private:
    void _setEnable();

    Tpool::ThreadPool m_threadpool;
    COMM::Client *m_coreclient;
    COMM::NodeAgent m_nodeAgent;
    SlaveHandler m_slavehanlder;
    SniperHandler m_sniperhandler;
    COMM::ClientManager m_sendManager;
    Ctrl::InternalComm m_internalComm;
};
