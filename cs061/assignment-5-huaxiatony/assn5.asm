;=================================================
; Name: Xia Hua 
; Email: xhua006@ucr.edu
; GitHub username: huaxiatony
; 
; Assignment name: Assignment 5
; Lab section: 023
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
GO_SELECTION_MENU
    LD R6, MENU	
    JSRR R6
;If is zero go print the selected section.
ADD R0, R1, #-1
BRz ONE
ADD R0, R1, #-2
BRz TWO
ADD R0, R1, #-3
BRz THREE
ADD R0, R1, #-4
BRz FOUR
ADD R0, R1, #-5
BRz FIVE
ADD R0, R1, #-6
BRz SIX
ADD R0, R1, #-7
BRz SEVEN

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
ONE 	
	LD R6, ALL_MACHINES_BUSY
	JSRR R6
	
	LEA R0, NEWLINE
	PUTS
	
	ADD R2, R2, #0
	BRnp BUSY_MENU
	LEA R0, ALLNOTBUSY
	PUTS
	
	BR GO_SELECTION_MENU
		BUSY_MENU	
			LEA R0, ALLBUSY
			PUTS
			BR GO_SELECTION_MENU
TWO 	
	LD R6, ALL_MACHINES_FREE
	JSRR R6
	LEA R0, NEWLINE
	PUTS
	
	ADD R2, R2, #0
	BRnp MENU_FREE
	LEA R0, NOTFREE
	PUTS
	
	BR GO_SELECTION_MENU
	MENU_FREE	
		LEA R0, FREE
		PUTS
		BR GO_SELECTION_MENU
		
THREE 	
	LD R6, NUM_BUSY_MACHINES
	JSRR R6
	LEA R0, NEWLINE
	PUTS
	
	LEA R0, BUSYMACHINE1
	PUTS
	
	LD R6, PRINT_NUMBER
	JSRR R6
	LEA R0, BUSYMACHINE2
	PUTS
	
	BR GO_SELECTION_MENU

FOUR 
	LD R6, NUM_FREE_MACHINES
	JSRR R6
	LEA R0, NEWLINE
	PUTS
	
	LEA R0, FREEMACHINE1
	PUTS
	
	LD R6, PRINT_NUMBER
	JSRR R6
	LEA R0, FREEMACHINE2
	PUTS
	
	BR GO_SELECTION_MENU

FIVE 
	LD R6, GET_INPUT
	JSRR R6
	AND R2, R2, #0
	ADD R2, R5, R2
	LEA R0, STATUS1
	PUTS
	
	LD R6, PRINT_NUMBER
	JSRR R6
	LD R6, MACHINE_STATUS
	JSRR R6
	ADD R2, R2, #0
	BRz BUSY_MENU_STATUS
	LEA R0, STATUS3
	PUTS
	
	BR GO_SELECTION_MENU
	BUSY_MENU_STATUS 
	LEA R0, STATUS2
	PUTS
	BR GO_SELECTION_MENU

SIX	
	LD R6, FIRST_FREE
	JSRR R6
	LEA R0, NEWLINE
	PUTS
	
	ADD R2, R2, #0
	BRn FILL_MENU
	LEA R0, FIRSTFREE1
	PUTS
	
	LD R6, PRINT_NUMBER
	JSRR R6
	LEA R0, NEWLINE
	PUTS
	
	BR GO_SELECTION_MENU
	FILL_MENU	
	LEA R0, FIRSTFREE2
	PUTS

	BR GO_SELECTION_MENU
 
SEVEN
	LEA R0, NEWLINE
	PUTS
	LEA R0, Goodbye
	PUTS
HALT
;---------------	
;Data
;---------------
;Add address for subroutines
MENU			.FILL x3200
ALL_MACHINES_BUSY	.FILL x3400
ALL_MACHINES_FREE	.FILL x3600
NUM_BUSY_MACHINES	.FILL x3800
NUM_FREE_MACHINES	.FILL x4000
MACHINE_STATUS		.FILL x4200
FIRST_FREE		.FILL x4400
GET_INPUT		.FILL x4600
PRINT_NUMBER		.FILL x4800
;Other data 
NEWLINE		.STRINGZ "\n"
;Strings for options
Goodbye         .STRINGZ "Goodbye!\n"
ALLNOTBUSY      .STRINGZ "Not all machines are busy\n"
ALLBUSY         .STRINGZ "All machines are busy\n"
FREE            .STRINGZ "All machines are free\n"
NOTFREE		      .STRINGZ "Not all machines are free\n"
BUSYMACHINE1    .STRINGZ "There are "
BUSYMACHINE2    .STRINGZ " busy machines\n"
FREEMACHINE1    .STRINGZ "There are "
FREEMACHINE2    .STRINGZ " free machines\n"
STATUS1         .STRINGZ "Machine "
STATUS2		      .STRINGZ " is busy\n"
STATUS3		      .STRINGZ " is free\n"
FIRSTFREE1      .STRINGZ "The first available machine is number "
FIRSTFREE2      .STRINGZ "No machines are free\n"
;NEWLINE         .STRINGZ "\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3200
;HINT back up 
ST R7, BACKUP_R7_x3200

