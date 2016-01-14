.text
	.globl __start

__start: 		           
	li $a0, 1	           
    jal recur                          
	move $a0, $v0	           
	li $v0, 1		           
	syscall 
	li $v0, 10		           
	syscall        

recur:
	addi $sp, $sp, -8	
	sw $a0, 4($sp)		
	sw $ra, 0($sp)		
	lw $v0, 4($sp)	            
	bgtz $v0, seguir	            
	addi $v0, $0, 0	           
	j volver		            

seguir:
	lw $v1, 4($sp)	            
	addi $a0, $v1, -1	            
	jal recur		            
	lw $v1, 4($sp)	    # esta parte nunca se ejecuta?  
	add $v0,$v0,$v1     # 

volver:
	lw $ra, 0($sp)	            
	addi $sp, $sp, 8            
	j $ra
