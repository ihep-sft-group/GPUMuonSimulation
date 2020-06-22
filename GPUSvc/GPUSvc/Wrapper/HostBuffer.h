#pragma once

#include "GPUBaseBuffer.h"

template <typename T, class E = Extent>
class HostBuffer
	: public BaseBuffer<T, E>
{

public:

	HostBuffer(const E& e)
		: BaseBuffer<T, E>(e)
	{
	}

	virtual ~HostBuffer()
	{
	}

};