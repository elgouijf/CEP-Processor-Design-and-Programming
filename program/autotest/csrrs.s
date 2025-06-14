# TAG = CSRRS
    .text
    #mstatus
    addi x1, x0, 1       # x1 = 1
    csrrw x2, mstatus, x1 # x2 = ancien mstatus, mstatus = x1
    csrrs x3, mstatus, x0 # x3 = mstatus, mstatus = mstatus or 0 = mstatus
    addi x31, x3, 0  # Affiche la valeur lue de mstatus


    addi x2, x0, 2
    addi x1, x0, 1       # x1 = 1
    csrrw x4, mstatus, x1 # x2 = ancien mstatus, mstatus = x1
    csrrs x3, mstatus, x2 # mstatus = mstatus or 00000002 = 00000003
    csrrw x3, mstatus, x0  # x3 = mstatus
    addi x31, x3, 0  # Affiche la valeur lue de mstatus

    #mtvec
    addi x1, x0, 1       # x1 = 1
    csrrw x2, mtvec, x1 # x2 = ancien mtvec, mtvec = 0 (bit forcé à 0)
    csrrs x3, mtvec, x0 # x3 = mtvec, mtvec = mtvec or 0 = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec


    addi x2, x0, 4
    addi x1, x0, 1       # x1 = 1
    csrrw x4, mtvec, x1 # x2 = ancien mtvec, mtvec = 0 (les 2 bits du pods faible de mtvec sont forcés à 0)
    csrrs x3, mtvec, x2 # mtvec = mtvec or 00000004 = 00000004
    csrrw x3, mtvec, x0  # x3 = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec


    #mie
    addi x1, x0, 1       # x1 = 1
    csrrw x2, mie, x1 # x2 = ancien mie, mie = x1
    csrrs x3, mie, x0 # x3 = mie, mie = mie or 0 = mie
    addi x31, x3, 0  # Affiche la valeur lue de mie


    addi x2, x0, 6
    addi x1, x0, 1       # x1 = 1
    csrrw x4, mie, x1 # x2 = ancien mie, mie = x1
    csrrs x3, mie, x2 # mie = mie or 00000006 = 00000007
    csrrw x3, mie, x0  # x3 = mie
    addi x31, x3, 0  # Affiche la valeur lue de mie


    #mepc
    addi x1, x0, 1       # x1 = 1
    csrrw x2, mepc, x1 # x2 = ancien mepc, mepc = 0 (bit forcé à 0)
    csrrs x3, mepc, x0 # x3 = mepc, mepc = mepc or 0 = mepc
    addi x31, x3, 0  # Affiche la valeur lue de mepc


    addi x2, x0, 8
    addi x1, x0, 1      # x1 = 1
    csrrw x4, mepc, x1 # x2 = ancien mepc, mepc = 0 (les 2 bits du pods faible de mepc sont forcés à 0)
    csrrs x3, mepc, x2 # mepc = mepc or 00000008 = 00000004
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
        
