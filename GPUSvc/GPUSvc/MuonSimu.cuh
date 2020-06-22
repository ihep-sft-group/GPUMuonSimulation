#ifndef MUONSIMU_H
#define MUONSIMU_H
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <curand.h>
#include <curand_kernel.h>
#include <stdio.h>
#include <math_constants.h>
#include <assert.h>



typedef struct res_arr
{
    double *hittime_arr;
    // int *pmtid_arr;
    double *npe_arr;
    int index;//current index
    int begin;//begin index
    int id;//thread id = pmtid
    int max; //max size
} Res_Arr;

__device__ double generateRandom(curandState *state);
__device__ void generateRandomInit(curandState *state,int seed);
__device__ int sampling(curandState *state,double *histo,int max,int id);
__device__ int binarySearch(double *histo,double target,int max,int id);
__device__ double calculateAngle(double x,double y,double z,double a,double b,double c);
__device__ void generateHits(double r,double theta, double ratio,double start_time,\
    double *hittime_histo,double *npe,curandState *state,Res_Arr *p_r_arr,bool m_merge);
__device__ int get_hittime(double r, double theta, int mode, double *hittime_histo, curandState *state);
__device__ int get_hittime_bin(int binx, int biny, int mode, double *hittime_histo, curandState *state);
__device__ int get_hittime_all(int binx, int biny,double *hittime_histo, curandState *state);
__device__ int get_bin_x(double r);
__device__ int get_bin_y(double theta);
__device__ int r_findBin(double r);
__device__ int get_npe(double r,double theta,double *npe,curandState *state);
__device__ int r3_findBin(double r3);
__device__ int theta_findBin(double theta);
__device__ int get_npe_num(int binx,int biny,double *npe,curandState *state);
__device__ int generateRandomInt(curandState *state,int begin,int end);

__device__ void calculate_by_step(double r,double pos_x,double pos_y,double pos_z,\
    double pmt_x,double pmt_y,double pmt_z,double intPart,double fractionPart,\
    double start_time,double *hittime_histo,double *npe,curandState *state,\
    Res_Arr *p_pmt_arr,bool m_merge);
__global__ void step_calculate_every_pmt(double *r,double *pos_x,double *pos_y,\
    double *pos_z,double *pmt_x,double *pmt_y,double *pmt_z,double *intPart,\
    double *fractionPart,double *start_time,int numElements,\
    double *hittime_histo,double *npe,int seed,double *hittime_result,\
    double *result_size,int step_size,bool m_merge);
__global__ void add(double*,double*,double*,double*);
// __global__ void evt_calculate_add(int *evt_res_list,int *evt_res_back,int evtnum,int pmtnum);

__device__ void append_res_arr(Res_Arr *p, double val);
// __device__ void result_merge_save(Res_Arr *p, int val);
__device__ void result_merge_save(Res_Arr *p, double hittime,int index);
// __device__ void add_evt_arr(Res_Arr *p, int evtid);
__device__ void init_res_arr(Res_Arr *p,double *hittime_result,double *result_size,int pmtid);

// #define CHECK(call) \
// {\
//     const cudaError_t error = call;\
//     if (error != cudaSuccess)\
//     {\
//         printf("Error:%s:%d, ", __FILE__, __LINE__);\
//         printf("code:%d, reason: %s\n", error, cudaGetErrorString(error));\
//         exit(1);\
//     }\
// }

#define pmt_num 17746
#define pmt_mem 3000
#define CUDART_PI_F 3.141592654f
#define CUDA_ERROR_CHECK
#define CudaCheckError()    __cudaCheckError( __FILE__, __LINE__ )

// static double *g_pmt_x,*g_pmt_y,*g_pmt_z,*g_data_hit,*g_data_npe;//global variable

// static double *d_hittime_result;
// static int *d_npe_result;
// int *d_pmtid_result;
// static int *d_result_size;
//申请GPU内存
// static double *d_r, *d_pos_x,*d_pos_y,*d_pos_z,*d_fractionPart,*d_start_time;
// static double *d_intPart;
static int m_gpuNum;


// extern "C" float GPU_Sampling_wrapper(double *r,double *pos_x,double *pos_y,double *pos_z, \
//     double *intPart, double *fractionPart,double *start_time,\
//     int seed,int step_size,double *hittime_addr,int *result_size);
// extern "C" float GPU_Sampling_merge(double *r,double *pos_x,double *pos_y,double *pos_z, \
//     double *intPart, double *fractionPart,double *start_time,\
//     int seed,int step_size,double *hittime_addr,int *result_size);
// extern "C" void GPU_Sampling_merge_multi(double *r,double *pos_x,double *pos_y,double *pos_z, \
//     double *intPart, double *fractionPart,double *start_time,\
//     int seed,int step_size,double *hittime_addr,int *hittime_npe);
// extern "C" void GPU_init_data(double *pmt_x,double *pmt_y,double *pmt_z,double *data_hit,double *data_npe,int size_1,int size_2,int size_3);
// extern "C" void GPU_init_data_multi(double *pmt_x,double *pmt_y,double *pmt_z,double *data_hit,double *data_npe,int size_1,int size_2,int size_3,int gpunum);
// extern "C" void GPU_exit();




#endif