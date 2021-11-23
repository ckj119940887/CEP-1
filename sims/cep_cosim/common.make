#//************************************************************************
#// Copyright 2021 Massachusetts Institute of Technology
#// SPDX short identifier: BSD-2-Clause
#//
#// File Name:      common.make
#// Program:        Common Evaluation Platform (CEP)
#// Description:    Top level common.make for CEP Cosimulation
#// Notes:          
#//
#//************************************************************************

# Avoid redundant inclusions of common.make
ifndef $(COMMON_MAKE_CALLED)
COMMON_MAKE_CALLED	= 1

# Set default tool locations
QUESTASIM_PATH				?= /opt/questa-2019.1/questasim/bin

$(info )
$(info CEP_COSIM: ----------------------------------------------------------------------)
$(info CEP_COSIM:        Common Evaluation Platform Co-Simulation Environment           )
$(info CEP_COSIM: ----------------------------------------------------------------------)

# RISCV *must* be defined
ifndef RISCV
$(error CEP_COSIM: RISCV is unset. You must set RISCV yourself, or through the Chipyard auto-generated env file)
else
$(info CEP_COSIM: Running with RISCV = $(RISCV))
endif

# Perform DUT_SIM_MODE Check
ifeq "$(findstring BFM,${DUT_SIM_MODE})" "BFM"
$(info CEP_COSIM: Running in BFM Mode)
DUT_SIM_MODE = BFM_MODE
else ifeq "$(findstring BARE,${DUT_SIM_MODE})" "BARE"
$(info CEP_COSIM: Running in Bare Metal Mode)
DUT_SIM_MODE = BARE_MODE
else
$(error CEP_COSIM: ${DUT_SIM_MODE} is invalid)
endif

# Validate the Chipyard verilog has been build by looking for the generated makefile
ifeq (,$(wildcard $(COSIM_TOP_DIR)/CHIPYARD_BUILD_INFO.make))
$(error "CEP_COSIM: CHIPYARD_BUILD_INFO.make does not exist. run make -f Makefile.chipyard in $(COSIM_TOP_DIR)")
endif
$(info )

# Include the file that contains info about the chipyard build
include $(COSIM_TOP_DIR)/CHIPYARD_BUILD_INFO.make

# The following DEFINES identify what simulator the user
# has chosen to run with, ensuring that only one is
# selected at a time

# Assign each DEFINE a default, if it is not defined.
MODELSIM        			?= 1
CADENCE 					?= 0
VERILATOR 					?= 0

# Ensure only ONE is set
ifeq (${MODELSIM},1)
CADENCE        				= 0
VERILATOR 					= 0
else ifeq (${CADENCE},1)
MODELSIM       				= 0
VERILATOR 					= 0
endif

# The following DEFINES control how the software is
# compiled and if will be overriden by lower level
# Makefiles as needed.

# Enables virtual memory support when operating in BARE mode
DUT_IN_VIRTUAL  			= 0

# Set some default flag values
NOWAVE          			= 0
PROFILE         			= 0
COVERAGE        			= 0
USE_DPI         			= 1

# transaction-level capturing
TL_CAPTURE      			= 0

# cycle-by-cycle capturing
C2C_CAPTURE     			= 0

# stupid VHDL package uses work.* inside so have no choice but to use work!!
WORK_NAME       			= ${TEST_SUITE}_work
WORK_DIR        			= ${TEST_SUITE_DIR}/${WORK_NAME}

# more paths for C build
SHARE_DIR					= ${COSIM_TOP_DIR}/share
PLI_DIR						= ${COSIM_TOP_DIR}/pli
SIMDIAG_DIR					= ${COSIM_TOP_DIR}/simDiag
SRC_DIR						= ${COSIM_TOP_DIR}/src
DVT_DIR         			= ${COSIM_TOP_DIR}/dvt
INC_DIR         			= ${COSIM_TOP_DIR}/include
BHV_DIR         			= ${DVT_DIR}/behav_models
LIB_DIR						= ${COSIM_TOP_DIR}/lib

