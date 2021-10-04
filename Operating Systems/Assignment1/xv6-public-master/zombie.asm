
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 64 02 00 00       	call   27a <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 f6 02 00 00       	call   31a <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit(0);
  27:	83 ec 0c             	sub    $0xc,%esp
  2a:	6a 00                	push   $0x0
  2c:	e8 51 02 00 00       	call   282 <exit>
  31:	66 90                	xchg   %ax,%ax
  33:	66 90                	xchg   %ax,%ax
  35:	66 90                	xchg   %ax,%ax
  37:	66 90                	xchg   %ax,%ax
  39:	66 90                	xchg   %ax,%ax
  3b:	66 90                	xchg   %ax,%ax
  3d:	66 90                	xchg   %ax,%ax
  3f:	90                   	nop

00000040 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  44:	8b 45 08             	mov    0x8(%ebp),%eax
  47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4a:	89 c2                	mov    %eax,%edx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  50:	83 c1 01             	add    $0x1,%ecx
  53:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  57:	83 c2 01             	add    $0x1,%edx
  5a:	84 db                	test   %bl,%bl
  5c:	88 5a ff             	mov    %bl,-0x1(%edx)
  5f:	75 ef                	jne    50 <strcpy+0x10>
    ;
  return os;
}
  61:	5b                   	pop    %ebx
  62:	5d                   	pop    %ebp
  63:	c3                   	ret    
  64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	56                   	push   %esi
  74:	53                   	push   %ebx
  75:	8b 55 08             	mov    0x8(%ebp),%edx
  78:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  7b:	0f b6 02             	movzbl (%edx),%eax
  7e:	0f b6 19             	movzbl (%ecx),%ebx
  81:	84 c0                	test   %al,%al
  83:	75 1e                	jne    a3 <strcmp+0x33>
  85:	eb 29                	jmp    b0 <strcmp+0x40>
  87:	89 f6                	mov    %esi,%esi
  89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  90:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  93:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  96:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  99:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  9d:	84 c0                	test   %al,%al
  9f:	74 0f                	je     b0 <strcmp+0x40>
  a1:	89 f1                	mov    %esi,%ecx
  a3:	38 d8                	cmp    %bl,%al
  a5:	74 e9                	je     90 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a7:	29 d8                	sub    %ebx,%eax
}
  a9:	5b                   	pop    %ebx
  aa:	5e                   	pop    %esi
  ab:	5d                   	pop    %ebp
  ac:	c3                   	ret    
  ad:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b2:	29 d8                	sub    %ebx,%eax
}
  b4:	5b                   	pop    %ebx
  b5:	5e                   	pop    %esi
  b6:	5d                   	pop    %ebp
  b7:	c3                   	ret    
  b8:	90                   	nop
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000c0 <strlen>:

uint
strlen(const char *s)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  c6:	80 39 00             	cmpb   $0x0,(%ecx)
  c9:	74 12                	je     dd <strlen+0x1d>
  cb:	31 d2                	xor    %edx,%edx
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	83 c2 01             	add    $0x1,%edx
  d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  d7:	89 d0                	mov    %edx,%eax
  d9:	75 f5                	jne    d0 <strlen+0x10>
    ;
  return n;
}
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  dd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  df:	5d                   	pop    %ebp
  e0:	c3                   	ret    
  e1:	eb 0d                	jmp    f0 <memset>
  e3:	90                   	nop
  e4:	90                   	nop
  e5:	90                   	nop
  e6:	90                   	nop
  e7:	90                   	nop
  e8:	90                   	nop
  e9:	90                   	nop
  ea:	90                   	nop
  eb:	90                   	nop
  ec:	90                   	nop
  ed:	90                   	nop
  ee:	90                   	nop
  ef:	90                   	nop

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	89 d7                	mov    %edx,%edi
  ff:	fc                   	cld    
 100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 102:	89 d0                	mov    %edx,%eax
 104:	5f                   	pop    %edi
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	89 f6                	mov    %esi,%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <strchr>:

