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
;------------------
;Instruction
;------------------
GETC
ADD R1,R0,#0
OUT
LD R2,SUB_COUNT_3200
JSRR R2

HALT
;------------------
;DATA
;------------------
SUB_COUNT_3200			.FILL x3200

;============================
;x3200
;============================

.orig x3200
ST R7,BACKUP_R7_3200
ST R4,BACKUP_R4_3200
ST R1,BACKUP_R1_3200
ST R0,BACKUP_R0_3200
   
AND R3,R3,#0
LD R4,DEC_16

COUNT
ADD R1,R1,#0
BRzp LEFT
  
ADD R3,R3,#1
  
LEFT
ADD R1,R1,R1
ADD R4,R4,#-1
BRp COUNT
   
LEA R0,PRINT
PUTS
   
LD R4,DEC_48
ADD R0,R3,R4
OUT

LD R7,BACKUP_R7_3200
LD R4,BACKUP_R4_3200
LD R1,BACKUP_R1_3200
LD R0,BACKUP_R0_3200
  
RET
  
BACKUP_R7_3200			.BLKW #1
BACKUP_R4_3200			.BLKW #1
BACKUP_R1_3200			.BLKW #1
BACKUP_R0_3200			.BLKW #1
DEC_16				.FILL #16
DEC_48				.FILL #48
PRINT				.STRINGZ "'s ASCII code have the number of 1 is : "

.end
