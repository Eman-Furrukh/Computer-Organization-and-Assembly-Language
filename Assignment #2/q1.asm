.model small
.stack 100h
.data
    array db 3 dup (3 dup(0))
    rowsize dw 3
    prompt DB 0dh,0ah,"The sum is: $"
    typeofarray dw ?

.code
main:
    mov ax,@data
    mov ds,ax

    mov bx,0
    mov si,0

L1:
	mov si,0

L2:
	mov ah,01h
	int 21h
	and al,0Fh
	mov array[bx+si],al
	inc si

	cmp si,3
	jnz L2
	mov dl,10
	mov ah,02h
	int 21h
	add bx,3
	cmp bx,9
	jnz L1

	mov ax,0
	mov bx,offset array
	mov ah,01h
	int 21h
	mov ah,0
	and al,0Fh
	mul rowsize
	push ax
	mov cx,rowsize
	push cx
	add bx,ax
	push bx
	mov ax,0

	mov typeofarray,type array
	mov dx,typeofarray
	push dx
	mov ax,0
	mov dx,0

    mov dx,offset prompt
    mov ah,09h
    int 21h

	call Sum

	mov dx,ax
	add dx,48
	mov ah,02h
	int 21h

exit:
	mov ah , 4ch 
	int 21h

Sum PROC 
    pop si
    pop dx
    pop bx
    pop cx   

    mov ax,0
loop1:
    add ax,[bx]
    add bx,dx
    loop loop1
    push si
	add bx, 48
    RET
Sum ENDP

end main