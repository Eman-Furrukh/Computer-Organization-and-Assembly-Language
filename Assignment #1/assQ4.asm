;	EMAN FURRUKH	 ;
;	ASSIGNMENT 1	 ;
;	 QUESTION 4	 ;

.model small
.stack 100h
.data
	num dword 12345678h
.code
main proc
	mov ax,@data
	mov ds,ax
	;adding
	mov ax,num
	mov bx,num
	add ax,bx
	mov cx,0F21Ah
	add cx,[0154H]
	mov ah,9FH
	add ah,bh
	ret

	;subtracting
	mov ax, num
	mov bx, num
	sbb ax,bx
	mov si, 0700h
	sbb [si], ax
	ret

	;multiplying
	mov ax, num
	mov bx, num
	mov ax, [si]
	inc ax
	mov bx,[si]
	mul bx
	mov [di], ax
	ret
	
	;dividing
	mov ax,num
	inc ax
	mov bx,ax
	div bx
	mov ax,num
	inc ax
	mov bx,ax
	ret

main endp
end main