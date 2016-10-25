library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use STD.textio.all;
--use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity memory_testbench is
end entity;

architecture basic of memory_testbench is

--function to_string ( a: std_logic_vector) return string is
--variable b : string (1 to a'length) := (others => NUL);
--variable stri : integer := 1; 
--begin
--    for i in a'range loop
--        b(stri) := std_logic'image(a(i));
--    stri := stri+1;
--    end loop;
--return b;
--end function;

component memory is
port(mem_address: in std_logic_vector(15 downto 0);
	  mem_data: in std_logic_vector(15 downto 0);
	  rw: in std_logic;
	  en: in std_logic;
	  clk: in std_logic;
	  mem_out: out std_logic_vector(15 downto 0)
	  );
end component;

signal mem_address: std_logic_vector(15 downto 0) := (others => '0');
signal mem_data: std_logic_vector(15 downto 0) := (others => '0');
signal rw: std_logic;
signal en: std_logic := '0';

signal clk: std_logic := '0';
signal mem_out: std_logic_vector(15 downto 0) := (others => '1');

--function to_string (arg : std_logic_vector) return string is
--      variable result : string (1 to arg'length);
--      variable v : std_logic_vector (result'range) := arg;
--   begin
--      for i in result'range loop
--         case v(i) is
--            when 'U' =>
--               result(i) := 'U';
--            when 'X' =>
--               result(i) := 'X';
--            when '0' =>
--               result(i) := '0';
--            when '1' =>
--               result(i) := '1';
--            when 'Z' =>
--               result(i) := 'Z';
--            when 'W' =>
--               result(i) := 'W';
--            when 'L' =>
--               result(i) := 'L';
--            when 'H' =>
--               result(i) := 'H';
--            when '-' =>
--               result(i) := '-';
--         end case;
--      end loop;
--      return result;
--   end;

begin

	en <= '1';
	clk <= (not clk) after 2 ns;
	
	process
	
		file inputs: text open read_mode is "memory_text.txt";
		file outputs: text open write_mode is "memory_vectors.out";
		variable file_line: line;
		variable out_line: line;
		variable line_num: integer := 0;
		variable mem_address1: bit_vector(15 downto 0) := (others => '0');
		variable mem_data1: bit_vector(15 downto 0) := (others => '0');
		variable mem_out1: bit_vector(15 downto 0) := (others => '0');
		variable temp_read: bit_vector(15 downto 0);

	begin
	
		while not endfile(inputs) loop
			
			rw <= '1';
		
			wait until clk='1';
		
			readline(inputs, file_line);
			
--			if(rw1 = '0') then
--			
--				read(file_line, mem_address1);
--				read(file_line, mem_out1);
--			
--				mem_address <= to_stdlogicvector(mem_address1);
--				
--				wait for 1 ns;
--				
--				if(mem_out /= to_stdlogicvector(mem_out1)) then
--					write(out_line, string'("found error at line "));
--					write(out_line, integer'image(line_num));
--					write(out_line, string'(" expected output "));
--					write(out_line, (mem_out1));
--					write(out_line, string'(" found output "));
--					write(out_line, to_bitvector(mem_out));
--					writeline(outputs, out_line);
--				
--				else 
--					write(out_line, string'("run successfully at line "));
--					write(out_line, integer'image(line_num));
--					writeline(outputs, out_line);
--					
--				end if;
--			
--			else
			
			read(file_line, mem_address1);
			read(file_line, mem_data1);
			
			mem_address <= to_stdlogicvector(mem_address1);
			mem_data <= to_stdlogicvector(mem_data1);
			
			rw <= '0';
			
			wait until clk='1';
			mem_address <= to_stdlogicvector(mem_address1);
			
			if(mem_out /= to_stdlogicvector(mem_data1)) then
				write(out_line, string'("found error at line "));
				write(out_line, integer'image(line_num));
				write(out_line, string'(" expected output "));
				write(out_line, (mem_data1));
				write(out_line, string'(" found output "));
				write(out_line, to_bitvector(mem_out));
				writeline(outputs, out_line);
			
			else 
				write(out_line, string'("run successfully at line "));
				write(out_line, integer'image(line_num));
				writeline(outputs, out_line);
				
			end if;
			
--			end if;		
				
			line_num := line_num + 1;
		
		end loop;
		
		wait;
	
	end process;
	
	module_memory: memory port map(mem_address, mem_data, rw, en, clk, mem_out);
	
end basic;
