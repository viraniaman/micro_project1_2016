library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity priority_encoder is

port(a: in std_logic_vector(8 downto 0);
	  o: out std_logic_vector(2 downto 0);
	  a1: out std_logic_vector(8 downto 0);
	  sig: in std_logic);

end entity;

architecture basic of priority_encoder is

begin
	
	a1(8) <= '0';

	process
	
	begin
	
		if(a(0) = '1') then
			o <= "000";
			a1(0) <= '0';
		elsif(a(1) = '1') then
			o <= "001";
			a1(1) <= '0';
		elsif(a(2) = '1') then
			o <= "010";
			a1(2) <= '0';
		elsif(a(3) = '1') then
			o <= "011";
			a1(3) <= '0';
		elsif(a(4) = '1') then
			o <= "100";
			a1(4) <= '0';
		elsif(a(5) = '1') then
			o <= "101";
			a1(5) <= '0';
		elsif(a(6) = '1') then
			o <= "110";
			a1(6) <= '0';
		elsif(a(7) = '1') then
			o <= "111";
			a1(7) <= '0';
		end if;
		
		wait until sig='0';
		
	end process;
	

end basic;