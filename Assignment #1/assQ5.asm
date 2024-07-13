;	EMAN FURRUKH	;
;	ASSIGNMENT 1	;
;	 QUESTION 5	;

dosseg
.model small
.stack 100h
.data
.code
main proc
	mov bx,1
	mov cx,5
L1:
	push cx
	mov cx,bx

L2:
	mov dl,'*'
	mov ah,2
	int 21h
loop L2
	
	mov dl,10
	mov ah,2
	int 21h
	mov dl,13
	mov ah,2
	int 21h
	inc bl
	pop cx
loop L1

	mov bx,5
	mov cx,5
	
L3:
	push bx
	mov bx,cx

L4:
	mov dl,'*'
	mov ah,2
	int 21h
loop L4

	mov dl,10
	mov ah,2
	int 21h
	mov dl,13
	mov ah,2
	int 21h
	dec bl
	pop cx
loop L3
	jmp Exit
	
Exit:
	mov ah,4ch
	int 21h

main endp
end main