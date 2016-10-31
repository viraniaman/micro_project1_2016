library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity uP is

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
	
end entity;

architecture Behave of uP is

	signal Q: FsmState;

begin

process(clk)

	variable nQ: FsmState;
	variable reset1: std_logic;
	variable MEM_write1,IR_write1,PC_write1,MDR_write1,RF_write1:std_logic;
	variable T1_write1,T2_write1,T3_write1,T4_write1,T5_write1:std_logic;
	variable M1a,M2a,M4a,M5a:std_logic_vector(1 downto 0); 
	variable M6a,M7a,M8a: std_logic;
	variable M3a:std_logic_vector(2 downto 0);
	variable aluop1: std_logic_vector(1 downto 0);
		
begin

	nQ := Q;
	reset1 := reset;
--	Mem_write1 := Mem_write;
--	IR_write1 := IR_write;
--	PC_write1 := PC_write;
--	MDR_write1 := MDR_write;
--	RF_write1 := RF_write;
--	T1_write1 := T1_write;
--	T2_write1 := T2_write;
--	T3_write1 := T3_write;
--	T4_write1 := T4_write;
--	T5_write1 := T5_write;
--	M1a := M1;
--	M2a := M2;
--	M3a := M3;
--	M4a := M4;
--	M5a := M5;
--	M6a := M6;
--	M7a := M7;
--	M8a := M8;
--	aluop1 := aluop;
--	done1 := done;
	
	case Q is
	
	when PC1 =>
	
		IR_write1:='1';
		PC_write1:='1';
		M1a :="00";
		M2a :="01";
		M3a :="001";
		M4a :="00";
		
		if(opcode="0000" or opcode="0010" or opcode="0001") then
			nQ := OP1;
		end if;
		
		if (opcode = "0011") then
			nQ := LHI1;
		end if;
		
		if(opcode="0001") then
			nQ := OPI1;
		end if;
		
		if (opcode = "0100" or opcode = "0101") then
			nQ := LW1;
		end if;
		
		if(opcode="1100") then
			nQ := BEQ1;
		end if;
		
		if (opcode = "1000" or opcode = "1001") then
			nQ := JAL1;
		end if;
		
		if (opcode = "0110" or opcode = "0111") then
			nQ := LM1;
		end if;
		
	when OP1 =>
	
		nQ := OP2;
		T1_write1:='1';
		T2_write1:='1';
		M8a :='0';
		
	when OP2 =>
	
		M3a :="000";
		M4a :="10";
		T3_write1:='1';
		
		if(opcode = "0000" or opcode = "0001") then
			aluop1 := "00";
		elsif(opcode = "0010") then
			aluop1 := "01";
		elsif(opcode = "1100") then
			aluop1 := "11";
		end if;
		
		if(opcode="1100") then
			if(Z = '1') then
				nQ := BEQ3;
			elsif(Z = '0') then 
				nQ := PC1;
			end if;
		else
			nQ := OP3;
		end if;
		
	when OP3 =>
	
		nQ := PC1;
		M5a :="00";
		
		if(IR(1 downto 0)="00" or IR(15 downto 12)="0011") then
			RF_write1 := '1';
		elsif(IR(1 downto 0)="01") then
			RF_write1 := Z;
		elsif(IR(1 downto 0)="10") then
			RF_write1 := C;
		else
			RF_write1 := '0';
		end if;
		
	when LHI1 =>
	
		nQ := OP3;
		M3a :="010";
		T3_write1:='1';
		
	when OPI1 =>
	
		nQ := OPI2;
		M8a :='0';
		T1_write1:='1';
		
	when OPI2 =>
	
		nQ := OP3;
		M3a :="000";
		M4a :="01";
		T3_write1:='1'; 
		
	when LW1 =>
	
		nQ := LW2;
		T2_write1:='1';
		
	when LW2 =>
	
		M3a := "011";
		M4a := "10";
		T3_write1 :='1';
		
		if (opcode(0) = '1') then
			nQ := SW3;
		elsif(opcode(1) = '0') then
			nQ := LW3;
		end if;
		
	when LW3 =>
	
		nQ := LW4;
		M2a := "00";
		MDR_write1:='1';
		
	when LW4 =>
	
		nQ := PC1;
		M5a := "01";
		RF_write1 :='1';
		
	when SW3 =>
	
		nQ := PC1;
		T1_write1:='1';
		MEM_write1:='1';
		M2a := "00";
		M8a := '0';	
		
