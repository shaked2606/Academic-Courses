typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;
typedef uint pde_t;

#define null 0
#define SIG_CHECK(num, sig) ((1 << sig) & (num))
#define SIG_ON(num, sig) ((1 << sig) | (num))
#define SIG_OFF(num, sig) ((num) & ~(1 << sig))