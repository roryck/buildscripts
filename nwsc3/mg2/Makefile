# Makefile for KGEN-generated kernel
#
#
include ./Macros

pcols ?= 16

ALL_OBJS := micro_mg_cam.o micro_mg2_0.o micro_mg_utils.o wv_sat_methods.o shr_spfn_mod.o shr_kind_mod.o shr_const_mod.o kernel_driver.o kgen_utils.o tprof_mod.o

.PHONY: kernel_driver.o 

run: build

build: ${ALL_OBJS}
	${FC} ${LD_FLAGS} -o kernel.exe $^  

micro_mg_cam.o: micro_mg_cam.F90 micro_mg2_0.o micro_mg_utils.o wv_sat_methods.o shr_spfn_mod.o shr_kind_mod.o shr_const_mod.o kgen_utils.o tprof_mod.o
	${FC} ${FC_FLAGS} -c -o $@ $<

micro_mg2_0.o: micro_mg2_0.F90 kgen_utils.o tprof_mod.o micro_mg_utils.o wv_sat_methods.o shr_spfn_mod.o
	${FC} ${FC_FLAGS} -c -o $@ $<

micro_mg_utils.o: micro_mg_utils.F90 kgen_utils.o tprof_mod.o shr_spfn_mod.o
	${FC} ${FC_FLAGS} -c -o $@ $<

wv_sat_methods.o: wv_sat_methods.F90 kgen_utils.o tprof_mod.o
	${FC} ${FC_FLAGS} -c -o $@ $<

shr_spfn_mod.o: shr_spfn_mod.F90 kgen_utils.o tprof_mod.o shr_kind_mod.o shr_const_mod.o
	${FC} ${FC_FLAGS} -c -o $@ $<

shr_kind_mod.o: shr_kind_mod.F90 kgen_utils.o tprof_mod.o
	${FC} ${FC_FLAGS} -c -o $@ $<

shr_const_mod.o: shr_const_mod.F90 kgen_utils.o tprof_mod.o shr_kind_mod.o
	${FC} ${FC_FLAGS} -c -o $@ $<

kernel_driver.o: kernel_driver.F90 micro_mg_cam.o micro_mg2_0.o micro_mg_utils.o wv_sat_methods.o shr_spfn_mod.o shr_kind_mod.o shr_const_mod.o kgen_utils.o tprof_mod.o
	${FC} ${FC_FLAGS} -DPCOLSSIZE=${pcols} -D STATEFILE='"./data.72cores/pcols${pcols}/kgen_statefile.lst"' -c -o $@ $<

kgen_utils.o: kgen_utils.f90
	${FC} ${FC_FLAGS} -c -o $@ $<

tprof_mod.o: tprof_mod.f90
	${FC} ${FC_FLAGS} -c -o $@ $<

clean:
	rm -f kernel.exe *.mod ${ALL_OBJS} *.opt* *.L
