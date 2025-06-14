# TAG = SLTI
    .text
    
# Non signés : 

    addi x1, x0, 3      # x1 = 3
    slti x31, x1, 0     # x31 = 0 car x1 = 3 >= 0
    slti x31, x1, 4     # x31 = 1 car x1 = 3 < 4
    slti x31, x1, 3     # x31 = 0 car x1 = 3 >= 3

# Signés :

    addi x1, x0, -7     # x1 = -7
    slti x31, x1, 0     # x31 = 1 car x1 = -7 < 0
    slti x31, x1, -15   # x31 = 0 car x1 = -7 >= -15
    slti x31, x1, -7    # x31 = 0 car x1 = -7 >= -7

# Signé et non signé : 

    addi x1, x0, 2      # x1 = 2
    slti x31, x1, -1    # x31 = 0 car x1 = 2 >= -1
    addi x1, x0, -2     # x1 = -2
    slti x31, x1, 1     # x31 = 1 car x1 = -2 < 1

    # max_cycle 50
    # pout_start
    # 00000000
    # 00000001
    # 00000000
    # 00000001
    # 00000000
    # 00000000
    # 00000000
    # 00000001
    # pout_end