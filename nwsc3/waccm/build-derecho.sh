#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`

# move data directory to work with AWT execution model
mv data v05/.

# copy patched files
cp $basedir/Macros v05/Macros
cp $basedir/kernel_driver.F90 v05/kernel_driver.F90

# load environment
module --force purge
module load ncarenv/23.04 craype/2.7.20 cce/15.0.1 cray-mpich/8.1.25 cray-libsci/23.02.1.1 ncarcompilers/0.8.0

# compile executable
cd v05
make clean
make -j 4 |& tee MAKE.log

