# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/ExternalLibs/Cmake/3.15.2/bin/cmake

# The command to remove a file.
RM = /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/ExternalLibs/Cmake/3.15.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build

# Include any dependencies generated for this target.
include CMakeFiles/GPUSvc.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/GPUSvc.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/GPUSvc.dir/flags.make

CMakeFiles/GPUSvc.dir/src/FastMuon.cu.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/FastMuon.cu.o: ../src/FastMuon.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CUDA object CMakeFiles/GPUSvc.dir/src/FastMuon.cu.o"
	/usr/local/cuda/bin/nvcc  $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/FastMuon.cu -o CMakeFiles/GPUSvc.dir/src/FastMuon.cu.o

CMakeFiles/GPUSvc.dir/src/FastMuon.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/GPUSvc.dir/src/FastMuon.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/GPUSvc.dir/src/FastMuon.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/GPUSvc.dir/src/FastMuon.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/GPUSvc.dir/src/GPU.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/GPU.cpp.o: ../src/GPU.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/GPUSvc.dir/src/GPU.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/GPU.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPU.cpp

CMakeFiles/GPUSvc.dir/src/GPU.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/GPU.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPU.cpp > CMakeFiles/GPUSvc.dir/src/GPU.cpp.i

CMakeFiles/GPUSvc.dir/src/GPU.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/GPU.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPU.cpp -o CMakeFiles/GPUSvc.dir/src/GPU.cpp.s

CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.o: ../src/GPUDeviceBuffer.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUDeviceBuffer.cpp

CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUDeviceBuffer.cpp > CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.i

CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUDeviceBuffer.cpp -o CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.s

CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.o: ../src/GPUExecConfig.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUExecConfig.cpp

CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUExecConfig.cpp > CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.i

CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUExecConfig.cpp -o CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.s

CMakeFiles/GPUSvc.dir/src/GPUList.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/GPUList.cpp.o: ../src/GPUList.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/GPUSvc.dir/src/GPUList.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/GPUList.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUList.cpp

CMakeFiles/GPUSvc.dir/src/GPUList.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/GPUList.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUList.cpp > CMakeFiles/GPUSvc.dir/src/GPUList.cpp.i

CMakeFiles/GPUSvc.dir/src/GPUList.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/GPUList.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUList.cpp -o CMakeFiles/GPUSvc.dir/src/GPUList.cpp.s

CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.o: ../src/GPUPartition.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUPartition.cpp

CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUPartition.cpp > CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.i

CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUPartition.cpp -o CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.s

CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.o: ../src/GPUPinnedBuffer.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUPinnedBuffer.cpp

CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUPinnedBuffer.cpp > CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.i

CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUPinnedBuffer.cpp -o CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.s

CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.o: ../src/GPUSvc.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUSvc.cpp

CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUSvc.cpp > CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.i

CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUSvc.cpp -o CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.s

CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.o: ../src/GPUUtil.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUUtil.cpp

CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUUtil.cpp > CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.i

CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/GPUUtil.cpp -o CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.s

CMakeFiles/GPUSvc.dir/src/Hit.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/Hit.cpp.o: ../src/Hit.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object CMakeFiles/GPUSvc.dir/src/Hit.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/Hit.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/Hit.cpp

CMakeFiles/GPUSvc.dir/src/Hit.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/Hit.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/Hit.cpp > CMakeFiles/GPUSvc.dir/src/Hit.cpp.i

CMakeFiles/GPUSvc.dir/src/Hit.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/Hit.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/Hit.cpp -o CMakeFiles/GPUSvc.dir/src/Hit.cpp.s

CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.o: ../src/MuonSimu.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CUDA object CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.o"
	/usr/local/cuda/bin/nvcc  $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/MuonSimu.cu -o CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.o

CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/GPUSvc.dir/src/NP.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/NP.cpp.o: ../src/NP.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object CMakeFiles/GPUSvc.dir/src/NP.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/NP.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/NP.cpp

CMakeFiles/GPUSvc.dir/src/NP.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/NP.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/NP.cpp > CMakeFiles/GPUSvc.dir/src/NP.cpp.i

