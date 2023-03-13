# *********************************************************************************
# * Program name: inout                                                           *
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
mystring : .asciz "Assignment 2: inout\n"
formatstr : .asciz "%ld"
outputStr : .asciz "%ld\n"

.global my_main                         # make my_main accessible globally
.global my_increment                    # make my_increment accessible globally


   
my_main:
        # set up the stack frame

        #call    inout                

        # clear the stack and return

        pushq   %rbp                # store the caller's base pointer  (rbp-register, rax too)
        movq    %rsp, %rbp          # initialize the base pointer
        movq $0 , %rax              # no vector registers in use for printf
        leaq mystring(%rip) , %rdi  # load address of a string
        call printf                 # Call the printf routine
        # addq $8 , %rsp              # Clean the stack ( magic number ) cleaning??????
        call inout

        mov $0, %rdi                # load program exit code (rdi for exit)
        call  exit                  # exit the program

inout: 
        # read input and increment it using my_increment

        # call    my_increment

        # output incremented number
        
        pushq %rbp                    # Prologue : push the base pointer . for begging subroutine
        movq %rsp , %rbp              # and copy stack pointer to RBP.     for begging soubroutine
        subq $16 , %rsp               # reserve stack space 8bytes(could be 16) for variables
        leaq -8(%rbp), %rsi           # Load address of stack var in rsi
        leaq formatstr(%rip), %rdi    # load first argument of scanf
        movq $0 , %rax                # no vector registers for scanf
        call scanf                      # Call scanf
        movq -8(%rbp), %rdi           # tell the computer that the number goes from 0 to -8
        call my_increment

        movq %rax, %rsi                 # moving the values of rsi to rax
        movq $0, %rax                   # reinitializing rax to 0, with no vector
        leaq outputStr(%rip), %rdi      # rdi is the first argument of the function
        call printf 


        movq %rbp, %rsp                 # at the end 
        popq %rbp                       # at the end
        

my_increment: 
        pushq %rbp                      # prologue
        movq %rsp, %rbp                 # prologue
        incq %rdi;                      # increases the input's val by 1
        movq %rdi, %rax;                # moves rdi to the return register(rax)

        movq %rbp, %rsp
        popq %rbp
        ret 

        # IMPLEMENT ME

