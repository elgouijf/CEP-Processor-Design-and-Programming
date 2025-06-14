# TAG = ORi
    .text

    ori x31, x0, 1 # 1 or 0

    ori x31, x31, 1 # 1 or 1 

    ori x31, x0, 0 # 0 or 0

    addi x1, x0, 38     # 38 =   100110
    ori x31, x1, 100    # 100 = 1100100

    addi x1, x0, -3 # le immédiat sera étendu de 1
    ori x31, x1, 3
    





    # max_cycle 50
	# pout_start
	# 00000001
	# 00000001
    # 00000000
    # 00000066
    # ffffffff
	# pout_end

