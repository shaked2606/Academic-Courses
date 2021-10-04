
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	bf 01 00 00 00       	mov    $0x1,%edi
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 43                	jle    69 <main+0x69>
  26:	8d 76 00             	lea    0x0(%esi),%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 00 03 00 00       	call   33a <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 14                	js     55 <main+0x55>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit(0);
  4b:	83 ec 0c             	sub    $0xc,%esp
  4e:	6a 00                	push   $0x0
  50:	e8 7d 02 00 00       	call   2d2 <exit>
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  55:	50                   	push   %eax
  56:	ff 33                	pushl  (%ebx)
  58:	68 77 07 00 00       	push   $0x777
  5d:	6a 02                	push   $0x2
  5f:	e8 dc 03 00 00       	call   440 <printf>
      break;
  64:	83 c4 10             	add    $0x10,%esp
  67:	eb e2                	jmp    4b <main+0x4b>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
  69:	52                   	push   %edx
  6a:	52                   	push   %edx
  6b:	68 60 07 00 00       	push   $0x760
  70:	6a 02                	push   $0x2
  72:	e8 c9 03 00 00       	call   440 <printf>
    exit(1);
  77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7e:	e8 4f 02 00 00       	call   2d2 <exit>
  83:	66 90                	xchg   %ax,%ax
  85:	66 90                	xchg   %ax,%ax
  87:	66 90                	xchg   %ax,%ax
  89:	66 90                	xchg   %ax,%ax
  8b:	66 90                	xchg   %ax,%ax
  8d:	66 90                	xchg   %ax,%ax
  8f:	90                   	nop

00000090 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  9a:	89 c2                	mov    %eax,%edx
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  a0:	83 c1 01             	add    $0x1,%ecx
  a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  a7:	83 c2 01             	add    $0x1,%edx
  aa:	84 db                	test   %bl,%bl
  ac:	88 5a ff             	mov    %bl,-0x1(%edx)
  af:	75 ef                	jne    a0 <strcpy+0x10>
    ;
  return os;
}
  b1:	5b                   	pop    %ebx
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    
  b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	56                   	push   %esi
  c4:	53                   	push   %ebx
  c5:	8b 55 08             	mov    0x8(%ebp),%edx
  c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  cb:	0f b6 02             	movzbl (%edx),%eax
  ce:	0f b6 19             	movzbl (%ecx),%ebx
  d1:	84 c0                	test   %al,%al
  d3:	75 1e                	jne    f3 <strcmp+0x33>
  d5:	eb 29                	jmp    100 <strcmp+0x40>
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  e0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  e6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  ed:	84 c0                	test   %al,%al
  ef:	74 0f                	je     100 <strcmp+0x40>
  f1:	89 f1                	mov    %esi,%ecx
  f3:	38 d8                	cmp    %bl,%al
  f5:	74 e9                	je     e0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  f7:	29 d8                	sub    %ebx,%eax
}
  f9:	5b                   	pop    %ebx
  fa:	5e                   	pop    %esi
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 100:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 102:	29 d8                	sub    %ebx,%eax
}
 104:	5b                   	pop    %ebx
 105:	5e                   	pop    %esi
 106:	5d                   	pop    %ebp
 107:	c3                   	ret    
 108:	90                   	nop
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000110 <strlen>:

