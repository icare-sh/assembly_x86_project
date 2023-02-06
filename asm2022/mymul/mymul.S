global mymul
    section .text

mymul:
    mov qword [rdx], 0 ; set res->low to 0
    mov qword [rdx+8], 0    ; set res->high to 0

    cmp rsi, rdi    ; check which is bigger 
    jle mymul_loop_rdi  ; if rsi is bigger or equal, jump to mymul_loop_rdi

mymul_loop_rsi:
    cmp rdi, 0   
    je end              ; if rdi is 0, end

    add [rdx + 8], rsi  ; add rsi to res->high
    jnc continue_rsi    

    ; handle overflow
    add qword [rdx], 1

; continue with rsi
continue_rsi: 
    sub rdi, 1
    jmp mymul_loop_rsi

mymul_loop_rdi:
    cmp rsi, 0
    je end          ; if rsi is 0, end

    add [rdx + 8], rdi      ; add rdi to res->high
    jnc continue_rdi    

    ; handle overflow
    add qword [rdx], 1


continue_rdi:
    sub rsi, 1
    jmp mymul_loop_rdi

end:
    ret