CMakeFiles/GPUSvc.dir/src/NP.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/NP.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/NP.cpp -o CMakeFiles/GPUSvc.dir/src/NP.cpp.s

CMakeFiles/GPUSvc.dir/src/NPU.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/NPU.cpp.o: ../src/NPU.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Building CXX object CMakeFiles/GPUSvc.dir/src/NPU.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/NPU.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/NPU.cpp

CMakeFiles/GPUSvc.dir/src/NPU.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/NPU.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/NPU.cpp > CMakeFiles/GPUSvc.dir/src/NPU.cpp.i

CMakeFiles/GPUSvc.dir/src/NPU.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/NPU.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/NPU.cpp -o CMakeFiles/GPUSvc.dir/src/NPU.cpp.s

CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.o: CMakeFiles/GPUSvc.dir/flags.make
CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.o: ../src/PartitionUtilities.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_14) "Building CXX object CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.o"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.o -c /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/PartitionUtilities.cpp

CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.i"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/PartitionUtilities.cpp > CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.i

CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.s"
	/hpcfs/juno/junogpu/yiph/Muon/software/sl7/gcc/8.3.0/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/src/PartitionUtilities.cpp -o CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.s

# Object files for target GPUSvc
GPUSvc_OBJECTS = \
"CMakeFiles/GPUSvc.dir/src/FastMuon.cu.o" \
"CMakeFiles/GPUSvc.dir/src/GPU.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUList.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/Hit.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.o" \
"CMakeFiles/GPUSvc.dir/src/NP.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/NPU.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.o"

# External object files for target GPUSvc
GPUSvc_EXTERNAL_OBJECTS =

CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/FastMuon.cu.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/GPU.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/GPUList.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/Hit.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/NP.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/NPU.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.o
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/build.make
CMakeFiles/GPUSvc.dir/cmake_device_link.o: CMakeFiles/GPUSvc.dir/dlink.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_15) "Linking CUDA device code CMakeFiles/GPUSvc.dir/cmake_device_link.o"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/GPUSvc.dir/dlink.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/GPUSvc.dir/build: CMakeFiles/GPUSvc.dir/cmake_device_link.o

.PHONY : CMakeFiles/GPUSvc.dir/build

# Object files for target GPUSvc
GPUSvc_OBJECTS = \
"CMakeFiles/GPUSvc.dir/src/FastMuon.cu.o" \
"CMakeFiles/GPUSvc.dir/src/GPU.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUList.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/Hit.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.o" \
"CMakeFiles/GPUSvc.dir/src/NP.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/NPU.cpp.o" \
"CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.o"

# External object files for target GPUSvc
GPUSvc_EXTERNAL_OBJECTS =

../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/FastMuon.cu.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/GPU.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/GPUDeviceBuffer.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/GPUExecConfig.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/GPUList.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/GPUPartition.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/GPUPinnedBuffer.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/GPUSvc.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/GPUUtil.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/Hit.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/MuonSimu.cu.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/NP.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/NPU.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/src/PartitionUtilities.cpp.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/build.make
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/cmake_device_link.o
../amd64_linux26/libGPUSvc.so: CMakeFiles/GPUSvc.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_16) "Linking CXX shared library ../amd64_linux26/libGPUSvc.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/GPUSvc.dir/link.txt --verbose=$(VERBOSE)
	ln -sf /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/amd64_linux26/libGPUSvc.so /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/InstallArea/amd64_linux26/lib/libGPUSvc.so
	echo [install]Symbolic\ link\ generation\ completed

# Rule to build all files generated by this target.
CMakeFiles/GPUSvc.dir/build: ../amd64_linux26/libGPUSvc.so

.PHONY : CMakeFiles/GPUSvc.dir/build

CMakeFiles/GPUSvc.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/GPUSvc.dir/cmake_clean.cmake
.PHONY : CMakeFiles/GPUSvc.dir/clean

CMakeFiles/GPUSvc.dir/depend:
	cd /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc/GPUSvc/build/CMakeFiles/GPUSvc.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/GPUSvc.dir/depend
