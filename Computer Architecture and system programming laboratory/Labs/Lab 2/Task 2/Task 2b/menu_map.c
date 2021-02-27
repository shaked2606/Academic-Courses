#include <stdio.h>
#include <string.h>
#include <stdlib.h>
 
char censor(char c) {
  if(c == '!')
    return '.';
  else
    return c;
}

char encrypt(char c){
  if((c>=' ')&(c<='~')){
    return c+3;
  }
  return c;
}

char decrypt(char c){
  if((c>=' ')&(c<='~')){
    return c-3;
  }
  return c;
}

char xprt(char c){
 printf("%#x\n",c);
 return c;
}

char cprt(char c){
 if((c>=' ')&(c<='~')){
   printf("%c\n",c);
 }
 else{
   printf(".");
 }
 return c;
}

char my_get(char c){
 char ch = fgetc(stdin);
 return ch;
}

char quit(char c){
  exit(0);
}

 
char* map(char *array, int array_length, char (*f) (char)){
  char* mapped_array = (char*)(malloc(array_length*sizeof(char)));
  int index;
  for(index=0;index<array_length;index++){
      mapped_array[index] = f(array[index]);
  }

  return mapped_array;
}
 
int main(int argc, char **argv){
int base_len = 5;
char arr1[base_len];
char* arr2 = map(arr1, base_len, my_get);
char* arr3 = map(arr2, base_len, encrypt);
char* arr4 = map(arr3, base_len, xprt);
char* arr5 = map(arr4, base_len, decrypt);
char* arr6 = map(arr5, base_len, cprt);
free(arr2);
free(arr3);
free(arr4);
free(arr5);
free(arr6);
}