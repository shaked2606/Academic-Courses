
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
  }
}

int
main(int argc, char *argv[])
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;

  if(argc <= 1){
  27:	7e 60                	jle    89 <main+0x89>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 76 03 00 00       	call   3b2 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 29                	js     6e <main+0x6e>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  if(argc <= 1){
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 4c 00 00 00       	call   a0 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 3e 03 00 00       	call   39a <close>
  if(argc <= 1){
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
      exit(1);
    }
    cat(fd);
    close(fd);
  }
  exit(0);
  64:	83 ec 0c             	sub    $0xc,%esp
  67:	6a 00                	push   $0x0
  69:	e8 04 03 00 00       	call   372 <exit>
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  6e:	50                   	push   %eax
  6f:	ff 33                	pushl  (%ebx)
  71:	68 23 08 00 00       	push   $0x823
  76:	6a 01                	push   $0x1
  78:	e8 63 04 00 00       	call   4e0 <printf>
      exit(1);
  7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  84:	e8 e9 02 00 00       	call   372 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  89:	83 ec 0c             	sub    $0xc,%esp
  8c:	6a 00                	push   $0x0
  8e:	e8 0d 00 00 00       	call   a0 <cat>
    exit(0);
  93:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  9a:	e8 d3 02 00 00       	call   372 <exit>
  9f:	90                   	nop

000000a0 <cat>:

char buf[512];

void
cat(int fd)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	56                   	push   %esi
  a4:	53                   	push   %ebx
  a5:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  a8:	eb 1d                	jmp    c7 <cat+0x27>
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	53                   	push   %ebx
  b4:	68 40 0b 00 00       	push   $0xb40
  b9:	6a 01                	push   $0x1
  bb:	e8 d2 02 00 00       	call   392 <write>
  c0:	83 c4 10             	add    $0x10,%esp
  c3:	39 c3                	cmp    %eax,%ebx
  c5:	75 26                	jne    ed <cat+0x4d>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  c7:	83 ec 04             	sub    $0x4,%esp
  ca:	68 00 02 00 00       	push   $0x200
  cf:	68 40 0b 00 00       	push   $0xb40
  d4:	56                   	push   %esi
  d5:	e8 b0 02 00 00       	call   38a <read>
  da:	83 c4 10             	add    $0x10,%esp
  dd:	83 f8 00             	cmp    $0x0,%eax
  e0:	89 c3                	mov    %eax,%ebx
  e2:	7f cc                	jg     b0 <cat+0x10>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit(1);
    }
  }
  if(n < 0){
  e4:	75 22                	jne    108 <cat+0x68>
    printf(1, "cat: read error\n");
    exit(1);
  }
}
  e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  e9:	5b                   	pop    %ebx
  ea:	5e                   	pop    %esi
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
  ed:	83 ec 08             	sub    $0x8,%esp
  f0:	68 00 08 00 00       	push   $0x800
  f5:	6a 01                	push   $0x1
  f7:	e8 e4 03 00 00       	call   4e0 <printf>
      exit(1);
  fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 103:	e8 6a 02 00 00       	call   372 <exit>
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
 108:	83 ec 08             	sub    $0x8,%esp
 10b:	68 12 08 00 00       	push   $0x812
 110:	6a 01                	push   $0x1
 112:	e8 c9 03 00 00       	call   4e0 <printf>
    exit(1);
 117:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 11e:	e8 4f 02 00 00       	call   372 <exit>
 123:	66 90                	xchg   %ax,%ax
 125:	66 90                	xchg   %ax,%ax
 127:	66 90                	xchg   %ax,%ax
 129:	66 90                	xchg   %ax,%ax
 12b:	66 90                	xchg   %ax,%ax
 12d:	66 90                	xchg   %ax,%ax
 12f:	90                   	nop

