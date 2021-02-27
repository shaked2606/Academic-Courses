#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>

void handler(int sig_num){
	char *signal_name;
	signal_name = strsignal(sig_num);
	printf("Signal name caught: %s\n", signal_name);
	signal(signum, SIG_DFL);
	raise(signum);
}

int main(int argc, char **argv){ 
	printf("Starting the program\n");
	signal(SIGINT, handler);
	signal(SIGTSTP, handler);
	signal(SIGCONT, handler);
	while(1) {
		sleep(2);
	}
	return 0;
}
