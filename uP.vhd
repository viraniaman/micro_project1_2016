library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uP is
    port(
        opcode: in std_logic_vector(3 downto 0);
        clk,reset: in std_logic;
        --Z_out, C_out:out signal; 
		done:out std_logic;
		Z,C : in std_logic;
		PE_done : in std_logic;
		)
end entity;

architecture Behave of uP is
    type FsmState is (PC1, OP1, OP2, OP3, LHI1, OPI1, OPI2, LW1, LW2, LW3, LW4, SW3, BEQ1, BEQ2, BEQ3, JAL1, JLR2, LM1, LM2, LM3, SM2, SM3);
    signal Q : FsmState;
	--signal C_out1, Z_out1 : std_logic;
    signal done1 : std_logic;
begin
    
    process(Q,opcode,clk,reset)
        variable nQ: FsmState;
        variable done_var: std_logic;
		--variable Z_out_var : std_logic;
		--variable C_out_var : std_logic;
    begin
        --defaults
        nQ := Q;
        done_var := done1;
		--Z_out_var := Z_out1;
		--C_out_var := C_out1;
        
        case Q is
            when PC1 =>
                if(opcode="0000" or opcode="0010" or opcode="0001") then
                    nQ := OP1;
                end if;
				if (opcode = "0011") then
					nQ := LH1;
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
                
            when OP2 =>
			    nQ := OP3;
                
            when OP3 =>
				nQ := PC1;
                
			when LHI1 =>
                nQ := OP3;
                
            when OPI1 =>
			    nQ := OPI2;
                
            when OPI2 =>
				nQ := OP3;
				
			when LW1 =>
                nQ := LW2;
                
            when LW2 =>
			    if (opcode(0) = '1') then
					nQ := SW3;
				end if;
				if (opcode(0) = '0') then
					nQ := LW3;
				end if;
                
            when LW3 =>
				nQ := LW4;
			
			when LW4 =>
				nQ := PC1;
			
			when SW3 =>
				nQ := PC1;
			
			when BEQ1 =>
				nQ := BEQ2;
                
            when BEQ2 =>
			    if (Z = '1') then
					nQ := BEQ3;
				end if;
				if (Z = '0') then
					nQ := PC1;
				end if;
                
            when BEQ3 =>
				nQ := PC1;
				
			when JAL1 =>
			    if (opcode(0) = '1') then
					nQ := JLR2;
				end if;
				if (opcode(0) = '0') then
					nQ := BEQ3;
				end if;
				
			when JLR2 =>
				nQ := PC1;
				
			when LM1 =>
			    if (opcode(0) = '1') then
					nQ := SM2;
				end if;
				if (opcode(0) = '0') then
					nQ := LM2;
				end if;
				
			when LM2 =>
				nQ := LM3;
				
			when LM3 =>
			    if (PE_done_ = '0') then
					nQ := LM2;
				else --(PE_done = '1') 
					nQ := PC1;
				end if;
				
			when SM2 =>
				nQ := SM3;
				
			when SM3 =>
			    if (PE_done = '0') then
					nQ := SM2;
				end if;
				else 
					nQ := PC1;
				end if;
                
            when others => 
                nQ := PC1;
            end case;
            
            if(clk'event and (clk = '1')) then
                
                done <= done1;
				--Z_out <= Z_out1;
				--C_out <= C_out1;
				
                if(reset1 = '1') then
                    Q <= PC1;
                else
                    Q <= nQ;
                end if;
            else
            end if;
    end process;
end Behave;