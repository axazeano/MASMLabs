;=========----Array sort----=======
;	si is first level counter 
;	di is second level counter
;	ah is min element
;	bx is index of min element
;	ch is used in swap 


        assume  cs:cseg, ds:dseg, ss:sseg

        ; code
cseg    segment
start:
        mov ax, dseg
        mov ds, ax
       
    	; set first level counter = 0
    	xor si, si
    	
    	; set second level counter = 0
    	xor di, di
    	
    	; set ah = 0
    	xor ah, ah
    	
sort:
	; Set ah= array+si as min element
	; si is incremented each time
	mov ah, [array+si]
	    	
min:
	; Compare test value with array+di
	; di is incremented each time
	cmp ah, [array+di]
	
	; If array isn't less than al we go to not_min label
	jb not_min
	
	; Else, we set al = array+di
	mov ah, [array+di]
	
	; Setin ah index of min element
	mov bx, di
	
	; Icrement di
	inc di
	
	; If di != lenght then we continue!
	cmp di, [len]
	jb min
	
; Or, if array+di is more than al
not_min:
	; Of corse, we increment di
	inc di
	
	; And we check that di != lenght 
	cmp di, [len]
	jb min
	
	; Swap varibles
	mov ch, [array+si]
	mov byte ptr [array+si], ah
	mov byte ptr [array+bx], ch
	
	
	inc si
	mov di, si
	
	cmp si, [len]
	jb sort
	
	
	; Print array into console
	; set si = 0
	xor si, si
print:
	mov dl, [array+si]
	add dl, '0'
	mov ah, 02h
	int 21h
	inc si
	cmp si, [len]
	jne print

        ; exit to DOS
        mov     ax, 4C00h
        int     21h

cseg    ends


        ; data
dseg    segment byte

	; Array for sort
        array db 7, 8, 4, 6, 8, 2, 6, 4, 3, 9
	; Length of array        
        len word $-array

dseg    ends


        ; stack
sseg    segment stack

        db      100h    dup(?)

sseg    ends
end start
