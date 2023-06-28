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
int main(int argc, char* argv[]) {
	// Exibindo a quantidade de argumentos
	printf("Quantidade de argumentos (argc): %i\n", argc);
	// Iterando sobre o(s) argumento(s) do programa
	for(uint32_t i = 0; i < argc; i++) {
		// Mostrando o argumento i
		printf("Argumento %i (argv[%i]): %s\n", i, i, argv[i]);
	}
	// Abrindo os arquivos com as permissoes corretas
	//FILE* input = fopen(argv[1], "r");
	//FILE* output = fopen(argv[2], "w");
	// .
	// .
	// .
	// Fechando os arquivos
	//fclose(input);
	//fclose(output);
	// Finalizando programa
	return 0;
}
