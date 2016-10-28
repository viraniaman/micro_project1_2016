library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity datapath is

port(
	PCWrite, IRWrite, RFWrite, MDRWrite, T1Write, T2Write, EN, RW, RegWrite,
	Control_M1, Control_M5, Control_M6, Control_M7, Control_M8: in std_logic;
	A1, A2, A3, Control_M3: in std_logic_vector(2 downto 0);
	ALUop, control_M2, control_M4: in std_logic_vector(1 downto 0);
	
	opcode: out std_logic_vector(3 downto 0);
	clk, reset, Z, C, PE_done: out std_logic;
	);

end entity;

architecture basic of datapath is

begin

	

end basic;