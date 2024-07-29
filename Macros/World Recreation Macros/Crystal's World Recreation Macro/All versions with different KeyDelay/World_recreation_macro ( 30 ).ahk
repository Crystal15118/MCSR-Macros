#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Event
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#If (WinActive("ahk_exe javaw.exe") || WinActive("ahk_exe java.exe"))

SetKeyDelay 30

u::start()

start() {
    Send {Tab}
    Send {Enter}
    Send {Tab 6}
    Send {Enter}
    Send {Tab 3}
    Send {Enter}
    Send {Tab 6}
    Send {Enter}
}