library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity UnitatControl is
Port (Reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		co : in STD_LOGIC_VECTOR (5 downto 0);
		IRWrite : out STD_LOGIC;
		MemRead : out STD_LOGIC;
		MemWrite : out STD_LOGIC;
		PCWriteCond : out STD_LOGIC;
		PCWrite : out STD_LOGIC;
		RegWrite : out STD_LOGIC;
		RegDst : out STD_LOGIC;
		MemtoReg : out STD_LOGIC;
		ALUSrcA : out STD_LOGIC;
		ALUSrcB : out STD_LOGIC;
		ALUOp : out STD_LOGIC_VECTOR (1 downto 0)	);
	end UnitatControl;


architecture Behavioral of UnitatControl is
	type Tipus_Estats is (E0, E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, Error);
	signal Estat: Tipus_Estats;
begin
transicions: process (clk)
	begin
	if falling_edge(clk) then
		if (reset = '1') then
			Estat <= E0;
		else
		case Estat is
			when E0 => Estat <= E1;
			when E1 => Estat <= E2;
			when E2 => 	if ((co = "100011") OR (co = "101011")) then 
								Estat <= E3;
							elsif (co = "000101") then
								Estat <= E9;
							elsif (co = "000000") then
								Estat <= E7;
							elsif (co = "001000") then
								Estat <= E11;
							else
								Estat <= Error;
							end if;
			when E3 =>	if (co = "100011") then
								Estat <= E4;
							else
								Estat <= E6;
							end if;
			when E7 => Estat <= E8;
			when E11 => Estat <= E12;
			when E4 => Estat <= E5;
			when E9 => Estat <= E10;
			when E5 => Estat <= E1;
			when E6 => Estat <= E1;
			when E10 => Estat <= E1;
			when E8 => Estat <= E1;
			when E12 => Estat <= E1;
			when Error => Estat <= E0;
		end case;
		end if;
	end if;
end process;


sortides: process (Estat)
	begin
	case Estat is
		when E0 => 	IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";
		
		when E1 => 	IRWrite <= '1';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";
		
		when E2 => 	IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";
		
		when E3 => 	IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '1';
						ALUSrcB <= '1';
						ALUOp <= "00";
		
		when E4 => 	IRWrite <= '0';
						MemRead <= '1';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";
		
		when E5 => 	IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '1';
						RegWrite <= '1';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";		
						
		when E6 => 	IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '1';
						PCWriteCond <= '0';
						PCWrite <= '1';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";
						
		when E7 => 	IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '1';
						ALUSrcB <= '0';
						ALUOp <= "10";
						
		when E8 => 	IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '1';
						RegWrite <= '1';
						RegDst <= '1';
						MemtoReg <= '1';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";
		
		when E9 => 	IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '0';
						ALUSrcB <= '1';
						ALUOp <= "00";
		
		when E10 => IRWrite <= '0'; 
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '1';
						PCWrite <= '1';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '1';
						ALUSrcB <= '0';
						ALUOp <= "01";
						
		when E11 => IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '1';
						ALUSrcB <= '1';
						ALUOp <= "00";
						
		when E12 => IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '1';
						RegWrite <= '1';
						RegDst <= '0';
						MemtoReg <= '1';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";
			
		when others =>
						IRWrite <= '0';
						MemRead <= '0';
						MemWrite <= '0';
						PCWriteCond <= '0';
						PCWrite <= '0';
						RegWrite <= '0';
						RegDst <= '0';
						MemtoReg <= '0';
						ALUSrcA <= '0';
						ALUSrcB <= '0';
						ALUOp <= "00";
							
	end case;
end process;
end Behavioral;