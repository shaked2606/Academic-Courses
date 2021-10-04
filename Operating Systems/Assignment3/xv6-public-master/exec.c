#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  struct proc *p = myproc();
  struct page_data backup_ram_pages[MAX_PSYC_PAGES];
  struct page_data backup_swap_file_pages[MAX_PSYC_PAGES];

  if(p->pid > 2){
      struct page_data *curr;
      int i=0;
      // back-up and reset the structs for case which exec fails
      for(curr = &p->ram_pages[0]; curr < &p->ram_pages[MAX_PSYC_PAGES] ; curr++){
        backup_ram_pages[i].ison = curr->ison;
        backup_ram_pages[i].creation_time = curr->creation_time;
        backup_ram_pages[i].age = curr->age;
        backup_ram_pages[i].offset = curr->offset;
        backup_ram_pages[i].pte = curr->pte;
        backup_ram_pages[i].vaddr = curr->vaddr;


        curr->ison = 0;
        curr->pte = 0;
        curr->vaddr = 0;
        curr->offset = -1;
        curr->age = 0;
        curr->creation_time = 0;
        i++;
      }

      i=0;
      for(curr = &p->swapfile_pages[0]; curr < &p->swapfile_pages[MAX_PSYC_PAGES] ; curr++){
        backup_swap_file_pages[i].ison = curr->ison;
        backup_swap_file_pages[i].creation_time = curr->creation_time;
        backup_swap_file_pages[i].age = curr->age;
        backup_swap_file_pages[i].offset = curr->offset;
        backup_swap_file_pages[i].pte = curr->pte;
        backup_swap_file_pages[i].vaddr = curr->vaddr;


        curr->ison = 0;
        curr->pte = 0;
        curr->vaddr = 0;
        curr->offset = -1;
        curr->age = 0;
        curr->creation_time = 0;
        i++;
      }
  }


  char *s, *last;
  int i, off;
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
    cprintf("exec: fail\n");
    goto bad2;
    return -1;
  }
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;

  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
  curproc->tf->esp = sp;
  switchuvm(curproc);
  freevm(oldpgdir);

  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
    end_op();
  }

  bad2:
  // if exec fails - back up all data in structs
  for(int i=0;i<MAX_PSYC_PAGES;i++){
      p->ram_pages[i].ison = backup_ram_pages[i].ison;
      p->ram_pages[i].creation_time = backup_ram_pages[i].creation_time;
      p->ram_pages[i].age = backup_ram_pages[i].age;
      p->ram_pages[i].offset = backup_ram_pages[i].offset;
      p->ram_pages[i].pte = backup_ram_pages[i].pte;
      p->ram_pages[i].vaddr = backup_ram_pages[i].vaddr;

      p->swapfile_pages[i].ison = backup_swap_file_pages[i].ison;
      p->swapfile_pages[i].creation_time = backup_swap_file_pages[i].creation_time;
      p->swapfile_pages[i].age = backup_swap_file_pages[i].age;
      p->swapfile_pages[i].offset = backup_swap_file_pages[i].offset;
      p->swapfile_pages[i].pte = backup_swap_file_pages[i].pte;
      p->swapfile_pages[i].vaddr = backup_swap_file_pages[i].vaddr;
  }

  return -1;
}
