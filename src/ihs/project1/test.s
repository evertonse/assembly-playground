	.text
	.intel_syntax noprefix
	.file	"test.c"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 48
	mov	rax, qword ptr fs:[40]
	mov	qword ptr [rbp - 8], rax
	mov	dword ptr [rbp - 16], 0
	mov	dword ptr [rbp - 20], edi
	mov	qword ptr [rbp - 32], rsi
	mov	rax, qword ptr [rbp - 32]
	mov	rdi, qword ptr [rax + 8]
	lea	rsi, [rip + .L.str]
	call	fopen@PLT
	mov	qword ptr [rip + input], rax
	cmp	qword ptr [rip + input], 0
	jne	.LBB0_2
# %bb.1:
	mov	rax, qword ptr [rbp - 32]
	mov	rsi, qword ptr [rax + 8]
	lea	rdi, [rip + .L.str.1]
	mov	al, 0
	call	printf@PLT
	mov	dword ptr [rbp - 16], 24
	jmp	.LBB0_11
.LBB0_2:
	mov	rax, qword ptr [rbp - 32]
	mov	rdi, qword ptr [rax + 16]
	lea	rsi, [rip + .L.str.2]
	call	fopen@PLT
	mov	qword ptr [rip + output], rax
	cmp	qword ptr [rip + output], 0
	jne	.LBB0_4
# %bb.3:
	mov	rax, qword ptr [rbp - 32]
	mov	rsi, qword ptr [rax + 16]
	lea	rdi, [rip + .L.str.3]
	mov	al, 0
	call	printf@PLT
	mov	dword ptr [rbp - 16], 420
	jmp	.LBB0_11
.LBB0_4:
	mov	dword ptr [rbp - 12], 0
	mov	rdi, qword ptr [rip + input]
	lea	rsi, [rip + .L.str.4]
	lea	rdx, [rbp - 12]
	mov	al, 0
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	je	.LBB0_6
# %bb.5:
	lea	rdi, [rip + .L.str.5]
	mov	al, 0
	call	printf@PLT
	mov	dword ptr [rbp - 16], 69
	jmp	.LBB0_11
.LBB0_6:
	mov	qword ptr [rbp - 40], 0
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 40]
	movsxd	rcx, dword ptr [rbp - 12]
	cmp	rax, rcx
	jae	.LBB0_10
# %bb.8:                                #   in Loop: Header=BB0_7 Depth=1
	mov	rax, qword ptr [rbp - 40]
	mov	edi, eax
	call	go_sort
# %bb.9:                                #   in Loop: Header=BB0_7 Depth=1
	mov	rax, qword ptr [rbp - 40]
	add	rax, 1
	mov	qword ptr [rbp - 40], rax
	jmp	.LBB0_7
.LBB0_10:
	mov	rdi, qword ptr [rip + input]
	call	fclose@PLT
	mov	rdi, qword ptr [rip + output]
	call	fclose@PLT
	mov	dword ptr [rbp - 16], 0
.LBB0_11:
	mov	eax, dword ptr [rbp - 16]
	mov	dword ptr [rbp - 44], eax       # 4-byte Spill
	mov	rax, qword ptr fs:[40]
	mov	rcx, qword ptr [rbp - 8]
	cmp	rax, rcx
	jne	.LBB0_13
# %bb.12:
	mov	eax, dword ptr [rbp - 44]       # 4-byte Reload
	add	rsp, 48
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.LBB0_13:
	.cfi_def_cfa rbp, 16
	call	__stack_chk_fail@PLT
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	go_sort                         # -- Begin function go_sort
	.p2align	4, 0x90
	.type	go_sort,@function
go_sort:                                # @go_sort

	.cfi_startproc
# %bb.0:

	push rbx
	push r12
	push r13
	push r14
	push r15
  push rbp
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 32
	mov	rax, qword ptr fs:[40]
	mov	qword ptr [rbp - 8], rax
	mov	dword ptr [rbp - 16], edi
	mov	dword ptr [rbp - 12], 0
	mov	rdi, qword ptr [rip + input]
	lea	rsi, [rip + .L.str.4]
	lea	rdx, [rbp - 12]
	mov	al, 0
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	je	.LBB1_2
# %bb.1:
	lea	rdi, [rip + .L.str.5]
	mov	al, 0
	call	printf@PLT
	mov	edi, 1
	call	exit@PLT
.LBB1_2:
	mov	rax, qword ptr fs:[40]
	mov	rcx, qword ptr [rbp - 8]
	cmp	rax, rcx
	jne	.LBB1_4
# %bb.3:
	add	rsp, 32
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.LBB1_4:
	.cfi_def_cfa rbp, 16
	call	__stack_chk_fail@PLT
.Lfunc_end1:
	.size	go_sort, .Lfunc_end1-go_sort
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"r"
	.size	.L.str, 2

	.type	input,@object                   # @input
	.bss
	.globl	input
	.p2align	3
input:
	.quad	0
	.size	input, 8

	.type	.L.str.1,@object                # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"Failed to open the input %s\n"
	.size	.L.str.1, 29

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"w"
	.size	.L.str.2, 2

	.type	output,@object                  # @output
	.bss
	.globl	output
	.p2align	3
output:
	.quad	0
	.size	output, 8

	.type	.L.str.3,@object                # @.str.3
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.3:
	.asciz	"Failed to open the output %s.\n"
	.size	.L.str.3, 31

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"%d\n"
	.size	.L.str.4, 4

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"Invalid input format.\n"
	.size	.L.str.5, 23

	.ident	"clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym fopen
	.addrsig_sym printf
	.addrsig_sym __isoc99_fscanf
	.addrsig_sym go_sort
	.addrsig_sym fclose
	.addrsig_sym exit
	.addrsig_sym __stack_chk_fail
	.addrsig_sym input
	.addrsig_sym output
