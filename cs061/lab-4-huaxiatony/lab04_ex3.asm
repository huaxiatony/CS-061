;=================================================
; Name: <Hua, Xia>
; Email: xhua006@ucr.edu
; Giuthub username: huaxiatony
; Lab: <lab 4>
; Lab section:023
; TA: Colvin, Robert
;=================================================
.orig x3000 ;program begins here 
;============
;Instructions 
;============
LD R5, ARRAY_PTR
LD R6, DEC_10

DO_WHILE
	Trap x20
	STR R0,R5,#0
	ADD R5,R5,#1
	ADD R6,R6,#-1
	BRp DO_WHILE
END_DO_WHILE_LOOP_INPUT

LD R5, ARRAY_PTR
LD R6, DEC_10

DO_WHILE_OUTPUT
	LDR R0,R5,#0
	Trap x21
	LD R0, NEW_LINE
	Trap x21
	ADD R5,R5,#1
	ADD R6,R6,#-1
	BRp DO_WHILE_OUTPUT
END_DO_WHILE_LOOP_OUTPUT

;======
;Data
;======
ARRAY_PTR .FILL x4000
DEC_10 .FILL #10
NEW_LINE .FILL x0A
.orig x4000
ARRAY_1 .BLKW #10


