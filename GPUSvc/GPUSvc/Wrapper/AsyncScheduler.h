#pragma once


#include <functional>
#include <future>
#include <vector>

template <class T>
class AsyncScheduler
{

public:

	void sync(std::vector<T> partitions, std::function<void(T)> closure) const
	{
		// Start all
		std::vector<decltype(async(closure, partitions[0]))> futures;
		for (auto& partition : partitions)
		{
			auto f = std::async(std::launch::async, closure, partition);
			futures.push_back(move(f));
		}
		// Sync
		for (auto& f : futures)
		{
			f.get();
		}
	}

};
