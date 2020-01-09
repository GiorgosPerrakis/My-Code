data segment
    table db 3 dup(?)
    msg1 db 'GIVE 3 HEX DIGITS: $'
    msg2 db 'DECIMAL= $'
    newln db 0dh,0ah,'$'
    c1000 db 0
    c100 db 0
    c10 db 0    
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here                   
strt:
    mov c1000, 0h
    mov c100, 0h
    mov c10, 0h
    lea dx,msg1              ; print starting message
    mov ah, 9h
    int 21h
    mov si, 0h				 ;number of accepted digits
    mov bx, 0h               ;given hex number to register bx
loop_input:            
    mov ah, 8h
    int 21h    
    cmp al, 'U'              ;if character 'U' is given stop the programme
    je exit
    cmp al, 0dh              ;if enter is given we check number of accepted digits
    je check_enter            
    cmp al, 30h
    jb loop_input
    cmp al, 39h              ;if a number is given it's considered as valid
    jbe valid 
    cmp al, 41h              ;if a capital letter between 'A' and 'F' is
    jb loop_input            ;given it's considered as valid
    cmp al, 46h
    jbe valid
    jmp loop_input           ;if anything else is given we ignore it
check_enter:        
    cmp si, 3h               ;if enter is pressed before 3 accepted digits we ignore it
    je convert               ;else we print the accepted digits
    jmp loop_input    
valid: 
    cmp si, 3h				 ;if we have already 3 valid digits we ignore the rest and wait enter
    je loop_input  
    mov table:[si], al       ;if we find a valid digit we keep it in
    sub table:[si], 30h      ;a table and we print it    
    cmp table:[si], 9h
    jbe number
    sub table:[si], 7h
number:       
    inc si
    mov dl, al               
    mov ah, 2
    int 21h        
    jmp loop_input
convert:
    lea dx, newln            ;we print a new line
    mov ah, 9h
    int 21h
    lea dx, msg2             ;and second message
    mov ah, 9h
    int 21h    
make_hex_number:    
    mov al, 1h              
    mul table:[2]
    mov bx, ax
    mov al, 10h              ; mul with 16
    mul table:[1]             
    add bx, ax
    mov ax, 100h             ; mul with 16^2
    mov dl, table:[0]
    mov dh, 0h
    mul dx
    add bx, ax               ;hex number to register bx
    mov ax, bx
    mov dx, 0h
    mov bx, 1000d            ;find number of 1000d
    div bx
    cmp al, 0h
    je less_than_1000
    mov c1000, 1h
    push dx
    add al, 30h
    mov dl, al
    mov ah, 2h
    int 21h
    mov dl, 2ch				;print ","
    mov ah, 2h
    int 21h
    pop dx
less_than_1000:
    mov ax, dx               ;find number of 100d
    mov bl, 100d
    div bl
    cmp al, 0h
    jne pt
    cmp c1000, 1h
    jne less_than_100
pt: 
    mov c100, 1h
    push ax
    add al,30h    
    mov dl, al
    mov ah, 2h 
    int 21h
    pop ax 
less_than_100:               ;find number of 10d
    mov al, ah
    mov ah, 0h
    mov bl, 10d
    div bl
    cmp al, 0h
    jne pt1
    cmp c1000, 1h
    je pt1
    cmp c100, 1h
    jne less_than_10
pt1:    
    push ax
    add al, 30h    
    mov dl, al
    mov ah, 2h 
    int 21h
    pop ax    
less_than_10:                ;and last number of 1d
    add ah, 30h              ;and print them all
    mov dl, ah
    mov ah, 2h
    int 21h    
     
    lea dx, newln            ;we print a new line
    mov ah, 9h
    int 21h    
    jmp strt        
exit:
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
