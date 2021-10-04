
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd, status;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      12:	eb 0d                	jmp    21 <main+0x21>
      14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f b0 00 00 00    	jg     d1 <main+0xd1>
{
  static char buf[100];
  int fd, status;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 91 12 00 00       	push   $0x1291
      2b:	e8 72 0d 00 00       	call   da2 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait(&status);
      37:	8d 5d f4             	lea    -0xc(%ebp),%ebx
      3a:	eb 26                	jmp    62 <main+0x62>
      3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      40:	e8 15 0d 00 00       	call   d5a <fork>
  if(pid == -1)
      45:	83 f8 ff             	cmp    $0xffffffff,%eax
      48:	0f 84 9e 00 00 00    	je     ec <main+0xec>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      4e:	85 c0                	test   %eax,%eax
      50:	0f 84 a3 00 00 00    	je     f9 <main+0xf9>
      runcmd(parsecmd(buf));
    wait(&status);
      56:	83 ec 0c             	sub    $0xc,%esp
      59:	53                   	push   %ebx
      5a:	e8 0b 0d 00 00       	call   d6a <wait>
      5f:	83 c4 10             	add    $0x10,%esp
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
      62:	83 ec 08             	sub    $0x8,%esp
      65:	6a 64                	push   $0x64
      67:	68 c0 18 00 00       	push   $0x18c0
      6c:	e8 9f 00 00 00       	call   110 <getcmd>
      71:	83 c4 10             	add    $0x10,%esp
      74:	85 c0                	test   %eax,%eax
      76:	78 6a                	js     e2 <main+0xe2>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      78:	80 3d c0 18 00 00 63 	cmpb   $0x63,0x18c0
      7f:	75 bf                	jne    40 <main+0x40>
      81:	80 3d c1 18 00 00 64 	cmpb   $0x64,0x18c1
      88:	75 b6                	jne    40 <main+0x40>
      8a:	80 3d c2 18 00 00 20 	cmpb   $0x20,0x18c2
      91:	75 ad                	jne    40 <main+0x40>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      93:	83 ec 0c             	sub    $0xc,%esp
      96:	68 c0 18 00 00       	push   $0x18c0
      9b:	e8 00 0b 00 00       	call   ba0 <strlen>
      if(chdir(buf+3) < 0)
      a0:	c7 04 24 c3 18 00 00 	movl   $0x18c3,(%esp)

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      a7:	c6 80 bf 18 00 00 00 	movb   $0x0,0x18bf(%eax)
      if(chdir(buf+3) < 0)
      ae:	e8 1f 0d 00 00       	call   dd2 <chdir>
      b3:	83 c4 10             	add    $0x10,%esp
      b6:	85 c0                	test   %eax,%eax
      b8:	79 a8                	jns    62 <main+0x62>
        printf(2, "cannot cd %s\n", buf+3);
      ba:	50                   	push   %eax
      bb:	68 c3 18 00 00       	push   $0x18c3
      c0:	68 99 12 00 00       	push   $0x1299
      c5:	6a 02                	push   $0x2
      c7:	e8 04 0e 00 00       	call   ed0 <printf>
      cc:	83 c4 10             	add    $0x10,%esp
      cf:	eb 91                	jmp    62 <main+0x62>
  int fd, status;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      d1:	83 ec 0c             	sub    $0xc,%esp
      d4:	50                   	push   %eax
      d5:	e8 b0 0c 00 00       	call   d8a <close>
      break;
      da:	83 c4 10             	add    $0x10,%esp
      dd:	e9 55 ff ff ff       	jmp    37 <main+0x37>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait(&status);
  }
  exit(0);
      e2:	83 ec 0c             	sub    $0xc,%esp
      e5:	6a 00                	push   $0x0
      e7:	e8 76 0c 00 00       	call   d62 <exit>
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
      ec:	83 ec 0c             	sub    $0xc,%esp
      ef:	68 1a 12 00 00       	push   $0x121a
      f4:	e8 67 00 00 00       	call   160 <panic>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
      f9:	83 ec 0c             	sub    $0xc,%esp
      fc:	68 c0 18 00 00       	push   $0x18c0
     101:	e8 aa 09 00 00       	call   ab0 <parsecmd>
     106:	89 04 24             	mov    %eax,(%esp)
     109:	e8 82 00 00 00       	call   190 <runcmd>
     10e:	66 90                	xchg   %ax,%ax

00000110 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	56                   	push   %esi
     114:	53                   	push   %ebx
     115:	8b 75 0c             	mov    0xc(%ebp),%esi
     118:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     11b:	83 ec 08             	sub    $0x8,%esp
     11e:	68 f0 11 00 00       	push   $0x11f0
     123:	6a 02                	push   $0x2
     125:	e8 a6 0d 00 00       	call   ed0 <printf>
  memset(buf, 0, nbuf);
     12a:	83 c4 0c             	add    $0xc,%esp
     12d:	56                   	push   %esi
     12e:	6a 00                	push   $0x0
     130:	53                   	push   %ebx
     131:	e8 9a 0a 00 00       	call   bd0 <memset>
  gets(buf, nbuf);
     136:	58                   	pop    %eax
     137:	5a                   	pop    %edx
     138:	56                   	push   %esi
     139:	53                   	push   %ebx
     13a:	e8 f1 0a 00 00       	call   c30 <gets>
     13f:	83 c4 10             	add    $0x10,%esp
     142:	31 c0                	xor    %eax,%eax
     144:	80 3b 00             	cmpb   $0x0,(%ebx)
     147:	0f 94 c0             	sete   %al
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
     14a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     14d:	f7 d8                	neg    %eax
     14f:	5b                   	pop    %ebx
     150:	5e                   	pop    %esi
     151:	5d                   	pop    %ebp
     152:	c3                   	ret    
     153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <panic>:
  exit(0);
}

void
panic(char *s)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     166:	ff 75 08             	pushl  0x8(%ebp)
     169:	68 8d 12 00 00       	push   $0x128d
     16e:	6a 02                	push   $0x2
     170:	e8 5b 0d 00 00       	call   ed0 <printf>
  exit(0);
     175:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     17c:	e8 e1 0b 00 00       	call   d62 <exit>
     181:	eb 0d                	jmp    190 <runcmd>
     183:	90                   	nop
     184:	90                   	nop
     185:	90                   	nop
     186:	90                   	nop
     187:	90                   	nop
     188:	90                   	nop
     189:	90                   	nop
     18a:	90                   	nop
     18b:	90                   	nop
     18c:	90                   	nop
     18d:	90                   	nop
     18e:	90                   	nop
     18f:	90                   	nop

