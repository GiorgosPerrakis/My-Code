data segment    

    msg1 db "Give a 9-bit 2's complement number: $"
    msg2 db "Decimal: $"
    newline db 0ah,0dh,'$'
    pt1 db ".00$"
    pt2 db ".25$"
    pt3 db ".50$"
    pt4 db ".75$"
    
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; our code starts here     
new_number:        
    mov dx, offset msg1            ; here we print starting message
    mov ah, 9
    int 21h            
    mov bl, 0                      ; number of accepted digits to register bl
    mov dh, 0                      ; and binary number to register dx
    mov dl, 0        
read_loop:        
    mov ah,8                       ; input is stored to register al
    int 21h     
    cmp al, '0'                    ; we check if that is a binary digit
    je is_binary_digit
    cmp al, '1'
    je is_binary_digit         
    cmp al, 'B'                    ; here we check if user want to terminate the programme
    jne read_loop                  ; by giving the string "B15"
found_B:
    mov ah,8                       ; if we find a "B" character we read again
    int 21h 
    cmp al, 'B'                    ; if we find again we re-read
    je found_B
    cmp al, '0'                    ; if we find a "0" after our "B" it is considered as
    je is_binary_digit             ; a part of our number 
    cmp al, '1'                    
    jne read_loop                  ; if we find anything else except "1" we ignore it
    inc bl                         ; if we find a "1" we increase number of accepted digits
    cmp bl, 1
    sub al,'0'
    je first                       ; here we add the accepted digit to register dx
    cmp bl, 9                      ; by addition and then rotating the register right
    je before_finish               
    add dl, al
    rol dl, 1
    jmp later
first:
    add dh, al
later:
    add al, '0'
    push dx
    mov dl,al                      ; here we print the accepted digit (1)
    mov ah,2
    int 21h 
    pop dx                          
    mov ah,8                       ; here we read next digit after having read the
    int 21h                        ; string "B1" already    
    cmp al, 'B'                    ; if its "B" again we re-read
    je found_B
    cmp al, '5'                    ; if its "5" we terminate the programme
    je end_programme     
    cmp al, '0'                    ; if its "0" or "1" we accept it
    je is_binary_digit:
    cmp al, '1'
    je is_binary_digit:    
    jmp read_loop                  ; if its anything else we ignore it
before_finish: 
    add al,'0'
    add dl, al
    rol dl, 1
    push dx                        ; here we print 9th accepted digit
    mov dl,al
    mov ah,2
    int 21h 
    pop dx             
    jmp finish    
is_binary_digit:                   ; we convert character to a number
    sub al,'0'                     ; by substracting its ascii code
    inc bl
    cmp bl, 1
    je first_digit 
    add dl, al                     ; we place current digit to register dl
    cmp bl, 9h
    je print
    rol dl, 1                      ; and we rotate it left
    jmp print    
first_digit:
    add dh, al                     ; first digit is placed in register dh        
print:
    add al, '0'                    
    cmp bl, 8
    jne just_the_digit
    push dx
    push ax
    mov ah,2                       ; here we print decimal point
    mov dl, 2eh
    int 21h 
    pop ax 
    pop dx
just_the_digit:                    ; here we print accepted digit
    push dx
    mov dl,al
    mov ah,2
    int 21h 
    pop dx                  
    cmp bl, 9
    je finish                      
    jmp read_loop    
finish: 
    push dx      
    mov dx, offset newline         ; here we change line
    mov ah, 9
    int 21h      
    mov dx, offset msg2            ; we print next message
    mov ah, 9
    int 21h
    pop dx
    push dx  
    cmp dh, 1h                     ; here we determine sign and print it    
    je negative
    mov dl, 2bh                    ; print '+'
    mov ah,2
    int 21h
    pop dx
    jmp separate_number     
negative:
    mov dl, 2dh                    ; or print '-'
    mov ah,2
    int 21h        
    pop dx
    not dx                         ; here we have the absolute value of our number
    add dx, 1h                     ; (if its negative)                                                      
    and dx, 0000000111111111b
separate_number:
    push dx
    mov cl, 2h
    shr dx, cl                                                                                                        
    mov bl, dl                     ; result to register bl without fraction                             
    pop dx
    and dl, 03h
    mov bh, dl                     ; and fraction to register bh    
    mov ah, 0h                     ; we set up registers for the division
    mov al, bl
    mov cl, 64h                    ; div with 100d
    div cl                         ; here we find number of hundreds
    mov ch, 0h
    cmp al, 0h
    je no_of_tens
    mov ch, 1                      ; if number was greater than 99 ch=1 (flag) 
    add al, '0'
    mov dl, al
    push ax                        ; we print number of hundreds if
    mov ah, 2h                     ; that is greater than 0
    int 21h
    pop ax
no_of_tens:
    mov al, ah
    mov ah, 0h
    mov cl, 10d
    div cl
    cmp al, 0h
    je check_if_printed
print_ten:
    add al, '0'
    mov dl, al
    push ax                        ; we print number of tens if
    mov ah, 2h                     ; that is greater than 0
    int 21h
    pop ax
    jmp no_of_ones    
check_if_printed:                  ; if that is zero we check if we have printed hundreds 
    cmp ch, 1
    jne no_of_ones                 ; we didnt
    jmp print_ten                  ; or we did so we go back to print        
no_of_ones:
    add ah, '0'
    mov dl, ah
    mov ah, 2h
    int 21h     
                                   ; here we print fraction
    cmp bh, 00000000b
    je prt1
    cmp bh, 00000001b
    je prt2
    cmp bh, 00000010b
    je prt3    
    mov dx, offset pt4             ; case .75
    mov ah, 9
    int 21h
    jmp ending
prt1:
    mov dx, offset pt1             ; case .00
    mov ah, 9
    int 21h
    jmp ending
prt2:    
    mov dx, offset pt2             ; case .25
    mov ah, 9
    int 21h
    jmp ending
prt3:
    mov dx, offset pt3             ; case .50
    mov ah, 9
    int 21h            
ending:    
    mov dx, offset newline         ; then we change line
    mov ah, 9
    int 21h    
    jmp new_number
    
    mov ax, 4c00h                  ; exit to operating system.
    int 21h    
ends          

end_programme:

end start                          ; set entry point and stop the assembler.
