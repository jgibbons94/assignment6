#####################################################################
# Assignment #:6	Programmer: Jesse Gibbons, Alessandra Lavallee,
#                               Bucky Bodenheimer
# Merge by Jesse Gibbons
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
#       main58();    //Alessandra's code
#       main57();    //Bucky's code
#       trnsfr();    //Jesse's code
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
	jal main58          # main58()
    jal main57          # main57()
    jal trnsfr          # trnsfr()
	li $v0,	10			# Prepare to exit
    syscall             # END OF PROGRAM

#########################################################################
# Assignment #:6			Programmer: Alessandra Lavallee
# Due Date: April 28, 2017	Course: CSC 225 040
# Last Modified: April 28, 2017
#########################################################################
# Functional Description: trnsfr
#	Page 55 – Exercise: 5.8
#	Write   the complete assembly language program, 
#	including data declarations, that corre­sponds to the 
#	C code fragment: 
#
#
#
#####################################################################
#	 Pseudocode:
#
#	int main() 
#	{ int K, Y 
#	int  Z [50]
#	 Y = 56 
#	K = 20 
#	Z[K] = Y -16 * (K/4 + 210); 
#	}
# 
######################################################################
# Register Usage:
#
# v0	Holds code for syscall
# s0	Keeps track of the number of loops remaining.
# s1	Keeps track of the address of SRC.
# s2    keeps track of the address of DEST.
# t0	Contains the address to load from
# t1	Contains the address to store to
# t2	Contains the value to move from t0 to t1
# 
######################################################################

	.globl	main58	
	.data
K:	.word	20	
Y:	.word	56
Z:	.word	0:50 		    #array of 50 or pass a diff array in 

	.text
main58:	
	lw	$t1, K
	lw	$t0, Y
	sra	$t1, $t1, 2	        # K/4
	addi	$t1, $t1, 210	# K/4 + 210
	sll	$t1, $t1, 4	        #  _ x 16
	sub	$t2, $t0, $t1	    # t2 = Y - 16 * (K / 4 +210)
	lw	$t1, K		        # t1=K
	sll	$t1, $t1, 2	        # scale K
	la	$t0, Z		        # t0 = Z or move $t0, $a0
	addu	$t0, $t0, $t1   # calculate offset into Z[]
	sw	$t2, ($t0)	        # Z[20]=t2
    jr	$ra	        	    # return to calling program
                            # END OF FUNCTION

#####################################################################
# Assignment #: Assignment 6 #5.7	Programmer: Bucky Bodenheimer
# Due Date: 4/28/17    Course: CSC225-040
# Last Modified: 4/28/17
#####################################################################
# Functional Description:
#	This program allows a user to enter 3 integers and the min
#	and max integers will be displayed to the console.
#####################################################################
#	 Pseudocode:
#	
#int main() {
#	printf("Enter Integer");
#	scanf(1st);
#	printf("enter another");
#	scanf(2nd);
#	printf("enter last integer");
#	scanf(3rd);
#		if (3rd < 2nd) {
#			temp = 3rd;
#			2nd = 3rd;
#			2nd = temp;
#				if (2nd < 1st) {
#					temp = 2nd;
#					2nd = 1st;
#					1st = temp;
#				}
#
#		else {
#			printf("Min: ", 1st);
#			printf("Max: ", 3rd);
#		}
#	}	
# 
######################################################################
# Register Usage:
# v0 - return register
# a0 - system
# t0-t2 - temporary registers filled with user input for calculation
######################################################################
	.data	                #data declaration section
prompt:	.asciiz "\nPlease enter an integer: "
min:	.asciiz "\nMinimum: "
max:	.asciiz "\nMaximum: "
	.text	
	
main57:
	li	$v0, 4		        	#print string
	la	$a0, prompt 	    	#load prompt
	syscall			        	#print prompt to I/O
	li	$v0, 5	    	    	#read integer
	syscall			        	#put value into $v0
	move	$a1, $v0	    	#move 1st integer to $t0
