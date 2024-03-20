# build script for NWSC-3 MPAS Benchmark on Derecho

# load environment
hn=`hostname | cut -c 1-2`
module --force purge
if [ "$hn" == "gu" ]; then
   module load ncarenv/23.09 nvhpc/24.1 craype/2.7.23 cray-mpich/8.1.27 cuda/12.2.1 hdf5-mpi/1.14.3 netcdf-mpi/4.9.2 parallel-netcdf/1.12.3 parallelio/2.6.2 ncarcompilers/1.0.0
elif [ "$hn" == "de" ]; then
   module load ncarenv/23.09 nvhpc/23.7 craype/2.7.20 cray-mpich/8.1.25 cuda/11.7.1 netcdf-mpi/4.9.2 parallel-netcdf/1.12.3 parallelio/2.6.2 ncarcompilers/1.0.0
else
   echo "Unknown host"
   exit 137
fi

# clean previous build
make clean CORE=atmosphere

# build with just a hint of parallelism
make -j 4 nvhpc-derecho CORE=atmosphere OPENACC=true PRECISION=single USE_PIO2=true |& tee MAKE.log


