library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_5bits is
    port(
        sel: in std_logic;
        A, B: in std_logic_vector(4 downto 0);
        O: out std_logic_vector(4 downto 0)
    );
end mux2x1_5bits;

architecture behavior of mux2x1_5bits is
begin
    process (sel, A, B) is
    begin
        case sel is
            when '0'   => O <= A;
            when others => O <= B;
        end case;
    end process;
end behavior;
