; GoLink.exe  /console /entry main hello.obj kernel32.dll  
; ml64 -Fo file.o -c file.asm

public flags

.data
    str_flags db "ZF = 0 CF = 0 OF = 0"

    CF_SHIFT db 0 	
    CF_MASK  dw 0001h 	 	;Carry flag 	Status 	CY(Carry) 	NC(No Carry)
    PF_SHIFT db 2 	
    PF_MASK  dw 0004h 	 	;Parity flag 	Status 	PE(Parity Even) 	PO(Parity Odd)
    AF_SHIFT db 4 	
    AF_MASK  dw 0010h 	 	;Auxiliary Carry flag[4] 	Status 	AC(Auxiliary Carry) 	NA(No Auxiliary Carry)
    ZF_SHIFT db 6 	
    ZF_MASK  dw 0040h 	 	;Zero flag 	Status 	ZR(Zero) 	NZ(Not Zero)
    SF_SHIFT db 7 	
    SF_MASK  dw 0080h 	 	;Sign flag 	Status 	NG(Negative) 	PL(Positive)
    TF_SHIFT db 8 	
    TF_MASK  dw 0100h 	 	;Trap flag (single step) 	Control
    IF_SHIFT db 9 	
    IF_MASK  dw 0200h 	 	;Interrupt enable flag 	Control 	EI(Enable Interrupt) 	DI(Disable Interrupt)
    DF_SHIFT db 10 	
    DF_MASK  dw 0400h 	 	;Direction flag 	Control 	DN(Down) 	UP(Up)
    OF_SHIFT db 11 	
    OF_MASK  dw 0800h 	 	;Overflow flag 	Status 	OV(Overflow) 	NV(Not Overflow)
.code 
; int fn_flags();
;fn_flags proc
flags:
    push rbp
    mov  rbp, rsp 

    ;; Ensure ZF is set
    xor rax,rax

    ; Getting Zero Flag
    mov dil, ZF_SHIFT
    mov si, ZF_MASK
    call get_flag
    
    ; Setting Zero Flag
    mov rdi, rax
    mov rsi, 5
    call set_flag


    ;; Ensure CF is set
    mov rax, -1; 0xffffff...
    add rax, 1; overflow CF must be set to one

    ; Getting CF
    mov dil, CF_SHIFT
    mov si,  CF_MASK
    call get_flag
    
    ; Setting CF
    mov rdi, rax
    mov rsi, 12
    call set_flag

    ; Getting OF
    mov dil, OF_SHIFT
    mov si,  OF_MASK
    call get_flag
    
    ; Setting OF Overflow Flag
    mov rdi, rax
    mov rsi, 19
    call set_flag

    lea  rax, [str_flags] 

    mov  rsp, rbp
    pop  rbp
    ret

get_flag: ; (shift:rdi, mask:rsi) -> eax
    push rbp
    mov  rbp, rsp 

    pushf
    mov cl, dil
    pop rax
    and rax, rsi
    shr rax, cl

    mov  rsp, rbp
    pop  rbp
    ret

set_flag: ;(flag:rdi, str_offset:rsi) -> void
    push rbp
    mov  rbp, rsp 

    cmp rdi,1
    jne L0 
    mov byte ptr [str_flags+esi], 49 ; ascii for 1
L0:
    mov  rsp, rbp
    pop  rbp
    ret
    
end