00000130 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 13a:	89 c2                	mov    %eax,%edx
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 140:	83 c1 01             	add    $0x1,%ecx
 143:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 147:	83 c2 01             	add    $0x1,%edx
 14a:	84 db                	test   %bl,%bl
 14c:	88 5a ff             	mov    %bl,-0x1(%edx)
 14f:	75 ef                	jne    140 <strcpy+0x10>
    ;
  return os;
}
 151:	5b                   	pop    %ebx
 152:	5d                   	pop    %ebp
 153:	c3                   	ret    
 154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 15a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	56                   	push   %esi
 164:	53                   	push   %ebx
 165:	8b 55 08             	mov    0x8(%ebp),%edx
 168:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 16b:	0f b6 02             	movzbl (%edx),%eax
 16e:	0f b6 19             	movzbl (%ecx),%ebx
 171:	84 c0                	test   %al,%al
 173:	75 1e                	jne    193 <strcmp+0x33>
 175:	eb 29                	jmp    1a0 <strcmp+0x40>
 177:	89 f6                	mov    %esi,%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 180:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 183:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 186:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 189:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 18d:	84 c0                	test   %al,%al
 18f:	74 0f                	je     1a0 <strcmp+0x40>
 191:	89 f1                	mov    %esi,%ecx
 193:	38 d8                	cmp    %bl,%al
 195:	74 e9                	je     180 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 197:	29 d8                	sub    %ebx,%eax
}
 199:	5b                   	pop    %ebx
 19a:	5e                   	pop    %esi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a2:	29 d8                	sub    %ebx,%eax
}
 1a4:	5b                   	pop    %ebx
 1a5:	5e                   	pop    %esi
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    
 1a8:	90                   	nop
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 39 00             	cmpb   $0x0,(%ecx)
 1b9:	74 12                	je     1cd <strlen+0x1d>
 1bb:	31 d2                	xor    %edx,%edx
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	83 c2 01             	add    $0x1,%edx
 1c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1c7:	89 d0                	mov    %edx,%eax
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1cd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    
 1d1:	eb 0d                	jmp    1e0 <memset>
 1d3:	90                   	nop
 1d4:	90                   	nop
 1d5:	90                   	nop
 1d6:	90                   	nop
 1d7:	90                   	nop
 1d8:	90                   	nop
 1d9:	90                   	nop
 1da:	90                   	nop
 1db:	90                   	nop
 1dc:	90                   	nop
 1dd:	90                   	nop
 1de:	90                   	nop
 1df:	90                   	nop

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld    
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1f2:	89 d0                	mov    %edx,%eax
 1f4:	5f                   	pop    %edi
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 20a:	0f b6 10             	movzbl (%eax),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	74 1d                	je     22e <strchr+0x2e>
    if(*s == c)
 211:	38 d3                	cmp    %dl,%bl
 213:	89 d9                	mov    %ebx,%ecx
 215:	75 0d                	jne    224 <strchr+0x24>
 217:	eb 17                	jmp    230 <strchr+0x30>
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 220:	38 ca                	cmp    %cl,%dl
 222:	74 0c                	je     230 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 224:	83 c0 01             	add    $0x1,%eax
 227:	0f b6 10             	movzbl (%eax),%edx
 22a:	84 d2                	test   %dl,%dl
 22c:	75 f2                	jne    220 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 22e:	31 c0                	xor    %eax,%eax
}
 230:	5b                   	pop    %ebx
 231:	5d                   	pop    %ebp
 232:	c3                   	ret    
 233:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
 245:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 246:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 248:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 24b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24e:	eb 29                	jmp    279 <gets+0x39>
    cc = read(0, &c, 1);
 250:	83 ec 04             	sub    $0x4,%esp
 253:	6a 01                	push   $0x1
 255:	57                   	push   %edi
 256:	6a 00                	push   $0x0
 258:	e8 2d 01 00 00       	call   38a <read>
    if(cc < 1)
 25d:	83 c4 10             	add    $0x10,%esp
 260:	85 c0                	test   %eax,%eax
 262:	7e 1d                	jle    281 <gets+0x41>
      break;
    buf[i++] = c;
 264:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 268:	8b 55 08             	mov    0x8(%ebp),%edx
 26b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 26d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 26f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 273:	74 1b                	je     290 <gets+0x50>
 275:	3c 0d                	cmp    $0xd,%al
 277:	74 17                	je     290 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 279:	8d 5e 01             	lea    0x1(%esi),%ebx
 27c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 27f:	7c cf                	jl     250 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 281:	8b 45 08             	mov    0x8(%ebp),%eax
 284:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 288:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28b:	5b                   	pop    %ebx
 28c:	5e                   	pop    %esi
 28d:	5f                   	pop    %edi
 28e:	5d                   	pop    %ebp
 28f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 290:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 293:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 295:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 299:	8d 65 f4             	lea    -0xc(%ebp),%esp
 29c:	5b                   	pop    %ebx
 29d:	5e                   	pop    %esi
 29e:	5f                   	pop    %edi
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	eb 0d                	jmp    2b0 <stat>
 2a3:	90                   	nop
 2a4:	90                   	nop
 2a5:	90                   	nop
 2a6:	90                   	nop
 2a7:	90                   	nop
 2a8:	90                   	nop
 2a9:	90                   	nop
 2aa:	90                   	nop
 2ab:	90                   	nop
 2ac:	90                   	nop
 2ad:	90                   	nop
 2ae:	90                   	nop
 2af:	90                   	nop

