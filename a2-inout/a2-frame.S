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
mystring : .asciz "Assignment 2: inout"
formatstr : .asciz "%ld"

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
        subq $8 , %rsp                 # reserve stack space 8bytes(could be 16) for variables
        leaq −8(%rbp), %rsi        # Load address of stack vari n rsi
        leaq formatstr(%rip), %rdi  # load first argument of scanf
        movq $0 , %rax                 # no vector registers for scanf
        call scanf                     # Call scanf

        movq %rbp, %rsp                 # at the end 
        popq %rbp                       # at the end
        ret

my_increment:
        # IMPLEMENT ME

