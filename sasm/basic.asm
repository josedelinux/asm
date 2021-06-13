%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    mov eax,5
    mov ebx,10
    add eax,ebx
    mov ebx,20
    add eax,ebx
    xor eax, eax
    ret