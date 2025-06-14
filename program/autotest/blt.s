# TAG = BLT
    .text

# Pour les non signés 

    addi x1, x0, 1
    addi x2, x0, 2
    blt x2, x1, inf         # x1 < x2 : ça ne va pas sauter à l'étiquette inf
    add x31, x0, x0         # x31 = 0 (0 pour signifier q'il n'y a pas eu de saut)

inf: 
    add x31, x0, x1

    blt x1, x2, sup         # x2 < x1 : ça va sauter à l'étiquette sup
    add x31, x0, x0

sup: 
    add x31, x1, x0         # x31 = 1 (1 pour signifier qu'il y a eu un saut)

    blt x0, x0, egal
    add x31, x0, x0         # 0 >= 0 : le saut ne s'effectue pas

egal: 
    add x31, x1, x0         # x31 = 1  

# Pour les signés

    addi x1, x0, -2
    addi x2, x0, -1
    blt x2, x1, inf         # x1 < x2 : ça ne va pas sauter à l'étiquette inf
    add x31, x0, x0         # x31 = 0 (0 pour signifier q'il n'y a pas eu de saut)


    blt x0, x0, egal
  

# Comparaison entre signés et non signés
    addi x3, x0, 1
    addi x1, x0,-2
    addi x2, x0, 1
    blt x2, x1, inf         # x1 < x2 : ça ne va pas sauter à l'étiquette inf
    add x31, x0, x3        # x31 = 0 (0 pour signifier q'il n'y a pas eu de saut)


    blt x0, x0, egal
    add x31, x0, x0         # 0 >= 0 : le saut ne s'effectue pas



    # max_cycle 250
	# pout_start
	# 00000000
    # 00000001
    # 00000001
    # 00000000
    # 00000001
    # 00000000
    # 00000001
    # 00000000
	# pout_end
      
