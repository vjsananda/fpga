//----------------------------------------------------------------------------
// user_logic.v - module
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** Xilinx, Inc.                                                          **
// ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
// ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
// ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
// ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
// ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
// ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
// ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
// ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
// ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
// ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
// ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
// ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
// ** FOR A PARTICULAR PURPOSE.                                             **
// **                                                                       **
// ** YOU MAY COPY AND MODIFY THESE FILES FOR YOUR OWN INTERNAL USE SOLELY  **
// ** WITH XILINX PROGRAMMABLE LOGIC DEVICES AND XILINX EDK SYSTEM OR       **
// ** CREATE IP MODULES SOLELY FOR XILINX PROGRAMMABLE LOGIC DEVICES AND    **
// ** XILINX EDK SYSTEM. NO RIGHTS ARE GRANTED TO DISTRIBUTE ANY FILES      **
// ** UNLESS THEY ARE DISTRIBUTED IN XILINX PROGRAMMABLE LOGIC DEVICES.     **
// **                                                                       **
// ***************************************************************************
//
//----------------------------------------------------------------------------
// Filename:          user_logic.v
// Version:           1.00.a
// Description:       User logic module.
// Date:              Tue Apr 05 13:12:01 2005 (by Create and Import Peripheral Wizard)
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

`define rd_code  3'd0
`define rd_code_ack  3'd1

`define rd_len  3'd2
`define rd_len_ack  3'd3

`define wait_for_pop  3'd4

`define wait_for_result 2'b00
`define wait_for_rfifo  2'b01
`define wait_for_wr_ack 2'b11   

module user_logic
(
  // -- add user ports below this line ---------------
  // --user ports added here 
  // -- add user ports above this line ---------------

  // -- do not edit below this line ------------------
  // -- bus protocol ports, do not add to or delete 
  bus2ip_clk,                     // bus to ip clock
  bus2ip_reset,                   // bus to ip reset
  bus2ip_data,                    // bus to ip data bus for user logic
  bus2ip_be,                      // bus to ip byte enables for user logic
  bus2ip_rdce,                    // bus to ip read chip enable for user logic
  bus2ip_wrce,                    // bus to ip write chip enable for user logic
  ip2bus_data,                    // ip to bus data bus for user logic
  ip2bus_ack,                     // ip to bus acknowledgement
  ip2bus_retry,                   // ip to bus retry response
  ip2bus_error,                   // ip to bus error response
  ip2bus_toutsup,                 // ip to bus timeout suppress
  ip2rfifo_wrreq,                 // ip to rfifo : ip write request
  ip2rfifo_data,                  // ip to rfifo : ip write data
  rfifo2ip_wrack,                 // rfifo to ip : rfifo write acknowledge
  rfifo2ip_almostfull,            // rfifo to ip : rfifo almost full
  rfifo2ip_full,                  // rfifo to ip : rfifo full
  rfifo2ip_vacancy,               // rfifo to ip : rfifo vacancy
  ip2wfifo_rdreq,                 // ip to wfifo : ip read request
  wfifo2ip_data,                  // wfifo to ip : wfifo read data
  wfifo2ip_rdack,                 // wfifo to ip : wfifo read acknowledge
  wfifo2ip_almostempty,           // wfifo to ip : wfifo almost empty
  wfifo2ip_empty,                 // wfifo to ip : wfifo empty
  wfifo2ip_occupancy              // wfifo to ip : wfifo occupancy
  // -- do not edit above this line ------------------
); // user_logic

// -- add user parameters below this line ------------
// --user parameters added here 
// -- add user parameters above this line ------------

parameter c_width=32 ; //code width from 1 to 32 bits
parameter p_width=32 ; //packed data width 32 bits
parameter p_width_msb=31 ; //packed data width 31 bits   
parameter cz_width=32 ; //code size width

