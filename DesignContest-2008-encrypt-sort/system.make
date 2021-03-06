#################################################################
# Makefile generated by Xilinx Platform Studio 
# Project:F:\fpga\proj\DesignContest08_vjs_64bit_blk4\system.xmp
#################################################################

# Name of the Microprocessor system
# The hardware specification of the system is in file :
# F:\fpga\proj\DesignContest08_vjs_64bit_blk4\system.mhs
# The software specification of the system is in file :
# F:\fpga\proj\DesignContest08_vjs_64bit_blk4\system.mss

include system_incl.make


#################################################################
# EXTERNAL TARGETS
#################################################################
all:
	@echo "Makefile to build a Microprocessor system :"
	@echo "Run make with any of the following targets"
	@echo " "
	@echo "  netlist  : Generates the netlist for the given MHS "
	@echo "  bits     : Runs Implementation tools to generate the bitstream"
	@echo "  exporttopn:Export to ProjNav"
	@echo " "
	@echo "  libs     : Configures the sw libraries for this system"
	@echo "  program  : Compiles the program sources for all the processor instances"
	@echo " "
	@echo "  init_bram: Initializes bitstream with BRAM data"
	@echo "  ace      : Generate ace file from bitstream and elf"
	@echo "  download : Downloads the bitstream onto the board"
	@echo " "
	@echo "  sim      : Generates HDL simulation models and runs simulator for chosen simulation mode"
	@echo "  simmodel : Generates HDL simulation models for chosen simulation mode"
	@echo "  behavioral_model:Generates behavioral HDL models with BRAM initialization"
	@echo "  structural_model:Generates structural simulation HDL models with BRAM initialization"
	@echo "  timing_model    : Generates timing simulation HDL models with BRAM initialization"
	@echo "  vp       : Generates virtual platform model"
	@echo " "
	@echo "  netlistclean: Deletes netlist"
	@echo "  bitsclean: Deletes bit, ncd, bmm files"
	@echo "  hwclean  : Deletes implementation dir"
	@echo "  libsclean: Deletes sw libraries"
	@echo "  programclean: Deletes compiled ELF files"
	@echo "  swclean  : Deletes sw libraries and ELF files"
	@echo "  simclean : Deletes simulation dir"
	@echo "  vpclean  : Deletes virtualplatform dir"
	@echo "  clean    : Deletes all generated files/directories"
	@echo " "
	@echo "  make <target> : (Default)"
	@echo "      Creates a Microprocessor system using default initializations"
	@echo "      specified for each processor in MSS file"


bits: $(SYSTEM_BIT)

ace: $(SYSTEM_ACE)

netlist: $(POSTSYN_NETLIST)

libs: $(LIBRARIES)

program: $(ALL_USER_ELF_FILES)

download: $(DOWNLOAD_BIT) dummy
	@echo "*********************************************"
	@echo "Downloading Bitstream onto the target board"
	@echo "*********************************************"
	impact -batch etc/download.cmd

init_bram: $(DOWNLOAD_BIT)

sim: $(DEFAULT_SIM_SCRIPT)
	cd simulation/behavioral; \
	$(SIM_CMD)  &

simmodel: $(DEFAULT_SIM_SCRIPT)

behavioral_model: $(BEHAVIORAL_SIM_SCRIPT)

structural_model: $(STRUCTURAL_SIM_SCRIPT)

timing_model: $(TIMING_SIM_SCRIPT)

vp: $(VPEXEC)

clean: hwclean libsclean programclean simclean vpclean
	rm -f _impact.cmd

hwclean: netlistclean bitsclean
	rm -rf implementation synthesis xst hdl
	rm -rf xst.srp $(SYSTEM).srp

netlistclean:
	rm -f $(POSTSYN_NETLIST)
	rm -f $(BMM_FILE)

bitsclean:
	rm -f $(SYSTEM_BIT)
	rm -f implementation/$(SYSTEM).ncd
	rm -f implementation/$(SYSTEM)_bd.bmm 

bitsclean:

simclean: 
	rm -rf simulation/behavioral

swclean: libsclean programclean
	@echo ""

libsclean: $(LIBSCLEAN_TARGETS)

programclean: $(PROGRAMCLEAN_TARGETS)

vpclean:
	rm -rf virtualplatform

#################################################################
# SOFTWARE PLATFORM FLOW
#################################################################


$(LIBRARIES): $(MHSFILE) $(MSSFILE) __xps/libgen.opt
	@echo "*********************************************"
	@echo "Creating software libraries..."
	@echo "*********************************************"
	libgen $(LIBGEN_OPTIONS) $(MSSFILE)


ppc405_0_libsclean:
	rm -rf ppc405_0/lib/

ppc405_1_libsclean:
	rm -rf ppc405_1/lib/

#################################################################
# SOFTWARE APPLICATION TESTAPP_MEMORY
#################################################################

