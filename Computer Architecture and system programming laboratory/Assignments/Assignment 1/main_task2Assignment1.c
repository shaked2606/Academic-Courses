#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define	MAX_LEN 34 			/* maximal input string size */
							/* enough to get 32-bit string + '\n' + null terminator */
extern void assFunc(int x,int y);

char c_checkValidity(int x,int y) {
	char result = '1';
	if(x < 0){
		result = '0';
	}
	if((y <= 0) | (y > 32768)){
		result = '0';
	}
return result;
}

int main(int argc, char** argv)
{
	int x = 0;
	int y = 0;
	char strx[MAX_LEN];
	char stry[MAX_LEN];
	printf("Enter 2 integer numbers:\n");
	fgets(strx,MAX_LEN,stdin);
	fgets(stry,MAX_LEN,stdin);
	sscanf(strx,"%d",&x);
	sscanf(stry,"%d",&y);
	assFunc(x, y);
	return 0;
}
