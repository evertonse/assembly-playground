gcc -fpic -c math.c -nostdlib  
gcc -fpic math.o -nostdlib  -shared -olib/libmath.so  -Wl,-soname,libmath.so
gcc main.c -c -Iinc -Llib 
gcc main.o -o main.exe -lmath -Iinc -Llib 
