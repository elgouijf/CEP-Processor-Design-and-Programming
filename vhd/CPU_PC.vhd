library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PKG.all;


entity CPU_PC is
    generic(
        mutant: integer := 0
    );
    Port (
        -- Clock/Reset
        clk    : in  std_logic ;
        rst    : in  std_logic ;

        -- Interface PC to PO
        cmd    : out PO_cmd ;
        status : in  PO_status
        
    );
end entity;

architecture RTL of CPU_PC is
    type State_type is (
        S_Error,
        S_Init,
        S_Pre_Fetch,
        S_Fetch,
        S_Decode,
        S_LUI,
        S_ADDi,
        S_ADD,
        S_AND,
        S_OR,
        S_ORi,
        S_ANDi,
        S_XOR,
        S_XORi,
        S_SUB,
        S_SLL, 
        S_SRL,
        S_SRA,
        S_SRAi,
        S_SLLi,
        S_SRLi,
        S_AUIPC,
        S_BEQ,
        S_BNE,
        S_BGEU,
        S_BLT,
        S_BGE,
        S_BLTU,
        S_SLTi,
        S_SLTU,
        S_SLTiU,
        S_SLT,
        S_LW,
        S_LW1,
        S_LW2,
        S_SW,
        S_SW1,
        S_SW2,
        S_JAL, 
        S_LB,
        S_LB1,
        S_LB2,
        S_LBU,
        S_LBU1,
        S_LBU2,
        S_LH,
        S_LH1,
        S_LH2,
        S_LHU,
        S_LHU1,
        S_LHU2,
        S_SB,
        S_SB1,
        S_SH,
        S_SH1,
        S_JALR,
        S_CSRR,
        S_INTERRUPTION_1,
        S_MRET
    );

    signal state_d, state_q : State_type;


