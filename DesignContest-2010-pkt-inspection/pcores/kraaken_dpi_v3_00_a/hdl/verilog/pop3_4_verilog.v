`timescale 1ns/1ps

`define ENABLED_REGEX_pop3_4 TRUE

module pop3_4_verilog(clk,
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


`ifdef ENABLED_REGEX_pop3_4

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd5;
    1: charMap = 8'd5;
    2: charMap = 8'd5;
    3: charMap = 8'd5;
    4: charMap = 8'd5;
    5: charMap = 8'd5;
    6: charMap = 8'd5;
    7: charMap = 8'd5;
    8: charMap = 8'd5;
    9: charMap = 8'd6;
    10: charMap = 8'd4;
    11: charMap = 8'd6;
    12: charMap = 8'd5;
    13: charMap = 8'd6;
    14: charMap = 8'd5;
    15: charMap = 8'd5;
    16: charMap = 8'd5;
    17: charMap = 8'd5;
    18: charMap = 8'd5;
    19: charMap = 8'd5;
    20: charMap = 8'd5;
    21: charMap = 8'd5;
    22: charMap = 8'd5;
    23: charMap = 8'd5;
    24: charMap = 8'd5;
    25: charMap = 8'd5;
    26: charMap = 8'd5;
    27: charMap = 8'd5;
    28: charMap = 8'd5;
    29: charMap = 8'd5;
    30: charMap = 8'd5;
    31: charMap = 8'd5;
    32: charMap = 8'd6;
    33: charMap = 8'd5;
    34: charMap = 8'd5;
    35: charMap = 8'd5;
    36: charMap = 8'd5;
    37: charMap = 8'd5;
    38: charMap = 8'd5;
    39: charMap = 8'd5;
    40: charMap = 8'd5;
    41: charMap = 8'd5;
    42: charMap = 8'd5;
    43: charMap = 8'd5;
    44: charMap = 8'd5;
    45: charMap = 8'd5;
    46: charMap = 8'd5;
    47: charMap = 8'd5;
    48: charMap = 8'd5;
    49: charMap = 8'd5;
    50: charMap = 8'd5;
    51: charMap = 8'd5;
    52: charMap = 8'd5;
    53: charMap = 8'd5;
    54: charMap = 8'd5;
    55: charMap = 8'd5;
    56: charMap = 8'd5;
    57: charMap = 8'd5;
    58: charMap = 8'd5;
    59: charMap = 8'd5;
    60: charMap = 8'd5;
    61: charMap = 8'd5;
    62: charMap = 8'd5;
    63: charMap = 8'd5;
    64: charMap = 8'd5;
    65: charMap = 8'd5;
    66: charMap = 8'd5;
    67: charMap = 8'd5;
    68: charMap = 8'd5;
    69: charMap = 8'd5;
    70: charMap = 8'd5;
    71: charMap = 8'd5;
    72: charMap = 8'd5;
    73: charMap = 8'd5;
    74: charMap = 8'd5;
    75: charMap = 8'd5;
    76: charMap = 8'd5;
    77: charMap = 8'd5;
    78: charMap = 8'd5;
    79: charMap = 8'd2;
    80: charMap = 8'd3;
    81: charMap = 8'd5;
    82: charMap = 8'd5;
    83: charMap = 8'd5;
    84: charMap = 8'd1;
    85: charMap = 8'd5;
    86: charMap = 8'd5;
    87: charMap = 8'd5;
    88: charMap = 8'd5;
    89: charMap = 8'd5;
    90: charMap = 8'd5;
    91: charMap = 8'd5;
    92: charMap = 8'd5;
    93: charMap = 8'd5;
    94: charMap = 8'd5;
    95: charMap = 8'd5;
    96: charMap = 8'd5;
    97: charMap = 8'd5;
    98: charMap = 8'd5;
    99: charMap = 8'd5;
    100: charMap = 8'd5;
    101: charMap = 8'd5;
    102: charMap = 8'd5;
    103: charMap = 8'd5;
    104: charMap = 8'd5;
    105: charMap = 8'd5;
    106: charMap = 8'd5;
    107: charMap = 8'd5;
    108: charMap = 8'd5;
    109: charMap = 8'd5;
    110: charMap = 8'd5;
    111: charMap = 8'd2;
    112: charMap = 8'd3;
    113: charMap = 8'd5;
    114: charMap = 8'd5;
    115: charMap = 8'd5;
    116: charMap = 8'd1;
    117: charMap = 8'd5;
    118: charMap = 8'd5;
    119: charMap = 8'd5;
    120: charMap = 8'd5;
    121: charMap = 8'd5;
    122: charMap = 8'd5;
    123: charMap = 8'd5;
    124: charMap = 8'd5;
    125: charMap = 8'd5;
    126: charMap = 8'd5;
    127: charMap = 8'd5;
    128: charMap = 8'd5;
    129: charMap = 8'd5;
    130: charMap = 8'd5;
    131: charMap = 8'd5;
    132: charMap = 8'd5;
    133: charMap = 8'd5;
    134: charMap = 8'd5;
    135: charMap = 8'd5;
    136: charMap = 8'd5;
    137: charMap = 8'd5;
    138: charMap = 8'd5;
    139: charMap = 8'd5;
    140: charMap = 8'd5;
    141: charMap = 8'd5;
    142: charMap = 8'd5;
    143: charMap = 8'd5;
    144: charMap = 8'd5;
    145: charMap = 8'd5;
    146: charMap = 8'd5;
    147: charMap = 8'd5;
    148: charMap = 8'd5;
    149: charMap = 8'd5;
    150: charMap = 8'd5;
    151: charMap = 8'd5;
    152: charMap = 8'd5;
    153: charMap = 8'd5;
    154: charMap = 8'd5;
    155: charMap = 8'd5;
    156: charMap = 8'd5;
    157: charMap = 8'd5;
    158: charMap = 8'd5;
    159: charMap = 8'd5;
    160: charMap = 8'd5;
    161: charMap = 8'd5;
    162: charMap = 8'd5;
    163: charMap = 8'd5;
    164: charMap = 8'd5;
    165: charMap = 8'd5;
    166: charMap = 8'd5;
    167: charMap = 8'd5;
    168: charMap = 8'd5;
    169: charMap = 8'd5;
    170: charMap = 8'd5;
    171: charMap = 8'd5;
    172: charMap = 8'd5;
    173: charMap = 8'd5;
    174: charMap = 8'd5;
    175: charMap = 8'd5;
    176: charMap = 8'd5;
    177: charMap = 8'd5;
    178: charMap = 8'd5;
    179: charMap = 8'd5;
    180: charMap = 8'd5;
    181: charMap = 8'd5;
    182: charMap = 8'd5;
    183: charMap = 8'd5;
    184: charMap = 8'd5;
    185: charMap = 8'd5;
    186: charMap = 8'd5;
    187: charMap = 8'd5;
    188: charMap = 8'd5;
    189: charMap = 8'd5;
    190: charMap = 8'd5;
    191: charMap = 8'd5;
    192: charMap = 8'd5;
    193: charMap = 8'd5;
    194: charMap = 8'd5;
    195: charMap = 8'd5;
    196: charMap = 8'd5;
    197: charMap = 8'd5;
    198: charMap = 8'd5;
    199: charMap = 8'd5;
    200: charMap = 8'd5;
    201: charMap = 8'd5;
    202: charMap = 8'd5;
    203: charMap = 8'd5;
    204: charMap = 8'd5;
    205: charMap = 8'd5;
    206: charMap = 8'd5;
    207: charMap = 8'd5;
    208: charMap = 8'd5;
    209: charMap = 8'd5;
    210: charMap = 8'd5;
    211: charMap = 8'd5;
    212: charMap = 8'd5;
    213: charMap = 8'd5;
    214: charMap = 8'd5;
    215: charMap = 8'd5;
    216: charMap = 8'd5;
    217: charMap = 8'd5;
    218: charMap = 8'd5;
    219: charMap = 8'd5;
    220: charMap = 8'd5;
    221: charMap = 8'd5;
    222: charMap = 8'd5;
    223: charMap = 8'd5;
    224: charMap = 8'd5;
    225: charMap = 8'd5;
    226: charMap = 8'd5;
    227: charMap = 8'd5;
    228: charMap = 8'd5;
    229: charMap = 8'd5;
    230: charMap = 8'd5;
    231: charMap = 8'd5;
    232: charMap = 8'd5;
    233: charMap = 8'd5;
    234: charMap = 8'd5;
    235: charMap = 8'd5;
    236: charMap = 8'd5;
    237: charMap = 8'd5;
    238: charMap = 8'd5;
    239: charMap = 8'd5;
    240: charMap = 8'd5;
    241: charMap = 8'd5;
    242: charMap = 8'd5;
    243: charMap = 8'd5;
    244: charMap = 8'd5;
    245: charMap = 8'd5;
    246: charMap = 8'd5;
    247: charMap = 8'd5;
    248: charMap = 8'd5;
    249: charMap = 8'd5;
    250: charMap = 8'd5;
    251: charMap = 8'd5;
    252: charMap = 8'd5;
    253: charMap = 8'd5;
    254: charMap = 8'd5;
    255: charMap = 8'd5;
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
    10: stateMap = 11'd9;
    11: stateMap = 11'd10;
    12: stateMap = 11'd11;
    13: stateMap = 11'd12;
    14: stateMap = 11'd13;
    15: stateMap = 11'd14;
    16: stateMap = 11'd15;
    17: stateMap = 11'd16;
    18: stateMap = 11'd17;
    19: stateMap = 11'd18;
    20: stateMap = 11'd19;
    21: stateMap = 11'd20;
    22: stateMap = 11'd21;
    23: stateMap = 11'd22;
    24: stateMap = 11'd23;
    25: stateMap = 11'd24;
    26: stateMap = 11'd25;
    27: stateMap = 11'd26;
    28: stateMap = 11'd27;
    29: stateMap = 11'd28;
    30: stateMap = 11'd29;
    31: stateMap = 11'd30;
    32: stateMap = 11'd31;
    33: stateMap = 11'd32;
    34: stateMap = 11'd33;
    35: stateMap = 11'd34;
    36: stateMap = 11'd35;
    37: stateMap = 11'd36;
    38: stateMap = 11'd37;
    39: stateMap = 11'd38;
    40: stateMap = 11'd39;
    41: stateMap = 11'd40;
    42: stateMap = 11'd41;
    43: stateMap = 11'd42;
    44: stateMap = 11'd43;
    45: stateMap = 11'd44;
    46: stateMap = 11'd45;
    47: stateMap = 11'd46;
    48: stateMap = 11'd47;
    49: stateMap = 11'd48;
    50: stateMap = 11'd49;
    51: stateMap = 11'd50;
    52: stateMap = 11'd51;
    53: stateMap = 11'd52;
    54: stateMap = 11'd53;
    55: stateMap = 11'd54;
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
    10: acceptStates = 1'b0;
    11: acceptStates = 1'b0;
    12: acceptStates = 1'b0;
    13: acceptStates = 1'b0;
    14: acceptStates = 1'b0;
    15: acceptStates = 1'b0;
    16: acceptStates = 1'b0;
    17: acceptStates = 1'b0;
    18: acceptStates = 1'b0;
    19: acceptStates = 1'b0;
    20: acceptStates = 1'b0;
    21: acceptStates = 1'b0;
    22: acceptStates = 1'b0;
    23: acceptStates = 1'b0;
    24: acceptStates = 1'b0;
    25: acceptStates = 1'b0;
    26: acceptStates = 1'b0;
    27: acceptStates = 1'b0;
    28: acceptStates = 1'b0;
    29: acceptStates = 1'b0;
    30: acceptStates = 1'b0;
    31: acceptStates = 1'b0;
    32: acceptStates = 1'b0;
    33: acceptStates = 1'b0;
    34: acceptStates = 1'b0;
    35: acceptStates = 1'b0;
    36: acceptStates = 1'b0;
    37: acceptStates = 1'b0;
    38: acceptStates = 1'b0;
    39: acceptStates = 1'b0;
    40: acceptStates = 1'b0;
    41: acceptStates = 1'b0;
    42: acceptStates = 1'b0;
    43: acceptStates = 1'b0;
    44: acceptStates = 1'b0;
    45: acceptStates = 1'b0;
    46: acceptStates = 1'b0;
    47: acceptStates = 1'b0;
    48: acceptStates = 1'b0;
    49: acceptStates = 1'b0;
    50: acceptStates = 1'b0;
    51: acceptStates = 1'b0;
    52: acceptStates = 1'b0;
    53: acceptStates = 1'b0;
    54: acceptStates = 1'b0;
    55: acceptStates = 1'b0;
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
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd6;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd6;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd55;
      2: stateTransition = 11'd55;
      3: stateTransition = 11'd55;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd55;
      6: stateTransition = 11'd55;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd2;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd2;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd2;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd7;
      2: stateTransition = 11'd7;
      3: stateTransition = 11'd7;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd7;
      6: stateTransition = 11'd7;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd8;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd8;
      6: stateTransition = 11'd8;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd9;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd9;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd9;
      6: stateTransition = 11'd9;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd10;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd10;
      6: stateTransition = 11'd10;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd11;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd11;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd11;
      6: stateTransition = 11'd11;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd12;
      2: stateTransition = 11'd12;
      3: stateTransition = 11'd12;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd12;
      6: stateTransition = 11'd12;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd13;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd13;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd13;
      6: stateTransition = 11'd13;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd15;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd15;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd15;
      6: stateTransition = 11'd15;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd16;
      6: stateTransition = 11'd16;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd17;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd17;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd17;
      6: stateTransition = 11'd17;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd18;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd18;
      6: stateTransition = 11'd18;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd19;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd19;
      6: stateTransition = 11'd19;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd20;
      2: stateTransition = 11'd20;
      3: stateTransition = 11'd20;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd20;
      6: stateTransition = 11'd20;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd21;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd21;
      6: stateTransition = 11'd21;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd22;
      2: stateTransition = 11'd22;
      3: stateTransition = 11'd22;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd22;
      6: stateTransition = 11'd22;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd23;
      2: stateTransition = 11'd23;
      3: stateTransition = 11'd23;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd23;
      6: stateTransition = 11'd23;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd24;
      3: stateTransition = 11'd24;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd26;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd26;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd26;
      6: stateTransition = 11'd26;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd27;
      6: stateTransition = 11'd27;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd28;
      2: stateTransition = 11'd28;
      3: stateTransition = 11'd28;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd28;
      6: stateTransition = 11'd28;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd29;
      2: stateTransition = 11'd29;
      3: stateTransition = 11'd29;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd29;
      6: stateTransition = 11'd29;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd30;
      2: stateTransition = 11'd30;
      3: stateTransition = 11'd30;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd30;
      6: stateTransition = 11'd30;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd31;
      2: stateTransition = 11'd31;
      3: stateTransition = 11'd31;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd31;
      6: stateTransition = 11'd31;
      default: stateTransition = 11'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd32;
      2: stateTransition = 11'd32;
      3: stateTransition = 11'd32;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd32;
      6: stateTransition = 11'd32;
      default: stateTransition = 11'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd33;
      2: stateTransition = 11'd33;
      3: stateTransition = 11'd33;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd33;
      6: stateTransition = 11'd33;
      default: stateTransition = 11'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd34;
      2: stateTransition = 11'd34;
      3: stateTransition = 11'd34;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd34;
      6: stateTransition = 11'd34;
      default: stateTransition = 11'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd35;
      2: stateTransition = 11'd35;
      3: stateTransition = 11'd35;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd35;
      6: stateTransition = 11'd35;
      default: stateTransition = 11'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd36;
      2: stateTransition = 11'd36;
      3: stateTransition = 11'd36;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd36;
      6: stateTransition = 11'd36;
      default: stateTransition = 11'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd37;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd37;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd37;
      6: stateTransition = 11'd37;
      default: stateTransition = 11'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd38;
      2: stateTransition = 11'd38;
      3: stateTransition = 11'd38;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd38;
      6: stateTransition = 11'd38;
      default: stateTransition = 11'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd39;
      2: stateTransition = 11'd39;
      3: stateTransition = 11'd39;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd39;
      6: stateTransition = 11'd39;
      default: stateTransition = 11'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd40;
      2: stateTransition = 11'd40;
      3: stateTransition = 11'd40;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd40;
      6: stateTransition = 11'd40;
      default: stateTransition = 11'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd41;
      2: stateTransition = 11'd41;
      3: stateTransition = 11'd41;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd41;
      6: stateTransition = 11'd41;
      default: stateTransition = 11'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd42;
      2: stateTransition = 11'd42;
      3: stateTransition = 11'd42;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd42;
      6: stateTransition = 11'd42;
      default: stateTransition = 11'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd43;
      2: stateTransition = 11'd43;
      3: stateTransition = 11'd43;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd43;
      6: stateTransition = 11'd43;
      default: stateTransition = 11'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd44;
      2: stateTransition = 11'd44;
      3: stateTransition = 11'd44;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd44;
      6: stateTransition = 11'd44;
      default: stateTransition = 11'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd45;
      2: stateTransition = 11'd45;
      3: stateTransition = 11'd45;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd45;
      6: stateTransition = 11'd45;
      default: stateTransition = 11'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd46;
      2: stateTransition = 11'd46;
      3: stateTransition = 11'd46;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd46;
      6: stateTransition = 11'd46;
      default: stateTransition = 11'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd47;
      2: stateTransition = 11'd47;
      3: stateTransition = 11'd47;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd47;
      6: stateTransition = 11'd47;
      default: stateTransition = 11'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd48;
      2: stateTransition = 11'd48;
      3: stateTransition = 11'd48;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd48;
      6: stateTransition = 11'd48;
      default: stateTransition = 11'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd49;
      2: stateTransition = 11'd49;
      3: stateTransition = 11'd49;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd49;
      6: stateTransition = 11'd49;
      default: stateTransition = 11'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd50;
      2: stateTransition = 11'd50;
      3: stateTransition = 11'd50;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd50;
      6: stateTransition = 11'd50;
      default: stateTransition = 11'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd51;
      2: stateTransition = 11'd51;
      3: stateTransition = 11'd51;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd51;
      6: stateTransition = 11'd51;
      default: stateTransition = 11'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd52;
      2: stateTransition = 11'd52;
      3: stateTransition = 11'd52;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd52;
      6: stateTransition = 11'd52;
      default: stateTransition = 11'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd53;
      2: stateTransition = 11'd53;
      3: stateTransition = 11'd53;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd53;
      6: stateTransition = 11'd53;
      default: stateTransition = 11'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd54;
      2: stateTransition = 11'd54;
      3: stateTransition = 11'd54;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd54;
      6: stateTransition = 11'd54;
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
