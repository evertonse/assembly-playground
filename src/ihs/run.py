#!/bin/python3
import os
run = os.system

file = "project"
run(f'clang -S -Xclang -ast-dump {file}.c')

run(f'clang -S -emit-llvm {file}.c')
run(f'llc -filetype=obj {file}.ll -o {file}.o')
