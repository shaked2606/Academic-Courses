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

extern int system_call(int,...);

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

int main(int argc, char **argv) {
    char c[1];
    char new_c[1];
    int i;
    int debug_mode = 0;
    int input = STDIN;
    int output = STDOUT;
    int data;
    int err_data;
    char *input_file_name = "stdin";
    char *output_file_name = "stdout";

    for(i=1;i<argc;i++) {    
        if(strcmp(argv[i], "-D") == 0) {  
            debug_mode = 1;
        }
        else if(strncmp("-i", argv[i],2)==0) {  
                input_file_name = argv[i]+2;
                input = system_call(SYS_OPEN, input_file_name, READ_WRITE, FILE_PERMISSION);
                print_system_call_err_mode(SYS_OPEN, input, debug_mode);
                if(input < 0){
                        system_call(SYS_WRITE, STDOUT,"ERROR OPENING FILE\n",strlen("ERROR OPENING FILE\n"));
                        system_call(EXIT, 1, 0, 0);
                }
        }
        else if(strncmp("-o", argv[i],2)==0){
                output_file_name = argv[i]+2;
                output = system_call(SYS_OPEN, output_file_name, READ_WRITE | O_CREAT, FILE_PERMISSION);
                print_system_call_err_mode(SYS_OPEN, output, debug_mode);
        }
    }

    if(debug_mode == 1) {    
        for(i=1;i<argc;i++) {
            system_call(SYS_WRITE,STDERR, argv[i],strlen(argv[i]));
            system_call(SYS_WRITE,STDERR,", ",2);
        }
        system_call(SYS_WRITE,STDERR,"\n",1);
    }

    while((data = system_call(SYS_READ, input, c, 1) > 0)) {  
        print_system_call_err_mode(SYS_READ, data, debug_mode);
        if(((*c) >= 'A') & ((*c) <= 'Z')) {   
            (*new_c) = (*c) + ('a'-'A');
        }
        else {    
            (*new_c) = (*c);
        }
        err_data = system_call(SYS_WRITE, output, new_c, 1);
        print_system_call_err_mode(SYS_WRITE, err_data, debug_mode);
    }
    if(debug_mode == 1){
        system_call(SYS_WRITE, STDERR, input_file_name, strlen(input_file_name));
        system_call(SYS_WRITE,STDERR, ", ", 2);
        system_call(SYS_WRITE, STDERR, output_file_name, strlen(output_file_name));
        system_call(SYS_WRITE,STDERR, "\n", 1);
    }

    
    return 0;
}
