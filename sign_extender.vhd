library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extender is

-- generic(n: integer);

port(a: in std_logic_vector(5 downto 0);
	  b: out std_logic_vector(15 downto 0));

end entity sign_extender;

architecture basic of sign_extender is

begin
	
	b(5 downto 0) <= a;
	
	b(15 downto 6) <= ("1111111111") when (a(5) = '1') else
							("0000000000");

end basic;