--	when BEQ1 =>
--	
--		nQ := BEQ2;
--		T1_write1:='1';
--		T2_write1:='1';
--		M8a :="0";
--		
--	when BEQ2 =>
--	
--		M3a:="000";
--		M4a:="10";
--		T3_write1:='1';
--		
--		if (Z = '1') then
--			nQ := BEQ3;
--		end if;
--		
--		if (Z = '0') then
--			nQ := PC1;
--		end if;
		
	when BEQ3 =>
	
		M3a := "001";
		nQ := PC1;
		M1a := "10";
		M4a:="01";
		PC_write1 := '1';
		
	when JAL1 =>
	
		M5a := "10";
		RF_write1:='1';
		
		if (opcode(0) = '1') then
			nQ := JLR2;
		end if;
		
		if (opcode(0) = '0') then
			nQ := BEQ3;
		end if;
		
	when JLR2 =>
	
		nQ := PC1;
		M1a:="01";
		RF_write1:='1';
		
	when LM1 =>
	
		M8a := '0';
		M6a :='0';
		M7a :='0';
		T4_write1:='1';
		
		if (opcode(0) = '1') then
			nQ := SM2;
		end if;
		
		if (opcode(0) = '0') then
			nQ := LM2;
		end if;	
		
	when LM2 =>
	
		T5_write1:='1';
		MDR_write1:='1';
		M3a :="100";
		M2a:="10";
		M4a:="00";
		T3_write1 := '1';
		nQ := LM3;
		
	when LM3 =>
	
		M5a:="01";
		RF_write1:='1';
		M6a:='1';
		M7a:='1';
		T4_write1:='1';  
		
		if (PE_done = '0') then
			nQ := LM2;
		elsif(PE_done = '1') then
			nQ := PC1;
--			done1:='1';
		end if;

	when SM2 =>
	
		nQ := SM3;
		T5_write1:='1';
		M3a:="100";
		M8a :='1';
		T1_write1 := '1';
		MEM_write1:='1';
		M2a :="10";
		M4a :="00";
		T3_write1 := '1';

	when SM3 =>
	
		M6a :='1';
		M7a :='1';
		T4_write1:='1';
		
		if (PE_done = '0') then
			nQ := SM2;
		elsif (PE_done = '1') then
			nQ := PC1;
--			done1:='1';
		end if;

	when others => 
	
		nQ := PC1;
		
	end case;

	if(clk'event and (clk = '1')) then
--		done <= done1;
--		--Z_out <= Z_out1;
--		--C_out <= C_out1;
--		MEM_write<=MEM_write1;
--		RF_write<=RF_write1;
--		IR_write<=IR_write1;
--		PC_write<=PC_write1;
--		M1 <= M1a;
--		M2 <= M2a;
--		M3 <= M3a;
--		M4 <= M4a;
--		M5 <= M5a;
--		M6 <= M6a;
--		M7 <= M7a;
--		M8 <= M8a;
--		aluop <= aluop1;

--		reset <= reset1;
		Mem_write <= Mem_write1;
		IR_write <= IR_write1;
		PC_write <= PC_write1;
		MDR_write <= MDR_write1;
		RF_write <= RF_write1;
		T1_write <= T1_write1;
		T2_write <= T2_write1;
		T3_write <= T3_write1;
		T4_write <= T4_write1;
		T5_write <= T5_write1;
		M1 <= M1a;
		M2 <= M2a;
		M3 <= M3a;
		M4 <= M4a;
		M5 <= M5a;
		M6 <= M6a;
		M7 <= M7a;
		M8 <= M8a;
		aluop <= aluop1;
<<<<<<< HEAD
--		done <= done1;
=======
		done <= done1;
>>>>>>> 68b87b1badcac436e74be53604c77bacf25350bc
		
		if(reset1 = '1') then
			Q <= PC1;
		else
			Q <= nQ;
		end if;
	end if;

end process;

end Behave;