000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b5:	83 ec 08             	sub    $0x8,%esp
 2b8:	6a 00                	push   $0x0
 2ba:	ff 75 08             	pushl  0x8(%ebp)
 2bd:	e8 f0 00 00 00       	call   3b2 <open>
  if(fd < 0)
 2c2:	83 c4 10             	add    $0x10,%esp
 2c5:	85 c0                	test   %eax,%eax
 2c7:	78 27                	js     2f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	ff 75 0c             	pushl  0xc(%ebp)
 2cf:	89 c3                	mov    %eax,%ebx
 2d1:	50                   	push   %eax
 2d2:	e8 f3 00 00 00       	call   3ca <fstat>
 2d7:	89 c6                	mov    %eax,%esi
  close(fd);
 2d9:	89 1c 24             	mov    %ebx,(%esp)
 2dc:	e8 b9 00 00 00       	call   39a <close>
  return r;
 2e1:	83 c4 10             	add    $0x10,%esp
 2e4:	89 f0                	mov    %esi,%eax
}
 2e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret    
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2f5:	eb ef                	jmp    2e6 <stat+0x36>
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	53                   	push   %ebx
 304:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 307:	0f be 11             	movsbl (%ecx),%edx
 30a:	8d 42 d0             	lea    -0x30(%edx),%eax
 30d:	3c 09                	cmp    $0x9,%al
 30f:	b8 00 00 00 00       	mov    $0x0,%eax
 314:	77 1f                	ja     335 <atoi+0x35>
 316:	8d 76 00             	lea    0x0(%esi),%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 320:	8d 04 80             	lea    (%eax,%eax,4),%eax
 323:	83 c1 01             	add    $0x1,%ecx
 326:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32a:	0f be 11             	movsbl (%ecx),%edx
 32d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 335:	5b                   	pop    %ebx
 336:	5d                   	pop    %ebp
 337:	c3                   	ret    
 338:	90                   	nop
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	56                   	push   %esi
 344:	53                   	push   %ebx
 345:	8b 5d 10             	mov    0x10(%ebp),%ebx
 348:	8b 45 08             	mov    0x8(%ebp),%eax
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	85 db                	test   %ebx,%ebx
 350:	7e 14                	jle    366 <memmove+0x26>
 352:	31 d2                	xor    %edx,%edx
 354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 358:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 35c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 35f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 362:	39 da                	cmp    %ebx,%edx
 364:	75 f2                	jne    358 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 366:	5b                   	pop    %ebx
 367:	5e                   	pop    %esi
 368:	5d                   	pop    %ebp
 369:	c3                   	ret    

0000036a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36a:	b8 01 00 00 00       	mov    $0x1,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <exit>:
SYSCALL(exit)
 372:	b8 02 00 00 00       	mov    $0x2,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <wait>:
SYSCALL(wait)
 37a:	b8 03 00 00 00       	mov    $0x3,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <pipe>:
SYSCALL(pipe)
 382:	b8 04 00 00 00       	mov    $0x4,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <read>:
