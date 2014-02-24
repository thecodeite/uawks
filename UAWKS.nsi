!include "MUI.nsh"

Name "Unofficial Apple Wireless Keyboard Support"
!define MUI_ICON "src\UAWKS.ico"
Icon "${MUI_ICON}"
OutFile "Install UAWKS ${VERSION_STR}.exe"
InstallDir "$PROGRAMFILES\Unofficial Apple Wireless Keyboard Support"
InstallDirRegKey HKCU "Software\Unofficial Apple Wireless Keyboard Support" ""
!define REG_UNINSTALL "Software\Microsoft\Windows\CurrentVersion\Uninstall\UAWKS"

!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_FINISHPAGE_NOAUTOCLOSE

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_CHECKED
!define MUI_FINISHPAGE_RUN_TEXT "Start program now"
!define MUI_FINISHPAGE_RUN_FUNCTION "StartProgram"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME $INSTDIR\Readme.txt

;!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "src\License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
 
;Languages
!insertmacro MUI_LANGUAGE "English"

;ShowInstDetails show

Section "!Install for All Users"
    SectionIn 1
    SetShellVarContext all
SectionEnd

Section "!Run at Windows Startup"
    SectionIn 1
	SetOutPath "$INSTDIR"
    CreateShortCut "$SMSTARTUP\Unofficial Apple Wireless Keyboard Support.lnk" "$INSTDIR\UAWKS.exe" "" "$INSTDIR\UAWKS.ico" 0
SectionEnd

Section "Program Files"
	SectionIn 1 RO
	SetOutPath "$INSTDIR"
	File "release\*.exe"
	File "release\*.txt"
	File "release\*.ini"
	File "release\*.ico"
	File "release\*.dll"
	WriteRegStr HKLM "${REG_UNINSTALL}" "DisplayName" "Unofficial Apple Wireless Keyboard Support"
	WriteRegStr HKLM "${REG_UNINSTALL}" "UninstallString" "$INSTDIR\Uninstall.exe"
	WriteRegDWORD HKLM "${REG_UNINSTALL}" "NoModify" 1
	WriteRegDWORD HKLM "${REG_UNINSTALL}" "NoRepair" 1

	WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd
 
Section "Uninstall"
	Delete "$SMSTARTUP\Unofficial Apple Wireless Keyboard Support.lnk"
	SetShellVarContext all
	Delete "$SMSTARTUP\Unofficial Apple Wireless Keyboard Support.lnk"
	RMDir /r "$INSTDIR"
	DeleteRegKey HKLM "${REG_UNINSTALL}"
SectionEnd
 
Function StartProgram
	ExecShell "" "$SMSTARTUP\Unofficial Apple Wireless Keyboard Support.lnk"
FunctionEnd

