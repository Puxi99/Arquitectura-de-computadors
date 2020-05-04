library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;



entity SALT is
    port(
        Zero: in std_logic;
        PCWriteCond: in std_logic;
        Sel: out std_logic);
end SALT;

        
architecture arch of SALT is
    Sel<= NOT(Zero) AND & PCWriteCond;
end architecture;