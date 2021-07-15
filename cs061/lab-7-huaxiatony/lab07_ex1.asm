;=================================================
; Name: Xia Hua 
; Email:  xhua006@ucr.edu
; GitHub username: huaxiatony
; 
; Lab: lab 7
; Lab section: 023
; TA: Colvin, Robert
;=================================================



.orig x3000
ADD R6,R6,#0
LD R4, Subroutine_1
JSRR R4

ADD R6,R6,#1
LD R4, Subroutine_2
JSRR R4

HALT
;========
;Data
;========
NEW_LINE	.FILL '\n'
Subroutine_1	.FILL x3200
Subroutine_2	.FILL x3400

;==========================
;Subroutine 1
;==========================
.orig x3200
;Store register to backup variables
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R4, BACKUP_R4_3200
ST R5, BACKUP_R5_3200
;ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200
;Hard code some value to R1
	LEA R0,welcome
	PUTS
;Load every register other than R1 
;LD R1,BACKUP_R1_x3200 --- Don't use this line 
LD R5,DEC_N_48
LD R3,NEWLINE_N

CHECK_SIGN
  GETC
  ADD R4,R0,R3				;CHECK ENTER
  BRz ERROR_MAG
  OUT
  
  LD R4,PASITIVE_SIGN			;CHECK +
  ADD R4,R0,R4
  BRz CHECK_AGAIN
  
  LD R4,NEGITIVE_SIGN			;CHECK -
  ADD R4,R0,R4
  BRz NEGITIVE_M
  BRnp ERROR_CHECK
  
NEGITIVE_M
  ADD R2,R2,#1
  
CHECK_AGAIN
  GETC
  ADD R4,R0,R3
  BRz NEWLINE
  OUT
  BRnp ERROR_CHECK
  
INPUT_LOOP
  GETC
  ADD R4,R0,R3
  BRz END_INPUT
  OUT

ERROR_CHECK
  ADD R4,R0,R5				;CHECK INPUT<0
  BRn ERROR_MAG
  ADD R4,R4,#-9				;CHECK INPUT>9
  BRp ERROR_MAG
  BRnz CONTINE				;NO ERROR
  
NEWLINE
  LD R0,ENDLINE
  OUT
  
ERROR_MAG
  ADD R4,R0,R3
  BRz NO_OUT
  LD R0,ENDLINE
  OUT
  
NO_OUT
  LD R0,error
  PUTS
  LD R0,welcome
  PUTS
  AND R6,R6,#0
  BRz CHECK_SIGN
  
CONTINE
  LD R1,DEC_9
  ADD R4,R6,#0
  MULTI
    ADD R6,R4,R6
    ADD R1,R1,#-1
    BRp MULTI
    
  ADD R0,R0,R5
  ADD R6,R6,R0
  BRnzp INPUT_LOOP

END_INPUT

ADD R2,R2,#0
BRz END_CONVERT

CONVERT
  NOT R6,R6
  ADD R6,R6,#1
END_CONVERT

LD R0,ENDLINE
OUT

LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R5, BACKUP_R5_3200
;LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200
RET
;Define backup register

;======
;Data
;======	
  BACKUP_R0_3200	.BLKW #1
  BACKUP_R1_3200	.BLKW #1
  BACKUP_R2_3200	.BLKW #1
  BACKUP_R3_3200	.BLKW #1
  BACKUP_R4_3200	.BLKW #1
  BACKUP_R5_3200	.BLKW #1
  ;BACKUP_R6_3200	.BLKW #1
  BACKUP_R7_3200	.BLKW #1
  
  welcome 		.stringz "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
  error			.stringz "ERROR INVALID INPUT\n"
  DEC_9			.FILL #9
  DEC_N_48		.FILL #-48
  ENDLINE		.FILL x0A
  PASITIVE_SIGN		.FILL #-43
  NEGITIVE_SIGN		.FILL #-45
  NEWLINE_N		.FILL #-10





