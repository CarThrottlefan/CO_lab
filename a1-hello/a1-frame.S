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
    mystring: .asciz "Hello_world!\n"

my_main:
	# IMPLEMENT ME    

    pushq %rbp
    movq %rsp, %rbp
    movq $0, %rax
    leaq mystring(%rip), %rdi
    call printf

    movq %rbp, %rsp
    popq %rbp
    mov $0, %rdi
    call exit