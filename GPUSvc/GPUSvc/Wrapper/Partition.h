#pragma once

template <class Framework, class Data>
struct Partition
{
	int partition_id;
	Framework framework;
	Data data;
};

//abandon
struct CudaPartition1D
{
	int partition_id;
	int device_id;
	cudaStream_t stream;	
	int start;							
	int end;
};
