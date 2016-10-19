library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity memory is

port(mem_address: in std_logic_vector(15 downto 0);
	  mem_data: in std_logic_vector(15 downto 0);
	  rw: in std_logic;
	  en: in std_logic;
	  clk: in std_logic;
	  mem_out: out std_logic_vector(15 downto 0)
	  );

end entity;

architecture basic of memory is 

type mem_cells1 is array(127 downto 0) of std_logic_vector(15 downto 0);

signal mem_cells: mem_cells1;

begin

	process(clk)	
	begin	
		if(rising_edge(clk)) then		
			if(en = '1') then		
				if(rw = '0') then				
					mem_out <= mem_cells(to_integer(unsigned(mem_address)));				
				else				
					mem_cells(to_integer(unsigned(mem_address))) <= mem_data;				
				end if;			
			end if;		
		end if;	
	end process;

end basic;