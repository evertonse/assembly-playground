section .data
randomValue dd 0

section .text
global _start

_start:
    ; Generate random value
    rdrand eax

    ; Store the random value in memory
    mov [randomValue], eax

    ; Rest of the code...
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
