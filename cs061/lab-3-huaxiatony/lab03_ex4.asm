;=================================================
; Name: <Hua, Xia>
; Email: xhua006@ucr.edu
; Giuthub username: huaxiatony
; Lab: <lab 3>
; Lab section:023
; TA: Colvin, Robert
;=================================================
.orig x3000

LDI R0,ADDR_1
LDI R1,ADDR_2

DO_WHILE_LOOP
	OUT
	ADD R0,R0,#1
	ADD R1,R1,#-1
	BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

HALT

ADDR_1	.FILL	x4000
ADDR_2	.FILL	x4001

.orig x4000
HEX_61	.FILL	x61
HEX_1A	.FILL	x1A
.end








