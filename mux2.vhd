library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mux2 is 

generic(
	n: integer
	);

port(
	sel: in std_logic;
	inp1, inp2: in std_logic_vector(n-1 downto 0);
	output: out std_logic_vector(n-1 downto 0)
	);
	
end entity;

architecture basic of mux2 is 

begin

	output <= inp1 when (sel='0') else inp2;

end basic;