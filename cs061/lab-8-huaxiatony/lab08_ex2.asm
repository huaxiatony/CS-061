;=================================================
; Name: 
; Email:  
; GitHub username: 
; 
; Lab: lab 8
; Lab section: 
; TA: 
; 
;=================================================

.orig x3000

LD R1, STRING_PTR
LD R4, SUB_GET_STRING
JSRR R4
LEA R0,STRING_PTR
PUTS

LD R1, STRING_PTR
LD R3, SUB_IS_A_PALINDROME
JSRR R3
HALT

;local data
STRING_PTR .FILL x4000
SUB_GET_STRING .FILL x3200
SUB_IS_A_PALINDROME .FILL x3400
;============================================================
;Subroutine SUB_GET_STRING
;Argument: R1 ;STRING_STARTING_ADDRESS
;Return R1 and R5(R1 is starting address of the string and R5 is the length of the string)
;=========================================================
.orig x3200

ST	R1,BACKUP_R1_x3200
;--------------------------------
ST	R7,BACKUP_R7_x3200

Input_loop
  AND R5,R5,#0
  GETC
  OUT
  ADD R1,R0,#-10 ;checking if the user input Enter
  BRz End_Input_loop
  STR R0,R3,#0   
  ADD R3,R3,#1 ;Increament the pointer
  ADD R5,R5,#1 ;Increament the counter
  BR Input_loop
End_Input_loop
  AND R1,R1,#0 ;Initializing R3 with NULL #0
  STR R1,R3,#0 ;Storing the null pointer
;load necessary register
;Restore register
  LD R1, BACKUP_R1_x3200
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
BACKUP_R1_x3200 .BLKW #1
BACKUP_R7_x3200 .BLKW #1

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
;------------------------------------------------------------------------------------------------------------------
.orig x3400
;=========================
;INSTRUCTIONS
;=========================
ST	R0,BACKUP_R0_x3400
ST	R1,BACKUP_R1_x3400
ST	R2,BACKUP_R2_x3400
ST	R3,BACKUP_R3_x3400
ST	R4,BACKUP_R4_x3400
ST	R5,BACKUP_R4_x3400
ST	R6,BACKUP_R4_x3400
;---------------------------------
ST	R7,BACKUP_R7_x3400

LD R3,STRING_PTR_x3400

ADD R4,R4,#0
ADD R4,R3,R5
ADD R4,R4,#-1

checking_palindrome_loop
  ADD R6,R5,#-1
  BRnz checking_palindrome_loop_done
  
  LDR R1,R3,#0
  LDR R2,R4,#0
  
  NOT R2,R2
  ADD R2,R2,#1
  
  ADD R3,R3,R2
  BRnp not_equal
equal
  ADD R5,R5,#-2
  BR checking_palindrome_loop
not_equal
  LEA R0,not_palindrome_msg
  PUTS
  BR done_checking
checking_palindrome_loop_done
  all_characters_equal
    LEA R0, palindrome_msg
    PUTS
done_checking	

LD R0, BACKUP_R0_x3400		; Restore R0
LD R1, BACKUP_R1_x3400		; Restore R1
LD R2, BACKUP_R2_x3400		; Restore R2
LD R3, BACKUP_R3_x3400		; Restore R3
LD R5, BACKUP_R5_x3400		; Restore R5
LD R6, BACKUP_R6_x3400		; Restore R6
LD R7, BACKUP_R7_x3400		; Restore R7
  RET
;--
; Subroutine Data 
;--
BACKUP_R7_x3400		.BLKW #1
;--------------------------------------
BACKUP_R0_x3400		.BLKW #1
BACKUP_R1_x3400		.BLKW #1
BACKUP_R2_x3400		.BLKW #1
BACKUP_R3_x3400		.BLKW #1
BACKUP_R4_x3400		.BLKW #1
BACKUP_R5_x3400		.BLKW #1
BACKUP_R6_x3400		.BLKW #1

STRING_PTR_x3400	.FILL x4000

palindrome_msg		.STRINGZ "It's a palindrome.\n"
not_palindrome_msg	.STRINGZ "It's not a palindrome.\n"
; -----------------------------------------------------------------------
; End of program
;------------------------------------------------------------------------


.end

