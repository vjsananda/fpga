------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              Tue Mar 30 10:52:23 2010 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--   C_NUM_REG                    -- Number of software accessible registers
--   C_NUM_INTR                   -- Number of interrupt event
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   Bus2IP_Burst                 -- Bus to IP burst-mode qualifier
--   Bus2IP_BurstLength           -- Bus to IP burst length
--   Bus2IP_RdReq                 -- Bus to IP read request
--   Bus2IP_WrReq                 -- Bus to IP write request
--   IP2Bus_AddrAck               -- IP to Bus address acknowledgement
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
--   IP2Bus_IntrEvent             -- IP to Bus interrupt event
--   IP2RFIFO_WrReq               -- IP to RFIFO : IP write request
--   IP2RFIFO_Data                -- IP to RFIFO : IP write data bus
--   RFIFO2IP_WrAck               -- RFIFO to IP : RFIFO write acknowledge
--   RFIFO2IP_AlmostFull          -- RFIFO to IP : RFIFO almost full
--   RFIFO2IP_Full                -- RFIFO to IP : RFIFO full
--   IP2WFIFO_RdReq               -- IP to WFIFO : IP read request
--   WFIFO2IP_Data                -- WFIFO to IP : WFIFO read data
--   WFIFO2IP_RdAck               -- WFIFO to IP : WFIFO read acknowledge
--   WFIFO2IP_AlmostEmpty         -- WFIFO to IP : WFIFO almost empty
--   WFIFO2IP_Empty               -- WFIFO to IP : WFIFO empty
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_SLV_DWIDTH                   : integer              := 32;
    C_NUM_REG                      : integer              := 20;
    C_NUM_INTR                     : integer              := 1
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    --USER ports added here
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(0 to C_SLV_DWIDTH-1);
    Bus2IP_BE                      : in  std_logic_vector(0 to C_SLV_DWIDTH/8-1);
    Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    Bus2IP_Burst                   : in  std_logic;
    Bus2IP_BurstLength             : in  std_logic_vector(0 to 8);
    Bus2IP_RdReq                   : in  std_logic;
    Bus2IP_WrReq                   : in  std_logic;
    IP2Bus_AddrAck                 : out std_logic;
    IP2Bus_Data                    : out std_logic_vector(0 to C_SLV_DWIDTH-1);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic;
    IP2Bus_IntrEvent               : out std_logic_vector(0 to C_NUM_INTR-1);
    IP2RFIFO_WrReq                 : out std_logic;
    IP2RFIFO_Data                  : out std_logic_vector(0 to C_SLV_DWIDTH-1);
    RFIFO2IP_WrAck                 : in  std_logic;
    RFIFO2IP_AlmostFull            : in  std_logic;
    RFIFO2IP_Full                  : in  std_logic;
    IP2WFIFO_RdReq                 : out std_logic;
    WFIFO2IP_Data                  : in  std_logic_vector(0 to C_SLV_DWIDTH-1);
    WFIFO2IP_RdAck                 : in  std_logic;
    WFIFO2IP_AlmostEmpty           : in  std_logic;
    WFIFO2IP_Empty                 : in  std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Reset  : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic

  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal slv_reg0                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg1                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg2                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg3                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg4                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg5                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg6                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg7                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg8                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg9                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg10                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg11                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg12                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg13                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg14                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg15                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg16                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg17                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg18                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg19                      : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg_write_sel              : std_logic_vector(0 to 19);
  signal slv_reg_read_sel               : std_logic_vector(0 to 19);
  signal slv_ip2bus_data                : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_read_ack                   : std_logic;
  signal slv_write_ack                  : std_logic;

  ------------------------------------------
  -- Signals for user logic interrupt example
  ------------------------------------------
  signal intr_counter                   : std_logic_vector(0 to C_NUM_INTR-1);

  ------------------------------------------
  -- Signals for read/write fifo loopback example
  ------------------------------------------
  type FIFO_CNTL_SM_TYPE is (IDLE, RD_REQ, WR_REQ);
  signal fifo_cntl_ns                   : FIFO_CNTL_SM_TYPE;
  signal fifo_cntl_cs                   : FIFO_CNTL_SM_TYPE;
  signal fifo_rdreq_cmb                 : std_logic;
  signal fifo_wrreq_cmb                 : std_logic;

