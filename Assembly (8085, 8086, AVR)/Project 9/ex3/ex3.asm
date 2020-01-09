.include "m16def.inc"

.def temp = r18
.def ekat = r19
.def dek = r20
.def mon = r21
.def msb = r22
.def flag = r23
.def temp1 = r17

start:
	ldi r24, low(RAMEND)																		
	out SPL, r24
	ldi r24, high(RAMEND)
	out SPH, r24
	
	clr temp				; set PORTA as input
	out DDRB, temp

	ldi r24, (1 << PD7) | (1 << PD6) | (1 << PD5) | (1 << PD4) | (1 << PD3) | (1 << PD2)		; set 6 MSBs as output (for monitor)
	out DDRD, r24


start1:		
	call lcd_init				; initialization
	in temp, PINB	 
						
	ldi r24, 48				; show the binary on screen
	sbrc temp, 7
	inc r24
	call lcd_data	
	ldi r24, 48
	sbrc temp, 6
	inc r24
	call lcd_data
	ldi r24, 48
	sbrc temp, 5
	inc r24
	call lcd_data
	ldi r24, 48
	sbrc temp, 4
	inc r24
	call lcd_data
	ldi r24, 48
	sbrc temp, 3
	inc r24
	call lcd_data
	ldi r24, 48
	sbrc temp, 2
	inc r24
	call lcd_data
	ldi r24, 48
	sbrc temp, 1
	inc r24
	call lcd_data
	ldi r24, 48
	sbrc temp, 0
	inc r24
	call lcd_data
			 	
	ldi r24, '=' 
 	call lcd_data	
	ldi msb, 0 
	sbrc temp , 0x07			; check for negative number
	ldi msb,1 				; msb is for sign
	sbrc temp , 0x07	
	neg temp				; if msb = 1 , temp = temp' + 1
	cpi msb,0x00	
	breq positive	
	ldi r24,'-'				; show sign on screen 	
	call lcd_data				; '-' for negative number
 	jmp continue
positive:
	ldi r24, '+'				; '+' for positive number
	call lcd_data

continue:
	ldi temp1, 1
	ldi ekat,0				; ekat=dec=mon=0
	ldi dek,0	
	ldi mon,0
	cpi temp,100	
	brlo to_dec											
	ldi ekat, 1				; if temp >= 100 , ekat = 1	
	subi temp,100				; and temp = temp - 100
to_dec:
	cpi temp,10
	brlo to_mon				; if temp < 10 move to define mon 
	add dek,temp1				; else dec = dec + 1 and temp = temp - 10 
	subi temp,10
	jmp to_dec
to_mon:
	mov mon,temp				; mon = temp
	
	ldi flag, 1				; if flag = 1 no hundreds
	mov r24,ekat				
	cpi r24, 0
	breq no_ekat
	ldi r24, 48
	add r24, ekat
	call lcd_data				; show ekat
	ldi flag, 0
no_ekat:
	cpi dek, 0
	breq check
label:						; show decades
	ldi r24, 48
	add r24, dek
	call lcd_data
	jmp no_dec
check:
	cpi flag, 0
	breq label
no_dec:
	ldi r24, 48
	add r24, mon			; show mon
	call lcd_data
	jmp start1				

wait_usec:
	sbiw r24 ,1				; 2 ?????? (0.250 �sec)
	nop					; 1 ?????? (0.125 �sec)
	nop					; 1 ?????? (0.125 �sec)
	nop					; 1 ?????? (0.125 �sec)
	nop			   		; 1 ?????? (0.125 �sec)
	brne wait_usec				; 1 ? 2 ?????? (0.125 ? 0.250 �sec)
	ret					; 4 ?????? (0.500 �sec)

wait_msec:
	push r24				; 2 ?????? (0.250 �sec)
	push r25				; 2 ??????
	ldi r24 , low(998)			; f??t?se t?? ?ata?. r25:r24 �e 998 (1 ?????? - 0.125 �sec)
	ldi r25 , high(998)			; 1 ?????? (0.125 �sec)
	rcall wait_usec				; 3 ?????? (0.375 �sec), p???a?e? s??????? ?a??st???s? 998.375 �sec
	pop r25					; 2 ?????? (0.250 �sec)
	pop r24					; 2 ??????
	sbiw r24 , 1				; 2 ??????
	brne wait_msec				; 1 ? 2 ?????? (0.125 ? 0.250 �sec)
	ret					; 4 ?????? (0.500 �sec)

