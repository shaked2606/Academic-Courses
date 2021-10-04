
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

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
  forktest();
  11:	e8 3a 00 00 00       	call   50 <forktest>
  exit(0);
  16:	83 ec 0c             	sub    $0xc,%esp
  19:	6a 00                	push   $0x0
  1b:	e8 b2 03 00 00       	call   3d2 <exit>

00000020 <printf>:

#define N  1000

void
printf(int fd, const char *s, ...)
{
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	53                   	push   %ebx
  24:	83 ec 10             	sub    $0x10,%esp
  27:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  2a:	53                   	push   %ebx
  2b:	e8 e0 01 00 00       	call   210 <strlen>
  30:	83 c4 0c             	add    $0xc,%esp
  33:	50                   	push   %eax
  34:	53                   	push   %ebx
  35:	ff 75 08             	pushl  0x8(%ebp)
  38:	e8 b5 03 00 00       	call   3f2 <write>
}
  3d:	83 c4 10             	add    $0x10,%esp
  40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  43:	c9                   	leave  
  44:	c3                   	ret    
  45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000050 <forktest>:

void
forktest(void)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  int n, pid, status;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  55:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
}

void
forktest(void)
{
  57:	83 ec 1c             	sub    $0x1c,%esp
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
  5a:	68 9c 04 00 00       	push   $0x49c
  5f:	e8 ac 01 00 00       	call   210 <strlen>
  64:	83 c4 0c             	add    $0xc,%esp
  67:	50                   	push   %eax
  68:	68 9c 04 00 00       	push   $0x49c
  6d:	6a 01                	push   $0x1
  6f:	e8 7e 03 00 00       	call   3f2 <write>
  74:	83 c4 10             	add    $0x10,%esp
  77:	eb 18                	jmp    91 <forktest+0x41>
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
  80:	0f 84 a3 00 00 00    	je     129 <forktest+0xd9>
{
  int n, pid, status;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  86:	83 c3 01             	add    $0x1,%ebx
  89:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  8f:	74 6f                	je     100 <forktest+0xb0>
    pid = fork();
  91:	e8 34 03 00 00       	call   3ca <fork>
    if(pid < 0)
  96:	85 c0                	test   %eax,%eax
  98:	79 e6                	jns    80 <forktest+0x30>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
  9a:	85 db                	test   %ebx,%ebx
  9c:	8d 75 f4             	lea    -0xc(%ebp),%esi
  9f:	74 1c                	je     bd <forktest+0x6d>
  a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(wait(&status) < 0){
  a8:	83 ec 0c             	sub    $0xc,%esp
  ab:	56                   	push   %esi
  ac:	e8 29 03 00 00       	call   3da <wait>
  b1:	83 c4 10             	add    $0x10,%esp
  b4:	85 c0                	test   %eax,%eax
  b6:	78 7b                	js     133 <forktest+0xe3>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
  b8:	83 eb 01             	sub    $0x1,%ebx
  bb:	75 eb                	jne    a8 <forktest+0x58>
      printf(1, "wait stopped early\n");
      exit(1);
    }
  }

  if(wait(&status) != -1){
  bd:	83 ec 0c             	sub    $0xc,%esp
  c0:	56                   	push   %esi
  c1:	e8 14 03 00 00       	call   3da <wait>
  c6:	83 c4 10             	add    $0x10,%esp
  c9:	83 f8 ff             	cmp    $0xffffffff,%eax
  cc:	0f 85 8a 00 00 00    	jne    15c <forktest+0x10c>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
  d2:	83 ec 0c             	sub    $0xc,%esp
  d5:	68 ce 04 00 00       	push   $0x4ce
  da:	e8 31 01 00 00       	call   210 <strlen>
  df:	83 c4 0c             	add    $0xc,%esp
  e2:	50                   	push   %eax
  e3:	68 ce 04 00 00       	push   $0x4ce
  e8:	6a 01                	push   $0x1
  ea:	e8 03 03 00 00       	call   3f2 <write>
    printf(1, "wait got too many\n");
    exit(1);
  }

  printf(1, "fork test OK\n");
}
  ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
  f2:	5b                   	pop    %ebx
  f3:	5e                   	pop    %esi
  f4:	5d                   	pop    %ebp
  f5:	c3                   	ret    
  f6:	8d 76 00             	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
 100:	83 ec 0c             	sub    $0xc,%esp
 103:	68 dc 04 00 00       	push   $0x4dc
 108:	e8 03 01 00 00       	call   210 <strlen>
 10d:	83 c4 0c             	add    $0xc,%esp
 110:	50                   	push   %eax
 111:	68 dc 04 00 00       	push   $0x4dc
 116:	6a 01                	push   $0x1
 118:	e8 d5 02 00 00       	call   3f2 <write>
      exit(0);
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
 11d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 124:	e8 a9 02 00 00       	call   3d2 <exit>
  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit(0);
 129:	83 ec 0c             	sub    $0xc,%esp
 12c:	6a 00                	push   $0x0
 12e:	e8 9f 02 00 00       	call   3d2 <exit>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
 133:	83 ec 0c             	sub    $0xc,%esp
 136:	68 a7 04 00 00       	push   $0x4a7
 13b:	e8 d0 00 00 00       	call   210 <strlen>
 140:	83 c4 0c             	add    $0xc,%esp
 143:	50                   	push   %eax
 144:	68 a7 04 00 00       	push   $0x4a7
 149:	6a 01                	push   $0x1
 14b:	e8 a2 02 00 00       	call   3f2 <write>
  }

  for(; n > 0; n--){
    if(wait(&status) < 0){
      printf(1, "wait stopped early\n");
      exit(1);
 150:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 157:	e8 76 02 00 00       	call   3d2 <exit>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
 15c:	83 ec 0c             	sub    $0xc,%esp
 15f:	68 bb 04 00 00       	push   $0x4bb
 164:	e8 a7 00 00 00       	call   210 <strlen>
 169:	83 c4 0c             	add    $0xc,%esp
 16c:	50                   	push   %eax
 16d:	68 bb 04 00 00       	push   $0x4bb
 172:	6a 01                	push   $0x1
 174:	e8 79 02 00 00       	call   3f2 <write>
    }
  }

  if(wait(&status) != -1){
    printf(1, "wait got too many\n");
    exit(1);
 179:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 180:	e8 4d 02 00 00       	call   3d2 <exit>
 185:	66 90                	xchg   %ax,%ax
 187:	66 90                	xchg   %ax,%ax
 189:	66 90                	xchg   %ax,%ax
 18b:	66 90                	xchg   %ax,%ax
 18d:	66 90                	xchg   %ax,%ax
 18f:	90                   	nop

00000190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 19a:	89 c2                	mov    %eax,%edx
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	83 c1 01             	add    $0x1,%ecx
 1a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1a7:	83 c2 01             	add    $0x1,%edx
 1aa:	84 db                	test   %bl,%bl
 1ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 1af:	75 ef                	jne    1a0 <strcpy+0x10>
    ;
  return os;
}
 1b1:	5b                   	pop    %ebx
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
 1c5:	8b 55 08             	mov    0x8(%ebp),%edx
 1c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1cb:	0f b6 02             	movzbl (%edx),%eax
 1ce:	0f b6 19             	movzbl (%ecx),%ebx
 1d1:	84 c0                	test   %al,%al
 1d3:	75 1e                	jne    1f3 <strcmp+0x33>
 1d5:	eb 29                	jmp    200 <strcmp+0x40>
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1e0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1e6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1e9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1ed:	84 c0                	test   %al,%al
 1ef:	74 0f                	je     200 <strcmp+0x40>
 1f1:	89 f1                	mov    %esi,%ecx
 1f3:	38 d8                	cmp    %bl,%al
 1f5:	74 e9                	je     1e0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1f7:	29 d8                	sub    %ebx,%eax
}
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 200:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 202:	29 d8                	sub    %ebx,%eax
}
 204:	5b                   	pop    %ebx
 205:	5e                   	pop    %esi
 206:	5d                   	pop    %ebp
 207:	c3                   	ret    
 208:	90                   	nop
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 39 00             	cmpb   $0x0,(%ecx)
 219:	74 12                	je     22d <strlen+0x1d>
 21b:	31 d2                	xor    %edx,%edx
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c2 01             	add    $0x1,%edx
 223:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 227:	89 d0                	mov    %edx,%eax
 229:	75 f5                	jne    220 <strlen+0x10>
    ;
  return n;
}
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 22d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 22f:	5d                   	pop    %ebp
 230:	c3                   	ret    
 231:	eb 0d                	jmp    240 <memset>
 233:	90                   	nop
 234:	90                   	nop
 235:	90                   	nop
 236:	90                   	nop
 237:	90                   	nop
 238:	90                   	nop
 239:	90                   	nop
 23a:	90                   	nop
 23b:	90                   	nop
 23c:	90                   	nop
 23d:	90                   	nop
 23e:	90                   	nop
 23f:	90                   	nop

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld    
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	89 d0                	mov    %edx,%eax
 254:	5f                   	pop    %edi
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	74 1d                	je     28e <strchr+0x2e>
    if(*s == c)
 271:	38 d3                	cmp    %dl,%bl
 273:	89 d9                	mov    %ebx,%ecx
 275:	75 0d                	jne    284 <strchr+0x24>
 277:	eb 17                	jmp    290 <strchr+0x30>
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 280:	38 ca                	cmp    %cl,%dl
 282:	74 0c                	je     290 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 284:	83 c0 01             	add    $0x1,%eax
 287:	0f b6 10             	movzbl (%eax),%edx
 28a:	84 d2                	test   %dl,%dl
 28c:	75 f2                	jne    280 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 28e:	31 c0                	xor    %eax,%eax
}
 290:	5b                   	pop    %ebx
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    
 293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
 2a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 2a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 2ab:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ae:	eb 29                	jmp    2d9 <gets+0x39>
    cc = read(0, &c, 1);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	6a 01                	push   $0x1
 2b5:	57                   	push   %edi
 2b6:	6a 00                	push   $0x0
 2b8:	e8 2d 01 00 00       	call   3ea <read>
    if(cc < 1)
 2bd:	83 c4 10             	add    $0x10,%esp
 2c0:	85 c0                	test   %eax,%eax
 2c2:	7e 1d                	jle    2e1 <gets+0x41>
      break;
    buf[i++] = c;
 2c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c8:	8b 55 08             	mov    0x8(%ebp),%edx
 2cb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 2cd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2cf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2d3:	74 1b                	je     2f0 <gets+0x50>
 2d5:	3c 0d                	cmp    $0xd,%al
 2d7:	74 17                	je     2f0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d9:	8d 5e 01             	lea    0x1(%esi),%ebx
 2dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2df:	7c cf                	jl     2b0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e1:	8b 45 08             	mov    0x8(%ebp),%eax
 2e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2eb:	5b                   	pop    %ebx
 2ec:	5e                   	pop    %esi
 2ed:	5f                   	pop    %edi
 2ee:	5d                   	pop    %ebp
 2ef:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2f0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fc:	5b                   	pop    %ebx
 2fd:	5e                   	pop    %esi
 2fe:	5f                   	pop    %edi
 2ff:	5d                   	pop    %ebp
 300:	c3                   	ret    
 301:	eb 0d                	jmp    310 <stat>
 303:	90                   	nop
 304:	90                   	nop
 305:	90                   	nop
 306:	90                   	nop
 307:	90                   	nop
 308:	90                   	nop
 309:	90                   	nop
 30a:	90                   	nop
 30b:	90                   	nop
 30c:	90                   	nop
 30d:	90                   	nop
 30e:	90                   	nop
 30f:	90                   	nop

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	pushl  0x8(%ebp)
 31d:	e8 f0 00 00 00       	call   412 <open>
  if(fd < 0)
 322:	83 c4 10             	add    $0x10,%esp
 325:	85 c0                	test   %eax,%eax
 327:	78 27                	js     350 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	ff 75 0c             	pushl  0xc(%ebp)
 32f:	89 c3                	mov    %eax,%ebx
 331:	50                   	push   %eax
 332:	e8 f3 00 00 00       	call   42a <fstat>
 337:	89 c6                	mov    %eax,%esi
  close(fd);
 339:	89 1c 24             	mov    %ebx,(%esp)
 33c:	e8 b9 00 00 00       	call   3fa <close>
  return r;
 341:	83 c4 10             	add    $0x10,%esp
 344:	89 f0                	mov    %esi,%eax
}
 346:	8d 65 f8             	lea    -0x8(%ebp),%esp
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 355:	eb ef                	jmp    346 <stat+0x36>
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	0f be 11             	movsbl (%ecx),%edx
 36a:	8d 42 d0             	lea    -0x30(%edx),%eax
 36d:	3c 09                	cmp    $0x9,%al
 36f:	b8 00 00 00 00       	mov    $0x0,%eax
 374:	77 1f                	ja     395 <atoi+0x35>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 380:	8d 04 80             	lea    (%eax,%eax,4),%eax
 383:	83 c1 01             	add    $0x1,%ecx
 386:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 38a:	0f be 11             	movsbl (%ecx),%edx
 38d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 395:	5b                   	pop    %ebx
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	53                   	push   %ebx
 3a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	7e 14                	jle    3c6 <memmove+0x26>
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3bf:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3c2:	39 da                	cmp    %ebx,%edx
 3c4:	75 f2                	jne    3b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3c6:	5b                   	pop    %ebx
 3c7:	5e                   	pop    %esi
 3c8:	5d                   	pop    %ebp
 3c9:	c3                   	ret    

