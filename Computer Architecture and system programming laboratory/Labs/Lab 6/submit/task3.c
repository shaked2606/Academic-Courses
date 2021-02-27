#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <limits.h>
#include <sys/wait.h>
#include "LineParser.h"
#include <sys/stat.h>

void redirection(cmdLine *pCmdLine){
	FILE *inputfile = NULL;
	FILE *outputfile = NULL;
	if(pCmdLine->inputRedirect != NULL){
		close(STDIN_FILENO);
		inputfile = fopen(pCmdLine->inputRedirect, "r+"); 
		if(inputfile == NULL){
			perror("Open Error:");
			_exit(0);
		}
	}

	if(pCmdLine->outputRedirect != NULL){
		close(STDOUT_FILENO);
		outputfile = fopen(pCmdLine->outputRedirect, "w+");
		if(outputfile == NULL){
			perror("Open Error:");
			_exit(0);
		}
	}
}


//return the pid of the child
int execute(cmdLine *pCmdLine) {
	int error = 0;
	int status;
	int is_piped = 0;
	int pipefd[2];				
	if(pCmdLine->next != NULL){		// cmdline is a pipe
		is_piped = 1;
	}

	if(is_piped == 1){
		if(pipe(pipefd) < 0){  	// create pipe
			perror("Pipe Error:");
			exit(1);
		}
	}

	int pid = fork();

	if(pid == -1){      // if fork fails
		perror("Error fork: ");
		exit(1);
	}
	else if(pid == 0){			// child do work
		redirection(pCmdLine); // redirect if needed
		if(is_piped == 1){
			close(STDOUT_FILENO);		// close stdout fd for taking it to the pipe
			dup(pipefd[1]);				// taking the fd of stdout to pipe
			close(pipefd[1]);			// close original fd pipe
		}
		error = execvp(pCmdLine->arguments[0],pCmdLine->arguments);
		
		if(error < 0) {
			perror("Error execvp: ");
			_exit(1);
		}
	}
	else{								// parent do work
		if(is_piped == 1){			
			close(pipefd[1]);			// close the write end of the pipe
		}
		else if(pCmdLine->blocking == 1){
			waitpid(pid, &status, 0);
		}
	}

	//second child:
	if(is_piped == 1){			// means that we need to fork again for second child
		pid = fork();			// creating second child

		if(pid == -1){      			// if fork fails
			perror("Error fork: ");
			exit(1);
		}
		else if(pid == 0){
			redirection(pCmdLine->next);	// redirect if needed
			close(STDIN_FILENO);			// close stdin
			dup(pipefd[0]);					// dup read-end of the pipe to have the stdin fd
			close(pipefd[0]);				// close original pipe
			error = execvp(pCmdLine->next->arguments[0],pCmdLine->next->arguments);

			if(error < 0) {
				perror("Error execvp: ");
				_exit(1);
			}
		}
		else {
			close(pipefd[0]);
			if(pCmdLine->next->blocking == 1){
				waitpid(pid, &status, 0);
			}
		}
	}
	//freeCmdLines(pCmdLine);
	return pid;
}
//return 1 when it's shell commend, or 0 if exec command
int command(cmdLine *pCmdLine){
	int result = 0;
	if(strcmp(pCmdLine->arguments[0],"quit") == 0){
		exit(0);
	}
	else if(strcmp(pCmdLine->arguments[0],"cd") == 0){
		if(chdir(pCmdLine->arguments[1]) < 0){
			perror("Error cd: ");
		}
		result = 1;
	}
	return result;
}

int main(int argc, char **argv) {
	int debug_mode = 0;
	int i;
	int rc;
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
		}
		
		if(rc == 0){					//execute command
			execute(pCmdLine);
		}
		//else{
			//freeCmdLines(pCmdLine);
		//}
	}
	return 0; 
}