00000190 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	53                   	push   %ebx
     194:	83 ec 14             	sub    $0x14,%esp
     197:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     19a:	85 db                	test   %ebx,%ebx
     19c:	0f 84 2c 01 00 00    	je     2ce <runcmd+0x13e>
    exit(1);

  switch(cmd->type){
     1a2:	83 3b 05             	cmpl   $0x5,(%ebx)
     1a5:	0f 87 16 01 00 00    	ja     2c1 <runcmd+0x131>
     1ab:	8b 03                	mov    (%ebx),%eax
     1ad:	ff 24 85 a8 12 00 00 	jmp    *0x12a8(,%eax,4)
int
fork1(void)
{
  int pid;

  pid = fork();
     1b4:	e8 a1 0b 00 00       	call   d5a <fork>
  if(pid == -1)
     1b9:	83 f8 ff             	cmp    $0xffffffff,%eax
     1bc:	0f 84 16 01 00 00    	je     2d8 <runcmd+0x148>
    wait(&status);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
     1c2:	85 c0                	test   %eax,%eax
     1c4:	74 5b                	je     221 <runcmd+0x91>
      runcmd(bcmd->cmd);
    break;
  }
  exit(0);
     1c6:	83 ec 0c             	sub    $0xc,%esp
     1c9:	6a 00                	push   $0x0
     1cb:	e8 92 0b 00 00       	call   d62 <exit>
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
     1d0:	8b 43 04             	mov    0x4(%ebx),%eax
     1d3:	85 c0                	test   %eax,%eax
     1d5:	0f 84 f3 00 00 00    	je     2ce <runcmd+0x13e>
      exit(1);
    exec(ecmd->argv[0], ecmd->argv);
     1db:	8d 53 04             	lea    0x4(%ebx),%edx
     1de:	51                   	push   %ecx
     1df:	51                   	push   %ecx
     1e0:	52                   	push   %edx
     1e1:	50                   	push   %eax
     1e2:	e8 b3 0b 00 00       	call   d9a <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     1e7:	83 c4 0c             	add    $0xc,%esp
     1ea:	ff 73 04             	pushl  0x4(%ebx)
     1ed:	68 fa 11 00 00       	push   $0x11fa
     1f2:	6a 02                	push   $0x2
     1f4:	e8 d7 0c 00 00       	call   ed0 <printf>
    break;
     1f9:	83 c4 10             	add    $0x10,%esp
     1fc:	eb c8                	jmp    1c6 <runcmd+0x36>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
     1fe:	83 ec 0c             	sub    $0xc,%esp
     201:	ff 73 14             	pushl  0x14(%ebx)
     204:	e8 81 0b 00 00       	call   d8a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     209:	58                   	pop    %eax
     20a:	5a                   	pop    %edx
     20b:	ff 73 10             	pushl  0x10(%ebx)
     20e:	ff 73 08             	pushl  0x8(%ebx)
     211:	e8 8c 0b 00 00       	call   da2 <open>
     216:	83 c4 10             	add    $0x10,%esp
     219:	85 c0                	test   %eax,%eax
     21b:	0f 88 c4 00 00 00    	js     2e5 <runcmd+0x155>
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
     221:	83 ec 0c             	sub    $0xc,%esp
     224:	ff 73 04             	pushl  0x4(%ebx)
     227:	e8 64 ff ff ff       	call   190 <runcmd>
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
     22c:	8d 45 f0             	lea    -0x10(%ebp),%eax
     22f:	83 ec 0c             	sub    $0xc,%esp
     232:	50                   	push   %eax
     233:	e8 3a 0b 00 00       	call   d72 <pipe>
     238:	83 c4 10             	add    $0x10,%esp
     23b:	85 c0                	test   %eax,%eax
     23d:	0f 88 be 00 00 00    	js     301 <runcmd+0x171>
int
fork1(void)
{
  int pid;

  pid = fork();
     243:	e8 12 0b 00 00       	call   d5a <fork>
  if(pid == -1)
     248:	83 f8 ff             	cmp    $0xffffffff,%eax
     24b:	0f 84 87 00 00 00    	je     2d8 <runcmd+0x148>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
     251:	85 c0                	test   %eax,%eax
     253:	0f 84 b5 00 00 00    	je     30e <runcmd+0x17e>
int
fork1(void)
{
  int pid;

  pid = fork();
     259:	e8 fc 0a 00 00       	call   d5a <fork>
  if(pid == -1)
     25e:	83 f8 ff             	cmp    $0xffffffff,%eax
     261:	74 75                	je     2d8 <runcmd+0x148>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
     263:	85 c0                	test   %eax,%eax
     265:	0f 84 d1 00 00 00    	je     33c <runcmd+0x1ac>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     26b:	83 ec 0c             	sub    $0xc,%esp
     26e:	ff 75 f0             	pushl  -0x10(%ebp)
    close(p[1]);
    wait(&status);
     271:	8d 5d ec             	lea    -0x14(%ebp),%ebx
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     274:	e8 11 0b 00 00       	call   d8a <close>
    close(p[1]);
     279:	58                   	pop    %eax
     27a:	ff 75 f4             	pushl  -0xc(%ebp)
     27d:	e8 08 0b 00 00       	call   d8a <close>
    wait(&status);
     282:	89 1c 24             	mov    %ebx,(%esp)
     285:	e8 e0 0a 00 00       	call   d6a <wait>
    wait(&status);
     28a:	89 1c 24             	mov    %ebx,(%esp)
     28d:	e8 d8 0a 00 00       	call   d6a <wait>
    break;
     292:	83 c4 10             	add    $0x10,%esp
     295:	e9 2c ff ff ff       	jmp    1c6 <runcmd+0x36>
int
fork1(void)
{
  int pid;

  pid = fork();
     29a:	e8 bb 0a 00 00       	call   d5a <fork>
  if(pid == -1)
     29f:	83 f8 ff             	cmp    $0xffffffff,%eax
     2a2:	74 34                	je     2d8 <runcmd+0x148>
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
     2a4:	85 c0                	test   %eax,%eax
     2a6:	0f 84 75 ff ff ff    	je     221 <runcmd+0x91>
      runcmd(lcmd->left);
    wait(&status);
     2ac:	8d 45 ec             	lea    -0x14(%ebp),%eax
     2af:	83 ec 0c             	sub    $0xc,%esp
     2b2:	50                   	push   %eax
     2b3:	e8 b2 0a 00 00       	call   d6a <wait>
    runcmd(lcmd->right);
     2b8:	5a                   	pop    %edx
     2b9:	ff 73 08             	pushl  0x8(%ebx)
     2bc:	e8 cf fe ff ff       	call   190 <runcmd>
  if(cmd == 0)
    exit(1);

  switch(cmd->type){
  default:
    panic("runcmd");
     2c1:	83 ec 0c             	sub    $0xc,%esp
     2c4:	68 f3 11 00 00       	push   $0x11f3
     2c9:	e8 92 fe ff ff       	call   160 <panic>
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit(1);
     2ce:	83 ec 0c             	sub    $0xc,%esp
     2d1:	6a 01                	push   $0x1
     2d3:	e8 8a 0a 00 00       	call   d62 <exit>
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
     2d8:	83 ec 0c             	sub    $0xc,%esp
     2db:	68 1a 12 00 00       	push   $0x121a
     2e0:	e8 7b fe ff ff       	call   160 <panic>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
     2e5:	51                   	push   %ecx
     2e6:	ff 73 08             	pushl  0x8(%ebx)
     2e9:	68 0a 12 00 00       	push   $0x120a
     2ee:	6a 02                	push   $0x2
     2f0:	e8 db 0b 00 00       	call   ed0 <printf>
      exit(1);
     2f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2fc:	e8 61 0a 00 00       	call   d62 <exit>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
     301:	83 ec 0c             	sub    $0xc,%esp
     304:	68 1f 12 00 00       	push   $0x121f
     309:	e8 52 fe ff ff       	call   160 <panic>
    if(fork1() == 0){
      close(1);
     30e:	83 ec 0c             	sub    $0xc,%esp
     311:	6a 01                	push   $0x1
     313:	e8 72 0a 00 00       	call   d8a <close>
      dup(p[1]);
     318:	58                   	pop    %eax
     319:	ff 75 f4             	pushl  -0xc(%ebp)
     31c:	e8 b9 0a 00 00       	call   dda <dup>
      close(p[0]);
     321:	58                   	pop    %eax
     322:	ff 75 f0             	pushl  -0x10(%ebp)
     325:	e8 60 0a 00 00       	call   d8a <close>
      close(p[1]);
     32a:	58                   	pop    %eax
     32b:	ff 75 f4             	pushl  -0xc(%ebp)
     32e:	e8 57 0a 00 00       	call   d8a <close>
      runcmd(pcmd->left);
     333:	58                   	pop    %eax
     334:	ff 73 04             	pushl  0x4(%ebx)
     337:	e8 54 fe ff ff       	call   190 <runcmd>
    }
    if(fork1() == 0){
      close(0);
     33c:	83 ec 0c             	sub    $0xc,%esp
     33f:	6a 00                	push   $0x0
     341:	e8 44 0a 00 00       	call   d8a <close>
      dup(p[0]);
     346:	5a                   	pop    %edx
     347:	ff 75 f0             	pushl  -0x10(%ebp)
     34a:	e8 8b 0a 00 00       	call   dda <dup>
      close(p[0]);
     34f:	59                   	pop    %ecx
     350:	ff 75 f0             	pushl  -0x10(%ebp)
     353:	e8 32 0a 00 00       	call   d8a <close>
      close(p[1]);
     358:	58                   	pop    %eax
     359:	ff 75 f4             	pushl  -0xc(%ebp)
     35c:	e8 29 0a 00 00       	call   d8a <close>
      runcmd(pcmd->right);
     361:	58                   	pop    %eax
     362:	ff 73 08             	pushl  0x8(%ebx)
     365:	e8 26 fe ff ff       	call   190 <runcmd>
     36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000370 <fork1>:
  exit(0);
}

int
fork1(void)
{
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	83 ec 08             	sub    $0x8,%esp
  int pid;

  pid = fork();
     376:	e8 df 09 00 00       	call   d5a <fork>
  if(pid == -1)
     37b:	83 f8 ff             	cmp    $0xffffffff,%eax
     37e:	74 02                	je     382 <fork1+0x12>
    panic("fork");
  return pid;
}
     380:	c9                   	leave  
     381:	c3                   	ret    
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
     382:	83 ec 0c             	sub    $0xc,%esp
     385:	68 1a 12 00 00       	push   $0x121a
     38a:	e8 d1 fd ff ff       	call   160 <panic>
     38f:	90                   	nop

00000390 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     390:	55                   	push   %ebp
     391:	89 e5                	mov    %esp,%ebp
     393:	53                   	push   %ebx
     394:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     397:	6a 54                	push   $0x54
     399:	e8 62 0d 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     39e:	83 c4 0c             	add    $0xc,%esp
struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3a3:	6a 54                	push   $0x54
     3a5:	6a 00                	push   $0x0
     3a7:	50                   	push   %eax
     3a8:	e8 23 08 00 00       	call   bd0 <memset>
  cmd->type = EXEC;
     3ad:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     3b3:	89 d8                	mov    %ebx,%eax
     3b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3b8:	c9                   	leave  
     3b9:	c3                   	ret    
     3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003c0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	53                   	push   %ebx
     3c4:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c7:	6a 18                	push   $0x18
     3c9:	e8 32 0d 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3ce:	83 c4 0c             	add    $0xc,%esp
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3d3:	6a 18                	push   $0x18
     3d5:	6a 00                	push   $0x0
     3d7:	50                   	push   %eax
     3d8:	e8 f3 07 00 00       	call   bd0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3dd:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
     3e0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3e6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ec:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3ef:	8b 45 10             	mov    0x10(%ebp),%eax
     3f2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3f5:	8b 45 14             	mov    0x14(%ebp),%eax
     3f8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3fb:	8b 45 18             	mov    0x18(%ebp),%eax
     3fe:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     401:	89 d8                	mov    %ebx,%eax
     403:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     406:	c9                   	leave  
     407:	c3                   	ret    
     408:	90                   	nop
     409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	53                   	push   %ebx
     414:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     417:	6a 0c                	push   $0xc
     419:	e8 e2 0c 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     41e:	83 c4 0c             	add    $0xc,%esp
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     421:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     423:	6a 0c                	push   $0xc
     425:	6a 00                	push   $0x0
     427:	50                   	push   %eax
     428:	e8 a3 07 00 00       	call   bd0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     42d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
     430:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     436:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     439:	8b 45 0c             	mov    0xc(%ebp),%eax
     43c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     43f:	89 d8                	mov    %ebx,%eax
     441:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     444:	c9                   	leave  
     445:	c3                   	ret    
     446:	8d 76 00             	lea    0x0(%esi),%esi
     449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	53                   	push   %ebx
     454:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     457:	6a 0c                	push   $0xc
     459:	e8 a2 0c 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     45e:	83 c4 0c             	add    $0xc,%esp
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     461:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     463:	6a 0c                	push   $0xc
     465:	6a 00                	push   $0x0
     467:	50                   	push   %eax
     468:	e8 63 07 00 00       	call   bd0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     46d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
     470:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     476:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     479:	8b 45 0c             	mov    0xc(%ebp),%eax
     47c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     47f:	89 d8                	mov    %ebx,%eax
     481:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     484:	c9                   	leave  
     485:	c3                   	ret    
     486:	8d 76 00             	lea    0x0(%esi),%esi
     489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000490 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	53                   	push   %ebx
     494:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     497:	6a 08                	push   $0x8
     499:	e8 62 0c 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     49e:	83 c4 0c             	add    $0xc,%esp
struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4a3:	6a 08                	push   $0x8
     4a5:	6a 00                	push   $0x0
     4a7:	50                   	push   %eax
     4a8:	e8 23 07 00 00       	call   bd0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     4ad:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
     4b0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     4b6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     4b9:	89 d8                	mov    %ebx,%eax
     4bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4be:	c9                   	leave  
     4bf:	c3                   	ret    

000004c0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	57                   	push   %edi
     4c4:	56                   	push   %esi
     4c5:	53                   	push   %ebx
     4c6:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     4c9:	8b 45 08             	mov    0x8(%ebp),%eax
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4cf:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
     4d2:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     4d4:	39 df                	cmp    %ebx,%edi
     4d6:	72 13                	jb     4eb <gettoken+0x2b>
     4d8:	eb 29                	jmp    503 <gettoken+0x43>
     4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     4e0:	83 c7 01             	add    $0x1,%edi
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     4e3:	39 fb                	cmp    %edi,%ebx
     4e5:	0f 84 ed 00 00 00    	je     5d8 <gettoken+0x118>
     4eb:	0f be 07             	movsbl (%edi),%eax
     4ee:	83 ec 08             	sub    $0x8,%esp
     4f1:	50                   	push   %eax
     4f2:	68 9c 18 00 00       	push   $0x189c
     4f7:	e8 f4 06 00 00       	call   bf0 <strchr>
     4fc:	83 c4 10             	add    $0x10,%esp
     4ff:	85 c0                	test   %eax,%eax
     501:	75 dd                	jne    4e0 <gettoken+0x20>
    s++;
  if(q)
     503:	85 f6                	test   %esi,%esi
     505:	74 02                	je     509 <gettoken+0x49>
    *q = s;
     507:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     509:	0f be 37             	movsbl (%edi),%esi
     50c:	89 f1                	mov    %esi,%ecx
     50e:	89 f0                	mov    %esi,%eax
  switch(*s){
     510:	80 f9 29             	cmp    $0x29,%cl
     513:	7f 5b                	jg     570 <gettoken+0xb0>
     515:	80 f9 28             	cmp    $0x28,%cl
     518:	7d 61                	jge    57b <gettoken+0xbb>
     51a:	84 c9                	test   %cl,%cl
     51c:	0f 85 de 00 00 00    	jne    600 <gettoken+0x140>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     522:	8b 55 14             	mov    0x14(%ebp),%edx
     525:	85 d2                	test   %edx,%edx
     527:	74 05                	je     52e <gettoken+0x6e>
    *eq = s;
     529:	8b 45 14             	mov    0x14(%ebp),%eax
     52c:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     52e:	39 fb                	cmp    %edi,%ebx
     530:	77 0d                	ja     53f <gettoken+0x7f>
     532:	eb 23                	jmp    557 <gettoken+0x97>
     534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     538:	83 c7 01             	add    $0x1,%edi
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
     53b:	39 fb                	cmp    %edi,%ebx
     53d:	74 18                	je     557 <gettoken+0x97>
     53f:	0f be 07             	movsbl (%edi),%eax
     542:	83 ec 08             	sub    $0x8,%esp
     545:	50                   	push   %eax
     546:	68 9c 18 00 00       	push   $0x189c
     54b:	e8 a0 06 00 00       	call   bf0 <strchr>
     550:	83 c4 10             	add    $0x10,%esp
     553:	85 c0                	test   %eax,%eax
     555:	75 e1                	jne    538 <gettoken+0x78>
    s++;
  *ps = s;
     557:	8b 45 08             	mov    0x8(%ebp),%eax
     55a:	89 38                	mov    %edi,(%eax)
  return ret;
}
     55c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     55f:	89 f0                	mov    %esi,%eax
     561:	5b                   	pop    %ebx
     562:	5e                   	pop    %esi
     563:	5f                   	pop    %edi
     564:	5d                   	pop    %ebp
     565:	c3                   	ret    
     566:	8d 76 00             	lea    0x0(%esi),%esi
     569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     570:	80 f9 3e             	cmp    $0x3e,%cl
     573:	75 0b                	jne    580 <gettoken+0xc0>
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
     575:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     579:	74 75                	je     5f0 <gettoken+0x130>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     57b:	83 c7 01             	add    $0x1,%edi
     57e:	eb a2                	jmp    522 <gettoken+0x62>
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     580:	7f 5e                	jg     5e0 <gettoken+0x120>
     582:	83 e9 3b             	sub    $0x3b,%ecx
     585:	80 f9 01             	cmp    $0x1,%cl
     588:	76 f1                	jbe    57b <gettoken+0xbb>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     58a:	39 fb                	cmp    %edi,%ebx
     58c:	77 24                	ja     5b2 <gettoken+0xf2>
     58e:	eb 7c                	jmp    60c <gettoken+0x14c>
     590:	0f be 07             	movsbl (%edi),%eax
     593:	83 ec 08             	sub    $0x8,%esp
     596:	50                   	push   %eax
     597:	68 94 18 00 00       	push   $0x1894
     59c:	e8 4f 06 00 00       	call   bf0 <strchr>
     5a1:	83 c4 10             	add    $0x10,%esp
     5a4:	85 c0                	test   %eax,%eax
     5a6:	75 1f                	jne    5c7 <gettoken+0x107>
      s++;
     5a8:	83 c7 01             	add    $0x1,%edi
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5ab:	39 fb                	cmp    %edi,%ebx
     5ad:	74 5b                	je     60a <gettoken+0x14a>
     5af:	0f be 07             	movsbl (%edi),%eax
     5b2:	83 ec 08             	sub    $0x8,%esp
     5b5:	50                   	push   %eax
     5b6:	68 9c 18 00 00       	push   $0x189c
     5bb:	e8 30 06 00 00       	call   bf0 <strchr>
     5c0:	83 c4 10             	add    $0x10,%esp
     5c3:	85 c0                	test   %eax,%eax
     5c5:	74 c9                	je     590 <gettoken+0xd0>
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
     5c7:	be 61 00 00 00       	mov    $0x61,%esi
     5cc:	e9 51 ff ff ff       	jmp    522 <gettoken+0x62>
     5d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5d8:	89 df                	mov    %ebx,%edi
     5da:	e9 24 ff ff ff       	jmp    503 <gettoken+0x43>
     5df:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     5e0:	80 f9 7c             	cmp    $0x7c,%cl
     5e3:	74 96                	je     57b <gettoken+0xbb>
     5e5:	eb a3                	jmp    58a <gettoken+0xca>
     5e7:	89 f6                	mov    %esi,%esi
     5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
     5f0:	83 c7 02             	add    $0x2,%edi
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
     5f3:	be 2b 00 00 00       	mov    $0x2b,%esi
     5f8:	e9 25 ff ff ff       	jmp    522 <gettoken+0x62>
     5fd:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     600:	80 f9 26             	cmp    $0x26,%cl
     603:	75 85                	jne    58a <gettoken+0xca>
     605:	e9 71 ff ff ff       	jmp    57b <gettoken+0xbb>
     60a:	89 df                	mov    %ebx,%edi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     60c:	8b 45 14             	mov    0x14(%ebp),%eax
     60f:	be 61 00 00 00       	mov    $0x61,%esi
     614:	85 c0                	test   %eax,%eax
     616:	0f 85 0d ff ff ff    	jne    529 <gettoken+0x69>
     61c:	e9 36 ff ff ff       	jmp    557 <gettoken+0x97>
     621:	eb 0d                	jmp    630 <peek>
     623:	90                   	nop
     624:	90                   	nop
     625:	90                   	nop
     626:	90                   	nop
     627:	90                   	nop
     628:	90                   	nop
     629:	90                   	nop
     62a:	90                   	nop
     62b:	90                   	nop
     62c:	90                   	nop
     62d:	90                   	nop
     62e:	90                   	nop
     62f:	90                   	nop

00000630 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	57                   	push   %edi
     634:	56                   	push   %esi
     635:	53                   	push   %ebx
     636:	83 ec 0c             	sub    $0xc,%esp
     639:	8b 7d 08             	mov    0x8(%ebp),%edi
     63c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     63f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     641:	39 f3                	cmp    %esi,%ebx
     643:	72 12                	jb     657 <peek+0x27>
     645:	eb 28                	jmp    66f <peek+0x3f>
     647:	89 f6                	mov    %esi,%esi
     649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     650:	83 c3 01             	add    $0x1,%ebx
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     653:	39 de                	cmp    %ebx,%esi
     655:	74 18                	je     66f <peek+0x3f>
     657:	0f be 03             	movsbl (%ebx),%eax
     65a:	83 ec 08             	sub    $0x8,%esp
     65d:	50                   	push   %eax
     65e:	68 9c 18 00 00       	push   $0x189c
     663:	e8 88 05 00 00       	call   bf0 <strchr>
     668:	83 c4 10             	add    $0x10,%esp
     66b:	85 c0                	test   %eax,%eax
     66d:	75 e1                	jne    650 <peek+0x20>
    s++;
  *ps = s;
     66f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     671:	0f be 13             	movsbl (%ebx),%edx
     674:	31 c0                	xor    %eax,%eax
     676:	84 d2                	test   %dl,%dl
     678:	74 17                	je     691 <peek+0x61>
     67a:	83 ec 08             	sub    $0x8,%esp
     67d:	52                   	push   %edx
     67e:	ff 75 10             	pushl  0x10(%ebp)
     681:	e8 6a 05 00 00       	call   bf0 <strchr>
     686:	83 c4 10             	add    $0x10,%esp
     689:	85 c0                	test   %eax,%eax
     68b:	0f 95 c0             	setne  %al
     68e:	0f b6 c0             	movzbl %al,%eax
}
     691:	8d 65 f4             	lea    -0xc(%ebp),%esp
     694:	5b                   	pop    %ebx
     695:	5e                   	pop    %esi
     696:	5f                   	pop    %edi
     697:	5d                   	pop    %ebp
     698:	c3                   	ret    
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006a0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	57                   	push   %edi
     6a4:	56                   	push   %esi
     6a5:	53                   	push   %ebx
     6a6:	83 ec 1c             	sub    $0x1c,%esp
     6a9:	8b 75 0c             	mov    0xc(%ebp),%esi
     6ac:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6af:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6b0:	83 ec 04             	sub    $0x4,%esp
     6b3:	68 41 12 00 00       	push   $0x1241
     6b8:	53                   	push   %ebx
     6b9:	56                   	push   %esi
     6ba:	e8 71 ff ff ff       	call   630 <peek>
     6bf:	83 c4 10             	add    $0x10,%esp
     6c2:	85 c0                	test   %eax,%eax
     6c4:	74 6a                	je     730 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     6c6:	6a 00                	push   $0x0
     6c8:	6a 00                	push   $0x0
     6ca:	53                   	push   %ebx
     6cb:	56                   	push   %esi
     6cc:	e8 ef fd ff ff       	call   4c0 <gettoken>
     6d1:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     6d3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     6d6:	50                   	push   %eax
     6d7:	8d 45 e0             	lea    -0x20(%ebp),%eax
     6da:	50                   	push   %eax
     6db:	53                   	push   %ebx
     6dc:	56                   	push   %esi
     6dd:	e8 de fd ff ff       	call   4c0 <gettoken>
     6e2:	83 c4 20             	add    $0x20,%esp
     6e5:	83 f8 61             	cmp    $0x61,%eax
     6e8:	75 51                	jne    73b <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     6ea:	83 ff 3c             	cmp    $0x3c,%edi
     6ed:	74 31                	je     720 <parseredirs+0x80>
     6ef:	83 ff 3e             	cmp    $0x3e,%edi
     6f2:	74 05                	je     6f9 <parseredirs+0x59>
     6f4:	83 ff 2b             	cmp    $0x2b,%edi
     6f7:	75 b7                	jne    6b0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6f9:	83 ec 0c             	sub    $0xc,%esp
     6fc:	6a 01                	push   $0x1
     6fe:	68 01 02 00 00       	push   $0x201
     703:	ff 75 e4             	pushl  -0x1c(%ebp)
     706:	ff 75 e0             	pushl  -0x20(%ebp)
     709:	ff 75 08             	pushl  0x8(%ebp)
     70c:	e8 af fc ff ff       	call   3c0 <redircmd>
      break;
     711:	83 c4 20             	add    $0x20,%esp
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     714:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     717:	eb 97                	jmp    6b0 <parseredirs+0x10>
     719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     720:	83 ec 0c             	sub    $0xc,%esp
     723:	6a 00                	push   $0x0
     725:	6a 00                	push   $0x0
     727:	eb da                	jmp    703 <parseredirs+0x63>
     729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
     730:	8b 45 08             	mov    0x8(%ebp),%eax
     733:	8d 65 f4             	lea    -0xc(%ebp),%esp
     736:	5b                   	pop    %ebx
     737:	5e                   	pop    %esi
     738:	5f                   	pop    %edi
     739:	5d                   	pop    %ebp
     73a:	c3                   	ret    
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
     73b:	83 ec 0c             	sub    $0xc,%esp
     73e:	68 24 12 00 00       	push   $0x1224
     743:	e8 18 fa ff ff       	call   160 <panic>
     748:	90                   	nop
     749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000750 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	57                   	push   %edi
     754:	56                   	push   %esi
     755:	53                   	push   %ebx
     756:	83 ec 30             	sub    $0x30,%esp
     759:	8b 75 08             	mov    0x8(%ebp),%esi
     75c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     75f:	68 44 12 00 00       	push   $0x1244
     764:	57                   	push   %edi
     765:	56                   	push   %esi
     766:	e8 c5 fe ff ff       	call   630 <peek>
     76b:	83 c4 10             	add    $0x10,%esp
     76e:	85 c0                	test   %eax,%eax
     770:	0f 85 9a 00 00 00    	jne    810 <parseexec+0xc0>
    return parseblock(ps, es);

  ret = execcmd();
     776:	e8 15 fc ff ff       	call   390 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     77b:	83 ec 04             	sub    $0x4,%esp
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
     77e:	89 c3                	mov    %eax,%ebx
     780:	89 45 cc             	mov    %eax,-0x34(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     783:	57                   	push   %edi
     784:	56                   	push   %esi
     785:	8d 5b 04             	lea    0x4(%ebx),%ebx
     788:	50                   	push   %eax
     789:	e8 12 ff ff ff       	call   6a0 <parseredirs>
     78e:	83 c4 10             	add    $0x10,%esp
     791:	89 45 d0             	mov    %eax,-0x30(%ebp)
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
     794:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     79b:	eb 16                	jmp    7b3 <parseexec+0x63>
     79d:	8d 76 00             	lea    0x0(%esi),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     7a0:	83 ec 04             	sub    $0x4,%esp
     7a3:	57                   	push   %edi
     7a4:	56                   	push   %esi
     7a5:	ff 75 d0             	pushl  -0x30(%ebp)
     7a8:	e8 f3 fe ff ff       	call   6a0 <parseredirs>
     7ad:	83 c4 10             	add    $0x10,%esp
     7b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     7b3:	83 ec 04             	sub    $0x4,%esp
     7b6:	68 5b 12 00 00       	push   $0x125b
     7bb:	57                   	push   %edi
     7bc:	56                   	push   %esi
     7bd:	e8 6e fe ff ff       	call   630 <peek>
     7c2:	83 c4 10             	add    $0x10,%esp
     7c5:	85 c0                	test   %eax,%eax
     7c7:	75 5f                	jne    828 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     7c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     7cc:	50                   	push   %eax
     7cd:	8d 45 e0             	lea    -0x20(%ebp),%eax
     7d0:	50                   	push   %eax
     7d1:	57                   	push   %edi
     7d2:	56                   	push   %esi
     7d3:	e8 e8 fc ff ff       	call   4c0 <gettoken>
     7d8:	83 c4 10             	add    $0x10,%esp
     7db:	85 c0                	test   %eax,%eax
     7dd:	74 49                	je     828 <parseexec+0xd8>
      break;
    if(tok != 'a')
     7df:	83 f8 61             	cmp    $0x61,%eax
     7e2:	75 66                	jne    84a <parseexec+0xfa>
      panic("syntax");
    cmd->argv[argc] = q;
     7e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    cmd->eargv[argc] = eq;
    argc++;
     7e7:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
     7eb:	83 c3 04             	add    $0x4,%ebx
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
     7ee:	89 43 fc             	mov    %eax,-0x4(%ebx)
    cmd->eargv[argc] = eq;
     7f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7f4:	89 43 24             	mov    %eax,0x24(%ebx)
    argc++;
     7f7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    if(argc >= MAXARGS)
     7fa:	83 f8 0a             	cmp    $0xa,%eax
     7fd:	75 a1                	jne    7a0 <parseexec+0x50>
      panic("too many args");
     7ff:	83 ec 0c             	sub    $0xc,%esp
     802:	68 4d 12 00 00       	push   $0x124d
     807:	e8 54 f9 ff ff       	call   160 <panic>
     80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);
     810:	83 ec 08             	sub    $0x8,%esp
     813:	57                   	push   %edi
     814:	56                   	push   %esi
     815:	e8 56 01 00 00       	call   970 <parseblock>
     81a:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     81d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     820:	5b                   	pop    %ebx
     821:	5e                   	pop    %esi
     822:	5f                   	pop    %edi
     823:	5d                   	pop    %ebp
     824:	c3                   	ret    
     825:	8d 76 00             	lea    0x0(%esi),%esi
     828:	8b 45 cc             	mov    -0x34(%ebp),%eax
     82b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     82e:	8d 04 90             	lea    (%eax,%edx,4),%eax
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     831:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     838:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
     83f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  return ret;
}
     842:	8d 65 f4             	lea    -0xc(%ebp),%esp
     845:	5b                   	pop    %ebx
     846:	5e                   	pop    %esi
     847:	5f                   	pop    %edi
     848:	5d                   	pop    %ebp
     849:	c3                   	ret    
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
     84a:	83 ec 0c             	sub    $0xc,%esp
     84d:	68 46 12 00 00       	push   $0x1246
     852:	e8 09 f9 ff ff       	call   160 <panic>
     857:	89 f6                	mov    %esi,%esi
     859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000860 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	57                   	push   %edi
     864:	56                   	push   %esi
     865:	53                   	push   %ebx
     866:	83 ec 14             	sub    $0x14,%esp
     869:	8b 5d 08             	mov    0x8(%ebp),%ebx
     86c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     86f:	56                   	push   %esi
     870:	53                   	push   %ebx
     871:	e8 da fe ff ff       	call   750 <parseexec>
  if(peek(ps, es, "|")){
     876:	83 c4 0c             	add    $0xc,%esp
struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     879:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     87b:	68 60 12 00 00       	push   $0x1260
     880:	56                   	push   %esi
     881:	53                   	push   %ebx
     882:	e8 a9 fd ff ff       	call   630 <peek>
     887:	83 c4 10             	add    $0x10,%esp
     88a:	85 c0                	test   %eax,%eax
     88c:	75 12                	jne    8a0 <parsepipe+0x40>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
     88e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     891:	89 f8                	mov    %edi,%eax
     893:	5b                   	pop    %ebx
     894:	5e                   	pop    %esi
     895:	5f                   	pop    %edi
     896:	5d                   	pop    %ebp
     897:	c3                   	ret    
     898:	90                   	nop
     899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
     8a0:	6a 00                	push   $0x0
     8a2:	6a 00                	push   $0x0
     8a4:	56                   	push   %esi
     8a5:	53                   	push   %ebx
     8a6:	e8 15 fc ff ff       	call   4c0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8ab:	58                   	pop    %eax
     8ac:	5a                   	pop    %edx
     8ad:	56                   	push   %esi
     8ae:	53                   	push   %ebx
     8af:	e8 ac ff ff ff       	call   860 <parsepipe>
     8b4:	89 7d 08             	mov    %edi,0x8(%ebp)
     8b7:	89 45 0c             	mov    %eax,0xc(%ebp)
     8ba:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     8bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8c0:	5b                   	pop    %ebx
     8c1:	5e                   	pop    %esi
     8c2:	5f                   	pop    %edi
     8c3:	5d                   	pop    %ebp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8c4:	e9 47 fb ff ff       	jmp    410 <pipecmd>
     8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008d0 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
     8d6:	83 ec 14             	sub    $0x14,%esp
     8d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     8df:	56                   	push   %esi
     8e0:	53                   	push   %ebx
     8e1:	e8 7a ff ff ff       	call   860 <parsepipe>
  while(peek(ps, es, "&")){
     8e6:	83 c4 10             	add    $0x10,%esp
struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     8e9:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8eb:	eb 1b                	jmp    908 <parseline+0x38>
     8ed:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8f0:	6a 00                	push   $0x0
     8f2:	6a 00                	push   $0x0
     8f4:	56                   	push   %esi
     8f5:	53                   	push   %ebx
     8f6:	e8 c5 fb ff ff       	call   4c0 <gettoken>
    cmd = backcmd(cmd);
     8fb:	89 3c 24             	mov    %edi,(%esp)
     8fe:	e8 8d fb ff ff       	call   490 <backcmd>
     903:	83 c4 10             	add    $0x10,%esp
     906:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     908:	83 ec 04             	sub    $0x4,%esp
     90b:	68 62 12 00 00       	push   $0x1262
     910:	56                   	push   %esi
     911:	53                   	push   %ebx
     912:	e8 19 fd ff ff       	call   630 <peek>
     917:	83 c4 10             	add    $0x10,%esp
     91a:	85 c0                	test   %eax,%eax
     91c:	75 d2                	jne    8f0 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     91e:	83 ec 04             	sub    $0x4,%esp
     921:	68 5e 12 00 00       	push   $0x125e
     926:	56                   	push   %esi
     927:	53                   	push   %ebx
     928:	e8 03 fd ff ff       	call   630 <peek>
     92d:	83 c4 10             	add    $0x10,%esp
     930:	85 c0                	test   %eax,%eax
     932:	75 0c                	jne    940 <parseline+0x70>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
     934:	8d 65 f4             	lea    -0xc(%ebp),%esp
     937:	89 f8                	mov    %edi,%eax
     939:	5b                   	pop    %ebx
     93a:	5e                   	pop    %esi
     93b:	5f                   	pop    %edi
     93c:	5d                   	pop    %ebp
     93d:	c3                   	ret    
     93e:	66 90                	xchg   %ax,%ax
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
     940:	6a 00                	push   $0x0
     942:	6a 00                	push   $0x0
     944:	56                   	push   %esi
     945:	53                   	push   %ebx
     946:	e8 75 fb ff ff       	call   4c0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     94b:	58                   	pop    %eax
     94c:	5a                   	pop    %edx
     94d:	56                   	push   %esi
     94e:	53                   	push   %ebx
     94f:	e8 7c ff ff ff       	call   8d0 <parseline>
     954:	89 7d 08             	mov    %edi,0x8(%ebp)
     957:	89 45 0c             	mov    %eax,0xc(%ebp)
     95a:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     95d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     960:	5b                   	pop    %ebx
     961:	5e                   	pop    %esi
     962:	5f                   	pop    %edi
     963:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
     964:	e9 e7 fa ff ff       	jmp    450 <listcmd>
     969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000970 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	57                   	push   %edi
     974:	56                   	push   %esi
     975:	53                   	push   %ebx
     976:	83 ec 10             	sub    $0x10,%esp
     979:	8b 5d 08             	mov    0x8(%ebp),%ebx
     97c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     97f:	68 44 12 00 00       	push   $0x1244
     984:	56                   	push   %esi
     985:	53                   	push   %ebx
     986:	e8 a5 fc ff ff       	call   630 <peek>
     98b:	83 c4 10             	add    $0x10,%esp
     98e:	85 c0                	test   %eax,%eax
     990:	74 4a                	je     9dc <parseblock+0x6c>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
     992:	6a 00                	push   $0x0
     994:	6a 00                	push   $0x0
     996:	56                   	push   %esi
     997:	53                   	push   %ebx
     998:	e8 23 fb ff ff       	call   4c0 <gettoken>
  cmd = parseline(ps, es);
     99d:	58                   	pop    %eax
     99e:	5a                   	pop    %edx
     99f:	56                   	push   %esi
     9a0:	53                   	push   %ebx
     9a1:	e8 2a ff ff ff       	call   8d0 <parseline>
  if(!peek(ps, es, ")"))
     9a6:	83 c4 0c             	add    $0xc,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
     9a9:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     9ab:	68 80 12 00 00       	push   $0x1280
     9b0:	56                   	push   %esi
     9b1:	53                   	push   %ebx
     9b2:	e8 79 fc ff ff       	call   630 <peek>
     9b7:	83 c4 10             	add    $0x10,%esp
     9ba:	85 c0                	test   %eax,%eax
     9bc:	74 2b                	je     9e9 <parseblock+0x79>
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
     9be:	6a 00                	push   $0x0
     9c0:	6a 00                	push   $0x0
     9c2:	56                   	push   %esi
     9c3:	53                   	push   %ebx
     9c4:	e8 f7 fa ff ff       	call   4c0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9c9:	83 c4 0c             	add    $0xc,%esp
     9cc:	56                   	push   %esi
     9cd:	53                   	push   %ebx
     9ce:	57                   	push   %edi
     9cf:	e8 cc fc ff ff       	call   6a0 <parseredirs>
  return cmd;
}
     9d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9d7:	5b                   	pop    %ebx
     9d8:	5e                   	pop    %esi
     9d9:	5f                   	pop    %edi
     9da:	5d                   	pop    %ebp
     9db:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
     9dc:	83 ec 0c             	sub    $0xc,%esp
     9df:	68 64 12 00 00       	push   $0x1264
     9e4:	e8 77 f7 ff ff       	call   160 <panic>
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
     9e9:	83 ec 0c             	sub    $0xc,%esp
     9ec:	68 6f 12 00 00       	push   $0x126f
     9f1:	e8 6a f7 ff ff       	call   160 <panic>
     9f6:	8d 76 00             	lea    0x0(%esi),%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a00 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	53                   	push   %ebx
     a04:	83 ec 04             	sub    $0x4,%esp
     a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     a0a:	85 db                	test   %ebx,%ebx
     a0c:	0f 84 96 00 00 00    	je     aa8 <nulterminate+0xa8>
    return 0;

  switch(cmd->type){
     a12:	83 3b 05             	cmpl   $0x5,(%ebx)
     a15:	77 48                	ja     a5f <nulterminate+0x5f>
     a17:	8b 03                	mov    (%ebx),%eax
     a19:	ff 24 85 c0 12 00 00 	jmp    *0x12c0(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     a20:	83 ec 0c             	sub    $0xc,%esp
     a23:	ff 73 04             	pushl  0x4(%ebx)
     a26:	e8 d5 ff ff ff       	call   a00 <nulterminate>
    nulterminate(lcmd->right);
     a2b:	58                   	pop    %eax
     a2c:	ff 73 08             	pushl  0x8(%ebx)
     a2f:	e8 cc ff ff ff       	call   a00 <nulterminate>
    break;
     a34:	83 c4 10             	add    $0x10,%esp
     a37:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a39:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a3c:	c9                   	leave  
     a3d:	c3                   	ret    
     a3e:	66 90                	xchg   %ax,%ax
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     a40:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a43:	8d 43 2c             	lea    0x2c(%ebx),%eax
     a46:	85 c9                	test   %ecx,%ecx
     a48:	74 15                	je     a5f <nulterminate+0x5f>
     a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a50:	8b 10                	mov    (%eax),%edx
     a52:	83 c0 04             	add    $0x4,%eax
     a55:	c6 02 00             	movb   $0x0,(%edx)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     a58:	8b 50 d8             	mov    -0x28(%eax),%edx
     a5b:	85 d2                	test   %edx,%edx
     a5d:	75 f1                	jne    a50 <nulterminate+0x50>
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
     a5f:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a64:	c9                   	leave  
     a65:	c3                   	ret    
     a66:	8d 76 00             	lea    0x0(%esi),%esi
     a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     a70:	83 ec 0c             	sub    $0xc,%esp
     a73:	ff 73 04             	pushl  0x4(%ebx)
     a76:	e8 85 ff ff ff       	call   a00 <nulterminate>
    break;
     a7b:	89 d8                	mov    %ebx,%eax
     a7d:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     a80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a83:	c9                   	leave  
     a84:	c3                   	ret    
     a85:	8d 76 00             	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     a88:	83 ec 0c             	sub    $0xc,%esp
     a8b:	ff 73 04             	pushl  0x4(%ebx)
     a8e:	e8 6d ff ff ff       	call   a00 <nulterminate>
    *rcmd->efile = 0;
     a93:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a96:	83 c4 10             	add    $0x10,%esp
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
     a99:	c6 00 00             	movb   $0x0,(%eax)
    break;
     a9c:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     aa1:	c9                   	leave  
     aa2:	c3                   	ret    
     aa3:	90                   	nop
     aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
     aa8:	31 c0                	xor    %eax,%eax
     aaa:	eb 8d                	jmp    a39 <nulterminate+0x39>
     aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ab0 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	56                   	push   %esi
     ab4:	53                   	push   %ebx
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     ab5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ab8:	83 ec 0c             	sub    $0xc,%esp
     abb:	53                   	push   %ebx
     abc:	e8 df 00 00 00       	call   ba0 <strlen>
  cmd = parseline(&s, es);
     ac1:	59                   	pop    %ecx
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     ac2:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     ac4:	8d 45 08             	lea    0x8(%ebp),%eax
     ac7:	5e                   	pop    %esi
     ac8:	53                   	push   %ebx
     ac9:	50                   	push   %eax
     aca:	e8 01 fe ff ff       	call   8d0 <parseline>
     acf:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     ad1:	8d 45 08             	lea    0x8(%ebp),%eax
     ad4:	83 c4 0c             	add    $0xc,%esp
     ad7:	68 09 12 00 00       	push   $0x1209
     adc:	53                   	push   %ebx
     add:	50                   	push   %eax
     ade:	e8 4d fb ff ff       	call   630 <peek>
  if(s != es){
     ae3:	8b 45 08             	mov    0x8(%ebp),%eax
     ae6:	83 c4 10             	add    $0x10,%esp
     ae9:	39 c3                	cmp    %eax,%ebx
     aeb:	75 12                	jne    aff <parsecmd+0x4f>
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
     aed:	83 ec 0c             	sub    $0xc,%esp
     af0:	56                   	push   %esi
     af1:	e8 0a ff ff ff       	call   a00 <nulterminate>
  return cmd;
}
     af6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     af9:	89 f0                	mov    %esi,%eax
     afb:	5b                   	pop    %ebx
     afc:	5e                   	pop    %esi
     afd:	5d                   	pop    %ebp
     afe:	c3                   	ret    

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
     aff:	52                   	push   %edx
     b00:	50                   	push   %eax
     b01:	68 82 12 00 00       	push   $0x1282
     b06:	6a 02                	push   $0x2
     b08:	e8 c3 03 00 00       	call   ed0 <printf>
    panic("syntax");
     b0d:	c7 04 24 46 12 00 00 	movl   $0x1246,(%esp)
     b14:	e8 47 f6 ff ff       	call   160 <panic>
     b19:	66 90                	xchg   %ax,%ax
     b1b:	66 90                	xchg   %ax,%ax
     b1d:	66 90                	xchg   %ax,%ax
     b1f:	90                   	nop

00000b20 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	53                   	push   %ebx
     b24:	8b 45 08             	mov    0x8(%ebp),%eax
     b27:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b2a:	89 c2                	mov    %eax,%edx
     b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b30:	83 c1 01             	add    $0x1,%ecx
     b33:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     b37:	83 c2 01             	add    $0x1,%edx
     b3a:	84 db                	test   %bl,%bl
     b3c:	88 5a ff             	mov    %bl,-0x1(%edx)
     b3f:	75 ef                	jne    b30 <strcpy+0x10>
    ;
  return os;
}
     b41:	5b                   	pop    %ebx
     b42:	5d                   	pop    %ebp
     b43:	c3                   	ret    
     b44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b50 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	56                   	push   %esi
     b54:	53                   	push   %ebx
     b55:	8b 55 08             	mov    0x8(%ebp),%edx
     b58:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b5b:	0f b6 02             	movzbl (%edx),%eax
     b5e:	0f b6 19             	movzbl (%ecx),%ebx
     b61:	84 c0                	test   %al,%al
     b63:	75 1e                	jne    b83 <strcmp+0x33>
     b65:	eb 29                	jmp    b90 <strcmp+0x40>
     b67:	89 f6                	mov    %esi,%esi
     b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b70:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     b73:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b76:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     b79:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     b7d:	84 c0                	test   %al,%al
     b7f:	74 0f                	je     b90 <strcmp+0x40>
     b81:	89 f1                	mov    %esi,%ecx
     b83:	38 d8                	cmp    %bl,%al
     b85:	74 e9                	je     b70 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     b87:	29 d8                	sub    %ebx,%eax
}
     b89:	5b                   	pop    %ebx
     b8a:	5e                   	pop    %esi
     b8b:	5d                   	pop    %ebp
     b8c:	c3                   	ret    
     b8d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     b90:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     b92:	29 d8                	sub    %ebx,%eax
}
     b94:	5b                   	pop    %ebx
     b95:	5e                   	pop    %esi
     b96:	5d                   	pop    %ebp
     b97:	c3                   	ret    
     b98:	90                   	nop
     b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ba0 <strlen>:

uint
strlen(const char *s)
{
     ba0:	55                   	push   %ebp
     ba1:	89 e5                	mov    %esp,%ebp
     ba3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     ba6:	80 39 00             	cmpb   $0x0,(%ecx)
     ba9:	74 12                	je     bbd <strlen+0x1d>
     bab:	31 d2                	xor    %edx,%edx
     bad:	8d 76 00             	lea    0x0(%esi),%esi
     bb0:	83 c2 01             	add    $0x1,%edx
     bb3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     bb7:	89 d0                	mov    %edx,%eax
     bb9:	75 f5                	jne    bb0 <strlen+0x10>
    ;
  return n;
}
     bbb:	5d                   	pop    %ebp
     bbc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
     bbd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     bbf:	5d                   	pop    %ebp
     bc0:	c3                   	ret    
     bc1:	eb 0d                	jmp    bd0 <memset>
     bc3:	90                   	nop
     bc4:	90                   	nop
     bc5:	90                   	nop
     bc6:	90                   	nop
     bc7:	90                   	nop
     bc8:	90                   	nop
     bc9:	90                   	nop
     bca:	90                   	nop
     bcb:	90                   	nop
     bcc:	90                   	nop
     bcd:	90                   	nop
     bce:	90                   	nop
     bcf:	90                   	nop

00000bd0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	57                   	push   %edi
     bd4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     bd7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     bda:	8b 45 0c             	mov    0xc(%ebp),%eax
     bdd:	89 d7                	mov    %edx,%edi
     bdf:	fc                   	cld    
     be0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     be2:	89 d0                	mov    %edx,%eax
     be4:	5f                   	pop    %edi
     be5:	5d                   	pop    %ebp
     be6:	c3                   	ret    
     be7:	89 f6                	mov    %esi,%esi
     be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bf0 <strchr>:

char*
strchr(const char *s, char c)
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	53                   	push   %ebx
     bf4:	8b 45 08             	mov    0x8(%ebp),%eax
     bf7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     bfa:	0f b6 10             	movzbl (%eax),%edx
     bfd:	84 d2                	test   %dl,%dl
     bff:	74 1d                	je     c1e <strchr+0x2e>
    if(*s == c)
     c01:	38 d3                	cmp    %dl,%bl
     c03:	89 d9                	mov    %ebx,%ecx
     c05:	75 0d                	jne    c14 <strchr+0x24>
     c07:	eb 17                	jmp    c20 <strchr+0x30>
     c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c10:	38 ca                	cmp    %cl,%dl
     c12:	74 0c                	je     c20 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     c14:	83 c0 01             	add    $0x1,%eax
     c17:	0f b6 10             	movzbl (%eax),%edx
     c1a:	84 d2                	test   %dl,%dl
     c1c:	75 f2                	jne    c10 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
     c1e:	31 c0                	xor    %eax,%eax
}
     c20:	5b                   	pop    %ebx
     c21:	5d                   	pop    %ebp
     c22:	c3                   	ret    
     c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c30 <gets>:

char*
gets(char *buf, int max)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	57                   	push   %edi
     c34:	56                   	push   %esi
     c35:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c36:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
     c38:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
     c3b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c3e:	eb 29                	jmp    c69 <gets+0x39>
    cc = read(0, &c, 1);
     c40:	83 ec 04             	sub    $0x4,%esp
     c43:	6a 01                	push   $0x1
     c45:	57                   	push   %edi
     c46:	6a 00                	push   $0x0
     c48:	e8 2d 01 00 00       	call   d7a <read>
    if(cc < 1)
     c4d:	83 c4 10             	add    $0x10,%esp
     c50:	85 c0                	test   %eax,%eax
     c52:	7e 1d                	jle    c71 <gets+0x41>
      break;
    buf[i++] = c;
     c54:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c58:	8b 55 08             	mov    0x8(%ebp),%edx
     c5b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
     c5d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
     c5f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     c63:	74 1b                	je     c80 <gets+0x50>
     c65:	3c 0d                	cmp    $0xd,%al
     c67:	74 17                	je     c80 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c69:	8d 5e 01             	lea    0x1(%esi),%ebx
     c6c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c6f:	7c cf                	jl     c40 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     c71:	8b 45 08             	mov    0x8(%ebp),%eax
     c74:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c7b:	5b                   	pop    %ebx
     c7c:	5e                   	pop    %esi
     c7d:	5f                   	pop    %edi
     c7e:	5d                   	pop    %ebp
     c7f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     c80:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c83:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     c85:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     c89:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c8c:	5b                   	pop    %ebx
     c8d:	5e                   	pop    %esi
     c8e:	5f                   	pop    %edi
     c8f:	5d                   	pop    %ebp
     c90:	c3                   	ret    
     c91:	eb 0d                	jmp    ca0 <stat>
     c93:	90                   	nop
     c94:	90                   	nop
     c95:	90                   	nop
     c96:	90                   	nop
     c97:	90                   	nop
     c98:	90                   	nop
     c99:	90                   	nop
     c9a:	90                   	nop
     c9b:	90                   	nop
     c9c:	90                   	nop
     c9d:	90                   	nop
     c9e:	90                   	nop
     c9f:	90                   	nop

00000ca0 <stat>:

int
stat(const char *n, struct stat *st)
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	56                   	push   %esi
     ca4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ca5:	83 ec 08             	sub    $0x8,%esp
     ca8:	6a 00                	push   $0x0
     caa:	ff 75 08             	pushl  0x8(%ebp)
     cad:	e8 f0 00 00 00       	call   da2 <open>
  if(fd < 0)
     cb2:	83 c4 10             	add    $0x10,%esp
     cb5:	85 c0                	test   %eax,%eax
     cb7:	78 27                	js     ce0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     cb9:	83 ec 08             	sub    $0x8,%esp
     cbc:	ff 75 0c             	pushl  0xc(%ebp)
     cbf:	89 c3                	mov    %eax,%ebx
     cc1:	50                   	push   %eax
     cc2:	e8 f3 00 00 00       	call   dba <fstat>
     cc7:	89 c6                	mov    %eax,%esi
  close(fd);
     cc9:	89 1c 24             	mov    %ebx,(%esp)
     ccc:	e8 b9 00 00 00       	call   d8a <close>
  return r;
     cd1:	83 c4 10             	add    $0x10,%esp
     cd4:	89 f0                	mov    %esi,%eax
}
     cd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cd9:	5b                   	pop    %ebx
     cda:	5e                   	pop    %esi
     cdb:	5d                   	pop    %ebp
     cdc:	c3                   	ret    
     cdd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     ce5:	eb ef                	jmp    cd6 <stat+0x36>
     ce7:	89 f6                	mov    %esi,%esi
     ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cf0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	53                   	push   %ebx
     cf4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cf7:	0f be 11             	movsbl (%ecx),%edx
     cfa:	8d 42 d0             	lea    -0x30(%edx),%eax
     cfd:	3c 09                	cmp    $0x9,%al
     cff:	b8 00 00 00 00       	mov    $0x0,%eax
     d04:	77 1f                	ja     d25 <atoi+0x35>
     d06:	8d 76 00             	lea    0x0(%esi),%esi
     d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     d10:	8d 04 80             	lea    (%eax,%eax,4),%eax
     d13:	83 c1 01             	add    $0x1,%ecx
     d16:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d1a:	0f be 11             	movsbl (%ecx),%edx
     d1d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     d20:	80 fb 09             	cmp    $0x9,%bl
     d23:	76 eb                	jbe    d10 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
     d25:	5b                   	pop    %ebx
     d26:	5d                   	pop    %ebp
     d27:	c3                   	ret    
     d28:	90                   	nop
     d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d30 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	56                   	push   %esi
     d34:	53                   	push   %ebx
     d35:	8b 5d 10             	mov    0x10(%ebp),%ebx
     d38:	8b 45 08             	mov    0x8(%ebp),%eax
     d3b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d3e:	85 db                	test   %ebx,%ebx
     d40:	7e 14                	jle    d56 <memmove+0x26>
     d42:	31 d2                	xor    %edx,%edx
     d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     d48:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     d4c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     d4f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d52:	39 da                	cmp    %ebx,%edx
     d54:	75 f2                	jne    d48 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     d56:	5b                   	pop    %ebx
     d57:	5e                   	pop    %esi
     d58:	5d                   	pop    %ebp
     d59:	c3                   	ret    

00000d5a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d5a:	b8 01 00 00 00       	mov    $0x1,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <exit>:
SYSCALL(exit)
     d62:	b8 02 00 00 00       	mov    $0x2,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <wait>:
SYSCALL(wait)
     d6a:	b8 03 00 00 00       	mov    $0x3,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <pipe>:
SYSCALL(pipe)
     d72:	b8 04 00 00 00       	mov    $0x4,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <read>:
SYSCALL(read)
     d7a:	b8 05 00 00 00       	mov    $0x5,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <write>:
SYSCALL(write)
     d82:	b8 10 00 00 00       	mov    $0x10,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <close>:
SYSCALL(close)
     d8a:	b8 15 00 00 00       	mov    $0x15,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <kill>:
SYSCALL(kill)
     d92:	b8 06 00 00 00       	mov    $0x6,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <exec>:
SYSCALL(exec)
     d9a:	b8 07 00 00 00       	mov    $0x7,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <open>:
SYSCALL(open)
     da2:	b8 0f 00 00 00       	mov    $0xf,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <mknod>:
SYSCALL(mknod)
     daa:	b8 11 00 00 00       	mov    $0x11,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <unlink>:
SYSCALL(unlink)
     db2:	b8 12 00 00 00       	mov    $0x12,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    

00000dba <fstat>:
SYSCALL(fstat)
     dba:	b8 08 00 00 00       	mov    $0x8,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    

00000dc2 <link>:
SYSCALL(link)
     dc2:	b8 13 00 00 00       	mov    $0x13,%eax
     dc7:	cd 40                	int    $0x40
     dc9:	c3                   	ret    

00000dca <mkdir>:
SYSCALL(mkdir)
     dca:	b8 14 00 00 00       	mov    $0x14,%eax
     dcf:	cd 40                	int    $0x40
     dd1:	c3                   	ret    

00000dd2 <chdir>:
SYSCALL(chdir)
     dd2:	b8 09 00 00 00       	mov    $0x9,%eax
     dd7:	cd 40                	int    $0x40
     dd9:	c3                   	ret    

00000dda <dup>:
SYSCALL(dup)
     dda:	b8 0a 00 00 00       	mov    $0xa,%eax
     ddf:	cd 40                	int    $0x40
     de1:	c3                   	ret    

00000de2 <getpid>:
SYSCALL(getpid)
     de2:	b8 0b 00 00 00       	mov    $0xb,%eax
     de7:	cd 40                	int    $0x40
     de9:	c3                   	ret    

00000dea <memsize>:
SYSCALL(memsize)
     dea:	b8 16 00 00 00       	mov    $0x16,%eax
     def:	cd 40                	int    $0x40
     df1:	c3                   	ret    

00000df2 <sbrk>:
SYSCALL(sbrk)
     df2:	b8 0c 00 00 00       	mov    $0xc,%eax
     df7:	cd 40                	int    $0x40
     df9:	c3                   	ret    

00000dfa <sleep>:
SYSCALL(sleep)
     dfa:	b8 0d 00 00 00       	mov    $0xd,%eax
     dff:	cd 40                	int    $0x40
     e01:	c3                   	ret    

00000e02 <uptime>:
SYSCALL(uptime)
     e02:	b8 0e 00 00 00       	mov    $0xe,%eax
     e07:	cd 40                	int    $0x40
     e09:	c3                   	ret    

00000e0a <policy>:
SYSCALL(policy)
     e0a:	b8 17 00 00 00       	mov    $0x17,%eax
     e0f:	cd 40                	int    $0x40
     e11:	c3                   	ret    

00000e12 <set_cfs_priority>:
SYSCALL(set_cfs_priority)
     e12:	b8 19 00 00 00       	mov    $0x19,%eax
     e17:	cd 40                	int    $0x40
     e19:	c3                   	ret    

00000e1a <set_ps_priority>:
SYSCALL(set_ps_priority)
     e1a:	b8 18 00 00 00       	mov    $0x18,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <proc_info>:
SYSCALL(proc_info)
     e22:	b8 1a 00 00 00       	mov    $0x1a,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    
     e2a:	66 90                	xchg   %ax,%ax
     e2c:	66 90                	xchg   %ax,%ax
     e2e:	66 90                	xchg   %ax,%ax

00000e30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	57                   	push   %edi
     e34:	56                   	push   %esi
     e35:	53                   	push   %ebx
     e36:	89 c6                	mov    %eax,%esi
     e38:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     e3e:	85 db                	test   %ebx,%ebx
     e40:	74 7e                	je     ec0 <printint+0x90>
     e42:	89 d0                	mov    %edx,%eax
     e44:	c1 e8 1f             	shr    $0x1f,%eax
     e47:	84 c0                	test   %al,%al
     e49:	74 75                	je     ec0 <printint+0x90>
    neg = 1;
    x = -xx;
     e4b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
     e4d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
     e54:	f7 d8                	neg    %eax
     e56:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     e59:	31 ff                	xor    %edi,%edi
     e5b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     e5e:	89 ce                	mov    %ecx,%esi
     e60:	eb 08                	jmp    e6a <printint+0x3a>
     e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     e68:	89 cf                	mov    %ecx,%edi
     e6a:	31 d2                	xor    %edx,%edx
     e6c:	8d 4f 01             	lea    0x1(%edi),%ecx
     e6f:	f7 f6                	div    %esi
     e71:	0f b6 92 e0 12 00 00 	movzbl 0x12e0(%edx),%edx
  }while((x /= base) != 0);
     e78:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     e7a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     e7d:	75 e9                	jne    e68 <printint+0x38>
  if(neg)
     e7f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e82:	8b 75 c0             	mov    -0x40(%ebp),%esi
     e85:	85 c0                	test   %eax,%eax
     e87:	74 08                	je     e91 <printint+0x61>
    buf[i++] = '-';
     e89:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
     e8e:	8d 4f 02             	lea    0x2(%edi),%ecx
     e91:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
     e95:	8d 76 00             	lea    0x0(%esi),%esi
     e98:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     e9b:	83 ec 04             	sub    $0x4,%esp
     e9e:	83 ef 01             	sub    $0x1,%edi
     ea1:	6a 01                	push   $0x1
     ea3:	53                   	push   %ebx
     ea4:	56                   	push   %esi
     ea5:	88 45 d7             	mov    %al,-0x29(%ebp)
     ea8:	e8 d5 fe ff ff       	call   d82 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     ead:	83 c4 10             	add    $0x10,%esp
     eb0:	39 df                	cmp    %ebx,%edi
     eb2:	75 e4                	jne    e98 <printint+0x68>
    putc(fd, buf[i]);
}
     eb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eb7:	5b                   	pop    %ebx
     eb8:	5e                   	pop    %esi
     eb9:	5f                   	pop    %edi
     eba:	5d                   	pop    %ebp
     ebb:	c3                   	ret    
     ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     ec0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     ec2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     ec9:	eb 8b                	jmp    e56 <printint+0x26>
     ecb:	90                   	nop
     ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ed0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	57                   	push   %edi
     ed4:	56                   	push   %esi
     ed5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ed6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     ed9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     edc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     edf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ee2:	89 45 d0             	mov    %eax,-0x30(%ebp)
     ee5:	0f b6 1e             	movzbl (%esi),%ebx
     ee8:	83 c6 01             	add    $0x1,%esi
     eeb:	84 db                	test   %bl,%bl
     eed:	0f 84 b0 00 00 00    	je     fa3 <printf+0xd3>
     ef3:	31 d2                	xor    %edx,%edx
     ef5:	eb 39                	jmp    f30 <printf+0x60>
     ef7:	89 f6                	mov    %esi,%esi
     ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f00:	83 f8 25             	cmp    $0x25,%eax
     f03:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
     f06:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f0b:	74 18                	je     f25 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f0d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f10:	83 ec 04             	sub    $0x4,%esp
     f13:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     f16:	6a 01                	push   $0x1
     f18:	50                   	push   %eax
     f19:	57                   	push   %edi
     f1a:	e8 63 fe ff ff       	call   d82 <write>
     f1f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f22:	83 c4 10             	add    $0x10,%esp
     f25:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f28:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     f2c:	84 db                	test   %bl,%bl
     f2e:	74 73                	je     fa3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
     f30:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
     f32:	0f be cb             	movsbl %bl,%ecx
     f35:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     f38:	74 c6                	je     f00 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f3a:	83 fa 25             	cmp    $0x25,%edx
     f3d:	75 e6                	jne    f25 <printf+0x55>
      if(c == 'd'){
     f3f:	83 f8 64             	cmp    $0x64,%eax
     f42:	0f 84 f8 00 00 00    	je     1040 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     f48:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     f4e:	83 f9 70             	cmp    $0x70,%ecx
     f51:	74 5d                	je     fb0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     f53:	83 f8 73             	cmp    $0x73,%eax
     f56:	0f 84 84 00 00 00    	je     fe0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f5c:	83 f8 63             	cmp    $0x63,%eax
     f5f:	0f 84 ea 00 00 00    	je     104f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     f65:	83 f8 25             	cmp    $0x25,%eax
     f68:	0f 84 c2 00 00 00    	je     1030 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f6e:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f71:	83 ec 04             	sub    $0x4,%esp
     f74:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f78:	6a 01                	push   $0x1
     f7a:	50                   	push   %eax
     f7b:	57                   	push   %edi
     f7c:	e8 01 fe ff ff       	call   d82 <write>
     f81:	83 c4 0c             	add    $0xc,%esp
     f84:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     f87:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     f8a:	6a 01                	push   $0x1
     f8c:	50                   	push   %eax
     f8d:	57                   	push   %edi
     f8e:	83 c6 01             	add    $0x1,%esi
     f91:	e8 ec fd ff ff       	call   d82 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f96:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f9a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f9d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f9f:	84 db                	test   %bl,%bl
     fa1:	75 8d                	jne    f30 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     fa3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fa6:	5b                   	pop    %ebx
     fa7:	5e                   	pop    %esi
     fa8:	5f                   	pop    %edi
     fa9:	5d                   	pop    %ebp
     faa:	c3                   	ret    
     fab:	90                   	nop
     fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
     fb0:	83 ec 0c             	sub    $0xc,%esp
     fb3:	b9 10 00 00 00       	mov    $0x10,%ecx
     fb8:	6a 00                	push   $0x0
     fba:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     fbd:	89 f8                	mov    %edi,%eax
     fbf:	8b 13                	mov    (%ebx),%edx
     fc1:	e8 6a fe ff ff       	call   e30 <printint>
        ap++;
     fc6:	89 d8                	mov    %ebx,%eax
     fc8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     fcb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
     fcd:	83 c0 04             	add    $0x4,%eax
     fd0:	89 45 d0             	mov    %eax,-0x30(%ebp)
     fd3:	e9 4d ff ff ff       	jmp    f25 <printf+0x55>
     fd8:	90                   	nop
     fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
     fe0:	8b 45 d0             	mov    -0x30(%ebp),%eax
     fe3:	8b 18                	mov    (%eax),%ebx
        ap++;
     fe5:	83 c0 04             	add    $0x4,%eax
     fe8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
     feb:	b8 d8 12 00 00       	mov    $0x12d8,%eax
     ff0:	85 db                	test   %ebx,%ebx
     ff2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
     ff5:	0f b6 03             	movzbl (%ebx),%eax
     ff8:	84 c0                	test   %al,%al
     ffa:	74 23                	je     101f <printf+0x14f>
     ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1000:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1003:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1006:	83 ec 04             	sub    $0x4,%esp
    1009:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    100b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    100e:	50                   	push   %eax
    100f:	57                   	push   %edi
    1010:	e8 6d fd ff ff       	call   d82 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1015:	0f b6 03             	movzbl (%ebx),%eax
    1018:	83 c4 10             	add    $0x10,%esp
    101b:	84 c0                	test   %al,%al
    101d:	75 e1                	jne    1000 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    101f:	31 d2                	xor    %edx,%edx
    1021:	e9 ff fe ff ff       	jmp    f25 <printf+0x55>
    1026:	8d 76 00             	lea    0x0(%esi),%esi
    1029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1030:	83 ec 04             	sub    $0x4,%esp
    1033:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1036:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1039:	6a 01                	push   $0x1
    103b:	e9 4c ff ff ff       	jmp    f8c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1040:	83 ec 0c             	sub    $0xc,%esp
    1043:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1048:	6a 01                	push   $0x1
    104a:	e9 6b ff ff ff       	jmp    fba <printf+0xea>
    104f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1052:	83 ec 04             	sub    $0x4,%esp
    1055:	8b 03                	mov    (%ebx),%eax
    1057:	6a 01                	push   $0x1
    1059:	88 45 e4             	mov    %al,-0x1c(%ebp)
    105c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    105f:	50                   	push   %eax
    1060:	57                   	push   %edi
    1061:	e8 1c fd ff ff       	call   d82 <write>
    1066:	e9 5b ff ff ff       	jmp    fc6 <printf+0xf6>
    106b:	66 90                	xchg   %ax,%ax
    106d:	66 90                	xchg   %ax,%ax
    106f:	90                   	nop

00001070 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1070:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1071:	a1 24 19 00 00       	mov    0x1924,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1076:	89 e5                	mov    %esp,%ebp
    1078:	57                   	push   %edi
    1079:	56                   	push   %esi
    107a:	53                   	push   %ebx
    107b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    107e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1080:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1083:	39 c8                	cmp    %ecx,%eax
    1085:	73 19                	jae    10a0 <free+0x30>
    1087:	89 f6                	mov    %esi,%esi
    1089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1090:	39 d1                	cmp    %edx,%ecx
    1092:	72 1c                	jb     10b0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1094:	39 d0                	cmp    %edx,%eax
    1096:	73 18                	jae    10b0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    1098:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    109a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    109c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    109e:	72 f0                	jb     1090 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10a0:	39 d0                	cmp    %edx,%eax
    10a2:	72 f4                	jb     1098 <free+0x28>
    10a4:	39 d1                	cmp    %edx,%ecx
    10a6:	73 f0                	jae    1098 <free+0x28>
    10a8:	90                   	nop
    10a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    10b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    10b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    10b6:	39 d7                	cmp    %edx,%edi
    10b8:	74 19                	je     10d3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    10ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10bd:	8b 50 04             	mov    0x4(%eax),%edx
    10c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10c3:	39 f1                	cmp    %esi,%ecx
    10c5:	74 23                	je     10ea <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    10c7:	89 08                	mov    %ecx,(%eax)
  freep = p;
    10c9:	a3 24 19 00 00       	mov    %eax,0x1924
}
    10ce:	5b                   	pop    %ebx
    10cf:	5e                   	pop    %esi
    10d0:	5f                   	pop    %edi
    10d1:	5d                   	pop    %ebp
    10d2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    10d3:	03 72 04             	add    0x4(%edx),%esi
    10d6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    10d9:	8b 10                	mov    (%eax),%edx
    10db:	8b 12                	mov    (%edx),%edx
    10dd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    10e0:	8b 50 04             	mov    0x4(%eax),%edx
    10e3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10e6:	39 f1                	cmp    %esi,%ecx
    10e8:	75 dd                	jne    10c7 <free+0x57>
    p->s.size += bp->s.size;
    10ea:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    10ed:	a3 24 19 00 00       	mov    %eax,0x1924
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    10f2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10f5:	8b 53 f8             	mov    -0x8(%ebx),%edx
    10f8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    10fa:	5b                   	pop    %ebx
    10fb:	5e                   	pop    %esi
    10fc:	5f                   	pop    %edi
    10fd:	5d                   	pop    %ebp
    10fe:	c3                   	ret    
    10ff:	90                   	nop

