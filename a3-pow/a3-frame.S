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
    leaq parameter1(%rip), %rdi    # Load address of stack var in rsi(%ld)
    leaq -8(%rbp), %rsi            # load first argument of scanf
    movq $0 , %rax                 # no vector registers for scanf
    call scanf                     # Call scanf


    leaq -16(%rbp), %rsi           # Load address of stack var in rsi
    leaq parameter1(%rip), %rdi    # load first argument of scanf rdi

    movq $0 , %rax                 # no vector registers for scanf
    call scanf                     # Call scanf
    movq -8(%rbp), %rdi            # move first parameter in rdi register
    movq -16(%rbp), %rsi           # move second parameter in rsi regster

    call my_pow

    movq %rax, %rsi                 # moving the values of rax to rsi
    movq $0 , %rax                  # no vector registers in use for printf
    leaq parameter1(%rip) , %rdi    # load address of a string
    call printf                     # Call the printf routine

    mov     $0, %rdi            # load program exit code
	call    exit                # exit the program


my_pow:

 pushq %rbp                    # Prologue : push the base pointer . for begging subroutine
 movq %rsp , %rbp              # and copy stack pointer to RBP.     for begging soubroutine
 movq %rdi, %rax                # move value in rdi to rax

 cmpq $0, %rsi                 # compare value in rsi(power) with 0
 je case1                     # if its equal it jumps to case 1
 jmp loop3

loop3:
cmpq $1, %rsi
je end

mulq %rdi                          # multiply vule in rdi with value in rax
decq %rsi                          # decrease rsi

jmp loop3                       # if rsi grwater or equal to 1 jump to loop3


case1:
movq $1 ,%rax                  # 1 moved in rax
je end                        # jump to end

end:
movq %rbp, %rsp           # end
popq %rbp                 # end
ret
