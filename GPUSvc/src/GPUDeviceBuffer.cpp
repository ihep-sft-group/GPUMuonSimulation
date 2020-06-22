#include <cuda_runtime_api.h>
#include "GPUSvc/Wrapper/GPUDeviceBuffer.h"
#include "GPUSvc/Wrapper/GPUUtil.h"
#include <cassert>
#include "GPUSvc/Wrapper/Extent.h"


template <typename T, class E>
DeviceBuffer<T, E>::DeviceBuffer(const E& e)
	: BaseBuffer<T, E>(e)
{
}

template <typename T, class E>
DeviceBuffer<T, E>::~DeviceBuffer()
{
	if (ptr)
	{
		free();
	}
	//智能指针管理的话无需手动释放
}

template <typename T, class E>
void DeviceBuffer<T, E>::alloc()
{
	CHECK(cudaMalloc((void**)&ptr, BaseBuffer<T, E>::get_size_in_bytes()));
	version = 0;
}

template <typename T, class E>
void DeviceBuffer<T, E>::free()
{
	CHECK(cudaFree(ptr));
	version = -1;
	ptr = 0;
}

template <typename T, class E>
void DeviceBuffer<T, E>::copy_from(const PinnedBuffer<T, E>& buf)
{
	const E ext1 = buf.get_extent();
	const E ext2 = BaseBuffer<T, E>::get_extent();
	assert(ext1 == ext2);
	const size_t sz = BaseBuffer<T, E>::get_size_in_bytes();
	const void* src = buf.get_ptr();
	CHECK(cudaMemcpy(ptr, src, sz, cudaMemcpyHostToDevice));
	BaseBuffer<T, E>::set_version(buf);
}

template <typename T, class E>
void DeviceBuffer<T, E>::copy_to(PinnedBuffer<T, E>& buf) const
{
	const E ext1 = buf.get_extent();
	const E ext2 = BaseBuffer<T, E>::get_extent();
	assert(ext1 == ext2);
	const size_t sz = BaseBuffer<T, E>::get_size_in_bytes();
	void* dst = buf.get_ptr();
	//const void* src = BaseBuffer<T, E>::get_ptr();
	CHECK(cudaMemcpy(dst, ptr, sz, cudaMemcpyDeviceToHost));
	// Util::check("cudaMemcpy");
	buf.set_version(*this);
}

// Instances
template class DeviceBuffer<int, Extent>;
template class DeviceBuffer<float, Extent>;
template class DeviceBuffer<double, Extent>;
template class DeviceBuffer<uchar4, Extent>;

