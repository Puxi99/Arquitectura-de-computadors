library ieee;
use ieee.std_logic_1164.all;

entity IR is
    port(
        clock: in std_logic;
		  Escr: in std_logic;
        D: in std_logic_vector(31 downto 0);
        Q: out std_logic_vector(31 downto 0)
    );
end IR;

architecture behavior of IR is
    signal aux: std_logic_vector(31 downto 0);
begin
    process (clock) begin
		if falling_edge(clock) and Escr = '1' then
			aux <= D;
		end if;
    end process;
    Q <= aux;
end behavior;
