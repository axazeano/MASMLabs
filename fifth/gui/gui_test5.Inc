include windows.inc
include user32.inc
include kernel32.inc
include comctl32.inc



includelib user32.lib
includelib kernel32.lib
includelib comctl32.lib

;Debug macros
include masm32.inc
;include debug.inc
includelib masm32.lib
;includelib debug.lib
;
DlgProc			PROTO :DWORD,:DWORD,:DWORD,:DWORD




.const

IDD_TABTEST		equ 1000
IDC_TAB1		equ 1001

IDD_TAB1		equ 2000

IDC_TAB1EDT1	equ	2001

IDC_TAB1EDT2	equ	2004

IDC_TAB1EDT3	equ	2005

IDC_TAB1EDT4	equ	2006

IDC_TAB1_BTN_1 equ 2003

IDD_TAB2		equ 3000

IDD_TAB3		equ 4000

   NULL        equ  0 
   MB_OK    equ  0 

.data

	struct1 struct 
		s_x	dq	1.0
		s_y	dq	2.0
	struct1 ends 

TabTitle1       db "Hello",0
TabTitle2       db "Tab2",0
TabTitle3       db "Tab3",0
text1	db	"12345fh5r6sdtyhjudrtujery6",0
buffer1	db	100h dup(0)
buffer2	db	100h dup(0)
to_xmm0	struct1	{1.1,2.2}
MsgBoxText     db "Hello, " 
MsgBoxCaption  db "Welcome!" 


.data?

settextex1	SETTEXTEX {ST_DEFAULT,1251}



hInstance		dd ?
hTab			dd ?
hEd1		dd ?
hTabDlg			dd 3 dup(?)
SelTab			dd ?
