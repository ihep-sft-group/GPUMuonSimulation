//
// Created by 易培淮 on 2019/12/12.
//

#ifndef MFS2ALG_UNPARK_FUNC_H
#define MFS2ALG_UNPARK_FUNC_H


namespace MFSPack {
    inline void unpack_args_impl(boost::archive::binary_iarchive &) {}

    template<typename T, typename... Args>
    inline typename std::enable_if<!is_tuple<T>::value>::type
    unpack_args_impl(boost::archive::binary_iarchive &ia, T &&t, Args &&... args) {
        ia >> t;
        unpack_args_impl(ia, std::forward<Args>(args)...);
    }


    template<typename T, typename... Args>
    inline typename std::enable_if<is_tuple<T>::value>::type
    unpack_args_impl(boost::archive::binary_iarchive &ia, T &&t, Args &&... args) {
        unpack_tuple(ia, std::forward<T>(t));
        unpack_args_impl(ia, std::forward<Args>(args)...);
    }
}
#endif //MFS2ALG_UNPARK_FUNC_H
