;-----------------------------------------------------------------------
;	First lab. Say hello!
;-----------------------------------------------------------------------
	assume	cs:cseg,ds:dseg,ss:sseg

cseg	segment 					; Code segment
start: 								; Entry point
	mov	ax, dseg 					; Move data segment to ax. We cant
				 					; directly move data into ds, so we use ax

	mov	ds, ax	 					; Next we move data from ax to ds

	mov	dx, offset msg 				; Add to dx pointer on our msg variable

	mov	ah, 09h 					; Set function 09h into ah
									; AH = 09h - WRITE STRING TO STANDARD OUTPUT

	int	21h							; Call 21h interruption
									; 21h  - Main DOS API

	mov ah, 01h						; Set funtion 1h into ah
									; AH = 01h - READ CHARACTER FROM STANDARD INPUT, WITH ECHO
									; In this case it works like 'Press any button to close app'

	int 21h							; Call 21h interruption againg

	mov	ax, 4C00h					; Set funtion 4Ch into ah
									; AH = 4Ch - "EXIT" - TERMINATE WITH RETURN CODE

	int	21h							; Call 21h interruption againg

cseg	ends						; End of code segment


dseg	segment	byte 				; Data segment

msg	db	'Hello, x64!',0Dh,0Ah,'$' 	; Create variable with type db and size = required size
								  	; for following string. $ is terminate symbol

dseg	ends						; End of data segment


sseg	segment	stack				; Stack segment

	db	100h dup(?)					; Create empty stack with 256 cells. Each cell = 4 byte.

sseg	ends						; End of stack segment

end	start							; End of start label
