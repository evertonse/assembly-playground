#include "stdio.h"

//extern "C" int func();
extern "C" char* flags();

int main() {
    printf("Hello from cpp %s", flags());
    //printf("Hello from cpp %x", flags());
}