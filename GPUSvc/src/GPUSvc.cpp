#include "GPUSvc/GPUSvc.h"
#include "SniperKernel/SvcFactory.h"
#include <iostream>

DECLARE_SERVICE(GPUSvc);


GPUSvc::GPUSvc(const std::string& name) : SvcBase(name) {
    declProp("gpuNum", m_gpuNum = 1);
    declProp("loadPath", m_loadPath = "./");
    declProp("seed", m_seed = 42);
    declProp("mergeEnable",m_merge = true);
}

GPUSvc::~GPUSvc(){
    
}

bool GPUSvc::initialize()
{
    // m_muonsimu = std::unique_ptr<MuonSimu>(new MuonSimu(m_gpuNum,m_loadPath,m_merge));
    m_muonsimu = std::unique_ptr<FastMuonMultiGPU>(new FastMuonMultiGPU(m_gpuNum,m_loadPath,m_merge,unuse_obj));
    m_muonsimu->init();
    // if(m_merge) m_muonsimu->setMerge(m_merge);
    return true;
}

bool GPUSvc::finalize()
{
    m_muonsimu->exit();
    return true;
}

// double* GPUSvc::muon_compute(std::vector<VoxelMethodHelper::StepInfo> &m_step_info,std::vector<VoxelMethodHelper::hitsResult> &result){
//     return m_muonsimu->compute(m_step_info,result,m_seed++);
// }

// double* GPUSvc::muon_compute(VoxelMethodHelper::StepInfo &m_step_info,std::vector<VoxelMethodHelper::hitsResult> &result){
//     return m_muonsimu->compute(m_step_info,result,m_seed++);
// }

void GPUSvc::muon_compute(std::vector<VoxelMethodHelper::StepInfo> &m_step_info,double*& result_hittime,double*& result_npe){
    m_muonsimu->compute(m_step_info,result_hittime,result_npe,m_seed);
    m_seed += m_gpuNum;
}