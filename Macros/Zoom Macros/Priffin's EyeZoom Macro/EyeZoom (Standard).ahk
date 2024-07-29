#SingleInstance force
#MaxHotkeysPerInterval 600
SetKeyDelay, 0
SetWinDelay, 0

; Zoom Settings

global hotkey := "z" ; https://www.autohotkey.com/docs/v1/Hotkeys.htm

global zoom := "Thin"

/*
"Default" - 3600 tall, best for normal measuring without boat ~ 0.004 standard deviation
"BoatEye" - 16384 tall ~ 0.0007 standard deviation with boat eye
"Thin" ~ Same as above but smaller width for less GPU usage, recommended if using an OBS Projector
Custom ~ format WxH e.g. "320x8192"
*/

; Projector Settings
global useProjector := True ; Ignore other settings if set to false
global projectorName := "Windowed Projector (Scene) - projector for eye measurements"
global projectorWidth := 750 ; (-1 = default)

; Sensitivity Settings
global zoomSensitivity := 1 ; Change windows sens to this value when zooming in. Set to 0 to disable.

; Window Settings (-1 = default)
global zoomXPos := -1 
global zoomYPos := -1
global projectorXPos := -1
global projectorYPos := -1

; Do Not Edit


global zoomWidth := 0
global zoomHeight := 0

if (zoom=="Default") {
    zoomWidth := A_ScreenWidth
    zoomHeight := 3600
}
else if (zoom=="BoatEye") {
    zoomWidth := A_ScreenWidth
    zoomHeight := 16384
}

else if (zoom=="Thin") {
    zoomWidth := 384
    zoomHeight := 16384
}

else if (InStr(zoom, "x")) {
    zoom := StrSplit(zoom, "x")
    zoomWidth := zoom[1]
    zoomHeight := zoom[2]
}

else {
    MsgBox, Invalid zoom setting
    ExitApp
}

global projectorWidth := (projectorWidth == -1) ? Floor((A_ScreenWidth - zoomWidth) / 2) : projectorWidth
global projectorHeight := A_ScreenHeight / (A_ScreenWidth / projectorWidth)

global zoomXPos := (zoomXPos == -1) ? Floor((A_ScreenWidth - zoomWidth) / 2) : zoomXPos
global zoomYPos := (zoomYPos == -1) ? Floor((A_ScreenHeight - zoomHeight) / 2) : zoomYPos
global projectorXPos := (projectorXPos == -1) ? 0 : projectorXPos
global projectorYPos := (projectorYPos == -1) ? ((A_ScreenHeight - projectorHeight) / 2) : projectorYPos


global ix := 0
global iy := 0
global iw := 0
global ih := 0


global initialStyle := 0
global initialExStyle := 0

global initialSens := 0
DllCall("SystemParametersInfo", "UInt", 0x70, "UInt", 0, "UIntP", initialSens, "UInt", 0)

checkProjector() {
    if (WinExist(projectorName) == "0x0")
        Msgbox, Windowed Projector not found, check projectorName is set correctly
    WinGet, state, MinMax, %projectorName%
    if (state==-1)
        WinRestore, %projectorName%
    WinSet, Style, -0xC40000, %projectorName%
    WinSet, AlwaysOnTop, On, %projectorName%

}

getActiveHwnd() {
    WinGet, hwnd, ID, A
    WinGet, name, ProcessName, % "ahk_id " hwnd
    if (name == "javaw.exe" || name == "java.exe")
        return hwnd
    else
        return False
}

Zoom() {
    WinGetPos,x,y,w,h,A
    if (h != zoomHeight){
        ix := x
        iy := y
        iw := w
        ih := h
        WinGet, initialStyle, Style, A
        WinGet, initialExStyle, ExStyle, A
        WinSet, Style, -0xC40000, A
        activeWindow := getActiveHwnd()
        DllCall("SetWindowPos", "Ptr", activeWindow, "UInt", 0, "Int", zoomXPos, "Int", zoomYPos, "Int", zoomWidth, "Int", zoomHeight, "UInt", 0x0400)
        if (useProjector) {
            checkProjector() 
            DllCall("SetWindowPos", "Ptr", WinExist(projectorName), "UInt", 0, "Int", projectorXPos, "Int", projectorYPos, "Int", projectorWidth, "Int", projectorHeight, "UInt", 0x0400)
        }
	
	if (zoomSensitivity != 0)
            DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, zoomSensitivity, UInt, 0)	
    }
    else {
        WinSet, Style, %initialStyle%, A
        WinSet, ExStyle, %initialExStyle%, A
        activeWindow := getActiveHwnd()
        DllCall("SetWindowPos", "Ptr", activeWindow, "UInt", 0, "Int", ix, "Int", iy, "Int", iw, "Int", ih, "UInt", 0x0400)
        if (useProjector)
            DllCall("SetWindowPos", "Ptr", WinExist(projectorName), "UInt", 0, "Int", 0, "Int", -A_ScreenHeight, "Int", 1, "Int", 1, "UInt", 0x0400)
        DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, initialSens, UInt, 0)   	
    }
    return
}

ResetWindowPosition() {
    WinGetPos,x,y,w,h,A
    activeWindow := getActiveHwnd()
    x := 0, y := 0
    DllCall("SetWindowPos", "Ptr", activeWindow, "UInt", 0, "Int", x, "Int", y, "Int", w, "Int", h, "UInt", 0x0400)
}

if (zoomXPos + zoomWidth > projectorXPos and zoomXPos < projectorXPos + projectorWidth and useProjector)
    MsgBox, The projector and game window overlap, either reduce zoomWidth or projectorWidth and then reload
if (useProjector) {
    if (WinExist(projectorName) = "0x0") 
        MsgBox, Windowed Projector not found. Check if projectorName is set correctly.
    else 
        DllCall("SetWindowPos", "Ptr", WinExist(projectorName), "UInt", 0, "Int", 0, "Int", -A_ScreenHeight, "Int", 1, "Int", 1, "UInt", 0x0400)
}
#If WinActive("Minecraft") && (WinActive("ahk_exe javaw.exe") || WinActive("ahk_exe java.exe"))
    Hotkey, %hotkey%, Zoom
    ; Hotkey, !%hotkey%, ResetWindowPosition ; Remove semi colon to add reset window position hotkey (alt + zoom hotkey), in case the window gets stuck off screen.
