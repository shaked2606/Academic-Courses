#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main (int argc, char** argv){
    int iarray[3];
    float farray[3];
    double darray[3];
    char carray[5];

    printf("farray+2: %p\n",farray+2);
    printf("darray: %p\n",darray);
    printf("darray+1: %p\n",darray+1);
    printf("darray+2: %p\n",darray+2);
    printf("carray: %p\n",carray);
    printf("carray+1: %p\n",carray+1);
    printf("carray+2: %p\n",carray+2);
    printf("carray+3: %p\n",carray+3);
    printf("carray+4: %p\n",carray+4);
    return 0;
}

