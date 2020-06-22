#ifndef GPUList_H
#define GPUList_H

#include <cuda_runtime_api.h>
#include <stdexcept>
#include <iostream>
#include "GPU.h"
#include "GPUUtil.h"
#include <vector>
#include <algorithm>
#include <iterator>
#include <map>


using namespace std;

class GPUList
{
public:

	GPUList();

	int get_number_of_GPU() const
	{
		return m_gpu_number;
	}

	void set_number_of_GPU(int n)
	{
		m_gpu_number = n;
	}

	GPU get_gpu(const int i) const
	{
		return gpulist[i];
	}

	std::vector<GPU> get_GPUList() const
	{
		return gpulist;
	}

	// returns all the GPUList capable of P2P 
	// (compute capability >= 2 && TCC driver if windows)
	std::vector<GPU> get_p2p_GPUList();

	// lazy getter
	std::vector<std::vector<GPU>> get_p2p_cliques()
	{
		if (!p2p_cliques_determined)
		{
			search_p2p_gpu();
		}
		return p2p_cliques;
	}

	// enables P2P with cudaDeviceEnablePeerAccess()
	void enable_p2p();

	// disables P2P with cudaDeviceEnablePeerAccess()
	void disable_p2p();

	// check other gpu can p2p with gpu 0
	bool check_p2p_just_gpu0();
 
	// for looping with "for (auto& gpu : GPUList)"
	std::vector<GPU>::const_iterator begin() const
	{
		return gpulist.begin();
	}

	// for looping with "for (auto& gpu : GPUList)"
	std::vector<GPU>::const_iterator end() const
	{
		return gpulist.end();
	}

	// for GPUList[1]
	GPU operator[](const int idx) const
	{
		return gpulist[idx];
	}

	void search_gpu();

private:

	void search_p2p_gpu();

private:

	// the number of GPUList
	int m_gpu_number;

	// the GPU information
	std::vector<GPU> gpulist;

	bool p2p_cliques_determined = false;

	// the P2P 'cliques', see search_p2p_gpu()
	std::vector<std::vector<GPU>> p2p_cliques;

};

#endif