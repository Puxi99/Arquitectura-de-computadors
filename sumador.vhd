library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity sumador is
	port(
		A, B: in std_logic_vector(31 downto 0);
		S: out std_logic_vector(31 downto 0)
	);
end entity sumador;

architecture behavior of sumador is
begin
	S <= A + B;
end behavior;