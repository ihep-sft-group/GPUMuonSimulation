#pragma once

#include "HostBuffer.h"
#include <memory>

template <typename T, class E = Extent>
class PinnedBuffer
	: public HostBuffer<T, E>
{

public:

	PinnedBuffer(const E& e);

	virtual ~PinnedBuffer();

	void alloc();

	void free();

	// no copies allowed for c++11
	PinnedBuffer(PinnedBuffer<T, E>&) = delete;


	using BaseBuffer<T, E>::ptr;

	using BaseBuffer<T, E>::version;

	static std::shared_ptr<PinnedBuffer<T, E>> make_shared(const E& e)
	{
		PinnedBuffer<T, E>* ptr = new PinnedBuffer<T, E>(e);
		return std::shared_ptr<PinnedBuffer<T, E>>(ptr);
	}
	

};