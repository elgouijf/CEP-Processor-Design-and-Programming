# TAG = ANDi
    .text

    andi x31, x0, 1 # 0 and 1

    andi x31, x0, 0 # 0 and 0

    addi x1, x0, 38     # 38 =   100110
    andi x31, x1, 100   # 100 = 1100100

    addi x1, x0, -3 # le immédiat sera étendu de 1
    andi x31, x1, 3
    





    # max_cycle 50
	# pout_start
	# 00000000
	# 00000000
    # 00000024
    # 00000001
	# pout_end
