.text
main:	
	addi s0, s0, 4
	jal ra, exit
	addi s1, s1 3 
	
exit:
	jalr zero, ra, 0