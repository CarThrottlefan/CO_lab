# *********************************************************************************
# * Program name: factorial                                                       *
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
formatstr : .asciz "%ld"
outputStr : .asciz "%ld\n"

.global my_main
.global factorial


my_main:
        pushq   %rbp                # store the caller's base pointer  (rbp-register, rax too)
        movq    %rsp, %rbp          # initialize the base pointer


        subq $16 , %rsp               # reserve stack space 8bytes(could be 16) for variables

        leaq -8(%rbp), %rsi           # Load address of stack var in rsi
        leaq formatstr(%rip), %rdi    # load first argument of scanf
        movq $0 , %rax                # no vector registers for scanf
        call scanf                    # Call scanf

        movq -8(%rbp), %rdi           # tell the computer that the number goes from 0 to -8
        call factorial

        movq %rax, %rsi                 # moving the values of rsi to rax
        movq $0, %rax                   # reinitializing rax to 0, with no vector
        leaq outputStr(%rip), %rdi      # rdi is the first argument of the function
        call printf


        movq %rbp, %rsp                 # at the end 
        popq %rbp                       # at the end

	movq $0, %rax
        ret                             # so call exit nukes it, but it works with ret?
        
factorial:
        pushq %rbp;
        movq %rsp, %rbp;
                                # rdi contains the value of n
        cmpq $0, %rdi           # test if number is 0
        je if
        jmp else

if:
        movq %rbp, %rsp; 
        popq %rbp;              

	movq $1, %rax;          # gives the value of 1 to rax
        ret
else:
        cmpq $1, %rdi           # compare RAX to 1
        je ifCode               # compares if rax is equal to 1
        jmp elseCode                # if you don't enter ifCode, jump to elseCode

ifCode:
        movq $1, %rax;          # set the value of rax to 1 - basecase of recursion
        movq %rbp, %rsp;
        popq %rbp;
        ret
elseCode:


        subq $16 , %rsp # allocate 16 bytes on stack
        movq %rdi, -8(%rbp)
        
        decq %rdi;      # decreases rdi by 1, so the next fuction call is with n-1
        call factorial  
        movq -8(%rbp), %rdi
        addq $16, %rsp       # after base case reached, start going backwards
        mulq %rdi       # multiply curr rdi with the next value going up

        movq %rbp, %rsp; 
        popq %rbp;
        ret