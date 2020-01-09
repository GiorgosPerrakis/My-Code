.include "m16def.inc"

.def temp = r18
.def minutes = r19
.def seconds = r20
.def minutes1 = r21
.def seconds1 = r22
.def ascii = r23

start:
	ldi r24, low(RAMEND)																		
	out SPL, r24
	ldi r24, high(RAMEND)
	out SPH, r24
	
	clr temp					; set PORTA as input
	out DDRA, temp

	ldi r24, (1 << PD7) | (1 << PD6) | (1 << PD5) | (1 << PD4) | (1 << PD3) | (1 << PD2)		; set 6 MSBs as output
	out DDRD, r24																				; in PORTD

	call lcd_init					; initialize lcd screen 
	ldi r24,'0'																	
	call lcd_data					; 00 MIN:00 SEC	
	ldi r24,'0'
	call lcd_data
	ldi r24,' '	
	call lcd_data
	ldi r24,'M'
	call lcd_data
	ldi r24,'I'
	call lcd_data					
	ldi r24,'N'
	call lcd_data
	ldi r24,':'
	call lcd_data
	ldi r24,'0'	
	call lcd_data
	ldi r24,'0'
	call lcd_data
	ldi r24,' '	
	call lcd_data	
	ldi r24,'S'
	call lcd_data
	ldi r24,'E'
	call lcd_data
	ldi r24,'C'
	call lcd_data

	ldi ascii, 0x30

loop:
	in temp, PINA					
	sbrs temp, 0x00					; check PA0			 
	jmp loop						; if it's pressed then skip instruction and start the stopwatch

beginning:							; set minutes = seconds = 0
	clr minutes
	ldi seconds, 1
	clr minutes1
	clr seconds1
	ldi r24, 0x02					; clear screen
	rcall lcd_command
	ldi r24,'0'																	
	call lcd_data					; 00 MIN:00 SEC	
	ldi r24,'0'
	call lcd_data
	ldi r24,' '	
	call lcd_data
	ldi r24,'M'
	call lcd_data
	ldi r24,'I'
	call lcd_data					
	ldi r24,'N'
	call lcd_data
	ldi r24,':'
	call lcd_data
	ldi r24,'0'	
	call lcd_data
	ldi r24,'0'
	call lcd_data
	ldi r24,' '	
	call lcd_data	
	ldi r24,'S'
	call lcd_data
	ldi r24,'E'
	call lcd_data
	ldi r24,'C'
	call lcd_data
	ldi r24, low(1)				; delay 1 second
	ldi r25, high(1)
	rcall wait_msec	

loop1:
	in temp, PINA		
	sbrc temp, 0x07					; check PA7
	jmp restart						; if it's pressed then restart the stopwatch			
	sbrs temp, 0x00					; check PA0			 
	jmp loop1						; if it's pressed then skip instruction and start the stopwatch
									
	ldi r24, 0x02					; clear screen
	rcall lcd_command

	mov temp, minutes1
	add minutes1, ascii
	mov r24, minutes1
	mov minutes1, temp
	call lcd_data					; print first digit of minutes to the screen

	mov temp, minutes
	add minutes, ascii
	mov r24, minutes
	mov minutes, temp
	call lcd_data					; print second digit of minutes to the screen
					
	ldi r24,' '	
	call lcd_data
	ldi r24,'M'
	call lcd_data
	ldi r24,'I'
	call lcd_data					; print "MIN:" to the screen
	ldi r24,'N'
	call lcd_data
	ldi r24,':'
	call lcd_data

	mov temp, seconds1				; print first digit of seconds to the screen
	add seconds1, ascii
	mov r24, seconds1
	mov seconds1, temp					
	call lcd_data

	mov temp, seconds				; print second digit of seconds to the screen
	add seconds, ascii
	mov r24, seconds
	mov seconds, temp					
	call lcd_data					

	ldi r24,' '	
	call lcd_data	
	ldi r24,'S'
	call lcd_data					; print " SEC" to the screen
	ldi r24,'E'
	call lcd_data
	ldi r24,'C'
	call lcd_data

	ldi r24, low(1)				; delay 1 second
	ldi r25, high(1)
	rcall wait_msec					

	cpi seconds, 9					; if second digit is 9 increase first digit and clear seconds
	brlo label0
	inc seconds1					; else just increase seconds
	ldi seconds, -1

label0:
	inc seconds
	
	cpi seconds1, 6					; check if 60 sec passed
	breq label1	
	jmp loop1

label1:								; if 60 sec passed increase second digit of minutes
	cpi minutes, 9
	brlo label2						; if second digit is 9 increase first digit and clear minutes
	inc minutes1
	ldi minutes, -1

label2:
	inc minutes

	clr seconds
	clr seconds1
	cpi minutes1, 6					; check if 60 minutes passed
	breq label3						; if yes restart the stopwatch
	jmp loop1

label3:
	jmp beginning

restart:
	in temp, PINA
	sbrs temp, 0x07					; check if PA7 was pressed
	jmp beginning					; if not restart the stopwatch
	jmp restart						; if yes wait



