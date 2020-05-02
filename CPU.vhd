library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all


entity CPU is
    Port (
        clock, reset: in std_logic);
end CPU;

architecture arch of CPU is
    component PC
        port(clk,Reset,Esc: in std_logic;
             PCin: in std_logic_vector(31 downto 0);
             PCout: out std_logic_vector(31 downto 0));
    end component;
    
    component ALU32
        port(Op1,Op2: in STD_LOGIC_VECTOR (31 downto 0);
            Control_ALU: in STD_LOGIC_VECTOR (2 downto 0);
            Resultat: out STD_LOGIC_VECTOR (31 downto 0);
            Z: out STD_LOGIC;
            C: out STD_LOGIC);
    end component;
    
        
    component ControlALU
        port(funcio : in STD_LOGIC_VECTOR (5 downto 0);
             ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
             Control_ALU : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    component BancRegistres
        port(clk : in STD_LOGIC;
              EscReg: in STD_LOGIC;
              RegL1: in STD_LOGIC_VECTOR (4 downto 0);
              RegL2: in STD_LOGIC_VECTOR (4 downto 0);
              RegE: in STD_LOGIC_VECTOR (4 downto 0);
              DadaE: in STD_LOGIC_VECTOR (31 downto 0);
              DadaL1: out STD_LOGIC_VECTOR (31 downto 0);
              DadaL2: out STD_LOGIC_VECTOR (31 downto 0));
    end component;

        
        
    component extSig
        port(entrada: in std_logic_vector(15 downto 0);
        sortida: out std_logic_vector(31 downto 0));
    end component;

    component IR
        port(clock: in std_logic;
		     Escr: in std_logic;
             D: in std_logic_vector(31 downto 0);
             Q: out std_logic_vector(31 downto 0));
    end component;
        
    component memDada
        port(clock, MemRead, MemWrite: in std_logic;
            Add: in std_logic_vector(7 downto 0);
            WD: in std_logic_vector(31 downto 0);
            RD: out std_logic_vector(31 downto 0));
    end component;
    
    component memInst
        port(Add : in  STD_LOGIC_VECTOR (31 downto 0);
             RD : out  STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component mux2x1_5bits
        port(sel: in std_logic;
            A, B: in std_logic_vector(4 downto 0);
            O: out std_logic_vector(4 downto 0));
    end component;

    component mux2x1_32bits
        port(sel: in std_logic;
		A, B: in std_logic_vector(31 downto 0);
		O: out std_logic_vector(31 downto 0));
    end component;
    
    component reg_32bits
        port(clk : in STD_LOGIC;
		Din : in  STD_LOGIC_VECTOR (31 downto 0);
		Dout : out  STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component sum4
        port(Entrada : in  std_logic_vector (31 downto 0);
		    Sortida : out  std_logic_vector (31 downto 0));
    end component;
    
    component UnitatControl
        port(Reset :      in STD_LOGIC;
            clk :        in STD_LOGIC;
            CO :         in STD_LOGIC_VECTOR (5 downto 0); 
            RegDst :     out STD_LOGIC;
            PCWrite :    out STD_LOGIC;
            MemtoReg :   out STD_LOGIC;
            MemRead :    out STD_LOGIC;
            MemWrite :   out STD_LOGIC;
            PCWriteCond :out STD_LOGIC;
            ALUOp : 		out STD_LOGIC_VECTOR (1 downto 0);
            RegWrite : 	out STD_LOGIC;
            IRWrite : 	out STD_LOGIC;
            ALUSrcA : 	out STD_LOGIC;
            ALUSrcB : 	out STD_LOGIC);
       end component;
        
        
        
        
signal 3Mux2x1_O-PC_PCin: std_logic_vector(31 downto 0);  --1
signal PC_PCout-memInst_Add: std_logic_vector(31 downto 0);  --2
signal PC_PCout-sum4_Entrada: std_logic_vector(31 downto 0);  --3
signal memInst_RD-IR_D: std_logic_vector(31 downto 0);  --4
signal IR_Q-BR:std_logic_vector(31 downto 0);  --5
signal BR_25_21-RegL1: std_logic_vector(4 downto 0);  --6
signal BR_20_16-RegL2: std_logic_vector(4 downto 0);  --7
signal BR_20_16-0Mux2x1_A: std_logic_vector(4 downto 0);  --8
signal BR_15_11-0Mux2x1_B: std_logic_vector(4 downto 0);  --9
signal 0Mux2x1_O-BR_RegE: std_logic_vector(4 downto 0);  --10
signal BR_15_0-extSig_entrada: std_logic_vector(15 downto 0);  --11
signal BR_5_0-ControlAlu_funcio: std_logic_vector(5 downto 0);  --12
signal 4Mux2x1_O-BR_DadaE: std_logic_vector(5 downto 0);  --13
signal BR_31_26-UnitatControl_CO: std_logic_vector(5 downto 0);  --14
signal UnitatControl_PCwrite-PC_Esc: std_logic;  --15
signal UnitatControl_IRWrite-IR_Escr: std_logic;  --16
signal UnitatControl_RegWrite-BR_EscReg: std_logic;  --17
signal UnitatControl_RegDst-0Mux2x1_sel: std_logic;  --18
signal extSig_sortida_2Mux2x1_B: std_logic_vector(31 downto 0);  --19
signal BR_DadaL1-1Mux2x1_B: std_logic_vector(31 downto 0);  --20
signal BR_DadaL2-2Mux2x1_A: std_logic_vector(31 downto 0);  --21
signal BR_DadaL2-memDada_WD: std_logic_vector(31 downto 0 );  --22
signal UnitatControl_AluSrcB-2Mux2x1_sel: std_logic;  --23
signal UnitatControl_AluSrcA-1Mux2x1_sel: std_logic;  --24
signal 1Mux2x1_O-ALU32_Op1: std_logic_vector(31 downto 0);  --25
signal 2Mux2x1_O-ALU32_Op2: std_logic_vector(31 downto 0);  --26
signal UnitatControl_ALUOp-ControlALU_ALUOp: std_logic_vector(1 downto 0);  --27
signal ControlALU_Control_ALU-ALU32_Control_ALU: std_logic_vector(2 downto 0);  --28
signal ALU32_Resultat-memDada_Add: std_logic_vector(7 downto 0);  --29
signal UnitatControl_MemRead-memDada_MemRead: std_logic;  --30
signal UnitatControl_MemWrite-memDada_MemWrite: std_logic;  --31
signal memDada_RD-4Mux2x1_A: std_logic_vector(31 downto 0);  --32
signal ALU32_Resultat-3Mux2x1_B: std_logic_vector(31 downto 0);  --33
signal ALU32_Resultat-4Mux2x1_B: std_logic_vector(31 downto 0);  --34
signal UnitatControl_MemtoReg-4Mux2x1_sel: std_logic;  --35
signal sum4_Sortida-0Mux2x1_A: std_logic_vector(31 downto 0);  --36
signal sum4_Sortida-3Mux2x1_A: std_logic_vector(32 downto 0);  --37
-- falta el sel del multiplexor 3!!!

