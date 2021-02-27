#include <stdio.h>
#include <string.h>
#include <stdlib.h>
 
char censor(char c) {
  char ch = c;
  if(c == '!'){
    ch = '.';
  }
  return ch;
}

char encrypt(char c){
  char ch = c;
  if((c>=' ')&(c<='~')){
    ch = c+3;
  }
  return ch;
}

char decrypt(char c){
  char ch = c;
  if((c>=' ')&(c<='~')){
    ch = c-3;
  }
  return ch;
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
 
 //defining struct for each function
struct fun_desc{
  char *name;
  char (*fun)(char);
};

int main(int argc, char **argv){
  char array[5];  
  array[0] = '\0';   //init to empty string
  char *carray = array;    //carray point to array[5]
  char option[128];
  int action;
  int index = 0;
  int size_menu = 0;
  struct fun_desc menu[] = {{"Censor",censor}, {"Encrypt",encrypt}, {"Decrypt",decrypt}, {"Print hex",xprt}, {"Print string",cprt}, {"Get string",my_get}, {"Quit",quit}, {"NULL",NULL}};

  //counting size of menu
  while(strcmp((menu[size_menu].name),"NULL") != 0){
    size_menu++;
  }

  while(1){ //loop until action = quit or action not within bounds
    printf("Please choose a function:\n");

    while(strcmp((menu[index].name),"NULL") != 0) { //loop all options of functions
      printf("%d) %s\n", index, menu[index].name);
      index++;
    }
    index = 0; //reset the counter for printing menu again next loop

    printf("Option: ");
    fgets(option,sizeof(option),stdin);  //user input
    action = atoi(option);    //converse string to int

    if((action >= 0) & (action <= size_menu)){   //checking action bounds
      printf("Within bounds\n");
      carray = map(carray,5,menu[action].fun);
    }
    else {
      printf("Not Within bounds\n");
      exit(0);
    }
  }
}