wait_usec:
	sbiw r24 ,1					; 2 ������ (0.250 �sec)
	nop							; 1 ������ (0.125 �sec)
	nop							; 1 ������ (0.125 �sec)
	nop							; 1 ������ (0.125 �sec)
	nop							; 1 ������ (0.125 �sec)
	brne wait_usec				; 1 � 2 ������ (0.125 � 0.250 �sec)
	ret							; 4 ������ (0.500 �sec)

wait_msec:
	push r24					; 2 ������ (0.250 �sec)
	push r25					; 2 ������
	ldi r24 , low(998)			; ������� ��� �����. r25:r24 �� 998 (1 ������ - 0.125 �sec)
	ldi r25 , high(998)			; 1 ������ (0.125 �sec)
	rcall wait_usec				; 3 ������ (0.375 �sec), �������� �������� ����������� 998.375 �sec
	pop r25						; 2 ������ (0.250 �sec)
	pop r24						; 2 ������
	sbiw r24 , 1				; 2 ������
	brne wait_msec				; 1 � 2 ������ (0.125 � 0.250 �sec)
	ret							; 4 ������ (0.500 �sec)

write_2_nibbles:
	push r24					; ������� �� 4 MSB
	in r25 ,PIND				; ����������� �� 4 LSB ��� �� �������������
	andi r25 ,0x0f				; ��� �� ��� ��������� ��� ����� ����������� ���������
	andi r24 ,0xf0				; ������������� �� 4 MSB ���
	add r24 ,r25				; ������������ �� �� ������������ 4 LSB
	out PORTD ,r24				; ��� �������� ���� �����
	sbi PORTD ,PD3				; ������������� ������ Enable ���� ��������� PD3
	cbi PORTD ,PD3				; PD3=1 ��� ���� PD3=0
	pop r24						; ������� �� 4 LSB. ��������� �� byte.
	swap r24					; ������������� �� 4 MSB �� �� 4 LSB
	andi r24 ,0xf0				; ��� �� ��� ����� ���� �������������
	add r24 ,r25
	out PORTD ,r24
	sbi PORTD ,PD3				; ���� ������ Enable
	cbi PORTD ,PD3
	ret

lcd_data:
	sbi PORTD ,PD2				; ������� ��� ���������� ��������� (PD2=1)
	rcall write_2_nibbles		; �������� ��� byte
	ldi r24 ,43					; ������� 43�sec ����� �� ����������� � ����
	ldi r25 ,0					; ��� ��������� ��� ��� ������� ��� lcd
	rcall wait_usec
	ret

lcd_command:
	cbi PORTD ,PD2				; ������� ��� ���������� ������� (PD2=1)
	rcall write_2_nibbles		; �������� ��� ������� ��� ������� 39�sec
	ldi r24 ,39					; ��� ��� ���������� ��� ��������� ��� ��� ��� ������� ��� lcd.
	ldi r25 ,0					; ���.: �������� ��� �������, �� clear display ��� return home,
	rcall wait_usec				; ��� �������� ��������� ���������� ������� ��������.
	ret

lcd_init:
	ldi r24 ,40					; ���� � �������� ��� lcd ������������� ��
	ldi r25 ,0					; ����� ������� ��� ���� ��� ������������.
	rcall wait_msec				; ������� 40 msec ����� ���� �� �����������.
	ldi r24 ,0x30				; ������ ��������� �� 8 bit mode
	out PORTD ,r24				; ������ ��� �������� �� ������� �������
	sbi PORTD ,PD3				; ��� �� ���������� ������� ��� �������
	cbi PORTD ,PD3				; ��� ������, � ������ ������������ ��� �����
	ldi r24 ,39
	ldi r25 ,0					; ��� � �������� ��� ������ ��������� �� 8-bit mode
	rcall wait_usec				; ��� �� ������ ������, ���� �� � �������� ���� ����������
								; ������� 4 bit �� ������� �� ���������� 8 bit
	ldi r24 ,0x30	
	out PORTD ,r24
	sbi PORTD ,PD3
	cbi PORTD ,PD3
	ldi r24 ,39
	ldi r25 ,0
	rcall wait_usec
	ldi r24 ,0x20				; ������ �� 4-bit mode
	out PORTD ,r24
	sbi PORTD ,PD3
	cbi PORTD ,PD3
	ldi r24 ,39
	ldi r25 ,0
	rcall wait_usec
	ldi r24 ,0x28				; ������� ���������� �������� 5x8 ��������
	rcall lcd_command			; ��� �������� ��� ������� ���� �����
	ldi r24 ,0x0c				; ������������ ��� ������, �������� ��� �������
	rcall lcd_command
	ldi r24 ,0x01				; ���������� ��� ������
	rcall lcd_command
	ldi r24 ,low(1530)
	ldi r25 ,high(1530)
	rcall wait_usec
	ldi r24 ,0x06				; ������������ ��������� ������� ���� 1 ��� ����������
	rcall lcd_command			; ��� ����� ������������ ���� ������� ����������� ���
								; �������������� ��� ��������� ��������� ��� ������
	ret