SYSCALL(read)
 38a:	b8 05 00 00 00       	mov    $0x5,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <write>:
SYSCALL(write)
 392:	b8 10 00 00 00       	mov    $0x10,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <close>:
SYSCALL(close)
 39a:	b8 15 00 00 00       	mov    $0x15,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <kill>:
SYSCALL(kill)
 3a2:	b8 06 00 00 00       	mov    $0x6,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <exec>:
SYSCALL(exec)
 3aa:	b8 07 00 00 00       	mov    $0x7,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <open>:
SYSCALL(open)
 3b2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <mknod>:
SYSCALL(mknod)
 3ba:	b8 11 00 00 00       	mov    $0x11,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <unlink>:
SYSCALL(unlink)
 3c2:	b8 12 00 00 00       	mov    $0x12,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <fstat>:
SYSCALL(fstat)
 3ca:	b8 08 00 00 00       	mov    $0x8,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <link>:
SYSCALL(link)
 3d2:	b8 13 00 00 00       	mov    $0x13,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mkdir>:
SYSCALL(mkdir)
 3da:	b8 14 00 00 00       	mov    $0x14,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <chdir>:
SYSCALL(chdir)
 3e2:	b8 09 00 00 00       	mov    $0x9,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <dup>:
SYSCALL(dup)
 3ea:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <getpid>:
SYSCALL(getpid)
 3f2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <memsize>:
SYSCALL(memsize)
 3fa:	b8 16 00 00 00       	mov    $0x16,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <sbrk>:
SYSCALL(sbrk)
 402:	b8 0c 00 00 00       	mov    $0xc,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <sleep>:
SYSCALL(sleep)
 40a:	b8 0d 00 00 00       	mov    $0xd,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <uptime>:
SYSCALL(uptime)
 412:	b8 0e 00 00 00       	mov    $0xe,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <policy>:
SYSCALL(policy)
 41a:	b8 17 00 00 00       	mov    $0x17,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <set_cfs_priority>:
SYSCALL(set_cfs_priority)
 422:	b8 19 00 00 00       	mov    $0x19,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <set_ps_priority>:
SYSCALL(set_ps_priority)
 42a:	b8 18 00 00 00       	mov    $0x18,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <proc_info>:
