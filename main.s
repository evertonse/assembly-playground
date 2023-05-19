# x86 Assembly
.global _start # .global is a directive that export symbols
.intel_syntax noprefix # Intel syntax vs ATMT is considered a holy war somehow? dont care

########################################################################
.section .text # below this directive everything is +r and +x but -w
_start:

    call print_integer 
    // write to stdout
    // syscall code for write
    mov rax, 1  # Hash comment work on the side, but // doesnt
    // fd - file descript 1, 1 is the stdout
    mov rdi, 1 
    // need to put the pointer to the start of the string
    #mov rsi, [hello_ptr]
    lea rsi, [hello_ptr] 
    // the length of the string
    mov rdx, 13 
    # int 0x80 is also considered a interruption for a syscall 
    syscall

    # Jump to the exit section, I know the next section also is the section
    /*
        The jmp (jump) and call instructions in x86 assembly are both used for altering the control flow of a program, but they serve different purposes.

    jmp (jump):
        The jmp instruction is used to perform an unconditional jump to a specified location in the code.
        It changes the instruction pointer (IP) to the target address, allowing program execution to continue from there.
        It does not save the return address, so there is no automatic return after executing the target code.
        jmp is typically used for implementing loops, conditional branches, or direct jumps to specific sections of code.

    call:
        The call instruction is used to perform a procedure call or subroutine call.
        It saves the return address (the address of the instruction immediately following the call instruction) onto the stack before transferring control to the target procedure.
        After executing the target procedure, a ret (return) instruction is typically used to retrieve the return address from the stack and continue execution from that point.
        call is commonly used for function calls, subroutines, or procedures.
    */
    jmp exit


# Exit section
exit:
    # Syscall for exit
    mov rax, 60
    # Exit code - 0 or any desired value
    mov rdi, 0x420
    # Syscall for exit
    syscall

print_integer:
    mov eax, 420  # Example integer value to print

    # Convert integer to string
    push rax         # Push the integer value onto the stack
    push int_format  # Push the format string onto the stack
    mov edi, esp  # Move the address of the format string into edi
    xor eax, eax  # Clear eax for the printf syscall

    # Call the printf syscall
    call printf

    # Exit
    mov eax, 60  # Syscall number for exit
    xor edi, edi  # Exit code 0
    syscall
    ret

 printf:
 /*
The pusha instruction is used to push the contents of the general-purpose registers (eax, ecx, edx, ebx, esp, ebp, esi, edi) onto the stack. It allows you to save the state of all the general-purpose registers in one instruction. Here's how pusha works:
Make sure to adjust the stack accordingly and ensure that you push and pop the registers in the reverse order to maintain proper stack alignment.
    The current values of the eight general-purpose registers are pushed onto the stack in the following order:
        eax
        ecx
        edx
        ebx
        esp
        ebp
        esi
        edi
 */
    # Save registers

/*
   The push instruction in x86 assembly is used to push a value onto the top of the stack. It performs the following steps:

    Decrement the stack pointer (rsp) by the size of the value being pushed.
    Copy the value to the memory location pointed to by rsp. 
*/
    push rax
    push rbx
    push rdx
    # Invoke the printf syscall
    mov eax, 0x4E   # Syscall number for write
    mov ebx, 1      # File descriptor - 1 is stdout
    mov edx, 10     # Length of the string
    int 0x80

    # Restore registers
    pop rdx
    pop rbx
    pop rax

    # Return from the function
    ret

####################################################################################
.section .data  # directive that says below this we have +r +w but not exectuable -x
hello_ptr:
    .asciz "hello, world\n"
int_format:
    .asciz "%d\n"
/*
    Registers:
        [e,r][a,b,c,d...]x are general purpuse 
        sp - top of the stack    
        bp - base of the stack
        ip - next instruction pointer
*/

push_implementation:
    # Manually push a 32-bit value onto the stack
    sub rsp, 4          # Decrement rsp by 4 bytes (size of a 32-bit value)
    #mov dword [rsp], 42 # Store the value 42 at the memory location pointed to by rsp
    ret
    /*
        It's important to ensure proper alignment and management of the stack when manually pushing values. 
        Remember to adjust the stack pointer by the appropriate size for the value being pushed
        Take care to maintain the correct stack alignment if required by the calling convention 
   */
