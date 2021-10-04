#include "types.h"
#include "stat.h"
#include "user.h"


int main(int argc, char *argv[])
{
	printf(1, "The process is using: %d\n", memsize());
	char* x = (char*) malloc(2000);
	printf(1, "Allocating more memory\n");
	printf(1, "The process is using: %d\n", memsize());
	free(x);
	printf(1, "Freeing memory\n");
	printf(1, "The process is using: %d\n", memsize());
	set_cfs_priority(2);
	exit(0);
}