// -- do not edit below this line --------------------
// -- bus protocol parameters, do not add to or delete
parameter c_dwidth                       = 32;
parameter c_num_ce                       = 2;
parameter c_rdfifo_dwidth                = 32;
parameter c_rdfifo_depth                 = 512;
parameter c_wrfifo_dwidth                = 32;
parameter c_wrfifo_depth                 = 512;
// -- do not edit above this line --------------------

// -- add user ports below this line -----------------
// --user ports added here 
// -- add user ports above this line -----------------

// -- do not edit below this line --------------------
// -- bus protocol ports, do not add to or delete
input                                     bus2ip_clk;
input                                     bus2ip_reset;
input      [0 : c_dwidth-1]               bus2ip_data;
input      [0 : c_dwidth/8-1]             bus2ip_be;
input      [0 : c_num_ce-1]               bus2ip_rdce;
input      [0 : c_num_ce-1]               bus2ip_wrce;
output     [0 : c_dwidth-1]               ip2bus_data;
output                                    ip2bus_ack;
output                                    ip2bus_retry;
output                                    ip2bus_error;
output                                    ip2bus_toutsup;
output                                    ip2rfifo_wrreq;
output     [0 : c_rdfifo_dwidth-1]        ip2rfifo_data;
input                                     rfifo2ip_wrack;
input                                     rfifo2ip_almostfull;
input                                     rfifo2ip_full;
input      [0 : 9]                        rfifo2ip_vacancy;
output                                    ip2wfifo_rdreq;
input      [0 : c_wrfifo_dwidth-1]        wfifo2ip_data;
input                                     wfifo2ip_rdack;
input                                     wfifo2ip_almostempty;
input                                     wfifo2ip_empty;
input      [0 : 9]                       wfifo2ip_occupancy;
// -- do not edit above this line --------------------

//----------------------------------------------------------------------------
// implementation
//----------------------------------------------------------------------------

  // --user nets declarations added here, as needed for user logic

  // nets for user logic slave model s/w accessible register example
  reg        [0 : c_dwidth-1]               slv_reg0;
  reg        [0 : c_dwidth-1]               slv_reg1;
  wire       [0 : 1]                        slv_reg_write_select;
  wire       [0 : 1]                        slv_reg_read_select;
  reg        [0 : c_dwidth-1]               slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;

