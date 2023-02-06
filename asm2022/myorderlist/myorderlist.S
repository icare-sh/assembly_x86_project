section .data
    PROT_READ equ 0x1 ; read
    PROT_WRITE equ 0x2 ; write
    MAP_PRIVATE equ 0x02 ; private
    MAP_ANONYMOUS equ 0x20 ; anonymous
    MAP_FAILED equ -1 ; failed

    STDOUT equ 1 ; stdout

section .text
    global orderlist

orderlist:
    push rbp
    mov rbp, rsp ;
    push rdi ; save rdi [rbp - 8] rdi is a list
    push rsi ; save rsi [rbp - 16] rsi is the size of the list
    mov rcx, rdi ; copy rsi to rcx

    ; write in first value of list
    mov rax , 1 ; write
    mov rdi , STDOUT ; stdout
    mov rsi , rcx ; list[0] = list
    mov rdx , 8 ; size of list[0]
    syscall


exit:
    pop rdi ; restore rdi
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall

end:
    ret

mmap_failed:
    mov rax, -1 ; exit code
    jmp end

newline:
    db 0x0a, 0x00
