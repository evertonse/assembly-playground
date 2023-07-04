	.text
	.intel_syntax noprefix
	.file	"evertonsantos_202100011379_sort.c"
	.globl	bubble_sort                     # -- Begin function bubble_sort
	.type	bubble_sort,@function
bubble_sort:                            # @bubble_sort
	.cfi_startproc
# %bb.0:
                                        # kill: def $esi killed $esi def $rsi
	cmp	esi, 2
	jl	.LBB0_9
# %bb.1:
	lea	r8d, [rsi - 1]
	xor	r9d, r9d
	mov	r10d, r8d
.LBB0_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_4 Depth 2
	mov	r10d, r10d
	mov	eax, r9d
	not	eax
	add	eax, esi
	test	eax, eax
	jle	.LBB0_8
# %bb.3:                                #   in Loop: Header=BB0_2 Depth=1
	mov	r11d, dword ptr [rdi]
	xor	ecx, ecx
.LBB0_4:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lea	rdx, [rcx + 1]
	mov	eax, dword ptr [rdi + 4*rcx + 4]
	cmp	r11d, eax
	jle	.LBB0_5
# %bb.6:                                #   in Loop: Header=BB0_4 Depth=2
	mov	dword ptr [rdi + 4*rcx], eax
	mov	dword ptr [rdi + 4*rcx + 4], r11d
	jmp	.LBB0_7
.LBB0_5:                                #   in Loop: Header=BB0_4 Depth=2
	mov	r11d, eax
.LBB0_7:                                #   in Loop: Header=BB0_4 Depth=2
	mov	rcx, rdx
	cmp	r10, rdx
	jne	.LBB0_4
.LBB0_8:                                #   in Loop: Header=BB0_2 Depth=1
	inc	r9d
	dec	r10d
	cmp	r9d, r8d
	jne	.LBB0_2
.LBB0_9:
	ret
.Lfunc_end0:
	.size	bubble_sort, .Lfunc_end0-bubble_sort
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	push	rbx
	.cfi_def_cfa_offset 16
	sub	rsp, 16
	.cfi_def_cfa_offset 32
	.cfi_offset rbx, -16
	mov	rbx, rsi
	mov	rax, qword ptr fs:[40]
	mov	qword ptr [rsp + 8], rax
	mov	rdi, qword ptr [rsi + 8]
	lea	rsi, [rip + .L.str]
	call	fopen@PLT
	mov	qword ptr [rip + input], rax
	test	rax, rax
	je	.LBB1_1
# %bb.2:
	mov	rdi, qword ptr [rbx + 16]
	lea	rsi, [rip + .L.str.2]
	call	fopen@PLT
	mov	qword ptr [rip + output], rax
	test	rax, rax
	je	.LBB1_3
# %bb.4:
	lea	rdx, [rsp + 4]
	mov	dword ptr [rdx], 0
	mov	rdi, qword ptr [rip + input]
	lea	rsi, [rip + .L.str.4]
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	jne	.LBB1_9
# %bb.5:
	cmp	dword ptr [rsp + 4], 0
	je	.LBB1_8
# %bb.6:
	xor	ebx, ebx
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
	mov	edi, ebx
	call	go_sort
	inc	rbx
	movsxd	rax, dword ptr [rsp + 4]
	cmp	rbx, rax
	jb	.LBB1_7
.LBB1_8:
	mov	rdi, qword ptr [rip + input]
	call	fclose@PLT
	mov	rdi, qword ptr [rip + output]
	call	fclose@PLT
	xor	eax, eax
	jmp	.LBB1_10
.LBB1_1:
	mov	rsi, qword ptr [rbx + 8]
	lea	rdi, [rip + .L.str.1]
	xor	eax, eax
	call	printf@PLT
	mov	eax, 24
	jmp	.LBB1_10
.LBB1_3:
	mov	rsi, qword ptr [rbx + 16]
	lea	rdi, [rip + .L.str.3]
	xor	eax, eax
	call	printf@PLT
	mov	eax, 420
	jmp	.LBB1_10
.LBB1_9:
	lea	rdi, [rip + .Lstr.16]
	call	puts@PLT
	mov	eax, 69
.LBB1_10:
	mov	rcx, qword ptr fs:[40]
	cmp	rcx, qword ptr [rsp + 8]
	jne	.LBB1_12
# %bb.11:
	add	rsp, 16
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
.LBB1_12:
	.cfi_def_cfa_offset 32
	call	__stack_chk_fail@PLT
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.globl	go_sort                         # -- Begin function go_sort
	.type	go_sort,@function
