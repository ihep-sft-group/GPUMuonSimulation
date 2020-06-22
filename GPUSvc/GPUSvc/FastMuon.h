#ifndef FASTMUON_H
#define FASTMUON_H

#include "NP.hh"
#include "Hit.h"
#include <cuda_runtime_api.h>
#include <vector>
#include <memory>
#include <map>
#include "Wrapper/GPUDeviceBuffer.h"
#include "Wrapper/GPUList.h"
#include "Wrapper/Extent.h"
#include "Wrapper/Partition.h"
#include "Wrapper/GPUPartition.h"
#include "Wrapper/AsyncScheduler.h"
#include "Wrapper/GPUExecConfig.h"
#include "Wrapper/GPUUtil.h"

#include <boost/thread/mutex.hpp>


class FastMuonMultiGPU
{
public:
    FastMuonMultiGPU(int gpuNum,std::string path,bool merge,std::vector<VoxelMethodHelper::StepInfo> &step_info);
    ~FastMuonMultiGPU()
    {
    }
    void init();//传输直方图和PMT坐标
    void compute(std::vector<VoxelMethodHelper::StepInfo> &step_info,double*&,double*&,int);//根据step计算
    void exit();//退出

    // using device_buf_double = std::shared_ptr<DeviceBuffer<double>>;
    using device_buf_double = std::unique_ptr<DeviceBuffer<double>>;
	using device_bufs_double = std::vector<device_buf_double> ;
    // using host_buf_t = std::shared_ptr<PinnedBuffer<double>>;
    using host_buf_t = std::unique_ptr<PinnedBuffer<double>>;


private:
    void init(GPUPartition& partition);
    void compute(const GPUPartition& partition);
    void reduce();
    void MuonSimu(GPUExecConfig& cfg,device_bufs_double& init_data,device_bufs_double& step_data, \
    device_bufs_double& hit_result, device_bufs_double& npe_result, int seed, int step_size);
    device_buf_double create_and_alloc(Extent& ext);
    device_buf_double create_and_alloc(int size);
    std::vector<GPUPartition> partitions;
    AsyncScheduler<GPUPartition> scheduler;
    GPUList gpulist;

    int m_gpu_num;
    int m_seed;
    NP<double> *m_data_pmt_x;
    NP<double> *m_data_pmt_y;
    NP<double> *m_data_pmt_z;
    NP<double> *m_data_hit;
    NP<double> *m_data_npe;
    double hittime_addr[17746*3000];
    double hittime_npe[17746*3000];
    bool m_merge = false;
    std::vector<VoxelMethodHelper::StepInfo> &m_step_info;

    std::map<int, device_bufs_double> dev_bufs_init_data;//gpu id 为key
    std::map<int, device_bufs_double> dev_bufs_hit_result_data;
    std::map<int, device_bufs_double> dev_bufs_npe_result_data;
    std::map<int, device_bufs_double> dev_bufs_step_data;

    //test
    mutable boost::mutex the_mutex;

};














#endif