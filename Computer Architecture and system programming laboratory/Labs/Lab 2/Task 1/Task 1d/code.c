#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define ARR_SZ 3

int main (int argc, char** argv){
    int iarray[ARR_SZ] = {1,2,3};
    char carray[] = {'a','b','c'};
    int* iarrayPtr;
    char* carrayPtr;

    iarrayPtr = iarray;
    carrayPtr = carray;
    void *p;
    for(iarrayPtr = iarray; iarrayPtr<iarray+ARR_SZ; iarrayPtr++){
        printf("int array: %d\n",(*iarrayPtr));
    }
        for(carrayPtr = carray; carrayPtr<carray+ARR_SZ;carrayPtr++){
        printf("int array: %c\n",(*carrayPtr));
    }


    return 0;
}

