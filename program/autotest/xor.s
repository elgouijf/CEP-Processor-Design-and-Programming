# TAG = XOR
    .text

    addi x1, x0, 1
    xor x31, x1, x0
    xor x31, x0, x1
    xor x31, x0, x0
    xor x31, x1, x1

    addi x1, x0, 24     # 24 = 11000
    addi x2, x0, 53     #  53 = 110101
    xor x31, x1, x2

    addi x1, x0, 33     # 33 = 100001
    addi x2, x0, 34     # 34 = 100010
    xor x31, x1, x2




    # max_cycle 50
	# pout_start
	# 00000001
    # 00000001
    # 00000000
    # 00000000
    # 0000002D
    # 00000003
	# pout_end
