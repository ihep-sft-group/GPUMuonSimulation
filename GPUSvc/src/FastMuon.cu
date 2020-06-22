#include "GPUSvc/FastMuon.h"
#include "GPUSvc/MuonSimu.cuh"
#include <iostream>

FastMuonMultiGPU::FastMuonMultiGPU(int gpuNum,std::string path,bool merge,std::vector<VoxelMethodHelper::StepInfo> &step_info):m_step_info(step_info)
{
    m_gpu_num = gpuNum;
    m_merge = merge;
    //加载数据
    m_data_pmt_x = NP<double>::Load((path + "pmt_x.npy").c_str());
    m_data_pmt_y = NP<double>::Load((path + "pmt_y.npy").c_str());
    m_data_pmt_z = NP<double>::Load((path + "pmt_z.npy").c_str());
    m_data_hit = NP<double>::Load((path + "hittime_cdf.npy").c_str());
    m_data_npe = NP<double>::Load((path + "npe_cdf.npy").c_str());
    //检查GPU
    std::cout<<"[CUDA init] version 03018 available GPU number: "<<gpulist.get_number_of_GPU()<<std::endl;
    assert(gpulist.get_number_of_GPU()>=m_gpu_num);
    gpulist.set_number_of_GPU(m_gpu_num);
    gpulist.search_gpu();
    if(!gpulist.check_p2p_just_gpu0()){
        std::cout<<"[CUDA ERROR] unable p2p copy"<<std::endl;
        // assert(gpulist.check_p2p_just_gpu0());
        // return;
        //不支持也能运行
    }
    gpulist.enable_p2p();
    
    for(auto& gpu:gpulist){
        dev_bufs_init_data[gpu.get_device_id()].clear();
        dev_bufs_hit_result_data[gpu.get_device_id()].clear();
        dev_bufs_npe_result_data[gpu.get_device_id()].clear();
        dev_bufs_step_data[gpu.get_device_id()].clear();
    }
}

void FastMuonMultiGPU::init()
{
    Extent ext = Extent(0);//不分块
    partitions = calc_partitions(gpulist, ext);//Partition < framework, data >
    scheduler.sync(partitions,[this](GPUPartition partition) { this->init(partition); });
}

