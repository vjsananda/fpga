#################################################################
# Makefile generated by Xilinx Platform Studio 
# Project:E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\system.xmp
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

FPGA_ARCH = virtex5

DEVICE = xc5vlx110tff1136-1

LANGUAGE = vhdl

SEARCHPATHOPT = 

SUBMODULE_OPT = 

PLATGEN_OPTIONS = -p $(DEVICE) -lang $(LANGUAGE) $(SEARCHPATHOPT) $(SUBMODULE_OPT)

LIBGEN_OPTIONS = -mhs $(MHSFILE) -p $(DEVICE) $(SEARCHPATHOPT) \
                   $(MICROBLAZE_0_LIBG_OPT)

VPGEN_OPTIONS = -p $(DEVICE) $(SEARCHPATHOPT)

MANAGE_FASTRT_OPTIONS = -reduce_fanout no

OBSERVE_PAR_OPTIONS = -error yes

TESTAPP_MEMORY_OUTPUT_DIR = TestApp_Memory
TESTAPP_MEMORY_OUTPUT = $(TESTAPP_MEMORY_OUTPUT_DIR)/executable.elf

TESTAPP_PERIPHERAL_OUTPUT_DIR = TestApp_Peripheral
TESTAPP_PERIPHERAL_OUTPUT = $(TESTAPP_PERIPHERAL_OUTPUT_DIR)/executable.elf

CANSCID_DPI_OUTPUT_DIR = canscid_dpi
CANSCID_DPI_OUTPUT = $(CANSCID_DPI_OUTPUT_DIR)/executable.elf

MICROBLAZE_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/microblaze/mb_bootloop.elf
PPC405_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/ppc405/ppc_bootloop.elf
PPC440_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/ppc440/ppc440_bootloop.elf
BOOTLOOP_DIR = bootloops

MICROBLAZE_0_BOOTLOOP = $(BOOTLOOP_DIR)/microblaze_0.elf
MICROBLAZE_0_XMDSTUB = microblaze_0/code/xmdstub.elf

BRAMINIT_ELF_FILES =   $(MICROBLAZE_0_BOOTLOOP) 
BRAMINIT_ELF_FILE_ARGS =   -pe microblaze_0  $(MICROBLAZE_0_BOOTLOOP) 

ALL_USER_ELF_FILES = $(TESTAPP_MEMORY_OUTPUT) $(TESTAPP_PERIPHERAL_OUTPUT) $(CANSCID_DPI_OUTPUT) 

SIM_CMD = vsim

BEHAVIORAL_SIM_SCRIPT = simulation/behavioral/$(SYSTEM)_setup.do

STRUCTURAL_SIM_SCRIPT = simulation/structural/$(SYSTEM)_setup.do

TIMING_SIM_SCRIPT = simulation/timing/$(SYSTEM)_setup.do

DEFAULT_SIM_SCRIPT = $(BEHAVIORAL_SIM_SCRIPT)

MIX_LANG_SIM_OPT = -mixed yes

SIMGEN_OPTIONS = -p $(DEVICE) -lang $(LANGUAGE) $(SEARCHPATHOPT) $(BRAMINIT_ELF_FILE_ARGS) $(MIX_LANG_SIM_OPT)  -s mti -X E:/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/ -E E:/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/


LIBRARIES =  \
       microblaze_0/lib/libxil.a 
VPEXEC = virtualplatform/vpexec.exe

LIBSCLEAN_TARGETS = microblaze_0_libsclean 

PROGRAMCLEAN_TARGETS = TestApp_Memory_programclean TestApp_Peripheral_programclean canscid_dpi_programclean 

