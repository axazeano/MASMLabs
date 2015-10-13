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
		mov dx, offset string
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
	


        ; exit to DOS
        mov     ax, 4C00h
        int     21h

CSEG_2    ENDS


        ; data
DSEG_2    SEGMENT byte

        ; ...

DSEG_2    ENDS

END