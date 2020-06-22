#include "GPUSvc/Wrapper/PartitionUtilities.h"
#include <algorithm>

partition_t partition(const int start, const int end, const int num_parts)
{
	partition_t result;
	if(end>0)
	{
		const int size_overall = end - start + 1;
		const int size_part = (size_overall + num_parts - 1) / num_parts;
		int i = start;
		while (i <= end)
		{
			interval_t p(i, std::min(i + size_part - 1, end));
			result.push_back(p);
			i += size_part;
		}
	}
	else
	{
		for(int i = 0; i<num_parts;++i){
			interval_t p(0,0);
			result.push_back(p);
		}
	}
	
	return result;
}