#include "GPUSvc/Wrapper/GPU.h"
#include "GPUSvc/Wrapper/GPUUtil.h"
#include <algorithm>

using namespace std;

GPU::GPU(const int _device_id, cudaDeviceProp& _properties)
	: device_id(_device_id)
	, properties(_properties)
{
}

bool GPU::supports_p2p() const
{
	return properties.major >= 2;
}

void GPU::add_to_p2p_clique(GPU gpu)
{
	p2p_clique.push_back(gpu);
}

bool GPU::supports_p2p_to(GPU gpu) const
{
	return find(p2p_clique.begin(), p2p_clique.end(), gpu) != p2p_clique.end();
}

bool GPU::supports_p2p_to(int gpuid) const
{
	int access;
	CHECK(cudaDeviceCanAccessPeer(&access, device_id, gpuid));
	return (access!=0);
}