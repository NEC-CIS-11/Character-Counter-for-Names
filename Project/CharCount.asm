; Character Counter for Names Program
; Create an LC-3 program that displays the frequency of characters of user full name.
; Input: User is prompt to input his or her full name.
; Output: Numerical value the represent the frequency of a character in the user fullname.
;
; The program must fulfill the following criteria:
; 1. Contain appropriate addresses: origination, fill, array, input and output. (20 points)
;   Task is completele this program uses .ORIG X3000 , BLKW 26 ARRAY, GETC AND PUTS
; 2. Display counted values in console. (20 points)
;	Task is complete the program dispalys the frequency of each letter in a string but does not distinguish between uppercase and lowercase
;	so a string of mixed characters can be entered but the case of the letter does not make it unique. 
;	EXAMPLE: 'None' would have a frequency-> n=2, o=1, e=1 and the rest of the letters in the alphabet would have a frequency of 0.
; 3. Use appropriate labels and comments. (20 points)
;	Task complete, there are comments and labels througout. Here are some examples you will find
;	- PRMT, PROMT, OFFSET_97, OFFSET_65,  OFFSET_UPPER, OFFSET_CNVRT, TOT_LTRS. THERE ARE MORE IN PROGRAM PLEASE EXAMINE BELOW!
;
; 4. Contain appropriate instructions for arithmetic, data movement and conditional operations. (40 points)
; 	TASK COMPLETE Please see program below. Too many examples to list here. 
; 5. Comprise of 2 or more subroutines and implement subroutine calls. (20 points)
;	Task complete. There are 2 subroutines that are implemented and called. We used JSR too.
; 	- CHECK_LOWER and CHECK_UPPER
; 6. Use branching for control: conditional and iterative. (30 points) 
;	Task complete please refer to program below for all instances of branching. We used BR, BRp, BRz, BRnzp, BRzp in conditional and iterative branching in the program.
;
; 7. Manage overflow and storage allocation. (20 points)
;	Note: we did use storage allocation but did not sure about overflow. This would have been applicable to the STACK but I don't think this was implemented
; 8. Manage stack: include PUSH-POP operation on stack. (20 points)
;	STACK IS IMPLEMENTED WITH PUSH AND POP FUNCTIONALITIES.
;	
;	NOTE: OUR PROGRAM MET THE PROJECT REQUIRMENTS WITHOUT A STACK SO WE TRIED IMPLMENTING A STACK TO CALCULATE THE STRING LENGTH. UNFORTUNETLY THE LENGTH IS NOT
; 	ALWAYS CALCULATED CORRECTLY. THERE IS A BUG AND THE PROGRAM WILL ONLY CALCULATE THE LENGTH UP TO A CERTAIN THRESHOLD.
;
; 9. Include save-restore operations. (30 points)
;	TASK COMPLETE, PLEASE REFER TO PROGRAM BELOW
; 10. Include pointer (20 points)
;	IMPLEMENTED IN STACK
; 11. Implement ASCII conversion operations (30 points)
;	TASK COMPLETE. MANY EXAMPLES IN THE PROGRAM BELOW. BASIS OF PROGRAM BECAUES WE NEED TO CONVERT FORM CHARS TO ASCII AND VICE VERSA FOR PROGRAM TO WORK.
;
; 12. Use appropriate system call directives. (10 point)
; 	TASK COMPLETE SEE PROGRAM BELOW.
;
; 13. Testing (20 points): Test the program using the team names.
;	TASK COMPLETE SEE ATTACHMENTS IN CANVAS FOR THIS. 
;	
;	NOTE TO USER: THE CORRECT CHARACTER FREQUENCY WILL BE CALCULATED AND DISPLAYED BUT THE CORRECT STRING LENGHT MIGHT NOT BE.

.ORIG x3000  


STACK	.BLKW 26  ; 26 words of memory for use as the program's stack


                  ; Display prompts 
LEA R0, PRMT      ; LEA PRMT -> R0
PUTS              ; Output R0 : PRMT
LEA R0, PROMPT    ; LEA PROMPT -> R0
PUTS              ; Output R0 : PROMPT 

