;=================================================
; Name: <Hua, Xia>
; Email: xhua006@ucr.edu
; Giuthub username: huaxiatony
; Lab: <lab 4>
; Lab section:023
; TA: Colvin, Robert
;=================================================
.orig x3000 ; programs begins here
;============
;Instructions 
;============
LD R5,ARRAY_PTR ;Set the pointer of array
;LD R6, DEC_10 ; Don't need anymore since the input could be less than 10, could be more than 10
LD R1,DEC_0 ;To count how many inputs are there

LEA R0,MSG
PUTS

DO_WHILE
	Trap x20 ; Take input 
	STR R0,R5,#0 ; Store R0 value in (R5+0) Address
	Trap x21
	ADD R5,R5,#1 ;Increament the pointer value
	ADD R1,R1,#1 ;For each input it will count it up
	ADD R0,R0,#-10 ;It will check wheather the input value is "Enter" or x0A or #10
	BRp DO_WHILE ;If the substraction of previous line is not 0 or the input is not "Enter" keep looping
END_DO_WHILE_LOOP_INPUT

LD R5,ARRAY_PTR ; Restore the pointer of array

DO_WHILE_OUTPUT
	LDR R0,R5,#0 ;Load value from (R5+0) to R0
	ADD R5,R5,#1 ;Increament the pointer value

	Trap x21;Output R0
	LD R0,END_LINE
	Trap x21
	ADD R1,R1,#-1 ;After each printing decreament the count of values
	BRp DO_WHILE_OUTPUT

END_DO_WHILE_LOOP_OUTPUT

HALT
;==========
;Local Data 
;==========
ARRAY_PTR .FILL x4000
;DEC_10 .FILL #10
END_LINE .FILL x0A
DEC_0 .FILL #10
MSG	.STRINGZ "Please enter a string.\n"
;.orig x4000
;ARRAY_1 .BLKW #10

