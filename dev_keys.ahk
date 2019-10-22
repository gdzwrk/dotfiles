#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
#SingleInstance FORCE
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, RegEx
;SetTitleMatchMode, 2

global groupNum := 1

;;;;; {{{1 Hotstrings
:*o:@@nf::{{}noformat{}}
:*o:@@jira::jira/browse/
:*o:@@link::[desc|http]
:*o:@@thu::{RAW}!file|thumbnail!

:*o:@@up::%USERPROFILE%

;;;;; Old ant/svn commands that should burn in the fiery pits of hello world.
::@@wfo.cd::ant -buildfile c:\dev\wfoserver\trunk\javaprojects\wfoadapter\ant\build.xml clean-wfoadapter dist-wfoadapter;Get-Date
::@@wfo.d::ant -buildfile c:\dev\wfoserver\trunk\javaprojects\wfoadapter\ant\build.xml dist-wfoadapter;Get-Date
::@@wfo.nd::ant  .uildfile c:\dev\wfoserver\trunk\javaprojects\wfoadapter\ant\build.xml dist-wfoadapter -Dnodeps=1;Get-Date
::@@wfo.deps::ant -buildfile c:\dev\wfoserver\trunk\javaprojects\wfoadapter\ant\build.xml clean-dependencies dependencies-all;Get-Date
::@@svn::svn update c:\dev\qm\trunk;svn update c:\dev\wfoserver\trunk;Get-Date

;;;;; IdeaVIM stuff
:*o:@@sv::source ~/.ideavimrc{enter}

;;;;; }}}1

;;;;; {{{1 Remap CapsLock
!CapsLock::            ; Alt+CapsLock
^CapsLock::            ; Ctrl+CapsLock
+CapsLock::            ; Shift+CapsLock
#CapsLock::            ; Win+CapsLock
^!CapsLock::           ; Ctrl+Alt+CapsLock
^!#CapsLock::          ; Ctrl+Alt+Win+CapsLock
SetCapsLockState, Off
return

;CRUISE CONTROL FOR COOL - actually turn on capslock
#!CapsLock::            ; Shift+Alt+CapsLock
SetCapsLockState, % (t:=!t) ?  "On" :  "Off"
return

; If caps is pressed twice within 500ms then Alt-Tab
CapsLock::  
    SetCapsLockState, Off

    ;KeyWait, CapsLock, T1
    if (caps_other_key_pressed = 1) {
        caps_other_key_pressed := 0
        pressed_twice_flag := 1
        ;KeyWait, CapsLock
        return
    }

    if (pressed_twice_flag = 1) {
        pressed_twice_flag := 0
        caps_other_key_pressed := 0
        Send {Alt down}{Tab}{Alt up}
    } else {
        pressed_twice_flag := 1
        caps_other_key_pressed := 0
        KeyWait, CapsLock
        SetTimer, ResetPressedTwice, -500
    }

    SetCapsLockState, Off
return

ResetPressedTwice:
    caps_other_key_pressed := 0
    pressed_twice_flag := 0
    skip_bracket := 0
return

; Add ']' as a right-hand modifier key. Disable it on first press-
; send when released if no other key combo was used.
; skip_bracket stuff had to be added to prevent '}]' input  
; when shift and brace key were release in a specific timing.

]::
    skip_bracket := 0
return

} Up::
    skip_bracket := 1
    SendRaw }
return

] Up::
    if (!skip_bracket && caps_other_key_pressed = 0) {
        if (GetKeyState("Shift", "D")) {
            SendRaw }
        }  else {
            Send ]
        }
    }
    skip_bracket := 0
    caps_other_key_pressed = 0
    pressed_twice_flag := 0
return

