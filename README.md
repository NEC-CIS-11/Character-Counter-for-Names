# Character Counter Program

## Overview
The Character Counter Program is an application designed to count and display how often each letter appears in a STRING you enter. This program runs on the LC-3 simulator.

## How It Works

### Getting Started

#### Welcome Messages:
- When you start the program, you will see a message that says "String character counter program".
- You will then be prompted with the message "Enter a string: ".

#### Input Your Text:
- Type in a line of text (e.g., "hello world" or "Bob Smith") and press Enter.
- The program accepts both uppercase and lowercase characters.

### Counting Characters

#### Processing Your Input:
- The program will read each letter in your string.
- It will count how many times each letter appears.
- NOTE: The program treats uppercase and lowercase letters as the same. For example, 'A' and 'a' are considered the same letter.

#### Displaying Results:
- After counting, the program will display each letter and the number of times it appeared in your text.
- For example, if you entered "Hello", it would display:
  - h = 1, e = 1, l = 2, o = 1

### Example of Program:
![Screenshot (467)](https://github.com/NEC-CIS-11/Character-Counter-for-Names/assets/125232234/2a70d1de-e3ac-40aa-bb74-03e00927a79b)

## How-it-Works
- The program uses an array to keep track of the frequencies of each letter.
- It converts each letter to a corresponding position in that array.
- It increments the count for each letter as it reads through your string.

## Key Features
- **User Input:** Simply type your string and press Enter.
- **Instant Counting:** The program processes and counts the frequency of characters in the string you entered regardless of case.
- **Clear Output:** Results are displayed and easy to read.

## How to Use

1. **Set Up:** Ensure the LC-3 simulator is installed on your computer.
2. **Load the Program:** Load the Character Counter Program into the simulator.
3. **Run the Program:** Start the program and follow the on-screen prompts.
4. **Input Your Text:** Enter a string and press Enter.
5. **View Results:** See the frequency of each letter displayed on the screen.

## Overview of Program Flow

### Initialization

1. **Display Welcome Messages:**
  - "String character counter program".
  - "Enter a string: ".

2. **Setup Registers and Array:**
  - Set the starting address of the array.
  - Initialize counters and flags.

### Count Characters 

1. **Get Input:**
  - Loop until the Enter key is pressed:
    - Read a character from the user.
    - Display the character on the screen.
    - If the Enter key is pressed, exit the loop.
    - Convert characters to lowercase if needed.
    - Increment the character frequency at the corresponding array position.

### Display Character Frequencies 

1. **Display Loop:**
  - Initialize a counter for the alphabet.
  - Set the starting address of the array.
  - Loop through the array and display each letter and its frequency.

### Program also includes functions to determine character cases and many of the project requirements that are not listed here. 
## Please refer to source code for specific details of implementation. 


## Labels and Prompts

- **PRMT:** "String character counter program"
- **PROMPT:** "Enter a string: "
- **ARRAY:** Array to store frequencies for 'a' to 'z'
- **OFFSET_97:** -97 for ASCII conversion
- **OFFSET_65:**  -65 for ASCII conversion
- **OFFSET_UPPER:** -26 for uppercase check
- **OFFSET_CNVRT:** 32 for converting uppercase to lowercase
- **TOT_LTRS:**  26 for the loop counter
- **OFFSET_LOWER:**  97 for converting to ASCII letters
- **OFFSET_NUM:** 48 for converting to ASCII numbers
- **EQ:** Equal sign '=' in ASCII
- **TAB:** Tab character

## Conclusion
The Character Counter Program is a simple program that will quickly calculate how often each letter of a string appears in the text you entered. 
