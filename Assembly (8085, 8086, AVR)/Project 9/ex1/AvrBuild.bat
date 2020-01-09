@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "E:\ex1\labels.tmp" -fI -W+ie -C V2E -o "E:\ex1\ex1.hex" -d "E:\ex1\ex1.obj" -e "E:\ex1\ex1.eep" -m "E:\ex1\ex1.map" "E:\ex1\ex1.asm"
