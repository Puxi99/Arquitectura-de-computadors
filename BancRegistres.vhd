library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BancRegistres is
  port
    ( clk : in STD_LOGIC;
      EscReg: in STD_LOGIC;
      RegL1: in STD_LOGIC_VECTOR (4 downto 0);
      RegL2: in STD_LOGIC_VECTOR (4 downto 0);
      RegE: in STD_LOGIC_VECTOR (4 downto 0);
      DadaE: in STD_LOGIC_VECTOR (31 downto 0);
      DadaL1: out STD_LOGIC_VECTOR (31 downto 0);
      DadaL2: out STD_LOGIC_VECTOR (31 downto 0));
end BancRegistres;

architecture behavior of BancRegistres is

	
    type word_array is array (integer range <>) of std_logic_vector(31 downto 0);
    signal dada: word_array(0 to 31):=(others=>x"00000000");
begin	 
process (clk,RegL1,RegL2) is
begin
    if (falling_edge(clk)) then
      if (EscReg = '1') and (RegE(4 downto 0) /= "00000") then
		dada(to_integer(unsigned(regE)))<= DadaE;
      end if;
	end if;
	DadaL1 <= dada(to_integer(unsigned(RegL1)));
   DadaL2 <= dada(to_integer(unsigned(RegL2)));
		
  end process;
end behavior;
      