SYSCALL(proc_info)
 432:	b8 1a 00 00 00       	mov    $0x1a,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    
 43a:	66 90                	xchg   %ax,%ax
 43c:	66 90                	xchg   %ax,%ax
 43e:	66 90                	xchg   %ax,%ax

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	89 c6                	mov    %eax,%esi
 448:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 44b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 44e:	85 db                	test   %ebx,%ebx
 450:	74 7e                	je     4d0 <printint+0x90>
 452:	89 d0                	mov    %edx,%eax
 454:	c1 e8 1f             	shr    $0x1f,%eax
 457:	84 c0                	test   %al,%al
 459:	74 75                	je     4d0 <printint+0x90>
    neg = 1;
    x = -xx;
 45b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 45d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 464:	f7 d8                	neg    %eax
 466:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 469:	31 ff                	xor    %edi,%edi
 46b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 46e:	89 ce                	mov    %ecx,%esi
 470:	eb 08                	jmp    47a <printint+0x3a>
 472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 478:	89 cf                	mov    %ecx,%edi
 47a:	31 d2                	xor    %edx,%edx
 47c:	8d 4f 01             	lea    0x1(%edi),%ecx
 47f:	f7 f6                	div    %esi
 481:	0f b6 92 40 08 00 00 	movzbl 0x840(%edx),%edx
  }while((x /= base) != 0);
 488:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 48a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 48d:	75 e9                	jne    478 <printint+0x38>
  if(neg)
 48f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 492:	8b 75 c0             	mov    -0x40(%ebp),%esi
 495:	85 c0                	test   %eax,%eax
 497:	74 08                	je     4a1 <printint+0x61>
    buf[i++] = '-';
 499:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 49e:	8d 4f 02             	lea    0x2(%edi),%ecx
 4a1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 4a5:	8d 76 00             	lea    0x0(%esi),%esi
 4a8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ab:	83 ec 04             	sub    $0x4,%esp
 4ae:	83 ef 01             	sub    $0x1,%edi
 4b1:	6a 01                	push   $0x1
 4b3:	53                   	push   %ebx
 4b4:	56                   	push   %esi
 4b5:	88 45 d7             	mov    %al,-0x29(%ebp)
 4b8:	e8 d5 fe ff ff       	call   392 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4bd:	83 c4 10             	add    $0x10,%esp
 4c0:	39 df                	cmp    %ebx,%edi
 4c2:	75 e4                	jne    4a8 <printint+0x68>
    putc(fd, buf[i]);
}
 4c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c7:	5b                   	pop    %ebx
 4c8:	5e                   	pop    %esi
 4c9:	5f                   	pop    %edi
 4ca:	5d                   	pop    %ebp
 4cb:	c3                   	ret    
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4d9:	eb 8b                	jmp    466 <printint+0x26>
 4db:	90                   	nop
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4ec:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4f5:	0f b6 1e             	movzbl (%esi),%ebx
 4f8:	83 c6 01             	add    $0x1,%esi
 4fb:	84 db                	test   %bl,%bl
 4fd:	0f 84 b0 00 00 00    	je     5b3 <printf+0xd3>
 503:	31 d2                	xor    %edx,%edx
 505:	eb 39                	jmp    540 <printf+0x60>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 510:	83 f8 25             	cmp    $0x25,%eax
 513:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 516:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 51b:	74 18                	je     535 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 51d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 520:	83 ec 04             	sub    $0x4,%esp
 523:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 526:	6a 01                	push   $0x1
 528:	50                   	push   %eax
 529:	57                   	push   %edi
 52a:	e8 63 fe ff ff       	call   392 <write>
 52f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 532:	83 c4 10             	add    $0x10,%esp
 535:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 538:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 53c:	84 db                	test   %bl,%bl
 53e:	74 73                	je     5b3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 540:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 542:	0f be cb             	movsbl %bl,%ecx
 545:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 548:	74 c6                	je     510 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 54a:	83 fa 25             	cmp    $0x25,%edx
 54d:	75 e6                	jne    535 <printf+0x55>
      if(c == 'd'){
 54f:	83 f8 64             	cmp    $0x64,%eax
 552:	0f 84 f8 00 00 00    	je     650 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 558:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 55e:	83 f9 70             	cmp    $0x70,%ecx
 561:	74 5d                	je     5c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 563:	83 f8 73             	cmp    $0x73,%eax
 566:	0f 84 84 00 00 00    	je     5f0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56c:	83 f8 63             	cmp    $0x63,%eax
 56f:	0f 84 ea 00 00 00    	je     65f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 575:	83 f8 25             	cmp    $0x25,%eax
 578:	0f 84 c2 00 00 00    	je     640 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 57e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 581:	83 ec 04             	sub    $0x4,%esp
 584:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 588:	6a 01                	push   $0x1
 58a:	50                   	push   %eax
 58b:	57                   	push   %edi
 58c:	e8 01 fe ff ff       	call   392 <write>
 591:	83 c4 0c             	add    $0xc,%esp
 594:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 597:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 59a:	6a 01                	push   $0x1
 59c:	50                   	push   %eax
 59d:	57                   	push   %edi
 59e:	83 c6 01             	add    $0x1,%esi
 5a1:	e8 ec fd ff ff       	call   392 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5aa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5ad:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5af:	84 db                	test   %bl,%bl
 5b1:	75 8d                	jne    540 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b6:	5b                   	pop    %ebx
 5b7:	5e                   	pop    %esi
 5b8:	5f                   	pop    %edi
 5b9:	5d                   	pop    %ebp
 5ba:	c3                   	ret    
 5bb:	90                   	nop
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5c0:	83 ec 0c             	sub    $0xc,%esp
 5c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5c8:	6a 00                	push   $0x0
 5ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5cd:	89 f8                	mov    %edi,%eax
 5cf:	8b 13                	mov    (%ebx),%edx
 5d1:	e8 6a fe ff ff       	call   440 <printint>
        ap++;
 5d6:	89 d8                	mov    %ebx,%eax
 5d8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5db:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 5dd:	83 c0 04             	add    $0x4,%eax
 5e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5e3:	e9 4d ff ff ff       	jmp    535 <printf+0x55>
 5e8:	90                   	nop
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 5f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5f3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5f5:	83 c0 04             	add    $0x4,%eax
 5f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 5fb:	b8 38 08 00 00       	mov    $0x838,%eax
 600:	85 db                	test   %ebx,%ebx
 602:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 605:	0f b6 03             	movzbl (%ebx),%eax
 608:	84 c0                	test   %al,%al
 60a:	74 23                	je     62f <printf+0x14f>
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 610:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 613:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 616:	83 ec 04             	sub    $0x4,%esp
 619:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 61b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 61e:	50                   	push   %eax
 61f:	57                   	push   %edi
 620:	e8 6d fd ff ff       	call   392 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 625:	0f b6 03             	movzbl (%ebx),%eax
 628:	83 c4 10             	add    $0x10,%esp
 62b:	84 c0                	test   %al,%al
 62d:	75 e1                	jne    610 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62f:	31 d2                	xor    %edx,%edx
 631:	e9 ff fe ff ff       	jmp    535 <printf+0x55>
 636:	8d 76 00             	lea    0x0(%esi),%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 640:	83 ec 04             	sub    $0x4,%esp
 643:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 646:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 649:	6a 01                	push   $0x1
 64b:	e9 4c ff ff ff       	jmp    59c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 650:	83 ec 0c             	sub    $0xc,%esp
 653:	b9 0a 00 00 00       	mov    $0xa,%ecx
 658:	6a 01                	push   $0x1
 65a:	e9 6b ff ff ff       	jmp    5ca <printf+0xea>
 65f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 662:	83 ec 04             	sub    $0x4,%esp
 665:	8b 03                	mov    (%ebx),%eax
 667:	6a 01                	push   $0x1
 669:	88 45 e4             	mov    %al,-0x1c(%ebp)
 66c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 66f:	50                   	push   %eax
 670:	57                   	push   %edi
 671:	e8 1c fd ff ff       	call   392 <write>
 676:	e9 5b ff ff ff       	jmp    5d6 <printf+0xf6>
 67b:	66 90                	xchg   %ax,%ax
 67d:	66 90                	xchg   %ax,%ax
 67f:	90                   	nop

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 20 0b 00 00       	mov    0xb20,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 690:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 693:	39 c8                	cmp    %ecx,%eax
 695:	73 19                	jae    6b0 <free+0x30>
 697:	89 f6                	mov    %esi,%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6a0:	39 d1                	cmp    %edx,%ecx
 6a2:	72 1c                	jb     6c0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a4:	39 d0                	cmp    %edx,%eax
 6a6:	73 18                	jae    6c0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6aa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ac:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ae:	72 f0                	jb     6a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b0:	39 d0                	cmp    %edx,%eax
 6b2:	72 f4                	jb     6a8 <free+0x28>
 6b4:	39 d1                	cmp    %edx,%ecx
 6b6:	73 f0                	jae    6a8 <free+0x28>
 6b8:	90                   	nop
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6c6:	39 d7                	cmp    %edx,%edi
 6c8:	74 19                	je     6e3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6cd:	8b 50 04             	mov    0x4(%eax),%edx
 6d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6d3:	39 f1                	cmp    %esi,%ecx
 6d5:	74 23                	je     6fa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6d7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6d9:	a3 20 0b 00 00       	mov    %eax,0xb20
}
 6de:	5b                   	pop    %ebx
 6df:	5e                   	pop    %esi
 6e0:	5f                   	pop    %edi
 6e1:	5d                   	pop    %ebp
 6e2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6e3:	03 72 04             	add    0x4(%edx),%esi
 6e6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e9:	8b 10                	mov    (%eax),%edx
 6eb:	8b 12                	mov    (%edx),%edx
 6ed:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6f0:	8b 50 04             	mov    0x4(%eax),%edx
 6f3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f6:	39 f1                	cmp    %esi,%ecx
 6f8:	75 dd                	jne    6d7 <free+0x57>
    p->s.size += bp->s.size;
 6fa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6fd:	a3 20 0b 00 00       	mov    %eax,0xb20
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 702:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 705:	8b 53 f8             	mov    -0x8(%ebx),%edx
 708:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 70a:	5b                   	pop    %ebx
 70b:	5e                   	pop    %esi
 70c:	5f                   	pop    %edi
 70d:	5d                   	pop    %ebp
 70e:	c3                   	ret    
 70f:	90                   	nop

