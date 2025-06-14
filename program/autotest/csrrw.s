# TAG = CSRRW
    .text
    # mstatus
    addi x1, x0, 3      # x1 = 3
    csrrw x2, mstatus, x1 # x2 = ancien mstatus, mstatus = x1
    csrrw x3, mstatus, x0 # x3 = mstatus (devrait être 3), mstatus = 0
    addi x31, x3, 0  # Affiche la valeur lue de mstatus

    # mtvec
    addi x1, x0, 7      # x1 = 7
    csrrw x2, mtvec, x1 # x2 = ancien mtvec, mtvec = x1(n downto 2) & "00" = (100)_2 = (4)_10
    csrrw x3, mtvec, x0 # x3 = mtvec (devrait être 3), mtvec = 0
    addi x31, x3, 0  # Affiche la valeur lue de mtvec

    # mie
    addi x1, x0, 15      # x1 = 15
    csrrw x2, mie, x1 # x2 = ancien mie, mie = 15
    csrrw x3, mie, x0 # x3 = mie (devrait être 3), mie = 0
    addi x31, x3, 0  # Affiche la valeur lue de mie

    #mepc
    addi x1, x0, 9      # x1 = 7
    csrrw x2, mtvec, x1 # x2 = ancien mtvec, mtvec = x1(n downto 2) & "00" = (1000)_2 = (8)_10
    csrrw x3, mtvec, x0 # x3 = mtvec (devrait être 3), mtvec = 0
    addi x31, x3, 0  # Affiche la valeur lue de mtvec

    # max_cycle 150
	# pout_start
    # 00000003
    # 00000004
    # 0000000f
    # 00000008
	# pout_end
        