# can be override by other Makefile
XX_LIB_DIR					?= ${LIB_DIR}
V2C_TAB_FILE				?= ${PLI_DIR}/v2c.tab
BUILD_HW_MAKEFILE			?= ${COSIM_TOP_DIR}/cep_buildHW.make
BUILD_SW_MAKEFILE			?= ${COSIM_TOP_DIR}/cep_buildSW.make
CADENCE_MAKE_FILE 			?= ${COSIM_TOP_DIR}/cadence.make
VPP_LIB 					?= ${XX_LIB_DIR}/libvpp.so
RISCV_LIB 					?= ${XX_LIB_DIR}/riscv_lib.a
BIN_DIR 					?= ${COSIM_TOP_DIR}/bin


RISCV_TEST_DIR 				?= ${REPO_TOP_DIR}/software/riscv-tests
ISA_TEST_TEMPLATE 			?= ${TEST_SUITE_DIR}/testTemplate

# Questasim related commands
ifeq (${MODELSIM},1)
VLOG_CMD					= ${QUESTASIM_PATH}/vlog
VCOM_CMD					= ${QUESTASIM_PATH}/vcom
VOPT_CMD					= ${QUESTASIM_PATH}/vopt
VSIM_CMD 					= ${QUESTASIM_PATH}/vsim
VLIB_CMD					= ${QUESTASIM_PATH}/vlib
VMAP_CMD					= ${QUESTASIM_PATH}/vmap
VMAKE_CMD					= ${QUESTASIM_PATH}/vmake
VCOVER_CMD					= ${QUESTASIM_PATH}/vcover

# Quick sanity check if vsim exists
ifeq (,$(shell which ${VSIM_CMD}))
$(error CEP_COSIM: vsim not found.  Check QUESTASIM_PATH)
endif

endif

# C/C+ tools
GCC     					= /usr/bin/g++
AR 							= /usr/bin/ar
RANLIB  					= /usr/bin/ranlib
LD 							= ${GCC}
VPP_CMD						= ${BIN_DIR}/vpp.pl

# Some variables 
SIM_DEPEND_TARGET			= .${WORK_NAME}_dependList

# Some derived switches
DUT_VSIM_DO_FILE			= ${TEST_DIR}/vsim.do


COSIM_COVERAGE_PATH			= ${TEST_SUITE_DIR}/coverage

# Include both the Hardware and Software makefiles
include ${BUILD_HW_MAKEFILE}
#include ${BUILD_SW_MAKE_FILE}

# Error Checking - If error message is not OK, exit
ifeq "$(findstring OK,${ERROR_MESSAGE})" "OK"
${BLD_DIR}/.is_checked: 
	@echo "Checking for proper enviroment settings = ${ERROR_MESSAGE}"
	touch $@
else
${BLD_DIR}/.is_checked: .force
	@echo "ERROR: **** ${ERROR_MESSAGE} ****"
	@rm -rf ${BLD_DIR}/.is_checked
	@exit 1
endif

# Include the Cadence toolset specific file, if enabled
ifeq (${CADENCE},1)
include ${CADENCE_MAKE_FILE}
endif

# run the simulation
#
# add +myplus=0 for stupid plus_arg
vsimOnly: ${TEST_SUITE_DIR}/_info ${VPP_LIB} ${DUT_VSIM_DO_FILE}
	${VSIM_CMD} -work ${WORK_DIR} -tab ${V2C_TAB_FILE} -pli ${VPP_LIB} -do ${DUT_VSIM_DO_FILE} ${DUT_VSIM_ARGS} ${WORK_DIR}.${DUT_OPT_MODULE} -batch -logfile ${TEST_DIR}/${TEST_NAME}.log

PLUSARGS      = " "
RANDOMIZE     = 1
UPDATE_INFO   = 1
TEST_INFO     = testHistory.txt
USE_GDB       = 0

# remove the .so
VPP_SV_LIB = $(subst libvpp.so,libvpp,${VPP_LIB})

VSIM_CMD_LINE = "${VSIM_CMD} -work ${WORK_DIR} -t 1ps -tab ${V2C_TAB_FILE} -pli ${VPP_LIB} -sv_lib ${VPP_SV_LIB} -do ${DUT_VSIM_DO_FILE} ${DUT_VSIM_ARGS} ${WORK_DIR}.${DUT_OPT_MODULE} -batch -logfile ${TEST_DIR}/${TEST_NAME}.log +myplus=0"
# depend list

.vrun_flag: ${TEST_SUITE_DIR}/_info ${XX_LIB_DIR}/.buildLibs ${DUT_VSIM_DO_FILE} c_dispatch ${RISCV_WRAPPER_ELF}
ifeq (${COVERAGE},1)
	@if test ! -d ${DUT_COVERAGE_PATH}; then	\
		mkdir  ${DUT_COVERAGE_PATH};		\
	fi