00000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 719:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 71c:	8b 15 20 0b 00 00    	mov    0xb20,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 722:	8d 78 07             	lea    0x7(%eax),%edi
 725:	c1 ef 03             	shr    $0x3,%edi
 728:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 72b:	85 d2                	test   %edx,%edx
 72d:	0f 84 a3 00 00 00    	je     7d6 <malloc+0xc6>
 733:	8b 02                	mov    (%edx),%eax
 735:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 738:	39 cf                	cmp    %ecx,%edi
 73a:	76 74                	jbe    7b0 <malloc+0xa0>
 73c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 742:	be 00 10 00 00       	mov    $0x1000,%esi
 747:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 74e:	0f 43 f7             	cmovae %edi,%esi
 751:	ba 00 80 00 00       	mov    $0x8000,%edx
 756:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 75c:	0f 46 da             	cmovbe %edx,%ebx
 75f:	eb 10                	jmp    771 <malloc+0x61>
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 768:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 76a:	8b 48 04             	mov    0x4(%eax),%ecx
 76d:	39 cf                	cmp    %ecx,%edi
 76f:	76 3f                	jbe    7b0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 771:	39 05 20 0b 00 00    	cmp    %eax,0xb20
 777:	89 c2                	mov    %eax,%edx
 779:	75 ed                	jne    768 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 77b:	83 ec 0c             	sub    $0xc,%esp
 77e:	53                   	push   %ebx
 77f:	e8 7e fc ff ff       	call   402 <sbrk>
  if(p == (char*)-1)
 784:	83 c4 10             	add    $0x10,%esp
 787:	83 f8 ff             	cmp    $0xffffffff,%eax
 78a:	74 1c                	je     7a8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 78c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 78f:	83 ec 0c             	sub    $0xc,%esp
 792:	83 c0 08             	add    $0x8,%eax
 795:	50                   	push   %eax
 796:	e8 e5 fe ff ff       	call   680 <free>
  return freep;
 79b:	8b 15 20 0b 00 00    	mov    0xb20,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7a1:	83 c4 10             	add    $0x10,%esp
 7a4:	85 d2                	test   %edx,%edx
 7a6:	75 c0                	jne    768 <malloc+0x58>
        return 0;
 7a8:	31 c0                	xor    %eax,%eax
 7aa:	eb 1c                	jmp    7c8 <malloc+0xb8>
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7b0:	39 cf                	cmp    %ecx,%edi
 7b2:	74 1c                	je     7d0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7b4:	29 f9                	sub    %edi,%ecx
 7b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7bc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 7bf:	89 15 20 0b 00 00    	mov    %edx,0xb20
      return (void*)(p + 1);
 7c5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7cb:	5b                   	pop    %ebx
 7cc:	5e                   	pop    %esi
 7cd:	5f                   	pop    %edi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7d0:	8b 08                	mov    (%eax),%ecx
 7d2:	89 0a                	mov    %ecx,(%edx)
 7d4:	eb e9                	jmp    7bf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7d6:	c7 05 20 0b 00 00 24 	movl   $0xb24,0xb20
 7dd:	0b 00 00 
 7e0:	c7 05 24 0b 00 00 24 	movl   $0xb24,0xb24
 7e7:	0b 00 00 
    base.s.size = 0;
 7ea:	b8 24 0b 00 00       	mov    $0xb24,%eax
 7ef:	c7 05 28 0b 00 00 00 	movl   $0x0,0xb28
 7f6:	00 00 00 
 7f9:	e9 3e ff ff ff       	jmp    73c <malloc+0x2c>
