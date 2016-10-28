library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extender is

generic(n: integer);

port(a: in std_logic_vector(n-1 downto 0);
	  b: out std_logic_vector(15 downto 0));

end entity sign_extender;

architecture basic of sign_extender is

begin

	b(15 downto n) <= (others => a(n-1));
	b(n-1 downto 0) <= a;

end basic;
