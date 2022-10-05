.global _start
      
.section .text
/*
program adds node to binary tree using binary search
there are no two nodes in tree with same value,
if new node has same value as a node in the tree then isnt added
algorithm ends when finds leaf

   rax - current node value
   rbx - rson address
   rcx - lson address
   rdx - current address
   r8  - new_node value */

_start:
movq %rsp, %rbp             #for correct debugging
movq (new_node),%r8
movq $root,%rdx
movq root(%rip),%rax
#check if empty
cmp $0,%rax
jz connect_first

movq (root),%rdx            #move first nodes address from root into %rdx
movq (%rdx),%rax            #move value of first node into %rax
movq 8(%rdx),%rbx           #move lson address into %rbx
movq 16(%rdx),%rcx          #move rson address into %rcx
xor %rdi,%rdi               #flag of came from left son or right if left son then will be on

cmpq %r8,%rax
jg lson                     #if rax is bigger than value of new node than search left tree
je end                      #if is equal then node already exists
jmp rson

lson:
movq $1,%rdi
cmp $0,%rbx                 #if the address is 0 then we found a leaf
jz connect
movq %rbx,%rdx              #move current nodes address from %rbx into %rdx
movq (%rdx),%rax            #move value of node into %rax
movq 8(%rdx),%rbx           #move lson address into %rbx
movq 16(%rdx),%rcx          #move rson address into %rcx
cmpq %r8,%rax
jg lson                     #if rax is bigger than value of new node than search left tree
je end
jmp rson

rson:
movq $0,%rdi
cmp $0,%rcx                 #if the address is 0 then we found a leaf
jz connect
movq %rcx,%rdx              #move nodes address from %rcx into %rdx
movq (%rdx),%rax            #move value of node into %rax
movq 8(%rdx),%rbx           #move lson address into %rbx
movq 16(%rdx),%rcx          #move rson address into %rcx
cmpq %r8,%rax 
jg lson                     #if rax is bigger than value of new node than search left tree
je end
jmp rson

connect:                        #if we get to a leaf we can add
cmp $0,%rdi                 #if 0 then came from right son
jz right
movq $new_node,8(%rdx)         #connect to father if was left son or right son
jmp end
right:
movq $new_node,16(%rdx) 
jmp end 

connect_first:
movq $new_node,(%rdx) 

end:

