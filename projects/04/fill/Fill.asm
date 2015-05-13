// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

(LOOP)
    @i
    M=0
    @KBD
    D=M
    @BLACK
    D;JGT   // jump to black if a key is pressed
(WHITE)
    @i
    D=M
    @SCREEN
    A=A+D
    M=0    // turn word white
    @i
    MD=M+1
    @8192
    D=A-D
    @WHITE
    D;JGT   // if we have more screen to fill
    @LOOP
    0;JMP
(BLACK)
    @i
    D=M
    @SCREEN
    A=A+D
    M=-1    // turn word black
    @i
    MD=M+1
    @8192
    D=A-D
    @BLACK
    D;JGT   // if we have more screen to fill
    @LOOP
    0;JMP
