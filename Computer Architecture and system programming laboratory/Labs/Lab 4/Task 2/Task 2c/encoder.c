#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {
    int c;
    int new_c;
    int i;
    int debug_mode = 0;
    int encrypt_mode = 0;
    int index_encrypt = 0;
    FILE* input = stdin;
    FILE* output = stdout;
    char* key = NULL;
    char* file = NULL;

    for(i=1;i<argc;i++) {     //iterating all arguments
        if(strcmp(argv[i], "-D") == 0) {   //debug_mode is activated
            debug_mode = 1;
        }
        else if(strncmp(argv[i], "+e", 2) == 0) {
            key = argv[i]+2;
            encrypt_mode = 1;
        }
        else if(strncmp(argv[i], "-e", 2) == 0) {
            key = argv[i]+2;
            encrypt_mode = -1;
        }
        else if(strncmp("-i", argv[i],2)==0) {  //read input from a file
            file = argv[i]+2;
            input = fopen(file,"r");
            if(input == NULL) {
                fprintf(stderr, "Error: can not open the file for reading\n");
                exit(0);
            }
        }
    }

    if(debug_mode == 1) {     //debug_mode is activated - priniting all the arguments
        for(i=1;i<argc;i++) {
            fprintf(stderr,"%s ",argv[i]);
        }
        fprintf(stderr,"\n");
    }

    while((c = fgetc(input)) != EOF) {   //reading from input (stdin/file)
        if(encrypt_mode == 0) {          //no argument +/-e supplied
            if((c >= 'A') & (c <= 'Z')) {   //characther is upper-case
                new_c = c+('a'-'A');
            }
            else {    //non upper-case character
                new_c = c;
            }
        }

        if(debug_mode == 1) {   //we need to print Haxa conversion
            if(c != new_c) {  //convert from upper-case to lower-case
                fprintf(stderr, "%#x     %#x\n", c , (unsigned char)new_c);
            }
            else {   //print characther as is (non upper-case)
                fprintf(stderr, "%#x     %#x\n", c, c);
            }
        }

        if(encrypt_mode != 0) {
            new_c = c+(key[index_encrypt]*encrypt_mode);
            if(new_c > 127){
                new_c-=127;
            }
            if(new_c < 0){
                new_c+=127;
            }
            index_encrypt++;
            if(index_encrypt == strlen(key)) {
                index_encrypt = 0;
            }
        }
	
        fputc(new_c, output);    //put characther to output
        if((c == '\n') & (encrypt_mode != 0)) {   //\n
            index_encrypt = 0;
            fputc('\n', output);
        }
    }
    
    return 0;
}