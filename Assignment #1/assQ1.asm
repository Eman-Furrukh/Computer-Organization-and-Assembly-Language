;   EMAN FURRUKH	;
;   ASSIGNMENT 1	;
;	QUESTION 1	;

.model small
.stack 100h
.data
	prompt db 0ah,0dh,"Guess a number from 0-9: $"
	right db 0ah,0dh, "You have guessed correctly. Well Done $"
	again db 0ah,0dh,"Incorrect, try again. $"
	wrong db 0ah,0dh,"Incorrect, you lose :/ $"
.code
main proc
	mov ax,@data
	mov ds,ax
	mov ah,09h
	lea dx,prompt
	int 21h
	mov ah,07h
	int 21h
	mov bl,al
	mov ah,09h

L1:
	mov ah,07h
	int 21h
	cmp al,bl
	je Correct
	mov ah,09h
	lea dx,again
	int 21h
	mov ah,02h
	int 21h
	loop L1
	
	mov ah,07h
	int 21h
	cmp al,bl
	je Correct
	mov ah,09h
	lea dx,wrong
	int 21h
	jmp Exit

Correct:
	mov ah,09h
	lea dx,right
	int 21h

Exit: 
	mov ah,4ch
	int 21h

main endp
end main
	