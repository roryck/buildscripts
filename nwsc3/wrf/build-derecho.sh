# build script for NWSC-3 WRF Benchmark on Derecho

# load environment
module --force purge
module load ncarenv/23.09 intel-classic/2023.2.1 craype/2.7.20 cray-mpich/8.1.25 mkl/2023.2.0 netcdf-mpi/4.9.2 parallel-netcdf/1.12.3 ncarcompilers/1.0.0

# clean previous build
./clean -a

# configure dm+sm for broadwell
# for AMD arch w/ the intel compiler, need to swap arch flags
sed -i "s/-xCORE-AVX2/-march=core-avx2/g;s/-xHost/-march=core-avx2/g" arch/configure.defaults
echo 67 | ./configure

# build with just a hint of parallelism
./compile -j 4 em_real |& tee MAKE.log