lcd_data:
	sbi PORTD ,PD2				; ep????? t?? ?ata????t? ded?�???? (PD2=1)
	rcall write_2_nibbles			; ap?st??? t?? byte
	ldi r24 ,43				; a?a�??? 43�sec �???? ?a ?????????e? ? ????
	ldi r25 ,0				; t?? ded?�???? ap? t?? e?e??t? t?? lcd
	rcall wait_usec
	ret

lcd_command:
	cbi PORTD ,PD2				; ep????? t?? ?ata????t? e?t???? (PD2=1)
	rcall write_2_nibbles			; ap?st??? t?? e?t???? ?a? a?a�??? 39�sec
	ldi r24 ,39				; ??a t?? ????????s? t?? e?t??es?? t?? ap? t?? e?e??t? t?? lcd.
	ldi r25 ,0				; S??.: ?p?????? d?? e?t????, ?? clear display ?a? return home,
	rcall wait_usec				; p?? apa?t??? s?�a?t??? �e?a??te?? ??????? d??st?�a.
	ret

write_2_nibbles:
	push r24				; st???e? ta 4 MSB
	in r25 ,PIND				; d?a�????ta? ta 4 LSB ?a? ta ?a?ast?????�e
	andi r25 ,0x0f				; ??a ?a �?? ?a??s??�e t?? ?p??a p??????�e?? ?at?stas?
	andi r24 ,0xf0				; ap?�??????ta? ta 4 MSB ?a?
	add r24 ,r25				; s??d?????ta? �e ta p???p?????ta 4 LSB
	out PORTD ,r24				; ?a? d????ta? st?? ???d?
	sbi PORTD ,PD3				; d?�?????e?ta? pa?�?? Enable st?? a???d??t? PD3
	cbi PORTD ,PD3				; PD3=1 ?a? �et? PD3=0
	pop r24					; st???e? ta 4 LSB. ??a?t?ta? t? byte.
	swap r24				; e?a???ss??ta? ta 4 MSB �e ta 4 LSB
	andi r24 ,0xf0				; p?? �e t?? se??? t??? ap?st?????ta?
	add r24 ,r25
	out PORTD ,r24
	sbi PORTD ,PD3				; ???? pa?�?? Enable
	cbi PORTD ,PD3
	ret


lcd_init:
	ldi r24 ,40				; ?ta? ? e?e??t?? t?? lcd t??f?d?te?ta? �e
	ldi r25 ,0				; ?e?�a e?te?e? t?? d??? t?? a?????p???s?.
	rcall wait_msec				; ??a�??? 40 msec �???? a?t? ?a ?????????e?.
	ldi r24 ,0x30				; e?t??? �et?�as?? se 8 bit mode
	out PORTD ,r24				; epe?d? de? �p????�e ?a e?�aste �?�a???
	sbi PORTD ,PD3				; ??a t? d?a�??f?s? e?s?d?? t?? e?e??t?
	cbi PORTD ,PD3				; t?? ??????, ? e?t??? ap?st???eta? d?? f????
	ldi r24 ,39
	ldi r25 ,0				; e?? ? e?e??t?? t?? ?????? �??s?eta? se 8-bit mode
	rcall wait_usec				; de? ?a s?��e? t?p?ta, a??? a? ? e?e??t?? ??e? d?a�??f?s?
						; e?s?d?? 4 bit ?a �eta�e? se d?a�??f?s? 8 bit
	ldi r24 ,0x30	
	out PORTD ,r24
	sbi PORTD ,PD3
	cbi PORTD ,PD3
	ldi r24 ,39
	ldi r25 ,0
	rcall wait_usec
	ldi r24 ,0x20				; a??a?? se 4-bit mode
	out PORTD ,r24
	sbi PORTD ,PD3
	cbi PORTD ,PD3
	ldi r24 ,39
	ldi r25 ,0
	rcall wait_usec
	ldi r24 ,0x28				; ep????? ?a?a?t???? �e?????? 5x8 ?????d??
	rcall lcd_command			; ?a? e�f???s? d?? ??a��?? st?? ?????
	ldi r24 ,0x0c				; e?e???p???s? t?? ??????, ap?????? t?? ???s??a
	rcall lcd_command
	ldi r24 ,0x01				; ?a?a??s�?? t?? ??????
	rcall lcd_command
	ldi r24 ,low(1530)
	ldi r25 ,high(1530)
	rcall wait_usec
	ldi r24 ,0x06				; e?e???p???s? a?t?�at?? a???s?? ?at? 1 t?? d?e????s??
	rcall lcd_command			; p?? e??a? ap????e?�??? st?? �et??t? d?e????se?? ?a?
						; ape?e???p???s? t?? ???s??s?? ????????? t?? ??????
	ret	