;;;;; Caps + hjkl - VIM-all-the-things!!! {{{2
~CapsLock & h::
    if GetKeyState("Ctrl", "D") && GetKeyState("Shift", "D") {
        Send +^{Left}
    } else if GetKeyState("Ctrl", "D") {
        Send ^{Left}
    } else if GetKeyState("Shift", "D") {
        Send +{Left}
    } else if GetKeyState("Alt", "D") {
        Send !{Left}
    } else {
        Send {Left}
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & j::
    if GetKeyState("Ctrl", "D") && GetKeyState("Shift", "D") {
        Send +^{Down}
    } else if GetKeyState("Ctrl", "D") {
        Send ^{Down}
    } else if GetKeyState("Shift", "D") {
        Send {Shift down}{Down}{Shift up}
    } else if GetKeyState("Alt", "D") {
        Send !{Down}
    } else {
        Send {Down}
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & k::
    if GetKeyState("Ctrl", "D") && GetKeyState("Shift", "D") {
    Send +^{Up}
    } else if GetKeyState("Ctrl", "D") {
        Send ^{Up}
    } else if GetKeyState("Shift", "D") {
        Send {Shift down}{Up}{Shift up}
    } else if GetKeyState("Alt", "D") {
        Send !{Up}
    } else {
        Send {Up}
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & l::
    if GetKeyState("Ctrl", "D") && GetKeyState("Shift", "D") {
        Send +^{Right}
    } else if GetKeyState("Ctrl", "D") {
        Send ^{Right}
    } else if GetKeyState("Shift", "D") {
        Send +{Right}
    } else if GetKeyState("Alt", "D") {
        Send !{Right}
    } else {
        Send {Right}
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & Up::
~CapsLock & o::
~] & Up::
    if GetKeyState("Shift", "D") {
        Send +{PgUp}
    } else {
        Send {PgUp}
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & Down::
~CapsLock & p::
~] & Down::
    if GetKeyState("Shift", "D") {
        Send +{PgDn}
    } else {
        Send {PgDn}
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & Left::
~] & Left::
~CapsLock & u::
    if GetKeyState("Ctrl", "D") && GetKeyState("Shift", "D") {
        Send +^{Home}
    } else if GetKeyState("Ctrl", "D") {
        Send ^{Home}
    } else if GetKeyState("Shift", "D") {
        Send +{Home}
    } else if GetKeyState("Alt", "D") {
        Send !{Home}
    } else {
        Send {Home}
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & Right::
~] & Right::
~CapsLock & i::
    if GetKeyState("Ctrl", "D") && GetKeyState("Shift", "D") {
        Send +^{End}
    } else if GetKeyState("Ctrl", "D") {
        Send ^{End}
    } else if GetKeyState("Shift", "D") {
        Send +{End}
    } else if GetKeyState("Alt", "D") {
        Send !{End}
    } else {
        Send {End}
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & [::
] & [::
^[::
    Send {Esc}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & '::
    Send {AppsKey}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & `;::
    Send {Tab}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & /::
    Send +{Tab}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return
;;;;; }}}2

;;;;; {{{2 Switcheroo and window management stuff

~CapsLock & f::    ; Switcheroo
~] & f::
    SetCapsLockState, Off
    Send, {LAlt down}{Ctrl down}{Shift down}
    Send, {F9}
    Send, {Shift up}{Ctrl up}{LAlt up}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & z::    ; Close window
~CapsLock & Del::
~] & z::
~] & Del::
    SetCapsLockState, Off
    Send !{F4}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & PgUp::  ; Maximize window 
~CapsLock & x::    
~] & x::
~] & PgUp::
    SetCapsLockState, Off

    ; If in an intelliJ dialog, do not do anything (it crashes)
    WinGetClass, winClass, A
    If (winClass = "SunAwtDialog") {
        return
    }

    WinGet MX, MinMax, A
    If MX
        WinRestore A
    Else
        WinMaximize A
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & PgDn::  ; Minimize window 
~] & PgDn::  ; Minimize window 
    SetCapsLockState, Off
    If WinActive("ahk_exe notepad++.exe") {
        Send, !{Space}n
    } else {
        WinMinimize, A
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return


LShift & RWin::     ; Minimize to tray (4t minimizer)
    Send !+^{F8}
return

~CapsLock & 4::     ; Open 4t minimizer
    Send !+^{F4}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & ,::    ; Move window to prev display
~] & ,::
    SetCapsLockState, Off
    Send #+{Left}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return


~CapsLock & .::    ; Move window to next display
~] & .::
    SetCapsLockState, Off
    Send #+{Right}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & F9::   ; Move window to main monitor, center, 75%
    SetCapsLockState, Off
    WinGet, active_id, ID
    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
    WinMove, %active_title%, , 240, 135, 1440, 810
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

~CapsLock & F10::
    SetCapsLockState, Off
    WinGet, active_id, ID
    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
    WinMove, %active_title%, , 240, 135, 1440, 810
    WinGet MX, MinMax, A
    If MX
        WinRestore A
    Else
        WinMaximize A
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

; Maximize window across top two monitors
~CapsLock & F11::
    SetCapsLockState, Off

    ; If the window is already maximized, unmaximize it or the move/resize will not work

    WinGet, active_id, ID
    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y

    WinGet MX, MinMax, A
    If (active_width <= 3800) {
        if (MX) {
            WinRestore A
        }
        Sleep 100

        hold_width := active_width
        hold_height := active_height
        hold_x := active_x
        hold_y := active_y
        hold_mx := MX

        WinMove, %active_title%, , -914, -1081, 3856, 1088
    } else {
        ;WinMove, %active_title%, , , , 1920, 1080
        WinMove, %active_title%, , hold_x, hold_y, hold_width, hold_height
        if(hold_mx) {
            WinMaximize A
        }

        ;WinRestore A
    }
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

; Give info about current window size
~CapsLock & F12::
    SetCapsLockState, Off
    WinGet, active_id, ID
    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
    MsgBox,,, title:%active_title% w:%active_width% h:%active_height% x:%active_x% y:%active_y%, 3
    caps_other_key_pressed := 1
    if (active_width >= 3800)
    {
        ;MsgBox,,, Detected embiggenation, 1
    }
return

#IfWinActive ahk_class TscShellContainerClass
  !Capslock::           ; Alt+Caps Lock
    ; Need a short sleep here for focus to restore properly.
    Sleep 50
    WinMinimize A    ; need A to specify Active window
    ;MsgBox, Received Desktop minimize hotkey    ; uncomment for debugging
  return
#IfWinActive

; Hide window titlebar
~CapsLock & PrintScreen::
    SetCapsLockState, Off
    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
    WinSet, Style, -0xC00000, %active_title%
;    WinGet, active_id, ID
;    WinGet, active_style, Style
;    MsgBox,,, id:%active_id%   style:%active_style%, 1
;    if (active_style & 0xC00000)
;        WinSet, Style, -0xC00000,
;    else
;        WinSet, Style, +0xC00000
    caps_other_key_pressed := 1
return

; Show window titlebar
~CapsLock & ScrollLock::
    SetCapsLockState, Off
    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
    WinSet, Style, +0xC00000, %active_title%
    caps_other_key_pressed := 1
return

; Show/Hide the taskbar
~CapsLock & LWin::
    SetCapsLockState, Off
    VarSetCapacity(APPBARDATA, A_PtrSize=4 ? 36:48)
    NumPut(DllCall("Shell32\SHAppBarMessage", "UInt", 4 ; ABM_GETSTATE
                                           , "Ptr", &APPBARDATA
                                           , "Int")
  ? 2:1, APPBARDATA, A_PtrSize=4 ? 32:40) ; 2 - ABS_ALWAYSONTOP, 1 - ABS_AUTOHIDE
  , DllCall("Shell32\SHAppBarMessage", "UInt", 10 ; ABM_SETSTATE
                                    , "Ptr", &APPBARDATA)
    KeyWait, % A_ThisHotkey
    caps_other_key_pressed := 1
Return
;;;;; }}}2

;;;;; {{{2 Persistent Alt+Tab and navigation in switcher
~CapsLock & Space::  ; Open Alt+Tab persistently
~CapsLock & Backspace::
~] & Space::
    Send {Alt down}{Ctrl down}{Tab}{Alt up}{Ctrl up}
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
return

;;;;; Use VIM navigation in Alt+Tab window
#IfWinActive, ahk_class MultitaskingViewFrame
*h::Send {Blind}{Left}
*j::Send {Blind}{Down}
*k::Send {Blind}{Up}
*l::Send {Blind}{Right}
*e::Send {Blind}{Up}
*d::Send {Blind}{Down}
*s::Send {Blind}{Left}
*f::Send {Blind}{Right}
*q::Send ^w
*[::Send {Esc}
*t::Send {Esc}
*Delete::Send ^w
*Backspace::Send {Space}
#IfWinActive

;;;;; Launch gVim on selected files in explorer
#IfWinActive, ahk_exe Explorer.EXE
~CapsLock & Enter::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0 
    OpenVim()
return
#Enter:: OpenVim("Admin")
#IfWinActive
;;;;; }}}2

;;;;; {{{2 Application-specific launcing/activation

;;;;; Cycle current window type
~CapsLock & t::
~] & t::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0

    if WinExist("Microsoft Teams") {
        WinActivate
    }
;    ; Get executable of current window
;    WinGet, curExe, ProcessName, A

;    if (lastExe != curExe) {
;        ; Create new auto-incrementing group name to separate groups each time this is invoked.
;        gdzCurrent = gdzCurrent%groupNum%
;        groupNum := groupNum + 1
;    }

;    ; Add all matching windows to this group
;    GroupAdd, %gdzCurrent%, ahk_exe %curExe%

;    ; Cycle through the windows
;    GroupActivate, %gdzCurrent%, r

;    ;Store exe for comparison next time
;    lastExe := curExe
return

;;;;; Terminals
~CapsLock & g::
~] & g::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0

    GroupAdd, gdzMintty, ahk_class mintty
    GroupAdd, gdzMintty, ahk_class ConsoleWindowClass
    GroupAdd, gdzMintty, ahk_class VirtualConsoleClass
    GroupAdd, gdzMintty, ahk_exe vcxsrv.exe
    GroupAdd, gdzMintty, ahk_exe WindowsTerminal.exe
    if WinActive("ahk_group gdzMintty") {
        GroupActivate, gdzMintty, r
    } else {
        WinActivate ahk_group gdzMintty
    }
return

;;;;; VIM
~CapsLock & v::
~] & v::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    ActivateVim()
return

ActivateVim() {
    class:="Vim"
    GroupAdd, gdzgVim, ahk_class %class%
    if WinActive("ahk_group gdzgVim")
    {
        GroupActivate, gdzgVim, r
    } else {
        WinActivate ahk_class %class%
    }
}

;;;;; Copy text into a new vim buffer
~CapsLock & Enter::
~] & Enter::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    class := "Vim"
    Send ^c
    ActivateVim()
    Send {Esc}{Esc}`;enew{Enter}
    Sleep 100
    Send {Esc}{Esc}PG{Esc}dd
return

;;;;; Copy text into existing vim buffer
~CapsLock & \::
~] & \::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    class := "Vim"
    Send ^c
    ActivateVim()
    Sleep 100
    Send Go{Esc}{Esc}p{Esc}G
return

;;;;; Explorer.exe
~CapsLock & e::
~] & e::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    class:="CabinetWClass"
    GroupAdd, gdzExplorer, ahk_class %class%
    if WinActive("ahk_group gdzExplorer") {
        GroupActivate, gdzExplorer, r
    } else {
        WinActivate ahk_class %class%
    }
return

;;;;; Web browser(s)
~CapsLock & r::
~] & r::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    GroupAdd, gdzBrowsers, ahk_class MozillaWindowClass
    GroupAdd, gdzBrowsers, ahk_exe chrome.exe
    if WinActive("ahk_group gdzBrowsers") {
        GroupActivate, gdzBrowsers, r
    } else {
        WinActivate ahk_group gdzBrowsers
    }
return

;;;;; Outlook
~CapsLock & a::
~] & a::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    progExe:="OUTLOOK.EXE"
    GroupAdd, gdzOutlook, ahk_exe %progExe%
    if WinActive("ahk_group gdzOutlook") {
        GroupActivate, gdzOutlook, r
    } else {
        WinActivate ahk_exe %progExe%
    }
return

;;;;; Slack
~CapsLock & s::
~] & s::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    if WinExist("Slack.*Calabrio") {
        WinActivate
    }
return

;;;;; IntelliJ
~CapsLock & d::
~] & d::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    GroupAdd, gdzIntellij, ahk_exe idea64.exe
    if WinActive("ahk_group gdzIntellij") {
        GroupActivate, gdzIntellij, r
    } else {
        WinActivate ahk_exe idea64.exe
    }
return

;;;;; SSMS
~CapsLock & c::
~] & c::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    GroupAdd, gdzVisStudio, ahk_exe devenv.exe
    if WinActive("ahk_group gdzVisStudio") {
        GroupActivate, gdzVisStudio, r
    } else {
        WinActivate ahk_exe devenv.exe
    }
return

;;;;; Notepad++
~CapsLock & n::
~] & n::
    caps_other_key_pressed := 1
    pressed_twice_flag := 0
    GroupAdd, gdzNpp, ahk_class Notepad++
    if WinActive("ahk_class Notepad++") {
        GroupActivate, gdzNpp, r
    } else {
        WinActivate ahk_exe notepad++.exe
    }
return
;;;;; }}}2

