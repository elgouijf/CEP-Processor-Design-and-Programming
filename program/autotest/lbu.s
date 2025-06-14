# TAG = LBU
    .text

    # Stocker puis charger un nombre non signé sur 1 octet depuis la mémoire
    lui x1, 1      # adresse mémoire utilisée 

    li x2, 255          # x2 = 255    (plus grand nombre représentable sur 8 bits)
    sw x2, 0(x1)        # x2 est stockée à l'@ x1    

    li x2, 1            # x2 = 1 
    sw x2, 4(x1)         # x2 est stockée à l'@ x1+4

    # Lecture d'un nombre qui dépasse 8 bits en complément à 2
    li x2, 256         # x2 = 256 = 100000000 en binaire
    sw x2, 8(x1)        # x2 est stockée à l'@ x1+8

    lbu x31, 0(x1)       # x31 = 255
    lbu x31, 4(x1)      # x31 = 1
    lbu x31, 8(x1)      # x31 = 0 (troncature du dernier bit de poids fort)


    # max_cycle 250
	# pout_start
    # 000000FF
    # 00000001
    # 00000000
	# pout_end

