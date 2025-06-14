
# TAG = jalr
 .text
    # Ajout d'un immédiat positif
    lui x31, 1
    jalr x31, 12(x31)
    addi x31, x0, 5 # x31 = 5 => on n'a pas sauter => erreur
    addi x31, x0, 4 # x31 = 4 => on a bien sauter vers l'adresse 1000 + 12

    # Ajout d'un immédiat négatif
    lui x31, 1
    addi x31, x31, 16
    jalr x31, -16 (x31) # on revient à l'instruction 1000 et x31 = PC + 4 = 101c
    

 



    # max_cycle 50
    # pout_start
    # 00001000
    # 00001008
    # 00000004
    # 00001000
    # 00001010
    # 0000101c
    # pout_end
