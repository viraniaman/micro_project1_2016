library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mux4 is 

port(
	sel: in std_logic_vector(1 downto 0);
	inp1, inp2, inp3, inp4: in std_logic_vector(15 downto 0);
	output: out std_logic_vector(15 downto 0);
	);
	
end entity;

architecture basic of mux2 is 

begin

	output <= inp1 when (sel="00") else 
				 inp2 when (sel="01") else
				 inp3 when (sel="10") else
				 inp4;

end basic;