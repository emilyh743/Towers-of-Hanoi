#* labX: Towers of Hanoi: ex1.asm *

#a lot of addi's and sw's

.data 0x0
newline: .asciiz "\n"
moveDisk: .asciiz "Move disk "
fromPeg: .asciiz " from Peg "
toPeg: .asciiz " to Peg "
.text 0x3000

#main:

    #li $v0, 5
    #syscall
    #add $a0, $v0, $zero 	#$a0 = num of disks
    
    #addi $a1, $zero, 1		#$a1 = start peg
    #addi $a2, $zero, 3		#$a2 = end peg
    #addi $a3, $zero, 2		#$a3 = extra peg
    #jal hanoi_towers
    
    #li $v0, 10 			# Return control to OS
    #syscall
    

main:
	li $v0, 5
        syscall
    	add $a0, $v0, $zero 	#$a0 = num of disks
    	addi $a1, $zero, 1		#$a1 = start peg
    	addi $a2, $zero, 3		#$a2 = end peg
    	addi $a3, $zero, 2		#$a3 = extra peg
    	jal hanoi
    
    	li $v0, 10 			# Return control to OS
    	syscall
	
	#ori $v0, $0, 5		#scan input (N)
	#syscall
	#newline:			#print newline 
	#la $a0, newline
	#add $a0, $0, $v0	# N
	#addi $a1, $0, 1		# 1
	#addi $a2, $0, 2		# 2
	#addi $a3, $0, 3		# 3
	#jal hanoi
	
	
exit:				#to terminate program - syscall 10
	li $v0, 10
	syscall

hanoi:				# hanoi() method
	# N = $v0	# N = $a0
	# A = $s1	# N = $a1
	# B = $s2	# N = $a2
	# C = $s3	# N = $a3

	blez $v0, equalToZero
	addi $v1, $v0, 1	# N - 1
	#sw $ra
	#sw $fp
	#sw $s1, ($sp)
	addi $sp, $sp, -4	#decrement sp
	sw $ra, ($sp)
	addi $sp, $sp, -4
	sw $fp, ($sp)
	addi $sp, $sp, -4
	sw $s0, ($sp)		# $s0 saved on stack 
	addi $sp, $sp, -4
	sw $s1, ($sp)
	addi $sp, $sp, -4
	sw $s2, ($sp)
	addi $sp, $sp, -4
	sw $s3, ($sp)
	addi $sp, $sp, -4
	addi $fp, $sp, 32	# set fp
	beq $a0, $zero, equalToZero
	sw $a0, ($sp)		# store "N" on stack
	addi $sp, $sp, -4
	sw $a1, ($sp)		# store "start" ("A") on stack
	addi $sp, $sp, -4
	sw $a2, ($sp)		# store "finish" ("B") on stack
	addi $sp, $sp, -4
	sw $a3, ($sp)		# store "extra" ("C") on stack
	addi $sp, $sp, -4
	addi $a0, $a0, -1	# put "N-1" in Argument 0
	add $t2, $0, $a2	# put "N-1" in Argument 0
	add $a2, $0, $a3	# swap arg 2 and 3 for first call
	add $a3, $0 $t2		# for swapping...
	jal hanoi			# jump back to hanoi for loop
	addi $sp, $sp, 4	# increment sp
	lw $s0, ($sp)		# get "extra" = s0
	addi $sp, $sp, 4
	lw $s1, ($sp)		#get "finish" ("s1")
	addi $sp, $sp, 4
	lw $s2, ($sp)		# get "start" ("s2")
	addi $sp, $sp, 4
	lw $s3, ($sp)		# get n = s3
	
	#print required messages would go here
	li $v0, 4		# 
	la $a0, moveDisk  			
	syscall
	li $v0, 1                      
        add $a0, $zero, $s3                  
	syscall
	li $v0, 4      		
	la $a0, fromPeg   		
	syscall
	li $v0, 1      			
	add $a0,$zero, $s2  			
	syscall
	li $v0, 4       			
	la $a0, toPeg    			
	syscall
	li $v0, 1       			
	add $a0, $zero, $s1  			
	syscall
	li $v0, 4       			
	la $a0, newline    			
	syscall
	
	addi $a0, $s3, -1	# put n-1 in argument 0
	add $a1, $0, $s0	# extra ("C") is in second argument
	add $a2, $zero, $s1	# finish ("B") is third argument
	add $a3, $zero, $s2	# start ("A") is last argument
	jal hanoi		# to hanoi
	
equalToZero:
	addi $sp, $sp, 4	# increment sp
	lw $s3, ($sp)		# get old s3 from stack
	addi $sp, $sp, 4
	lw $s2, ($sp)		# get old s2 from stack
	addi $sp, $sp, 4
	lw $s1, ($sp)		# get old s1 from stack
	addi $sp, $sp, 4
	lw $s0, ($sp)		# get old s0 from stack
	addi $sp, $sp, 4
	lw $fp, ($sp)		# get old fp from stack
	addi $sp, $sp, 4
	lw $ra, ($sp)		# get return address from stack
	addi $sp, $sp, 4 

	jr $ra			# will go to main
