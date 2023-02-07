global mymul
    section .text

mymul:
    mov qword [rdx], 0 ; set res->low to 0
    mov qword [rdx+8], 0    ; set res->high to 0


loop:
    cmp rsi, 0
    je end  ; if rsi == 0, end

    add [rdx + 8], rdi ; add rdi to res->high
    adc qword [rdx], 0 ; add carry to res->low

    dec rsi   ; decrement rsi
    jmp loop  ; loop

end:
    ret