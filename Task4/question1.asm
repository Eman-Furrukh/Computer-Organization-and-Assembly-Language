;Lab Task 1;

.model small
.stack 100h
.data
	fname db 'first.txt',0
.code
main proc
	mov ax,@data
	mov ds,ax

	mov ah,3ch
	mov dx,offset fname
	mov cl,0
	int 21h
	jc if_error
	mov fhandle,ax

main endp
end main