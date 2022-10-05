.global _start

.section .text
_start:

#movq %rbp, %rsp

# initialize registers
# head --> %rax
# &head --> %rbx
# source --> %rcx
# destination --> %rdx
movq head(%rip), %rax
lea head, %rbx
xorq %rcx, %rcx
xorq %rdx, %rdx

#tmp register - probably wont need to initialize
xorq %rsi, %rsi

.first_check:
#%rax is contains the adress val' mean it is the ptr of the node
# this is why we cmp %ran to null
cmpq $0, %rax
je .end

.loop:
movq (%rax), %rsi
cmpq src, %rsi
jne .next1
# we save the adress of next pointing to src
movq %rbx, %rcx
.next1:
cmp dst, %rsi
jne .next2
# we save the adress of next pointing to dst
movq %rbx, %rdx
.next2:
cmpq $0, %rdx
jne .dst_not_zero
jmp .next_move


.dst_not_zero:
movq %rdx, %rsi
addq %rcx, %rsi
cmpq %rdx, %rsi
je .end

# swap nodes
# src --> r9
movq (%rcx), %r9
# src->next  --> r10
movq (%rcx), %rsi
lea 8(%rsi), %r10
#maby more organized
movq (%r10), %r14
# dst --> r11
movq (%rdx), %r11
# dst->next --> r12
movq (%rdx), %rsi
lea 8(%rsi), %r12
movq (%r12), %r13

# check if nodes are connected one after the other
movq (%rcx), %rsi
addq $8, %rsi
cmpq %rsi, %rdx
je .one_after_another

movq %r11, (%rcx)
movq %r14, (%r12)
movq %r9, (%rdx)
movq %r13, (%r10)
jmp .end

.one_after_another:
movq %r11, (%rcx)
movq %r9, (%r12)
movq %r13, (%r10)
jmp .end


.next_move:
lea 8(%rax), %rbx
movq 8(%rax), %rax
jmp .first_check

.end:
nop
