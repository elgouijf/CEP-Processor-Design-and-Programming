# TAG = BGEU
    .text
    addi x1, x0, 1
    addi x2, x0, 2
    bgeu x1, x2, inf        # x1 <= x2 : ça ne va pas sauter à l'étiquette inf
    add x31, x0, x0         # X31 = 0 (0 pour signifier q'il n'y a pas eu de saut)
inf: 
    add x31, x0, x1
fin_inf:
    bgeu x2, x1, sup        # x2 >= x1 : ça va sauter à l'étiquette sup
    add x31, x0, x0
sup: 
    add x31, x1, x0         # x31 = 1 (1 pour signifier qu'il y a eu un saut)
fin_sup:
    bgeu x0, x0, egal
    add x31, x0, x0         # 0 >= 0 : le saut s'effectue
egal: 
    add x31, x1, x0         # x31 = 1 car il y a eu un saut  

    # max_cycle 250
	# pout_start
	# 00000000
    # 00000001
    # 00000001
	# pout_end
      

    

