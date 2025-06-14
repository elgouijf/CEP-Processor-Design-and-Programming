# TAG = LW

    .text
    #  chargement d'une ADDR + 0:
    lui x30, 1
    lw x31, 0(x30) # lui x30, 1

    #l'addresse initiale
    lw x31, 4(x30) #  lw x31, 0(x30)
    lw x31, 5(x30) # négligée, garde la meme valeur

    #ADDR + imm négatif 
    addi x30, x30,  8
    lw x31, -8(x30) # lui x30, 1
    

    # max_cycle 50
	# pout_start
    # 00001f37
    # 000f2f83
    # 000f2f83
    # 00001f37
	# pout_end
        