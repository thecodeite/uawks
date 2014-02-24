

;; {Apple Fn Key}-{Arrow Keys} --> {Home, End, PgUp, PgDn}
$*Left::FnKey("{Left}", "{Home}")
$*Right::FnKey("{Right}", "{End}")
$*Up::FnKey("{Up}", "{PgUp}")
$*Down::FnKey("{Down}", "{PgDn}")

;; {Control}-{Backquote} --> {Control}-{Shift}-{Tab}
^`::
	SetKeyDelay, -1
	if (RemapControlBackquote) {
		Send, ^+{Tab}
	} else {
		Send, ^`
	}
	Return

