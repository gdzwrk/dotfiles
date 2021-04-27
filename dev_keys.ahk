#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
#SingleInstance FORCE
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, RegEx

;;;;; Auto Exectuion - initialize variables here
other_key_pressed := 0

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

;;;;; {{{1 Remake CapsLock To Be Good
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

; If caps is depressed and released without firing a hotkey, send Esc
CapsLock::  
    SetCapsLockState, Off
    KeyWait, CapsLock
    if (other_key_pressed = 0) {
        Send {Esc}
    } else {
        other_key_pressed := 0
        if !WinActive("Slack.*Calabrio") {
            Send {Alt up}
        }
    }
    SetCapsLockState, Off
return

;Application-specific remapping
#IfWinActive ahk_exe EliteDangerous64.exe

CapsLock::
    Send {ScrollLock}
    SetCapsLockState, Off
return

CapsLock & q::q
CapsLock & e::e
CapsLock & r::r
CapsLock & t::t

CapsLock & w::Up
CapsLock & s::Down
CapsLock & a::Left
CapsLock & d::Right
CapsLock & f::F7
CapsLock & g::g

CapsLock & z::z
CapsLock & x::x
CapsLock & c::c
CapsLock & v::v
CapsLock & b::b
CapsLock & n::n
CapsLock & p::p
return
#IfWinActive

; Add ']' as a right-hand modifier key. Disable it on first press-
; send when released if no other key combo was used.
; skip_bracket stuff had to be added to prevent '}]' input  
; when shift and brace key were release in a specific timing.
]::
}::
    ;MsgBox,,, 'shift_state_on_depress is:' %shift_state_on_depress%, 0.5
    shift_state_on_depress := GetKeyState("Shift")
    if (shift_state_on_depress) {
        SendRaw }
        other_key_pressed := 0
        return
    }
    KeyWait, ]
    if (other_key_pressed = 0){
        SendRaw ]
    } else {
        other_key_pressed := 0
    }
return

; Supress the normal key release action
] Up::
} Up::
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
    other_key_pressed := 1
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
    other_key_pressed := 1
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
    other_key_pressed := 1
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
    other_key_pressed := 1
return

~CapsLock & Up::
~CapsLock & o::
~] & Up::
    if GetKeyState("Shift", "D") {
        Send +{PgUp}
    } else {
        Send {PgUp}
    }
    other_key_pressed := 1
return

~CapsLock & Down::
~CapsLock & p::
~] & Down::
    if GetKeyState("Shift", "D") {
        Send +{PgDn}
    } else {
        Send {PgDn}
    }
    other_key_pressed := 1
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
    other_key_pressed := 1
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
    other_key_pressed := 1
return

