#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <elf.h>
#include <sys/mman.h>

typedef struct {
  char debug_mode;
  char file_name[128];
  int unit_size;
  //unsigned char mem_buf[10000];
  //size_t mem_count;

} state;


struct fun_desc{
  char *name;
  void (*fun)(state*);
};

char buffer[128];	// for get file name input from user
int Currentfd = -1;	// file descriptor of the executable file
void *map_start;	// will point to the start of the memory mapped file

// function that return encoding data scheme string
char* dataEncodingScheme(int value){
	char* data_scheme = NULL;
	if(value == 1){
		data_scheme = "2's complement, little endian";
	}
	else{
		data_scheme = "2's complement, big endian";	
	}
	return data_scheme;
}

// function prints all header data
void printHeaderData(Elf32_Ehdr* header, struct stat fd_stat){
	printf("Bytes 1,2,3 of the magic number (in ASCII): %c,%c,%c\n",header->e_ident[1],header->e_ident[2],header->e_ident[3]);

	// checks if the file is ELF file
	if(header->e_ident[1] != 'E' || header->e_ident[2] != 'L' || header->e_ident[3] != 'F'){
		perror("not an ELF file!\n");
		// unmap the file
		munmap(0, fd_stat.st_size);
		// close the fd
		close(Currentfd);
		// exit with error
		exit(1);
	}

	printf("Data: %s\n", dataEncodingScheme(header->e_ident[5]));

	printf("Entry point: %x\n", header->e_entry);

	printf("Start of section headers: %d (bytes into file)\n", header->e_shoff);

	printf("Number of section headers: %d\n", header->e_shnum);

	printf("Size of section headers: %d (bytes)\n", header->e_shentsize);

	printf("Start of program headers: %d (bytes into file)\n", header->e_phoff);

	printf("Number of program headers: %d\n", header->e_phnum);

	printf("Size of program headers: %d (bytes)\n", header->e_phentsize);
}

// activate debug_mode, if off, or turn it off if on
void toggleDebugMode(state * s){
	if(s->debug_mode == 1){
		s->debug_mode = 0;
		printf("Debug flag now off\n");
	}
	else{
		s->debug_mode = 1;
		printf("Debug flag now on\n");
	}
}

// function prints the header of the ELF file
// prinicpels was taken from course website
void examineElfFile(state *s){
	struct stat fd_stat;	// this is needed to  the size of the file
	Elf32_Ehdr *header;	// this will point to the header structure

	// get file name from the user:
	printf("Enter file name: ");
	fgets(buffer, sizeof(buffer),stdin);			
	buffer[strlen(buffer)-1] = '\0';
	strcpy(s->file_name, buffer);
	if(s->debug_mode == 1){
		printf("Debug: file name set to '%s'\n", s->file_name);
	}

	// when debug_mode is on
	if(s->debug_mode == 1){
		printf("DEBUG INFO:\n");
		printf("file_name: %s\n", s->file_name);
	}
	
	// close any currently open file
	close(Currentfd);

	// open the file with the name inputed:
	Currentfd = open(s->file_name, O_RDWR);
	
	// checks if open not succeed
	if(Currentfd < 0){
		perror("Error open");
		Currentfd = -1;
		exit(1);
	}
	else{
		// checks the size of the file
		if(fstat(Currentfd, &fd_stat) != 0){
			perror("stat failed");
			Currentfd = -1;
			exit(1);
		}
		// mmap the file 
		if((map_start = mmap(0, fd_stat.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, Currentfd, 0)) == MAP_FAILED){
			perror("mmap failed");
			Currentfd = -1;
			exit(-4);
		}

		header = (Elf32_Ehdr*) map_start;		// header point to the beginning of the mapped file
 
		printHeaderData(header, fd_stat);		// print all header data
	}
}


void quit(state * s){
	struct stat fd_stat;	// this is needed to  the size of the file
	if(s->debug_mode == 1){
		printf("DEBUG INFO:\n");
		printf("file_name: %s\n", s->file_name);
		printf("quitting\n");
	}

	// close any currently open file
	close(Currentfd);

	// open the file with the name inputed:
	Currentfd = open(s->file_name, O_RDWR);
	
	// checks if open not succeed
	if(Currentfd < 0){
		perror("Error open: ");
		exit(1);
	}
	// checks the size of the file
	if(fstat(Currentfd, &fd_stat) != 0){
		perror("stat failed");
		exit(1);
	}
	// unmap the file
	munmap(0, fd_stat.st_size);
	// close the fd
	close(Currentfd);
	// exit normally
	free(s);
	exit(0);
}

void map(void (*f)(state*), state * s){
    f(s);
}

int main(int argc, char **argv) {
	int size_menu = 0;
	int index = 0;
	int action = 0;
	char option[128];
	struct fun_desc menu[] = {{"Toggle Debug Mode",toggleDebugMode}, {"Examine ELF File",examineElfFile}, {"Quit",quit}, {"NULL",NULL}};
	state *s = malloc(sizeof(state));
	s->unit_size = 1;
	s->debug_mode = 0;

	//counting size of menu
  	while(strcmp((menu[size_menu].name),"NULL") != 0){
    		size_menu++;
 	}

	while(1){
		printf("Choose action:\n");
		while(strcmp((menu[index].name),"NULL") != 0) { //loop all options of functions
			printf("%d- %s\n", index, menu[index].name);
			index++;
		}
		index = 0; //reset the counter for printing menu again next loop

		printf("Option: ");
		fgets(option,sizeof(option),stdin);  //user input
		sscanf(option,"%d",&action);    //convert string to int

		if((action >= 0) & (action < size_menu)){   //checking action bounds
			printf("Input Within bounds\n");
			map(menu[action].fun, s);
		}
		else {
			printf("Input Not Within bounds\n");
			exit(0);
		}
	}
	return 0;
}
