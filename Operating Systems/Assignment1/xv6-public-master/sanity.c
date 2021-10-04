#include "types.h"
#include "stat.h"
#include "user.h"
#include "perf.h"

int fib(int n) 
{ 
    if (n <= 1) 
        return n; 
    return fib(n-1) + fib(n-2); 
} 

void test(int pid, int ps_priority, int cfs_priority){
	struct perf performance;
	// int i = 10000000;
	// int dummy = 0;
	set_ps_priority(ps_priority);
	set_cfs_priority(cfs_priority);
	// while(i--){
	// 	dummy+=i;
	// }
	fib(40);
	proc_info(&performance);
	printf(1,"%d		%d		%d		%d		%d\n",
	pid, performance.ps_priority, performance.stime, performance.retime, performance.rtime);
}

int main(int argc, char *argv[])
{
	int status1, status2, status3;
	printf(1,"PID   	PS_PRIORITY   	      STIME   	      RETIME   	     RTIME\n");
	int pid1 = fork();
	if(pid1 == 0){
		test(getpid(),10, 3);
		exit(0);
	}
	else{
		int pid2 = fork();
		if(pid2 == 0){
			test(getpid(), 5, 2);
			exit(0);
		}
		else{
			int pid3 = fork();
			if(pid3 == 0){
				test(getpid(), 1, 1);
				exit(0);
			}
			else{
				wait(&status1);
				wait(&status2);
				wait(&status3);
			}
		}
	}
	exit(0);
}






