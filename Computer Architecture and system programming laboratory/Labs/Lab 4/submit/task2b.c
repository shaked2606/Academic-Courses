#include "util.h"

#define READ_ONLY 0
#define WRITE_ONLY 1
#define READ_WRITE 2
#define O_CREAT 64
#define FILE_PERMISSION 0777


#define EXIT 1
#define SYS_READ 3
#define SYS_WRITE 4
#define SYS_OPEN 5
#define SYS_CLOSE 6
#define SYS_LSEEK 19
#define GETDENTS 141

#define STDIN 0
#define STDOUT 1
#define STDERR 2

enum
  {
    DT_UNKNOWN = 0,
# define DT_UNKNOWN	DT_UNKNOWN
    DT_FIFO = 1,
# define DT_FIFO	DT_FIFO
    DT_CHR = 2,
# define DT_CHR		DT_CHR
    DT_DIR = 4,
# define DT_DIR		DT_DIR
    DT_BLK = 6,
# define DT_BLK		DT_BLK
    DT_REG = 8,
# define DT_REG		DT_REG
    DT_LNK = 10,
# define DT_LNK		DT_LNK
    DT_SOCK = 12,
# define DT_SOCK	DT_SOCK
    DT_WHT = 14
# define DT_WHT		DT_WHT
  };

extern int system_call(int,...);


typedef struct linux_dirent { 
    unsigned long  d_ino;     /* Inode number */
    unsigned long  d_off;     /* Offset to next linux_dirent */
    unsigned short d_reclen;  /* Length of this linux_dirent */
    char           d_name[];  /* Filename (null-terminated) */
                        /* length is actually (d_reclen - 2 -
                        offsetof(struct linux_dirent, d_name)) */
    /*
    char           pad;       // Zero padding byte
    char           d_type;    // File type (only since Linux
                                // 2.6.4); offset is (d_reclen - 1)
    */
} ent;

void print_system_call_err_mode(int code_system_call, int return_code, int debug_mode){
    char *code;
    char *r_code;
    if(debug_mode == 1){
        code = itoa(code_system_call);
        system_call(SYS_WRITE, STDERR, code, strlen(code));
        system_call(SYS_WRITE,STDERR,", ",2);
        r_code = itoa(return_code);
        system_call(SYS_WRITE, STDERR, r_code, strlen(r_code));
        system_call(SYS_WRITE,STDERR,"\n",1);
    }
}

void print_struct_err(ent* entp, int debug_mode){
    if(debug_mode == 1){
        system_call(SYS_WRITE,STDERR,entp->d_name,strlen(entp->d_name));
        system_call(SYS_WRITE,STDERR,", ",2);
        system_call(SYS_WRITE, STDERR, itoa(entp->d_reclen), strlen(itoa(entp->d_reclen)));
        system_call(SYS_WRITE,STDERR,"\n",1);
    }
}

char *d_type_value(int d_type){
    char *d_type_s = "Unknown";

    if(d_type == DT_REG){
        d_type_s = "regular";
    }
    else if(d_type == DT_DIR){
        d_type_s = "directory";
    }
    else if(d_type == DT_FIFO){
        d_type_s = "FIFO";
    }
    else if(d_type == DT_SOCK){
        d_type_s = "socket";
    }
    else if(d_type == DT_LNK){
        d_type_s = "symlink";
    }
    else if(d_type == DT_BLK){
        d_type_s = "block dev";
    }
     else if(d_type == DT_CHR){
        d_type_s = "char dev";
    }
    return d_type_s;
}

int main(int argc, char **argv) {
int debug_mode = 0;
int p_prefix_mode = 0;
char *prefix_name;
int nread = 0;
int err_data;
int index = 32;
char dir_data[8192];
int i;
int fd;
char d_type;
ent *entp = (struct linux_dirent*)dir_data;


for(i=1;i<argc;i++) {    
    if(strcmp(argv[i], "-D") == 0) {  
        debug_mode = 1;
    }
    else if(strncmp(argv[i], "-p", 2) == 0) {  
        prefix_name = argv[i] + 2;
        p_prefix_mode = 1;
    }
}

if(debug_mode == 1) {    
    for(i=1;i<argc;i++) {
        system_call(SYS_WRITE,STDERR, argv[i],strlen(argv[i]));
        system_call(SYS_WRITE,STDERR,", ",2);
    }
    system_call(SYS_WRITE,STDERR,"\n",1);
}

fd = system_call(SYS_OPEN, ".", 0, 0);
print_system_call_err_mode(SYS_OPEN, fd, debug_mode);

nread = system_call(GETDENTS, fd, entp, 8192);
print_system_call_err_mode(GETDENTS, nread, debug_mode);

while(index < nread){
    entp = (struct linux_dirent*)(dir_data + index);
    if(p_prefix_mode == 0 || strncmp(entp->d_name, prefix_name, strlen(prefix_name)) == 0){
            err_data = system_call(SYS_WRITE, STDOUT, entp->d_name, strlen(entp->d_name));
            if(p_prefix_mode == 1){
                system_call(SYS_WRITE,STDOUT,", ", 2);
                d_type = *(dir_data + index + entp->d_reclen -1);
                err_data = system_call(SYS_WRITE,STDOUT, d_type_value(d_type), strlen(d_type_value(d_type)));
                print_system_call_err_mode(SYS_WRITE, err_data, debug_mode);
            }
            system_call(SYS_WRITE,STDOUT,"\n",1);
            print_system_call_err_mode(SYS_WRITE, err_data, debug_mode);
    }
    print_struct_err(entp, debug_mode);
    index+= entp->d_reclen;
}
return 0;
}