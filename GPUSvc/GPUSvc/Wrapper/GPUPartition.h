
#ifndef GPUPARTITION_H
#define GPUPARTITION_H

#include "GPU.h"
#include "GPUList.h"
#include "Extent.h"
#include "Partition.h"
#include "PartitionUtilities.h"

// the partitions
struct framework
{
	GPU gpu;
};

struct data
{
	interval_t interval;
};

using GPUPartition = Partition < framework, data > ;

std::vector<GPUPartition> calc_partitions(GPUList& gpulist, const Extent& extent);

#endif