begin

    FSM_synchrone : process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                state_q <= S_Init;
            else
                state_q <= state_d;
            end if;
        end if;
    end process FSM_synchrone;

    FSM_comb : process (state_q, status)
    begin

        -- Valeurs par défaut de cmd 
        cmd.ALU_op <= ALU_plus;
        cmd.LOGICAL_op <= LOGICAL_and;
        cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
       
        cmd.SHIFTER_op <= SHIFT_rl;
        cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
       
        cmd.RF_we <= '0';
        cmd.RF_SIZE_sel <= RF_SIZE_word;
        cmd.RF_SIGN_enable <= '0';
        cmd.DATA_sel <= DATA_from_alu;
       
        cmd.PC_we <= '0';
        cmd.PC_sel <= PC_from_alu; 
       
        cmd.PC_X_sel <= PC_X_cst_x00;
        cmd.PC_Y_sel <= PC_Y_cst_x04;
       
        cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
       
        cmd.AD_we <= '0';
        cmd.AD_Y_sel <= AD_Y_immI;
       
        cmd.IR_we <= '0';
       
        cmd.ADDR_sel <= ADDR_from_pc;
        cmd.mem_we <= '0';
        cmd.mem_ce <= '0';
       
        cmd.cs.CSR_we <= CSR_none;
       
        cmd.cs.TO_CSR_sel <= TO_CSR_from_rs1;
        cmd.cs.CSR_sel <= CSR_from_mcause;
        cmd.cs.MEPC_sel <= MEPC_from_pc;
       
        cmd.cs.MSTATUS_mie_set <= '0';
        cmd.cs.MSTATUS_mie_reset <= '0';
       
        cmd.cs.CSR_WRITE_mode <= WRITE_mode_simple;
       
        state_d <= state_q;

        case state_q is
            when S_Error =>
                -- Etat transitoire en cas d'instruction non reconnue 
                -- Aucune action
                state_d <= S_Init;

            when S_Init =>
                -- PC <- RESET_VECTOR
                cmd.PC_we <= '1';
                cmd.PC_sel <= PC_rstvec;
                state_d <= S_Pre_Fetch;

            when S_Pre_Fetch =>
                -- mem[PC]
                cmd.mem_we <= '0' ;
                cmd.mem_ce <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                state_d <= S_Fetch;

            when S_Fetch =>
                cmd.IR_we <= '1';
                --cas d'interruption
                if status.IT = true then 
                     state_d <= S_INTERRUPTION_1;
                else 
                    -- IR <- mem_datain
                    state_d <= S_Decode;
                end if; 

            when S_Decode => 
                -- Pour l'instrcution auipc et les instructions
                -- de branchement, pas d'incrémentation de PC au niveau
                -- de cet état
                
                -- Lecture des opcodes pour identifier l'instruction courante
                if status.IR(6 downto 0) = "0010111" then 
                    -- AUIPC
                    state_d <= S_AUIPC ;
                elsif status.IR(6 downto 0) = "1101111" then
                    -- JAL
                    state_d <= S_JAL ;
                elsif status.IR(6 downto 0) = "1100111" then
                    -- JALR
                    state_d <= S_JALR ;
                
                -- Instructions de branchements
                elsif status.IR(6 downto 0) = "1100011" then 
                    if status.IR(14 downto 12) = "000" then
                        -- BEQ
                        state_d <= S_BEQ ;
                    elsif status.IR(14 downto 12) = "001" then
                        -- BNE
                        state_d <= S_BNE ;
                    elsif status.IR(14 downto 12) = "111" then
                        -- BGEU
                        state_d <= S_BGEU ; 
                    elsif status.IR(14 downto 12) = "100" then
                        -- BLT
                        state_d <= S_BLT ; 
                    elsif status.IR(14 downto 12) = "101" then
                        -- BGE
                        state_d <= S_BGE ;
                    elsif status.IR(14 downto 12) = "110" then
                        -- BLTU
                        state_d <= S_BLTU ;
                    end if;
                else
                    -- pour le reste des instruction il faut incrémenter pc dand l'etat Decode
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04 ;
                    cmd.PC_sel <= PC_from_pc ;
                    cmd.PC_we <= '1' ;
                    
                    -- Identification des instructions via leurs opcodes
                    if status.IR(6 downto 0) = "0110111" then
                        -- LUI
                        state_d <= S_LUI ;

                    -- les instructions de chargement depuis la memoire
                    elsif status.IR(6 downto 0) = "0000011" then 
                        if status.IR(14 downto 12) = "010" then
                            -- LW
                            state_d <= S_LW;
                        elsif status.IR(14 downto 12) = "000" then
                            -- LB
                            state_d <= S_LB ; 
                        elsif status.IR(14 downto 12) = "100" then
                            -- LBU
                            state_d <= S_LBU ;
                        elsif status.IR(14 downto 12) = "001" then
                            -- LH
                            state_d <= S_LH ;
                        elsif status.IR(14 downto 12) = "101" then
                            -- LHU
                            state_d <= S_LHU ;
                        end if; 
                    
                    -- les instructions de stockage en memoire
                    elsif status.IR(6 downto 0) = "0100011" then 
                        if status.IR(14 downto 12) = "010" then
                            -- SW
                            state_d <= S_SW;
                        elsif status.IR(14 downto 12) = "000" then
                            -- SB
                            state_d <= S_SB ;
                        elsif status.IR(14 downto 12) = "001" then
                            -- SH
                            state_d <= S_SH ;
                        end if ;
                    
                    -- les opérations arithmétiques et logiques à immédiat
                    elsif status.IR(6 downto 0) = "0010011" then
                        --ADDi
                        if status.IR(14 downto 12) = "000" then
                            state_d <= S_ADDi ;
                        --ORi    
                        elsif status.IR(14 downto 12) = "110" then
                            state_d <= S_ORi ;
                        --XORi    
                        elsif status.IR(14 downto 12) = "100" then
                            state_d <= S_XORi ;
                        --ANDi
                        elsif status.IR(14 downto 12) = "111" then
                            state_d <= S_ANDi ;
                        -- SLTi
                        elsif status.IR(14 downto 12) = "010" then
                            state_d <= S_SLTi ;
                        -- SLTiU
                        elsif status.IR(14 downto 12) = "011" then
                            state_d <= S_SLTiU ;
                        end if;
                        
                        -- les opération de décalage
                        if status.IR(31 downto 25) = "0100000" then
                            -- SRAi
                            if status.IR(14 downto 12) = "101" then 
                                state_d <= S_SRAi ;
                            end if ;
                        elsif status.IR(31 downto 25) = "0000000" then
                            -- SLLi
                            if status.IR(14 downto 12) = "001" then
                                state_d <= S_SLLi ;
                            -- SRLi
                            elsif status.IR(14 downto 12) = "101" then
                                state_d <= S_SRLi ;
                            end if ;
                        end if ;
                        
                    -- les opérations arithmétiques et logiques à registre
                    elsif status.IR(6 downto 0) = "0110011" then 
                        if status.IR(31 downto 25) = "0000000" then
                            --ADD
                            if status.IR(14 downto 12) = "000" then
                                state_d <= S_ADD ;
                            --AND
                            elsif status.IR(14 downto 12) = "111" then 
                                state_d <= S_AND ;
                            --OR
                            elsif status.IR(14 downto 12) = "110" then
                                state_d <= S_OR ;
                            --XOR
                            elsif status.IR(14 downto 12) = "100" then
                                state_d <= S_XOR ;
                            --SLL
                            elsif status.IR(14 downto 12) = "001" then
                                state_d <= S_SLL ;
                            --SRL
                            elsif status.IR(14 downto 12) = "101" then
                                state_d <= S_SRL ;
                            --STL
                            elsif status.IR(14 downto 12) = "010" then
                                state_d <= S_SLT ;
                            -- SLTU
                            elsif status.IR(14 downto 12) = "011" then
                                state_d <= S_SLTU ;
                            end if;

                        
                        elsif status.IR(31 downto 25) = "0100000" then
                            -- SUB
                            if status.IR(14 downto 12) = "000" then
                                state_d <= S_SUB ;
                            -- SRA
                            elsif status.IR(14 downto 12) = "101" then
                                state_d <= S_SRA ;
                            end if ;
                        end if ;  

                        -- Instructions d'interruption
                        elsif status.IR(6 downto 0) = "1110011" then 
                            -- MRET
                            if status.IR(14 downto 12) = "000" then
                                state_d <= S_MRET;
                            -- CSRR
                            else
                                state_d <= S_CSRR;
                            end if;   
                    else 
                        state_d <= S_Error ;
                    end if ;
                end if ;

        -- Décodage effectif des instructions

