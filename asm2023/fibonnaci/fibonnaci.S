global fibonnaci
    section .text

fibonnaci:
    ; check if rdi is negative
    mov rdx, rdi
    shr rdx, 63 
    cmp rdx, 0
    jne negative   ; if rdi is negative, return -1

    cmp rdi, 0
    jle end0     ; if rdi is 0 or 1, return 1
    
    cmp rdi, 1
    jle end1      ; if rdi is 0 or 1, return 1
    
    mov rax, 1
    mov rbx, 1
    mov rcx, rdi    ; rcx = n
    dec rcx

loop:
    cmp rcx, 0
    jle end

    mov rdx, rax
    add rdx , rbx
    mov rax, rbx
    mov rbx, rdx
    dec rcx
    cmp rcx, 0
    jg loop

end:
    ret

end1:
    mov rax, 1
    ret
end0:
    mov rax, 0
    ret

negative:
    mov rax, -1
    ret