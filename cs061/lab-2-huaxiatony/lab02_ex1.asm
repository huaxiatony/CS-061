;=================================================
; Name: <Hua, Xia>
; Email: xhua006@ucr.edu
; Giuthub username: huaxiatony
; Lab: <lab 2>
; Lab section:023
; TA: Colvin, Robert
;=================================================

.orig x3000


LD R1,DEC_0
LD R2,DEC_12
LD R3,DEC_6

LOOP
	ADD R1,R1,R2	;12 = 0+12  24 = 12 + 12  
	ADD R3,R3,#-1	;5 = 6+(-1) Repeat 6 times tp addomg 
	BRp LOOP
END_LOOP	;Final will be 6* 12 = 72

DEC_0 .FILL #0
DEC_12 .FILL #12
DEC_6 .FILL #6
