library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use STD.textio.all;
--use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity priority_encoder_testbench is
end entity;

architecture basic of priority_encoder_testbench is

component priority_encoder is
port(a: in std_logic_vector(8 downto 0);
	  o: out std_logic_vector(2 downto 0);
	  a1: out std_logic_vector(8 downto 0);
	  sig: out std_logic);

end component;

signal a: std_logic_vector(8 downto 0) := (others => '0');
signal o: std_logic_vector(2 downto 0) := (others => '0');
signal a1: std_logic_vector(8 downto 0) := (others => '0');
signal sig: std_logic := '0';

begin
	
	process
	
		file inputs: text open read_mode is "priority_encoder_text.txt";
		file outputs: text open write_mode is "priority_encoder_vectors.out";
		variable file_line: line;
		variable out_line: line;
		variable line_num: integer := 0;
		variable a_read: bit_vector(8 downto 0);
		variable o_read: bit_vector(2 downto 0);
		variable a1_read: bit_vector(8 downto 0);
		variable sig_read: bit;

	begin
	
		while not endfile(inputs) loop
		
			readline(inputs, file_line);
			read(file_line, a_read);
			read(file_line, o_read);
			read(file_line, a1_read);
			read(file_line, sig_read);
			
			a <= to_stdlogicvector(a_read);
			
			wait for 1 ns;

			if(o /= to_stdlogicvector(o_read)) then
				write(out_line, string'("o found error at line "));
				write(out_line, integer'image(line_num));
				write(out_line, string'(" expected output "));
				write(out_line, (o_read));
				write(out_line, string'(" found output "));
				write(out_line, to_bitvector(o));
				writeline(outputs, out_line);
				
			elsif(a1 /= to_stdlogicvector(a1_read)) then 
				write(out_line, string'("a1 found error at line "));
				write(out_line, integer'image(line_num));
				write(out_line, string'(" expected output "));
				write(out_line, (a1_read));
				write(out_line, string'(" found output "));
				write(out_line, to_bitvector(a1));
				writeline(outputs, out_line);
				
			elsif(sig /= to_stdulogic(sig_read)) then 
				write(out_line, string'("sig found error at line "));
				write(out_line, integer'image(line_num));
				write(out_line, string'(" expected output "));
				write(out_line, (sig_read));
				write(out_line, string'(" found output "));
				write(out_line, to_bit(sig));
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
	
	module_priority_encoder: priority_encoder port map(a, o, a1, sig);
	
end basic;
