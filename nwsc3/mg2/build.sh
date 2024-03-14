#!/bin/bash -l

# find base directory containing files needed for build
fpath=`readlink -f ${BASH_SOURCE:-$0}`
basedir=`dirname $fpath`

# move data directory to work with AWT execution model
mv data.72cores v14/.

# load environment
module --force purge
hn=`hostname | cut -c 1-2`
if [ "$hn" == "gu" ]; then
   module load ncarenv/23.09 craype/2.7.23 intel/2024.0.2 cray-mpich/8.1.27 mkl/2024.0.0 ncarcompilers/1.0.0
elif [ "$hn" == "de" ]; then
   module load ncarenv/23.09 craype/2.7.20 intel-classic/2023.2.1 cray-mpich/8.1.25 mkl/2023.2.0 ncarcompilers/1.0.0
else
   echo "Unknown host"
   exit 137
fi

# copy patched files
cp $basedir/Makefile v14/Makefile
cp $basedir/Macros.$hn v14/Macros
cp $basedir/kgen_statefile.lst.16 v14/data.72cores/pcols16/kgen_statefile.lst
cp $basedir/kgen_statefile.lst.32 v14/data.72cores/pcols32/kgen_statefile.lst
cp $basedir/kgen_statefile.lst.48 v14/data.72cores/pcols48/kgen_statefile.lst
cp $basedir/kgen_statefile.lst.64 v14/data.72cores/pcols64/kgen_statefile.lst
cp $basedir/kgen_statefile.lst.96 v14/data.72cores/pcols96/kgen_statefile.lst
cp $basedir/kgen_statefile.lst.192 v14/data.72cores/pcols192/kgen_statefile.lst

# compile executable
cd v14
make clean
make -j 4 pcols=16 |& tee MAKE.log

