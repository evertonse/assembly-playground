;; compile: nasm -f elf32  file.asm -ofile.o
;; link: ld -m elf_i386 file.o -ofile
;; If you're gonna use gcc, it expects main: instead of _start: label
;; link-gcc: gcc -m32 -no-pie file.o -ofile
; nasm -f elf32  file.asm -ofile.o && ld -m elf_i386 file.o -ofile && ./file; echo $?
; withgcc: nasm -f elf32  file.asm -ofile.o && gcc -m32 -no-pie file.o -ofile && ./file; echo $?
;global _start
global main 

extern printf
section .data
    msg db "Hello, world",10,0x0
    len equ $ - msg
    format db "Formated string {%d}",10, 0  ; Format string for printing an integer

section .text
main:
    push 0
    push 0x48
    call fn_printf
    call fn_args
    call fn_push
    push ip_next
    jmp fn_ip
    ip_next:
    call fn_dynamic
    mov  [msg], byte 'f'
    call fn_write
    jmp  fn_loop

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80
    mov ebx, 0x69
add_again:
    add ebx, 1
    cmp ebx, 0x420
    jge done
    jmp add_again
done:
    mov eax, 1
    int 0x80

fn_write:
    mov eax, 4 ; syscall write 
    mov ebx, 1 ; stdout
    mov ecx, msg; le char pointer
    mov edx, len; le bytes
    int 0x80 ; syscall
    ret


fn_loop:
    mov ebx, 1
    mov ecx, 5
l1:
    sal ebx, 1 ; preverse the sign bit
    dec ecx ; ecx -= 1
    cmp ecx,0 ; 
    je l2
    jmp l1
l2:
    mov eax, 1
    int 0x80

fn_dynamic:
    mov [msg], byte 'f'
    mov [msg +1], byte 'u'
    mov [msg +2], byte 'c'
    mov [msg +3], byte 'k'
    ret

fn_ip:
    pop eax
    jmp eax

;; If your gonna use this you need to link with gcc -m32 to use printf
fn_printf:
    push ebp
    mov ebp, esp
    mov eax, [esp]  ; Dereference the stack pointer (ESP) and move the value into EAX

    ;; Print the value in EAX
    push eax  ; Push the value onto the stack
    push format  ; Push the format string onto the stack
    call printf  ; Call the printf function
    ;add esp, 8  ; Adjust the stack pointer to remove the arguments

    mov esp, ebp
    pop ebp
    ret

;; This part below is all about mimicking functions without using the 
;; mv bp,sp construct. It is harder, but the point is exercising the stack mentality
fn_push:
    ; We preserve the base pointer because if we don't, when we call another func 
    ; it'll alter the base pointer again, and when we return from func, out base pointer 
    ; is gonna be altered which is bad
    ; By pushing on ebp on the stack we preserve our base pointer, and every onther func can
    ; change ebp as much as they want because they'll have another function frame 
    ; This is what makes nested function calls possible
    ;;; Prolog Begin
    push ebp 
    mov ebp, esp ; save the base of the stack, creatign a frame
    sub esp, 4
    ;;; Prolog End

    mov [esp], byte 'H'
    mov [esp+1], byte 'e'
    mov [esp+2], byte 'y'
    mov [esp+3], byte 0
    push esp
    push 4
    call fn_print ; stack after this op is {old_esp, 4, next_ip}
    ;;; Epilog Begin
    mov esp,ebp
    pop ebp ; restore ebp
    ret
    ;;; Epilog End

fn_print: ; (string: b4, len: b4)
    pop eax ; next_ip
    pop ebx ; 0x4
    pop ecx ; char pointer; old_esp which is also the string "Hey\0"
    push eax ; put the next_ip back on the stack
    mov edx, ebx ; number of bytes on edx
    mov eax, 4 ; syscall write 
    mov ebx, 1 ; stdout
    int 0x80 ; syscall
    ret ; pop and jump whaterver addr was at the top at the stack 

fn_return_val:

;; Args args passed on the stack, worflow push 1,2,3,4 call fn
;; Caller passes the arguments in reversed order
;; Callee receives the args in normal order by poping
;; Example: func (a: int b: int) -> void
;;    Caller: push b; push a;
;;    Callee: pop a; pop b;
;; Is responsability of the caller to remove args from the stack
;; since it was the one that pushes it
fn_args:
    push ebp
    mov ebp, esp
    sub esp, 4
    ;; Args start in ebp+8, think about it:
    ;; ebp has previous_ebp ebp+4 has return addr
    ;; then anything earlier than that are the arguments 
    ;; so ebp+8 has the first 32bit value then ebp+12 has the next 32bit val
    ;; eb+16 the next 32bit val and so on
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    add eax, ebx 
    mov [esp], eax

    push esp
    push 4
    call fn_print

    mov esp, ebp
    pop ebp
    ret
