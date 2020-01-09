name "part2"

org 100h
jmp start

line       db  26 DUP(0F1h)
infile     db  "..\..\\Users\markos\AppData\Roaming\Skype\My Skype Received Files\input.txt",  0h
outfile    db  "..\..\Users\markos\Desktop\output.txt", 0h
offset_s   db  ?
newline    db  0Dh
len        dw  ?
lineoffset dw  ?
shandle    dw  ?
dhandle    dw  ?

putchar10 macro                 ; putchar('\n')
         mov  al,0Ah            ;print newline
         mov  ah,0Eh
         int  10h
         mov  al,0Dh            ;print enter
         int  10h
endm

fputchar10 macro                ;write to file
         mov  cx,01h
         mov  bx,dhandle
         lea  dx,newline
         mov  ah,40h
         int  21h
endm

putline macro                   ;print a string until you find '$'
         mov  ah,09h
         int  21h
endm
                                ;write a string to file
fputline macro
         mov  ah,40h
         mov  bx,dhandle
         mov  cx,len
         int  21h
endm

start:   mov  ah,01h            ; read input digit (0-9)
         int  21h
         cmp  al,31h
         jl   start
         cmp  al,39h
         jg   start
         sub  al,30h
         mov  offset_s,al
         xor  ah,ah
         lea  dx,line
         add  ax,dx
         mov  lineoffset,ax
         putchar10                          
         lea  dx,infile         ; open input file to read
         mov  ax,3D00h
         int  21h
         jc   fin
         xor  ah,ah
         mov  shandle,ax         
         lea  dx,outfile        ; open output file
         mov  ax,3C00h
         xor  cx,cx
         int  21h
         jc   fin
         mov  dhandle,ax
         
fgetc:   mov  dx,lineoffset     ; read line (until '\n' or EOF)
         mov  bx,dx
         mov  [bx],24h          ;'$'
         mov  cx,01h
         mov  bx,shandle
fgetc_:  mov  ah,3Fh
         int  21h
         cmp  ax,00h
         jne  skip
         inc  di
         jmp  endbuf
skip:    mov  di,dx
         inc  dx
         cmp  [di],0Dh           ;enter
         jne  fgetc_
endbuf:  cmp  ax,00h
         jne  skp
         mov  bx,lineoffset
         cmp  [bx],24h
         je   fin
skp:     push ax
         mov  [di],24h
         mov  bx,di
         push bx
         mov  dx,lineoffset
         sub  di,dx             ; di = strlen(line)
         mov  len,di
         putline
         putchar10
         xor  dx,dx
         xor  ah,ah
         mov  al,offset_s
         cmp  di,00h
         jne  skip_
         pop  bx
         jmp  lp_end
skip_:   div  di                ; cx = max(strlen(line),shift)
         mov  cx,dx
         sub  bx,cx
         xor  ah,ah
         mov  al,offset_s
         sub  ax,cx
         mov  di,lineoffset
         sub  di,cx
         pop  bx
         sub  bx,cx
         mov  si,bx
         push cx
         push si
         repz movsb
         pop  si
         mov  [si],24h
         mov  dx,lineoffset
         pop  cx
         sub  dx,cx
         putline
         fputline
                               ; remind registers critical values
lp_end:  pop  ax               ; if not EOF continue
         cmp  ax,00h
         je   fin
         mov  cx,01h
         mov  bx,shandle
         mov  ah,3Fh
         int  21h
         putchar10
         fputchar10
         jmp  fgetc
         
fin:     mov  ah,3Eh            ; close files
         mov  bx,shandle
         int  21h
         mov  ah,3Eh
         mov  bx,dhandle
         int  21h
         mov  aX,4Ch
         int  21h
         ret
