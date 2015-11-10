.686 
.MMX 
.XMM 
.model flat,stdcall 
option casemap:none


        assume  cs:cseg, ds:dseg, ss:sseg

        ; code
cseg    segment
start:
       mov ax, dseg
       mov ds, ax 
	mov si, offset steps
	mov di, offset height
	xor bx, bx
	
	@@:
		movups xmm0, [si+bx]
		movups xmm1, [di+bx]
		mulps xmm0, xmm1
		addps xmm2, xmm0
		add bx, 16
		cmp bx, 2048
		jb @b

        ; exit to DOS
        mov     ax, 4C00h
        int     21h

cseg    ends


        ; data
dseg    segment byte

        Qadre STRUCT
        	first DWORD 0
        	second DWORD 0
        	third DWORD 0
        	fourth DWORD 0
        Qadre ends
        
        steps Qadre 100h dup(<>)
        height Qadre 100h dup(<>)

dseg    ends


        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start
