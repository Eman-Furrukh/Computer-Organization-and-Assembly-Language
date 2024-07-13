.model small
.stack 100h
.data
	base db ?
	power db ?
	lab1 db 0Ah,0Dh,'Enter Base:','$'
	lab2 db 0Ah,0Dh,'Enter Power:','$'
.code
main proc
	mov ax, @data
	mov ds,ax
	enter_base:
		lea dx,lab1
		mov ah,09h
		int 21h
		mov ah,01h
		int 21h
		sub al,30h
		mov bl,al
		mov base,al
	enter_power:
		lea dx,lab2
		mov ah,09h
		int 21h
		mov ah,01h
		int 21h
		sub al,30h
		mov cl,al
		dec cl
		mov ax,00
		mov al,base
	label1:
		mul bl
	loop label1
	mov cl,10
	div cl
	add ax,3030h
	mov dx,ax
	mov ah,02h
	int 21h
	mov dl,dh
	int 21h
	mov ah,4ch
	int 21h
main endp
end main