INPUT_LOOP_x3200 
LD R0, Menu_string_addr
PUTS
GETC
OUT
LD R1, DEC_ZERO_x3200
ADD R1, R1, R0
BRnz ERROR_MENU_INPUT
LD R1, DEC_SEVEN_x3200
ADD R1, R1, R0
BRp ERROR_MENU_INPUT

LD R1, DEC_ZERO_x3200	
ADD R1, R1, R0
;HINT Restore
LD R7, BACKUP_R7_x3200
RET

ERROR_MENU_INPUT 
LEA R0, NEWLINE_x3200
PUTS
LEA R0, Error_msg_1
PUTS
BR INPUT_LOOP_x3200
;--------------------------------
;Data for subroutine MENU
;--------------------------------
BACKUP_R7_x3200		.BLKW		#1
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6000
NEWLINE_x3200		.STRINGZ "\n"
DEC_ZERO_x3200		.FILL #-48
DEC_SEVEN_x3200		.FILL #-55

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.orig x3400
;HINT back up 
ST R7,BACKUP_R7_x3400

AND R2,R2,#0
LDI R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
ADD R0,R0,#0
BRnp NOT_BUSY
ADD R2,R2,#1

NOT_BUSY
;HINT Restore
LD R7, BACKUP_R7_x3400
RET

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BACKUP_R7_x3400	.BLKW	#1
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xA400

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.ORIG x3600
;HINT back up 
ST R7, BACKUP_R7_x3600
AND R2, R2, #0

LD R1, BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR R0, R1, #0

ADD R1, R0, #1
BRz MACHINE_FREE
BR CHECKING_ALL_MACHINES_FREE
MACHINE_FREE
ADD R2, R2, #1

CHECKING_ALL_MACHINES_FREE
;HINT Restore
LD R7, BACKUP_R7_x3600
RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BACKUP_R7_x3600	.BLKW	#1
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xA400

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------

.orig x3800
;HINT back up 
ST R7, BACKUP_R7_x3800


;--------------------------------------------
;USING R2 to reutrn the number of busy machine
;---------------------------------------------

LDI R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES
AND R2, R2, #0
LD R3,LOOP_COUNT
BUSY_MACHINES	
ADD R1 ,R1,#0
BRn NOT_BUSY_MACHINES
ADD R2, R2, #1
NOT_BUSY_MACHINES	
ADD R1, R1, R1
ADD R3, R3, #-1
BRp BUSY_MACHINES

;HINT Restore
LD R7, BACKUP_R7_x3800
RET


;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BACKUP_R7_x3800			.BLKW #1
LOOP_COUNT			.FILL #16
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xA400

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.orig x4000
;HINT back up 
ST R7, BACKUP_R7_x4000
LD R0, BUSYNESS_ADDR_NUM_FREE_MACHINES
LDR R1, R0, #0
AND R2, R2, 0
LD R3, LOOP_COUNT_x4000
FREE_MACHINES	
ADD R1, R1, #0
BRzp NOT_FREE_MACHINE
ADD R2, R2, #1
NOT_FREE_MACHINE
ADD R1, R1, R1
ADD R3, R3,#-1
BRp FREE_MACHINES

;HINT Restore
LD R7, BACKUP_R7_x4000
RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xA400
BACKUP_R7_x4000		.BLKW #1
LOOP_COUNT_x4000	.FILL #16


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------

.orig x4200
;HINT back up 
ST R7, BACKUP_R7_x4200
AND R3, R3, #0
AND R2, R2, #0
LDI R0, BUSYNESS_ADDR_MACHINE_STATUS	
ADD R3, R3, #1

