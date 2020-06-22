#include "GPUSvc/Wrapper/GPUExecConfig.h"


GPUExecConfig::GPUExecConfig()
	: block(dim3(256,1,1))
	, grid(dim3(70,1,1))
	, shared_mem(0)
	, stream(0)
	, extent(Extent(0))
{
}

// GPUExecConfig::GPUExecConfig(const Extent& _extent, const dim3 _block, const int _shared_mem, cudaStream_t _stream)
// 	: block(dim3(256,1,1))
// 	, grid()
// 	, shared_mem(_shared_mem)
// 	, stream(_stream)
// 	, extent(_extent)
// {
// }

// GPUExecConfig::GPUExecConfig(const int num_elems, const dim3 _block /*= dim3(128, 1, 1)*/, const int _shared_mem /*= 0*/, cudaStream_t _stream /*= 0*/)
// 	: block(_block)
// 	, grid(dim3(256,1,1))
// 	, shared_mem(_shared_mem)
// 	, stream(_stream)
// 	, extent(Extent(num_elems, 1))
// {
// }
