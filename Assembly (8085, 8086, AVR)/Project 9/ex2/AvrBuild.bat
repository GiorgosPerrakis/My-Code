@ECHO OFF
"C:\Program Files\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "E:\ex2\labels.tmp" -fI -W+ie -C V2E -o "E:\ex2\ex2.hex" -d "E:\ex2\ex2.obj" -e "E:\ex2\ex2.eep" -m "E:\ex2\ex2.map" "E:\ex2\ex2.asm"