;-------------------------------------------------------------------
;By using the mask method to use the code for getting machine status.
;-------------------------------------------------------------------
GET_STATUS	
ADD R3, R3, R3
ADD R1, R1, #-1
BRp GET_STATUS

AND R3, R3, R0
BRz MACHINE_BUSY
ADD R2, R2, #1

MACHINE_BUSY
;HINT Restore
LD R7, BACKUP_R7_x4200
RET


;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xA400
BACKUP_R7_x4200		.BLKW #1


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------

.orig x4400
;HINT back up 
ST R7, BACKUP_R7_x4400
LDI R0, BUSYNESS_ADDR_FIRST_FREE
AND R1, R1, #0
AND R2, R2, #0
ADD R1, R1, #1
LD R3, FIRST_FREE_COUNT

COUNER_LOOP	
AND R1, R1, R0			
BRp EXIT_FIRST_FREE
ADD R1, R1, R1
ADD R2, R2, R2
ADD R3, R3, #-1
BRp COUNER_LOOP
AND R2, R2, #0
ADD R2, R2, #-1
EXIT_FIRST_FREE

;HINT Restore
LD R7, BACKUP_R7_x4400
RET

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xA400
BACKUP_R7_x4400		.BLKW #1
FIRST_FREE_COUNT	.FILL #16

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x4600
ST R7, BACKUP_R7_x4600
  LEA R0, NEWLINE_x4600
  PUTS
INPUT_WITHOUT_LINE
  LEA R0, prompt 
  PUTS
INPUT_LOOP
  AND R0, R0, #0
  AND R1, R1, #0
  AND R2, R2, #0
  AND R3, R3, #0
  AND R4, R4, #0
  AND R5, R5, #0
  AND R6, R6, #0
  ST R0, FLAG
  LD R3, COUNTER
CHECKING_INPUT
  GETC 
  OUT
  ADD R3, R3, #-1
  LD R2, DEC_ZERO
  ADD R2, R2, R0
  BRn GO_ERROR
  LD R2, DEC_NINE
  ADD R2, R2, R0
  BRp GO_ERROR
  ;-----------------------------
  ;Copy from Lab 07 Exercise 01
  ;-----------------------------
  ADD R4, R5, x0
  ADD R4, R4, R4
  ADD R5, R5, R5
  ADD R5, R5, R5
  ADD R5, R5, R5
  ADD R5, R4, R5
  AND R4, R4, x0
  LD R6, DEC_ZERO
  ADD R0, R0, R6
  ADD R5, R5, R0 
  ADD R3, R3, #0	
  BRp CHECKING_INPUT
  LD R0, NEWLINE_x4600	
  OUT
  BR ADDING_TWO_COMPLIMENT
;--------------- 
;Negate Number  
;---------------
SETTING_FLAG
    ADD R6, R3, #-2 	
    BRn PRINT_NEWLINE

    LD R2, FLAG
    ADD R2, R2, #-1
    ST R2, FLAG
BR CHECKING_INPUT

ADDING_TWO_COMPLIMENT
  LD R2, FLAG
  ADD R2, R2, x0
BRzp END_PROGRAM
  NOT R5, R5
  ADD R5, R5, #1
BR END_PROGRAM

;----------------------------
;ERROR HANDLING
;----------------------------
GO_ERROR
  CHECK_IF_MINUS
    LD R2, DEC_MINUS
    ADD R2, R2, R0
  BRz SETTING_FLAG
  
  CHECK_IF_PLUS
    LD R2, DEC_PLUS
    ADD R2, R2, R0
BRz LOOP_LESS_THAN_FIVE

CHECK_IF_ENTER
    ADD R6, R3, #-2 	
    BRz SELECTION_INPUT_ERROR
    LD R2, HEX_ENTER
    ADD R2, R2, R0
BRz ADDING_TWO_COMPLIMENT
  
LOOP_LESS_THAN_FIVE
    ADD R6, R3, #-2 	
    BRn PRINT_NEWLINE
    BR CHECKING_INPUT
  
PRINT_NEWLINE
LEA R0, NEWLINE_x4600
PUTS
SELECTION_INPUT_ERROR
LEA R0, Error_msg_2  
PUTS
BR INPUT_WITHOUT_LINE

END_PROGRAM
ADD R5, R5, #0
BRn SELECTION_INPUT_ERROR
LD R0, MAX
ADD R0, R0, R5
BRp SELECTION_INPUT_ERROR

AND R1, R1, #0
ADD R1, R1, R5