CORE_STATE_DEVELOPMENT_FILES = E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\netlist\cam_v6_1.ngc \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\netlist\srlfifo39.ngc \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\proc_common_pkg.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\ipif_pkg.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\or_muxcy.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\or_gate128.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\family_support.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pselect_f.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\counter_f.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\inferred_lut4.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pf_counter_bit.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pf_counter.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pf_counter_top.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pf_occ_counter.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pf_occ_counter_top.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pf_adder_bit.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pf_adder.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\pf_dpram_select.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\proc_common_v2_00_a\hdl\vhdl\srl16_fifo.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_single_v1_00_a\hdl\vhdl\plb_address_decoder.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_single_v1_00_a\hdl\vhdl\plb_slave_attachment.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_single_v1_00_a\hdl\vhdl\plbv46_slave_single.vhd \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\my_timer_v1_00_a\hdl\verilog\user_logic.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\my_timer_v1_00_a\hdl\vhdl\my_timer.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\flex_addr_cntr.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\addr_reg_cntr_brst_flex.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\plb_address_decoder.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\burst_support.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\wr_buffer.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\be_reset_gen.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\plb_slave_attachment.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\data_mirror_128.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\plbv46_slave_burst_v1_00_a\hdl\vhdl\plbv46_slave_burst.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\interrupt_control_v2_00_a\hdl\vhdl\interrupt_control.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\dre_v2_00_a\hdl\vhdl\dsp48_mux.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\dre_v2_00_a\hdl\vhdl\tx_dre_top.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\wrpfifo_v4_00_a\hdl\vhdl\pf_dly1_mux.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\wrpfifo_v4_00_a\hdl\vhdl\wrpfifo_dp_cntl.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\wrpfifo_v4_00_a\hdl\vhdl\ipif_control_wr_dre.vhd \
C:\Xilinx\10.1\EDK\hw\XilinxProcessorIPLib\pcores\wrpfifo_v4_00_a\hdl\vhdl\wrpfifo_top.vhd \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\flist.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cam_v6_1.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\id_allocator.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\tag_data_splitter.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\srlfifo39.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\ALL_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\ALL_1_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\ALL_2_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\ALL_3_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\ALL_4_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_finger_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_ftp_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_http_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_imap_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_netbios_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_nntp_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_pop3_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_rlogin_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_smtp_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\CATEGORY_telnet_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\finger_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\ftp_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\http_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\imap_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\netbios_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\nntp_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\pop3_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\rlogin_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\smtp_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\telnet_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_ALL_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_ALL_1_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_ALL_2_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_ALL_3_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_ALL_4_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_finger_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_ftp_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_http_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_imap_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_netbios_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_nntp_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_pop3_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_rlogin_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_smtp_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_CATEGORY_telnet_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_finger_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_ftp_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_http_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_imap_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_netbios_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_nntp_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_pop3_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_rlogin_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_smtp_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\cancid_telnet_0_verilog.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\tag_parser.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\verilog\user_logic.v \
E:\work\FPGA_PROJECTS\ML509\xupv5_kraaken_v1\pcores\kraaken_dpi_v3_00_a\hdl\vhdl\kraaken_dpi.vhd

WRAPPER_NGC_FILES = implementation/microblaze_0_wrapper.ngc \
implementation/mb_plb_wrapper.ngc \
implementation/ilmb_wrapper.ngc \
implementation/dlmb_wrapper.ngc \
implementation/dlmb_cntlr_wrapper.ngc \
implementation/ilmb_cntlr_wrapper.ngc \
implementation/lmb_bram_wrapper.ngc \
implementation/rs232_uart_1_wrapper.ngc \
implementation/ddr2_sdram_wrapper.ngc \
implementation/clock_generator_0_wrapper.ngc \
implementation/debug_module_wrapper.ngc \
implementation/proc_sys_reset_0_wrapper.ngc \
implementation/my_timer_0_wrapper.ngc \
implementation/xps_intc_0_wrapper.ngc \
implementation/xps_central_dma_0_wrapper.ngc \
implementation/kraaken_dpi_0_wrapper.ngc

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

TESTAPP_MEMORY_SOURCES = /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/TestApp_Memory/src/TestApp_Memory.c /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/TestApp_Memory/src/my_dma_test.c 

TESTAPP_MEMORY_HEADERS = /cygdrive/e//work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/TestApp_Memory/src/my_dma_test.h 

