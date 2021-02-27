#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct virus {
    unsigned short SigSize;
    char virusName[16];
    char sig[];
} virus;

void PrintHex(char *buffer,int length) {
	int i;
	for(i=0; i<length;i++) {
		printf("%hhX ",buffer[i]);
	}
	printf("\n");
}

void printVirus(virus *v){  
	printf("Virus name: %s\n", v->virusName);
	printf("Virus size: %d\n", v->SigSize);
	PrintHex(v->sig,v->SigSize);
}

int main(int argc, char **argv) {
	char* filename = "signatures";   //assume file name input as constant
	short vir_size = 0;
	FILE* file = NULL;
	virus* v = NULL;

	file = fopen(filename, "r");
	if(file != NULL){
		while(fread(&vir_size,sizeof(short),1,file) > 0){   //there is more viruses to read
			v = malloc(vir_size);
			v->SigSize = vir_size - 18;
			fread(v->virusName, vir_size-2, 1, file);
			printVirus(v);
			free(v);
		}
	}

	fclose(file);

	return 0;
} 
