#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
	int policynum = atoi(argv[1]);
	switch (policynum)
	{
	case 0:
		printf(1, "Policy has been successfully changed to Default Policy\n");
		break;
	case 1:
		printf(1, "Policy has been successfully changed to Priority Policy\n");
		break;
	case 2:
		printf(1, "Policy has been successfully changed to CFS Policy\n");
		break;
	default:
		printf(1, "Error replacing policy, no such a policy number (%d)\n", policynum);
		break;
	}
	policy(policynum);
  	exit(0);
}