---------- Instructions avec immediat de type U ----------
            when S_LUI => 
                -- rd <- ImmuU + 0
                cmd.PC_X_sel <= PC_X_cst_x00 ; 
                cmd.PC_Y_sel <= PC_Y_immU ;
                cmd.RF_we <= '1' ; 
                cmd.DATA_sel <= DATA_from_pc ;
                                -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;
            
            when S_AUIPC =>
                cmd.PC_X_sel <= PC_X_pc ;
                cmd.PC_Y_sel <= PC_Y_immU ;
                cmd.RF_we <= '1' ;
                cmd.DATA_sel <= DATA_from_pc ;
                -- Incrémentation de PC 
                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04 ;
                cmd.PC_sel <= PC_from_pc ;
                cmd.PC_we <= '1' ;
                -- next state
                state_d <= S_Pre_Fetch ;

---------- Instructions arithmétiques et logiques ----------
            when S_ADDi => 
                -- On séléctionne le signal immI à l'entrée Y du +/-
                cmd.ALU_Y_sel <= ALU_Y_immI ;
                -- Comme on effectue une addition, l'opérateur séléctionné est +
                cmd.ALU_op <= ALU_plus ;
                -- Le résultat doit être écrit dans rd = IR[11:7],
                -- donc on permet l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du +/- (ALU)
                cmd.DATA_sel <= DATA_from_alu ;
                                -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_ADD =>
                -- On séléctionne le signal rs2_q à l'entrée Y du +/-
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2 ;
                -- Comme on effectue une addition, l'opérateur séléctionné est +
                cmd.ALU_op <= ALU_plus ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du +/-
                cmd.DATA_sel <= DATA_from_alu ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_AND =>
                -- On séléctionne le signal rs2_q à l'entrée Y de logical
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2 ;
                -- Comme on effectue un and, l'opérateur séléctionné est and
                cmd.LOGICAL_op <= LOGICAL_and ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du logical
                cmd.DATA_sel <= DATA_from_logical ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            When S_OR => 
                -- On séléctionne le signal rs2_q à l'entrée Y de logical   
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2 ;
                -- Comme on effectue un or, l'opérateur séléctionné est or
                cmd.LOGICAL_op <= LOGICAL_or ;
                -- Autorisation de l'écriture dans RF 
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du logical
                cmd.DATA_sel <= DATA_from_logical ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;
            
            When S_ORi => 
                -- On séléctionne le signal imm_I à l'entrée Y de logical
                cmd.ALU_Y_sel <= ALU_Y_immI ;
                -- Comme on effectue un or, l'opérateur séléctionné est or
                cmd.LOGICAL_op <= LOGICAL_or ;
                -- Autorisation de l'écriture dans RF 
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du logical
                cmd.DATA_sel <= DATA_from_logical ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            When S_ANDi => 
                -- On séléctionne le signal imm_I à l'entrée Y de logical
                cmd.ALU_Y_sel <= ALU_Y_immI ;
                -- Comme on effectue un and, l'opérateur séléctionné est and
                cmd.LOGICAL_op <= LOGICAL_and ;
                -- Autorisation de l'écriture dans RF 
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du logical
                cmd.DATA_sel <= DATA_from_logical ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            When S_XOR => 
                -- On séléctionne le signal rs2_q à l'entrée Y de logical
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2 ;
                -- Comme on effectue un xor, l'opérateur séléctionné est xor
                cmd.LOGICAL_op <= LOGICAL_xor ;
                -- Autorisation de l'écriture dans RF 
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du logical
                cmd.DATA_sel <= DATA_from_logical ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            When S_XORi => 
                -- On séléctionne le signal imm_I à l'entrée Y de logical            
                cmd.ALU_Y_sel <= ALU_Y_immI ;
                -- Comme on effectue un xori, l'opérateur séléctionné est and
                cmd.LOGICAL_op <= LOGICAL_xor ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du logical
                cmd.DATA_sel <= DATA_from_logical ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;
            
            when S_SUB => 
                -- On séléctionne le signal rs2_q à l'entrée Y du +/-
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2 ;
                -- Comme on effectue une soustraction, l'opérateur séléctionné est -
                cmd.ALU_op <= ALU_minus ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du +/-
                cmd.DATA_sel <= DATA_from_alu ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;
            
            when S_SLL =>
            
                -- On séléctionne le signal rs2_q à l'entrée Y du shifter
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2 ; 
                -- Opération de décalage à gauche => opérateur = SHIFT_ll
                cmd.SHIFTER_op <= SHIFT_ll ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du shifter
                cmd.DATA_sel <= DATA_from_shifter ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;
            
            when S_SRL =>
                -- On séléctionne le signal rs2_q à l'entrée Y du shifter
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2 ; 
                -- Opération de décalage à à droite => opérateur = SHIFT_rl
                cmd.SHIFTER_op <= SHIFT_rl ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du shifter
                cmd.DATA_sel <= DATA_from_shifter ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_SRA =>
                -- On séléctionne le signal rs2_q à l'entrée Y du shifter
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2 ; 
                -- Opération de décalage arithmétique à droite => opérateur = SHIFT_ra
                cmd.SHIFTER_op <= SHIFT_ra ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du shifter
                cmd.DATA_sel <= DATA_from_shifter ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_SRAi =>
                -- On séléctionne le signal ir_sh à l'entrée Y du shifter
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh ; 
                -- Opération de décalage arithmétique à droite => opérateur = SHIFT_ra
                cmd.SHIFTER_op <= SHIFT_ra ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du shifter
                cmd.DATA_sel <= DATA_from_shifter ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_SLLi =>
                -- On séléctionne le signal ir_sh à l'entrée Y du shifter
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh ; 
                -- Opération de décalage immédiat à gauche => opérateur = SHIFT_ll
                cmd.SHIFTER_op <= SHIFT_ll ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du shifter
                cmd.DATA_sel <= DATA_from_shifter ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_SRLi =>
                -- On séléctionne le signal ir_sh à l'entrée Y du shifter
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh ; 
                -- Opération de décalage immédiat à droite => opérateur = SHIFT_rl
                cmd.SHIFTER_op <= SHIFT_rl ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du shifter
                cmd.DATA_sel <= DATA_from_shifter ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_SLT =>
                -- La deuxième entrée provient du multiplexeur géré par le signal de sélection ALU_Y_sel
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2 ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du CPU_CND
                cmd.DATA_sel <= DATA_from_slt; 
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_SLTi =>
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du CPU_CND
                cmd.DATA_sel <= DATA_from_slt; 
                -- La deuxième entrée provient du multiplexeur géré par le signal de sélection ALU_Y_sel
                cmd.ALU_Y_sel <= ALU_Y_immI ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_SLTU =>
                -- La deuxième entrée provient du multiplexeur géré par le signal de sélection ALU_Y_sel
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2 ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du CPU_CND
                cmd.DATA_sel <= DATA_from_slt; 
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_SLTiU =>
                -- La deuxième entrée provient du multiplexeur géré par le signal de sélection ALU_Y_sel
                cmd.ALU_Y_sel <= ALU_Y_immI ;
                -- Autorisation de l'écriture dans RF
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la sortie du CPU_CND
                cmd.DATA_sel <= DATA_from_slt; 
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;                

        
---------- Instructions de saut ----------
            when S_BEQ | S_BNE | S_BGEU | S_BLT | S_BGE | S_BLTU =>
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2 ;
                cmd.PC_sel <= PC_from_pc ;
                cmd.PC_we <= '1' ;
                if status.jcond then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB ;
                else 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04 ;
                end if;
                -- On transite à l'état S_PRE_Fetch
                state_d <= S_Pre_Fetch ;


