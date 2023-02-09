global mydiv
section .text

mydiv:
    mov rbx, rdx ; store address of  rbx
    ; check if divisor = 0
    cmp rsi, 0
    je  error

    ; divide rdi by rsi
    mov rax, rdi
    mov rdx, 0
    div rsi

    ; store quotient in [rbx]
    mov qword [rbx], rax

    ; store remainder in [rbx + 8]
    mov qword [rbx + 8], rdx

    mov rax, 1 ; set return value to 1

end:
    ret

error:
    mov rax, 0 ; set return value to 0
    mov qword [rbx], 0
    mov qword [rbx + 8], 0
    jmp end