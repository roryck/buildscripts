# build script for NWSC-3 WRF Benchmark on Derecho
# ncarenv-23.09 w/ profiling

# load environment
module --force purge
module load ncarenv/23.09
module load craype/2.7.20
module load intel-classic/2023.2.1
module load cray-mpich/8.1.25
module load mkl/2023.2.0
module load netcdf-mpi/4.9.2
module load parallel-netcdf/1.12.3
module load perftools-base/23.03.0
module load perftools-lite
export HDF5=$NCAR_ROOT_HDF5

# clean previous build
./clean -a

# configure dm+sm for broadwell
# for AMD arch w/ the intel compiler, need to swap arch flags
sed -i "s/-xCORE-AVX2/-march=core-avx2/g;s/-xHost/-march=core-avx2/g" arch/configure.defaults
# update hdf5 library underscoring
sed -i "s/hdf5hl_fortran/hdf5_hl_fortran/g" arch/Config.pl
sed -i "s/hdf5hl_fortran/hdf5_hl_fortran/g" compile
echo 67 | ./configure

# build with just a hint of parallelism
./compile -j 4 em_real |& tee MAKE.log
