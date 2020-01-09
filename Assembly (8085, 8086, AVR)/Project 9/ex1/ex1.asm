.include "m16def.inc"

.dseg
_tmp_: .byte 2
.def temp = r18
.cseg

start:
	ldi r24, low(RAMEND)																		
	out SPL, r24
	ldi r24, high(RAMEND)
	out SPH, r24

	ldi r24, (1 << PC7) | (1 << PC6) | (1 << PC5) | (1 << PC4)									; set 4 MSBs as output
	out DDRC, r24																				; in PORTC
	
	ldi r24, (1 << PD7) | (1 << PD6) | (1 << PD5) | (1 << PD4) | (1 << PD3) | (1 << PD2)		; set 6 MSBs as output
	out DDRD, r24														
							; in PORTD

	call lcd_init																				; initialize lcd screen with "NONE"
	ldi r24,'N'
	call lcd_data
	ldi r24,'O'
	call lcd_data
	ldi r24,'N'	
	call lcd_data
	ldi r24,'E'
	call lcd_data

loop:
	ldi r24, 20						; set 20ms bouncing delay
	call scan_keypad_rising_edge	; read keyboard
	call keypad_to_ascii
	cpi r24, 0						; if no buttons are pressed, read again
	breq loop
	mov temp, r24					; temp has the number that was pressed

	ldi r24, 0x02					; clear screen
	rcall lcd_command

	mov r24, temp					
	call lcd_data					; print number to the screen
	ldi r24,' '
	call lcd_data
	ldi r24,' '
	call lcd_data
	ldi r24,' '
	call lcd_data
	jmp loop


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

scan_row:
	ldi r25 ,0x08				; ������������ �� �0000 1000�
back_:
	lsl r25						; �������� �������� ��� �1� ����� ������
	dec r24						; ���� ����� � ������� ��� �������
	brne back_
	out PORTC ,r25				; � ���������� ������ ������� ��� ������ �1�
	nop
	nop							; ����������� ��� �� �������� �� ����� � ������ ����������
	in r24 ,PINC				; ����������� �� ������ (������) ��� ��������� ��� ����� ���������
	andi r24 ,0x0f				; ������������� �� 4 LSB ���� �� �1� �������� ��� ����� ���������
	ret							; �� ���������.

scan_keypad:
	ldi r24 ,0x01				; ������ ��� ����� ������ ��� �������������
	rcall scan_row
	swap r24					; ���������� �� ����������
	mov r27 ,r24				; ��� 4 msb ��� r27
	ldi r24 ,0x02				; ������ �� ������� ������ ��� �������������
	rcall scan_row
	add r27 ,r24				; ���������� �� ���������� ��� 4 lsb ��� r27
	ldi r24 ,0x03				; ������ ��� ����� ������ ��� �������������
	rcall scan_row
	swap r24					; ���������� �� ����������
	mov r26 ,r24				; ��� 4 msb ��� r26
	ldi r24 ,0x04				; ������ ��� ������� ������ ��� �������������
	rcall scan_row
	add r26 ,r24				; ���������� �� ���������� ��� 4 lsb ��� r26
	movw r24 ,r26				; �������� �� ���������� ����� ����������� r25:r24
	ret

scan_keypad_rising_edge:
	mov r22 ,r24				; ���������� �� ����� ������������ ���� r22
	rcall scan_keypad			; ������ �� ������������ ��� ���������� ���������
	push r24					; ��� ���������� �� ����������
	push r25
	mov r24 ,r22				; ����������� r22 ms (������� ����� 10-20 msec ��� ����������� ��� ���
	ldi r25 ,0					; ������������ ��� ������������� � ������������� ������������)
	rcall wait_msec
	rcall scan_keypad			; ������ �� ������������ ���� ��� ��������
	pop r23						; ��� ������� ���������� �����������
	pop r22
	and r24 ,r22
	and r25 ,r23
	ldi r26 ,low(_tmp_)			; ������� ��� ��������� ��� ��������� ����
	ldi r27 ,high(_tmp_)		; ����������� ����� ��� �������� ����� r27:r26
	ld r23 ,X+
	ld r22 ,X
	st X ,r24					; ���������� ��� RAM �� ��� ���������
	st -X ,r25					; ��� ���������
	com r23
	com r22						; ���� ���� ��������� ��� ����� ������ �������
	and r24 ,r22
	and r25 ,r23
	ret

keypad_to_ascii:				; ������ �1� ���� ������ ��� ���������� r26 ��������
	movw r26 ,r24				; �� �������� ������� ��� ��������
	ldi r24 ,'*'
	sbrc r26 ,0
	ret
	ldi r24 ,'0'
	sbrc r26 ,1
	ret
	ldi r24 ,'#'
	sbrc r26 ,2
	ret
	ldi r24 ,'D'
	sbrc r26 ,3					; �� ��� ����� �1������������ ��� ret, ������ (�� ����� �1�)
	ret							; ���������� �� ��� ���������� r24 ��� ASCII ���� ��� D.
	ldi r24 ,'7'
	sbrc r26 ,4
	ret
	ldi r24 ,'8'
	sbrc r26 ,5
	ret
	ldi r24 ,'9'
	sbrc r26 ,6
	ret
	ldi r24 ,'C'
	sbrc r26 ,7
	ret
	ldi r24 ,'4'				; ������ �1� ���� ������ ��� ���������� r27 ��������
	sbrc r27 ,0					; �� �������� ������� ��� ��������
	ret
	ldi r24 ,'5'
	sbrc r27 ,1
	ret
	ldi r24 ,'6'
	sbrc r27 ,2
	ret
	ldi r24 ,'B'
	sbrc r27 ,3
	ret
	ldi r24 ,'1'
	sbrc r27 ,4
	ret
	ldi r24 ,'2'	
	sbrc r27 ,5
	ret
	ldi r24 ,'3'
	sbrc r27 ,6
	ret
	ldi r24 ,'A'
	sbrc r27 ,7
	ret
	clr r24
	ret

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
