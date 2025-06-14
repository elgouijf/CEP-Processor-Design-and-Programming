# TAG = BLTU
    .text 

    addi x1, x0, 1
    addi x2, x0, 2
    bltu x1, x2, saut_fait      # x1 < x2 => branch to saut_fait pour que x31 = 1

saut_fait:
    add x31, x1, x0

    bltu x2, x1, saut_non_fait
    add x31, x0, x0

saut_non_fait:



    # max_cycle 250
	# pout_start
    # 00000001
    # 00000000
	# pout_end

