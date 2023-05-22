; Recebe uma certa quantidade de notas decimais do usuário, interrompe a leitura quando lê
; -1 e printa a média decimal dessas notas
; rode com 
; nasm -f elf q1.asm && gcc -m32 -no-pie -o q1 q1.o

section .data
    mensagem_inicial db "Digite as notas. Quando finalizar, digite -1", 10, 0
    scanf_fmt        db "%f", 0
    printf_fmt       db "Média das notas: %.2f", 10, 0

section .bss
    nota_atual  resq 1
    quant_notas resq 1
    resultado   resq 1 

section .text
    global main
    extern printf
    extern scanf

main:
    push mensagem_inicial
    call printf
    mov ebx, 0                  ; usamos ebx para contar as notas.
                                ; Não podemos usar ecx/eax pq printf/scanf fazem overwrite nele
    fld dword [resultado]       ; resultado vai para st0
    add esp, 4                  ; limpa os argumentos da chamada de printf da pilha

le_notas:
    push nota_atual             ; lê a próxima nota
    push scanf_fmt
    call scanf
    fld dword [nota_atual]      ; nota vai pra st0 e resultado para st1
    fld1                        ; pusha 1 pra st0, o resto sobe
    fchs                        ; muda o sinal de st0 (-1)
    fucomip st0, st1            ; compara st0 (-1) com st1 (nota_atual) e dá pop em st0
    je media
    add ebx, 1
    faddp                       ; st0 = nota_atual (st0 antigo) + resultado (st1 antigo)
    add esp, 8
    jmp le_notas

media:
    fstp st0                   ; pop no st0 pra tirar o último -1
    cmp ebx, 0
    je final
    mov [quant_notas], ebx
    fild dword [quant_notas]   ; st1 contem as somas, st0 a quantidade de notas
    fdivp st1, st0             ; divide as somas pela quantidade de notas e faz o pop

printa:
    fstp qword [esp]           ; st0 é pushado pra pilha
    push printf_fmt
    call printf

final:
    mov eax, 1
    xor ebx, ebx
    int 0x80