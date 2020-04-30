library ieee;
use ieee.std_logic_1164.all;


entity Despl2 is
    port(
        entrada: in std_logic_vector(31 downto 0);
        sortida: out std_logic_vector(31 downto 0)
    );
end Despl2;

architecture behavior of Despl2 is
begin
	sortida <= entrada(29 downto 0) & "00";
end behavior;