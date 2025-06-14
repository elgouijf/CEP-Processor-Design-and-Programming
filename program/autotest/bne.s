# TAG = bne

	.text
    addi x31,x0,0
    addi x1, x0, 2
adddd: 
    bne x31,x1,edddd
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
