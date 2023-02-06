global mymul
mymul:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rax, rdi
    mul rsi
    mov [rbp-8], rax
    mov [rbp-16], rdx
    mov rax, [rbp-8]
    mov rdx, [rbp-16]
    add rsp, 16
    pop rbp
    ret