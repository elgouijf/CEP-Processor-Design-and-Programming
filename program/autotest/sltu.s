# TAG = SLTU
    .text

    addi x1, x0, 3      # x1 = 3
    sltu x31, x1, x0    # x31 = 0 car x1 = 3 >= x0 = 0
    addi x2, x0, 4
    sltu x31, x1, x2    # x31 = 1 car x1 = 3 < x2 = 4
    sltu x31, x1, x1    # x31 = 0 car x1 = 3 >= x1 = 3


    # max_cycle 50
    # pout_start
    # 00000000
    # 00000001
    # 00000000
    # pout_end