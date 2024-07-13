dosseg
.model small
.stack 100h
.386
.data
	val1 db ?
.code
main proc
	mov ax,@data
	mov ds,ax
	mov ah , 01
	int 21h
	sub al,48
	clc
	mov bl,cl
	rcl al,2
	add al,48
	mov dl,al
	mov ah,2
	int 21h
	rcr bl,2
	add bl,48
	mov dl,bl
	mov ah,2
	int 21h
	mov ah,4ch
	int 21h
main endp
end main