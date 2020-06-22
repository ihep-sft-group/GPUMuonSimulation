#include "GPUSvc/Wrapper/GPUUtil.h"

#include <cuda_runtime_api.h>
#include <ostream>
#include <stdexcept>
#include <sstream>
#include <iostream>


namespace Util
{
    int get_number_of_gpus()
    {
        int count = -1;
        CHECK(cudaGetDeviceCount(&count));
        return count;
    }

    void reset_all()
    {
        int count = get_number_of_gpus();
        for (int d = 0; d < count; d++)
        {
            CHECK(cudaSetDevice(d));
            CHECK(cudaDeviceReset());
        }
    }

    void sync_all()
    {
        int count = get_number_of_gpus();
        for (int d = 0; d < count; d++)
        {
            CHECK(cudaSetDevice(d));
            CHECK(cudaDeviceSynchronize());
        }
    }

    // void check_rc(cudaError_t rc, const char* msg)
    // {
    //     if (rc != cudaSuccess)
    //     {
    //         throw std::runtime_error(msg);
    //     }
    // }

    // void check(const char* msg)
    // {
    //     cudaError_t rc = cudaGetLastError();
    //     if (msg)
    //     {
    //         std::ostringstream buf;
    //         buf << msg << " - " << cudaGetErrorString(rc);
    //         check_rc(rc, buf.str().c_str());
    //     }
    //     else
    //     {
    //         check_rc(rc, cudaGetErrorString(rc));
    //     }
    // }
}