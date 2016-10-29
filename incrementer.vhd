use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity incrementer is

generic(
	n: integer;
	);

port(
	a: in std_logic_vector(n-1 downto 0);
	b: out std_logic_vector(n-1 downto 0)
	);
	
architecture basic of incrementer is

begin
	
	b <= std_logic_vector(unsigned(a) + 1);
	
end basic;