TESTAPP_MEMORY_CC = mb-gcc
TESTAPP_MEMORY_CC_SIZE = mb-size
TESTAPP_MEMORY_CC_OPT = -O2
TESTAPP_MEMORY_CFLAGS = 
TESTAPP_MEMORY_CC_SEARCH = # -B
TESTAPP_MEMORY_LIBPATH = -L./microblaze_0/lib/ # -L
TESTAPP_MEMORY_INCLUDES = -I./microblaze_0/include/  -ITestApp_Memory/src/ # -I
TESTAPP_MEMORY_LFLAGS = # -l
TESTAPP_MEMORY_LINKER_SCRIPT = /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/TestApp_Memory/src/TestApp_Memory_LinkScr.ld
TESTAPP_MEMORY_LINKER_SCRIPT_FLAG = -Wl,-T -Wl,$(TESTAPP_MEMORY_LINKER_SCRIPT) 
TESTAPP_MEMORY_CC_DEBUG_FLAG =  -g 
TESTAPP_MEMORY_CC_PROFILE_FLAG = # -pg
TESTAPP_MEMORY_CC_GLOBPTR_FLAG= # -mxl-gp-opt
TESTAPP_MEMORY_MODE = executable
TESTAPP_MEMORY_LIBG_OPT = -$(TESTAPP_MEMORY_MODE) microblaze_0
TESTAPP_MEMORY_CC_INFERRED_FLAGS= -mno-xl-soft-mul -mxl-pattern-compare -mcpu=v7.10.d 
TESTAPP_MEMORY_CC_START_ADDR_FLAG=  #  # -Wl,-defsym -Wl,_TEXT_START_ADDR=
TESTAPP_MEMORY_CC_STACK_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_STACK_SIZE=
TESTAPP_MEMORY_CC_HEAP_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_HEAP_SIZE=
TESTAPP_MEMORY_OTHER_CC_FLAGS= $(TESTAPP_MEMORY_CC_GLOBPTR_FLAG)  \
                  $(TESTAPP_MEMORY_CC_START_ADDR_FLAG) $(TESTAPP_MEMORY_CC_STACK_SIZE_FLAG) $(TESTAPP_MEMORY_CC_HEAP_SIZE_FLAG)  \
                  $(TESTAPP_MEMORY_CC_INFERRED_FLAGS)  \
                  $(TESTAPP_MEMORY_LINKER_SCRIPT_FLAG) $(TESTAPP_MEMORY_CC_DEBUG_FLAG) $(TESTAPP_MEMORY_CC_PROFILE_FLAG) 

#################################################################
# SOFTWARE APPLICATION TESTAPP_PERIPHERAL
#################################################################

TESTAPP_PERIPHERAL_SOURCES = /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/TestApp_Peripheral/src/TestApp_Peripheral.c /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/TestApp_Peripheral/src/xuartlite_selftest_example.c 

TESTAPP_PERIPHERAL_HEADERS = /cygdrive/e//work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/TestApp_Peripheral/src/uartlite_header.h 

TESTAPP_PERIPHERAL_CC = mb-gcc
TESTAPP_PERIPHERAL_CC_SIZE = mb-size
TESTAPP_PERIPHERAL_CC_OPT = -O2
TESTAPP_PERIPHERAL_CFLAGS = 
TESTAPP_PERIPHERAL_CC_SEARCH = # -B
TESTAPP_PERIPHERAL_LIBPATH = -L./microblaze_0/lib/ # -L
TESTAPP_PERIPHERAL_INCLUDES = -I./microblaze_0/include/  -ITestApp_Peripheral/src/ # -I
TESTAPP_PERIPHERAL_LFLAGS = # -l
TESTAPP_PERIPHERAL_LINKER_SCRIPT = /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/TestApp_Peripheral/src/TestApp_Peripheral_LinkScr.ld
TESTAPP_PERIPHERAL_LINKER_SCRIPT_FLAG = -Wl,-T -Wl,$(TESTAPP_PERIPHERAL_LINKER_SCRIPT) 
TESTAPP_PERIPHERAL_CC_DEBUG_FLAG =  -g 
TESTAPP_PERIPHERAL_CC_PROFILE_FLAG = # -pg
TESTAPP_PERIPHERAL_CC_GLOBPTR_FLAG= # -mxl-gp-opt
TESTAPP_PERIPHERAL_MODE = executable
TESTAPP_PERIPHERAL_LIBG_OPT = -$(TESTAPP_PERIPHERAL_MODE) microblaze_0
TESTAPP_PERIPHERAL_CC_INFERRED_FLAGS= -mno-xl-soft-mul -mxl-pattern-compare -mcpu=v7.10.d 
TESTAPP_PERIPHERAL_CC_START_ADDR_FLAG=  #  # -Wl,-defsym -Wl,_TEXT_START_ADDR=
TESTAPP_PERIPHERAL_CC_STACK_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_STACK_SIZE=
TESTAPP_PERIPHERAL_CC_HEAP_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_HEAP_SIZE=
TESTAPP_PERIPHERAL_OTHER_CC_FLAGS= $(TESTAPP_PERIPHERAL_CC_GLOBPTR_FLAG)  \
                  $(TESTAPP_PERIPHERAL_CC_START_ADDR_FLAG) $(TESTAPP_PERIPHERAL_CC_STACK_SIZE_FLAG) $(TESTAPP_PERIPHERAL_CC_HEAP_SIZE_FLAG)  \
                  $(TESTAPP_PERIPHERAL_CC_INFERRED_FLAGS)  \
                  $(TESTAPP_PERIPHERAL_LINKER_SCRIPT_FLAG) $(TESTAPP_PERIPHERAL_CC_DEBUG_FLAG) $(TESTAPP_PERIPHERAL_CC_PROFILE_FLAG) 

