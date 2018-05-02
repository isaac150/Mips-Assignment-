.data
	msg:		.asciiz "\n Program to solve a quadratic equation"
	prompt_1: 	.asciiz "\n Enter value for root A = "
	prompt_2: 	.asciiz "\n Enter value for root B = "
	prompt_3: 	.asciiz "\n Enter value for root c = "
	result:		.asciiz "\nResult for x1 and x2 = "
	continue:  	.asciiz "\nDo you want to continue?\nPress 1 to continue any other number to quit : "
	ands: 		.asciiz  " & "
	root: 		.asciiz "this equation has a complex root \nplease try again"
	two:    	.float 2
        four:   	.float 4
        var1:		.float 1
        zero: 		.float 0.0
	determinant: 	.float -1.0
        
.text
	lw $t1, var1
	
	li $v0, 4
	la $a0, msg
	syscall
main:
	lwc1 $f4, zero
 	lwc1 $f2, determinant
 	lwc1 $f20, two
 	lwc1 $f18, four
 	
 	# Ask user to enter value for root A
 	li $v0, 4
 	la $a0, prompt_1
 	syscall
 	
 	li $v0, 6
 	syscall 
 	mov.s $f6, $f0
 	
 	# Ask user to enter value for root B
 	li $v0, 4
 	la $a0, prompt_2
 	syscall
 	
 	li $v0, 6
 	syscall
 	mov.s $f8, $f0
 	
 	# Ask user to enter value for root C
 	li $v0, 4
 	la $a0, prompt_3
 	syscall
 	
 	li $v0, 6
 	syscall
 	mov.s $f10, $f0
 	
 	# Calculate for B square first (b^2)
 	mul.s $f14,$f8,$f8
 	
 	# Calculate for -B 
	mul.s $f2,$f8,$f2
	
	# Calculate for A*C (AC)
	mul.s $f16, $f6, $f10 
	
	# Calculate for 4*(Ac)
	mul.s $f10, $f18, $f16
	
	# Calculate for B^2 - 4(AC)
	sub.s $f22, $f14, $f10
	
	mfc1 $t1, $f22
	bltz $t1, complexroot
	
	
	# Calculate for the square root of (B^2 - 4AC)
	sqrt.s $f28, $f22
	
	# Calculate for the first equation (-B + sqrt(B^2 - 4AC)
	add.s $f22, $f2, $f28
	
	# Calculate for the second equation (-B - sqrt(B^2 - 4AC)
	sub.s $f24, $f2, $f28
	
	# 2a check $f16 if errorr
	mul.s $f16, $f20, $f6
	
	# Calculate the first equation and divide it by 2A (-b + sqrt(B^2 - 4AC))/2A 
	div.s $f26, $f22, $f16
	
	# Calculate the first equation and divide it by 2A (-b - sqrt(B^2 - 4AC))/2A 
	div.s $f30, $f24, $f16
	
	# to output the string for the answer
	li $v0,4
	la $a0,result
	syscall
	
	# To Display the answer for the equation
	li $v0, 2
 	add.s $f12,$f26,$f4
 	syscall
 	
 	li $v0,4
	la $a0,ands
	syscall
	
	li $v0, 2
 	add.s $f12,$f30,$f4
 	syscall
 	
 	li $v0,4
	la $a0,continue
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	beq $t0,1,main
	
	li $v0,10
	syscall
 	
 	# To Check if equation has a complex value
 complexroot:
 	li $v0,4
 	la $a0,root
 	syscall
 	
 	# Jump to main if the equation has a complex values
 	j main