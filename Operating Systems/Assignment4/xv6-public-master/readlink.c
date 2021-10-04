#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  char buf[128];
  uint bufsize = sizeof(buf);
  if(argc != 2){
    printf(2, "Usage: ln old new\n");
    exit();
  }

  if(readlink(argv[1], buf, bufsize) == 0){
      printf(1, "%s\n", buf);
  } else{
    printf(2, "readlink fail\n");
  }
  exit();
}
