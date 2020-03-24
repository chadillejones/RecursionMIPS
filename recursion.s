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

	
	jal getValidString #jumps to subprogram A
	
	
	
getValidString:   #subprogram A to accept all the string and make it substrings
	sw $ra, 0($sp) #stores the return address for the program
	li $t1, 20 #checks if number if characters us >=20
	li $t2, 0x0A #initialized a new line
	lw $t3, 4($sp) #loads the user_input
	li $t4, 32 #loaded a space here 
	li $t5, 9 #loaded a tab here
	li $t6, 0 #initialized count of valid characters
	li $t7, 0 #initialized zero
	li $t8, 48 #lowest possible valid character ascii
	li $t9, 57 #hightest possible non-letter digit ascii
	li $s0, 65 #lowest possible capital letter ascii
	li $s1, 89 #highest possible capital letter ascii # =Y since N = 35
	li $s2, 97 #lowest possible common letter ascii 
	li $s3, 121 #highest possible common letter ascii = y since N = 35
	j loop
	
	loop:
		bgt $t6,$t1, print_invalid_input #if number of valid characters is greater than 20
		lb $t0, 0($t3) #gets a character of the string
		beq $t6, $t7, leading_characters #branch if character could be considered leading
		
	leading_characters:
		beq $t0, $t4, skip_leading_tab_or_space #branches if leading charater is a space
		beq $t0, $t5, skip_leading_tab_or_space #branches if leading character is a tab
		j check_if_invalid #if it is not a tab or space then check if is valid
	
	skip_leading_tab_or_space: #skips character and goes to the next one
	addi $t3, $t3, 1
	
	print_invalid_input: #prints invalid input and exists file
	li $v0, 4
	la $a0, invalid #prints "Invalid Input"
	syscall
	
	li $v0, 10
	syscall #tell the system to end the program
	
	
	
	