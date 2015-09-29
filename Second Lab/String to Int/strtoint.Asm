; Template for DOS .exe file
;	al is symbol
;	bx is number
;	dx is result of to_int
;	ch is size of string

        assume  cs:cseg, ds:dseg, ss:sseg

        ; code
cseg    segment
start:
        mov ax, dseg
        mov ds, ax
               
        mov dx, offset msg_hello
        mov ah, 09h
        int 21h
        
        mov bl, 10
        
        mov dx, offset string
        mov ah, 0Ah
        int 21h
        
        ; mov size of array into di
        xor ax, ax
        mov al, [string+1]
        add al, 2
        mov di, ax
        
        ;mov ax, word ptr [string+1]
        
        
        ;mov di, byte ptr [string+1]
        
        mov si, 2
        
        xor dx, dx
        
        mov dl, 0Ah
	mov ah, 02h
	int 21h
        
        ;first element
        
to_int:
	mov cl, [string+si]
	sub cl, '0'
	xor ch, ch
	
	cmp cl, 0
	jb error
	cmp cl, 9
	ja error
	
	mov ax, dx
	mul bl
	mov dx, ax
	add dx, cx
	
	inc si
	cmp si, di
	jb to_int
	
	xor si, si
	mov ax, dx
	
	jmp to_str
	
to_str:
	mov ax, 123
	div bl
	mov dh, ah
	add dl, '0'
	mov dh, al

	mov ah, 02h
	int 21
	
	xor ah, ah
	
	mov al, 255
	sub al, dh
	add al, 1

	
;	mov dl, al
;	xor dh, dh
;	
;	mov al, dh
;	xor ah, ah
	
	inc si
	cmp si, di
	jb to_str
	jmp finish
	
        
error:
	mov dx, offset msg_error
	mov ah, 09h
	int 21h
	
finish:
	;mov ah, 01
	;int 21
	
	mov     ax, 4C00h
        int     21h

cseg    ends


        ; data
dseg    segment byte

        msg_hello db 'Hi! Enter a string',0Dh,0Ah,'$' 
	msg_error db 'String must countain only numbers!',0Dh,0Ah,'$' 
	msg_again db 'Enter a string again',0Dh,0Ah,'$'
	msg_finish db 'ok',0Dh,0Ah,'$'
	string db 100h dup ('$')
	
	mv_cursor db 0Dh
	new_line db 0Dh
	
	digit db 100h dup(?)

dseg    ends

        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start
