.ORIG x3000  

                 ; Display prompts 
LEA R0, PRMT      ; Load address of PRMT into R0
PUTS              ; Print contents of R0 : PRMT
LEA R0, PROMPT    ; Load address of PROMPT into R0
PUTS              ; Print contents of R0 : PROMPT string

LEA R2, NEG_97    ; Load address of NEG_97 into R2
LDR R2, R2, #0    ; Load contents of address in R2 into R2 : R2 now holds -97

LEA R4, ARRAY     ; Load starting address of ARRAY into R4
AND R3, R3, #0    ; Clear R3 - character counter

AND R7, R7, #0    ; Clear R7 - lowercase flag
AND R6, R6, #0    ; Clear R6 - uppercase flag

INPUT
GETC              ; Read character into R0
OUT               ; Show the character on the screen 
ADD R5, R0, #-10  ; Subtract 10, because the enter key has value of 10
BRz OUTPUT        ; If zero it means Enter pressed, branch to OUTPUT

                    ; Check if character is uppercase
JSR CHECK_UPPERCASE ; Jump to subroutine to check for uppercase
BRnzp PROCESS_CHAR  

PROCESS_CHAR
ADD R0, R0, R2    ; Subtract 97 to find ASCII index : R0 = R0 + (-97)
BRn INPUT         ; If the result is negative then read the next character
BRzp INPUT_LOOP   ; Else start reading input

INPUT_LOOP
ADD R4, R4, R0    ; Move to the correct index in the array
LDR R1, R4, #0    ; Load contents of ARRAY at index into R1
ADD R1, R1, #1    ; Increment the value of the letter counter at index in ARRAY
STR R1, R4, #0    ; Store the new incremented value back into ARRAY
LEA R4, ARRAY     ; Reset R4 to point to the start of the ARRAY
BR INPUT          ; branch to INPUT

OUTPUT
                ; Print the character frequencies below
LEA R3, TOT_LTRS  ; Load address of TOT_LTRS into R3
LDR R3, R3, #0    ; Load contents of address in R3 into R3 : R3 now holds 26
AND R0, R0, #0    ; Reset R0 to zero
LEA R6, POS_97    ; Load address of POS_97 into R6
LDR R6, R6, #0    ; Load contents of POS_97 into R6
ADD R0, R6, #0    ; Add to R0 : print letter 'a' later

LEA R4, ARRAY     ; Point to start of ARRAY
LEA R2, POS_48    ; Load address of POS_48 into R2
LDR R2, R2, #0    ; Load contents into R2: R2 now holds 48

OUTPUT_LOOP
OUT               ; Print character stored in R0 as letter

                 ;  for printing the equal sign
LD R1, EQ         ; Load equal sign = into R1
ADD R0, R1, #0    ; Copy = sign to R0
OUT               ; Print the equal sign

LDR R0, R4, #0    ; Load contents of ARRAY at index into R0
ADD R4, R4, #1    ; Increment array index
ADD R0, R0, R2    ; Convert from ASCII chart - 0 starts at 48
OUT               ; Print character frequency

LD R1, TAB        ; Load address of TAB into R1
ADD R0, R1, #0    ; Copy tab character to R0
OUT               ; Print tab space in console

ADD R6, R6, #1    ; Go to next ASCII char
ADD R0, R6, #0    ; Add to R0, to print char at beginning of loop
ADD R3, R3, #-1   ; Decrease loop counter
BRp OUTPUT_LOOP   ; Loop if positive

HALT                    

CHECK_UPPERCASE
LEA R5, OFFSET_65 ; Load address of OFFSET_65 into R5
LDR R5, R5, #0    ; Load contents of OFFSET_65 into R5 : -65
ADD R5, R0, R5    ; Subtract 65: A
BRn CHECK_LOWERCASE ; If negative, not uppercase
LEA R6, NEG_26    ; Load address of NEG_26 into R6
LDR R6, R6, #0    ; Load contents of NEG_26 into R6: -26
ADD R5, R5, R6    ; Subtract 26
BRp CHECK_LOWERCASE ; If positive then not uppercase
ADD R6, R6, #1    ; Set R6 to 1 if uppercase
LEA R5, POS_32    ; Load address of POS_32 into R5
LDR R5, R5, #0    ; Load contents of POS_32 into R5: 32
ADD R0, R0, R5    ; Convert uppercase to lowercase by adding 32
RET

CHECK_LOWERCASE
LEA R5, NEG_97 ; Load address of NEG_97 into R5
LDR R5, R5, #0 ; Load contents of NEG_97 into R5: -97
ADD R5, R0, R5 ; Subtract 97: a
BRn INPUT      ; If negative, not lowercase
LEA R6, NEG_26 ; Load address of NEG_26 into R6
LDR R6, R6, #0 ; Load contents of NEG_26 into R6: -26
ADD R5, R5, R6 ; Subtract 26
BRp INPUT      ; If positive, not lowercase
ADD R7, R7, #1 ; Set R7 to 1 indicating lowercase
RET

PRMT    .STRINGZ "Character Counter Program!\n"
PROMPT  .STRINGZ "Please enter a string: "

ARRAY   .BLKW 26          ; Array-> size 26 to store counts of frequency of letters 

NEG_97   .FILL #-97        ; For converting from ASCII : a is 97
OFFSET_65   .FILL #-65     ; For converting from ASCII : A is 65
NEG_26      .FILL #-26     ; Negative 26 for upper case check
POS_32      .FILL #32      ; For adding 32 to convert upper case to lower case
TOT_LTRS    .FILL #26      ; For counter : 26 letters in alphabet

POS_97   .FILL #97         ; For converting to ASCII letters : a to z
POS_48   .FILL #48         ; For converting to ASCII numbers : 0 to 9

EQ      .FILL x003D       ; Hex value for equal sign '=' in ASCII
TAB     .FILL x0009       ; Hex value for making a 'tab' in ASCII

.END
