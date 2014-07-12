#include <GUIConstantsEx.au3>

AutoItSetOption("WinTitleMatchMode", -2)
HotKeySet("!{SPACE}", "ShowUp")

;;; BEGIN GUI
Global $gui = GUICreate("", 300, 30)
Global $edit = GUICtrlCreateInput("", 0, 0, 300, 30)
GUICtrlSetBkColor($edit, 0)
GUICtrlSetColor($edit, 0xFFFFFF)
GUICtrlSetFont($edit, 15)
WinSetOnTop($gui, "", 1)

;;; BEGIN OVERLAY
; Styles: Basic: WS_POPUP (0x80000000), Extended: WS_EX_NOACTIVATE 0x08000000,
; $WS_EX_TOOLWINDOW (0x80) + $WS_EX_TOPMOST (0x8)? + $WS_EX_TRANSPARENT (click-through)
Global $hGUI = GUICreate("", @DesktopWidth, @DesktopHeight, 0, 0, 0x80000000, 0x08000080 + 0x20)
WinSetTrans($hGUI, "", 110)
GUISetBkColor(0x141414)
WinSetOnTop($hGUI, "", 1)

While 1
    Sleep(500)
WEnd

Func ShowUp()
   Global $s = ""
   GUICtrlSetData($edit, "")
   
   WinSetState($hGUI, "", @SW_SHOWNOACTIVATE)
   WinSetState($gui, "", @SW_SHOWNOACTIVATE)
   WinActivate($gui)
   
   HotKeySet("{ENTER}", "enterWhilePopup")
   WinWaitNotActive($gui, "") 
   HotKeySet("{ENTER}")
   
   if WinGetState($gui) <> @SW_HIDE Then
	  WinSetState($gui, "", @SW_HIDE)
   EndIf
   WinSetState($hGUI, "", @SW_HIDE)
   
   If @error = 0 And $s <> "" Then
	  If WinExists($s) Then
		 WinActivate($s)
	  EndIf
   EndIf
EndFunc

Func enterWhilePopup()
   Global $s = GUICtrlRead($edit)
   WinSetState($gui, "", @SW_HIDE)
EndFunc