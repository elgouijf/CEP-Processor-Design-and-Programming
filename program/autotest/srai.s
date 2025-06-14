# TAG = SRAi
    .text

    # Décalage d'un nombre positif :
    addi x1, x0, 255        # 0000 0000 1111 1111 en binaire
    srai x31, x1, 4       # x31 = x1 >>> 4 = 0000 0000 0000 1111

    # Décalage d'un nombre négatif :
    addi x1, x0, -255       # 1111 1111 0000 0001 en binaire
    srai x31, x1, 6         # x31 = 1111 1111 1111 1100


    # max_cycle 50
	# pout_start
    # 0000000F
    # FFFFFFFC
	# pout_end
        