---------- Instructions de chargement à partir de la mémoire ----------
            When S_LW => 
                -- ADDR est la somme de la valeur dans rs1 et celle d'un immédiat de type I
                cmd.AD_Y_sel <=  AD_Y_immI ;
                cmd.AD_we <= '1' ;
                state_d <= S_LW1 ;
    
            when S_LW1 =>
                -- ADDR s'attend à une adresse calculé dans l'additionneur
                cmd.ADDR_sel <= ADDR_from_ad ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                state_d <= S_LW2 ;

            when S_LW2 =>
                -- Auotisation d'ecriture dans le registre
                cmd.RF_we <= '1' ;
                -- Ce qu'on écrit dans RF provient de la mémoire sans changement
                cmd.DATA_sel <= DATA_from_mem ;
                -- lw charge un mot
                cmd.RF_SIZE_sel <= RF_SIZE_word ;
                -- pqs d'extension de signe
                cmd.RF_SIGN_enable <= '0' ;
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_LB => 
                -- @ = somme rs1 et immI
                cmd.AD_Y_sel <= AD_Y_immI ; 
                cmd.AD_we <= '1' ;
                state_d <= S_LB1 ; -- Passer au cycle suivant pour avoir l'@ effective

            when S_LB1 => 
                -- Récupération de l'@ calculée dans l'additionneur
                cmd.ADDR_sel <= ADDR_from_ad ; 
                cmd.mem_ce <= '1' ;     -- mémoire activée pour la lecture depuis l'@ calculée
                cmd.mem_we <= '0' ;
                state_d <= S_LB2 ;

            when S_LB2 => 
                -- Autorisation de l'écriture dans le registre
                cmd.RF_we <= '1' ;
                -- La donnée provient de la mémoire 
                cmd.DATA_sel <= DATA_from_mem ;
                -- Taille du mot lu : byte
                cmd.RF_SIZE_sel <= RF_SIZE_byte ; 
                cmd.RF_SIGN_enable <= '1' ;     -- activation de l'extension de signe
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_LBU => 
            -- @ = somme rs1 et immI
            cmd.AD_Y_sel <= AD_Y_immI ; 
            cmd.AD_we <= '1' ;
            state_d <= S_LBU1; -- Passer au cycle suivant pour avoir l'@ effective
    
            when S_LBU1 => 
                -- Récupération de l'@ calculée dans l'additionneur
                cmd.ADDR_sel <= ADDR_from_ad ; 
                cmd.mem_ce <= '1' ;     -- mémoire activée pour la lecture depuis l'@ calculée
                cmd.mem_we <= '0' ;
                state_d <= S_LBU2 ;

            when S_LBU2 => 
                -- Autorisation de l'écriture dans le registre
                cmd.RF_we <= '1' ;
                -- La donnée provient de la mémoire 
                cmd.DATA_sel <= DATA_from_mem ;
                -- Taille du mot lu : byte
                cmd.RF_SIZE_sel <= RF_SIZE_byte ; 
                cmd.RF_SIGN_enable <= '0' ;     -- pas d'extension de signe
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_LH => 
            -- @ = somme rs1 et immI
            cmd.AD_Y_sel <= AD_Y_immI ; 
            cmd.AD_we <= '1' ;
            state_d <= S_LH1 ; -- Passer au cycle suivant pour avoir l'@ effective
    
            when S_LH1 => 
                -- Récupération de l'@ calculée dans l'additionneur
                cmd.ADDR_sel <= ADDR_from_ad ; 
                cmd.mem_ce <= '1' ;     -- mémoire activée pour la lecture depuis l'@ calculée
                cmd.mem_we <= '0' ;
                state_d <= S_LH2 ;

            when S_LH2 => 
                -- Autorisation de l'écriture dans le registre
                cmd.RF_we <= '1' ;
                -- La donnée provient de la mémoire 
                cmd.DATA_sel <= DATA_from_mem ;
                -- Taille du mot lu : half
                cmd.RF_SIZE_sel <= RF_SIZE_half ; 
                cmd.RF_SIGN_enable <= '1' ;     -- activation de l'extension de signe
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;

            when S_LHU => 
            -- @ = somme rs1 et immI
            cmd.AD_Y_sel <= AD_Y_immI ; 
            cmd.AD_we <= '1' ;
            state_d <= S_LHU1 ; -- Passer au cycle suivant pour avoir l'@ effective
    
            when S_LHU1 => 
                -- Récupération de l'@ calculée dans l'additionneur
                cmd.ADDR_sel <= ADDR_from_ad ; 
                cmd.mem_ce <= '1' ;     -- mémoire activée pour la lecture depuis l'@ calculée
                cmd.mem_we <= '0' ;
                state_d <= S_LHU2 ;

            when S_LHU2 => 
                -- Autorisation de l'écriture dans le registre
                cmd.RF_we <= '1' ;
                -- La donnée provient de la mémoire 
                cmd.DATA_sel <= DATA_from_mem ;
                -- Taille du mot lu : half
                cmd.RF_SIZE_sel <= RF_SIZE_half ; 
                cmd.RF_SIGN_enable <= '0' ;     -- pas d'extension de signe
                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;
    
