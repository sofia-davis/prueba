.text
main:
	addi s0, zero, 0 # selector
	addi s1, zero, 5 # a
	addi s2, zero, 3 # b
	addi s3, zero, 0 # c

	# switch
	beq s0, zero, andBitwise # si selector es igual a 0, salta a andBitwise
	addi t0, zero, 1 # t0 = 1
  	beq s0, t0, suma # si selector es igual a t0, salta a suma
   	addi t0, zero, 2 # t0 = 2
	beq s0, t0, resta # si selector es igual a t0, salta a resta
   	addi t0, zero, 3 # t0 = 3
   	beq s0, t0, multiplica # si selector es igual a t0, salta a multiplica
	
suma:
	add s3, s1, s2 # suma a+b y lo guarda en c
	jal exit
resta:
	sub s3, s1, s2 # resta a-b y lo guarda en c
	jal exit
multiplica:
	mul s3, s1, s2 # multiplica a*b y lo guarda en c
	jal exit
andBitwise:
	and s3, s1, s2 # a&b y lo guarda en c
exit:
	addi zero, zero, 0 # nop
