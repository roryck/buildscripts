# build script for NWSC-3 MPAS Benchmark on Derecho
# ncarenv-23.04

# load environment
module --force purge
module load ncarenv/23.04
module load nvhpc/23.1
module load cray-mpich/8.1.25
module load netcdf-mpi/4.9.1
module load parallel-netcdf/1.12.3
module load parallelio/2.5.10
module load cuda/11.7.1
module load ncarcompilers/0.8.0

# clean previous build
make clean CORE=atmosphere

# build with just a hint of parallelism
make -j 4 nvhpc-derecho CORE=atmosphere OPENACC=true PRECISION=single USE_PIO2=true |& tee MAKE.log


