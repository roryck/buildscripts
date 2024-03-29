#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`
echo "BASE: $basedir"

# copy patched files
cp $basedir/Makefile SRC/FEMAIN/Makefile

# load environment
source /etc/profile.d/z00_modules.sh
module --force purge
module load ncarenv/23.09 craype/2.7.20 nvhpc/23.7 cray-mpich/8.1.25 netcdf/4.9.2 ncarcompilers/1.0.0 cuda/11.8.0

# compile executable
cd SRC/FEMAIN
make clean && make