main57_second:	
	li	$v0, 4	    	    	#print string
    la	$a0, prompt         	#ask for integer again
	syscall	
	li	$v0, 5		        	#read integer into v0
	syscall	
	move	$a2, $v0	    	#move 2nd input to $t1
main57_less:
	blt	$a2, $a1, main57_swap	#if t1 < t0 branch to swap
	bgt	$a2, $a1, main57_last
		
main57_swap:	
	xor	$a1, $a1, $a2	    	#swap values if t1 < t0
	xor	$a2, $a1, $a2	
	xor	$a1, $a1, $a2	
	beqz	$a3, main57_last	
	bgtz	$a3, main57_print
	jal	last		        	#jump back to last
		
main57_last:		
	li	$v0, 4		        	#print string
	la	$a0, prompt	        	#ask for integer again
	syscall	
	li	$v0, 5	    	    	#read integer
	syscall	
	move	$a3, $v0	    	#move 3rd input to $t2
	blt	$a3, $a2, main57_swap2
	bgt	$a3, $a2, main57_print
		
main57_swap2:		
	xor	$a2, $a2, $a3	    	#swap values if t1 < t0
	xor	$a3, $a2, $a3	
	xor	$a2, $a2, $a3	
	jal	main57_less2	    	#jump back to last
		
main57_less2:	
	blt	$a2, $a1, main57_swap	#if t1 < t0 branch to swap
	bgt	$a2, $a1, main57_print
		
main57_print:	
	li	$v0, 4		        	#print integer
	la	$a0, min	        	#load prompt
	syscall	
	li	$v0, 1	
	la	$a0, ($a1)	
	syscall	
	li	$v0, 4	
	la	$a0, max	
	syscall	
	li	$v0, 1	
	la	$a0, ($a3)	
	syscall		    	    	#print prompt to I/O	
    jr	$ra		          	    #return to calling program
								# END OF FUNCTION

#####################################################################
# Assignment #:6			Programmer: Jesse Gibbons
# Due Date: April 28, 2017	Course: CSC 225 040
# Last Modified: April 25, 2017
#####################################################################
# Functional Description: trnsfr
#	Page 55 – Exercise: 5.2
#	Write a MIPS assembly language program to transfer a block of 100 words starting at memory location SRC to another area of memory beginning at memory location DEST.
#
#
#
#####################################################################
#	 Pseudocode:
#
#	s0 = 99 * sizeof(WORD);
#	s1 = &SRC;
#	s2 = &DEST;
#	do{
#		t0 = s0 + s1
#		t1 = s0 + s2
#		t2 = *(t1 + 0)
#		*(t2 + 0) = t2
#		s0 = s0 - 1
#	}while(s0 >= 0);
#	return;
# 
######################################################################
# Register Usage:
#
# v0	Holds code for syscall
# s0	Keeps track of the number of loops remaining.
# s1	Keeps track of the address of SRC.
# s2    keeps track of the address of DEST.
# t0	Contains the address to load from
# t1	Contains the address to store to
# t2	Contains the value to move from t0 to t1
# 
######################################################################
	.data						# Data declaration section

SRC:
.word 0xdeadbeef:100			# Reserve 100 words, each with value 0xdeadbeef. The initial value doesn't matter as long as it is different than the initial value in DEST.
DEST:
.word 0:100						# Reserve 100 words, each with value 0
	.text			    		# Executable code follows
	
trnsfr:
	li		$s0,	99			#load a counter into s0.
    sll     $s0,    $s0,    2   #size of word is 4 bytes, so left shift 2
	la		$s1,	SRC			#load address of SRC  into register s1
	la		$s2,	DEST		#load address of DEST into register s2
trnsfr_loop:
	add		$t0,	$s0,	$s1	# t0 = s0 + s1;
	add		$t1,	$s0,	$s2	# t1 = s0 + s2;
	lw 		$t2,	0($t0) 		# t2 = *(t0 + t1);
	sw 		$t2,	0($t1)  	# *(t1 + 0) = t2;
	addi	$s0,	-4			# s0--;
	bgez	$s0,	trnsfr_loop # if s0 >= 0 goto loop;
	jr		$ra					# return function;
                                # END OF function
						
	
	
