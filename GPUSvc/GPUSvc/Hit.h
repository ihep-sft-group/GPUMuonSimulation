#ifndef SNIPER_HIT_H
#define SNIPER_HIT_H
namespace VoxelMethodHelper {
class hitsResult
{
public:
    int pmtid;
    double hittime;

    template<class Archive>
    void serialize(Archive &ar, const unsigned int) {
        ar & pmtid;
        ar & hittime;
    }
    hitsResult(int pmtid,double hittime);
    hitsResult();
};

class gpuHitResult
{
public:
    double npe[17746*3000];
    double hittime[17746*3000];

    template<class Archive>
    void serialize(Archive &ar, const unsigned int) {
        ar & npe;
        ar & hittime;
    }
    gpuHitResult();
};

class StepInfo
{
public:
    double step_r;
    int step_energy_intPart;
    double step_energy_fractionPart;
    double step_pos_x;
    double step_pos_y;
    double step_pos_z;
    double step_start_time;
    int step_evt_id;

    template<class Archive>
    void serialize(Archive &ar, const unsigned int) {
        ar & step_r;
        ar & step_energy_intPart;
        ar & step_energy_fractionPart;
        ar & step_pos_x;
        ar & step_pos_y;
        ar & step_pos_z;
        ar & step_start_time;
        ar & step_evt_id;
    }

    StepInfo(double r, int energy_intPart, double energy_fractionPart,
                double pos_x, double pos_y, double pos_z, double start_time,
                int evt_id);
    StepInfo();
};
}
#endif