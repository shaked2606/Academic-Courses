#include <stdlib.h>
#include <stdio.h>

void PrintHex(char *buffer,int length) {
	int i;
	for(i=0; i<length;i++) {
		printf("%hhX ",buffer[i]);
	}
	printf("\n");
}

int main(int argc, char **argv) {
	char *filename = argv[1];
	char *content = NULL;
	int file_length = 0;
	FILE *file;
	file = fopen(filename,"r");

	fseek(file,0,SEEK_END);     //seeking through the end of file
	file_length = ftell(file); //position of pointer of file
	fseek(file,0,SEEK_SET);    //seeking to the begining of file

	content = malloc(file_length);
	fread(content,1,file_length,file);
	PrintHex(content,file_length);

	free(content);
	fclose(file);

	return 0;
}
