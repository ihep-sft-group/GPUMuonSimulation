//
// Created by 易培淮 on 2019/10/5.
//
#include <iostream>
#include "file.h"

std::string Util::getServerPort() {
    boost::filesystem::path file_path = boost::filesystem::current_path() / "serverPort.ini";
    BOOST_ASSERT(boost::filesystem::exists(file_path));
    boost::filesystem::fstream fstream_read(file_path, std::ios_base::in);
    std::string server_port;
    fstream_read >> server_port;
    fstream_read.close();
    return server_port;
}

std::string Util::getServerPort(std::string filepath) {
    boost::filesystem::path file_path(filepath);
    BOOST_ASSERT(boost::filesystem::exists(file_path.parent_path()));
    if(boost::filesystem::is_directory(file_path)){//判断是否为文件夹
        file_path = file_path / "serverPort.ini";
    }
    else{
        file_path = file_path.parent_path() / "serverPort.ini";
    }
    while(!boost::filesystem::exists(file_path)){
        sleep(1);
    }
    boost::filesystem::fstream fstream_read(file_path, std::ios_base::in);
    std::string server_port;
    fstream_read >> server_port;
    fstream_read.close();
    return server_port;
}

void Util::saveServerPort(const char *port_name){
    boost::filesystem::path file_path = boost::filesystem::current_path() / "serverPort.ini";
    boost::filesystem::fstream fstream_write(file_path, std::ios_base::out);
    fstream_write << port_name;
    fstream_write.close();
}

void Util::saveServerPort(const char *port_name,std::string filepath){
    boost::filesystem::path file_path(filepath);
    if(boost::filesystem::is_directory(file_path)){//判断是否为文件夹
        file_path = file_path / "serverPort.ini";
    }
    else{
        file_path = file_path.parent_path() / "serverPort.ini";
    }
    boost::filesystem::fstream fstream_write(file_path, std::ios_base::out);
    fstream_write << port_name;
    fstream_write.close();
    BOOST_ASSERT(boost::filesystem::exists(file_path));
}

void Util::rmConfigFile(std::string filepath){
    boost::filesystem::path file_path(filepath);
    if(boost::filesystem::is_directory(file_path)){//判断是否为文件夹
        file_path = file_path / "serverPort.ini";
    }
    else{
        file_path = file_path.parent_path() / "serverPort.ini";
    }
    if(boost::filesystem::exists(file_path)){//存在就删除
        boost::filesystem::remove(file_path);
    }
}