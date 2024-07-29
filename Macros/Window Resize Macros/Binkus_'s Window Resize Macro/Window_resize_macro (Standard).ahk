; Default window position, edit if necessary
global defaultX := 0
global defaultY := 0
global defaultWidth := A_ScreenWidth
global defaultHeight := A_ScreenHeight

; Function to resize the active window
Resize(newWidth, newHeight, newXpos := -1, newYpos := -1) {
    WinGet, hwnd, ID, A
    WinGet, processName, ProcessName, % "ahk_id " hwnd
    ; Only proceed if the process is javaw.exe or java.exe
    if (processName != "javaw.exe" && processName != "java.exe")
        return

    WinGetPos,,, currentWidth, currentHeight, ahk_id %hwnd%
    newX := (newXpos == -1) ? Floor((A_ScreenWidth - newWidth) / 2) : newXpos
    newY := (newYpos == -1) ? Floor((A_ScreenHeight - newHeight) / 2) : newYpos
    if (currentWidth != newWidth || currentHeight != newHeight) {
        DllCall("SetWindowPos", "Ptr", hwnd, "UInt", 0, "Int", newX, "Int", newY, "Int", newWidth, "Int", newHeight, "UInt", 0x0400)
    } else {
        DllCall("SetWindowPos", "Ptr", hwnd, "UInt", 0, "Int", defaultX, "Int", defaultY, "Int", defaultWidth, "Int", defaultHeight, "UInt", 0x0400)
    }
}

; Hotkeys to resize the Minecraft window
#If WinActive("Minecraft") && (WinActive("ahk_exe javaw.exe") || WinActive("ahk_exe java.exe"))
*Y::Resize(1920, 300, 0, 200)
*CapsLock::Resize(240, 700)