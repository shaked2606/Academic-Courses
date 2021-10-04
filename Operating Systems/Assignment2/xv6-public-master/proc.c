#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "sig_action.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);


void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}


int 
allocpid(void) 
{
  int pid;
  // acquire(&ptable.lock);
  // pid = nextpid++;
  // release(&ptable.lock);
  // return pid;

  pushcli();
  do {
    pid = nextpid;
  } while(!cas(&nextpid, pid, pid+1));
  popcli();
  return pid;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  pushcli();
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      // if succeed we can ensure that only one process was chosen, and only one cpu will continue. The other cpus still in the loop
      if(cas(&p->state, UNUSED, EMBRYO)){
        goto found;
      }
  }
  popcli();
  // release(&ptable.lock);
  return 0;

found:
  // p->state = EMBRYO;
  // release(&ptable.lock);
  popcli();
  p->pid = allocpid();

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;



  p->handle_user_signal = 0;
  p->stopped = 0;
  p->pending_sig = 0;
  p->mask_sig = 0;
  for(int i=0;i<SIGNUM;i++){
    p->signal_handlers[i] = SIG_DFL;
    p->handlers_sigmask[i] = 0;
  }
  p->utfb = (struct trapframe*)kalloc();

  p->signal_handlers[SIGKILL] = (void*)SIGKILL;
  p->signal_handlers[SIGSTOP] = (void*)SIGSTOP;
  p->signal_handlers[SIGCONT] = (void*)SIGCONT;

  return p;
}


//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();

  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.

  // acquire(&ptable.lock);
  // p->state = RUNNABLE;
  // release(&ptable.lock);
  pushcli();
  p->state = RUNNABLE;
  popcli();
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }
  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    kfree((char*)np->utfb);
    np->utfb = 0;
    np->state = UNUSED;
    return -1;
  }

  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  // copy all signal handlers and their mask to the child
  for(int i=0;i<SIGNUM;i++){
    np->signal_handlers[i] = curproc->signal_handlers[i];
    np->handlers_sigmask[i] = curproc->handlers_sigmask[i];
  }
  // copy parent mask signal to the child
  np->mask_sig = curproc->mask_sig;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  // acquire(&ptable.lock);
  // np->state = RUNNABLE;
  // release(&ptable.lock);
  pushcli();
  np->state = RUNNABLE;
  popcli();

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  // acquire(&ptable.lock);
  pushcli();
  curproc->state = MINUSZOMBIE;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent == curproc){
          p->parent = initproc;
          if(p->state == ZOMBIE)
              wakeup1(initproc);
      }
  }
  // Jump into the scheduler, never to return.
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  pushcli();
  // acquire(&ptable.lock);
  for(;;){
    while(!cas(&curproc->state, RUNNING, MINUSSLEEPING)){}
    curproc->chan = (void*)curproc;

    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      while(p->state == MINUSZOMBIE){}
      if(cas(&p->state, ZOMBIE, MINUSUNUSED)){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        kfree((char*)p->utfb);
        p->utfb = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        curproc->chan = 0;
        if(!cas(&p->state, MINUSUNUSED, UNUSED)){
          panic("wait1\n");
        }
        if(!cas(&curproc->state, MINUSSLEEPING, RUNNING)){
          panic("wait2\n");
        }
        popcli();
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      curproc->chan = 0;
      curproc->state = RUNNING;
      popcli();
      return -1;
    }

    sched();
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    // sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
  int flag = 0;

  
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    // acquire(&ptable.lock);
    pushcli();
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(!cas(&p->state, RUNNABLE, MINUSRUNNING)){
        continue;
      }

    if(p->stopped == 1){
      // check if some of the on signals is with cont handler or kill handler
      for(int i=0;i<SIGNUM;i++){
        if(SIG_CHECK(p->pending_sig, i) != 0){
          if(p->signal_handlers[i] == (void*)SIGCONT || p->signal_handlers[SIGCONT] == (void*)SIG_DFL || p->signal_handlers[i] == (void*)SIGKILL){
            flag = 1;
            break;
          }
        }
      }
    }
      // check if the stopped process needs to be awaken
      if(p->stopped == 1 && flag == 0){
        cas(&p->state, MINUSRUNNING, RUNNABLE);
        continue;
      }
      flag = 0;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);

      swtch(&(c->scheduler), p->context);
      switchkvm();
      c->proc = 0;

      cas(&p->state, MINUSRUNNABLE, RUNNABLE);
      if(cas(&p->state, MINUSSLEEPING, SLEEPING)){
        if(p->killed==1)
          cas(&p->state, SLEEPING, RUNNABLE);
      }
      if(cas(&p->state, MINUSZOMBIE, ZOMBIE)){
            wakeup1(p->parent);
      }
    }
    // release(&ptable.lock);
    popcli();
  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  // if(!holding(&ptable.lock))
  //   panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  if(!cas(&p->state, MINUSRUNNING, RUNNING)){
    panic("sched");
  }
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  // acquire(&ptable.lock);  //DOC: yieldlock
  pushcli();
  struct proc *p = myproc();
  if(!cas(&p->state, RUNNING, MINUSRUNNABLE)){
    panic("yield");
  }
  sched();
  popcli();
  // release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  struct proc *p = myproc();
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  // release(&ptable.lock);
   p->state = RUNNING;
  popcli();
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Go to sleep.
  pushcli();
  while(!cas(&p->chan, 0, (int)chan)){}
  p->state = MINUSSLEEPING;
  release(lk);
  sched();
  while(!cas(&p->chan, 0, 0)){}
  popcli();
  acquire(lk);
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    while(cas(&p->state, MINUSSLEEPING, MINUSSLEEPING)){}
    if(p->state == SLEEPING && chan == p->chan){
      if(!cas(&p->chan, (int)chan, 0)){
        panic("wakeup1");
      }
      if(!cas(&p->state, SLEEPING, RUNNABLE)){
          continue;
      }
    }
  }
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  // acquire(&ptable.lock);
  pushcli();
  wakeup1(chan);
  popcli();
  // release(&ptable.lock);
}




// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid, int signum)
{
  struct proc *p;
  int wakeup = 0;

  pushcli();
  // acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->pending_sig = SIG_ON(p->pending_sig, signum);

      if(cas(&p->state, SLEEPING, MINUSSLEEPING)){

        if(SIG_CHECK(p->mask_sig, signum) == 0){
          if(p->signal_handlers[signum] == (void*)SIGKILL || (p->signal_handlers[signum] == (void*)SIG_DFL && (signum != SIGCONT && signum != SIGSTOP))){
            wakeup = 1;
          }
        }
        if(signum == SIGKILL || wakeup == 1){
          p->killed = 1;
          cas(&p->state, MINUSSLEEPING, RUNNABLE);
        }
        else{
          cas(&p->state, MINUSSLEEPING, SLEEPING);
        }
      }
      

      popcli();
      // release(&ptable.lock);
      wakeup = 0;
      return 0;
    }
  }
  popcli();
  // release(&ptable.lock);
  return -1;
}

uint sigprocmask(uint sigmask){
    struct proc *p = myproc();
    uint old_mask = p->mask_sig;
    p->mask_sig = sigmask;
    return old_mask;
}

int
sigaction(int signum, const struct sigaction *act, struct sigaction *oldact){
  struct proc *p = myproc();

  if(act->sigmask < 0){
    return -1;
  }
  if(signum == SIGKILL || signum == SIGSTOP){
    return -1;
  }
  if(oldact != null){
    oldact->sa_handler = p->signal_handlers[signum];
    oldact->sigmask = p->handlers_sigmask[signum];
  }

  p->signal_handlers[signum] = act->sa_handler;
  p->handlers_sigmask[signum] = act->sigmask;

  return 0;
}

void kill_handler(int signum){
    struct proc *p = myproc();
    p->killed = 1;
}

void stop_handler(int signum){
    struct proc *p = myproc();
    p->stopped = 1;
    yield();
}

void cont_handler(int signum){
    struct proc *p = myproc();
    p->stopped = 0;
}

void sigret(void){
    struct proc *p = myproc();
    *p->tf = *p->utfb;
    p->mask_sig = p->mask_backup;
    p->handle_user_signal = 0;
}


void pending_signals(){
   uint sig_ret_position_stack = 0;
   int code_size = 0;

  struct proc *p = myproc();
  if(p == null){
    return;
  }

  // // DONT KNOW IF NEEDS
  // if((p->tf->cs&3) != DPL_USER){
  //   return;
  // }

  for(int i=0;i<SIGNUM;i++){
    if(SIG_CHECK(p->pending_sig, i) != 0){
        if(i == SIGKILL){
          kill_handler(i); // never to avoid
        }
        else if(i == SIGSTOP){
          stop_handler(i);  // never to avoid
        }
        else if(SIG_CHECK(p->mask_sig, i) == 0){ // handle only if sigmask of proc is not blocking on this signal
          if(p->signal_handlers[i] == (void*)SIGKILL){

            kill_handler(i);
          }
          else if(p->signal_handlers[i] == (void*)SIGSTOP){
            stop_handler(i);
          }
          if(p->signal_handlers[i] == (void*)SIG_DFL){
              if(i == SIGCONT){
                if(p->stopped == 1){ // only handled if sigstop is on. if not - ignored.
                  cont_handler(i);
                }
              }
              else{
                  kill_handler(i);
              }
          }
          else if(p->signal_handlers[i] == (void*)SIGCONT){
            if(p->stopped == 1){ // only handled if sigstop is on. if not - ignored.
              cont_handler(i);
            }
          }
          else if(p->signal_handlers[i] == (void*)SIG_IGN){
                // skiping the signal and turn off the bit in pending array
                p->pending_sig = SIG_OFF(p->pending_sig, i);
                continue;
          }
          else if(p->handle_user_signal == 0){ // user-handler
              *p->utfb = *p->tf;
              p->handle_user_signal = 1; // so we dont handle other user-handlers
              p->pending_sig = SIG_OFF(p->pending_sig, i);
              p->mask_backup = sigprocmask(p->handlers_sigmask[i]);  // we save our original mask of the proc
              code_size = (int)end_sigret - (int)start_sigret;
              p->tf->esp -= code_size;
              sig_ret_position_stack = p->tf->esp;
              memmove((void*)p->tf->esp, &start_sigret, code_size);

              // argument of signum
              p->tf->esp -= sizeof(int);
              (*((int*)p->tf->esp)) = i;
              
              // injected code
              p->tf->esp -= sizeof(char*);
              *((int*)p->tf->esp) = sig_ret_position_stack;

              p->tf->eip = (uint)p->signal_handlers[i];
              // user-handler function address
              break; // handling user-handler right now !
          }
          else if(p->handle_user_signal == 1){
            continue;
          }
        }
        else if(SIG_CHECK(p->mask_sig, i) != 0){
          // signal needs to be skipped but not turned off
          continue;
        }
    p->pending_sig = SIG_OFF(p->pending_sig, i);
    }
  }
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
