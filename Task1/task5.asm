.model small
.stack 100h
.data
.code

main proc

mov ah,01h
int 21h
mov bl,al


mov cx,5 
L1:
mov ah,01h
int 21h
mov dh,al
	cmp dh,bl
	jne F
	inc cx

Loop L1


F:
	mov cx,0
	mov ah,4ch
	int 21h

mov ah,4ch
int 21h

main endp
end main
