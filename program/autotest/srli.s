# TAG = SRLi
    .text

    addi x1, x0, 992  # x1 = 0011 1110 0000 en binaire
    srli x31, x1, 1    # x31 = x1 >> 1 

    addi x1, x0, 992
    srli x31, x1, 2     # x31 = x1 >> 2 

    addi x1, x0, 992
    srli x31, x1, 5     # x31 = x1 >> 5 

    addi x1, x0, 992
    srli x31, x1, 0    # x31 = x1 >> 0  (pas de changement)

    # max_cycle 50
    # pout_start
    # 000001F0
    # 000000F8
    # 0000001F
    # 000003E0
    # pout_end