#################################################################
# SOFTWARE APPLICATION CANSCID_DPI
#################################################################

CANSCID_DPI_SOURCES = /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/canscid_dpi/src/main.c /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/canscid_dpi/src/my_timer.c /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/drivers/kraaken_dpi_v3_00_a/src/kraaken_dpi.c /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/canscid_dpi/src/dma_intr_handler.c 

CANSCID_DPI_HEADERS = /cygdrive/e//work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/canscid_dpi/src/my_timer.h /cygdrive/e//work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/drivers/kraaken_dpi_v3_00_a/src/kraaken_dpi.h /cygdrive/e//work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/canscid_dpi/src/dma_intr_handler.h 

CANSCID_DPI_CC = mb-gcc
CANSCID_DPI_CC_SIZE = mb-size
CANSCID_DPI_CC_OPT = -O2
CANSCID_DPI_CFLAGS = 
CANSCID_DPI_CC_SEARCH = # -B
CANSCID_DPI_LIBPATH = -L./microblaze_0/lib/ # -L
CANSCID_DPI_INCLUDES = -I./microblaze_0/include/  -Icanscid_dpi/src/ -Idrivers/kraaken_dpi_v3_00_a/src/ # -I
CANSCID_DPI_LFLAGS = # -l
CANSCID_DPI_LINKER_SCRIPT = /cygdrive/e/work/FPGA_PROJECTS/ML509/xupv5_kraaken_v1/canscid_dpi/canscid_dpi_linker_script.ld
CANSCID_DPI_LINKER_SCRIPT_FLAG = -Wl,-T -Wl,$(CANSCID_DPI_LINKER_SCRIPT) 
CANSCID_DPI_CC_DEBUG_FLAG =  -g 
CANSCID_DPI_CC_PROFILE_FLAG = # -pg
CANSCID_DPI_CC_GLOBPTR_FLAG= # -mxl-gp-opt
CANSCID_DPI_MODE = executable
CANSCID_DPI_LIBG_OPT = -$(CANSCID_DPI_MODE) microblaze_0
CANSCID_DPI_CC_INFERRED_FLAGS= -mno-xl-soft-mul -mxl-pattern-compare -mcpu=v7.10.d 
CANSCID_DPI_CC_START_ADDR_FLAG=  #  # -Wl,-defsym -Wl,_TEXT_START_ADDR=
CANSCID_DPI_CC_STACK_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_STACK_SIZE=
CANSCID_DPI_CC_HEAP_SIZE_FLAG=  #  # -Wl,-defsym -Wl,_HEAP_SIZE=
CANSCID_DPI_OTHER_CC_FLAGS= $(CANSCID_DPI_CC_GLOBPTR_FLAG)  \
                  $(CANSCID_DPI_CC_START_ADDR_FLAG) $(CANSCID_DPI_CC_STACK_SIZE_FLAG) $(CANSCID_DPI_CC_HEAP_SIZE_FLAG)  \
                  $(CANSCID_DPI_CC_INFERRED_FLAGS)  \
                  $(CANSCID_DPI_LINKER_SCRIPT_FLAG) $(CANSCID_DPI_CC_DEBUG_FLAG) $(CANSCID_DPI_CC_PROFILE_FLAG) 
