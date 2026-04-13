section .data 
	name db "Hello, World!"
	len equ $ - name 
	FilePath db "hello.txt"

section .bss
	cream resb 64
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

print_newline:
	
	push 10
	mov rax,1 
	mov rdi,1
	mov rsi,rsp
	mov rdx,1
	syscall 

	pop rax
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
	
	call print_newline
	call print_newline
	call print_newline

	call end_suc 
