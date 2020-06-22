#ifndef SNIPER_MFSSVC_H
#define SNIPER_MFSSVC_H

#include "SniperKernel/SvcBase.h"
#include "MFSSvc/MPIService.h"
#include <memory>

/**************************************************************************
 * Examples
 *     MFSSvc* svc = SvcMgr::get<MFSSvc>("MFSSvc");
 *     std::vector<int> vec { 345, 973845739 };
 *     svc->post_datas(vec);
 *     std::vector<int> result; 
 *     svc->get_datas(result);
 *************************************************************************/
// class MFSSvcImpl;

class MFSSvc : public SvcBase
{
public :
	MFSSvc(const std::string& name);
	~MFSSvc();
	bool initialize();
	bool finalize();
	bool exit();
	bool isMaster();
	int  getNodeNum();
	int  getSlaveNum();
	// bool probe();
	template<typename... Args>
	void post_datas(Args&&... datas){
		mpiservice->post_datas(std::forward<Args>(datas)...);
		
	}
	template<typename... Args>
    bool get_datas(Args&&... datas){
		return mpiservice->get_datas(std::forward<Args>(datas)...);
		
	}



private :
	bool m_isMaster;
	int m_slaveNum;
	std::string m_savePath;
    std::unique_ptr<MPIService> mpiservice;
};
#endif