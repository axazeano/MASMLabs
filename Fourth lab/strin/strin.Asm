; Template for DOS .exe file
.286
.model LARGE, C


        assume  cs:cseg, ds:dseg, ss:sseg

        ; code
cseg    segment

Print PROC string:WORD
	; Print string to console
	push ax
	push dx
	
	mov dx, string
	mov ah, 09h
	int 21h
	
	pop dx
	pop ax
	ret
Print endp 

ReadStr PROC far string:WORD
	; Read str into buffer
	push ax
	
	mov dx, string
	mov ah, 0Ah
	int 21h
	
	pop ax
	ret

ReadStr endp

ReplaceStr PROC far main_string:WORD, substring:WORD, substing_len:WORD, position:WORD
	; Procedure for replace substring in string
	push di
	push si
	push cx
	
	mov di, main_string
	add di, position
	mov si, substring
	mov cx, 4
	rep movsb 
	
	pop cx
	pop si
	pop di
	ret

ReplaceStr endp

start:
        mov ax, dseg
        mov ds, ax
        mov es, ax
        
        ; Enter string
        mov dx, offset original_str
        mov bx, offset rep_str
        
        invoke ReplaceStr,dx,bx,4,3
	
	mov dx, offset original_str
	invoke Print,dx
	
	mov ah, 01h
	int 21h
        ; exit to DOS
        mov     ax, 4C00h
        int     21h

cseg    ends


        ; data
dseg    segment byte
        original_str db "Hello world!$",0Dh,0Ah, '$'
        rep_str db "test"

dseg    ends


        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start