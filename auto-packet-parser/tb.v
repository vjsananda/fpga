`timescale 1ns/1ns

module tb;

   `include "parameter.vh"
   
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To unpack_i of app_unpack.v, ...
   reg [w_din-1:0]	din;			// To unpack_i of app_unpack.v
   reg			din_v;			// To unpack_i of app_unpack.v
   reg			rst;			// To unpack_i of app_unpack.v, ...
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [w_din-1:0]	dout;			// From pack_i of app_pack.v
   wire			dout_v;			// From pack_i of app_pack.v
   wire [w_f0-1:0]	f0;			// From unpack_i of app_unpack.v
   wire			f0_v;			// From unpack_i of app_unpack.v
   wire [w_f1-1:0]	f1;			// From unpack_i of app_unpack.v
   wire			f1_v;			// From unpack_i of app_unpack.v
   wire [w_f2-1:0]	f2;			// From unpack_i of app_unpack.v
   wire			f2_v;			// From unpack_i of app_unpack.v
   wire [w_f3-1:0]	f3;			// From unpack_i of app_unpack.v
   wire			f3_v;			// From unpack_i of app_unpack.v
   wire [w_f4-1:0]	f4;			// From unpack_i of app_unpack.v
   wire			f4_v;			// From unpack_i of app_unpack.v
   // End of automatics


   initial
     begin
	$dumpvars;
	clk=0;
	din=0;
	din_v=0;
	rst=1;
	#100;
	rst=0;
	#10000;
	$finish;
     end

   always #5 clk = ~clk;

   always @(posedge clk)
     if (~rst)
       begin
	  @(posedge clk);
	  din <= $random() ;
	  din_v <= 1;
	  @(posedge clk);	  	  
	  din_v <= 0;	  	  
	  @(posedge clk);	  
	  din <= $random() ;
	  din_v <= 1;
	  @(posedge clk);	  	  
	  din_v <= 0;	  	  
	  @(posedge clk);	  
	  din <= $random() ;
	  din_v <= 1;
	  @(posedge clk);	  	  
	  din_v <= 0;	  
       end

   app_unpack unpack_i (/*AUTOINST*/
			// Outputs
			.f0		(f0[w_f0-1:0]),
			.f0_v		(f0_v),
			.f1		(f1[w_f1-1:0]),
			.f1_v		(f1_v),
			.f2		(f2[w_f2-1:0]),
			.f2_v		(f2_v),
			.f3		(f3[w_f3-1:0]),
			.f3_v		(f3_v),
			.f4		(f4[w_f4-1:0]),
			.f4_v		(f4_v),
			// Inputs
			.clk		(clk),
			.rst		(rst),
			.din		(din[w_din-1:0]),
			.din_v		(din_v));
   
   app_pack pack_i (/*AUTOINST*/
		    // Outputs
		    .dout		(dout[w_din-1:0]),
		    .dout_v		(dout_v),
		    // Inputs
		    .clk		(clk),
		    .rst		(rst),
		    .f0			(f0[w_f0-1:0]),
		    .f0_v		(f0_v),
		    .f1			(f1[w_f1-1:0]),
		    .f1_v		(f1_v),
		    .f2			(f2[w_f2-1:0]),
		    .f2_v		(f2_v),
		    .f3			(f3[w_f3-1:0]),
		    .f3_v		(f3_v),
		    .f4			(f4[w_f4-1:0]),
		    .f4_v		(f4_v));
   
endmodule // test
