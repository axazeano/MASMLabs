.286
.model LARGE, C

; Template for DOS .exe file


        assume  cs:CSEG, ds:DSEG, ss:SSEG

	; this is header file of module_test4
	include module_test4.inc



        ; code
CSEG    SEGMENT





start:
        ; ... put your code here ...

	
	invoke WAIT_ANY_KEY
	
        ; exit to DOS
        mov     ax, 4C00h
        int     21h

CSEG    ENDS


        ; data
DSEG    SEGMENT byte

        string db "Hello!$",0Dh,0Ah

DSEG    ENDS


        ; stack
SSEG    SEGMENT stack

        db      100h    dup(?)

SSEG    ENDS
END start
