# TAG = SB
    .text

    # @ mémoire utilisée 
    lui x1, 1

    # stockage d'un octet positif 
    li x2, 127          # plus grand octet positif en complément à 2
    sb x2, 0(x1)

    # stockage de 0
    sb x0, 4(x1)

    # stockage d'un octet négatif 
    li x2, -128     # plus petit octet négatif
    sb x2, 8(x1)

    # stockage d'un nombre + dépassant 8 bits
    li x2, 150
    sb x2, 12(x1)

    # stockage d'un nombre - dépassant 8 bits
    li x2, -200
    sb x2, 16(x1)

    # lecture depuis la mémoire des octets (et "sur"-octets tronqués)
    lb x31, 0(x1)       # x31 = 127
    lb x31, 4(x1)       # x31 = 0
    lb x31, 8(x1)       # x31 = -128
    lb x31, 12(x1)      # x31 = -106 (par troncature)
    lb x31, 16(x1)      # x31 = 56 (par troncature)


    # max_cycle 250
	# pout_start
    # 0000007F
    # 00000000
    # FFFFFF80
    # FFFFFF96
    # 00000038
	# pout_end

