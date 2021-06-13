mov ax,0xb800
mov ds,ax
mov byte [0x00],'a'
mov byte [0x02],'s'
mov byte [0x04],'m'
jmp $

;
times 510-($-$$) db 0
db 0x55,0xaa

;make it bootable
;The last 2 bytes should be 0x55 and 0xaa
;$-$$ gives you the offset from start to address of the currently executed instruction.
; If subtract that value from 510 you will get the offset from the address of the currently executed instruction to the 510th byte.
;The times directive will pad that number of bytes up to 510th byte with zeros.