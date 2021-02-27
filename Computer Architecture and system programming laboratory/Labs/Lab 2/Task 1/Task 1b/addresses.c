#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int addr5;   //bss - not initilaize variable, not inside function
int addr6;   //bss - not initilaize variable, not inside function

int foo();    //read-only variable code/text
void point_at(void *p);   ////read-only variable code/text

int main (int argc, char** argv){
    int addr2;    //stack
    int addr3;    //stack
    char* yos="ree";  //immutable string, read-only variable - text/code
    int * addr4 = (int*)(malloc(50));   //heap
    printf("- &addr2: %p\n",&addr2);
    printf("- &addr3: %p\n",&addr3);
    printf("- foo: %p\n",foo);
    printf("- &addr5: %p\n",&addr5);
    
	point_at(&addr5);
	
    printf("- &addr6: %p\n",&addr6);
    printf("- yos: %p\n",yos);
    printf("- addr4: %p\n",addr4);
    printf("- &addr4: %p\n",&addr4);
    return 0;
}

int foo(){
    return -1;
}

void point_at(void *p){
    int local;              //stack
	static int addr0 = 2;   //data - initilaized static variable 
    static int addr1;       //bss - uninitilaized static variable 


    long dist1 = (size_t)&addr6 - (size_t)p;  //stack
    long dist2 = (size_t)&local - (size_t)p;  //stack
    long dist3 = (size_t)&foo - (size_t)p;   //stack
    
    printf("dist1: (size_t)&addr6 - (size_t)p: %ld\n",dist1);
    printf("dist2: (size_t)&local - (size_t)p: %ld\n",dist2);
    printf("dist3: (size_t)&foo - (size_t)p:  %ld\n",dist3);
	
	printf("- addr0: %p\n", & addr0);
    printf("- addr1: %p\n",&addr1);
}

