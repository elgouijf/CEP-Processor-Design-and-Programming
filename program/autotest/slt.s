# TAG = slt

	.text
    addi x1,x0,24
    addi x2, x0, 5
    slt x31, x2, x1

    slt x31, x1, x2

    # max_cycle 250
	# pout_start
	# 00000001
	# 00000000
	# pout_end
