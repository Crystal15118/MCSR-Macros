#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
f5::
    Sendinput, {Escape}
    Sleep, 50
    Sendinput, {Tab 8}
    Sleep, 50
    Sendinput, {Enter}
    Sleep, 500
    Sendinput, {Tab}
    Sleep, 50
    Sendinput, {Enter}
    Sleep, 50
    Sendinput, {Click Left}
    Sleep, 80
    Sendinput, {Tab 7}
    Sleep, 50
    SendInput, {Enter}
    Sleep, 50
    Sendinput, {Tab 7}
    Sleep, 50
    Sendinput, {Enter}
  
    
    
  