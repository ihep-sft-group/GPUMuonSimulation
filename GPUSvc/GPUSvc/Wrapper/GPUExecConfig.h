#pragma once

#include <cuda_runtime_api.h>
#include "Extent.h"

class GPUExecConfig
{

public:
	GPUExecConfig();
	
	// GPUExecConfig(const Extent& _extent, const dim3 _block = dim3(1, 1, 1), const int _shared_mem = 0, cudaStream_t _stream = 0);

	// GPUExecConfig(const int num_elems, const dim3 _block = dim3(1, 1, 1), const int _shared_mem = 0, cudaStream_t _stream = 0);

	dim3 get_grid() const
	{
		return grid;
	}

	dim3 get_block() const
	{
		return block;
	}

	int get_shared_mem() const
	{
		return shared_mem;
	}

	cudaStream_t get_stream() const
	{
		return stream;
	}

	void set_stream(cudaStream_t _stream)
	{
		stream = _stream;
	}

	Extent get_extent() const
	{
		return extent;
	}

private:

	Extent extent;
	dim3 grid;
	dim3 block;
	int shared_mem;
	cudaStream_t stream;

};