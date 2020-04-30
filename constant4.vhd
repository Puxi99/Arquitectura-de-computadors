library ieee;
use ieee.std_logic_1164.all;

entity constant4 is
	port (
		Output: out std_logic_vector(2 downto 0)
	);
end constant4;

architecture behav of constant4 is
begin
	Output <= "100";
end behav;