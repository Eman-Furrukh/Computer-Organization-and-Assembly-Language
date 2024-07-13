.model small
.stack 100h

printmsg macro msg
push ax
push bx
push cx
push dx
LEA dx,msg
mov ah,09h
int 21h
pop dx
pop cx
pop bx
pop ax
endm

.data
prompt1 db 0ah,0dh,"Enter First String: $"
prompt2 db 0ah,0dh,"Enter Second String:$"
prompt3 db 0ah,0dh,'$'
Equal db 0ah,0dh,"Strings aren't equal$"
NotEqual db 0ah,0dh,"Strings are equal$"
str1 db 50 dup('$')
str2 db 50 dup('$')

.code
START:
	mov ax,@data
	mov ds,ax
	mov es,ax
	printmsg prompt1
	lea dx,str1
	number=0ah
	mov ah,0ah
	int 21h
	printmsg prompt3
	printmsg prompt2
	LEA dx, str2
	mov ah,0ah
	int 21h
	call equalsIgnoreCase
	cmp cx,00h
	jne NoEqual
	printmsg Equal
	jmp L1

NoEqual:
	printmsg NotEqual

L1:
	mov ah,4ch
	int 21h


equalsIgnoreCase proc near
	lea si,str1
	call toUpper 
	lea si,str2
	call toUpper 
	lea si,str1
	mov cl,[si+1] 
	mov ch,00h
	cld 
	add si,02h 
	lea di,str2 
	add di,02h 
	repe cmpsb 
	cmp [di],0dh 
	je Str2End
	mov cx,01h
	Str2End: 
		ret
equalsIgnoreCase endp

toUpper proc near
	mov cl,[si+1] 
	mov ch,00h
	add si,02h 
ToLower:
	cmp [si],61h 
	jl L2
	cmp [si],7ah
	jg L2
	sub [si],20h 
L2:
	inc si
	loop ToLower
	ret
toUpper endp

end start