go_sort:                                # @go_sort
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	push	r15
	.cfi_def_cfa_offset 24
	push	r14
	.cfi_def_cfa_offset 32
	push	r13
	.cfi_def_cfa_offset 40
	push	r12
	.cfi_def_cfa_offset 48
	push	rbx
	.cfi_def_cfa_offset 56
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	.cfi_offset rbx, -56
	.cfi_offset r12, -48
	.cfi_offset r13, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	.cfi_offset rbp, -16
	mov	r14d, edi
	mov	rax, qword ptr fs:[40]
	mov	qword ptr [rsp + 16], rax
	lea	rdx, [rsp + 12]
	mov	dword ptr [rdx], 0
	mov	rdi, qword ptr [rip + input]
	lea	rsi, [rip + .L.str.4]
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	jne	.LBB2_1
# %bb.3:
	movsxd	rdi, dword ptr [rsp + 12]
	shl	rdi, 2
	call	malloc@PLT
	test	rax, rax
	je	.LBB2_4
# %bb.5:
	mov	r13, rax
	lea	rdi, [rip + .L.str.7]
	call	puts@PLT
	lea	rdi, [rip + .L.str.8]
	call	puts@PLT
	lea	rdi, [rip + .L.str.9]
	mov	esi, r14d
	xor	eax, eax
	call	printf@PLT
	cmp	dword ptr [rsp + 12], 0
	jle	.LBB2_9
# %bb.6:
	lea	r15, [rip + .L.str.10]
	lea	r12, [rip + .L.str.11]
	mov	rbx, r13
	xor	ebp, ebp
.LBB2_7:                                # =>This Inner Loop Header: Depth=1
	mov	rdi, qword ptr [rip + input]
	mov	rsi, r15
	mov	rdx, rbx
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	jne	.LBB2_1
# %bb.8:                                #   in Loop: Header=BB2_7 Depth=1
	mov	esi, dword ptr [rbx]
	mov	rdi, r12
	xor	eax, eax
	call	printf@PLT
	inc	rbp
	movsxd	rax, dword ptr [rsp + 12]
	add	rbx, 4
	cmp	rbp, rax
	jl	.LBB2_7
.LBB2_9:
	mov	edi, 10
	call	putchar@PLT
	mov	esi, dword ptr [rsp + 12]
	mov	rdi, r13
	call	bubble_sort
	lea	rdi, [rip + .L.str.12]
	call	puts@PLT
	mov	rdi, qword ptr [rip + output]
	lea	rbx, [rip + .L.str.9]
	mov	rsi, rbx
	mov	edx, r14d
	xor	eax, eax
	call	fprintf@PLT
	mov	rdi, rbx
	mov	esi, r14d
	xor	eax, eax
	call	printf@PLT
	cmp	dword ptr [rsp + 12], 0
	jle	.LBB2_12
# %bb.10:
	lea	rbx, [rip + .L.str.11]
	xor	ebp, ebp
.LBB2_11:                               # =>This Inner Loop Header: Depth=1
	mov	rdi, qword ptr [rip + output]
	mov	edx, dword ptr [r13 + 4*rbp]
	mov	rsi, rbx
	xor	eax, eax
	call	fprintf@PLT
	mov	esi, dword ptr [r13 + 4*rbp]
	mov	rdi, rbx
	xor	eax, eax
	call	printf@PLT
	inc	rbp
	movsxd	rax, dword ptr [rsp + 12]
	cmp	rbp, rax
	jl	.LBB2_11
.LBB2_12:
	mov	rsi, qword ptr [rip + output]
	mov	edi, 10
	call	fputc@PLT
	mov	edi, 10
	call	putchar@PLT
	mov	rdi, r13
	call	free@PLT
	mov	rax, qword ptr fs:[40]
	cmp	rax, qword ptr [rsp + 16]
	jne	.LBB2_14
# %bb.13:
	add	rsp, 24
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	r12
	.cfi_def_cfa_offset 40
	pop	r13
	.cfi_def_cfa_offset 32
	pop	r14
	.cfi_def_cfa_offset 24
	pop	r15
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
.LBB2_1:
	.cfi_def_cfa_offset 80
	lea	rdi, [rip + .Lstr.16]
.LBB2_2:
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.LBB2_4:
	lea	rdi, [rip + .Lstr.15]
	jmp	.LBB2_2
.LBB2_14:
	call	__stack_chk_fail@PLT
.Lfunc_end2:
	.size	go_sort, .Lfunc_end2-go_sort
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

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"################################\n"
	.size	.L.str.7, 34

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"--------------INPUT---------------\n"
	.size	.L.str.8, 36

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"[%d] "
	.size	.L.str.9, 6

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"%d"
	.size	.L.str.10, 3

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"%d "
	.size	.L.str.11, 4

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"---------------OUTPUT---------------\n"
	.size	.L.str.12, 38

	.type	.Lstr.15,@object                # @str.15
.Lstr.15:
	.asciz	"Memory allocation failed."
	.size	.Lstr.15, 26

	.type	.Lstr.16,@object                # @str.16
.Lstr.16:
	.asciz	"Invalid input format."
	.size	.Lstr.16, 22

	.ident	"clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __stack_chk_fail
