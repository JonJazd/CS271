TITLE Composite numbers    (prog3_Jonathan_Jazdzewski.asm)
; Author:Jonathan Jazdzewski
; Last Modified: 7/25/18
; OSU email address: jazdzewj@oregonstate.edu
; Course number/section: CS271
; Assignment Number: 3                Due Date:7/29/18
; Description: A program which calls procedures in order to display a number of composite numbers
INCLUDE Irvine32.inc
; (insert constant definitions here)
.data
intro       BYTE    "Composite numbers.     Programmed by: Jonathan Jazdzewski",0
start1      BYTE    "Enter the number of composite numbers to display between 1 and 400.",0
enter1      BYTE    "Please enter an integer between 1 and 400",0
outofrange  BYTE    "That was out of range.",0
outro       BYTE    "Goodbye.",0
spaces      BYTE    "   ",0
MAX         DWORD    400
min         DWORD    1
two        DWORD    2
storednumber   DWORD   ?
loop1number DWORD   ?
loop2number DWORD   ?
divider     DWORD   ?
test1       BYTE    "Looping",0
test2       BYTE    "L2",0

.code
main PROC
    call    introduction
    call    getnumber
    call    displaynumbers
    call    exitprog
exit  
; exit to operating systemmain 
main ENDP

introduction PROC
    mov     edx,OFFSET intro
    call    WriteString
	call	Crlf
    mov     edx,OFFSET start1
    call    WriteString
	call	Crlf
ret
introduction ENDP

getnumber PROC
startproc:
    mov     edx, OFFSET enter1
    call    WriteString
    call    Crlf
    call    ReadInt
    call    Crlf
    cmp     eax,min
    jge     overone
    mov     edx, OFFSET outofrange
    call    WriteString
    call    Crlf
    jmp     startproc
overone:
    cmp     eax,MAX
    jb      belowmax
    mov     edx, OFFSET outofrange
    call    WriteString
    call    Crlf
    jmp     startproc
belowmax:
    mov ecx,eax
ret
getnumber ENDP

displaynumbers PROC
    mov     eax,3
	mov		ebx,0
loop1:
    add eax,1
    mov loop1number,ecx
    mov storednumber,eax
	mov edx,0
    div two
	mov	ecx,eax
    mov eax,storednumber
    loop2:
        cmp ecx,1
        je ending
		mov edx,0
        mov divider,ecx
        div divider
        cmp edx,0
        je equalzero
        jmp ending
        equalzero:
        mov eax,storednumber
		add ebx,1
        call WriteDec
        mov edx,OFFSET spaces
        call WriteString
        sub loop1number,1
        mov divider,ecx
		sub divider,1
		sub ecx,divider
        ending:
        mov eax,storednumber
        loop loop2
    add loop1number,1
	mov ecx,loop1number
	cmp ebx,5
	jne noline
	call Crlf
	mov ebx,0
noline:
    sub ecx,1
	cmp ecx,0
	jg loop1 ; this was a loop command but the jump was too far
    call	Crlf
ret
displaynumbers ENDP

exitprog PROC
    mov     edx, OFFSET outro
    call    WriteString
ret
exitprog ENDP

END main