#ifndef MFS2ALG_MFSHASH_H
#define MFS2ALG_MFSHASH_H

#include <map>
#include <string.h>
#include <sstream>
#include "MFSHashAlg.h"

using namespace std;

namespace Util {
    class MFSHash {
    public:
        MFSHash(int node_num, int virtual_node_num);

        ~MFSHash();

        void init();

        size_t getId(const char *key);

        void deleteNode(const int index);

        void addNode(const int index);

    private:
        int m_node_num;//物理节点个数
        int m_virtual_node_num;//每个节点的虚拟节点个数
        map<uint32_t, size_t> m_server_nodes; //虚拟节点,key是哈希值，value是节点的index
    };
}

#endif //MFS2ALG_MFSHASH_H