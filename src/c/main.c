// gcc -m32 -o main add42.o main.c
#include <stdio.h>
#include <inttypes.h>

int add42(int x);

struct Struct1 {
   int64_t j, k, l;    // Struct1 exceeds 64 bits.
};

struct Struct1  func3(int a, int b, int c, int d);

int a = 0.;
int main() {
    //printf("lê thingy %d", add42(2));
    //int myptr = (int)&a;
    func3(69, 420.0, 36, 7.0f); 
    return 0;
}
struct Struct1  func3(int a, int b, int c, int d) {
    
    return (struct Struct1){a,b,c};
}
