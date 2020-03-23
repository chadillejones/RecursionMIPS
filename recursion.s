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