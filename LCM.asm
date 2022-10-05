.global _start

.section .text
_start:
	movq %rsp,%rbp
	xorq %rax,%rax
	xorq %rbx,%rbx
	xorq %rcx,%rcx
	xorq %rdx,%rdx
	movq (a),%rax
	movq (b),%rbx
gcd:
	divq %rbx
	movq %rbx,%rax
	movl %edx,%ebx
	xorq %rdx,%rdx
	cmpl $0,%ebx
	jne gcd
#lcm = a*b/(a,b) first divide then multiply so doesnt overflow
	movq %rax,%rbx
	movq (a),%rax
#%rax = a/(a,b)
	divq %rbx
	movq (b),%rbx
#%rax = b*%rax = lcm
	mulq %rbx
	movq %rax,(c)
