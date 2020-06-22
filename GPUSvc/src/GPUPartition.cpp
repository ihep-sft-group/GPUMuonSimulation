#include "GPUSvc/Wrapper/GPUPartition.h"
#include "GPUSvc/Wrapper/PartitionUtilities.h"

using namespace std;

vector<GPUPartition> calc_partitions(GPUList& gpulist, const Extent& extent)
{
	vector<GPUPartition> partitions;

	const int num_gpus = gpulist.get_number_of_GPU();

	const int length = extent.get_length();

	partitions.clear();

	
	partition_t ps1 = partition(0, length-1, num_gpus);

	int i = 0;
	for (auto& gpu : gpulist)
	{
		framework f{ gpu };
		data d{ps1[i]};
		GPUPartition p{ i, f, d };
		partitions.push_back(p);
		i++;
	}
	return partitions;
}
