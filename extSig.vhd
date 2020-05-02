library ieee;
use ieee.std_logic_1164.all;


entity extSig is
    port(
        entrada: in std_logic_vector(15 downto 0);
        sortida: out std_logic_vector(31 downto 0)
    );
end extSig;

architecture behavior of extSig is
begin
    sortida <= x"0000" & entrada when (entrada(15) = '0') else x"FFFF" & entrada;
end behavior;