endif
	${VPP_CMD} ${TEST_DIR}/c_dispatch ${RANDOMIZE} ${UPDATE_INFO} ${TEST_INFO} ${USE_GDB} ${TEST_DIR}/${TEST_NAME}.log ${COVERAGE} \"${VSIM_CMD_LINE}\"

# Create default local vsim do file if not there: one with sim for interactive and one for regression
define VSIM_DO_BODY
set NumericStdNoWarnings 1
set StdArithNoWarnings 1
#
# Procedure to turn on/off wave and continue
# they are called from inside Verilog
#
proc wave_on {} {
     echo "Enable logging";	
     log -ports -r /* ;
}

proc wave_off {} {
     echo "Stop logging"	
     nolog -all;
}
proc dump_coverage {} {
     echo "Dumping Coverage";
     coverage save ../coverage/${TEST_NAME}.ucdb
}
#
# just run
#
run -all;
#
# should never get here anyway!!
#
quit
endef

export VSIM_DO_BODY

${TEST_DIR}/vsim.do:
	@if test ! -f $@; then	\
	echo "$$VSIM_DO_BODY" > $@; \
	fi

# To detect if any important flag has changed since last run
PERSUITE_CHECK = ${TEST_SUITE_DIR}/.PERSUITE_${DUT_SIM_MODE}_${NOWAVE}_${COVERAGE}_${PROFILE}

#
# delete other mode marker if just switch
# always do this check
${PERSUITE_CHECK}: 
	if test ! -f ${PERSUITE_CHECK}; then rm -f ${TEST_SUITE_DIR}/.PERSUITE_*; touch ${PERSUITE_CHECK}; fi

# ISA Auto test generation
makeTest: ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/${TEST_NAME}${SFX}.dump
	@echo "Done"

# override at command line ONLY!!!
SINGLE_THREAD=0
VIRTUAL_MODE=0
PASS_IS_TO_HOST=0;

${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/${TEST_NAME}${SFX}.dump : ${RISCV_TEST_DIR}/isa/${TEST_NAME}
	@if test ! -d ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}; then	\
		mkdir  ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}; \
	fi
	@cp -f ${ISA_TEST_TEMPLATE}/Makefile        ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/.
	@cp -f ${ISA_TEST_TEMPLATE}/*.h             ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/.
	@cp -f ${ISA_TEST_TEMPLATE}/c_module.cc     ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/.
	@rm -f ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/c_dispatch.cc
ifeq (${SINGLE_THREAD},1)
	@echo "#define SINGLE_THREAD_ONLY" >> ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/c_dispatch.cc
endif
ifneq (${SINGLE_CORE_ONLY},)
	@echo "#define SINGLE_CORE_ONLY ${SINGLE_CORE_ONLY}" >> ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/c_dispatch.cc
endif
ifeq (${VIRTUAL_MODE},1)
	@echo "#define MAX_TIMEOUT 200"    >> ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/c_dispatch.cc
	@echo "#define VIRTUAL_MODE"       >> ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/c_dispatch.cc
else
	@echo "#define MAX_TIMEOUT 200"    >> ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/c_dispatch.cc
endif
ifeq (${PASS_IS_TO_HOST},1)
	@echo "#define PASS_IS_TO_HOST"    >> ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/c_dispatch.cc
endif
	@cat ${ISA_TEST_TEMPLATE}/c_dispatch.cc >>        ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/c_dispatch.cc
	@cp -f ${RISCV_TEST_DIR}/isa/${TEST_NAME}      ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/riscv_wrapper.elf
	@cp -f ${RISCV_TEST_DIR}/isa/${TEST_NAME}.dump ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/${TEST_NAME}${SFX}.dump
	@${BIN_DIR}/createPassFail.pl ${RISCV_TEST_DIR}/isa/${TEST_NAME}.dump ${TEST_SUITE_DIR}/${TEST_NAME}${SFX}/PassFail.hex








#
# -------------------------------------------
# coverage for modelsim
# -------------------------------------------
# NOTE: double ::
#
merge::
ifeq (${MODELSIM},1)
	@if test -d ${DUT_COVERAGE_PATH}; then	\
		(cd ${DUT_COVERAGE_PATH}; ${VCOVER_CMD} merge -out ${TEST_SUITE}.ucdb ${DUT_COVERAGE_PATH}/*.ucdb;) \
	fi
endif

# use "coverage open <file>.ucdb" under vsim to open and view
MODELSIM_TOP_COVERAGE  = ${COSIM_TOP_DIR}/coverage
MODELSIM_COV_DO_SCRIPT = ${COSIM_TOP_DIR}/modelsim_coverage.do

mergeAll:: .force
ifeq (${MODELSIM},1)
	@if test ! -d ${MODELSIM_TOP_COVERAGE}; then	\
	   mkdir  ${MODELSIM_TOP_COVERAGE};		\
	fi
	@rm -rf ${MODELSIM_TOP_COVERAGE}/*
	@for i in ${TEST_GROUP}; do	\
	   (cd $${i}; make merge; cp coverage/$${i}.ucdb ${MODELSIM_TOP_COVERAGE}/.);	\
	done
	@(cd ${MODELSIM_TOP_COVERAGE};  ${VSIM_CMD} -64 -do ${MODELSIM_COV_DO_SCRIPT})
endif

#
# -------------------------------------------
# clean
# -------------------------------------------
#

clean: cleanAll

#cleanAll: cleanLibs
cleanAll:
	-rm -rf ${COSIM_TOP_DIR}/*/*_work ${COSIM_TOP_DIR}/*/.*work_dependList.make
	-rm -rf ${COSIM_TOP_DIR}/*/*.o* ${COSIM_TOP_DIR}/*/*/*.bo* ${COSIM_TOP_DIR}/*/*/*.o*
	-rm -rf ${COSIM_TOP_DIR}/*/*/status
	-rm -rf ${COSIM_TOP_DIR}/bareMetalTests/*/*.elf ${COSIM_TOP_DIR}/bareMetalTests/*/*.dump
	-rm -rf ${COSIM_TOP_DIR}/*/.build*
	-rm -rf ${LIB_DIR}/*/*.o* ${LIB_DIR}/*.a ${LIB_DIR}/*.so
	-rm -rf ${COSIM_TOP_DIR}/*/.*_dependList* ${COSIM_TOP_DIR}/*/.is_checked
	-rm -rf ${COSIM_TOP_DIR}/*/*/C2V*
	-rm -rf ${BHV_DIR}/VCShell*.v ${BHV_DIR}/ddr3.v
	-rm -rf ${COSIM_TOP_DIR}/*/xcelium.d ${COSIM_TOP_DIR}/*/.cadenceBuild ${COSIM_TOP_DIR}/*/*/cov_work ${COSIM_TOP_DIR}/*/*/xrun.log
ifeq (${COVERAGE},1)
ifeq (${CADENCE},1)
	-rm -rf ${COSIM_TOP_DIR}/*/cad_coverage
endif
ifeq (${MODELSIM},1)
	-rm -rf ${COSIM_TOP_DIR}/*/coverage
	-rm -f ${COSIM_TOP_DIR}/*/*/vsim.do
endif
endif
#
#
#
.force:

#
# -------------------------------------------
# Print usage
# -------------------------------------------
#
define MAKE_USAGE_HELP_BODY
make [NOWAVE=0|1] [COVERAGE=0|1] [PROFILE=0|1] [USE_GDB=0|1] <all|summary|cleanAll|merge|usage>

Options:
  NOWAVE=1      : turn off wave capturing. Default is ON for interactive. OFF for regression
  USE_GDB=1     : run the test under "gdb" debugger. Default is OFF. Should only be used for interactive session.
  COVERAGE=1    : run the test with coverage capture enable. Default is OFF
  PROFILE=1     : run the test with profiling turn on. Default is OFF
  TL_CAPTURE=1  : turn on Title-Link comand sequence capturing to be used for BARE Metal (and Unit-level testbench)
  C2C_CAPTURE=1 : turn on cycle-by-cycle at core's IO  for Unit testbench

Targets:
  all        : run the test. Default target (empty string = same as "all")
  summary    : print out regression summary (run at the top or suite directories.
  cleanAll   : clean up and force a rebuild of every thing
  merge      : merge coverage reports
  usage      : print this help lines

  see <common.make> for more options and targets
endef

export MAKE_USAGE_HELP_BODY

usage:
	@echo "$$MAKE_USAGE_HELP_BODY"

# ifdef $(COMMON_MAKE_CALLED)
endif
