#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"
#include "spinlock.h"

extern char data[];  // defined by kernel.ld
pde_t *kpgdir;  // for use in scheduler()

struct spinlock lk;
int refcount_page[PHYSTOP / PGSIZE]; // array of size max pages on ram

void
increment_refcount_page(pte_t * pte){
  acquire(&lk);

  uint pa = PTE_ADDR(*pte);
  uint index = pa / PGSIZE;

  refcount_page[index] += 1;

  release(&lk);
}

void
decrement_refcount_page(pte_t * pte){
  acquire(&lk);

  uint pa = PTE_ADDR(*pte);
  uint index = pa / PGSIZE;

  refcount_page[index] -= 1;

  release(&lk);
}

int
get_num_refcount_page(pte_t * pte){
  acquire(&lk);

  uint pa = PTE_ADDR(*pte);
  uint index = pa / PGSIZE;

  int count = refcount_page[index];
  
  release(&lk);

  return count;
}


int
count_num_of_1(uint age){
  int count = 0;
  while(age > 0){
    if((age & 0x1) > 0){
      count++;
    }
    age = age >> 1;
  }
  return count;
}


int
nfua(){
  struct proc* p = myproc();
  int page_chosen = -1;
  int min_val = __INT32_MAX__;
  for(int i=0;i<MAX_PSYC_PAGES;i++){
      if(p->ram_pages[i].age < min_val){
        min_val = p->ram_pages[i].age;
        page_chosen = i;
      }
  }
  return page_chosen;
}


int
lapa(){
  struct proc* p = myproc();
  int page_chosen = -1;
  int num_of_1 = __INT32_MAX__;
  int min_val = __INT32_MAX__;
  // find minimal count of 1
  for(int i=0;i<MAX_PSYC_PAGES;i++){
    int count_num_of_1_page = count_num_of_1(p->ram_pages[i].age);
    if(count_num_of_1_page < num_of_1){
      num_of_1 = count_num_of_1_page;
      page_chosen = i;
    }
  }
  
  // between the minimal pages were found - choose the lowest value age
  for(int i=0;i<MAX_PSYC_PAGES;i++){
    if(num_of_1 == count_num_of_1(p->ram_pages[i].age)){
      if(p->ram_pages[i].age < min_val){
        min_val = p->ram_pages[i].age;
        page_chosen = i;
      }
    }
  }
  return page_chosen;
}


int 
find_next_min_val(int min){
  struct proc* p = myproc();
  int min_val = __INT32_MAX__;
  int page_index = -1;
  for(int i=0;i<MAX_PSYC_PAGES;i++){
      if((p->ram_pages[i].creation_time > min) && (p->ram_pages[i].creation_time < min_val)){
        min_val = p->ram_pages[i].creation_time;
        page_index = i;
      }
  }

  return page_index;
}

int
scfifo(){
  struct proc* p = myproc();
  int chosen_page = -1;
  int curr_min_val = -1;
  int num_pages_check = 0;
          
  while(1){
      int temp_chosen_page = find_next_min_val(curr_min_val);
      if(temp_chosen_page >= 0){
        chosen_page = temp_chosen_page;
      }
      if(chosen_page < 0){
        panic("invalid index of array");
      }
      if(PTE_A(*p->ram_pages[chosen_page].pte) > 0){
        *p->ram_pages[chosen_page].pte = CLEAR_PTE_A(*p->ram_pages[chosen_page].pte);
        curr_min_val = p->ram_pages[chosen_page].creation_time;
        num_pages_check++;
      }
      else{
        return chosen_page;
      }

      if(num_pages_check == MAX_PSYC_PAGES){
        curr_min_val = -1;
        num_pages_check = 0;
      }
  }
}

#if SELECTION == AQ
int 
aq(){
  struct proc* p = myproc();

  int chosen_page = p->aq_page_indexes[MAX_PSYC_PAGES-1];
  
  return chosen_page;
}
#endif

int
choose_page_to_swap(){
  #if SELECTION == NFUA
    return nfua();
  #endif

  #if SELECTION == LAPA
    return lapa();
  #endif

  #if SELECTION == SCFIFO
    return scfifo();
  #endif

  #if SELECTION == AQ
    return aq();
  #endif

  return -1;
}


