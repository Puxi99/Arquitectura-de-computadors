   
    library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.std_logic_arith.all
    
    
    entity CPU is
        Port (
            clk, reset: in std_logic);
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
            port(clk: in std_logic;
                 Escr: in std_logic;
                 D: in std_logic_vector(31 downto 0);
                 Q: out std_logic_vector(31 downto 0));
        end component;
            
        component memDada
            port(clk, MemRead, MemWrite: in std_logic;
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
                ALUOp : 	out STD_LOGIC_VECTOR (1 downto 0);
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
    signal extSig_sortida-Imm_Din:std_logic_vector(31 downto 0);  --38
    signal Imm_Dout-2Mux2x1_B: std_logic_vector(31 downto 0);  --19
    signal BR_DadaL1-A_Din: std_logic_vector(31 downto 0);  --39
    signal A_Dout-1Mux2x1_B: std_logic_vector(31 downto 0);  --20
    signal BR_DadaL2-B_Din: std_logic_vecotr(31 downto 0);  --40
    signal B_Dout-2Mux2x1_A: std_logic_vector(31 downto 0);  --21
    signal BR_DadaL2-memDada_WD: std_logic_vector(31 downto 0 );  --22
    signal UnitatControl_AluSrcB-2Mux2x1_sel: std_logic;  --23
    signal UnitatControl_AluSrcA-1Mux2x1_sel: std_logic;  --24
    signal 1Mux2x1_O-ALU32_Op1: std_logic_vector(31 downto 0);  --25
    signal 2Mux2x1_O-ALU32_Op2: std_logic_vector(31 downto 0);  --26
    signal UnitatControl_ALUOp-ControlALU_ALUOp: std_logic_vector(1 downto 0);  --27
    signal ControlALU_Control_ALU-ALU32_Control_ALU: std_logic_vector(2 downto 0);  --28
    signal ALU32_Resultat-ALUOut_Din:std_logic_vector(31 downto 0);  --45
    signal ALUOut_Dout-memDada_Add: std_logic_vector(7 downto 0);  --29(Agafa els 7downto0 de aluout)
    signal UnitatControl_MemRead-memDada_MemRead: std_logic;  --30
    signal UnitatControl_MemWrite-memDada_MemWrite: std_logic;  --31
    signal memDada_RD-MDR_Din: std_logic_vector(31 downto 0);  --32
    signal MDR_Dout-4Mux2x1_A: std_logic_vector(31 downto 0);  --44
    signal ALUOut_Dout-3Mux2x1_B: std_logic_vector(31 downto 0);  --33
    signal ALUOut_Dout-4Mux2x1_B: std_logic_vector(31 downto 0);  --34
    signal UnitatControl_MemtoReg-4Mux2x1_sel: std_logic;  --35
    signal sum4_Sortida-NPC_Din:std_logic_vector(31 downto 0);  --46
    signal NPC_Dout-1Mux2x1_A: std_logic_vector(31 downto 0);  --36
    signal NPC_Dout-3Mux2x1_A: std_logic_vector(31 downto 0);  --37
    signal ALU32_zero-SALT_Zero: std_logic;  --41
    signal UnitatControl_PCWriteCond-SALT_PCWriteCond: std_logic;  --42
    signal SALT_Sel-3Mux2x1_Sel: std_logic;  --43
    
    
    begin
    
    PC: PC port map(
        PCin => 3Mux2x1_O-PC_PCin;  --1
        PCout => PC_PCout-memInst_Add;  --2
        PCout => PC_PCout-sum4_Entrada;  --3
        PCWrite => UnitatControl_PCwrite-PC_Esc;  --15
        reset => reset;
        clk => clk);
        
    memInst: memInst port map(
        Add => PC_PCout-memInst_Add;  --2
        RD => memInst_RD-IR_D);  --4
        
    IR: IR port map(
        clk => clk;
        Escr =>UnitatControl_IRWrite-IR_Escr;  --16
        D => memInst_RD-IR_D;  --4
        Q => IR_Q-BR);  --5
       
    mux0_5bits: mux2x1_5bits port map(
        sel => UnitatControl_RegDst-0Mux2x1_sel; --18
        A => BR_20_16-0Mux2x1_A;  --8
        B => BR_15_11-0Mux2x1_B;  --9
        O => 0Mux2x1_O-BR_RegE);  --10
    
    BancRegistres: BancRegistres port map(
        EscReg => UnitatControl_RegWrite-BR_EscReg;  --17
        RegL1 => BR_25_21-RegL1;  --6
        RegL2 =>  BR_20_16-RegL2;  --7
        RegE =>   0Mux2x1_O-BR_RegE;  --10
        DadaE =>  4Mux2x1_O-BR_DadaE;  --13
        DadaL1=>BR_DadaL1-A_Din; --39
        DadaL2=>BR_DadaL2-B_Din); --40
    
    extSig: extSig port map(
        entrada => BR_15_0-extSig_entrada; --11
        sortida => extSig_sortida-Imm_Din);  --38
    
    Imm: reg_32Bits port map(
        clk => clk;
        Din=> extSig_sortida-Imm_Din;  --38
        Dout=> Imm_Dout-2Mux2x1_B);  --19
            
    
    
    A: reg_32Bits port map(
        clk => clk;
        Din=> BR_DadaL1-A_Din;  --39
        Dout=> A_Dout-1Mux2x1_B); --20
    
    B: reg_32Bits port map(
        clk => clk;
        Din=> BR_DadaL2-B_Din;  --40
        Dout=> B_Dout-2Mux2x1_A); --21
    
    mux1: mux2x1_32bits port map(
        sel => UnitatControl_AluSrcA-1Mux2x1_sel;  --24
        A => NPC_Dout-1Mux2x1_A;  --36
        B => A_Dout-1Mux2x1_B;  --20
        O => 1Mux2x1_O-ALU32_Op1);  --25

    mux2: mux2x1_32bits port map(
        sel => UnitatControl_AluSrcB-2Mux2x1_sel;  --23
        A => B_Dout-2Mux2x1_A;  --21
        B => Imm_Dout-2Mux2x1_B;  --19
        O => 2Mux2x1_O-ALU32_Op2);  --26

    ALU32: ALU32 port map(
        Op1 => 1Mux2x1_O-ALU32_Op1;  --25
        Op2 => 2Mux2x1_O-ALU32_Op2;  --26
        Control_ALU => ControlALU_Control_ALU-ALU32_Control_ALU;  --28
        Resultat => ALU32_Resultat-ALUOut_Din;  --45
        Z => ALU32_zero-SALT_Zero;  --41

    ControlALU: ControlALU port map(
        funcio : BR_5_0-ControlAlu_funcio;  --12
        ALUOp : UnitatControl_ALUOp-ControlALU_ALUOp;  --27
        Control_ALU : ControlALU_Control_ALU-ALU32_Control_ALU);  --28

    ALUOut: reg_32bits port map(
        clk => clk;
        Din=> ALU32_Resultat-ALUOut_Din;  --45
        Dout=> ALUOut_Dout-memDada_Add); --29 però i els 8 bits???


    Cond_salt: SALT port map(
        Zero: ALU32_zero-SALT_Zero;  --41
        PCWriteCond: UnitatControl_PCWriteCond-SALT_PCWriteCond;  --42
        Sel: SALT_Sel-3Mux2x1_Sel);  --43
    
    memDada: memDada port map(
        clock => clk
        MemRead => UnitatControl_MemRead-memDada_MemRead;  --30
        MemWrite => UnitatControl_MemWrite-memDada_MemWrite;  --31
        Add => ALUOut_Dout-memDada_Add;  --29 i els 8 bits??
        WD => BR_DadaL2-memDada_WD;  --22
        RD => memDada_RD-MDR_Din;  --32

    
    
    MDR: reg_32bits port map(
        clk => clk;
        Din=> memDada_RD-MDR_Din;  --32
        Dout=> MDR_Dout-4Mux2x1_A); --44
    
    mux4: mux2x1_32bits port map(
        sel => UnitatControl_MemtoReg-4Mux2x1_sel;  --35
        A => MDR_Dout-4Mux2x1_A;  --44
        B => ALUOut_Dout-4Mux2x1_B;  --34
        O => 4Mux2x1_O-BR_DadaE);  --13

    mux3: mux2x1_32bits port map(
        sel => SALT_Sel-3Mux2x1_Sel;  --43
        A => NPC_Dout-3Mux2x1_A;  --37
        B => ALUOut_Dout-3Mux2x1_B;  --33
        O => 3Mux2x1_O-PC_PCin);  --1

    sum4: sum4 port map(
        Entrada => PC_PCout-sum4_Entrada; --3
        Sortida => sum4_Sortida-NPC_Din);  --46

    NPC: reg_32bits port map(
        clk => clk;
        Din=> sum4_Sortida-NPC_Din;  --46
        Dout=> NPC_Dout-1Mux2x1_A); --36