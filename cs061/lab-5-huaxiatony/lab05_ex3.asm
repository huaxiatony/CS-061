;=================================================
; Name: Xia Hua
; Email:  xhua006@ucr.edu
; GitHub username: huaxiatony
;
; Lab: lab 5
; Lab section: 023
; TA: Colvin, Robert
;================================================
.ORIG x3000

LD R1, DEC_10
LD R2, ARRAY_PTR
LD R3, DEC_1

LOOP
  STR R3, R2, #0

  ADD R2, R2, #1
  ADD R1, R1, #-1
  ADD R3, R3, R3
  BRp LOOP;
END_LOOP

LD R0, ARRAY_PTR
LDR R2, R0, #6

HALT

;DATA;

DEC_10		.FILL	#10
ARRAY_PTR	.FILL 	x4000
DEC_1		.FILL	#1

.ORIG x4000

ARRAY_1		.BLKW	#10
