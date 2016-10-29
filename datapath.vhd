library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity datapath is

port(
	PCWrite, IRWrite, RFWrite, MDRWrite, T1Write, T2Write, EN, RW, RegWrite,
	Control_M1, Control_M5, Control_M6, Control_M7, Control_M8, clk: in std_logic;
	A1, A2, A3, Control_M3: in std_logic_vector(2 downto 0);
	ALUop, control_M2, control_M4: in std_logic_vector(1 downto 0);
	state: in fsm_state;
	
	opcode: out std_logic_vector(3 downto 0);
	Z, C, PE_done: out std_logic
	);

end entity;

architecture basic of datapath is

component alu is

port(ALUop: in std_logic_vector(1 downto 0);
	  A,B: in std_logic_vector(15 downto 0);
--	  C_en, Z_en: out std_logic;
	  C, Z: out std_logic;
	  OUTPUT: out std_logic_vector(15 downto 0)
	  );
	  
end component;

component register_file is

port(A1: in std_logic_vector(2 downto 0);
	  A2: in std_logic_vector(2 downto 0);
	  A3: in std_logic_vector(2 downto 0);
	  D3: in std_logic_vector(15 downto 0);
	  reg_write: in std_logic;
	  clk: in std_logic;
	  D1: out std_logic_vector(15 downto 0);
	  D2: out std_logic_vector(15 downto 0));
	  
end component;

component general_register is

generic(
	integer: n
	);

port(D: in std_logic_vector(n-1 downto 0);
	  Q: out std_logic_vector(n-1 downto 0);
	  clk: in std_logic;
	  w: in std_logic);
	  
end component;

component priority_encoder is

port(a: in std_logic_vector(8 downto 0);
	  o: out std_logic_vector(2 downto 0);
	  a1: out std_logic_vector(8 downto 0);
	  sig: out std_logic);

end component;

component sign_extender is

generic(n: integer);

port(a: in std_logic_vector(n-1 downto 0);
	  b: out std_logic_vector(15 downto 0));

end component;

component mux2 is

generic(
	n: integer
	);

port(
	sel: in std_logic;
	inp1, inp2: in std_logic_vector(n-1 downto 0);
	output: out std_logic_vector(n-1 downto 0)
	);

end component;

component mux4 is

generic(
	n: integer
	);

port(
	sel: in std_logic_vector(1 downto 0);
	inp1, inp2, inp3, inp4: in std_logic_vector(n-1 downto 0);
	output: out std_logic_vector(n-1 downto 0)
	);

end component;

component mux8 is

generic(
	n: integer
	);

port(
	sel: in std_logic_vector(2 downto 0);
	inp1, inp2, inp3, inp4, inp5, inp6, inp7, inp8: in std_logic_vector(n-1 downto 0);
	output: out std_logic_vector(n-1 downto 0)
	);

end component;

component incrementer is

generic(
	n: integer;
	);

port(
	a: in std_logic_vector(n-1 downto 0);
	b: out std_logic_vector(n-1 downto 0)
	);

end component;

type FSM_state is ;

signal m3_to_alu, m4_to_alu, alu_out, t3_out, t1_out, t2_out, t4_out, pc_out, se9_out, se6_out
		 temp1, temp2, temp3, temp4, temp5, temp6, ir_out, mem_out, d1, d2, d3, mdr_out, pc_in,
		 mem_in: std_logic_vector(15 downto 0);
signal imm9, ir_to_mux6, t5_to_mux6: std_logic_vector(8 downto 0);
signal imm6: std_logic_vector(5 downto 0);
signal pe_next, m6_to_pe: std_logic_vector(7 downto 0);
signal a1, a2, a3, pe_out, mux8_out: std_logic_vector(2 downto 0);
signal c_reg, z_reg: std_logic;
signal 

begin

	C <= c_reg;
	Z <= z_reg;
	ir_to_mux6 <= "0" & ir_out(7 downto 0);
	t5_to_mux6 <= "0" & t5_out;

	alu_block: alu port map (ALUop, m3_to_alu, m4_to_alu, c_reg, z_reg, alu_out);
	
	T3: general_register generic map (16) port map (alu_out, t3_out, clk, '1');
	T1: general_register generic map (16) port map (d1, t1_out, clk, T1Write);
	T2: general_register generic map (16) port map (d2, t2_out, clk, T2Write);
	T5: general_register generic map (8) port map (pe_next, t5_out, clk, '1');
	T4: general_register generic map (16) port map ();
	
	MUX_1: mux2 generic map (16) port map (control_M1, alu_out, d2, pc_in);
	MUX_2: mux4 generic map (16) port map (control_M2, t3_out, pc_out, t4_out, temp5, mem_in)
	MUX_3: mux8 generic map (16) port map (control_M3, t1_out, pc_out, se9_out, se6_out, t4_out, temp1, temp2, temp3, m3_to_alu);
	MUX_4: mux4 generic map (16) port map (control_M4, "0000000000000001", se6_out, t2_out, temp4, m4_to_alu);
	MUX_5: mux2 generic map (16) port map(control_M5, t3_out, mdr_out, d3);
	MUX_6: mux2 generic map (8) port map(control_M6, ir_to_mux6, t5_out, m6_to_pe);
	MUX_7: 
	MUX_8: mux2 generic map (3) port map(control_M8, ir_out(11 downto 9), pe_out, mux8_out);
	
	SE9: sign_extender generic map (9) port map (imm9, se9_out);	
	SE6: sign_extender generic map (6) port map (imm6, se6_out);
	
	Ins_reg: general_register generic map (16) port map(mem_out, ir_out, clk, IRWrite);
	
	--separating outputs of IR
	
	a1 <= "111" when (state=PC1 or state=JLR2) else mux8_out; 
	a2 <= ir_out(8 downto 6);
	a3 <= "111" when (state=PC1) else
			ir_out(5 downto 3) when (ir_out(15 downto 12)="0000" or ir_out(15 downto 12)="0010") else
			ir_out(8 downto 6) when (ir_out(15 downto 12)="0001") else
			ir_out(11 downto 9) when (ir_out(15 downto 12)="0011");
			
	
	reg_file: register_file port map(a1, a2, a3, d3, RegWrite, clk, d1, d2);
	
	PC: general_register generic map (16) port map(pc_in, pc_out, clk, PCWrite);
	
	PE: priority_encoder port map (m6_to_pe, pe_out, pe_next, PE_done);
	
	
	

end basic;