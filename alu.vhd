library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity alu is
port(ALUop: in std_logic_vector(1 downto 0);
	  A,B: in std_logic_vector(15 downto 0);
--	  C_en, Z_en: out std_logic;
	  C, Z: out std_logic;
	  OUTPUT: out std_logic_vector(15 downto 0)
	  );
end alu;

architecture basic of alu is

	signal a_temp, b_temp, out_temp: std_logic_vector(16 downto 0);

begin

	a_temp(15 downto 0) <= A;
	b_temp(15 downto 0) <= B;
	OUTPUT <= out_temp(15 downto 0);

	process
		variable temp1, temp2: bit_vector(15 downto 0);
	begin
		case ALUop is
			when "00" =>
				out_temp <= a_temp + b_temp;
			when "01" =>
				out_temp <= a_temp nand b_temp;
			when "10" =>
				temp1 := to_bitvector(A);
				temp2 := temp1 sll 7;
				out_temp(15 downto 0) <= to_stdlogicvector(temp2);
			when "11" =>
				out_temp <= a_temp - b_temp;
		end case;
		
		if(out_temp = (others => '0')) then
			Z <= '1';
--			Z_en <= '1';
		end if;
		
		C <= out_temp(16);
		
	end process;

end basic;