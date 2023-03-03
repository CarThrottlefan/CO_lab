# *********************************************************************************
# * Program name: Hello World                                                     *
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
    exit: jmp _exit
#endif

.text
# your strings here
    mystring: .asciz "Alexandru Florea, Rasa Karnite\n%d, %d\nAssignment %d\n"
.global my_main

my_main:
	# IMPLEMENT ME    

    pushq %rbp /*initializes stack, rbp - register base pointer*/
    movq %rsp, %rbp /**/
    movq $0, %rax /*0 means i don't have any vector registers, if i have >6 args i need vector*/
    movq $2772605, %rsi /*rsi is the second register in memory, after rdi. This puts this number to the first %d*/
    movq $2766765, %rdx /*rdx is 3rd, puts the value to 2nd %d*/
    movq $1, %rcx # rcx is 3rd, puts the value in 3rd
    leaq mystring(%rip), %rdi # rdi is the first register, that is the first arg of any function
    call printf 

    movq %rbp, %rsp # epilogue 
    popq %rbp # epilogue

    movq $0, %rdi
    call exit
    