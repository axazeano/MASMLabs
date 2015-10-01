; Template for DOS .exe file


        assume  cs:cseg, ds:dseg, ss:sseg

        ; code
cseg    segment

set_segment MACRO SegmentRegister, SegmentName
	push ax
	mov ax, SegmentName
	mov SegmentRegister, ax
	pop ax
endm

Print MACRO string
	push ax
	push dx
	mov dx, offset string
	mov ah, 09h
	int 21h
	pop dx
	pop ax
endm

WAIT_ANY_KEY MACRO
	push ax
	mov ah, 01h
	int 21h
	pop ax
endm


swap MACRO array, first, second
	push dx
	push cx
	
	
	mov dl, [array+first]
	mov cl, [array+second]
	
	mov byte ptr [array+first], cl
	mov byte ptr [array+second], dl
	
	pop cx
	pop dx
endm

min MACRO array, start_point, array_size
	; Return AX:DX
	; DX is min element
	; AX is index of min element
	
	push si

	xor dx, dx
	xor ax, ax
		
	mov si, start_point
	mov dl, [array+si]
	mov ax, si
	
	find:
		mov dh, [array+si]
		cmp dl, dh
		ja set
		je set
		
		cmp si, array_size
		je finish
		inc si
		jb find
		
		
		
	set:
		mov dl, dh
		xor dh, dh
		mov ax, si
	
		cmp si, array_size
		je finish
		inc si
		jmp find
	
	finish:
		pop si	
		endm
		
		


array_sort MACRO array, len
; Sort array wirh min and swap macroses
	; save si, dx, ax
	push si
	push dx
	push ax
	
	; set dx=0
	xor dx, dx
	; set si=0
	xor si, si
	sort_loop:
		xor di, di
		xor ax, ax
		; invoke min array
		min array, si, len
		; save min position in di
		mov di, ax
		; swap di and si element
		swap array, di, si
		; debug
		print_array array, 8
		; si+++
		inc si
		; Check that si <=len
		cmp si, len
		jb sort_loop
	
	pop ax
	pop dx
	pop si
endm

print_array MACRO array, len
	push si
	push dx
	push ax
	
	xor si, si
	
	print_loop:
		mov dl, [array+si]
		add dl, '0'
		mov ah, 02h
		int 21h
		inc si
		cmp si, len
		jb print_loop
		
	mov dl, 0Ah
	mov ah, 02h
	int 21h
	
	pop ax
	pop dx
	pop si
endm

start:
        
	set_segment ds, dseg
	
	array_sort array, 8
	
;	swap array, 0, 4
;	swap array, 1, 3
	
	;print_array array, 5
	
	WAIT_ANY_KEY
	

        ; exit to DOS
        mov     ax, 4C00h
        int     21h

cseg    ends


        ; data
dseg    segment byte

        hello db 'hello!', 0Dh, 0Ah, '$'
        ;array db 7,3,5,2,4
        array db 8,7,6,5,4,3,2,1
        len db $-array

dseg    ends


        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start
