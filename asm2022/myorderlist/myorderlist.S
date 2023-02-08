global orderlist
    section .text

orderlist:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    sub rsp, 128
    mov dword [rbp - 64], 0
    mov dword [rbp - 56], 1
    
print:
    ; allocate space for a char * buffer with syscall mmap
    mov rdi, 0    ; address
    mov rsi, 0x1000 ; size
    mov rdx, 0x1 | 0x2  ; read/write
    mov r10, 0x02 | 0x20 ; anonymous, private
    mov r8, -1    ; fd
    mov r9, 0     ; offset
    mov rax, 9    ; syscall number
    syscall
    
    mov r8, [rbp - 64]
    mov r9, [rbp - 56]
    
atoi:
    ; rdi = source integer
    ; rbx = Target address (buffer)
    mov rdi , [ rbp - 8]
    mov rbx, rax   ; save the address of the buffer in rbx
    mov rcx, rax  ; save the address of the buffer in rcx
    mov rdx, 10   ; base
    mov rax, [rdi + r8] ; rax = *rdi

divrem:
    push rdx
    push rcx
    mov rcx, rdx   ; base
    xor rdx, rdx   ; rdx = 0
    div rcx       ; rax = rax / rcx, rdx = rax % rcx
    cmp rdx, 9    ; rdx > 9
    ja uppercase
    
    add rdx, '0'  ; dl = '0123456789'[rdx]
    jmp writechar
    uppercase:
        sub rdx, 10 ; rdx = rdx - 10
        add rdx, 'A' ; dl = 'ABCDEF'[rdx]
        mov byte dl, [rdx]  ; dl = 'ABCDEF'[rdx]
    writechar:
        mov byte [rbx], dl ; write the character to the buffer
        pop rcx
        pop rdx
        inc rbx ; increment the buffer pointer
        cmp rax, 0 ; rax == 0
        jne divrem ; if rax != 0, then continue
        mov rax, rcx ; restore the address of the buffer
reverse:
    cmp rax, rbx
    jge endreverse
    mov dl, [rax]
    mov dh, [rbx]
    mov [rax], dh
    mov [rbx], dl
    inc rax
    dec rbx
    jmp reverse
endreverse:
    mov rax, rcx
write:
    ; rwrite the buffer to stdout
    mov rdi, 1    ; fd
    mov rsi, rax  ; buffer
    mov rdx, 0x1000 ; size
    mov rax, 1    ; syscall number
    syscall

    add dword [rbp - 64], 8
    
    inc dword [rbp - 56]
    cmp r9, [rbp - 16]
    jne print
end: 
    mov rax, 60
    xor rdi, rdi
    syscall
    pop rsi
    pop rdi
    pop rbp
    ret
