#################################################################
# Makefile generated by Xilinx Platform Studio 
# Project:E:\work\FPGA_PROJECTS\BLOCKS\integer_divider\system.xmp
#
# WARNING : This file will be re-generated every time a command
# to run a make target is invoked. So, any changes made to this  
# file manually, will be lost when make is invoked next. 
#################################################################

XILINX_EDK_DIR = /cygdrive/c/Xilinx/10.1/EDK
NON_CYG_XILINX_EDK_DIR = C:/Xilinx/10.1/EDK

SYSTEM = system

MHSFILE = system.mhs

MSSFILE = system.mss

FPGA_ARCH = virtex2p

DEVICE = xc2vp30ff896-7

LANGUAGE = vhdl

SEARCHPATHOPT = 

SUBMODULE_OPT = 

PLATGEN_OPTIONS = -p $(DEVICE) -lang $(LANGUAGE) $(SEARCHPATHOPT) $(SUBMODULE_OPT)

LIBGEN_OPTIONS = -mhs $(MHSFILE) -p $(DEVICE) $(SEARCHPATHOPT)

VPGEN_OPTIONS = -p $(DEVICE) $(SEARCHPATHOPT)

MANAGE_FASTRT_OPTIONS = -reduce_fanout no

OBSERVE_PAR_OPTIONS = -error no

TESTAPP_MEMORY_OUTPUT_DIR = TestApp_Memory
TESTAPP_MEMORY_OUTPUT = $(TESTAPP_MEMORY_OUTPUT_DIR)/executable.elf

TESTAPP_PERIPHERAL_OUTPUT_DIR = TestApp_Peripheral
TESTAPP_PERIPHERAL_OUTPUT = $(TESTAPP_PERIPHERAL_OUTPUT_DIR)/executable.elf

MICROBLAZE_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/microblaze/mb_bootloop.elf
PPC405_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/ppc405/ppc_bootloop.elf
PPC440_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/ppc440/ppc440_bootloop.elf
BOOTLOOP_DIR = bootloops

PPC405_0_BOOTLOOP = $(BOOTLOOP_DIR)/ppc405_0.elf

PPC405_1_BOOTLOOP = $(BOOTLOOP_DIR)/ppc405_1.elf

BRAMINIT_ELF_FILES =   $(PPC405_0_BOOTLOOP) 
BRAMINIT_ELF_FILE_ARGS =   -pe ppc405_0  $(PPC405_0_BOOTLOOP) 

ALL_USER_ELF_FILES = $(TESTAPP_MEMORY_OUTPUT) $(TESTAPP_PERIPHERAL_OUTPUT) 

SIM_CMD = vsim

BEHAVIORAL_SIM_SCRIPT = simulation/behavioral/$(SYSTEM)_setup.do

STRUCTURAL_SIM_SCRIPT = simulation/structural/$(SYSTEM)_setup.do

TIMING_SIM_SCRIPT = simulation/timing/$(SYSTEM)_setup.do

DEFAULT_SIM_SCRIPT = $(BEHAVIORAL_SIM_SCRIPT)

MIX_LANG_SIM_OPT = -mixed yes

SIMGEN_OPTIONS = -p $(DEVICE) -lang $(LANGUAGE) $(SEARCHPATHOPT) $(BRAMINIT_ELF_FILE_ARGS) $(MIX_LANG_SIM_OPT)  -s mti -X E:/work/FPGA_PROJECTS/BLOCKS/integer_divider/ -E E:/work/FPGA_PROJECTS/BLOCKS/integer_divider/


LIBRARIES =  \
       ppc405_0/lib/libxil.a  \
       ppc405_1/lib/libxil.a 
VPEXEC = virtualplatform/vpexec.exe

LIBSCLEAN_TARGETS = ppc405_0_libsclean ppc405_1_libsclean 

PROGRAMCLEAN_TARGETS = TestApp_Memory_programclean TestApp_Peripheral_programclean 

