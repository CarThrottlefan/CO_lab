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
        movl -12(%rsi), %rcx
        xorl -32(%rsi), %rcx
        xorl -56(%rsi), %rcx
        xorl -64(%rsi), %rcx

        roll $1, %rcx
        addq $4, %rsi # increment pointer

        cmpq %rdi, %rsi # test to see if the first loop is over
        jl loop1

        movl (%r15), hashVar_a
        movl 4(%r15), hashVar_b
        movl 8(%r15), hashVar_c
        movl 12(%r15), hashVar_d
        movl 16(%r15), hashVar_e
        
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

        movl hashVar_b(%rip), %rcx
        notl %rcx
        andl %hashVar_d(%rip), %rcx

        xorl %rcx, %eax 

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

        movl hashVar_b(%rip), %rcx
        andl hashVar_d(%rip), %rcx

        xorl %rcx, %eax

        movl hashVar_c(%rip), %rcx
        andl hashVar_d(%rip), %rcx
        
        xorl %rcx, %eax

        movl $0x8F1BBCDC, hashVar_k  # k = 0x8F1BBCDC

        jmp endPart
endPart: 
# stack now is a,b,c,d,e from top to bottom

        # temp = (a leftrotate 5) + f + e + k + w[i])
        movl hashVar_a(%rip), %rcx # temp is rcx
        roll $5, %rcx
        addl %eax, %rcx
        addl hashVar_e(%rip), %rcx
        addl hashVar_k(%rip), %rcx
        movl i(%rip), %eax
        addl (%rbx, %eax, 4), %rcx

        movl hashVar_d(%rip), hashVar_e
        movl hashVar_c(%rip), hashVar_d
        movl hashVar_b(%rip), hashVar_c
        roll $30, hashVar_c # FIXME add rip?
        movl hashVar_a(%rip), hashVar_b
        movl %rcx, hashVar_a

end:    
        addl hashVar_a(%rip), (%r15)
        addl hashVar_b(%rip), 4(%r15)
        addl hashVar_c(%rip), 8(%r15)
        addl hashVar_d(%rip), 12(%r15)
        addl hashVar_e(%rip), 16(%r15)

        addq $8, %rsp
        popq %r15
        popq %r14
        popq %r13
        popq %r12
        popq %rbx     

        movq %rbp, %rsp
        popq %rbp

        ret

