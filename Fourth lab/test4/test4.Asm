.286
.model LARGE, C

; Template for DOS .exe file


        assume  cs:CSEG, ds:DSEG, ss:SSEG

	; this is header file of module_test4
	include module_test4.inc



        ; code
CSEG    SEGMENT


start:
        mov ax, DSEG
        mov ds, ax
        mov es, ax
        
        mov ax, offset string
        invoke Print,ax
        
        mov dx, 5
        mov ax, WORD PTR [arr]
        invoke print_array, ax, 5

	
	invoke WAIT_ANY_KEY
	
        ; exit to DOS
        mov     ax, 4C00h
        int     21h

CSEG    ENDS


        ; data
DSEG    SEGMENT byte

        string db "Hello!",0Dh,0Ah, '$'
        arr db 1,2,3,4,5,6

DSEG    ENDS


        ; stack
SSEG    SEGMENT stack

        db      100h    dup(?)

SSEG    ENDS
END start
