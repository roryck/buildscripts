#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`
echo "BASE: $basedir"

# copy patched files
cp $basedir/Make.casper setup/Make.casper

# load environment
module --force purge
module load ncarenv/23.09 intel/2023.2.1 cuda/12.2.1 openmpi/4.1.6 mkl/2023.2.0 ncarcompilers/1.0.0

# compile executable
mkdir build
cd build
../configure casper
make
