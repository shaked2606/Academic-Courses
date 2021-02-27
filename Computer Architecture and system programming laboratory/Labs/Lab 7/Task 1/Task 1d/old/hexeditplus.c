#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

typedef struct {
  char debug_mode;
  char file_name[128];
  int unit_size;
  unsigned char mem_buf[10000];
  size_t mem_count;
  /*
   .
   .
   Any additional fields you deem necessary
  */
} state;


struct fun_desc{
  char *name;
  void (*fun)(state*);
};

char buffer[128];

/* Reads units from file */
void read_units_to_memory(FILE* input, char* buffer, int count,state *s) {
    fread(buffer, s->unit_size, count, input);
    
}

char* unit_to_format(int unit, int base) {
	if(base == 0){					//decimal print
		 	static char* formats_d[] = {"%#hhd\n", "%#hd\n", "No such unit", "%#d\n"};
			return formats_d[unit-1];
	}
	else{							// hexa print
    	static char* formats_h[] = {"%#hhx\n", "%#hx\n", "No such unit", "%#x\n"};
		return formats_h[unit-1];
	}
}  

/* Prints the buffer to screen by converting it to text with printf */
void print_units(FILE* output, char* buffer, int count, state *s) {
    char* end = buffer + (s->unit_size)*count;
    while (buffer < end) {
        //print ints
        int var = *((int*)(buffer));
        fprintf(output, unit_to_format(s->unit_size, 0), var);
		fprintf(output, unit_to_format(s->unit_size, 1), var);
        buffer += s->unit_size;
    }
}

/* Writes buffer to file without converting it to text with write */
void write_units(FILE* output, char* buffer, int count, state *s) {
    fwrite(buffer, s->unit_size, count, output);
}

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

void setFileName(state * s){
	printf("Enter filename: ");
	fgets(buffer, sizeof(buffer),stdin);
	buffer[strlen(buffer)-1] = '\0';
	strcpy(s->file_name, buffer);
	if(s->debug_mode == 1){
		printf("Debug: file name set to '%s'\n", s->file_name);
	}
}


void setUnitSize(state * s){
	int unitsize = 0;
	char unit_size_s[128];
	printf("Enter Unit Size: \n");
	fgets(unit_size_s,sizeof(unit_size_s),stdin);  //user input
	sscanf(unit_size_s,"%d",&unitsize);    //convert string to int
	if(unitsize == 1 || unitsize == 2 || unitsize == 4){
		s->unit_size = unitsize;
		if(s->debug_mode == 1){
			printf("Debug: set size to %d\n",unitsize);
		}
	}
	else{
		printf("Invalid unit size!\n");

	}

}

void LoadIntoMmemory(state *s){
	FILE * file = NULL;
	int location = -1;
	int length = -1;
	char location_s[128];
	char length_s[128];
	if(s->file_name == NULL){
		printf("Error: file name is NULL\n");
		return;
	}
	file = fopen(s->file_name, "r+");
	if(file == NULL){
		perror("Error open: ");
		return;
	}
	printf("Please enter <location> <length>\n");
	fgets(location_s,sizeof(location_s),stdin);  //user input
	sscanf(location_s,"%X",&location);    //convert string to int
	fgets(length_s,sizeof(length_s),stdin);  //user input
	sscanf(length_s,"%d",&length);    //convert string to int
	if(s->debug_mode == 1){
		printf("Filename: %s\n",s->file_name);
		printf("Location: %X\n",location);
		printf("Length: %d\n",length);
	}

	fseek(file, location, SEEK_SET);
	read_units_to_memory(file, (char*)s->mem_buf, length,  s);
	
	printf("Loaded %X units into memory\n",length);
	fclose(file);
}

void memoryDisplay(state *s){
	int u = -1;
	int addr = -1;
	char u_s[128];
	char addr_s[128];

	printf("Please enter <units> <address>\n");
	fgets(u_s,sizeof(u_s),stdin);  //user input
	sscanf(u_s,"%X",&u);    //convert string to int
	fgets(addr_s,sizeof(addr_s),stdin);  //user input
	sscanf(addr_s,"%d",&addr);    //convert string to int

	if(addr == 0){
		addr_s = &s->mem_buf;
	}
	print_units(stdout, addr_s, u, s);
}

void saveIntoFile(state *s){
	FILE *file = NULL;
	char* source_address = NULL;
	int target_location = -1;
	int length = -1;
	int size = 0;
	char source_address_s[128];
	char target_location_s[128];
	char length_s[128];

	printf("Please enter <source-address> <target-location> <length>\n");
	fgets(source_address_s,sizeof(source_address_s),stdin);  //user input
	sscanf(source_address_s,"%X",(unsigned int*)&source_address);    //convert string to int
	fgets(target_location_s,sizeof(target_location_s),stdin);  //user input
	sscanf(target_location_s,"%X",&target_location);    //convert string to int
	fgets(length_s,sizeof(length_s),stdin);  //user input
	sscanf(length_s,"%d",&length);    //convert string to int

	file = fopen(s->file_name, "r+");
	if(file == NULL){
		perror("Error open: ");
		return;
	}

	fseek(file, 0, SEEK_END);
	size = ftell(file);

	if(target_location > size){
		printf("Error target location is greater than file size\n");
		return;
	}

	fseek(file, target_location, SEEK_SET);
	if(source_address == 0){
		source_address = (char*)s->mem_buf;
	}

	write_units(file, source_address, length, s);

	printf("Write units with length %d into file\n",length);
	fclose(file);
}

void fileModify(state *s){
	FILE *file = NULL;
	int location = -1;
	int val = -1;
	char location_s[128];
	char val_s[128];

	printf("Please enter <location> <value>\n");
	fgets(location_s,sizeof(location_s),stdin);  //user input
	sscanf(location_s,"%X",&location);    //convert string to int
	fgets(val_s,sizeof(val_s),stdin);  //user input
	sscanf(val_s,"%X",&val);    //convert string to int

	if(s->debug_mode == 1){
		printf("Location: %X\n", location);
		printf("Val: %X\n", val);
	}
	file = fopen(s->file_name, "w+");
	if(file == NULL){
		perror("Error open: ");
		return;
	}
	if(location > 999 || location < 0){
		printf("Invalid input of location\n");
		return;
	}

	write_units(file, source_address_s, length, s);

	fclose(file);
}

void quit(state * s){
	if(s->debug_mode == 1){
		printf("quitting\n");
	}
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
	struct fun_desc menu[] = {{"Toggle Debug Mode",toggleDebugMode}, {"Set File Name",setFileName},{"Set Unit Size",setUnitSize},{"Load Into Memory",LoadIntoMmemory},{"Memory Display",memoryDisplay},{"Save Into File", saveIntoFile},{"File Modify",fileModify}, {"Quit",quit}, {"NULL",NULL}};
	state *s = malloc(sizeof(state));
	s->unit_size = 1;


	//counting size of menu
  	while(strcmp((menu[size_menu].name),"NULL") != 0){
    		size_menu++;
 	}

	while(1){
		if(s->debug_mode == 1){
			printf("DEBUG INFO:\n");
			printf("unit_size: %d\n", s->unit_size);
			printf("file_name: %s\n", s->file_name);
			printf("mem_count: %d\n", s->mem_count);
		}
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
