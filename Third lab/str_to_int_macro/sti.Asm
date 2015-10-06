; Template for DOS .exe file


        assume  cs:cseg, ds:dseg, ss:sseg
		
cseg    segment


isInt MACRO string, len
	; True if string can be converted into int
	; al = 1 or 0
	push si
	push ax
	xor si, si
	check_loop:
		mov ah, [string+si]
		sub ah, '0'
		cmp ah, 0
		jb not_int
		cmp ah, 9
		ja not_int
		mov al, 1
		inc si
		cmp si, len
		ja finish
		jmp check_loop 
	not_int:
		mov al, 0
	finish:
		xor ah, ah
		pop si
		endm


set_segment MACRO SegmentRegister, SegmentName
	push ax
	mov ax, SegmentName
	mov SegmentRegister, ax
	pop ax
endm

toInt MACRO string, len
	push dx
	push cx
	push si

	mov cl, 0Ah
	xor si, si
	xor dx, dx
	xor ax, ax
	
	convert_loop:
		mov dl, [string+si]
		sub dl, '0'
		
		mul cl
		add ax, dx
		
		inc si
		cmp si, len
		jb convert_loop

	pop si
	pop cx
	pop dx
endm


tostr MACRO num
	push ax
	push bx
	push dx
	push si
	mov ax, num
	mov bl, 10
	xor dx, dx
	xor si, si
	
	convert_loop:
		div bx
		push dx
		inc si
		xor dx, dx
		cmp ax, 0
		jne convert_loop
	
	print_loop:
		cmp si, 0
		je finish
		pop dx
		add dl, '0'
		mov ah, 02h
		int 21h
		dec si
		jmp print_loop
		
	finish:
		pop si
		pop dx
		pop bx
		pop ax
endm

start:
       set_segment ds, dseg
       	
       toInt string, 5
       mov ax, 12345
       tostr ax

       
       mov     ax, 4C00h
       int     21h

cseg    ends


        ; data
dseg    segment byte

       string db '12345'
       msg_error db 'String containts non-digit symbols', 0Dh, 0Ah, '$'

dseg    ends


        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start
