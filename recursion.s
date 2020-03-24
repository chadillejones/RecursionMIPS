#Chadille Jones
#02856918 % 11 = 9 Base 35

.data  #data declaration section
user_input: .space 2000 #creating space for the users input
invalid: .asciiz "Invalid input"

.text #Assembly language instruction

main: 

	li $v0, 8 #accepts user input
	la $a0, user_input
	li $a1, 102 #specify the length the user can input
	syscall
	
	lw $t0, user_input #loads the word in $t0
	sub $sp, $sp, 12 #moves the pointer for stack
	sw $t0, 4($sp) #adds the input string to the stack

	
	jal processString #jumps to subprogram A
	
	
	
processString:   #subprogram A to accept all the string and make it substrings
	sw $ra, 0($sp) #stores the return address for the program
	li $t1, 20 #checks if number if characters us >=20
	li $t2, 0x0A #initialized a new line
	
	
	