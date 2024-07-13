.model small
.stack 100h
.data
.code
	main proc
	mov dl, 'A'
	mov cx, 26
L1:
	mov ah,02
	int 21h
	inc dl
loop L1

	mov cx, 27
L2:
	mov ah,02
	int 21h
	dec dl
loop L2

	mov ah,4ch
	int 21h
main endp
end main
