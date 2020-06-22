//
// Created by 易培淮 on 2019/9/30.
//

#ifndef MFS2ALG_FILE_H
#define MFS2ALG_FILE_H
#include <boost/filesystem.hpp>

namespace Util {
    std::string getServerPort();
    std::string getServerPort(std::string filepath);
    void saveServerPort(const char *port_name);
    void saveServerPort(const char *port_name,std::string filepath);
    void rmConfigFile(std::string filepath);
}
#endif //MFS2ALG_FILE_H
