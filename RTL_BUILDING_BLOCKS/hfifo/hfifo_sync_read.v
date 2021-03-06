`timescale 1ns/1ns

/*
 * Output valid if not_empty is high, use like a valid
 */

module hfifo_sync_read(/*AUTOARG*/
   // Outputs
   dout, rdy, not_full, 
   // Inputs
   clk, reset, din, push, pop
   );

   //following 3 params must be consistent
   parameter size   = 256 ;
   parameter pwidth = 8 ;//log2(size)
   parameter swidth = 9 ;//log2(size)+1
   parameter dwidth = 8 ;
   
   input     clk ;
   input     reset;
   input [dwidth-1:0] din;
   input 	      push ;
   input 	      pop;
   
   output [dwidth-1:0] dout;
   output 	       rdy ;
   output 	       not_full ;
   
   reg [dwidth-1:0]    fmem [size-1:0];
   reg [pwidth-1:0]    wr_ptr ;
   reg [pwidth-1:0]    rd_ptr;
   reg [swidth-1:0]    cnt ;
   reg 		       not_empty ;
   reg 		       not_full ;

   wire 	       rdy = not_empty ;
   
   reg [dwidth-1:0]    dout ;

   always @(posedge clk)
     dout <= fmem[rd_ptr];

   always @(cnt or push or pop)
     begin
	not_empty = 0 ;
	if ( cnt != 0 | push)
	  not_empty = 1;

	if (cnt == 1 & pop)
	  not_empty = 0 ;

	not_full = 0;
	if (cnt != size | pop)
	  not_full = 1 ;

	if (cnt == size-1 & push)
	    not_full = 0;
     end
   
   always @(posedge clk or posedge reset)
     if (reset == 1'b1)
       begin
	  wr_ptr <= 0;
	  rd_ptr <= 0;
	  cnt <= 0;
       end
     else
       begin
	  if ( push )
	    begin
	       fmem[wr_ptr] <= din ;
	       wr_ptr <= wr_ptr+1 ;
	    end

	  if ( pop )
	    begin
	       rd_ptr <= rd_ptr+1 ;
	    end

	  case ({push,pop})
	    2'b00: cnt <= cnt ;
	    2'b01: cnt <= cnt-1;
	    2'b10: cnt <= cnt+1;
	    2'b11: cnt <= cnt;
	  endcase // case({push,pop})
       end
   
endmodule // rel_fifo


   
