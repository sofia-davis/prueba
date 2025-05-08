.text
	auipc s0, 0xFC10
	addi s0, s0, 0x0024
	addi s1, s1, 4
	sw s1, 0(s0)
	lw s2, 0(s0)
	add s1, s1, s2
