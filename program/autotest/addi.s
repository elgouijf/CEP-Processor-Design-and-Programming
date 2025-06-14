# TAG = addi
	.text

    # Initialisation de x31 à 0
    addi x31, x0, 0             # x31 = 0

    # Addition de deux valeurs positives
    addi x1, x0, 1              # x1 = 1
    addi x31, x1, 9             # x31 = x1 + 9 = 10

    # Addition d'une valeur positive et d'une valeur négative
    # produisant un résultat positif
    addi x1, x0, 10            # x1 = 10
    addi x31, x1, -5           # x31 = 10 + -5 = 5

    # Addition d'une valeur positive et d'une valeur négative
    # produisant un résultat négatif
    addi x1, x0, 5              # x1 = 5
    addi x31, x1, -7            # x31 = 5 + -7 = -2


    # Addition de deux valeurs négatives 
    addi x1, x0, -2             # x1 = -2
    addi x31, x1, -3            # x31 = -2 + -3 = -5

    # Addition de deux valeurs opposées 
    addi x1, x0, 20             # x1 = 20
    addi x31, x1, -20           # x31 = 20 + -20 = 0

    # Additions avec des valeurs extrêmes de l'immédiat
    addi x31, x0, 2047          # 2047 est la valeur positive maximale sur 12 bits
    addi x31, x0, -2048        # -2048 est la valeur négative minimale sur 12 bits





	# max_cycle 50
	# pout_start
    # 00000000
    # 0000000A
    # 00000005
    # FFFFFFFE
    # FFFFFFFB
    # 00000000
    # 000007FF
    # FFFFF800
	# pout_ends
