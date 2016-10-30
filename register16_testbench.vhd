library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use STD.textio.all;
--use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity register16_testbench is
end entity;

architecture basic of register16_testbench is

component general_register is

generic(
    n: integer
    );

port(D: in std_logic_vector(n-1 downto 0);
	  Q: out std_logic_vector(n-1 downto 0);
	  clk: in std_logic;
	  w: in std_logic);
end component;

--signal D3: std_logic_vector(15 downto 0) := (others => '0');
signal clk: std_logic := '0';
signal w: std_logic := '0';
signal register16_write: std_logic := '0';
signal D: std_logic_vector(15 downto 0) := (others => '0');
signal Q: std_logic_vector(15 downto 0) := (others => '0');

begin

	clk <= (not clk) after 2 ns;
	
	process
	
		file inputs: text open read_mode is "register16_text.txt";
		file outputs: text open write_mode is "register16_vectors.out";
		variable file_line: line;
		variable out_line: line;
		variable line_num: integer := 0;
		variable reg_write1: bit;
		variable D1: bit_vector(15 downto 0);
		variable Q1: bit_vector(15 downto 0);
		variable w1: bit; 

	begin
	
		while not endfile(inputs) loop
		
			--wait until clk='1';
			--wait for 1 ns;
			readline(inputs, file_line);
			--read(file_line, A11);
			--read(file_line, A21);
			--read(file_line, A31);
			--read(file_line, D31);
			read(file_line, w1);
			read(file_line, D1);
			read(file_line, Q1);
			--read(file_line,w1);			
			---A1 <= to_stdlogicvector(A11);
			--A2<= to_stdlogicvector(A21);
			--Q <= to_stdlogicvector(Q1);
			D <= to_stdlogicvector(D1);
			w <= to_stdulogic(w1);
			
			--wait for 1 ns;
			--wait until rising_edge(clk);
			wait until rising_edge(clk);
			wait for 1 ns;
			
			if(Q /= to_stdlogicvector(Q1)) then
				write(out_line, string'("D found error at line "));
				write(out_line, integer'image(line_num));
				write(out_line, string'(" expected output "));
				write(out_line, (Q1));
				write(out_line, string'(" found output "));
				write(out_line, to_bitvector(Q));
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
	
	module_register16: general_register generic map(16) port map(D,Q,clk,w);
end basic;
