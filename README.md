# GPUMuonSimulation

## Compile
```sh
# 配置编译运行环境
cd /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch
source setup.sh
# MPI编译
cd MFSSvc/cmt 
cmt config
cmt make
# GPU编译
cd GPUSvc/build
cmake ../
make && make install
```

## Run
```sh
# 配置编译运行环境
cd /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch
source setup.sh
# GPU缪子快速模拟执行Demo
mdate='0325'
mindex='V1'
mevent='1'
mgpu='2'
ulimit -s 102400
ulimit -s
time python /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/Examples/Tutorial/share/tut_detsim.py \
--voxel-fast-sim --voxel-gpu-compute --voxel-merge-flag --no-cerenkov --pmtsd-merge-twindow 1.0 --pmt-hit-type 2 \
--voxel-gpu-num ${mgpu} --voxel-fast-dir /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/Examples/Tutorial/share \
--evtmax ${mevent} --seed 100 --output /hpcfs/juno/junogpu/yiph/Muon/result/0319data/gpu_${mdate}_${mevent}muon_g${mgpu}_sample_detsim_${mindex}.root \
--user-output /hpcfs/juno/junogpu/yiph/Muon/result/0319data/gpu_${mdate}_${mevent}muon_g${mgpu}_sample_user_detsim_${mindex}.root \
--no-gdml gun --particles mu- --positions 0 0 25000 --directions 0 0 -1 --momentums 215000 >>/hpcfs/juno/junogpu/yiph/Muon/result/0319data/gpu_${mdate}_${mevent}muon_g${mgpu}_output_${mindex}.txt
# MPI+GPU缪子快速模拟Demo

# 主节点
mdate='0331'
mindex='V1'
mevent='1'
mnode='1'
mgpu='1'
mrepeat='10'
ulimit -s 302400
ulimit -s
mkdir /hpcfs/juno/junogpu/yiph/Muon/result/mpidata/config${mgpu}${mrepeat}${index}${mevent}${mdate}
chmod 1777 /hpcfs/juno/junogpu/yiph/Muon/result/mpidata/config${mgpu}${mrepeat}${index}${mevent}${mdate}
time mpiexec -np 1 python /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/Examples/Tutorial/share/tut_detsim.py \
--voxel-fast-sim --no-pmt20inch --no-pmt3inch --disable-struts-fastens all --voxel-gpu-compute --voxel-merge-flag --no-cerenkov --pmtsd-merge-twindow 1.0 --pmt-hit-type 2 \
--voxel-gpu-num ${mgpu} --voxel-fast-dir /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/Examples/Tutorial/share --voxel-gpu-test ${mrepeat} \
--voxel-mpi-config-dir /hpcfs/juno/junogpu/yiph/Muon/result/mpidata/config${mgpu}${mrepeat}${index}${mevent}${mdate} \
--voxel-mpi-compute --voxel-mpigpu-compute --voxel-master-on --voxel-slave-num ${mnode} \
--output /hpcfs/juno/junogpu/yiph/Muon/result/mpidata/mpi_server_${mdate}_${mevent}muon${mrepeat}_${mnode}g${mgpu}_sample_detsim_${mindex}.root \
--user-output /hpcfs/juno/junogpu/yiph/Muon/result/mpidata/mpi_server_${mdate}_${mevent}muon${mrepeat}_${mnode}g${mgpu}_sample_user_detsim_${mindex}.root \
--evtmax ${mevent} --no-gdml --voxel-save-hits-off --voxel-big-step \
gun --particles mu- --positions 0 0 25000 --directions 0 0 -1 --momentums 215000 >>/hpcfs/juno/junogpu/yiph/Muon/result/mpidata/mpi_server_${mdate}_${mevent}muon${mrepeat}_g${mgpu}_n${mnode}_output_${mindex}.txt

#从节点
mdate='0331'
mindex='V3'
mevent='1'
mnode='1'
mgpu='1'
mrepeat='10'
mnodeid='1'
ulimit -s 302400
ulimit -s
time mpiexec -np 1 python /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/Examples/Tutorial/share/tut_detsim.py \
--voxel-fast-sim --no-pmt20inch --no-pmt3inch --disable-struts-fastens all --voxel-gpu-compute --voxel-merge-flag --no-cerenkov --pmtsd-merge-twindow 1.0 --pmt-hit-type 2 \
--voxel-gpu-num ${mgpu} --voxel-fast-dir /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/Examples/Tutorial/share --voxel-gpu-test ${mrepeat} \
--voxel-mpi-config-dir /hpcfs/juno/junogpu/yiph/Muon/result/mpidata/config${mgpu}${mrepeat}${index}${mevent}${mdate} \
--voxel-mpi-compute --voxel-mpigpu-compute --voxel-master-off \
--output /hpcfs/juno/junogpu/yiph/Muon/result/mpidata/mpi_client_${mdate}_${mevent}muon${mrepeat}_${mnode}g${mgpu}_${mnodeid}sample_detsim_${mindex}.root \
--user-output /hpcfs/juno/junogpu/yiph/Muon/result/mpidata/mpi_client_${mdate}_${mevent}muon${mrepeat}_${mnode}g${mgpu}_${mnodeid}sample_user_detsim_${mindex}.root \
--evtmax 1 --no-gdml --voxel-save-hits-off --voxel-big-step \
gun --particles mu- --positions 0 0 25000 --directions 0 0 -1 --momentums 215000 >>/hpcfs/juno/junogpu/yiph/Muon/result/mpidata/mpi_client_${mdate}_${mevent}muon${mrepeat}_g${mgpu}_${mnodeid}n${mnode}_output_${mindex}.txt
```
