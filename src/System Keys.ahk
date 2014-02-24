

;; {Left Control} --> {Windows Key}
$*LCtrl::PreferenceKeyDown("LCtrl", "RemapLeftControlToWindows", "Control Up}{LWin")
$*LCtrl Up::PreferenceKeyUp("LCtrl", "RemapLeftControlToWindows", "LWin")

;; {Apple Command Key} --> {Control}
$*LWin::PreferenceKeyDown("LWin", "RemapCommandToControl", "LCtrl")
$*LWin Up::PreferenceKeyUp("LWin", "RemapCommandToControl", "LCtrl")
$*RWin::PreferenceKeyDown("RWin", "RemapCommandToControl", "RCtrl")
$*RWin Up::PreferenceKeyUp("RWin", "RemapCommandToControl", "RCtrl")

;; {Right Alt} --> {Apple Fn Key}
$*RAlt::PreferenceKeyFnDown("RAlt", "RemapRightOptionToFn")
$*RAlt Up::PreferenceKeyFnUp("RAlt", "RemapRightOptionToFn")

;; {Apple Fn Key}-{Backspace} --> {Forward Delete}
$*Backspace::FnKey("{Backspace}", "{Delete}")

;; {Apple Fn Key}-{F3} --> {Print Screen}
$F3::FnKey("{F3 Down}", "", false)
$F3 Up::FnKey("{F3 Up}", "{PrintScreen}", false)

;; {Control}-{Alt}-{Backspace} --> Ctrl-Alt-Delete
#!Backspace::
^!Backspace::Run taskmgr.exe

;; {Capslock} --> {Control}
$*CapsLock::
	SetKeyDelay, -1
	if (RemapCapsLockToControl) {
		Send, {Blind}{Control Down}
	} else {
		if (GetKeyState("CapsLock", "T")) {
			SetCapsLockState, Off
		} else {
			SetCapsLockState, On
		}
		KeyWait, CapsLock
	}
	Return

$*CapsLock Up::
	SetKeyDelay, -1
	if (RemapCapsLockToControl) {
		Send, {Blind}{Control Up}
	}
	Return

