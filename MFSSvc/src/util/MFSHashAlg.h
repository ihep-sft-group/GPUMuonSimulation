#ifndef MFS2ALG_MFSHASHALG_H
#define MFS2ALG_MFSHASHALG_H
#include <stdint.h>


extern uint32_t murmur3_32(const char *key, uint32_t len, uint32_t seed = 17);


#endif //MFS2ALG_MFSHASHALG_H