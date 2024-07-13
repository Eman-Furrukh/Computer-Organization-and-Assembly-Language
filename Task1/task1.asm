dosseg
.model smaal
.stack 100h
.data
	var1 db ?
	var2 db ?
	var3 db ?
	q db ?
	r db ?
.code
	main proc

	mov ax,@data
	mov ds,ax
	mov ah,1
	int 21h
	mov var1,al
	sub var1,48

	mov ah,1
	int 21h
	mov var2,al
	sub var2,48

	mov ah,1
	int 21h
	mov var3,al
	sub var3,48

	mov al,var2
	mul var1
	add al,var3

	mov bl,10
	div bl

	mov q,al
	mov r,ah

	add q,48
	add r,48

	mov dl,q
	mov ah,2
	int 21h

	mov dl,r
	mov ah,2
	int 21h

	mov ah,4ch
	int 21h
main endp
end main
