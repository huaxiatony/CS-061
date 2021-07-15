;=================================================
; Name: Xia Hua
; Email:  xhua006@ucr.edu
; GitHub username: huaxiatony
;
; Lab: lab 5
; Lab section: 023
; TA: Colvin, Robert
;=================================================

.orig x3000
;============
;instructions
;============

LD R4, ARRAY_PTR	;Starting pointer of array
;LD R5, COUNTER		;R5 <-- #16, Because we want to print 16 character
LD R6, POSITION		;R5 <-- #-1,Where prints '1' 
LD R3, LINE		;I want to print 10 lines R3<--#10
LD R2, SPACE_COUNTER
;LD R1, SPACE_TIMER
OUTER_LOOP
	LD R5, COUNTER			;R5 <-- #16, Because we want to print 16 character
;	LD R6, POSITION			;R5 <-- #-1,Where prints '1' 
	LD R1, SPACE_TIMER
	LD R0, ASC_B
	OUT
	INNER_LOOP			;Task of the inner loop to print one line
		ADD R0,R5,R6		;CHeck if the counter value reach to the position where we have to print '1'
		BRnp PRINT_ZERO		;If previous operation is Zero, you have to print '1', other wise print '0'
	
		PRINT_ONE		;Tag line of printing One
			LD R0,ONE	;Load R0 with '1'
			OUT		;Display R0
			BR END_PRINTING_ZERO_ONE		;This Unconditional Brancing needed so that next it does not Print Zero
				
		PRINT_ZERO		;Tag line of printing Zero	
			LD R0, ZERO	;Load R0 with '0'
			OUT		;Display R0
			;BR END_PRINTING_ZERO_ONE
		END_PRINTING_ZERO_ONE	;End of if-else
		

		;ADD R1,R1,#-1
		;BRp CONTINUE_MAKE_SPACE
		;	PRINT_SPACE_TIMES
				
				ADD R2,R2,#-1		;Reduce the space counter
				BRp CONTINUE_INNER_LOOP	;IF it is positive continue with inner loop
			PRINT_SPACE		;else print the space 
			
				ADD R1,R1,#-1
                                BRn END_INNER_LOOP				

				LD R0,SPACE		;load space char to R0
				OUT
				LD R2,SPACE_COUNTER	;Reset the space counter to 4
				;ADD R1,R1,#-1
				;BRn END_INNER_LOOP
			CONTINUE_INNER_LOOP


		;CONTINUE_MAKE_SPACE




	 	;LD R1,SPACE_TIMER	
		ADD R5, R5,#-1		;Decrement the counter until of became 0, 16,15,14,..........,1,0
		BRp INNER_LOOP		;If the previous operation positive, do the task of inner loop
		;LD R1,SPACE_TIMER
	END_INNER_LOOP
LD R2,SPACE_COUNTER
LD R1,SPACE_TIMER
LD R0,NEW_LINE			;Print a new line 
OUT				;Print

ADD R6,R6,#-1			;Decrement the POSITION until if become -1,-2,-3,....,-10
ADD R3,R3,#-1			;Decrement the line counter
BRp OUTER_LOOP			;Do outer loop until the previous operation is positive

HALT
;==========
;LOCAL DATA
;==========
ARRAY_PTR	.FILL	x4000
COUNTER		.FILL	#16
POSITION	.FILL	#-1
ZERO		.FILL	#48
ONE		.FILl	#49
NEW_LINE	.FILL	#10
LINE		.FILL	#10
SPACE		.FILL	#32
SPACE_COUNTER	.FILL	#4
ASC_B		.FILL	x62
SPACE_TIMER	.FILL	#3
;.orig x4000
;ARRAY_1 .BLKW   #10
