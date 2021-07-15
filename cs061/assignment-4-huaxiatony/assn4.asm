;=================================================
; Name: 
; Email: 
; GitHub username: 
; 
; Assignment name: Assignment 4
; Lab section: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================
;main program
.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;R0 input
;R1 Check have symbol /or not
;R2 Counter #6
;R3 RAW data storage  (SAME AS R5)
;R6 Check symbol is '-'/'='/''
;R5 Processing data
;R4 REPRESENTATION value (important)
;-------------------------------
;INSERT CODE STARTING FROM HERE 
;--------------------------------
;Example of how to Output Intro Message
;LD R0, introMessagePtr  ; Get pointer to Intro Message
;PUTS
;Example of how to Output Error Message
;LD R0, errorMessagePtr  ; Get pointer to Error Message
;PUTS

MAIN_LOOP
LD R2, Counter 		; init counter as 6 character 
ADD	R3,R3,#0	; init R3
AND	R1,R1,#0 	; Symbol Checker 0 =no 1 =yes
AND	R6,R6,#0 	; 0 = + 1 = - Default 0
AND	R4,R4,#0 	; Init the final output to 0	
LD R0, introMessagePtr
PUTS

SUB_LOOP
GETC			;Take user input
ADD R3,R0,#0		;Put user input data to R1
LD R5, NEWLINE_N		;Load Newline to check it later 
ADD R3,R3,R5		;if R1 is enter(newline) then R1 will be zero
BRnp OUTPUT_CHAR 	;if is positive or negative jump to output function.
	
;----------------
;Output Condition
;----------------
OUTPUT_CHAR
OUT
BR CHECK_DIGIT	;JUMP to check digit 
	
;This function prints the NEWLINE ERROR
NEWLINE_ERROR
LD R0, NEWLINE
OUT
LD R0,errorMessagePtr
PUTS			;OUTPUT IF IS ERROR 
BR MAIN_LOOP	
;---------------------
;Checking First Digit
;---------------------	
NEGATIVE
NOT R4,R4
ADD R4,R4,#1
BR PRINT_NEWLINE
CORRECT_VALUE
LD R5,DEC_48_N
ADD R0,R0,R5
ADD R4,R0,R4
ADD R2,R2,#-2
BR SUB_LOOP
CHECK_NEWLINE
;check if is a newline, check if it is the first char
ADD R3,R2,#0 			;Copy current counter to R1
ADD R3,R1,#-6 			;substract 6 from the counter
BRz ABOVE_NINE 	 		;if 0 then 1st char = newline. ERROR
	
;if this is a newline, now check if it is the second char
ADD R3,R2,#0			; Copy current counter to R1
ADD R3,R3,#-5			;
BRnp END_LOOP
ADD R3,R1,#0
ADD R3,R3,#-1
BRz NEWLINE_ERROR
BRnp END_LOOP

CHECK_PLUS
ADD R3,R2,#0
ADD R3,R3,#-6
BRnp ABOVE_NINE
	
ADD R6,R6,#0
ADD R1,R1,#1
ADD R2,R2,#-1
BR SUB_LOOP

CHECK_MINUS
ADD R3,R2,#0
ADD R3,R3,#-6
BRnp ABOVE_NINE

ADD R6,R6,#1
ADD R1,R1,#1
ADD R2,R2,#-1
BR SUB_LOOP

;-------------------------
;Under Zero Condition 
;--------------------------
UNDER_ZERO
;Check the value is plus (0) for yes
LD R5,PLUS
ADD R3,R0,#0
ADD R3,R3,R5
BRz CHECK_PLUS
	
;Check the value is minus (0) for yes
LD R5,MINUS
ADD R3,R0,#0
ADD R3,R3,R5
BRz CHECK_MINUS

;Check the value is NEWLINE (0) for yes
LD R5,NEWLINE_N
ADD R3,R0,#0
ADD R3,R3,R5
BRz CHECK_NEWLINE

ABOVE_NINE
ADD R3,R0,#0
ADD R3,R3,#-10
BRnp	NEWLINE_ERROR

LD R0,errorMessagePtr
PUTS					;OUTPUT IF IS ERROR 
BR MAIN_LOOP				;START OVER AND START A NEW CHARACTER DECISION.	

;-------------------------------
; Data Handling Unit
;-------------------------------
CHECK_DIGIT
;if ASCII value less than #0
ADD R3,R0,#0 
LD R5,DEC_48_N
ADD R3,R3,R5 
BRn UNDER_ZERO 
	
;if ASCII value is greater than #9
ADD R3,R0,#0
LD R5,DEC_57_N
ADD R3,R3,R5
BRp ABOVE_NINE 
	
	;Here we can get the value from 0 to 9 (48 - 57)
	;IF THIS IS THE FIRST CHARACTER 
	ADD R3,R2,#0	;COPY CURRENT COUNTER TO R1
	ADD R3,R3,#-6	;SUBTRACT 6 FROM CURRENT COUNTER
	BRz CORRECT_VALUE ; 
	
;ADDING
ADD R4,R4,R4; 2X= X+X
ADD R5,R4,R4; 4X =2X+2X
ADD R5,R5,R5; 8X = 4X+4X
ADD R4,R4,R5; 10X = 2X+8X
	
;THEN add the inputted char to R5
LD R5,DEC_48_N
ADD R0,R0,R5
ADD R4,R4,R0
ADD R2,R2,#-1
BRp SUB_LOOP
BRz END_LOOP
END_LOOP
ADD R3,R6,#0
ADD R3,R3,#-1
BRz NEGATIVE
PRINT_NEWLINE
LD R0,NEWLINE
OUT
	
HALT




;---------------	
;Data
;---------------
DEC_48_N		.FILL #-48
DEC_57_N		.FILl #-57
NEWLINE_N			.FILL #-10
NEWLINE		.FILL #10
MINUS			.FILL #-45
PLUS			.FILL #-43
Counter			.FILL #6
introMessagePtr		.FILL x6000
errorMessagePtr		.FILL x6100

;------------
;Remote data
;------------
.ORIG x6000
;---------------
;welcome messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_msg	.STRINGZ	"ERROR INVALID INPUT\n"
;---------------
;END of PROGRAM
;---------------
.END
;-------------------
;PURPOSE of PROGRAM
;-------------------

