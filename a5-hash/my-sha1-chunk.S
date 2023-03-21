.text
# your strings here

.global sha1_chunk

global.data 

hashVar_a DQ 1
hashVar_b DQ 1
hashVar_c DQ 1
hashVar_d DQ 1
hashVar_e DQ 1

hashVar_f DQ 1
hashVar_k DQ 1

temp_1 

sha1_chunk:
        # IMPLEMENT ME
        pushq %rbp
        movq %rsp, %rbp

        movq hashVar_a, %rdi # copy the value of rdi to a
        movq hashVar_b, %rsi
        movq hashVar_c, %rdx
        movq hashVar_d, %rcx
        movq hashVar_e, %r8;

        movq $16, %rdi;
        compq $79, %rdi;
        jmp if_1
        je end

if_1:   
        # implement the arrary part (the first for loop)


        subq $48, %rsp # allocate 48 bytes on stack
 
        # FIXME need to push the w to the stack 
        /*movq hashVar_e(%rip), -8(%rbp); # move the values from registers to stack, to free them
        movq hashVar_a(%rip), -16(%rbp);
        movq hashVar_d(%rip), -24(%rbp);
        movq hashVar_c(%rip), -32(%rbp);
        movq hashVar_b(%rip), -40(%rbp); */

        pushq hashVar_e; # pushes the values from registers to stack, to free them 
        pushq hashVar_a; # FIXME maybe needs (%rip) ??
        pushq hashVar_d;
        pushq hashVar_c;
        pushq hashVar_b;

        movq $0, %r9 # intialize the "i" variable to 0
        cmpq $79, %r9 # do the loop test
        je endFor

        cmpq $19, %r9
        je if_2
if_2:

        popq %rdi; # rdi holds b, rsi holds c, rdx holds d
        popq %rsi     
        popq %rdx

        and %rsi, %rdi; # rsi holds the value of the first and
        not %rdi # not b
        and %rdx, %rdi # second and, stored in rdx
        xor %rsi, %rdx; # does the xor comparison, moves result to rsi
        movq hashVar_f, %rsi; # moves result to f;
        movq hashVar_k, 0x5A827999 # gives k the value from the pseudocode

        pushq hashVar_d; # pushes the og vals of b,c,d back in the stack
        pushq hashVar_c;
        pushq hashVar_b;

        jmp endPart
endPart: 
        temp DQ 1
# stack now is b, c, d, a, e from top to bottom
        pushq %rdi;
        pushq %rsi;
        pushq %rdx;
        pushq %rcx;
        pushq %r8;

        rol %rcx, 5;
        addq temp, %rcx;
        addq temp, hashVar_f;
        addq temp, hashVar_e;
        addq temp, hashVar_k;
        addq temp, # FIXME see how to get the value of the w[i] to here.
        # create temp vars, or see how to implement the gates - copy into registers???

