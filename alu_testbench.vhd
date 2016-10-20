library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use STD.textio.all;
--use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity alu_testbench is
end entity;

architecture basic of alu_testbench is

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

component alu is
port(ALUop: in std_logic_vector(1 downto 0);
	  A,B: in std_logic_vector(15 downto 0);
	  C, Z: out std_logic;
	  OUTPUT: out std_logic_vector(15 downto 0)
	  );
end component;

signal op: std_logic_vector(1 downto 0):="00";
signal a_temp: std_logic_vector(15 downto 0):= (others=>'0');
signal b_temp: std_logic_vector(15 downto 0):= (others=>'0');
signal output_temp: std_logic_vector(15 downto 0):= (others=>'0');
signal ctemp: std_logic:='0';
signal ztemp: std_logic:='0';

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
	
	process
	
		file inputs: text open read_mode is "alu_text.txt";
		file outputs: text open write_mode is "alu_vectors.out";
		variable file_line: line;
		variable out_line: line;
		variable line_num: integer := 0;
		variable op1: bit_vector(1 downto 0);
		variable a_temp1, b_temp1, output_temp1: bit_vector(15 downto 0);

	begin
	
		while not endfile(inputs) loop
		
			readline(inputs, file_line);
			read(file_line, op1);
			read(file_line, a_temp1);
			read(file_line, b_temp1);
			read(file_line, output_temp1);
			
			op <= to_stdlogicvector(op1);
			a_temp <= to_stdlogicvector(a_temp1);
			b_temp <= to_stdlogicvector(b_temp1);
			
			wait for 1 ns;
			
			if(output_temp /= to_stdlogicvector(output_temp1)) then
				write(out_line, string'("found error at line "));
				write(out_line, integer'image(line_num));
				write(out_line, string'(" expected output "));
				write(out_line, (output_temp1));
				write(out_line, string'(" found output "));
				write(out_line, to_bitvector(output_temp));
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
	
	module_alu: alu port map(op, a_temp, b_temp, ctemp, ztemp, output_temp);

end basic;
