.model small
.stack 100h
.data
.code
	main proc
	mov bh,'5'
	mov bl,'5'

	CMP bh,bl

	JE L1:

	mov dl,'N'
	mov ah,02h
	int 21h

	mov ah,4ch
	int 21h

	L1:
	mov dl,'E'
	mov ah,02h
	int 21h

	mov ah,4ch
	int 21h
main endp
end main
