;=================================================
; Name: 
; Email:  
; GitHub username: 
; 
; Lab: lab 9
; Lab section: 
; TA: 
; 
;=================================================
.orig x3000

LD R4, BASE
LD R5, MAX
LD R6, TOS

LD R2, ENTERED_VALUE
PRE_LOOP
	ADD R6, R6, #1			; ADD TOS with #1
	ADD R3, R3, #1			; R3 <-- R3 + #1
	STR R3, R6, #0			; Mem[R6 + #0] <-- R3
	ADD R2, R2, #-1			; R2 <-- R2 - #1
	BRp PRE_LOOP			; if (R2 > 0) PRE_LOOP
LD R2, CONTAINER_SIZE
POP_LOOP
	LD R1,SUB_STACK_POP
	JSRR R1
	ADD R1,R0,#1
	BRz EMPTY_LOOP
	LD R3,DEC_48
	ADD R0,R0,R3
	OUT
EMPTY_LOOP
	ADD R2,R2,#-1
	BRp POP_LOOP
HALT

;local data
BASE .FILL xA000
MAX .FILL xA005
TOS .FILL xA000
SUB_STACK_POP .FILL x3400
DEC_48 .FILL #48
CONTAINER_SIZE .FILL #6
ENTERED_VALUE .FILL #4

;============================
;
;============================

.orig x3400
ST R1, R1_x3400
ST R2, R2_x3400
ST R4, R4_x3400
ST R7, R7_x3400
;Check if TOS reached to MAX
;if MAX == TOS
NOT R1,R4
ADD R1,R1,#1
ADD R2,R1,R6
BRp POPPING_LOOP

LEA R0, STACK_NOT_FULL_MSG
PUTS

ADD R0,R0,#0
ADD R0,R0,#-1
BR END_POP

POPPING_LOOP
LDR R0,R6,#0
ADD R6,R6,#-1

END_POP
;then give a message the stack is full
LD R1,R1_x3400
LD R2,R2_x3400
LD R4,R4_x3400
LD R7,R7_x3400
RET
;local data
;define necessary variables
R1_x3400	.BLKW	#1
R2_x3400	.BLKW	#1
R4_x3400	.BLKW	#1
R7_x3400	.BLKW	#1
STACK_NOT_FULL_MSG	.STRINGZ	"\nUnderflow Error!\n"
.END
