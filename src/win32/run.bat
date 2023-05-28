cls
rem make sure cl.exe is available
ml64 -c -Fofile.o file.asm 
cl -Zi -nologo -Femain.exe file.o main.cpp  /link /LARGEADDRESSAWARE:NO

objdump -j.data -s -d -M intel file.o > file.dump.dis
cl -Fa file.cl.dis file.o main.cpp

g++ -S -Os -masm=intel file.o main.cpp -omain.gxx.dis

main.exe
rem http://www.masm32.com/board/index.php