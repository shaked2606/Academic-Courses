#include "types.h"
#include "stat.h"
#include "user.h"
#include "sig_action.h"
#include "signal.h"

void custom_handler(int signum){
	printf(1, "HELLO WORLD!!!!!!\n");
	return;
}

void sigmask_handler(int signum){
	int i=0;
	while(i<50){
		printf(1, "%d, ",i);
		i++;
		sleep(10);
	}
	printf(1,"\nFINISH USER-HANDLER\n");
	return;
}

void test1_changing_sig_action_to_sigkill(void){
  int signalnum = 4;

printf(1,"TEST 1 - changing_sig_action_to_sigkill\n");
printf(1,"EXPECTED: SHOULD FINISH\n");
  struct sigaction action;
  action.sigmask = 0;
  action.sa_handler = (void*)SIGKILL;

  int pid = fork();

   if(pid == 0){ 	//kid
    printf(1,"sigaction changed now\n");
	if(sigaction(signalnum, &action, (struct sigaction *)null) < 0){
		printf(1, "failed changing sigaction\n");
		exit();
	}
    while(1){}
    exit();
   }
  else{ 	//parent
	printf(1, "parent sending kill with signal num %d to child\n",signalnum);
	sleep(100);
	if (kill(pid, signalnum) < 0){
		printf(1, "kill failed");
		exit();
	}
	printf(1, "parent waiting for child...\n"); 
	wait();
	printf(1,"test1_changing_sig_action_to_sigkill PASSED\n");
  }
}

void test2_restoring_sig_action(void){
	int signalnum = 4;
	int signalnum1 = 7;

	printf(1,"TEST 2 - restoring_sig_action\n");
	printf(1,"EXPECTED: PRINT 'HELLO WORLD' TWICE AND FINISH\n");
	struct sigaction action;
	action.sigmask = 0;
	action.sa_handler = custom_handler;

	struct sigaction oldaction;

	int pid = fork();

	if(pid == 0){ 	//kid
	    printf(1,"sigaction changed now\n");
		if(sigaction(signalnum, &action, &oldaction) < 0){
			printf(1, "failed changing sigaction custom-handler\n");
			exit();
		}
		if(sigaction(signalnum, &action, &oldaction) < 0){
			printf(1, "failed changing sigaction custom-handler");
			exit();
		}
		if(sigaction(signalnum1, &oldaction, (struct sigaction *)null) < 0){
			printf(1, "failed restoring custom handler to signalnum1");
			exit();
		}
		while(1){}
		exit();
	}
	else{ 	//parent
		sleep(100);
		printf(1, "parent sending kill with signal num %d to child\n",signalnum);
		if (kill(pid, signalnum) < 0){
			printf(1, "kill failed - first sig action");
			exit();
		}
		sleep(100);
		if (kill(pid, signalnum1) < 0){
			printf(1, "kill failed - second sig action");
			exit();
		}
		sleep(100);
		if (kill(pid, SIGKILL) < 0){
			printf(1, "kill failed - third sig action");
			exit();
		}
		wait();
		printf(1,"test2_restoring_sig_action PASSED\n");
	}
}

// need to pay attention that "kid gonna die" print after "parent sends SIGCONT" 
void test3_stop_and_cont(void){
	printf(1,"TEST 3 - stop_and_cont\n");
	printf(1,"EXPECTED: SHOULD PRINT 'kid gonna die' AFTER 'parent sends SIGCONT'\n");
	int pid = fork();

	if(pid == 0){
		printf(1,"kid alive :)\n");
		sleep(50);
		printf(1,"kid gonna die :'(\n");
		exit();

	}else{
		sleep(10);
		printf(1,"parent sends SIGSTOP\n");
		kill(pid,SIGSTOP);
		sleep(300);
		printf(1,"parent sends SIGCONT\n");
		kill(pid,SIGCONT);
		printf(1,"parent going to sleep...\n");
		wait();
		printf(1,"parent waking up!\n");
	}

	printf(1,"test3_stop_and_cont PASSED\n");
}

