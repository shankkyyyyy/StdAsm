section .data 
	FilePath db "hello.txt"
	string db "124"
section .bss
	cream resb 64
	loc resb 124 
section .text 
	global print 
	global _start
;	
; rbp 
; ret 8
; 2 16 
; 1 24

print_2:
	; saving rbp 
	push rbp 
	; moving stack pointer to rbp [base pointer]
	mov rbp,rsp 

	; first argument should be the pointer 
	; second argument should be the length

	mov rax,1
	mov rdi,1
	mov rsi,[rbp + 24]
	mov rdx,[rbp + 16]
	syscall 

	pop rbp 
	ret 

input_2:
	; saving rbp 
	push rbp 

	; moving stack pointer to base pointer 
	mov rbp,rsp 

	;first argument should be the pointer to buffer 
	;second argumnet should be the size of the buffer 

	;; syscall function
	mov rax,0 
	mov rdi,0 
	mov rsi,[rbp + 24]
	mov rdx,[rbp + 16]
	syscall 

	;; poping hte base pointer 
	pop rbp 
	; returning 
	ret

fprint_3:
	; pushing rbp to stack 
	push rbp 
	; moving stack pointer to base pointer 
	mov rbp,rsp 

	; first argument should be the file descriptor 
	; second argument should be the buffer pointer to write to fp 
	; third argument should be the size of the buffer 

	mov rax,1
	mov rdi,[rbp + 32]
	mov rsi,[rbp + 24]
	mov rdx,[rbp + 16]
	syscall 

	pop rbp 
	ret


fd_close:

	push rbp 
	mov rbp,rsp 

	mov rax,3
	mov rdi,[rbp + 16]
	syscall 

	pop rbp 
	ret 

print_newline:
	
	push 10

	mov rax,1 
	mov rdi,1
	mov rsi,rsp
	mov rdx,1
	syscall 

	pop rax
	ret 

ToInt:
	

	push rbp 
	mov rbp,rsp 

	; first argument pointer to string 
	; second argument pointer to int location 
	mov r8,[rbp + 24]
	mov rdi,0 
	mov rdx,0
	mov rsi,0
	jmp compare 

compare:
	cmp byte [r8 + rdi],0 ; compares if it is zero or not;
	je Int_Finshed
	movzx rsi, byte[r8 + rdi] ; '129' -> '1' || '2'
	sub rsi,48 ; 1 ; 2

	imul rdx,10 ;-> 0 + 1 = 1 | 10  
	add rdx,rsi ; -> 0 + 1 = 1 | 10 + 2 -> 12

	add rdi,1
	jmp compare

Int_Finshed:
	; debug 
	; write the code which returns the int in a memory addres; rbp + 24
	
	mov [rbp + 16],rdx
	pop rbp
	ret

fopen_3:
	; pushing rbp to the stack 
	push rbp 

	mov rbp,rsp 

	; first argument should be file path 
	; second argument should be flags 
	; third argument should be permissions 

	mov rax,2
	mov rdi,[rbp + 32]
	mov rsi,[rbp + 24]
	mov rdx,[rbp + 16]
	syscall 

	pop rbp 
	ret 



end_suc:	
	; this will exit program with a success value of 0  
	mov rax,60
	mov rdi,0
	syscall 

_start:

	push stringmore
	push fork
	push idc
	push string
	push loc
	call ToInt

	add rsp,24
	
	push loc
	push 124
	call print_2
	add rsp,24

	call end_suc 
