#ifndef GPUPARALLEL_H
#define GPUPARALLEL_H

void parallel_for(vector<CudaPartition> ps, function<void(CudaPartition&)> closure)
{
	scheduler->sync(ps, closure);
}

#endif
