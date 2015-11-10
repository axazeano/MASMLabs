.686
.MMX
.XMM
.model flat,stdcall
option casemap:none

include gui_test5.inc
	
	
	



.code

start:

	MOVUPS xmm0, to_xmm0
	
	

	invoke GetModuleHandle, NULL
	mov		hInstance, eax
	invoke InitCommonControls		
	invoke DialogBoxParam,hInstance,IDD_TABTEST,NULL,addr DlgProc,NULL
	invoke ExitProcess,eax 

Proc1 PROC far param1:WORD, param2:WORD
	LOCAL loc1:WORD


	ret
Proc1 ENDP


Tab1Proc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	
	.if uMsg==WM_INITDIALOG

	.elseif uMsg==WM_COMMAND
		.if wParam==IDC_TAB1_BTN_1
			invoke GetDlgItemText,hTabDlg,IDC_TAB1EDT1,addr buffer1, 100h
			mov esi, offset buffer1
			mov edi, offset MsgBoxText  + 7
			mov ecx, 5
			rep movsb
			INVOKE    MessageBoxA, NULL, ADDR MsgBoxText, ADDR MsgBoxCaption, MB_OK
		.endif
	.else		
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

Tab1Proc endp

Tab2Proc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	.if uMsg==WM_INITDIALOG
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

Tab2Proc endp

Tab3Proc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	.if uMsg==WM_INITDIALOG
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

Tab3Proc endp

DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	LOCAL	ts:TC_ITEM

	mov		eax,uMsg
	.if eax==WM_COMMAND
		mov		eax,wParam
		mov		edx,eax
		and		eax,0FFFFh
		shr		edx,16

		.if edx==BN_CLICKED
			.if eax==IDCANCEL
				invoke SendMessage,hWin,WM_CLOSE,0,0
			.elseif eax==IDOK
				invoke SendMessage,hWin,WM_CLOSE,0,0
			.endif
		.endif
	.elseif eax==WM_NOTIFY
		mov		eax,lParam
		mov		eax,[eax].NMHDR.code
		.if eax==TCN_SELCHANGE
			;Tab selection
			invoke SendMessage,hTab,TCM_GETCURSEL,0,0
			.if eax!=SelTab
				push	eax
				mov		eax,SelTab
				invoke ShowWindow,[hTabDlg+eax*4],SW_HIDE
				pop		eax
				mov		SelTab,eax
				invoke ShowWindow,[hTabDlg+eax*4],SW_SHOWDEFAULT
			.endif
		.endif
	.elseif eax==WM_INITDIALOG
		;Create the tabs
		
		invoke GetDlgItem,hWin,IDC_TAB1
		mov		hTab,eax
		mov		ts.imask,TCIF_TEXT
		mov		ts.lpReserved1,0
		mov		ts.lpReserved2,0
		mov		ts.iImage,-1
		mov		ts.lParam,0
		mov		ts.pszText,offset TabTitle1
		mov		ts.cchTextMax,sizeof TabTitle1
		invoke SendMessage,hTab,TCM_INSERTITEM,0,addr ts
		mov		ts.pszText,offset TabTitle2
		mov		ts.cchTextMax,sizeof TabTitle2
		invoke SendMessage,hTab,TCM_INSERTITEM,1,addr ts
		mov		ts.pszText,offset TabTitle3
		mov		ts.cchTextMax,sizeof TabTitle3
		invoke SendMessage,hTab,TCM_INSERTITEM,2,addr ts
		;Create the tab dialogs
		invoke CreateDialogParam,hInstance,IDD_TAB1,hTab,addr Tab1Proc,0
		mov hTabDlg,eax
		invoke CreateDialogParam,hInstance,IDD_TAB2,hTab,addr Tab2Proc,0
		mov hTabDlg[4],eax
		invoke CreateDialogParam,hInstance,IDD_TAB3,hTab,addr Tab3Proc,0
		mov hTabDlg[8],eax
	.elseif eax==WM_CLOSE
		invoke EndDialog,hWin,NULL
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

DlgProc endp

end start
