;include lib_extr

stack segment
    dw   128  dup(0)
ends

data segment
    a dd 0             ;a=first number (32 bits)
    b dd 0             ;b=second number(32 bits)   
    tmp dd 0
    sign db ? 
    address dw ?
    newln dw 0ah,0dh,'$'
     
ends


code segment
    assume cs:code,ss:stack,ds:data
    
main proc far 
    mov ax,data
    mov ds,ax
start:
    
    mov dx,0
    mov bx,0
    mov ax,0
    mov cx,0    
    mov si,-1

    
first_number:
    call read_decimal
    jc valid1           ;it is decimal
    
    cmp al,'Q'          ;'Q' is for exit
    je  exit
    
    cmp al,'+'          ;for + / - continue,only then!
    je  next1
    
    cmp al,'-'
    je  next1
    
    jmp first_number    ;ignore everything else!
    
valid1:
    cmp si,4            ;if the number of digits is 5 or more
    je  first_number    ;read again until +/- is given
    inc si
    mov ah,02h          ;else type the digit 
    mov dl,al
    int 21h
    sub al,30h          ;take the real value 
    mov ah,0
    push ax             ;and save it in stack
    jmp first_number    
    

next1:   
    ;dec si
    mov sign,al
    mov ah,02h          ;type '+' or '-'
    mov dl,al
    int 21h 
    
    mov tmp,0
    call decimal_to_reg 
    ;pop ax 
    mov  ax,[tmp]  
    mov  dx,[tmp+2]
    mov word ptr [a],ax
    mov word ptr [a+2],dx
    mov si, -1
   

second_number:         ;repeat for the second number
    call read_decimal     
    jc valid2
    
    cmp al,'Q' 
    je exit
    
    cmp al,'='
    je next2           ;now we continue if '=' is given
    
    jmp second_number
    
valid2:
    cmp si,3
    jg second_number
    inc si
    mov ah,02h         
    mov dl,al
    int 21h     
    sub al,30h   
    mov ah,0
    push ax
    jmp second_number    
    

next2: 
    push ax                    ;print '='
    mov ah,02
    mov dl,'='
    int 21h 
    pop ax
    mov tmp,0
    call decimal_to_reg       ;convert characters to 32 bit number
    mov  ax,[tmp]  
    mov  dx,[tmp+2]    
    mov word ptr [b],ax         ;the result in b(den polu xreiazetai ayto)
    mov word ptr [b+2],dx
    cmp sign,'+'
    je addition
    jmp substraction
    
addition:  
    add ax,[a]              ;thn prosthesi h thn afairesh thn kano ksexorista,ta ax mazi kai ta dx mazi
    adc dx,[a+2]            ;alla xreiazomai kai to carry
    jmp next3    
substraction:
    cmp [a+2],dx     
    jge agb 
    cmp [a],ax
    jge agb
    push dx
    push ax
    mov dl,sign
    mov ah,02h
    int 21h
    pop ax
    pop dx
    sub dx,[a]      ;sub b,a
    sbb ax,[a+2]
    ;mov a,b         ;a=b-a
    push dx
    mov dl,sign
    mov ah,02h
    int 21h
    pop dx 
    jmp next3
        
agb:
    mov sign,'+'
    sub [a+2],dx         ;a=a-b
    sbb [a],ax    
    mov ax,[a]
    mov dx,[a+2]
    
    
next3:
             
    call print_hex       ;number to print in dx:ax
    
    mov ah,02
    mov dl,'='
    int 21h    
    cmp sign,'-'
    jne nwl
    mov dl,sign          ;print '-' or not 
    mov ah,02h
    int 21h
    
  
   ; call print_decimal ;trito skelos ths askhshs(to afhno san askhsk :P' 
    
nwl:
    mov ah,09h         ;change line
    mov dx,newln 
    int 21h
    
    jmp start  ;*** or start?
        
    
exit:
   mov ax, 4c00h
   int 21h  
    
    
   
read_decimal proc near  
    mov ah,08h      ;read input
    int 21h 

    cmp al,30h      
    jl no_decimal  
    cmp al,39h
    jg no_decimal 
    
    stc 
    ret
                ;if it is decimal CF=1 
no_decimal:
    clc             ;if it isn't CF=0    
    ret

read_decimal endp    
                     
    
decimal_to_reg proc near   
    mov dx,0
    mov bx,10d
    pop ax  
    mov address,ax
    mov cx, 0
begin:    
    pop ax         ;ax=the given digit
    
    cmp cx,0
    je gg
    push cx
form_number:    
    mul bx          ;ax:dx=ax*bx 
loop form_number
    pop cx 
gg:   
    add word ptr tmp,ax
    add word ptr tmp+2,dx  
    inc cx   
    cmp cx,si 
    jle begin
    mov ax,address
    push ax 
    ret     

decimal_to_reg endp    
           


print_hex proc near         ;only parameter the number ( dx:ax )         
    cmp dx,00
    je in_16bits
    
    push ax 
    mov dl,ah
    call convert
    mov ah,02h
    int 21h
    pop ax 
    
        
in_16bits:
    push ax
    and ah,0f0h  
    ror ah,1
    ror ah,1
    ror ah,1
    ror ah,1 
    cmp ah,0
    je in_12bits
    mov dl,ah 
    call convert 
    mov ah,02h                         
    int 21h
in_12bits:    
    pop ax
    push ax
    and ah,0fh
    cmp ah,0
    je in_8bits
    mov dl,ah  
    call convert
    mov ah,02h
    int 21h
in_8bits:    
    pop ax
    push ax
    and al,0f0h 
    ror al,1
    ror al,1
    ror al,1
    ror al,1
    cmp al,00
    je in_4bits
    mov dl,al  
    call convert
    mov ah,02h
    int 21h    
in_4bits:    
    pop ax    
    push ax  
    and al,0fh
    mov dl,al   
    call convert
    mov ah,02h
    int 21h
    pop ax
    ret

print_hex endp

convert proc near
    add dl,30h
    cmp dl,39h
    jg a_to_f
    ret
     
a_to_f:
    add dl,7h
    ret
        
convert endp    
    
        
                 
ends
end main                 