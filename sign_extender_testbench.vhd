library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use STD.textio.all;
--use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity sign_extender_testbench is
end entity;

architecture basic of sign_extender_testbench is

component sign_extender is

generic(n: integer);

port(a: in std_logic_vector(n-1 downto 0);
	  b: out std_logic_vector(15 downto 0));
end component;

signal a: std_logic_vector(5 downto 0) := (others => '0');
signal b: std_logic_vector(15 downto 0) := (others => '0');

begin
	
	process
	
		file inputs: text open read_mode is "sign_extender_text.txt";
		file outputs: text open write_mode is "sign_extender_vectors.out";
		variable file_line: line;
		variable out_line: line;
		variable line_num: integer := 0;
		variable a_temp: bit_vector(5 downto 0) := (others => '0');
		variable b_temp: bit_vector(15 downto 0) := (others => '0');

	begin
	
		while not endfile(inputs) loop
		
			readline(inputs, file_line);			
			read(file_line, a_temp);
			read(file_line, b_temp);
			
			a <= to_stdlogicvector(a_temp);
			
			wait for 1 ns;
			
			if(b /= to_stdlogicvector(b_temp)) then
				write(out_line, string'("found error at line "));
				write(out_line, integer'image(line_num));
				write(out_line, string'(" expected output "));
				write(out_line, (b_temp));
				write(out_line, string'(" found output "));
				write(out_line, to_bitvector(b));
				writeline(outputs, out_line);
			
			else 
				write(out_line, string'("run successfully at line "));
				write(out_line, integer'image(line_num));
				writeline(outputs, out_line);
				
			end if;
				
			line_num := line_num + 1;
		
		end loop;
		
		wait;
	
	end process;
	
	sign_extender_module: sign_extender generic map(6) port map(a, b);
	
end basic;
