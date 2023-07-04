.intel_syntax noprefix

.section	.rodata
LC0:
	.string	"%d "
	.text
	.globl	test
	.type	test, @function

test:
	push	rbp
	mov	rbp, rsp
#begin printf 
	mov	esi, 0xcafebad
	lea	rdi, [rip+LC0]
	xor eax, eax 
	call printf@PLT
#end printf 

	pop	rbp
	ret
	
.LFE6:
	.size	test, .-test
	.globl	main
	.type	main, @function
main:
.LFB7:
	
	push	rbp
	
	
	mov	rbp, rsp
	
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi
	mov	QWORD PTR -16[rbp], rsi
	call	test
	mov	eax, 0
	leave
	
	ret
	
.LFE7:
	.size	main, .-main
	.ident	"GCC: (GNU) 13.1.1 20230429"
	.section	.note.GNU-stack,"",@progbits
