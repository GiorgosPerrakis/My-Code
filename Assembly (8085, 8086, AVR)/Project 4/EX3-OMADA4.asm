data segment
  table db 16 dup(?)
  min1 db ?              
  min2 db ?              
  msg db 'Give up to 16 characters: $'
  newln db 0dh,0ah,'$'              
data ends 


code segment
   assume cs:code,ds:data

main proc far 
    mov ax,data
    mov ds,ax

start:
    lea dx,msg             ;type the message for input
    mov ah,9
    int 21h 
    
    mov si,0
    
    
loop_input:  
    mov ah,8 
    int 21h

    cmp al,'*'             ;if '*' is given we exit
    je exit
    cmp al,0dh             ;if enter is pressed we move to the print of group
    je next         
    
    cmp al,20h             ;space is accepted 
    je valid
               
    cmp al,30h             ;check if character is a number
    jl loop_input
    cmp al,39h
    jng valid
    
    cmp al,41h             ;check if it is a capital letter
    jl loop_input
    cmp al,5ah
    jng valid
    
    cmp al,61h             ;check if it is a lowercase letter
    jl loop_input
    cmp al,7ah
    jg loop_input
    
valid:              
    cmp si,16              ;if we have more than 16 characters ignore the character 
    jge loop_input
    
    mov dl,al              ;else print it
    mov ah,2
    int 21h    
      
    mov table:[si],al      ;and save it in the table
    inc si
    jmp loop_input         ;continue until we have 16 characters or enter/'*' is pressed
    
next: 
    mov cx,si              ;*** cx=si in every call of the procedure print_group *** (for the number of loops)
    lea dx,newln 
    mov ah,9               ;change line
    int 21h
      
    push cx
    mov bl,41h             ;parameters of the procedure print_group that define the group
    mov bh,5ah             ;first group is capital letters
    call print_group
    pop cx
    
    mov dl,'-'             ;type '-'
    mov ah,2
    int 21h
    
    push cx
    mov bl,61h             ;second group is lowercase letters
    mov bh,7ah
    call print_group    
    pop cx
        
    mov dl,'-'             ;type '-'
    mov ah,2
    int 21h
    
    push cx
    mov bl,30h             ;third group is numbers
    mov bh,39h             
    mov min1, 3ah          ;we set min1 and min2 as 3ah
    mov min2, 3ah          ;so they are greater than '9'=39h
    call print_group
    pop cx
    
    lea dx,newln           ;change line
    mov ah,09h
    int 21h
    
    cmp min1, 3ah
    je start
    
    mov si, 0h             ;now that we have min1 and min2
print_if_found:            ;we search them in table to print 
    mov al, table:[si]     ;them correctly (as they were given)
    cmp al, min1
    jne n1
    mov dl,al              
    mov ah,2               
    int 21h
    mov min1, 3ah
n1:
    cmp al, min2
    jne n2
    mov dl,al              
    mov ah,2               
    int 21h
    mov min2, 3ah
n2:
    inc si              
loop print_if_found                     

    lea dx,newln           ;change line
    mov ah,09h
    int 21h
   
    jmp start              ;continue for next input

exit:
    mov ax, 4c00h
    int 21h 

main endp

print_group proc near   
    mov si,0
next_char:    
    mov al,table:[si]   
    cmp al,bl              ;bl and bh are defined in the main programm (limits)
    jl nxt                 ;if current character doesn't belong in the current group
    cmp al,bh              ;continue with the next one
    jg nxt  
;--------------------------     
    cmp bl, 30h            ;here we will find the 2 smallest numbers (if they exist)
    jne prt                ;if we dont check numbers, we ignore this part
    cmp al, min1
    ja p1				   ;if it's greater go to p1
    push cx
    mov cl, min1  
    mov min2, cl
    pop cx    
    mov min1, al
    jmp prt    
p1:    
    cmp al, min2
    ja prt
    mov min2, al    
;--------------------------         
prt:     
    mov dl,al              ;if it does
    mov ah,2               ;print it
    int 21h 

nxt: inc si                ;move to the next character

loop next_char 
     
ret 

print_group endp          
       
 
code ends
   
end main 
