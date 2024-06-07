
# Character Counter Program

## Overview
The Character Counter Program is an application designed to count and display how often each letter appears in a line of text that you enter. This program runs on the LC-3 simulator.

## How It Works

### Getting Started

#### Welcome Messages:
- When you start the program, you will see a message that says "String character counter program".
- You will then be prompted with the message "Enter a string: ".

#### Input Your Text:
- Type in a line of text (e.g., "hello world" or "Bob Smith") and press Enter.
- Program accepts both uppercase and lowercase characters. 
### Counting Characters

#### Processing Your Input:
- The program will read each letter in your string.
- It will count how many times each letter appears.
- NOTE: - Program accepts uppercase and lowercase letters but the case of the letter is not considered uniquely! This means that entering a captial versus lowercase charater only counts as the same ocurrance of the same letter. 
#### Displaying Results:
- After counting, the program will display each letter and the number of times it appeared in your text.
- For example, if you entered "Hello", it would display:
  h = 1 , e  = 1, l =2, o = 1 

##### EXAMPLE OF PROGRAM OUTPUT: 
![Screenshot (467)](https://github.com/NEC-CIS-11/Character-Counter-for-Names/assets/125232234/2a70d1de-e3ac-40aa-bb74-03e00927a79b)


## How-it-Works
- The program uses an array to keep track of the counts for each letter.
- It converts each letter to a corresponding position in the array.
- It increments the count for each letter as it reads through your input.

### Finishing Up
- Once the counts are displayed, the program will halt, and you can view the results.

## Key Features
- **User-centric Input:** Simply type your text and press Enter.
- **Real-Time Counting:** The program processes and counts letters as you type.
- **Clear Output:** Results are displayed in an easy-to-read format.

## How to Use

1. **Set Up:** Ensure the LC-3 simulator is installed on your computer.
2. **Load the Program:** Load the Character Counter Program into the simulator.
3. **Run the Program:** Start the program and follow the on-screen prompts.
4. **Input Your Text:** Enter a line of lowercase text and press Enter.
5. **View Results:** See the frequency of each letter displayed on the screen.

## Detailed Program Flow

### Initialization

1. **Display Welcome Messages:**
  - "Character Counter"
  - "Please enter a line of lower case text"
2. **Stack Pointer Setup:** Set the stack pointer to the base address x4000.
3. **Array Setup:**
  - Set the starting address of the array.
  - Initialize a counter to 0.
  - Initialize array elements to zero using a loop.

### Count Characters Function

1. **Save State:** Save the return address (current PC) to the stack. Decrement the stack pointer by 1.
2. **ASCII Conversion Preparation:**
  - Load the value -97 for ASCII conversion.
  - Set the starting address of the array.
  - Initialize the character counter to 0.
3. **Input Loop:**
  - Loop until the Enter key is pressed:
      - Read a character from the user.
      - Display the character on the screen.
      - If the Enter key is pressed, exit the loop.
      - Subtract 97 from the character to find the array index.
      - If the result is negative, read the next character.
      - Move to the correct position in the array based on the index.
      - Increment the character count at this position.
      - Store the new count back in the array.
      - Reset to the start of the array for the next character.
4. **Restore State:** Restore the return address from the stack. Save the current stack pointer address to STACK_PTR. Restore the saved stack pointer address from STACK_PTR. Increment the stack pointer by 1. Return from the character counting function.

### Display Character Frequencies Function

1. **Save State:** Save the return address (current PC) to the stack. Decrement the stack pointer by 1.
2. **Display Loop:**
  - Initialize a counter to 26 (for the alphabet).
  - Set the current character to 'a'.
  - Set the starting address of the array.
  - Load the ASCII value for '0'.
  - Loop:
      - Display the current character.
      - Display the equal sign '='.
      - Get the count of the current character from the array.
      - Move to the next position in the array.
      - Convert the count to its ASCII representation.
      - Display the count.
      - Display a newline character.
      - Move to the next character in the alphabet.
      - Decrement the counter.
3. **Restore State:** Restore the return address from the stack. Save the current stack pointer address to STACK_PTR. Restore the saved stack pointer address from STACK_PTR. Increment the stack pointer by 1. Return from the display function.

### Termination
- Halt the program.

## Constants and Messages

- **MSG0:** "Character Counter"
- **MSG1:** "Please enter a line of lower case text"
- **ARRAY:** Array to store counts for 'a' to 'z'
- **NEG97:** Constant -97 for ASCII conversion
- **POS26:** Constant 26 for the loop counter
- **EQ:** Equal sign '=' in ASCII
- **TAB:** Newline character
- **POS97:** Constant 97 for converting to ASCII letters
- **POS48:** Constant 48 for converting to ASCII numbers
- **STACK_BASE:** Starting address of the stack

## Conclusion
The Character Counter Program is an easy-to-use program that helps you quickly see how often each letter appears in any line of lowercase text you enter. 
