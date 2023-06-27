; ----------------------------------------------------------------------------
; triangle.asm
;
; A very simple *Windows* OpenGL application using the GLUT library.  It
; draws a nicely colored triangle in a top-level application window.  One
; interesting thing is that the Windows GL and GLUT functions do NOT use the
; C calling convention; instead they use the "stdcall" convention which is
; like C except that the callee pops the parameters.
;
; Assemble with "nasm -fwin32 glut.asm"
; Link with "ld -e_main -oglut glut.obj -lkernel32 -lglut -lopengl32 -luser32 -LC:/windows/system32 --enable-stdcall-fixup"
;ld -e_main -oglut glut.obj -lkernel32 -lfreeglut -lopengl32 -luser32 -LD:\tools\msys2\mingw64\lib -LC:/windows/system32 --enable-stdcall-fixup
;gcc -e_main -oglut glut.obj -lkernel32 -lfreeglut -lopengl32 -luser32 -LC:/windows/system32 --enable-stdcall-fixup
; ----------------------------------------------------------------------------

global  _main
extern  _glClear@4
extern  _glBegin@4
extern  _glEnd@0
extern  _glColor3f@12
extern  _glVertex3f@12
extern  _glFlush@0
extern  _glutInit@8
extern  _glutInitDisplayMode@4
extern  _glutInitWindowPosition@8
extern  _glutInitWindowSize@8
extern  _glutCreateWindow@4
extern  _glutDisplayFunc@4
extern  _glutMainLoop@0

        section .text
title:  db      'A Simple Triangle', 0
zero:   dd      0.0
one:    dd      1.0
half:   dd      0.5
neghalf:dd      -0.5

display:
        mov rcx, dword 16384
        call    _glClear@4              ; glClear(GL_COLOR_BUFFER_BIT)

        mov rcx, dword 9
        call    _glBegin@4              ; glBegin(GL_POLYGON)

        movss xmm0, [zero]
        movss xmm1, [zero]
        movss xmm2, [one]
        call    _glColor3f@12           ; glColor3f(1, 0, 0)

        movss xmm0, [zero]
        movss xmm1, [zero]
        movss xmm2, [neghalf]
        call    _glVertex3f@12          ; glVertex(-.5, -.5, 0)

        movss xmm0, [zero]
        movss xmm1, [one]
        movss xmm2, [zero]
        call    _glColor3f@12           ; glColor3f(0, 1, 0)

        movss xmm0, [zero]
        movss xmm1, [neghalf]
        movss xmm2, [half]
        call    _glVertex3f@12          ; glVertex(.5, -.5, 0)

        movss xmm1, [zero]
        movss xmm0, [zero]
        movss xmm2, [one]
        call    _glColor3f@12           ; glColor3f(0, 0, 1)
        
        movss xmm1, [zero]
        movss xmm0, [half]
        movss xmm2, [one]
        call    _glVertex3f@12          ; glVertex(0, .5, 0)

        call    _glEnd@0                ; glEnd()
        call    _glFlush@0              ; glFlush()
        ret

_main:
        push rcx
        lea rcx, [rsp] 
        call    _glutInit@8             ; glutInit(&argc, argv)

        mov rcx, 0
        call    _glutInitDisplayMode@4
        
        mov rcx, 80
        mov rdx, 80
        
        call    _glutInitWindowPosition@8

        mov rcx, 300
        mov rdx, 400
        call    _glutInitWindowSize@8

        mov r8, title
        call    _glutCreateWindow@4
        push    display
        call    _glutDisplayFunc@4
        call    _glutMainLoop@0
        ret
