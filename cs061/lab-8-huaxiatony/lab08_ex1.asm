;=================================================
; Name: 
; Email:  
; GitHub username: 
; 
; Lab: lab 8
; Lab section: 
; TA: 
;=================================================

.orig x3000

LD R1, STRING_PTR
LD R4, SUB_GET_STRING
JSRR R4
 
LEA R0,STRING_PTR
PUTS

HALT
;local data
STRING_PTR .FILL x4000
SUB_GET_STRING .FILL x3200


;============================================================
;Subroutine SUB_GET_STRING
;Argument: R1 ;STRING_STARTING_ADDRESS
;Return R1 and R5(R1 is starting address of the string and R5 is the length of the string)
;=========================================================
.orig x3200

ST	R3,BACKUP_R3_x3200
ST	R7,BACKUP_R7_x3200

Input_loop
  AND R5,R5,#0
  GETC
  OUT
  ADD R3,R0,#-10 ;checking if the user input Enter
  BRz End_Input_loop
  STR R0,R1,#0   
  ADD R1,R1,#1 ;Increament the pointer
  ADD R5,R5,#1 ;Increament the counter
  BR Input_loop
End_Input_loop
  AND R3,R3,#0 ;Initializing R3 with NULL #0
  STR R3,R1,#0 ;Storing the null pointer
;load necessary register
  LD R3, BACKUP_R3_x3200
  LD R7, BACKUP_R7_x3200
;========================
;store necessary register
;take input into string statring from the address R0 also count length R5
;Stop taking input when input is "Enter" Don't Store the "Enter" into string
;load necessary register
;========================
RET
;local data
;define necessary variables
BACKUP_R3_x3200 .BLKW #1
BACKUP_R7_x3200 .BLKW #1

;end program
.end

