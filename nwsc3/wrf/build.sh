# build script for NWSC-3 WRF Benchmark on Derecho / Gust

# load environment
module --force purge
hn=`hostname | cut -c 1-2`
if [ "$hn" == "gu" ]; then
   module load ncarenv/23.09 intel/2024.0.2 craype/2.7.23 cray-mpich/8.1.27 mkl/2024.0.0 hdf5-mpi/1.14.3 netcdf-mpi/4.9.2 parallel-netcdf/1.12.3 ncarcompilers/1.0.0
elif [ "$hn" == "de" ]; then
   module load ncarenv/23.09 intel-classic/2023.2.1 craype/2.7.20 cray-mpich/8.1.25 mkl/2023.2.0 netcdf-mpi/4.9.2 parallel-netcdf/1.12.3 ncarcompilers/1.0.0
else
   echo "Unknown host"
   exit 137
fi

# clean previous build
./clean -a

# configure dm+sm for broadwell
# for AMD arch w/ the intel compiler, need to swap arch flags, and patch config files
sed -i "s/CFLAGS_LOCAL    =/CFLAGS_LOCAL    = -std=gnu89/g" arch/configure.defaults
sed -i "s/-no-prec-div//g;s/-no-prec-sqrt//g" arch/configure.defaults
sed -i "s/-fpp -auto//g" arch/configure.defaults
sed -i "s/ icc/ icx/g" arch/configure.defaults
sed -i "s/-xCORE-AVX2/-march=core-avx2/g;s/-xHost/-march=core-avx2/g" arch/configure.defaults
sed -i "s/= CONFIGURE_NMM_CORE/= -O2 -std=gnu89 CONFIGURE_NMM_CORE/" arch/postamble
echo 67 | ./configure

# build with just a hint of parallelism
export CFLAGS="-O2 -std=gnu89"
export CFLAGS_LOCAL="-O2 -std=gnu89"
./compile -j 4 em_real |& tee MAKE.log
