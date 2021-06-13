.data #initialized data
msg:
    .ascii "Hola SASM!"
.text #program goes in
.global _main
.extern _printf
_main:
    movl %esp, %ebp #for correct debugging
    push %ebp
    movl %ebp ,%esp
    
    push $msg
    call _printf
    
    movl %esp,%ebp
    pop %ebp
    
    ret
