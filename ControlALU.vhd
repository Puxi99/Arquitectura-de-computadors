library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity ControlALU is
  Port ( funcio : in STD_LOGIC_VECTOR (5 downto 0);
         ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
         Control_ALU : out STD_LOGIC_VECTOR (2 downto 0));
end ControlALU;

architecture arch of ControlALU is
begin
  process (ALUOp,funcio) is
  begin
    case ALUOp is
      when "10" =>
			   case funcio is
					when "100000" => Control_ALU <= "010";
			      when "100010" => Control_ALU <= "110";
               when "100100" => Control_ALU <= "000";
			      when "100101" => Control_ALU <= "001";
					when others => Control_ALU <= "---";
					end case;
      
		when "00" => Control_ALU <= "010";
      when "01" => Control_ALU <= "110";
      when "11" => Control_ALU <= "111";
		when others=> Control_ALU<= "---";
    end case;
  end process;
end arch;

                         
                         
     
      
      
