	.file	"test.c"
	.text
	.globl	_start
	.def	_start;	.scl	2;	.type	32;	.endef
	.seh_proc	_start
_start:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	nop
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "char\0"
	.text
	.globl	another
	.def	another;	.scl	2;	.type	32;	.endef
	.seh_proc	another
another:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movabsq	$-3819410104729601330, %rax
	movq	%rax, -8(%rbp)
	movl	$-559038737, -12(%rbp)
	leaq	.LC0(%rip), %rax
	movq	%rax, -24(%rbp)
	movl	$1918986339, -28(%rbp)
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "hello, world\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	call	__main
	movl	$1, -16(%rbp)
	movl	$2, -12(%rbp)
	movl	$3, -8(%rbp)
	movl	$4, -4(%rbp)
	leaq	.LC1(%rip), %rax
	movq	%rax, %rcx
	call	puts
	call	another
	movl	$1, %eax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev11, Built by MSYS2 project) 12.2.0"
	.def	puts;	.scl	2;	.type	32;	.endef
