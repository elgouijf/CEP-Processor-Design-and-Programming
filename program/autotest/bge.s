# TAG = BGE 
    .text

# Comparaison entre non signés : 
    addi x1, x0, 1
    addi x2, x0, 2
    bge x2, x1, saut_fait           # Saut effectué car x2 >= x1 

saut_fait:
    add x31, x1, x0                 # x31 = 1

    bge x1, x2, saut_non_fait       # Saut non effectué car x1 < x2
    add x31, x0, x0                 # x31 = 0           

saut_non_fait:
    add x31, x1, x0

    bge x1, x1, saut_fait           # Saut effectué car x1 >= x1

# Comparaison entre signés :
    addi x1, x0, -2
    addi x2, x0, -1
    bge x2, x1, saut_fait           # Saut effectué car x2 >= x1 

    bge x1, x2, saut_non_fait      # Saut non effectué car x1 < x2
    add x31, x0, x0                 # x31 = 0           

    bge x1, x1, saut_fait          # Saut effectué car x1 >= x1

# Comparaison entre signé et non signé :
    addi x1, x0, -2
    addi x2, x0, 1
    bge x2, x1, saut_fait          # Saut effectué car x2 >= x1 

    bge x1, x2, saut_non_fait    # Saut non effectué car x1 < x2
    add x31, x0, x0                 # x31 = 0           

    bge x1, x1, saut_fait          # Saut effectué car x1 >= x1



    # max_cycle 250
	# pout_start
    # 00000001
    # 00000000
    # 00000001
    # 00000001
    # 00000000
    # 00000001
    # 00000001
    # 00000000
    # 00000001
	# pout_end



