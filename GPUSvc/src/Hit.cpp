#include "GPUSvc/Hit.h"

VoxelMethodHelper::hitsResult::hitsResult(int mpmtid,double mhittime):pmtid(mpmtid),hittime(mhittime){

}

VoxelMethodHelper::hitsResult::hitsResult():pmtid(0),hittime(0){

}

VoxelMethodHelper::StepInfo::StepInfo(double r, int energy_intPart, double energy_fractionPart,
                double pos_x, double pos_y, double pos_z, double start_time,
                int evt_id)
{
    this->step_r = r;
    this->step_energy_fractionPart = energy_fractionPart;
    this->step_energy_intPart = energy_intPart;
    this->step_pos_x = pos_x;
    this->step_pos_y = pos_y;
    this->step_pos_z = pos_z;
    this->step_start_time = start_time;
    this->step_evt_id = evt_id;
}
VoxelMethodHelper::StepInfo::StepInfo(){

}

VoxelMethodHelper::gpuHitResult::gpuHitResult(){
    
}