#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <limits.h>
#include "LineParser.h"

void execute(cmdLine *pCmdLine) {
	int error = 0;
	error = execvp(pCmdLine->arguments[0],pCmdLine->arguments);
	freeCmdLines(pCmdLine);
	if(error < 0) {
		perror("Error: ");
		exit(1);
	}
}

int main(int argc, char **argv) {
	char buf[PATH_MAX];
	char input_line[2048];
	cmdLine *pCmdLine = NULL;
	getcwd(buf, PATH_MAX);
	printf("%s: ", buf);
	fgets(input_line, 2048, stdin);
	while(strncmp(input_line,"quit", 4) != 0){
		pCmdLine = parseCmdLines(input_line);
		execute(pCmdLine);
		printf("\n");
		getcwd(buf, PATH_MAX);
		printf("%s: ", buf);
		fgets(input_line, 2048, stdin);
	}
	return 0; 
}