int
find_free_ram_page(){
  int index_ram = -1;
  struct proc* p = myproc();

  for(int i=0;i<MAX_PSYC_PAGES;i++){
    if(p->ram_pages[i].ison == 0){
        index_ram = i;
        break;
    }
  }
  return index_ram;
}

void
update_ram_page_data(int ison, pte_t* pte, uint vaddr, int offset, int index){
  struct proc* p = myproc();

  p->ram_pages[index].ison = ison;
  p->ram_pages[index].offset = offset;
  p->ram_pages[index].vaddr = vaddr;
  p->ram_pages[index].pte = pte;
  
  #if SELECTION == SCFIFO
    p->ram_pages[index].creation_time = p->creation_time_counter;
    
    p->creation_time_counter+=1;
  #endif

  #if SELECTION == NFUA
    p->ram_pages[index].age = 0;
  #endif

  #if SELECTION == LAPA
    p->ram_pages[index].age = 0xFFFFFFFF;
  #endif

  #if SELECTION == AQ
    for(int i=MAX_PSYC_PAGES-2;i>=0;i--){
        p->aq_page_indexes[i+1] = p->aq_page_indexes[i];
    }
    p->aq_page_indexes[0] = index;
  #endif
}


// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
  struct cpu *c;

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  lgdt(c->gdt, sizeof(c->gdt));
}

// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.



static
pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}

pte_t *
unstatic_walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
  return walkpgdir(pgdir, va, alloc);
}



// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}

// There is one page table per process, plus one that's used when
// a CPU is not running any process (kpgdir). The kernel uses the
// current process's page table during system calls and interrupts;
// page protection bits prevent user code from using the kernel's
// mappings.
//
// setupkvm() and exec() set up every page table like this:
//
//   0..KERNBASE: user memory (text+data+stack+heap), mapped to
//                phys memory allocated by the kernel
//   KERNBASE..KERNBASE+EXTMEM: mapped to 0..EXTMEM (for I/O space)
//   KERNBASE+EXTMEM..data: mapped to EXTMEM..V2P(data)
//                for the kernel's instructions and r/o data
//   data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP,
//                                  rw data + free physical memory
//   0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
// (directly addressable from end..P2V(PHYSTOP)).

// This table defines the kernel's mappings, which are present in
// every process's page table.
static struct kmap {
  void *virt;
  uint phys_start;
  uint phys_end;
  int perm;
} kmap[] = {
 { (void*)KERNBASE, 0,             EXTMEM,    PTE_W}, // I/O space
 { (void*)KERNLINK, V2P(KERNLINK), V2P(data), 0},     // kern text+rodata
 { (void*)data,     V2P(data),     PHYSTOP,   PTE_W}, // kern data+memory
 { (void*)DEVSPACE, DEVSPACE,      0,         PTE_W}, // more devices
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
}

void
update_swapfile_page_data(int ison, pte_t* pte, uint vaddr, int offset, int index){
  struct proc* p = myproc();

  p->swapfile_pages[index].ison = ison;
  p->swapfile_pages[index].offset = offset;
  p->swapfile_pages[index].vaddr = vaddr;
  p->swapfile_pages[index].pte = pte;
}

