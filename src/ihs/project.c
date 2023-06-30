// Como executar no terminal:
// gcc -Wall -O3 nomesobrenome_123456789012_exemplo.c -o nomesobrenome_123456789012_exemplo
// ./nomesobrenome_123456789012_exemplo entrada saida

// Numeros padronizados
#include <stdint.h>
// Biblioteca padrao
#include <stdlib.h>
// Entrada/saida padrao
#include <stdio.h>

int a = 'd';
// Funcao principal

void bubbleSort(int arr[], int n) {
    int i, j;
    for (i = 0; i < n-1; i++) {
        for (j = 0; j < n-i-1; j++) {
            if (arr[j] > arr[j+1]) {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

int main(int argc, char* argv[]) {
    FILE *file;
    int numbers[100];
    int count = 0;

    // Open the file for reading
    file = fopen("numbers.txt", "r");
    if (file == NULL) {
        printf("Failed to open the file.\n");
        return 1;
    }

    // Read numbers from the file
    while (fscanf(file, "%d", &numbers[count]) == 1) {
        count++;
    }

    // Close the file
    fclose(file);

    // Sort the numbers using bubble sort
    bubbleSort(numbers, count);

    // Display the sorted numbers
    printf("Sorted numbers:\n");
    for (int i = 0; i < count; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\n");

    return 0;
}
