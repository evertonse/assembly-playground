// Numeros padronizados
#include <stdint.h>
// Biblioteca padrao
#include <stdlib.h>
// Entrada/saida padrao
#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>


void go_sort(int);

FILE *input, *output;

int main(int argc, char *argv[]) {
  input = fopen(argv[1], "r");
  if (input == NULL) {
    printf("Failed to open the input %s\n", argv[1]);
    return 24;
  }

  output = fopen(argv[2], "w");
  if (output == NULL) {
    printf("Failed to open the output %s.\n", argv[2]);
    return 420;
  }

  int n_array = 0;
  if (fscanf(input, "%d\n", &n_array) != 1) {
    printf("Invalid input format.\n");
    return 69;
  }
  for (size_t i = 0; i < n_array; i++) {
    go_sort(i);
  }

  fclose(input);
  fclose(output);

  return 0;
}

void go_sort(int run) {
  int *numbers;
  int count = 0;
  // Read the first number in the input as the size of the array
  if (fscanf(input, "%d\n", &count) != 1) {
    printf("Invalid input format.\n");
    exit(1);
  }
}
