
test:     file format pe-x86-64


Disassembly of section .text:

0000000000000000 <main>:
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 83 ec 30          	sub    rsp,0x30
   8:	e8 00 00 00 00       	call   d <main+0xd>
   d:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [rbp-0x10],0x1
  14:	c7 45 f4 02 00 00 00 	mov    DWORD PTR [rbp-0xc],0x2
  1b:	c7 45 f8 03 00 00 00 	mov    DWORD PTR [rbp-0x8],0x3
  22:	c7 45 fc 04 00 00 00 	mov    DWORD PTR [rbp-0x4],0x4
  29:	48 8d 05 00 00 00 00 	lea    rax,[rip+0x0]        # 30 <main+0x30>
  30:	48 89 c1             	mov    rcx,rax
  33:	e8 00 00 00 00       	call   38 <main+0x38>
  38:	b8 01 00 00 00       	mov    eax,0x1
  3d:	48 83 c4 30          	add    rsp,0x30
  41:	5d                   	pop    rbp
  42:	c3                   	ret

0000000000000043 <another>:
  43:	55                   	push   rbp
  44:	48 89 e5             	mov    rbp,rsp
  47:	48 83 ec 20          	sub    rsp,0x20
  4b:	48 b8 ce fa 0d f0 be 	movabs rax,0xcafebabef00dface
  52:	ba fe ca 
  55:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
  59:	c7 45 f4 ef be ad de 	mov    DWORD PTR [rbp-0xc],0xdeadbeef
  60:	48 8d 05 0d 00 00 00 	lea    rax,[rip+0xd]        # 74 <another+0x31>
  67:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
  6b:	c7 45 e4 63 68 61 72 	mov    DWORD PTR [rbp-0x1c],0x72616863
  72:	90                   	nop
  73:	48 83 c4 20          	add    rsp,0x20
  77:	5d                   	pop    rbp
  78:	c3                   	ret
  79:	90                   	nop
  7a:	90                   	nop
  7b:	90                   	nop
  7c:	90                   	nop
  7d:	90                   	nop
  7e:	90                   	nop
  7f:	90                   	nop
