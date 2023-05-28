// gcc -m32 -o main add42.o main.c
#include <stdio.h>

int add42(int x);
int a = 0.;
int main() {
    printf("lê thingy %d", add42(2));
    int myptr = (int)&a;
}