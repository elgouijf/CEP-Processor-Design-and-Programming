# TAG = SUB
    .text

    # Soustraction de deux valeurs positives donnant un résultat positif
    addi x1, x0, 10
    addi x2, x0, 5
    sub x31, x1, x2

    # Soustraction de deux valeurs positives donnant un résultat négatif
    sub x31, x2, x1

    # Soustraction de deux valeurs négatives donnant un résultat négatif
    addi x1, x0, -100
    addi x2, x0, -50
    sub x31, x1, x2

    # Soustraction de deux valeurs négatives donnant un résultat positif
    sub x31, x2, x1

    # Soustraction de deux valeurs positives égales (chargées dans le même registre)
    addi x1, x0, 7
    sub x31, x1, x1

    # Soustraction de deux valeurs positives égales (chargées dans deux registres différents)
    addi x2, x0, 7
    sub x31, x2, x1
    sub x31, x1, x2

    # Soustraction de deux valeurs négatives égales (chargées dans le même registre)
    addi x1, x0, -7
    sub x31, x1, x1

    # Soustraction de deux valeurs négatives égales (chargées dans deux registres différents)
    addi x2, x0, -7
    sub x31, x2, x1
    sub x31, x1, x2

    # Soustractions de part et d'autre de 0 
    addi x1, x0, 3
    sub x31, x1, x0
    sub x31, x0, x1

    addi x1, x0, -3
    sub x31, x1, x0
    sub x31, x0, x1

    # 0 - 0 = 0
    sub x31, x0, x0

    # max_cycle 250
	# pout_start
    # 00000005
    # FFFFFFFB
    # FFFFFFCE 
    # 00000032 
    # 00000000 
    # 00000000 
    # 00000000 
    # 00000000
    # 00000000
    # 00000000
    # 00000003
    # FFFFFFFD
    # FFFFFFFD
    # 00000003
    # 00000000
	# pout_end
