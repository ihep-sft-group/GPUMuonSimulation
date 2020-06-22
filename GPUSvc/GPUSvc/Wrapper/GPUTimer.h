#ifndef GPUTIME_H
#define GPUTIME_H

#include <cuda_runtime_api.h>
#include "GPUUtil.h"

class CudaTimer
{
public:
	CudaTimer()
	{
		CHECK(cudaEventCreate(&start_ev));
		CHECK(cudaEventCreate(&stop_ev));
	}

	~CudaTimer()
	{
		CHECK(cudaEventDestroy(start_ev));
		CHECK(cudaEventDestroy(stop_ev));
	}

	void start()
	{
		CHECK(cudaEventRecord(start_ev));
	}

	void stop()
	{
		CHECK(cudaEventRecord(stop_ev));
		CHECK(cudaEventSynchronize(stop_ev));
	}

	float getTime()
	{
		float delta = 0.0f;
		CHECK(cudaEventElapsedTime(&delta, start_ev, stop_ev));
		return delta;
	}

private:
	cudaEvent_t start_ev, stop_ev;
};


#endif