global myadd
    section .text

myadd:
    mov rax, 0
    add rax, rdi
    add rax, rsi
    ret