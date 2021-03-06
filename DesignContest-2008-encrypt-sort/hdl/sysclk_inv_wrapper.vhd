-------------------------------------------------------------------------------
-- sysclk_inv_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library util_vector_logic_v1_00_a;
use util_vector_logic_v1_00_a.all;

entity sysclk_inv_wrapper is
  port (
    Op1 : in std_logic_vector(0 to 0);
    Op2 : in std_logic_vector(0 to 0);
    Res : out std_logic_vector(0 to 0)
  );
  attribute x_core_info : STRING;
  attribute x_core_info of sysclk_inv_wrapper: entity is "util_vector_logic_v1_00_a";

end sysclk_inv_wrapper;

architecture STRUCTURE of sysclk_inv_wrapper is

  component util_vector_logic is
    generic (
      C_OPERATION : string;
      C_SIZE : INTEGER
    );
    port (
      Op1 : in std_logic_vector(0 to C_SIZE-1);
      Op2 : in std_logic_vector(0 to C_SIZE-1);
      Res : out std_logic_vector(0 to C_SIZE-1)
    );
  end component;

begin

  sysclk_inv : util_vector_logic
    generic map (
      C_OPERATION => "not",
      C_SIZE => 1
    )
    port map (
      Op1 => Op1,
      Op2 => Op2,
      Res => Res
    );

end architecture STRUCTURE;

