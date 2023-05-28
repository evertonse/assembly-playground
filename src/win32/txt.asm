.386

.model flat, stdcall

includelib \masm32\lib\msvcrt.lib
printf proto c :ptr, :vararg

THREEBYTE struct
one BYTE ?
two BYTE ?
three BYTE ?
THREEBYTE ends

.data
received db “Values received one: %hhx two: %hhx three: %hhx”,0

.code

myfunct proc threeBytes : THREEBYTE
invoke printf, offset received, threeBytes.one, threeBytes.two, threeBytes.three
ret
myfunct endp

main proc
LOCAL threeBytes : THREEBYTE

mov BYTE PTR threeBytes.one, 1
mov BYTE PTR threeBytes.two, 2
mov BYTE PTR threeBytes.three, 3
;int 3
INVOKE myfunct, threeBytes
ret
main endp