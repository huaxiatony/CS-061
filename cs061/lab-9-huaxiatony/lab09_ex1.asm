;=================================================
; Name: 
; Email:  
; GitHub username: 
; 
; Lab: lab 9
; Lab section: 
; TA: 
;=================================================

.orig x3000

LD R4, BASE
LD R5, MAX
LD R6, TOS

LEA R0, INTRO
PUTS

LD R2, DEC_6

PUSH_LOOP
	GETC				; prompt input for push
	OUT
	LD R1, SUB_STACK_PUSH	; Subroutine SUB_STACK_PUSH_3200
	JSRR R1
	ADD R2, R2, #-1			; R2 <-- R2 - #1
	BRp PUSH_LOOP			; if (R2 > 0) PUSH_LOOP
;local data
BASE .FILL xA000
MAX .FILL xA005
TOS .FILL xA000
DEC_6 .FILL #6
INTRO .STRINGZ "Enter a single character:\n"

SUB_STACK_PUSH .FILL x3200




;-------------
;
;--------------

.orig x3200
ST R0, R0_x3200
ST R1, R1_x3200
ST R2, R2_x3200
ST R5, R5_x3200
ST R7, R7_x3200
;Check if TOS reached to MAX
;if MAX == TOS
ADD R6, R6, #1
NOT R1, R5
ADD R1, R1, #1
ADD R2, R1, R6	
BRnz STORE_VALUE
  LEA R0,STACK_FULL_MSG
  PUTS
  ADD R6,R6,-1
  BR END_IF_ELSE

STORE_VALUE
  STR R6,R6,#0
  END_IF_ELSE
;then give a message the stack is full
LD R0,R0_x3200
LD R1,R1_x3200
LD R2,R2_x3200
LD R5,R5_x3200
LD R7,R7_x3200
RET
;local data
;define necessary variables
R0_x3200	.BLKW	#1
R1_x3200	.BLKW	#1
R2_x3200	.BLKW	#1
R5_x3200	.BLKW	#1
R7_x3200	.BLKW	#1
STACK_FULL_MSG	.STRINGZ	"\nOverflow Error!\n"
.END


