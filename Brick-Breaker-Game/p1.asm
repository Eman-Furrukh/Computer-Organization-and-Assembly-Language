.model small
.stack 100h
.data
;----------bar's variables
barInitX dw 130
barInitY dw 190

barWidth = 5
barLength = 60
barSpeed = 10
;----------ball's variables
ballInitX dw 50
ballInitY dw 50
ballSpeedX dw 5
ballSpeedY dw 5
timeVar db 0

windowsWidth = 200
windowsLength = 320

ballSize = 5
 NO_BALL1          DW 0
     NO_BALL2          DW 0 
       
     B_LOSS            DW 0 
score dw 0
scor_msg db "Score : $"

 WLCM      DB  0AH,0DH,"                  ================================"
              DB  0AH,0DH,"                  ================================"
              DB  0AH,0DH,"                  ========== WELCOME TO =========="
              DB  0AH,0DH,"                  ================================"
              DB  0AH,0DH,"                  ================================"
              DB  0AH,0DH,"                  ========= BRICK BREAKER ========"
              DB  0AH,0DH,"                  ================================"
              DB  0AH,0DH,"                  ================================$"
        
    str2      DB  0AH,0DH,"=================================================================="
              DB  0AH,0DH,"=================================================================="
              DB  0AH,0DH,"======== PROGRAMMED BY: =========================================="
              DB  0AH,0DH,"=================================================================="
              DB  0AH,0DH,"=================================================================="
              DB  0AH,0DH,"======================== SHAMAIL AAMIR KHAN =================="  
              DB  0AH,0DH,"=================================================================="
              DB  0AH,0DH,"======================== EMAN FURRUKH ========"
              DB  0AH,0DH,"=================================================================="
              DB  0AH,0DH,"==================================================================$"
       
        
    str3      DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"== IT IS A SINGLE PLAYER GAME. YOU HAVE TWO BALLS WHICH MEAN YOU =="
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"=== HAVE DOUBLE CHANCE OF WINNING BUT AT THE SAME TIME HAVE THE ==="
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"==== SAME CHANCE OF LOSING. IF YOU LOSE BOTH OF YOUR BALLS THEN ==="
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"============================ GAME OVER ============================"
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"===================================================================$"
       
    str5      DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"=======================    CONTROLS   ============================="
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,0AH,0DH
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"== USE THE LEFT AND RIGHT ARROW KEYS TO MOVE THE BAR FROM IT'S  ==="
              DB  0AH,0DH,"==================================================================="
              DB  0AH,0DH,"======== CURRENT POSITION TO LEFT OR RIGHT RESPECTIVELY ==========="
              DB  0AH,0DH,"===================================================================$"   
       
                                                                      
    str6      DB 0AH,0DH,"                  =========================="
              DB 0AH,0DH,"                  =========================="
              DB 0AH,0DH,"                  ====    THANK YOU     ===="
              DB 0AH,0DH,"                  ====       FOR        ===="
              DB 0AH,0DH,"                  ==== PLAYING THE GAME ===="
              DB 0AH,0DH,"                  =========================="
              DB 0AH,0DH,"                  ==========================$"
                        
    LOSE_MSG  DB 0AH,0DH,"                  =========================="
              DB 0AH,0DH,"                  =========================="
              DB 0AH,0DH,"                  ====     YOU LOSE     ===="
              DB 0AH,0DH,"                  =========================="
              DB 0AH,0DH,"                  ==========================$"  
             
    ITEM0     DB 0AH,0DH,"                  ==========================="
              DB 0AH,0DH,"                  ===========================",0AH,0DH,'$'
    ITEM1     DB 'NEW GAME      ====',0AH,0DH,'$'
    ITEM2     DB 'PROGRAMMED BY ====',0AH,0DH,'$'
    ITEM3     DB 'ABOUT         ====',0AH,0DH,'$'
    ITEM4     DB 'HIGHSCORES    ====',0AH,0DH,'$'
    ITEM5     DB 'INSTRUCTIONS  ====',0AH,0DH,'$'
    ITEM6     DB 'QUIT GAME     ====',0AH,0DH,'$'        
    ITEM7     DB "                  ==========================="
              DB 0AH,0DH,"                  ===========================$"
   
    SELECTED DW 0     ; currenlty selected menu item.
    MENU_COUNT DW 6   ; number of items in menu.
    UP      EQU     48h
    DOWN    EQU     50h

    ; all menu items should be
    ; entered in this address array:
    ITEMS_ADR DW ITEM1, ITEM2,ITEM3, ITEM4,ITEM5, ITEM6,ITEM7
   
    SELECTOR        DB '                  ==== ->  $'
    EMPTY_SELECTOR  DB '                  ====     $'
   
