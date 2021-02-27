#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct virus {
    unsigned short SigSize;
    char virusName[16];
    char sig[];
} virus;

typedef struct link link;

struct link {
    link *nextVirus;
    virus *vir;
};

link *virus_list;

struct fun_desc {
  char *name;
  void (*fun)();
};

void PrintHex(char *buffer,int length) {
	int i;
	for(i=0; i<length;i++) {
		printf("%hhX ",buffer[i]);
	}
}

void printVirus(virus *v){
	printf("Virus name: %s\n", v->virusName);
	printf("Virus size: %d\n", v->SigSize);
	printf("Signature:\n");
	PrintHex(v->sig,v->SigSize);
	printf("\n");
}

void list_print(link *virus_list){
	link *curr_link = virus_list;
		while(curr_link != NULL){
			printVirus(curr_link->vir);
			curr_link = curr_link->nextVirus;
		}
}

//principles was taken from intro181
link* list_append(link* virus_list, virus* data){
	link *curr = NULL;
	link *new_link = malloc(sizeof(link));
	new_link->nextVirus = NULL;
	new_link->vir = data;

	if(virus_list == NULL){
		virus_list = new_link;
	}
	else{
		curr = virus_list;
		while(curr->nextVirus != NULL){
			curr = curr->nextVirus;
		}
		curr->nextVirus = new_link;
	}
	return virus_list;
}

void list_free(link* virus_list){
	if (virus_list == NULL) {
		return;
	}
	else {
		list_free(virus_list->nextVirus);
		free(virus_list->vir);
		free(virus_list);
	}
}

void load_signatures(){
	char filename[128];
	FILE* file = NULL;
	virus* v = NULL;
	short vir_size = 0;
	fgets(filename,sizeof(filename),stdin);
	filename[strlen(filename)-1]= '\0'; //remove \n
	file = fopen(filename, "r");
	if(file != NULL){
		while(fread(&vir_size,sizeof(short),1,file) > 0){   //there is more viruses to read
			v = malloc(vir_size);
			v->SigSize = vir_size - 18;
			fread(v->virusName, vir_size-2, 1, file);
			virus_list = list_append(virus_list,v);
		}
		fclose(file);
	}
}

void print_signatures(){
	list_print(virus_list);
}

void quit(){
	list_free(virus_list);
	exit(0);
}

void map(void (*f)()){
    f();
}

int main(int argc, char **argv) {
	int size_menu = 0;
	int index = 0;
	int action = 0;
	char option[128];
	struct fun_desc menu[] = {{"Load signatures", load_signatures}, {"Print signatures", print_signatures}, {"Quit",quit}, {"NULL", NULL}};

	//counting size of menu
  	while(strcmp((menu[size_menu].name),"NULL") != 0){
    	size_menu++;
 	 }

	while(1){ //loop until action = quit
		printf("Please choose a function:\n");

		while(strcmp((menu[index].name),"NULL") != 0) { //loop all options of functions
			printf("%d) %s\n", index+1, menu[index].name);
			index++;
		}
		index = 0; //reset the counter for printing menu again next loop

		printf("Option: ");
		fgets(option,sizeof(option),stdin);  //user input
		sscanf(option,"%d",&action);    //convert string to int

		if((action >= 1) & (action <= size_menu)){   //checking action bounds
			printf("Within bounds\n");
			map(menu[action-1].fun);
		}
		else {
			printf("Not Within bounds\n");
			list_free(virus_list);
			exit(0);
		}
	}
	return 0;
}
