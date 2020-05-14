library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity memInst is
    Port ( Add : in  STD_LOGIC_VECTOR (31 downto 0);
           RD : out  STD_LOGIC_VECTOR (31 downto 0));
end memInst;


architecture Behavioral of MemInst is

type ARRAY_64 is ARRAY (0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
signal Programa: ARRAY_64 :=	(	
		
		x"00002820", -- 0
		x"8C020050", -- 1
		x"8C010054", -- 2
		x"00002020", -- 3
		x"8CA30060", -- 4
		x"14230010", -- 5
		x"AC030058", -- 6
		x"AC04005C", -- 7
		x"20010001", -- 8
		x"14200010", -- 9
		x"2042FFFF", -- 10
		x"20840001", -- 11
		x"20A50004", -- 12
		x"1440FFD8", -- 13
		x"20010001", -- 14
		x"1420FFFC", -- 15
		X"00000000", -- 16
		X"00000000", -- 17
		X"00000000", -- 18
		X"00000000", -- 19
		X"00000000", -- 20
		X"00000000", -- 21
		X"00000000", -- 22
		X"00000000", -- 23
		X"00000000", -- 24
		X"00000000", -- 25
		X"00000000", -- 26
		X"00000000", -- 27
		X"00000000", -- 28
		X"00000000", -- 29
		X"00000000", -- 30
		X"00000000", -- 31
		x"00000000", -- 32
		X"00000000", -- 33
		X"00000000", -- 34
		X"00000000", -- 35
		X"00000000", -- 36
		X"00000000", -- 37
		X"00000000", -- 38
		X"00000000", -- 39
		X"00000000", -- 40
		X"00000000", -- 41
		X"00000000", -- 42
		X"00000000", -- 43
		X"00000000", -- 44
		X"00000000", -- 45
		X"00000000", -- 46
		X"00000000", -- 47
		X"00000000", -- 48
		X"00000000", -- 49
		X"00000000", -- 50
		X"00000000", -- 51
		X"00000000", -- 52
		X"00000000", -- 53
		X"00000000", -- 54
		X"00000000", -- 55
		X"00000000", -- 56
		X"00000000", -- 57
		X"00000000", -- 58
		X"00000000", -- 59
		X"00000000", -- 60
		X"00000000", -- 61
		X"00000000", -- 62
		X"00000000"  -- 63
		);

begin

RD <= Programa(to_integer(unsigned(Add(7 downto 2))));

end Behavioral;