~CapsLock & [::
~] & [::
^[::
    Send {Esc}
    other_key_pressed := 1
return

~CapsLock & '::
    Send {AppsKey}
    other_key_pressed := 1
return

~CapsLock & `;::
    Send {Tab}
    other_key_pressed := 1
return

~CapsLock & /::
    Send +{Tab}
    other_key_pressed := 1
return
;;;;; }}}2

;;;;; {{{2 Switcheroo and window management stuff

;~CapsLock & q::    ; Switcheroo
;~] & q::
;    SetCapsLockState, Off
;    Send, {LAlt down}{Ctrl down}{Shift down}
;    Send, {F9}
;    Send, {Shift up}{Ctrl up}{LAlt up}
;    other_key_pressed := 1
;return

~CapsLock & F4::
~CapsLock & Del::
~] & Del::
    SetCapsLockState, Off
    Send !{F4}
    other_key_pressed := 1
return

~CapsLock & PgUp::  ; Maximize window 
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
    other_key_pressed := 1
return

~CapsLock & PgDn::  ; Minimize window 
~] & PgDn::  ; Minimize window 
    SetCapsLockState, Off
    If WinActive("ahk_exe notepad++.exe") {
        Send, !{Space}n
    } else {
        WinMinimize, A
    }
    other_key_pressed := 1
return


LShift & RWin::     ; Minimize to tray (4t minimizer)
LShift & LWin::     ; Minimize to tray (4t minimizer)
    Send !+^{Space}
return

~CapsLock & 4::     ; Open 4t minimizer
    Send !+^{F4}
    other_key_pressed := 1
return

~CapsLock & ,::    ; Move window to prev display
~] & ,::
    SetCapsLockState, Off
    Send #+{Left}
    other_key_pressed := 1
return


~CapsLock & .::    ; Move window to next display
~] & .::
    SetCapsLockState, Off
    Send #+{Right}
    other_key_pressed := 1
return

~CapsLock & F9::   ; Move window to main monitor, center, 75%
    SetCapsLockState, Off
    WinGet, active_id, ID
    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
    WinMove, %active_title%, , 240, 135, 1440, 810
    other_key_pressed := 1
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
    other_key_pressed := 1
return

; Give info about current window size
~CapsLock & F12::
    SetCapsLockState, Off
    WinGet, active_id, ID
    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
    MsgBox,,, title:%active_title% w:%active_width% h:%active_height% x:%active_x% y:%active_y%, 3
    other_key_pressed := 1
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

;; Hide window titlebar
;~CapsLock & PrintScreen::
;    SetCapsLockState, Off
;    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
;    WinSet, Style, -0xC00000, %active_title%
;;    WinGet, active_id, ID
;;    WinGet, active_style, Style
;;    MsgBox,,, id:%active_id%   style:%active_style%, 1
;;    if (active_style & 0xC00000)
;;        WinSet, Style, -0xC00000,
;;    else
;;        WinSet, Style, +0xC00000
;    other_key_pressed := 1
;return
;
;;; Show window titlebar
;~CapsLock & ScrollLock::
;    SetCapsLockState, Off
;    WinGetActiveStats, active_title, active_width, active_height, active_x, active_y
;    WinSet, Style, +0xC00000, %active_title%
;    other_key_pressed := 1
;return
;
;; Show/Hide the taskbar
;~CapsLock & LWin::
;    SetCapsLockState, Off
;    VarSetCapacity(APPBARDATA, A_PtrSize=4 ? 36:48)
;    NumPut(DllCall("Shell32\SHAppBarMessage", "UInt", 4 ; ABM_GETSTATE
;                                           , "Ptr", &APPBARDATA
;                                           , "Int")
;  ? 2:1, APPBARDATA, A_PtrSize=4 ? 32:40) ; 2 - ABS_ALWAYSONTOP, 1 - ABS_AUTOHIDE
;  , DllCall("Shell32\SHAppBarMessage", "UInt", 10 ; ABM_SETSTATE
;                                    , "Ptr", &APPBARDATA)
;    KeyWait, % A_ThisHotkey
;    other_key_pressed := 1
;Return
;;;;; }}}2

;;;;; {{{2 Persistent Alt+Tab and navigation in switcher
~CapsLock & Space::  ; Open Alt+Tab persistently
~] & Space::
~CapsLock & Backspace::
~] & Backspace::
    Send {Alt down}{Ctrl down}{Tab}{Alt up}{Ctrl up}
    other_key_pressed := 1
return

~CapsLock & f::
~] & f::
    ;Send {Alt down}{Tab}{Alt up}
    Send {Alt down}
    Send {Tab}
    other_key_pressed := 1
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
*m::Send ^w
*Delete::Send ^w
*Backspace::Send {Space}
#IfWinActive
;;;; ;}}}2

;;;;; {{{2 Application-specific launcing/activation

;;;;; MS Teams
~CapsLock & t::
~] & t::
    other_key_pressed := 1
    groupAdd, gdzTeams, ahk_exe Teams.exe

    if WinExist("ahk_group gdzTeams") {
        GroupActivate, gdzTeams, r
    } else {
        WinActivate ahk_group gdzTeams
    }
return

;;;;; Terminals
~CapsLock & g::
~] & g::
    other_key_pressed := 1

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
    other_key_pressed := 1
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

;;;;; Copy text into a new buffer, or open a file from explorer.exe
~CapsLock & Enter::
~] & Enter::
    other_key_pressed := 1
    
    if(WinActive("ahk_exe explorer.exe")) {
        OpenVim()
        ;MsgBox,,,Hello,3
    } else {
        class := "Vim"
        Send ^c
        ActivateVim()
        Send {Esc}{Esc}`;enew{Enter}
        Sleep 100
        Send {Esc}{Esc}PG{Esc}k
    }
return

;;;;; Copy text into existing vim buffer
~CapsLock & \::
~] & \::
    other_key_pressed := 1
    class := "Vim"
    Send ^c
    ActivateVim()
    Sleep 100
    Send Go{Esc}{Esc}PG{Esc}k
