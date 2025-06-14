# TAG = JAL
    .text

# Pour les non signés 

    jal x31, saut1

    saut1:
    addi x31, x0, 5
    jal x31, saut2

    saut2:
    addi x31, x31, 2

    


    # max_cycle 250
	# pout_start
	# 00001004
    # 00000005
    # 0000100c
	# pout_end
      