LEA R2, OFFSET_97 ; LEA is used to load the ADDRESS of OFFSET_97 to R2
LDR R2, R2, #0    ; Load what is IN the address of R2 into R2 so that R2 now has -97
LEA R4, ARRAY     ; LEA the beginning address of the array -> R4
AND R3, R3, #0    ; Clear R3 - character counter
AND R7, R7, #0    ; Clear R7 - lowercase flag
AND R6, R6, #0    ; Clear R6 - uppercase flag

GET_INPUT
GETC              ; Same as TRAP x20: read single char
OUT               ; Outupt char on console 
ADD R5, R0, #-10  ; Add -10: new-line is 10 in ASCII which is end of string
BRz RES_OUT       ; Zero would mean that the enter key was pressed, if so branch to RES_OUT

                  ; Check if character is uppercase
JSR CHECK_UPPER   ; Jump to subroutine to check if uppercase
BRnzp PROCESS_CHAR  

PROCESS_CHAR
ADD R0, R0, R2    ; -97 gets us the ASCII value we need -> R0 = R0 + (-97)
BRn GET_INPUT     ; If result is negative, read the next char
BRzp LOOP4IN   	  ; If not then read GET_INPUT

LOOP4IN
ADD R4, R4, R0    ; Move along index in the array
LDR R1, R4, #0    ; LDR what is in the index of the array into R1 
ADD R1, R1, #1    ; Increase the counter used for the letter in index of arrray
STR R1, R4, #0    ; Now put new increased value in the array again 
LEA R4, ARRAY     ; Reset R4 to point to the start of the ARRAY
BR GET_INPUT      ; branch to GET_INPUT

RES_OUT		 	 ; Print the character frequencies below
LEA R3, TOT_LTRS  	 ; Loading TOT_LTRS address into R3
LDR R3, R3, #0    	 ; LDR so we can load what is in the address of R3 back to R3 so it contains 26
AND R0, R0, #0    	 ; And to make register -> 0
LEA R6, OFFSET_LOWER     ; LEA address of OFFSET_LOWER into R6
LDR R6, R6, #0    	 ; LDR what OFFSET_LOWER contains into R6
ADD R0, R6, #0    	 ; Add to R0 : Console out letter 

LEA R4, ARRAY     	; This will point to beginning addresss of array 
LEA R2, OFFSET_NUM 	; LEA so the address of OFFSET_NUM can be put into R2
LDR R2, R2, #0    	; LDR so that what is in R2 can be put back into R2 with offset 48

LOOP4OUT
OUT               ; Console out char 

LD R1, EQ         ; LD equal sign into R1
ADD R0, R1, #0    ; Copy equal sign to reg
OUT               ; Console out the equal sign

LDR R0, R4, #0    ; LDR what is in index R0 of the array
ADD R4, R4, #1    ; Increase the index 
ADD R0, R0, R2    ; ADD for ASCII conversion 
OUT               ; Console out frequency of chars 

LD R1, TAB        ; LD the address of tab to R1 
ADD R0, R1, #0    ; Need to copy tab so it can be used 
OUT               ; Print tab space in console

ADD R6, R6, #1    ; Continue onto next ASCII value
ADD R0, R6, #0    ; ADD R6 to R0 be able to print character at loop start
ADD R3, R3, #-1   ; Decrement loop 
BRp LOOP4OUT      ; Only pos loop
	  
LEA R0, LEN
PUTS

		  ; Stack
LEA R6, STACK

LEA R4, ARRAY	  ; Reset index of array
LEA R3, TOT_LTRS  ; Loading TOT_LTRS address into R3
LDR R3, R3, #0	  ; LDR so we can load what is in the address of R3 back to R3 so it contains 26
AND R0, R0, #0	  ; Clear R0

PUSH_LOOP
LDR R1, R4, #0 	  ; Load the value at the current index of ARRAY into R1

ADD R6, R6, #-1	  ; Decrement R6 to push
    
STR R1, R6, #0 	  ; Store R1 to the stack
    
ADD R4, R4, #1 	  ; Move to the next index
    
ADD R3, R3, #-1	  ; Decrement the counter
    
