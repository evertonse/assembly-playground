
# gprof
- gcc -g -pg file.c -o file.bin
- ./file.bin arg0 arg1 .. argn %
- gprof ./pg.bin gmon.out

# perf

# debuugers
-  x64dbg
-  IDA Pro
- gdb-peda

# gcov
- ``gcc --coverage -g file.c -o file.bin` && file.bin`
- ``gcov file.bin-file.c && cat file.c.gcov``