00001100 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	57                   	push   %edi
    1104:	56                   	push   %esi
    1105:	53                   	push   %ebx
    1106:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1109:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    110c:	8b 15 24 19 00 00    	mov    0x1924,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1112:	8d 78 07             	lea    0x7(%eax),%edi
    1115:	c1 ef 03             	shr    $0x3,%edi
    1118:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    111b:	85 d2                	test   %edx,%edx
    111d:	0f 84 a3 00 00 00    	je     11c6 <malloc+0xc6>
    1123:	8b 02                	mov    (%edx),%eax
    1125:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1128:	39 cf                	cmp    %ecx,%edi
    112a:	76 74                	jbe    11a0 <malloc+0xa0>
    112c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1132:	be 00 10 00 00       	mov    $0x1000,%esi
    1137:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    113e:	0f 43 f7             	cmovae %edi,%esi
    1141:	ba 00 80 00 00       	mov    $0x8000,%edx
    1146:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    114c:	0f 46 da             	cmovbe %edx,%ebx
    114f:	eb 10                	jmp    1161 <malloc+0x61>
    1151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1158:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    115a:	8b 48 04             	mov    0x4(%eax),%ecx
    115d:	39 cf                	cmp    %ecx,%edi
    115f:	76 3f                	jbe    11a0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1161:	39 05 24 19 00 00    	cmp    %eax,0x1924
    1167:	89 c2                	mov    %eax,%edx
    1169:	75 ed                	jne    1158 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    116b:	83 ec 0c             	sub    $0xc,%esp
    116e:	53                   	push   %ebx
    116f:	e8 7e fc ff ff       	call   df2 <sbrk>
  if(p == (char*)-1)
    1174:	83 c4 10             	add    $0x10,%esp
    1177:	83 f8 ff             	cmp    $0xffffffff,%eax
    117a:	74 1c                	je     1198 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    117c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    117f:	83 ec 0c             	sub    $0xc,%esp
    1182:	83 c0 08             	add    $0x8,%eax
    1185:	50                   	push   %eax
    1186:	e8 e5 fe ff ff       	call   1070 <free>
  return freep;
    118b:	8b 15 24 19 00 00    	mov    0x1924,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1191:	83 c4 10             	add    $0x10,%esp
    1194:	85 d2                	test   %edx,%edx
    1196:	75 c0                	jne    1158 <malloc+0x58>
        return 0;
    1198:	31 c0                	xor    %eax,%eax
    119a:	eb 1c                	jmp    11b8 <malloc+0xb8>
    119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    11a0:	39 cf                	cmp    %ecx,%edi
    11a2:	74 1c                	je     11c0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    11a4:	29 f9                	sub    %edi,%ecx
    11a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    11a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    11ac:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    11af:	89 15 24 19 00 00    	mov    %edx,0x1924
      return (void*)(p + 1);
    11b5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    11b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11bb:	5b                   	pop    %ebx
    11bc:	5e                   	pop    %esi
    11bd:	5f                   	pop    %edi
    11be:	5d                   	pop    %ebp
    11bf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    11c0:	8b 08                	mov    (%eax),%ecx
    11c2:	89 0a                	mov    %ecx,(%edx)
    11c4:	eb e9                	jmp    11af <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    11c6:	c7 05 24 19 00 00 28 	movl   $0x1928,0x1924
    11cd:	19 00 00 
    11d0:	c7 05 28 19 00 00 28 	movl   $0x1928,0x1928
    11d7:	19 00 00 
    base.s.size = 0;
    11da:	b8 28 19 00 00       	mov    $0x1928,%eax
    11df:	c7 05 2c 19 00 00 00 	movl   $0x0,0x192c
    11e6:	00 00 00 
    11e9:	e9 3e ff ff ff       	jmp    112c <malloc+0x2c>
