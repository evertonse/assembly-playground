	.file	"evertonsantos_202100011379_projeto.c"
	.text
	.globl	bubble_sort
	.type	bubble_sort, @function
bubble_sort:
.LFB6:
	.cfi_startproc
	xorl	%edx, %edx
	decl	%esi
.L2:
	cmpl	%edx, %esi
	jle	.L8
	movl	%esi, %r9d
	xorl	%eax, %eax
	subl	%edx, %r9d
.L5:
	cmpl	%eax, %r9d
	jle	.L9
	movl	(%rdi,%rax,4), %ecx
	movl	4(%rdi,%rax,4), %r8d
	cmpl	%r8d, %ecx
	jle	.L3
	movl	%r8d, (%rdi,%rax,4)
	movl	%ecx, 4(%rdi,%rax,4)
.L3:
	incq	%rax
	jmp	.L5
.L9:
	incl	%edx
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
	.string	"%d"
.LC4:
	.string	"Sorted numbers:\n"
.LC5:
	.string	"%d "
	.text
	.globl	go_sort
	.type	go_sort, @function
go_sort:
.LFB8:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	xorl	%edx, %edx
	leaq	.LC0(%rip), %rsi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movq	input(%rip), %rdi
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movl	%edx, 4(%rsp)
	leaq	4(%rsp), %rdx
	call	__isoc99_fscanf@PLT
	decl	%eax
	je	.L11
.L14:
	leaq	.LC1(%rip), %rdi
	jmp	.L21
.L11:
	movslq	4(%rsp), %rdi
	salq	$2, %rdi
	call	malloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L12
	movq	%rax, %r12
	xorl	%ebp, %ebp
	leaq	.LC3(%rip), %r13
	jmp	.L13
.L12:
	leaq	.LC2(%rip), %rdi
.L21:
	call	puts@PLT
	movl	$1, %edi
	call	exit@PLT
.L15:
	movq	input(%rip), %rdi
	movq	%r12, %rdx
	xorl	%eax, %eax
	movq	%r13, %rsi
	addq	$4, %r12
	call	__isoc99_fscanf@PLT
	decl	%eax
	jne	.L14
	incl	%ebp
.L13:
	movl	4(%rsp), %esi
	cmpl	%ebp, %esi
	jg	.L15
	movq	%rbx, %rdi
	xorl	%ebp, %ebp
	leaq	.LC5(%rip), %r12
	call	bubble_sort
	movq	output(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	fputs@PLT
.L16:
	cmpl	%ebp, 4(%rsp)
	jle	.L22
	movl	(%rbx,%rbp,4), %edx
	movq	output(%rip), %rdi
	movq	%r12, %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
	movl	(%rbx,%rbp,4), %esi
	movq	%r12, %rdi
	xorl	%eax, %eax
	incq	%rbp
	call	printf@PLT
	jmp	.L16
.L22:
	movl	$10, %edi
	call	putchar@PLT
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	je	.L18
	call	__stack_chk_fail@PLT
.L18:
	addq	$24, %rsp
	.cfi_def_cfa_offset 40
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.cfi_endproc
.LFE8:
	.size	go_sort, .-go_sort
	.section	.rodata.str1.1
.LC6:
	.string	"r"
.LC7:
	.string	"Failed to open the input %s\n"
.LC8:
	.string	"w"
.LC9:
	.string	"Failed to open the output %s.\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rsi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	cmpq	$0, input(%rip)
	jne	.L24
	movq	8(%rsi), %rdi
	leaq	.LC6(%rip), %rsi
	call	fopen@PLT
	movq	8(%rbx), %rsi
	leaq	.LC7(%rip), %rdi
	movq	%rax, input(%rip)
	xorl	%eax, %eax
	jmp	.L34
.L24:
	movq	16(%rsi), %rdi
	leaq	.LC8(%rip), %rsi
	call	fopen@PLT
	movq	%rax, output(%rip)
	testq	%rax, %rax
	jne	.L26
	movq	16(%rbx), %rsi
	leaq	.LC9(%rip), %rdi
.L34:
	call	printf@PLT
	jmp	.L25
.L26:
	xorl	%esi, %esi
	movq	input(%rip), %rdi
	xorl	%eax, %eax
	leaq	4(%rsp), %rdx
	movl	%esi, 4(%rsp)
	leaq	.LC0(%rip), %rsi
	xorl	%ebx, %ebx
	call	__isoc99_fscanf@PLT
	decl	%eax
	je	.L27
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	jmp	.L25
.L27:
	movslq	4(%rsp), %rax
	cmpq	%rax, %rbx
	jnb	.L35
	xorl	%eax, %eax
	incq	%rbx
	call	go_sort
	jmp	.L27
.L35:
	movq	input(%rip), %rdi
	call	fclose@PLT
	movq	output(%rip), %rdi
	call	fclose@PLT
.L25:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	je	.L29
	call	__stack_chk_fail@PLT
.L29:
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	movl	$1, %eax
	popq	%rbx
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
