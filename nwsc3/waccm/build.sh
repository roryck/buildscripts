#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`

# move data directory to work with AWT execution model
mv data v05/.

# load environment
hn=`hostname | cut -c 1-2`
module --force purge
if [ "$hn" == "gu" ]; then
   module load ncarenv/23.09 craype/2.7.23 intel/2024.0.2 cray-mpich/8.1.27 mkl/2024.0.0 ncarcompilers/1.0.0
elif [ "$hn" == "de" ]; then
   module load ncarenv/23.06 craype/2.7.20 cce/15.0.1 cray-mpich/8.1.25 cray-libsci/23.02.1.1 ncarcompilers/1.0.0
else
   echo "Unknown host"
   exit 137
fi

# copy patched files
cp $basedir/Macros.$hn v05/Macros
cp $basedir/kernel_driver.F90 v05/kernel_driver.F90

# compile executable
cd v05
make clean
make -j 4 |& tee MAKE.log

