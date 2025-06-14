# TAG = SRL
    .text

    addi x1, x0, 992  # x1 = 1111100000 en binaire
    addi x2, x0, 1
    srl x31, x1, x2     # x31 = x1 >> 1 

    addi x1, x0, 992
    addi x2, x0, 2
    srl x31, x1, x2     # x31 = x1 >> 2 

    addi x1, x0, 992
    addi x2, x0, 5
    srl x31, x1, x2     # x31 = x1 >> 5 

    addi x1, x0, 992
    srl x31, x1, x0     # x31 = x1 >> 0  (pas de changement)

    # max_cycle 50
    # pout_start
    # 000001F0
    # 000000F8
    # 0000001F
    # 000003E0
    # pout_end