void FastMuonMultiGPU::init(GPUPartition& partition)
{
    int gpu = partition.framework.gpu.get_device_id();
    CHECK(cudaSetDevice(gpu));
    dev_bufs_init_data[gpu].push_back(create_and_alloc(m_data_pmt_x->data.size()));//pmt_x
    dev_bufs_init_data[gpu].push_back(create_and_alloc(m_data_pmt_y->data.size()));//pmt_y
    dev_bufs_init_data[gpu].push_back(create_and_alloc(m_data_pmt_z->data.size()));//pmt_z
    dev_bufs_init_data[gpu].push_back(create_and_alloc(m_data_hit->data.size()));
    dev_bufs_init_data[gpu].push_back(create_and_alloc(m_data_npe->data.size()));
    CHECK(cudaMemcpy(dev_bufs_init_data[gpu][0]->get_ptr(),&(m_data_pmt_x->data[0]),dev_bufs_init_data[gpu][0]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_init_data[gpu][1]->get_ptr(),&(m_data_pmt_y->data[0]),dev_bufs_init_data[gpu][1]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_init_data[gpu][2]->get_ptr(),&(m_data_pmt_z->data[0]),dev_bufs_init_data[gpu][2]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_init_data[gpu][3]->get_ptr(),&(m_data_hit->data[0]),dev_bufs_init_data[gpu][3]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_init_data[gpu][4]->get_ptr(),&(m_data_npe->data[0]),dev_bufs_init_data[gpu][4]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    
    dev_bufs_hit_result_data[gpu].push_back(create_and_alloc(17746*3000));
    dev_bufs_npe_result_data[gpu].push_back(create_and_alloc(17746*3000));
}

void FastMuonMultiGPU::compute(std::vector<VoxelMethodHelper::StepInfo> &step_info,double*& result_hittime,double*& result_npe,int seed)
{
    m_step_info = step_info;
    m_seed = seed;
    Extent ext = Extent(m_step_info.size());
    // std::cout<<"m_step_info:"<<m_step_info.size()<<std::endl;
    partitions = calc_partitions(gpulist, ext);
    // std::cout<<"m_partition:"<<partitions.size()<<std::endl;
    //多GPU并行计算
    scheduler.sync(partitions,[this](GPUPartition partition) { this->compute(partition); });
    //合并结果
    reduce();
    //从GPU0返回结果
    CHECK(cudaMemcpy(hittime_addr,dev_bufs_hit_result_data[0][0]->get_ptr(),dev_bufs_hit_result_data[0][0]->get_size_in_bytes(),cudaMemcpyDeviceToHost));
    CHECK(cudaMemcpy(hittime_npe,dev_bufs_npe_result_data[0][0]->get_ptr(),dev_bufs_npe_result_data[0][0]->get_size_in_bytes(),cudaMemcpyDeviceToHost));
    result_hittime = hittime_addr;
    result_npe = hittime_npe;
}


void FastMuonMultiGPU::compute(const GPUPartition& partition)
{
    // GPU gpu = partition.framework.gpu;
    int gpu = partition.framework.gpu.get_device_id();
    // std::cout<<gpu<<" GPUid: "<<gpu<<std::endl;
    int data_length = partition.data.interval.second-partition.data.interval.first+1;
    CHECK(cudaSetDevice(gpu));
    // Util::check("cudaSetDevice [init]");
    // std::cout<<gpu<<" CHECK1: "<<data_length<<" "<<partition.data.interval.second<<" "<<partition.data.interval.first<<std::endl;
    //结果置0
    CHECK(cudaMemset(dev_bufs_hit_result_data[gpu][0]->get_ptr(),0,dev_bufs_hit_result_data[gpu][0]->get_size_in_bytes()));
    CHECK(cudaMemset(dev_bufs_npe_result_data[gpu][0]->get_ptr(),0,dev_bufs_npe_result_data[gpu][0]->get_size_in_bytes()));
    // std::cout<<gpu<<" CHECK2"<<std::endl;
    //转存step信息，占用大量栈内存，线程数量较少时容易耗尽栈内存,修改默认栈内存大小解决。ulimit -s 20480
    //使用堆内存可能产生线程安全问题，具体与编译器有关。
    // double v_data_step_r[data_length];
    // double v_data_step_pos_x[data_length];
    // double v_data_step_pos_y[data_length];
    // double v_data_step_pos_z[data_length];
    // double v_data_step_intPart[data_length];
    // double v_data_step_fraPart[data_length];
    // double v_data_step_starttime[data_length];
    //栈内存不够用，换成堆内存试试
    double* const v_data_step_r = new double[data_length];
    double* const v_data_step_pos_x = new double[data_length];
    double* const v_data_step_pos_y = new double[data_length];
    double* const v_data_step_pos_z = new double[data_length];
    double* const v_data_step_intPart = new double[data_length];
    double* const v_data_step_fraPart = new double[data_length];
    double* const v_data_step_starttime = new double[data_length];
    // std::cout<<gpu<<" CHECK3"<<std::endl;
    for (int i = 0; i < data_length; ++i)
    {
        // std::cout<<"[item]"<<i<<std::endl;
        v_data_step_r[i] = m_step_info[partition.data.interval.first+i].step_r;
        v_data_step_pos_x[i] = m_step_info[partition.data.interval.first+i].step_pos_x;
        v_data_step_pos_y[i] = m_step_info[partition.data.interval.first+i].step_pos_y;
        v_data_step_pos_z[i] = m_step_info[partition.data.interval.first+i].step_pos_z;
        v_data_step_intPart[i] = (double)m_step_info[partition.data.interval.first+i].step_energy_intPart;
        v_data_step_fraPart[i] = m_step_info[partition.data.interval.first+i].step_energy_fractionPart;
        v_data_step_starttime[i] = m_step_info[partition.data.interval.first+i].step_start_time;
    }
    // std::cout<<gpu<<" CHECK4"<<std::endl;
    //分配内存
    for(int i=0;i<7;++i){
        dev_bufs_step_data[gpu].push_back(create_and_alloc(data_length));
    }
    // std::cout<<gpu<<" CHECK5"<<std::endl;
    //拷贝step信息
    CHECK(cudaMemcpy(dev_bufs_step_data[gpu][0]->get_ptr(),v_data_step_r,dev_bufs_step_data[gpu][0]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_step_data[gpu][1]->get_ptr(),v_data_step_pos_x,dev_bufs_step_data[gpu][1]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_step_data[gpu][2]->get_ptr(),v_data_step_pos_y,dev_bufs_step_data[gpu][2]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_step_data[gpu][3]->get_ptr(),v_data_step_pos_z,dev_bufs_step_data[gpu][3]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_step_data[gpu][4]->get_ptr(),v_data_step_intPart,dev_bufs_step_data[gpu][4]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_step_data[gpu][5]->get_ptr(),v_data_step_fraPart,dev_bufs_step_data[gpu][5]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(dev_bufs_step_data[gpu][6]->get_ptr(),v_data_step_starttime,dev_bufs_step_data[gpu][6]->get_size_in_bytes(),cudaMemcpyHostToDevice));
    // std::cout<<gpu<<" CHECK6"<<std::endl;
    //计算
    GPUExecConfig cfg;
    MuonSimu(cfg,dev_bufs_init_data[gpu],dev_bufs_step_data[gpu],dev_bufs_hit_result_data[gpu],dev_bufs_npe_result_data[gpu],m_seed+gpu,data_length);
    CHECK(cudaDeviceSynchronize());
    // std::cout<<gpu<<" CHECK7"<<std::endl;
    dev_bufs_step_data[gpu].clear();
    delete []v_data_step_r;
    delete []v_data_step_pos_x;
    delete []v_data_step_pos_y;
    delete []v_data_step_pos_z;
    delete []v_data_step_intPart;
    delete []v_data_step_fraPart;
    delete []v_data_step_starttime;
}

void FastMuonMultiGPU::MuonSimu(GPUExecConfig& cfg,device_bufs_double& init_data,device_bufs_double& step_data, \
    device_bufs_double& hit_result, device_bufs_double& npe_result, int seed,int step_size)
{
    dim3 grid = cfg.get_grid();
    dim3 block = cfg.get_block();
    step_calculate_every_pmt<<<grid, block>>>(step_data[0]->get_ptr(),step_data[1]->get_ptr(),step_data[2]->get_ptr(), \
    step_data[3]->get_ptr(),init_data[0]->get_ptr(),init_data[1]->get_ptr(), \
    init_data[2]->get_ptr(),step_data[4]->get_ptr(),step_data[5]->get_ptr(), \
    step_data[6]->get_ptr(),17746,init_data[3]->get_ptr(),init_data[4]->get_ptr(),seed, \
    hit_result[0]->get_ptr(),npe_result[0]->get_ptr(),step_size,true); 
}

void FastMuonMultiGPU::reduce()
{
    if(gpulist.get_number_of_GPU()==1){
        return;
    }
    CHECK(cudaSetDevice(0));
    // Util::check("cudaSetDevice [init]");
    //拷贝结果到GPU0
    dev_bufs_hit_result_data[0].push_back(create_and_alloc(17746*3000));
    dev_bufs_npe_result_data[0].push_back(create_and_alloc(17746*3000));
    for(int gpuid = 1; gpuid < gpulist.get_number_of_GPU(); ++gpuid){
        CHECK(cudaMemcpyPeer(dev_bufs_hit_result_data[0][1]->get_ptr(),0,dev_bufs_hit_result_data[gpuid][0]->get_ptr(),gpuid,dev_bufs_hit_result_data[0][1]->get_size_in_bytes()));
        CHECK(cudaMemcpyPeer(dev_bufs_npe_result_data[0][1]->get_ptr(),0,dev_bufs_npe_result_data[gpuid][0]->get_ptr(),gpuid,dev_bufs_hit_result_data[0][1]->get_size_in_bytes()));
        dim3 block(1024);
        dim3 grid(51991);
        add<<<grid, block>>>(dev_bufs_hit_result_data[0][0]->get_ptr(), \
        dev_bufs_npe_result_data[0][0]->get_ptr(), dev_bufs_hit_result_data[0][1]->get_ptr(), \
        dev_bufs_npe_result_data[0][1]->get_ptr());
        CHECK(cudaDeviceSynchronize());
    }
    //释放内存
    // dev_bufs_hit_result_data[0][1]->free();//无需手动释放
    // dev_bufs_npe_result_data[0][1]->free();
    dev_bufs_hit_result_data[0].pop_back();
    dev_bufs_npe_result_data[0].pop_back();
}


FastMuonMultiGPU::device_buf_double FastMuonMultiGPU::create_and_alloc(int size)
{
    Extent ext(size); 
    FastMuonMultiGPU::device_buf_double d = std::move(make_unique<DeviceBuffer<double>>(ext)); 
    d->alloc();
	return d;
}

FastMuonMultiGPU::device_buf_double FastMuonMultiGPU::create_and_alloc(Extent& ext)
{
    FastMuonMultiGPU::device_buf_double d = std::move(make_unique<DeviceBuffer<double>>(ext));
	d->alloc();
	return d;
}

void FastMuonMultiGPU::exit()
{
    for(auto& gpu:gpulist){
        dev_bufs_init_data[gpu.get_device_id()].clear();
        dev_bufs_hit_result_data[gpu.get_device_id()].clear();
        dev_bufs_npe_result_data[gpu.get_device_id()].clear();
        dev_bufs_step_data[gpu.get_device_id()].clear();
    }//先释放智能指针，再重置GPU
    Util::reset_all();
    return;
}