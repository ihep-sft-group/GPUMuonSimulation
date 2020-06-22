#ifndef UNPINNEDBUFFER_H
#define UNPINNEDBUFFER_H

#include "HostBuffer.h"
#include <memory>

template <typename T, class E = Extent>
class UnpinnedBuffer
	: public HostBuffer < T, E >
{

public:

	UnpinnedBuffer(const E& e)
		: HostBuffer<T, E>(e)
	{
	}

	virtual ~UnpinnedBuffer()
	{
		if (ptr)
		{
			free();
		}
	}

	void alloc()
	{
		const size_t sz = BaseBuffer<T, E>::get_size_in_bytes();
		ptr = (T*)malloc(sz);
		version = 0;
	}

	void free()
	{
		if (ptr)
		{
			::free(ptr);
			ptr = 0;
			version = -1;
		}
	}

	using BaseBuffer<T, E>::ptr;

	using BaseBuffer<T, E>::version;

	static std::shared_ptr<UnpinnedBuffer<T, E>> make_shared(const E& e)
	{
		UnpinnedBuffer<T, E>* ptr = new UnpinnedBuffer<T, E>(e);
		return std::shared_ptr<UnpinnedBuffer<T, E>>(ptr);
	}

};







#endif