;======================
;Subroutine 2
; R1 as the taking value
;======================
.orig x3400
;Store register to backup variable
ST R0, BACKUP_R0_3400
ST R1, BACKUP_R1_3400
ST R2, BACKUP_R2_3400
ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400
ST R5, BACKUP_R5_3400
;ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

; ADD R1,R1,#1
;Load every register other than R1

;print every value of R1 ---- Think about the algorithm
;Initialise the counter 

 LEA R1,DIGIT
  LD R5, N_10000
  STR R5,R1,#0
  ADD R1,R1,#1
  
  LD R5,N_1000
  STR R5,R1,#0
  ADD R1,R1,#1
  
  LD R5,N_100
  STR R5,R1,#0
  ADD R1,R1,#1
  
  LD R5,N_10
  STR R5,R1,#0
  ADD R1,R1,#1
  
  LD R5,N_1
  STR R5,R1,#0
  ADD R1,R1,#1

  
  ADD R6,R6,#0
  BRz OUT_ZERO
  BRp SIGN_P
  BRn SIGN_N
  
  OUT_ZERO
    LD R0,DEC_48_N
    OUT
    BRnzp END
    
  SIGN_P
    LD R0,PASI
    OUT
    BRnzp END_SIGN
    
  SIGN_N
    ADD R6,R6,#-1
    NOT R6,R6
    LD R0,NEGI
    OUT
    
  END_SIGN
  
  LD R1,DEC_5
  LEA R5,DIGIT
  AND R2,R2,#0
  
  PRINT_LOOP
    ADD R4,R6,#0
    AND R3,R3,#0
    LDR R0,R5,#0
    
    COUNT_TIMES
      ADD R3,R3,#1
      ADD R4,R0,R4
      BRzp COUNT_TIMES
      
    ADD R3,R3,#-1
    BRz OUTPUT
    LD R2,SIGN
    
  OUTPUT
    ADD R2,R2,#0
    BRz END_OUTPUT
    LD R0,DEC_48_N
    ADD R0,R0,R3
    OUT
    
  END_OUTPUT
  
  ADD R3,R3,#0
  BRz END_NUMBER
  NUMBER
    LDR R0,R5,#0
    ADD R6,R0,R6
    ADD R3,R3,#-1
    BRp NUMBER
  END_NUMBER

  ADD R5,R5,#1
  ADD R1,R1,#-1
  BRp PRINT_LOOP
  
END
;Load every register other than R1
LD R0, BACKUP_R0_3400
LD R1, BACKUP_R1_3400
LD R2, BACKUP_R2_3400
LD R3, BACKUP_R3_3400
LD R4, BACKUP_R4_3400
LD R5, BACKUP_R5_3400
;LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400
RET


;=========================
;Define backup register
;=========================
;Data
;=========================

BACKUP_R0_3400 .BLKW #1
BACKUP_R1_3400 .BLKW #1
BACKUP_R2_3400 .BLKW #1
BACKUP_R3_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
;BACKUP_R6_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1



PASI				.FILL #43
NEGI				.FILL #45

DEC_48				.FILL #48
DEC_48_N			.FILL #48

DEC_5				.FILL #5

DIGIT				.BLKW #5

N_10000				.FILL #-10000
N_1000				.FILL #-1000
N_100				.FILL #-100
N_10				.FILL #-10
N_1				.FILL #-1

DEC_M_10000 .FILL #-10000
DEC_P_10000 .FILL #10000

DEC_M_1000 .FILL #-1000
DEC_P_1000 .FILL #1000

DEC_M_100 .FILL #-100
DEC_P_100 .FILL #100

DEC_M_10 .FILL #-10
DEC_P_10 .FILL #10

DEC_M_1	.FILL #-1
DEC_P_1	.FILL #1

SIGN	.FILL #1

;=================
; END OF PROGRAM
;=================
.end

