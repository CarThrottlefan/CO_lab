.text
# your strings here

.global sha1_chunk

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
        subq $8, %rsp # allocate 16 bytes on stack

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

        movl %ecx, (%rsi)

        addq $4, %rsi # increment pointer

        cmpq %rdi, %rsi # test to see if the first loop is over
        jl loop_0

        movl (%r15), %r8d        # a = h0
        movl 4(%r15), %r9d       # b = h1
        movl 8(%r15), %r10d      # c = h2
        movl 12(%r15), %r11d     # d = h3
        movl 16(%r15), %r12d     # e = h4
        
        movq $0, %r13 # intialize the "i" variable to 0
loop_1:   
        cmpq $80, %r13 # do the loop test
        jge end
        cmpq $19, %r13
        jle if_2
        cmpq $39, %r13
        jle if_3
        cmpq $59, %r13
        jle if_4
        cmpq $79, %r13
        jle if_5
if_2:
        incq %r13
        
        movl %r9d, %eax
        andl %r10d, %eax

        movl %r9d, %ecx
        notl %ecx
        andl %r11d, %ecx

        xorl %ecx, %eax 

        movl $0x5A827999, %r14d # k = 0x5A827999 

        jmp endPart
if_3: 
        incq %r13

        movl %r9d, %eax
        xorl %r10d, %eax
        xorl %r11d, %eax

        movl $0x6ED9EBA1, %r14d  # k = 0x6ED9EBA1

        jmp endPart
if_4: 
        incq %r13

        movl %r9d, %eax
        andl %r10d, %eax

        movl %r9d, %ecx
        andl %r11d, %ecx

        xorl %ecx, %eax

        movl %r10d, %ecx
        andl %r11d, %ecx
        
        xorl %ecx, %eax

        movl $0x8F1BBCDC, %r14d  # k = 0x8F1BBCDC

        jmp endPart

if_5: 
        incq %r13

        movl %r9d, %eax
        xorl %r10d, %eax
        xorl %r11d, %eax

        movl $0xCA62C1D6, %r14d  # k = 0xCA62C1D6

        jmp endPart
endPart: 
# stack now is a,b,c,d,e from top to bottom

        # temp = (a leftrotate 5) + f + e + k + w[i])
        movl %r8d, %ecx # temp is ecx
        roll $5, %ecx
        addl %eax, %ecx
        addl %r12d, %ecx
        addl %r14d, %ecx # k
        addl -4(%rbx, %r13, 4), %ecx

        movl %r11d, %r12d        # e = d
        movl %r10d, %r11d        # d = c
        movl %r9d, %r10d         # c = b...
        roll $30, %r10d          # ...leftrotate 30
        movl %r8d, %r9d          # b = a
        movl %ecx, %r8d          # a = temp

        jmp loop_1

end:    
        addl %r8d, (%r15)
        addl %r9d, 4(%r15)
        addl %r10d, 8(%r15)
        addl %r11d, 12(%r15)
        addl %r12d, 16(%r15)

        addq $8, %rsp
        popq %r15
        popq %r14
        popq %r13
        popq %r12
        popq %rbx     

        movq %rbp, %rsp
        popq %rbp

        ret