000003ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ca:	b8 01 00 00 00       	mov    $0x1,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <exit>:
SYSCALL(exit)
 3d2:	b8 02 00 00 00       	mov    $0x2,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <wait>:
SYSCALL(wait)
 3da:	b8 03 00 00 00       	mov    $0x3,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <pipe>:
SYSCALL(pipe)
 3e2:	b8 04 00 00 00       	mov    $0x4,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <read>:
SYSCALL(read)
 3ea:	b8 05 00 00 00       	mov    $0x5,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <write>:
SYSCALL(write)
 3f2:	b8 10 00 00 00       	mov    $0x10,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <close>:
SYSCALL(close)
 3fa:	b8 15 00 00 00       	mov    $0x15,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <kill>:
SYSCALL(kill)
 402:	b8 06 00 00 00       	mov    $0x6,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <exec>:
SYSCALL(exec)
 40a:	b8 07 00 00 00       	mov    $0x7,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <open>:
SYSCALL(open)
 412:	b8 0f 00 00 00       	mov    $0xf,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <mknod>:
SYSCALL(mknod)
 41a:	b8 11 00 00 00       	mov    $0x11,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <unlink>:
SYSCALL(unlink)
 422:	b8 12 00 00 00       	mov    $0x12,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <fstat>:
SYSCALL(fstat)
 42a:	b8 08 00 00 00       	mov    $0x8,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <link>:
