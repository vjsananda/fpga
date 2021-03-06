//
// Generated by Bluespec Compiler, version 2008.05.beta4 (build 14006, 2008-05-12)
// 
// On Sat Jun  7 12:01:30 PDT 2008
// 
// Method conflict info:
// Method: start
// Sequenced after: result
// Conflicts: start
//  
// Method: result
// Conflict-free: result
// Sequenced before: start
//  
// 
// Ports:
// Name                         I/O  size props
// RDY_start                      O     1
// result                         O    32 reg
// RDY_result                     O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// start_num1                     I    32
// start_num2                     I    32
// EN_start                       I     1
// 
// No combinational paths from inputs to outputs
// 
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY
`endif

module mkGCD(CLK,
	     RST_N,
	     
	     start_num1,
	     start_num2,
	     EN_start,
	     RDY_start,
	     
	     result,
	     RDY_result);
  input  CLK;
  input  RST_N;
  
  // action method start
  input  [31 : 0] start_num1;
  input  [31 : 0] start_num2;
  input  EN_start;
  output RDY_start;
  
  // value method result
  output [31 : 0] result;
  output RDY_result;

  // signals for module outputs
  wire [31 : 0] result;
  wire RDY_result, RDY_start;

  // register x
  reg [31 : 0] x;
  wire [31 : 0] x$D_IN;
  wire x$EN;

  // register y
  reg [31 : 0] y;
  reg [31 : 0] y$D_IN;
  wire y$EN;

  // rule scheduling signals
  wire WILL_FIRE_RL_subtract, WILL_FIRE_RL_swap;

  // inputs to muxes for submodule ports
  wire [31 : 0] MUX_y$write_1__VAL_3;

  // remaining internal signals
  wire x_SLE_y___d3;

  // action method start
  assign RDY_start = y == 32'd0 ;

  // value method result
  assign result = x ;
  assign RDY_result = y == 32'd0 ;

  // rule RL_subtract
  assign WILL_FIRE_RL_subtract = x_SLE_y___d3 && y != 32'd0 ;

  // rule RL_swap
  assign WILL_FIRE_RL_swap = !x_SLE_y___d3 && y != 32'd0 ;

  // inputs to muxes for submodule ports
  assign MUX_y$write_1__VAL_3 = y - x ;

  // register x
  assign x$D_IN = EN_start ? start_num1 : y ;
  assign x$EN = EN_start || WILL_FIRE_RL_swap ;

  // register y
  always@(EN_start or
	  start_num2 or
	  WILL_FIRE_RL_swap or
	  x or WILL_FIRE_RL_subtract or MUX_y$write_1__VAL_3)
  begin
    case (1'b1) // synopsys parallel_case
      EN_start: y$D_IN = start_num2;
      WILL_FIRE_RL_swap: y$D_IN = x;
      WILL_FIRE_RL_subtract: y$D_IN = MUX_y$write_1__VAL_3;
      default: y$D_IN = 32'hAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign y$EN = EN_start || WILL_FIRE_RL_swap || WILL_FIRE_RL_subtract ;

  // remaining internal signals
  assign x_SLE_y___d3 = (x ^ 32'h80000000) <= (y ^ 32'h80000000) ;

  // handling of inlined registers
  
  always@(posedge CLK)
  begin
    if (!RST_N)
      begin
        y <= `BSV_ASSIGNMENT_DELAY 32'd0;
      end
    else
      begin
        if (y$EN) y <= `BSV_ASSIGNMENT_DELAY y$D_IN;
      end
    if (x$EN) x <= `BSV_ASSIGNMENT_DELAY x$D_IN;
  end
  
  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    x = 32'hAAAAAAAA;
    y = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkGCD


module tb;

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			CLK;			// To dut of mkGCD.v
   reg			EN_start;		// To dut of mkGCD.v
   reg			RST_N;			// To dut of mkGCD.v
   reg [31:0]		start_num1;		// To dut of mkGCD.v
   reg [31:0]		start_num2;		// To dut of mkGCD.v
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			RDY_result;		// From dut of mkGCD.v
   wire			RDY_start;		// From dut of mkGCD.v
   wire [31:0]		result;			// From dut of mkGCD.v
   // End of automatics

   initial
     begin
	$dumpvars;
	CLK =0;
	RST_N=0;
	start_num1=15;
	start_num2=6;
	EN_start = 0;
	#100;
	RST_N=1;
	#10000;
	$finish;
     end // initial begin

   always #5 CLK = ~CLK;


   always @(posedge CLK)
     if ( RST_N )
       begin
	  start_num1 <= start_num1 + 1;
	  start_num2 <= start_num2 + 2;
	  EN_start <= 1;
	  @(posedge CLK);
	  EN_start <= 0;
	  @(posedge CLK);	  
	  wait( RDY_start );
       end
   
   
   mkGCD dut(/*AUTOINST*/
	     // Outputs
	     .RDY_start			(RDY_start),
	     .result			(result[31:0]),
	     .RDY_result		(RDY_result),
	     // Inputs
	     .CLK			(CLK),
	     .RST_N			(RST_N),
	     .start_num1		(start_num1[31:0]),
	     .start_num2		(start_num2[31:0]),
	     .EN_start			(EN_start));
   
endmodule // tb
