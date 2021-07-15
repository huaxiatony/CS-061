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

;--
; Instructions
;--
LD	R0,str_addr
LD	R1,SUB_GET_STRING
JSRR	R1
JSR	SUB_CHECK_P

HALT
;--
; Local Data 
;--
SUB_GET_STRING	.FILL x3200
str_addr	.FILL x4000

;----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R0): The address of where to start storing the string
; Postcondition: The subroutine has allowed the user to input a string,
; terminated by the [ENTER] key, and has stored it in an array
; that starts at (R0) and is NULL-terminated.
; Return Value: R5 The number of non-sentinel characters read from the user
;-----------------------------------------------------------------------------------------------------------------
.orig x3200

;--
; Subroutine Instructions
;--
ST	R0,BACKUP_R0_3200
ST	R7,BACKUP_R7_3200

LD	R1,BACKUP_R0_3200
AND	R5,R5,#0
LD	R2,ASCII_ENTER

LEA R0,MSG
PUTS

INPUT
  GETC
  OUT
  ADD	R3,R2,R0
  BRz END_INPUT
CHECK_UPPER
  LD	R4,UPPER_A
  ADD	R4,R4,R0
  BRn	INPUT
  LD	R4,LOWER_Z
  ADD	R4,R4,R0
  BRp	CHECK_LOWER
  BR	TO_LOWER
CHECK_LOWER
  LD	R4,UPPER_BOUND
  ADD	R4,R4,R0
  BRn	INPUT
  LD	R4,LOWER_BOUND
  ADD	R4,R4,R0
  BRp	INPUT
  STR	R0,R1,#0
  ADD	R1,R1,#1
  BR	INPUT
TO_LOWER
  LD	R4,TO_LOWER_BIT
  ADD	R0,R0,R4
  BR	CHECK_LOWER
END_INPUT
  ADD	R1,R1,#-1
  LD	R0,BACKUP_R0_3200
  LD	R7,BACKUP_R7_3200
  RET
;--
; Subroutine Data Block
;--
BACKUP_R0_3200		.BLKW #1
BACKUP_R7_3200		.BLKW #1
ASCII_ENTER		.FILL -xA
TO_LOWER_BIT		.FILL x20
UPPER_A			.FILL -x41
LOWER_Z			.FILL -x5A
UPPER_BOUND		.FILL -x61
LOWER_BOUND		.FILL -x7A
MSG			.STRINGZ   "Please enter your word: \n"
;--
; End of subroutine
;--

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R0): The address of a string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R0) is
; a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;------------------------------------------------------------------------------------------------------------------
.orig x3400
;--
; Subroutine Instructions
;--
SUB_CHECK_P
  ST  R0, BACKUP_R0_3400
  ST  R1, BACKUP_R1_3400
  ST  R7, BACKUP_R7_3400
CHECK_STRING                         
  LDR R3, R0, #0
  LDR R4, R1, #0
  NOT R5, R4
  ADD R5, R5, #1
  ADD R5, R5, R3
  BRnp NOT_PALINDROME
  ; check the position of string, if at middle then SR finished
  ; for even string
  NOT R5, R0
  ADD R5, R5, #1
  ADD R6, R5, R1
  ADD R6, R6, #-1
  BRz IS_PALINDROME
  ; for uneven string
  ADD R6, R5, R1
  ADD R6, R6, #-2
  BRz IS_PALINDROME
  ADD R1, R1, #-1
  ADD R0, R0, #1
  BR  CHECK_STRING
NOT_PALINDROME
  LEA R0, notMessage                         
  PUTS
  BR END_SUB_LOOP_3400
IS_PALINDROME
  LEA R0, isMessage
  PUTS
END_SUB_LOOP_3400                                                       
  LD  R0, BACKUP_R0_3400
  LD  R1, BACKUP_R1_3400
  LD  R7, BACKUP_R7_3400

  RET
;--
; Subroutine Data block
;--
BACKUP_R7_3400		.BLKW #1
BACKUP_R0_3400		.BLKW #1
BACKUP_R1_3400		.BLKW #1
isMessage		.STRINGZ "It's a palindrome.\n"
notMessage		.STRINGZ "It's not a palindrome.\n"
; -----------------------------------------------------------------------
;--
; End of program
;--
.end

