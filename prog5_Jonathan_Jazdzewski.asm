TITLE Recursion     (prog5_Jonathan_Jazdzewski.asm)
; Author:Jonathan Jazdzewski
; Last Modified:
; OSU email address: jazdzewj@oregonstate.edu
; Course number/section: CS271
; Assignment Number:                 Due Date:
; Description: A program which gives a set size and number of elements and asks the user for an answer. 
; Determines if the answer is correct.
INCLUDE Irvine32.inc
mWriteString MACRO buffer
    push edx
    mov edx, OFFSET buffer
    call WriteString
    pop edx
ENDM
.data
INTRO   BYTE    "Combination Calculator",0
INTRO2  BYTE    "By Jonathan Jazdzewski",0
INTRO3  BYTE    "I'll give you a combination problem.",0
INTRO4  BYTE    "You enter your answer and I'll tell you if you're right.",0
PROB    BYTE    "Problem:",0
NUMELE  BYTE    "Number of elements in the set: ",0
NUMCHOOSE   BYTE  "Number of elements to choose from in the set: ",0
HOWMANY BYTE    "How many combinations are there?",0
THEREARE    BYTE    "There are ",0
COMBOOF BYTE    " combinations of ",0
ITEMSFROM   BYTE    " items from a set of ",0
ANOTHER BYTE    "Another problem? (y/n) ",0
INVALID BYTE    "Invalid response  ",0
CORRECT BYTE    "Correct!",0
INCORRECT	BYTE	"Incorrect",0
GOODBYE BYTE    "Goodbye.",0
TEST1	BYTE	"Test",0

HI  DWORD   12
LO  DWORD   3

n   DWORD   ?
re  DWORD   ?
n1  DWORD   0
r1  DWORD   0
n1minusr1   DWORD   0
answer  DWORD   ?
result  DWORD   ?
input	BYTE	?

.code
main PROC
    call Randomize
	call introduction
again:
    push OFFSET n
    push OFFSET re
    call showProblem
	
	mov eax,n
	call WriteDec
	call Crlf
	mov eax,re
	call WriteDec
	call Crlf

    push OFFSET answer
    call getData

    push n
    push re
    push OFFSET result
    call combinations

    push n
    push re
    push result
    push answer
    call showResult
another1:
	mWriteString ANOTHER
	mov ecx,2
	mov edx,OFFSET input
	call ReadString
	mov esi,edx
	mov eax,0
	mov al,0
	lodsb
	cmp al,121
	jne check1
	jmp again
check1:
	cmp al,110
	jne invalid1
	jmp quit1
invalid1:
	mWriteString INVALID
	call Crlf
	jmp another1
quit1:
	mWriteString GOODBYE
	call Crlf


exit
main ENDP

factorial PROC
    push ebp
    mov ebp,esp
    push eax
    push ebx
    push ecx
    mov eax,[ebp+8]
    mov ebx,[ebp+12]
    mov ecx,[ebx]
    cmp ecx,0
    jne multi
    mov [ebx],eax
    jmp fac
multi:
    mul ecx
    mov [ebx],eax
fac:
    dec eax
	cmp eax,1
	je exit1
	call WriteDec
	call Crlf
    push ebx
    push eax
    call factorial
exit1:
    mov eax,[ebp-4]
    mov ebx,[ebp-8]
    mov ecx,[ebp-12]
    pop ebx
    pop ebp
    ret 8
factorial ENDP

introduction PROC
    mWriteString INTRO
	call Crlf
	mWriteString INTRO2
	call Crlf
    mWriteString INTRO3
	call Crlf
	mWriteString INTRO4
	call Crlf
    ret
introduction ENDP

showProblem PROC
    push ebp
    push eax
    push ebx
    push edx
    mov ebp,esp
    mov eax,HI
    mov ebx,LO
    sub eax,ebx
    inc eax
    call RandomRange
    add eax,ebx
	
	mWriteString PROB
	call Crlf
	mWriteString NUMELE
	call Crlf
	call WriteDec
	call Crlf
    
    mov ebx,[ebp+12]
	mov [ebx],eax
	dec eax
    call RandomRange
	inc eax

	mWriteString NUMCHOOSE
	call Crlf
	call WriteDec
	call Crlf

    mov ebx,[ebp+8]
	mov [ebx],eax

    mov eax,[ebp-4]
    mov ebx,[ebp-8]
    mov edx,[ebp-12]
    pop edx
    pop ebx
    pop eax
    pop ebp
    ret 8
showProblem ENDP

getData PROC
    push ebp
    mov ebp,esp
    push edx
    push eax
    push ebx
    mWriteString HOWMANY
	call Crlf
	call ReadInt
    mov ebx,[ebp+8]
    mov [ebx],eax
    mov edx,[ebp-4]
    mov eax,[ebp-8]
    mov ebx,[ebp-12]
    pop ebx
    pop eax
    pop edx
    pop ebp
    ret 4
getData ENDP

combinations PROC
    push ebp
    mov ebp,esp
    push eax
    push ebx
    push ecx
    push edx
    mov eax,[ebp+16]
    mov ebx,[ebp+12]
    sub eax,ebx
    mov ecx,eax
    push OFFSET n1minusr1
    push ecx
    call factorial
    mov ecx,n1minusr1
    mov eax,[ebp+12]
    push OFFSET r1
    push eax
    call factorial
    mov eax,r1
    mul ecx
    mov ebx,eax ; ebx = denom
    mov eax,[ebp+16]
    push OFFSET n1
    push eax
    call factorial
    mov eax,n1
    mov edx,0
    div ebx
    mov ebx,[ebp+8]
    mov [ebx],eax
    mov eax,[ebp-4]
    mov ebx,[ebp-8]
    mov ecx,[ebp-12]
    mov edx,[ebp-16]
    pop edx
    pop ecx
    pop ebx
    pop eax
    pop ebp
    ret 12
combinations ENDP

showResult PROC
    push ebp
    mov ebp,esp
    push eax
    push ebx
    push edx
    mWriteString THEREARE
	call WriteDec
	mWriteString COMBOOF
	mov eax,[ebp+20]
	call WriteDec
	mWriteString ITEMSFROM
	mov eax,[ebp+16]
	call WriteDec
	call Crlf
    mov eax,[ebp+8]
    mov ebx,[ebp+12]
    cmp eax,ebx
    je correct1
    mWriteString INCORRECT
    call Crlf
    jmp ending
    correct1:
	mWriteString CORRECT
	call Crlf
    ending:
    mov eax,[ebp-4]
    mov ebx,[ebp-8]
    mov edx,[ebp-12]
    pop edx
    pop ebx
    pop eax
    pop ebp
    ret 16
showResult ENDP

; (insert additional procedures here)
END main