uint
strlen(const char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 116:	80 39 00             	cmpb   $0x0,(%ecx)
 119:	74 12                	je     12d <strlen+0x1d>
 11b:	31 d2                	xor    %edx,%edx
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	83 c2 01             	add    $0x1,%edx
 123:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 127:	89 d0                	mov    %edx,%eax
 129:	75 f5                	jne    120 <strlen+0x10>
    ;
  return n;
}
 12b:	5d                   	pop    %ebp
 12c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 12d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    
 131:	eb 0d                	jmp    140 <memset>
 133:	90                   	nop
 134:	90                   	nop
 135:	90                   	nop
 136:	90                   	nop
 137:	90                   	nop
 138:	90                   	nop
 139:	90                   	nop
 13a:	90                   	nop
 13b:	90                   	nop
 13c:	90                   	nop
 13d:	90                   	nop
 13e:	90                   	nop
 13f:	90                   	nop

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld    
 150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 152:	89 d0                	mov    %edx,%eax
 154:	5f                   	pop    %edi
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	89 f6                	mov    %esi,%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	53                   	push   %ebx
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	74 1d                	je     18e <strchr+0x2e>
    if(*s == c)
 171:	38 d3                	cmp    %dl,%bl
 173:	89 d9                	mov    %ebx,%ecx
 175:	75 0d                	jne    184 <strchr+0x24>
 177:	eb 17                	jmp    190 <strchr+0x30>
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 180:	38 ca                	cmp    %cl,%dl
 182:	74 0c                	je     190 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 184:	83 c0 01             	add    $0x1,%eax
 187:	0f b6 10             	movzbl (%eax),%edx
 18a:	84 d2                	test   %dl,%dl
 18c:	75 f2                	jne    180 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 18e:	31 c0                	xor    %eax,%eax
}
 190:	5b                   	pop    %ebx
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
 1a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 1ab:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ae:	eb 29                	jmp    1d9 <gets+0x39>
    cc = read(0, &c, 1);
 1b0:	83 ec 04             	sub    $0x4,%esp
 1b3:	6a 01                	push   $0x1
 1b5:	57                   	push   %edi
 1b6:	6a 00                	push   $0x0
 1b8:	e8 2d 01 00 00       	call   2ea <read>
    if(cc < 1)
 1bd:	83 c4 10             	add    $0x10,%esp
 1c0:	85 c0                	test   %eax,%eax
 1c2:	7e 1d                	jle    1e1 <gets+0x41>
      break;
    buf[i++] = c;
 1c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c8:	8b 55 08             	mov    0x8(%ebp),%edx
 1cb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 1cd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 1cf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1d3:	74 1b                	je     1f0 <gets+0x50>
 1d5:	3c 0d                	cmp    $0xd,%al
 1d7:	74 17                	je     1f0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d9:	8d 5e 01             	lea    0x1(%esi),%ebx
 1dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1df:	7c cf                	jl     1b0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1eb:	5b                   	pop    %ebx
 1ec:	5e                   	pop    %esi
 1ed:	5f                   	pop    %edi
 1ee:	5d                   	pop    %ebp
 1ef:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fc:	5b                   	pop    %ebx
 1fd:	5e                   	pop    %esi
 1fe:	5f                   	pop    %edi
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    
 201:	eb 0d                	jmp    210 <stat>
 203:	90                   	nop
 204:	90                   	nop
 205:	90                   	nop
 206:	90                   	nop
 207:	90                   	nop
 208:	90                   	nop
 209:	90                   	nop
 20a:	90                   	nop
 20b:	90                   	nop
 20c:	90                   	nop
 20d:	90                   	nop
 20e:	90                   	nop
 20f:	90                   	nop

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 f0 00 00 00       	call   312 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 f3 00 00 00       	call   32a <fstat>
 237:	89 c6                	mov    %eax,%esi
  close(fd);
 239:	89 1c 24             	mov    %ebx,(%esp)
 23c:	e8 b9 00 00 00       	call   2fa <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
 244:	89 f0                	mov    %esi,%eax
}
 246:	8d 65 f8             	lea    -0x8(%ebp),%esp
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 250:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 255:	eb ef                	jmp    246 <stat+0x36>
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
 274:	77 1f                	ja     295 <atoi+0x35>
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 280:	8d 04 80             	lea    (%eax,%eax,4),%eax
 283:	83 c1 01             	add    $0x1,%ecx
 286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28a:	0f be 11             	movsbl (%ecx),%edx
 28d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 295:	5b                   	pop    %ebx
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 db                	test   %ebx,%ebx
 2b0:	7e 14                	jle    2c6 <memmove+0x26>
 2b2:	31 d2                	xor    %edx,%edx
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2bf:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c2:	39 da                	cmp    %ebx,%edx
 2c4:	75 f2                	jne    2b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5d                   	pop    %ebp
 2c9:	c3                   	ret    

000002ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ca:	b8 01 00 00 00       	mov    $0x1,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <exit>:
SYSCALL(exit)
 2d2:	b8 02 00 00 00       	mov    $0x2,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <wait>:
SYSCALL(wait)
 2da:	b8 03 00 00 00       	mov    $0x3,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <pipe>:
