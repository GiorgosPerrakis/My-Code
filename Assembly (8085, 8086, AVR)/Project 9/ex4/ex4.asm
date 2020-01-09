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
	sbiw r24 ,1					; 2 κύκλοι (0.250 μsec)
	nop							; 1 κύκλος (0.125 μsec)
	nop							; 1 κύκλος (0.125 μsec)
	nop							; 1 κύκλος (0.125 μsec)
	nop							; 1 κύκλος (0.125 μsec)
	brne wait_usec				; 1 ή 2 κύκλοι (0.125 ή 0.250 μsec)
	ret							; 4 κύκλοι (0.500 μsec)

wait_msec:
	push r24					; 2 κύκλοι (0.250 μsec)
	push r25					; 2 κύκλοι
	ldi r24 , low(998)			; φόρτωσε τον καταχ. r25:r24 με 998 (1 κύκλος - 0.125 μsec)
	ldi r25 , high(998)			; 1 κύκλος (0.125 μsec)
	rcall wait_usec				; 3 κύκλοι (0.375 μsec), προκαλεί συνολικά καθυστέρηση 998.375 μsec
	pop r25						; 2 κύκλοι (0.250 μsec)
	pop r24						; 2 κύκλοι
	sbiw r24 , 1				; 2 κύκλοι
	brne wait_msec				; 1 ή 2 κύκλοι (0.125 ή 0.250 μsec)
	ret							; 4 κύκλοι (0.500 μsec)

write_2_nibbles:
	push r24					; στέλνει τα 4 MSB
	in r25 ,PIND				; διαβάζονται τα 4 LSB και τα ξαναστέλνουμε
	andi r25 ,0x0f				; για να μην χαλάσουμε την όποια προηγούμενη κατάσταση
	andi r24 ,0xf0				; απομονώνονται τα 4 MSB και
	add r24 ,r25				; συνδυάζονται με τα προϋπάρχοντα 4 LSB
	out PORTD ,r24				; και δίνονται στην έξοδο
	sbi PORTD ,PD3				; δημιουργείται παλμός Enable στον ακροδέκτη PD3
	cbi PORTD ,PD3				; PD3=1 και μετά PD3=0
	pop r24						; στέλνει τα 4 LSB. Ανακτάται το byte.
	swap r24					; εναλλάσσονται τα 4 MSB με τα 4 LSB
	andi r24 ,0xf0				; που με την σειρά τους αποστέλλονται
	add r24 ,r25
	out PORTD ,r24
	sbi PORTD ,PD3				; Νέος παλμός Enable
	cbi PORTD ,PD3
	ret

lcd_data:
	sbi PORTD ,PD2				; επιλογή του καταχωρήτη δεδομένων (PD2=1)
	rcall write_2_nibbles		; αποστολή του byte
	ldi r24 ,43					; αναμονή 43μsec μέχρι να ολοκληρωθεί η λήψη
	ldi r25 ,0					; των δεδομένων από τον ελεγκτή της lcd
	rcall wait_usec
	ret

lcd_command:
	cbi PORTD ,PD2				; επιλογή του καταχωρητή εντολών (PD2=1)
	rcall write_2_nibbles		; αποστολή της εντολής και αναμονή 39μsec
	ldi r24 ,39					; για την ολοκλήρωση της εκτέλεσης της από τον ελεγκτή της lcd.
	ldi r25 ,0					; ΣΗΜ.: υπάρχουν δύο εντολές, οι clear display και return home,
	rcall wait_usec				; που απαιτούν σημαντικά μεγαλύτερο χρονικό διάστημα.
	ret

lcd_init:
	ldi r24 ,40					; Όταν ο ελεγκτής της lcd τροφοδοτείται με
	ldi r25 ,0					; ρεύμα εκτελεί την δική του αρχικοποίηση.
	rcall wait_msec				; Αναμονή 40 msec μέχρι αυτή να ολοκληρωθεί.
	ldi r24 ,0x30				; εντολή μετάβασης σε 8 bit mode
	out PORTD ,r24				; επειδή δεν μπορούμε να είμαστε βέβαιοι
	sbi PORTD ,PD3				; για τη διαμόρφωση εισόδου του ελεγκτή
	cbi PORTD ,PD3				; της οθόνης, η εντολή αποστέλλεται δύο φορές
	ldi r24 ,39
	ldi r25 ,0					; εάν ο ελεγκτής της οθόνης βρίσκεται σε 8-bit mode
	rcall wait_usec				; δεν θα συμβεί τίποτα, αλλά αν ο ελεγκτής έχει διαμόρφωση
								; εισόδου 4 bit θα μεταβεί σε διαμόρφωση 8 bit
	ldi r24 ,0x30	
	out PORTD ,r24
	sbi PORTD ,PD3
	cbi PORTD ,PD3
	ldi r24 ,39
	ldi r25 ,0
	rcall wait_usec
	ldi r24 ,0x20				; αλλαγή σε 4-bit mode
	out PORTD ,r24
	sbi PORTD ,PD3
	cbi PORTD ,PD3
	ldi r24 ,39
	ldi r25 ,0
	rcall wait_usec
	ldi r24 ,0x28				; επιλογή χαρακτήρων μεγέθους 5x8 κουκίδων
	rcall lcd_command			; και εμφάνιση δύο γραμμών στην οθόνη
	ldi r24 ,0x0c				; ενεργοποίηση της οθόνης, απόκρυψη του κέρσορα
	rcall lcd_command
	ldi r24 ,0x01				; καθαρισμός της οθόνης
	rcall lcd_command
	ldi r24 ,low(1530)
	ldi r25 ,high(1530)
	rcall wait_usec
	ldi r24 ,0x06				; ενεργοποίηση αυτόματης αύξησης κατά 1 της διεύθυνσης
	rcall lcd_command			; που είναι αποθηκευμένη στον μετρητή διευθύνσεων και
								; απενεργοποίηση της ολίσθησης ολόκληρης της οθόνης
	ret
