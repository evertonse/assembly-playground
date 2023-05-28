.386
.model flat, c
.code
s struct
x db 3 dup(?)
s ends
foo proto :s
bar proc
local x:s
invoke foo,x
ret
bar endp
end

;Code produced:
;push ebp
;mov ebp, esp
;add esp, -4
;mov al, byte ptr [ebp-2H]
;push ax
;push word ptr [ebp-2H] <-- should be [ebp-4]
;call _foo
;add esp,4
;leave
;ret