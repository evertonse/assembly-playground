#!/bin/bash
gcc -Wall -O3 -g evertonsantos_202100011379_sort.c -o c.bin
clang -S -Os -mllvm --x86-asm-syntax=intel evertonsantos_202100011379_sort.c -o evertonsantos_sort.clang.s
# [not valid]tcc -S -masm=intel evertonsantos_202100011379_sort.c -o evertonsantos_sort.tcc.s
gcc -Wall -Os -S -masm=intel evertonsantos_202100011379_sort.c -o evertonsantos_sort.gcc.s
./c.bin sort.input sort.gcc.output > /dev/null
# alias objump='objdump -M intel'
objdump -M intel -d bin > bin.dump
objdump -M intel -d bin.o > bin.o.dump
gcc -Wall -O3 -g evertonsantos_202100011379_sort.s -o work.bin && ./work.bin sort.input sort.output