void test4_block_signals(void){
	printf(1,"TEST 4 - block_signals\n");
	printf(1,"EXPECTED: SHOULD PRINT 'HELLO WORLD' ONCE AND THAN FINISH\n");
	int signalnum = 4;

	struct sigaction action;
	action.sigmask = 0;
	action.sa_handler = custom_handler;

	int pid = fork();
	if(pid == 0){
		int oldmask = sigprocmask(16);
		sigaction(signalnum,&action,(struct sigaction *)null);
		sleep(50);
		printf(1,"changing to original mask\n");
		sigprocmask(oldmask);
		while(1){}
	}else{
		sleep(10);
		kill(pid,signalnum);
		sleep(100);
		kill(pid,SIGKILL);
		wait();
	}
	printf(1,"test4_block_signals PASSED\n");
}

void test5_check_ignore_signal(void){
	printf(1,"TEST 5 - check_ignore_signal\n");
	printf(1,"EXPECTED: PRINT #1 => #2 => #3\n");
	int signalnum = 4;
	int signalnum1 = 7;

	struct sigaction action;
	action.sigmask = 0;
	action.sa_handler = (void*)SIG_IGN;

	int pid = fork();
	if(pid == 0){
		sigaction(signalnum,&action,(struct sigaction *)null);
		sleep(50);
		printf(1,"#2 kid still alive\n");
		while(1){}
	}else{
		sleep(10);
		printf(1,"#1 parent send first kill (sig_ign handler signal)\n");
		kill(pid, signalnum);
		sleep(100);
		printf(1,"#3 parent send second kill (sig_dfl handler signal)\n");
		kill(pid, signalnum1);
		wait();
	}
	printf(1,"test5_check_ignore_signal PASSED\n");
}

void test6_a_lot_of_forks(void){
	printf(1,"TEST 6 - a_lot_of_forks\n");
	printf(1,"EXPECTED: should PASSED\n");

	int procs = 12;

	for(int i=0;i<procs;i++){
		int pid = fork();
		if(pid == 0){
			int j=0;
			while(j<500){
				printf(1,"");
				j++;
			}
			exit();
		}
	}

	for(int i=0;i<procs;i++)
		wait();

	printf(1,"test6_a_lot_of_forks PASSED\n");
}


void test7_sigmask_of_userhandler(void){
	printf(1,"TEST 7 - sigmask_of_userhandler\n");
	printf(1,"EXPECTED: GET PASSED AFTER PRINT 'FINISHED USER-HANDLER'\n");
	int signalnum4 = 4;
	int signalnum10 = 10;

	struct sigaction action10;
	action10.sigmask = 0;
	action10.sa_handler = SIG_DFL;

	struct sigaction action4;
	action4.sigmask = 1024;
	action4.sa_handler = sigmask_handler;

	int pid = fork();
	if(pid == 0){
		sigaction(signalnum4,&action4,(struct sigaction *)null);
		sigaction(signalnum10,&action10,(struct sigaction *)null);
		sleep(50);
		while(1){}
	}else{
		sleep(10);
		kill(pid, signalnum4); // handling user-handler
		sleep(100);
		printf(1, "parent sends blocked signal with kill handler\n");
		kill(pid, signalnum10); // proc should not killed
		sleep(1000);
		printf(1, "parent sends SIGKILL signal\n");
		kill(pid, SIGKILL); // killed and print "FINISHED USER-HANDLER"
		wait();
	}

	printf(1,"test7_sigmask_of_userhandler PASSED\n");
}


int
main(int argc, char *argv[])
{
	printf(1,"STARTING TESTS!\n");
	printf(1,"\n\n");
	test1_changing_sig_action_to_sigkill();
	printf(1,"\n\n");
	test2_restoring_sig_action();
	printf(1,"\n\n");
	test3_stop_and_cont();
	printf(1,"\n\n");
	test4_block_signals();
	printf(1,"\n\n");
	test5_check_ignore_signal();
	printf(1,"\n\n");
	test6_a_lot_of_forks();
	printf(1,"\n\n");
	test7_sigmask_of_userhandler();
	printf(1,"\n\n");
	printf(1, "ALL TESTS PASSED :-)\n");
	exit();
}
