        .ORIG x3000  

       			  ; Display prompts below
        LEA R0, MSG0      ; Load address of MSG0 into R0
        PUTS              ; Print contents of R0 : MSG0
        LEA R0, MSG1      ; Load address of MSG1 into R0
        PUTS              ; Print contents of R0 : MSG1 string

	
        LEA R2, NEG97     ; Load address of NEG97 into R2
        LDR R2, R2, #0    ; Load contents of address in R2 into R2 : R2 now holds -97

        LEA R4, ARRAY     ; Load starting address of ARRAY into R4
        AND R3, R3, #0    ; Clear R3 - character counter

INPUT
        GETC              ; Read character into R0
        OUT               ; Show the character on the screen so user can see what they are typing
        ADD R5, R0, #-10  ; Subtract 10, because the 'Enter' key has value of 10
        BRz OUTPUT        ; If zero (Enter pressed), branch to OUTPUT

        ADD R0, R0, R2    ; Subtract 97 to find ASCII index : R0 = R0 + (-97)
        BRn INPUT         ; If the result is negative then read the next character
        BRzp INPUT_LOOP   ; Else start reading input

INPUT_LOOP
        ADD R4, R4, R0    ; Move to the correct index in the array
        LDR R1, R4, #0    ; Load contents of ARRAY at index into R1
        ADD R1, R1, #1    ; Increment the value of the letter counter at index in ARRAY
        STR R1, R4, #0    ; Store the new incremented value back into ARRAY
        LEA R4, ARRAY     ; Reset R4 to point to the start of the ARRAY
        BR INPUT          ; Unconditional branch to INPUT
	
	
OUTPUT
       			  ; Print the character frequencies below
        LEA R3, POS26     ; Load address of POS26 into R3
        LDR R3, R3, #0    ; Load contents of address in R3 into R3 : R3 now holds 26
        AND R0, R0, #0    ; Reset R0 to zero
        LEA R6, POS97     ; Load address of POS97 into R6
        LDR R6, R6, #0    ; Load contents of POS97 into R6
        ADD R0, R6, #0    ; Add to R0 : print letter 'a' later

        LEA R4, ARRAY     ; Point to start of ARRAY
        LEA R2, POS48     ; Load address of POS48 into R2
        LDR R2, R2, #0    ; Load contents into R2 :R2 now holds 48

OUTPUT_LOOP
        OUT               ; Print character stored in R0 as letter

        		  ; Below is for printing the equal sign
        LD R1, EQ         ; Load equal sign '=' into R1
        ADD R0, R1, #0    ; Copy '=' sign to R0
        OUT               ; Print the equal sign

        LDR R0, R4, #0    ; Load contents of ARRAY at index into R0
        ADD R4, R4, #1    ; Increment array index
        ADD R0, R0, R2    ; Convert from ASCII chart - 0 starts at 48
        OUT               ; Print character frequency
	
	
        LD R1, TAB        ; Load address of TAB into R1
        ADD R0, R1, #0    ; Copy tab character to R0
        OUT               ; Print tab space in console

        ADD R6, R6, #1    ; Go to next char in ASCII table
        ADD R0, R6, #0    ; Add to R0, to print char at beginning of loop
        ADD R3, R3, #-1   ; Decrease loop counter
        BRp OUTPUT_LOOP   ; Loop if positive

	HALT                    

MSG0    .STRINGZ "Character Counter Program!\n"
MSG1    .STRINGZ "Please enter a lower-case string: "

ARRAY   .BLKW 26          ; Array of size 26 to store counts for 'a' to 'z'
NEG97   .FILL #-97        ; Constant for converting from ASCII : 'a' is 97
POS26   .FILL #26         ; Constant for counter : 26 letters in alphabet
EQ      .FILL x003D       ; Hex value for equal sign '=' in ASCII
TAB     .FILL x0009       ; Hex value for making a 'tab' in ASCII

POS97   .FILL #97         ; Constant for converting to ASCII letters : 'a' to 'z'
POS48   .FILL #48         ; Constant for converting to ASCII numbers : '0' to '9'

.END
