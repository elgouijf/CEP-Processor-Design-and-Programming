# TAG = AND
    .text

    addi x1, x0, 1
    and x31, x0, x1

    and x31, x0, x0

    and x31, x1, x1

    addi x1, x0, 38     # 38 =   100110
    addi x2, x0, 100    # 100 = 1100100
    and x31, x1, x2





    # max_cycle 50
	# pout_start
	# 00000000
	# 00000000
    # 00000001
    # 00000024
	# pout_end