SYSCALL(link)
 432:	b8 13 00 00 00       	mov    $0x13,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <mkdir>:
SYSCALL(mkdir)
 43a:	b8 14 00 00 00       	mov    $0x14,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <chdir>:
SYSCALL(chdir)
 442:	b8 09 00 00 00       	mov    $0x9,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <dup>:
SYSCALL(dup)
 44a:	b8 0a 00 00 00       	mov    $0xa,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <getpid>:
SYSCALL(getpid)
 452:	b8 0b 00 00 00       	mov    $0xb,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <memsize>:
SYSCALL(memsize)
 45a:	b8 16 00 00 00       	mov    $0x16,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <sbrk>:
SYSCALL(sbrk)
 462:	b8 0c 00 00 00       	mov    $0xc,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <sleep>:
SYSCALL(sleep)
 46a:	b8 0d 00 00 00       	mov    $0xd,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <uptime>:
SYSCALL(uptime)
 472:	b8 0e 00 00 00       	mov    $0xe,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <policy>:
SYSCALL(policy)
 47a:	b8 17 00 00 00       	mov    $0x17,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <set_cfs_priority>:
SYSCALL(set_cfs_priority)
 482:	b8 19 00 00 00       	mov    $0x19,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <set_ps_priority>:
SYSCALL(set_ps_priority)
 48a:	b8 18 00 00 00       	mov    $0x18,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <proc_info>:
SYSCALL(proc_info)
 492:	b8 1a 00 00 00       	mov    $0x1a,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    
