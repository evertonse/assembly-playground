#!/usr/bin/python3
import os
os.system("as main.s -o main.o && gcc -omain main.o -nostdlib -static")
os.system("gcc test.c -S")