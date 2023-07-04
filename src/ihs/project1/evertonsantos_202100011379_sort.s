.intel_syntax noprefix

.global	bubble_sort
.section .text
# We don't mess with the stack here, so we don't need to save it
bubble_sort: # bubble_sort = fn(arr: *int, int: n: int), edi has the 'arr' pointer and esi has the 'n'
  # alias i = edx; j = eax
	xor	edx, edx # i = 0 
	dec	esi  # esi = n-1 i.e. decrements 1 from  'n' that is in esi
.i_cmp: # if (i <= n-1) 
	cmp	esi, edx # esi -= i
	jle	.return  # if i <= n-1 (same as esi - edx <= 0) we jump to .return, 
	mov	ecx, esi # ecx = n-1
	xor	eax, eax # j = 0
	sub	ecx, edx # ecx = n-1-i, normal loop in bubble sort 
.j_cmp:
	cmp	ecx, eax # ecx - j
	jle	.j_true # if j <= n-i-1, jump to L9
  #: These part below has to be a multiple of 4 because 
  #: we're dealing with 32bits integers
	mov	r9d, DWORD PTR [0 + rdi + rax*4]    # r9 = arr[j]
	mov	r8d, DWORD PTR [4 + rdi + rax*4]  # r8 = arr[j+1]
	#mov	r8d, DWORD PTR 4[rdi+rax*4]   # Why is this also valid? ? what if 4[exp]
	#mov	r8d, DWORD PTR 4[rdi+rax*4]   # Why is this also valid? ? what if 4[exp]
	cmp	r9d, r8d
	jle	.j_dont_swap # if arr[j] > arr[j+1] jump l3
# .swap r9 and r8
	mov	DWORD PTR [0 + rdi + rax*4], r8d # arr[j] = r8x
	mov	DWORD PTR [4 + rdi + rax*4], r9d
.j_dont_swap:
	inc	eax # j += 1
	jmp	.j_cmp
.j_true:
	inc	edx # i += 1
	jmp	.i_cmp
.return:
	ret
	

.section	.data
fdigit1:
	.string	"%d\n"
finvalid:
	.string	"Invalid input format."
fmalloc_failed:
	.string	"Memory allocation failed."
fseparator:
	.string	"################################"
finput:
	.string	"--------------INPUT---------------"
fbrack_digit:
	.string	"[%d] "
fdigit2:
	.string	"%d"
fdigit3:
	.string	"%d "
foutput:
	.string	"---------------OUTPUT---------------"

.section .text
.global	go_sort

go_sort:
  push rbp
  mov rbp, rsp
  sub rsp, 12 #8+4 # space for an int and a ^int (integer pointer)
  # rbp-4 = int counter
  # rbp-12 = int*numbers
  #;;;;;;;;;;#
  mov	rdi, input # fprintf 1º input: *File
  mov rsi, fdigit1 # fprintf 2º formated string
  lea rdx, [rbp-4] # frprintf 3º load &counter in rdx 
	call	__isoc99_fscanf@PLT
	cmp eax, 1
	je	.fscanf_ok
.fscanf_erro:
	lea	rdi, [finvalid]
	jmp	.puts_and_leave
.fscanf_ok:
	movsx	rdi, DWORD PTR [rbp-4] # has to use [mov] [s]ign e[x]tend malloc 1º arg
	sal	rdi, 2 # multiply by 4, because it's the size for an integer
	call	malloc@PLT
	#mov	rbx, rax
	cmp rax, 0 # check if malloc returned null
	jne	.malloc_success
	lea	rdi, [fmalloc_failed]
.puts_and_leave:
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.malloc_success:
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
	
	mov	rdi, rbx
	pop	rbx
	
	pop	rbp
	
	pop	r12
	
	pop	r13
	
	pop	r14
	
	pop	r15
	
	jmp	free@PLT
.LFE8:
	
	.section	.data.str1.1
.LC9:
	.string	"r"
.LC10:
	.string	"Failed to open the input %s\n"
.LC11:
	.string	"w"
.LC12:
	.string	"Failed to open the output %s.\n"


.section	.text
.globl	main
main:
	push	rbx
	mov	rbx, rsi
	sub	rsp, 16
	
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
	jmp	.L35
.L25:
	mov	rdi, QWORD PTR 16[rbx]
	lea	rsi, .LC11[rip]
	call	fopen@PLT
	mov	QWORD PTR output[rip], rax
	test	rax, rax
	jne	.L27
	mov	rsi, QWORD PTR 16[rbx]
	lea	rdi, .LC12[rip]
.L35:
	call	printf@PLT
	jmp	.L26
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
	jmp	.L26
.L28:
	movsx	rax, DWORD PTR 4[rsp]
	cmp	rbx, rax
	jnb	.L36
	mov	edi, ebx
	inc	rbx
	call	go_sort
	jmp	.L28
.L36:
	mov	rdi, QWORD PTR input[rip]
	call	fclose@PLT
	mov	rdi, QWORD PTR output[rip]
	call	fclose@PLT
.L26:
	mov	rax, QWORD PTR 8[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L30
	call	__stack_chk_fail@PLT
.L30:
	add	rsp, 16
	
	mov	eax, 1
	pop	rbx
	
	ret
.LFE7:

.section .bss

.globl	output
.align 8
output:
  .zero	8

.globl	input
.align 8
input:
  .zero	8
