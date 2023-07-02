#!/bin/bash
gcc -Wall -g evertonsantos_202100011379_projeto.c -o bin
gcc -Wall -Os -S evertonsantos_202100011379_projeto.c -o evertonsantos_202100011379_projeto.s
./bin sort2.input sort.output
