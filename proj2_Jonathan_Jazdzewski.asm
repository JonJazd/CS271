TITLE Fibonacci sequence     (proj2_Jonathan_Jazdzewski.asm)
; Author:Jonathan Jazdzewski
; Last Modified:
; OSU email address: jazdzewj@oregonstate.edu
; Course number/section: CS271
; Assignment Number: 2                Due Date: 7/15/18
; Description:A program to display a user specified number of fibonacci numbers
INCLUDE Irvine32.inc
.data
NAME1       BYTE    "Programmed by: Jonathan Jazdzewski",0
PROGNAME    BYTE    "Fibonacci Numbers",0
USERNAME    BYTE    "What's your name? ",0
HI          BYTE    "Hi, ",0
ENTERSTRING BYTE    "Enter the number of Fibonacci numbers to be shown.",0
GIVENUMBERS BYTE    "Give the numbers as an integer in the range 1-46.",0
HOWMANY     BYTE    "How many Fibonacci terms do you want? ",0
OUTOFRANGE  BYTE    "Out of range.  Enter a number between 1-46",0
BYE         BYTE    "Goodbye, ",0
FOURSIX     DWORD   46
ONE         DWORD   1
SPACES      BYTE   "     ",0
; (insert constant definitions here)

StoredNumber1  DWORD    0
StoredNumber2  DWORD    0
Fibnumber      DWORD    ?
usersname      BYTE     33 DUP(0)
; (insert variable definitions here)
.code
main PROC
    ;program name
    mov     edx, OFFSET PROGNAME
    call    WriteString
    call    Crlf

    ;my name
    mov     edx, OFFSET NAME1
    call    WriteString
    call    Crlf

    ;user input name
    mov     edx, OFFSET USERNAME
    call    WriteString
    mov     edx, OFFSET usersname
    mov     ecx, 32
    call    ReadString
    call    Crlf

    ;say hello
    mov     edx, OFFSET HI
    call    WriteString
    mov     edx, OFFSET usersname
    call    WriteString
    call    Crlf

    ;ask for number
    mov     edx, OFFSET ENTERSTRING
    call    WriteString
    call    Crlf
    mov     edx, OFFSET GIVENUMBERS
asknumbers:
    call    WriteString
    call    Crlf
    mov     edx, OFFSET HOWMANY
    call    WriteString
    call    ReadInt
    call    Crlf
    mov     edx, OFFSET OUTOFRANGE
    ;check if number is below 0 or above 46
    cmp     ONE,eax
    jg      asknumbers
    cmp     eax,FOURSIX
    jg      asknumbers
    mov     ecx,eax

    ;loop ecx number of times
    mov     eax,ONE
    mov     edx,OFFSET SPACES
displaynumbers:
    add     eax,StoredNumber2
    call    WriteDec
    call    WriteString
    mov     ebx,StoredNumber1
    mov     StoredNumber2,ebx
    mov     StoredNumber1,eax
    loop displaynumbers

    ;display goodbye strings
    call    Crlf
    mov     edx,OFFSET BYE
    call    WriteString
    mov     edx,OFFSET  usersname
    call    WriteString
    call    Crlf
; (insert executable instructions here)
exit  
; exit to operating systemmain 
main ENDP
; (insert additional procedures here)
END main