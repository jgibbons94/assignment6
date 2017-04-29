#####################################################################
# Assignment #:7	Programmer: Jesse Gibbons, Alessandra Lavallee,
#                               Bucky Bodenheimer
# Merge by Alessandra Lavallee and Jesse Gibbons
# Due Date:April 28, 2017     Course: CSC 225 040
# Last Modified:April 28, 2017
#####################################################################
# Functional Description: Main
#After each person on the team has completed their exercise, combine
#the exercises into one program. Make sure you comment what each
#person has completed. EACH PERSON must upload the completed program
#to their own D2L Dropbox.
#
#####################################################################
#	 Pseudocode:
#	void main()
#	{
#       main72();    //Bucky's code
#       largest();    //Jesse's code
#       Assn73();    //Alessandra's code
#       exit
#	}
#
######################################################################
# Register Usage:
# 
# 
# 
######################################################################
	.data				# Data declaration section

	.text			    # Executable code follows
main:
   	jal main72         	# main72()
	jal largest         # largest()
	jal Assn73          # Assn73()
# END OF PROGRAM
#########################################################################
# Assignment #:7 			Programmer: Alessandra Lavallee
# Due Date: April 28, 2017	Course: CSC 225 040
# Last Modified: April 28, 2017
#########################################################################
# Functional Description:
# 3. Continually prompt the user for an integer.  Constrain the user’s input to integers
# between 1 and 100,000.  You can assume that the user will enter an integer and not a string.
#
#
#
#####################################################################
#	 Pseudocode:
#
#	
#	
#	
#	 
#	
#	
#	
# 
######################################################################
# Register Usage:
# a0  Holds the pointe to the messages 
# s0	Holds code for syscall 
######################################################################
	.globl Assn73
	.data
pmtmsg:	.asciiz	"\nEnter a number between 1 and 100000 inclusive: "
errmsg:	.asciiz	"\nNumber was outside of 1-100000.\n"

	.text
Assn73:
loop:
	la	$a0, pmtmsg
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall

	blt	$v0, 1, err
	bgt	$v0, 100000, err
	j	loop
err:
	la	$a0, errmsg
	li	$v0, 4
	syscall
	j 	loop

	jr	$ra	        	    	# return to calling program
                            	# END OF FUNCTION
#####################################################################
# Assignment #: 7			Programmer: Jesse Gibbons
# Due Date: April 28, 2017	Course: CSC 225 040
# Last Modified: April 25, 2017
#####################################################################
# Functional Description:
# 
# Write a function that takes 3 int arguments and returns the largest of the 3.
# 
#####################################################################
#	 Pseudocode:
#	int largest(a0, a1, a2) {
#	v0 = a0;
#	if a1 > t0
#		v0 = a1;
#	if a2 > t0
#		v0 = a2;
#	return v0;
#	
######################################################################
# Register Usage:
#	a0 the first parameter.
#	a1 the second parameter.
#	a2 the third parameter.
#	v0 the return register.
# 
######################################################################
	.data							# Data declaration section
			
	.text			    			# Executable code follows
				
									# END OF PROGRAM
main71:
    li      $a0,	44				#a0 = 44
    li      $a1,    0x44			#a1	= 0x44
    li      $a2,    0				#a2 = 0
	addi	$sp,	-4				#prepare to push $ra
	sw		$ra,	0($sp)			#push ra register
	jal 	largest					#largest(a0,a1,a2)
	lw		$ra,	0($sp)			#pop ra register
	jr		$ra						#return
.text
largest:
	move	$v0,	$a0				# v0 = a0
	ble		$a1,	$v0,	check2	# if a2 <= v0 goto check2
	move	$v0,	$a1				# v0 = a1
check2:
	ble		$a2,	$v0,	return	# if a2 <= v0 goto return
	move	$v0,	$a2				# v0 = a2
return:
	jr		$ra						#return
#####################################################################
# Assignment #: 7 - 2	Programmer: Bucky Bodenheimer
# Due Date: 4/28/17    Course: CSC 225-040
# Last Modified: 4/28/17
#####################################################################
# Functional Description:
# Write an Assembler program to perform the task of temperature 
# conversion from Celsius to Fahrenheit. Note that given C as the 
# degree of temperature in Celsius, the corresponding degree F in 
# Fahrenheit equals 1.8*C + 32.0
#
#####################################################################
#	 Pseudocode:
#	prompt user for temp in Celsius
#	store input to $a0
#	mult $a0, 1.8
#	add $a0, $a0, 32
#	print temp in F to user
#	
#	
# 
######################################################################
# Register Usage:
# 
# 
# 
######################################################################
	.data					# Data declaration section
input:	.asciiz	"\nEnter degrees in Celsius: "
output:	.asciiz	"\nFahrenheit: "
	.text			    	# Executable code follows
main72:	
	li		$v0, 4			# call to print string
	la		$a0, input		#load input string
	syscall					#print to console
	li		$v0, 5			#read int
	move	$t0, $v0		#store user input to t0
	syscall
	
	li	$t1, 9
	li	$t2, 5
	mult	$t0, $t1		#multiply user input by 9
	#s.d	$f0, ($t0)		#stores product for float calculation
	div	$t0, $t2			#divide product by 5
	#srl	$t3, $t0, 5
	addi	$t0, $t0, 32 	#add 32
	
	li		$v0, 4
	la		$a0, output
	syscall
	
	move	$a0, $t0
	li		$v0, 1
	syscall
	jr 		$ra
# END OF PROGRAM
