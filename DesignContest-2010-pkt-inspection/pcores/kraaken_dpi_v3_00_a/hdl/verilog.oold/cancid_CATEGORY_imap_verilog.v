`timescale 1ns/1ps

module cancid_CATEGORY_imap_verilog (
   // Outputs
   count, fired ,
   // Inputs
   clk, rst_n, eop, char_in, enable, char_in_vld, stream_id, new_stream_id,load_state
   );

   // The clock and reset info.
    input clk, rst_n;

   input  eop ;
   input load_state ;

    // Input character, and state, if being set.
   input [7:0] char_in;

   input       enable ;
   
    // char_in_vld should be true if there's a character to process.
    // state_in_vld should be true if the outside world is overwriting our state.
    input char_in_vld ;
   
   input [5:0] stream_id ;
   input       new_stream_id ;
   
   output [15:0] count ;
   output 	 fired ;

   wire 	 fired ;

   //Memory
   reg [10:0] state_mem [0:63] ;

   reg 	     state_in_vld;
   reg [10:0] state_in ;

   reg [15:0] count ;
   reg [15:0] speculative_match ;   
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			accept_out;		// From regex of regex_category_finger.v
   wire [10:0]		state_out;		// From regex of regex_category_finger.v
   // End of automatics

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   // End of automatics

   assign 	 fired = speculative_match ;
   
   always @(posedge clk)
     if (~rst_n)
       begin
	  count <= 0;
	  speculative_match <= 0;
       end	  
     else
       begin
	  //Reset speculative match flag at start of every pkt
	  if ( load_state )
            speculative_match <= 0;

	  //For every match increment a speculative match
	  if ( accept_out ) 
	    speculative_match <= 1;

	  //At EOP finalize counts, if regex matcher is enabled
	  //update count and save state
	  if ( eop )
	    begin
	       if ( enable )
		 begin
		    //This regex is enabled for this stream id
		    count <= count + speculative_match ;
		    state_mem[stream_id] <= state_out ;
		 end
	       else
		 //regex not enabled for this count
		 //no need to reset state, because at the start
		 //old state for this stream id loaded
		 speculative_match <= 0;
	    end // if ( eop )
	  
       end

   //State save and restore
   //For a new stream id reset, else load old state
   always @(posedge clk)
       begin
	  state_in_vld <= 0;
	
	if ( load_state )
	 begin	
	   //If StreamID not recognized
	   if ( new_stream_id )
	     begin
	       state_in <= 0;
	       state_in_vld <= 1;
	     end	
	   else	    
	     begin
	       state_in <= state_mem[stream_id];
	       state_in_vld <= 1;
	     end
          end
       end
CATEGORY_imap_verilog CATEGORY_imap_verilog_i (
				 // Outputs
				 .state_out(state_out[10:0]),
				 .accept_out(accept_out),
				 // Inputs
				 .clk	(clk),
				 .rst_n	(rst_n),
				 .char_in(char_in[7:0]),
				 .state_in(state_in[10:0]),
				 .char_in_vld(char_in_vld),
				 .state_in_vld(state_in_vld));
endmodule
