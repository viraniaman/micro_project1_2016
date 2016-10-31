library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity microprocessor is

port(clk, reset: in std_logic);
 
end entity;

architecture basic of microprocessor is

component uP is

port(

	opcode: in std_logic_vector(3 downto 0);
	clk,reset: in std_logic;
	IR: in std_logic_vector(15 downto 0);
	--Z_out, C_out:out signal; 
	Z,C : in std_logic;
	PE_done : in std_logic;
--	done:out std_logic;
	MEM_write,RF_write,IR_write,PC_write,MDR_write:out std_logic;
	T1_write,T2_write,T3_write,T4_write,T5_write:out std_logic;
	M1,M2,M4,M5: out std_logic_vector(1 downto 0);
	M6,M7,M8: out std_logic;
	M3:out std_logic_vector(2 downto 0);
	ALUop: out std_logic_vector(1 downto 0)
	
	);
	
end component;

component datapath is

port(
	PCWrite, IRWrite, RFWrite, MDRWrite, T1Write, T2Write, T3Write, T4Write, T5Write, MemWrite, RegWrite,
	Control_M6, Control_M7, Control_M8, clk: in std_logic;
	Control_M3: in std_logic_vector(2 downto 0);
	ALUop, control_M2, control_M4, control_M5, Control_M1: in std_logic_vector(1 downto 0);
	
	opcode: out std_logic_vector(3 downto 0);
	Z, C, PE_done: out std_logic;
	IR: out std_logic_vector(15 downto 0)
	);

end component;

signal PCWrite, IRWrite, RFWrite, MDRWrite, T1Write, T2Write, T3Write, T4Write, T5Write, MemWrite, RegWrite,
		 Control_M6, Control_M7, Control_M8: std_logic;
signal Control_M3: std_logic_vector(2 downto 0);
signal ALUop, control_M2, control_M4, control_M5, Control_M1: std_logic_vector(1 downto 0);
signal opcode: std_logic_vector(3 downto 0);
signal Z, C, PE_done: std_logic;
signal IR: std_logic_vector(15 downto 0);

begin

	control_path: uP port map (opcode, clk, reset, IR, Z, C, PE_done, MemWrite, RFWrite, IRWrite,
										PCWrite, MDRWrite, T1Write, T2Write, T3Write, T4Write, T5Write, 
										control_M1, control_M2, control_M4, control_M5, control_M6,
										control_M7, control_M8, control_M3, ALUop);
	
	data_path: datapath port map (PCWrite, IRWrite, RFWrite, MDRWrite, T1Write, T2Write, 
											T3Write, T4Write, T5Write, MemWrite, RegWrite,
											Control_M6, Control_M7, Control_M8, clk, Control_M3,
											ALUop, control_M2, control_M4, control_M5, Control_M1,
											opcode, Z, C, PE_done, IR);

end basic;