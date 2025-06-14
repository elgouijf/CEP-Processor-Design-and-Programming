# TAG = AUIPC
    .text

    auipc x31, 1 #ajout de 1 décalé à gauche de 12 '0' 00001000 en hexa et
                # PC devient 0x1004 en passant du Pre_Fetch
    auipc x31, 2 # PC + 0x2000 = 0x3004 et PC devien 0x1008 en passant du Pre_Fetch

    # Les addi sont pour faire incrémenter la PC
    addi x31, x0, 0 # PC <- PC +4 donc PC = 0x100C
    addi x31, x31, -2048 # PC <- PC +4 donc PC = 0x1010
    auipc x31, 3 # x31 <- PC + 3000 = 4010

    # max_cycle 50
    # pout_start
    # 00002000
    # 00003004
    # 00000000
    # FFFFF800
    # 00004010
    # pout_end