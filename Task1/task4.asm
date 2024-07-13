.model small
.stack 100h
.data
.code
main proc
mov ah,01h
int 21h
add al,48

	mov bl,2
	div bl

cmp ah,0

je True
	mov dx, 13
	mov ah, 02
	int 21h
mov dx,10
mov ah,02
int 21h 
;False case
	mov dl,'O'
	mov ah,02h
	int 21h

mov ah,4ch
int 21h

;True Case
True:
mov dx, 13
mov ah, 02
int 21h

mov dx,10
mov ah,02
int 21h 

mov dl,'E'
mov ah,02h
int 21h

mov ah,4ch
int 21h


main endp
end main
