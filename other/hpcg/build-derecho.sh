#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`
echo "BASE: $basedir"

# copy patched files
cp $basedir/Make.derecho setup/Make.derecho

# load environment
module --force purge
module load ncarenv/23.09 craype/2.7.20 intel/2023.2.1 mkl/2023.2.0 cray-mpich/8.1.25 ncarcompilers/1.0.0

# compile executable
mkdir build
cd build
../configure derecho
make