int
swap(pde_t *pgdir, uint addr){
  struct proc* p = myproc();
  uint pa;
                             
  int index_ram = choose_page_to_swap();
      


  if(index_ram == -1){
    panic("didn't find page :(");
    return -1;
  }
  for(int i=0;i<MAX_PSYC_PAGES;i++){
    if(p->swapfile_pages[i].ison == 0){
        p->times_of_pages_out++;

        writeToSwapFile(p, (char*)PGROUNDDOWN(p->ram_pages[index_ram].vaddr), i*PGSIZE,PGSIZE);
        
        *p->ram_pages[index_ram].pte &= ~PTE_P;
        *p->ram_pages[index_ram].pte |= PTE_PG;
        update_swapfile_page_data(1, p->ram_pages[index_ram].pte, p->ram_pages[index_ram].vaddr, i*PGSIZE, i);



        pa = PTE_ADDR(*p->ram_pages[index_ram].pte);
        decrement_refcount_page(p->ram_pages[index_ram].pte);
        int count = get_num_refcount_page(p->ram_pages[index_ram].pte);
        // this process is the only one who point to this page
        if(count == 0){
          kfree(P2V(pa));  
        }

        pte_t *new_pte = walkpgdir(pgdir, (void*)addr, 0);
        *new_pte |= PTE_P;
        *new_pte &= ~PTE_PG;
        update_ram_page_data(1, new_pte, addr, index_ram*PGSIZE, index_ram);



        increment_refcount_page(new_pte);

        lcr3(V2P(p->pgdir));

        return 0;
    }
  }
  return -1;
}

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *mem;
  uint a;
  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W | PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
    }

    #if SELECTION == NONE
      if(myproc()->pid > 2){
        pte_t* pte_proc = walkpgdir(pgdir, (void*) a, 0);
        increment_refcount_page(pte_proc);
      }
    #endif


    #if SELECTION != NONE
      struct proc* p = myproc();
      if(p->pid > 2){
        int i;
        for(i=0;i<MAX_PSYC_PAGES;i++){
          if(p->ram_pages[i].ison == 0){
            update_ram_page_data(1, walkpgdir(pgdir, (void*) a, 0), a, i*PGSIZE, i);
            increment_refcount_page(p->ram_pages[i].pte);
            *p->ram_pages[i].pte |= PTE_P;
            lcr3(V2P(p->pgdir));
            break;
          }
        }


        if(i == MAX_PSYC_PAGES){
          if(swap(pgdir, a) < 0){
            deallocuvm(pgdir, newsz, oldsz);
            panic("can't allocate more than 32 pages");
            return 0;
          }
        }
      }
      #endif
  }
  return newsz;
}

int
deep_copy_of_page(pte_t* pte, uint addr){
  struct proc* p = myproc();
  char* mem;
  uint pa;

  if((*pte & PTE_U) == 0 || addr >= KERNBASE){
    p->killed = 1;
    return -1;
  }

  if(get_num_refcount_page(pte) == 1){
    *pte |= PTE_W;
    lcr3(V2P(p->pgdir));
    return 0;
  }

  pa = PTE_ADDR(*pte);

  if((mem = kalloc()) == 0){
    p->killed = 1;
    return -1;
  }

  memmove(mem, (char*)P2V(pa), PGSIZE);


  // dec reference to this page
  decrement_refcount_page(pte);

  *pte = V2P(mem) | PTE_P | PTE_W | PTE_U | PTE_COW;
  
  increment_refcount_page(pte);

  // update pgdir because we changed flags
  lcr3(V2P(p->pgdir));

  return 0;

}

#if SELECTION != NONE

int
swap_page_to_ram(uint addr){
    uint start_of_page = PGROUNDDOWN(addr);
    uint pa;
    struct proc* p = myproc();
    pte_t* pte_2;
    struct page_data temp_page_data;
    char *mem = kalloc();

    memset(mem, 0, PGSIZE);

    int index_ram = find_free_ram_page();
    if(index_ram != -1){
      // found free page in the ram
      for(int i=0;i<MAX_PSYC_PAGES;i++){
        if(PGROUNDDOWN(p->swapfile_pages[i].vaddr) == start_of_page){
            if(readFromSwapFile(p, mem, p->swapfile_pages[i].offset, PGSIZE) != PGSIZE){
              panic("readFromSWapFIle failed :(");
            }
            uint temp_vaddr_from_swapfile = p->swapfile_pages[i].vaddr;
            mappages(p->pgdir, (void*)PGROUNDDOWN(temp_vaddr_from_swapfile), PGSIZE, V2P(mem), (PTE_W | PTE_U| PTE_P));
            pte_2 = walkpgdir(p->pgdir,(void*)PGROUNDDOWN(temp_vaddr_from_swapfile), 1);
            *pte_2 &= ~PTE_PG; 
            
            increment_refcount_page(pte_2);

            update_ram_page_data(1, pte_2, temp_vaddr_from_swapfile,index_ram*PGSIZE, index_ram);
            update_swapfile_page_data(0, 0, 0, 0, i);
            lcr3(V2P(p->pgdir));
            return 0;
        }
      }
      return -1;
    }
    else {
      p->times_of_pages_out++;
      // there's no free page in the ram - need to swap
      int occupied_page_index = choose_page_to_swap();
      if(occupied_page_index == -1){
        return -1;
      }
      for(int i=0;i<MAX_PSYC_PAGES;i++){
        if(p->swapfile_pages[i].vaddr == start_of_page){ 
            // read from file and save into mem
            if(readFromSwapFile(p, mem, p->swapfile_pages[i].offset, PGSIZE) != PGSIZE){
              panic("readFromSWapFIle failed :(");
            } 
            if(writeToSwapFile(p, (char*)PGROUNDDOWN(p->ram_pages[occupied_page_index].vaddr), i*PGSIZE, PGSIZE) != PGSIZE){
                panic("writeToSWapFIle failed :(");
            }

            temp_page_data.vaddr = p->swapfile_pages[i].vaddr;

            update_swapfile_page_data(1, p->ram_pages[occupied_page_index].pte, p->ram_pages[occupied_page_index].vaddr, i*PGSIZE, i);

            *p->swapfile_pages[i].pte &= ~PTE_P;
            *p->swapfile_pages[i].pte |= PTE_PG;
            pa = PTE_ADDR(*p->ram_pages[occupied_page_index].pte);

            decrement_refcount_page(p->ram_pages[occupied_page_index].pte);
            int count = get_num_refcount_page(p->ram_pages[occupied_page_index].pte);

            // this process is the only one who point to this page
            if(count == 0){
              kfree(P2V(pa));  
            }

            mappages(p->pgdir, (void*)PGROUNDDOWN(temp_page_data.vaddr), PGSIZE, V2P(mem),  (PTE_W|PTE_U|PTE_P));
            pte_2 = walkpgdir(p->pgdir,(void*)PGROUNDDOWN(temp_page_data.vaddr), 1);
            *pte_2 &= ~PTE_PG;
            
            increment_refcount_page(pte_2);

            update_ram_page_data(1, pte_2, temp_page_data.vaddr, occupied_page_index*PGSIZE, occupied_page_index);
            lcr3(V2P(p->pgdir));

            return 0;
        }
      }
      return -1;
    }
}

