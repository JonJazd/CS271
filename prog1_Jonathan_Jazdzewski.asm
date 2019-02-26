TITLE Program1 (prog1_Jonathan_Jazdzewski.asm)

;Author: Jonathan Jazdzewski
;CS271 Program 1
;Description: Asks for two integers from the user and calculates the sum, difference, product and quotient with remainder.

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword


.data

firstnumber     DWORD   ?
secondnumber    DWORD   ?
sum             DWORD   ?
difference      DWORD   ?
product         DWORD   ?
quotient        DWORD   ?
remainder       DWORD   ?
firstnumstring  BYTE    "First number: ",0
secondnumstring BYTE    "Second number: ",0
singoff         BYTE    "Over and out.",0
intro1          BYTE    "Enter two numbers and I will display the sum, difference,",0
intro2          BYTE    "product and quotient with the remainder.",0
plus            BYTE    " + ",0
minus           BYTE    " - ",0
times           BYTE    " x ",0
divide          BYTE    " / ",0
remainderstring BYTE    " remainder ",0
equals          BYTE    " = ",0


.code
main proc
    ;call intro1 string
    mov     edx,OFFSET intro1
    call    WriteString
    call    Crlf
    ;call intro2 string
    mov     edx,OFFSET intro2
    call    WriteString
    call    Crlf
    ;get first integer
    mov     edx,OFFSET firstnumstring
    call    WriteString
    call    ReadInt
    mov     firstnumber,eax
    ;get second integer
    mov     edx,OFFSET secondnumstring
    call    WriteString
    call    ReadInt
    mov     secondnumber,eax
    ;add numbers together, move to sum
    add     eax,firstnumber
    mov     sum,eax
    ;subtract numbers, move to difference
    mov     eax,firstnumber
    sub     eax,secondnumber
    mov     difference,eax
    ;multiply numbers, move to product
    mov     eax,firstnumber
    imul    secondnumber
    mov     product,eax
    ;divide numbers, move to quotient and remainder
    mov     eax,firstnumber
	div     secondnumber
    mov     quotient,eax
    mov     remainder,edx
    ;display sum
    mov     eax,firstnumber
    call    WriteDec
    mov     edx, OFFSET plus
    call    WriteString
    mov     eax,secondnumber
    call    WriteDec
    mov     edx,OFFSET equals
    call    WriteString
    mov     eax,sum
    call    WriteDec
    call    Crlf
    ;display difference
    mov     eax,firstnumber
    call    WriteDec
    mov     edx,OFFSET minus
    call    WriteString
    mov     eax,secondnumber
    call    WriteDec
    mov     edx,OFFSET equals
    call    WriteString
    mov     eax,difference
    call    WriteDec
    call    Crlf
    ;display product
    mov     eax,firstnumber
    call    WriteDec
    mov     edx,OFFSET times
    call    WriteString
    mov     eax,secondnumber
    call    WriteDec
    mov     edx,OFFSET equals
    call    WriteString
    mov     eax,product
    call    WriteDec
    call    Crlf
    ;display quotient
    mov     eax,firstnumber
    call    WriteDec
    mov     edx,OFFSET divide
    call    WriteString
    mov     eax,secondnumber
    call    WriteDec
    mov     edx,OFFSET equals
    call    WriteString
    mov     eax,quotient
    call    WriteDec
    mov     edx,OFFSET remainderstring
    call    WriteString
    mov     eax,remainder
    call    WriteDec
    call    Crlf
		invoke ExitProcess,0
main ENDP
END main