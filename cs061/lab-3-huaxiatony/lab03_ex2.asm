;=================================================
; Name: <Hua, Xia>
; Email: xhua006@ucr.edu
; Giuthub username: huaxiatony
; Lab: <lab 3>
; Lab section:023
; TA: Colvin, Robert
;=================================================
.orig x3000

LDI R3, DEC_65_PTR
LDI R4, HEX_41_PTR

ADD R3,R3,#1
ADD R4,R4,#1

STI R3,DEC_65_PTR
STI R4,HEX_41_PTR

HALT

DEC_65_PTR	.FILL x4000
HEX_41_PTR	.FILL x4001

.orig x4000
DEC_65	.FILL #65
HEX_41	.FILL x41

.END



