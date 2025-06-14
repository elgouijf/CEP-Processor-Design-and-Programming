# TAG = beq

	.text
    addi x31,x0,0
adddd: 
    beq x31,x0,edddd
    addi x31,x31,2
edddd:
    addi x31,x31,1
qdddd:
    addi x31,x31,1

    # max_cycle 250
	# pout_start
	# 00000000
	# 00000001
    # 00000002
	# pout_end
