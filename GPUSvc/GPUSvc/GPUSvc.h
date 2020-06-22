#ifndef SNIPER_GPUSVC_H
#define SNIPER_GPUSVC_H

#include "SniperKernel/SvcBase.h"
// #include "GPUSvc/HelpMuonSimu.h"
#include "GPUSvc/FastMuon.h"
#include "GPUSvc/Hit.h"
#include <memory>

/**************************************************************************
 * Examples
 *     GPUSvc* svc = SvcMgr::get<GPUSvc>("GPUSvc");
 *     std::vector<StepInfo> vec {...};
 *     std::vector<hitsResult> result; 
 *     svc->muon_compute(vec,result);
 *************************************************************************/


class GPUSvc : public SvcBase
{
public :
	GPUSvc(const std::string& name);
	~GPUSvc();
	bool initialize();
	bool finalize();
    // double* muon_compute(std::vector<VoxelMethodHelper::StepInfo> &m_step_info,std::vector<VoxelMethodHelper::hitsResult> &result);
	// double* muon_compute(VoxelMethodHelper::StepInfo &m_step_info,std::vector<VoxelMethodHelper::hitsResult> &result);
	void muon_compute(std::vector<VoxelMethodHelper::StepInfo> &m_step_info,double *&,double *&);

private :
    // std::unique_ptr<MuonSimu> m_muonsimu;
	std::unique_ptr<FastMuonMultiGPU> m_muonsimu;
	std::vector<VoxelMethodHelper::StepInfo> unuse_obj;
	int m_gpuNum;
	int m_seed;
	bool m_merge;
	std::string m_loadPath;
};
#endif