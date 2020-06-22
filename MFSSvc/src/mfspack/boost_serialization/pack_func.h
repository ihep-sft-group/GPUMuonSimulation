//
// Created by 易培淮 on 2019/12/12.
//

#ifndef MFS2ALG_PACK_FUNC_H
#define MFS2ALG_PACK_FUNC_H

namespace MFSPack {
    inline void pack_args_impl(boost::archive::binary_oarchive &) {}

    template<typename T, typename... Args>
    inline typename std::enable_if<!is_tuple<T>::value>::type
    pack_args_impl(boost::archive::binary_oarchive &oa, T &&t, Args &&... args) {
        oa << t;
        pack_args_impl(oa, std::forward<Args>(args)...);
    }

    template<typename T, typename... Args>
    inline typename std::enable_if<is_tuple<T>::value>::type
    pack_args_impl(boost::archive::binary_oarchive &oa, T &&t, Args &&... args) {
        pack_tuple(oa, std::forward<T>(t));
        pack_args_impl(oa, std::forward<Args>(args)...);
    }
}

#endif //MFS2ALG_PACK_FUNC_H
