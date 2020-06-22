#ifndef GPUSTREAM_H
#define GPUSTREAM_H

#include <cuda_runtime_api.h>
#include <vector>
#include <map>

struct Stream
{

	Stream(const int _device, cudaStream_t& _stream)
		: device(_device)
		, stream(_stream)
	{
	}

	cudaStream_t stream;
	int device;
};


class StreamList
{
public:

	void add(Stream stream)
	{
		streamList.push_back(stream);
		gpuOfStream[stream] = stream.device;
		streamListOfGPU[stream.device].push_back(stream);
	}

private:

	std::vector<Stream> streamList;
	std::map<Stream, int> gpuOfStream;
	std::map<int, std::vector<Stream>> streamListOfGPU;
};



#endif