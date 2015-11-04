 .286
 .model LARGE, C
 
        ; code
 CSEG_2    SEGMENT public


	;this is implementation of proc1 procedure.
	 proc1 PROC far a:WORD
		
		mov ah, 1
		int 21h
		
		ret
	proc1 endp 
	
	Print PROC far string:WORD
		
		push ax
		push dx
		
		mov dx, string
		mov ah, 09h
		int 21h
		
		pop dx
		pop ax
		
		ret
	Print endp

	WAIT_ANY_KEY PROC far
	
		push ax
		mov ah, 01h
		int 21h
		pop ax
		
		ret
	WAIT_ANY_KEY endp
	
	
	print_array PROC array:WORD, len:WORD
		push si
		push dx
		push ax
		push bx
	
		xor si, si
	
		print_loop:
			mov bx, array
			add bx, si
			mov dx, bx
			add dx, '0'
			mov ah, 02h
			int 21h
			inc si
			cmp si, len
			jb print_loop
		
		mov dl, 0Ah
		mov ah, 02h
		int 21h
	
		pop bx
		pop ax
		pop dx
		pop si
		
		ret
	print_array endp


        ; exit to DOS
        mov     ax, 4C00h
        int     21h

CSEG_2    ENDS


        ; data
DSEG_2    SEGMENT byte

        ; ...

DSEG_2    ENDS

END