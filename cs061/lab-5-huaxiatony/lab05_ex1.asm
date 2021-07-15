;=================================================
; Name: Xia Hua 
; Email:  xhua006@ucr.edu
; GitHub username: huaxiatony
; 
; Lab: lab 5
; Lab section: 023
; TA: Colvin, Robert
;=================================================
LD R1, ZERO 
LD R3, COUNTER
LD R4, ARRAY_PTR

WHILE_LOOP
	;take input R0
	STR R1, R4, #0
	ADD R1, R1, #1
	ADD R4, R4, #1
	ADD R3, R3, #-1
	BRp WHILE_LOOP

;access the 7th value 
LD R4, ARRAY_PTR	; R4 <-- x4000
ADD R4, R4, #6		; R4 <-- x4006
LDR R2, R4, #0		; R2 <-- m[x4006]
;Instead of previous two line you can use: LDR R2, R4, #7
HALT
;Stored Data
ARRAY_PTR	.FILL x4000
ZERO		.FILL #0
COUNTER		.FILL #10

.orig x4000
ARRAY_1	.BLKW	#10