SYSCALL(pipe)
 2e2:	b8 04 00 00 00       	mov    $0x4,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <read>:
SYSCALL(read)
 2ea:	b8 05 00 00 00       	mov    $0x5,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <write>:
SYSCALL(write)
 2f2:	b8 10 00 00 00       	mov    $0x10,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <close>:
SYSCALL(close)
 2fa:	b8 15 00 00 00       	mov    $0x15,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <kill>:
SYSCALL(kill)
 302:	b8 06 00 00 00       	mov    $0x6,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <exec>:
SYSCALL(exec)
 30a:	b8 07 00 00 00       	mov    $0x7,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <open>:
SYSCALL(open)
 312:	b8 0f 00 00 00       	mov    $0xf,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mknod>:
SYSCALL(mknod)
 31a:	b8 11 00 00 00       	mov    $0x11,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <unlink>:
SYSCALL(unlink)
 322:	b8 12 00 00 00       	mov    $0x12,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <fstat>:
SYSCALL(fstat)
 32a:	b8 08 00 00 00       	mov    $0x8,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <link>:
SYSCALL(link)
 332:	b8 13 00 00 00       	mov    $0x13,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <mkdir>:
SYSCALL(mkdir)
 33a:	b8 14 00 00 00       	mov    $0x14,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <chdir>:
SYSCALL(chdir)
 342:	b8 09 00 00 00       	mov    $0x9,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <dup>:
SYSCALL(dup)
 34a:	b8 0a 00 00 00       	mov    $0xa,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <getpid>:
SYSCALL(getpid)
 352:	b8 0b 00 00 00       	mov    $0xb,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <memsize>:
SYSCALL(memsize)
 35a:	b8 16 00 00 00       	mov    $0x16,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <sbrk>:
SYSCALL(sbrk)
 362:	b8 0c 00 00 00       	mov    $0xc,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <sleep>:
SYSCALL(sleep)
 36a:	b8 0d 00 00 00       	mov    $0xd,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <uptime>:
SYSCALL(uptime)
 372:	b8 0e 00 00 00       	mov    $0xe,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <policy>:
SYSCALL(policy)
 37a:	b8 17 00 00 00       	mov    $0x17,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <set_cfs_priority>:
SYSCALL(set_cfs_priority)
 382:	b8 19 00 00 00       	mov    $0x19,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <set_ps_priority>:
SYSCALL(set_ps_priority)
 38a:	b8 18 00 00 00       	mov    $0x18,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <proc_info>:
