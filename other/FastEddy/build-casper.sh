#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`
echo "BASE: $basedir"

# copy patched files
cp $basedir/Makefile SRC/FEMAIN/Makefile

# load environment
module --force purge
module load ncarenv/23.09 nvhpc/23.7 openmpi/4.1.6 netcdf/4.9.2 cuda/12.2.1 ncarcompilers/1.0.0

# compile executable
cd SRC/FEMAIN
make clean && make
