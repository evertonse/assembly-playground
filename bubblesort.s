.intel_syntax noprefix

.section .data
    aux: .8byte 0
    quantidadeElementos: .8byte 10
    vetor: .8byte 8,5,2,1,4,7,9,6,3,0

.section .rodata
    printarNaTela: .string "%ld "

.section .text
.global main

main:
    push rbp

    lea rbx, [rip+vetor]
bubblesort:
    mov r14, [rip+quantidadeElementos]
for_x_igual_vectormenosum_x_maiorque_0_xmenosmenos:
    sub r14, 1
    mov r15, 0
for_y_igual_0_y_menorque_x_ymaismais:
    mov rcx, [rbx+8*r15]
    cmp rcx, [rbx+8*r15+8]
    jle continua
    mov rcx, [rbx+8*r15]
    mov [rip+aux], rcx
    mov rcx, [rbx+8*r15+8]
    mov [rbx+8*r15], rcx
    mov rcx, [rip+aux]
    mov [rbx+8*r15+8], rcx
continua:
    add r15, 1
    cmp r15, r14
    jl for_y_igual_0_y_menorque_x_ymaismais
    cmp r14, 0
    jg for_x_igual_vectormenosum_x_maiorque_0_xmenosmenos

    mov r14, 0
for_z_igual_0_z_menorque_vector_zmaismais:
    cmp r14, [rip+quantidadeElementos]
    jge sair
    lea rdi, [rip+printarNaTela]
    mov rsi, [rbx+8*r14]
    xor rax, rax
    call printf

    add r14, 1
    jmp for_z_igual_0_z_menorque_vector_zmaismais

sair:
    pop rbp
