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

scan_row:
	ldi r25 ,0x08				; αρχικοποίηση με 0000 1000
back_:
	lsl r25						; αριστερή ολίσθηση του 1 τόσες θέσεις
	dec r24						; όσος είναι ο αριθμός της γραμμής
	brne back_
	out PORTC ,r25				; η αντίστοιχη γραμμή τίθεται στο λογικό 1
	nop
	nop							; καθυστέρηση για να προλάβει να γίνει η αλλαγή κατάστασης
	in r24 ,PINC				; επιστρέφουν οι θέσεις (στήλες) των διακοπτών που είναι πιεσμένοι
	andi r24 ,0x0f				; απομονώνονται τα 4 LSB όπου τα 1 δείχνουν που είναι πατημένοι
	ret							; οι διακόπτες.

scan_keypad:
	ldi r24 ,0x01				; έλεγξε την πρώτη γραμμή του πληκτρολογίου
	rcall scan_row
	swap r24					; αποθήκευσε το αποτέλεσμα
	mov r27 ,r24				; στα 4 msb του r27
	ldi r24 ,0x02				; έλεγξε τη δεύτερη γραμμή του πληκτρολογίου
	rcall scan_row
	add r27 ,r24				; αποθήκευσε το αποτέλεσμα στα 4 lsb του r27
	ldi r24 ,0x03				; έλεγξε την τρίτη γραμμή του πληκτρολογίου
	rcall scan_row
	swap r24					; αποθήκευσε το αποτέλεσμα
	mov r26 ,r24				; στα 4 msb του r26
	ldi r24 ,0x04				; έλεγξε την τέταρτη γραμμή του πληκτρολογίου
	rcall scan_row
	add r26 ,r24				; αποθήκευσε το αποτέλεσμα στα 4 lsb του r26
	movw r24 ,r26				; μετέφερε το αποτέλεσμα στους καταχωρητές r25:r24
	ret

scan_keypad_rising_edge:
	mov r22 ,r24				; αποθήκευσε το χρόνο σπινθηρισμού στον r22
	rcall scan_keypad			; έλεγξε το πληκτρολόγιο για πιεσμένους διακόπτες
	push r24					; και αποθήκευσε το αποτέλεσμα
	push r25
	mov r24 ,r22				; καθυστέρησε r22 ms (τυπικές τιμές 10-20 msec που καθορίζεται από τον
	ldi r25 ,0					; κατασκευαστή του πληκτρολογίου  χρονοδιάρκεια σπινθηρισμών)
	rcall wait_msec
	rcall scan_keypad			; έλεγξε το πληκτρολόγιο ξανά και απόρριψε
	pop r23						; όσα πλήκτρα εμφανίζουν σπινθηρισμό
	pop r22
	and r24 ,r22
	and r25 ,r23
	ldi r26 ,low(_tmp_)			; φόρτωσε την κατάσταση των διακοπτών στην
	ldi r27 ,high(_tmp_)		; προηγούμενη κλήση της ρουτίνας στους r27:r26
	ld r23 ,X+
	ld r22 ,X
	st X ,r24					; αποθήκευσε στη RAM τη νέα κατάσταση
	st -X ,r25					; των διακοπτών
	com r23
	com r22						; βρες τους διακόπτες που έχουν «μόλις» πατηθεί
	and r24 ,r22
	and r25 ,r23
	ret

keypad_to_ascii:				; λογικό 1 στις θέσεις του καταχωρητή r26 δηλώνουν
	movw r26 ,r24				; τα παρακάτω σύμβολα και αριθμούς
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
	sbrc r26 ,3					; αν δεν είναι 1παρακάμπτει την ret, αλλιώς (αν είναι 1)
	ret							; επιστρέφει με τον καταχωρητή r24 την ASCII τιμή του D.
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
	ldi r24 ,'4'				; λογικό 1 στις θέσεις του καταχωρητή r27 δηλώνουν
	sbrc r27 ,0					; τα παρακάτω σύμβολα και αριθμούς
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
