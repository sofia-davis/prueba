.text
	addi zero, zero, 0
	auipc s0, 0xFC10
	addi s1, s1, 6
	sw s1, 0(s0)
	#addi s1, s0, 6
	lw s2, 0(s0)
	addi a0, s2, 3