#pragma once
#include "GPUBaseBuffer.h"
#include "GPUPinnedBuffer.h"
#include <memory>

template <typename T, class E = Extent>
class DeviceBuffer
	: public BaseBuffer<T, E>
{

public:

	DeviceBuffer(const E& e);

	virtual ~DeviceBuffer();

	void alloc();

	void free();

	void copy_from(const PinnedBuffer<T, E>& buf);

	void copy_to(PinnedBuffer<T, E>& buf) const;

	DeviceBuffer(const DeviceBuffer<T, E>&) = delete;				// no copies allowed

	using BaseBuffer<T, E>::ptr;
	
	using BaseBuffer<T, E>::version;

	static std::shared_ptr<DeviceBuffer<T, E>> make_shared(const E& e)
	{
		DeviceBuffer<T, E>* ptr = new DeviceBuffer<T, E>(e);
		return std::shared_ptr<DeviceBuffer<T, E>>(ptr);
	}
	
};