.global _start

.section .text
_start:
movq %rsp, %rbp
xor %rbx,%rbx #counter of on bits
movq $64,%rcx #counter in loop
movq (num),%rdx

_for:
    salq $1,%rdx
    jb _onBits #if bit that came into cf is a 1 then jump
    loop _for
    jmp _end
_onBits:
    inc %rbx
    loop _for
_end:
movl %ebx,(countBits)



