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

    pushq %rbp
    movq %rsp, %rbp
    movq $0, %rax
    movq $2772605, %rsi
    movq $2766765, %rdx
    movq $1, %rcx
    leaq mystring(%rip), %rdi
    call printf

    movq %rbp, %rsp
    popq %rbp

    movq $0, %rdi
    call exit
    