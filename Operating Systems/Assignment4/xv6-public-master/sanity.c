#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define KB 1024
#define MB 1048576
#define BLOCK_SIZE 512

int main(int argc, char **argv)
{
    char buffer[512];
    int fd;
    if((fd = open("file", O_WRONLY | O_CREATE)) < 0){
        printf(1, "Open failed\n");
        exit();
    }
    int i=0;
    while(1){
        *(int*)buffer = i;
        if(write(fd, buffer, sizeof(buffer)) <= 0){
            printf(1, "Write failed\n");
            exit();
        }

        if(i == ((6 * KB)/BLOCK_SIZE)){ //Writing to NDIRECT
            printf(1, "Finished writing 6KB (direct)\n");
        }

        if(i == ((70 * KB)/BLOCK_SIZE)){ //Writing to NINDIRECT
            printf(1, "Finished writing 70KB (single indirect)\n");
        }
        
        if(i == ((1 * MB)/BLOCK_SIZE)){ //Writing to DINDIRECT
            printf(1, "Finished writing 1MB\n");
            break;
        }
        i++;
    }

    close(fd);
    exit();
}