char*
strchr(const char *s, char c)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 11a:	0f b6 10             	movzbl (%eax),%edx
 11d:	84 d2                	test   %dl,%dl
 11f:	74 1d                	je     13e <strchr+0x2e>
    if(*s == c)
 121:	38 d3                	cmp    %dl,%bl
 123:	89 d9                	mov    %ebx,%ecx
 125:	75 0d                	jne    134 <strchr+0x24>
 127:	eb 17                	jmp    140 <strchr+0x30>
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 130:	38 ca                	cmp    %cl,%dl
 132:	74 0c                	je     140 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 134:	83 c0 01             	add    $0x1,%eax
 137:	0f b6 10             	movzbl (%eax),%edx
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 13e:	31 c0                	xor    %eax,%eax
}
 140:	5b                   	pop    %ebx
 141:	5d                   	pop    %ebp
 142:	c3                   	ret    
 143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <gets>:

char*
gets(char *buf, int max)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	56                   	push   %esi
 155:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 156:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 158:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 15b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15e:	eb 29                	jmp    189 <gets+0x39>
    cc = read(0, &c, 1);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	6a 01                	push   $0x1
 165:	57                   	push   %edi
 166:	6a 00                	push   $0x0
 168:	e8 2d 01 00 00       	call   29a <read>
    if(cc < 1)
 16d:	83 c4 10             	add    $0x10,%esp
 170:	85 c0                	test   %eax,%eax
 172:	7e 1d                	jle    191 <gets+0x41>
      break;
    buf[i++] = c;
 174:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 178:	8b 55 08             	mov    0x8(%ebp),%edx
 17b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 17d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 17f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 183:	74 1b                	je     1a0 <gets+0x50>
 185:	3c 0d                	cmp    $0xd,%al
 187:	74 17                	je     1a0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 189:	8d 5e 01             	lea    0x1(%esi),%ebx
 18c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 18f:	7c cf                	jl     160 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 191:	8b 45 08             	mov    0x8(%ebp),%eax
 194:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 198:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19b:	5b                   	pop    %ebx
 19c:	5e                   	pop    %esi
 19d:	5f                   	pop    %edi
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ac:	5b                   	pop    %ebx
 1ad:	5e                   	pop    %esi
 1ae:	5f                   	pop    %edi
 1af:	5d                   	pop    %ebp
 1b0:	c3                   	ret    
 1b1:	eb 0d                	jmp    1c0 <stat>
 1b3:	90                   	nop
 1b4:	90                   	nop
 1b5:	90                   	nop
 1b6:	90                   	nop
 1b7:	90                   	nop
 1b8:	90                   	nop
 1b9:	90                   	nop
 1ba:	90                   	nop
 1bb:	90                   	nop
 1bc:	90                   	nop
 1bd:	90                   	nop
 1be:	90                   	nop
 1bf:	90                   	nop

000001c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 f0 00 00 00       	call   2c2 <open>
  if(fd < 0)
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 27                	js     200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	pushl  0xc(%ebp)
 1df:	89 c3                	mov    %eax,%ebx
 1e1:	50                   	push   %eax
 1e2:	e8 f3 00 00 00       	call   2da <fstat>
 1e7:	89 c6                	mov    %eax,%esi
  close(fd);
 1e9:	89 1c 24             	mov    %ebx,(%esp)
 1ec:	e8 b9 00 00 00       	call   2aa <close>
  return r;
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	89 f0                	mov    %esi,%eax
}
 1f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 205:	eb ef                	jmp    1f6 <stat+0x36>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	8d 42 d0             	lea    -0x30(%edx),%eax
 21d:	3c 09                	cmp    $0x9,%al
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
 224:	77 1f                	ja     245 <atoi+0x35>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 230:	8d 04 80             	lea    (%eax,%eax,4),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23a:	0f be 11             	movsbl (%ecx),%edx
 23d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 240:	80 fb 09             	cmp    $0x9,%bl
 243:	76 eb                	jbe    230 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 245:	5b                   	pop    %ebx
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	8b 5d 10             	mov    0x10(%ebp),%ebx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 14                	jle    276 <memmove+0x26>
 262:	31 d2                	xor    %edx,%edx
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 272:	39 da                	cmp    %ebx,%edx
 274:	75 f2                	jne    268 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5d                   	pop    %ebp
 279:	c3                   	ret    

0000027a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27a:	b8 01 00 00 00       	mov    $0x1,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <exit>:
SYSCALL(exit)
 282:	b8 02 00 00 00       	mov    $0x2,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <wait>:
