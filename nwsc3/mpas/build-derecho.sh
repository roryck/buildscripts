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
module load ncarcompilers/0.8.0

# clean previous build
make clean CORE=atmosphere

# Add definitions like this to the makefile if necessary
#nvhpc-derecho:
#	( $(MAKE) all \
#	"FC_PARALLEL = ftn" \
#	"CC_PARALLEL = cc" \
#	"CXX_PARALLEL = CC" \
#	"FC_SERIAL = nvfortran" \
#	"CC_SERIAL = nvcc" \
#	"CXX_SERIAL = nvc++" \
#	"FFLAGS_PROMOTION = -r8" \
#	"FFLAGS_OPT = -O4 -byteswapio -Mfree" \
#	"CFLAGS_OPT = -O3" \
#	"CXXFLAGS_OPT = -O3" \
#	"LDFLAGS_OPT = -O3" \
#	"FFLAGS_DEBUG = -O0 -g -Mbounds -Mchkptr -byteswapio -Mfree -Ktrap=divz,fp,inv,ovf -traceback" \
#	"CFLAGS_DEBUG = -O0 -g -traceback" \
#	"CXXFLAGS_DEBUG = -O0 -g -traceback" \
#	"LDFLAGS_DEBUG = -O0 -g -Mbounds -Mchkptr -Ktrap=divz,fp,inv,ovf -traceback" \
#	"FFLAGS_OMP = -mp" \
#	"CFLAGS_OMP = -mp" \
#	"FFLAGS_ACC = -Mnofma -acc=gpu -Minfo=accel" \
#	"CFLAGS_ACC =" \
#	"CORE = $(CORE)" \
#	"DEBUG = $(DEBUG)" \
#	"USE_PAPI = $(USE_PAPI)" \
#	"OPENMP = $(OPENMP)" \
#	"OPENACC = $(OPENACC)" \
#	"CPPFLAGS = $(MODEL_FORMULATION) -DUSE_PIO2=true -D_MPI -DUNDERSCORE" )

# build with just a hint of parallelism
make -j 4 nvhpc-derecho CORE=atmosphere OPENACC=true PRECISION=single USE_PIO2=true |& tee MAKE.log