;;;;; }}}1

;;;;; {{{1 Kinesis configuration

;;;;; Remap  'international' key to escape
SC056::Send {Esc}

`::
return

` Up::
    if (copy_paste_key_pressed) {
        copy_paste_key_pressed := 0
        return
    } else {
        Send ``
    }
return

~` & x::
    copy_paste_key_pressed := 1
    Send ^x
return

~` & v::
    copy_paste_key_pressed := 1
    Send +{Ins}
return

~` & c::
    copy_paste_key_pressed := 1
    Send ^{Ins}
return
;;;;; }}}1

;;;;; {{{1 Routine non-secure uname/passwords
#`::
#=::
    Input keyPressed, L1 T2,, 1,2
    if (keyPressed = "``") {
        Send {Backspace}
        Input keyPressed, L1 T2,, 1,2
    }
    if (keyPressed = "``" || keyPressed = "=")
        MsgBox,,,
            (LTrim
                1 = Admin2193!
                2 = admin2193

                q = garrett.dezeeuw@calabrio.com
                w = admin@calabrio.com
                e = testthethings@calabrio.com
                                    x = WebEx login (Garrett DeZeeuw, garrett.dezeeuw@calabrio.com)
            )
            , 3
    else if (keyPressed = "1")
        Send, Admin2193{!}
    else if (keyPressed = "2")
        Send, admin2193
    else if (keyPressed = "q")
        Send, garrett.dezeeuw@calabrio.com
    else if (keyPressed = "w")
        Send, admin@calabrio.com
    else if (keyPressed = "e")
        Send, testthethings@calabrio.com
    else if (keyPressed = "x") {
        Send, Garrett DeZeeuw{tab}
        Sleep 100
        Send, garrett.dezeeuw@calabrio.com
    }
    else if (keyPressed = "z") {
        Send, garrett.dezeeuw@calabrio.com{tab}
        Sleep 100
        Send, Admin2193{!}{Enter}
    }
return
;;;;; }}}1

