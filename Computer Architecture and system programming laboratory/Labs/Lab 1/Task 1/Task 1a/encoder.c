#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {
    int c;
    int new_c;
    FILE* input = stdin;
    FILE* output = stdout;

    while((c = fgetc(input)) != EOF) {
        if((c>=65) & (c<=90)) {
            new_c = c+32;
        }
        else
            new_c = c;
        fputc(new_c, output);
    }
    
    return 0;
}