CORE_STATE_DEVELOPMENT_FILES = 

WRAPPER_NGC_FILES = implementation/ppc405_0_wrapper.ngc \
implementation/ppc405_1_wrapper.ngc \
implementation/jtagppc_0_wrapper.ngc \
implementation/reset_block_wrapper.ngc \
implementation/plb_wrapper.ngc \
implementation/opb_wrapper.ngc \
implementation/plb2opb_wrapper.ngc \
implementation/rs232_uart_1_wrapper.ngc \
implementation/leds_4bit_wrapper.ngc \
implementation/dipsws_4bit_wrapper.ngc \
implementation/plb_bram_if_cntlr_1_wrapper.ngc \
implementation/plb_bram_if_cntlr_1_bram_wrapper.ngc \
implementation/dcm_0_wrapper.ngc \
implementation/huffman_encode_testharness_0_wrapper.ngc

POSTSYN_NETLIST = implementation/$(SYSTEM).ngc

SYSTEM_BIT = implementation/$(SYSTEM).bit

DOWNLOAD_BIT = implementation/download.bit

SYSTEM_ACE = implementation/$(SYSTEM).ace

UCF_FILE = data/system.ucf

BMM_FILE = implementation/$(SYSTEM).bmm

BITGEN_UT_FILE = etc/bitgen.ut

XFLOW_OPT_FILE = etc/fast_runtime.opt
XFLOW_DEPENDENCY = __xps/xpsxflow.opt $(XFLOW_OPT_FILE)

XPLORER_DEPENDENCY = __xps/xplorer.opt
XPLORER_OPTIONS = -p $(DEVICE) -uc $(SYSTEM).ucf -bm $(SYSTEM).bmm -max_runs 7

FPGA_IMP_DEPENDENCY = $(BMM_FILE) $(POSTSYN_NETLIST) $(UCF_FILE) $(XFLOW_DEPENDENCY)

#################################################################
# SOFTWARE APPLICATION TESTAPP_MEMORY
#################################################################

TESTAPP_MEMORY_SOURCES = /cygdrive/e/work/FPGA_PROJECTS/BLOCKS/integer_divider/TestApp_Memory/src/TestApp_Memory.c 

TESTAPP_MEMORY_HEADERS = 

TESTAPP_MEMORY_CC = powerpc-eabi-gcc
TESTAPP_MEMORY_CC_SIZE = powerpc-eabi-size
TESTAPP_MEMORY_CC_OPT = -O2
TESTAPP_MEMORY_CFLAGS = 
TESTAPP_MEMORY_CC_SEARCH = # -B
TESTAPP_MEMORY_LIBPATH = -L./ppc405_0/lib/ # -L
TESTAPP_MEMORY_INCLUDES = -I./ppc405_0/include/ # -I
TESTAPP_MEMORY_LFLAGS = # -l
TESTAPP_MEMORY_LINKER_SCRIPT = /cygdrive/e/work/FPGA_PROJECTS/BLOCKS/integer_divider/TestApp_Memory/src/TestApp_Memory_LinkScr
TESTAPP_MEMORY_LINKER_SCRIPT_FLAG = -Wl,-T -Wl,$(TESTAPP_MEMORY_LINKER_SCRIPT) 
TESTAPP_MEMORY_CC_DEBUG_FLAG =  -g 
TESTAPP_MEMORY_CC_PROFILE_FLAG = # -pg
TESTAPP_MEMORY_CC_GLOBPTR_FLAG= # -msdata=eabi
TESTAPP_MEMORY_CC_INFERRED_FLAGS= 
TESTAPP_MEMORY_CC_START_ADDR_FLAG=  #  # -Wl,-defsym -Wl,_START_ADDR=
TESTAPP_MEMORY_CC_STACK_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_STACK_SIZE=
TESTAPP_MEMORY_CC_HEAP_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_HEAP_SIZE=
TESTAPP_MEMORY_OTHER_CC_FLAGS= $(TESTAPP_MEMORY_CC_GLOBPTR_FLAG)  \
                  $(TESTAPP_MEMORY_CC_START_ADDR_FLAG) $(TESTAPP_MEMORY_CC_STACK_SIZE_FLAG) $(TESTAPP_MEMORY_CC_HEAP_SIZE_FLAG)  \
                  $(TESTAPP_MEMORY_CC_INFERRED_FLAGS)  \
                  $(TESTAPP_MEMORY_LINKER_SCRIPT_FLAG) $(TESTAPP_MEMORY_CC_DEBUG_FLAG) $(TESTAPP_MEMORY_CC_PROFILE_FLAG) 

