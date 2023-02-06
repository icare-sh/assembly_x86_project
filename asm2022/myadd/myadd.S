global myadd
    section .text

myadd:
    mov rax, 0   ; rax = 0
    add rax, rdi    ; rax = rax + rdi
    add rax, rsi    ; rax = rax + rsi
    ret