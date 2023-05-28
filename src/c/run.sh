#!/usr/bin/bash
#nasm -f elf32 add42.asm -o add42.o && gcc -m32 main.c add42.o -omain
gcc -m32 main.c -o main.s -g0 -Os -S -masm=intel -fno-asynchronous-unwind-tables -fno-exceptions
#objdump --no-show-raw-insn
nasm add42.asm -f elf32  -o add42.o
as main.s --32 -o main.o
gcc -m32 main.o add42.o -o main.exe
# -m is the architetures, -e is the starting point
# -lc is to link with c library
ld  main.o add42.o -o main.ld.exe -m elf_i386 -e main -lc

## -dC Undo manggling
objdump main.exe -dC --no-show-raw-insn
#readlef -a main.exe
./main.exe