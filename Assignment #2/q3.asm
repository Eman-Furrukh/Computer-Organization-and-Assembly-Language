.model small  

printprompt macro prompt
	push ax                    	
	push bx
	push cx
	push dx                                                
	LEA dx,prompt
	mov ah,09h
	int 21h
	pop dx

	pop cx
	pop bx
	pop ax

endm

.stack 100h
.data
    prompt1 db "Enter string1: ",0ah,0dh,"$"
    prompt2 db "Enter string2: ",0ah,0dh,"$"
    prompt3 db 0ah,0dh,'$'
    prompt4 db "string1 is not a substring of string2$"   
    prompt5 db "string1 is a substring of string2$"
    string1_base db 50
    string1_len db ?
    string1 db  50 dup('$')
    string2_base db 50
    string2_len db ?
    string2 db 50 dup('$')
    len db 0

.code
start:
    mov ax,@data
    mov ds,ax
    printprompt prompt1
    LEA dx, string1_base
    mov ah,0ah
    int 21h     
    printprompt prompt3
    cmp string1_len ,0
    je Fail
    
    printprompt prompt2                   
    LEA dx, string2_base          
    mov ah,0ah
    int 21h
    printprompt prompt3
    cmp string2_len ,0                         
    je Fail                                    
    mov cl, string2_len                         
    cmp string1_len, cl                         
    jg Fail                                     
   
    mov di,0                                   
 L2:
    mov cx,0
    mov cl,string2_len                           
    cmp di,cx                                  
    jge Fail                                   
    mov si,0                                    
    call check                                 
    cmp ax,1                                  
    je Pass                                   
    inc di                                    
    jmp L2
Pass:   
	printprompt prompt5                             
    jmp Exit
Fail:
    printprompt prompt4                              
Exit:      
	mov ah,4ch                                    
	int 21h    

check proc near
    push si                                    
    push di
    push cx
    mov cl,string1_len                           
 L4:
    cmp cl,0                                   
    je L5
    mov ch,string1[si]                           
    cmp ch,string2[di]
    jne L6                                   
    inc si                                    
    inc di                                    
    dec cl                                    
    jmp L4
L5:
    mov ax,1                                  
    jmp L7 
L6:                                                                         
    mov ax,0                                   
L7: 
    pop cx                                    
    pop di
    pop si
    ret  
check endp  

end start