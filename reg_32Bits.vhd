library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_32Bits is
	Port (
		clk : in STD_LOGIC;
		Din : in  STD_LOGIC_VECTOR (31 downto 0);
		Dout : out  STD_LOGIC_VECTOR (31 downto 0) 
	); 
end reg_32Bits;

architecture Behavioral of reg_32Bits is
    signal aux: std_logic_vector(31 downto 0);
begin
	process (clk) begin
		if falling_edge(clk) then
			aux <= Din;
		end if;
	end process;
	Dout <= aux;
end Behavioral;