#endif


// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;
  struct proc *p;

  if(newsz >= oldsz)
    return oldsz;

  p = get_proc_by_pg_dir(pgdir);
  if(p == 0){
    p = myproc();
  }

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");

      char *v = P2V(pa);

      if(p->pid > 2){
          decrement_refcount_page(pte);
          if(get_num_refcount_page(pte) == 0){
            kfree(v);
            *pte = 0;
          }

          #if SELECTION != NONE
              for(int i=0;i<MAX_PSYC_PAGES;i++){
                if(p->ram_pages[i].vaddr == a){
                  p->ram_pages[i].ison = 0;
                }
              }
          #endif
      }
      else {
        kfree(v);
        *pte = 0;
      }
    }
  }
  return newsz;
}

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
}

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
  *pte &= ~PTE_U;
}

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P)){
      if(!(*pte & PTE_PG) || myproc()->pid < 2)
        panic("copyuvm: page not present and not in swapfile");
    }

    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);

    #if SELECTION != NONE
      pte_t *new_pte;
      if(myproc()->pid > 2){  
        if((*pte & PTE_PG) > 0){
            if(mappages(d, (void*)i, PGSIZE, V2P(0), flags) < 0)
                goto bad;
            new_pte = walkpgdir(d, (void *) i, 1);
            *new_pte = *new_pte & (~PTE_P);
            *new_pte = *new_pte | PTE_PG;
            *new_pte &= PTE_FLAGS(*new_pte);
            lcr3(V2P(d));
            continue;
        }
     }
    #endif


    if(myproc()->pid > 2){
      // child point to the same pa as his parent (not doing kalloc)
      if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
        goto bad;
      }
      pte_t* cow_pte = walkpgdir(d, (void*) i, 0);

      if((*pte & PTE_W) || (*pte & PTE_COW)){
          *cow_pte &= ~PTE_W;
          *cow_pte |= PTE_COW;

          *pte &= ~PTE_W;
          *pte |= PTE_COW;
      }

      // inc reference count to this page
      increment_refcount_page(pte);
    }
    else { // init and sh should allocate memory normally
      if((mem = kalloc()) == 0)
        goto bad;
      memmove(mem, (char*)P2V(pa), PGSIZE);

      // child of init/sh need to deep copy mem
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), (flags)) < 0) {
        kfree(mem);
        goto bad;
      }


      if(myproc()->pid == 2){
        pte_t* pte_of_son = walkpgdir(d, (void*)i, 0);
        increment_refcount_page(pte_of_son);
      }
    }
  }

  // update pgdir because we changed flags
  lcr3(V2P(pgdir));
  return d;

bad:
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}

// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}

//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.

