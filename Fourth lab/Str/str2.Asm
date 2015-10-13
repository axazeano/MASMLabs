; Template for DOS .exe file


        assume  cs:cseg, ds:dseg, ss:sseg

        ; code
cseg    segment

;StringReplace PROC far original_string:WORD, substring:WORD, index:WORD
;
;	mov di, original_string+index
;	mov si, substring
;	mov cx, 4
;	rep movsb
;	
;	ret
;StringReplace endp 

start:
        mov ax, dseg
        mov ds, ax
        
;       mov si, 9
;	mov di,18

	mov di, offset original_str
	mov si, offset rep_str
	mov cx, 3
	replace_loop:
		lodsb
		mov dl, al
		mov ah, 02h
		int 21h
		stosb
	loop replace_loop
	
	
       mov dx, offset original_str
       mov ah, 09h
       int 21h 
       
        ;nvoke StringReplace WORD PTR [original_str], WORD PTR [substring], 4
	mov ah, 01h
	int 21h
        ; exit to DOS
        mov     ax, 4C00h
        int     21h

cseg    ends


        ; data
dseg    segment byte

        original_str db "Hello world!$",0Dh,0Ah
        rep_str db "test"

dseg    ends


        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start