;Hint Load R7
LD R7, BACKUP_R7_x4600

RET

;
;Data Set One
;
BACKUP_R7_x4600	.BLKW #1
;------------------------
DEC_ZERO	.FILL	#-48
DEC_NINE	.FILL	#-57
DEC_MINUS	.FILL	#-45
DEC_PLUS	.FILL	#-43
HEX_ENTER	.FILL	-#10
FLAG		.FILL 	x0

NEWLINE_x4600	.STRINGZ "\n"

COUNTER		.FILL 	#3
MAX		.FILL -#15


;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x4800
ST R7, BACKUP_R7_x4800
AND R4, R4, #0
AND R3, R3, #0
AND R5, R5, #0
ADD R5, R2, R5
ADD R5, R5, #0
BRz SKIP_FOURTH
;------------------------------------
;By using the same method we used on Lab07_exercise01. 
;We can conclude to subtract 10000, 1000, 100,10,1 to get the value for R6
;---------------------------------------
LD R0, DEC_N_TEN_THOUSAND
MINUS_TEN_THOUSAND
  ADD R5, R5, R0
BRn MINUS_ONE_THOUSAND
  ADD R4, R4, #1
BR MINUS_TEN_THOUSAND
;-------------------------------------
MINUS_ONE_THOUSAND
LD R0, DEC_TEN_THOUSAND
ADD R5, R5, R0
ADD R4, R4, #0
BRz SKIP_FIRST
;-------------------------------------
LD R0, DEC_ZERO_x4800
ADD  R0, R4 ,R0
OUT
ADD R3, R3, #1	
AND R4, R4, #0	
SKIP_FIRST
LD R0, DEC_N_ONE_THOUSAND	
ADD R5, R5, R0		
BRn MINUS_ONE_HUNDRED
ADD R4, R4 , #1		
BR SKIP_FIRST	
;-------------------------------------
MINUS_ONE_HUNDRED
LD R0, DEC_ONE_THOUSAND
ADD R5, R5, R0
ADD R3, R3, #0
BRp LOOP_TWO
ADD R4, R4, #0
BRz SKIP_SECOND
;-------------------------------------
LOOP_TWO
AND R3, R3, #0
LD R0, DEC_ZERO_x4800
ADD  R0, R4 ,R0
OUT
ADD R3, R3, #1
AND R4, R4, #0
SKIP_SECOND
LD R0, DEC_N_ONE_HUNDRED
ADD R5, R5, R0
BRn MINUS_TEN
ADD R4, R4, #1
BR SKIP_SECOND
;-------------------------------------
MINUS_TEN
LD R0, DEC_ONE_HUNDRED
ADD R5, R5, R0
ADD R3, R3, #0
BRp LOOP_THREE
ADD R4, R4, #0
BRz SKIP_THIRD
;-------------------------------------
LOOP_THREE
AND R3, R3, #0
LD R0, DEC_ZERO_x4800
ADD  R0, R4 ,R0
OUT
;-------------------------------------
ADD R3, R3, #1
AND R4, R4, #0
SKIP_THIRD
LD R0, DEC_N_TEN
ADD R5, R5, R0
BRn FINAL_OUTPUT
ADD R4, R4, #1
BR SKIP_THIRD
;-------------------------------------
FINAL_OUTPUT
LD R0, DEC_TEN
ADD R5, R5, R0
ADD R3, R3, #0
BRp LOOP_FOUR
ADD R4, R4, #0
BRz SKIP_FOURTH
;-------------------------------------
LOOP_FOUR
LD R0, DEC_ZERO_x4800
ADD R0, R0, R4
OUT
SKIP_FOURTH
LD R0, DEC_ZERO_x4800
ADD R0, R0, R5
OUT
LD R7, BACKUP_R7_x4800
RET


;--------------------------------
;Data for subroutine print number
;--------------------------------
BACKUP_R7_x4800		.BLKW #1
DEC_ZERO_x4800		.FILL #48

DEC_TEN_THOUSAND	.FILL #10000
DEC_N_TEN_THOUSAND	.FILL #-10000

DEC_ONE_THOUSAND	.FILL #1000
DEC_N_ONE_THOUSAND	.FILL #-1000

DEC_ONE_HUNDRED		.FILL #100
DEC_N_ONE_HUNDRED	.FILL #-100

DEC_TEN			.FILL #10
DEC_N_TEN		.FILL #-10


.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xA400			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END