---------- Instructions de sauvegarde en mémoire ----------
            When S_SW => 
                -- ADDR est la somme de la valeur dans rs1 et celle d'un immédiat de type S
                cmd.AD_Y_sel <=  AD_Y_immS ;
                cmd.AD_we <= '1' ;
                state_d <= S_SW1 ;

            when S_SW1 =>
                -- ADDR s'attend à une adresse calculée dans l'additionneur
                cmd.ADDR_sel <= ADDR_from_ad ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '1' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Pre_Fetch ;

             When S_SB => 
                -- ADDR est la somme de la valeur dans rs1 et celle d'un immédiat de type S
                cmd.AD_Y_sel <=  AD_Y_immS ;
                cmd.AD_we <= '1' ;
                state_d <= S_SB1 ;

            when S_SB1 =>
                -- ADDR s'attend à une adresse calculée dans l'additionneur
                cmd.ADDR_sel <= ADDR_from_ad ;
                -- Taille du mot stocke : byte
                cmd.RF_SIZE_sel <= RF_SIZE_byte ; 
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '1' ;     -- autorisation d'ecriture dans la memoire
                -- On repasse à l'état S_Fetch
                state_d <= S_Pre_Fetch ;

             When S_SH => 
                -- ADDR est la somme de la valeur dans rs1 et celle d'un immédiat de type S
                cmd.AD_Y_sel <=  AD_Y_immS ;
                cmd.AD_we <= '1' ;
                state_d <= S_SH1 ;

            when S_SH1 =>
                -- ADDR s'attend à une adresse calculée dans l'additionneur
                cmd.ADDR_sel <= ADDR_from_ad ;
                -- Taille du mot stocke : half
                cmd.RF_SIZE_sel <= RF_SIZE_half ; 
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '1' ;     -- autorisation d'ecriture dans la memoire
                -- On repasse à l'état S_Fetch
                state_d <= S_Pre_Fetch ;
                        
            when S_JAL =>
                cmd.PC_X_sel <= PC_X_pc ;
                cmd.PC_Y_sel <= PC_Y_cst_x04 ;
                cmd.RF_we <= '1' ;
                cmd.DATA_sel <= DATA_from_pc ;
                -- Incrémentation de PC 
                cmd.TO_PC_Y_sel <= TO_PC_Y_immJ ;
                cmd.PC_sel <= PC_from_pc ;
                cmd.PC_we <= '1' ;
                -- next state
                state_d <= S_Pre_Fetch ;

            when S_JALR =>
                -- Sauvegarde de l'@ de l’instruction suivant le jalr dans le regsitre
                cmd.PC_X_sel <= PC_X_pc ;
                cmd.PC_Y_sel <= PC_Y_cst_x04 ;
                cmd.RF_we <= '1' ;
                cmd.DATA_sel <= DATA_from_pc ;

                -- immI + rs1 
                cmd.ALU_op <= ALU_plus ;
                cmd.ALU_Y_sel <= ALU_Y_immI ;

                -- mettre l'@ de saut dans pc
                cmd.PC_sel <= PC_from_alu ;
                cmd.PC_we <= '1' ;

                -- aller au next state
                state_d <= S_Pre_Fetch ;
            

