; Have to use the microsoft linker
;nasm -f win64 HelloWindow.nasm.asm -o hello.nasm.o && dumpbin  /all hello.nasm.o > hello.nasm.bin.dis && dumppe /disam hello.nasm.o > hello.nasm.pe.dis
;ld -L C:\Windows\System32 -l kernel32 -ohello.nasm.exe hello.nasm.o
;link /subsystem:console /entry:start /defaultlib:kernel32 hello.nasm.o /out:hello.nasm.exe
;dumpbin /exports original.dll > exports.txt
;dumpbin /imports original.dll > exports.txt


NULL EQU 0
STD_OUT_HANDLE EQU -11

extern ExitProcess
extern GetStdHandle
extern WriteFile

import ExitProcess kernel32.dll ExitProcess 
import GetStdHandle kernel32.dll GetStdHandle 
import WriteFile kernel32.dll WriteFile 



global start 

section .data
    mensagem db "HELLO WORLD OS VILOES 2", 0x0A,0x0D,0
    tamanho_mensagem EQU $-mensagem

section .text

start:

    mov rcx, STD_OUT_HANDLE
    call GetStdHandle
    
    mov rcx,rax
    mov rdx,mensagem
    mov r8,tamanho_mensagem
    mov r9,0
    call WriteFile

    mov rax,NULL
    call ExitProcess