.code
;------------- MACROs
	makeBall MACRO
		mov al, 0fh; white colour ball
		call drawBall
	ENDM

	clearBall MACRO
		mov al, 00h; black colour ball
		call drawBall
	ENDM

	makeBar MACRO
		mov al, 0fh; white colour bar
		call drawBar
	ENDM

	clearBar MACRO
		mov al, 00h; black colour bar
		call drawBar
	ENDM

;------- Attaching the data segment
mov ax, @data
mov ds, ax
mov ax, 0

;---------- Main Procedure
main proc
	mov ah, 0;	setting video mode
	mov al, 13h
	int 10h

	call game

mov ah, 4ch
int 21h
main endp
;---------------------------------------------------------------------------------------------
game PROC uses ax bx

timeLoop:
	mov ah, 2ch	;getting the time
	int 21h
	
	;if 1/100 sec hasnt passed, repeat loop
	cmp dl, timeVar
	je timeLoop
	
	;moving the ball
	clearBall
	call moveBall
	makeBall
	
	;moving the bar
	clearBar
	call moveBar
	makeBar
	
	;Now that 1/100 sec has passed, store the sec in time var and repeat the loop again
	mov timeVar, dl
	jmp timeLoop
	
ret
game endp
;---------------------------------------------------------------------------------------------
moveBar PROC uses ax bx cx dx
moveBar_Loop:

	mov ah, 01;taking input
	int 16h
	jz moveBarExit

	mov ah, 00;taking input
	int 16h
	cmp ah, 4Bh; left key
	je leftKey
	cmp ah, 4Dh; right key
	je rightKey

	leftKey:
		;boundaryCheckLeft
		cmp barInitX, 0
		jle moveBar_Loop
		sub barInitX, barSpeed
	jmp moveBar_Loop

	rightKey:
		;boundaryCheckRight
		mov ax, barInitX
		add ax, barLength
		cmp ax, windowsLength
		jge moveBar_Loop
		add barInitX, barSpeed
	jmp moveBar_Loop
	
	moveBarExit:
ret
moveBar endp
;---------------------------------------------------------------------------------------------
drawBar proc uses ax bx cx dx si di
mov cx, barInitX ;inital x
mov dx, barInitY ;inital y
mov bh, 0; page number

mov si, barWidth

barLoop:
	mov di, barLength
	mov cx, barInitX
	barNestedLoop:
		call drawPixel
		inc cx
		
	dec di
	cmp di, 0
	jne barNestedLoop
	
	inc dx
dec si
cmp si, 0
jne barLoop
ret
drawBar endp

;---------------------------------------------------------------------------------------------
drawPixel PROC
	mov ah, 0ch
	int 10h
