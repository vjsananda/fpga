`timescale 1ns/1ps

`define ENABLED_REGEX_imap_1 TRUE

module imap_1_verilog(clk,
                    rst_n,
                    char_in,
                    char_in_vld,
                    state_in,
                    state_in_vld,
                    state_out,
                    accept_out);
   // The clock and reset info.
    input clk, rst_n;
    // Input character, and state, if being set.
    input [7:0] char_in;
    input [10:0] state_in;
    // char_in_vld should be true if there's a character to process.
    // state_in_vld should be true if the outside world is overwriting our state.
    input char_in_vld, state_in_vld;
    // state_out is our current state.
    output [10:0] state_out;
    // Accept out is true if the character triggered a regex match.
    output accept_out;
    // A register for the current state.
    reg [10:0] cur_state;


`ifdef ENABLED_REGEX_imap_1

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd7;
    1: charMap = 8'd7;
    2: charMap = 8'd7;
    3: charMap = 8'd7;
    4: charMap = 8'd7;
    5: charMap = 8'd7;
    6: charMap = 8'd7;
    7: charMap = 8'd7;
    8: charMap = 8'd7;
    9: charMap = 8'd8;
    10: charMap = 8'd1;
    11: charMap = 8'd8;
    12: charMap = 8'd7;
    13: charMap = 8'd8;
    14: charMap = 8'd7;
    15: charMap = 8'd7;
    16: charMap = 8'd7;
    17: charMap = 8'd7;
    18: charMap = 8'd7;
    19: charMap = 8'd7;
    20: charMap = 8'd7;
    21: charMap = 8'd7;
    22: charMap = 8'd7;
    23: charMap = 8'd7;
    24: charMap = 8'd7;
    25: charMap = 8'd7;
    26: charMap = 8'd7;
    27: charMap = 8'd7;
    28: charMap = 8'd7;
    29: charMap = 8'd7;
    30: charMap = 8'd7;
    31: charMap = 8'd7;
    32: charMap = 8'd8;
    33: charMap = 8'd7;
    34: charMap = 8'd7;
    35: charMap = 8'd7;
    36: charMap = 8'd7;
    37: charMap = 8'd9;
    38: charMap = 8'd7;
    39: charMap = 8'd7;
    40: charMap = 8'd7;
    41: charMap = 8'd7;
    42: charMap = 8'd7;
    43: charMap = 8'd7;
    44: charMap = 8'd7;
    45: charMap = 8'd7;
    46: charMap = 8'd7;
    47: charMap = 8'd7;
    48: charMap = 8'd7;
    49: charMap = 8'd7;
    50: charMap = 8'd7;
    51: charMap = 8'd7;
    52: charMap = 8'd7;
    53: charMap = 8'd7;
    54: charMap = 8'd7;
    55: charMap = 8'd7;
    56: charMap = 8'd7;
    57: charMap = 8'd7;
    58: charMap = 8'd7;
    59: charMap = 8'd7;
    60: charMap = 8'd7;
    61: charMap = 8'd7;
    62: charMap = 8'd7;
    63: charMap = 8'd7;
    64: charMap = 8'd7;
    65: charMap = 8'd7;
    66: charMap = 8'd7;
    67: charMap = 8'd7;
    68: charMap = 8'd7;
    69: charMap = 8'd7;
    70: charMap = 8'd7;
    71: charMap = 8'd4;
    72: charMap = 8'd7;
    73: charMap = 8'd5;
    74: charMap = 8'd7;
    75: charMap = 8'd7;
    76: charMap = 8'd2;
    77: charMap = 8'd7;
    78: charMap = 8'd6;
    79: charMap = 8'd3;
    80: charMap = 8'd7;
    81: charMap = 8'd7;
    82: charMap = 8'd7;
    83: charMap = 8'd7;
    84: charMap = 8'd7;
    85: charMap = 8'd7;
    86: charMap = 8'd7;
    87: charMap = 8'd7;
    88: charMap = 8'd7;
    89: charMap = 8'd7;
    90: charMap = 8'd7;
    91: charMap = 8'd7;
    92: charMap = 8'd7;
    93: charMap = 8'd7;
    94: charMap = 8'd7;
    95: charMap = 8'd7;
    96: charMap = 8'd7;
    97: charMap = 8'd7;
    98: charMap = 8'd7;
    99: charMap = 8'd7;
    100: charMap = 8'd7;
    101: charMap = 8'd7;
    102: charMap = 8'd7;
    103: charMap = 8'd4;
    104: charMap = 8'd7;
    105: charMap = 8'd5;
    106: charMap = 8'd7;
    107: charMap = 8'd7;
    108: charMap = 8'd2;
    109: charMap = 8'd7;
    110: charMap = 8'd6;
    111: charMap = 8'd3;
    112: charMap = 8'd7;
    113: charMap = 8'd7;
    114: charMap = 8'd7;
    115: charMap = 8'd7;
    116: charMap = 8'd7;
    117: charMap = 8'd7;
    118: charMap = 8'd7;
    119: charMap = 8'd7;
    120: charMap = 8'd7;
    121: charMap = 8'd7;
    122: charMap = 8'd7;
    123: charMap = 8'd7;
    124: charMap = 8'd7;
    125: charMap = 8'd7;
    126: charMap = 8'd7;
    127: charMap = 8'd7;
    128: charMap = 8'd7;
    129: charMap = 8'd7;
    130: charMap = 8'd7;
    131: charMap = 8'd7;
    132: charMap = 8'd7;
    133: charMap = 8'd7;
    134: charMap = 8'd7;
    135: charMap = 8'd7;
    136: charMap = 8'd7;
    137: charMap = 8'd7;
    138: charMap = 8'd7;
    139: charMap = 8'd7;
    140: charMap = 8'd7;
    141: charMap = 8'd7;
    142: charMap = 8'd7;
    143: charMap = 8'd7;
    144: charMap = 8'd7;
    145: charMap = 8'd7;
    146: charMap = 8'd7;
    147: charMap = 8'd7;
    148: charMap = 8'd7;
    149: charMap = 8'd7;
    150: charMap = 8'd7;
    151: charMap = 8'd7;
    152: charMap = 8'd7;
    153: charMap = 8'd7;
    154: charMap = 8'd7;
    155: charMap = 8'd7;
    156: charMap = 8'd7;
    157: charMap = 8'd7;
    158: charMap = 8'd7;
    159: charMap = 8'd7;
    160: charMap = 8'd7;
    161: charMap = 8'd7;
    162: charMap = 8'd7;
    163: charMap = 8'd7;
    164: charMap = 8'd7;
    165: charMap = 8'd7;
    166: charMap = 8'd7;
    167: charMap = 8'd7;
    168: charMap = 8'd7;
    169: charMap = 8'd7;
    170: charMap = 8'd7;
    171: charMap = 8'd7;
    172: charMap = 8'd7;
    173: charMap = 8'd7;
    174: charMap = 8'd7;
    175: charMap = 8'd7;
    176: charMap = 8'd7;
    177: charMap = 8'd7;
    178: charMap = 8'd7;
    179: charMap = 8'd7;
    180: charMap = 8'd7;
    181: charMap = 8'd7;
    182: charMap = 8'd7;
    183: charMap = 8'd7;
    184: charMap = 8'd7;
    185: charMap = 8'd7;
    186: charMap = 8'd7;
    187: charMap = 8'd7;
    188: charMap = 8'd7;
    189: charMap = 8'd7;
    190: charMap = 8'd7;
    191: charMap = 8'd7;
    192: charMap = 8'd7;
    193: charMap = 8'd7;
    194: charMap = 8'd7;
    195: charMap = 8'd7;
    196: charMap = 8'd7;
    197: charMap = 8'd7;
    198: charMap = 8'd7;
    199: charMap = 8'd7;
    200: charMap = 8'd7;
    201: charMap = 8'd7;
    202: charMap = 8'd7;
    203: charMap = 8'd7;
    204: charMap = 8'd7;
    205: charMap = 8'd7;
    206: charMap = 8'd7;
    207: charMap = 8'd7;
    208: charMap = 8'd7;
    209: charMap = 8'd7;
    210: charMap = 8'd7;
    211: charMap = 8'd7;
    212: charMap = 8'd7;
    213: charMap = 8'd7;
    214: charMap = 8'd7;
    215: charMap = 8'd7;
    216: charMap = 8'd7;
    217: charMap = 8'd7;
    218: charMap = 8'd7;
    219: charMap = 8'd7;
    220: charMap = 8'd7;
    221: charMap = 8'd7;
    222: charMap = 8'd7;
    223: charMap = 8'd7;
    224: charMap = 8'd7;
    225: charMap = 8'd7;
    226: charMap = 8'd7;
    227: charMap = 8'd7;
    228: charMap = 8'd7;
    229: charMap = 8'd7;
    230: charMap = 8'd7;
    231: charMap = 8'd7;
    232: charMap = 8'd7;
    233: charMap = 8'd7;
    234: charMap = 8'd7;
    235: charMap = 8'd7;
    236: charMap = 8'd7;
    237: charMap = 8'd7;
    238: charMap = 8'd7;
    239: charMap = 8'd7;
    240: charMap = 8'd7;
    241: charMap = 8'd7;
    242: charMap = 8'd7;
    243: charMap = 8'd7;
    244: charMap = 8'd7;
    245: charMap = 8'd7;
    246: charMap = 8'd7;
    247: charMap = 8'd7;
    248: charMap = 8'd7;
    249: charMap = 8'd7;
    250: charMap = 8'd7;
    251: charMap = 8'd7;
    252: charMap = 8'd7;
    253: charMap = 8'd7;
    254: charMap = 8'd7;
    255: charMap = 8'd7;
    default: charMap = 8'bX;
  endcase
end
endfunction

function [10:0] stateMap;
  input [10:0] instate;
begin
  case( instate )
    0: stateMap = 11'd0;
    1: stateMap = 11'd1;
    2: stateMap = 11'd1;
    3: stateMap = 11'd2;
    4: stateMap = 11'd3;
    5: stateMap = 11'd4;
    6: stateMap = 11'd5;
    7: stateMap = 11'd6;
    8: stateMap = 11'd7;
    9: stateMap = 11'd8;
    default: stateMap = 11'bX;
  endcase
end
endfunction

function acceptStates;
  input [10:0] instate;
begin
  case( instate )
    0: acceptStates = 1'b0;
    1: acceptStates = 1'b1;
    2: acceptStates = 1'b1;
    3: acceptStates = 1'b0;
    4: acceptStates = 1'b0;
    5: acceptStates = 1'b0;
    6: acceptStates = 1'b0;
    7: acceptStates = 1'b0;
    8: acceptStates = 1'b0;
    9: acceptStates = 1'b0;
    default: acceptStates = 1'bX;
  endcase
end
endfunction

function [10:0] stateTransition;
  input [10:0] mapped_state;
  input [7:0]  mapped_char;
begin
  case( mapped_state )
    0: case ( mapped_char ) 
      0: stateTransition = 11'd1;
      1: stateTransition = 11'd3;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd3;
      9: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    1: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    2: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd4;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd5;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd6;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd7;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd8;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd9;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd9;
      9: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd9;
      4: stateTransition = 11'd9;
      5: stateTransition = 11'd9;
      6: stateTransition = 11'd9;
      7: stateTransition = 11'd9;
      8: stateTransition = 11'd9;
      9: stateTransition = 11'd2;
      default: stateTransition = 11'bX;
    endcase
    default: stateTransition = 11'bX;
  endcase
end
endfunction

`else

