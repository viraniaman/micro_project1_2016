library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
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

type mem_cells1 is array(0 to 127) of std_logic_vector(15 downto 0);
signal mem_cells: mem_cells1 := (others => (others => '1'));

function to_string (arg : std_logic_vector) return string is
      variable result : string (1 to arg'length);
      variable v : std_logic_vector (result'range) := arg;
   begin
      for i in result'range loop
         case v(i) is
            when 'U' =>
               result(i) := 'U';
            when 'X' =>
               result(i) := 'X';
            when '0' =>
               result(i) := '0';
            when '1' =>
               result(i) := '1';
            when 'Z' =>
               result(i) := 'Z';
            when 'W' =>
               result(i) := 'W';
            when 'L' =>
               result(i) := 'L';
            when 'H' =>
               result(i) := 'H';
            when '-' =>
               result(i) := '-';
         end case;
      end loop;
      return result;
   end;

begin

	mem_out <= mem_cells(to_integer(unsigned(mem_address))) when ((rw = '0') and (en = '1'))
				  else (others => '0');

	process(clk, mem_data, mem_address)	
	
	begin	
		if(rising_edge(clk)) then		
			if(en = '1') then		
				if(rw = '1') then							
					mem_cells(to_integer(unsigned(mem_address))) <= mem_data;
					report to_string(mem_address);
				end if;
			end if;		
		end if;	
	end process;
	
	

end basic;