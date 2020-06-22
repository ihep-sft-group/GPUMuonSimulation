#include "GPUSvc/Wrapper/GPUList.h"
#include "GPUSvc/Wrapper/GPUUtil.h"
using namespace std;

GPUList::GPUList()
{
	m_gpu_number = Util::get_number_of_gpus();
	// search_gpu();
}

void GPUList::search_gpu()
{
	for (int i = 0; i < m_gpu_number; ++i)
	{
		// find properties
		cudaDeviceProp prop;
		CHECK(cudaGetDeviceProperties(&prop, i));
		// add to vector
		GPU gpu(i, prop);
		gpulist.push_back(gpu);
	}
}

std::vector<GPU> GPUList::get_p2p_GPUList()
{
	std::vector<GPU> result;
	for (auto& gpu : gpulist)
	{
		if (gpu.supports_p2p())
		{
			result.push_back(gpu);
		}
	}
	return result;
}

void GPUList::search_p2p_gpu()
{
	if (!p2p_cliques_determined)
	{
		p2p_cliques.resize(0);
		vector<bool> done(m_gpu_number, false);
		for (int d = 0; d < m_gpu_number; d++)
		{
			if (!done[d])
			{
				//create a new clique with GPU d
				vector<GPU> newClique;
				done[d] = true;
				newClique.push_back(gpulist[d]);
				// are the other devices available from this device?
				for (int e = d + 1; e < m_gpu_number; e++)
				{
					int access;
					CHECK(cudaDeviceCanAccessPeer(&access, d, e));
					if (access)
					{
						newClique.push_back(gpulist[e]);
						gpulist[e].add_to_p2p_clique(gpulist[d]);
						gpulist[d].add_to_p2p_clique(gpulist[e]);
						done[e] = true;
					}
				}
				p2p_cliques.push_back(newClique);
			}
		}
		p2p_cliques_determined = true;
	}
}

void GPUList::enable_p2p()
{
	search_p2p_gpu();
	for (auto& clique : p2p_cliques)
	{
		const int num = (int) clique.size();
		for (int d = 0; d < num; d++)
		{
			CHECK(cudaSetDevice(d));
			for (int e = 0; e < num && d != e; e++)
			{
				CHECK(cudaDeviceEnablePeerAccess(e, 0));
			}
		}
	}
}

void GPUList::disable_p2p()
{
	search_p2p_gpu();
	for (auto& clique : p2p_cliques)
	{
		const int num = (int) clique.size();
		for (int d = 0; d < num; d++)
		{
			CHECK(cudaSetDevice(d));
			for (int e = 0; e < num && d != e; e++)
			{
				CHECK(cudaDeviceDisablePeerAccess(e));
			}
		}
	}
}

bool GPUList::check_p2p_just_gpu0(){
	bool result = true;
	for (auto& gpu : gpulist)
	{
		if(gpu.get_device_id()==0){
			continue;
		}
		if (!gpu.supports_p2p_to(0))
		{
			result=false;
			break;
		}
	}
	return result;
}