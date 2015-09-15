; ▄▄▄· ▄▄▄  ▄▄▄   ▄▄▄·  ▄· ▄▌    .▄▄ ·       ▄▄▄  ▄▄▄▄▄
;▐█ ▀█ ▀▄ █·▀▄ █·▐█ ▀█ ▐█▪██▌    ▐█ ▀. ▪     ▀▄ █·•██  
;▄█▀▀█ ▐▀▀▄ ▐▀▀▄ ▄█▀▀█ ▐█▌▐█▪    ▄▀▀▀█▄ ▄█▀▄ ▐▀▀▄  ▐█.▪
;▐█ ▪▐▌▐█•█▌▐█•█▌▐█ ▪▐▌ ▐█▀·.    ▐█▄▪▐█▐█▌.▐▌▐█•█▌ ▐█▌·
; ▀  ▀ .▀  ▀.▀  ▀ ▀  ▀   ▀ •      ▀▀▀▀  ▀█▄▀▪.▀  ▀ ▀▀▀ 


assume cs:cseg, ds:dseg, ss:sseg

; Code segment
cseg segment

; Entry point
start:
	mov axm dseg
	mov ds, ax

; Function for init array
mov ecx, 5
init:
	mov array[ecx], ecx
	mov dx, array[ecx]
	jmp PrintText
	dec ecx
	test ecx, ecx
	jnz init

arrayInit PROC array:

	
PrintText:
	mov ah, 09h
	int 21h

; Function for 



	; End of programm
	mov ax, 4C00h
	int 21h

; End of code segment
cseg ends


; Data segment
dseg segment byte

	; Create array with 5 zero cells
	array db 5 dup (0)

; End of data segment
dseg ends


; Stack segment
sseg segment

; End of stack segment
sseg ends

end start

