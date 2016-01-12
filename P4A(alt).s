.data
cad1: 		.asciiz "\n  Fin de las 3 iteraciones!"
newline: 	.asciiz "\n"
esp: 		.asciiz " "
	.globl __start
			.text
	
__start:
	li $t0,0			# cargamos 0 en t0
	li $t1,3			# cargamos 3 en t1 para utilizarlo para comparar
	
reiniciar:        
	seq $t7,$t0,$t1		# si a0 es 3 (a1), establece 1 en t7
	bgtz $t7,end		# si t7 es mayor que 0, salta a end
	subu $sp,$sp, 8		# Hacemos hueco en la pila para 8 bytes // convenio guardar invocador
	sw  $t0,4($sp)		# Guardamos t0 en pila
	jal rutina			# JAL, salta a rutina
	lw $t0,4($sp)		# cargamos de pila t0
	add $sp,$sp,8		# Deshacemos el hueco que hemos utiizado en la pila moviendo el puntero 8 posiciones arriba
	la $a0,newline		# cargamos newline para mostrarlo por pantalla
	li $v0,4			# escribe cadena de texto
	syscall				# llamada al sistema
	add $t0,$t0,1		# suma 1 al contador t0
	j reiniciar			# saltamos a reiniciar
	
rutina:	                       
	sw $31,0($sp)		# guardamos return address de "jal rutina" en pila // si hubieramos hecho esto antes de saltar a rutina la RA seria CERO, por eso se incluye aqui.
	li $t0,20			# cargamos 30 en a0, empezando rutina_a

repetirrutina:              
	seq $t5,$t0,31		# set if equal, establecemos t5 si t0=31
	bgtz $t5,return		# si t5 es mayor que 0, salta a return
	add $a0,$t0,$0		# copiamos el valor de t0 a a0 para mostrarlo en pantalla
	jal put_int			# JAL, salta a put_int
	add $t0,$t0,1		# suma t0=t0+1
	la $a0,esp			# cargamos esp para mostrarla por pantalla
	li $v0,4			# escribe cadena de texto
	syscall				# llamada al sistema
	j repetirrutina		# salta a repetir rutina
	
put_int:		
	li $v0,1			# escribe entero
	syscall				# llamada al sistema
	jr $31				# vuelve a la rutina anterior

return:		           
	lw $31,0($sp)		# cargamos de pila la return address
	jr $31				# volvemos a la rutina anterior
	
end:	
	la $a0,cad1			# cargamos cad_1 para mostrarla por pantalla
	li $v0,4			# escribe cadena de texto
	syscall				# llamada al sistema
	li $v0,10			# cargamos 10 en v0 para terminar el programa
	syscall 			# llamada al sistema