`timescale 1ns/1ns

`define init   3'd0
`define stage1 3'd1
`define stage2 3'd2
`define stage3 3'd3
`define stage4 3'd4
`define stage5 3'd5
`define stage6 3'd6
`define stage7 3'd7

module huffman_encode ( /*AUTOARG*/
   // Outputs
   odata, push, pop,
   // Inputs
   code, rdy, not_full, clk, reset
   ) ;

   parameter c_width = 4 ;//fixed length code width
   
   parameter vlc_width=5  ; //max variable length code width 
   parameter vlcz_width=5 ; //code size width
   
   parameter p_width=32 ; //packed data width 
   parameter p_width_msb=31 ; //packed data width
   
   parameter EOM = 5'b11111 ;
   parameter EOM_LENGTH = 4 ;//code length - 1
   
   input [3:0] code ;
   input 		rdy;
   input 		not_full ;
   input 		clk,reset ;
   
   output [p_width-1:0] odata ;//packed output data
   output 		push;
   output 		pop ;

   reg [vlc_width-1:0] 	cdata_rd ; //incoming code
   reg [vlcz_width-1:0] ldata_rd ; //incoming code length
   reg [vlc_width-1:0] 	cdata_wd ; //incoming code
   reg [vlcz_width-1:0] ldata_wd ; //incoming code length   

   reg [p_width-1:0] odata_wd ;//packed output data
   reg [p_width-1:0] odata_rd ;//packed output data

   reg [p_width-1:0] odata ;
   
   // //    
   reg 			push_rc;
   reg 			pop_rc ;
   reg 			push_wc;
   reg 			pop_wc ;   

   reg [p_width*2-1:0] 	pdata_rd ;//packed data register
   reg [p_width*2-1:0] 	pdata_wd ;//packed data register
   //    
   reg [vlcz_width:0] 	plsb_bit_rc ;//lsb start bit in packed data reg
   reg [vlcz_width:0] 	plsb_bit_wc ;//lsb start bit in packed data reg   

   
   reg [p_width*2-1:0] 	cdata_shift_rd ;
   reg [p_width-1:0] shift_mult_result_rd ;
   reg [p_width*2-1:0] 	cdata_shift_wd ;
   reg [p_width-1:0] shift_mult_result_wd ;   
   
   wire 		push = push_rc ;
   wire 		pop = pop_rc ;

   reg 			eom_detected_wc , eom_detected_rc ;
   reg [2:0] fsm_cs, fsm_ns;

   reg push_pending_wc,push_pending_rc,
       push_eom_pending_wc,push_eom_pending_rc;
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
	  pop_rc <= 0;
	  fsm_cs <= `init ;
	  push_rc <= 0;
	  plsb_bit_rc <= 0;
	  odata_rd <= 0;
	  pdata_rd <= 0;
	  eom_detected_rc <= 0;
	  push_pending_rc <= 0;
	  push_eom_pending_rc <= 0;
       end
     else
       begin
	  fsm_cs <= fsm_ns ;
	  pop_rc <= pop_wc ;
	  cdata_rd <= cdata_wd ;
	  ldata_rd <= ldata_wd ;
	  shift_mult_result_rd <= shift_mult_result_wd ;

	  cdata_shift_rd  <= cdata_shift_wd ;
	  push_rc <= push_wc ;
	  odata_rd <= odata_wd ;
	  plsb_bit_rc <= plsb_bit_wc ;
	  pdata_rd <= pdata_wd ;
	  eom_detected_rc <= eom_detected_wc ;

	  push_pending_rc <= push_pending_wc ;
	  push_eom_pending_rc <= push_eom_pending_wc;	  
       end

   integer i ;
   
   always @(/*autosense*/
	    cdata_rd
	    or cdata_shift_rd or code or eom_detected_rc or fsm_cs
	    or ldata_rd or not_full or odata_rd or pdata_rd
	    or plsb_bit_rc or push_eom_pending_rc or push_pending_rc
	    or rdy or shift_mult_result_rd)
     begin
	
	fsm_ns = fsm_cs ;
	pop_wc = 0;
	push_wc = 0;
	
	//Hold values
	cdata_wd = cdata_rd ;
	ldata_wd = ldata_rd ;
	shift_mult_result_wd = shift_mult_result_rd;

	cdata_shift_wd = cdata_shift_rd ;
	odata_wd = odata_rd ;
	pdata_wd = pdata_rd;
	plsb_bit_wc = plsb_bit_rc ;
	eom_detected_wc = eom_detected_rc ;

	push_pending_wc = push_pending_rc ;
	push_eom_pending_wc = push_eom_pending_rc;
	
	//Swizzle output data
	for (i=0;i<=31;i=i+1)
	  odata[i] = odata_rd[31-i];
	
	case ( fsm_cs )

	  `init:
	    if ( rdy & not_full )
	      begin
//		 push_pending_wc = 0;
		 fsm_ns = `stage1 ;
		 pop_wc = 1 ;
	      end

	  `stage1:
	    begin
	       cdata_wd = huffman_code_swizzled(code);
	       ldata_wd = huffman_code_length(code) - 1'b1;
	       shift_mult_result_wd = shift_mult_operand( plsb_bit_rc ) ;
	       fsm_ns = `stage2 ;
	    end

	  `stage2:
	    begin
	       eom_detected_wc = ( cdata_rd == EOM ) & ( ldata_rd == EOM_LENGTH ) ;
	       plsb_bit_wc = plsb_bit_rc + ldata_rd + 1'b1 ;
	       cdata_shift_wd = cdata_rd * shift_mult_result_rd ;
	       fsm_ns = `stage3 ;
	    end

	  `stage3:
	    begin
	       pdata_wd =  pdata_rd | cdata_shift_rd ;
	       fsm_ns = `stage4 ;
	    end	  

	  `stage4:
	    begin
	       if ( plsb_bit_rc >= p_width )
		 begin
		    push_pending_wc =1 ;
		    odata_wd = pdata_rd[p_width-1:0];
		    pdata_wd = { 32'h0 , pdata_rd[p_width*2-1:p_width] };
		    plsb_bit_wc = plsb_bit_rc - p_width ;
		 end
	       else
		 begin
		    pdata_wd = pdata_rd ;
		    plsb_bit_wc = plsb_bit_rc;
		 end // else: !if( plsb_bit_wc >= p_width )

	       if (eom_detected_rc && plsb_bit_wc != 0)
		 push_eom_pending_wc = 1;

	       case ( {not_full,push_eom_pending_wc,push_pending_wc} )
		 3'b100:fsm_ns=`init;
		 3'b000:fsm_ns=`init;		 
		 3'b101:
		   begin
		      push_wc = 1;
		      push_pending_wc = 0;		      
		      fsm_ns = `init ;
		   end

		 3'b111:
		   begin
		    push_wc = 1;
		    fsm_ns = `stage6 ;
		   end		 		 
		 3'b011: fsm_ns = `stage5 ;
		 
		 3'b001: fsm_ns = `stage5;
		 3'b010: fsm_ns = `stage6 ;
		 3'b110: fsm_ns = `stage6 ;
	       endcase // case ( {not_full,push_eom_pending_wc,push_pending_wc} )
	    end // case: `stage4

	  `stage5:
	    begin
	       if (not_full)
		 begin
		    push_wc = 1;
		    push_pending_wc = 0;

		    if ( push_eom_pending_rc )
		      fsm_ns = `stage6 ;
		    else
		      fsm_ns = `init;
		 end
	    end
	  
	  `stage6:
	    begin
	       push_pending_wc = 0;
	       eom_detected_wc = 0;
	       plsb_bit_wc     = 0;
	       pdata_wd        = 0;
	       odata_wd        = pdata_rd[p_width-1:0];
	       fsm_ns          = `stage7 ;
	    end

	  `stage7:
	    begin
	       if ( not_full )
		 begin
		    push_wc = 1 ;
		    push_eom_pending_wc = 0;
		    fsm_ns  = `init;
		 end
	    end
	  
	  default:fsm_ns = `init ;
	  
	endcase // case ( fsm_cs )
     end
   
   function [p_width-1:0] shift_mult_operand ;
      input [vlcz_width-1:0] ival ;
      begin
	 if ( ival )
	   shift_mult_operand = 1 << ival ;
	 else
	   shift_mult_operand = 1 ;	   
      end
   endfunction // shift_mult_operand

   function [vlc_width-1:0] huffman_code ;
      input [c_width-1:0] code ;
      begin
	 case(code)
	   0:huffman_code = 3'b100;//A
	   1:huffman_code = 5'b11110;//B
	   2:huffman_code = 4'b1100;//C
	   3:huffman_code = 3'b101;//D
	   4:huffman_code = 2'b00;//E
	   5:huffman_code = 4'b1101;//F
	   6:huffman_code = 4'b1110;//G
	   7:huffman_code = 2'b01;//H
	   8:huffman_code = 5'b11111;//EOS-End Of Stream
	   default: huffman_code = 5'bx ;
	 endcase // case (code)
      end
   endfunction // huffman_code

   function [vlc_width-1:0] huffman_code_swizzled ;
      input [c_width-1:0] code ;
      begin
	 case(code)
	   0:huffman_code_swizzled = 3'b001;//A
	   1:huffman_code_swizzled = 5'b01111;//B
	   2:huffman_code_swizzled = 4'b0011;//C
	   3:huffman_code_swizzled = 3'b101;//D
	   4:huffman_code_swizzled = 2'b00;//E
	   5:huffman_code_swizzled = 4'b1011;//F
	   6:huffman_code_swizzled = 4'b0111;//G
	   7:huffman_code_swizzled = 2'b10;//H
	   8:huffman_code_swizzled = 5'b11111;//EOS-End Of Stream
	   default: huffman_code_swizzled = 5'bx ;
	 endcase // case (code)
      end
   endfunction // huffman_code
   
   function [vlcz_width-1:0] huffman_code_length ;
      input [c_width-1:0] code ;
      begin
	 case(code)
	   0:huffman_code_length = 3;//A
	   1:huffman_code_length = 5;//B
	   2:huffman_code_length = 4;//C
	   3:huffman_code_length = 3;//D
	   4:huffman_code_length = 2;//E
	   5:huffman_code_length = 4;//F
	   6:huffman_code_length = 4;//G
	   7:huffman_code_length = 2;//H
	   8:huffman_code_length = 5;//EOS-End Of Stream
	   default: huffman_code_length = 3'bx ;
	 endcase // case (code)
      end      
   endfunction   
			  
endmodule // huffman_encode
