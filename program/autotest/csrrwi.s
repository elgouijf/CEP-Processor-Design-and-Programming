# TAG = CSRRWi
    .text
    # mstatus
    csrrwi x2, mstatus, 3 # x2 = ancien mstatus, mstatus = 3
    csrrw x3, mstatus, x0 # x3 = mstatus (devrait être 3), mstatus = 0
    addi x31, x3, 0  # Affiche la valeur lue de mstatus

    # mtvec
    csrrwi x2, mtvec, 7  # x2 = ancien mtvec, mtvec = x1(n downto 2) & "00" = (100)_2 = (4)_10
    csrrw x3, mtvec, x0 # x3 = mtvec (devrait être 3), mtvec = 0
    addi x31, x3, 0  # Affiche la valeur lue de mtvec

    # mie
    csrrwi x2, mie, 15 # x2 = ancien mie, mie = 15
    csrrw x3, mie, x0 # x3 = mie (devrait être 3), mie = 0
    addi x31, x3, 0  # Affiche la valeur lue de mie

    # mepc
    csrrwi x2, mepc, 11  # x2 = ancien mepc, mepc = x1(n downto 2) & "00" = (1000)_2 = (8)_10
    csrrw x3, mepc, x0 # x3 = mepc (devrait être 3), mepc = 0
    addi x31, x3, 0  # Affiche la valeur lue de mepc

    # max_cycle 50
	# pout_start
    # 00000003
    # 00000004
    # 0000000f
    # 00000008
	# pout_end
        
        
