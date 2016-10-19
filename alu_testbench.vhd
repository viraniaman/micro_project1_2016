library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use STD.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity alu_testbench is
end entity;

architecture basic of alu_testbench is

function to_string ( a: std_logic_vector) return string is
variable b : string (1 to a'length) := (others => NUL);
variable stri : integer := 1; 
begin
    for i in a'range loop
        b(stri) := std_logic'image(a((i)))(2);
    stri := stri+1;
    end loop;
return b;
end function;

component alu is
port(ALUop: in std_logic_vector(1 downto 0);
	  A,B: in std_logic_vector(15 downto 0);
	  C_en, Z_en: out std_logic;
	  C, Z: out std_logic;
	  OUTPUT: out std_logic_vector(15 downto 0)
	  );
end component;

signal op: std_logic_vector(1 downto 0);
signal a_temp, b_temp, output_temp: std_logic_vector(15 downto 0);
signal cen, zen, ctemp, ztemp: std_logic;

begin

	module_alu: alu port map(op, a_temp, b_temp, cen, zen, ctemp, ztemp, output_temp);
	
	process
	
		file inputs: text is "alu_text.txt";
		file outputs: text open write_mode is "alu_vectors.out";
		variable file_line: line;
		variable out_line: line;
		variable line_num: integer := 0;
		variable op1: std_logic_vector(1 downto 0);
		variable a_temp1, b_temp1, output_temp1: std_logic_vector(15 downto 0);

	begin
	
		while not endfile(inputs) loop
		
			readline(inputs, file_line);
			read(file_line, op1);
			read(file_line, a_temp1);
			read(file_line, b_temp1);
			read(file_line, output_temp1);
			
			op <= op1;
			a_temp <= a_temp1;
			b_temp <= b_temp1;
			
			wait for 2 ns;
			
			if(output_temp /= output_temp1) then
				write(out_line, string("found error at line "));
				write(out_line, integer'image(line_num));
				write(out_line, string(" expected output "));
				write(out_line, to_string(output_temp1));
				write(out_line, string(" found output "));
				write(out_line, to_string(output_temp));
				writeline(outputs, out_line);
				
			end if;
				
			line_num := line_num + 1;
		
		end loop;
	
	end process;

end basic;