function [7:0] charMap;
input [7:0] inchar;
begin
    charMap = inchar;
end
endfunction

function [10:0] stateMap;
input [10:0] instate;
begin
    stateMap = instate;
end
endfunction

function acceptStates;
    input [10:0] instate;
begin
    acceptStates = 1'b0;
end
endfunction

function [10:0] stateTransition;
    input [10:0] instate;
    input [7:0]  inchar;
begin
    stateTransition = instate;
end
endfunction

`endif

    // Invoke the DFA functions.
    wire [7:0]  mapped_char;
    wire [10:0] mapped_state, next_state;
    wire next_accept;
    assign mapped_char = charMap(char_in);
    assign mapped_state = stateMap(cur_state);
    assign next_state = stateTransition(mapped_state, mapped_char);
    assign next_accept = acceptStates(next_state);
    // Update our outputs.
    assign accept_out = state_in_vld ? 1'b0 : char_in_vld ? next_accept : 1'b0;
    assign state_out = cur_state;
    // Update our local state.
    always @(posedge clk)
    begin
       if (!rst_n)
        begin
            cur_state <= 0;
        end
        else
        begin
            if (state_in_vld)
            begin
                cur_state <= state_in;
            end
            else if (char_in_vld)
            begin
                cur_state <= next_state;
            end
        end
    end
endmodule