---------- Instructions d'accès aux CSR ----------
            when S_CSRR =>
                -- Autorisation de l'écriture dans le registre
                cmd.RF_we <= '1' ;
                -- La donnée à mettre dans rd provient de csr 
                cmd.DATA_sel <= DATA_from_csr ;
                -- préciser le csr

                -- mstatus <=> 0x300 = 1100000000
                if status.IR(31 downto 20) = "001100000000" then
                    cmd.cs.CSR_we <= CSR_mstatus;
                    cmd.cs.CSR_sel <= CSR_from_mstatus;
                    
                -- mie <=> 0x304 = 1100000100
                elsif status.IR(31 downto 20) = "001100000100" then
                    cmd.cs.CSR_we <= CSR_mie;
                    cmd.cs.CSR_sel <= CSR_from_mie;
                    
                -- mtvec <=> 0x305 = 1100000101
                elsif status.IR(31 downto 20) = "001100000101" then
                    cmd.cs.CSR_we <= CSR_mtvec;
                    cmd.cs.CSR_sel <= CSR_from_mtvec;
                    
                -- mepc <=> 0x341 = 1101000001
                elsif status.IR(31 downto 20) = "001101000001" then
                    cmd.cs.MEPC_sel <= MEPC_from_csr;
                    cmd.cs.CSR_we <= CSR_mepc;
                    cmd.cs.CSR_sel <= CSR_from_mepc;
                    
                -- mcause <=> 0x342 = 1101000010
                elsif status.IR(31 downto 20) = "001101000010" then
                    cmd.cs.CSR_we <= CSR_none;
                    cmd.cs.CSR_sel <= CSR_from_mcause;
                    
                -- mip <=> 0x344 = 1101000100
                elsif status.IR(31 downto 20) = "001101000100" then
                    cmd.cs.CSR_we <= CSR_none;
                    cmd.cs.CSR_sel <= CSR_from_mip;
                    
                else
                    cmd.cs.MEPC_sel <= MEPC_from_csr;
                    cmd.cs.CSR_we <= CSR_mepc;
                    cmd.cs.CSR_sel <= CSR_from_mepc;   
                end if;

                -- on choisit l'état à visiter
                -- CSRRW
                if status.IR(14 downto 12) = "001" then
                    -- La donnée à mettre dans csr provient de rs1 
                    cmd.cs.TO_CSR_sel <= TO_CSR_from_rs1;
                    -- Le mode d'écriture correspondant est le mode simple (mettre tous les 32 bits de rs1)
                    cmd.cs.CSR_WRITE_mode <= WRITE_mode_simple;

                -- CSRRS
                elsif status.IR(14 downto 12) = "010" then
                    -- La donnée à mettre dans csr provient de rs1 
                    cmd.cs.TO_CSR_sel <= TO_CSR_from_rs1;
                    -- Le mode d'écriture correspondant est le mode set (affectation de certains bit à partir de rs1(les bits vrais))
                    cmd.cs.CSR_WRITE_mode <= WRITE_mode_set;
                  
                -- CSRRC
                elsif status.IR(14 downto 12) = "011" then
                    -- La donnée à mettre dans csr provient de rs1 
                    cmd.cs.TO_CSR_sel <= TO_CSR_from_rs1;
                    -- Le mode d'écriture correspondant est le mode clear (mettre les bits vrais de rs1 à 0 dans csr)
                    cmd.cs.CSR_WRITE_mode <= WRITE_mode_clear;

                -- CSRRWi
                elsif status.IR(14 downto 12) = "101" then
                    -- La donnée à mettre dans csr est un imm
                    cmd.cs.TO_CSR_sel <= TO_CSR_from_imm;
                    -- Le mode d'écriture correspondant est le mode simple (mettre tous les 32 bits (0^27&zimm))
                    cmd.cs.CSR_WRITE_mode <= WRITE_mode_simple;

                -- CSRRSi
                elsif status.IR(14 downto 12) = "110" then
                    -- La donnée à mettre dans csr est un imm
                    cmd.cs.TO_CSR_sel <= TO_CSR_from_imm;
                    -- Le mode d'écriture correspondant est le mode set (affectation de certains bit à partir de zimm(les bits vrais))
                    cmd.cs.CSR_WRITE_mode <= WRITE_mode_set;

                -- CSRRCi
                elsif status.IR(14 downto 12) = "111" then
                    -- La donnée à mettre dans csr est un imm
                    cmd.cs.TO_CSR_sel <= TO_CSR_from_imm;
                    -- Le mode d'écriture correspondant est le mode clear (mettre les bits vrais de zimm à 0 dans csr)
                    cmd.cs.CSR_WRITE_mode <= WRITE_mode_clear;
                end if; 

                 -- On lit l'adresse de l'instruction suivante
                cmd.ADDR_sel <= ADDR_from_pc ;
                cmd.mem_ce <= '1' ;
                cmd.mem_we <= '0' ;
                -- On repasse à l'état S_Fetch
                state_d <= S_Fetch ;
                    
            when S_INTERRUPTION_1 =>
                -- on se rappelle de pc en l'écrivant dans mepc
                cmd.cs.CSR_we <= CSR_mepc;
                cmd.PC_we <= '1';
                cmd.PC_sel <= PC_mtvec;
                cmd.cs.MEPC_sel <= MEPC_from_pc;        
                -- On met mstatus_mie_reset à 1 de sorte qu'aucune autre interruption ne soit prise en compte au cours d'une interruption (forcer le 3ème bit de mstatus à 0)
                cmd.cs.MSTATUS_mie_reset <= '1';
                -- On repasse à l'état S_Pre_Fetch pour lire l'instruction suivante
                state_d <= S_Pre_Fetch;
        
            when S_MRET =>
                -- on récupère pc stockée dans mepc
                cmd.PC_sel <= PC_from_mepc;
                cmd.PC_we <= '1';
                cmd.cs.MSTATUS_mie_set <= '1';
                -- On repasse à l'état S_Pre_Fetch pour lire l'instruction suivante
                state_d <= S_Pre_Fetch;


            when others => null;

        end case;
    end process FSM_comb;
end architecture;
