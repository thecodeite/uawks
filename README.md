uawks
=====

Clone of http://code.google.com/p/uawks/

Overview
--------

Unofficial Apple Wireless Keyboard Support (UAWKS) is a small package that allows Windows users to make full use of Apple's uber-sexy bluetooth keyboard. Most importantly, it provides support for essential keys that don't work out of the box:

|Forward Delete|Fn + Delete|
|Home, End, Page Up and Down |	Fn + Arrow Keys|
|Media and volume control |	Fn + F7-F12|
|Print Screen |	Fn + F3|
|CTRL-ALT-DEL |	Control + Alt + Delete|
|Eject |	Eject|

Additional Features
-------------------

* __Translucent volume overlay.__ 
* __Use Command (Apple) keys as Control keys (optional).__ Use Command-C for copy, Command-V for paste, etc. Toggle in the UAWKS notification icon (tray icon) menu. 
* __Use media/volume keys without holding down Fn (optional).__ As in OS X, you can choose to have the media and volume controls take effect with or without holding Fn (either way, you can still use your F7-12 keys normally by doing the opposite). 
* __Use Control-` as Shift-Control-Tab (optional).__ Many tabbed applications on Windows use Control-Tab to cycle forward, and Shift-Control-Tab to cycle backwards. Shift-Control-Tab is really awkward on the AWK, so this rebinds it to Control-Backquote. 
* __Use Right Option key as an extra Fn key (optional).__ If you don't need two option keys, this makes it easier to hit forward delete, home, etc. 
* __Use left control as a Windows key (optional).__ This is helpful if you've rebound your command keys to act like control keys, as above. Please note that the Windows key is almost completely useless, and has been deprecated by a jury of your peers. 
* __Use caps lock as an extra control key (optional).__ Apparently, before computers were even invented, an Emacs user somewhere attained the ability to reason introspectively. He noticed that he wasn't using Caps Lock for anything except posting flames to Usenet. Okay, just kidding, but it does turn out that rebinding Caps Lock as another control key makes it that much more comfortable to hit C-u 3 C-x 5 2. 

Source
------

To run UAWKS from source, you'll need [AutoHotkey](http://www.autohotkey.com/). After it's installed, run UAWKS.ahk. If you want to add custom AHK bindings, User Keys.ahk exists solely for this purpose (it's just an empty file included at the end of UAWKS.ahk). See the [AHK Tutorial](http://www.autohotkey.com/docs/Tutorial.htm) to get started.

Acknowledgements
----------------

UAWKS is implemented with [AutoHotkey](http://www.autohotkey.com/). The code which interfaces with bluetooth HID devices was created by [Micha](http://www.autohotkey.net/~Micha/HIDsupport/Autohotkey.html). Code which adapts this for use with the Apple Wireless Keyboard was originally created by [Veil](http://www.autohotkey.com/forum/topic6367-75.html) (also see his post [here](http://yotz.eu/fnkey/) for more information about using Micha's DLL with bluetooth devices).

Enjoy! 
