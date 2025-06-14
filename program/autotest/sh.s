# TAG = SH
    .text

    # @ mémoire utilisée 
    lui x1, 1

    # stockage d'un half positif 
    li x2, 32767          # plus grand half positif en complément à 2
    sh x2, 0(x1)

    # stockage de 0
    sh x0, 4(x1)

    # stockage d'un half négatif 
    li x2, -32768     # plus half octet négatif
    sh x2, 8(x1)

    # stockage d'un nombre + dépassant 16 bits en complément à 2
    li x2, 35000
    sh x2, 12(x1)

    # stockage d'un nombre - dépassant 16 bits en complément à 2
    li x2, -35000
    sh x2, 16(x1)

    # lecture depuis la mémoire des octets (et "sur"-octets tronqués)
    lh x31, 0(x1)       # x31 =  32767
    lh x31, 4(x1)       # x31 = 0
    lh x31, 8(x1)       # x31 = -32768
    lh x31, 12(x1)      # x31 = -30536 (par troncature)
    lh x31, 16(x1)      # x31 = 30536 (par troncature)


    # max_cycle 250
	# pout_start
    # 00007FFF
    # 00000000
    # FFFF8000
    # FFFF88b8
    # 00007748
	# pout_end