SYSCALL(wait)
 28a:	b8 03 00 00 00       	mov    $0x3,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <pipe>:
SYSCALL(pipe)
 292:	b8 04 00 00 00       	mov    $0x4,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <read>:
SYSCALL(read)
 29a:	b8 05 00 00 00       	mov    $0x5,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <write>:
SYSCALL(write)
 2a2:	b8 10 00 00 00       	mov    $0x10,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <close>:
SYSCALL(close)
 2aa:	b8 15 00 00 00       	mov    $0x15,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <kill>:
SYSCALL(kill)
 2b2:	b8 06 00 00 00       	mov    $0x6,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <exec>:
SYSCALL(exec)
 2ba:	b8 07 00 00 00       	mov    $0x7,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <open>:
SYSCALL(open)
 2c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <mknod>:
SYSCALL(mknod)
 2ca:	b8 11 00 00 00       	mov    $0x11,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <unlink>:
SYSCALL(unlink)
 2d2:	b8 12 00 00 00       	mov    $0x12,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <fstat>:
SYSCALL(fstat)
 2da:	b8 08 00 00 00       	mov    $0x8,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <link>:
SYSCALL(link)
 2e2:	b8 13 00 00 00       	mov    $0x13,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mkdir>:
SYSCALL(mkdir)
 2ea:	b8 14 00 00 00       	mov    $0x14,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <chdir>:
SYSCALL(chdir)
 2f2:	b8 09 00 00 00       	mov    $0x9,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <dup>:
SYSCALL(dup)
 2fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <getpid>:
SYSCALL(getpid)
 302:	b8 0b 00 00 00       	mov    $0xb,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <memsize>:
SYSCALL(memsize)
 30a:	b8 16 00 00 00       	mov    $0x16,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <sbrk>:
SYSCALL(sbrk)
 312:	b8 0c 00 00 00       	mov    $0xc,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <sleep>:
SYSCALL(sleep)
 31a:	b8 0d 00 00 00       	mov    $0xd,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <uptime>:
SYSCALL(uptime)
 322:	b8 0e 00 00 00       	mov    $0xe,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <policy>:
SYSCALL(policy)
 32a:	b8 17 00 00 00       	mov    $0x17,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <set_cfs_priority>:
SYSCALL(set_cfs_priority)
 332:	b8 19 00 00 00       	mov    $0x19,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <set_ps_priority>:
SYSCALL(set_ps_priority)
 33a:	b8 18 00 00 00       	mov    $0x18,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <proc_info>:
