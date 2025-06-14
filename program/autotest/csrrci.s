# TAG = CSRRCi
    .text

    #mstatus
    addi x1, x0, 1       # x1 = 1
    csrrwi x2, mstatus, 1 # x2 = ancien mstatus, mstatus = 1
    csrrci x3, mstatus, 0 # x3 = mstatus, mstatus = mstatus and ffffffff = mstatus
    addi x31, x3, 0  # Affiche la valeur lue de mstatus


    addi x1, x0, 2047       # x1 = 000007ff
    csrrw x4, mstatus, x1 # x2 = ancien mstatus, mstatus = x1 = 000007ff 
    csrrci x3, mstatus, 15 # mstatus = mstatus and comp(0000000f) = 000007ff and fffffff0 = 000007f0
							# on se contente de 15 pour zimm pour éviter le cas négatif (qui est analogue,
							#comme le résultat ne dépend pas de son signe) 
	addi x31, x3, 0
    csrrwi x3, mstatus, 0  # x3 = mstatus
    addi x31, x3, 0  # Affiche la valeur lue de mtvec


    #mtvec
    addi x1, x0, 1       # x1 = 1
    csrrwi x2, mtvec, 1 # x2 = ancien mtvec, mtvec = 0 (car les 2 bits du poids faible sont forçées à 0)
    csrrci x3, mtvec, 0 # x3 = mtvec, mtvec = mtvec and ffffffff = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec


    addi x1, x0, 1791       # x1 = 000006ff
    csrrw x4, mtvec, x1 # x2 = ancien mtvec, mtvec  = 000006ffc (car les 2 bits du poids faible de mtvec sont toujours égal à 0)
    csrrci x3, mtvec, 15 # mtvec = mtvec and comp(0000000f) = 000006ff and fffffff0 = 000006f0
							# on se contente de 15 pour zimm pour éviter le cas négatif (qui est analogue,
							#comme le résultat ne dépend pas de son signe) 
	addi x31, x3, 0
    csrrwi x3, mtvec, 0  # x3 = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec

    #mie
    addi x1, x0, 1       # x1 = 1
    csrrwi x2, mie, 1 # x2 = ancien mie, mie = 1
    csrrci x3, mie, 0 # x3 = mie, mie = mie and ffffffff = mie
    addi x31, x3, 0  # Affiche la valeur lue de mie


    addi x1, x0, 1279       # x1 = 000004ff
    csrrw x4, mie, x1 # x2 = ancien mie, mie = x1 = 000004ff 
    csrrci x3, mie, 15 # mie = mie and comp(0000000f) = 000004ff and fffffff0 = 000004f0 (car le 3 ème bit de mie est protégé
							# on se contente de 15 pour zimm pour éviter le cas négatif (qui est analogue,
							#comme le résultat ne dépend pas de son signe) 
	addi x31, x3, 0
    csrrwi x3, mie, 0  # x3 = mie
    addi x31, x3, 0  # Affiche la valeur lue de mie

    #mtvec
    addi x1, x0, 1       # x1 = 1
    csrrwi x2, mtvec, 1 # x2 = ancien mtvec, mtvec = 0 (car les 2 bits du poids faible sont forçées à 0)
    csrrci x3, mtvec, 0 # x3 = mtvec, mtvec = mtvec and ffffffff = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec


    addi x1, x0, 1023       # x1 = 000003ff
    csrrw x4, mtvec, x1 # x2 = ancien mepc, mepc = 000003ffc (car les 2 bits du poids faible de mepc sont toujours égal à 0)
    csrrci x3, mtvec, 15 # mtvec = mepc and comp(0000000f) = 000003ff and fffffff0 = 000003f0
							# on se contente de 15 pour zimm pour éviter le cas négatif (qui est analogue,
							#comme le résultat ne dépend pas de son signe) 
	addi x31, x3, 0
    csrrwi x3, mtvec, 0  # x3 = mepc
    addi x31, x3, 0  # Affiche la valeur lue de mepc

    
    
    # max_cycle 500
	# pout_start
    # 00000001
	# 000007ff
    # 000007f0
    # 00000000
	# 000006fc
    # 000006f0
    # 00000001
	# 000004ff
    # 000004f0
    # 00000000
	# 000003fc
    # 000003f0
	# pout_end
        