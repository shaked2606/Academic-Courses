#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <limits.h>
#include <sys/wait.h>
#include "LineParser.h"

#define TERMINATED  -1
#define RUNNING 1
#define SUSPENDED 0

typedef struct process{
    cmdLine* cmd;                         /* the parsed command line*/
    pid_t pid; 		                  /* the process id that is running the command*/
    int status;                           /* status of the process: RUNNING/SUSPENDED/TERMINATED */
    struct process *next;	                  /* next process in chain */
} process;

void freeProcessList(process* process_list){
	process *curr_process = process_list;
	while(curr_process != NULL){
		process *temp = curr_process->next;
		freeCmdLines(curr_process->cmd);
		free(curr_process);
		curr_process = temp;
	}
}

void updateProcessList(process **process_list){
	int status;
	int ret_waitpid = 0;
	process *curr_process = (*process_list);
	while(curr_process != NULL){
		ret_waitpid = waitpid(curr_process->pid, &status,WNOHANG);
		if(ret_waitpid == -1){
			curr_process->status = TERMINATED;
		}
		else if(ret_waitpid != 0){
			if(WIFCONTINUED(status)){
				curr_process->status = RUNNING;
			}
			else if(WIFSTOPPED(status)){
				curr_process->status = SUSPENDED;
			}
			else {
				curr_process->status = TERMINATED;
			}
		}
		curr_process = curr_process->next;
	}
}

void updateProcessStatus(process* process_list, int pid, int status){
	process *curr_process = process_list;
	while(curr_process != NULL){
		if(curr_process->pid == pid){
			curr_process->status = status;
			return;
		}
		curr_process = curr_process->next;
	}
} 

void addProcess(process** process_list, cmdLine* cmd, pid_t pid){
	process *curr_process = (*process_list);
	process *new_process = malloc(sizeof(process));
	new_process->cmd = cmd;
	new_process->pid = pid;
	new_process->status = RUNNING;
	new_process->next = NULL;

	if(curr_process != NULL){
		new_process->next = curr_process;
	}

	(*process_list) = new_process;
}

void printProcess(process *curr_process, int index){
	printf("Index		PID		STATUS		Command\n");
	printf("%d		", index);
	printf("%d",curr_process->pid);
	printf("		%s",curr_process->cmd->arguments[0]);
	if(curr_process->status == 0){
		printf("		SUSPENDED\n");
	}
	else if(curr_process->status == 1){
		printf("		RUNNING\n");
	}
	else if(curr_process->status == -1){
		printf("		TERMINATED\n");
	}
}

void printProcessList(process** process_list){
	updateProcessList(process_list);
	int index = 0;
	if(process_list == NULL){
		fprintf(stderr,"list is empty\n");
		return;
	}
	process *prev_process = NULL;
	process *curr_process = (*process_list);
	while(curr_process != NULL){
		printProcess(curr_process, index);
		if(curr_process->status == TERMINATED){
			if(prev_process != NULL){
				prev_process->next = curr_process->next;
				curr_process = prev_process->next;
			}
			else{
				(*process_list) = curr_process->next;
				curr_process = curr_process->next;
			}
		}
		else{
			curr_process = curr_process->next;
		}
		index++;
	}
}

//return the pid of the child
int execute(cmdLine *pCmdLine) {
	int error = 0;
	int status;
	int pid = fork();

	if(pid == -1){      // if fork fails
		perror("Error fork: ");
		exit(1);
	}
	else if(pid == 0){   //child handle this
		error = execvp(pCmdLine->arguments[0],pCmdLine->arguments);
		if(error < 0) {
			perror("Error execvp: ");
			_exit(1);
		}
	}
	else {					//parent handle this
		if(pCmdLine->blocking){
			waitpid(pid, &status, 0);
		}
	}
	return pid;
}
//return 1 when it's shell commend, or 0 if exec command
int command(cmdLine *pCmdLine, process **process_list){
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
	else if(strcmp(pCmdLine->arguments[0],"procs") == 0){
		printProcessList(process_list);
		result = 1;
	}
	return result;
}

int main(int argc, char **argv) {
	int debug_mode = 0;
	int i;
	int rc;
	int pid;
	char buf[PATH_MAX];
	char input_line[2048];
	process **process_list = malloc(sizeof(process*));
	(*process_list) = NULL;
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
		rc = command(pCmdLine, process_list);
		if(debug_mode == 1){   //dubeg mode is on
			fprintf(stderr,"command: %s\n",pCmdLine->arguments[0]);
			fprintf(stderr, "pid: %d\n",pid);
		}
		
		if(rc == 0){					//execute command
			pid = execute(pCmdLine);
			addProcess(process_list, pCmdLine, pid);
		}
	}
	if((*process_list) != NULL){
		freeProcessList(*process_list);
	}
	free(process_list);
	return 0; 
}

