.model small 
.stack 100h
.data
	time db 22
	str1 db 'Good Morning$'
	str2 db 'Good Day$'
	str3 db 'Good Evening$'
.code
	main proc

	mov ax,@DATA
	mov ds,ax
	mov al,time
	cmp al,10
	ja Label1
	Label1:
		mov dx,offset str1
		mov ah,9
		int 21h
		jmp exit
	mov al, 20
	cmp time, al
	ja Label2
	Label2:
		mov dx,offset str2
		mov ah,9
		int 21h
		jmp exit

	mov dx,offset str3
	mov ah,9
	int 21h
	jmp exit
	exit:
		mov ah,4ch
		int 21h
main endp
end main

	
	


	
	
	
	