bits 64

section .rodata

msg:
  db  "Hello!",0
caption:
  db  "Hello Windows App",0

section .text

  ; Importado de user32.dll
  extern __imp_MessageBoxA

  global WinMain
WinMain:
  sub   rsp,40        ; Isso é necessário.
                      ; Estranhamente é preciso avançar RSP
                      ; por causa dos argumentos de WinMain e
                      ; o endereço de retorno... senão dá crash!

  xor   ecx,ecx       ; hWnd = NULL
  lea   rdx,[msg]     ; msg ptr
  lea   r8,[caption]  ; caption ptr
  mov   r9d,0x40      ; MB_OK | MB_ICONINFORMATION
  call  [__imp_MessageBoxA] 

  xor   eax,eax       ; return 0L;

  add   rsp,40        ; Retorna a pilha para o lugar original.

  ret