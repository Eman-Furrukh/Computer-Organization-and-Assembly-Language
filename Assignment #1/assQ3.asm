;	EMAN FURRUKH	;
;	ASSIGNMENT 1	;
;	 QUESTION 2	;

.model small
.stack 100h
.data
	a db "Enter a: $"
	b db "Enter b: $"
	c db "Enter c: $"
	d db "Enter d: $"
	e db "Enter e: $"
	f db "Enter f: $"
	g db "Enter g: $"
.code
main proc 
	mov ax,@data
	mov ds,ax
	
	lea dx,g
	mov ah,09h
	int 21h
	mov ah,01
	int 21h

	lea dx,f
	mov ah,09h
	int 21h
	mov ah,01
	int 21h
	
	mov ax,g
	cmp ax,f
	je L1
	
	lea dx,e
	mov ah,09h
	int 21h
	mov ah,01
	int 21h

	lea dx,d
	mov ah,09h
	int 21h
	mov ah,01
	int 21h
	
	mov ax,e
	cmp ax,d
	jne L1
	
	
main endp
end main