# TAG = ADD
    .text

    # Addition 0 + 0 :
    add x31, x0, x0
    
    # Addition d'un nombre positif à 0 :
    addi x1, x0, 10         # x1 = 10
    add x31, x1, x0

    # Addtion d'un nombre négatif à 0 :  
    addi x1, x0, -10        # x1 = -10
    add x31, x1, x0

    # Addition de deux nombres positifs :
    addi x1, x0, 2
    addi x2, x0, 3
    add x31, x1, x2

    # Addition de deux nombres négatifs :
    addi x1, x0, -2
    addi x2, x0, -3
    add x31, x1, x2

    # Addition de deux valeurs opposées 
    addi x1, x0, 20             # x1 = 20
    addi x2, x0, -20           # x2 = 20 + -20 = 0
    add x31, x1, x2

    # Addition d'une valeur positive et d'une valeur négative
    # produisant un résultat positif
    addi x1, x0, 10            # x1 = 10
    addi x2, x0, -5           # x2= 10 + -5 = 5
    add x31, x1, x2

    # Addition d'une valeur positive et d'une valeur négative
    # produisant un résultat négatif
    addi x1, x0, 5              # x1 = 5
    addi x2, x0, -7            # x2 = 5 + -7 = -2
    add x31, x1, x2

    # 2^31 -1 = 2147483647
    # Addition avec des valeurs extrêmes : impossible car les instructions disponbiles 
    # ne permettent pas de charger des immédiats au delà de 12 bits





    # max_cycle 250
	# pout_start
    # 00000000
    # 0000000A
    # FFFFFFF6
    # 00000005
    # FFFFFFFB
    # 00000000
    # 00000005
    # FFFFFFFE
	# pout_end
    




