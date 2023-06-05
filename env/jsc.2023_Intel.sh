#!/usr/bin/env bash

# Load modules
module --force purge
module use $OTHERSTAGES
module load Stages/2023
module load Intel/2022.1.0
module load ParaStationMPI/5.7.0-1
#
module load Hypre/2.27.0-cpu
module load Silo/4.11
module load Tcl/8.6.12 
#
module load ecCodes/2.27.0 
module load HDF5/1.12.2-serial 
module load netCDF/4.9.0
module load netCDF-Fortran/4.6.0
module load PnetCDF/1.12.3
module load cURL/7.83.0
module load Szip/.2.1.1 
module load Python/3.10.4
module load NCO/5.1.3  
module load CMake/3.23.1
module load git/2.36.0-nodocs  

module li

# Set default compilers
export CC=mpicc
export FC=mpif90
export CXX=mpicxx
export MPI_HOME=$EBROOTPSMPI

# Set OASIS root
export OASIS_ROOT="/p/project/cslts/software/$STAGE/${SYSTEMNAME}/OASIS3-MCT/5.0"
if [[ ":$CMAKE_PREFIX_PATH:" != *":${OASIS_ROOT}:"* ]]; then
  CMAKE_PREFIX_PATH="${CMAKE_PREFIX_PATH:+"$CMAKE_PREFIX_PATH:"}${OASIS_ROOT}"
fi
