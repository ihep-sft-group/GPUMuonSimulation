#pragma once

#include <cuda_runtime_api.h>
#include <iostream>
#include <vector>
#include "PartitionUtilities.h"

class Extent
{

public:

	__device__ __host__
	Extent(const int _length = 1)
		: length(_length)
	{
	}

    __device__ __host__
	Extent(interval_t& i)
		: length(i.second-i.first+1)
	{
	}

	__device__ __host__
	Extent(const Extent& extent)
		: length(extent.length)
	{
	}

	__device__ __host__
	Extent(const int start, const int end)
		: length(end - start + 1)
	{
	}

	__device__ __host__
	bool in_bounds(const int x) const
	{
		return x < length;
	}

	__device__ __host__
	bool in_bounds_strict(const int x) const
	{
		return 0 <= x && x < length;
	}

	__device__ __host__
	bool at_border(const int x) const
	{
		return 0 == x || x == length - 1;
	}

	__device__ __host__
	int get_length() const
	{
		return length;
	}

	__device__ __host__
	Extent& operator=(const Extent& a)
	{
		length = a.length;
		return *this;
	}

	__device__ __host__
	bool operator==(const Extent& b) const
	{
		return this->length == b.length;
	}

private:

	int length;

};

inline std::ostream &operator<<(std::ostream& ostr, const Extent& d)
{
	return ostr << d.get_length();
}