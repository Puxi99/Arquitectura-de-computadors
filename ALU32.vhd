library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity ALU32 is
  Port(
    Op1,Op2: in STD_LOGIC_VECTOR (31 downto 0);
    Control_ALU: in STD_LOGIC_VECTOR (2 downto 0);
    Resultat: out STD_LOGIC_VECTOR (31 downto 0);
    Z: out STD_LOGIC;
    C: out STD_LOGIC);
end ALU32;

architecture arch of ALU32 is
  signal oper1: STD_LOGIC_VECTOR(32 downto 0);
  signal oper2: STD_LOGIC_VECTOR(32 downto 0);
  signal result: STD_LOGIC_VECTOR(32 downto 0);

  begin
  process (Control_ALU,Op1,Op2) is
    
    begin 
      case Control_ALU is
        when "000" => result <= ('0' & Op1) and ('0' & Op2);
		  
        when "001" => result <= ('0' & Op1) or ('0' & Op2);
                      
        when "010" => result <= ('0' & Op1) + ('0' & Op2);
                      
        when "110" => result <= ('0' & Op1) - ('0' & Op2);
                      
        when "111" => if Op1 < Op2 then
                        result <= (others =>'0');
								result(0)<='1';
                      else
                        result <= (others =>'0');
                      end if;
	     when others => result<=(others=>'0');
        end case;
    end process;
	 Z<= '1' when result(31 downto 0)= x"00000000" else '0';
	 C<= '1' when result(32) = '1' else '0';
	 Resultat <= result(31 downto 0);
end arch;
                