ret
drawPixel endp
;---------------------------------------------------------------------------------------------
moveBall PROC uses ax 
	
	;moving the ball in x-axis
	mov ax, ballSpeedX
	add ballInitX, ax
	
	;if hit the left wall
	cmp ballInitX, 0
	jle reverseSpeedX
	
	;if hit the right wall
	mov ax, ballInitX
	add ax, ballSize
	cmp ax, windowsLength
	jge reverseSpeedX
	
	;moving the ball in y-axis
	mov ax, ballSpeedY
	add ballInitY, ax
	
	;if hit the upper wall
	cmp ballInitY, 0
	jle reverseSpeedY
	
	;if hit the lower wall
	mov ax, ballInitY
	add ax, ballSize
	cmp ax, windowsWidth
	jge reverseSpeedY
	
	;checking ball's collision with bar
	mov ax, ballInitY
	add ax, ballSize
	cmp ax, barInitY
	jl moveBallExit 
	
	;barX >= x && x <= barX+length
	mov ax, ballInitX
	cmp ax, barInitX
	jl moveBallExit
	
	add ax, ballSize
	mov bx, barInitX
	add bx, barLength
	cmp ax, bx
	jl reverseSpeedY
	
	moveBallExit:
	ret 
	reverseSpeedY:
	neg ballSpeedY
	ret
	
	reverseSpeedX:
	neg ballSpeedX
	ret
	
moveBall endp
;---------------------------------------------------------------------------------------------
drawBall proc uses ax bx cx dx si di
	mov cx, ballInitX ;inital x
	mov dx, ballInitY ;inital y
	mov bh, 0; page number

	mov si, ballSize

	ballLoop:
		mov di, ballSize
		mov cx, ballInitX
		ballNestedLoop:
			call drawPixel
			inc cx
			
		dec di
		cmp di, 0
		jne ballNestedLoop
		
		inc dx
	dec si
	cmp si, 0
	jne ballLoop
ret
drawBall endp




MAIN_menu PROC     
    PUSH    AX      ; store registers...
    PUSH    BX      ;
    PUSH    CX      ;
    PUSH    DX      ;     

   

    START:
        PRINT_MENU:
       
            CALL CLEAR_SCREEN
            MOV AH,9
            LEA DX,ITEM0
            INT 21H
           
            MOV BX, 0
            MOV CX, MENU_COUNT
            PRINT_ITEMS:
                MOV AX,BX
                SHR AX, 1   ; DIVIDE BY 2.
                CMP AX, SELECTED
                JNE NOT_SEL
               
                LEA DX, SELECTOR
                MOV AH, 09H
                INT 21H
                   
                JMP CONT
            NOT_SEL:
                LEA DX, EMPTY_SELECTOR
                MOV AH, 09H
                INT 21H
            CONT:   
                MOV DX, ITEMS_ADR[BX]
                MOV AH, 09H
                INT 21H
               
                ADD BX, 2  ; NEXT ITEM.
            LOOP PRINT_ITEMS
           
           
           
            MOV AH,9
            LEA DX,ITEM7
            INT 21H
              
           
            CHECK_FOR_KEY:
           
            MOV     AH,01H
            INT     16H
            JZ      NO_KEY
           
            MOV     AH,00H
            INT     16H
           
            CMP     AL, 1BH    ; ESC - KEY?
            JE      NOT_ENTER  ;
           
            CMP     AH, UP
            JNE     NOT_UP
            SUB     SELECTED, 1
            NOT_UP:
           
            CMP     AH, DOWN
            JNE     NOT_DOWN
            ADD     SELECTED, 1
            NOT_DOWN:
           
           
            ; enter pressed?      
            CMP    AH, 1CH
            JNE    NOT_ENTER
                CMP SELECTED, 0
                JNE NOT_ITEM_0
                CALL CLEAR_SCREEN
                JMP START_GAME
            NOT_ITEM_0:
                CMP SELECTED, 1
                JNE NOT_ITEM_1
                CALL CLEAR_SCREEN
                LEA DX, STR2
                MOV AH, 9
                INT 21H          
                MOV AH,1
                INT 21H
                JMP START 
            NOT_ITEM_1:
                CMP SELECTED, 2
                JNE NOT_ITEM_2
                CALL CLEAR_SCREEN
                LEA DX, STR3
                MOV AH, 9
                INT 21H              
                MOV AH,1
                INT 21H
                JMP START
            NOT_ITEM_2:
                CMP SELECTED,3
                JNE NOT_ITEM_3
                CALL CLEAR_SCREEN
                CALL SCORE_DISP          
                MOV AH,1
                INT 21H
                JMP START
            NOT_ITEM_3:
                CMP SELECTED, 4
                JNE NOT_ITEM_4
                CALL CLEAR_SCREEN
                LEA DX, STR5
                MOV AH, 9
                INT 21H          
                MOV AH,1
                INT 21H   
                JMP START
            NOT_ITEM_4:
                CMP SELECTED,5
                JNE NOT_ITEM_5
                CALL CLEAR_SCREEN
                LEA DX, STR6
                MOV AH, 9
                INT 21H          
                MOV AH,1
                INT 21H   
                JMP stop_prog
            NOT_ITEM_5:
                ; WAIT FOR KEY:
                MOV    AH, 00
                INT    16H   
            NOT_ENTER:
           
           
           
            ; CHECK IF OUT OF MENU BOUNDS:
            CMP    SELECTED, -1
            JNLE    OK1
            MOV    SELECTED, 0
            OK1:
                MOV AX, MENU_COUNT
                CMP    SELECTED, AX
                JNGE OK2
                DEC    AX
                MOV    SELECTED, AX
            OK2:
                JMP PRINT_MENU
           
            NO_KEY:
                JMP CHECK_FOR_KEY
       
       
       
        STOP_PROG:
            MOV AH,4CH
            INT 21H
    START_GAME:       
       MOV NO_BALL1,0
       MOV NO_BALL2,0
       MOV B_LOSS,0
    POP     DX      ; re-store registers...
    POP     CX      ;
    POP     BX      ;    
    POP     AX 
    ret     