#################################################################
# SOFTWARE APPLICATION TESTAPP_PERIPHERAL
#################################################################

TESTAPP_PERIPHERAL_SOURCES = /cygdrive/e/work/FPGA_PROJECTS/BLOCKS/integer_divider/TestApp_Peripheral/src/TestApp_Peripheral.c /cygdrive/e/work/FPGA_PROJECTS/BLOCKS/integer_divider/drivers/huffman_encode_testharness_v1_00_a/src/test1.c 

TESTAPP_PERIPHERAL_HEADERS = 

TESTAPP_PERIPHERAL_CC = powerpc-eabi-gcc
TESTAPP_PERIPHERAL_CC_SIZE = powerpc-eabi-size
TESTAPP_PERIPHERAL_CC_OPT = -O2
TESTAPP_PERIPHERAL_CFLAGS = 
TESTAPP_PERIPHERAL_CC_SEARCH = # -B
TESTAPP_PERIPHERAL_LIBPATH = -L./ppc405_0/lib/ # -L
TESTAPP_PERIPHERAL_INCLUDES = -I./ppc405_0/include/ # -I
TESTAPP_PERIPHERAL_LFLAGS = # -l
TESTAPP_PERIPHERAL_LINKER_SCRIPT = /cygdrive/e/work/FPGA_PROJECTS/BLOCKS/integer_divider/TestApp_Peripheral/src/TestApp_Peripheral_LinkScr
TESTAPP_PERIPHERAL_LINKER_SCRIPT_FLAG = -Wl,-T -Wl,$(TESTAPP_PERIPHERAL_LINKER_SCRIPT) 
TESTAPP_PERIPHERAL_CC_DEBUG_FLAG =  -g 
TESTAPP_PERIPHERAL_CC_PROFILE_FLAG = # -pg
TESTAPP_PERIPHERAL_CC_GLOBPTR_FLAG= # -msdata=eabi
TESTAPP_PERIPHERAL_CC_INFERRED_FLAGS= 
TESTAPP_PERIPHERAL_CC_START_ADDR_FLAG=  #  # -Wl,-defsym -Wl,_START_ADDR=
TESTAPP_PERIPHERAL_CC_STACK_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_STACK_SIZE=
TESTAPP_PERIPHERAL_CC_HEAP_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_HEAP_SIZE=
TESTAPP_PERIPHERAL_OTHER_CC_FLAGS= $(TESTAPP_PERIPHERAL_CC_GLOBPTR_FLAG)  \
                  $(TESTAPP_PERIPHERAL_CC_START_ADDR_FLAG) $(TESTAPP_PERIPHERAL_CC_STACK_SIZE_FLAG) $(TESTAPP_PERIPHERAL_CC_HEAP_SIZE_FLAG)  \
                  $(TESTAPP_PERIPHERAL_CC_INFERRED_FLAGS)  \
                  $(TESTAPP_PERIPHERAL_LINKER_SCRIPT_FLAG) $(TESTAPP_PERIPHERAL_CC_DEBUG_FLAG) $(TESTAPP_PERIPHERAL_CC_PROFILE_FLAG) 
