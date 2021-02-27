#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <limits.h>
#include <sys/wait.h>
#include "LineParser.h"

//return the pid of the child
int execute(cmdLine *pCmdLine) {
	int error = 0;
	int status;
	int pid = fork();

	if(pid == -1){      // if fork fails
		perror("fork() fails");
		exit(1);
	}
	else if(pid == 0){
		error = execvp(pCmdLine->arguments[0],pCmdLine->arguments);
		if(error < 0) {
			perror("Error: ");
			_exit(1);
		}
	}
	else{
		waitpid(pid, &status, 0);
		freeCmdLines(pCmdLine);
	}
	return pid;
}
//return 1 when it's shell commend, or 0 if exec command
int command(cmdLine *pCmdLine){
	if(strcmp(pCmdLine->arguments[0],"quit") == 0){
		exit(0);
	}
	return 0;
}

int main(int argc, char **argv) {
	int debug_mode = 0;
	int i;
	int rc;
	int pid;
	char buf[PATH_MAX];
	char input_line[2048];
	cmdLine *pCmdLine = NULL;

		for(i=1; i<argc;i++) {
		if(strncmp(argv[i],"-d",2) == 0) {   
			debug_mode = 1;
		}
	}

	while(1){
		getcwd(buf, PATH_MAX);
		printf("%s: ", buf);
		fgets(input_line, 2048, stdin);
		pCmdLine = parseCmdLines(input_line);   // allocate cmd line pointer from the string line
		rc = command(pCmdLine);

		if(debug_mode == 1){   //dubeg mode is on
			fprintf(stderr,"command: %s\n",pCmdLine->arguments[0]);
			fprintf(stderr, "pid: %d\n",pid);
		}
		
		if(rc == 0){					//execute command
			pid = execute(pCmdLine);
		}
	}
	return 0; 
}