TestApp_Memory_program: $(TESTAPP_MEMORY_OUTPUT) 

$(TESTAPP_MEMORY_OUTPUT) : $(TESTAPP_MEMORY_SOURCES) $(TESTAPP_MEMORY_HEADERS) $(TESTAPP_MEMORY_LINKER_SCRIPT) \
                    $(LIBRARIES) __xps/testapp_memory_compiler.opt
	@mkdir -p $(TESTAPP_MEMORY_OUTPUT_DIR) 
	$(TESTAPP_MEMORY_CC) $(TESTAPP_MEMORY_CC_OPT) $(TESTAPP_MEMORY_SOURCES) -o $(TESTAPP_MEMORY_OUTPUT) \
	$(TESTAPP_MEMORY_OTHER_CC_FLAGS) $(TESTAPP_MEMORY_INCLUDES) $(TESTAPP_MEMORY_LIBPATH) \
	$(TESTAPP_MEMORY_CFLAGS) $(TESTAPP_MEMORY_LFLAGS) 
	$(TESTAPP_MEMORY_CC_SIZE) $(TESTAPP_MEMORY_OUTPUT) 

TestApp_Memory_programclean:
	rm -f $(TESTAPP_MEMORY_OUTPUT) 

#################################################################
# SOFTWARE APPLICATION TESTAPP_PERIPHERAL
#################################################################

TestApp_Peripheral_program: $(TESTAPP_PERIPHERAL_OUTPUT) 

$(TESTAPP_PERIPHERAL_OUTPUT) : $(TESTAPP_PERIPHERAL_SOURCES) $(TESTAPP_PERIPHERAL_HEADERS) $(TESTAPP_PERIPHERAL_LINKER_SCRIPT) \
                    $(LIBRARIES) __xps/testapp_peripheral_compiler.opt
	@mkdir -p $(TESTAPP_PERIPHERAL_OUTPUT_DIR) 
	$(TESTAPP_PERIPHERAL_CC) $(TESTAPP_PERIPHERAL_CC_OPT) $(TESTAPP_PERIPHERAL_SOURCES) -o $(TESTAPP_PERIPHERAL_OUTPUT) \
	$(TESTAPP_PERIPHERAL_OTHER_CC_FLAGS) $(TESTAPP_PERIPHERAL_INCLUDES) $(TESTAPP_PERIPHERAL_LIBPATH) \
	$(TESTAPP_PERIPHERAL_CFLAGS) $(TESTAPP_PERIPHERAL_LFLAGS) 
	$(TESTAPP_PERIPHERAL_CC_SIZE) $(TESTAPP_PERIPHERAL_OUTPUT) 

TestApp_Peripheral_programclean:
	rm -f $(TESTAPP_PERIPHERAL_OUTPUT) 

#################################################################
# SOFTWARE APPLICATION MERGE_SORT64
#################################################################

merge_sort64_program: $(MERGE_SORT64_OUTPUT) 

$(MERGE_SORT64_OUTPUT) : $(MERGE_SORT64_SOURCES) $(MERGE_SORT64_HEADERS) $(MERGE_SORT64_LINKER_SCRIPT) \
                    $(LIBRARIES) __xps/merge_sort64_compiler.opt
	@mkdir -p $(MERGE_SORT64_OUTPUT_DIR) 
	$(MERGE_SORT64_CC) $(MERGE_SORT64_CC_OPT) $(MERGE_SORT64_SOURCES) -o $(MERGE_SORT64_OUTPUT) \
	$(MERGE_SORT64_OTHER_CC_FLAGS) $(MERGE_SORT64_INCLUDES) $(MERGE_SORT64_LIBPATH) \
	$(MERGE_SORT64_CFLAGS) $(MERGE_SORT64_LFLAGS) 
	$(MERGE_SORT64_CC_SIZE) $(MERGE_SORT64_OUTPUT) 

merge_sort64_programclean:
	rm -f $(MERGE_SORT64_OUTPUT) 

#################################################################
# SOFTWARE APPLICATION METRIC
#################################################################

metric_program: $(METRIC_OUTPUT) 

$(METRIC_OUTPUT) : $(METRIC_SOURCES) $(METRIC_HEADERS) $(METRIC_LINKER_SCRIPT) \
                    $(LIBRARIES) __xps/metric_compiler.opt
	@mkdir -p $(METRIC_OUTPUT_DIR) 
	$(METRIC_CC) $(METRIC_CC_OPT) $(METRIC_SOURCES) -o $(METRIC_OUTPUT) \
	$(METRIC_OTHER_CC_FLAGS) $(METRIC_INCLUDES) $(METRIC_LIBPATH) \
	$(METRIC_CFLAGS) $(METRIC_LFLAGS) 
	$(METRIC_CC_SIZE) $(METRIC_OUTPUT) 

metric_programclean:
	rm -f $(METRIC_OUTPUT) 

