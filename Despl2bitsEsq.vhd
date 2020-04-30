  
library ieee;
use ieee.std_logic_1164.all;


entity Despl2BitsEsq is
    port(
        entrada: in std_logic_vector(25 downto 0);
        sortida: out std_logic_vector(27 downto 0)
    );
end Despl2BitsEsq;

architecture behavior of Despl2BitsEsq is
begin
	sortida <= entrada & "00";
end behavior;