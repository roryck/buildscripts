#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`

# move data directory to work with AWT execution model
mv data orig/.

# load environment
hn=`hostname | cut -c 1-2`
module --force purge
if [ "$hn" == "gu" ]; then
   module load ncarenv/23.09 craype/2.7.23 intel/2024.0.2 cray-mpich/8.1.27 mkl/2024.0.0 ncarcompilers/1.0.0
elif [ "$hn" == "de" ]; then
   module load ncarenv/23.09 craype/2.7.20 intel-classic/2023.2.1 cray-mpich/8.1.25 mkl/2023.2.0 ncarcompilers/1.0.0
else
   echo "Unknown host"
   exit 137
fi

# copy patched files
cp $basedir/Makefile orig/Makefile
cp $basedir/Macros.$hn orig/Macros
cp $basedir/kgen_statefile.lst orig/data/162K/kgen_statefile.lst

# compile executable
cd orig
make clean
make -j 4 |& tee MAKE.log
