; -------------------------------------------------------------------------
; Hello World Windows, from :https://www.youtube.com/watch?v=b0zxIfJJLAY
; -------------------------------------------------------------------------
.386 ; Full 80386 instruction set

; All 32-bit and later apps are flat, idk what that means. Apparently used to include "tiny"?
; Is something related fo 16-bit segmented memory model
.model flat, stdcall 
option casemap:none ; insesitive do case except identifier

; Include files - header and libs for calling sys32 dlls : user32, kernel32, gdi32
include \masm32\include\windows.inc ; akin to #include "window.h"
include \masm32\include\user32.inc  ; Windows, Control
include \masm32\include\kernel32.inc ; Handles, Modules, Paths
include \masm32\include\gdi32.inc ; Drawing into Device Context
; Libs

includelib \masm32\include\user32.lib   ; kernel32.dll
includelib \masm32\include\kernel32.lib ; user32.dll
includelib \masm32\include\gdi32.lib    ; gdi32.dll

WinMain proto :dword, :dword, :dword, :dword

; Constants
width   equ 800
height equ 600

.data
win_class db "Win Name",0
win_name db "Tiny App",0

.data? ; Uninitialized Data
instance HINSTANCE ? ; process id of the app
cmd      LPSTR ? ; Pointer to cmdline text

; -------------------------------------------------------------------------
.code
; -------------------------------------------------------------------------
; To call a Function in the Kernel, simply push the arguments from right to left
MainEntry:
    push NULL ; Get the instance handle, NULL is ourselves
    call GetModuleHandle 
    mov instance, eax

    call GetCommandLine
    mov cmd, eax

    ;; Call WinMain and then Exit
    push SW_SHOWDEFAULT
    lea eax, cmd
    push eax
    push NULL
    push instance
    call WinMain
    push eax 
    call ExitProcess

;
; WinMain
;
WinMain proc inst:HINSTANCE, prev_inst: HINSTANCE, cmd_line: LPSTR, cmdshow:dword
    
    local wc:WNDCLASSEX
    local msg:MSG
    local hwnd:HWND
    mov wc.cbSize, sizeof WNDCLASSEX
    mov wc.style, CS_HREDRAW or CS_VREDRAW
    mov wc.lpfnWndProc, offset WndProc
    mov wc.cbClsExtra, 0
    mov wc.cbWndExtra, 0
    mov eax, inst
    mov wc.hInstance, eax
    mov wc.hbrBackground, COLOR_3DSHADOW + 1
    mov wc.lpszMenuName, NULL
    mov wc.lpszClassName, offset ClassName

    push IDI_APPLICATION
    push NULL
    call LoadIcon
    mov wc.hIcon, eax
    mov wc.hIconSm, eax

    push IDC_ARROW
    push NULL
    call LoadCursor
    mov wc.hCursor, eax

    lea eax, wc
    push eax
    call RegisterClassEx

    push NULL
    push inst
    push NULL
    push NULL
    push height
    push width
    push CW_USEDEFAULT
    push CW_USEDEFAULT
    push WS_OVERLAPPEDWINDOW + WS_VISIBLE
    push offset win_name
    push offset win_class
    push 0
    call CreateWindowExA
    cmp eax, NULL
    je WinMainRet
    mov hwnd, eax

    push eax
    call UpdateWindow

message_loop:
    push 0
    push 0
    push NULL
    lea eax, msg
    push eax
    call GetMessage

    cmp eax, 0
    je DoneMessages

    lea eax, msg
    push eax
    call TranslateMessage

    lea eax, msg
    push eax
    call DispatchMessage

