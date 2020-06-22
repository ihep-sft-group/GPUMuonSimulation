#include "GPUSvc/Wrapper/GPUPinnedBuffer.h"
#include "GPUSvc/Wrapper/GPUUtil.h"
#include "GPUSvc/Wrapper/Extent.h"


template <typename T, class E>
PinnedBuffer<T, E>::PinnedBuffer(const E& e)
	: HostBuffer<T, E>(e)
{
}

template <typename T, class E>
PinnedBuffer<T, E>::~PinnedBuffer()
{
	if (ptr)
	{
		free();
	}
}

template <typename T, class E>
void PinnedBuffer<T, E>::alloc()
{
	const size_t sz = BaseBuffer<T, E>::get_size_in_bytes();
	CHECK(cudaMallocHost((void**)&ptr, sz));
	version = 0;
}
 
template <typename T, class E>
void PinnedBuffer<T, E>::free()
{
	if (ptr)
	{
		CHECK(cudaFreeHost(ptr));
		ptr = 0;
		version = -1;
	}
}

// Instances
template class PinnedBuffer < int, Extent >;
template class PinnedBuffer < float, Extent >;
template class PinnedBuffer < double, Extent >;
template class PinnedBuffer < uchar4, Extent >;
// Linux
template class HostBuffer < int, Extent >;
template class HostBuffer < float, Extent >;
template class HostBuffer < double, Extent >;
template class HostBuffer < uchar4, Extent >;