SYSCALL(proc_info)
 342:	b8 1a 00 00 00       	mov    $0x1a,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    
 34a:	66 90                	xchg   %ax,%ax
 34c:	66 90                	xchg   %ax,%ax
 34e:	66 90                	xchg   %ax,%ax

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	89 c6                	mov    %eax,%esi
 358:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 35b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 35e:	85 db                	test   %ebx,%ebx
 360:	74 7e                	je     3e0 <printint+0x90>
 362:	89 d0                	mov    %edx,%eax
 364:	c1 e8 1f             	shr    $0x1f,%eax
 367:	84 c0                	test   %al,%al
 369:	74 75                	je     3e0 <printint+0x90>
    neg = 1;
    x = -xx;
 36b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 36d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 374:	f7 d8                	neg    %eax
 376:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 379:	31 ff                	xor    %edi,%edi
 37b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 37e:	89 ce                	mov    %ecx,%esi
 380:	eb 08                	jmp    38a <printint+0x3a>
 382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 388:	89 cf                	mov    %ecx,%edi
 38a:	31 d2                	xor    %edx,%edx
 38c:	8d 4f 01             	lea    0x1(%edi),%ecx
 38f:	f7 f6                	div    %esi
 391:	0f b6 92 18 07 00 00 	movzbl 0x718(%edx),%edx
  }while((x /= base) != 0);
 398:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 39a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 39d:	75 e9                	jne    388 <printint+0x38>
  if(neg)
 39f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3a2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3a5:	85 c0                	test   %eax,%eax
 3a7:	74 08                	je     3b1 <printint+0x61>
    buf[i++] = '-';
 3a9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3ae:	8d 4f 02             	lea    0x2(%edi),%ecx
 3b1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3b5:	8d 76 00             	lea    0x0(%esi),%esi
 3b8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3bb:	83 ec 04             	sub    $0x4,%esp
 3be:	83 ef 01             	sub    $0x1,%edi
 3c1:	6a 01                	push   $0x1
 3c3:	53                   	push   %ebx
 3c4:	56                   	push   %esi
 3c5:	88 45 d7             	mov    %al,-0x29(%ebp)
 3c8:	e8 d5 fe ff ff       	call   2a2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3cd:	83 c4 10             	add    $0x10,%esp
 3d0:	39 df                	cmp    %ebx,%edi
 3d2:	75 e4                	jne    3b8 <printint+0x68>
    putc(fd, buf[i]);
}
 3d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d7:	5b                   	pop    %ebx
 3d8:	5e                   	pop    %esi
 3d9:	5f                   	pop    %edi
 3da:	5d                   	pop    %ebp
 3db:	c3                   	ret    
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3e0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3e2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3e9:	eb 8b                	jmp    376 <printint+0x26>
 3eb:	90                   	nop
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3f9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3fc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3ff:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 402:	89 45 d0             	mov    %eax,-0x30(%ebp)
 405:	0f b6 1e             	movzbl (%esi),%ebx
 408:	83 c6 01             	add    $0x1,%esi
 40b:	84 db                	test   %bl,%bl
 40d:	0f 84 b0 00 00 00    	je     4c3 <printf+0xd3>
 413:	31 d2                	xor    %edx,%edx
 415:	eb 39                	jmp    450 <printf+0x60>
 417:	89 f6                	mov    %esi,%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 420:	83 f8 25             	cmp    $0x25,%eax
 423:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 426:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 42b:	74 18                	je     445 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 42d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 430:	83 ec 04             	sub    $0x4,%esp
 433:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 436:	6a 01                	push   $0x1
 438:	50                   	push   %eax
 439:	57                   	push   %edi
 43a:	e8 63 fe ff ff       	call   2a2 <write>
 43f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 442:	83 c4 10             	add    $0x10,%esp
 445:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 448:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 44c:	84 db                	test   %bl,%bl
 44e:	74 73                	je     4c3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 450:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 452:	0f be cb             	movsbl %bl,%ecx
 455:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 458:	74 c6                	je     420 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 45a:	83 fa 25             	cmp    $0x25,%edx
 45d:	75 e6                	jne    445 <printf+0x55>
      if(c == 'd'){
 45f:	83 f8 64             	cmp    $0x64,%eax
 462:	0f 84 f8 00 00 00    	je     560 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 468:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 46e:	83 f9 70             	cmp    $0x70,%ecx
 471:	74 5d                	je     4d0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 473:	83 f8 73             	cmp    $0x73,%eax
 476:	0f 84 84 00 00 00    	je     500 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 47c:	83 f8 63             	cmp    $0x63,%eax
 47f:	0f 84 ea 00 00 00    	je     56f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 485:	83 f8 25             	cmp    $0x25,%eax
 488:	0f 84 c2 00 00 00    	je     550 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 48e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 491:	83 ec 04             	sub    $0x4,%esp
 494:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 498:	6a 01                	push   $0x1
 49a:	50                   	push   %eax
 49b:	57                   	push   %edi
 49c:	e8 01 fe ff ff       	call   2a2 <write>
 4a1:	83 c4 0c             	add    $0xc,%esp
 4a4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4a7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4aa:	6a 01                	push   $0x1
 4ac:	50                   	push   %eax
 4ad:	57                   	push   %edi
 4ae:	83 c6 01             	add    $0x1,%esi
 4b1:	e8 ec fd ff ff       	call   2a2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4b6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ba:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4bd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4bf:	84 db                	test   %bl,%bl
 4c1:	75 8d                	jne    450 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c6:	5b                   	pop    %ebx
 4c7:	5e                   	pop    %esi
 4c8:	5f                   	pop    %edi
 4c9:	5d                   	pop    %ebp
 4ca:	c3                   	ret    
 4cb:	90                   	nop
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4d0:	83 ec 0c             	sub    $0xc,%esp
 4d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4d8:	6a 00                	push   $0x0
 4da:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4dd:	89 f8                	mov    %edi,%eax
 4df:	8b 13                	mov    (%ebx),%edx
 4e1:	e8 6a fe ff ff       	call   350 <printint>
        ap++;
 4e6:	89 d8                	mov    %ebx,%eax
 4e8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4eb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4ed:	83 c0 04             	add    $0x4,%eax
 4f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4f3:	e9 4d ff ff ff       	jmp    445 <printf+0x55>
 4f8:	90                   	nop
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 500:	8b 45 d0             	mov    -0x30(%ebp),%eax
 503:	8b 18                	mov    (%eax),%ebx
        ap++;
 505:	83 c0 04             	add    $0x4,%eax
 508:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 50b:	b8 10 07 00 00       	mov    $0x710,%eax
 510:	85 db                	test   %ebx,%ebx
 512:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 515:	0f b6 03             	movzbl (%ebx),%eax
 518:	84 c0                	test   %al,%al
 51a:	74 23                	je     53f <printf+0x14f>
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 520:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 523:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 526:	83 ec 04             	sub    $0x4,%esp
 529:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 52b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52e:	50                   	push   %eax
 52f:	57                   	push   %edi
 530:	e8 6d fd ff ff       	call   2a2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 535:	0f b6 03             	movzbl (%ebx),%eax
 538:	83 c4 10             	add    $0x10,%esp
 53b:	84 c0                	test   %al,%al
 53d:	75 e1                	jne    520 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 53f:	31 d2                	xor    %edx,%edx
 541:	e9 ff fe ff ff       	jmp    445 <printf+0x55>
 546:	8d 76 00             	lea    0x0(%esi),%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 550:	83 ec 04             	sub    $0x4,%esp
 553:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 556:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 559:	6a 01                	push   $0x1
 55b:	e9 4c ff ff ff       	jmp    4ac <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	b9 0a 00 00 00       	mov    $0xa,%ecx
 568:	6a 01                	push   $0x1
 56a:	e9 6b ff ff ff       	jmp    4da <printf+0xea>
 56f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 572:	83 ec 04             	sub    $0x4,%esp
 575:	8b 03                	mov    (%ebx),%eax
 577:	6a 01                	push   $0x1
 579:	88 45 e4             	mov    %al,-0x1c(%ebp)
 57c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 57f:	50                   	push   %eax
 580:	57                   	push   %edi
 581:	e8 1c fd ff ff       	call   2a2 <write>
 586:	e9 5b ff ff ff       	jmp    4e6 <printf+0xf6>
 58b:	66 90                	xchg   %ax,%ax
 58d:	66 90                	xchg   %ax,%ax
 58f:	90                   	nop

00000590 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 590:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 591:	a1 b0 09 00 00       	mov    0x9b0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 596:	89 e5                	mov    %esp,%ebp
 598:	57                   	push   %edi
 599:	56                   	push   %esi
 59a:	53                   	push   %ebx
 59b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5a0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a3:	39 c8                	cmp    %ecx,%eax
 5a5:	73 19                	jae    5c0 <free+0x30>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 5b0:	39 d1                	cmp    %edx,%ecx
 5b2:	72 1c                	jb     5d0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b4:	39 d0                	cmp    %edx,%eax
 5b6:	73 18                	jae    5d0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ba:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5bc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5be:	72 f0                	jb     5b0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c0:	39 d0                	cmp    %edx,%eax
 5c2:	72 f4                	jb     5b8 <free+0x28>
 5c4:	39 d1                	cmp    %edx,%ecx
 5c6:	73 f0                	jae    5b8 <free+0x28>
 5c8:	90                   	nop
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 5d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5d6:	39 d7                	cmp    %edx,%edi
 5d8:	74 19                	je     5f3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5dd:	8b 50 04             	mov    0x4(%eax),%edx
 5e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5e3:	39 f1                	cmp    %esi,%ecx
 5e5:	74 23                	je     60a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5e7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5e9:	a3 b0 09 00 00       	mov    %eax,0x9b0
}
 5ee:	5b                   	pop    %ebx
 5ef:	5e                   	pop    %esi
 5f0:	5f                   	pop    %edi
 5f1:	5d                   	pop    %ebp
 5f2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5f3:	03 72 04             	add    0x4(%edx),%esi
 5f6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5f9:	8b 10                	mov    (%eax),%edx
 5fb:	8b 12                	mov    (%edx),%edx
 5fd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 600:	8b 50 04             	mov    0x4(%eax),%edx
 603:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 606:	39 f1                	cmp    %esi,%ecx
 608:	75 dd                	jne    5e7 <free+0x57>
    p->s.size += bp->s.size;
 60a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 60d:	a3 b0 09 00 00       	mov    %eax,0x9b0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 612:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 615:	8b 53 f8             	mov    -0x8(%ebx),%edx
 618:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 61a:	5b                   	pop    %ebx
 61b:	5e                   	pop    %esi
 61c:	5f                   	pop    %edi
 61d:	5d                   	pop    %ebp
 61e:	c3                   	ret    
 61f:	90                   	nop