MAIN_MENU ENDP

CLEAR_SCREEN PROC
        PUSH    AX      ; store registers...
        PUSH    DS      ;
        PUSH    BX      ;
        PUSH    CX      ;
        PUSH    DI      ;

        MOV     AX, 40h
        MOV     DS, AX  ; for getting screen parameters.
        MOV     AH, 06h ; scroll up function id.
        MOV     AL, 0   ; scroll all lines!
        MOV     BH, 07  ; attribute for new lines.
        MOV     CH, 0   ; upper row.
        MOV     CL, 0   ; upper col.
        MOV     DI, 84h ; rows on screen -1,
        MOV     DH, [DI] ; lower row (byte).
        MOV     DI, 4Ah ; columns on screen,
        MOV     DL, [DI]
        DEC     DL      ; lower col.
        INT     10h

        ; set cursor position to top
        ; of the screen:
        MOV     BH, 0   ; current page.
        MOV     DL, 0   ; col.
        MOV     DH, 0   ; row.
        MOV     AH, 02
        INT     10h

        POP     DI      ; re-store registers...
        POP     CX      ;
        POP     BX      ;
        POP     DS      ;
        POP     AX      ;

        RET
CLEAR_SCREEN ENDP

SCORE_DISP PROC
    PUSH AX  
    PUSH BX
    PUSH CX
    PUSH DX
        CALL CLEAR_SCREEN
                             
        MOV AH,9
        LEA DX,SCOR_MSG
        INT 21H
       
        MOV AX,SCORE
        MOV BX,10D
        XOR CX,CX
        SAV_DEC:
            XOR DX,DX
            DIV BX        
            INC CX
            PUSH DX
            OR AX,AX
            JNZ SAV_DEC
           
            MOV AH,2 
           
        OUT_DEC:
            POP DX
            ADD DX,30H
            INT 21H
            LOOP OUT_DEC
       MOV AH,1
       INT 21H
    POP DX
    POP CX
    POP BX
    POP AX
    RET
SCORE_DISP ENDP
                   
WELCOME_SCR PROC
    PUSH    AX      ; store registers...
    PUSH    BX      ;
    PUSH    CX      ;
    PUSH    DX      ;
                             
        CALL CLEAR_SCREEN
        MOV AH,9
        LEA DX,WLCM
        INT 21H        
       
        MOV AH,1
        INT 21H
       
    POP     DX      ; re-store registers...
    POP     CX      ;
    POP     BX      ;
    POP     AX      ; 

RET
WELCOME_SCR ENDP

end
