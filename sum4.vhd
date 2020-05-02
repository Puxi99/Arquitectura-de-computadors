library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sum4 is
	Port (
		Entrada : in  std_logic_vector (31 downto 0);
		Sortida : out  std_logic_vector (31 downto 0) 
	);
end sum4;

architecture Behavioral of sum4 is

begin
  Sortida <= Entrada + x"0000004";
end Behavioral;