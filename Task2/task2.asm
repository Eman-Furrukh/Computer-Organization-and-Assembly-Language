dosseg
.model small
.stack 100h
.386
.data
	var db ?
.code
main proc
	mov ax,@data
	mov ds,ax

	mov ah,1
	int 21h
	mov ah, 0
	sub al,48
	mov bl,al

	shl al,2
	mov dl,al
	add dl, 48
	mov ah,2
	int 21h

	shr bl,2
	mov dl,bl
	add dl, 48
	mov ah,2
	int 21h

	mov ah,4ch
	int 21h
main endp
end main
