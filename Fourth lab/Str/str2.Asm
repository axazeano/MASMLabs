; Template for DOS .exe file
.286
.model LARGE, C


        assume  cs:cseg, ds:dseg, ss:sseg

        ; code
cseg    segment

Print PROC string:WORD
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
	push ax
	
	mov dx, string
	mov ah, 0Ah
	int 21h
	
	pop ax
	ret

ReadStr endp

start:
        mov ax, dseg
        mov ds, ax
        mov es, ax
        
        ; Enter string
	
	mov dx, offset enter_str
	invoke Print,dx
	mov dx, offset rep_str
	invoke ReadStr,dx
	mov di, offset original_str+2
	mov si, offset rep_str
	mov cx, offset rep_str+1
	rep movsb 
	
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
	
	 enter_str db "Enter string$", 0Ah, 0Dh 
        original_str db "Hello world!$",0Dh,0Ah
        rep_str db 100h dup("$")

dseg    ends


        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start