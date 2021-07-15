;=================================================
; Name: <Hua, Xia>
; Email: xhua006@ucr.edu
; Giuthub username: huaxiatony
; Lab: <lab 4>
; Lab section:023
; TA: Colvin, Robert
;=================================================

.orig x3000
LD R5, DATA_PTR
ADD R6, R5, #1

LDR R1,R5,#0
LDR R2,R6,#0

ADD R1,R1,#1
ADD R2,R2,#1

STR R1,R5,#0
STR R2,R6,#0
HALT

;----
;Data
;----
DATA_PTR .FILL x4000

.orig x4000
NEW_DEC_65 .FILL #65
NEW_HEX_41 .FILL x41
.end
