global myitoa
    section .text

myitoa:
    mov rax , 0 
    mov rbx, 0 ; flag for negative
    mov rcx , 0 ; counter = 0
    cmp byte [rdi], '-'
    jne loop

    mov rbx, 1 ; flag for negative
    inc rdi 

loop:
    cmp byte [rdi], 0
    je end

    ; rcx = rcx * 10 + (rdi - '0')
    mov rax, rcx 
    imul rax, 10 
    mov rcx, rax 
    movzx rax, byte [rdi] 
    sub rax, '0' 
    add rcx, rax 

    inc rdi
    jmp loop

end:
    cmp rbx, 1 ; check if negative
    je negative

    mov rax, rcx ; return the result
    ret

negative:
    neg rcx ; negate the result
    mov rax, rcx ; return the result
    ret
