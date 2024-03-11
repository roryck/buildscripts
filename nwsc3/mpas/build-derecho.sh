# build script for NWSC-3 MPAS Benchmark on Derecho

# load environment
module --force purge
module load ncarenv/23.09 nvhpc/23.7 craype/2.7.20 cray-mpich/8.1.25 cuda/11.7.1 netcdf-mpi/4.9.2 parallel-netcdf/1.12.3 parallelio/2.6.2 ncarcompilers/1.0.0

# clean previous build
make clean CORE=atmosphere

# build with just a hint of parallelism
make -j 4 nvhpc-derecho CORE=atmosphere OPENACC=true PRECISION=single USE_PIO2=true |& tee MAKE.log