//type fifo_cntl_sm_type

    reg [2:0] fifo_cntl_ns;
    reg [2:0] fifo_cntl_cs;

    reg ip2wfifo_rdreq_cmb;
    reg ip2rfifo_wrreq_cmb;
    wire [0:(c_dwidth - 1)] ip2bus_data;
    wire ip2bus_ack;
    wire ip2bus_retry;
    wire ip2bus_error;
    wire ip2bus_toutsup;
    reg ip2rfifo_wrreq;
    wire [0:(c_rdfifo_dwidth - 1)] ip2rfifo_data;
    wire ip2rfifo_wrmark;
    wire ip2rfifo_wrrelease;
    wire ip2rfifo_wrrestore;
    reg ip2wfifo_rdreq;
    wire ip2wfifo_rdmark;
    wire ip2wfifo_rdrelease;
    wire ip2wfifo_rdrestore;

  // --user logic implementation added here

  // ------------------------------------------------------
  // example code to read/write user logic slave model s/w accessible registers
  // 
  // note:
  // the example code presented here is to show you one way of reading/writing
  // software accessible registers implemented in the user logic slave model.
  // each bit of the bus2ip_wrce/bus2ip_rdce signals is configured to correspond
  // to one software accessible register by the top level template. for example,
  // if you have four 32 bit software accessible registers in the user logic, you
  // are basically operating on the following memory mapped registers:
  // 
  //    bus2ip_wrce or   memory mapped
  //       bus2ip_rdce   register
  //            "1000"   c_baseaddr + 0x0
  //            "0100"   c_baseaddr + 0x4
  //            "0010"   c_baseaddr + 0x8
  //            "0001"   c_baseaddr + 0xc
  // 
  // ------------------------------------------------------
  
  assign
    slv_reg_write_select = bus2ip_wrce[0:1],
    slv_reg_read_select  = bus2ip_rdce[0:1],
    slv_write_ack        = bus2ip_wrce[0] || bus2ip_wrce[1] ,
    slv_read_ack         = bus2ip_rdce[0] || bus2ip_rdce[1] ;

  // implement slave model register read mux
  always @( slv_reg_read_select or slv_reg0 or slv_reg1 )
    begin: slave_reg_read_proc

      case ( slv_reg_read_select )
        2'b10 : slv_ip2bus_data <= slv_reg0;
        2'b01 : slv_ip2bus_data <= slv_reg1;
        default : slv_ip2bus_data <= 0;
      endcase

    end // slave_reg_read_proc

  // ------------------------------------------------------------
  // example code to drive ip to bus signals
  // ------------------------------------------------------------

  assign ip2bus_data        = slv_ip2bus_data;
  assign ip2bus_ack         = slv_write_ack || slv_read_ack;
  assign ip2bus_error       = 0;
  assign ip2bus_retry       = 0;
  assign ip2bus_toutsup     = 0;

   //fifo read/write

   assign {ip2rfifo_wrmark}=1'b0;
   
   assign {ip2rfifo_wrrelease}=1'b0;
   
   assign {ip2rfifo_wrrestore}=1'b0;
   
   assign {ip2wfifo_rdmark}=1'b0;
   
   assign {ip2wfifo_rdrelease}=1'b0;
   
   assign {ip2wfifo_rdrestore}=1'b0;

   wire   clk = bus2ip_clk ;
   wire   reset = bus2ip_reset ;

   wire 	  not_full = ~rfifo2ip_full;		// To vlcpack_i of vlcpacker.v

   reg 			rdy_rc,rdy_wc;
   
   wire 		rdy = rdy_rc ;
   
   reg [cz_width-1:0]	ldata_wd;		// to dut of vlcpacker.v
   reg [cz_width-1:0]	ldata_rd;		// to dut of vlcpacker.v
   
   wire [3:0] 		code = ldata_rd ;
   
   /*autoreg*/

   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [p_width-1:0]	odata;			// From huffman_encode_i of huffman_encode.v
   wire			pop;			// From huffman_encode_i of huffman_encode.v
   wire			push;			// From huffman_encode_i of huffman_encode.v
   // End of automatics

   reg [p_width-1:0]	result_rd;	// from dut of vlcpacker.v
   reg [p_width-1:0]	result_wd;	// from dut of vlcpacker.v   //

  // implement slave model register(s)
   //Read only , number of pops and pushes
  always @( posedge bus2ip_clk )
    begin: slave_reg_write_proc

      if ( bus2ip_reset == 1 )
        begin
          slv_reg0 <= 0;
          slv_reg1 <= 0;
        end
      else
	begin
	   case ( slv_reg_write_select )
             2'b10 :
               slv_reg0 <= bus2ip_data;
             2'b01 :
               slv_reg1 <= bus2ip_data;
	     default:
	       begin
		  if ( pop )
		    slv_reg0 <= slv_reg0 + 1;
		  if (push)
		    slv_reg1 <= slv_reg1 + 1;
	       end
	   endcase
	end // else: !if( bus2ip_reset == 1 )
    end // slave_reg_write_proc
   
   huffman_encode huffman_encode_i (/*AUTOINST*/
				    // Outputs
				    .odata		(odata[p_width-1:0]),
				    .push		(push),
				    .pop		(pop),
				    // Inputs
				    .code		(code[3:0]),
				    .rdy		(rdy),
				    .not_full		(not_full),
				    .clk		(clk),
				    .reset		(reset));
       
   always @ (/*autosense*/
	     fifo_cntl_cs or ldata_rd or pop or rdy_rc
	     or wfifo2ip_data or wfifo2ip_empty or wfifo2ip_rdack)

     begin

	//default assignments
        ip2wfifo_rdreq_cmb = 1'b0;

        fifo_cntl_ns = fifo_cntl_cs;
	rdy_wc = rdy_rc ;

	ldata_wd = ldata_rd ;
	
	//read code and len 
        case (fifo_cntl_cs)
          `rd_code:
            if ((wfifo2ip_empty == 1'b0)) 	      
              begin
		 rdy_wc = 1'b0;
                 ip2wfifo_rdreq_cmb = 1'b1;
                 fifo_cntl_ns = `rd_code_ack;
              end

          `rd_code_ack:
            if ((wfifo2ip_rdack == 1'b1)) 
              begin
		 ldata_wd = wfifo2ip_data ;
		 rdy_wc = 1'b1 ;
                 fifo_cntl_ns = `wait_for_pop;
              end

	  `wait_for_pop:
	    if ( pop == 1 )
	      begin
		 rdy_wc = 1'b0 ;
		 fifo_cntl_ns = `rd_code;
	      end
	  
          default : 
            fifo_cntl_ns = `rd_code ;
	  
        endcase
     end 
   // end always 

   reg [1:0] fifo_wr_cntl_cs ,fifo_wr_cntl_ns ;
   
   always @(/*AUTOSENSE*/
	    code or fifo_wr_cntl_cs or push
	    or result_rd or rfifo2ip_full or rfifo2ip_wrack)
     begin
	result_wd = result_rd ;
        ip2rfifo_wrreq_cmb = 1'b0;
        fifo_wr_cntl_ns = fifo_wr_cntl_cs;
	
	case(fifo_wr_cntl_cs)
          
	  `wait_for_result:	
            if ( push == 1'b1 )
	      begin
		 result_wd = odata;
		 
		 if ( rfifo2ip_full )
		   fifo_wr_cntl_ns = `wait_for_rfifo ;
		 else
		   begin
		      fifo_wr_cntl_ns = `wait_for_wr_ack;
		      ip2rfifo_wrreq_cmb = 1'b1;
		   end
	      end

	  `wait_for_rfifo:
	    begin
	       if ( rfifo2ip_full == 1'b0)
		 begin
		    ip2rfifo_wrreq_cmb = 1'b1;	    
		    fifo_wr_cntl_ns = `wait_for_wr_ack ;
		 end
	    end
		 
	  `wait_for_wr_ack:	
	    if ( rfifo2ip_wrack == 1'b1 )
	      fifo_wr_cntl_ns = `wait_for_result;

          default : 
            fifo_wr_cntl_ns = `wait_for_result ;
	  
	endcase // case (fifo_wr_cntl_cs)
     end
   
   always @ (posedge bus2ip_clk ) // begin 
     if ((bus2ip_reset == 1'b1)) 
       begin 
          ip2wfifo_rdreq <= 1'b0;
          ip2rfifo_wrreq <= 1'b0;
          fifo_cntl_cs <= `rd_code ;
	  fifo_wr_cntl_cs <= `wait_for_result ;
	  rdy_rc <= 0;
	  
       end
     else 
       begin
	  rdy_rc <= rdy_wc ;
	  result_rd <= result_wd ;
	  ldata_rd <= ldata_wd ;
          ip2wfifo_rdreq <= ip2wfifo_rdreq_cmb;
          ip2rfifo_wrreq <= ip2rfifo_wrreq_cmb;
          fifo_cntl_cs <= fifo_cntl_ns;
          fifo_wr_cntl_cs <= fifo_wr_cntl_ns;	  
       end
                        
   // end always 

   assign ip2rfifo_data = result_rd ;
   
   assign {ip2bus_data}=slv_ip2bus_data;
   
   assign {ip2bus_ack}=(slv_write_ack | slv_read_ack);
   
   assign {ip2bus_error}=1'b0;
   
   assign {ip2bus_retry}=1'b0;
   
   assign {ip2bus_toutsup}=1'b0;
   
endmodule
