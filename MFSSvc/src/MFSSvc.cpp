// #include "MFSSvc/MFSSvc.h"
// #include "MFSSvcImpl.h"
#include "MFSSvc/MFSSvc.h"
#include "SniperKernel/SvcFactory.h"
#include "MFSSvc/MPIService.h"
#include <iostream>

// class MFSSvcImpl
// {
// public :
// 	MFSSvcImpl(bool,int);
// 	~MFSSvcImpl();
// 	bool initialize();
// 	bool finalize();
// 	bool isMaster();
// 	template<typename... Args>
// 	void post_datas(Args&&... datas);
// 	template<typename... Args>
//     bool get_datas(Args&&... datas);

// private :
// 	std::unique_ptr<MPIService> mpiservice;
// 	bool m_isMaster;
// 	int m_slaveNum;
// };

DECLARE_SERVICE(MFSSvc);

MFSSvc::MFSSvc(const std::string& name) : SvcBase(name) {
    declProp("isMaster", m_isMaster = false);
    declProp("slaveNum", m_slaveNum = 0);
    declProp("savePath", m_savePath = "./");
}

MFSSvc::~MFSSvc(){
    
}


bool MFSSvc::initialize()
{
    // mpiservice =std::unique_ptr<MPIService>(new MPIService(m_isMaster,m_slaveNum));
    mpiservice =std::unique_ptr<MPIService>(new MPIService(m_isMaster,m_slaveNum,m_savePath));
    return true;
}

bool MFSSvc::finalize()
{
    mpiservice->exit();
    return true;
}

// bool MFSSvc::probe(){
//     return mpiservice->probe();
// }

bool MFSSvc::exit(){
    mpiservice->exit();
    return true;
}

bool MFSSvc::isMaster()
{
    return m_isMaster;
}

int MFSSvc::getNodeNum()
{
    return m_slaveNum+1;
}

int MFSSvc::getSlaveNum()
{
    return m_slaveNum;
}