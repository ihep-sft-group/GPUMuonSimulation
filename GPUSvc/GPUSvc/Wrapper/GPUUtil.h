#ifndef GPUUTIL_H
#define GPUUTIL_H
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <stdio.h>
#include <memory>
using namespace std;


#define CHECK(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}
// 支持普通指针
template<class T,class... Args> inline
typename enable_if<!is_array<T>::value,unique_ptr<T>>::type
make_unique(Args&&... args){
    return unique_ptr<T>(new T(std::forward<Args>(args)...));
}

// 支持动态数组
template<class T> inline
typename enable_if<is_array<T>::value && extent<T>::value == 0,unique_ptr<T>>::type
make_unique(size_t size){
    typedef typename remove_extent<T>::type U;
    return unique_ptr<T>(new U[size]());
}

// 过滤掉定长数组的情况
template<class T,class... Args>
typename enable_if<extent<T>::value != 0,void>::type
make_unique(Args&&...) = delete;


namespace Util
{
    int get_number_of_gpus();
    void reset_all();
    void sync_all();
    // void check(const char* msg);
}


#endif