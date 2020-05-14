library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memDada is
    port(
        clk, MemRead, MemWrite: in std_logic;
        Add: in std_logic_vector(7 downto 0);
        WD: in std_logic_vector(31 downto 0);
        RD: out std_logic_vector(31 downto 0)
    );
end memDada;

architecture behavior of memDada is

type byte_array is array (natural range <>) of std_logic_vector(7 downto 0);

 signal bank: byte_array(0 to 255):= (
		X"00", x"00", x"00", x"00", -- Adreça 00h
		x"00", x"00", x"00", x"00", -- Adreça 04h
		x"00", x"00", x"00", x"00", -- Adreça 08h
		x"00", x"00", x"00", x"00", -- Adreça 0Ch
		X"00", x"00", x"00", x"00", -- Adreça 10h
		x"00", x"00", x"00", x"00", -- Adreça 14h
		x"00", x"00", x"00", x"00", -- Adreça 18h
		x"00", x"00", x"00", x"00", -- Adreça 1Ch
		X"00", x"00", x"00", x"00", -- Adreça 20h
		x"00", x"00", x"00", x"00", -- Adreça 24h
		x"00", x"00", x"00", x"00", -- Adreça 28h
		x"00", x"00", x"00", x"00", -- Adreça 2Ch
		X"00", x"00", x"00", x"00", -- Adreça 30h
		x"00", x"00", x"00", x"00", -- Adreça 34h
		x"00", x"00", x"00", x"00", -- Adreça 38h
		x"00", x"00", x"00", x"00", -- Adreça 3Ch
		X"00", x"00", x"00", x"00", -- Adreça 40h
		x"00", x"00", x"00", x"00", -- Adreça 44h
		x"00", x"00", x"00", x"00", -- Adreça 48h
		x"00", x"00", x"00", x"00", -- Adreça 4Ch
		X"00", x"00", x"00", x"20", -- Adreça 50h
		x"00", x"00", x"00", x"96", -- Adreça 54h
		x"00", x"00", x"00", x"00", -- Adreça 58h
		x"00", x"00", x"00", x"00", -- Adreça 5Ch
		X"00", x"00", x"00", x"34", -- Adreça 60h
		x"00", x"00", x"00", x"67", -- Adreça 64h
		x"00", x"00", x"10", x"00", -- Adreça 68h
		X"00", x"10", x"00", x"00", -- Adreça 6Ch
		x"10", x"00", x"00", x"00", -- Adreça 70h
		x"00", x"00", x"0F", x"69", -- Adreça 74h
		x"00", x"00", x"11", x"00", -- Adreça 78h
		X"00", x"00", x"00", x"96", -- Adreça 7Ch
		x"00", x"00", x"00", x"00", -- Adreça 84h
		x"00", x"00", x"00", x"00", -- Adreça 88h
		x"00", x"00", x"00", x"00", -- Adreça 8Ch
		X"00", x"00", x"00", x"00", -- Adreça 90h
		x"00", x"00", x"00", x"00", -- Adreça 94h
		x"00", x"00", x"00", x"00", -- Adreça 98h
		x"00", x"00", x"00", x"00", -- Adreça 9Ch
		X"00", x"00", x"00", x"00", -- Adreça A0h
		x"00", x"00", x"00", x"00", -- Adreça A4h
		x"00", x"00", x"00", x"00", -- Adreça A8h
		x"00", x"00", x"00", x"00", -- Adreça ACh
		X"00", x"00", x"00", x"00", -- Adreça B0h
		x"00", x"00", x"00", x"00", -- Adreça B4h
		x"00", x"00", x"00", x"00", -- Adreça B8h
		x"00", x"00", x"00", x"00", -- Adreça BCh
		X"00", x"00", x"00", x"00", -- Adreça C0h
		x"00", x"00", x"00", x"00", -- Adreça C4h
		x"00", x"00", x"00", x"00", -- Adreça C8h
		x"00", x"00", x"00", x"00", -- Adreça CCh
		X"00", x"00", x"00", x"00", -- Adreça D0h
		x"00", x"00", x"00", x"00", -- Adreça D4h
		x"00", x"00", x"00", x"00", -- Adreça D8h
		x"00", x"00", x"00", x"00", -- Adreça DCh
		X"00", x"00", x"00", x"00", -- Adreça E0h
		x"00", x"00", x"00", x"00", -- Adreça E4h
		x"00", x"00", x"00", x"00", -- Adreça E8h
		x"00", x"00", x"00", x"00", -- Adreça ECh
		X"00", x"00", x"00", x"00", -- Adreça F0h
		x"00", x"00", x"00", x"00", -- Adreça F4h
		x"00", x"00", x"00", x"00",
		x"00", x"00", x"00", x"00",	-- Adreça F8h
		x"00", x"00", x"00", x"00");-- Adreça FCh

signal addr: integer := -1;

	 
	 
begin
	addr <= to_integer(unsigned(Add));
    process (clk) is
    begin
        if falling_edge(clk) then
            if MemWrite = '1' then
                bank(addr)     <= WD(31 downto 24);
                bank(addr + 1) <= WD(23 downto 16);
                bank(addr + 2) <= WD(15 downto 8);
                bank(addr + 3) <= WD(7 downto 0);
            end if;
        end if;
    end process;
	RD <= (bank(addr) & bank(addr + 1) & bank(addr + 2) & bank(addr + 3)) when MemRead = '1' else x"00000000";

end behavior;