return

;;;;; Explorer.exe
~CapsLock & e::
~] & e::
    other_key_pressed := 1
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
    other_key_pressed := 1
    GroupAdd, gdzBrowsers, ahk_class MozillaWindowClass
    GroupAdd, gdzBrowsers, Google Chrome ahk_exe chrome.exe
    GroupAdd, gdzBrowsers, Microsoft Edge ahk_exe ApplicationFrameHost.exe
    if WinActive("ahk_group gdzBrowsers") {
        GroupActivate, gdzBrowsers, r
    } else {
        WinActivate ahk_group gdzBrowsers
    }
return

;;;;; Dev tools
~CapsLock & q::
~] & q::
    other_key_pressed := 1
    GroupAdd, gdzDevTools, DevTools ahk_exe chrome.exe
    GroupAdd, gdzDevTools, Postman ahk_exe Postman.exe
    if WinActive("ahk_group gdzDevTools") {
        GroupActivate, gdzDevTools, r
    } else {
        WinActivate ahk_group gdzDevTools
    }
return

;;;;; Outlook
~CapsLock & a::
~] & a::
    other_key_pressed := 1
    progExe:="OUTLOOK.EXE"
    GroupAdd, gdzOutlook, ahk_exe %progExe%
    GroupAdd, gdzOutlook, ".*Reminder(s)"
    if WinActive("ahk_group gdzOutlook") {
        GroupActivate, gdzOutlook, r
    } else {
        WinActivate ahk_exe %progExe%
    }
return

;;;;; Slack
~CapsLock & s::
~] & s::
    other_key_pressed := 1
    if WinExist("Slack.*Calabrio") {
        WinActivate
    }
return

#IfWinActive ahk_exe slack.exe
CapsLock & [::!Left
CapsLock & ]::!Right
#IfWinActive

;;;;; IntelliJ
~CapsLock & d::
~] & d::
    other_key_pressed := 1
    GroupAdd, gdzIntellij, ahk_exe idea64.exe
    if WinActive("ahk_group gdzIntellij") {
        GroupActivate, gdzIntellij, r
    } else {
        WinActivate ahk_exe idea64.exe
    }
return

;;;;; vscode & Vis Studio
~CapsLock & c::
~] & c::
    other_key_pressed := 1
    GroupAdd, gdzVS, .*- Microsoft Visual Studio
    GroupAdd, gdzVS, ahk_exe Code.exe
    if WinActive("ahk_group gdzVS") {
        GroupActivate, gdzVS, r
    } else {
        WinActivate ahk_group gdzVS
    }
;    WinGet, c, Count, ahk_group gdzVS
;    MsgBox, c(%c%)
return

;;;;; SSMS
~CapsLock & x::
~] & x::
    other_key_pressed := 1
    GroupAdd, gdzSQL, ahk_exe Ssms.exe
    if WinActive("ahk_group gdzSQL") {
        GroupActivate, gdzSQL, r
    } else {
        WinActivate ahk_group gdzSQL
    }
;    WinGet, c, Count, ahk_group gdzSQL
;    MsgBox, c(%c%)
return

;;;;; Notepad++
~CapsLock & n::
~] & n::
    other_key_pressed := 1
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
~::
return

` Up::
~ Up::
    if (copy_paste_key_pressed) {
        copy_paste_key_pressed := 0
        return
    } else {
        if (GetKeyState("Shift", "D")) {
            Send ~
        } else {
            Send ``
        }
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
F8::
F9::
    Send ^q
    Sleep 50
    Send ^+1
return
#IfWinActive

;;;;; Fun sounds
;!+^0::SoundPlay, C:\Windows\Media\Windows Ding.wav
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
    ;MsgBox ,,,path name: %path_name%, 3
    
    if (Admin) {
        Run *RunAs C:\Program Files\Vim\vim82\gvim.exe --servername "ADMIN MODE" --remote-silent "%path_name%",,,OutputVarPID
    }
    else {
        Run, C:\Program Files\Vim\vim82\gvim.exe --servername "GVIM" --remote-silent "%path_name%",,,OutputVarPID
    }
    return
}
;;;;; }}}1


