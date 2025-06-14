library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PKG.all;

entity CPU_CND is
    generic (
        mutant      : integer := 0
    );
    port (
        rs1         : in w32;
        alu_y       : in w32;
        IR          : in w32;
        slt         : out std_logic;
        jcond       : out std_logic
    );
end entity;

architecture RTL of CPU_CND is
    -- s : bit de signe
    -- z : bit de test de résultat nul
    -- es : comparaison signée ou non signée
    -- res : résultat de la soustraction étendue à 33 bits
    -- rs1_33, alu_y_33 : opérandes étendues à 33 bits pour éviter des erreurs de signe lors de la soustraction
    signal s, z, es: std_logic;
    signal  res, rs1_33, alu_y_33: signed(32 downto 0);

begin
    -- Determiner s'il faut faire une comparaison signee ou non signee
    es <= (not IR(12) and not IR(6)) or (IR(6) and not IR(13));

    -- Extension du registre rs_1 sur 33 bits
    rs1_33(31 downto 0) <= signed(rs1);
    -- si comparaison non signe mettre un 0 en MSB sinon y recopier le signe
    rs1_33(32) <= '0' when es = '0' else rs1_33(31);

    -- Idem pour alu_y
    alu_y_33(31 downto 0) <= signed(alu_y);
    alu_y_33(32) <= '0' when es = '0' else alu_y_33(31);
   
    -- Resultat de la soustraction etendue
    res <= rs1_33 - alu_y_33;

    -- bit de signe (vaut 1 ssi rs1 < alu_y)
    s <= res(32);
    -- bit de zero (vaut 1 ssi rs1 = alu_y)
    z <= '1' when res = 0 else '0';
    
    -- Calcul de la condition de branchement
    jcond <= ((IR(12) xor z) and not IR(14)) or ((IR(12) xor s) and IR(14));

    -- preciser directement que rs1 < alu_y
    slt <= s;
    
end architecture;
