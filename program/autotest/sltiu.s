# TAG = SLTiU
    .text

    addi x1, x0, 3      # x1 = 3
    sltiu x31, x1, 0    # x31 = 0 car x1 = 3 >= x0 = 0
    sltiu x31, x1, 4    # x31 = 1 car x1 = 3 < x2 = 4
    sltiu x31, x1, 3   # x31 = 0 car x1 = 3 >= x1 = 3


    # max_cycle 50
    # pout_start
    # 00000000
    # 00000001
    # 00000000
    # pout_end