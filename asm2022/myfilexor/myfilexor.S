global myfilexor
    section .text

extern malloc
extern fgetc

myfilexor:
    push rbp              ; save the base pointer
    mov rbp, rsp          ; set the base pointer to the stack pointer
    push rdi              ; save the first argument
    push rsi              ; save the second argument

    ; open the file 
    mov rax, 2            ; system call number for open
    mov rdi, [rbp - 8]    ; first argument is the filename
    mov rsi, 0            ; second argument is the flags (0 = read only)
    syscall               ; call the system call