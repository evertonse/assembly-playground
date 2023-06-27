; ----------------------------------------------------------------------------
; libc_link.nasm.asm
;
; Displays libc_link.nasm of 2 from 2^0 to 2^31, one per line, to standard output.
;
; Assembler: NASM
; OS: Any Win32-based OS
; Other libraries: Use gcc's C runtime library
; Assemble with "nasm -fwin32 libc_link.nasm.asm"
; MS Link: "link libc_link.nasm.obj libc.lib /subsystem:console"
; Link with "gcc libc_link.nasm.obj crt1.o -LD:\tools\MinGW\lib -LD:\tools\MinGW\lib -LD:\tools\MinGW\lib\gcc\mingw32\6.3.0" (C runtime library linked automatically)
; ----------------------------------------------------------------------------

        extern _printf
        global _main

        section .text
_main:
        push    esi                     ; callee-save registers
        push    edi

        mov     esi, 1                  ; current value
        mov     edi, 31                 ; counter
L1:
        push    esi                     ; push value to print
        push    format                  ; push address of format string
        call    _printf
        add     esp, 8                  ; pop off parameters passed to printf
        add     esi, esi                ; double value
        dec     edi                     ; keep counting
        jne     L1

        pop     edi
        pop     esi
        ret

format: db      '%d', 10, 0
