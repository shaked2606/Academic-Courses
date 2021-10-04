#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
  if(argc < 3){
    printf(1, "usage: kill pid signum...\n");
    exit();
  }
  kill(atoi(argv[1]),atoi(argv[2]));
  exit();
}
