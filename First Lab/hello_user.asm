;------------------------------------------------
;____________Hello, username_____________________
;------------------------------------------------
assume cs:cseg,ds:dseg,ss:sseg

; Start of code segment
cseg segment
start:
	mov ax, dseg
	mov ds, ax
	
	
	; Print 'hello'
	mov dx, offset hello
	mov ah, 09h
	int 21h
	
	; Set 256 into dx for init 0Ah
	mov dx, 100h
	; Call 0Ah
	mov ah, 0Ah
	int 21h
	
	; Print again
	mov ah, 09h
	int 21h
	
	; End of programm
	mov ax, 4C00h
	int 21h
cseg ends

; Data segment
dseg segment byte
	hello db 'Hello, $'
dseg ends

;Stack segment
sseg segment stack
	db 100h dup(?)
sseg ends

end start