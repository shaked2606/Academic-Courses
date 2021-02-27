#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {
    int c;
    int new_c;
    int i;
    int debug_mode = 0;
    FILE* input = stdin;
    FILE* output = stdout;

    for(i=1;i<argc;i++) {     //iterating all arguments
        if(strcmp(argv[i], "-D") == 0) {   //debug_mode is activated
            debug_mode = 1;
        }
    }

    if(debug_mode == 1) {     //debug_mode is activated - priniting all the arguments
        for(i=1;i<argc;i++) {
            fprintf(stderr,"%s ",argv[i]);
        }
        fprintf(stderr,"\n");
    }

    while((c = fgetc(input)) != EOF) {   //reading from input (stdin/file)
        if((c >= 'A') & (c <= 'Z')) {   //characther is upper-case
            new_c = c+('a'-'A');
        }
        else {    //non upper-case character
            new_c = c;
        }

        if(debug_mode == 1) {   //we need to print Haxa conversion
            if(c != new_c) {  //convert from upper-case to lower-case
                fprintf(stderr, "%#x     %#x\n", c , new_c);
            }
            else {   //print characther as is (non upper-case)
                fprintf(stderr, "%#x     %#x\n", c, c);
            }
        }
	
        fputc(new_c, output);    //put characther to output
    }
    
    return 0;
}
