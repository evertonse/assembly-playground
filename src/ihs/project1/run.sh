#!/bin/bash
gcc -Wall -O3 -g evertonsantos_202100011379_sort.c -o bin
gcc -Wall -Os -c evertonsantos_202100011379_sort.c -o bin.o
gcc -Wall -Os -S -masm=intel evertonsantos_202100011379_sort.c -o evertonsantos_202100011379_sort.gcc.s
./bin sort.input sort.gcc.output
# alias objump='objdump -M intel'
objdump -M intel -d bin > bin.dump
objdump -M intel -d bin.o > bin.o.dump
gcc -Wall -O3 evertonsantos_202100011379_sort.s -o work.bin
