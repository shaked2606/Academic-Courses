#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <limits.h>
#include <sys/wait.h>
#include "LineParser.h"
#include <sys/stat.h>

//declaring struct of pair
typedef struct pair{
	char *name;
	char *value;
	struct pair *next;
} pair;

void freePairList(pair* pair_list){
	pair *curr_pair = pair_list;
	while(curr_pair != NULL){
		pair *temp = curr_pair->next;
		free(curr_pair->name);
		free(curr_pair->value);
		free(curr_pair);
		curr_pair = temp;
	}
}
void addPair(pair **pair_list, char *name, char *value){
	name = strdup(name);
	value = strdup(value);
	pair *curr_pair = (*pair_list);
	pair *find_pair = (*pair_list);

	while(find_pair != NULL){							//check if already exist
		if(strcmp(find_pair->name, name) == 0){
			find_pair->value = value;
			return;
		}
		find_pair = find_pair->next;
	}

	// create new pair struct:
	pair *new_pair = malloc(sizeof(pair));
	new_pair->name = name;
	new_pair->value = value;
	new_pair->next = NULL;

	if(curr_pair != NULL){						// add to the start of the list
		new_pair->next = curr_pair;
	}

	(*pair_list) = new_pair;				// add as a first pair in the list
}

void printPair(pair *curr_pair){
	printf("Name: %s\n", curr_pair->name);
	printf("Value: %s\n", curr_pair->value);
}

void printPairList(pair ** pair_list){
	if((*pair_list) == NULL){
		fprintf(stderr, "list is empty\n");
		return;
	}

	pair *curr_pair = (*pair_list);

	while(curr_pair != NULL){
		printPair(curr_pair);
		curr_pair = curr_pair->next;
	}
}

void deletePair(char *name_of_pair, pair **pair_list){
	pair *prev_pair = NULL;
	pair *curr_pair = *pair_list;

	while(curr_pair != NULL){
		if(strcmp(curr_pair->name, name_of_pair) == 0){
			if(prev_pair != NULL){							// first pair in the list
				prev_pair->next = curr_pair->next;
				curr_pair = prev_pair->next;
			}
			else{											// other pair somewhere in the middle of list
				(*pair_list) = curr_pair->next;
				curr_pair = curr_pair->next;
			}
			return;
		}
		else{												// loop to the next pair
			prev_pair = curr_pair;
			curr_pair = curr_pair->next;
		}
	}
	fprintf(stderr,"variable not found to be deleted\n");
}



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
int command(cmdLine *pCmdLine, pair **pair_list){
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
	else if(strcmp(pCmdLine->arguments[0],"set") == 0){
		addPair(pair_list, pCmdLine->arguments[1], pCmdLine->arguments[2]);
		result = 1;
	}
	else if(strcmp(pCmdLine->arguments[0],"vars") == 0){
		printPairList(pair_list);
		result = 1;
	}
	else if(strcmp(pCmdLine->arguments[0],"delete") == 0){
		deletePair(pCmdLine->arguments[1], pair_list);
		result = 1;
	}
	return result;
}

int updateCmdLine(cmdLine *pCmdLine, pair **pair_list){
	if (!pCmdLine)			// check if no other commands in cmdline
	{
		return 1;
	}
	int result = 0;
	int i=0;
	char *home_dir = NULL;
	pair *curr_pair = *pair_list;
	while(pCmdLine->arguments[i] != NULL){						//running over all arguments of command
		if(strncmp(pCmdLine->arguments[i],"$",1) == 0){
			result = 0;		
			char *name_of_var = pCmdLine->arguments[i]+1;
			curr_pair = *pair_list;
			while(curr_pair != NULL){
				if(strcmp(curr_pair->name, name_of_var) == 0){
					replaceCmdArg(pCmdLine, i, curr_pair->value);
					result = 1;
					break;
				}
				curr_pair = curr_pair->next;
			}
			if(result == 0){
				fprintf(stderr, "variable not found!!\n");
			}
		}
		else if(strncmp(pCmdLine->arguments[i],"~",1) == 0){ 
			home_dir = getenv("HOME");
			replaceCmdArg(pCmdLine, i, home_dir);
		}
		
		i++;
	}

	return updateCmdLine(pCmdLine->next, pair_list);
}

int main(int argc, char **argv) {
	int debug_mode = 0;
	int i;
	int rc;
	char buf[PATH_MAX];
	char input_line[2048];
	pair **pair_list = malloc(sizeof(pair*));
	(*pair_list) = NULL;
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
		
		updateCmdLine(pCmdLine,pair_list);		// update arguments in pCmdLine if needed

		rc = command(pCmdLine, pair_list);

		if(debug_mode == 1){   //dubeg mode is on
			fprintf(stderr,"command: %s\n",pCmdLine->arguments[0]);
		}
		
		if(rc == 0){					//execute command
			execute(pCmdLine);
		}
	}
	if((*pair_list) != NULL){
		freePairList(*pair_list);
	}
	free(pair_list);
	return 0; 
}

