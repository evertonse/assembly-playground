#!/usr/bin/bash

nasm -f elf32  file.asm -ofile.o && ld -m elf_i386 file.o -ofile && ./file
echo $?
