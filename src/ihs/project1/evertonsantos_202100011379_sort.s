.intel_syntax noprefix

.globl	bubble_sort
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
  #:: These part below has to be a multiple of 4 because 
  #:: we're dealing with 32bits integers
	mov	r9d, dword ptr [0 + rdi + rax*4]    # r9 = arr[j]
	mov	r8d, dword ptr [4 + rdi + rax*4]  # r8 = arr[j+1]
	#mov	r8d, DWORD PTR 4[rdi+rax*4]   # Why is this also valid? ? what if 4[exp]
	cmp	r9d, r8d
	jle	.j_dont_swap # if arr[j] > arr[j+1] jump l3
# .swap r9 and r8
	mov	dword ptr [0 + rdi + rax*4], r8d # arr[j] = r8x
	mov	dword ptr [4 + rdi + rax*4], r9d
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
.globl	go_sort

go_sort:
#:: begin prologue
	push  r15
  push  r14
	push  r13
	push  r12
  push  rbx
	push  rbp
  mov rbp, rsp

  sub rsp, 16+8 #16 # space for an int and a ^int (integer pointer)
#:: end
  mov dword ptr [rbp - 16], edi # r9d = run : int 
  # rbp-16 = int  rum 
  # rbp-4  = int  count
  # rbp-12 = int* numbers
  #;;;;;;;;;;#

	mov	dword ptr [rbp - 4], 0
;
  mov rdi, qword ptr [rip + input] # fprintf 1º input: *File
  lea rsi, [rip + fdigit1] # fprintf 2º formated string
  lea rdx, [rbp-4] # frprintf 3º load &counter in rdx 
  xor eax, eax # AL = 0

	call	__isoc99_fscanf@PLT

	cmp eax, 1
	je	.fscanf_ok

.fscanf_error:
	lea	rdi, [rip + finvalid]
	jmp	.puts_and_leave

.fscanf_ok:
#:: malloc begin
	movsx	rdi, DWORD PTR [rbp-4] # has to use [mov] [s]ign e[x]tend malloc 1º arg
	sal	rdi, 2 # multiply by 4, because it's the size for an integer
	call	malloc@PLT
#:: end

	cmp rax, 0 # check if malloc returned null
	jne	.malloc_success
	lea	rdi, [rip + fmalloc_failed]

.puts_and_leave:
	call	puts@PLT
	mov	edi, 24
	call	exit@PLT

.malloc_success:
  mov qword ptr [rbp-12], rax # number = return of malloc

#:: puts begin
	lea	rdi, [rip + fseparator]
	call	puts@PLT
	lea	rdi, [rip + finput]
	call	puts@PLT
#:: end

#:: printf begin 
	lea	rdi, [rip + fbrack_digit]
	mov	esi, dword ptr [rbp-16] # run
	xor	eax, eax
	call	printf@PLT
#:: end


#:: for i .. count
  # r14 is preserver across function call, so we can use it here
	xor	r14d, r14d #:: int i = 0
  mov r13, qword ptr [rbp-12]  # r13 = numbers: ^int
.for_i_to_count:
	cmp	DWORD PTR [rbp-4], r14d #:: cmp count with count with j 
	jle	.for_i_to_count_done    #:: if count <= i === ~(i < count) 

  #:: fscanf begin
    mov	rdi, qword ptr [rip + input] # input: ^FILE
    lea	rsi, qword ptr [rip + fdigit2]
    lea rdx, [r13 + 4*r14]  # rdx = numbers

    xor	eax, eax #:: variadic function has to say how many vector reg is using in reg AL 
    call	__isoc99_fscanf@PLT
  #:: end

	cmp eax, 1 #:: if (fscanf(input, "%d", &numbers[i]) != 1) {
	jne	.fscanf_error

  #:: printf begin
    lea	rdi, [rip + fdigit3]
    mov	esi, dword ptr [r13 + 4*r14] #:: numbers[i]
    xor	eax, eax #:: zeros everything else, but eve so it's no necessary because we only need AL to be 0
    call	printf@PLT
  #:: end

	inc	r14
	jmp	.for_i_to_count

.for_i_to_count_done:
	mov	edi, 10 #:: \n has opcode 10, so fine
	call	putchar@PLT

	mov	rdi, qword ptr [rbp-12] #:: 1º numbers: ^int
	mov	esi, dword ptr [rbp-4]  #:: 2º count: int
	call	bubble_sort

#:: begin puts("---------------OUTPUT---------------\n");
	lea	rdi, [rip + foutput]
	call	puts@PLT
#:: end

