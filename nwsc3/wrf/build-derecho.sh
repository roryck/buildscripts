# build script for NWSC-3 WRF Benchmark on Derecho
# ncarenv-23.04

# load environment
module --force purge
module load ncarenv/23.04
module load intel/2023.0.0
module load cray-mpich/8.1.25
module load mkl/2023.0.0
module load netcdf-mpi/4.9.1
module load parallel-netcdf/1.12.3
module load ncarcompilers/0.8.0

# clean previous build
./clean -a

# configure dm+sm for broadwell
# for AMD arch, will need to g/-xCORE-AVX2/s//-march=core-avx2/g; :g/-xHost/s//-march=core-avx2/g
echo 67 | ./configure

# build with just a hint of parallelism
./compile -j 4 em_real |& tee MAKE.log
