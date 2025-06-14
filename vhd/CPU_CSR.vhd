library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PKG.all;

entity CPU_CSR is
    generic (
        INTERRUPT_VECTOR : waddr   := w32_zero;
        mutant           : integer := 0
    );
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;

        -- Interface de et vers la PO
        cmd         : in  PO_cs_cmd;
        it          : out std_logic;
        pc          : in  w32;
        rs1         : in  w32;
        imm         : in  W32;
        csr         : out w32;
        mtvec       : out w32;
        mepc        : out w32;

        -- Interface de et vers les IP d'interruption
        irq         : in  std_logic;
        meip        : in  std_logic;
        mtip        : in  std_logic;
        mie         : out w32;
        mip         : out w32;
        mcause      : in  w32
    );
end entity;

architecture RTL of CPU_CSR is
     -- Registres CSR internes
     signal irq_d, irq_q : std_logic ;
     signal mux_csr, mux_mepc : w32 ;
     signal mstatus_d,mstatus_q : w32 ;
     signal mie_d,mie_q   : w32 ;
     signal mip_d,mip_q     : w32 ;
     signal mtvec_d,mtvec_q : w32 ;
     signal mepc_d,mepc_q    : w32 ;
     signal mcause_d,mcause_q  : w32 ;

 
 
    -- Fonction retournant la valeur à écrire dans un csr en fonction
    -- du « mode » d'écriture, qui dépend de l'instruction
    function CSR_write (CSR        : w32;
                         CSR_reg    : w32;
                         WRITE_mode : CSR_WRITE_mode_type)
        return w32 is
        variable res : w32;
    begin
        case WRITE_mode is
            when WRITE_mode_simple =>
                res := CSR;
            when WRITE_mode_set =>
                res := CSR_reg or CSR;
            when WRITE_mode_clear =>
                res := CSR_reg and (not CSR);
            when others => null;
        end case;
        return res;
    end CSR_write;

begin
    -- Choix entre rs1 et immediate pour écriture dans CSR
    mux_csr <= rs1 when cmd.to_csr_sel = to_csr_from_rs1 else imm;
    -- Choix de la valeur à écrire dans mepc
    mux_mepc <= pc when cmd.MEPC_sel = MEPC_from_pc else mux_csr;


    -- Mise à jour des registres via un process synchrone
    les_registres : process(all)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                -- Mettre tous les CSR à 0
                mip_q     <= (others => '0');
                mstatus_q <= (others => '0');
                mie_q     <= (others => '0');
                mtvec_q   <= (others => '0');
                mepc_q    <= (others => '0');
                mcause_q  <= (others => '0');
                irq_q <= '0';
        
            else
                mip_q     <= mip_d;
                mstatus_q <= mstatus_d;
                mie_q     <= mie_d;
                mtvec_q   <= mtvec_d;
                mepc_q    <= mepc_d;
                mcause_q  <= mcause_d;
                irq_q <= irq_d;

            end if;
        end if;
    end process;

    -- Process combinatoire : logique CSR
    process(all)
    begin
        irq_d <= irq;
        mcause_d <= mcause_q;
        -- Si irq active alors détecter la cause de l'interruption
        if irq_d = '1' then
            mcause_d <= mcause;
        end if;

        -- Gestion du registre mip
        mip_d <= (others => '0'); 
        mip_d(7)  <= mtip;  -- interruption timer
        mip_d(11) <= meip;  -- interruption externe
        

        -- Gestion de mstatus
        mstatus_d <= mstatus_q;
        -- Désactivation de MIE global
        if cmd.MSTATUS_mie_reset ='1' then
            mstatus_d(3) <= '0';
        -- Activation de MIE global
        elsif cmd.MSTATUS_mie_set ='1' then
            mstatus_d(3) <= '1';
        elsif cmd.CSR_we = CSR_mstatus then
            -- Écriture CSR mstatus selon mode
            mstatus_d <= CSR_write(mux_csr, mstatus_q , cmd.CSR_WRITE_mode);
        end if;

        -- Valeurs par défaut pour les autres CSR
        mtvec_d <= mtvec_q;
        mie_d <= mie_q ;
        mepc_d <= mepc_q;
        
        -- Gestion des modes d'écriture pour ces CSR
        case cmd.CSR_we is
            when CSR_mie =>
                mie_d     <= CSR_write(mux_csr , mie_q, cmd.CSR_WRITE_mode);
            when CSR_mtvec =>
                mtvec_d     <= CSR_write(mux_csr, mtvec_q, cmd.CSR_WRITE_mode);
            when CSR_mepc =>
                mepc_d <=  CSR_write(mux_mepc, mepc_q, cmd.CSR_WRITE_mode);
            when others => null;
        end case;
        -- Alignement de mtvec et mepc : mettre les deux derniers bits de poids faible à 0
        mtvec_d(1 downto 0) <= "00";
        mepc_d(1 downto 0) <= "00";

    end process;
    
    --  Process combinatoire pour sélectionner la valeur de sortie CSR (pour pouvoir faire un case)
    process(all)
        begin
        case cmd.CSR_sel is
            when CSR_from_mip =>
                csr <= mip_q;
            when CSR_from_mstatus =>
                csr <= mstatus_q;
            when CSR_from_mie =>
                csr <= mie_q;
            when CSR_from_mtvec =>
                csr <= mtvec_q;
            when CSR_from_mcause =>
                csr <= mcause_q;
            when others =>
                -- Par défaut, on retourne mepc
                csr <= mepc_q;
        end case;

    end process;
         
    -- Signaux de sortie :
    it <= irq_q and mstatus_q(3);       -- Interruption valide ssi irq active et MIE global actif
    mip    <= mip_q;
    mtvec  <= mtvec_q;
    mepc   <= mepc_q;
    mie    <= mie_q;
        
    end architecture;

