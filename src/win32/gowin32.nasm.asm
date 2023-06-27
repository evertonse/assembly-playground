; ----------------------------------------------------------------------------
; hello.asm
;
; This is a Win32 console program that writes "Hello, World" on one line and
; then exits.  It uses only plain Win32 system calls from kernel32.dll, so it
; is very instructive to study since it does not make use of a C library.
; Because system calls from kernel32.dll are used, you need to link with
; an import library.  You also have to specify the starting address yourself.
;
; Assembler: NASM
; Other libraries: Use gcc's import library libkernel32.a
; OS: Any Win32-based OS
; Assemble with "nasm -fwin32 gowin32.nasm.asm"
; Link with "ld -ego -ogo.exe gowin32.nasm.obj -lkernel32 -LC:/windows/system32 --enable-stdcall-fixup"
; ----------------------------------------------------------------------------

global  go
extern  _ExitProcess@4
extern  _GetStdHandle@4
extern  _WriteConsoleA@20

section .data
msg:     db      "Hello, World", 10
handle:  db      0
written: db      0

section .text

go:
  ; handle = GetStdHandle(-11)
  push    dword -11
  call    _GetStdHandle@4
  mov     [handle], eax

  ; WriteConsole(handle, &msg[0], 13, &written, 0)
  push    dword 0
  push    written
  push    dword 13
  push    msg
  push    dword [handle]
  call    _WriteConsoleA@20

  ; ExitProcess(0)
  push    dword 0
  call    _ExitProcess@4
