.model small
.stack 100h
.data
	num1 dw 5580h
	num2 dw 8000h
	ans dw 0,0,0,0
.code
main proc
	mov ax,@data
	mov ds,ax
	mov ax,num1
	mul num2
	mov ans,ax

	mov ans+2,dx
	mov ax,num1+2
	mul num2

	mov ax,num1
	mul num2
	add ans+2,ax
	adc ans+4,dx
	adc ans+6,0

	mov ax,num1+2
	mul num2
	add ans+4,ax
	adc ans+6,dx

	mov ax,4ch
	int 21h
main endp
end main

	