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

        movq $0, %r9 # intialize the "i" variable to 0
        cmpq $79, %r9 # do the loop test
        je endFor

        cmpq $19, %r9
        je if

if:

        # create temp vars, or see how to implement the gates - copy into registers???

