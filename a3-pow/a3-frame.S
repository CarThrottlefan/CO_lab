# *********************************************************************************
# * Program name: pow                                                             *
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
    exit: jmp _exit
#endif

.text
# your strings here
parameter1 : .asciz "%ld"
parameter2 : .asciz "%ld"
parameter3 : .asciz "%ld"

.global my_main
.global my_pow


my_main:
    pushq   %rbp                # store the caller's base pointer 
    movq    %rsp, %rbp          # initialize the base pointer

    subq $16 , %rsp                # reserve stack space 8bytes(could be 16) for variables
    leaq parameter1(%rip), %rdi         # Load address of stack var in rsi
    leaq -8(%rbp), %rsi     # load first argument of scanf
    movq $0 , %rax                 # no vector registers for scanf
    call scanf                   # Call scanf


    leaq -16(%rbp), %rsi           # Load address of stack var in rsi
    leaq parameter2(%rip), %rdi     # load first argument of scanf rdi

    movq $0 , %rax                 # no vector registers for scanf
    call scanf                # Call scanf
    movq -8(%rbp), %rdi           # tell the computer that the number goes from 0 to -8
    movq -16(%rbp), %rsi           # tell the computer that the number goes from 0 to -8

    call my_pow

    movq %rax, %rsi                 # moving the values of rax to rsi
    movq $0 , %rax              # no vector registers in use for printf
    leaq parameter3(%rip) , %rdi  # load address of a string is in rdi
    call printf                 # Call the printf routine

    mov     $0, %rdi            # load program exit code
	call    exit                # exit the program


my_pow:

 pushq %rbp                    # Prologue : push the base pointer . for begging subroutine
 movq %rsp , %rbp              # and copy stack pointer to RBP.     for begging soubroutine
 movq %rdi, %rax

 cmpq $0, %rsi
 jle case1

case1:
 movq $1 ,%rax
 jle end

loop3:
mulq %rdi
decq %rsi

cmpq $1 , %rsi       # r e p e a t t h e l o o p
jge loop3            # if rsi less or equal
# movq %rdi, %rax                # moves rdi to the return register(rax)
jmp end

end:
movq %rbp, %rsp
popq %rbp
ret
