# Integrantes: Cuauhtemoc Herrera Perez y Sofia Davis Rodriguez
# Fecha de entrega: 16 de Marzo 2025
# Título: Práctica 1: Torres de Hanoi
.text
main:
	addi a0, zero, 3      # Número de discos (n)
	
	# direcciones iniciales de las torres
	lui s1, 0x10010       # dirección alta de la torre A (10010000)
	addi s1, s1, 0x0000   # ajuste bajo
	lui s2, 0x10010       # torre B (10010040)
	addi s2, s2, 0x0040
	lui s3, 0x10010       # torre C (10010080)
	addi s3, s3, 0x0080
	# constantes
	addi t0, zero, 1     # constante 1 (para decrementar o aumentar n)
	addi t3, zero, 4     # constante 4 (tamaño de las direcciones de memoria)
	addi a1, a0, 0       # contador para llenar el stack

# llenar la torre A con los discos
llenar_torreA:
	beq a1, zero, torreA_lleno    # si n = 0, ya este lleno el stack y salta a hanoi_start
	sw a1, 0(s1)		     # escribe el disco n en el stack
	addi s1, s1, 4		     # aumenta 4 para la proxima direccion
	addi a1, a1, -1    	     # decrementa n (n-1)
	jal zero, llenar_torreA	     # se llama a si misma para el proximo disco
torreA_lleno:
	sub s1, s1, t3		     # direccion del disco mas pequeño
	addi a1, a0, 0    	     # restaura n
	
hanoi:
	bge a1, t0, loop   # si a1 >= 1, salta a loop
    
	# guardar informacion del stack antes de la llamada recursiva
	addi sp, sp, -20	 
	sw ra, 0(sp)             # guardar direccion de retorno
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw a1, 16(sp)

	# ajustar la direccion correcta de los dicos
	jal ra, torreC_completa		# verifica si ya esta llena la torre c
	jal ra, encontrar_origen	# encuentra la direccion de origen

	# restaurar informacion del stack despues de la llamada recursiva
	lw ra, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw a1, 16(sp)
	addi sp, sp, 20         # restaurar el puntero del stack
     
	# mover disco de origen a destino
	lw t5, 0(s1)	      # lee el disco de origen y lo guarda en t5
	sw zero, 0(s1)	      # escribe un zero en esa direccion (quita el disco)
	sw t5, 0(s2)	      # escribe el disco en destino
	addi s2, s2, 4	      # aumenta la torre 4 (la direccion del nuevo disco)
	jalr zero, ra, 0      # regresa a donde la llamaron

loop:
	# guardar informacion del stack
	addi sp, sp, -20
	sw ra, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw a1, 16(sp)
	
 	# cambiar torre auxiliar por destino
	addi a1, a1, -1		# n-1
	add t4, s3, zero	# guarda temporalmente destino
	add s3, s2, zero	# destino = auxiliar
	add s2, t4, zero	# auxiliar = destino
	jal ra, hanoi		# primera llamda recursiva
	
	# restaurar informacion del stack
 	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw a1, 16(sp)
	
	# ajustar la direccion correcta de los dicos
	jal ra, torreC_completa		# verifica si ya esta llena la torre c
	jal ra, encontrar_origen	# encuentra la direccion de origen
	lw ra, 0(sp) # restaurar ra del stack despues de encontrar el origen
	
	# mover disco de origen a destino
	lw t5, 0(s1)	      # lee el disco de origen y lo guarda en t5
	sw zero, 0(s1)	      # escribe un zero en esa direccion (quita el disco)
	sw t5, 0(s2)	      # escribe el disco en destino
	addi s2, s2, 4	      # aumenta la torre 4 (la direccion del nuevo disco)
	
	# guardar informacion del stack para la segunda llamada recursiva
	addi sp, sp, -20      
	sw ra, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw a1, 16(sp)
	
	# cambiar auxiliar por origen
	addi a1, a1, -1		# n-1
	add t4, s1, zero	# guarda temporalmente origen
	add s1, s3, zero	# origen = auxiliar
	add s3, t4, zero	# auxiliar = origen
 	jal ra, hanoi		# segunda llamada resursiva
 	
	# restaurar informacion del stack
 	lw ra, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
 	lw a1, 16(sp)
	addi sp, sp, 40
    	
	jalr zero, ra, 0

encontrar_origen:
	lw t4, 0(s1)			# lee contenido de la direccion de origen (s1)
	sub s1, s1, t3			# resta 4 a s1
	beq zero, t4, encontrar_origen	# si lo que hay es un 0, vuelve a restar
	add s1, s1, t3			# si no es 0, ya es el disco de origen y suma 4
	sw s1, 4(sp) 			# guardar nueva direccion de origen (s1)
	lw t5, 4(s1)			# lee el contenido de la siguiente direccion
	bne, zero, t5, avanzar_origen	# si lo que hay es diferente de 0, avanza
	jalr zero, ra, 0		# regresa a hanoi o loop para el movimiento
avanzar_origen:
	lw t5, 4(s1)			# lee el contenido de la siguiente direccion
	add s1, s1, t3			# avanza (suma 4)
	bne zero, t5, avanzar_origen	# si lo que hay es diferente de 0, vuelve a avanzar
	sub s1, s1, t3			# si es igual a 0, ya es el disco de origen y resta  4
	sw s1, 4(sp)			# guardar nueva direccion de origen (s1)
	jalr zero, ra, 0		# regresa a hanoi o loop para el movimiento

torreC_completa:
	lui s4, 0x10010		# direccion inicial de torre C (10010080)
	addi s4, s4, 0x0080
	mul t4, a0, t3		# multiplicar n por 4 
	add s4, s4, t4		# sumar a la direccion inicial
	sub s4, s4, t3		# restar 4 (direccion del ultimo disco)
	lw t5, 0(s4)		# leer el contenido de esa direccion
	bne zero, t5, exit	# si no es igual a 0, la torre esta llena y termina
	jalr zero, ra, 0	# si es igual a 0, aun no termina y se regresa

exit:
	addi zero, zero, 0	# termina el programa