BRp PUSH_LOOP  	  ; Loop back if there are more characters to process

LEA R3, TOT_LTRS
LDR R3, R3, #0

SUM_LENGTHS
    
LDR R1, R6, #0 	  ; Pop the top value from the stack into R1
    
ADD R0, R0, R1 	  ; Add the value in R1 to R0
    
ADD R6, R6, #1 	  ; Move stack pointer back down (pop operation)
    
ADD R3, R3, #-1   
BRp SUM_LENGTHS   ; Loop until R6 is back at initial position

ADD R0, R0, R2
OUT


; Integer to string converter fix needed so commented out
;CONVERT_LOOP    
;AND R0, R0, #0       ; Clear R0
    
;ADD R0, R1, #0       ; Copy R1 to R0
    
;ADD R0, R0, #48      ; Convert the digit to ASCII
    
;STR R0, R2, #0       ; Store the ASCII character in buffer
    
;ADD R2, R2, #-1      ; Move buffer pointer backwards
    
; R1, R1, #10         ; Divide R1 by 10
    
;BRp CONVERT_LOOP    ; Loop if there are more digits


; Now point R2 to the first digit in the buffer
ADD R2, R2, #1      
; Adjust R2 to point to first digit

 
HALT
      
		  ; Subroutine to check for uppercase characters in string 

CHECK_UPPER
LEA R5, OFFSET_65 	; Load OFFSET_65 address into R5
LDR R5, R5, #0    	; Load what is in address OFFSET_65 into R5 : -65
ADD R5, R0, R5   	; Subtract 65: A
BRn CHECK_LOWER 	; If negative, not uppercase
LEA R6, OFFSET_UPPER    ; Load  OFFSET_UPPER address into R6
LDR R6, R6, #0    	; Load what is in address of OFFSET_UPPER into R6: -26
ADD R5, R5, R6    	; Subtract 26
BRp CHECK_LOWER 	; If positive then not uppercase
ADD R6, R6, #1    	; Set R6 to 1 if uppercase
LEA R5, OFFSET_CNVRT    ; Load OFFSET_CNVRT address into R5
LDR R5, R5, #0    	; Load what is in OFFSET_CNVRT address into R5: 32
ADD R0, R0, R5    	; Convert uppercase to lowercase by adding 32
RET

		  ; Subroutine to check for lowercase characters in string 
CHECK_LOWER
LEA R5, OFFSET_97	; Load OFFSET_97 address into R5
LDR R5, R5, #0 	  	; Load what is in address of OFFSET_97 into R5: -97
ADD R5, R0, R5 	 	; Subtract 97: a
BRn GET_INPUT     	; If negative, not lowercase
LEA R6, OFFSET_UPPER 	; Load OFFSET_UPPER address into R6
LDR R6, R6, #0 		; Load what is in address of OFFSET_UPPER into R6: -26
ADD R5, R5, R6 		; Subtract 26
BRp GET_INPUT      	; If positive, not lowercase
ADD R7, R7, #1 		; Set R7 to 1 indicating lowercase
RET



PRMT    .STRINGZ "String character counter program\n"
PROMPT  .STRINGZ "\nEnter a string: "
S 	.STRINGZ " "
LEN	.STRINGZ "\n\n\nLength Of string: "

ARRAY   .BLKW 26               ; Array-> size 26 to store counts of frequency of letters

OFFSET_97 	.FILL #-97     ; Offset for ASCII conversion  : a is 97
OFFSET_65       .FILL #-65     ; Offset for ASCII conversion : A is 65
OFFSET_UPPER    .FILL #-26     ; Negative 26 for upper case check
OFFSET_CNVRT    .FILL #32      ; For adding 32 to convert upper case to lower case
TOT_LTRS    	.FILL #26      ; For counter : 26 letters in alphabet

OFFSET_LOWER    .FILL #97      ; Offset for ASCII conversion of letters: a to z
OFFSET_NUM      .FILL #48      ; Offset for ASCII conversion of numbers : 0 to 9

EQ      .FILL x003D       ; Hexadecimal ASCII value for equal sign '=' 
TAB     .FILL x0009       ; Hexadecimal ASCII value for making a 'tab'

.END