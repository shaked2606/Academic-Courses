 
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int digit_counter(char *s){
    int counter = 0;
    int i=0;
    while(s[i] != '\0'){
        if(s[i] >= '0' && s[i] <= '9'){
            counter++;
        }
        i++;
    }
    return counter;
}

int main( int argc, char **argv){
    printf("%d\n",digit_counter(argv[1]));
    return 0;
}