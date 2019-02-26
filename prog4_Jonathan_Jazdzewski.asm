TITLE Sorting Program
; Written by Jonathan Jazdzewski
; 7/30/18
; Sorts a user entered number of random numbers between 100 and 999 into an array in desecending order

INCLUDE Irvine32.inc
.data
MIN 	DWORD	10
MAX		DWORD	200
HI		DWORD	999
LO		DWORD	100
intro	BYTE	"Sorting program by Jonathan Jazdzewski",0
asknumber	BYTE	"Enter a number between 10 and 200 and I will fill an array with that many random numbers",0
medianstring BYTE	"Median: ",0
SPACES		BYTE	"  ",0
usernumber	DWORD	?
randarray 	DWORD 200 DUP(?)
title1	BYTE	" Unsorted list",0
title2 	BYTE	" Sorted list ",0


.code
main PROC
	call Randomize ;seed random numbers
	;Procedure to introduce the program
	call introduction

	;Procedure to ask the user to enter a number between MAX and MIN
	;receives OFFSET of a DWORD ?
	;changes registers: eax,ebx,edx
	push OFFSET usernumber
	call getdata

	;Procedure to fill the array with random numbers between 100 and 999
	;receives DWORD a between 10 and 200, OFFSET of a DWORD array 200 DUP(?)
	;returns DWORD array with a numbers
	;changes registers: eax,ebx,ecx,edx
	push usernumber
	push OFFSET randarray
	call fillarray

	;Procedure to display the array with a title
	;receives OFFSET of a DWORD array returned from fillarray, DWORD a between 10 and 200 from getdata, OFFSET of a string
	;returns nothing
	;changes registers: eax,ebx,ecx,edx
	push OFFSET randarray
	push usernumber
	push OFFSET title1
	call displaylist

	;Procedure to sort the array from highest to lowest
	;receives OFFSET of a DWORD array returned from fillarray, DWORD a between 10 and 200 from getdata
	;returns sorted array
	;changes registers: eax,ebx,ecx,edx
	push OFFSET randarray
	push usernumber
	call sortlist

	;Procedure to display the median of the array.
	;receives OFFSET of a DWORD array returned from sortlist, DWORD a between 10 and 200 from getdata
	;returns nothing
	;changes registers: eax,ebx,ecx,edx
	push OFFSET randarray
	push usernumber
	call displaymedian ;display array median

	;Procedure to display the array with a title
	;receives OFFSET of a DWORD array returned from sortlist, DWORD a between 10 and 200 from getdata, OFFSET of a string
	;returns nothing
	;changes registers: eax,ebx,ecx,edx
	push OFFSET randarray
	push usernumber
	push OFFSET title2
	call displaylist ;display sorted array

	exit
main ENDP

introduction PROC
	mov edx, OFFSET intro
	call WriteString ;write introduction
	call Crlf
	ret
introduction ENDP

getdata PROC
	push ebp
	mov ebp,esp
	mov edx, OFFSET asknumber
getnumber: ;keep asking for number if first number is outside of range
	call WriteString
	call Crlf
	call readInt
	cmp eax, MIN
	jb getnumber
	cmp eax, MAX
	jg getnumber
	mov ebx,[ebp+8]
	mov [ebx],eax ;move read number to parameter
	pop ebp
	ret	4
getdata ENDP

fillarray PROC
	push ebp
	mov ebp,esp
	mov ecx,[ebp+12] ;ecx = parameter1
	mov esi,[ebp+8] ;esi = address of parameter2[0]
	mov edx,0
loop1:
		mov eax,HI
		sub eax,LO
		inc eax
		call RandomRange ; random range between 0 and HI-LO (0-899)
		add eax,LO ; add LO to random number (100-999)
		mov ebx,esi
		mov [ebx+edx],eax ; add random number to the next spot in parameter2
		add edx,4
	loop loop1
	pop ebp
	ret 8
fillarray ENDP

displaylist PROC
	push ebp
	mov ebp,esp
	mov edx,[ebp+8] ; edx = parameter3
	call WriteString
	call Crlf
	mov ecx,[ebp+12] ;ecx = parameter2
	mov esi,[ebp+16] ;esi = parameter1[0]
	mov edx,0
	mov ebx,0 ;ebx will equal ecx*4
displayloop:
		mov eax,[esi+ebx] 
		call WriteDec ;Write the number at parameter1[ecx*4]
		add ebx,4 ;on next loop will equal ecx*4
		mov eax,ebx
		mov edx, OFFSET SPACES
		call WriteString
		mov edx,0
		mov ecx,40
		div ecx
		cmp edx,0 ;if ecx*4 is a multiplier of 40 then draw a new line. This will draw a new line every 10 numbers.
		je newline
		jmp nonewline
newline:
		call Crlf
nonewline:
		mov eax,ebx
		mov ecx,4
		mov edx,0
		div ecx ; divide ebx by 4 to get number of loops run so far
		mov ecx,eax
		mov eax,[ebp+12] ;eax = total number of loops to be run
		sub eax,ecx ;subtract number of loops so far
		mov ecx,eax 
		inc ecx ;add 1 as loop command will dec 1
	loop displayloop
	call Crlf
	pop ebp
	ret 12
displaylist ENDP

sortlist PROC
	push ebp
	mov ebp,esp
	mov esi,[ebp+12] ;esi =parameter1[0]
	mov edx,0
	mov ecx,[ebp+8] ;ecx = parameter2
sortloopout:
	push ecx ;push current ecx to preserve number of sortloopout loops
	mov ecx,[ebp+8] 
	sub ecx,1 ;sortloopin needs to run parameter2 -1 number of times for each loop of sortloopout
	mov edx,0
	sortloopin:
		mov eax,[esi+edx] ;eax = parameter1[x]
		mov ebx,[esi+edx+4] ;ebx=parameter1[x+1]
		cmp eax,ebx
		jg noswitch ; if eax<ebx then switch, else don't switch
		mov [esi+edx],ebx
		mov [esi+edx+4],eax
		noswitch:
		add edx,4
		loop sortloopin
	mov ecx,[ebp-4] ;change the counter back to the pushed value
	pop ecx
	loop sortloopout
pop ebp
ret 8
sortlist ENDP

displaymedian PROC
	push ebp
	mov ebp,esp
	mov eax,[ebp+8] ;eax=parameter2
	mov esi,[ebp+12] ;esi = parameter1[0]
	mov edx,0
	mov ebx,2
	div ebx
	cmp edx,0
	je eve
	mov ebx,4 ; if parameter2 is odd then find the middle value of the array and display it
	mul ebx
	mov edx,eax
	mov eax,[esi+edx]
	mov edx,OFFSET medianstring
	call WriteString
	call WriteDec
	call Crlf
	jmp ending
eve:
	mov ebx,4 ;if parameter2 is even then find the two middle values of the array
	mul ebx
	mov edx,eax
	mov eax,[esi+edx]
	sub edx,4
	mov ebx,[esi+edx]
	add eax,ebx
	mov ebx,2
	mov edx,0
	div ebx
	cmp edx,0
	je write ;if the two middle values divided by 2 is even then write the number
	inc eax ;else increment the number by one then write it
write:
	mov edx,OFFSET medianstring
	call WriteString
	call WriteDec
	call Crlf
ending:
	pop ebp
	ret 8
displaymedian ENDP

END main