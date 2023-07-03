#!/bin/bash
gcc -Wall -O3 -g evertonsantos_202100011379_sort.c -o bin
gcc -Wall -Os -c evertonsantos_202100011379_sort.c -o bin.o
gcc -Wall -Os -S -masm=intel evertonsantos_202100011379_sort.c -o evertonsantos_202100011379_sort.s
./bin sort.input sort.output
objump='objdump -M intel'
objdump -d bin > bin.dump
objdump -d bin.o > bin.o.dump
gcc -Wall -O3 evertonsantos_202100011379_sort.work.s -o work.bin 
