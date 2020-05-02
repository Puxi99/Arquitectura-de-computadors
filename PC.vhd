library ieee;
use ieee.std_logic_1164.all;

entity PC is
  port(
    clk,Reset,Esc: in std_logic;
    PCin: in std_logic_vector(31 downto 0);
    PCout: out std_logic_vector(31 downto 0));
end PC;

architecture behavior of PC is
  signal aux: std_logic_vector(31 downto 0);
begin
  process (clk,Reset) begin
                        if Reset = '1' then
                          aux <= x"00000000";
                        elsif (falling_edge(clk) and Esc = '1') then
                          aux <= PCin;
                        end if;
  end process;
  PCout <= aux;
end behavior;
                        
    
