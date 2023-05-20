# Resources
- https://www.youtube.com/watch?v=6S5KRJv-7RU
- https://man7.org/linux/man-pages/man2/syscalls.2.html // syscalls
- list of syscalls https://x86.syscall.sh/
- kernel in rust - https://www.youtube.com/watch?v=yq-msJOQ4nU
- voxel experiments https://www.youtube.com/watch?v=apXAoyKkjDs
- networking in c but i'll try in assembly https://youtu.be/dpXKe-dw0uk
- c std lib but better https://youtu.be/3IAlJSIjvH0
- x86 crash course https://youtu.be/75gBFiFtAb8
- gdb tutorial https://youtu.be/svG6OPyKsrw
- gdb 15 min change your life https://youtu.be/PorfLSr3DDI
- gdb the finish https://youtu.be/Dq8l1_-QgAc
- func in assembly https://www.youtube.com/watch?v=H9RlaFqMb9k&t=50s
- elf format https://www.youtube.com/watch?v=nC1U1LJQL8o
- static vs dynamic link https://www.youtube.com/watch?v=UdMRcJwvWIY&t=24s
- oracle syntax https://docs.oracle.com/cd/E53394_01/html/E54851/ennab.html#scrolltoc
.comm name, size,alignment

    The .comm directive allocates storage in the data section. The storage is referenced by the identifier name. Size is measured in bytes and must be a positive integer. Name cannot be predefined. Alignment is optional. If alignment is specified, the address of name is aligned to a multiple of alignment.

- ml64.exe BNF https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-bnf-grammar?view=msvc-170
- le syscall blog post https://blog.packagecloud.io/the-definitive-guide-to-linux-system-calls/


# Tips
- To use `gdb` first we compile with `gcc`using `-g` flag 
- Then run `gdb ./executable` then `(gdb) lay next` tap enter two times to see the src code and assembly 
 - ``gdb -tui -iex "set disassembly-flavor intel"``
- `(gdb) break <symbol>` to add a break point to a symbol
- `(gdb) run` continues
- `(gdb) nexti` step one assembly instruction further  
- `(gdb) next` step one line in C further  
- `(gdb) step` step into a func or next line
- `(gdb) info locals` local vars
- `(gdb) info registers` see the state of all the registers
- `(gdb) info registers <reg>` see the state of one register
- `(gdb) print struct_name.member` print variable in a struct
- `(gdb) print array_name[index]` print array at
- `(gdb) print array_name[start:end]` print array slice print start to end
- `(gdb) p $eax` print register
- ``(gdb) backtrace`` #0  main () at test.c:4
- ``(gdb) x/i $reg`` examine the instruct at reg
- ``(gdb) x/4g 0x5ffe90 ``
    0x5ffe90:       0x0000000200000001      0x0000000400000003
    0x5ffea0:       0x0000000000bf2470      0x00007ff653ee12ee
- ``(gdb) ref`` refresh layout
- ``(gdb) finish`` finish func call and stop
- ``(gdb) bt`` back trace
- ``(gdb) watch x`` make gdb tell you when something changes in x var
- ``(gdb) list 2`` see line 2
- ``(gdb) info breakpoints | ib`` see all breakpoints 
- ``(gdb) delete id`` delete id of a info thingy
- ``(gdb) whatis j |what j`` print typeof j
- ``(gdb) target record-full`` record everything thi points onward
- ``(gdb) ``

# Setup
- sudo apt install gcc-aarch64-linux-gnu gcc-arm-linux-gnueabi gcc-powerpc-linux-gnu 

# Cmds
- ``gcc -c -g``, -c to make obj file, -g to insert debug info
- ``objdump -M intel -d <file>`` display info about a .o or .exe whatever, using intel syntax
- ``as main.s -o main.o -P`` assemble, -P run the preprocessor
- `` gcc -omain main.o -nostdlib -static`` compile with _start, instead of main

# Todo
- Create a memory section that +w +r +x and write some machine code there, something that can be verified, run, th
- Use xmm0 with normal operation 
- Use SIMD things

# Directives:

Language: 
2.3 Assembler Directives

Directives are commands that are part of the assembler syntax but are not related to the x86 processor instruction set. All assembler directives begin with a period (.) (ASCII 0x2E).

.align integer, pad

    The .align directive causes the next data generated to be aligned modulo integer bytes. Integer must be a positive integer expression and must be a power of 2. If specified, pad is an integer byte value used for padding. The default value of pad for the text section is 0x90 (nop); for other sections, the default value of pad is zero (0).
.ascii "string"

    The .ascii directive places the characters in string into the object module at the current location but does not terminate the string with a null byte (\0). String must be enclosed in double quotes (") (ASCII 0x22). The .ascii directive is not valid for the .bss section.
.bcd integer

    The .bcd directive generates a packed decimal (80-bit) value into the current section. The .bcd directive is not valid for the .bss section.
.bss

    The .bss directive changes the current section to .bss.
.bss symbol, integer

    Define symbol in the .bss section and add integer bytes to the value of the location counter for .bss. When issued with arguments, the .bss directive does not change the current section to .bss. Integer must be positive.
.byte byte1,byte2,...,byteN

    The .byte directive generates initialized bytes into the current section. The .byte directive is not valid for the .bss section. Each byte must be an 8-bit value.
.2byte expression1, expression2, ..., expressionN

    Refer to the description of the .value directive.
.4byte expression1, expression2, ..., expressionN

    Refer to the description of the .long directive.
.8byte expression1, expression2, ..., expressionN

    Refer to the description of the .quad directive.

.globl symbol1, symbol2, ..., symbolN

    The .globl directive declares each symbol in the list to be global. Each symbol is either defined externally or defined in the input file and accessible in other files. Default bindings for the symbol are overridden. A global symbol definition in one file satisfies an undefined reference to the same global symbol in another file. Multiple definitions of a defined global symbol are not allowed. If a defined global symbol has more than one definition, an error occurs. The .globl directive only declares the symbol to be global in scope, it does not define the symbol.
- lê instruction set https://docs.oracle.com/cd/E53394_01/html/E54851/ennbz.html#scrolltoc