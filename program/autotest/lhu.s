# TAG = LHU
    .text

    # Stocker puis charger un nombre non signé sur 2 octets depuis la mémoire
    lui x1, 1      # adresse mémoire utilisée 

    li x2, 65535          # x2 = 65535    (plus grand nombre représentable sur 16 bits)
    sw x2, 0(x1)        # x2 est stockée à l'@ x1    


    li x2, 1            # x2 = 1 
    sw x2, 4(x1)   

    # Lecture d'un nombre qui dépasse 16 bits 
    li x2, 70000          # x2 = 10001000101110000 en binaire
    sw x2, 8(x1)

    lhu x31, 0(x1)       # x31 = 65535
    lhu x31, 4(x1)      # x31 = 1
    lhu x31, 8(x1)      # x31 = 4464 (troncature du dernier bit de poids fort)


    # max_cycle 250
	# pout_start
    # 0000FFFF
    # 00000001
    # 00001170
	# pout_end

