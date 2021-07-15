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
HALT

;======
;Data
;======

ARRAY_PTR .FILL x4000
DEC_10 .FILL #10

.orig x4000
ARRAY_1 .BLKW #10
