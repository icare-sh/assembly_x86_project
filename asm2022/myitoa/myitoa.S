global myitoa
    section .text

myitoa:
    mov rax , 0 
    mov rbx, 0 ; flag for negative
    mov rcx , 0 ; counter = 0
    cmp byte [rdi], '-'
    jne positive

    mov rbx, 1 ; flag for negative
    inc rdi ; skip the '-'

positive:
    cmp byte [rdi], 0
    je end

    mov rax, rcx ; save rcx
    imul rax, 10 ; multiply by 10
    mov rcx, rax ; save the result
    movzx rax, byte [rdi] ; get the digit
    sub rax, '0' ; convert to number
    add rcx, rax ; add to the result

    inc rdi ; next digit
    jmp positive

end:
    cmp rbx, 1 ; check if negative
    je negative

    mov rax, rcx ; return the result
    ret

negative:
    neg rcx ; negate the result
    mov rax, rcx ; return the result
    ret
