.global _start

.section .text
_start:

movq %rsp, %rbp

#define number of iterations - that equals to the num of bytes to copy
xorq %rax, %rax
movl num, %eax
cdq

#check if %edx that continains the sign is 1 or 0 
cmp $0, %edx
#if it is a positive number (%edx == 0) --> (ZF == 1) - continue program
je .continue
# num < 0
movl %eax, destination
jmp .end


.continue:
#define registers as source and destination
lea source, %rbx
lea destination, %rcx

#tmp register
xorq %rdx, %rdx

cmpq %rbx, %rcx
je .end
ja .end_to_beggining

.loop:
cmpl $0, %eax
je .end
movb (%rbx), %dl
movb %dl, (%rcx)
inc %rbx
inc %rcx
dec %eax
jmp .loop

.end_to_beggining:
addq %rax, %rbx
dec %rbx
addq %rax, %rcx
dec %rcx

.loop2:
cmpl $0, %eax
je .end
movb (%rbx), %dl
movb %dl, (%rcx)
dec %rbx
dec %rcx
dec %eax
jmp .loop2

.end:
nop