#################################################################
# BOOTLOOP ELF FILES
#################################################################



$(PPC405_0_BOOTLOOP): $(PPC405_BOOTLOOP)
	@mkdir -p $(BOOTLOOP_DIR)
	cp -f $(PPC405_BOOTLOOP) $(PPC405_0_BOOTLOOP)

$(PPC405_1_BOOTLOOP): $(PPC405_BOOTLOOP)
	@mkdir -p $(BOOTLOOP_DIR)
	cp -f $(PPC405_BOOTLOOP) $(PPC405_1_BOOTLOOP)

#################################################################
# HARDWARE IMPLEMENTATION FLOW
#################################################################


$(BMM_FILE) \
$(WRAPPER_NGC_FILES): $(MHSFILE) __xps/platgen.opt \
                      $(CORE_STATE_DEVELOPMENT_FILES)
	@echo "****************************************************"
	@echo "Creating system netlist for hardware specification.."
	@echo "****************************************************"
	platgen $(PLATGEN_OPTIONS) -st xst $(MHSFILE)

$(POSTSYN_NETLIST): $(WRAPPER_NGC_FILES)
	@echo "Running synthesis..."
	bash -c "cd synthesis; ./synthesis.sh; cd .."

$(SYSTEM_BIT): $(BMM_FILE) $(POSTSYN_NETLIST) __xps/xpsxflow.opt \
               $(UCF_FILE) $(BITGEN_UT_FILE) $(FASTRUNTIME_OPT_FILE)
	@echo "Copying Xilinx Implementation tool scripts.."
	@cp -f $(BITGEN_UT_FILE) implementation/bitgen.ut
	@cp -f $(FASTRUNTIME_OPT_FILE) implementation/fast_runtime.opt
	@cp -f $(UCF_FILE) implementation/$(SYSTEM).ucf
	@echo "*********************************************"
	@echo "Running Xilinx Implementation tools.."
	@echo "*********************************************"
	xflow -wd implementation -p $(DEVICE) -implement fast_runtime.opt $(SYSTEM).ngc
	cd implementation; bitgen -w -f bitgen.ut $(SYSTEM)

exporttopn: 
	@echo "You have chosen XPS for implementation tool flow."
	@echo "Please select ProjNav as your implementation flow in Project Options."
	@echo "In batch mode, use commad xset pnproj <isefile>."

$(DOWNLOAD_BIT): $(SYSTEM_BIT) $(BRAMINIT_ELF_FILES) __xps/bitinit.opt
	@cp -f implementation/$(SYSTEM)_bd.bmm .
	@echo "*********************************************"
	@echo "Initializing BRAM contents of the bitstream"
	@echo "*********************************************"
	bitinit $(MHSFILE) $(SEARCHPATHOPT) $(BRAMINIT_ELF_FILE_ARGS) \
	-bt $(SYSTEM_BIT) -o $(DOWNLOAD_BIT)
	@rm -f $(SYSTEM)_bd.bmm

$(SYSTEM_ACE):
	@echo "In order to generate ace file, you must have:-"
	@echo "- exactly one processor."
	@echo "- opb_mdm, if using microblaze."

#################################################################
# SIMULATION FLOW
#################################################################


################## BEHAVIORAL SIMULATION ##################

$(BEHAVIORAL_SIM_SCRIPT): $(MHSFILE) __xps/simgen.opt \
                          $(BRAMINIT_ELF_FILES)
	@echo "*********************************************"
	@echo "Creating behavioral simulation models..."
	@echo "*********************************************"
	simgen $(SIMGEN_OPTIONS) -m behavioral $(MHSFILE)

################## STRUCTURAL SIMULATION ##################

$(STRUCTURAL_SIM_SCRIPT): $(WRAPPER_NGC_FILES) __xps/simgen.opt \
                          $(BRAMINIT_ELF_FILES)
	@echo "*********************************************"
	@echo "Creating structural simulation models..."
	@echo "*********************************************"
	simgen $(SIMGEN_OPTIONS) -sd implementation -m structural $(MHSFILE)


################## TIMING SIMULATION ##################

$(TIMING_SIM_SCRIPT): $(SYSTEM_BIT) __xps/simgen.opt \
                      $(BRAMINIT_ELF_FILES)
	@echo "*********************************************"
	@echo "Creating timing simulation models..."
	@echo "*********************************************"
	simgen $(SIMGEN_OPTIONS) -sd implementation -m timing $(MHSFILE)

#################################################################
# VIRTUAL PLATFORM FLOW
#################################################################


$(VPEXEC): $(MHSFILE) __xps/vpgen.opt
	@echo "****************************************************"
	@echo "Creating virtual platform for hardware specification.."
	@echo "****************************************************"
	vpgen $(VPGEN_OPTIONS) $(MHSFILE)

dummy:
	@echo ""

