# TAG = LB
    .text

    # Stocker puis charger un nombre sur 1 octet depuis la mémoire
    lui x1, 1      # adresse mémoire utilisée 

    li x2, 127          # x2 = 127    (plus grand nombre représentable sur 8 bits)
    sw x2, 0(x1)        # x2 est stockée à l'@ x1    

    li x2, -128         # x2 = -128 (plus petite valeur représentable sur 8 bits)
    sw x2, 4(x1)

    li x2, -1           # x2 = -1 (pour voir l'extension de signe en négatif)
    sw x2, 8(x1)  

    li x2, 1            # x2 = 1 (extension de signe en positif)
    sw x2, 12(x1)   

    # Lecture d'un nombre qui dépasse 8 bits en complément à 2
    li x2, 255          # x2 = 11111111 en binaire
    sw x2, 16(x1)

    lb x31, 0(x1)       # x31 = 127
    lb x31, 4(x1)       # x31 = -128
    lb x31, 8(x1)       # x31 = -1
    lb x31, 12(x1)      # x31 = 1
    lb x31, 16(x1)      # x31 = -1 (troncature du dernier bit de poids fort)


    # max_cycle 250
	# pout_start
    # 0000007F
    # FFFFFF80
    # FFFFFFFF
    # 00000001
    # FFFFFFFF
	# pout_end

