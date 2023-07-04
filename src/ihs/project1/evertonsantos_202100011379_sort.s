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
	

.section	.rodata
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
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
  pop rbp
#----------------#
  mov rbp, rsp
  sub rsp, 16 #8+4 # space for an int and a ^int (integer pointer)
  mov dword ptr [rbp-16], edi # r9d = run : int 
  # rbp-16 = int  rum 
  # rbp-4  = int  count
  # rbp-12 = int* numbers
  #;;;;;;;;;;#
  lea rdi, [rip + input] # fprintf 1º input: *File
  lea rsi, [rip + fdigit1] # fprintf 2º formated string
  lea rdx, [rbp-4] # frprintf 3º load &counter in rdx 
	call	__isoc99_fscanf@PLT
	cmp eax, 1
	je	.fscanf_ok
.fscanf_error:
	lea	rdi, [rip + finvalid]
	jmp	.puts_and_leave
.fscanf_ok:
#: malloc begin
	movsx	rdi, DWORD PTR [rbp-4] # has to use [mov] [s]ign e[x]tend malloc 1º arg
	sal	rdi, 2 # multiply by 4, because it's the size for an integer
	call	malloc@PLT
#: end

	cmp rax, 0 # check if malloc returned null
	jne	.malloc_success
	lea	rdi, [rip + fmalloc_failed]
.puts_and_leave:
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.malloc_success:
  mov qword ptr [rbp-12], rax # number = return of malloc
	lea	rdi, [rip + fseparator]
	call	puts@PLT
	lea	rdi, [rip + finput]
	call	puts@PLT

#: printf begin 
	lea	rdi, [rip + fbrack_digit]
	mov	esi, dword ptr [rbp-16] # run
	xor	eax, eax
	call	printf@PLT
#: end


#: for i .. count

	xor	r14d, r14d #: int i = 0
.for_i_to_count:
	cmp	DWORD PTR [rbp-4], r14d #: cmp count with count with j 
	jle	.for_i_to_count_done    #: if count <= i === ~(i < count) 
#: fscanf begin
	mov	rdi, QWORD PTR [rip + input]

	lea rdx, qword ptr [rbp-12 + 4*r14] #: &number[i]
	lea	rsi, qword ptr [rip + fdigit2]
  xor	eax, eax #: variadic function has to say how many vector reg is using in reg AL 
	call	__isoc99_fscanf@PLT
	cmp eax, 1 #: if (fscanf(input, "%d", &numbers[i]) != 1) {
	jne	.fscanf_error

	lea	rdi, [rip + fdigit3]
	mov	esi, DWORD PTR [rbp-12 + 4*r14] #: numbers[i]
	xor	eax, eax #: zeros everything else, but eve so it's no necessary because we only need AL to be 0
  call	printf@PLT
	inc	r14d
	jmp	.for_i_to_count

.for_i_to_count_done:
	mov	edi, 10 #: \n has opcode 10, so fine
	call	putchar@PLT

	mov	rdi, qword ptr [rbp-12] #: 1º numbers: ^int
	mov	esi, dword ptr [rbp-4]  #: 2º count: int
	call	bubble_sort

#: begin puts("---------------OUTPUT---------------\n");
	lea	rdi, [rip + foutput]
	call	puts@PLT
#: end

#: begin fprintf
	mov	rdi, qword ptr [rip + output]
  lea rsi, [rip + fbrack_digit]
	mov	edx, dword ptr [rbp - 16]
	xor	eax, eax
	call	fprintf@PLT
#: end 

#: begin printf 
  lea rdi, [rip + fbrack_digit]
	mov	esi, dword ptr [rbp - 16]
	xor	eax, eax
	call	printf@PLT
#: end

  xor r11d, r11d # i = 0
.for_i_to_count_output:
	cmp	dword ptr [rbp-4], r11d
	jle	.for_i_to_count_output_done

#: begin fprintf
	mov	rdi, qword ptr [rip + output]
	lea	rsi, [rip + fdigit3]
	mov	edx, dword ptr [r11*4 + rbp - 12]
	xor	eax, eax
	call fprintf@PLT
#: end

#: begin printf
	lea	rdi, [rip + fdigit3]
	mov	esi, dword ptr [r11*4 + rbp - 12]
	xor	eax, eax
	call printf@PLT
#: end
  inc	r11d
	jmp	.for_i_to_count_output

.for_i_to_count_output_done:

  mov	edi, 10
	mov	rsi,qword ptr [rip + output]
	call	fputc@PLT # fputc (c :int, stream : ^FILE) -> int ;

	mov	edi, 10
	call	putchar@PLT

	add	rsp, 16
	
	mov rdi, qword ptr [rbp-12]  
	jmp	free@PLT

#: begin prologue
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
  pop rbp
  ret
#: end
	
.section	.rodata
str_read:
	.string	"r"
str_failed_input:
	.string	"Failed to open the input %s\n"
str_write:
	.string	"w"
str_failed_output:
	.string	"Failed to open the output %s.\n"


.section	.text
.globl	main
main:
	push	rbx
	mov	rbx, rsi
	sub	rsp, 16

#:begin fopen	
	mov	rdi, QWORD PTR 8[rsi]
	lea	rsi, [rip + str_read]
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 8[rsp], rax
	xor	eax, eax
	call	fopen@PLT
#: end

	mov	QWORD PTR input[rip], rax
	test	rax, rax
	jne	.L25

	mov	rsi, QWORD PTR 8[rbx]
	lea	rdi, str_failed_input[rip]
	jmp	.L35
.L25:
	mov	rdi, QWORD PTR 16[rbx]
	lea	rsi, [rip + str_write]
	call	fopen@PLT
	mov	QWORD PTR output[rip], rax
	test	rax, rax
	jne	.L27
#: begin printf
	mov	rsi, QWORD PTR 16[rbx]
	lea	rdi, str_failed_output[rip]
.L35:
	call	printf@PLT
#: end

	jmp	.L26

.L27:
	xor	esi, esi
	mov	rdi, QWORD PTR input[rip]
	xor	eax, eax
	lea	rdx, [rsp + 4]
	mov	dword ptr [rsp + 4], esi
	lea	rsi, fdigit1[rip]
	xor	ebx, ebx
	call	__isoc99_fscanf@PLT
	dec	eax
	je	.L28
	lea	rdi, finvalid[rip]
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
