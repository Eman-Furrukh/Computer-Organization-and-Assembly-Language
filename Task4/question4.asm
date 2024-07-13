.model small
.stack 100h
.data
	num1 dd 02h
	num2 dw 03h
	q dw ?
	r dw ?
.code
main proc
	mov ax,@data
	mov ds,ax
	lea si,num1
	mov ax,[si]
	mov dx,[si+2]
	div num2
	mov q,ax
	mov r,dx
	mov ah,4ch
	int 21h
main endp
end main

	