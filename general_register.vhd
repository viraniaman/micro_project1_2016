library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;

entity general_register is

generic(
	n: integer
	);

port(D: in std_logic_vector(n-1 downto 0);
	  Q: out std_logic_vector(n-1 downto 0);
	  clk: in std_logic;
	  w: in std_logic);

end entity;

architecture basic of general_register is

begin

	process(clk)
	
	begin
	
		if(rising_edge(clk)) then
			if(w = '1') then
				Q <= D;
			end if;
		end if;
	
	end process;

end basic;
