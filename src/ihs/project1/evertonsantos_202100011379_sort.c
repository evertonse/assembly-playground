// Como executar no terminal:
// gcc -Wall -O3 nomesobrenome_123456789012_exemplo.c -o
// nomesobrenome_123456789012_exemplo gcc -Wall -O3 project.c -o project.bin &&
// ./project.bin sort.input
// ./nomesobrenome_123456789012_exemplo entrada saida
// /home/excyber/code/assembly-playground/src/ihs/project1/evertonsantos_202100011379_sort.s


// Numeros padronizados
#include <stdint.h>
// Biblioteca padrao
#include <stdlib.h>
// Entrada/saida padrao
#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>

void bubble_sort(int arr[], int n) {
  int i, j;
  for (i = 0; i < n - 1; i++) {
    for (j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}

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

  // Allocate memory for the array dynamically
  numbers = (int *)malloc(count * sizeof(int));
  if (numbers == NULL) {
    printf("Memory allocation failed.\n");
    exit(1);
  }

  // Read numbers from the input

  puts("################################\n");
  puts("--------------INPUT---------------\n");
  printf("[%d] ", run);
  for (int i = 0; i < count; i++) {
    if (fscanf(input, "%d", &numbers[i]) != 1) {
      printf("Invalid input format.\n");
      exit(1);
    }
    printf("%d ", numbers[i]);
  }
  putchar('\n');
  // Sort the numbers using bubble sort
  bubble_sort(numbers, count);

  puts("---------------OUTPUT---------------\n");
  // Display the sorted numbers
  fprintf(output, "[%d] ", run);
  printf("[%d] ", run);
  for (int i = 0; i < count; i++) {
    fprintf(output, "%d ", numbers[i]);
    printf("%d ", numbers[i]);
  }
  fprintf(output, "\n");
  printf("\n");
  // Free the dynamically allocated memory
  free(numbers);
  // Close the input
}
