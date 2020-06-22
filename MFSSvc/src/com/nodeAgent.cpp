#include "nodeAgent.h"

COMM::NodeAgent::NodeAgent()
    :parent(MPI_COMM_NULL,boost::mpi::comm_attach),self(MPI_COMM_SELF,boost::mpi::comm_attach){

}