#Chadille Jones
#02856918 % 11 = 9 Base 35

.data  #data declaration section
user_input: .space 2000 #creating space for the users input
invalid: .asciiz "Invalid input"
list: .word 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 #initialize a word list


.text #Assembly language instruction

main: 

	li $v0, 8 #accepts user input
	la $a0, user_input
	li $a1, 102 #specify the length the user can input
	syscall
	
	lw $t0, user_input #loads the word in $t0
	sub $sp, $sp, 12 #moves the pointer for stack
	sw $t0, 4($sp) #adds the input string to the stack
	la $a0, list #load the list 
	
	
	jal getValidString #jumps to subprogram A
	
	
	
getValidString:   #subprogram A to accept all the string and make it substrings
	sw $ra, 0($sp) #stores the return address for the program
	li $t1, 20 #checks if number if characters us >=20
	li $t2, 0x0A #initialized a new line
	la $t3, 4($sp) #loads the user_input
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
	add $s5, $a0, $zero
	j loop
	
	loop:
		bgt $t6,$t1, print_invalid_input #if number of valid characters is greater than 20
		lb $s4, 0($t3) #gets a character of the string
		beq $t6, $t7, leading_characters #branch if character could be considered leading
		beq $s4, $t4, skip_trailing_tab_or_space #branches if trailing character is equal to space
		beq $s4, $t5, skip_trailing_tab_or_space #branches if trailing character is equal to tab
		beq $s4, $s3, valid_input #branches if a newline comes before a invalid character is entered
	check_if_invalid:
		blt $s4, $t8, print_invalid_input #breaks if ascii of character is < 48
		bgt $s4, $t9, not_a_digit #breaks if ascii of character is > 57
		addi $s4, $s4, -48 #makes the ascii for digit align with digits
		
	leading_characters:
		beq $s4, $t4, skip_leading_tab_or_space #branches if leading charater is a space
		beq $s4, $t5, skip_leading_tab_or_space #branches if leading character is a tab
		j check_if_invalid #if it is not a tab or space then check if is valid
	
	skip_leading_tab_or_space: #skips character and goes to the next one
	addi $s4, $s4, 1
	j loop
	
	skip_trailing_tab_or_space:  #fucntion for checking if the rest of the code is all trailing tabs or spaces
	addi $s4, $s4, 1 #move to the next byte
	lb $s4, 0($t3)  #gets a character of the string
	beq $s4, $s3, valid_input #branches if only trailing tabs are spaces are found before newline
	bne $s4, $s4, not_a_space #branches if character is not a space
	j skip_trailing_tab_or_space #returns to check next character for trailing tab or space

	not_a_space:
	bne $s4, $t5, print_invalid_input #if character after space for trailing is not a tab or space then print invalid
	j skip_trailing_tab_or_space #returns to check the next character for trailing tab or space

	print_invalid_input: #prints invalid input and exists file
	li $v0, 4
	la $a0, invalid #prints "Invalid Input"
	syscall
	
	li $v0, 10
	syscall #tell the system to end the program
	
	not_a_digit:
	blt $s4, $s0, print_invalid_input #breaks if ascii of character is < 65
	bgt $s4, $s1, not_a_capital_letter #breaks if ascii of character is > 89
	addi $s4, $s4, -55 #makes the ascii for digit align with capital letters
	
	
	not_a_capital_letter: 
	blt $s4, $s2, print_invalid_input #breaks if ascii of character is < 97
	bgt $s4, $s3, print_invalid_input #breaks if ascii of character is > 121
	addi $s4, $s4, -87 #makes the ascii for digit align with common letters

	
	valid_input:
	
	
