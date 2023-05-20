#include "stdio.h"

int _start() {}

int another() {
    long long n_long = 0xcafebabef00dface;
    int n_int = 0xdeadbeef;
    char* n_char_ptr = "char";
    char n_char_ptr2[] = {'c','h', 'a', 'r'};
}

int main() {
  int array[4] = {1,2,3,4};
  puts("hello, world");
  another();
  return 1;
}
