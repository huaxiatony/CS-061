;=================================================
; Name: Xia Hua 
; Email: xhua006@ucr.edu
; GitHub username: huaxiatony
; 
; Assignment name: Assignment 2
; Lab section: CS061.023
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string
;-------------------------------
;INSERT YOUR CODE BELOW
;--------------------------------
AND R1,R1,#0
AND R2,R2,#0

Trap x20	;GETC
ADD R1, R0, #0	;Get the 1st number to R1
Trap x21
LD  R0, NEWLINE ;Make a new line
Trap x21	;OUT

Trap x20	;GETC
ADD R2, R0, #0	;Get the 2nd number to R2
Trap x21
LD  R0, NEWLINE	;Make a new line
Trap x21	;OUT
;----------------
;OUTPUT INTERFACE
;----------------

ADD R0, R1, #0		;Copy R1 to R0 and print
Trap x21
LD  R0, SPACE 		;Print space
Trap x21  		
LD  R0, MIN_SIGN	;Print '-'
Trap x21		
LD  R0, SPACE 		;Print ' '
Trap x21		

ADD R0, R2, #0		;Copy R2 to R0 to print 
Trap x21		
LD  R0, SPACE 		;Print space
Trap x21
LD  R0, EQU_SIGN	;Print '='
Trap x21		
LD  R0, SPACE 		;Print ' '
Trap x21		

;-----------
;Calculation R2 to negative
;-----------

NOT R2, R2	;Flip the R2 
ADD R2, R2 ,#1	;Add 0001 to negative 
ADD R6, R1 ,R2	;Adding R1 to R2 to R6
;-------------
;if statement 
;-------------

BRn NEGATIVE
;If positive
LD R7, DEC_48
ADD R0,R6,R7
Trap x21

LD R0,NEWLINE
Trap x21
HALT

NEGATIVE
	LD R0,MIN_SIGN
	Trap x21	;show negative sign
	ADD R0,R6,#-1	;add -1
	NOT R0,R0
	LD R6,DEC_48
	ADD R0,R0,R6
	Trap x21
	LD R0,NEWLINE
	Trap x21
;--------------------------------
HALT				; Stop execution of program


;------	
;Data
;------
; String to explain what to input 
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with PUTS. Note: already includes terminating newline!
NEWLINE .FILL '\n'	; newline character - use with OUT
MIN_SIGN .FILL x2D	;'-' character
EQU_SIGN .FILL x3D	;'=' character
SPACE .FILL x20		;' ' character
DEC_48 .FILL #48	;'0' value
;DEC_N48 .FILL #-48	;'-0' value
;---------------	
;END of PROGRAM
;---------------	
.END


