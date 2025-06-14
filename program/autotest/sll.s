# TAG = SLL
.text

addi x1, x0, 31     # x1 = 31 = 0x1F (11111 en binaire)
addi x2, x0, 1
sll x31, x1, x2     # x31 = 62  (0x3E)

addi x2, x0, 2
sll x31, x1, x2     # x31 = 124 (0x7C)

addi x2, x0, 5
sll x31, x1, x2     # x31 = 992 (0x3E0)

sll x31, x1, x0     # x31 = 31  (0x1F)

# max_cycle 50
# pout_start
# 0000003E
# 0000007C
# 000003E0
# 0000001F
# pout_end
