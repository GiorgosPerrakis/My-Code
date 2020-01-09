
DATA_SEG SEGMENT
    TABLE DB 3 DUP(0)
    NEWLN DB 0AH,0DH,'$'
    MSGIN DB 'GIVE 3 HEX DIGITS: $'
    MSGOUT DB 'DECIMAL=$'
DATA_SEG ENDS  

CODE_SEG SEGMENT   
    
ASSUME CS:CODE_SEG,DS:DATA_SEG   

MAIN PROC FAR
    MOV AX,DATA_SEG
    MOV DS,AX 
    
START:
    LEA DX,MSGIN          ;load message
    MOV AH,9
    INT 21H
    MOV BL,0              ;counter of decimal digits
    MOV SI,0              
        
LOOP_KEYB:  
    CALL HEX_KEYB         ;read hex number
    CMP AL,'U'
    JE QUIT
    CMP AL,'W'            ;agreement that 'W'=Enter
    JNE ADDR1 
    CMP BL,3              ;if it's not enter store the number
    JNE LOOP_KEYB         ;if it's enter but not the 3rd number then ignore enter
    JMP NEXT              ;else finish with the entrance and continue the program
    
ADDR1: 
    CMP BL,3              ;check if we have 3 numbers
    JE LOOP_KEYB          ;if yes don't increase the counter
    MOV TABLE:[SI],AL     ;else store the number
    INC BL 
    INC SI
    JMP LOOP_KEYB  
    
NEXT:
    LEA DX,NEWLN
    MOV AH,9
    INT 21H
    MOV AX,0
    MOV CX,3              ;we have 3 digits so we will do 3 loops
    
CONVERT:
    SHL AX,4              ;shifts so as to set each digit to the right place
    MOV BH,0
    MOV BL,TABLE:[SI]
    ADD AX,BX 
    CMP SI,2
    JE ADDR2              ;if the table is full, set SI=0 so as to store in the right place
    INC SI                ;else increase by 1
    JMP ADDR3  
    
ADDR2:
    MOV SI,0    
    
ADDR3:
    LOOP CONVERT
    PUSH AX
    LEA DX,MSGOUT
    MOV AH,9
    INT 21H
    POP AX
    CALL PRINT_DEC          ;print the decimal number of AX
    LEA DX,NEWLN
    MOV AH,9
    INT 21H
    JMP START   
    
QUIT:                       ;exit program
    MOV AX,4C00H 
    INT 21H  
    
MAIN ENDP       

HEX_KEYB PROC NEAR        
IGNORE:
    MOV AH,08H              ;read a character
    INT 21H
    CMP AL,'U'              ;check if it is 'U'
    JE KEYB_RET             
    CMP AL,0DH              ;check if it's enter
    JNE HEX_NUM
    MOV AL,'W'              ;agreement that 'W'=enter
    JMP KEYB_RET  
    
HEX_NUM:
    CMP AL,30H              ;30H = 0 dec
    JL IGNORE
    CMP AL,39H              ;39H = 9 dec
    JG IGNORE               
    MOV DL,AL
    SUB AL,30H              ;convert of digit to a number (0-9)
    JMP KEYB_PRINT     
    
KEYB_PRINT:
    PUSH AX
    MOV AH,02H
    INT 21H
    POP AX      
    
KEYB_RET:
    RET
    
HEX_KEYB ENDP

PRINT_DEC PROC NEAR
    MOV BX,0AH
    MOV CX,00H          ;counter of decimal digits
    
CALC_DEC:
    MOV DX,00H
    DIV BX              ;division by 10
    PUSH DX             ;store the decimal number 
    INC CX              
    CMP AX,00H          ;continue until the quotient is 0
    JNZ CALC_DEC   
    
PRI_DEC:
    POP DX 
    ADD DX,030H         ;convert to ASCII
    MOV AH,2            ;print
    INT 21H
    LOOP PRI_DEC
    RET
PRINT_DEC ENDP   

CODE_SEG ENDS   

END MAIN