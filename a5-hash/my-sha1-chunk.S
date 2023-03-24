.text
# your strings here

.global sha1_chunk

.data

hashVar_a: .long 1
hashVar_b: .long 1
hashVar_c: .long 1
hashVar_d: .long 1
hashVar_e: .long 1

hashVar_k: .long 1

i: .long 1

.text

 # rdi: [h0, h1, h2, h3, h4], rsi: uint32 v[80]
sha1_chunk:
        # IMPLEMENT ME
        pushq %rbp
        movq %rsp, %rbp

        pushq %rbx # pushes the values from registers to stack
        pushq %r12; 
        pushq %r13;
        pushq %r14;
        pushq %r15;
        subq $16, %rsp # allocate 16 bytes on stack

        movq %rsi, %rbx # set rbx as base pointer
        movq %rdi, %r15 # set r15 as the vector h

        leaq 64(%rbx), %rsi 
        leaq 320(%rbx), %rdi
loop_0:
        movl -12(%rsi), %ecx
        xorl -32(%rsi), %ecx
        xorl -56(%rsi), %ecx
        xorl -64(%rsi), %ecx

        roll $1, %ecx
        addq $4, %rsi # increment pointer

        cmpq %rdi, %rsi # test to see if the first loop is over
        jl loop_1

        movl (%r15), %ebx
        movl %ebx, hashVar_a
        movl 4(%r15), %ebx
        movl %ebx, hashVar_b
        movl 8(%r15), %ebx
        movl %ebx, hashVar_c
        movl 12(%r15), %ebx
        movl %ebx, hashVar_d
        movl 16(%r15), %ebx
        movl %ebx, hashVar_e
        
        movq $0, i # intialize the "i" variable to 0
loop_1:   
        cmpq $80, i # do the loop test
        jge end
        cmpq $19, i
        jle if_2
        cmpq $39, i
        jle if_3
        cmpq $59, i
        jle if_4
        cmpq $79, i
        jle if_3
if_2:
        incq i(%rip)
        
        movl hashVar_b(%rip), %eax
        andl hashVar_c(%rip), %eax

        movl hashVar_b(%rip), %ecx
        notl %ecx
        andl hashVar_d(%rip), %ecx

        xorl %ecx, %eax 

        movl $0x5A827999, hashVar_k # k = 0x5A827999 

        jmp endPart
if_3: 
        incq i(%rip)

        movl hashVar_b(%rip), %eax
        xorl hashVar_c(%rip), %eax
        xorl hashVar_d(%rip), %eax

        movl $0x6ED9EBA1, hashVar_k  # k = 0x6ED9EBA1

        jmp endPart
if_4: 
        incq i(%rip)

        movl hashVar_b(%rip), %eax
        andl hashVar_c(%rip), %eax

        movl hashVar_b(%rip), %ecx
        andl hashVar_d(%rip), %ecx

        xorl %ecx, %eax

        movl hashVar_c(%rip), %ecx
        andl hashVar_d(%rip), %ecx
        
        xorl %ecx, %eax

        movl $0x8F1BBCDC, hashVar_k  # k = 0x8F1BBCDC

        jmp endPart
endPart: 
# stack now is a,b,c,d,e from top to bottom

        # temp = (a leftrotate 5) + f + e + k + w[i])
        movl hashVar_a(%rip), %ecx # temp is ecx
        roll $5, %ecx
        addl %eax, %ecx
        addl hashVar_e(%rip), %ecx
        addl hashVar_k(%rip), %ecx
        movq i(%rip), %rcx
        addl (%rbx, %rcx, 4), %ecx

        movl hashVar_d(%rip), %ebx
        movl %ebx, hashVar_e
        movl hashVar_c(%rip), %ebx
        movl %ebx, hashVar_d
        movl hashVar_b(%rip), %ebx
        movl %ebx, hashVar_c
        roll $30, hashVar_c # FIXME add rip?
        movl hashVar_a(%rip), %ebx
        movl %ebx, hashVar_b
        movl %ecx, hashVar_a

end:    
        movl hashVar_a(%rip), %ebx
        addl %ebx, (%r15)
        movl hashVar_b(%rip), %ebx
        addl %ebx, 4(%r15)
        movl hashVar_c(%rip), %ebx
        addl %ebx, 8(%r15)
        movl hashVar_d(%rip), %ebx
        addl %ebx, 12(%r15)
        movl hashVar_e(%rip), %ebx
        addl %ebx, 16(%r15)

        addq $16, %rsp
        popq %r15
        popq %r14
        popq %r13
        popq %r12
        popq %rbx     

        movq %rbp, %rsp
        popq %rbp

        ret
