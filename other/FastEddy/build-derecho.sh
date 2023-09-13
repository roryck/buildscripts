#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`
echo "BASE: $basedir"

# copy patched files
cp $basedir/Makefile SRC/FEMAIN/Makefile

# load environment
module --force purge
module load ncarenv/23.06 nvhpc/23.1 cray-mpich/8.1.25 cuda/11.7.1 netcdf-mpi/4.9.2 ncarcompilers/1.0.0

# compile executable
cd SRC/FEMAIN
make clean && make
