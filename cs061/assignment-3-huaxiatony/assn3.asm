;=================================================
; Name: Xia Hua 
; Email: xhua006@ucr.edu
; GitHub username: huaxiatony
; 
; Assignment name: Assignment 3
; Lab section: 023
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, COUNTER
;------------------------
MAIN_LOOP
	ADD R1,R1,#0
	BRn PRINT_ONE
	BRzp PRINT_ZERO
;-------------------------
PRINT_ONE
	LD R0,ONE
	OUT
	ADD R2,R2,#-1
	BRp END_LOOP
	BRz PRINT_NEWLINE 
;-----------------------------
PRINT_ZERO
	LD R0,ZERO
	OUT
	ADD R2,R2,#-1
	BRp END_LOOP
	BRz PRINT_NEWLINE
;-------------------------
END_LOOP
	ADD R1,R1,R1
	ADD R3,R2,#-12
	BRz PRINT_SPACE
	ADD R3,R2,#-8
	BRz PRINT_SPACE
	ADD R3,R2,#-4
	BRz PRINT_SPACE
	BR MAIN_LOOP
;-------------------------
PRINT_SPACE
	LD R0,SPACE
	OUT
	BR MAIN_LOOP
;--------------------------
PRINT_NEWLINE
	LD R0,NEW_LINE
	OUT

HALT
;---------------	
;Data
;---------------
Value_addr	.FILL xD800	; The address where value to be displayed is stored
COUNTER		.FILL	#16
ZERO		.FILL	#48
ONE		.FILL	#49

NEW_LINE	.FILL	#10
SPACE		.FILL	#32

.ORIG xD800					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
