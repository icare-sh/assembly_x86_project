global myfilexor
    section .text

extern malloc

; [rbp - 8] = filename
; [rbp - 16] = key
; [rbp - 24] = size
; [rbp - 32] = buffer
; [rbp - 40] = buffer pointer

myfilexor:
    push rbp
    mov rbp, rsp
    push rdi 
    push rsi 
    sub rsp, 128 ; Allocate space in the stack

    ; open file
    mov rax, 2 
    mov rdi, rdi 
    mov rsi, 0 
    syscall
    mov rbx, rax 

    ; get file size
    mov rax, 8
    mov rdi, rbx 
    mov rsi, 0 
    mov rdx, 2 
    syscall
    mov [rbp-24], rax

    ; malloc buffer of size [rbp-24]
    mov rdi, qword [rbp-24] 
    call malloc wrt ..plt
    mov [rbp-32], rax 
    mov [rbp-40], rax 

    ; go to the start of the file
    mov rax, 8
    mov rdi, rbx 
    mov rsi, 0 
    mov rdx, 0 
    syscall

    ; read file
    mov rax, 0
    mov rdi, rbx 
    mov rsi, qword [rbp-40] 
    mov rdx, qword [rbp-24] 
    syscall

loop:
    ; xor
    mov rax, qword [rbp-16]
    mov rcx, [rbp-40]
    xor byte [rcx], al

    ; increment buffer pointer and decrement size
    dec qword [rbp-24]
    inc qword [rbp-40]

    ; if size is 0, break
    cmp dword [rbp-24], 0
    jne loop

    ; pop and return
    mov rax, qword [rbp-32]
    add rsp, 128 ; free the stack
    pop rsi
    pop rdi
    pop rbp
    ret