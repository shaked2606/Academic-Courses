#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <elf.h>
#include <sys/mman.h>


char buffer[128];	// for get file name input from user
int Currentfd = -1;	// file descriptor of the executable file
void *map_start;	// will point to the start of the memory mapped file

int main(int argc, char **argv) {
	struct stat fd_stat;	// this is needed to  the size of the file
	Elf32_Ehdr *header;	// this will point to the header structure
	Elf32_Phdr * ph_header;
	int i;
	printf("Enter file name: ");
	fgets(buffer, sizeof(buffer),stdin);			
	buffer[strlen(buffer)-1] = '\0';
	
	// close any currently open file
	close(Currentfd);

	// open the file with the name inputed:
	Currentfd = open(buffer, O_RDONLY);

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
		if((map_start = mmap(0, fd_stat.st_size, PROT_READ, MAP_SHARED, Currentfd, 0)) == MAP_FAILED){
			perror("mmap failed");
			Currentfd = -1;
			exit(-4);
		}

		header = (Elf32_Ehdr*) map_start;		// header point to the beginning of the mapped file
 
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

		ph_header = (Elf32_Phdr *)(map_start + header->e_phoff);
		printf("Type\tOffset\t\tVirtAddr\t\tPhysAddr\t\tFileSize\t\tMemSiz\t\tFlg\t\tAlign\n");
		for(i=0;i<header->e_phnum;i++){
			printf("%d\t%#06x\t\t%#08x\t\t%#08x\t\t%#05x\t\t%#05x\t\t%d\t\t%#x\n", ph_header[i].p_type, ph_header[i].p_offset, ph_header[i].p_vaddr, ph_header[i].p_paddr, ph_header[i].p_filesz, ph_header[i].p_memsz, ph_header[i].p_flags, ph_header[i].p_align);

		}
		
	}

	return 0;
}