SYSCALL(proc_info)
 392:	b8 1a 00 00 00       	mov    $0x1a,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	89 c6                	mov    %eax,%esi
 3a8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	74 7e                	je     430 <printint+0x90>
 3b2:	89 d0                	mov    %edx,%eax
 3b4:	c1 e8 1f             	shr    $0x1f,%eax
 3b7:	84 c0                	test   %al,%al
 3b9:	74 75                	je     430 <printint+0x90>
    neg = 1;
    x = -xx;
 3bb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3bd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 3c4:	f7 d8                	neg    %eax
 3c6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3c9:	31 ff                	xor    %edi,%edi
 3cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3ce:	89 ce                	mov    %ecx,%esi
 3d0:	eb 08                	jmp    3da <printint+0x3a>
 3d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3d8:	89 cf                	mov    %ecx,%edi
 3da:	31 d2                	xor    %edx,%edx
 3dc:	8d 4f 01             	lea    0x1(%edi),%ecx
 3df:	f7 f6                	div    %esi
 3e1:	0f b6 92 9c 07 00 00 	movzbl 0x79c(%edx),%edx
  }while((x /= base) != 0);
 3e8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3ea:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3ed:	75 e9                	jne    3d8 <printint+0x38>
  if(neg)
 3ef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3f2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 3f5:	85 c0                	test   %eax,%eax
 3f7:	74 08                	je     401 <printint+0x61>
    buf[i++] = '-';
 3f9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3fe:	8d 4f 02             	lea    0x2(%edi),%ecx
 401:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 405:	8d 76 00             	lea    0x0(%esi),%esi
 408:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 40b:	83 ec 04             	sub    $0x4,%esp
 40e:	83 ef 01             	sub    $0x1,%edi
 411:	6a 01                	push   $0x1
 413:	53                   	push   %ebx
 414:	56                   	push   %esi
 415:	88 45 d7             	mov    %al,-0x29(%ebp)
 418:	e8 d5 fe ff ff       	call   2f2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 41d:	83 c4 10             	add    $0x10,%esp
 420:	39 df                	cmp    %ebx,%edi
 422:	75 e4                	jne    408 <printint+0x68>
    putc(fd, buf[i]);
}
 424:	8d 65 f4             	lea    -0xc(%ebp),%esp
 427:	5b                   	pop    %ebx
 428:	5e                   	pop    %esi
 429:	5f                   	pop    %edi
 42a:	5d                   	pop    %ebp
 42b:	c3                   	ret    
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 430:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 432:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 439:	eb 8b                	jmp    3c6 <printint+0x26>
 43b:	90                   	nop
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000440 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 446:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 449:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 44c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 44f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 452:	89 45 d0             	mov    %eax,-0x30(%ebp)
 455:	0f b6 1e             	movzbl (%esi),%ebx
 458:	83 c6 01             	add    $0x1,%esi
 45b:	84 db                	test   %bl,%bl
 45d:	0f 84 b0 00 00 00    	je     513 <printf+0xd3>
 463:	31 d2                	xor    %edx,%edx
 465:	eb 39                	jmp    4a0 <printf+0x60>
 467:	89 f6                	mov    %esi,%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 470:	83 f8 25             	cmp    $0x25,%eax
 473:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 476:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 47b:	74 18                	je     495 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 47d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 480:	83 ec 04             	sub    $0x4,%esp
 483:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 486:	6a 01                	push   $0x1
 488:	50                   	push   %eax
 489:	57                   	push   %edi
 48a:	e8 63 fe ff ff       	call   2f2 <write>
 48f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 492:	83 c4 10             	add    $0x10,%esp
 495:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 498:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 49c:	84 db                	test   %bl,%bl
 49e:	74 73                	je     513 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 4a0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4a2:	0f be cb             	movsbl %bl,%ecx
 4a5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4a8:	74 c6                	je     470 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4aa:	83 fa 25             	cmp    $0x25,%edx
 4ad:	75 e6                	jne    495 <printf+0x55>
      if(c == 'd'){
 4af:	83 f8 64             	cmp    $0x64,%eax
 4b2:	0f 84 f8 00 00 00    	je     5b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4b8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4be:	83 f9 70             	cmp    $0x70,%ecx
 4c1:	74 5d                	je     520 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4c3:	83 f8 73             	cmp    $0x73,%eax
 4c6:	0f 84 84 00 00 00    	je     550 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4cc:	83 f8 63             	cmp    $0x63,%eax
 4cf:	0f 84 ea 00 00 00    	je     5bf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4d5:	83 f8 25             	cmp    $0x25,%eax
 4d8:	0f 84 c2 00 00 00    	je     5a0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4de:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4e1:	83 ec 04             	sub    $0x4,%esp
 4e4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4e8:	6a 01                	push   $0x1
 4ea:	50                   	push   %eax
 4eb:	57                   	push   %edi
 4ec:	e8 01 fe ff ff       	call   2f2 <write>
 4f1:	83 c4 0c             	add    $0xc,%esp
 4f4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4f7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4fa:	6a 01                	push   $0x1
 4fc:	50                   	push   %eax
 4fd:	57                   	push   %edi
 4fe:	83 c6 01             	add    $0x1,%esi
 501:	e8 ec fd ff ff       	call   2f2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 506:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 50a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 50d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 50f:	84 db                	test   %bl,%bl
 511:	75 8d                	jne    4a0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 513:	8d 65 f4             	lea    -0xc(%ebp),%esp
 516:	5b                   	pop    %ebx
 517:	5e                   	pop    %esi
 518:	5f                   	pop    %edi
 519:	5d                   	pop    %ebp
 51a:	c3                   	ret    
 51b:	90                   	nop
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 520:	83 ec 0c             	sub    $0xc,%esp
 523:	b9 10 00 00 00       	mov    $0x10,%ecx
 528:	6a 00                	push   $0x0
 52a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 52d:	89 f8                	mov    %edi,%eax
 52f:	8b 13                	mov    (%ebx),%edx
 531:	e8 6a fe ff ff       	call   3a0 <printint>
        ap++;
 536:	89 d8                	mov    %ebx,%eax
 538:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 53b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 53d:	83 c0 04             	add    $0x4,%eax
 540:	89 45 d0             	mov    %eax,-0x30(%ebp)
 543:	e9 4d ff ff ff       	jmp    495 <printf+0x55>
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 550:	8b 45 d0             	mov    -0x30(%ebp),%eax
 553:	8b 18                	mov    (%eax),%ebx
        ap++;
 555:	83 c0 04             	add    $0x4,%eax
 558:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 55b:	b8 93 07 00 00       	mov    $0x793,%eax
 560:	85 db                	test   %ebx,%ebx
 562:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 565:	0f b6 03             	movzbl (%ebx),%eax
 568:	84 c0                	test   %al,%al
 56a:	74 23                	je     58f <printf+0x14f>
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 570:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 573:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 576:	83 ec 04             	sub    $0x4,%esp
 579:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 57b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 57e:	50                   	push   %eax
 57f:	57                   	push   %edi
 580:	e8 6d fd ff ff       	call   2f2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 585:	0f b6 03             	movzbl (%ebx),%eax
 588:	83 c4 10             	add    $0x10,%esp
 58b:	84 c0                	test   %al,%al
 58d:	75 e1                	jne    570 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 58f:	31 d2                	xor    %edx,%edx
 591:	e9 ff fe ff ff       	jmp    495 <printf+0x55>
 596:	8d 76 00             	lea    0x0(%esi),%esi
 599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5a9:	6a 01                	push   $0x1
 5ab:	e9 4c ff ff ff       	jmp    4fc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5b0:	83 ec 0c             	sub    $0xc,%esp
 5b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5b8:	6a 01                	push   $0x1
 5ba:	e9 6b ff ff ff       	jmp    52a <printf+0xea>
 5bf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5c2:	83 ec 04             	sub    $0x4,%esp
 5c5:	8b 03                	mov    (%ebx),%eax
 5c7:	6a 01                	push   $0x1
 5c9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 5cc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5cf:	50                   	push   %eax
 5d0:	57                   	push   %edi
 5d1:	e8 1c fd ff ff       	call   2f2 <write>
 5d6:	e9 5b ff ff ff       	jmp    536 <printf+0xf6>
 5db:	66 90                	xchg   %ax,%ax
 5dd:	66 90                	xchg   %ax,%ax
 5df:	90                   	nop

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 40 0a 00 00       	mov    0xa40,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ee:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5f0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f3:	39 c8                	cmp    %ecx,%eax
 5f5:	73 19                	jae    610 <free+0x30>
 5f7:	89 f6                	mov    %esi,%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 600:	39 d1                	cmp    %edx,%ecx
 602:	72 1c                	jb     620 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 604:	39 d0                	cmp    %edx,%eax
 606:	73 18                	jae    620 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 608:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60e:	72 f0                	jb     600 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 610:	39 d0                	cmp    %edx,%eax
 612:	72 f4                	jb     608 <free+0x28>
 614:	39 d1                	cmp    %edx,%ecx
 616:	73 f0                	jae    608 <free+0x28>
 618:	90                   	nop
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 620:	8b 73 fc             	mov    -0x4(%ebx),%esi
 623:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 626:	39 d7                	cmp    %edx,%edi
 628:	74 19                	je     643 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 62a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 62d:	8b 50 04             	mov    0x4(%eax),%edx
 630:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 633:	39 f1                	cmp    %esi,%ecx
 635:	74 23                	je     65a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 637:	89 08                	mov    %ecx,(%eax)
  freep = p;
 639:	a3 40 0a 00 00       	mov    %eax,0xa40
}
 63e:	5b                   	pop    %ebx
 63f:	5e                   	pop    %esi
 640:	5f                   	pop    %edi
 641:	5d                   	pop    %ebp
 642:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 643:	03 72 04             	add    0x4(%edx),%esi
 646:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 649:	8b 10                	mov    (%eax),%edx
 64b:	8b 12                	mov    (%edx),%edx
 64d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 650:	8b 50 04             	mov    0x4(%eax),%edx
 653:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 656:	39 f1                	cmp    %esi,%ecx
 658:	75 dd                	jne    637 <free+0x57>
    p->s.size += bp->s.size;
 65a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 65d:	a3 40 0a 00 00       	mov    %eax,0xa40
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 662:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 665:	8b 53 f8             	mov    -0x8(%ebx),%edx
 668:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 66a:	5b                   	pop    %ebx
 66b:	5e                   	pop    %esi
 66c:	5f                   	pop    %edi
 66d:	5d                   	pop    %ebp
 66e:	c3                   	ret    
 66f:	90                   	nop