00000620 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 629:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 62c:	8b 15 b0 09 00 00    	mov    0x9b0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 632:	8d 78 07             	lea    0x7(%eax),%edi
 635:	c1 ef 03             	shr    $0x3,%edi
 638:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 63b:	85 d2                	test   %edx,%edx
 63d:	0f 84 a3 00 00 00    	je     6e6 <malloc+0xc6>
 643:	8b 02                	mov    (%edx),%eax
 645:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 648:	39 cf                	cmp    %ecx,%edi
 64a:	76 74                	jbe    6c0 <malloc+0xa0>
 64c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 652:	be 00 10 00 00       	mov    $0x1000,%esi
 657:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 65e:	0f 43 f7             	cmovae %edi,%esi
 661:	ba 00 80 00 00       	mov    $0x8000,%edx
 666:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 66c:	0f 46 da             	cmovbe %edx,%ebx
 66f:	eb 10                	jmp    681 <malloc+0x61>
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 678:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 67a:	8b 48 04             	mov    0x4(%eax),%ecx
 67d:	39 cf                	cmp    %ecx,%edi
 67f:	76 3f                	jbe    6c0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 681:	39 05 b0 09 00 00    	cmp    %eax,0x9b0
 687:	89 c2                	mov    %eax,%edx
 689:	75 ed                	jne    678 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 68b:	83 ec 0c             	sub    $0xc,%esp
 68e:	53                   	push   %ebx
 68f:	e8 7e fc ff ff       	call   312 <sbrk>
  if(p == (char*)-1)
 694:	83 c4 10             	add    $0x10,%esp
 697:	83 f8 ff             	cmp    $0xffffffff,%eax
 69a:	74 1c                	je     6b8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 69c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 69f:	83 ec 0c             	sub    $0xc,%esp
 6a2:	83 c0 08             	add    $0x8,%eax
 6a5:	50                   	push   %eax
 6a6:	e8 e5 fe ff ff       	call   590 <free>
  return freep;
 6ab:	8b 15 b0 09 00 00    	mov    0x9b0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6b1:	83 c4 10             	add    $0x10,%esp
 6b4:	85 d2                	test   %edx,%edx
 6b6:	75 c0                	jne    678 <malloc+0x58>
        return 0;
 6b8:	31 c0                	xor    %eax,%eax
 6ba:	eb 1c                	jmp    6d8 <malloc+0xb8>
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6c0:	39 cf                	cmp    %ecx,%edi
 6c2:	74 1c                	je     6e0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6c4:	29 f9                	sub    %edi,%ecx
 6c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6cc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 6cf:	89 15 b0 09 00 00    	mov    %edx,0x9b0
      return (void*)(p + 1);
 6d5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6db:	5b                   	pop    %ebx
 6dc:	5e                   	pop    %esi
 6dd:	5f                   	pop    %edi
 6de:	5d                   	pop    %ebp
 6df:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6e0:	8b 08                	mov    (%eax),%ecx
 6e2:	89 0a                	mov    %ecx,(%edx)
 6e4:	eb e9                	jmp    6cf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6e6:	c7 05 b0 09 00 00 b4 	movl   $0x9b4,0x9b0
 6ed:	09 00 00 
 6f0:	c7 05 b4 09 00 00 b4 	movl   $0x9b4,0x9b4
 6f7:	09 00 00 
    base.s.size = 0;
 6fa:	b8 b4 09 00 00       	mov    $0x9b4,%eax
 6ff:	c7 05 b8 09 00 00 00 	movl   $0x0,0x9b8
 706:	00 00 00 
 709:	e9 3e ff ff ff       	jmp    64c <malloc+0x2c>
