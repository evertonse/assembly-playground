
; nasm -f elf32 add43.asm -o add32.o
global add42
add42:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    add eax, 42
    mov esp, esp
    pop ebp
    ret