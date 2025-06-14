# TAG = LH
    .text

    # Stocker puis charger un nombre sur 2 octets depuis la mémoire
    lui x1, 1      # adresse mémoire utilisée 

    li x2, 32767          # x2 = 32767    (plus grand nombre + représentable sur 16 bits)
    sw x2, 0(x1)        # x2 est stockée à l'@ x1    

    li x2, -32768         # x2 = -32768 (plus petite valeur représentable sur 16 bits)
    sw x2, 4(x1)

    li x2, -1           # x2 = -1 (pour voir l'extension de signe en négatif)
    sw x2, 8(x1)  

    li x2, 1            # x2 = 1 (extension de signe en positif)
    sw x2, 12(x1)   

    # Lecture d'un nombre qui dépasse 16 bits en complément à 2
    li x2, 40000          # x2 = 1001110001000000 en binaire
    sw x2, 16(x1)

    lh x31, 0(x1)       # x31 = 32767
    lh x31, 4(x1)       # x31 = -32768
    lh x31, 8(x1)       # x31 = -1
    lh x31, 12(x1)      # x31 = 1
    lh x31, 16(x1)      # x31 = -25536 (troncature du dernier bit de poids fort)


    # max_cycle 250
	# pout_start
    # 00007FFF
    # FFFF8000
    # FFFFFFFF
    # 00000001
    # FFFF9C40
	# pout_end

