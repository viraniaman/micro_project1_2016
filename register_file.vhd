library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity register_file is

port(A1: in std_logic_vector(2 downto 0);
	  A2: in std_logic_vector(2 downto 0);
	  A3: in std_logic_vector(2 downto 0);
	  D3: in std_logic_vector(15 downto 0);
	  reg_write: in std_logic;
	  clk: in std_logic;
	  D1: out std_logic_vector(15 downto 0);
	  D2: out std_logic_vector(15 downto 0));

end entity;

architecture basic of register_file is

type register_array is array(7 downto 0) of std_logic_vector(15 downto 0); 

signal registers: register_array;

begin

	D1 <= D3 when (A1 = A3) else 
			registers(to_integer(unsigned(A1)));
	D2 <= D3 when (A2 = A3) else 
			registers(to_integer(unsigned(A2)));
	
	

	process(clk)
		
	begin
		
		if(rising_edge(clk)) then
			
			if(reg_write = '1') then
			
				registers(to_integer(unsigned(A3))) <= D3;
				
			end if;
	
		end if;
		
	end process;

end basic;