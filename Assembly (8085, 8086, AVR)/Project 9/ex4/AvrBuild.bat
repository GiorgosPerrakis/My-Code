@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "E:\ex4\labels.tmp" -fI -W+ie -C V2E -o "E:\ex4\ex4.hex" -d "E:\ex4\ex4.obj" -e "E:\ex4\ex4.eep" -m "E:\ex4\ex4.map" "E:\ex4\ex4.asm"