00000670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 679:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 67c:	8b 15 40 0a 00 00    	mov    0xa40,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 682:	8d 78 07             	lea    0x7(%eax),%edi
 685:	c1 ef 03             	shr    $0x3,%edi
 688:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 68b:	85 d2                	test   %edx,%edx
 68d:	0f 84 a3 00 00 00    	je     736 <malloc+0xc6>
 693:	8b 02                	mov    (%edx),%eax
 695:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 698:	39 cf                	cmp    %ecx,%edi
 69a:	76 74                	jbe    710 <malloc+0xa0>
 69c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6a2:	be 00 10 00 00       	mov    $0x1000,%esi
 6a7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 6ae:	0f 43 f7             	cmovae %edi,%esi
 6b1:	ba 00 80 00 00       	mov    $0x8000,%edx
 6b6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 6bc:	0f 46 da             	cmovbe %edx,%ebx
 6bf:	eb 10                	jmp    6d1 <malloc+0x61>
 6c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ca:	8b 48 04             	mov    0x4(%eax),%ecx
 6cd:	39 cf                	cmp    %ecx,%edi
 6cf:	76 3f                	jbe    710 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6d1:	39 05 40 0a 00 00    	cmp    %eax,0xa40
 6d7:	89 c2                	mov    %eax,%edx
 6d9:	75 ed                	jne    6c8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6db:	83 ec 0c             	sub    $0xc,%esp
 6de:	53                   	push   %ebx
 6df:	e8 7e fc ff ff       	call   362 <sbrk>
  if(p == (char*)-1)
 6e4:	83 c4 10             	add    $0x10,%esp
 6e7:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ea:	74 1c                	je     708 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6ec:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6ef:	83 ec 0c             	sub    $0xc,%esp
 6f2:	83 c0 08             	add    $0x8,%eax
 6f5:	50                   	push   %eax
 6f6:	e8 e5 fe ff ff       	call   5e0 <free>
  return freep;
 6fb:	8b 15 40 0a 00 00    	mov    0xa40,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 701:	83 c4 10             	add    $0x10,%esp
 704:	85 d2                	test   %edx,%edx
 706:	75 c0                	jne    6c8 <malloc+0x58>
        return 0;
 708:	31 c0                	xor    %eax,%eax
 70a:	eb 1c                	jmp    728 <malloc+0xb8>
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 710:	39 cf                	cmp    %ecx,%edi
 712:	74 1c                	je     730 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 714:	29 f9                	sub    %edi,%ecx
 716:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 719:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 71c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 71f:	89 15 40 0a 00 00    	mov    %edx,0xa40
      return (void*)(p + 1);
 725:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 728:	8d 65 f4             	lea    -0xc(%ebp),%esp
 72b:	5b                   	pop    %ebx
 72c:	5e                   	pop    %esi
 72d:	5f                   	pop    %edi
 72e:	5d                   	pop    %ebp
 72f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 730:	8b 08                	mov    (%eax),%ecx
 732:	89 0a                	mov    %ecx,(%edx)
 734:	eb e9                	jmp    71f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 736:	c7 05 40 0a 00 00 44 	movl   $0xa44,0xa40
 73d:	0a 00 00 
 740:	c7 05 44 0a 00 00 44 	movl   $0xa44,0xa44
 747:	0a 00 00 
    base.s.size = 0;
 74a:	b8 44 0a 00 00       	mov    $0xa44,%eax
 74f:	c7 05 48 0a 00 00 00 	movl   $0x0,0xa48
 756:	00 00 00 
 759:	e9 3e ff ff ff       	jmp    69c <malloc+0x2c>
