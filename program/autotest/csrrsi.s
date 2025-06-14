# TAG = CSRRSi
    .text

    # mstatus  
    csrrw x2, mstatus, 1 # x2 = ancien mstatus, mstatus = 1
    csrrsi x3, mstatus, 0 # x3 = mstatus, mstatus = mstatus or 0 = mstatus
    addi x31, x3, 0  # Affiche la valeur lue de mstatus


    csrrw x4, mstatus, 1 # x4 = ancien mstatus, mstatus = x1
    csrrsi x3, mstatus, 2 # mstatus = mstatus or 00000002 = 00000003
    csrrw x3, mstatus, x0  # x3 = mstatus
    addi x31, x3, 0  # Affiche la valeur lue de mstatus

    # mtvec  
    csrrw x2, mtvec, 1 # x2 = ancien mtvec, mtvec = 0 (les 2 bits du poids faible de mtvec sont forcées à 0)
    csrrsi x3, mtvec, 0 # x3 = mtvec, mtvec = mtvec or 0 = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec


    csrrw x4, mtvec, 1 # x4 = ancien mtvec, mtvec = 0 (bit forcé à 0)
    csrrsi x3, mtvec, 4 # mtvec = mtvec or 00000004 = 00000004
    csrrw x3, mtvec, x0  # x3 = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec

    # mie  
    csrrw x2, mie, 1 # x2 = ancien mie, mie = 1 
    csrrsi x3, mie, 0 # x3 = mie, mie = mie or 0 = mie
    addi x31, x3, 0  # Affiche la valeur lue de mie


    csrrw x4, mie, 1   # x4 = ancien mie, mie = 
    csrrsi x3, mie, 6 # mie = mie or 00000006 = 00000007
    csrrw x3, mie, x0  # x3 = mie
    addi x31, x3, 0  # Affiche la valeur lue de mie

    # mepc  
    csrrw x2, mepc, 1 # x2 = ancien mepc, mepc = 0 (les 2 bits du poids faible de mepc sont forcées à 0)
    csrrsi x3, mepc, 0 # x3 = mepc, mepc = mepc or 0 = mepc
    addi x31, x3, 0  # Affiche la valeur lue de mepc


    csrrw x4, mepc, 1 # x4 = ancien mepc, mepc = 0 (bit forcé à 0)
    csrrsi x3, mepc, 8 # mepc = mepc or 00000008 = 00000008
    csrrw x3, mepc, x0  # x3 = mepc
    addi x31, x3, 0  # Affiche la valeur lue de mepc
    
    # max_cycle 500
	# pout_start
    # 00000001
    # 00000003
    # 00000000
    # 00000004
    # 00000001
    # 00000007
    # 00000000
    # 00000008
	# pout_end
        
