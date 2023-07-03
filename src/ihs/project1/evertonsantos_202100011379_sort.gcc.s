	.file	"evertonsantos_202100011379_sort.c"
	.intel_syntax noprefix
	.text
	.globl	bubble_sort
	.type	bubble_sort, @function
bubble_sort:
.LFB6:
	.cfi_startproc
	xor	edx, edx
	dec	esi
.L2:
	cmp	esi, edx
	jle	.L8
	mov	r9d, esi
	xor	eax, eax
	sub	r9d, edx
.L5:
	cmp	r9d, eax
	jle	.L9
	mov	ecx, DWORD PTR [rdi+rax*4]
	mov	r8d, DWORD PTR 4[rdi+rax*4]
	cmp	ecx, r8d
	jle	.L3
	mov	DWORD PTR [rdi+rax*4], r8d
	mov	DWORD PTR 4[rdi+rax*4], ecx
.L3:
	inc	rax
	jmp	.L5
.L9:
	inc	edx
	jmp	.L2
.L8:
	ret
	.cfi_endproc
.LFE6:
	.size	bubble_sort, .-bubble_sort
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
.LC1:
	.string	"Invalid input format."
.LC2:
	.string	"Memory allocation failed."
.LC3:
	.string	"################################"
.LC4:
	.string	"--------------INPUT---------------"
.LC5:
	.string	"[%d] "
.LC6:
	.string	"%d"
.LC7:
	.string	"%d "
.LC8:
	.string	"---------------OUTPUT---------------"
	.text
	.globl	go_sort
	.type	go_sort, @function
go_sort:
.LFB8:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xor	edx, edx
	lea	rsi, .LC0[rip]
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	ebp, edi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	mov	rdi, QWORD PTR input[rip]
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 8[rsp], rax
	xor	eax, eax
	mov	DWORD PTR 4[rsp], edx
	lea	rdx, 4[rsp]
	call	__isoc99_fscanf@PLT
	dec	eax
	je	.L11
.L14:
	lea	rdi, .LC1[rip]
	jmp	.L21
.L11:
	movsx	rdi, DWORD PTR 4[rsp]
	sal	rdi, 2
	call	malloc@PLT
	mov	rbx, rax
	test	rax, rax
	jne	.L12
	lea	rdi, .LC2[rip]
.L21:
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L12:
	lea	rdi, .LC3[rip]
	lea	r13, .LC5[rip]
	mov	r12, rbx
	xor	r14d, r14d
	call	puts@PLT
	lea	rdi, .LC4[rip]
	lea	r15, .LC6[rip]
	call	puts@PLT
	mov	esi, ebp
	mov	rdi, r13
	xor	eax, eax
	call	printf@PLT
.L13:
	cmp	DWORD PTR 4[rsp], r14d
	jle	.L22
	mov	rdi, QWORD PTR input[rip]
	xor	eax, eax
	mov	rdx, r12
	mov	rsi, r15
	call	__isoc99_fscanf@PLT
	dec	eax
	jne	.L14
	mov	esi, DWORD PTR [r12]
	lea	rdi, .LC7[rip]
	xor	eax, eax
	inc	r14d
	add	r12, 4
	call	printf@PLT
	jmp	.L13
.L22:
	mov	edi, 10
	lea	r12, .LC7[rip]
	call	putchar@PLT
	mov	esi, DWORD PTR 4[rsp]
	mov	rdi, rbx
	call	bubble_sort
	lea	rdi, .LC8[rip]
	call	puts@PLT
	mov	rdi, QWORD PTR output[rip]
	mov	edx, ebp
	xor	eax, eax
	mov	rsi, r13
	call	fprintf@PLT
	mov	esi, ebp
	mov	rdi, r13
	xor	eax, eax
	call	printf@PLT
	xor	ebp, ebp
.L16:
	mov	rdi, QWORD PTR output[rip]
	cmp	DWORD PTR 4[rsp], ebp
	jle	.L23
	mov	edx, DWORD PTR [rbx+rbp*4]
	mov	rsi, r12
	xor	eax, eax
	call	fprintf@PLT
	mov	esi, DWORD PTR [rbx+rbp*4]
	mov	rdi, r12
	xor	eax, eax
	inc	rbp
	call	printf@PLT
	jmp	.L16
.L23:
	mov	rsi, rdi
	mov	edi, 10
	call	fputc@PLT
	mov	edi, 10
	call	putchar@PLT
	mov	rax, QWORD PTR 8[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L18
	call	__stack_chk_fail@PLT
.L18:
	add	rsp, 24
	.cfi_def_cfa_offset 56
	mov	rdi, rbx
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.cfi_endproc
.LFE8:
	.size	go_sort, .-go_sort
	.section	.rodata.str1.1
.LC9:
	.string	"r"
.LC10:
	.string	"Failed to open the input %s\n"
.LC11:
	.string	"w"
.LC12:
	.string	"Failed to open the output %s.\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	rbx, rsi
	sub	rsp, 16
	.cfi_def_cfa_offset 32
	mov	rdi, QWORD PTR 8[rsi]
	lea	rsi, .LC9[rip]
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 8[rsp], rax
	xor	eax, eax
	call	fopen@PLT
	mov	QWORD PTR input[rip], rax
	test	rax, rax
	jne	.L25
	mov	rsi, QWORD PTR 8[rbx]
	lea	rdi, .LC10[rip]
	call	printf@PLT
	mov	eax, 24
	jmp	.L24
.L25:
	mov	rdi, QWORD PTR 16[rbx]
	lea	rsi, .LC11[rip]
	call	fopen@PLT
	mov	QWORD PTR output[rip], rax
	test	rax, rax
	jne	.L27
	mov	rsi, QWORD PTR 16[rbx]
	lea	rdi, .LC12[rip]
	call	printf@PLT
	mov	eax, 420
	jmp	.L24
.L27:
	xor	esi, esi
	mov	rdi, QWORD PTR input[rip]
	xor	eax, eax
	lea	rdx, 4[rsp]
	mov	DWORD PTR 4[rsp], esi
	lea	rsi, .LC0[rip]
	xor	ebx, ebx
	call	__isoc99_fscanf@PLT
	dec	eax
	je	.L28
	lea	rdi, .LC1[rip]
	call	puts@PLT
	mov	eax, 69
	jmp	.L24
.L28:
	movsx	rax, DWORD PTR 4[rsp]
	cmp	rbx, rax
	jnb	.L35
	mov	edi, ebx
	inc	rbx
	call	go_sort
	jmp	.L28
.L35:
	mov	rdi, QWORD PTR input[rip]
	call	fclose@PLT
	mov	rdi, QWORD PTR output[rip]
	call	fclose@PLT
	xor	eax, eax
.L24:
	mov	rdx, QWORD PTR 8[rsp]
	sub	rdx, QWORD PTR fs:40
	je	.L30
	call	__stack_chk_fail@PLT
.L30:
	add	rsp, 16
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.globl	output
	.bss
	.align 8
	.type	output, @object
	.size	output, 8
output:
	.zero	8
	.globl	input
	.align 8
	.type	input, @object
	.size	input, 8
input:
	.zero	8
	.globl	a
	.data
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.long	100
	.ident	"GCC: (GNU) 13.1.1 20230429"
	.section	.note.GNU-stack,"",@progbits
