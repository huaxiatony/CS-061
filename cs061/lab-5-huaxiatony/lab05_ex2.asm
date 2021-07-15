;=================================================
; Name: Xia Hua
; Email:  xhua006@ucr.edu
; GitHub username: huaxiatony
;
; Lab: lab 5
; Lab section: 023
; TA: Colvin, Robert
;=================================================
.orig x3000
LD R4, ARRAY_PTR
LD R5, ZERO
LD R6, COUNTER

PROCESS_LOOP
        ;take input R0
        STR R5, R4, #0
        ADD R5, R5, #1
        ADD R4, R4, #1
        ADD R6, R6, #-1
        BRp PROCESS_LOOP
;access the 7th value 
LD R4, ARRAY_PTR        ; R4 <-- x4000
;LD R5, ZERO		; Load R5 to 0
LD R6,COUNTER		; Load R6 to counter = #10
LD R3,DEC_48
;ADD R4, R4, #7          ; R4 <-- x4007
;LDR R2, R4, #0          ; R2 <-- m[x4007]
;Instead of previous two line you can use: LDR R2, R4, #7

PRINT_LOOP
	LDR R0, R4, #0	;Load memory value to R0, for first iteration R0 <-mx[4000]
	ADD R0, R0, R3	;Making a digit to character by adding #48 to it
	OUT		;Output the character
	ADD R4, R4, #1	;Increament the arraty pointer
	ADD R6, R6, #-1	;Decrement the loop counter
	BRp PRINT_LOOP	;If the loop counter is still positive do the task again
END_PRINT_LOOP
HALT


;Stored Data
ARRAY_PTR       .FILL x4000
ZERO            .FILL #0
COUNTER         .FILL #10
DEC_48		.FILL #48
.orig x4000
ARRAY_1 .BLKW   #10

