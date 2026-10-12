bits 64
global _start

nse à utiliser les balises code quand tu en insères (le # de l'éditeur).

Si ton caractère se déplace trop vite, il te faut faire une temporisation, ton programme attendra la fin de celle-ci avant réexecution de la boucle. Le mieux pour cela est faire une temporisation à l'aide du timer. Pour débuter tu peux utiliser les fonctions intégrées au BIOS (recherche à faire sur timer bios).
section .bss
	filename: resq 3

section .text
	_start:
		mov al, byte [i]
		cmp al, 0
		je _error

		; compilation

		mov eax, 57 ; fork
		syscall
	
		cmp rax, 0
		je _child
		jmp _parent
		
		_child:
			mov rax, 59 ; syscall execve
			lea rdi, [rel comp]
			lea rsi, [rel args_comp]
			lea rdx, [rel envp]
			syscall

		_parent:
			mov rdi, rax ; pid de l'enfant
			xor esi, esi
			xor edx, edx
			xor r10d, r10d
			mov eax, 61
			syscall

		; execution

		mov eax, 57 ; fork
		syscall
	
		cmp rax, 0
		je _child
		jmp _parent
		
		_child:
			mov rax, 59 ; syscall execve
			lea rdi, [rel exec]
			lea rsi, [rel args_exec]
			lea rdx, [rel envp]
			syscall

		_parent:
			mov rdi, rax ; pid de l'enfant
			xor esi, esi
			xor edx, edx
			xor r10d, r10d
			mov eax, 61
			syscall

		mov rax, 60
		mov rdi, 0
		syscall

		_error:
			mov rax, 60
			mov rdi, 1
			syscall


section .data
	i: db 5
	comp: db "/usr/bin/nasm", 0
	arg1: db "-f", 0
	arg2: db "elf64", 0
	arg3: db "Sully_X.s", 0
	args_comp: dq comp, arg1, arg2, arg3, 0
	exec: db "./a.out", 0
	args_exec: dq 0
	envp: dq 0