begin

  --USER logic implementation added here

  ------------------------------------------
  -- Example code to read/write user logic slave model s/w accessible registers
  -- 
  -- Note:
  -- The example code presented here is to show you one way of reading/writing
  -- software accessible registers implemented in the user logic slave model.
  -- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  -- to one software accessible register by the top level template. For example,
  -- if you have four 32 bit software accessible registers in the user logic,
  -- you are basically operating on the following memory mapped registers:
  -- 
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0
  --                     "0100"   C_BASEADDR + 0x4
  --                     "0010"   C_BASEADDR + 0x8
  --                     "0001"   C_BASEADDR + 0xC
  -- 
  ------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE(0 to 19);
  slv_reg_read_sel  <= Bus2IP_RdCE(0 to 19);
  slv_write_ack     <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2) or Bus2IP_WrCE(3) or Bus2IP_WrCE(4) or Bus2IP_WrCE(5) or Bus2IP_WrCE(6) or Bus2IP_WrCE(7) or Bus2IP_WrCE(8) or Bus2IP_WrCE(9) or Bus2IP_WrCE(10) or Bus2IP_WrCE(11) or Bus2IP_WrCE(12) or Bus2IP_WrCE(13) or Bus2IP_WrCE(14) or Bus2IP_WrCE(15) or Bus2IP_WrCE(16) or Bus2IP_WrCE(17) or Bus2IP_WrCE(18) or Bus2IP_WrCE(19);
  slv_read_ack      <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2) or Bus2IP_RdCE(3) or Bus2IP_RdCE(4) or Bus2IP_RdCE(5) or Bus2IP_RdCE(6) or Bus2IP_RdCE(7) or Bus2IP_RdCE(8) or Bus2IP_RdCE(9) or Bus2IP_RdCE(10) or Bus2IP_RdCE(11) or Bus2IP_RdCE(12) or Bus2IP_RdCE(13) or Bus2IP_RdCE(14) or Bus2IP_RdCE(15) or Bus2IP_RdCE(16) or Bus2IP_RdCE(17) or Bus2IP_RdCE(18) or Bus2IP_RdCE(19);

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
  begin

    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Reset = '1' then
        slv_reg0 <= (others => '0');
        slv_reg1 <= (others => '0');
        slv_reg2 <= (others => '0');
        slv_reg3 <= (others => '0');
        slv_reg4 <= (others => '0');
        slv_reg5 <= (others => '0');
        slv_reg6 <= (others => '0');
        slv_reg7 <= (others => '0');
        slv_reg8 <= (others => '0');
        slv_reg9 <= (others => '0');
        slv_reg10 <= (others => '0');
        slv_reg11 <= (others => '0');
        slv_reg12 <= (others => '0');
        slv_reg13 <= (others => '0');
        slv_reg14 <= (others => '0');
        slv_reg15 <= (others => '0');
        slv_reg16 <= (others => '0');
        slv_reg17 <= (others => '0');
        slv_reg18 <= (others => '0');
        slv_reg19 <= (others => '0');
      else
        case slv_reg_write_sel is
          when "10000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg0(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "01000000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg1(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00100000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg2(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00010000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg3(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00001000000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg4(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000100000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg5(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000010000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg6(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000001000000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg7(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000100000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg8(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000010000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg9(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000001000000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg10(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000100000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg11(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000010000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg12(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000001000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg13(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000000100000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg14(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000000010000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg15(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000000001000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg16(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000000000100" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg17(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000000000010" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg18(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000000000000000001" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg19(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when others => null;
        end case;
      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read mux
  SLAVE_REG_READ_PROC : process( slv_reg_read_sel, slv_reg0, slv_reg1, slv_reg2, slv_reg3, slv_reg4, slv_reg5, slv_reg6, slv_reg7, slv_reg8, slv_reg9, slv_reg10, slv_reg11, slv_reg12, slv_reg13, slv_reg14, slv_reg15, slv_reg16, slv_reg17, slv_reg18, slv_reg19 ) is
  begin

    case slv_reg_read_sel is
      when "10000000000000000000" => slv_ip2bus_data <= slv_reg0;
      when "01000000000000000000" => slv_ip2bus_data <= slv_reg1;
      when "00100000000000000000" => slv_ip2bus_data <= slv_reg2;
      when "00010000000000000000" => slv_ip2bus_data <= slv_reg3;
      when "00001000000000000000" => slv_ip2bus_data <= slv_reg4;
      when "00000100000000000000" => slv_ip2bus_data <= slv_reg5;
      when "00000010000000000000" => slv_ip2bus_data <= slv_reg6;
      when "00000001000000000000" => slv_ip2bus_data <= slv_reg7;
      when "00000000100000000000" => slv_ip2bus_data <= slv_reg8;
      when "00000000010000000000" => slv_ip2bus_data <= slv_reg9;
      when "00000000001000000000" => slv_ip2bus_data <= slv_reg10;
      when "00000000000100000000" => slv_ip2bus_data <= slv_reg11;
      when "00000000000010000000" => slv_ip2bus_data <= slv_reg12;
      when "00000000000001000000" => slv_ip2bus_data <= slv_reg13;
      when "00000000000000100000" => slv_ip2bus_data <= slv_reg14;
      when "00000000000000010000" => slv_ip2bus_data <= slv_reg15;
      when "00000000000000001000" => slv_ip2bus_data <= slv_reg16;
      when "00000000000000000100" => slv_ip2bus_data <= slv_reg17;
      when "00000000000000000010" => slv_ip2bus_data <= slv_reg18;
      when "00000000000000000001" => slv_ip2bus_data <= slv_reg19;
      when others => slv_ip2bus_data <= (others => '0');
    end case;

  end process SLAVE_REG_READ_PROC;

  ------------------------------------------
  -- Example code to generate user logic interrupts
  -- 
  -- Note:
  -- The example code presented here is to show you one way of generating
  -- interrupts from the user logic. This code snippet infers a counter
  -- and generate the interrupts whenever the counter rollover (the counter
  -- will rollover ~21 sec @50Mhz).
  ------------------------------------------
  INTR_PROC : process( Bus2IP_Clk ) is
    constant COUNT_SIZE   : integer := 30;
    constant ALL_ONES     : std_logic_vector(0 to COUNT_SIZE-1) := (others => '1');
    variable counter      : std_logic_vector(0 to COUNT_SIZE-1);
  begin

    if ( Bus2IP_Clk'event and Bus2IP_Clk = '1' ) then
      if ( Bus2IP_Reset = '1' ) then
        counter := (others => '0');
        intr_counter <= (others => '0');
      else
        counter := counter + 1;
        if ( counter = ALL_ONES ) then
          intr_counter <= (others => '1');
        else
          intr_counter <= (others => '0');
        end if;
      end if;
    end if;

  end process INTR_PROC;

  IP2Bus_IntrEvent <= intr_counter;

  ------------------------------------------
  -- Example code to transfer data between read/write fifo
  -- 
  -- Note:
  -- The example code presented here is to show you one way of operating on
  -- the read/write FIFOs provided for you. There's a set of IPIC ports
  -- dedicated to the FIFO operations, beginning with RFIFO2IP_* or IP2RFIFO_*
  -- or WFIFO2IP_* or IP2WFIFO_*. Some FIFO ports are only available when
  -- certain FIFO services are present, s.t. vacancy calculation, etc.
  -- Typically you will need to have a state machine to read data from the
  -- write FIFO or write data to the read FIFO. This code snippet simply
  -- transfer the data from the write FIFO to the read FIFO.
  ------------------------------------------
  FIFO_CNTL_SM_COMB : process( WFIFO2IP_empty, WFIFO2IP_RdAck, RFIFO2IP_full, RFIFO2IP_WrAck, fifo_cntl_cs ) is
  begin

    -- set defaults
    fifo_rdreq_cmb <= '0';
    fifo_wrreq_cmb <= '0';
    fifo_cntl_ns   <= fifo_cntl_cs;

    case fifo_cntl_cs is
      when IDLE =>
        -- data is available in the write fifo and there's space in the read fifo,
        -- so we can start transfering the data from write fifo to read fifo
        if ( WFIFO2IP_empty = '0' and RFIFO2IP_full = '0' ) then
          fifo_rdreq_cmb <= '1';
          fifo_cntl_ns   <= RD_REQ;
        end if;
      when RD_REQ =>
        -- data has been read from the write fifo,
        -- so we can write it to the read fifo
        if ( WFIFO2IP_RdAck = '1' ) then
          fifo_wrreq_cmb <= '1';
          fifo_cntl_ns   <= WR_REQ;
        end if;
      when WR_REQ =>
        -- data has been written to the read fifo,
        -- so data transfer is done
        if ( RFIFO2IP_WrAck = '1' ) then
          fifo_cntl_ns <= IDLE;
        end if;
      when others =>
        fifo_cntl_ns <= IDLE;
    end case;

  end process FIFO_CNTL_SM_COMB;

-- Just drain the fifo
--  FIFO_CNTL_SM_COMB : process( WFIFO2IP_empty, WFIFO2IP_RdAck, RFIFO2IP_full, RFIFO2IP_WrAck, fifo_cntl_cs ) is
--  begin

--    -- set defaults
--    fifo_rdreq_cmb <= '0';
--    fifo_wrreq_cmb <= '0';
--    fifo_cntl_ns   <= fifo_cntl_cs;

--    case fifo_cntl_cs is
--      when IDLE =>
--        -- data is available in the write fifo and there's space in the read fifo,
--        -- so we can start transfering the data from write fifo to read fifo
--        if ( WFIFO2IP_empty = '0' and RFIFO2IP_full = '0' ) then
--          fifo_rdreq_cmb <= '1';
--          fifo_cntl_ns   <= RD_REQ;
--        end if;
--      when RD_REQ =>
--        -- data has been read from the write fifo,
--        -- so we can write it to the read fifo
--        if ( WFIFO2IP_RdAck = '1' ) then
--          fifo_wrreq_cmb <= '1';
--          fifo_cntl_ns   <= IDLE;
--        end if;
--      when others =>
--        fifo_cntl_ns <= IDLE;
--    end case;

--  end process FIFO_CNTL_SM_COMB;

  
  FIFO_CNTL_SM_SEQ : process( Bus2IP_Clk ) is
  begin

    if ( Bus2IP_Clk'event and Bus2IP_Clk = '1' ) then
      if ( Bus2IP_Reset = '1' ) then
        IP2WFIFO_RdReq <= '0';
        IP2RFIFO_WrReq <= '0';
        fifo_cntl_cs   <= IDLE;
      else
        IP2WFIFO_RdReq <= fifo_rdreq_cmb;
        IP2RFIFO_WrReq <= fifo_wrreq_cmb;
        fifo_cntl_cs   <= fifo_cntl_ns;
      end if;
    end if;

  end process FIFO_CNTL_SM_SEQ;

  IP2RFIFO_Data <= WFIFO2IP_Data;

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data  <= slv_ip2bus_data when slv_read_ack = '1' else
                  (others => '0');

  IP2Bus_AddrAck <= slv_write_ack or slv_read_ack;
  IP2Bus_WrAck <= slv_write_ack;
  IP2Bus_RdAck <= slv_read_ack;
  IP2Bus_Error <= '0';

end IMP;
