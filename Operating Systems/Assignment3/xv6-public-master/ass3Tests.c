#include "types.h"
#include "stat.h"
#include "user.h"

#define PGSIZE 4096
#define NFUA 1
#define LAPA 2
#define SCFIFO 3
#define AQ 4
#define NONE 5

void allocate_n_pages(int n){
    for(int i=0;i<n;i++){
        sbrk(PGSIZE);
    }
}

// TASK 1 TESTS

void test1_check_if_one_page_is_allocted(){
    printf(1,"****STARTING test1_check_if_one_page_is_allocted****\n");
    printf(1, "%d free pages before fork in parent\n", getNumberOfFreePages());
    if(fork() == 0){
        int* a = (int*)sbrk(PGSIZE);
        printf(1, "storing a = 0x%x in memory\n", a);
        printf(1, "%d free pages after fork in child\n\n", getNumberOfFreePages());
        printf(1,"EXPECTED: difference of 69 pages\n\n");
        exit();
    }else{
        wait();
    }
    printf(1,"****test1_check_if_one_page_is_allocted ended****\n");
}


void test2_check_if_16_pages_are_allocted(){
    printf(1,"****STARTING test2_check_if_16_pages_are_allocted****\n");
    printf(1, "%d free pages before fork in parent\n", getNumberOfFreePages());

    if(fork() == 0){
        allocate_n_pages(16);
        printf(1, "%d free pages after fork in child\n\n", getNumberOfFreePages());
        printf(1,"EXPECTED: difference of 84 pages\n\n");
        exit();
    }else{
        wait();
    }
    printf(1,"****test2_check_if_16_pages_are_allocted ended****\n");
}

void test3_check_if_swap_pages_succeed(){
    printf(1,"****STARTING test3_check_if_swap_pages_succeed****\n");
    if(fork() == 0){
        int* numbers[32];
        for(int i=0;i<32;i++){
            numbers[i] = (int*)sbrk(PGSIZE);
            *numbers[i] = i;
        }
        
        for(int i = 0;i<32;i++){
            if(*numbers[i] != i){
                printf(1,"ERROR - value is'nt correct in the memory\n");
            }
            else{
                printf(1,"SUCCESS: numbers[%d] = %d\n", i, i);
            }
        }
        exit();
    }else{
        wait();
    }

    printf(1,"****test3_check_if_swap_pages_succeed ended****\n");
}


// TASK 2 TESTS

void test4_check_if_after_cow_no_free_pages_is_added(){
    printf(1,"****STARTING test4_check_if_after_cow_no_free_pages_is_added****\n");
    printf(1, "%d free pages before fork in parent\n", getNumberOfFreePages());
    if(fork() == 0){
        printf(1, "%d free pages after fork in child\n\n", getNumberOfFreePages());
        printf(1,"EXPECTED: difference of 68 pages\n\n");
        exit();
    } else{
        wait();
    }

    printf(1,"****test4_check_if_after_cow_no_free_pages_is_added ended****\n");
}

void test5_check_if_after_write_page_is_created_to_son(){
    printf(1,"****STARTING test5_check_if_after_write_page_is_created_to_son****\n");
    
    if (fork() == 0){
        int* test = (int*)sbrk(PGSIZE);
        *test = 0;
        printf(1, "test before fork in parent: %d\n", *test);
        printf(1, "%d free pages before fork in parent\n", getNumberOfFreePages());
        if(fork() == 0){
            *test = 1; // son writes to page which is read-only :O
            printf(1, "test after fork in child: %d\n", *test);
            printf(1, "%d free pages after fork in child\n\n", getNumberOfFreePages());
            printf(1,"EXPECTED: difference of 69 pages\n\n");
            exit();
        } else{
            printf(1, "test at the end of the function in parent: %d\n", *test);
            wait();
        }

    }
    else {
        wait();
    }
    
    



    printf(1,"****test5_check_if_after_write_page_is_created_to_son ended****\n");
}

// TASK 3 TESTS

void test6_check_nfua(){
    printf(1,"****    NFUA ONLY    ****\n");
    printf(1,"****STARTING test6_check_nfua****\n");
    if(fork() == 0){
        int* numbers[16];
        for(int i=0;i<16;i++){
            numbers[i] = (int*)sbrk(PGSIZE);
            if(i != 14){
                *numbers[i] = i;
            }
            if(i != 14){
                printf(1, "numbers[i] = 0x%x *numbers[i] = %d\n", numbers[i],*numbers[i]);
            }
        }
        printVaddressInRam();
        for(int i = 0;i<16;i++){
            if(i != 14){    // choose page to swap - we choose 14
                *numbers[i] = i;
            }
        }
        sleep(1);
        printVaddressInRam();
        printf(1, "trying to allocate another page (named a)...\n");
        int* a = (int*)sbrk(PGSIZE);
        *a = 100;
        printf(1, "a = 0x%x *a = %d\n", a, *a);
        printVaddressInRam(); 
        exit();
    }else{
        wait();
    }

    printf(1,"****test6_check_nfua ended****\n");
}

