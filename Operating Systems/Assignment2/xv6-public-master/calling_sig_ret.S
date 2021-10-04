#include "syscall.h"
#include "traps.h"

.globl start_sigret
start_sigret:
    movl $SYS_sigret, %eax
    int $64
    ret
.globl end_sigret
end_sigret:
