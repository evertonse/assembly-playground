; compile: ml64.exe /c /Zi simple.asm
; link: link.exe /subsystem:console /entry:main simple.obj

.code
main PROC
    mov eax, 42     ; Move the value 42 into EAX
    ret             ; Return from the program
main ENDP

END