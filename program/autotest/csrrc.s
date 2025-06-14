# TAG = CSRRC
    .text

    # mstatus
    addi x1, x0, 1       # x1 = 1
    csrrw x2, mstatus, x1 # x2 = ancien mstatus, mstatus = x1
    csrrc x3, mstatus, x0 # x3 = mstatus, mstatus = mstatus and ffffffff = mstatus
    addi x31, x3, 0  # Affiche la valeur lue de mstatus


    lui x2 , 126991 # 0001f000 => 1f00f000
    lui x1, 2047       # 2047 = 00007ff => x1 = 007ff000
    csrrw x4, mstatus, x1 # x2 = ancien mstatus, mstatus = x1 = 007ff000
    csrrc x3, mstatus, x2 # mstatus = mstatus and comp(1f00f000) = 007ff000 and e0ff0fff = 007f0000
    addi x31, x3, 0 # on s'assure que mstatus avait bien 000007ff
    csrrw x3, mstatus, x0  # x3 = mstatus
    addi x31, x3, 0  # Affiche la valeur lue de mstatus


    # mtvec
    addi x1, x0, 1       # x1 = 1
    csrrw x2, mtvec, x1 # x2 = ancien mtvec, mtvec = 0( bit forcé à 0)
    csrrc x3, mtvec, x0 # x3 = mtvec, mtvec = mtvec and ffffffff = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec


    lui x2 , 126991 # 0001f000 => 1f00f000
    lui x1, 1791       # 1791 = 000006ff => x1 = 006ff000
    csrrw x4, mtvec, x1 # x2 = ancien mtvec, mtvec = x1 = 006ff000
    csrrc x3, mtvec, x2 # mtvec = mtvec and comp(1f00f000) = 006ff000 and e0ff0fff = 006f0000
    addi x31, x3, 0 # on s'assure que mtvec avait bien 000006ff
    csrrw x3, mtvec, x0  # x3 = mtvec
    addi x31, x3, 0  # Affiche la valeur lue de mtvec


    # mie 
    addi x1, x0, 1       # x1 = 1
    csrrw x2, mie, x1 # x2 = ancien mie, mie = x1
    csrrc x3, mie, x0 # x3 = mie, mie = mie and ffffffff = mie
    addi x31, x3, 0  # Affiche la valeur lue de mie


    lui x2 , 126991 # 0001f000 => 1f00f000
    lui x1, 1279       # # x1 = 000004ff => 004ff000
    csrrw x4, mie, x1 # x2 = ancien mie, mie = x1 =   004ff000
    csrrc x3, mie, x2 # mie = mie and comp(1f00f000) = 000004ff and e0ff0fff = 004f0000
    addi x31, x3, 0 # on s'assure que mie avait bien 000005ff
    csrrw x3, mie, x0  # x3 = mie
    addi x31, x3, 0  # Affiche la valeur lue de mie


    # mepc
    addi x1, x0, 1       # x1 = 1
    csrrw x2, mepc, x1 # x2 = ancien mepc, mepc = 0( bit forcé à 0)
    csrrc x3, mepc, x0 # x3 = mepc, mepc = mepc and ffffffff = mepc
    addi x31, x3, 0  # Affiche la valeur lue de mepc


    lui x2 , 126991 # 0001f000 => 1f00f000
    lui x1, 1023       # 1023 = 000003ff => x1 = 003ff000
    csrrw x4, mepc, x1 # x2 = ancien mepc, mepc = x1 = 003ff000
    csrrc x3, mepc, x2 # mepc = mepc and comp(1f00f000) = 003ff000 and e0ff0fff = 003f0000
    addi x31, x3, 0 # on s'assure que mepc avait bien 000003ff
    csrrw x3, mepc, x0  # x3 = mepc
    addi x31, x3, 0  # Affiche la valeur lue de mepc


    # max_cycle 500
	# pout_start
    # 00000001
    # 007ff000
    # 007f0000
    # 00000000
    # 006ff000
    # 006f0000
    # 00000001
    # 004ff000
    # 004f0000
    # 00000000
    # 003ff000
    # 003f0000
	# pout_end
        