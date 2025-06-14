# TAG = XORi

    .text

    addi x1, x0, 255        # 255 = 1111111
    xori x31, x1, 0


    xori x31, x0, 1

    xori x31, x1, 255
    xori x31, x0, 0

    addi x1, x0, 163       # 163 = 10100011
    xori x31, x1, 201      # 201 = 11001001


    # max_cycle 50
	# pout_start
	# 000000FF
	# 00000001
    # 00000000
    # 00000000
    # 0000006A
	# pout_end
