# Resources
- https://www.youtube.com/watch?v=6S5KRJv-7RU
- https://man7.org/linux/man-pages/man2/syscalls.2.html // syscalls
- list of syscalls https://x86.syscall.sh/

# Tips
- To use `gdb` first we compile with `gcc`using `-g` flag 
- Then run `gdb ./executable` then `(gdb) lay next` tap enter two times to see the src code and assembly 
- `(gdb) break <symbol>` to add a break point to a symbol
- `(gdb) run` continues
- `(gdb) nexti` step one assembly instruction further  
- `(gdb) next` step one line in C further  
- `(gdb) info registers` see the state of all the registers
- `(gdb) info registers <reg>` see the state of one register
- `(gdb) print struct_name.member` print variable in a struct
- `(gdb) print array_name[index]` print array at
- `(gdb) print array_name[start:end]` print array slice print start to end
- `(gdb) p $eax` print register
