#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`

# move data directory to work with AWT execution model
mv data orig/.

# copy patched files
cp $basedir/Makefile orig/Makefile
cp $basedir/Macros orig/Macros
cp $basedir/kgen_statefile.lst orig/data/162K/kgen_statefile.lst

# load environment
module --force purge
module load ncarenv/23.09 craype/2.7.20 intel-classic/2023.2.1 cray-mpich/8.1.25 mkl/2023.2.0 ncarcompilers/1.0.0

# compile executable
cd orig
make clean
make -j 4 |& tee MAKE.log
