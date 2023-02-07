global orderlist
    section .text

orderlist:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    sub rsp, 128

    ; allocate space for a char * buffer with syscall mmap
    mov rdi, 0    ; address
    mov rsi, 0x1000 ; size
    mov rdx, 0x1 | 0x2  ; read/write
    mov r10, 0x02 | 0x20 ; anonymous, private
    mov r8, -1    ; fd
    mov r9, 0     ; offset
    mov rax, 9    ; syscall number
    syscall

    mov rcx, rax    ; save the address of the buffer in rcx
    ; put some data in the buffer
    mov rdi, rcx
    mov rsi, 0x41; A
    mov [rdi], rsi ; buffer[0] = 0x4141414141414141

    ; rwrite the buffer to stdout
    mov rdi, 1    ; fd
    mov rsi, rcx    ; buffer
    mov rdx, 0x1000 ; size
    mov rax, 1    ; syscall number
    syscall



end: 
    mov rax, 60
    xor rdi, rdi
    syscall
    pop rsi
    pop rdi
    pop rbp
    ret
