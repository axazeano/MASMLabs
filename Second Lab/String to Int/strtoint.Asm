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
        
        mov bx, 10
        
        mov dx, offset string
        mov ah, 0Ah
        int 21h
        
        mov dl, 0Ah
        mov ah, 02h
	int 21h
	
	mov dl, 0Ah
        mov ah, 02h
	int 21h
        
        ; mov size of array into di
        xor ax, ax
        mov al, [string+1]
        add al, 2
        mov di, ax
        
        xor dx, dx
        
        mov si, 2
        
to_int:
	; read element from string
	mov cl, [string+si]
	; make digit
	sub cl, '0'
	;set ch=0 
	xor ch, ch
	
	; check that cl is digit
	cmp cl, 0
	jb error
	cmp cl, 9
	ja error
	
	mov ax, dx
	mul bl
	mov dx, ax
	add ax, cx
	
	inc si
	cmp si, di
	jb to_int
	
	mov si, 2
	
	mov ax, dx
	xor si, si
	
	jmp to_str
	
to_str:
	; Divide on 10
	div bl
	
	mov dl, ah
	add dl, '0'
	xor dh, dh
	push dx
	
	mov ah, 02h
	int 21h
	
	xor ah, ah
	inc si

	cmp al, 0
	jne to_str
	jmp print

print:
	pop dx
	mov ah, 02h
	int 21h
	dec si
	cmp si, 0
	jne print
	jmp finish
        
error:
	mov dx, offset msg_error
	mov ah, 09h
	int 21h
	
finish:
	mov ah, 01h
	int 21h
	
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
	
	res_str db 100h dup ('$')
	
	mv_cursor db 0Dh
	new_line db 0Dh
	
	digit db 100h dup(?)

dseg    ends

        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start
