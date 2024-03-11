#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`

# move data directory to work with AWT execution model
mv data v01/.

# copy patched files
cp $basedir/Makefile v01/Makefile
cp $basedir/Macros v01/Macros
cp $basedir/kgen_statefile.lst.16 v01/data/pcols16/kgen_statefile.lst
cp $basedir/kgen_statefile.lst.192 v01/data/pcols192/kgen_statefile.lst

# load environment
module --force purge
module load ncarenv/23.06 craype/2.7.20 cce/15.0.1 cray-mpich/8.1.25 cray-libsci/23.02.1.1 ncarcompilers/1.0.0

# compile executable
cd v01
make clean
make -j 4 |& tee MAKE.log

