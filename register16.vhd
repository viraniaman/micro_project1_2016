library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register16 is

port(D: in std_logic_vector(15 downto 0);
	  Q: out std_logic_vector(15 downto 0);
	  clk: in std_logic;
	  w: in std_logic);

end entity;

architecture basic of register16 is

begin

	process(clk, w)
	
	begin
	
		if(rising_edge(clk)) then
			if(w = '0') then
				Q <= D;
			end if;
		end if;
	
	end process;

end basic;