void test7_check_lapa(){
    printf(1,"****    LAPA ONLY    ****\n");
    printf(1,"****STARTING test7_check_lapa****\n");
    if(fork() == 0){
        int* numbers[16];
        for(int i=0;i<16;i++){
            numbers[i] = (int*)sbrk(PGSIZE);
            if(i != 14){
                *numbers[i] = i;
            }
            if(i != 14){
                printf(1, "numbers[i] = 0x%x *numbers[i] = %d\n", numbers[i],*numbers[i]);
            }
        }

        printVaddressInRamLAPAAlgo();
        for(int i = 0;i<16;i++){
            if(i % 2 != 0){    // choose page to swap - we choose 14
                *numbers[i] = i;
            }
        }

        printVaddressInRamLAPAAlgo();
  
        printf(1, "trying to allocate another page (named a)...\n");
        int* a = (int*)sbrk(PGSIZE);
        *a = 100;
        printf(1, "a = 0x%x *a = %d\n", a, *a);
        printVaddressInRamLAPAAlgo(); 
        printf(1, "EXPECTED: vaddr of lowest number of 1's swap to file and vaddr of a in ram\n");
        exit();
    }else{
        wait();
    }

    printf(1,"****test7_check_lapa ended****\n");
}




void test8_check_scfifo(){
    printf(1,"****    SCFIFO ONLY    ****\n");
    printf(1,"****STARTING test8_check_scfifo****\n");
    if(fork() == 0){
        int* numbers[16];
        for(int i=0;i<16;i++){
            numbers[i] = (int*)sbrk(PGSIZE);
            if(i == 0 || i==1 || i==2){
                *numbers[i] = i;
                printf(1, "numbers[i] = 0x%x *numbers[i] = %d\n", numbers[i],*numbers[i]);

            }
        }

        printVaddressInRam();
  
        printf(1, "trying to allocate another page (named a)...\n");
        int* a = (int*)sbrk(PGSIZE);
        *a = 100;
        printf(1, "a = 0x%x *a = %d\n", a, *a);
        printVaddressInRam(); 
        printf(1, "EXPECTED: vaddr of 3 swap to file and vaddr of a in ram\n");
        exit();
    }else{
        wait();
    }

    printf(1,"****test8_check_scfifo ended****\n");
}


void test9_check_aq(){
    printf(1,"****    AQ ONLY    ****\n");
    printf(1,"****STARTING test9_check_aq****\n");
    if(fork() == 0){
        int* numbers[16];
        for(int i=0;i<16;i++){
            numbers[i] = (int*)sbrk(PGSIZE);
            *numbers[i] = i;
            printf(1, "numbers[%d] = 0x%x *numbers[%d] = %d\n", i, numbers[i],*numbers[i], i);
        }

        printVaddressInRam(); 
        for(int i=0; i<16;i++){
            if(i%2 == 0){
                *numbers[i] = i;
            printf(1, "numbers[%d] = 0x%x *numbers[%d] = %d\n", i, numbers[i],*numbers[i], i);

            }
        }

        sleep(10);
        printVaddressInRam(); 

        printf(1, "trying to allocate another page (named a)...\n");
        int* a = (int*)sbrk(PGSIZE);
        *a = 100;
        printf(1, "a = 0x%x *a = %d\n", a, *a);
        sleep(10);

        printVaddressInRam(); 
        printf(1, "EXPECTED: vaddr of 1 swap to file and vaddr of a in ram\n");

        exit();
    }else{
        wait();
    }

    printf(1,"****test9_check_aq ended****\n");
}




int main(int argc, char **argv)
{
    printf(1, "STARTING TESTS: \n");
    printf(1, "\n");
    test1_check_if_one_page_is_allocted();
    printf(1, "\n");
    printf(1, "\n");
    test2_check_if_16_pages_are_allocted();
    printf(1, "\n");
    printf(1, "\n");
    test3_check_if_swap_pages_succeed();
    printf(1, "\n");
    printf(1, "\n");
    test4_check_if_after_cow_no_free_pages_is_added();
    printf(1, "\n");
    printf(1, "\n");
    test5_check_if_after_write_page_is_created_to_son();
    #if SELECTION == NFUA
        printf(1, "\n\n");
        test6_check_nfua();
    #elif SELECTION==LAPA
        printf(1, "\n\n");
        test7_check_lapa();
    #elif SELECTION== SCFIFO
        printf(1, "\n\n");
        test8_check_scfifo();
    #elif SELECTION== AQ
        printf(1, "\n\n");
        test9_check_aq();
    #endif

    exit();

}