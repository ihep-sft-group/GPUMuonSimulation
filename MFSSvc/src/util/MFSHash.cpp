//
// Created by 易培淮 on 2019/10/3.
//
#include <iostream>
#include "MFSHash.h"

Util::MFSHash::MFSHash(int node_num, int virtual_node_num) {
    m_node_num = node_num;
    m_virtual_node_num = virtual_node_num;
}

Util::MFSHash::~MFSHash() {
    m_server_nodes.clear();
}


void Util::MFSHash::init() {
    for (int i = 0; i < m_node_num; ++i) {
        for (int j = 0; j < m_virtual_node_num; ++j) {
            stringstream node_key;
            node_key << "SHARD-" << i << "-NODE-" << j;
            uint32_t partition = murmur3_32(node_key.str().c_str(), strlen(node_key.str().c_str()));
            m_server_nodes.insert(pair<uint32_t, size_t>(partition, i));
        }
    }
}


size_t Util::MFSHash::getId(const char *key) {
    uint32_t partition = murmur3_32(key, strlen(key));
    map<uint32_t, size_t>::iterator it = m_server_nodes.lower_bound(partition);//沿环的顺时针找到一个大于等于key的虚拟节点

    if (it == m_server_nodes.end())//未找到
    {
        return m_server_nodes.begin()->second;
    }
    return it->second;
}

void Util::MFSHash::deleteNode(const int index) {
    for (int j = 0; j < m_virtual_node_num; ++j) {
        stringstream node_key;
        node_key << "SHARD-" << index << "-NODE-" << j;
        uint32_t partition = murmur3_32(node_key.str().c_str(), strlen(node_key.str().c_str()));
        map<uint32_t, size_t>::iterator it = m_server_nodes.find(partition);
        if (it != m_server_nodes.end()) {
            m_server_nodes.erase(it);
        }
    }
}

void Util::MFSHash::addNode(const int index) {
    for (int j = 0; j < m_virtual_node_num; ++j) {
        stringstream node_key;
        node_key << "SHARD-" << index << "-NODE-" << j;
        uint32_t partition = murmur3_32(node_key.str().c_str(), strlen(node_key.str().c_str()));
        m_server_nodes.insert(pair<uint32_t, size_t>(partition, index));
    }
}
