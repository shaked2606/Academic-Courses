#include "types.h"
#include "stat.h"
#include "user.h"


/*void
alloc_free_mem_test(int val)
{
    int *mem = malloc(sizeof(int));
    printf(1, "memory allocated\n");

    *mem = val;
    printf(1, "memory_val= %d\n", *mem);
    
    free(mem);
    printf(1, "memory freed\n");
}

void
fork_test1 ()
{
    for (int i=0; i<4; i++) {
        if (fork()==0) {
            alloc_free_mem_test(200);
            exit();
        }
    }

    for (int i=0; i<4; i++) {
        wait();
    }
}

void
fork_test2 ()
{
    for (int i=0; i<4; i++) {
        if (fork()==0) {
            printf(1, "my pid = %d\n", getpid());
            exit();
        }
    }

    for (int i=0; i<4; i++) {
        wait();
    }
}

void
fork_test3 ()
{
    if(fork()==0) {
        printf(1, "child\n");
        exit();
    }
    else {
        printf(1, "parent\n");
        wait();
    }
}

void
deep_fork_test1 ()
{   
    if (fork()==0) {
        printf(1, "Parent, pid = %d\n", getpid());
        for (int i=0; i<4; i++) {
            if (fork()==0) {
                int pid = getpid();
                printf(1, "Children, pid = %d\n", pid);
                alloc_free_mem_test(pid*100);
                exit();
            }
        }

        for (int i=0; i<4; i++) {
          wait();
        }

        exit();
    }

    else {
        printf(1, "Grandparent, pid = %d\n", getpid());
        wait();
    }
    
}

int fib (int n) {
    if (n<2) {
        return n;
    }
    return fib(n-1) + fib(n-2);
}

void
alloc_many_pages_test()
{
    int  *mem[100];
    for (int i=0; i<100; i++) {
        mem[i] = malloc(4096);
    }

    fib(40);

    for (int i=0; i<100; i++) {
        fib(10);
        *(mem[i]) = i*100;
        printf(1, "pid=%d, memory_val= %d\n", getpid(), *(mem[i]));
    }

    for (int i=0; i<100; i++) {
        free(mem[i]);
    }
}

void
pgflt_test ()
{   
    if (fork()==0) {
        printf(1, "Parent, pid = %d\n", getpid());
        for (int i=0; i<4; i++) {
            if (fork()==0) {
                int pid = getpid();
                printf(1, "Children, pid = %d\n", pid);
                alloc_many_pages_test();
                exit();
            }
        }

        for (int i=0; i<4; i++) {
          wait();
        }

        exit();
    }

    else {
        printf(1, "Grandparent, pid = %d\n", getpid());
        wait();
    }
    
}
*/
void
pgflt_test2 ()
{
    int* ptr = malloc(10000);

    printf(1,"allocated 10,000 byts\n");
    int d = 3000;

    for (int i=0; i<3; i++) {
        printf(1,"init %d\n",i);
        *(ptr+d*i) = d*i;
    }

    for (int i=0; i<10; i++) {
        printf(1, "mem at %d= %d", i*d, *(ptr+d*i));
    }

    free(ptr);
}
int
main(int argc, char *argv[])
{
    // alloc_free_mem_test(); // works
    // fork_test1();   
    // fork_test2();      
    // fork_test3();

    // deep_fork_test1();
    pgflt_test2();

    exit();
}
