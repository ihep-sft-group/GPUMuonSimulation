//
// Created by 易培淮 on 2019/12/8.
//

#ifndef MFS2ALG_MPISERVICE_H
#define MFS2ALG_MPISERVICE_H

#include <boost/thread/thread.hpp>
#include "MFSSvc/core/baseContext.hpp"
#include "MFSSvc/mfspack/mfspack.hpp"
#include "MFSSvc/control/internalQueue.h"

// sniper主接口
class MPIService {
public:
    MPIService(bool isMaster, int nodeNum,std::string filePath);
    MPIService(bool isMaster, int nodeNum);

    ~MPIService();

    template<typename T>
    T get() {//for slave
        BOOST_ASSERT(!isMaster());
        std::string str;
        mfsToSniper.wait_and_pop(str);
        MFSPack::unpack up(str);
        T data;
        up.unpack_args(data);
        return data;
    }

    template<typename T>
    void get(T &data) {//for master
        BOOST_ASSERT(isMaster());
        std::string str;
        mfsToSniper.wait_and_pop(str);
        MFSPack::unpack up(str);
        up.unpack_args(data);
    }

    template<typename T>
    typename std::enable_if<!std::is_same<T,std::string>::value>::type post(T data) {
        MFSPack::pack p;
        p.pack_args(data);
        sniperToMfs.push(p.get_string());
    }

    template<typename T>
    typename std::enable_if<std::is_same<T,std::string>::value>::type post(T data) {
        sniperToMfs.push(data);
    }

    template<typename... Args>
    void post_datas(Args&&... datas){
        MFSPack::pack p;
        p.pack_args(std::forward<Args>(datas)...);
        sniperToMfs.push(p.get_string());
    }

    template<typename... Args>
    bool get_datas(Args&&... datas){
       std::string str;
       mfsToSniper.wait_and_pop(str);
       if(str.empty()){
           return false;
       }
       MFSPack::unpack up(str);
       up.unpack_args(std::forward<Args>(datas)...);
       return true;
    }

    // bool probe();
    void exit();//退出
    bool isMaster() const;

    void setIsMaster(bool isMaster);

private:
    void _close();

    bool m_isMaster;
    BaseContext *m_baseContext;
    boost::thread *m_thread;
};


#endif //MFS2ALG_MPISERVICE_H