;;;;; {{{1 Miscellaneous

;;;;; Reload script on Win+Esc
#Esc::
#SC056::
    MsgBox ,,,Script Reloaded, 1
    Sleep 100
    Reload
return

;;;;; Remap Ctrl+W to close window in Outlook
#IfWinActive ahk_class rctrl_renwnd32
^w::Send !fc
#IfWinActive

;;;;; Fun sounds
!+^0::SoundPlay, C:\Windows\Media\Windows Ding.wav
;;;;; }}}1

; {{{1 OpenVim.ahk
;
; Author: Arthur Jaron
; EMail: hifreeo@gmail.com

; Overview:
; Explorer_GetSelection(): Helper function (found in the AHK-forums)
; OpenVim(): Core function
; Hotkeys:
;   Win+Enter: Open current file in gVim session "GVIM"
;   Win+Ctrl+Enter: Open current selected file in gVim session "ADMIN MODE" with
;       elevated rights. This wil let you write to protected files, e.g. inside
;       the Windows/ folder and top-level files (c:\example.txt).

Explorer_GetSelection(hwnd="") {
    ; Get the full filepath + name of the currently selected file inside
    ; the explorer window.
    hwnd := hwnd ? hwnd : WinExist("A")
    WinGetClass class, ahk_id %hwnd%
    if (class="CabinetWClass" or class="ExploreWClass" or class="Progman")
            for window in ComObjCreate("Shell.Application").Windows
                    if (window.hwnd==hwnd)
    sel := window.Document.SelectedItems
    ;echom sel
    for item in sel
        ToReturn .= item.path "`n"
    return Trim(ToReturn,"`n")
}

OpenVim(Admin="") {
    ; Open the currently selected file within explorer in gVim.
    ; Passing a non-empty string as a parameter will bring up the UAC-prompt
    ; to elevate the next gVim session. It doesn't elevate the current existing
    ; "GVIM" session, but opens a new one named "ADMIN MODE".
    path_name := % Explorer_GetSelection()
    if (Admin) {
        Run *RunAs C:\Program Files\Vim\vim81\gvim.exe --servername "ADMIN MODE" --remote-silent "%path_name%",,,OutputVarPID
    }
    else {
        Run, C:\Program Files\Vim\vim81\gvim.exe --servername "GVIM" --remote-silent "%path_name%",,,OutputVarPID
    }
    return
}
;;;;; }}}1


