;代码清单5-1 
;文件名：c05_mbr.asm
;文件说明：硬盘主引导扇区代码
;创建日期：2011-3-31 21:15 
 
;以上两句，相当于设置段的起始地址为0xb8000，存放在寄存器es中，因为处理器在处理段地址时，会将段地址左移4位。intel不允许直接将立即数放到
 
	mov ax,0xb800                 ;指向文本模式的显示缓冲区
	mov es,ax
 
;在段内偏移从0X00--0x19放置字符串，放置显存是，先放置ASCII字符，然后放置显示格式，显示格式又分为前景色和背景色，用1个字节表示
;以下显示字符串"Label offset:"
	mov byte [es:0x00],'L'
	mov byte [es:0x01],0x07       ;显示字符的背景色和前景色
	mov byte [es:0x02],'a'
	mov byte [es:0x03],0x07
	mov byte [es:0x04],'b'
	mov byte [es:0x05],0x07
	mov byte [es:0x06],'e'
	mov byte [es:0x07],0x07
	mov byte [es:0x08],'l'
	mov byte [es:0x09],0x07
	mov byte [es:0x0a],' '
	mov byte [es:0x0b],0x07
	mov byte [es:0x0c],"o"
	mov byte [es:0x0d],0x07
	mov byte [es:0x0e],'f'
	mov byte [es:0x0f],0x07
	mov byte [es:0x10],'f'
	mov byte [es:0x11],0x07
	mov byte [es:0x12],'s'
	mov byte [es:0x13],0x07
	mov byte [es:0x14],'e'
	mov byte [es:0x15],0x07
	mov byte [es:0x16],'t'
	mov byte [es:0x17],0x07
	mov byte [es:0x18],':'
	mov byte [es:0x19],0x07
 
	;mov ax,number                 ;取得标号number的偏移地址
	mov ax,0x99                 ;取得标号number的偏移地址
	mov bx,10
 
	;设置数据段的基地址
	mov cx,cs
	mov ds,cx
 
	;求个位上的数字
	mov dx,0
	div bx
	mov [0x7c00+number+0x00],dl   ;保存个位上的数字
 
	;求十位上的数字
	xor dx,dx
	div bx
	mov [0x7c00+number+0x01],dl   ;保存十位上的数字
 
	;求百位上的数字
	xor dx,dx
	div bx
	mov [0x7c00+number+0x02],dl   ;保存百位上的数字
 
	;求千位上的数字
	xor dx,dx
	div bx
	mov [0x7c00+number+0x03],dl   ;保存千位上的数字
 
	;求万位上的数字 
	xor dx,dx
	div bx
	mov [0x7c00+number+0x04],dl   ;保存万位上的数字
 
	;以下用十进制显示标号的偏移地址
	mov al,[0x7c00+number+0x04]
	add al,0x30      ;0x30是'0'的ascii字符，将该字符加上0的ascii字符
	mov [es:0x1a],al ;将该字符送到es:0x1a的位置显示
	mov byte [es:0x1b],0x04;设置显示的属性
 
	mov al,[0x7c00+number+0x03]
	add al,0x30
	mov [es:0x1c],al
	mov byte [es:0x1d],0x04
 
	mov al,[0x7c00+number+0x02]
	add al,0x30
	mov [es:0x1e],al
	mov byte [es:0x1f],0x04
 
	mov al,[0x7c00+number+0x01]
	add al,0x30
	mov [es:0x20],al
	mov byte [es:0x21],0x04
 
	mov al,[0x7c00+number+0x00]
	add al,0x30
	mov [es:0x22],al
	mov byte [es:0x23],0x04
 
	mov byte [es:0x24],'D'
	mov byte [es:0x25],0x07
 
infi: jmp near infi                 ;无限循环
 
	number db 0,0,0,0,0
 
times 203 db 0
	db 0x55,0xaa