#:: begin fprintf
	mov	rdi, qword ptr [rip + output] # output: ^FILE
  lea rsi, [rip + fbrack_digit] # "[%d] "
	mov	edx, dword ptr [rbp - 16] # run
	xor	eax, eax
	call	fprintf@PLT
#:: end 

#:: begin printf 
  lea rdi, [rip + fbrack_digit]
	mov	esi, dword ptr [rbp - 16]
	xor	eax, eax
	call	printf@PLT
#:: end

  xor r14d, r14d # i = 0
.for_i_to_count_output:
	cmp	dword ptr [rbp-4], r14d
	jle	.for_i_to_count_output_done

#:: begin fprintf
	mov	rdi, qword ptr [rip + output] # output: ^FILE
	lea	rsi, [rip + fdigit3]
  mov	edx, dword ptr[r13 + 4*r14]  #  numbers[i]
	xor	eax, eax
	call fprintf@PLT
#:: end

#:: begin printf
	lea	rdi, [rip + fdigit3]
  mov	esi, dword ptr [r13 + 4*r14] # numbers[i]
	xor	eax, eax
	call printf@PLT
#:: end

  inc	r14
	jmp	.for_i_to_count_output

.for_i_to_count_output_done:

  mov	edi, 10
	mov	rsi,qword ptr [rip + output]
	call	fputc@PLT # fputc (c :int, stream : ^FILE) -> int ;

	mov	edi, 10
	call	putchar@PLT

	mov rdi, r13
	call free@PLT

#:: begin epilogue
  add rsp, 16+8 #16 # space for an int and a ^int (integer pointer)
  pop rbp
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
  ret
#:: end
	
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
#:: begin prologue
.main_prologue:
  push r14
  push r13
  push r12
	push rbx
  push rbp
	sub	rsp, 16
#:: end
  mov	rbx, rsi # rbx = argv

#::begin fopen	
	mov	rdi, qword ptr [rsi+8] #argv[1] argv + 8 because a pointer is 8 bytes
	lea	rsi, [rip + str_read]  # rsi = "r"
	mov	rax, QWORD PTR fs:40   # @why
	mov	qword ptr [rsp + 8], rax #
	xor	eax, eax
	call	fopen@PLT
#:: end
	mov	qword ptr [rip + input], rax # input = rax (result of fopen)

	test	rax, rax # rax & rax; only way for this to be NULL is if every single bit is zero
	jne	.fopen_input_success

	mov	rsi, qword ptr [rbx+8] # argv[1]
	lea	rdi, [rip + str_failed_input]
	jmp	.print_and_return

.fopen_input_success:

#::begin fopen	
	mov	rdi, qword ptr [rbx + 16] # argv[2]
	lea	rsi, [rip + str_write] # "w"
	call	fopen@PLT
#:: end

	mov	qword ptr [rip + output], rax # output = rax
	test	rax, rax # test if null, rax == null
	jne	.fopen_output_success

	mov	rsi, qword ptr [rbx + 16]
	lea	rdi, [rip + str_failed_output]

.print_and_return:
  xor eax, eax
	call	printf@PLT
  mov eax, 69 # retun code 69 which means sex
	jmp	.main_epilogue

.fopen_output_success:
#:: begin fscanf
  mov	rdi, qword ptr [rip + input]
  lea	rsi, [rip + fdigit1] # "%d\n"
  lea	rdx, [rsp + 4] # &n_array
  xor	eax, eax # eax = 0 
	call	__isoc99_fscanf@PLT
#:: end

	cmp eax, 1 # fscanf, read only one
	je	.f_scanf_n_array_success
	lea	rdi, [rip + finvalid]
	call	puts@PLT
  mov rax, 69
	jmp	.main_epilogue

.f_scanf_n_array_success:
  xor ebx, ebx # ebx = 0
	movsx	r13d, dword ptr [rsp + 4] # rax = n_array

.for_go_sort:
  cmp	ebx, r13d # ebx == ebax == n_array?
	je .for_go_sort_done # if ebx == n_array, jmp to done
	mov	edi, ebx
  call go_sort

	inc	ebx # ebx += 1
	jmp	.for_go_sort

.for_go_sort_done:
	mov	rdi, qword ptr [rip + input]
	call	fclose@PLT
	mov	rdi, qword ptr [rip + output]
	call	fclose@PLT
  mov eax, 0 # return ok

.main_epilogue:
	add	rsp, 16
  pop rbp
	pop	rbx
  pop r12
  pop r13
  pop r14
	ret

.section .bss

.globl	output
.align 8
output:
  .zero	8

.globl	input
.align 8
input:
  .zero	8
