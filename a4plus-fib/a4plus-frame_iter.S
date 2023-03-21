# *********************************************************************************
# * Program name: fibonacci                                                       *
# * Description :                                                                 *
# *********************************************************************************

#ifndef MACOS
.ifndef CODEGRADE
    .global main
    main: jmp my_main
.endif
#else
    .global _main
    _main: jmp my_main
    printf: jmp _printf
    scanf: jmp _scanf
    malloc: jmp _malloc
    calloc: jmp _calloc
    realloc: jmp _realloc
    free: jmp _free
    exit: jmp _exit
#endif

.text
# your strings here
parameter1 : .asciz "%ld"

.global my_main
.global fibonacci


my_main:
        # IMPLEMENT ME
    pushq   %rbp                # store the caller's base pointer 
    movq    %rsp, %rbp          # initialize the base pointer

    subq $16 , %rsp                # reserve stack space 8bytes(could be 16) for variables
    leaq parameter1(%rip), %rdi    # Load address of stack var in rsi(%ld)
    leaq -8(%rbp), %rsi            # load first argument of scanf
    movq $0 , %rax                 # no vector registers for scanf
    call scanf                     # Call scanf
    movq -8(%rbp), %rdi            # move first parameter in rdi register

    call fibonacci

    movq %rax, %rsi                 # moving the values of rax to rsi
    movq $0 , %rax                  # no vector registers in use for printf
    leaq parameter1(%rip) , %rdi    # load address of a string
    call printf                     # Call the printf routine

    mov     $0, %rdi            # load program exit code
	call    exit                # exit the program

fibonacci:

 pushq %rbp                    # Prologue : push the base pointer . for begging subroutine
 movq %rsp , %rbp              # and copy stack pointer to RBP.     for begging soubroutine
 movq $0, %rsi               # move value in rdi to rax
 movq $1, %rax
 jmp loop3

loop3:
cmpq $0, %rdi
je end

movq %rsi, %rdx
addq %rsi, %rax                         # multiply vule in rdi with value in rax
movq %rax, %rsi
movq %rdx, %rax
decq %rdi                          # decrease rsi

jmp loop3                       # if rsi grwater or equal to 1 jump to loop3

end:
movq %rdx, %rax
movq %rbp, %rsp           # end
popq %rbp                 # end
ret
