cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
set(name GPUSvc)
project(${name} LANGUAGES CXX CUDA)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -rdynamic")

## ROOT
include_directories($ENV{JUNO_EXTLIB_ROOT_HOME}/include)
find_program(ROOT_CONFIG_EXECUTABLE root-config
    PATHS $ENV{JUNO_EXTLIB_ROOT_HOME}/bin)
execute_process(
    COMMAND ${ROOT_CONFIG_EXECUTABLE} --evelibs
    OUTPUT_VARIABLE ROOT_LIBRARIES
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
link_directories($ENV{JUNO_EXTLIB_ROOT_HOME}/lib)


## Python
include_directories($ENV{JUNO_EXTLIB_Python_HOME}/include/python2.7)
find_library(PYTHON_LIBRARIES python
    HINTS $ENV{JUNO_EXTLIB_Python_HOME}/lib
)
link_directories($ENV{JUNO_EXTLIB_Python_HOME}/lib)
    
## Boost
include_directories($ENV{JUNO_EXTLIB_Boost_HOME})
find_library(BOOST_LIBRARIES boost_python
    HINTS $ENV{JUNO_EXTLIB_Boost_HOME}/lib
)
link_directories($ENV{JUNO_EXTLIB_Boost_HOME}/lib)

## SNiPER
include_directories(
    $ENV{SNIPERKERNELROOT}
    $ENV{ROOTWRITERROOT}
    $ENV{DATABUFFERROOT}
)
find_library(SNIPERKERNEL_LIBRARIES SniperKernel SniperPython
    HINTS $ENV{SNIPERKERNELROOT}/$ENV{CMTCONFIG}
)
link_directories($ENV{SNIPERKERNELROOT}/$ENV{CMTCONFIG})
find_library(ROOTWRITER_LIBRARIES RootWriter
    HINTS $ENV{ROOTWRITERROOT}/$ENV{CMTCONFIG}
)
link_directories($ENV{ROOTWRITERROOT}/$ENV{CMTCONFIG})

## Pthread
find_package( Threads )


## CUDA
#nvcc c++11
include_directories ("/usr/local/cuda/include")
#设定device函数分开编译
set(CMAKE_CUDA_SEPARABLE_COMPILATION ON)
if(NOT DEFINED CMAKE_CUDA_STANDARD)
    set(CMAKE_CUDA_STANDARD 11)
    set(CMAKE_CUDA_STANDARD_REQUIRED ON)
    set(CMAKE_CUDA_FLAGS -G)
endif()


#指定输出库和可执行文件路径
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/amd64_linux26)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/amd64_linux26)

#指定源文件路径
aux_source_directory(./src DIR_LIB_SRCS)
#指定头文件路径
# include_directories (${PROJECT_SOURCE_DIR}/${name})
include_directories (${PROJECT_SOURCE_DIR})


#生成动态库
add_library(${name} SHARED 
    ${DIR_LIB_SRCS} 
)
target_link_libraries( ${name} ${CMAKE_THREAD_LIBS_INIT} )

#写入安装区
add_custom_command(TARGET ${name}
    POST_BUILD
    COMMAND ln -sf ${PROJECT_SOURCE_DIR}/amd64_linux26/lib${name}.so $ENV{JUNOTOP}/offline/InstallArea/amd64_linux26/lib/lib${name}.so
    COMMAND echo "[install]Symbolic link generation completed"
)
#添加python包
install(DIRECTORY python/  DESTINATION $ENV{JUNOTOP}/offline/InstallArea/python/)
#添加头文件到installArea
install(DIRECTORY ${name}/  DESTINATION $ENV{JUNOTOP}/offline/InstallArea/include/${name})