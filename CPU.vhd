<<<<<<< HEAD
 
=======
      
>>>>>>> a2186e2e7d3aed88ec6c6ecc1ace63535c2667c7
    library IEEE;
    use IEEE.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    
    
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
            
         component SALT 
				port(
					 Zero: in std_logic;
			       PCWriteCond: in std_logic;
					 Sel: out std_logic);
			end component;

            
    
    signal Mux2x1_3_O_PC_PCin: std_logic_vector(31 downto 0);  --1
    signal PC_PCout_memInst_Add: std_logic_vector(31 downto 0);  --2
    signal PC_PCout_sum4_Entrada: std_logic_vector(31 downto 0);  --3
    signal memInst_RD_IR_D: std_logic_vector(31 downto 0);  --4
    signal IR_Q_BR:std_logic_vector(31 downto 0);  --5
    signal BR_25_21_RegL1: std_logic_vector(4 downto 0);  --6
    signal BR_20_16_RegL2: std_logic_vector(4 downto 0);  --7
    signal BR_20_16_Mux2x1_0_A: std_logic_vector(4 downto 0);  --8
    signal BR_15_11_Mux2x1_0_B: std_logic_vector(4 downto 0);  --9
    signal Mux2x1_0_O_BR_RegE: std_logic_vector(4 downto 0);  --10
    signal BR_15_0_extSig_entrada: std_logic_vector(15 downto 0);  --11
    signal BR_5_0_ControlAlu_funcio: std_logic_vector(5 downto 0);  --12
    signal Mux2x1_4_O_BR_DadaE: std_logic_vector(31 downto 0);  --13
    signal BR_31_26_UnitatControl_CO: std_logic_vector(5 downto 0);  --14
    signal UnitatControl_PCwrite_PC_Esc: std_logic;  --15
    signal UnitatControl_IRWrite_IR_Escr: std_logic;  --16
    signal UnitatControl_RegWrite_BR_EscReg: std_logic; --17
    signal UnitatControl_RegDst_Mux2x1_0_sel: std_logic;  --18
    signal extSig_sortida_Imm_Din:std_logic_vector(31 downto 0);  --38
    signal Imm_Dout_Mux2x1_2_B: std_logic_vector(31 downto 0);  --19
    signal BR_DadaL1_A_Din: std_logic_vector(31 downto 0);  --39
    signal A_Dout_Mux2x1_1_B: std_logic_vector(31 downto 0);  --20
    signal BR_DadaL2_B_Din: std_logic_vector(31 downto 0);  --40
    signal B_Dout_Mux2x1_2_A: std_logic_vector(31 downto 0);  --21
    signal BR_DadaL2_memDada_WD: std_logic_vector(31 downto 0 );  --22
    signal UnitatControl_AluSrcB_Mux2x1_2_sel: std_logic;  --23
    signal UnitatControl_AluSrcA_Mux2x1_1_sel: std_logic;  --24
    signal Mux2x1_1_O_ALU32_Op1: std_logic_vector(31 downto 0);  --25
    signal Mux2x1_2_O_ALU32_Op2: std_logic_vector(31 downto 0);  --26
    signal UnitatControl_ALUOp_ControlALU_ALUOp: std_logic_vector(1 downto 0);  --27
    signal ControlALU_Control_ALU_ALU32_Control_ALU: std_logic_vector(2 downto 0);  --28
    signal ALU32_Resultat_ALUOut_Din:std_logic_vector(31 downto 0);  --45
    signal ALUOut_Dout_memDada_Add: std_logic_vector(31 downto 0);  --29(Agafa els 7downto0 de aluout)
    signal UnitatControl_MemRead_memDada_MemRead: std_logic;  --30
    signal UnitatControl_MemWrite_memDada_MemWrite: std_logic;  --31
    signal memDada_RD_MDR_Din: std_logic_vector(31 downto 0);  --32
    signal MDR_Dout_Mux2x1_4_A: std_logic_vector(31 downto 0);  --44
    signal ALUOut_Dout_Mux2x1_3_B: std_logic_vector(31 downto 0);  --33
    signal ALUOut_Dout_Mux2x1_4_B: std_logic_vector(31 downto 0);  --34
    signal UnitatControl_MemtoReg_Mux2x1_4_sel: std_logic;  --35
    signal sum4_Sortida_NPC_Din:std_logic_vector(31 downto 0);  --46
    signal NPC_Dout_Mux2x1_1_A: std_logic_vector(31 downto 0);  --36
    signal NPC_Dout_Mux2x1_3_A: std_logic_vector(31 downto 0);  --37
    signal ALU32_zero_SALT_Zero: std_logic;  --41
    signal UnitatControl_PCWriteCond_SALT_PCWriteCond: std_logic;  --42
    signal SALT_Sel_Mux2x1_3_Sel: std_logic;  --43
    
    
    begin
    
    PC_1: PC port map(
        PCin => Mux2x1_3_O_PC_PCin,  --1
        PCout => PC_PCout_memInst_Add,  --2 i 3
        Esc => UnitatControl_PCwrite_PC_Esc,  --15
        reset => reset,
        clk => clk);
        
    memInst_1: memInst port map(
        Add => PC_PCout_memInst_Add,  --2 i 3
        RD => memInst_RD_IR_D);  --4
        
    IR_1: IR port map(
        clk => clk,
        Escr =>UnitatControl_IRWrite_IR_Escr,  --16
        D => memInst_RD_IR_D,  --4
        Q => IR_Q_BR);  --5
       
    mux0_5bits_1: mux2x1_5bits port map(
        sel => UnitatControl_RegDst_Mux2x1_0_sel, --18
        A => IR_Q_BR(20 downto 16),  --8
        B => IR_Q_BR(15 downto 11),  --9
        O => Mux2x1_0_O_BR_RegE);  --10
    
    BancRegistres_1: BancRegistres port map(
		  clk=>clk,
        EscReg => UnitatControl_RegWrite_BR_EscReg,  --17
        RegL1 => IR_Q_BR(25 downto 21),  --6
        RegL2 =>  IR_Q_BR(20 downto 16),  --7
        RegE =>   Mux2x1_0_O_BR_RegE,  --10
        DadaE =>  Mux2x1_4_O_BR_DadaE,  --13
        DadaL1=>BR_DadaL1_A_Din, --39
        DadaL2=>BR_DadaL2_B_Din); --40
    
    extSig_1: extSig port map(
        entrada => IR_Q_BR(15 downto 0), --11
        sortida => extSig_sortida_Imm_Din);  --38
    
    Imm_1: reg_32Bits port map(
        clk => clk,
        Din=> extSig_sortida_Imm_Din,  --38
        Dout=> Imm_Dout_Mux2x1_2_B);  --19
            
    
    
    A_1: reg_32Bits port map(
        clk => clk,
        Din=> BR_DadaL1_A_Din,  --39
        Dout=> A_Dout_Mux2x1_1_B); --20
    
    B_1: reg_32Bits port map(
        clk => clk,
        Din=> BR_DadaL2_B_Din,  --40
        Dout=> B_Dout_Mux2x1_2_A); --21
    
    mux1_1: mux2x1_32bits port map(
        sel => UnitatControl_AluSrcA_Mux2x1_1_sel,  --24
        A => NPC_Dout_Mux2x1_1_A,  --36 i 37
        B => A_Dout_Mux2x1_1_B,  --20
        O => Mux2x1_1_O_ALU32_Op1);  --25

    mux2_1: mux2x1_32bits port map(
        sel => UnitatControl_AluSrcB_Mux2x1_2_sel,  --23
        A => B_Dout_Mux2x1_2_A,  --21
        B => Imm_Dout_Mux2x1_2_B,  --19
        O => Mux2x1_2_O_ALU32_Op2);  --26

    ALU32_1: ALU32 port map(
        Op1 => Mux2x1_1_O_ALU32_Op1,  --25
        Op2 => Mux2x1_2_O_ALU32_Op2,  --26
        Control_ALU => ControlALU_Control_ALU_ALU32_Control_ALU,  --28
        Resultat => ALU32_Resultat_ALUOut_Din,  --45
        Z => ALU32_zero_SALT_Zero);  --41

    ControlALU_1: ControlALU port map(
        funcio => IR_Q_BR(5 downto 0),  --12
        ALUOp => UnitatControl_ALUOp_ControlALU_ALUOp,  --27
        Control_ALU => ControlALU_Control_ALU_ALU32_Control_ALU);  --28

    ALUOut_1: reg_32bits port map(
        clk => clk,
        Din=> ALU32_Resultat_ALUOut_Din,  --45
        Dout=> ALUOut_Dout_memDada_Add); --29,33 i 34


    Cond_salt_1: SALT port map(
        Zero=> ALU32_zero_SALT_Zero,  --41
        PCWriteCond=> UnitatControl_PCWriteCond_SALT_PCWriteCond,--42
        Sel=> SALT_Sel_Mux2x1_3_Sel);  --43
    
    memDada_1: memDada port map(
        clk => clk,
        MemRead => UnitatControl_MemRead_memDada_MemRead,  --30
        MemWrite => UnitatControl_MemWrite_memDada_MemWrite,  --31
        Add =>ALUOut_Dout_memDada_Add(7 downto 0),  --29, 33 i 34
        WD => Mux2x1_1_O_ALU32_Op1,  --21
        RD => memDada_RD_MDR_Din);  --32

    
    
    MDR_1: reg_32bits port map(
        clk => clk,
        Din=> memDada_RD_MDR_Din,  --32
        Dout=> MDR_Dout_Mux2x1_4_A); --44
    
    mux4_1: mux2x1_32bits port map(
        sel => UnitatControl_MemtoReg_Mux2x1_4_sel,  --35
        A => MDR_Dout_Mux2x1_4_A,  --44
        B => ALUOut_Dout_memDada_Add,  --33,34 i 29
        O => Mux2x1_4_O_BR_DadaE);  --13

    mux3_1: mux2x1_32bits port map(
        sel => SALT_Sel_Mux2x1_3_Sel,  --43
        A => NPC_Dout_Mux2x1_1_A,  --36 i 37
        B => ALUOut_Dout_memDada_Add,  --29 i 33
        O => Mux2x1_3_O_PC_PCin);  --1

    sum4_1: sum4 port map(
        Entrada =>  PC_PCout_memInst_Add, --2 i 3
        Sortida => sum4_Sortida_NPC_Din);  --46
    
    NPC_1: reg_32bits port map(
        clk => clk,
        Din=> sum4_Sortida_NPC_Din,  --46
        Dout=> NPC_Dout_Mux2x1_1_A); --36 i 37

    UnitatControl_1: UnitatControl port map(
        Reset => reset,
        clk => clk,
        CO => IR_Q_BR(31 downto 26),
        RegDst => UnitatControl_RegDst_Mux2x1_0_sel,  --18
        PCWrite => UnitatControl_PCwrite_PC_Esc,  --15
        MemtoReg => UnitatControl_MemtoReg_Mux2x1_4_sel,  --35
        MemRead =>UnitatControl_MemRead_memDada_MemRead,  --30
        MemWrite =>UnitatControl_MemWrite_memDada_MemWrite,  --31
        PCWriteCond =>UnitatControl_PCWriteCond_SALT_PCWriteCond,  --42
        ALUOp =>UnitatControl_ALUOp_ControlALU_ALUOp,  --27
        RegWrite =>UnitatControl_RegWrite_BR_EscReg,  --17
        IRWrite =>UnitatControl_IRWrite_IR_Escr,  --16
        ALUSrcA =>UnitatControl_AluSrcA_Mux2x1_1_sel,  --24
        ALUSrcB =>UnitatControl_AluSrcB_Mux2x1_2_sel);  --23
	end arch;