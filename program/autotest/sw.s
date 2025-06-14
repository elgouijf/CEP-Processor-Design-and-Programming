# TAG = SW

    .text
    #  chargement d'une ADDR + 0:
    addi x1, x0, 5
    lui x20, 1
    sw x1, 0(x20)
    lw x31, 0(x20) # affiche 5


    #ADDR + imm négatif 
    addi x20, x20,  8
    addi x1, x0, 10
    sw x1, 0(x20)
    lw x31, 0(x20) #affiche 10
    addi x1, x0, 9
    sw x1, -8(x20)
    lw x31, -8(x20) # afcihe 9

    #ADDR + imm positif
    addi x20, x20, -8
    addi x1, x0, 7
    sw x1, 8(x20)
    lw x31, 8(x20) # affiche 7

    # max_cycle 250
	# pout_start
    # 00000005
    # 0000000a
    # 00000009
    # 00000007
	# pout_end
        