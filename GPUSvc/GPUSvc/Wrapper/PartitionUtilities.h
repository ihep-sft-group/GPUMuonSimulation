#pragma once

#include <iostream>
#include <vector>


typedef std::pair<int, int> interval_t; // first:begin second:end
typedef std::vector<interval_t> partition_t;

// divide the data from start top end into num_parts parts
partition_t partition(const int start, const int end, const int num_parts);