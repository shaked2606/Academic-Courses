
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 ee 52 00 00       	push   $0x52ee
      16:	6a 01                	push   $0x1
      18:	e8 c3 3f 00 00       	call   3fe0 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	5a                   	pop    %edx
      1e:	59                   	pop    %ecx
      1f:	6a 00                	push   $0x0
      21:	68 02 53 00 00       	push   $0x5302
      26:	e8 87 3e 00 00       	call   3eb2 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 1b                	js     4d <main+0x4d>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	83 ec 08             	sub    $0x8,%esp
      35:	68 6c 5a 00 00       	push   $0x5a6c
      3a:	6a 01                	push   $0x1
      3c:	e8 9f 3f 00 00       	call   3fe0 <printf>
    exit(1);
      41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      48:	e8 25 3e 00 00       	call   3e72 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      4d:	50                   	push   %eax
      4e:	50                   	push   %eax
      4f:	68 00 02 00 00       	push   $0x200
      54:	68 02 53 00 00       	push   $0x5302
      59:	e8 54 3e 00 00       	call   3eb2 <open>
      5e:	89 04 24             	mov    %eax,(%esp)
      61:	e8 34 3e 00 00       	call   3e9a <close>

  argptest();
      66:	e8 35 3b 00 00       	call   3ba0 <argptest>
  createdelete();
      6b:	e8 60 13 00 00       	call   13d0 <createdelete>
  linkunlink();
      70:	e8 fb 1c 00 00       	call   1d70 <linkunlink>
  concreate();
      75:	e8 a6 19 00 00       	call   1a20 <concreate>
  fourfiles();
      7a:	e8 21 11 00 00       	call   11a0 <fourfiles>
  sharedfd();
      7f:	e8 5c 0f 00 00       	call   fe0 <sharedfd>

  bigargtest();
      84:	e8 77 37 00 00       	call   3800 <bigargtest>
  bigwrite();
      89:	e8 22 27 00 00       	call   27b0 <bigwrite>
  bigargtest();
      8e:	e8 6d 37 00 00       	call   3800 <bigargtest>
  bsstest();
      93:	e8 e8 36 00 00       	call   3780 <bsstest>
  sbrktest();
      98:	e8 63 31 00 00       	call   3200 <sbrktest>
  validatetest();
      9d:	e8 0e 36 00 00       	call   36b0 <validatetest>

  opentest();
      a2:	e8 e9 03 00 00       	call   490 <opentest>
  writetest();
      a7:	e8 84 04 00 00       	call   530 <writetest>
  writetest1();
      ac:	e8 8f 06 00 00       	call   740 <writetest1>
  createtest();
      b1:	e8 8a 08 00 00       	call   940 <createtest>

  openiputtest();
      b6:	e8 a5 02 00 00       	call   360 <openiputtest>
  exitiputtest();
      bb:	e8 70 01 00 00       	call   230 <exitiputtest>
  iputtest();
      c0:	e8 6b 00 00 00       	call   130 <iputtest>

  mem();
      c5:	e8 26 0e 00 00       	call   ef0 <mem>
  pipe1();
      ca:	e8 71 0a 00 00       	call   b40 <pipe1>
  preempt();
      cf:	e8 2c 0c 00 00       	call   d00 <preempt>
  exitwait();
      d4:	e8 77 0d 00 00       	call   e50 <exitwait>

  rmdot();
      d9:	e8 22 2b 00 00       	call   2c00 <rmdot>
  fourteen();
      de:	e8 bd 29 00 00       	call   2aa0 <fourteen>
  bigfile();
      e3:	e8 b8 27 00 00       	call   28a0 <bigfile>
  subdir();
      e8:	e8 e3 1e 00 00       	call   1fd0 <subdir>
  linktest();
      ed:	e8 de 16 00 00       	call   17d0 <linktest>
  unlinkread();
      f2:	e8 19 15 00 00       	call   1610 <unlinkread>
  dirfile();
      f7:	e8 b4 2c 00 00       	call   2db0 <dirfile>
  iref();
      fc:	e8 ef 2e 00 00       	call   2ff0 <iref>
  forktest();
     101:	e8 1a 30 00 00       	call   3120 <forktest>
  bigdir(); // slow
     106:	e8 75 1d 00 00       	call   1e80 <bigdir>

  uio();
     10b:	e8 00 3a 00 00       	call   3b10 <uio>

  exectest();
     110:	e8 db 09 00 00       	call   af0 <exectest>

  exit(0);
     115:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     11c:	e8 51 3d 00 00       	call   3e72 <exit>
     121:	66 90                	xchg   %ax,%ax
     123:	66 90                	xchg   %ax,%ax
     125:	66 90                	xchg   %ax,%ax
     127:	66 90                	xchg   %ax,%ax
     129:	66 90                	xchg   %ax,%ax
     12b:	66 90                	xchg   %ax,%ax
     12d:	66 90                	xchg   %ax,%ax
     12f:	90                   	nop

00000130 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     136:	68 94 43 00 00       	push   $0x4394
     13b:	ff 35 a4 63 00 00    	pushl  0x63a4
     141:	e8 9a 3e 00 00       	call   3fe0 <printf>

  if(mkdir("iputdir") < 0){
     146:	c7 04 24 27 43 00 00 	movl   $0x4327,(%esp)
     14d:	e8 88 3d 00 00       	call   3eda <mkdir>
     152:	83 c4 10             	add    $0x10,%esp
     155:	85 c0                	test   %eax,%eax
     157:	78 58                	js     1b1 <iputtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit(1);
  }
  if(chdir("iputdir") < 0){
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	68 27 43 00 00       	push   $0x4327
     161:	e8 7c 3d 00 00       	call   3ee2 <chdir>
     166:	83 c4 10             	add    $0x10,%esp
     169:	85 c0                	test   %eax,%eax
     16b:	0f 88 9a 00 00 00    	js     20b <iputtest+0xdb>
    printf(stdout, "chdir iputdir failed\n");
    exit(1);
  }
  if(unlink("../iputdir") < 0){
     171:	83 ec 0c             	sub    $0xc,%esp
     174:	68 24 43 00 00       	push   $0x4324
     179:	e8 44 3d 00 00       	call   3ec2 <unlink>
     17e:	83 c4 10             	add    $0x10,%esp
     181:	85 c0                	test   %eax,%eax
     183:	78 68                	js     1ed <iputtest+0xbd>
    printf(stdout, "unlink ../iputdir failed\n");
    exit(1);
  }
  if(chdir("/") < 0){
     185:	83 ec 0c             	sub    $0xc,%esp
     188:	68 49 43 00 00       	push   $0x4349
     18d:	e8 50 3d 00 00       	call   3ee2 <chdir>
     192:	83 c4 10             	add    $0x10,%esp
     195:	85 c0                	test   %eax,%eax
     197:	78 36                	js     1cf <iputtest+0x9f>
    printf(stdout, "chdir / failed\n");
    exit(1);
  }
  printf(stdout, "iput test ok\n");
     199:	83 ec 08             	sub    $0x8,%esp
     19c:	68 cc 43 00 00       	push   $0x43cc
     1a1:	ff 35 a4 63 00 00    	pushl  0x63a4
     1a7:	e8 34 3e 00 00       	call   3fe0 <printf>
}
     1ac:	83 c4 10             	add    $0x10,%esp
     1af:	c9                   	leave  
     1b0:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
     1b1:	50                   	push   %eax
     1b2:	50                   	push   %eax
     1b3:	68 00 43 00 00       	push   $0x4300
     1b8:	ff 35 a4 63 00 00    	pushl  0x63a4
     1be:	e8 1d 3e 00 00       	call   3fe0 <printf>
    exit(1);
     1c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1ca:	e8 a3 3c 00 00       	call   3e72 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit(1);
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
     1cf:	50                   	push   %eax
     1d0:	50                   	push   %eax
     1d1:	68 4b 43 00 00       	push   $0x434b
     1d6:	ff 35 a4 63 00 00    	pushl  0x63a4
     1dc:	e8 ff 3d 00 00       	call   3fe0 <printf>
    exit(1);
     1e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1e8:	e8 85 3c 00 00       	call   3e72 <exit>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit(1);
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
     1ed:	52                   	push   %edx
     1ee:	52                   	push   %edx
     1ef:	68 2f 43 00 00       	push   $0x432f
     1f4:	ff 35 a4 63 00 00    	pushl  0x63a4
     1fa:	e8 e1 3d 00 00       	call   3fe0 <printf>
    exit(1);
     1ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     206:	e8 67 3c 00 00       	call   3e72 <exit>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit(1);
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
     20b:	51                   	push   %ecx
     20c:	51                   	push   %ecx
     20d:	68 0e 43 00 00       	push   $0x430e
     212:	ff 35 a4 63 00 00    	pushl  0x63a4
     218:	e8 c3 3d 00 00       	call   3fe0 <printf>
    exit(1);
     21d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     224:	e8 49 3c 00 00       	call   3e72 <exit>
     229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <exitiputtest>:
}

// does exit(0) call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	83 ec 20             	sub    $0x20,%esp
  int pid, status;

  printf(stdout, "exitiput test\n");
     236:	68 5b 43 00 00       	push   $0x435b
     23b:	ff 35 a4 63 00 00    	pushl  0x63a4
     241:	e8 9a 3d 00 00       	call   3fe0 <printf>

  pid = fork();
     246:	e8 1f 3c 00 00       	call   3e6a <fork>
  if(pid < 0){
     24b:	83 c4 10             	add    $0x10,%esp
     24e:	85 c0                	test   %eax,%eax
     250:	0f 88 a1 00 00 00    	js     2f7 <exitiputtest+0xc7>
    printf(stdout, "fork failed\n");
    exit(1);
  }
  if(pid == 0){
     256:	75 58                	jne    2b0 <exitiputtest+0x80>
    if(mkdir("iputdir") < 0){
     258:	83 ec 0c             	sub    $0xc,%esp
     25b:	68 27 43 00 00       	push   $0x4327
     260:	e8 75 3c 00 00       	call   3eda <mkdir>
     265:	83 c4 10             	add    $0x10,%esp
     268:	85 c0                	test   %eax,%eax
     26a:	0f 88 c3 00 00 00    	js     333 <exitiputtest+0x103>
      printf(stdout, "mkdir failed\n");
      exit(1);
    }
    if(chdir("iputdir") < 0){
     270:	83 ec 0c             	sub    $0xc,%esp
     273:	68 27 43 00 00       	push   $0x4327
     278:	e8 65 3c 00 00       	call   3ee2 <chdir>
     27d:	83 c4 10             	add    $0x10,%esp
     280:	85 c0                	test   %eax,%eax
     282:	0f 88 8d 00 00 00    	js     315 <exitiputtest+0xe5>
      printf(stdout, "child chdir failed\n");
      exit(1);
    }
    if(unlink("../iputdir") < 0){
     288:	83 ec 0c             	sub    $0xc,%esp
     28b:	68 24 43 00 00       	push   $0x4324
     290:	e8 2d 3c 00 00       	call   3ec2 <unlink>
     295:	83 c4 10             	add    $0x10,%esp
     298:	85 c0                	test   %eax,%eax
     29a:	78 3c                	js     2d8 <exitiputtest+0xa8>
      printf(stdout, "unlink ../iputdir failed\n");
      exit(1);
    }
    exit(0);
     29c:	83 ec 0c             	sub    $0xc,%esp
     29f:	6a 00                	push   $0x0
     2a1:	e8 cc 3b 00 00       	call   3e72 <exit>
     2a6:	8d 76 00             	lea    0x0(%esi),%esi
     2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
  wait(&status);
     2b0:	8d 45 f4             	lea    -0xc(%ebp),%eax
     2b3:	83 ec 0c             	sub    $0xc,%esp
     2b6:	50                   	push   %eax
     2b7:	e8 be 3b 00 00       	call   3e7a <wait>
  printf(stdout, "exitiput test ok\n");
     2bc:	58                   	pop    %eax
     2bd:	5a                   	pop    %edx
     2be:	68 7e 43 00 00       	push   $0x437e
     2c3:	ff 35 a4 63 00 00    	pushl  0x63a4
     2c9:	e8 12 3d 00 00       	call   3fe0 <printf>
}
     2ce:	83 c4 10             	add    $0x10,%esp
     2d1:	c9                   	leave  
     2d2:	c3                   	ret    
     2d3:	90                   	nop
     2d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit(1);
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
     2d8:	83 ec 08             	sub    $0x8,%esp
     2db:	68 2f 43 00 00       	push   $0x432f
     2e0:	ff 35 a4 63 00 00    	pushl  0x63a4
     2e6:	e8 f5 3c 00 00       	call   3fe0 <printf>
      exit(1);
     2eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2f2:	e8 7b 3b 00 00       	call   3e72 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     2f7:	50                   	push   %eax
     2f8:	50                   	push   %eax
     2f9:	68 41 52 00 00       	push   $0x5241
     2fe:	ff 35 a4 63 00 00    	pushl  0x63a4
     304:	e8 d7 3c 00 00       	call   3fe0 <printf>
    exit(1);
     309:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     310:	e8 5d 3b 00 00       	call   3e72 <exit>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit(1);
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
     315:	51                   	push   %ecx
     316:	51                   	push   %ecx
     317:	68 6a 43 00 00       	push   $0x436a
     31c:	ff 35 a4 63 00 00    	pushl  0x63a4
     322:	e8 b9 3c 00 00       	call   3fe0 <printf>
      exit(1);
     327:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     32e:	e8 3f 3b 00 00       	call   3e72 <exit>
    printf(stdout, "fork failed\n");
    exit(1);
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
     333:	50                   	push   %eax
     334:	50                   	push   %eax
     335:	68 00 43 00 00       	push   $0x4300
     33a:	ff 35 a4 63 00 00    	pushl  0x63a4
     340:	e8 9b 3c 00 00       	call   3fe0 <printf>
      exit(1);
     345:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     34c:	e8 21 3b 00 00       	call   3e72 <exit>
     351:	eb 0d                	jmp    360 <openiputtest>
     353:	90                   	nop
     354:	90                   	nop
     355:	90                   	nop
     356:	90                   	nop
     357:	90                   	nop
     358:	90                   	nop
     359:	90                   	nop
     35a:	90                   	nop
     35b:	90                   	nop
     35c:	90                   	nop
     35d:	90                   	nop
     35e:	90                   	nop
     35f:	90                   	nop

00000360 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	83 ec 20             	sub    $0x20,%esp
  int pid, status;

  printf(stdout, "openiput test\n");
     366:	68 90 43 00 00       	push   $0x4390
     36b:	ff 35 a4 63 00 00    	pushl  0x63a4
     371:	e8 6a 3c 00 00       	call   3fe0 <printf>
  if(mkdir("oidir") < 0){
     376:	c7 04 24 9f 43 00 00 	movl   $0x439f,(%esp)
     37d:	e8 58 3b 00 00       	call   3eda <mkdir>
     382:	83 c4 10             	add    $0x10,%esp
     385:	85 c0                	test   %eax,%eax
     387:	0f 88 9d 00 00 00    	js     42a <openiputtest+0xca>
    printf(stdout, "mkdir oidir failed\n");
    exit(1);
  }
  pid = fork();
     38d:	e8 d8 3a 00 00       	call   3e6a <fork>
  if(pid < 0){
     392:	85 c0                	test   %eax,%eax
     394:	0f 88 ae 00 00 00    	js     448 <openiputtest+0xe8>
    printf(stdout, "fork failed\n");
    exit(1);
  }
  if(pid == 0){
     39a:	75 3c                	jne    3d8 <openiputtest+0x78>
    int fd = open("oidir", O_RDWR);
     39c:	83 ec 08             	sub    $0x8,%esp
     39f:	6a 02                	push   $0x2
     3a1:	68 9f 43 00 00       	push   $0x439f
     3a6:	e8 07 3b 00 00       	call   3eb2 <open>
    if(fd >= 0){
     3ab:	83 c4 10             	add    $0x10,%esp
     3ae:	85 c0                	test   %eax,%eax
     3b0:	78 6e                	js     420 <openiputtest+0xc0>
      printf(stdout, "open directory for write succeeded\n");
     3b2:	83 ec 08             	sub    $0x8,%esp
     3b5:	68 24 53 00 00       	push   $0x5324
     3ba:	ff 35 a4 63 00 00    	pushl  0x63a4
     3c0:	e8 1b 3c 00 00       	call   3fe0 <printf>
      exit(0);
     3c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3cc:	e8 a1 3a 00 00       	call   3e72 <exit>
     3d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    exit(0);
  }
  sleep(1);
     3d8:	83 ec 0c             	sub    $0xc,%esp
     3db:	6a 01                	push   $0x1
     3dd:	e8 28 3b 00 00       	call   3f0a <sleep>
  if(unlink("oidir") != 0){
     3e2:	c7 04 24 9f 43 00 00 	movl   $0x439f,(%esp)
     3e9:	e8 d4 3a 00 00       	call   3ec2 <unlink>
     3ee:	83 c4 10             	add    $0x10,%esp
     3f1:	85 c0                	test   %eax,%eax
     3f3:	75 71                	jne    466 <openiputtest+0x106>
    printf(stdout, "unlink failed\n");
    exit(1);
  }
  wait(&status);
     3f5:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3f8:	83 ec 0c             	sub    $0xc,%esp
     3fb:	50                   	push   %eax
     3fc:	e8 79 3a 00 00       	call   3e7a <wait>
  printf(stdout, "openiput test ok\n");
     401:	58                   	pop    %eax
     402:	5a                   	pop    %edx
     403:	68 c8 43 00 00       	push   $0x43c8
     408:	ff 35 a4 63 00 00    	pushl  0x63a4
     40e:	e8 cd 3b 00 00       	call   3fe0 <printf>
}
     413:	83 c4 10             	add    $0x10,%esp
     416:	c9                   	leave  
     417:	c3                   	ret    
     418:	90                   	nop
     419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    int fd = open("oidir", O_RDWR);
    if(fd >= 0){
      printf(stdout, "open directory for write succeeded\n");
      exit(0);
    }
    exit(0);
     420:	83 ec 0c             	sub    $0xc,%esp
     423:	6a 00                	push   $0x0
     425:	e8 48 3a 00 00       	call   3e72 <exit>
{
  int pid, status;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
     42a:	50                   	push   %eax
     42b:	50                   	push   %eax
     42c:	68 a5 43 00 00       	push   $0x43a5
     431:	ff 35 a4 63 00 00    	pushl  0x63a4
     437:	e8 a4 3b 00 00       	call   3fe0 <printf>
    exit(1);
     43c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     443:	e8 2a 3a 00 00       	call   3e72 <exit>
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     448:	50                   	push   %eax
     449:	50                   	push   %eax
     44a:	68 41 52 00 00       	push   $0x5241
     44f:	ff 35 a4 63 00 00    	pushl  0x63a4
     455:	e8 86 3b 00 00       	call   3fe0 <printf>
    exit(1);
     45a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     461:	e8 0c 3a 00 00       	call   3e72 <exit>
    }
    exit(0);
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
     466:	51                   	push   %ecx
     467:	51                   	push   %ecx
     468:	68 b9 43 00 00       	push   $0x43b9
     46d:	ff 35 a4 63 00 00    	pushl  0x63a4
     473:	e8 68 3b 00 00       	call   3fe0 <printf>
    exit(1);
     478:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     47f:	e8 ee 39 00 00       	call   3e72 <exit>
     484:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     48a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000490 <opentest>:

// simple file system tests

void
opentest(void)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
     496:	68 da 43 00 00       	push   $0x43da
     49b:	ff 35 a4 63 00 00    	pushl  0x63a4
     4a1:	e8 3a 3b 00 00       	call   3fe0 <printf>
  fd = open("echo", 0);
     4a6:	58                   	pop    %eax
     4a7:	5a                   	pop    %edx
     4a8:	6a 00                	push   $0x0
     4aa:	68 e5 43 00 00       	push   $0x43e5
     4af:	e8 fe 39 00 00       	call   3eb2 <open>
  if(fd < 0){
     4b4:	83 c4 10             	add    $0x10,%esp
     4b7:	85 c0                	test   %eax,%eax
     4b9:	78 36                	js     4f1 <opentest+0x61>
    printf(stdout, "open echo failed!\n");
    exit(1);
  }
  close(fd);
     4bb:	83 ec 0c             	sub    $0xc,%esp
     4be:	50                   	push   %eax
     4bf:	e8 d6 39 00 00       	call   3e9a <close>
  fd = open("doesnotexist", 0);
     4c4:	5a                   	pop    %edx
     4c5:	59                   	pop    %ecx
     4c6:	6a 00                	push   $0x0
     4c8:	68 fd 43 00 00       	push   $0x43fd
     4cd:	e8 e0 39 00 00       	call   3eb2 <open>
  if(fd >= 0){
     4d2:	83 c4 10             	add    $0x10,%esp
     4d5:	85 c0                	test   %eax,%eax
     4d7:	79 36                	jns    50f <opentest+0x7f>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit(0);
  }
  printf(stdout, "open test ok\n");
     4d9:	83 ec 08             	sub    $0x8,%esp
     4dc:	68 28 44 00 00       	push   $0x4428
     4e1:	ff 35 a4 63 00 00    	pushl  0x63a4
     4e7:	e8 f4 3a 00 00       	call   3fe0 <printf>
}
     4ec:	83 c4 10             	add    $0x10,%esp
     4ef:	c9                   	leave  
     4f0:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
     4f1:	50                   	push   %eax
     4f2:	50                   	push   %eax
     4f3:	68 ea 43 00 00       	push   $0x43ea
     4f8:	ff 35 a4 63 00 00    	pushl  0x63a4
     4fe:	e8 dd 3a 00 00       	call   3fe0 <printf>
    exit(1);
     503:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     50a:	e8 63 39 00 00       	call   3e72 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     50f:	50                   	push   %eax
     510:	50                   	push   %eax
     511:	68 0a 44 00 00       	push   $0x440a
     516:	ff 35 a4 63 00 00    	pushl  0x63a4
     51c:	e8 bf 3a 00 00       	call   3fe0 <printf>
    exit(0);
     521:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     528:	e8 45 39 00 00       	call   3e72 <exit>
     52d:	8d 76 00             	lea    0x0(%esi),%esi

00000530 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	56                   	push   %esi
     534:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
     535:	83 ec 08             	sub    $0x8,%esp
     538:	68 36 44 00 00       	push   $0x4436
     53d:	ff 35 a4 63 00 00    	pushl  0x63a4
     543:	e8 98 3a 00 00       	call   3fe0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     548:	59                   	pop    %ecx
     549:	5b                   	pop    %ebx
     54a:	68 02 02 00 00       	push   $0x202
     54f:	68 47 44 00 00       	push   $0x4447
     554:	e8 59 39 00 00       	call   3eb2 <open>
  if(fd >= 0){
     559:	83 c4 10             	add    $0x10,%esp
     55c:	85 c0                	test   %eax,%eax
     55e:	0f 88 b2 01 00 00    	js     716 <writetest+0x1e6>
    printf(stdout, "creat small succeeded; ok\n");
     564:	83 ec 08             	sub    $0x8,%esp
     567:	89 c6                	mov    %eax,%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(1);
  }
  for(i = 0; i < 100; i++){
     569:	31 db                	xor    %ebx,%ebx
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
     56b:	68 4d 44 00 00       	push   $0x444d
     570:	ff 35 a4 63 00 00    	pushl  0x63a4
     576:	e8 65 3a 00 00       	call   3fe0 <printf>
     57b:	83 c4 10             	add    $0x10,%esp
     57e:	66 90                	xchg   %ax,%ax
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(1);
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     580:	83 ec 04             	sub    $0x4,%esp
     583:	6a 0a                	push   $0xa
     585:	68 84 44 00 00       	push   $0x4484
     58a:	56                   	push   %esi
     58b:	e8 02 39 00 00       	call   3e92 <write>
     590:	83 c4 10             	add    $0x10,%esp
     593:	83 f8 0a             	cmp    $0xa,%eax
     596:	0f 85 dd 00 00 00    	jne    679 <writetest+0x149>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit(1);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     59c:	83 ec 04             	sub    $0x4,%esp
     59f:	6a 0a                	push   $0xa
     5a1:	68 8f 44 00 00       	push   $0x448f
     5a6:	56                   	push   %esi
     5a7:	e8 e6 38 00 00       	call   3e92 <write>
     5ac:	83 c4 10             	add    $0x10,%esp
     5af:	83 f8 0a             	cmp    $0xa,%eax
     5b2:	0f 85 e1 00 00 00    	jne    699 <writetest+0x169>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(1);
  }
  for(i = 0; i < 100; i++){
     5b8:	83 c3 01             	add    $0x1,%ebx
     5bb:	83 fb 64             	cmp    $0x64,%ebx
     5be:	75 c0                	jne    580 <writetest+0x50>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit(1);
    }
  }
  printf(stdout, "writes ok\n");
     5c0:	83 ec 08             	sub    $0x8,%esp
     5c3:	68 9a 44 00 00       	push   $0x449a
     5c8:	ff 35 a4 63 00 00    	pushl  0x63a4
     5ce:	e8 0d 3a 00 00       	call   3fe0 <printf>
  close(fd);
     5d3:	89 34 24             	mov    %esi,(%esp)
     5d6:	e8 bf 38 00 00       	call   3e9a <close>
  fd = open("small", O_RDONLY);
     5db:	58                   	pop    %eax
     5dc:	5a                   	pop    %edx
     5dd:	6a 00                	push   $0x0
     5df:	68 47 44 00 00       	push   $0x4447
     5e4:	e8 c9 38 00 00       	call   3eb2 <open>
  if(fd >= 0){
     5e9:	83 c4 10             	add    $0x10,%esp
     5ec:	85 c0                	test   %eax,%eax
      exit(1);
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
     5ee:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     5f0:	0f 88 c3 00 00 00    	js     6b9 <writetest+0x189>
    printf(stdout, "open small succeeded ok\n");
     5f6:	83 ec 08             	sub    $0x8,%esp
     5f9:	68 a5 44 00 00       	push   $0x44a5
     5fe:	ff 35 a4 63 00 00    	pushl  0x63a4
     604:	e8 d7 39 00 00       	call   3fe0 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit(1);
  }
  i = read(fd, buf, 2000);
     609:	83 c4 0c             	add    $0xc,%esp
     60c:	68 d0 07 00 00       	push   $0x7d0
     611:	68 80 8b 00 00       	push   $0x8b80
     616:	53                   	push   %ebx
     617:	e8 6e 38 00 00       	call   3e8a <read>
  if(i == 2000){
     61c:	83 c4 10             	add    $0x10,%esp
     61f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     624:	0f 85 ae 00 00 00    	jne    6d8 <writetest+0x1a8>
    printf(stdout, "read succeeded ok\n");
     62a:	83 ec 08             	sub    $0x8,%esp
     62d:	68 d9 44 00 00       	push   $0x44d9
     632:	ff 35 a4 63 00 00    	pushl  0x63a4
     638:	e8 a3 39 00 00       	call   3fe0 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit(1);
  }
  close(fd);
     63d:	89 1c 24             	mov    %ebx,(%esp)
     640:	e8 55 38 00 00       	call   3e9a <close>

  if(unlink("small") < 0){
     645:	c7 04 24 47 44 00 00 	movl   $0x4447,(%esp)
     64c:	e8 71 38 00 00       	call   3ec2 <unlink>
     651:	83 c4 10             	add    $0x10,%esp
     654:	85 c0                	test   %eax,%eax
     656:	0f 88 9b 00 00 00    	js     6f7 <writetest+0x1c7>
    printf(stdout, "unlink small failed\n");
    exit(1);
  }
  printf(stdout, "small file test ok\n");
     65c:	83 ec 08             	sub    $0x8,%esp
     65f:	68 01 45 00 00       	push   $0x4501
     664:	ff 35 a4 63 00 00    	pushl  0x63a4
     66a:	e8 71 39 00 00       	call   3fe0 <printf>
}
     66f:	83 c4 10             	add    $0x10,%esp
     672:	8d 65 f8             	lea    -0x8(%ebp),%esp
     675:	5b                   	pop    %ebx
     676:	5e                   	pop    %esi
     677:	5d                   	pop    %ebp
     678:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit(1);
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
     679:	83 ec 04             	sub    $0x4,%esp
     67c:	53                   	push   %ebx
     67d:	68 48 53 00 00       	push   $0x5348
     682:	ff 35 a4 63 00 00    	pushl  0x63a4
     688:	e8 53 39 00 00       	call   3fe0 <printf>
      exit(1);
     68d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     694:	e8 d9 37 00 00       	call   3e72 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     699:	83 ec 04             	sub    $0x4,%esp
     69c:	53                   	push   %ebx
     69d:	68 6c 53 00 00       	push   $0x536c
     6a2:	ff 35 a4 63 00 00    	pushl  0x63a4
     6a8:	e8 33 39 00 00       	call   3fe0 <printf>
      exit(1);
     6ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6b4:	e8 b9 37 00 00       	call   3e72 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     6b9:	83 ec 08             	sub    $0x8,%esp
     6bc:	68 be 44 00 00       	push   $0x44be
     6c1:	ff 35 a4 63 00 00    	pushl  0x63a4
     6c7:	e8 14 39 00 00       	call   3fe0 <printf>
    exit(1);
     6cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6d3:	e8 9a 37 00 00       	call   3e72 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     6d8:	83 ec 08             	sub    $0x8,%esp
     6db:	68 05 48 00 00       	push   $0x4805
     6e0:	ff 35 a4 63 00 00    	pushl  0x63a4
     6e6:	e8 f5 38 00 00       	call   3fe0 <printf>
    exit(1);
     6eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6f2:	e8 7b 37 00 00       	call   3e72 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     6f7:	83 ec 08             	sub    $0x8,%esp
     6fa:	68 ec 44 00 00       	push   $0x44ec
     6ff:	ff 35 a4 63 00 00    	pushl  0x63a4
     705:	e8 d6 38 00 00       	call   3fe0 <printf>
    exit(1);
     70a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     711:	e8 5c 37 00 00       	call   3e72 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     716:	83 ec 08             	sub    $0x8,%esp
     719:	68 68 44 00 00       	push   $0x4468
     71e:	ff 35 a4 63 00 00    	pushl  0x63a4
     724:	e8 b7 38 00 00       	call   3fe0 <printf>
    exit(1);
     729:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     730:	e8 3d 37 00 00       	call   3e72 <exit>
     735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000740 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	56                   	push   %esi
     744:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
     745:	83 ec 08             	sub    $0x8,%esp
     748:	68 15 45 00 00       	push   $0x4515
     74d:	ff 35 a4 63 00 00    	pushl  0x63a4
     753:	e8 88 38 00 00       	call   3fe0 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     758:	59                   	pop    %ecx
     759:	5b                   	pop    %ebx
     75a:	68 02 02 00 00       	push   $0x202
     75f:	68 8f 45 00 00       	push   $0x458f
     764:	e8 49 37 00 00       	call   3eb2 <open>
  if(fd < 0){
     769:	83 c4 10             	add    $0x10,%esp
     76c:	85 c0                	test   %eax,%eax
     76e:	0f 88 8b 01 00 00    	js     8ff <writetest1+0x1bf>
     774:	89 c6                	mov    %eax,%esi
     776:	31 db                	xor    %ebx,%ebx
     778:	90                   	nop
     779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(1);
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
     780:	83 ec 04             	sub    $0x4,%esp
    printf(stdout, "error: creat big failed!\n");
    exit(1);
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
     783:	89 1d 80 8b 00 00    	mov    %ebx,0x8b80
    if(write(fd, buf, 512) != 512){
     789:	68 00 02 00 00       	push   $0x200
     78e:	68 80 8b 00 00       	push   $0x8b80
     793:	56                   	push   %esi
     794:	e8 f9 36 00 00       	call   3e92 <write>
     799:	83 c4 10             	add    $0x10,%esp
     79c:	3d 00 02 00 00       	cmp    $0x200,%eax
     7a1:	0f 85 b7 00 00 00    	jne    85e <writetest1+0x11e>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit(1);
  }

  for(i = 0; i < MAXFILE; i++){
     7a7:	83 c3 01             	add    $0x1,%ebx
     7aa:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     7b0:	75 ce                	jne    780 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit(1);
    }
  }

  close(fd);
     7b2:	83 ec 0c             	sub    $0xc,%esp
     7b5:	56                   	push   %esi
     7b6:	e8 df 36 00 00       	call   3e9a <close>

  fd = open("big", O_RDONLY);
     7bb:	58                   	pop    %eax
     7bc:	5a                   	pop    %edx
     7bd:	6a 00                	push   $0x0
     7bf:	68 8f 45 00 00       	push   $0x458f
     7c4:	e8 e9 36 00 00       	call   3eb2 <open>
  if(fd < 0){
     7c9:	83 c4 10             	add    $0x10,%esp
     7cc:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
     7ce:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     7d0:	0f 88 0a 01 00 00    	js     8e0 <writetest1+0x1a0>
     7d6:	31 db                	xor    %ebx,%ebx
     7d8:	eb 21                	jmp    7fb <writetest1+0xbb>
     7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit(0);
      }
      break;
    } else if(i != 512){
     7e0:	3d 00 02 00 00       	cmp    $0x200,%eax
     7e5:	0f 85 b1 00 00 00    	jne    89c <writetest1+0x15c>
      printf(stdout, "read failed %d\n", i);
      exit(1);
    }
    if(((int*)buf)[0] != n){
     7eb:	a1 80 8b 00 00       	mov    0x8b80,%eax
     7f0:	39 c3                	cmp    %eax,%ebx
     7f2:	0f 85 86 00 00 00    	jne    87e <writetest1+0x13e>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit(0);
    }
    n++;
     7f8:	83 c3 01             	add    $0x1,%ebx
    exit(1);
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
     7fb:	83 ec 04             	sub    $0x4,%esp
     7fe:	68 00 02 00 00       	push   $0x200
     803:	68 80 8b 00 00       	push   $0x8b80
     808:	56                   	push   %esi
     809:	e8 7c 36 00 00       	call   3e8a <read>
    if(i == 0){
     80e:	83 c4 10             	add    $0x10,%esp
     811:	85 c0                	test   %eax,%eax
     813:	75 cb                	jne    7e0 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     815:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     81b:	0f 84 9b 00 00 00    	je     8bc <writetest1+0x17c>
             n, ((int*)buf)[0]);
      exit(0);
    }
    n++;
  }
  close(fd);
     821:	83 ec 0c             	sub    $0xc,%esp
     824:	56                   	push   %esi
     825:	e8 70 36 00 00       	call   3e9a <close>
  if(unlink("big") < 0){
     82a:	c7 04 24 8f 45 00 00 	movl   $0x458f,(%esp)
     831:	e8 8c 36 00 00       	call   3ec2 <unlink>
     836:	83 c4 10             	add    $0x10,%esp
     839:	85 c0                	test   %eax,%eax
     83b:	0f 88 dd 00 00 00    	js     91e <writetest1+0x1de>
    printf(stdout, "unlink big failed\n");
    exit(1);
  }
  printf(stdout, "big files ok\n");
     841:	83 ec 08             	sub    $0x8,%esp
     844:	68 b6 45 00 00       	push   $0x45b6
     849:	ff 35 a4 63 00 00    	pushl  0x63a4
     84f:	e8 8c 37 00 00       	call   3fe0 <printf>
}
     854:	83 c4 10             	add    $0x10,%esp
     857:	8d 65 f8             	lea    -0x8(%ebp),%esp
     85a:	5b                   	pop    %ebx
     85b:	5e                   	pop    %esi
     85c:	5d                   	pop    %ebp
     85d:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
     85e:	83 ec 04             	sub    $0x4,%esp
     861:	53                   	push   %ebx
     862:	68 3f 45 00 00       	push   $0x453f
     867:	ff 35 a4 63 00 00    	pushl  0x63a4
     86d:	e8 6e 37 00 00       	call   3fe0 <printf>
      exit(1);
     872:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     879:	e8 f4 35 00 00       	call   3e72 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit(1);
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     87e:	50                   	push   %eax
     87f:	53                   	push   %ebx
     880:	68 90 53 00 00       	push   $0x5390
     885:	ff 35 a4 63 00 00    	pushl  0x63a4
     88b:	e8 50 37 00 00       	call   3fe0 <printf>
             n, ((int*)buf)[0]);
      exit(0);
     890:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     897:	e8 d6 35 00 00       	call   3e72 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit(0);
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
     89c:	83 ec 04             	sub    $0x4,%esp
     89f:	50                   	push   %eax
     8a0:	68 93 45 00 00       	push   $0x4593
     8a5:	ff 35 a4 63 00 00    	pushl  0x63a4
     8ab:	e8 30 37 00 00       	call   3fe0 <printf>
      exit(1);
     8b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8b7:	e8 b6 35 00 00       	call   3e72 <exit>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     8bc:	83 ec 04             	sub    $0x4,%esp
     8bf:	68 8b 00 00 00       	push   $0x8b
     8c4:	68 76 45 00 00       	push   $0x4576
     8c9:	ff 35 a4 63 00 00    	pushl  0x63a4
     8cf:	e8 0c 37 00 00       	call   3fe0 <printf>
        exit(0);
     8d4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8db:	e8 92 35 00 00       	call   3e72 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     8e0:	83 ec 08             	sub    $0x8,%esp
     8e3:	68 5d 45 00 00       	push   $0x455d
     8e8:	ff 35 a4 63 00 00    	pushl  0x63a4
     8ee:	e8 ed 36 00 00       	call   3fe0 <printf>
    exit(1);
     8f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8fa:	e8 73 35 00 00       	call   3e72 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     8ff:	83 ec 08             	sub    $0x8,%esp
     902:	68 25 45 00 00       	push   $0x4525
     907:	ff 35 a4 63 00 00    	pushl  0x63a4
     90d:	e8 ce 36 00 00       	call   3fe0 <printf>
    exit(1);
     912:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     919:	e8 54 35 00 00       	call   3e72 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     91e:	83 ec 08             	sub    $0x8,%esp
     921:	68 a3 45 00 00       	push   $0x45a3
     926:	ff 35 a4 63 00 00    	pushl  0x63a4
     92c:	e8 af 36 00 00       	call   3fe0 <printf>
    exit(1);
     931:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     938:	e8 35 35 00 00       	call   3e72 <exit>
     93d:	8d 76 00             	lea    0x0(%esi),%esi

00000940 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
     944:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     949:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     94c:	68 b0 53 00 00       	push   $0x53b0
     951:	ff 35 a4 63 00 00    	pushl  0x63a4
     957:	e8 84 36 00 00       	call   3fe0 <printf>

  name[0] = 'a';
     95c:	c6 05 80 ab 00 00 61 	movb   $0x61,0xab80
  name[2] = '\0';
     963:	c6 05 82 ab 00 00 00 	movb   $0x0,0xab82
     96a:	83 c4 10             	add    $0x10,%esp
     96d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
     970:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     973:	88 1d 81 ab 00 00    	mov    %bl,0xab81
     979:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     97c:	68 02 02 00 00       	push   $0x202
     981:	68 80 ab 00 00       	push   $0xab80
     986:	e8 27 35 00 00       	call   3eb2 <open>
    close(fd);
     98b:	89 04 24             	mov    %eax,(%esp)
     98e:	e8 07 35 00 00       	call   3e9a <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     993:	83 c4 10             	add    $0x10,%esp
     996:	80 fb 64             	cmp    $0x64,%bl
     999:	75 d5                	jne    970 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     99b:	c6 05 80 ab 00 00 61 	movb   $0x61,0xab80
  name[2] = '\0';
     9a2:	c6 05 82 ab 00 00 00 	movb   $0x0,0xab82
     9a9:	bb 30 00 00 00       	mov    $0x30,%ebx
     9ae:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    unlink(name);
     9b0:	83 ec 0c             	sub    $0xc,%esp
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     9b3:	88 1d 81 ab 00 00    	mov    %bl,0xab81
     9b9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     9bc:	68 80 ab 00 00       	push   $0xab80
     9c1:	e8 fc 34 00 00       	call   3ec2 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     9c6:	83 c4 10             	add    $0x10,%esp
     9c9:	80 fb 64             	cmp    $0x64,%bl
     9cc:	75 e2                	jne    9b0 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     9ce:	83 ec 08             	sub    $0x8,%esp
     9d1:	68 d8 53 00 00       	push   $0x53d8
     9d6:	ff 35 a4 63 00 00    	pushl  0x63a4
     9dc:	e8 ff 35 00 00       	call   3fe0 <printf>
}
     9e1:	83 c4 10             	add    $0x10,%esp
     9e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9e7:	c9                   	leave  
     9e8:	c3                   	ret    
     9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009f0 <dirtest>:

void dirtest(void)
{
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     9f6:	68 c4 45 00 00       	push   $0x45c4
     9fb:	ff 35 a4 63 00 00    	pushl  0x63a4
     a01:	e8 da 35 00 00       	call   3fe0 <printf>

  if(mkdir("dir0") < 0){
     a06:	c7 04 24 d0 45 00 00 	movl   $0x45d0,(%esp)
     a0d:	e8 c8 34 00 00       	call   3eda <mkdir>
     a12:	83 c4 10             	add    $0x10,%esp
     a15:	85 c0                	test   %eax,%eax
     a17:	78 58                	js     a71 <dirtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit(1);
  }

  if(chdir("dir0") < 0){
     a19:	83 ec 0c             	sub    $0xc,%esp
     a1c:	68 d0 45 00 00       	push   $0x45d0
     a21:	e8 bc 34 00 00       	call   3ee2 <chdir>
     a26:	83 c4 10             	add    $0x10,%esp
     a29:	85 c0                	test   %eax,%eax
     a2b:	0f 88 9a 00 00 00    	js     acb <dirtest+0xdb>
    printf(stdout, "chdir dir0 failed\n");
    exit(1);
  }

  if(chdir("..") < 0){
     a31:	83 ec 0c             	sub    $0xc,%esp
     a34:	68 75 4b 00 00       	push   $0x4b75
     a39:	e8 a4 34 00 00       	call   3ee2 <chdir>
     a3e:	83 c4 10             	add    $0x10,%esp
     a41:	85 c0                	test   %eax,%eax
     a43:	78 68                	js     aad <dirtest+0xbd>
    printf(stdout, "chdir .. failed\n");
    exit(1);
  }

  if(unlink("dir0") < 0){
     a45:	83 ec 0c             	sub    $0xc,%esp
     a48:	68 d0 45 00 00       	push   $0x45d0
     a4d:	e8 70 34 00 00       	call   3ec2 <unlink>
     a52:	83 c4 10             	add    $0x10,%esp
     a55:	85 c0                	test   %eax,%eax
     a57:	78 36                	js     a8f <dirtest+0x9f>
    printf(stdout, "unlink dir0 failed\n");
    exit(1);
  }
  printf(stdout, "mkdir test ok\n");
     a59:	83 ec 08             	sub    $0x8,%esp
     a5c:	68 0d 46 00 00       	push   $0x460d
     a61:	ff 35 a4 63 00 00    	pushl  0x63a4
     a67:	e8 74 35 00 00       	call   3fe0 <printf>
}
     a6c:	83 c4 10             	add    $0x10,%esp
     a6f:	c9                   	leave  
     a70:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
     a71:	50                   	push   %eax
     a72:	50                   	push   %eax
     a73:	68 00 43 00 00       	push   $0x4300
     a78:	ff 35 a4 63 00 00    	pushl  0x63a4
     a7e:	e8 5d 35 00 00       	call   3fe0 <printf>
    exit(1);
     a83:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a8a:	e8 e3 33 00 00       	call   3e72 <exit>
    printf(stdout, "chdir .. failed\n");
    exit(1);
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
     a8f:	50                   	push   %eax
     a90:	50                   	push   %eax
     a91:	68 f9 45 00 00       	push   $0x45f9
     a96:	ff 35 a4 63 00 00    	pushl  0x63a4
     a9c:	e8 3f 35 00 00       	call   3fe0 <printf>
    exit(1);
     aa1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     aa8:	e8 c5 33 00 00       	call   3e72 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit(1);
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
     aad:	52                   	push   %edx
     aae:	52                   	push   %edx
     aaf:	68 e8 45 00 00       	push   $0x45e8
     ab4:	ff 35 a4 63 00 00    	pushl  0x63a4
     aba:	e8 21 35 00 00       	call   3fe0 <printf>
    exit(1);
     abf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ac6:	e8 a7 33 00 00       	call   3e72 <exit>
    printf(stdout, "mkdir failed\n");
    exit(1);
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
     acb:	51                   	push   %ecx
     acc:	51                   	push   %ecx
     acd:	68 d5 45 00 00       	push   $0x45d5
     ad2:	ff 35 a4 63 00 00    	pushl  0x63a4
     ad8:	e8 03 35 00 00       	call   3fe0 <printf>
    exit(1);
     add:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ae4:	e8 89 33 00 00       	call   3e72 <exit>
     ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000af0 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     af6:	68 1c 46 00 00       	push   $0x461c
     afb:	ff 35 a4 63 00 00    	pushl  0x63a4
     b01:	e8 da 34 00 00       	call   3fe0 <printf>
  if(exec("echo", echoargv) < 0){
     b06:	5a                   	pop    %edx
     b07:	59                   	pop    %ecx
     b08:	68 a8 63 00 00       	push   $0x63a8
     b0d:	68 e5 43 00 00       	push   $0x43e5
     b12:	e8 93 33 00 00       	call   3eaa <exec>
     b17:	83 c4 10             	add    $0x10,%esp
     b1a:	85 c0                	test   %eax,%eax
     b1c:	78 02                	js     b20 <exectest+0x30>
    printf(stdout, "exec echo failed\n");
    exit(1);
  }
}
     b1e:	c9                   	leave  
     b1f:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
     b20:	50                   	push   %eax
     b21:	50                   	push   %eax
     b22:	68 27 46 00 00       	push   $0x4627
     b27:	ff 35 a4 63 00 00    	pushl  0x63a4
     b2d:	e8 ae 34 00 00       	call   3fe0 <printf>
    exit(1);
     b32:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b39:	e8 34 33 00 00       	call   3e72 <exit>
     b3e:	66 90                	xchg   %ax,%ax

00000b40 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	57                   	push   %edi
     b44:	56                   	push   %esi
     b45:	53                   	push   %ebx
  int fds[2], pid, status;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     b46:	8d 45 e0             	lea    -0x20(%ebp),%eax

// simple fork and pipe read/write

void
pipe1(void)
{
     b49:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid, status;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     b4c:	50                   	push   %eax
     b4d:	e8 30 33 00 00       	call   3e82 <pipe>
     b52:	83 c4 10             	add    $0x10,%esp
     b55:	85 c0                	test   %eax,%eax
     b57:	0f 85 4b 01 00 00    	jne    ca8 <pipe1+0x168>
    printf(1, "pipe() failed\n");
    exit(1);
  }
  pid = fork();
     b5d:	e8 08 33 00 00       	call   3e6a <fork>
  seq = 0;
  if(pid == 0){
     b62:	83 f8 00             	cmp    $0x0,%eax
     b65:	0f 84 86 00 00 00    	je     bf1 <pipe1+0xb1>
        printf(1, "pipe1 oops 1\n");
        exit(1);
      }
    }
    exit(0);
  } else if(pid > 0){
     b6b:	0f 8e 52 01 00 00    	jle    cc3 <pipe1+0x183>
    close(fds[1]);
     b71:	83 ec 0c             	sub    $0xc,%esp
     b74:	ff 75 e4             	pushl  -0x1c(%ebp)
    total = 0;
    cc = 1;
     b77:	bf 01 00 00 00       	mov    $0x1,%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit(1);
  }
  pid = fork();
  seq = 0;
     b7c:	31 db                	xor    %ebx,%ebx
        exit(1);
      }
    }
    exit(0);
  } else if(pid > 0){
    close(fds[1]);
     b7e:	e8 17 33 00 00       	call   3e9a <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     b83:	83 c4 10             	add    $0x10,%esp
      }
    }
    exit(0);
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
     b86:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     b8d:	83 ec 04             	sub    $0x4,%esp
     b90:	57                   	push   %edi
     b91:	68 80 8b 00 00       	push   $0x8b80
     b96:	ff 75 e0             	pushl  -0x20(%ebp)
     b99:	e8 ec 32 00 00       	call   3e8a <read>
     b9e:	83 c4 10             	add    $0x10,%esp
     ba1:	85 c0                	test   %eax,%eax
     ba3:	0f 8e ac 00 00 00    	jle    c55 <pipe1+0x115>
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     ba9:	89 d9                	mov    %ebx,%ecx
     bab:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     bae:	f7 d9                	neg    %ecx
     bb0:	38 9c 0b 80 8b 00 00 	cmp    %bl,0x8b80(%ebx,%ecx,1)
     bb7:	8d 53 01             	lea    0x1(%ebx),%edx
     bba:	75 1b                	jne    bd7 <pipe1+0x97>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     bbc:	39 f2                	cmp    %esi,%edx
     bbe:	89 d3                	mov    %edx,%ebx
     bc0:	75 ee                	jne    bb0 <pipe1+0x70>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     bc2:	01 ff                	add    %edi,%edi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     bc4:	01 45 d4             	add    %eax,-0x2c(%ebp)
     bc7:	b8 00 20 00 00       	mov    $0x2000,%eax
     bcc:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     bd2:	0f 4f f8             	cmovg  %eax,%edi
     bd5:	eb b6                	jmp    b8d <pipe1+0x4d>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     bd7:	83 ec 08             	sub    $0x8,%esp
     bda:	68 56 46 00 00       	push   $0x4656
     bdf:	6a 01                	push   $0x1
     be1:	e8 fa 33 00 00       	call   3fe0 <printf>
          return;
     be6:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit(1);
  }
  printf(1, "pipe1 ok\n");
}
     be9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bec:	5b                   	pop    %ebx
     bed:	5e                   	pop    %esi
     bee:	5f                   	pop    %edi
     bef:	5d                   	pop    %ebp
     bf0:	c3                   	ret    
    exit(1);
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     bf1:	83 ec 0c             	sub    $0xc,%esp
     bf4:	ff 75 e0             	pushl  -0x20(%ebp)
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit(1);
  }
  pid = fork();
  seq = 0;
     bf7:	31 f6                	xor    %esi,%esi
  if(pid == 0){
    close(fds[0]);
     bf9:	e8 9c 32 00 00       	call   3e9a <close>
     bfe:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     c01:	89 f0                	mov    %esi,%eax
     c03:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx

// simple fork and pipe read/write

void
pipe1(void)
{
     c09:	89 f3                	mov    %esi,%ebx
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     c0b:	f7 d8                	neg    %eax
     c0d:	8d 76 00             	lea    0x0(%esi),%esi
     c10:	88 9c 18 80 8b 00 00 	mov    %bl,0x8b80(%eax,%ebx,1)
     c17:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     c1a:	39 d3                	cmp    %edx,%ebx
     c1c:	75 f2                	jne    c10 <pipe1+0xd0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     c1e:	83 ec 04             	sub    $0x4,%esp
     c21:	89 de                	mov    %ebx,%esi
     c23:	68 09 04 00 00       	push   $0x409
     c28:	68 80 8b 00 00       	push   $0x8b80
     c2d:	ff 75 e4             	pushl  -0x1c(%ebp)
     c30:	e8 5d 32 00 00       	call   3e92 <write>
     c35:	83 c4 10             	add    $0x10,%esp
     c38:	3d 09 04 00 00       	cmp    $0x409,%eax
     c3d:	0f 85 9b 00 00 00    	jne    cde <pipe1+0x19e>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     c43:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     c49:	75 b6                	jne    c01 <pipe1+0xc1>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit(1);
      }
    }
    exit(0);
     c4b:	83 ec 0c             	sub    $0xc,%esp
     c4e:	6a 00                	push   $0x0
     c50:	e8 1d 32 00 00       	call   3e72 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     c55:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     c5c:	75 2c                	jne    c8a <pipe1+0x14a>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit(1);
    }
    close(fds[0]);
     c5e:	83 ec 0c             	sub    $0xc,%esp
     c61:	ff 75 e0             	pushl  -0x20(%ebp)
     c64:	e8 31 32 00 00       	call   3e9a <close>
    wait(&status);
     c69:	8d 45 dc             	lea    -0x24(%ebp),%eax
     c6c:	89 04 24             	mov    %eax,(%esp)
     c6f:	e8 06 32 00 00       	call   3e7a <wait>
  } else {
    printf(1, "fork() failed\n");
    exit(1);
  }
  printf(1, "pipe1 ok\n");
     c74:	58                   	pop    %eax
     c75:	5a                   	pop    %edx
     c76:	68 7b 46 00 00       	push   $0x467b
     c7b:	6a 01                	push   $0x1
     c7d:	e8 5e 33 00 00       	call   3fe0 <printf>
     c82:	83 c4 10             	add    $0x10,%esp
     c85:	e9 5f ff ff ff       	jmp    be9 <pipe1+0xa9>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
     c8a:	83 ec 04             	sub    $0x4,%esp
     c8d:	ff 75 d4             	pushl  -0x2c(%ebp)
     c90:	68 64 46 00 00       	push   $0x4664
     c95:	6a 01                	push   $0x1
     c97:	e8 44 33 00 00       	call   3fe0 <printf>
      exit(1);
     c9c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ca3:	e8 ca 31 00 00       	call   3e72 <exit>
{
  int fds[2], pid, status;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     ca8:	83 ec 08             	sub    $0x8,%esp
     cab:	68 39 46 00 00       	push   $0x4639
     cb0:	6a 01                	push   $0x1
     cb2:	e8 29 33 00 00       	call   3fe0 <printf>
    exit(1);
     cb7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cbe:	e8 af 31 00 00       	call   3e72 <exit>
      exit(1);
    }
    close(fds[0]);
    wait(&status);
  } else {
    printf(1, "fork() failed\n");
     cc3:	83 ec 08             	sub    $0x8,%esp
     cc6:	68 85 46 00 00       	push   $0x4685
     ccb:	6a 01                	push   $0x1
     ccd:	e8 0e 33 00 00       	call   3fe0 <printf>
    exit(1);
     cd2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cd9:	e8 94 31 00 00       	call   3e72 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     cde:	83 ec 08             	sub    $0x8,%esp
     ce1:	68 48 46 00 00       	push   $0x4648
     ce6:	6a 01                	push   $0x1
     ce8:	e8 f3 32 00 00       	call   3fe0 <printf>
        exit(1);
     ced:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cf4:	e8 79 31 00 00       	call   3e72 <exit>
     cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d00 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	57                   	push   %edi
     d04:	56                   	push   %esi
     d05:	53                   	push   %ebx
     d06:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3, status;
  int pfds[2];

  printf(1, "preempt: ");
     d09:	68 94 46 00 00       	push   $0x4694
     d0e:	6a 01                	push   $0x1
     d10:	e8 cb 32 00 00       	call   3fe0 <printf>
  pid1 = fork();
     d15:	e8 50 31 00 00       	call   3e6a <fork>
  if(pid1 == 0)
     d1a:	83 c4 10             	add    $0x10,%esp
     d1d:	85 c0                	test   %eax,%eax
     d1f:	75 02                	jne    d23 <preempt+0x23>
     d21:	eb fe                	jmp    d21 <preempt+0x21>
     d23:	89 c7                	mov    %eax,%edi
    for(;;)
      ;

  pid2 = fork();
     d25:	e8 40 31 00 00       	call   3e6a <fork>
  if(pid2 == 0)
     d2a:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
     d2c:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     d2e:	75 02                	jne    d32 <preempt+0x32>
     d30:	eb fe                	jmp    d30 <preempt+0x30>
    for(;;)
      ;

  pipe(pfds);
     d32:	8d 45 e0             	lea    -0x20(%ebp),%eax
     d35:	83 ec 0c             	sub    $0xc,%esp
     d38:	50                   	push   %eax
     d39:	e8 44 31 00 00       	call   3e82 <pipe>
  pid3 = fork();
     d3e:	e8 27 31 00 00       	call   3e6a <fork>
  if(pid3 == 0){
     d43:	83 c4 10             	add    $0x10,%esp
     d46:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
     d48:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     d4a:	75 47                	jne    d93 <preempt+0x93>
    close(pfds[0]);
     d4c:	83 ec 0c             	sub    $0xc,%esp
     d4f:	ff 75 e0             	pushl  -0x20(%ebp)
     d52:	e8 43 31 00 00       	call   3e9a <close>
    if(write(pfds[1], "x", 1) != 1)
     d57:	83 c4 0c             	add    $0xc,%esp
     d5a:	6a 01                	push   $0x1
     d5c:	68 59 4c 00 00       	push   $0x4c59
     d61:	ff 75 e4             	pushl  -0x1c(%ebp)
     d64:	e8 29 31 00 00       	call   3e92 <write>
     d69:	83 c4 10             	add    $0x10,%esp
     d6c:	83 f8 01             	cmp    $0x1,%eax
     d6f:	74 12                	je     d83 <preempt+0x83>
      printf(1, "preempt write error");
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 9e 46 00 00       	push   $0x469e
     d79:	6a 01                	push   $0x1
     d7b:	e8 60 32 00 00       	call   3fe0 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     d83:	83 ec 0c             	sub    $0xc,%esp
     d86:	ff 75 e4             	pushl  -0x1c(%ebp)
     d89:	e8 0c 31 00 00       	call   3e9a <close>
     d8e:	83 c4 10             	add    $0x10,%esp
     d91:	eb fe                	jmp    d91 <preempt+0x91>
    for(;;)
      ;
  }

  close(pfds[1]);
     d93:	83 ec 0c             	sub    $0xc,%esp
     d96:	ff 75 e4             	pushl  -0x1c(%ebp)
     d99:	e8 fc 30 00 00       	call   3e9a <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     d9e:	83 c4 0c             	add    $0xc,%esp
     da1:	68 00 20 00 00       	push   $0x2000
     da6:	68 80 8b 00 00       	push   $0x8b80
     dab:	ff 75 e0             	pushl  -0x20(%ebp)
     dae:	e8 d7 30 00 00       	call   3e8a <read>
     db3:	83 c4 10             	add    $0x10,%esp
     db6:	83 f8 01             	cmp    $0x1,%eax
     db9:	74 1a                	je     dd5 <preempt+0xd5>
    printf(1, "preempt read error");
     dbb:	83 ec 08             	sub    $0x8,%esp
     dbe:	68 b2 46 00 00       	push   $0x46b2
     dc3:	6a 01                	push   $0x1
     dc5:	e8 16 32 00 00       	call   3fe0 <printf>
    return;
     dca:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait(&status);
  wait(&status);
  wait(&status);
  printf(1, "preempt ok\n");
}
     dcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dd0:	5b                   	pop    %ebx
     dd1:	5e                   	pop    %esi
     dd2:	5f                   	pop    %edi
     dd3:	5d                   	pop    %ebp
     dd4:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     dd5:	83 ec 0c             	sub    $0xc,%esp
     dd8:	ff 75 e0             	pushl  -0x20(%ebp)
     ddb:	e8 ba 30 00 00       	call   3e9a <close>
  printf(1, "kill... ");
     de0:	58                   	pop    %eax
     de1:	5a                   	pop    %edx
     de2:	68 c5 46 00 00       	push   $0x46c5
     de7:	6a 01                	push   $0x1
     de9:	e8 f2 31 00 00       	call   3fe0 <printf>
  kill(pid1);
     dee:	89 3c 24             	mov    %edi,(%esp)
     df1:	e8 ac 30 00 00       	call   3ea2 <kill>
  kill(pid2);
     df6:	89 34 24             	mov    %esi,(%esp)
     df9:	e8 a4 30 00 00       	call   3ea2 <kill>
  kill(pid3);
     dfe:	89 1c 24             	mov    %ebx,(%esp)
     e01:	e8 9c 30 00 00       	call   3ea2 <kill>
  printf(1, "wait... ");
     e06:	59                   	pop    %ecx
     e07:	5b                   	pop    %ebx
  wait(&status);
     e08:	8d 5d dc             	lea    -0x24(%ebp),%ebx
  close(pfds[0]);
  printf(1, "kill... ");
  kill(pid1);
  kill(pid2);
  kill(pid3);
  printf(1, "wait... ");
     e0b:	68 ce 46 00 00       	push   $0x46ce
     e10:	6a 01                	push   $0x1
     e12:	e8 c9 31 00 00       	call   3fe0 <printf>
  wait(&status);
     e17:	89 1c 24             	mov    %ebx,(%esp)
     e1a:	e8 5b 30 00 00       	call   3e7a <wait>
  wait(&status);
     e1f:	89 1c 24             	mov    %ebx,(%esp)
     e22:	e8 53 30 00 00       	call   3e7a <wait>
  wait(&status);
     e27:	89 1c 24             	mov    %ebx,(%esp)
     e2a:	e8 4b 30 00 00       	call   3e7a <wait>
  printf(1, "preempt ok\n");
     e2f:	5e                   	pop    %esi
     e30:	5f                   	pop    %edi
     e31:	68 d7 46 00 00       	push   $0x46d7
     e36:	6a 01                	push   $0x1
     e38:	e8 a3 31 00 00       	call   3fe0 <printf>
     e3d:	83 c4 10             	add    $0x10,%esp
     e40:	eb 8b                	jmp    dcd <preempt+0xcd>
     e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e50 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	56                   	push   %esi
     e55:	53                   	push   %ebx
     e56:	be 64 00 00 00       	mov    $0x64,%esi
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait(&status) != pid){
     e5b:	8d 7d e4             	lea    -0x1c(%ebp),%edi
}

// try to find any races between exit and wait
void
exitwait(void)
{
     e5e:	83 ec 1c             	sub    $0x1c,%esp
     e61:	eb 1c                	jmp    e7f <exitwait+0x2f>
     e63:	90                   	nop
     e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     e68:	74 78                	je     ee2 <exitwait+0x92>
      if(wait(&status) != pid){
     e6a:	83 ec 0c             	sub    $0xc,%esp
     e6d:	57                   	push   %edi
     e6e:	e8 07 30 00 00       	call   3e7a <wait>
     e73:	83 c4 10             	add    $0x10,%esp
     e76:	39 c3                	cmp    %eax,%ebx
     e78:	75 2e                	jne    ea8 <exitwait+0x58>
void
exitwait(void)
{
  int i, pid, status;

  for(i = 0; i < 100; i++){
     e7a:	83 ee 01             	sub    $0x1,%esi
     e7d:	74 49                	je     ec8 <exitwait+0x78>
    pid = fork();
     e7f:	e8 e6 2f 00 00       	call   3e6a <fork>
    if(pid < 0){
     e84:	85 c0                	test   %eax,%eax
exitwait(void)
{
  int i, pid, status;

  for(i = 0; i < 100; i++){
    pid = fork();
     e86:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     e88:	79 de                	jns    e68 <exitwait+0x18>
      printf(1, "fork failed\n");
     e8a:	83 ec 08             	sub    $0x8,%esp
     e8d:	68 41 52 00 00       	push   $0x5241
     e92:	6a 01                	push   $0x1
     e94:	e8 47 31 00 00       	call   3fe0 <printf>
      return;
     e99:	83 c4 10             	add    $0x10,%esp
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
}
     e9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e9f:	5b                   	pop    %ebx
     ea0:	5e                   	pop    %esi
     ea1:	5f                   	pop    %edi
     ea2:	5d                   	pop    %ebp
     ea3:	c3                   	ret    
     ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait(&status) != pid){
        printf(1, "wait wrong pid\n");
     ea8:	83 ec 08             	sub    $0x8,%esp
     eab:	68 e3 46 00 00       	push   $0x46e3
     eb0:	6a 01                	push   $0x1
     eb2:	e8 29 31 00 00       	call   3fe0 <printf>
        return;
     eb7:	83 c4 10             	add    $0x10,%esp
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
}
     eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ebd:	5b                   	pop    %ebx
     ebe:	5e                   	pop    %esi
     ebf:	5f                   	pop    %edi
     ec0:	5d                   	pop    %ebp
     ec1:	c3                   	ret    
     ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
     ec8:	83 ec 08             	sub    $0x8,%esp
     ecb:	68 f3 46 00 00       	push   $0x46f3
     ed0:	6a 01                	push   $0x1
     ed2:	e8 09 31 00 00       	call   3fe0 <printf>
     ed7:	83 c4 10             	add    $0x10,%esp
}
     eda:	8d 65 f4             	lea    -0xc(%ebp),%esp
     edd:	5b                   	pop    %ebx
     ede:	5e                   	pop    %esi
     edf:	5f                   	pop    %edi
     ee0:	5d                   	pop    %ebp
     ee1:	c3                   	ret    
      if(wait(&status) != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit(0);
     ee2:	83 ec 0c             	sub    $0xc,%esp
     ee5:	6a 00                	push   $0x0
     ee7:	e8 86 2f 00 00       	call   3e72 <exit>
     eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ef0 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	57                   	push   %edi
     ef4:	56                   	push   %esi
     ef5:	53                   	push   %ebx
     ef6:	83 ec 24             	sub    $0x24,%esp
  void *m1, *m2;
  int pid, ppid, status;

  printf(1, "mem test\n");
     ef9:	68 00 47 00 00       	push   $0x4700
     efe:	6a 01                	push   $0x1
     f00:	e8 db 30 00 00       	call   3fe0 <printf>
  ppid = getpid();
     f05:	e8 e8 2f 00 00       	call   3ef2 <getpid>
     f0a:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     f0c:	e8 59 2f 00 00       	call   3e6a <fork>
     f11:	83 c4 10             	add    $0x10,%esp
     f14:	85 c0                	test   %eax,%eax
     f16:	75 78                	jne    f90 <mem+0xa0>
     f18:	31 db                	xor    %ebx,%ebx
     f1a:	eb 08                	jmp    f24 <mem+0x34>
     f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
     f20:	89 18                	mov    %ebx,(%eax)
     f22:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     f24:	83 ec 0c             	sub    $0xc,%esp
     f27:	68 11 27 00 00       	push   $0x2711
     f2c:	e8 df 32 00 00       	call   4210 <malloc>
     f31:	83 c4 10             	add    $0x10,%esp
     f34:	85 c0                	test   %eax,%eax
     f36:	75 e8                	jne    f20 <mem+0x30>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     f38:	85 db                	test   %ebx,%ebx
     f3a:	74 18                	je     f54 <mem+0x64>
     f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     f40:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     f42:	83 ec 0c             	sub    $0xc,%esp
     f45:	53                   	push   %ebx
     f46:	89 fb                	mov    %edi,%ebx
     f48:	e8 33 32 00 00       	call   4180 <free>
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     f4d:	83 c4 10             	add    $0x10,%esp
     f50:	85 db                	test   %ebx,%ebx
     f52:	75 ec                	jne    f40 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     f54:	83 ec 0c             	sub    $0xc,%esp
     f57:	68 00 50 00 00       	push   $0x5000
     f5c:	e8 af 32 00 00       	call   4210 <malloc>
    if(m1 == 0){
     f61:	83 c4 10             	add    $0x10,%esp
     f64:	85 c0                	test   %eax,%eax
     f66:	74 48                	je     fb0 <mem+0xc0>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit(1);
    }
    free(m1);
     f68:	83 ec 0c             	sub    $0xc,%esp
     f6b:	50                   	push   %eax
     f6c:	e8 0f 32 00 00       	call   4180 <free>
    printf(1, "mem ok\n");
     f71:	58                   	pop    %eax
     f72:	5a                   	pop    %edx
     f73:	68 24 47 00 00       	push   $0x4724
     f78:	6a 01                	push   $0x1
     f7a:	e8 61 30 00 00       	call   3fe0 <printf>
    exit(0);
     f7f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f86:	e8 e7 2e 00 00       	call   3e72 <exit>
     f8b:	90                   	nop
     f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    wait(&status);
     f90:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f93:	83 ec 0c             	sub    $0xc,%esp
     f96:	50                   	push   %eax
     f97:	e8 de 2e 00 00       	call   3e7a <wait>
  }
}
     f9c:	83 c4 10             	add    $0x10,%esp
     f9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fa2:	5b                   	pop    %ebx
     fa3:	5e                   	pop    %esi
     fa4:	5f                   	pop    %edi
     fa5:	5d                   	pop    %ebp
     fa6:	c3                   	ret    
     fa7:	89 f6                	mov    %esi,%esi
     fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
     fb0:	83 ec 08             	sub    $0x8,%esp
     fb3:	68 0a 47 00 00       	push   $0x470a
     fb8:	6a 01                	push   $0x1
     fba:	e8 21 30 00 00       	call   3fe0 <printf>
      kill(ppid);
     fbf:	89 34 24             	mov    %esi,(%esp)
     fc2:	e8 db 2e 00 00       	call   3ea2 <kill>
      exit(1);
     fc7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fce:	e8 9f 2e 00 00       	call   3e72 <exit>
     fd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fe0 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	57                   	push   %edi
     fe4:	56                   	push   %esi
     fe5:	53                   	push   %ebx
     fe6:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, n, nc, np, status;
  char buf[10];

  printf(1, "sharedfd test\n");
     fe9:	68 2c 47 00 00       	push   $0x472c
     fee:	6a 01                	push   $0x1
     ff0:	e8 eb 2f 00 00       	call   3fe0 <printf>

  unlink("sharedfd");
     ff5:	c7 04 24 3b 47 00 00 	movl   $0x473b,(%esp)
     ffc:	e8 c1 2e 00 00       	call   3ec2 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    1001:	5b                   	pop    %ebx
    1002:	5e                   	pop    %esi
    1003:	68 02 02 00 00       	push   $0x202
    1008:	68 3b 47 00 00       	push   $0x473b
    100d:	e8 a0 2e 00 00       	call   3eb2 <open>
  if(fd < 0){
    1012:	83 c4 10             	add    $0x10,%esp
    1015:	85 c0                	test   %eax,%eax
    1017:	0f 88 29 01 00 00    	js     1146 <sharedfd+0x166>
    101d:	89 c7                	mov    %eax,%edi
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
    101f:	8d 75 de             	lea    -0x22(%ebp),%esi
    1022:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    1027:	e8 3e 2e 00 00       	call   3e6a <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    102c:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    102f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1032:	19 c0                	sbb    %eax,%eax
    1034:	83 ec 04             	sub    $0x4,%esp
    1037:	83 e0 f3             	and    $0xfffffff3,%eax
    103a:	6a 0a                	push   $0xa
    103c:	83 c0 70             	add    $0x70,%eax
    103f:	50                   	push   %eax
    1040:	56                   	push   %esi
    1041:	e8 9a 2c 00 00       	call   3ce0 <memset>
    1046:	83 c4 10             	add    $0x10,%esp
    1049:	eb 0a                	jmp    1055 <sharedfd+0x75>
    104b:	90                   	nop
    104c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
    1050:	83 eb 01             	sub    $0x1,%ebx
    1053:	74 26                	je     107b <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    1055:	83 ec 04             	sub    $0x4,%esp
    1058:	6a 0a                	push   $0xa
    105a:	56                   	push   %esi
    105b:	57                   	push   %edi
    105c:	e8 31 2e 00 00       	call   3e92 <write>
    1061:	83 c4 10             	add    $0x10,%esp
    1064:	83 f8 0a             	cmp    $0xa,%eax
    1067:	74 e7                	je     1050 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
    1069:	83 ec 08             	sub    $0x8,%esp
    106c:	68 2c 54 00 00       	push   $0x542c
    1071:	6a 01                	push   $0x1
    1073:	e8 68 2f 00 00       	call   3fe0 <printf>
      break;
    1078:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
    107b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    107e:	85 c9                	test   %ecx,%ecx
    1080:	0f 84 f4 00 00 00    	je     117a <sharedfd+0x19a>
    exit(0);
  else
    wait(&status);
    1086:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1089:	83 ec 0c             	sub    $0xc,%esp
    108c:	31 db                	xor    %ebx,%ebx
    108e:	50                   	push   %eax
    108f:	e8 e6 2d 00 00       	call   3e7a <wait>
  close(fd);
    1094:	89 3c 24             	mov    %edi,(%esp)
    1097:	8d 7d e8             	lea    -0x18(%ebp),%edi
    109a:	e8 fb 2d 00 00       	call   3e9a <close>
  fd = open("sharedfd", 0);
    109f:	58                   	pop    %eax
    10a0:	5a                   	pop    %edx
    10a1:	6a 00                	push   $0x0
    10a3:	68 3b 47 00 00       	push   $0x473b
    10a8:	e8 05 2e 00 00       	call   3eb2 <open>
  if(fd < 0){
    10ad:	83 c4 10             	add    $0x10,%esp
    10b0:	31 d2                	xor    %edx,%edx
    10b2:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit(0);
  else
    wait(&status);
  close(fd);
  fd = open("sharedfd", 0);
    10b4:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
    10b7:	0f 88 a3 00 00 00    	js     1160 <sharedfd+0x180>
    10bd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    10c6:	6a 0a                	push   $0xa
    10c8:	56                   	push   %esi
    10c9:	ff 75 d0             	pushl  -0x30(%ebp)
    10cc:	e8 b9 2d 00 00       	call   3e8a <read>
    10d1:	83 c4 10             	add    $0x10,%esp
    10d4:	85 c0                	test   %eax,%eax
    10d6:	7e 27                	jle    10ff <sharedfd+0x11f>
    10d8:	89 f0                	mov    %esi,%eax
    10da:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    10dd:	eb 13                	jmp    10f2 <sharedfd+0x112>
    10df:	90                   	nop
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    10e0:	80 f9 70             	cmp    $0x70,%cl
    10e3:	0f 94 c1             	sete   %cl
    10e6:	0f b6 c9             	movzbl %cl,%ecx
    10e9:	01 cb                	add    %ecx,%ebx
    10eb:	83 c0 01             	add    $0x1,%eax
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    10ee:	39 c7                	cmp    %eax,%edi
    10f0:	74 ce                	je     10c0 <sharedfd+0xe0>
      if(buf[i] == 'c')
    10f2:	0f b6 08             	movzbl (%eax),%ecx
    10f5:	80 f9 63             	cmp    $0x63,%cl
    10f8:	75 e6                	jne    10e0 <sharedfd+0x100>
        nc++;
    10fa:	83 c2 01             	add    $0x1,%edx
    10fd:	eb ec                	jmp    10eb <sharedfd+0x10b>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    10ff:	83 ec 0c             	sub    $0xc,%esp
    1102:	ff 75 d0             	pushl  -0x30(%ebp)
    1105:	e8 90 2d 00 00       	call   3e9a <close>
  unlink("sharedfd");
    110a:	c7 04 24 3b 47 00 00 	movl   $0x473b,(%esp)
    1111:	e8 ac 2d 00 00       	call   3ec2 <unlink>
  if(nc == 10000 && np == 10000){
    1116:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1119:	83 c4 10             	add    $0x10,%esp
    111c:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
    1122:	75 60                	jne    1184 <sharedfd+0x1a4>
    1124:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    112a:	75 58                	jne    1184 <sharedfd+0x1a4>
    printf(1, "sharedfd ok\n");
    112c:	83 ec 08             	sub    $0x8,%esp
    112f:	68 44 47 00 00       	push   $0x4744
    1134:	6a 01                	push   $0x1
    1136:	e8 a5 2e 00 00       	call   3fe0 <printf>
    113b:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit(1);
  }
}
    113e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1141:	5b                   	pop    %ebx
    1142:	5e                   	pop    %esi
    1143:	5f                   	pop    %edi
    1144:	5d                   	pop    %ebp
    1145:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    1146:	83 ec 08             	sub    $0x8,%esp
    1149:	68 00 54 00 00       	push   $0x5400
    114e:	6a 01                	push   $0x1
    1150:	e8 8b 2e 00 00       	call   3fe0 <printf>
    return;
    1155:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit(1);
  }
}
    1158:	8d 65 f4             	lea    -0xc(%ebp),%esp
    115b:	5b                   	pop    %ebx
    115c:	5e                   	pop    %esi
    115d:	5f                   	pop    %edi
    115e:	5d                   	pop    %ebp
    115f:	c3                   	ret    
  else
    wait(&status);
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    1160:	83 ec 08             	sub    $0x8,%esp
    1163:	68 4c 54 00 00       	push   $0x544c
    1168:	6a 01                	push   $0x1
    116a:	e8 71 2e 00 00       	call   3fe0 <printf>
    return;
    116f:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit(1);
  }
}
    1172:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1175:	5b                   	pop    %ebx
    1176:	5e                   	pop    %esi
    1177:	5f                   	pop    %edi
    1178:	5d                   	pop    %ebp
    1179:	c3                   	ret    
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit(0);
    117a:	83 ec 0c             	sub    $0xc,%esp
    117d:	6a 00                	push   $0x0
    117f:	e8 ee 2c 00 00       	call   3e72 <exit>
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1184:	53                   	push   %ebx
    1185:	52                   	push   %edx
    1186:	68 51 47 00 00       	push   $0x4751
    118b:	6a 01                	push   $0x1
    118d:	e8 4e 2e 00 00       	call   3fe0 <printf>
    exit(1);
    1192:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1199:	e8 d4 2c 00 00       	call   3e72 <exit>
    119e:	66 90                	xchg   %ax,%ax

000011a0 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	57                   	push   %edi
    11a4:	56                   	push   %esi
    11a5:	53                   	push   %ebx
  int fd, pid, i, j, n, total, pi, status;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    11a6:	be 66 47 00 00       	mov    $0x4766,%esi

  for(pi = 0; pi < 4; pi++){
    11ab:	31 db                	xor    %ebx,%ebx

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    11ad:	83 ec 44             	sub    $0x44,%esp
  int fd, pid, i, j, n, total, pi, status;
  char *names[] = { "f0", "f1", "f2", "f3" };
    11b0:	c7 45 d8 66 47 00 00 	movl   $0x4766,-0x28(%ebp)
    11b7:	c7 45 dc af 48 00 00 	movl   $0x48af,-0x24(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    11be:	68 6c 47 00 00       	push   $0x476c
    11c3:	6a 01                	push   $0x1
// time, to test block allocation.
void
fourfiles(void)
{
  int fd, pid, i, j, n, total, pi, status;
  char *names[] = { "f0", "f1", "f2", "f3" };
    11c5:	c7 45 e0 b3 48 00 00 	movl   $0x48b3,-0x20(%ebp)
    11cc:	c7 45 e4 69 47 00 00 	movl   $0x4769,-0x1c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    11d3:	e8 08 2e 00 00       	call   3fe0 <printf>
    11d8:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    fname = names[pi];
    unlink(fname);
    11db:	83 ec 0c             	sub    $0xc,%esp
    11de:	56                   	push   %esi
    11df:	e8 de 2c 00 00       	call   3ec2 <unlink>

    pid = fork();
    11e4:	e8 81 2c 00 00       	call   3e6a <fork>
    if(pid < 0){
    11e9:	83 c4 10             	add    $0x10,%esp
    11ec:	85 c0                	test   %eax,%eax
    11ee:	0f 88 b4 01 00 00    	js     13a8 <fourfiles+0x208>
      printf(1, "fork failed\n");
      exit(1);
    }

    if(pid == 0){
    11f4:	0f 84 fa 00 00 00    	je     12f4 <fourfiles+0x154>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    11fa:	83 c3 01             	add    $0x1,%ebx
    11fd:	83 fb 04             	cmp    $0x4,%ebx
    1200:	74 06                	je     1208 <fourfiles+0x68>
    1202:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1206:	eb d3                	jmp    11db <fourfiles+0x3b>
      exit(0);
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait(&status);
    1208:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
    120b:	83 ec 0c             	sub    $0xc,%esp
    120e:	bf 30 00 00 00       	mov    $0x30,%edi
    1213:	53                   	push   %ebx
    1214:	e8 61 2c 00 00       	call   3e7a <wait>
    1219:	89 1c 24             	mov    %ebx,(%esp)
    121c:	e8 59 2c 00 00       	call   3e7a <wait>
    1221:	89 1c 24             	mov    %ebx,(%esp)
    1224:	e8 51 2c 00 00       	call   3e7a <wait>
    1229:	89 1c 24             	mov    %ebx,(%esp)
    122c:	e8 49 2c 00 00       	call   3e7a <wait>
    1231:	83 c4 10             	add    $0x10,%esp
    1234:	c7 45 c4 66 47 00 00 	movl   $0x4766,-0x3c(%ebp)
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    123b:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    123e:	31 db                	xor    %ebx,%ebx
    wait(&status);
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    1240:	6a 00                	push   $0x0
    1242:	ff 75 c4             	pushl  -0x3c(%ebp)
    1245:	e8 68 2c 00 00       	call   3eb2 <open>
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    124a:	83 c4 10             	add    $0x10,%esp
    wait(&status);
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    124d:	89 c6                	mov    %eax,%esi
    124f:	90                   	nop
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1250:	83 ec 04             	sub    $0x4,%esp
    1253:	68 00 20 00 00       	push   $0x2000
    1258:	68 80 8b 00 00       	push   $0x8b80
    125d:	56                   	push   %esi
    125e:	e8 27 2c 00 00       	call   3e8a <read>
    1263:	83 c4 10             	add    $0x10,%esp
    1266:	85 c0                	test   %eax,%eax
    1268:	7e 1c                	jle    1286 <fourfiles+0xe6>
    126a:	31 d2                	xor    %edx,%edx
    126c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
    1270:	0f be 8a 80 8b 00 00 	movsbl 0x8b80(%edx),%ecx
    1277:	39 f9                	cmp    %edi,%ecx
    1279:	75 5e                	jne    12d9 <fourfiles+0x139>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    127b:	83 c2 01             	add    $0x1,%edx
    127e:	39 d0                	cmp    %edx,%eax
    1280:	75 ee                	jne    1270 <fourfiles+0xd0>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit(1);
        }
      }
      total += n;
    1282:	01 c3                	add    %eax,%ebx
    1284:	eb ca                	jmp    1250 <fourfiles+0xb0>
    }
    close(fd);
    1286:	83 ec 0c             	sub    $0xc,%esp
    1289:	56                   	push   %esi
    128a:	e8 0b 2c 00 00       	call   3e9a <close>
    if(total != 12*500){
    128f:	83 c4 10             	add    $0x10,%esp
    1292:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1298:	0f 85 ee 00 00 00    	jne    138c <fourfiles+0x1ec>
      printf(1, "wrong length %d\n", total);
      exit(1);
    }
    unlink(fname);
    129e:	83 ec 0c             	sub    $0xc,%esp
    12a1:	ff 75 c4             	pushl  -0x3c(%ebp)
    12a4:	83 c7 01             	add    $0x1,%edi
    12a7:	e8 16 2c 00 00       	call   3ec2 <unlink>

  for(pi = 0; pi < 4; pi++){
    wait(&status);
  }

  for(i = 0; i < 2; i++){
    12ac:	83 c4 10             	add    $0x10,%esp
    12af:	83 ff 32             	cmp    $0x32,%edi
    12b2:	75 1a                	jne    12ce <fourfiles+0x12e>
      exit(1);
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    12b4:	83 ec 08             	sub    $0x8,%esp
    12b7:	68 aa 47 00 00       	push   $0x47aa
    12bc:	6a 01                	push   $0x1
    12be:	e8 1d 2d 00 00       	call   3fe0 <printf>
}
    12c3:	83 c4 10             	add    $0x10,%esp
    12c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12c9:	5b                   	pop    %ebx
    12ca:	5e                   	pop    %esi
    12cb:	5f                   	pop    %edi
    12cc:	5d                   	pop    %ebp
    12cd:	c3                   	ret    
    12ce:	8b 45 dc             	mov    -0x24(%ebp),%eax
    12d1:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    12d4:	e9 62 ff ff ff       	jmp    123b <fourfiles+0x9b>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    12d9:	83 ec 08             	sub    $0x8,%esp
    12dc:	68 8d 47 00 00       	push   $0x478d
    12e1:	6a 01                	push   $0x1
    12e3:	e8 f8 2c 00 00       	call   3fe0 <printf>
          exit(1);
    12e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12ef:	e8 7e 2b 00 00       	call   3e72 <exit>
      printf(1, "fork failed\n");
      exit(1);
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    12f4:	83 ec 08             	sub    $0x8,%esp
    12f7:	68 02 02 00 00       	push   $0x202
    12fc:	56                   	push   %esi
    12fd:	e8 b0 2b 00 00       	call   3eb2 <open>
      if(fd < 0){
    1302:	83 c4 10             	add    $0x10,%esp
    1305:	85 c0                	test   %eax,%eax
      printf(1, "fork failed\n");
      exit(1);
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    1307:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1309:	78 66                	js     1371 <fourfiles+0x1d1>
        printf(1, "create failed\n");
        exit(1);
      }

      memset(buf, '0'+pi, 512);
    130b:	83 ec 04             	sub    $0x4,%esp
    130e:	83 c3 30             	add    $0x30,%ebx
    1311:	68 00 02 00 00       	push   $0x200
    1316:	53                   	push   %ebx
    1317:	bb 0c 00 00 00       	mov    $0xc,%ebx
    131c:	68 80 8b 00 00       	push   $0x8b80
    1321:	e8 ba 29 00 00       	call   3ce0 <memset>
    1326:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
    1329:	83 ec 04             	sub    $0x4,%esp
    132c:	68 f4 01 00 00       	push   $0x1f4
    1331:	68 80 8b 00 00       	push   $0x8b80
    1336:	56                   	push   %esi
    1337:	e8 56 2b 00 00       	call   3e92 <write>
    133c:	83 c4 10             	add    $0x10,%esp
    133f:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1344:	75 0f                	jne    1355 <fourfiles+0x1b5>
        printf(1, "create failed\n");
        exit(1);
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    1346:	83 eb 01             	sub    $0x1,%ebx
    1349:	75 de                	jne    1329 <fourfiles+0x189>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit(1);
        }
      }
      exit(0);
    134b:	83 ec 0c             	sub    $0xc,%esp
    134e:	6a 00                	push   $0x0
    1350:	e8 1d 2b 00 00       	call   3e72 <exit>
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
    1355:	83 ec 04             	sub    $0x4,%esp
    1358:	50                   	push   %eax
    1359:	68 7c 47 00 00       	push   $0x477c
    135e:	6a 01                	push   $0x1
    1360:	e8 7b 2c 00 00       	call   3fe0 <printf>
          exit(1);
    1365:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    136c:	e8 01 2b 00 00       	call   3e72 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    1371:	83 ec 08             	sub    $0x8,%esp
    1374:	68 07 4a 00 00       	push   $0x4a07
    1379:	6a 01                	push   $0x1
    137b:	e8 60 2c 00 00       	call   3fe0 <printf>
        exit(1);
    1380:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1387:	e8 e6 2a 00 00       	call   3e72 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    138c:	83 ec 04             	sub    $0x4,%esp
    138f:	53                   	push   %ebx
    1390:	68 99 47 00 00       	push   $0x4799
    1395:	6a 01                	push   $0x1
    1397:	e8 44 2c 00 00       	call   3fe0 <printf>
      exit(1);
    139c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a3:	e8 ca 2a 00 00       	call   3e72 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    13a8:	83 ec 08             	sub    $0x8,%esp
    13ab:	68 41 52 00 00       	push   $0x5241
    13b0:	6a 01                	push   $0x1
    13b2:	e8 29 2c 00 00       	call   3fe0 <printf>
      exit(1);
    13b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13be:	e8 af 2a 00 00       	call   3e72 <exit>
    13c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013d0 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	57                   	push   %edi
    13d4:	56                   	push   %esi
    13d5:	53                   	push   %ebx
  int pid, i, fd, pi, status;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    13d6:	31 db                	xor    %ebx,%ebx
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    13d8:	83 ec 54             	sub    $0x54,%esp
  enum { N = 20 };
  int pid, i, fd, pi, status;
  char name[32];

  printf(1, "createdelete test\n");
    13db:	68 b8 47 00 00       	push   $0x47b8
    13e0:	6a 01                	push   $0x1
    13e2:	e8 f9 2b 00 00       	call   3fe0 <printf>
    13e7:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    13ea:	e8 7b 2a 00 00       	call   3e6a <fork>
    if(pid < 0){
    13ef:	85 c0                	test   %eax,%eax
    13f1:	0f 88 da 01 00 00    	js     15d1 <createdelete+0x201>
      printf(1, "fork failed\n");
      exit(1);
    }

    if(pid == 0){
    13f7:	0f 84 06 01 00 00    	je     1503 <createdelete+0x133>
  int pid, i, fd, pi, status;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    13fd:	83 c3 01             	add    $0x1,%ebx
    1400:	83 fb 04             	cmp    $0x4,%ebx
    1403:	75 e5                	jne    13ea <createdelete+0x1a>
      exit(0);
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait(&status);
    1405:	8d 5d c4             	lea    -0x3c(%ebp),%ebx
    1408:	83 ec 0c             	sub    $0xc,%esp
    140b:	8d 7d c8             	lea    -0x38(%ebp),%edi
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    140e:	31 f6                	xor    %esi,%esi
      exit(0);
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait(&status);
    1410:	53                   	push   %ebx
    1411:	e8 64 2a 00 00       	call   3e7a <wait>
    1416:	89 1c 24             	mov    %ebx,(%esp)
    1419:	e8 5c 2a 00 00       	call   3e7a <wait>
    141e:	89 1c 24             	mov    %ebx,(%esp)
    1421:	e8 54 2a 00 00       	call   3e7a <wait>
    1426:	89 1c 24             	mov    %ebx,(%esp)
    1429:	e8 4c 2a 00 00       	call   3e7a <wait>
  }

  name[0] = name[1] = name[2] = 0;
    142e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1432:	83 c4 10             	add    $0x10,%esp
    1435:	8d 76 00             	lea    0x0(%esi),%esi
    1438:	8d 46 30             	lea    0x30(%esi),%eax
    143b:	83 fe 09             	cmp    $0x9,%esi
      exit(1);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
    143e:	bb 70 00 00 00       	mov    $0x70,%ebx
    1443:	0f 9f c2             	setg   %dl
    1446:	85 f6                	test   %esi,%esi
    1448:	88 45 b7             	mov    %al,-0x49(%ebp)
    144b:	0f 94 c0             	sete   %al
    144e:	09 c2                	or     %eax,%edx
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(1);
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1450:	8d 46 ff             	lea    -0x1(%esi),%eax
    1453:	88 55 b6             	mov    %dl,-0x4a(%ebp)
    1456:	89 45 b0             	mov    %eax,-0x50(%ebp)

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    1459:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
      fd = open(name, 0);
    145d:	83 ec 08             	sub    $0x8,%esp
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    1460:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
      fd = open(name, 0);
    1463:	6a 00                	push   $0x0
    1465:	57                   	push   %edi

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    1466:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1469:	e8 44 2a 00 00       	call   3eb2 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    146e:	89 c1                	mov    %eax,%ecx
    1470:	83 c4 10             	add    $0x10,%esp
    1473:	c1 e9 1f             	shr    $0x1f,%ecx
    1476:	84 c9                	test   %cl,%cl
    1478:	74 0a                	je     1484 <createdelete+0xb4>
    147a:	80 7d b6 00          	cmpb   $0x0,-0x4a(%ebp)
    147e:	0f 85 16 01 00 00    	jne    159a <createdelete+0x1ca>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(1);
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1484:	83 7d b0 08          	cmpl   $0x8,-0x50(%ebp)
    1488:	0f 86 5e 01 00 00    	jbe    15ec <createdelete+0x21c>
        printf(1, "oops createdelete %s did exist\n", name);
        exit(1);
      }
      if(fd >= 0)
    148e:	85 c0                	test   %eax,%eax
    1490:	78 0c                	js     149e <createdelete+0xce>
        close(fd);
    1492:	83 ec 0c             	sub    $0xc,%esp
    1495:	50                   	push   %eax
    1496:	e8 ff 29 00 00       	call   3e9a <close>
    149b:	83 c4 10             	add    $0x10,%esp
    149e:	83 c3 01             	add    $0x1,%ebx
    wait(&status);
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    14a1:	80 fb 74             	cmp    $0x74,%bl
    14a4:	75 b3                	jne    1459 <createdelete+0x89>
  for(pi = 0; pi < 4; pi++){
    wait(&status);
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    14a6:	83 c6 01             	add    $0x1,%esi
    14a9:	83 fe 14             	cmp    $0x14,%esi
    14ac:	75 8a                	jne    1438 <createdelete+0x68>
    14ae:	be 70 00 00 00       	mov    $0x70,%esi
    14b3:	90                   	nop
    14b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    14b8:	8d 46 c0             	lea    -0x40(%esi),%eax
    14bb:	bb 04 00 00 00       	mov    $0x4,%ebx
    14c0:	88 45 b7             	mov    %al,-0x49(%ebp)
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    14c3:	89 f0                	mov    %esi,%eax
      name[1] = '0' + i;
      unlink(name);
    14c5:	83 ec 0c             	sub    $0xc,%esp
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    14c8:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    14cb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
      unlink(name);
    14cf:	57                   	push   %edi
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
      name[1] = '0' + i;
    14d0:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    14d3:	e8 ea 29 00 00       	call   3ec2 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    14d8:	83 c4 10             	add    $0x10,%esp
    14db:	83 eb 01             	sub    $0x1,%ebx
    14de:	75 e3                	jne    14c3 <createdelete+0xf3>
    14e0:	83 c6 01             	add    $0x1,%esi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    14e3:	89 f0                	mov    %esi,%eax
    14e5:	3c 84                	cmp    $0x84,%al
    14e7:	75 cf                	jne    14b8 <createdelete+0xe8>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    14e9:	83 ec 08             	sub    $0x8,%esp
    14ec:	68 cb 47 00 00       	push   $0x47cb
    14f1:	6a 01                	push   $0x1
    14f3:	e8 e8 2a 00 00       	call   3fe0 <printf>
}
    14f8:	83 c4 10             	add    $0x10,%esp
    14fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14fe:	5b                   	pop    %ebx
    14ff:	5e                   	pop    %esi
    1500:	5f                   	pop    %edi
    1501:	5d                   	pop    %ebp
    1502:	c3                   	ret    
      printf(1, "fork failed\n");
      exit(1);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    1503:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    1506:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    150a:	be 01 00 00 00       	mov    $0x1,%esi
      printf(1, "fork failed\n");
      exit(1);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    150f:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1512:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[2] = '\0';
    1515:	31 db                	xor    %ebx,%ebx
    1517:	eb 12                	jmp    152b <createdelete+0x15b>
    1519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1520:	83 fe 14             	cmp    $0x14,%esi
    1523:	74 6b                	je     1590 <createdelete+0x1c0>
    1525:	83 c3 01             	add    $0x1,%ebx
    1528:	83 c6 01             	add    $0x1,%esi
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    152b:	83 ec 08             	sub    $0x8,%esp

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    152e:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    1531:	68 02 02 00 00       	push   $0x202
    1536:	57                   	push   %edi

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    1537:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    153a:	e8 73 29 00 00       	call   3eb2 <open>
        if(fd < 0){
    153f:	83 c4 10             	add    $0x10,%esp
    1542:	85 c0                	test   %eax,%eax
    1544:	78 70                	js     15b6 <createdelete+0x1e6>
          printf(1, "create failed\n");
          exit(1);
        }
        close(fd);
    1546:	83 ec 0c             	sub    $0xc,%esp
    1549:	50                   	push   %eax
    154a:	e8 4b 29 00 00       	call   3e9a <close>
        if(i > 0 && (i % 2 ) == 0){
    154f:	83 c4 10             	add    $0x10,%esp
    1552:	85 db                	test   %ebx,%ebx
    1554:	74 cf                	je     1525 <createdelete+0x155>
    1556:	f6 c3 01             	test   $0x1,%bl
    1559:	75 c5                	jne    1520 <createdelete+0x150>
          name[1] = '0' + (i / 2);
          if(unlink(name) < 0){
    155b:	83 ec 0c             	sub    $0xc,%esp
          printf(1, "create failed\n");
          exit(1);
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    155e:	89 d8                	mov    %ebx,%eax
    1560:	d1 f8                	sar    %eax
          if(unlink(name) < 0){
    1562:	57                   	push   %edi
          printf(1, "create failed\n");
          exit(1);
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    1563:	83 c0 30             	add    $0x30,%eax
    1566:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1569:	e8 54 29 00 00       	call   3ec2 <unlink>
    156e:	83 c4 10             	add    $0x10,%esp
    1571:	85 c0                	test   %eax,%eax
    1573:	79 ab                	jns    1520 <createdelete+0x150>
            printf(1, "unlink failed\n");
    1575:	83 ec 08             	sub    $0x8,%esp
    1578:	68 b9 43 00 00       	push   $0x43b9
    157d:	6a 01                	push   $0x1
    157f:	e8 5c 2a 00 00       	call   3fe0 <printf>
            exit(1);
    1584:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    158b:	e8 e2 28 00 00       	call   3e72 <exit>
          }
        }
      }
      exit(0);
    1590:	83 ec 0c             	sub    $0xc,%esp
    1593:	6a 00                	push   $0x0
    1595:	e8 d8 28 00 00       	call   3e72 <exit>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    159a:	83 ec 04             	sub    $0x4,%esp
    159d:	57                   	push   %edi
    159e:	68 78 54 00 00       	push   $0x5478
    15a3:	6a 01                	push   $0x1
    15a5:	e8 36 2a 00 00       	call   3fe0 <printf>
        exit(1);
    15aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15b1:	e8 bc 28 00 00       	call   3e72 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    15b6:	83 ec 08             	sub    $0x8,%esp
    15b9:	68 07 4a 00 00       	push   $0x4a07
    15be:	6a 01                	push   $0x1
    15c0:	e8 1b 2a 00 00       	call   3fe0 <printf>
          exit(1);
    15c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15cc:	e8 a1 28 00 00       	call   3e72 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    15d1:	83 ec 08             	sub    $0x8,%esp
    15d4:	68 41 52 00 00       	push   $0x5241
    15d9:	6a 01                	push   $0x1
    15db:	e8 00 2a 00 00       	call   3fe0 <printf>
      exit(1);
    15e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15e7:	e8 86 28 00 00       	call   3e72 <exit>
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(1);
      } else if((i >= 1 && i < N/2) && fd >= 0){
    15ec:	85 c0                	test   %eax,%eax
    15ee:	0f 88 aa fe ff ff    	js     149e <createdelete+0xce>
        printf(1, "oops createdelete %s did exist\n", name);
    15f4:	83 ec 04             	sub    $0x4,%esp
    15f7:	57                   	push   %edi
    15f8:	68 9c 54 00 00       	push   $0x549c
    15fd:	6a 01                	push   $0x1
    15ff:	e8 dc 29 00 00       	call   3fe0 <printf>
        exit(1);
    1604:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    160b:	e8 62 28 00 00       	call   3e72 <exit>

00001610 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1610:	55                   	push   %ebp
    1611:	89 e5                	mov    %esp,%ebp
    1613:	56                   	push   %esi
    1614:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1615:	83 ec 08             	sub    $0x8,%esp
    1618:	68 dc 47 00 00       	push   $0x47dc
    161d:	6a 01                	push   $0x1
    161f:	e8 bc 29 00 00       	call   3fe0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1624:	5b                   	pop    %ebx
    1625:	5e                   	pop    %esi
    1626:	68 02 02 00 00       	push   $0x202
    162b:	68 ed 47 00 00       	push   $0x47ed
    1630:	e8 7d 28 00 00       	call   3eb2 <open>
  if(fd < 0){
    1635:	83 c4 10             	add    $0x10,%esp
    1638:	85 c0                	test   %eax,%eax
    163a:	0f 88 e6 00 00 00    	js     1726 <unlinkread+0x116>
    printf(1, "create unlinkread failed\n");
    exit(1);
  }
  write(fd, "hello", 5);
    1640:	83 ec 04             	sub    $0x4,%esp
    1643:	89 c3                	mov    %eax,%ebx
    1645:	6a 05                	push   $0x5
    1647:	68 12 48 00 00       	push   $0x4812
    164c:	50                   	push   %eax
    164d:	e8 40 28 00 00       	call   3e92 <write>
  close(fd);
    1652:	89 1c 24             	mov    %ebx,(%esp)
    1655:	e8 40 28 00 00       	call   3e9a <close>

  fd = open("unlinkread", O_RDWR);
    165a:	58                   	pop    %eax
    165b:	5a                   	pop    %edx
    165c:	6a 02                	push   $0x2
    165e:	68 ed 47 00 00       	push   $0x47ed
    1663:	e8 4a 28 00 00       	call   3eb2 <open>
  if(fd < 0){
    1668:	83 c4 10             	add    $0x10,%esp
    166b:	85 c0                	test   %eax,%eax
    exit(1);
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    166d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    166f:	0f 88 33 01 00 00    	js     17a8 <unlinkread+0x198>
    printf(1, "open unlinkread failed\n");
    exit(1);
  }
  if(unlink("unlinkread") != 0){
    1675:	83 ec 0c             	sub    $0xc,%esp
    1678:	68 ed 47 00 00       	push   $0x47ed
    167d:	e8 40 28 00 00       	call   3ec2 <unlink>
    1682:	83 c4 10             	add    $0x10,%esp
    1685:	85 c0                	test   %eax,%eax
    1687:	0f 85 01 01 00 00    	jne    178e <unlinkread+0x17e>
    printf(1, "unlink unlinkread failed\n");
    exit(1);
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    168d:	83 ec 08             	sub    $0x8,%esp
    1690:	68 02 02 00 00       	push   $0x202
    1695:	68 ed 47 00 00       	push   $0x47ed
    169a:	e8 13 28 00 00       	call   3eb2 <open>
  write(fd1, "yyy", 3);
    169f:	83 c4 0c             	add    $0xc,%esp
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit(1);
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    16a2:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    16a4:	6a 03                	push   $0x3
    16a6:	68 4a 48 00 00       	push   $0x484a
    16ab:	50                   	push   %eax
    16ac:	e8 e1 27 00 00       	call   3e92 <write>
  close(fd1);
    16b1:	89 34 24             	mov    %esi,(%esp)
    16b4:	e8 e1 27 00 00       	call   3e9a <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    16b9:	83 c4 0c             	add    $0xc,%esp
    16bc:	68 00 20 00 00       	push   $0x2000
    16c1:	68 80 8b 00 00       	push   $0x8b80
    16c6:	53                   	push   %ebx
    16c7:	e8 be 27 00 00       	call   3e8a <read>
    16cc:	83 c4 10             	add    $0x10,%esp
    16cf:	83 f8 05             	cmp    $0x5,%eax
    16d2:	0f 85 9c 00 00 00    	jne    1774 <unlinkread+0x164>
    printf(1, "unlinkread read failed");
    exit(1);
  }
  if(buf[0] != 'h'){
    16d8:	80 3d 80 8b 00 00 68 	cmpb   $0x68,0x8b80
    16df:	75 79                	jne    175a <unlinkread+0x14a>
    printf(1, "unlinkread wrong data\n");
    exit(1);
  }
  if(write(fd, buf, 10) != 10){
    16e1:	83 ec 04             	sub    $0x4,%esp
    16e4:	6a 0a                	push   $0xa
    16e6:	68 80 8b 00 00       	push   $0x8b80
    16eb:	53                   	push   %ebx
    16ec:	e8 a1 27 00 00       	call   3e92 <write>
    16f1:	83 c4 10             	add    $0x10,%esp
    16f4:	83 f8 0a             	cmp    $0xa,%eax
    16f7:	75 47                	jne    1740 <unlinkread+0x130>
    printf(1, "unlinkread write failed\n");
    exit(1);
  }
  close(fd);
    16f9:	83 ec 0c             	sub    $0xc,%esp
    16fc:	53                   	push   %ebx
    16fd:	e8 98 27 00 00       	call   3e9a <close>
  unlink("unlinkread");
    1702:	c7 04 24 ed 47 00 00 	movl   $0x47ed,(%esp)
    1709:	e8 b4 27 00 00       	call   3ec2 <unlink>
  printf(1, "unlinkread ok\n");
    170e:	58                   	pop    %eax
    170f:	5a                   	pop    %edx
    1710:	68 95 48 00 00       	push   $0x4895
    1715:	6a 01                	push   $0x1
    1717:	e8 c4 28 00 00       	call   3fe0 <printf>
}
    171c:	83 c4 10             	add    $0x10,%esp
    171f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1722:	5b                   	pop    %ebx
    1723:	5e                   	pop    %esi
    1724:	5d                   	pop    %ebp
    1725:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1726:	51                   	push   %ecx
    1727:	51                   	push   %ecx
    1728:	68 f8 47 00 00       	push   $0x47f8
    172d:	6a 01                	push   $0x1
    172f:	e8 ac 28 00 00       	call   3fe0 <printf>
    exit(1);
    1734:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    173b:	e8 32 27 00 00       	call   3e72 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit(1);
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1740:	51                   	push   %ecx
    1741:	51                   	push   %ecx
    1742:	68 7c 48 00 00       	push   $0x487c
    1747:	6a 01                	push   $0x1
    1749:	e8 92 28 00 00       	call   3fe0 <printf>
    exit(1);
    174e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1755:	e8 18 27 00 00       	call   3e72 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit(1);
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    175a:	53                   	push   %ebx
    175b:	53                   	push   %ebx
    175c:	68 65 48 00 00       	push   $0x4865
    1761:	6a 01                	push   $0x1
    1763:	e8 78 28 00 00       	call   3fe0 <printf>
    exit(1);
    1768:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    176f:	e8 fe 26 00 00       	call   3e72 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    1774:	56                   	push   %esi
    1775:	56                   	push   %esi
    1776:	68 4e 48 00 00       	push   $0x484e
    177b:	6a 01                	push   $0x1
    177d:	e8 5e 28 00 00       	call   3fe0 <printf>
    exit(1);
    1782:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1789:	e8 e4 26 00 00       	call   3e72 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit(1);
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    178e:	50                   	push   %eax
    178f:	50                   	push   %eax
    1790:	68 30 48 00 00       	push   $0x4830
    1795:	6a 01                	push   $0x1
    1797:	e8 44 28 00 00       	call   3fe0 <printf>
    exit(1);
    179c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17a3:	e8 ca 26 00 00       	call   3e72 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    17a8:	50                   	push   %eax
    17a9:	50                   	push   %eax
    17aa:	68 18 48 00 00       	push   $0x4818
    17af:	6a 01                	push   $0x1
    17b1:	e8 2a 28 00 00       	call   3fe0 <printf>
    exit(1);
    17b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17bd:	e8 b0 26 00 00       	call   3e72 <exit>
    17c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000017d0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    17d0:	55                   	push   %ebp
    17d1:	89 e5                	mov    %esp,%ebp
    17d3:	53                   	push   %ebx
    17d4:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    17d7:	68 a4 48 00 00       	push   $0x48a4
    17dc:	6a 01                	push   $0x1
    17de:	e8 fd 27 00 00       	call   3fe0 <printf>

  unlink("lf1");
    17e3:	c7 04 24 ae 48 00 00 	movl   $0x48ae,(%esp)
    17ea:	e8 d3 26 00 00       	call   3ec2 <unlink>
  unlink("lf2");
    17ef:	c7 04 24 b2 48 00 00 	movl   $0x48b2,(%esp)
    17f6:	e8 c7 26 00 00       	call   3ec2 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    17fb:	58                   	pop    %eax
    17fc:	5a                   	pop    %edx
    17fd:	68 02 02 00 00       	push   $0x202
    1802:	68 ae 48 00 00       	push   $0x48ae
    1807:	e8 a6 26 00 00       	call   3eb2 <open>
  if(fd < 0){
    180c:	83 c4 10             	add    $0x10,%esp
    180f:	85 c0                	test   %eax,%eax
    1811:	0f 88 1e 01 00 00    	js     1935 <linktest+0x165>
    printf(1, "create lf1 failed\n");
    exit(1);
  }
  if(write(fd, "hello", 5) != 5){
    1817:	83 ec 04             	sub    $0x4,%esp
    181a:	89 c3                	mov    %eax,%ebx
    181c:	6a 05                	push   $0x5
    181e:	68 12 48 00 00       	push   $0x4812
    1823:	50                   	push   %eax
    1824:	e8 69 26 00 00       	call   3e92 <write>
    1829:	83 c4 10             	add    $0x10,%esp
    182c:	83 f8 05             	cmp    $0x5,%eax
    182f:	0f 85 d0 01 00 00    	jne    1a05 <linktest+0x235>
    printf(1, "write lf1 failed\n");
    exit(1);
  }
  close(fd);
    1835:	83 ec 0c             	sub    $0xc,%esp
    1838:	53                   	push   %ebx
    1839:	e8 5c 26 00 00       	call   3e9a <close>

  if(link("lf1", "lf2") < 0){
    183e:	5b                   	pop    %ebx
    183f:	58                   	pop    %eax
    1840:	68 b2 48 00 00       	push   $0x48b2
    1845:	68 ae 48 00 00       	push   $0x48ae
    184a:	e8 83 26 00 00       	call   3ed2 <link>
    184f:	83 c4 10             	add    $0x10,%esp
    1852:	85 c0                	test   %eax,%eax
    1854:	0f 88 91 01 00 00    	js     19eb <linktest+0x21b>
    printf(1, "link lf1 lf2 failed\n");
    exit(1);
  }
  unlink("lf1");
    185a:	83 ec 0c             	sub    $0xc,%esp
    185d:	68 ae 48 00 00       	push   $0x48ae
    1862:	e8 5b 26 00 00       	call   3ec2 <unlink>

  if(open("lf1", 0) >= 0){
    1867:	58                   	pop    %eax
    1868:	5a                   	pop    %edx
    1869:	6a 00                	push   $0x0
    186b:	68 ae 48 00 00       	push   $0x48ae
    1870:	e8 3d 26 00 00       	call   3eb2 <open>
    1875:	83 c4 10             	add    $0x10,%esp
    1878:	85 c0                	test   %eax,%eax
    187a:	0f 89 51 01 00 00    	jns    19d1 <linktest+0x201>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit(1);
  }

  fd = open("lf2", 0);
    1880:	83 ec 08             	sub    $0x8,%esp
    1883:	6a 00                	push   $0x0
    1885:	68 b2 48 00 00       	push   $0x48b2
    188a:	e8 23 26 00 00       	call   3eb2 <open>
  if(fd < 0){
    188f:	83 c4 10             	add    $0x10,%esp
    1892:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit(1);
  }

  fd = open("lf2", 0);
    1894:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1896:	0f 88 1b 01 00 00    	js     19b7 <linktest+0x1e7>
    printf(1, "open lf2 failed\n");
    exit(1);
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    189c:	83 ec 04             	sub    $0x4,%esp
    189f:	68 00 20 00 00       	push   $0x2000
    18a4:	68 80 8b 00 00       	push   $0x8b80
    18a9:	50                   	push   %eax
    18aa:	e8 db 25 00 00       	call   3e8a <read>
    18af:	83 c4 10             	add    $0x10,%esp
    18b2:	83 f8 05             	cmp    $0x5,%eax
    18b5:	0f 85 e2 00 00 00    	jne    199d <linktest+0x1cd>
    printf(1, "read lf2 failed\n");
    exit(1);
  }
  close(fd);
    18bb:	83 ec 0c             	sub    $0xc,%esp
    18be:	53                   	push   %ebx
    18bf:	e8 d6 25 00 00       	call   3e9a <close>

  if(link("lf2", "lf2") >= 0){
    18c4:	58                   	pop    %eax
    18c5:	5a                   	pop    %edx
    18c6:	68 b2 48 00 00       	push   $0x48b2
    18cb:	68 b2 48 00 00       	push   $0x48b2
    18d0:	e8 fd 25 00 00       	call   3ed2 <link>
    18d5:	83 c4 10             	add    $0x10,%esp
    18d8:	85 c0                	test   %eax,%eax
    18da:	0f 89 a3 00 00 00    	jns    1983 <linktest+0x1b3>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit(1);
  }

  unlink("lf2");
    18e0:	83 ec 0c             	sub    $0xc,%esp
    18e3:	68 b2 48 00 00       	push   $0x48b2
    18e8:	e8 d5 25 00 00       	call   3ec2 <unlink>
  if(link("lf2", "lf1") >= 0){
    18ed:	59                   	pop    %ecx
    18ee:	5b                   	pop    %ebx
    18ef:	68 ae 48 00 00       	push   $0x48ae
    18f4:	68 b2 48 00 00       	push   $0x48b2
    18f9:	e8 d4 25 00 00       	call   3ed2 <link>
    18fe:	83 c4 10             	add    $0x10,%esp
    1901:	85 c0                	test   %eax,%eax
    1903:	79 64                	jns    1969 <linktest+0x199>
    printf(1, "link non-existant succeeded! oops\n");
    exit(1);
  }

  if(link(".", "lf1") >= 0){
    1905:	83 ec 08             	sub    $0x8,%esp
    1908:	68 ae 48 00 00       	push   $0x48ae
    190d:	68 76 4b 00 00       	push   $0x4b76
    1912:	e8 bb 25 00 00       	call   3ed2 <link>
    1917:	83 c4 10             	add    $0x10,%esp
    191a:	85 c0                	test   %eax,%eax
    191c:	79 31                	jns    194f <linktest+0x17f>
    printf(1, "link . lf1 succeeded! oops\n");
    exit(1);
  }

  printf(1, "linktest ok\n");
    191e:	83 ec 08             	sub    $0x8,%esp
    1921:	68 4c 49 00 00       	push   $0x494c
    1926:	6a 01                	push   $0x1
    1928:	e8 b3 26 00 00       	call   3fe0 <printf>
}
    192d:	83 c4 10             	add    $0x10,%esp
    1930:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1933:	c9                   	leave  
    1934:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1935:	50                   	push   %eax
    1936:	50                   	push   %eax
    1937:	68 b6 48 00 00       	push   $0x48b6
    193c:	6a 01                	push   $0x1
    193e:	e8 9d 26 00 00       	call   3fe0 <printf>
    exit(1);
    1943:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    194a:	e8 23 25 00 00       	call   3e72 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit(1);
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    194f:	50                   	push   %eax
    1950:	50                   	push   %eax
    1951:	68 30 49 00 00       	push   $0x4930
    1956:	6a 01                	push   $0x1
    1958:	e8 83 26 00 00       	call   3fe0 <printf>
    exit(1);
    195d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1964:	e8 09 25 00 00       	call   3e72 <exit>
    exit(1);
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    1969:	52                   	push   %edx
    196a:	52                   	push   %edx
    196b:	68 e4 54 00 00       	push   $0x54e4
    1970:	6a 01                	push   $0x1
    1972:	e8 69 26 00 00       	call   3fe0 <printf>
    exit(1);
    1977:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    197e:	e8 ef 24 00 00       	call   3e72 <exit>
    exit(1);
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1983:	50                   	push   %eax
    1984:	50                   	push   %eax
    1985:	68 12 49 00 00       	push   $0x4912
    198a:	6a 01                	push   $0x1
    198c:	e8 4f 26 00 00       	call   3fe0 <printf>
    exit(1);
    1991:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1998:	e8 d5 24 00 00       	call   3e72 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit(1);
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    199d:	51                   	push   %ecx
    199e:	51                   	push   %ecx
    199f:	68 01 49 00 00       	push   $0x4901
    19a4:	6a 01                	push   $0x1
    19a6:	e8 35 26 00 00       	call   3fe0 <printf>
    exit(1);
    19ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19b2:	e8 bb 24 00 00       	call   3e72 <exit>
    exit(1);
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    19b7:	53                   	push   %ebx
    19b8:	53                   	push   %ebx
    19b9:	68 f0 48 00 00       	push   $0x48f0
    19be:	6a 01                	push   $0x1
    19c0:	e8 1b 26 00 00       	call   3fe0 <printf>
    exit(1);
    19c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19cc:	e8 a1 24 00 00       	call   3e72 <exit>
    exit(1);
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    19d1:	50                   	push   %eax
    19d2:	50                   	push   %eax
    19d3:	68 bc 54 00 00       	push   $0x54bc
    19d8:	6a 01                	push   $0x1
    19da:	e8 01 26 00 00       	call   3fe0 <printf>
    exit(1);
    19df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19e6:	e8 87 24 00 00       	call   3e72 <exit>
    exit(1);
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    19eb:	51                   	push   %ecx
    19ec:	51                   	push   %ecx
    19ed:	68 db 48 00 00       	push   $0x48db
    19f2:	6a 01                	push   $0x1
    19f4:	e8 e7 25 00 00       	call   3fe0 <printf>
    exit(1);
    19f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a00:	e8 6d 24 00 00       	call   3e72 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit(1);
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    1a05:	50                   	push   %eax
    1a06:	50                   	push   %eax
    1a07:	68 c9 48 00 00       	push   $0x48c9
    1a0c:	6a 01                	push   $0x1
    1a0e:	e8 cd 25 00 00       	call   3fe0 <printf>
    exit(1);
    1a13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a1a:	e8 53 24 00 00       	call   3e72 <exit>
    1a1f:	90                   	nop

00001a20 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1a20:	55                   	push   %ebp
    1a21:	89 e5                	mov    %esp,%ebp
    1a23:	57                   	push   %edi
    1a24:	56                   	push   %esi
    1a25:	53                   	push   %ebx
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1a26:	31 ff                	xor    %edi,%edi
    1a28:	8d 5d a9             	lea    -0x57(%ebp),%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    1a2b:	be 56 55 55 55       	mov    $0x55555556,%esi
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1a30:	83 ec 64             	sub    $0x64,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1a33:	68 59 49 00 00       	push   $0x4959
    1a38:	6a 01                	push   $0x1
    1a3a:	e8 a1 25 00 00       	call   3fe0 <printf>
  file[0] = 'C';
    1a3f:	c6 45 a9 43          	movb   $0x43,-0x57(%ebp)
  file[2] = '\0';
    1a43:	c6 45 ab 00          	movb   $0x0,-0x55(%ebp)
    1a47:	83 c4 10             	add    $0x10,%esp
    1a4a:	eb 5b                	jmp    1aa7 <concreate+0x87>
    1a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    1a50:	89 f8                	mov    %edi,%eax
    1a52:	89 f9                	mov    %edi,%ecx
    1a54:	f7 ee                	imul   %esi
    1a56:	89 f8                	mov    %edi,%eax
    1a58:	c1 f8 1f             	sar    $0x1f,%eax
    1a5b:	29 c2                	sub    %eax,%edx
    1a5d:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1a60:	29 c1                	sub    %eax,%ecx
    1a62:	83 f9 01             	cmp    $0x1,%ecx
    1a65:	0f 84 cd 00 00 00    	je     1b38 <concreate+0x118>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1a6b:	83 ec 08             	sub    $0x8,%esp
    1a6e:	68 02 02 00 00       	push   $0x202
    1a73:	53                   	push   %ebx
    1a74:	e8 39 24 00 00       	call   3eb2 <open>
      if(fd < 0){
    1a79:	83 c4 10             	add    $0x10,%esp
    1a7c:	85 c0                	test   %eax,%eax
    1a7e:	78 77                	js     1af7 <concreate+0xd7>
        printf(1, "concreate create %s failed\n", file);
        exit(1);
      }
      close(fd);
    1a80:	83 ec 0c             	sub    $0xc,%esp
    1a83:	50                   	push   %eax
    1a84:	e8 11 24 00 00       	call   3e9a <close>
    1a89:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
      exit(0);
    else
      wait(&status);
    1a8c:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1a8f:	83 ec 0c             	sub    $0xc,%esp
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1a92:	83 c7 01             	add    $0x1,%edi
      close(fd);
    }
    if(pid == 0)
      exit(0);
    else
      wait(&status);
    1a95:	50                   	push   %eax
    1a96:	e8 df 23 00 00       	call   3e7a <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1a9b:	83 c4 10             	add    $0x10,%esp
    1a9e:	83 ff 28             	cmp    $0x28,%edi
    1aa1:	0f 84 a9 00 00 00    	je     1b50 <concreate+0x130>
    file[1] = '0' + i;
    unlink(file);
    1aa7:	83 ec 0c             	sub    $0xc,%esp

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    1aaa:	8d 47 30             	lea    0x30(%edi),%eax
    unlink(file);
    1aad:	53                   	push   %ebx

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    1aae:	88 45 aa             	mov    %al,-0x56(%ebp)
    unlink(file);
    1ab1:	e8 0c 24 00 00       	call   3ec2 <unlink>
    pid = fork();
    1ab6:	e8 af 23 00 00       	call   3e6a <fork>
    if(pid && (i % 3) == 1){
    1abb:	83 c4 10             	add    $0x10,%esp
    1abe:	85 c0                	test   %eax,%eax
    1ac0:	75 8e                	jne    1a50 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    1ac2:	89 f8                	mov    %edi,%eax
    1ac4:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1ac9:	f7 ea                	imul   %edx
    1acb:	89 f8                	mov    %edi,%eax
    1acd:	c1 f8 1f             	sar    $0x1f,%eax
    1ad0:	d1 fa                	sar    %edx
    1ad2:	29 c2                	sub    %eax,%edx
    1ad4:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1ad7:	29 c7                	sub    %eax,%edi
    1ad9:	83 ff 01             	cmp    $0x1,%edi
    1adc:	74 3a                	je     1b18 <concreate+0xf8>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1ade:	83 ec 08             	sub    $0x8,%esp
    1ae1:	68 02 02 00 00       	push   $0x202
    1ae6:	53                   	push   %ebx
    1ae7:	e8 c6 23 00 00       	call   3eb2 <open>
      if(fd < 0){
    1aec:	83 c4 10             	add    $0x10,%esp
    1aef:	85 c0                	test   %eax,%eax
    1af1:	0f 89 5c 02 00 00    	jns    1d53 <concreate+0x333>
        printf(1, "concreate create %s failed\n", file);
    1af7:	83 ec 04             	sub    $0x4,%esp
    1afa:	53                   	push   %ebx
    1afb:	68 6c 49 00 00       	push   $0x496c
    1b00:	6a 01                	push   $0x1
    1b02:	e8 d9 24 00 00       	call   3fe0 <printf>
        exit(1);
    1b07:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b0e:	e8 5f 23 00 00       	call   3e72 <exit>
    1b13:	90                   	nop
    1b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    1b18:	83 ec 08             	sub    $0x8,%esp
    1b1b:	53                   	push   %ebx
    1b1c:	68 69 49 00 00       	push   $0x4969
    1b21:	e8 ac 23 00 00       	call   3ed2 <link>
    1b26:	83 c4 10             	add    $0x10,%esp
        exit(1);
      }
      close(fd);
    }
    if(pid == 0)
      exit(0);
    1b29:	83 ec 0c             	sub    $0xc,%esp
    1b2c:	6a 00                	push   $0x0
    1b2e:	e8 3f 23 00 00       	call   3e72 <exit>
    1b33:	90                   	nop
    1b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    1b38:	83 ec 08             	sub    $0x8,%esp
    1b3b:	53                   	push   %ebx
    1b3c:	68 69 49 00 00       	push   $0x4969
    1b41:	e8 8c 23 00 00       	call   3ed2 <link>
    1b46:	83 c4 10             	add    $0x10,%esp
    1b49:	e9 3e ff ff ff       	jmp    1a8c <concreate+0x6c>
    1b4e:	66 90                	xchg   %ax,%ax
      exit(0);
    else
      wait(&status);
  }

  memset(fa, 0, sizeof(fa));
    1b50:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1b53:	83 ec 04             	sub    $0x4,%esp
    1b56:	8d 7d b0             	lea    -0x50(%ebp),%edi
    1b59:	6a 28                	push   $0x28
    1b5b:	6a 00                	push   $0x0
    1b5d:	50                   	push   %eax
    1b5e:	e8 7d 21 00 00       	call   3ce0 <memset>
  fd = open(".", 0);
    1b63:	59                   	pop    %ecx
    1b64:	5e                   	pop    %esi
    1b65:	6a 00                	push   $0x0
    1b67:	68 76 4b 00 00       	push   $0x4b76
    1b6c:	e8 41 23 00 00       	call   3eb2 <open>
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1b71:	83 c4 10             	add    $0x10,%esp
    else
      wait(&status);
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
    1b74:	89 c6                	mov    %eax,%esi
  n = 0;
    1b76:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    1b7d:	8d 76 00             	lea    0x0(%esi),%esi
  while(read(fd, &de, sizeof(de)) > 0){
    1b80:	83 ec 04             	sub    $0x4,%esp
    1b83:	6a 10                	push   $0x10
    1b85:	57                   	push   %edi
    1b86:	56                   	push   %esi
    1b87:	e8 fe 22 00 00       	call   3e8a <read>
    1b8c:	83 c4 10             	add    $0x10,%esp
    1b8f:	85 c0                	test   %eax,%eax
    1b91:	7e 3d                	jle    1bd0 <concreate+0x1b0>
    if(de.inum == 0)
    1b93:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1b98:	74 e6                	je     1b80 <concreate+0x160>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1b9a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1b9e:	75 e0                	jne    1b80 <concreate+0x160>
    1ba0:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1ba4:	75 da                	jne    1b80 <concreate+0x160>
      i = de.name[1] - '0';
    1ba6:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1baa:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    1bad:	83 f8 27             	cmp    $0x27,%eax
    1bb0:	0f 87 7e 01 00 00    	ja     1d34 <concreate+0x314>
        printf(1, "concreate weird file %s\n", de.name);
        exit(1);
      }
      if(fa[i]){
    1bb6:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1bbb:	0f 85 54 01 00 00    	jne    1d15 <concreate+0x2f5>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit(1);
      }
      fa[i] = 1;
    1bc1:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1bc6:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    1bca:	eb b4                	jmp    1b80 <concreate+0x160>
    1bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  close(fd);
    1bd0:	83 ec 0c             	sub    $0xc,%esp
    1bd3:	56                   	push   %esi
    1bd4:	e8 c1 22 00 00       	call   3e9a <close>

  if(n != 40){
    1bd9:	83 c4 10             	add    $0x10,%esp
    1bdc:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1be0:	0f 85 14 01 00 00    	jne    1cfa <concreate+0x2da>
    1be6:	31 f6                	xor    %esi,%esi
    1be8:	eb 7a                	jmp    1c64 <concreate+0x244>
    1bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid < 0){
      printf(1, "fork failed\n");
      exit(1);
    }
    if(((i % 3) == 0 && pid == 0) ||
       ((i % 3) == 1 && pid != 0)){
    1bf0:	83 fa 01             	cmp    $0x1,%edx
    1bf3:	0f 85 a3 00 00 00    	jne    1c9c <concreate+0x27c>
      close(open(file, 0));
    1bf9:	83 ec 08             	sub    $0x8,%esp
    1bfc:	6a 00                	push   $0x0
    1bfe:	53                   	push   %ebx
    1bff:	e8 ae 22 00 00       	call   3eb2 <open>
    1c04:	89 04 24             	mov    %eax,(%esp)
    1c07:	e8 8e 22 00 00       	call   3e9a <close>
      close(open(file, 0));
    1c0c:	58                   	pop    %eax
    1c0d:	5a                   	pop    %edx
    1c0e:	6a 00                	push   $0x0
    1c10:	53                   	push   %ebx
    1c11:	e8 9c 22 00 00       	call   3eb2 <open>
    1c16:	89 04 24             	mov    %eax,(%esp)
    1c19:	e8 7c 22 00 00       	call   3e9a <close>
      close(open(file, 0));
    1c1e:	59                   	pop    %ecx
    1c1f:	58                   	pop    %eax
    1c20:	6a 00                	push   $0x0
    1c22:	53                   	push   %ebx
    1c23:	e8 8a 22 00 00       	call   3eb2 <open>
    1c28:	89 04 24             	mov    %eax,(%esp)
    1c2b:	e8 6a 22 00 00       	call   3e9a <close>
      close(open(file, 0));
    1c30:	58                   	pop    %eax
    1c31:	5a                   	pop    %edx
    1c32:	6a 00                	push   $0x0
    1c34:	53                   	push   %ebx
    1c35:	e8 78 22 00 00       	call   3eb2 <open>
    1c3a:	89 04 24             	mov    %eax,(%esp)
    1c3d:	e8 58 22 00 00       	call   3e9a <close>
    1c42:	83 c4 10             	add    $0x10,%esp
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    1c45:	85 ff                	test   %edi,%edi
    1c47:	0f 84 dc fe ff ff    	je     1b29 <concreate+0x109>
      exit(0);
    else
      wait(&status);
    1c4d:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1c50:	83 ec 0c             	sub    $0xc,%esp
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit(1);
  }

  for(i = 0; i < 40; i++){
    1c53:	83 c6 01             	add    $0x1,%esi
      unlink(file);
    }
    if(pid == 0)
      exit(0);
    else
      wait(&status);
    1c56:	50                   	push   %eax
    1c57:	e8 1e 22 00 00       	call   3e7a <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit(1);
  }

  for(i = 0; i < 40; i++){
    1c5c:	83 c4 10             	add    $0x10,%esp
    1c5f:	83 fe 28             	cmp    $0x28,%esi
    1c62:	74 64                	je     1cc8 <concreate+0x2a8>
    file[1] = '0' + i;
    1c64:	8d 46 30             	lea    0x30(%esi),%eax
    1c67:	88 45 aa             	mov    %al,-0x56(%ebp)
    pid = fork();
    1c6a:	e8 fb 21 00 00       	call   3e6a <fork>
    if(pid < 0){
    1c6f:	85 c0                	test   %eax,%eax
    exit(1);
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    1c71:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1c73:	78 6a                	js     1cdf <concreate+0x2bf>
      printf(1, "fork failed\n");
      exit(1);
    }
    if(((i % 3) == 0 && pid == 0) ||
    1c75:	b8 56 55 55 55       	mov    $0x55555556,%eax
    1c7a:	f7 ee                	imul   %esi
    1c7c:	89 f0                	mov    %esi,%eax
    1c7e:	c1 f8 1f             	sar    $0x1f,%eax
    1c81:	29 c2                	sub    %eax,%edx
    1c83:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1c86:	89 f2                	mov    %esi,%edx
    1c88:	29 c2                	sub    %eax,%edx
    1c8a:	89 f8                	mov    %edi,%eax
    1c8c:	09 d0                	or     %edx,%eax
    1c8e:	0f 84 65 ff ff ff    	je     1bf9 <concreate+0x1d9>
       ((i % 3) == 1 && pid != 0)){
    1c94:	85 ff                	test   %edi,%edi
    1c96:	0f 85 54 ff ff ff    	jne    1bf0 <concreate+0x1d0>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    1c9c:	83 ec 0c             	sub    $0xc,%esp
    1c9f:	53                   	push   %ebx
    1ca0:	e8 1d 22 00 00       	call   3ec2 <unlink>
      unlink(file);
    1ca5:	89 1c 24             	mov    %ebx,(%esp)
    1ca8:	e8 15 22 00 00       	call   3ec2 <unlink>
      unlink(file);
    1cad:	89 1c 24             	mov    %ebx,(%esp)
    1cb0:	e8 0d 22 00 00       	call   3ec2 <unlink>
      unlink(file);
    1cb5:	89 1c 24             	mov    %ebx,(%esp)
    1cb8:	e8 05 22 00 00       	call   3ec2 <unlink>
    1cbd:	83 c4 10             	add    $0x10,%esp
    1cc0:	eb 83                	jmp    1c45 <concreate+0x225>
    1cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
    else
      wait(&status);
  }

  printf(1, "concreate ok\n");
    1cc8:	83 ec 08             	sub    $0x8,%esp
    1ccb:	68 be 49 00 00       	push   $0x49be
    1cd0:	6a 01                	push   $0x1
    1cd2:	e8 09 23 00 00       	call   3fe0 <printf>
}
    1cd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cda:	5b                   	pop    %ebx
    1cdb:	5e                   	pop    %esi
    1cdc:	5f                   	pop    %edi
    1cdd:	5d                   	pop    %ebp
    1cde:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1cdf:	83 ec 08             	sub    $0x8,%esp
    1ce2:	68 41 52 00 00       	push   $0x5241
    1ce7:	6a 01                	push   $0x1
    1ce9:	e8 f2 22 00 00       	call   3fe0 <printf>
      exit(1);
    1cee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cf5:	e8 78 21 00 00       	call   3e72 <exit>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    1cfa:	83 ec 08             	sub    $0x8,%esp
    1cfd:	68 08 55 00 00       	push   $0x5508
    1d02:	6a 01                	push   $0x1
    1d04:	e8 d7 22 00 00       	call   3fe0 <printf>
    exit(1);
    1d09:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d10:	e8 5d 21 00 00       	call   3e72 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit(1);
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    1d15:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1d18:	83 ec 04             	sub    $0x4,%esp
    1d1b:	50                   	push   %eax
    1d1c:	68 a1 49 00 00       	push   $0x49a1
    1d21:	6a 01                	push   $0x1
    1d23:	e8 b8 22 00 00       	call   3fe0 <printf>
        exit(1);
    1d28:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d2f:	e8 3e 21 00 00       	call   3e72 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    1d34:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1d37:	83 ec 04             	sub    $0x4,%esp
    1d3a:	50                   	push   %eax
    1d3b:	68 88 49 00 00       	push   $0x4988
    1d40:	6a 01                	push   $0x1
    1d42:	e8 99 22 00 00       	call   3fe0 <printf>
        exit(1);
    1d47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d4e:	e8 1f 21 00 00       	call   3e72 <exit>
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
        exit(1);
      }
      close(fd);
    1d53:	83 ec 0c             	sub    $0xc,%esp
    1d56:	50                   	push   %eax
    1d57:	e8 3e 21 00 00       	call   3e9a <close>
    1d5c:	83 c4 10             	add    $0x10,%esp
    1d5f:	e9 c5 fd ff ff       	jmp    1b29 <concreate+0x109>
    1d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001d70 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1d70:	55                   	push   %ebp
    1d71:	89 e5                	mov    %esp,%ebp
    1d73:	57                   	push   %edi
    1d74:	56                   	push   %esi
    1d75:	53                   	push   %ebx
    1d76:	83 ec 34             	sub    $0x34,%esp
  int pid, i, status;

  printf(1, "linkunlink test\n");
    1d79:	68 cc 49 00 00       	push   $0x49cc
    1d7e:	6a 01                	push   $0x1
    1d80:	e8 5b 22 00 00       	call   3fe0 <printf>

  unlink("x");
    1d85:	c7 04 24 59 4c 00 00 	movl   $0x4c59,(%esp)
    1d8c:	e8 31 21 00 00       	call   3ec2 <unlink>
  pid = fork();
    1d91:	e8 d4 20 00 00       	call   3e6a <fork>
  if(pid < 0){
    1d96:	83 c4 10             	add    $0x10,%esp
    1d99:	85 c0                	test   %eax,%eax
  int pid, i, status;

  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
    1d9b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(pid < 0){
    1d9e:	0f 88 b6 00 00 00    	js     1e5a <linkunlink+0xea>
    printf(1, "fork failed\n");
    exit(1);
  }

  unsigned int x = (pid ? 1 : 97);
    1da4:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    1da8:	bb 64 00 00 00       	mov    $0x64,%ebx
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    1dad:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit(1);
  }

  unsigned int x = (pid ? 1 : 97);
    1db2:	19 ff                	sbb    %edi,%edi
    1db4:	83 e7 60             	and    $0x60,%edi
    1db7:	83 c7 01             	add    $0x1,%edi
    1dba:	eb 1e                	jmp    1dda <linkunlink+0x6a>
    1dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    1dc0:	83 fa 01             	cmp    $0x1,%edx
    1dc3:	74 7b                	je     1e40 <linkunlink+0xd0>
      link("cat", "x");
    } else {
      unlink("x");
    1dc5:	83 ec 0c             	sub    $0xc,%esp
    1dc8:	68 59 4c 00 00       	push   $0x4c59
    1dcd:	e8 f0 20 00 00       	call   3ec2 <unlink>
    1dd2:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit(1);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1dd5:	83 eb 01             	sub    $0x1,%ebx
    1dd8:	74 3d                	je     1e17 <linkunlink+0xa7>
    x = x * 1103515245 + 12345;
    1dda:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1de0:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1de6:	89 f8                	mov    %edi,%eax
    1de8:	f7 e6                	mul    %esi
    1dea:	d1 ea                	shr    %edx
    1dec:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1def:	89 fa                	mov    %edi,%edx
    1df1:	29 c2                	sub    %eax,%edx
    1df3:	75 cb                	jne    1dc0 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1df5:	83 ec 08             	sub    $0x8,%esp
    1df8:	68 02 02 00 00       	push   $0x202
    1dfd:	68 59 4c 00 00       	push   $0x4c59
    1e02:	e8 ab 20 00 00       	call   3eb2 <open>
    1e07:	89 04 24             	mov    %eax,(%esp)
    1e0a:	e8 8b 20 00 00       	call   3e9a <close>
    1e0f:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit(1);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1e12:	83 eb 01             	sub    $0x1,%ebx
    1e15:	75 c3                	jne    1dda <linkunlink+0x6a>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1e17:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1e1a:	85 c9                	test   %ecx,%ecx
    1e1c:	74 57                	je     1e75 <linkunlink+0x105>
    wait(&status);
    1e1e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1e21:	83 ec 0c             	sub    $0xc,%esp
    1e24:	50                   	push   %eax
    1e25:	e8 50 20 00 00       	call   3e7a <wait>
  else
    exit(0);

  printf(1, "linkunlink ok\n");
    1e2a:	58                   	pop    %eax
    1e2b:	5a                   	pop    %edx
    1e2c:	68 e1 49 00 00       	push   $0x49e1
    1e31:	6a 01                	push   $0x1
    1e33:	e8 a8 21 00 00       	call   3fe0 <printf>
}
    1e38:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e3b:	5b                   	pop    %ebx
    1e3c:	5e                   	pop    %esi
    1e3d:	5f                   	pop    %edi
    1e3e:	5d                   	pop    %ebp
    1e3f:	c3                   	ret    
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    1e40:	83 ec 08             	sub    $0x8,%esp
    1e43:	68 59 4c 00 00       	push   $0x4c59
    1e48:	68 dd 49 00 00       	push   $0x49dd
    1e4d:	e8 80 20 00 00       	call   3ed2 <link>
    1e52:	83 c4 10             	add    $0x10,%esp
    1e55:	e9 7b ff ff ff       	jmp    1dd5 <linkunlink+0x65>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    1e5a:	83 ec 08             	sub    $0x8,%esp
    1e5d:	68 41 52 00 00       	push   $0x5241
    1e62:	6a 01                	push   $0x1
    1e64:	e8 77 21 00 00       	call   3fe0 <printf>
    exit(1);
    1e69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e70:	e8 fd 1f 00 00       	call   3e72 <exit>
  }

  if(pid)
    wait(&status);
  else
    exit(0);
    1e75:	83 ec 0c             	sub    $0xc,%esp
    1e78:	6a 00                	push   $0x0
    1e7a:	e8 f3 1f 00 00       	call   3e72 <exit>
    1e7f:	90                   	nop

00001e80 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1e80:	55                   	push   %ebp
    1e81:	89 e5                	mov    %esp,%ebp
    1e83:	56                   	push   %esi
    1e84:	53                   	push   %ebx
    1e85:	83 ec 18             	sub    $0x18,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1e88:	68 f0 49 00 00       	push   $0x49f0
    1e8d:	6a 01                	push   $0x1
    1e8f:	e8 4c 21 00 00       	call   3fe0 <printf>
  unlink("bd");
    1e94:	c7 04 24 fd 49 00 00 	movl   $0x49fd,(%esp)
    1e9b:	e8 22 20 00 00       	call   3ec2 <unlink>

  fd = open("bd", O_CREATE);
    1ea0:	58                   	pop    %eax
    1ea1:	5a                   	pop    %edx
    1ea2:	68 00 02 00 00       	push   $0x200
    1ea7:	68 fd 49 00 00       	push   $0x49fd
    1eac:	e8 01 20 00 00       	call   3eb2 <open>
  if(fd < 0){
    1eb1:	83 c4 10             	add    $0x10,%esp
    1eb4:	85 c0                	test   %eax,%eax
    1eb6:	0f 88 ec 00 00 00    	js     1fa8 <bigdir+0x128>
    printf(1, "bigdir create failed\n");
    exit(1);
  }
  close(fd);
    1ebc:	83 ec 0c             	sub    $0xc,%esp
    1ebf:	8d 75 ee             	lea    -0x12(%ebp),%esi

  for(i = 0; i < 500; i++){
    1ec2:	31 db                	xor    %ebx,%ebx
  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    exit(1);
  }
  close(fd);
    1ec4:	50                   	push   %eax
    1ec5:	e8 d0 1f 00 00       	call   3e9a <close>
    1eca:	83 c4 10             	add    $0x10,%esp
    1ecd:	8d 76 00             	lea    0x0(%esi),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1ed0:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
    1ed2:	83 ec 08             	sub    $0x8,%esp
    exit(1);
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    1ed5:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1ed9:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
    1edc:	56                   	push   %esi
    1edd:	68 fd 49 00 00       	push   $0x49fd
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1ee2:	83 c0 30             	add    $0x30,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    1ee5:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1ee9:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1eec:	89 d8                	mov    %ebx,%eax
    1eee:	83 e0 3f             	and    $0x3f,%eax
    1ef1:	83 c0 30             	add    $0x30,%eax
    1ef4:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    if(link("bd", name) != 0){
    1ef7:	e8 d6 1f 00 00       	call   3ed2 <link>
    1efc:	83 c4 10             	add    $0x10,%esp
    1eff:	85 c0                	test   %eax,%eax
    1f01:	75 6f                	jne    1f72 <bigdir+0xf2>
    printf(1, "bigdir create failed\n");
    exit(1);
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1f03:	83 c3 01             	add    $0x1,%ebx
    1f06:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1f0c:	75 c2                	jne    1ed0 <bigdir+0x50>
      printf(1, "bigdir link failed\n");
      exit(1);
    }
  }

  unlink("bd");
    1f0e:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    1f11:	31 db                	xor    %ebx,%ebx
      printf(1, "bigdir link failed\n");
      exit(1);
    }
  }

  unlink("bd");
    1f13:	68 fd 49 00 00       	push   $0x49fd
    1f18:	e8 a5 1f 00 00       	call   3ec2 <unlink>
    1f1d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1f20:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
    1f22:	83 ec 0c             	sub    $0xc,%esp
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    1f25:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1f29:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
    1f2c:	56                   	push   %esi
  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    1f2d:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1f31:	83 c0 30             	add    $0x30,%eax
    1f34:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1f37:	89 d8                	mov    %ebx,%eax
    1f39:	83 e0 3f             	and    $0x3f,%eax
    1f3c:	83 c0 30             	add    $0x30,%eax
    1f3f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    if(unlink(name) != 0){
    1f42:	e8 7b 1f 00 00       	call   3ec2 <unlink>
    1f47:	83 c4 10             	add    $0x10,%esp
    1f4a:	85 c0                	test   %eax,%eax
    1f4c:	75 3f                	jne    1f8d <bigdir+0x10d>
      exit(1);
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1f4e:	83 c3 01             	add    $0x1,%ebx
    1f51:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1f57:	75 c7                	jne    1f20 <bigdir+0xa0>
      printf(1, "bigdir unlink failed");
      exit(1);
    }
  }

  printf(1, "bigdir ok\n");
    1f59:	83 ec 08             	sub    $0x8,%esp
    1f5c:	68 3f 4a 00 00       	push   $0x4a3f
    1f61:	6a 01                	push   $0x1
    1f63:	e8 78 20 00 00       	call   3fe0 <printf>
}
    1f68:	83 c4 10             	add    $0x10,%esp
    1f6b:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1f6e:	5b                   	pop    %ebx
    1f6f:	5e                   	pop    %esi
    1f70:	5d                   	pop    %ebp
    1f71:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1f72:	83 ec 08             	sub    $0x8,%esp
    1f75:	68 16 4a 00 00       	push   $0x4a16
    1f7a:	6a 01                	push   $0x1
    1f7c:	e8 5f 20 00 00       	call   3fe0 <printf>
      exit(1);
    1f81:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f88:	e8 e5 1e 00 00       	call   3e72 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1f8d:	83 ec 08             	sub    $0x8,%esp
    1f90:	68 2a 4a 00 00       	push   $0x4a2a
    1f95:	6a 01                	push   $0x1
    1f97:	e8 44 20 00 00       	call   3fe0 <printf>
      exit(1);
    1f9c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fa3:	e8 ca 1e 00 00       	call   3e72 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1fa8:	83 ec 08             	sub    $0x8,%esp
    1fab:	68 00 4a 00 00       	push   $0x4a00
    1fb0:	6a 01                	push   $0x1
    1fb2:	e8 29 20 00 00       	call   3fe0 <printf>
    exit(1);
    1fb7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fbe:	e8 af 1e 00 00       	call   3e72 <exit>
    1fc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001fd0 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1fd0:	55                   	push   %ebp
    1fd1:	89 e5                	mov    %esp,%ebp
    1fd3:	53                   	push   %ebx
    1fd4:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1fd7:	68 4a 4a 00 00       	push   $0x4a4a
    1fdc:	6a 01                	push   $0x1
    1fde:	e8 fd 1f 00 00       	call   3fe0 <printf>

  unlink("ff");
    1fe3:	c7 04 24 d3 4a 00 00 	movl   $0x4ad3,(%esp)
    1fea:	e8 d3 1e 00 00       	call   3ec2 <unlink>
  if(mkdir("dd") != 0){
    1fef:	c7 04 24 70 4b 00 00 	movl   $0x4b70,(%esp)
    1ff6:	e8 df 1e 00 00       	call   3eda <mkdir>
    1ffb:	83 c4 10             	add    $0x10,%esp
    1ffe:	85 c0                	test   %eax,%eax
    2000:	0f 85 4d 06 00 00    	jne    2653 <subdir+0x683>
    printf(1, "subdir mkdir dd failed\n");
    exit(1);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    2006:	83 ec 08             	sub    $0x8,%esp
    2009:	68 02 02 00 00       	push   $0x202
    200e:	68 a9 4a 00 00       	push   $0x4aa9
    2013:	e8 9a 1e 00 00       	call   3eb2 <open>
  if(fd < 0){
    2018:	83 c4 10             	add    $0x10,%esp
    201b:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit(1);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    201d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    201f:	0f 88 14 06 00 00    	js     2639 <subdir+0x669>
    printf(1, "create dd/ff failed\n");
    exit(1);
  }
  write(fd, "ff", 2);
    2025:	83 ec 04             	sub    $0x4,%esp
    2028:	6a 02                	push   $0x2
    202a:	68 d3 4a 00 00       	push   $0x4ad3
    202f:	50                   	push   %eax
    2030:	e8 5d 1e 00 00       	call   3e92 <write>
  close(fd);
    2035:	89 1c 24             	mov    %ebx,(%esp)
    2038:	e8 5d 1e 00 00       	call   3e9a <close>

  if(unlink("dd") >= 0){
    203d:	c7 04 24 70 4b 00 00 	movl   $0x4b70,(%esp)
    2044:	e8 79 1e 00 00       	call   3ec2 <unlink>
    2049:	83 c4 10             	add    $0x10,%esp
    204c:	85 c0                	test   %eax,%eax
    204e:	0f 89 cb 05 00 00    	jns    261f <subdir+0x64f>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit(0);
  }

  if(mkdir("/dd/dd") != 0){
    2054:	83 ec 0c             	sub    $0xc,%esp
    2057:	68 84 4a 00 00       	push   $0x4a84
    205c:	e8 79 1e 00 00       	call   3eda <mkdir>
    2061:	83 c4 10             	add    $0x10,%esp
    2064:	85 c0                	test   %eax,%eax
    2066:	0f 85 99 05 00 00    	jne    2605 <subdir+0x635>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit(1);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    206c:	83 ec 08             	sub    $0x8,%esp
    206f:	68 02 02 00 00       	push   $0x202
    2074:	68 a6 4a 00 00       	push   $0x4aa6
    2079:	e8 34 1e 00 00       	call   3eb2 <open>
  if(fd < 0){
    207e:	83 c4 10             	add    $0x10,%esp
    2081:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit(1);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2083:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2085:	0f 88 5c 04 00 00    	js     24e7 <subdir+0x517>
    printf(1, "create dd/dd/ff failed\n");
    exit(1);
  }
  write(fd, "FF", 2);
    208b:	83 ec 04             	sub    $0x4,%esp
    208e:	6a 02                	push   $0x2
    2090:	68 c7 4a 00 00       	push   $0x4ac7
    2095:	50                   	push   %eax
    2096:	e8 f7 1d 00 00       	call   3e92 <write>
  close(fd);
    209b:	89 1c 24             	mov    %ebx,(%esp)
    209e:	e8 f7 1d 00 00       	call   3e9a <close>

  fd = open("dd/dd/../ff", 0);
    20a3:	58                   	pop    %eax
    20a4:	5a                   	pop    %edx
    20a5:	6a 00                	push   $0x0
    20a7:	68 ca 4a 00 00       	push   $0x4aca
    20ac:	e8 01 1e 00 00       	call   3eb2 <open>
  if(fd < 0){
    20b1:	83 c4 10             	add    $0x10,%esp
    20b4:	85 c0                	test   %eax,%eax
    exit(1);
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    20b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    20b8:	0f 88 0f 04 00 00    	js     24cd <subdir+0x4fd>
    printf(1, "open dd/dd/../ff failed\n");
    exit(1);
  }
  cc = read(fd, buf, sizeof(buf));
    20be:	83 ec 04             	sub    $0x4,%esp
    20c1:	68 00 20 00 00       	push   $0x2000
    20c6:	68 80 8b 00 00       	push   $0x8b80
    20cb:	50                   	push   %eax
    20cc:	e8 b9 1d 00 00       	call   3e8a <read>
  if(cc != 2 || buf[0] != 'f'){
    20d1:	83 c4 10             	add    $0x10,%esp
    20d4:	83 f8 02             	cmp    $0x2,%eax
    20d7:	0f 85 3a 03 00 00    	jne    2417 <subdir+0x447>
    20dd:	80 3d 80 8b 00 00 66 	cmpb   $0x66,0x8b80
    20e4:	0f 85 2d 03 00 00    	jne    2417 <subdir+0x447>
    printf(1, "dd/dd/../ff wrong content\n");
    exit(1);
  }
  close(fd);
    20ea:	83 ec 0c             	sub    $0xc,%esp
    20ed:	53                   	push   %ebx
    20ee:	e8 a7 1d 00 00       	call   3e9a <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    20f3:	5b                   	pop    %ebx
    20f4:	58                   	pop    %eax
    20f5:	68 0a 4b 00 00       	push   $0x4b0a
    20fa:	68 a6 4a 00 00       	push   $0x4aa6
    20ff:	e8 ce 1d 00 00       	call   3ed2 <link>
    2104:	83 c4 10             	add    $0x10,%esp
    2107:	85 c0                	test   %eax,%eax
    2109:	0f 85 0c 04 00 00    	jne    251b <subdir+0x54b>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit(1);
  }

  if(unlink("dd/dd/ff") != 0){
    210f:	83 ec 0c             	sub    $0xc,%esp
    2112:	68 a6 4a 00 00       	push   $0x4aa6
    2117:	e8 a6 1d 00 00       	call   3ec2 <unlink>
    211c:	83 c4 10             	add    $0x10,%esp
    211f:	85 c0                	test   %eax,%eax
    2121:	0f 85 24 03 00 00    	jne    244b <subdir+0x47b>
    printf(1, "unlink dd/dd/ff failed\n");
    exit(1);
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2127:	83 ec 08             	sub    $0x8,%esp
    212a:	6a 00                	push   $0x0
    212c:	68 a6 4a 00 00       	push   $0x4aa6
    2131:	e8 7c 1d 00 00       	call   3eb2 <open>
    2136:	83 c4 10             	add    $0x10,%esp
    2139:	85 c0                	test   %eax,%eax
    213b:	0f 89 aa 04 00 00    	jns    25eb <subdir+0x61b>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit(0);
  }

  if(chdir("dd") != 0){
    2141:	83 ec 0c             	sub    $0xc,%esp
    2144:	68 70 4b 00 00       	push   $0x4b70
    2149:	e8 94 1d 00 00       	call   3ee2 <chdir>
    214e:	83 c4 10             	add    $0x10,%esp
    2151:	85 c0                	test   %eax,%eax
    2153:	0f 85 78 04 00 00    	jne    25d1 <subdir+0x601>
    printf(1, "chdir dd failed\n");
    exit(1);
  }
  if(chdir("dd/../../dd") != 0){
    2159:	83 ec 0c             	sub    $0xc,%esp
    215c:	68 3e 4b 00 00       	push   $0x4b3e
    2161:	e8 7c 1d 00 00       	call   3ee2 <chdir>
    2166:	83 c4 10             	add    $0x10,%esp
    2169:	85 c0                	test   %eax,%eax
    216b:	0f 85 c0 02 00 00    	jne    2431 <subdir+0x461>
    printf(1, "chdir dd/../../dd failed\n");
    exit(1);
  }
  if(chdir("dd/../../../dd") != 0){
    2171:	83 ec 0c             	sub    $0xc,%esp
    2174:	68 64 4b 00 00       	push   $0x4b64
    2179:	e8 64 1d 00 00       	call   3ee2 <chdir>
    217e:	83 c4 10             	add    $0x10,%esp
    2181:	85 c0                	test   %eax,%eax
    2183:	0f 85 a8 02 00 00    	jne    2431 <subdir+0x461>
    printf(1, "chdir dd/../../dd failed\n");
    exit(1);
  }
  if(chdir("./..") != 0){
    2189:	83 ec 0c             	sub    $0xc,%esp
    218c:	68 73 4b 00 00       	push   $0x4b73
    2191:	e8 4c 1d 00 00       	call   3ee2 <chdir>
    2196:	83 c4 10             	add    $0x10,%esp
    2199:	85 c0                	test   %eax,%eax
    219b:	0f 85 60 03 00 00    	jne    2501 <subdir+0x531>
    printf(1, "chdir ./.. failed\n");
    exit(1);
  }

  fd = open("dd/dd/ffff", 0);
    21a1:	83 ec 08             	sub    $0x8,%esp
    21a4:	6a 00                	push   $0x0
    21a6:	68 0a 4b 00 00       	push   $0x4b0a
    21ab:	e8 02 1d 00 00       	call   3eb2 <open>
  if(fd < 0){
    21b0:	83 c4 10             	add    $0x10,%esp
    21b3:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit(1);
  }

  fd = open("dd/dd/ffff", 0);
    21b5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    21b7:	0f 88 ce 05 00 00    	js     278b <subdir+0x7bb>
    printf(1, "open dd/dd/ffff failed\n");
    exit(1);
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    21bd:	83 ec 04             	sub    $0x4,%esp
    21c0:	68 00 20 00 00       	push   $0x2000
    21c5:	68 80 8b 00 00       	push   $0x8b80
    21ca:	50                   	push   %eax
    21cb:	e8 ba 1c 00 00       	call   3e8a <read>
    21d0:	83 c4 10             	add    $0x10,%esp
    21d3:	83 f8 02             	cmp    $0x2,%eax
    21d6:	0f 85 95 05 00 00    	jne    2771 <subdir+0x7a1>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit(1);
  }
  close(fd);
    21dc:	83 ec 0c             	sub    $0xc,%esp
    21df:	53                   	push   %ebx
    21e0:	e8 b5 1c 00 00       	call   3e9a <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    21e5:	59                   	pop    %ecx
    21e6:	5b                   	pop    %ebx
    21e7:	6a 00                	push   $0x0
    21e9:	68 a6 4a 00 00       	push   $0x4aa6
    21ee:	e8 bf 1c 00 00       	call   3eb2 <open>
    21f3:	83 c4 10             	add    $0x10,%esp
    21f6:	85 c0                	test   %eax,%eax
    21f8:	0f 89 81 02 00 00    	jns    247f <subdir+0x4af>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit(0);
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    21fe:	83 ec 08             	sub    $0x8,%esp
    2201:	68 02 02 00 00       	push   $0x202
    2206:	68 be 4b 00 00       	push   $0x4bbe
    220b:	e8 a2 1c 00 00       	call   3eb2 <open>
    2210:	83 c4 10             	add    $0x10,%esp
    2213:	85 c0                	test   %eax,%eax
    2215:	0f 89 4a 02 00 00    	jns    2465 <subdir+0x495>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    221b:	83 ec 08             	sub    $0x8,%esp
    221e:	68 02 02 00 00       	push   $0x202
    2223:	68 e3 4b 00 00       	push   $0x4be3
    2228:	e8 85 1c 00 00       	call   3eb2 <open>
    222d:	83 c4 10             	add    $0x10,%esp
    2230:	85 c0                	test   %eax,%eax
    2232:	0f 89 7f 03 00 00    	jns    25b7 <subdir+0x5e7>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(open("dd", O_CREATE) >= 0){
    2238:	83 ec 08             	sub    $0x8,%esp
    223b:	68 00 02 00 00       	push   $0x200
    2240:	68 70 4b 00 00       	push   $0x4b70
    2245:	e8 68 1c 00 00       	call   3eb2 <open>
    224a:	83 c4 10             	add    $0x10,%esp
    224d:	85 c0                	test   %eax,%eax
    224f:	0f 89 48 03 00 00    	jns    259d <subdir+0x5cd>
    printf(1, "create dd succeeded!\n");
    exit(0);
  }
  if(open("dd", O_RDWR) >= 0){
    2255:	83 ec 08             	sub    $0x8,%esp
    2258:	6a 02                	push   $0x2
    225a:	68 70 4b 00 00       	push   $0x4b70
    225f:	e8 4e 1c 00 00       	call   3eb2 <open>
    2264:	83 c4 10             	add    $0x10,%esp
    2267:	85 c0                	test   %eax,%eax
    2269:	0f 89 14 03 00 00    	jns    2583 <subdir+0x5b3>
    printf(1, "open dd rdwr succeeded!\n");
    exit(0);
  }
  if(open("dd", O_WRONLY) >= 0){
    226f:	83 ec 08             	sub    $0x8,%esp
    2272:	6a 01                	push   $0x1
    2274:	68 70 4b 00 00       	push   $0x4b70
    2279:	e8 34 1c 00 00       	call   3eb2 <open>
    227e:	83 c4 10             	add    $0x10,%esp
    2281:	85 c0                	test   %eax,%eax
    2283:	0f 89 e0 02 00 00    	jns    2569 <subdir+0x599>
    printf(1, "open dd wronly succeeded!\n");
    exit(0);
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2289:	83 ec 08             	sub    $0x8,%esp
    228c:	68 52 4c 00 00       	push   $0x4c52
    2291:	68 be 4b 00 00       	push   $0x4bbe
    2296:	e8 37 1c 00 00       	call   3ed2 <link>
    229b:	83 c4 10             	add    $0x10,%esp
    229e:	85 c0                	test   %eax,%eax
    22a0:	0f 84 a9 02 00 00    	je     254f <subdir+0x57f>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    22a6:	83 ec 08             	sub    $0x8,%esp
    22a9:	68 52 4c 00 00       	push   $0x4c52
    22ae:	68 e3 4b 00 00       	push   $0x4be3
    22b3:	e8 1a 1c 00 00       	call   3ed2 <link>
    22b8:	83 c4 10             	add    $0x10,%esp
    22bb:	85 c0                	test   %eax,%eax
    22bd:	0f 84 72 02 00 00    	je     2535 <subdir+0x565>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    22c3:	83 ec 08             	sub    $0x8,%esp
    22c6:	68 0a 4b 00 00       	push   $0x4b0a
    22cb:	68 a9 4a 00 00       	push   $0x4aa9
    22d0:	e8 fd 1b 00 00       	call   3ed2 <link>
    22d5:	83 c4 10             	add    $0x10,%esp
    22d8:	85 c0                	test   %eax,%eax
    22da:	0f 84 d3 01 00 00    	je     24b3 <subdir+0x4e3>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/ff/ff") == 0){
    22e0:	83 ec 0c             	sub    $0xc,%esp
    22e3:	68 be 4b 00 00       	push   $0x4bbe
    22e8:	e8 ed 1b 00 00       	call   3eda <mkdir>
    22ed:	83 c4 10             	add    $0x10,%esp
    22f0:	85 c0                	test   %eax,%eax
    22f2:	0f 84 a1 01 00 00    	je     2499 <subdir+0x4c9>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/xx/ff") == 0){
    22f8:	83 ec 0c             	sub    $0xc,%esp
    22fb:	68 e3 4b 00 00       	push   $0x4be3
    2300:	e8 d5 1b 00 00       	call   3eda <mkdir>
    2305:	83 c4 10             	add    $0x10,%esp
    2308:	85 c0                	test   %eax,%eax
    230a:	0f 84 47 04 00 00    	je     2757 <subdir+0x787>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/dd/ffff") == 0){
    2310:	83 ec 0c             	sub    $0xc,%esp
    2313:	68 0a 4b 00 00       	push   $0x4b0a
    2318:	e8 bd 1b 00 00       	call   3eda <mkdir>
    231d:	83 c4 10             	add    $0x10,%esp
    2320:	85 c0                	test   %eax,%eax
    2322:	0f 84 15 04 00 00    	je     273d <subdir+0x76d>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/xx/ff") == 0){
    2328:	83 ec 0c             	sub    $0xc,%esp
    232b:	68 e3 4b 00 00       	push   $0x4be3
    2330:	e8 8d 1b 00 00       	call   3ec2 <unlink>
    2335:	83 c4 10             	add    $0x10,%esp
    2338:	85 c0                	test   %eax,%eax
    233a:	0f 84 e3 03 00 00    	je     2723 <subdir+0x753>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/ff/ff") == 0){
    2340:	83 ec 0c             	sub    $0xc,%esp
    2343:	68 be 4b 00 00       	push   $0x4bbe
    2348:	e8 75 1b 00 00       	call   3ec2 <unlink>
    234d:	83 c4 10             	add    $0x10,%esp
    2350:	85 c0                	test   %eax,%eax
    2352:	0f 84 b1 03 00 00    	je     2709 <subdir+0x739>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/ff") == 0){
    2358:	83 ec 0c             	sub    $0xc,%esp
    235b:	68 a9 4a 00 00       	push   $0x4aa9
    2360:	e8 7d 1b 00 00       	call   3ee2 <chdir>
    2365:	83 c4 10             	add    $0x10,%esp
    2368:	85 c0                	test   %eax,%eax
    236a:	0f 84 7f 03 00 00    	je     26ef <subdir+0x71f>
    printf(1, "chdir dd/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/xx") == 0){
    2370:	83 ec 0c             	sub    $0xc,%esp
    2373:	68 55 4c 00 00       	push   $0x4c55
    2378:	e8 65 1b 00 00       	call   3ee2 <chdir>
    237d:	83 c4 10             	add    $0x10,%esp
    2380:	85 c0                	test   %eax,%eax
    2382:	0f 84 4d 03 00 00    	je     26d5 <subdir+0x705>
    printf(1, "chdir dd/xx succeeded!\n");
    exit(0);
  }

  if(unlink("dd/dd/ffff") != 0){
    2388:	83 ec 0c             	sub    $0xc,%esp
    238b:	68 0a 4b 00 00       	push   $0x4b0a
    2390:	e8 2d 1b 00 00       	call   3ec2 <unlink>
    2395:	83 c4 10             	add    $0x10,%esp
    2398:	85 c0                	test   %eax,%eax
    239a:	0f 85 ab 00 00 00    	jne    244b <subdir+0x47b>
    printf(1, "unlink dd/dd/ff failed\n");
    exit(1);
  }
  if(unlink("dd/ff") != 0){
    23a0:	83 ec 0c             	sub    $0xc,%esp
    23a3:	68 a9 4a 00 00       	push   $0x4aa9
    23a8:	e8 15 1b 00 00       	call   3ec2 <unlink>
    23ad:	83 c4 10             	add    $0x10,%esp
    23b0:	85 c0                	test   %eax,%eax
    23b2:	0f 85 03 03 00 00    	jne    26bb <subdir+0x6eb>
    printf(1, "unlink dd/ff failed\n");
    exit(1);
  }
  if(unlink("dd") == 0){
    23b8:	83 ec 0c             	sub    $0xc,%esp
    23bb:	68 70 4b 00 00       	push   $0x4b70
    23c0:	e8 fd 1a 00 00       	call   3ec2 <unlink>
    23c5:	83 c4 10             	add    $0x10,%esp
    23c8:	85 c0                	test   %eax,%eax
    23ca:	0f 84 d1 02 00 00    	je     26a1 <subdir+0x6d1>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit(0);
  }
  if(unlink("dd/dd") < 0){
    23d0:	83 ec 0c             	sub    $0xc,%esp
    23d3:	68 85 4a 00 00       	push   $0x4a85
    23d8:	e8 e5 1a 00 00       	call   3ec2 <unlink>
    23dd:	83 c4 10             	add    $0x10,%esp
    23e0:	85 c0                	test   %eax,%eax
    23e2:	0f 88 9f 02 00 00    	js     2687 <subdir+0x6b7>
    printf(1, "unlink dd/dd failed\n");
    exit(1);
  }
  if(unlink("dd") < 0){
    23e8:	83 ec 0c             	sub    $0xc,%esp
    23eb:	68 70 4b 00 00       	push   $0x4b70
    23f0:	e8 cd 1a 00 00       	call   3ec2 <unlink>
    23f5:	83 c4 10             	add    $0x10,%esp
    23f8:	85 c0                	test   %eax,%eax
    23fa:	0f 88 6d 02 00 00    	js     266d <subdir+0x69d>
    printf(1, "unlink dd failed\n");
    exit(1);
  }

  printf(1, "subdir ok\n");
    2400:	83 ec 08             	sub    $0x8,%esp
    2403:	68 52 4d 00 00       	push   $0x4d52
    2408:	6a 01                	push   $0x1
    240a:	e8 d1 1b 00 00       	call   3fe0 <printf>
}
    240f:	83 c4 10             	add    $0x10,%esp
    2412:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2415:	c9                   	leave  
    2416:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit(1);
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    2417:	50                   	push   %eax
    2418:	50                   	push   %eax
    2419:	68 ef 4a 00 00       	push   $0x4aef
    241e:	6a 01                	push   $0x1
    2420:	e8 bb 1b 00 00       	call   3fe0 <printf>
    exit(1);
    2425:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    242c:	e8 41 1a 00 00       	call   3e72 <exit>
  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    exit(1);
  }
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    2431:	50                   	push   %eax
    2432:	50                   	push   %eax
    2433:	68 4a 4b 00 00       	push   $0x4b4a
    2438:	6a 01                	push   $0x1
    243a:	e8 a1 1b 00 00       	call   3fe0 <printf>
    exit(1);
    243f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2446:	e8 27 1a 00 00       	call   3e72 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit(1);
  }

  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    244b:	52                   	push   %edx
    244c:	52                   	push   %edx
    244d:	68 15 4b 00 00       	push   $0x4b15
    2452:	6a 01                	push   $0x1
    2454:	e8 87 1b 00 00       	call   3fe0 <printf>
    exit(1);
    2459:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2460:	e8 0d 1a 00 00       	call   3e72 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit(0);
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    2465:	50                   	push   %eax
    2466:	50                   	push   %eax
    2467:	68 c7 4b 00 00       	push   $0x4bc7
    246c:	6a 01                	push   $0x1
    246e:	e8 6d 1b 00 00       	call   3fe0 <printf>
    exit(0);
    2473:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    247a:	e8 f3 19 00 00       	call   3e72 <exit>
    exit(1);
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    247f:	52                   	push   %edx
    2480:	52                   	push   %edx
    2481:	68 ac 55 00 00       	push   $0x55ac
    2486:	6a 01                	push   $0x1
    2488:	e8 53 1b 00 00       	call   3fe0 <printf>
    exit(0);
    248d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2494:	e8 d9 19 00 00       	call   3e72 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2499:	52                   	push   %edx
    249a:	52                   	push   %edx
    249b:	68 5b 4c 00 00       	push   $0x4c5b
    24a0:	6a 01                	push   $0x1
    24a2:	e8 39 1b 00 00       	call   3fe0 <printf>
    exit(0);
    24a7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24ae:	e8 bf 19 00 00       	call   3e72 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    24b3:	51                   	push   %ecx
    24b4:	51                   	push   %ecx
    24b5:	68 1c 56 00 00       	push   $0x561c
    24ba:	6a 01                	push   $0x1
    24bc:	e8 1f 1b 00 00       	call   3fe0 <printf>
    exit(0);
    24c1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24c8:	e8 a5 19 00 00       	call   3e72 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    24cd:	50                   	push   %eax
    24ce:	50                   	push   %eax
    24cf:	68 d6 4a 00 00       	push   $0x4ad6
    24d4:	6a 01                	push   $0x1
    24d6:	e8 05 1b 00 00       	call   3fe0 <printf>
    exit(1);
    24db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24e2:	e8 8b 19 00 00       	call   3e72 <exit>
    exit(1);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    24e7:	51                   	push   %ecx
    24e8:	51                   	push   %ecx
    24e9:	68 af 4a 00 00       	push   $0x4aaf
    24ee:	6a 01                	push   $0x1
    24f0:	e8 eb 1a 00 00       	call   3fe0 <printf>
    exit(1);
    24f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24fc:	e8 71 19 00 00       	call   3e72 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit(1);
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    2501:	50                   	push   %eax
    2502:	50                   	push   %eax
    2503:	68 78 4b 00 00       	push   $0x4b78
    2508:	6a 01                	push   $0x1
    250a:	e8 d1 1a 00 00       	call   3fe0 <printf>
    exit(1);
    250f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2516:	e8 57 19 00 00       	call   3e72 <exit>
    exit(1);
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    251b:	51                   	push   %ecx
    251c:	51                   	push   %ecx
    251d:	68 64 55 00 00       	push   $0x5564
    2522:	6a 01                	push   $0x1
    2524:	e8 b7 1a 00 00       	call   3fe0 <printf>
    exit(1);
    2529:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2530:	e8 3d 19 00 00       	call   3e72 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2535:	53                   	push   %ebx
    2536:	53                   	push   %ebx
    2537:	68 f8 55 00 00       	push   $0x55f8
    253c:	6a 01                	push   $0x1
    253e:	e8 9d 1a 00 00       	call   3fe0 <printf>
    exit(0);
    2543:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    254a:	e8 23 19 00 00       	call   3e72 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit(0);
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    254f:	50                   	push   %eax
    2550:	50                   	push   %eax
    2551:	68 d4 55 00 00       	push   $0x55d4
    2556:	6a 01                	push   $0x1
    2558:	e8 83 1a 00 00       	call   3fe0 <printf>
    exit(0);
    255d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2564:	e8 09 19 00 00       	call   3e72 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit(0);
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    2569:	50                   	push   %eax
    256a:	50                   	push   %eax
    256b:	68 37 4c 00 00       	push   $0x4c37
    2570:	6a 01                	push   $0x1
    2572:	e8 69 1a 00 00       	call   3fe0 <printf>
    exit(0);
    2577:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    257e:	e8 ef 18 00 00       	call   3e72 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit(0);
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    2583:	50                   	push   %eax
    2584:	50                   	push   %eax
    2585:	68 1e 4c 00 00       	push   $0x4c1e
    258a:	6a 01                	push   $0x1
    258c:	e8 4f 1a 00 00       	call   3fe0 <printf>
    exit(0);
    2591:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2598:	e8 d5 18 00 00       	call   3e72 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    259d:	50                   	push   %eax
    259e:	50                   	push   %eax
    259f:	68 08 4c 00 00       	push   $0x4c08
    25a4:	6a 01                	push   $0x1
    25a6:	e8 35 1a 00 00       	call   3fe0 <printf>
    exit(0);
    25ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25b2:	e8 bb 18 00 00       	call   3e72 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    25b7:	50                   	push   %eax
    25b8:	50                   	push   %eax
    25b9:	68 ec 4b 00 00       	push   $0x4bec
    25be:	6a 01                	push   $0x1
    25c0:	e8 1b 1a 00 00       	call   3fe0 <printf>
    exit(0);
    25c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25cc:	e8 a1 18 00 00       	call   3e72 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit(0);
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    25d1:	50                   	push   %eax
    25d2:	50                   	push   %eax
    25d3:	68 2d 4b 00 00       	push   $0x4b2d
    25d8:	6a 01                	push   $0x1
    25da:	e8 01 1a 00 00       	call   3fe0 <printf>
    exit(1);
    25df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25e6:	e8 87 18 00 00       	call   3e72 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit(1);
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    25eb:	50                   	push   %eax
    25ec:	50                   	push   %eax
    25ed:	68 88 55 00 00       	push   $0x5588
    25f2:	6a 01                	push   $0x1
    25f4:	e8 e7 19 00 00       	call   3fe0 <printf>
    exit(0);
    25f9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2600:	e8 6d 18 00 00       	call   3e72 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit(0);
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    2605:	53                   	push   %ebx
    2606:	53                   	push   %ebx
    2607:	68 8b 4a 00 00       	push   $0x4a8b
    260c:	6a 01                	push   $0x1
    260e:	e8 cd 19 00 00       	call   3fe0 <printf>
    exit(1);
    2613:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    261a:	e8 53 18 00 00       	call   3e72 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    261f:	50                   	push   %eax
    2620:	50                   	push   %eax
    2621:	68 3c 55 00 00       	push   $0x553c
    2626:	6a 01                	push   $0x1
    2628:	e8 b3 19 00 00       	call   3fe0 <printf>
    exit(0);
    262d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2634:	e8 39 18 00 00       	call   3e72 <exit>
    exit(1);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    2639:	50                   	push   %eax
    263a:	50                   	push   %eax
    263b:	68 6f 4a 00 00       	push   $0x4a6f
    2640:	6a 01                	push   $0x1
    2642:	e8 99 19 00 00       	call   3fe0 <printf>
    exit(1);
    2647:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    264e:	e8 1f 18 00 00       	call   3e72 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    2653:	50                   	push   %eax
    2654:	50                   	push   %eax
    2655:	68 57 4a 00 00       	push   $0x4a57
    265a:	6a 01                	push   $0x1
    265c:	e8 7f 19 00 00       	call   3fe0 <printf>
    exit(1);
    2661:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2668:	e8 05 18 00 00       	call   3e72 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit(1);
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    266d:	50                   	push   %eax
    266e:	50                   	push   %eax
    266f:	68 40 4d 00 00       	push   $0x4d40
    2674:	6a 01                	push   $0x1
    2676:	e8 65 19 00 00       	call   3fe0 <printf>
    exit(1);
    267b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2682:	e8 eb 17 00 00       	call   3e72 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit(0);
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    2687:	52                   	push   %edx
    2688:	52                   	push   %edx
    2689:	68 2b 4d 00 00       	push   $0x4d2b
    268e:	6a 01                	push   $0x1
    2690:	e8 4b 19 00 00       	call   3fe0 <printf>
    exit(1);
    2695:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    269c:	e8 d1 17 00 00       	call   3e72 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit(1);
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    26a1:	51                   	push   %ecx
    26a2:	51                   	push   %ecx
    26a3:	68 40 56 00 00       	push   $0x5640
    26a8:	6a 01                	push   $0x1
    26aa:	e8 31 19 00 00       	call   3fe0 <printf>
    exit(0);
    26af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26b6:	e8 b7 17 00 00       	call   3e72 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit(1);
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    26bb:	53                   	push   %ebx
    26bc:	53                   	push   %ebx
    26bd:	68 16 4d 00 00       	push   $0x4d16
    26c2:	6a 01                	push   $0x1
    26c4:	e8 17 19 00 00       	call   3fe0 <printf>
    exit(1);
    26c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26d0:	e8 9d 17 00 00       	call   3e72 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    26d5:	50                   	push   %eax
    26d6:	50                   	push   %eax
    26d7:	68 fe 4c 00 00       	push   $0x4cfe
    26dc:	6a 01                	push   $0x1
    26de:	e8 fd 18 00 00       	call   3fe0 <printf>
    exit(0);
    26e3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26ea:	e8 83 17 00 00       	call   3e72 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    26ef:	50                   	push   %eax
    26f0:	50                   	push   %eax
    26f1:	68 e6 4c 00 00       	push   $0x4ce6
    26f6:	6a 01                	push   $0x1
    26f8:	e8 e3 18 00 00       	call   3fe0 <printf>
    exit(0);
    26fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2704:	e8 69 17 00 00       	call   3e72 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2709:	50                   	push   %eax
    270a:	50                   	push   %eax
    270b:	68 ca 4c 00 00       	push   $0x4cca
    2710:	6a 01                	push   $0x1
    2712:	e8 c9 18 00 00       	call   3fe0 <printf>
    exit(0);
    2717:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    271e:	e8 4f 17 00 00       	call   3e72 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2723:	50                   	push   %eax
    2724:	50                   	push   %eax
    2725:	68 ae 4c 00 00       	push   $0x4cae
    272a:	6a 01                	push   $0x1
    272c:	e8 af 18 00 00       	call   3fe0 <printf>
    exit(0);
    2731:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2738:	e8 35 17 00 00       	call   3e72 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    273d:	50                   	push   %eax
    273e:	50                   	push   %eax
    273f:	68 91 4c 00 00       	push   $0x4c91
    2744:	6a 01                	push   $0x1
    2746:	e8 95 18 00 00       	call   3fe0 <printf>
    exit(0);
    274b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2752:	e8 1b 17 00 00       	call   3e72 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2757:	50                   	push   %eax
    2758:	50                   	push   %eax
    2759:	68 76 4c 00 00       	push   $0x4c76
    275e:	6a 01                	push   $0x1
    2760:	e8 7b 18 00 00       	call   3fe0 <printf>
    exit(0);
    2765:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    276c:	e8 01 17 00 00       	call   3e72 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit(1);
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    2771:	50                   	push   %eax
    2772:	50                   	push   %eax
    2773:	68 a3 4b 00 00       	push   $0x4ba3
    2778:	6a 01                	push   $0x1
    277a:	e8 61 18 00 00       	call   3fe0 <printf>
    exit(1);
    277f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2786:	e8 e7 16 00 00       	call   3e72 <exit>
    exit(1);
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    278b:	50                   	push   %eax
    278c:	50                   	push   %eax
    278d:	68 8b 4b 00 00       	push   $0x4b8b
    2792:	6a 01                	push   $0x1
    2794:	e8 47 18 00 00       	call   3fe0 <printf>
    exit(1);
    2799:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27a0:	e8 cd 16 00 00       	call   3e72 <exit>
    27a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    27a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000027b0 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    27b0:	55                   	push   %ebp
    27b1:	89 e5                	mov    %esp,%ebp
    27b3:	56                   	push   %esi
    27b4:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    27b5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
void
bigwrite(void)
{
  int fd, sz;

  printf(1, "bigwrite test\n");
    27ba:	83 ec 08             	sub    $0x8,%esp
    27bd:	68 5d 4d 00 00       	push   $0x4d5d
    27c2:	6a 01                	push   $0x1
    27c4:	e8 17 18 00 00       	call   3fe0 <printf>

  unlink("bigwrite");
    27c9:	c7 04 24 6c 4d 00 00 	movl   $0x4d6c,(%esp)
    27d0:	e8 ed 16 00 00       	call   3ec2 <unlink>
    27d5:	83 c4 10             	add    $0x10,%esp
    27d8:	90                   	nop
    27d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    27e0:	83 ec 08             	sub    $0x8,%esp
    27e3:	68 02 02 00 00       	push   $0x202
    27e8:	68 6c 4d 00 00       	push   $0x4d6c
    27ed:	e8 c0 16 00 00       	call   3eb2 <open>
    if(fd < 0){
    27f2:	83 c4 10             	add    $0x10,%esp
    27f5:	85 c0                	test   %eax,%eax

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    27f7:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    27f9:	0f 88 85 00 00 00    	js     2884 <bigwrite+0xd4>
      printf(1, "cannot create bigwrite\n");
      exit(1);
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    27ff:	83 ec 04             	sub    $0x4,%esp
    2802:	53                   	push   %ebx
    2803:	68 80 8b 00 00       	push   $0x8b80
    2808:	50                   	push   %eax
    2809:	e8 84 16 00 00       	call   3e92 <write>
      if(cc != sz){
    280e:	83 c4 10             	add    $0x10,%esp
    2811:	39 c3                	cmp    %eax,%ebx
    2813:	75 55                	jne    286a <bigwrite+0xba>
      printf(1, "cannot create bigwrite\n");
      exit(1);
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    2815:	83 ec 04             	sub    $0x4,%esp
    2818:	53                   	push   %ebx
    2819:	68 80 8b 00 00       	push   $0x8b80
    281e:	56                   	push   %esi
    281f:	e8 6e 16 00 00       	call   3e92 <write>
      if(cc != sz){
    2824:	83 c4 10             	add    $0x10,%esp
    2827:	39 c3                	cmp    %eax,%ebx
    2829:	75 3f                	jne    286a <bigwrite+0xba>
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit(0);
      }
    }
    close(fd);
    282b:	83 ec 0c             	sub    $0xc,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    282e:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit(0);
      }
    }
    close(fd);
    2834:	56                   	push   %esi
    2835:	e8 60 16 00 00       	call   3e9a <close>
    unlink("bigwrite");
    283a:	c7 04 24 6c 4d 00 00 	movl   $0x4d6c,(%esp)
    2841:	e8 7c 16 00 00       	call   3ec2 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    2846:	83 c4 10             	add    $0x10,%esp
    2849:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    284f:	75 8f                	jne    27e0 <bigwrite+0x30>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    2851:	83 ec 08             	sub    $0x8,%esp
    2854:	68 9f 4d 00 00       	push   $0x4d9f
    2859:	6a 01                	push   $0x1
    285b:	e8 80 17 00 00       	call   3fe0 <printf>
}
    2860:	83 c4 10             	add    $0x10,%esp
    2863:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2866:	5b                   	pop    %ebx
    2867:	5e                   	pop    %esi
    2868:	5d                   	pop    %ebp
    2869:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    286a:	50                   	push   %eax
    286b:	53                   	push   %ebx
    286c:	68 8d 4d 00 00       	push   $0x4d8d
    2871:	6a 01                	push   $0x1
    2873:	e8 68 17 00 00       	call   3fe0 <printf>
        exit(0);
    2878:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    287f:	e8 ee 15 00 00       	call   3e72 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    2884:	83 ec 08             	sub    $0x8,%esp
    2887:	68 75 4d 00 00       	push   $0x4d75
    288c:	6a 01                	push   $0x1
    288e:	e8 4d 17 00 00       	call   3fe0 <printf>
      exit(1);
    2893:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    289a:	e8 d3 15 00 00       	call   3e72 <exit>
    289f:	90                   	nop

000028a0 <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    28a0:	55                   	push   %ebp
    28a1:	89 e5                	mov    %esp,%ebp
    28a3:	57                   	push   %edi
    28a4:	56                   	push   %esi
    28a5:	53                   	push   %ebx
    28a6:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    28a9:	68 ac 4d 00 00       	push   $0x4dac
    28ae:	6a 01                	push   $0x1
    28b0:	e8 2b 17 00 00       	call   3fe0 <printf>

  unlink("bigfile");
    28b5:	c7 04 24 c8 4d 00 00 	movl   $0x4dc8,(%esp)
    28bc:	e8 01 16 00 00       	call   3ec2 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    28c1:	5e                   	pop    %esi
    28c2:	5f                   	pop    %edi
    28c3:	68 02 02 00 00       	push   $0x202
    28c8:	68 c8 4d 00 00       	push   $0x4dc8
    28cd:	e8 e0 15 00 00       	call   3eb2 <open>
  if(fd < 0){
    28d2:	83 c4 10             	add    $0x10,%esp
    28d5:	85 c0                	test   %eax,%eax
    28d7:	0f 88 82 01 00 00    	js     2a5f <bigfile+0x1bf>
    28dd:	89 c6                	mov    %eax,%esi
    28df:	31 db                	xor    %ebx,%ebx
    28e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "cannot create bigfile");
    exit(1);
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    28e8:	83 ec 04             	sub    $0x4,%esp
    28eb:	68 58 02 00 00       	push   $0x258
    28f0:	53                   	push   %ebx
    28f1:	68 80 8b 00 00       	push   $0x8b80
    28f6:	e8 e5 13 00 00       	call   3ce0 <memset>
    if(write(fd, buf, 600) != 600){
    28fb:	83 c4 0c             	add    $0xc,%esp
    28fe:	68 58 02 00 00       	push   $0x258
    2903:	68 80 8b 00 00       	push   $0x8b80
    2908:	56                   	push   %esi
    2909:	e8 84 15 00 00       	call   3e92 <write>
    290e:	83 c4 10             	add    $0x10,%esp
    2911:	3d 58 02 00 00       	cmp    $0x258,%eax
    2916:	0f 85 0d 01 00 00    	jne    2a29 <bigfile+0x189>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit(1);
  }
  for(i = 0; i < 20; i++){
    291c:	83 c3 01             	add    $0x1,%ebx
    291f:	83 fb 14             	cmp    $0x14,%ebx
    2922:	75 c4                	jne    28e8 <bigfile+0x48>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit(0);
    }
  }
  close(fd);
    2924:	83 ec 0c             	sub    $0xc,%esp
    2927:	56                   	push   %esi
    2928:	e8 6d 15 00 00       	call   3e9a <close>

  fd = open("bigfile", 0);
    292d:	59                   	pop    %ecx
    292e:	5b                   	pop    %ebx
    292f:	6a 00                	push   $0x0
    2931:	68 c8 4d 00 00       	push   $0x4dc8
    2936:	e8 77 15 00 00       	call   3eb2 <open>
  if(fd < 0){
    293b:	83 c4 10             	add    $0x10,%esp
    293e:	85 c0                	test   %eax,%eax
      exit(0);
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    2940:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2942:	0f 88 fc 00 00 00    	js     2a44 <bigfile+0x1a4>
    2948:	31 db                	xor    %ebx,%ebx
    294a:	31 ff                	xor    %edi,%edi
    294c:	eb 30                	jmp    297e <bigfile+0xde>
    294e:	66 90                	xchg   %ax,%ax
      printf(1, "read bigfile failed\n");
      exit(1);
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2950:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2955:	0f 85 98 00 00 00    	jne    29f3 <bigfile+0x153>
      printf(1, "short read bigfile\n");
      exit(1);
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    295b:	0f be 05 80 8b 00 00 	movsbl 0x8b80,%eax
    2962:	89 fa                	mov    %edi,%edx
    2964:	d1 fa                	sar    %edx
    2966:	39 d0                	cmp    %edx,%eax
    2968:	75 6e                	jne    29d8 <bigfile+0x138>
    296a:	0f be 15 ab 8c 00 00 	movsbl 0x8cab,%edx
    2971:	39 d0                	cmp    %edx,%eax
    2973:	75 63                	jne    29d8 <bigfile+0x138>
      printf(1, "read bigfile wrong data\n");
      exit(1);
    }
    total += cc;
    2975:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit(1);
  }
  total = 0;
  for(i = 0; ; i++){
    297b:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    297e:	83 ec 04             	sub    $0x4,%esp
    2981:	68 2c 01 00 00       	push   $0x12c
    2986:	68 80 8b 00 00       	push   $0x8b80
    298b:	56                   	push   %esi
    298c:	e8 f9 14 00 00       	call   3e8a <read>
    if(cc < 0){
    2991:	83 c4 10             	add    $0x10,%esp
    2994:	85 c0                	test   %eax,%eax
    2996:	78 76                	js     2a0e <bigfile+0x16e>
      printf(1, "read bigfile failed\n");
      exit(1);
    }
    if(cc == 0)
    2998:	75 b6                	jne    2950 <bigfile+0xb0>
      printf(1, "read bigfile wrong data\n");
      exit(1);
    }
    total += cc;
  }
  close(fd);
    299a:	83 ec 0c             	sub    $0xc,%esp
    299d:	56                   	push   %esi
    299e:	e8 f7 14 00 00       	call   3e9a <close>
  if(total != 20*600){
    29a3:	83 c4 10             	add    $0x10,%esp
    29a6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    29ac:	0f 85 c8 00 00 00    	jne    2a7a <bigfile+0x1da>
    printf(1, "read bigfile wrong total\n");
    exit(1);
  }
  unlink("bigfile");
    29b2:	83 ec 0c             	sub    $0xc,%esp
    29b5:	68 c8 4d 00 00       	push   $0x4dc8
    29ba:	e8 03 15 00 00       	call   3ec2 <unlink>

  printf(1, "bigfile test ok\n");
    29bf:	58                   	pop    %eax
    29c0:	5a                   	pop    %edx
    29c1:	68 57 4e 00 00       	push   $0x4e57
    29c6:	6a 01                	push   $0x1
    29c8:	e8 13 16 00 00       	call   3fe0 <printf>
}
    29cd:	83 c4 10             	add    $0x10,%esp
    29d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    29d3:	5b                   	pop    %ebx
    29d4:	5e                   	pop    %esi
    29d5:	5f                   	pop    %edi
    29d6:	5d                   	pop    %ebp
    29d7:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit(1);
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    29d8:	83 ec 08             	sub    $0x8,%esp
    29db:	68 24 4e 00 00       	push   $0x4e24
    29e0:	6a 01                	push   $0x1
    29e2:	e8 f9 15 00 00       	call   3fe0 <printf>
      exit(1);
    29e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29ee:	e8 7f 14 00 00       	call   3e72 <exit>
      exit(1);
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    29f3:	83 ec 08             	sub    $0x8,%esp
    29f6:	68 10 4e 00 00       	push   $0x4e10
    29fb:	6a 01                	push   $0x1
    29fd:	e8 de 15 00 00       	call   3fe0 <printf>
      exit(1);
    2a02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a09:	e8 64 14 00 00       	call   3e72 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    2a0e:	83 ec 08             	sub    $0x8,%esp
    2a11:	68 fb 4d 00 00       	push   $0x4dfb
    2a16:	6a 01                	push   $0x1
    2a18:	e8 c3 15 00 00       	call   3fe0 <printf>
      exit(1);
    2a1d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a24:	e8 49 14 00 00       	call   3e72 <exit>
    exit(1);
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    2a29:	83 ec 08             	sub    $0x8,%esp
    2a2c:	68 d0 4d 00 00       	push   $0x4dd0
    2a31:	6a 01                	push   $0x1
    2a33:	e8 a8 15 00 00       	call   3fe0 <printf>
      exit(0);
    2a38:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2a3f:	e8 2e 14 00 00       	call   3e72 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    2a44:	83 ec 08             	sub    $0x8,%esp
    2a47:	68 e6 4d 00 00       	push   $0x4de6
    2a4c:	6a 01                	push   $0x1
    2a4e:	e8 8d 15 00 00       	call   3fe0 <printf>
    exit(1);
    2a53:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a5a:	e8 13 14 00 00       	call   3e72 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    2a5f:	83 ec 08             	sub    $0x8,%esp
    2a62:	68 ba 4d 00 00       	push   $0x4dba
    2a67:	6a 01                	push   $0x1
    2a69:	e8 72 15 00 00       	call   3fe0 <printf>
    exit(1);
    2a6e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a75:	e8 f8 13 00 00       	call   3e72 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    2a7a:	83 ec 08             	sub    $0x8,%esp
    2a7d:	68 3d 4e 00 00       	push   $0x4e3d
    2a82:	6a 01                	push   $0x1
    2a84:	e8 57 15 00 00       	call   3fe0 <printf>
    exit(1);
    2a89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a90:	e8 dd 13 00 00       	call   3e72 <exit>
    2a95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002aa0 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    2aa0:	55                   	push   %ebp
    2aa1:	89 e5                	mov    %esp,%ebp
    2aa3:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2aa6:	68 68 4e 00 00       	push   $0x4e68
    2aab:	6a 01                	push   $0x1
    2aad:	e8 2e 15 00 00       	call   3fe0 <printf>

  if(mkdir("12345678901234") != 0){
    2ab2:	c7 04 24 a3 4e 00 00 	movl   $0x4ea3,(%esp)
    2ab9:	e8 1c 14 00 00       	call   3eda <mkdir>
    2abe:	83 c4 10             	add    $0x10,%esp
    2ac1:	85 c0                	test   %eax,%eax
    2ac3:	0f 85 9b 00 00 00    	jne    2b64 <fourteen+0xc4>
    printf(1, "mkdir 12345678901234 failed\n");
    exit(1);
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2ac9:	83 ec 0c             	sub    $0xc,%esp
    2acc:	68 60 56 00 00       	push   $0x5660
    2ad1:	e8 04 14 00 00       	call   3eda <mkdir>
    2ad6:	83 c4 10             	add    $0x10,%esp
    2ad9:	85 c0                	test   %eax,%eax
    2adb:	0f 85 05 01 00 00    	jne    2be6 <fourteen+0x146>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit(1);
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2ae1:	83 ec 08             	sub    $0x8,%esp
    2ae4:	68 00 02 00 00       	push   $0x200
    2ae9:	68 b0 56 00 00       	push   $0x56b0
    2aee:	e8 bf 13 00 00       	call   3eb2 <open>
  if(fd < 0){
    2af3:	83 c4 10             	add    $0x10,%esp
    2af6:	85 c0                	test   %eax,%eax
    2af8:	0f 88 ce 00 00 00    	js     2bcc <fourteen+0x12c>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit(1);
  }
  close(fd);
    2afe:	83 ec 0c             	sub    $0xc,%esp
    2b01:	50                   	push   %eax
    2b02:	e8 93 13 00 00       	call   3e9a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2b07:	58                   	pop    %eax
    2b08:	5a                   	pop    %edx
    2b09:	6a 00                	push   $0x0
    2b0b:	68 20 57 00 00       	push   $0x5720
    2b10:	e8 9d 13 00 00       	call   3eb2 <open>
  if(fd < 0){
    2b15:	83 c4 10             	add    $0x10,%esp
    2b18:	85 c0                	test   %eax,%eax
    2b1a:	0f 88 92 00 00 00    	js     2bb2 <fourteen+0x112>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit(1);
  }
  close(fd);
    2b20:	83 ec 0c             	sub    $0xc,%esp
    2b23:	50                   	push   %eax
    2b24:	e8 71 13 00 00       	call   3e9a <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2b29:	c7 04 24 94 4e 00 00 	movl   $0x4e94,(%esp)
    2b30:	e8 a5 13 00 00       	call   3eda <mkdir>
    2b35:	83 c4 10             	add    $0x10,%esp
    2b38:	85 c0                	test   %eax,%eax
    2b3a:	74 5c                	je     2b98 <fourteen+0xf8>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit(0);
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2b3c:	83 ec 0c             	sub    $0xc,%esp
    2b3f:	68 bc 57 00 00       	push   $0x57bc
    2b44:	e8 91 13 00 00       	call   3eda <mkdir>
    2b49:	83 c4 10             	add    $0x10,%esp
    2b4c:	85 c0                	test   %eax,%eax
    2b4e:	74 2e                	je     2b7e <fourteen+0xde>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit(0);
  }

  printf(1, "fourteen ok\n");
    2b50:	83 ec 08             	sub    $0x8,%esp
    2b53:	68 b2 4e 00 00       	push   $0x4eb2
    2b58:	6a 01                	push   $0x1
    2b5a:	e8 81 14 00 00       	call   3fe0 <printf>
}
    2b5f:	83 c4 10             	add    $0x10,%esp
    2b62:	c9                   	leave  
    2b63:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    2b64:	50                   	push   %eax
    2b65:	50                   	push   %eax
    2b66:	68 77 4e 00 00       	push   $0x4e77
    2b6b:	6a 01                	push   $0x1
    2b6d:	e8 6e 14 00 00       	call   3fe0 <printf>
    exit(1);
    2b72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b79:	e8 f4 12 00 00       	call   3e72 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit(0);
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2b7e:	50                   	push   %eax
    2b7f:	50                   	push   %eax
    2b80:	68 dc 57 00 00       	push   $0x57dc
    2b85:	6a 01                	push   $0x1
    2b87:	e8 54 14 00 00       	call   3fe0 <printf>
    exit(0);
    2b8c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b93:	e8 da 12 00 00       	call   3e72 <exit>
    exit(1);
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2b98:	52                   	push   %edx
    2b99:	52                   	push   %edx
    2b9a:	68 8c 57 00 00       	push   $0x578c
    2b9f:	6a 01                	push   $0x1
    2ba1:	e8 3a 14 00 00       	call   3fe0 <printf>
    exit(0);
    2ba6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bad:	e8 c0 12 00 00       	call   3e72 <exit>
    exit(1);
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2bb2:	51                   	push   %ecx
    2bb3:	51                   	push   %ecx
    2bb4:	68 50 57 00 00       	push   $0x5750
    2bb9:	6a 01                	push   $0x1
    2bbb:	e8 20 14 00 00       	call   3fe0 <printf>
    exit(1);
    2bc0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bc7:	e8 a6 12 00 00       	call   3e72 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit(1);
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2bcc:	51                   	push   %ecx
    2bcd:	51                   	push   %ecx
    2bce:	68 e0 56 00 00       	push   $0x56e0
    2bd3:	6a 01                	push   $0x1
    2bd5:	e8 06 14 00 00       	call   3fe0 <printf>
    exit(1);
    2bda:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2be1:	e8 8c 12 00 00       	call   3e72 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit(1);
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2be6:	50                   	push   %eax
    2be7:	50                   	push   %eax
    2be8:	68 80 56 00 00       	push   $0x5680
    2bed:	6a 01                	push   $0x1
    2bef:	e8 ec 13 00 00       	call   3fe0 <printf>
    exit(1);
    2bf4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bfb:	e8 72 12 00 00       	call   3e72 <exit>

00002c00 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    2c00:	55                   	push   %ebp
    2c01:	89 e5                	mov    %esp,%ebp
    2c03:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    2c06:	68 bf 4e 00 00       	push   $0x4ebf
    2c0b:	6a 01                	push   $0x1
    2c0d:	e8 ce 13 00 00       	call   3fe0 <printf>
  if(mkdir("dots") != 0){
    2c12:	c7 04 24 cb 4e 00 00 	movl   $0x4ecb,(%esp)
    2c19:	e8 bc 12 00 00       	call   3eda <mkdir>
    2c1e:	83 c4 10             	add    $0x10,%esp
    2c21:	85 c0                	test   %eax,%eax
    2c23:	0f 85 b4 00 00 00    	jne    2cdd <rmdot+0xdd>
    printf(1, "mkdir dots failed\n");
    exit(1);
  }
  if(chdir("dots") != 0){
    2c29:	83 ec 0c             	sub    $0xc,%esp
    2c2c:	68 cb 4e 00 00       	push   $0x4ecb
    2c31:	e8 ac 12 00 00       	call   3ee2 <chdir>
    2c36:	83 c4 10             	add    $0x10,%esp
    2c39:	85 c0                	test   %eax,%eax
    2c3b:	0f 85 52 01 00 00    	jne    2d93 <rmdot+0x193>
    printf(1, "chdir dots failed\n");
    exit(1);
  }
  if(unlink(".") == 0){
    2c41:	83 ec 0c             	sub    $0xc,%esp
    2c44:	68 76 4b 00 00       	push   $0x4b76
    2c49:	e8 74 12 00 00       	call   3ec2 <unlink>
    2c4e:	83 c4 10             	add    $0x10,%esp
    2c51:	85 c0                	test   %eax,%eax
    2c53:	0f 84 20 01 00 00    	je     2d79 <rmdot+0x179>
    printf(1, "rm . worked!\n");
    exit(0);
  }
  if(unlink("..") == 0){
    2c59:	83 ec 0c             	sub    $0xc,%esp
    2c5c:	68 75 4b 00 00       	push   $0x4b75
    2c61:	e8 5c 12 00 00       	call   3ec2 <unlink>
    2c66:	83 c4 10             	add    $0x10,%esp
    2c69:	85 c0                	test   %eax,%eax
    2c6b:	0f 84 ee 00 00 00    	je     2d5f <rmdot+0x15f>
    printf(1, "rm .. worked!\n");
    exit(0);
  }
  if(chdir("/") != 0){
    2c71:	83 ec 0c             	sub    $0xc,%esp
    2c74:	68 49 43 00 00       	push   $0x4349
    2c79:	e8 64 12 00 00       	call   3ee2 <chdir>
    2c7e:	83 c4 10             	add    $0x10,%esp
    2c81:	85 c0                	test   %eax,%eax
    2c83:	0f 85 bc 00 00 00    	jne    2d45 <rmdot+0x145>
    printf(1, "chdir / failed\n");
    exit(1);
  }
  if(unlink("dots/.") == 0){
    2c89:	83 ec 0c             	sub    $0xc,%esp
    2c8c:	68 13 4f 00 00       	push   $0x4f13
    2c91:	e8 2c 12 00 00       	call   3ec2 <unlink>
    2c96:	83 c4 10             	add    $0x10,%esp
    2c99:	85 c0                	test   %eax,%eax
    2c9b:	0f 84 8a 00 00 00    	je     2d2b <rmdot+0x12b>
    printf(1, "unlink dots/. worked!\n");
    exit(0);
  }
  if(unlink("dots/..") == 0){
    2ca1:	83 ec 0c             	sub    $0xc,%esp
    2ca4:	68 31 4f 00 00       	push   $0x4f31
    2ca9:	e8 14 12 00 00       	call   3ec2 <unlink>
    2cae:	83 c4 10             	add    $0x10,%esp
    2cb1:	85 c0                	test   %eax,%eax
    2cb3:	74 5c                	je     2d11 <rmdot+0x111>
    printf(1, "unlink dots/.. worked!\n");
    exit(0);
  }
  if(unlink("dots") != 0){
    2cb5:	83 ec 0c             	sub    $0xc,%esp
    2cb8:	68 cb 4e 00 00       	push   $0x4ecb
    2cbd:	e8 00 12 00 00       	call   3ec2 <unlink>
    2cc2:	83 c4 10             	add    $0x10,%esp
    2cc5:	85 c0                	test   %eax,%eax
    2cc7:	75 2e                	jne    2cf7 <rmdot+0xf7>
    printf(1, "unlink dots failed!\n");
    exit(1);
  }
  printf(1, "rmdot ok\n");
    2cc9:	83 ec 08             	sub    $0x8,%esp
    2ccc:	68 66 4f 00 00       	push   $0x4f66
    2cd1:	6a 01                	push   $0x1
    2cd3:	e8 08 13 00 00       	call   3fe0 <printf>
}
    2cd8:	83 c4 10             	add    $0x10,%esp
    2cdb:	c9                   	leave  
    2cdc:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    2cdd:	50                   	push   %eax
    2cde:	50                   	push   %eax
    2cdf:	68 d0 4e 00 00       	push   $0x4ed0
    2ce4:	6a 01                	push   $0x1
    2ce6:	e8 f5 12 00 00       	call   3fe0 <printf>
    exit(1);
    2ceb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cf2:	e8 7b 11 00 00       	call   3e72 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit(0);
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    2cf7:	50                   	push   %eax
    2cf8:	50                   	push   %eax
    2cf9:	68 51 4f 00 00       	push   $0x4f51
    2cfe:	6a 01                	push   $0x1
    2d00:	e8 db 12 00 00       	call   3fe0 <printf>
    exit(1);
    2d05:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d0c:	e8 61 11 00 00       	call   3e72 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit(0);
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    2d11:	52                   	push   %edx
    2d12:	52                   	push   %edx
    2d13:	68 39 4f 00 00       	push   $0x4f39
    2d18:	6a 01                	push   $0x1
    2d1a:	e8 c1 12 00 00       	call   3fe0 <printf>
    exit(0);
    2d1f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d26:	e8 47 11 00 00       	call   3e72 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit(1);
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    2d2b:	51                   	push   %ecx
    2d2c:	51                   	push   %ecx
    2d2d:	68 1a 4f 00 00       	push   $0x4f1a
    2d32:	6a 01                	push   $0x1
    2d34:	e8 a7 12 00 00       	call   3fe0 <printf>
    exit(0);
    2d39:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d40:	e8 2d 11 00 00       	call   3e72 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit(0);
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    2d45:	50                   	push   %eax
    2d46:	50                   	push   %eax
    2d47:	68 4b 43 00 00       	push   $0x434b
    2d4c:	6a 01                	push   $0x1
    2d4e:	e8 8d 12 00 00       	call   3fe0 <printf>
    exit(1);
    2d53:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d5a:	e8 13 11 00 00       	call   3e72 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit(0);
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2d5f:	50                   	push   %eax
    2d60:	50                   	push   %eax
    2d61:	68 04 4f 00 00       	push   $0x4f04
    2d66:	6a 01                	push   $0x1
    2d68:	e8 73 12 00 00       	call   3fe0 <printf>
    exit(0);
    2d6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d74:	e8 f9 10 00 00       	call   3e72 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit(1);
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    2d79:	50                   	push   %eax
    2d7a:	50                   	push   %eax
    2d7b:	68 f6 4e 00 00       	push   $0x4ef6
    2d80:	6a 01                	push   $0x1
    2d82:	e8 59 12 00 00       	call   3fe0 <printf>
    exit(0);
    2d87:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d8e:	e8 df 10 00 00       	call   3e72 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit(1);
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    2d93:	50                   	push   %eax
    2d94:	50                   	push   %eax
    2d95:	68 e3 4e 00 00       	push   $0x4ee3
    2d9a:	6a 01                	push   $0x1
    2d9c:	e8 3f 12 00 00       	call   3fe0 <printf>
    exit(1);
    2da1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2da8:	e8 c5 10 00 00       	call   3e72 <exit>
    2dad:	8d 76 00             	lea    0x0(%esi),%esi

00002db0 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    2db0:	55                   	push   %ebp
    2db1:	89 e5                	mov    %esp,%ebp
    2db3:	53                   	push   %ebx
    2db4:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    2db7:	68 70 4f 00 00       	push   $0x4f70
    2dbc:	6a 01                	push   $0x1
    2dbe:	e8 1d 12 00 00       	call   3fe0 <printf>

  fd = open("dirfile", O_CREATE);
    2dc3:	59                   	pop    %ecx
    2dc4:	5b                   	pop    %ebx
    2dc5:	68 00 02 00 00       	push   $0x200
    2dca:	68 7d 4f 00 00       	push   $0x4f7d
    2dcf:	e8 de 10 00 00       	call   3eb2 <open>
  if(fd < 0){
    2dd4:	83 c4 10             	add    $0x10,%esp
    2dd7:	85 c0                	test   %eax,%eax
    2dd9:	0f 88 51 01 00 00    	js     2f30 <dirfile+0x180>
    printf(1, "create dirfile failed\n");
    exit(1);
  }
  close(fd);
    2ddf:	83 ec 0c             	sub    $0xc,%esp
    2de2:	50                   	push   %eax
    2de3:	e8 b2 10 00 00       	call   3e9a <close>
  if(chdir("dirfile") == 0){
    2de8:	c7 04 24 7d 4f 00 00 	movl   $0x4f7d,(%esp)
    2def:	e8 ee 10 00 00       	call   3ee2 <chdir>
    2df4:	83 c4 10             	add    $0x10,%esp
    2df7:	85 c0                	test   %eax,%eax
    2df9:	0f 84 17 01 00 00    	je     2f16 <dirfile+0x166>
    printf(1, "chdir dirfile succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", 0);
    2dff:	83 ec 08             	sub    $0x8,%esp
    2e02:	6a 00                	push   $0x0
    2e04:	68 b6 4f 00 00       	push   $0x4fb6
    2e09:	e8 a4 10 00 00       	call   3eb2 <open>
  if(fd >= 0){
    2e0e:	83 c4 10             	add    $0x10,%esp
    2e11:	85 c0                	test   %eax,%eax
    2e13:	0f 89 e3 00 00 00    	jns    2efc <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", O_CREATE);
    2e19:	83 ec 08             	sub    $0x8,%esp
    2e1c:	68 00 02 00 00       	push   $0x200
    2e21:	68 b6 4f 00 00       	push   $0x4fb6
    2e26:	e8 87 10 00 00       	call   3eb2 <open>
  if(fd >= 0){
    2e2b:	83 c4 10             	add    $0x10,%esp
    2e2e:	85 c0                	test   %eax,%eax
    2e30:	0f 89 c6 00 00 00    	jns    2efc <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  if(mkdir("dirfile/xx") == 0){
    2e36:	83 ec 0c             	sub    $0xc,%esp
    2e39:	68 b6 4f 00 00       	push   $0x4fb6
    2e3e:	e8 97 10 00 00       	call   3eda <mkdir>
    2e43:	83 c4 10             	add    $0x10,%esp
    2e46:	85 c0                	test   %eax,%eax
    2e48:	0f 84 7e 01 00 00    	je     2fcc <dirfile+0x21c>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile/xx") == 0){
    2e4e:	83 ec 0c             	sub    $0xc,%esp
    2e51:	68 b6 4f 00 00       	push   $0x4fb6
    2e56:	e8 67 10 00 00       	call   3ec2 <unlink>
    2e5b:	83 c4 10             	add    $0x10,%esp
    2e5e:	85 c0                	test   %eax,%eax
    2e60:	0f 84 4c 01 00 00    	je     2fb2 <dirfile+0x202>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit(0);
  }
  if(link("README", "dirfile/xx") == 0){
    2e66:	83 ec 08             	sub    $0x8,%esp
    2e69:	68 b6 4f 00 00       	push   $0x4fb6
    2e6e:	68 1a 50 00 00       	push   $0x501a
    2e73:	e8 5a 10 00 00       	call   3ed2 <link>
    2e78:	83 c4 10             	add    $0x10,%esp
    2e7b:	85 c0                	test   %eax,%eax
    2e7d:	0f 84 15 01 00 00    	je     2f98 <dirfile+0x1e8>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile") != 0){
    2e83:	83 ec 0c             	sub    $0xc,%esp
    2e86:	68 7d 4f 00 00       	push   $0x4f7d
    2e8b:	e8 32 10 00 00       	call   3ec2 <unlink>
    2e90:	83 c4 10             	add    $0x10,%esp
    2e93:	85 c0                	test   %eax,%eax
    2e95:	0f 85 e3 00 00 00    	jne    2f7e <dirfile+0x1ce>
    printf(1, "unlink dirfile failed!\n");
    exit(1);
  }

  fd = open(".", O_RDWR);
    2e9b:	83 ec 08             	sub    $0x8,%esp
    2e9e:	6a 02                	push   $0x2
    2ea0:	68 76 4b 00 00       	push   $0x4b76
    2ea5:	e8 08 10 00 00       	call   3eb2 <open>
  if(fd >= 0){
    2eaa:	83 c4 10             	add    $0x10,%esp
    2ead:	85 c0                	test   %eax,%eax
    2eaf:	0f 89 af 00 00 00    	jns    2f64 <dirfile+0x1b4>
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
    2eb5:	83 ec 08             	sub    $0x8,%esp
    2eb8:	6a 00                	push   $0x0
    2eba:	68 76 4b 00 00       	push   $0x4b76
    2ebf:	e8 ee 0f 00 00       	call   3eb2 <open>
  if(write(fd, "x", 1) > 0){
    2ec4:	83 c4 0c             	add    $0xc,%esp
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
    2ec7:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2ec9:	6a 01                	push   $0x1
    2ecb:	68 59 4c 00 00       	push   $0x4c59
    2ed0:	50                   	push   %eax
    2ed1:	e8 bc 0f 00 00       	call   3e92 <write>
    2ed6:	83 c4 10             	add    $0x10,%esp
    2ed9:	85 c0                	test   %eax,%eax
    2edb:	7f 6d                	jg     2f4a <dirfile+0x19a>
    printf(1, "write . succeeded!\n");
    exit(0);
  }
  close(fd);
    2edd:	83 ec 0c             	sub    $0xc,%esp
    2ee0:	53                   	push   %ebx
    2ee1:	e8 b4 0f 00 00       	call   3e9a <close>

  printf(1, "dir vs file OK\n");
    2ee6:	58                   	pop    %eax
    2ee7:	5a                   	pop    %edx
    2ee8:	68 4d 50 00 00       	push   $0x504d
    2eed:	6a 01                	push   $0x1
    2eef:	e8 ec 10 00 00       	call   3fe0 <printf>
}
    2ef4:	83 c4 10             	add    $0x10,%esp
    2ef7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2efa:	c9                   	leave  
    2efb:	c3                   	ret    
    printf(1, "chdir dirfile succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    2efc:	50                   	push   %eax
    2efd:	50                   	push   %eax
    2efe:	68 c1 4f 00 00       	push   $0x4fc1
    2f03:	6a 01                	push   $0x1
    2f05:	e8 d6 10 00 00       	call   3fe0 <printf>
    exit(0);
    2f0a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f11:	e8 5c 0f 00 00       	call   3e72 <exit>
    printf(1, "create dirfile failed\n");
    exit(1);
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    2f16:	50                   	push   %eax
    2f17:	50                   	push   %eax
    2f18:	68 9c 4f 00 00       	push   $0x4f9c
    2f1d:	6a 01                	push   $0x1
    2f1f:	e8 bc 10 00 00       	call   3fe0 <printf>
    exit(0);
    2f24:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f2b:	e8 42 0f 00 00       	call   3e72 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    2f30:	52                   	push   %edx
    2f31:	52                   	push   %edx
    2f32:	68 85 4f 00 00       	push   $0x4f85
    2f37:	6a 01                	push   $0x1
    2f39:	e8 a2 10 00 00       	call   3fe0 <printf>
    exit(1);
    2f3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f45:	e8 28 0f 00 00       	call   3e72 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    2f4a:	51                   	push   %ecx
    2f4b:	51                   	push   %ecx
    2f4c:	68 39 50 00 00       	push   $0x5039
    2f51:	6a 01                	push   $0x1
    2f53:	e8 88 10 00 00       	call   3fe0 <printf>
    exit(0);
    2f58:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f5f:	e8 0e 0f 00 00       	call   3e72 <exit>
    exit(1);
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    2f64:	53                   	push   %ebx
    2f65:	53                   	push   %ebx
    2f66:	68 30 58 00 00       	push   $0x5830
    2f6b:	6a 01                	push   $0x1
    2f6d:	e8 6e 10 00 00       	call   3fe0 <printf>
    exit(0);
    2f72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f79:	e8 f4 0e 00 00       	call   3e72 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    2f7e:	50                   	push   %eax
    2f7f:	50                   	push   %eax
    2f80:	68 21 50 00 00       	push   $0x5021
    2f85:	6a 01                	push   $0x1
    2f87:	e8 54 10 00 00       	call   3fe0 <printf>
    exit(1);
    2f8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f93:	e8 da 0e 00 00       	call   3e72 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit(0);
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    2f98:	50                   	push   %eax
    2f99:	50                   	push   %eax
    2f9a:	68 10 58 00 00       	push   $0x5810
    2f9f:	6a 01                	push   $0x1
    2fa1:	e8 3a 10 00 00       	call   3fe0 <printf>
    exit(0);
    2fa6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fad:	e8 c0 0e 00 00       	call   3e72 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    2fb2:	50                   	push   %eax
    2fb3:	50                   	push   %eax
    2fb4:	68 fc 4f 00 00       	push   $0x4ffc
    2fb9:	6a 01                	push   $0x1
    2fbb:	e8 20 10 00 00       	call   3fe0 <printf>
    exit(0);
    2fc0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fc7:	e8 a6 0e 00 00       	call   3e72 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2fcc:	50                   	push   %eax
    2fcd:	50                   	push   %eax
    2fce:	68 df 4f 00 00       	push   $0x4fdf
    2fd3:	6a 01                	push   $0x1
    2fd5:	e8 06 10 00 00       	call   3fe0 <printf>
    exit(0);
    2fda:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fe1:	e8 8c 0e 00 00       	call   3e72 <exit>
    2fe6:	8d 76 00             	lea    0x0(%esi),%esi
    2fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002ff0 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2ff0:	55                   	push   %ebp
    2ff1:	89 e5                	mov    %esp,%ebp
    2ff3:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
    2ff4:	bb 33 00 00 00       	mov    $0x33,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2ff9:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2ffc:	68 5d 50 00 00       	push   $0x505d
    3001:	6a 01                	push   $0x1
    3003:	e8 d8 0f 00 00       	call   3fe0 <printf>
    3008:	83 c4 10             	add    $0x10,%esp
    300b:	90                   	nop
    300c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    3010:	83 ec 0c             	sub    $0xc,%esp
    3013:	68 6e 50 00 00       	push   $0x506e
    3018:	e8 bd 0e 00 00       	call   3eda <mkdir>
    301d:	83 c4 10             	add    $0x10,%esp
    3020:	85 c0                	test   %eax,%eax
    3022:	0f 85 bb 00 00 00    	jne    30e3 <iref+0xf3>
      printf(1, "mkdir irefd failed\n");
      exit(1);
    }
    if(chdir("irefd") != 0){
    3028:	83 ec 0c             	sub    $0xc,%esp
    302b:	68 6e 50 00 00       	push   $0x506e
    3030:	e8 ad 0e 00 00       	call   3ee2 <chdir>
    3035:	83 c4 10             	add    $0x10,%esp
    3038:	85 c0                	test   %eax,%eax
    303a:	0f 85 be 00 00 00    	jne    30fe <iref+0x10e>
      printf(1, "chdir irefd failed\n");
      exit(1);
    }

    mkdir("");
    3040:	83 ec 0c             	sub    $0xc,%esp
    3043:	68 23 47 00 00       	push   $0x4723
    3048:	e8 8d 0e 00 00       	call   3eda <mkdir>
    link("README", "");
    304d:	59                   	pop    %ecx
    304e:	58                   	pop    %eax
    304f:	68 23 47 00 00       	push   $0x4723
    3054:	68 1a 50 00 00       	push   $0x501a
    3059:	e8 74 0e 00 00       	call   3ed2 <link>
    fd = open("", O_CREATE);
    305e:	58                   	pop    %eax
    305f:	5a                   	pop    %edx
    3060:	68 00 02 00 00       	push   $0x200
    3065:	68 23 47 00 00       	push   $0x4723
    306a:	e8 43 0e 00 00       	call   3eb2 <open>
    if(fd >= 0)
    306f:	83 c4 10             	add    $0x10,%esp
    3072:	85 c0                	test   %eax,%eax
    3074:	78 0c                	js     3082 <iref+0x92>
      close(fd);
    3076:	83 ec 0c             	sub    $0xc,%esp
    3079:	50                   	push   %eax
    307a:	e8 1b 0e 00 00       	call   3e9a <close>
    307f:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    3082:	83 ec 08             	sub    $0x8,%esp
    3085:	68 00 02 00 00       	push   $0x200
    308a:	68 58 4c 00 00       	push   $0x4c58
    308f:	e8 1e 0e 00 00       	call   3eb2 <open>
    if(fd >= 0)
    3094:	83 c4 10             	add    $0x10,%esp
    3097:	85 c0                	test   %eax,%eax
    3099:	78 0c                	js     30a7 <iref+0xb7>
      close(fd);
    309b:	83 ec 0c             	sub    $0xc,%esp
    309e:	50                   	push   %eax
    309f:	e8 f6 0d 00 00       	call   3e9a <close>
    30a4:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    30a7:	83 ec 0c             	sub    $0xc,%esp
    30aa:	68 58 4c 00 00       	push   $0x4c58
    30af:	e8 0e 0e 00 00       	call   3ec2 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    30b4:	83 c4 10             	add    $0x10,%esp
    30b7:	83 eb 01             	sub    $0x1,%ebx
    30ba:	0f 85 50 ff ff ff    	jne    3010 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    30c0:	83 ec 0c             	sub    $0xc,%esp
    30c3:	68 49 43 00 00       	push   $0x4349
    30c8:	e8 15 0e 00 00       	call   3ee2 <chdir>
  printf(1, "empty file name OK\n");
    30cd:	58                   	pop    %eax
    30ce:	5a                   	pop    %edx
    30cf:	68 9c 50 00 00       	push   $0x509c
    30d4:	6a 01                	push   $0x1
    30d6:	e8 05 0f 00 00       	call   3fe0 <printf>
}
    30db:	83 c4 10             	add    $0x10,%esp
    30de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30e1:	c9                   	leave  
    30e2:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    30e3:	83 ec 08             	sub    $0x8,%esp
    30e6:	68 74 50 00 00       	push   $0x5074
    30eb:	6a 01                	push   $0x1
    30ed:	e8 ee 0e 00 00       	call   3fe0 <printf>
      exit(1);
    30f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30f9:	e8 74 0d 00 00       	call   3e72 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    30fe:	83 ec 08             	sub    $0x8,%esp
    3101:	68 88 50 00 00       	push   $0x5088
    3106:	6a 01                	push   $0x1
    3108:	e8 d3 0e 00 00       	call   3fe0 <printf>
      exit(1);
    310d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3114:	e8 59 0d 00 00       	call   3e72 <exit>
    3119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003120 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    3120:	55                   	push   %ebp
    3121:	89 e5                	mov    %esp,%ebp
    3123:	56                   	push   %esi
    3124:	53                   	push   %ebx
  int n, pid, status;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    3125:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    3127:	83 ec 18             	sub    $0x18,%esp
  int n, pid, status;

  printf(1, "fork test\n");
    312a:	68 b0 50 00 00       	push   $0x50b0
    312f:	6a 01                	push   $0x1
    3131:	e8 aa 0e 00 00       	call   3fe0 <printf>
    3136:	83 c4 10             	add    $0x10,%esp
    3139:	eb 12                	jmp    314d <forktest+0x2d>
    313b:	90                   	nop
    313c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    3140:	74 79                	je     31bb <forktest+0x9b>
{
  int n, pid, status;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    3142:	83 c3 01             	add    $0x1,%ebx
    3145:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    314b:	74 53                	je     31a0 <forktest+0x80>
    pid = fork();
    314d:	e8 18 0d 00 00       	call   3e6a <fork>
    if(pid < 0)
    3152:	85 c0                	test   %eax,%eax
    3154:	79 ea                	jns    3140 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit(0);
  }

  for(; n > 0; n--){
    3156:	85 db                	test   %ebx,%ebx
    3158:	8d 75 f4             	lea    -0xc(%ebp),%esi
    315b:	74 18                	je     3175 <forktest+0x55>
    315d:	8d 76 00             	lea    0x0(%esi),%esi
    if(wait(&status) < 0){
    3160:	83 ec 0c             	sub    $0xc,%esp
    3163:	56                   	push   %esi
    3164:	e8 11 0d 00 00       	call   3e7a <wait>
    3169:	83 c4 10             	add    $0x10,%esp
    316c:	85 c0                	test   %eax,%eax
    316e:	78 55                	js     31c5 <forktest+0xa5>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit(0);
  }

  for(; n > 0; n--){
    3170:	83 eb 01             	sub    $0x1,%ebx
    3173:	75 eb                	jne    3160 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit(1);
    }
  }

  if(wait(&status) != -1){
    3175:	83 ec 0c             	sub    $0xc,%esp
    3178:	56                   	push   %esi
    3179:	e8 fc 0c 00 00       	call   3e7a <wait>
    317e:	83 c4 10             	add    $0x10,%esp
    3181:	83 f8 ff             	cmp    $0xffffffff,%eax
    3184:	75 5a                	jne    31e0 <forktest+0xc0>
    printf(1, "wait got too many\n");
    exit(1);
  }

  printf(1, "fork test OK\n");
    3186:	83 ec 08             	sub    $0x8,%esp
    3189:	68 e2 50 00 00       	push   $0x50e2
    318e:	6a 01                	push   $0x1
    3190:	e8 4b 0e 00 00       	call   3fe0 <printf>
}
    3195:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3198:	5b                   	pop    %ebx
    3199:	5e                   	pop    %esi
    319a:	5d                   	pop    %ebp
    319b:	c3                   	ret    
    319c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit(0);
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    31a0:	83 ec 08             	sub    $0x8,%esp
    31a3:	68 50 58 00 00       	push   $0x5850
    31a8:	6a 01                	push   $0x1
    31aa:	e8 31 0e 00 00       	call   3fe0 <printf>
    exit(0);
    31af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31b6:	e8 b7 0c 00 00       	call   3e72 <exit>
  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit(0);
    31bb:	83 ec 0c             	sub    $0xc,%esp
    31be:	6a 00                	push   $0x0
    31c0:	e8 ad 0c 00 00       	call   3e72 <exit>
    exit(0);
  }

  for(; n > 0; n--){
    if(wait(&status) < 0){
      printf(1, "wait stopped early\n");
    31c5:	83 ec 08             	sub    $0x8,%esp
    31c8:	68 bb 50 00 00       	push   $0x50bb
    31cd:	6a 01                	push   $0x1
    31cf:	e8 0c 0e 00 00       	call   3fe0 <printf>
      exit(1);
    31d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31db:	e8 92 0c 00 00       	call   3e72 <exit>
    }
  }

  if(wait(&status) != -1){
    printf(1, "wait got too many\n");
    31e0:	83 ec 08             	sub    $0x8,%esp
    31e3:	68 cf 50 00 00       	push   $0x50cf
    31e8:	6a 01                	push   $0x1
    31ea:	e8 f1 0d 00 00       	call   3fe0 <printf>
    exit(1);
    31ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31f6:	e8 77 0c 00 00       	call   3e72 <exit>
    31fb:	90                   	nop
    31fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003200 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    3200:	55                   	push   %ebp
    3201:	89 e5                	mov    %esp,%ebp
    3203:	57                   	push   %edi
    3204:	56                   	push   %esi
    3205:	53                   	push   %ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    3206:	31 f6                	xor    %esi,%esi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    3208:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid, status;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    320b:	68 f0 50 00 00       	push   $0x50f0
    3210:	ff 35 a4 63 00 00    	pushl  0x63a4
    3216:	e8 c5 0d 00 00       	call   3fe0 <printf>
  oldbrk = sbrk(0);
    321b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3222:	e8 db 0c 00 00       	call   3f02 <sbrk>

  // can one sbrk() less than a page?
  a = sbrk(0);
    3227:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int fds[2], pid, pids[10], ppid, status;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);
    322e:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    3231:	e8 cc 0c 00 00       	call   3f02 <sbrk>
    3236:	83 c4 10             	add    $0x10,%esp
    3239:	89 c3                	mov    %eax,%ebx
    323b:	90                   	nop
    323c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    3240:	83 ec 0c             	sub    $0xc,%esp
    3243:	6a 01                	push   $0x1
    3245:	e8 b8 0c 00 00       	call   3f02 <sbrk>
    if(b != a){
    324a:	83 c4 10             	add    $0x10,%esp
    324d:	39 d8                	cmp    %ebx,%eax
    324f:	0f 85 9d 02 00 00    	jne    34f2 <sbrktest+0x2f2>
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    3255:	83 c6 01             	add    $0x1,%esi
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit(1);
    }
    *b = 1;
    3258:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    325b:	83 c3 01             	add    $0x1,%ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    325e:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    3264:	75 da                	jne    3240 <sbrktest+0x40>
      exit(1);
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    3266:	e8 ff 0b 00 00       	call   3e6a <fork>
  if(pid < 0){
    326b:	85 c0                	test   %eax,%eax
      exit(1);
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    326d:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    326f:	0f 88 ff 03 00 00    	js     3674 <sbrktest+0x474>
    printf(stdout, "sbrk test fork failed\n");
    exit(1);
  }
  c = sbrk(1);
    3275:	83 ec 0c             	sub    $0xc,%esp
  c = sbrk(1);
  if(c != a + 1){
    3278:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit(1);
  }
  c = sbrk(1);
    327b:	6a 01                	push   $0x1
    327d:	e8 80 0c 00 00       	call   3f02 <sbrk>
  c = sbrk(1);
    3282:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3289:	e8 74 0c 00 00       	call   3f02 <sbrk>
  if(c != a + 1){
    328e:	83 c4 10             	add    $0x10,%esp
    3291:	39 d8                	cmp    %ebx,%eax
    3293:	0f 85 bc 03 00 00    	jne    3655 <sbrktest+0x455>
    printf(stdout, "sbrk test failed post-fork\n");
    exit(1);
  }
  if(pid == 0)
    3299:	85 f6                	test   %esi,%esi
    329b:	0f 84 aa 03 00 00    	je     364b <sbrktest+0x44b>
    exit(0);
  wait(&status);
    32a1:	8d 5d b4             	lea    -0x4c(%ebp),%ebx
    32a4:	83 ec 0c             	sub    $0xc,%esp
    32a7:	53                   	push   %ebx
    32a8:	e8 cd 0b 00 00       	call   3e7a <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    32ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    32b4:	e8 49 0c 00 00       	call   3f02 <sbrk>
    32b9:	89 c6                	mov    %eax,%esi
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
    32bb:	b8 00 00 40 06       	mov    $0x6400000,%eax
    32c0:	29 f0                	sub    %esi,%eax
    32c2:	89 04 24             	mov    %eax,(%esp)
    32c5:	e8 38 0c 00 00       	call   3f02 <sbrk>
  if (p != a) {
    32ca:	83 c4 10             	add    $0x10,%esp
    32cd:	39 c6                	cmp    %eax,%esi
    32cf:	0f 85 57 03 00 00    	jne    362c <sbrktest+0x42c>
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    32d5:	83 ec 0c             	sub    $0xc,%esp
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit(1);
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    32d8:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    32df:	6a 00                	push   $0x0
    32e1:	e8 1c 0c 00 00       	call   3f02 <sbrk>
  c = sbrk(-4096);
    32e6:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    32ed:	89 c6                	mov    %eax,%esi
  c = sbrk(-4096);
    32ef:	e8 0e 0c 00 00       	call   3f02 <sbrk>
  if(c == (char*)0xffffffff){
    32f4:	83 c4 10             	add    $0x10,%esp
    32f7:	83 f8 ff             	cmp    $0xffffffff,%eax
    32fa:	0f 84 0d 03 00 00    	je     360d <sbrktest+0x40d>
    printf(stdout, "sbrk could not deallocate\n");
    exit(1);
  }
  c = sbrk(0);
    3300:	83 ec 0c             	sub    $0xc,%esp
    3303:	6a 00                	push   $0x0
    3305:	e8 f8 0b 00 00       	call   3f02 <sbrk>
  if(c != a - 4096){
    330a:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    3310:	83 c4 10             	add    $0x10,%esp
    3313:	39 d0                	cmp    %edx,%eax
    3315:	0f 85 d4 02 00 00    	jne    35ef <sbrktest+0x3ef>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit(1);
  }

  // can one re-allocate that page?
  a = sbrk(0);
    331b:	83 ec 0c             	sub    $0xc,%esp
    331e:	6a 00                	push   $0x0
    3320:	e8 dd 0b 00 00       	call   3f02 <sbrk>
    3325:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    3327:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    332e:	e8 cf 0b 00 00       	call   3f02 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    3333:	83 c4 10             	add    $0x10,%esp
    3336:	39 c6                	cmp    %eax,%esi
    exit(1);
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
    3338:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    333a:	0f 85 91 02 00 00    	jne    35d1 <sbrktest+0x3d1>
    3340:	83 ec 0c             	sub    $0xc,%esp
    3343:	6a 00                	push   $0x0
    3345:	e8 b8 0b 00 00       	call   3f02 <sbrk>
    334a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    3350:	83 c4 10             	add    $0x10,%esp
    3353:	39 d0                	cmp    %edx,%eax
    3355:	0f 85 76 02 00 00    	jne    35d1 <sbrktest+0x3d1>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit(1);
  }
  if(*lastaddr == 99){
    335b:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    3362:	0f 84 4a 02 00 00    	je     35b2 <sbrktest+0x3b2>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(1);
  }

  a = sbrk(0);
    3368:	83 ec 0c             	sub    $0xc,%esp
    336b:	6a 00                	push   $0x0
    336d:	e8 90 0b 00 00       	call   3f02 <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    3372:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(1);
  }

  a = sbrk(0);
    3379:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    337b:	e8 82 0b 00 00       	call   3f02 <sbrk>
    3380:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    3383:	29 c1                	sub    %eax,%ecx
    3385:	89 0c 24             	mov    %ecx,(%esp)
    3388:	e8 75 0b 00 00       	call   3f02 <sbrk>
  if(c != a){
    338d:	83 c4 10             	add    $0x10,%esp
    3390:	39 c6                	cmp    %eax,%esi
    3392:	0f 85 fc 01 00 00    	jne    3594 <sbrktest+0x394>
    3398:	be 00 00 00 80       	mov    $0x80000000,%esi
    339d:	8d 76 00             	lea    0x0(%esi),%esi
    exit(1);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    33a0:	e8 4d 0b 00 00       	call   3ef2 <getpid>
    33a5:	89 c7                	mov    %eax,%edi
    pid = fork();
    33a7:	e8 be 0a 00 00       	call   3e6a <fork>
    if(pid < 0){
    33ac:	85 c0                	test   %eax,%eax
    33ae:	0f 88 c1 01 00 00    	js     3575 <sbrktest+0x375>
      printf(stdout, "fork failed\n");
      exit(1);
    }
    if(pid == 0){
    33b4:	0f 84 92 01 00 00    	je     354c <sbrktest+0x34c>
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit(1);
    }
    wait(&status);
    33ba:	83 ec 0c             	sub    $0xc,%esp
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(1);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    33bd:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit(1);
    }
    wait(&status);
    33c3:	53                   	push   %ebx
    33c4:	e8 b1 0a 00 00       	call   3e7a <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(1);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    33c9:	83 c4 10             	add    $0x10,%esp
    33cc:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    33d2:	75 cc                	jne    33a0 <sbrktest+0x1a0>
    wait(&status);
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    33d4:	8d 45 b8             	lea    -0x48(%ebp),%eax
    33d7:	83 ec 0c             	sub    $0xc,%esp
    33da:	50                   	push   %eax
    33db:	e8 a2 0a 00 00       	call   3e82 <pipe>
    33e0:	83 c4 10             	add    $0x10,%esp
    33e3:	85 c0                	test   %eax,%eax
    33e5:	0f 85 46 01 00 00    	jne    3531 <sbrktest+0x331>
    33eb:	8d 75 c0             	lea    -0x40(%ebp),%esi
    33ee:	89 f7                	mov    %esi,%edi
    printf(1, "pipe() failed\n");
    exit(1);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    33f0:	e8 75 0a 00 00       	call   3e6a <fork>
    33f5:	85 c0                	test   %eax,%eax
    33f7:	89 07                	mov    %eax,(%edi)
    33f9:	0f 84 aa 00 00 00    	je     34a9 <sbrktest+0x2a9>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    33ff:	83 f8 ff             	cmp    $0xffffffff,%eax
    3402:	74 14                	je     3418 <sbrktest+0x218>
      read(fds[0], &scratch, 1);
    3404:	8d 45 b3             	lea    -0x4d(%ebp),%eax
    3407:	83 ec 04             	sub    $0x4,%esp
    340a:	6a 01                	push   $0x1
    340c:	50                   	push   %eax
    340d:	ff 75 b8             	pushl  -0x48(%ebp)
    3410:	e8 75 0a 00 00       	call   3e8a <read>
    3415:	83 c4 10             	add    $0x10,%esp
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit(1);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3418:	8d 45 e8             	lea    -0x18(%ebp),%eax
    341b:	83 c7 04             	add    $0x4,%edi
    341e:	39 f8                	cmp    %edi,%eax
    3420:	75 ce                	jne    33f0 <sbrktest+0x1f0>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3422:	83 ec 0c             	sub    $0xc,%esp
    3425:	68 00 10 00 00       	push   $0x1000
    342a:	e8 d3 0a 00 00       	call   3f02 <sbrk>
    342f:	83 c4 10             	add    $0x10,%esp
    3432:	89 c7                	mov    %eax,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    3434:	8b 06                	mov    (%esi),%eax
    3436:	83 f8 ff             	cmp    $0xffffffff,%eax
    3439:	74 14                	je     344f <sbrktest+0x24f>
      continue;
    kill(pids[i]);
    343b:	83 ec 0c             	sub    $0xc,%esp
    343e:	50                   	push   %eax
    343f:	e8 5e 0a 00 00       	call   3ea2 <kill>
    wait(&status);
    3444:	89 1c 24             	mov    %ebx,(%esp)
    3447:	e8 2e 0a 00 00       	call   3e7a <wait>
    344c:	83 c4 10             	add    $0x10,%esp
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    344f:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3452:	83 c6 04             	add    $0x4,%esi
    3455:	39 c6                	cmp    %eax,%esi
    3457:	75 db                	jne    3434 <sbrktest+0x234>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait(&status);
  }
  if(c == (char*)0xffffffff){
    3459:	83 ff ff             	cmp    $0xffffffff,%edi
    345c:	0f 84 b0 00 00 00    	je     3512 <sbrktest+0x312>
    printf(stdout, "failed sbrk leaked memory\n");
    exit(1);
  }

  if(sbrk(0) > oldbrk)
    3462:	83 ec 0c             	sub    $0xc,%esp
    3465:	6a 00                	push   $0x0
    3467:	e8 96 0a 00 00       	call   3f02 <sbrk>
    346c:	83 c4 10             	add    $0x10,%esp
    346f:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    3472:	73 1a                	jae    348e <sbrktest+0x28e>
    sbrk(-(sbrk(0) - oldbrk));
    3474:	83 ec 0c             	sub    $0xc,%esp
    3477:	6a 00                	push   $0x0
    3479:	e8 84 0a 00 00       	call   3f02 <sbrk>
    347e:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    3481:	29 c1                	sub    %eax,%ecx
    3483:	89 0c 24             	mov    %ecx,(%esp)
    3486:	e8 77 0a 00 00       	call   3f02 <sbrk>
    348b:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    348e:	83 ec 08             	sub    $0x8,%esp
    3491:	68 98 51 00 00       	push   $0x5198
    3496:	ff 35 a4 63 00 00    	pushl  0x63a4
    349c:	e8 3f 0b 00 00       	call   3fe0 <printf>
}
    34a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    34a4:	5b                   	pop    %ebx
    34a5:	5e                   	pop    %esi
    34a6:	5f                   	pop    %edi
    34a7:	5d                   	pop    %ebp
    34a8:	c3                   	ret    
    exit(1);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    34a9:	83 ec 0c             	sub    $0xc,%esp
    34ac:	6a 00                	push   $0x0
    34ae:	e8 4f 0a 00 00       	call   3f02 <sbrk>
    34b3:	ba 00 00 40 06       	mov    $0x6400000,%edx
    34b8:	29 c2                	sub    %eax,%edx
    34ba:	89 14 24             	mov    %edx,(%esp)
    34bd:	e8 40 0a 00 00       	call   3f02 <sbrk>
      write(fds[1], "x", 1);
    34c2:	83 c4 0c             	add    $0xc,%esp
    34c5:	6a 01                	push   $0x1
    34c7:	68 59 4c 00 00       	push   $0x4c59
    34cc:	ff 75 bc             	pushl  -0x44(%ebp)
    34cf:	e8 be 09 00 00       	call   3e92 <write>
    34d4:	83 c4 10             	add    $0x10,%esp
    34d7:	89 f6                	mov    %esi,%esi
    34d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      // sit around until killed
      for(;;) sleep(1000);
    34e0:	83 ec 0c             	sub    $0xc,%esp
    34e3:	68 e8 03 00 00       	push   $0x3e8
    34e8:	e8 1d 0a 00 00       	call   3f0a <sleep>
    34ed:	83 c4 10             	add    $0x10,%esp
    34f0:	eb ee                	jmp    34e0 <sbrktest+0x2e0>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    34f2:	83 ec 0c             	sub    $0xc,%esp
    34f5:	50                   	push   %eax
    34f6:	53                   	push   %ebx
    34f7:	56                   	push   %esi
    34f8:	68 fb 50 00 00       	push   $0x50fb
    34fd:	ff 35 a4 63 00 00    	pushl  0x63a4
    3503:	e8 d8 0a 00 00       	call   3fe0 <printf>
      exit(1);
    3508:	83 c4 14             	add    $0x14,%esp
    350b:	6a 01                	push   $0x1
    350d:	e8 60 09 00 00       	call   3e72 <exit>
      continue;
    kill(pids[i]);
    wait(&status);
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    3512:	83 ec 08             	sub    $0x8,%esp
    3515:	68 7d 51 00 00       	push   $0x517d
    351a:	ff 35 a4 63 00 00    	pushl  0x63a4
    3520:	e8 bb 0a 00 00       	call   3fe0 <printf>
    exit(1);
    3525:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    352c:	e8 41 09 00 00       	call   3e72 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    3531:	83 ec 08             	sub    $0x8,%esp
    3534:	68 39 46 00 00       	push   $0x4639
    3539:	6a 01                	push   $0x1
    353b:	e8 a0 0a 00 00       	call   3fe0 <printf>
    exit(1);
    3540:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3547:	e8 26 09 00 00       	call   3e72 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit(1);
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    354c:	0f be 06             	movsbl (%esi),%eax
    354f:	50                   	push   %eax
    3550:	56                   	push   %esi
    3551:	68 64 51 00 00       	push   $0x5164
    3556:	ff 35 a4 63 00 00    	pushl  0x63a4
    355c:	e8 7f 0a 00 00       	call   3fe0 <printf>
      kill(ppid);
    3561:	89 3c 24             	mov    %edi,(%esp)
    3564:	e8 39 09 00 00       	call   3ea2 <kill>
      exit(1);
    3569:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3570:	e8 fd 08 00 00       	call   3e72 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    3575:	83 ec 08             	sub    $0x8,%esp
    3578:	68 41 52 00 00       	push   $0x5241
    357d:	ff 35 a4 63 00 00    	pushl  0x63a4
    3583:	e8 58 0a 00 00       	call   3fe0 <printf>
      exit(1);
    3588:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    358f:	e8 de 08 00 00       	call   3e72 <exit>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3594:	50                   	push   %eax
    3595:	56                   	push   %esi
    3596:	68 44 59 00 00       	push   $0x5944
    359b:	ff 35 a4 63 00 00    	pushl  0x63a4
    35a1:	e8 3a 0a 00 00       	call   3fe0 <printf>
    exit(1);
    35a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    35ad:	e8 c0 08 00 00       	call   3e72 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit(1);
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    35b2:	83 ec 08             	sub    $0x8,%esp
    35b5:	68 14 59 00 00       	push   $0x5914
    35ba:	ff 35 a4 63 00 00    	pushl  0x63a4
    35c0:	e8 1b 0a 00 00       	call   3fe0 <printf>
    exit(1);
    35c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    35cc:	e8 a1 08 00 00       	call   3e72 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    35d1:	57                   	push   %edi
    35d2:	56                   	push   %esi
    35d3:	68 ec 58 00 00       	push   $0x58ec
    35d8:	ff 35 a4 63 00 00    	pushl  0x63a4
    35de:	e8 fd 09 00 00       	call   3fe0 <printf>
    exit(1);
    35e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    35ea:	e8 83 08 00 00       	call   3e72 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit(1);
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    35ef:	50                   	push   %eax
    35f0:	56                   	push   %esi
    35f1:	68 b4 58 00 00       	push   $0x58b4
    35f6:	ff 35 a4 63 00 00    	pushl  0x63a4
    35fc:	e8 df 09 00 00       	call   3fe0 <printf>
    exit(1);
    3601:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3608:	e8 65 08 00 00       	call   3e72 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    360d:	83 ec 08             	sub    $0x8,%esp
    3610:	68 49 51 00 00       	push   $0x5149
    3615:	ff 35 a4 63 00 00    	pushl  0x63a4
    361b:	e8 c0 09 00 00       	call   3fe0 <printf>
    exit(1);
    3620:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3627:	e8 46 08 00 00       	call   3e72 <exit>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    362c:	83 ec 08             	sub    $0x8,%esp
    362f:	68 74 58 00 00       	push   $0x5874
    3634:	ff 35 a4 63 00 00    	pushl  0x63a4
    363a:	e8 a1 09 00 00       	call   3fe0 <printf>
    exit(1);
    363f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3646:	e8 27 08 00 00       	call   3e72 <exit>
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    exit(1);
  }
  if(pid == 0)
    exit(0);
    364b:	83 ec 0c             	sub    $0xc,%esp
    364e:	6a 00                	push   $0x0
    3650:	e8 1d 08 00 00       	call   3e72 <exit>
    exit(1);
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    3655:	83 ec 08             	sub    $0x8,%esp
    3658:	68 2d 51 00 00       	push   $0x512d
    365d:	ff 35 a4 63 00 00    	pushl  0x63a4
    3663:	e8 78 09 00 00       	call   3fe0 <printf>
    exit(1);
    3668:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    366f:	e8 fe 07 00 00       	call   3e72 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    3674:	83 ec 08             	sub    $0x8,%esp
    3677:	68 16 51 00 00       	push   $0x5116
    367c:	ff 35 a4 63 00 00    	pushl  0x63a4
    3682:	e8 59 09 00 00       	call   3fe0 <printf>
    exit(1);
    3687:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    368e:	e8 df 07 00 00       	call   3e72 <exit>
    3693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000036a0 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    36a0:	55                   	push   %ebp
    36a1:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    36a3:	5d                   	pop    %ebp
    36a4:	c3                   	ret    
    36a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    36a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000036b0 <validatetest>:

void
validatetest(void)
{
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	57                   	push   %edi
    36b4:	56                   	push   %esi
    36b5:	53                   	push   %ebx
      exit(0);
    }
    sleep(0);
    sleep(0);
    kill(pid);
    wait(&status);
    36b6:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    36b9:	31 db                	xor    %ebx,%ebx
      "ebx");
}

void
validatetest(void)
{
    36bb:	83 ec 24             	sub    $0x24,%esp
  int hi, pid, status;
  uint p;

  printf(stdout, "validate test\n");
    36be:	68 a6 51 00 00       	push   $0x51a6
    36c3:	ff 35 a4 63 00 00    	pushl  0x63a4
    36c9:	e8 12 09 00 00       	call   3fe0 <printf>
    36ce:	83 c4 10             	add    $0x10,%esp
    36d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
    36d8:	e8 8d 07 00 00       	call   3e6a <fork>
    36dd:	85 c0                	test   %eax,%eax
    36df:	89 c6                	mov    %eax,%esi
    36e1:	74 67                	je     374a <validatetest+0x9a>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit(0);
    }
    sleep(0);
    36e3:	83 ec 0c             	sub    $0xc,%esp
    36e6:	6a 00                	push   $0x0
    36e8:	e8 1d 08 00 00       	call   3f0a <sleep>
    sleep(0);
    36ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    36f4:	e8 11 08 00 00       	call   3f0a <sleep>
    kill(pid);
    36f9:	89 34 24             	mov    %esi,(%esp)
    36fc:	e8 a1 07 00 00       	call   3ea2 <kill>
    wait(&status);
    3701:	89 3c 24             	mov    %edi,(%esp)
    3704:	e8 71 07 00 00       	call   3e7a <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3709:	58                   	pop    %eax
    370a:	5a                   	pop    %edx
    370b:	53                   	push   %ebx
    370c:	68 b5 51 00 00       	push   $0x51b5
    3711:	e8 bc 07 00 00       	call   3ed2 <link>
    3716:	83 c4 10             	add    $0x10,%esp
    3719:	83 f8 ff             	cmp    $0xffffffff,%eax
    371c:	75 36                	jne    3754 <validatetest+0xa4>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    371e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    3724:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    372a:	75 ac                	jne    36d8 <validatetest+0x28>
      printf(stdout, "link should not succeed\n");
      exit(1);
    }
  }

  printf(stdout, "validate ok\n");
    372c:	83 ec 08             	sub    $0x8,%esp
    372f:	68 d9 51 00 00       	push   $0x51d9
    3734:	ff 35 a4 63 00 00    	pushl  0x63a4
    373a:	e8 a1 08 00 00       	call   3fe0 <printf>
}
    373f:	83 c4 10             	add    $0x10,%esp
    3742:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3745:	5b                   	pop    %ebx
    3746:	5e                   	pop    %esi
    3747:	5f                   	pop    %edi
    3748:	5d                   	pop    %ebp
    3749:	c3                   	ret    

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit(0);
    374a:	83 ec 0c             	sub    $0xc,%esp
    374d:	6a 00                	push   $0x0
    374f:	e8 1e 07 00 00       	call   3e72 <exit>
    kill(pid);
    wait(&status);

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    3754:	83 ec 08             	sub    $0x8,%esp
    3757:	68 c0 51 00 00       	push   $0x51c0
    375c:	ff 35 a4 63 00 00    	pushl  0x63a4
    3762:	e8 79 08 00 00       	call   3fe0 <printf>
      exit(1);
    3767:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    376e:	e8 ff 06 00 00       	call   3e72 <exit>
    3773:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003780 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3780:	55                   	push   %ebp
    3781:	89 e5                	mov    %esp,%ebp
    3783:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    3786:	68 e6 51 00 00       	push   $0x51e6
    378b:	ff 35 a4 63 00 00    	pushl  0x63a4
    3791:	e8 4a 08 00 00       	call   3fe0 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    3796:	83 c4 10             	add    $0x10,%esp
    3799:	80 3d 60 64 00 00 00 	cmpb   $0x0,0x6460
    37a0:	75 35                	jne    37d7 <bsstest+0x57>
    37a2:	b8 61 64 00 00       	mov    $0x6461,%eax
    37a7:	89 f6                	mov    %esi,%esi
    37a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    37b0:	80 38 00             	cmpb   $0x0,(%eax)
    37b3:	75 22                	jne    37d7 <bsstest+0x57>
    37b5:	83 c0 01             	add    $0x1,%eax
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    37b8:	3d 70 8b 00 00       	cmp    $0x8b70,%eax
    37bd:	75 f1                	jne    37b0 <bsstest+0x30>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit(1);
    }
  }
  printf(stdout, "bss test ok\n");
    37bf:	83 ec 08             	sub    $0x8,%esp
    37c2:	68 01 52 00 00       	push   $0x5201
    37c7:	ff 35 a4 63 00 00    	pushl  0x63a4
    37cd:	e8 0e 08 00 00       	call   3fe0 <printf>
}
    37d2:	83 c4 10             	add    $0x10,%esp
    37d5:	c9                   	leave  
    37d6:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    37d7:	83 ec 08             	sub    $0x8,%esp
    37da:	68 f0 51 00 00       	push   $0x51f0
    37df:	ff 35 a4 63 00 00    	pushl  0x63a4
    37e5:	e8 f6 07 00 00       	call   3fe0 <printf>
      exit(1);
    37ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    37f1:	e8 7c 06 00 00       	call   3e72 <exit>
    37f6:	8d 76 00             	lea    0x0(%esi),%esi
    37f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003800 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3800:	55                   	push   %ebp
    3801:	89 e5                	mov    %esp,%ebp
    3803:	83 ec 24             	sub    $0x24,%esp
  int pid, fd, status;

  unlink("bigarg-ok");
    3806:	68 0e 52 00 00       	push   $0x520e
    380b:	e8 b2 06 00 00       	call   3ec2 <unlink>
  pid = fork();
    3810:	e8 55 06 00 00       	call   3e6a <fork>
  if(pid == 0){
    3815:	83 c4 10             	add    $0x10,%esp
    3818:	85 c0                	test   %eax,%eax
    381a:	74 45                	je     3861 <bigargtest+0x61>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit(0);
  } else if(pid < 0){
    381c:	0f 88 e0 00 00 00    	js     3902 <bigargtest+0x102>
    printf(stdout, "bigargtest: fork failed\n");
    exit(1);
  }
  wait(&status);
    3822:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3825:	83 ec 0c             	sub    $0xc,%esp
    3828:	50                   	push   %eax
    3829:	e8 4c 06 00 00       	call   3e7a <wait>
  fd = open("bigarg-ok", 0);
    382e:	5a                   	pop    %edx
    382f:	59                   	pop    %ecx
    3830:	6a 00                	push   $0x0
    3832:	68 0e 52 00 00       	push   $0x520e
    3837:	e8 76 06 00 00       	call   3eb2 <open>
  if(fd < 0){
    383c:	83 c4 10             	add    $0x10,%esp
    383f:	85 c0                	test   %eax,%eax
    3841:	0f 88 9d 00 00 00    	js     38e4 <bigargtest+0xe4>
    printf(stdout, "bigarg test failed!\n");
    exit(1);
  }
  close(fd);
    3847:	83 ec 0c             	sub    $0xc,%esp
    384a:	50                   	push   %eax
    384b:	e8 4a 06 00 00       	call   3e9a <close>
  unlink("bigarg-ok");
    3850:	c7 04 24 0e 52 00 00 	movl   $0x520e,(%esp)
    3857:	e8 66 06 00 00       	call   3ec2 <unlink>
}
    385c:	83 c4 10             	add    $0x10,%esp
    385f:	c9                   	leave  
    3860:	c3                   	ret    
    3861:	b8 c0 63 00 00       	mov    $0x63c0,%eax
    3866:	8d 76 00             	lea    0x0(%esi),%esi
    3869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3870:	c7 00 68 59 00 00    	movl   $0x5968,(%eax)
    3876:	83 c0 04             	add    $0x4,%eax
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3879:	3d 3c 64 00 00       	cmp    $0x643c,%eax
    387e:	75 f0                	jne    3870 <bigargtest+0x70>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    printf(stdout, "bigarg test\n");
    3880:	50                   	push   %eax
    3881:	50                   	push   %eax
    3882:	68 18 52 00 00       	push   $0x5218
    3887:	ff 35 a4 63 00 00    	pushl  0x63a4
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    388d:	c7 05 3c 64 00 00 00 	movl   $0x0,0x643c
    3894:	00 00 00 
    printf(stdout, "bigarg test\n");
    3897:	e8 44 07 00 00       	call   3fe0 <printf>
    exec("echo", args);
    389c:	58                   	pop    %eax
    389d:	5a                   	pop    %edx
    389e:	68 c0 63 00 00       	push   $0x63c0
    38a3:	68 e5 43 00 00       	push   $0x43e5
    38a8:	e8 fd 05 00 00       	call   3eaa <exec>
    printf(stdout, "bigarg test ok\n");
    38ad:	59                   	pop    %ecx
    38ae:	58                   	pop    %eax
    38af:	68 25 52 00 00       	push   $0x5225
    38b4:	ff 35 a4 63 00 00    	pushl  0x63a4
    38ba:	e8 21 07 00 00       	call   3fe0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    38bf:	58                   	pop    %eax
    38c0:	5a                   	pop    %edx
    38c1:	68 00 02 00 00       	push   $0x200
    38c6:	68 0e 52 00 00       	push   $0x520e
    38cb:	e8 e2 05 00 00       	call   3eb2 <open>
    close(fd);
    38d0:	89 04 24             	mov    %eax,(%esp)
    38d3:	e8 c2 05 00 00       	call   3e9a <close>
    exit(0);
    38d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38df:	e8 8e 05 00 00       	call   3e72 <exit>
    exit(1);
  }
  wait(&status);
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    38e4:	50                   	push   %eax
    38e5:	50                   	push   %eax
    38e6:	68 4e 52 00 00       	push   $0x524e
    38eb:	ff 35 a4 63 00 00    	pushl  0x63a4
    38f1:	e8 ea 06 00 00       	call   3fe0 <printf>
    exit(1);
    38f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    38fd:	e8 70 05 00 00       	call   3e72 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit(0);
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    3902:	50                   	push   %eax
    3903:	50                   	push   %eax
    3904:	68 35 52 00 00       	push   $0x5235
    3909:	ff 35 a4 63 00 00    	pushl  0x63a4
    390f:	e8 cc 06 00 00       	call   3fe0 <printf>
    exit(1);
    3914:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    391b:	e8 52 05 00 00       	call   3e72 <exit>

00003920 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3920:	55                   	push   %ebp
    3921:	89 e5                	mov    %esp,%ebp
    3923:	57                   	push   %edi
    3924:	56                   	push   %esi
    3925:	53                   	push   %ebx
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3926:	31 db                	xor    %ebx,%ebx

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3928:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    392b:	68 63 52 00 00       	push   $0x5263
    3930:	6a 01                	push   $0x1
    3932:	e8 a9 06 00 00       	call   3fe0 <printf>
    3937:	83 c4 10             	add    $0x10,%esp
    393a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3940:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3945:	89 de                	mov    %ebx,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    3947:	89 d9                	mov    %ebx,%ecx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3949:	f7 eb                	imul   %ebx
    394b:	c1 fe 1f             	sar    $0x1f,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    394e:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    3950:	83 ec 04             	sub    $0x4,%esp

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    3953:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    3957:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    395b:	c1 fa 06             	sar    $0x6,%edx
    395e:	29 f2                	sub    %esi,%edx
    3960:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3963:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3969:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    396c:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3971:	29 d1                	sub    %edx,%ecx
    3973:	f7 e9                	imul   %ecx
    3975:	c1 f9 1f             	sar    $0x1f,%ecx
    name[3] = '0' + (nfiles % 100) / 10;
    3978:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    397d:	c1 fa 05             	sar    $0x5,%edx
    3980:	29 ca                	sub    %ecx,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    3982:	b9 67 66 66 66       	mov    $0x66666667,%ecx

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    3987:	83 c2 30             	add    $0x30,%edx
    398a:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    398d:	f7 eb                	imul   %ebx
    398f:	c1 fa 05             	sar    $0x5,%edx
    3992:	29 f2                	sub    %esi,%edx
    3994:	6b d2 64             	imul   $0x64,%edx,%edx
    3997:	29 d7                	sub    %edx,%edi
    3999:	89 f8                	mov    %edi,%eax
    399b:	c1 ff 1f             	sar    $0x1f,%edi
    399e:	f7 e9                	imul   %ecx
    name[4] = '0' + (nfiles % 10);
    39a0:	89 d8                	mov    %ebx,%eax
  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    39a2:	c1 fa 02             	sar    $0x2,%edx
    39a5:	29 fa                	sub    %edi,%edx
    39a7:	83 c2 30             	add    $0x30,%edx
    39aa:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    39ad:	f7 e9                	imul   %ecx
    39af:	89 d9                	mov    %ebx,%ecx
    39b1:	c1 fa 02             	sar    $0x2,%edx
    39b4:	29 f2                	sub    %esi,%edx
    39b6:	8d 04 92             	lea    (%edx,%edx,4),%eax
    39b9:	01 c0                	add    %eax,%eax
    39bb:	29 c1                	sub    %eax,%ecx
    39bd:	89 c8                	mov    %ecx,%eax
    39bf:	83 c0 30             	add    $0x30,%eax
    39c2:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    39c5:	8d 45 a8             	lea    -0x58(%ebp),%eax
    39c8:	50                   	push   %eax
    39c9:	68 70 52 00 00       	push   $0x5270
    39ce:	6a 01                	push   $0x1
    39d0:	e8 0b 06 00 00       	call   3fe0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    39d5:	58                   	pop    %eax
    39d6:	8d 45 a8             	lea    -0x58(%ebp),%eax
    39d9:	5a                   	pop    %edx
    39da:	68 02 02 00 00       	push   $0x202
    39df:	50                   	push   %eax
    39e0:	e8 cd 04 00 00       	call   3eb2 <open>
    if(fd < 0){
    39e5:	83 c4 10             	add    $0x10,%esp
    39e8:	85 c0                	test   %eax,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    39ea:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    39ec:	78 50                	js     3a3e <fsfull+0x11e>
    39ee:	31 f6                	xor    %esi,%esi
    39f0:	eb 08                	jmp    39fa <fsfull+0xda>
    39f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    39f8:	01 c6                	add    %eax,%esi
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    39fa:	83 ec 04             	sub    $0x4,%esp
    39fd:	68 00 02 00 00       	push   $0x200
    3a02:	68 80 8b 00 00       	push   $0x8b80
    3a07:	57                   	push   %edi
    3a08:	e8 85 04 00 00       	call   3e92 <write>
      if(cc < 512)
    3a0d:	83 c4 10             	add    $0x10,%esp
    3a10:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3a15:	7f e1                	jg     39f8 <fsfull+0xd8>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3a17:	83 ec 04             	sub    $0x4,%esp
    3a1a:	56                   	push   %esi
    3a1b:	68 8c 52 00 00       	push   $0x528c
    3a20:	6a 01                	push   $0x1
    3a22:	e8 b9 05 00 00       	call   3fe0 <printf>
    close(fd);
    3a27:	89 3c 24             	mov    %edi,(%esp)
    3a2a:	e8 6b 04 00 00       	call   3e9a <close>
    if(total == 0)
    3a2f:	83 c4 10             	add    $0x10,%esp
    3a32:	85 f6                	test   %esi,%esi
    3a34:	74 22                	je     3a58 <fsfull+0x138>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3a36:	83 c3 01             	add    $0x1,%ebx
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    3a39:	e9 02 ff ff ff       	jmp    3940 <fsfull+0x20>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    3a3e:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3a41:	83 ec 04             	sub    $0x4,%esp
    3a44:	50                   	push   %eax
    3a45:	68 7c 52 00 00       	push   $0x527c
    3a4a:	6a 01                	push   $0x1
    3a4c:	e8 8f 05 00 00       	call   3fe0 <printf>
      break;
    3a51:	83 c4 10             	add    $0x10,%esp
    3a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3a58:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3a5d:	89 de                	mov    %ebx,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    3a5f:	89 d9                	mov    %ebx,%ecx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3a61:	f7 eb                	imul   %ebx
    3a63:	c1 fe 1f             	sar    $0x1f,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    3a66:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    unlink(name);
    3a68:	83 ec 0c             	sub    $0xc,%esp
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    3a6b:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    3a6f:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3a73:	c1 fa 06             	sar    $0x6,%edx
    3a76:	29 f2                	sub    %esi,%edx
    3a78:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3a7b:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3a81:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3a84:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3a89:	29 d1                	sub    %edx,%ecx
    3a8b:	f7 e9                	imul   %ecx
    3a8d:	c1 f9 1f             	sar    $0x1f,%ecx
    name[3] = '0' + (nfiles % 100) / 10;
    3a90:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    3a95:	c1 fa 05             	sar    $0x5,%edx
    3a98:	29 ca                	sub    %ecx,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    3a9a:	b9 67 66 66 66       	mov    $0x66666667,%ecx

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    3a9f:	83 c2 30             	add    $0x30,%edx
    3aa2:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3aa5:	f7 eb                	imul   %ebx
    3aa7:	c1 fa 05             	sar    $0x5,%edx
    3aaa:	29 f2                	sub    %esi,%edx
    3aac:	6b d2 64             	imul   $0x64,%edx,%edx
    3aaf:	29 d7                	sub    %edx,%edi
    3ab1:	89 f8                	mov    %edi,%eax
    3ab3:	c1 ff 1f             	sar    $0x1f,%edi
    3ab6:	f7 e9                	imul   %ecx
    name[4] = '0' + (nfiles % 10);
    3ab8:	89 d8                	mov    %ebx,%eax
  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    3aba:	c1 fa 02             	sar    $0x2,%edx
    3abd:	29 fa                	sub    %edi,%edx
    3abf:	83 c2 30             	add    $0x30,%edx
    3ac2:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3ac5:	f7 e9                	imul   %ecx
    3ac7:	89 d9                	mov    %ebx,%ecx
    name[5] = '\0';
    unlink(name);
    nfiles--;
    3ac9:	83 eb 01             	sub    $0x1,%ebx
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    3acc:	c1 fa 02             	sar    $0x2,%edx
    3acf:	29 f2                	sub    %esi,%edx
    3ad1:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3ad4:	01 c0                	add    %eax,%eax
    3ad6:	29 c1                	sub    %eax,%ecx
    3ad8:	89 c8                	mov    %ecx,%eax
    3ada:	83 c0 30             	add    $0x30,%eax
    3add:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    unlink(name);
    3ae0:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3ae3:	50                   	push   %eax
    3ae4:	e8 d9 03 00 00       	call   3ec2 <unlink>
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    3ae9:	83 c4 10             	add    $0x10,%esp
    3aec:	83 fb ff             	cmp    $0xffffffff,%ebx
    3aef:	0f 85 63 ff ff ff    	jne    3a58 <fsfull+0x138>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3af5:	83 ec 08             	sub    $0x8,%esp
    3af8:	68 9c 52 00 00       	push   $0x529c
    3afd:	6a 01                	push   $0x1
    3aff:	e8 dc 04 00 00       	call   3fe0 <printf>
}
    3b04:	83 c4 10             	add    $0x10,%esp
    3b07:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3b0a:	5b                   	pop    %ebx
    3b0b:	5e                   	pop    %esi
    3b0c:	5f                   	pop    %edi
    3b0d:	5d                   	pop    %ebp
    3b0e:	c3                   	ret    
    3b0f:	90                   	nop

00003b10 <uio>:

void
uio()
{
    3b10:	55                   	push   %ebp
    3b11:	89 e5                	mov    %esp,%ebp
    3b13:	83 ec 20             	sub    $0x20,%esp

  ushort port = 0;
  uchar val = 0;
  int pid, status;

  printf(1, "uio test\n");
    3b16:	68 b2 52 00 00       	push   $0x52b2
    3b1b:	6a 01                	push   $0x1
    3b1d:	e8 be 04 00 00       	call   3fe0 <printf>
  pid = fork();
    3b22:	e8 43 03 00 00       	call   3e6a <fork>
  if(pid == 0){
    3b27:	83 c4 10             	add    $0x10,%esp
    3b2a:	85 c0                	test   %eax,%eax
    3b2c:	74 21                	je     3b4f <uio+0x3f>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit(1);
  } else if(pid < 0){
    3b2e:	78 4a                	js     3b7a <uio+0x6a>
    printf (1, "fork failed\n");
    exit(1);
  }
  wait(&status);
    3b30:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3b33:	83 ec 0c             	sub    $0xc,%esp
    3b36:	50                   	push   %eax
    3b37:	e8 3e 03 00 00       	call   3e7a <wait>
  printf(1, "uio test done\n");
    3b3c:	58                   	pop    %eax
    3b3d:	5a                   	pop    %edx
    3b3e:	68 bc 52 00 00       	push   $0x52bc
    3b43:	6a 01                	push   $0x1
    3b45:	e8 96 04 00 00       	call   3fe0 <printf>
}
    3b4a:	83 c4 10             	add    $0x10,%esp
    3b4d:	c9                   	leave  
    3b4e:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3b4f:	ba 70 00 00 00       	mov    $0x70,%edx
    3b54:	b8 09 00 00 00       	mov    $0x9,%eax
    3b59:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3b5a:	ba 71 00 00 00       	mov    $0x71,%edx
    3b5f:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    3b60:	50                   	push   %eax
    3b61:	50                   	push   %eax
    3b62:	68 48 5a 00 00       	push   $0x5a48
    3b67:	6a 01                	push   $0x1
    3b69:	e8 72 04 00 00       	call   3fe0 <printf>
    exit(1);
    3b6e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b75:	e8 f8 02 00 00       	call   3e72 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    3b7a:	51                   	push   %ecx
    3b7b:	51                   	push   %ecx
    3b7c:	68 41 52 00 00       	push   $0x5241
    3b81:	6a 01                	push   $0x1
    3b83:	e8 58 04 00 00       	call   3fe0 <printf>
    exit(1);
    3b88:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b8f:	e8 de 02 00 00       	call   3e72 <exit>
    3b94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3b9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003ba0 <argptest>:
  wait(&status);
  printf(1, "uio test done\n");
}

void argptest()
{
    3ba0:	55                   	push   %ebp
    3ba1:	89 e5                	mov    %esp,%ebp
    3ba3:	53                   	push   %ebx
    3ba4:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  fd = open("init", O_RDONLY);
    3ba7:	6a 00                	push   $0x0
    3ba9:	68 cb 52 00 00       	push   $0x52cb
    3bae:	e8 ff 02 00 00       	call   3eb2 <open>
  if (fd < 0) {
    3bb3:	83 c4 10             	add    $0x10,%esp
    3bb6:	85 c0                	test   %eax,%eax
    3bb8:	78 39                	js     3bf3 <argptest+0x53>
    printf(2, "open failed\n");
    exit(1);
  }
  read(fd, sbrk(0) - 1, -1);
    3bba:	83 ec 0c             	sub    $0xc,%esp
    3bbd:	89 c3                	mov    %eax,%ebx
    3bbf:	6a 00                	push   $0x0
    3bc1:	e8 3c 03 00 00       	call   3f02 <sbrk>
    3bc6:	83 c4 0c             	add    $0xc,%esp
    3bc9:	83 e8 01             	sub    $0x1,%eax
    3bcc:	6a ff                	push   $0xffffffff
    3bce:	50                   	push   %eax
    3bcf:	53                   	push   %ebx
    3bd0:	e8 b5 02 00 00       	call   3e8a <read>
  close(fd);
    3bd5:	89 1c 24             	mov    %ebx,(%esp)
    3bd8:	e8 bd 02 00 00       	call   3e9a <close>
  printf(1, "arg test passed\n");
    3bdd:	58                   	pop    %eax
    3bde:	5a                   	pop    %edx
    3bdf:	68 dd 52 00 00       	push   $0x52dd
    3be4:	6a 01                	push   $0x1
    3be6:	e8 f5 03 00 00       	call   3fe0 <printf>
}
    3beb:	83 c4 10             	add    $0x10,%esp
    3bee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3bf1:	c9                   	leave  
    3bf2:	c3                   	ret    
void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
  if (fd < 0) {
    printf(2, "open failed\n");
    3bf3:	51                   	push   %ecx
    3bf4:	51                   	push   %ecx
    3bf5:	68 d0 52 00 00       	push   $0x52d0
    3bfa:	6a 02                	push   $0x2
    3bfc:	e8 df 03 00 00       	call   3fe0 <printf>
    exit(1);
    3c01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c08:	e8 65 02 00 00       	call   3e72 <exit>
    3c0d:	8d 76 00             	lea    0x0(%esi),%esi

00003c10 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    3c10:	69 05 a0 63 00 00 0d 	imul   $0x19660d,0x63a0,%eax
    3c17:	66 19 00 
}

unsigned long randstate = 1;
unsigned int
rand()
{
    3c1a:	55                   	push   %ebp
    3c1b:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
  return randstate;
}
    3c1d:	5d                   	pop    %ebp

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    3c1e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3c23:	a3 a0 63 00 00       	mov    %eax,0x63a0
  return randstate;
}
    3c28:	c3                   	ret    
    3c29:	66 90                	xchg   %ax,%ax
    3c2b:	66 90                	xchg   %ax,%ax
    3c2d:	66 90                	xchg   %ax,%ax
    3c2f:	90                   	nop

00003c30 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3c30:	55                   	push   %ebp
    3c31:	89 e5                	mov    %esp,%ebp
    3c33:	53                   	push   %ebx
    3c34:	8b 45 08             	mov    0x8(%ebp),%eax
    3c37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3c3a:	89 c2                	mov    %eax,%edx
    3c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c40:	83 c1 01             	add    $0x1,%ecx
    3c43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3c47:	83 c2 01             	add    $0x1,%edx
    3c4a:	84 db                	test   %bl,%bl
    3c4c:	88 5a ff             	mov    %bl,-0x1(%edx)
    3c4f:	75 ef                	jne    3c40 <strcpy+0x10>
    ;
  return os;
}
    3c51:	5b                   	pop    %ebx
    3c52:	5d                   	pop    %ebp
    3c53:	c3                   	ret    
    3c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003c60 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3c60:	55                   	push   %ebp
    3c61:	89 e5                	mov    %esp,%ebp
    3c63:	56                   	push   %esi
    3c64:	53                   	push   %ebx
    3c65:	8b 55 08             	mov    0x8(%ebp),%edx
    3c68:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    3c6b:	0f b6 02             	movzbl (%edx),%eax
    3c6e:	0f b6 19             	movzbl (%ecx),%ebx
    3c71:	84 c0                	test   %al,%al
    3c73:	75 1e                	jne    3c93 <strcmp+0x33>
    3c75:	eb 29                	jmp    3ca0 <strcmp+0x40>
    3c77:	89 f6                	mov    %esi,%esi
    3c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    3c80:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3c83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    3c86:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3c89:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3c8d:	84 c0                	test   %al,%al
    3c8f:	74 0f                	je     3ca0 <strcmp+0x40>
    3c91:	89 f1                	mov    %esi,%ecx
    3c93:	38 d8                	cmp    %bl,%al
    3c95:	74 e9                	je     3c80 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3c97:	29 d8                	sub    %ebx,%eax
}
    3c99:	5b                   	pop    %ebx
    3c9a:	5e                   	pop    %esi
    3c9b:	5d                   	pop    %ebp
    3c9c:	c3                   	ret    
    3c9d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3ca0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3ca2:	29 d8                	sub    %ebx,%eax
}
    3ca4:	5b                   	pop    %ebx
    3ca5:	5e                   	pop    %esi
    3ca6:	5d                   	pop    %ebp
    3ca7:	c3                   	ret    
    3ca8:	90                   	nop
    3ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003cb0 <strlen>:

uint
strlen(const char *s)
{
    3cb0:	55                   	push   %ebp
    3cb1:	89 e5                	mov    %esp,%ebp
    3cb3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3cb6:	80 39 00             	cmpb   $0x0,(%ecx)
    3cb9:	74 12                	je     3ccd <strlen+0x1d>
    3cbb:	31 d2                	xor    %edx,%edx
    3cbd:	8d 76 00             	lea    0x0(%esi),%esi
    3cc0:	83 c2 01             	add    $0x1,%edx
    3cc3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3cc7:	89 d0                	mov    %edx,%eax
    3cc9:	75 f5                	jne    3cc0 <strlen+0x10>
    ;
  return n;
}
    3ccb:	5d                   	pop    %ebp
    3ccc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    3ccd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    3ccf:	5d                   	pop    %ebp
    3cd0:	c3                   	ret    
    3cd1:	eb 0d                	jmp    3ce0 <memset>
    3cd3:	90                   	nop
    3cd4:	90                   	nop
    3cd5:	90                   	nop
    3cd6:	90                   	nop
    3cd7:	90                   	nop
    3cd8:	90                   	nop
    3cd9:	90                   	nop
    3cda:	90                   	nop
    3cdb:	90                   	nop
    3cdc:	90                   	nop
    3cdd:	90                   	nop
    3cde:	90                   	nop
    3cdf:	90                   	nop

00003ce0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3ce0:	55                   	push   %ebp
    3ce1:	89 e5                	mov    %esp,%ebp
    3ce3:	57                   	push   %edi
    3ce4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3ce7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3cea:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ced:	89 d7                	mov    %edx,%edi
    3cef:	fc                   	cld    
    3cf0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3cf2:	89 d0                	mov    %edx,%eax
    3cf4:	5f                   	pop    %edi
    3cf5:	5d                   	pop    %ebp
    3cf6:	c3                   	ret    
    3cf7:	89 f6                	mov    %esi,%esi
    3cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003d00 <strchr>:

char*
strchr(const char *s, char c)
{
    3d00:	55                   	push   %ebp
    3d01:	89 e5                	mov    %esp,%ebp
    3d03:	53                   	push   %ebx
    3d04:	8b 45 08             	mov    0x8(%ebp),%eax
    3d07:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    3d0a:	0f b6 10             	movzbl (%eax),%edx
    3d0d:	84 d2                	test   %dl,%dl
    3d0f:	74 1d                	je     3d2e <strchr+0x2e>
    if(*s == c)
    3d11:	38 d3                	cmp    %dl,%bl
    3d13:	89 d9                	mov    %ebx,%ecx
    3d15:	75 0d                	jne    3d24 <strchr+0x24>
    3d17:	eb 17                	jmp    3d30 <strchr+0x30>
    3d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d20:	38 ca                	cmp    %cl,%dl
    3d22:	74 0c                	je     3d30 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3d24:	83 c0 01             	add    $0x1,%eax
    3d27:	0f b6 10             	movzbl (%eax),%edx
    3d2a:	84 d2                	test   %dl,%dl
    3d2c:	75 f2                	jne    3d20 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    3d2e:	31 c0                	xor    %eax,%eax
}
    3d30:	5b                   	pop    %ebx
    3d31:	5d                   	pop    %ebp
    3d32:	c3                   	ret    
    3d33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003d40 <gets>:

char*
gets(char *buf, int max)
{
    3d40:	55                   	push   %ebp
    3d41:	89 e5                	mov    %esp,%ebp
    3d43:	57                   	push   %edi
    3d44:	56                   	push   %esi
    3d45:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3d46:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    3d48:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    3d4b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3d4e:	eb 29                	jmp    3d79 <gets+0x39>
    cc = read(0, &c, 1);
    3d50:	83 ec 04             	sub    $0x4,%esp
    3d53:	6a 01                	push   $0x1
    3d55:	57                   	push   %edi
    3d56:	6a 00                	push   $0x0
    3d58:	e8 2d 01 00 00       	call   3e8a <read>
    if(cc < 1)
    3d5d:	83 c4 10             	add    $0x10,%esp
    3d60:	85 c0                	test   %eax,%eax
    3d62:	7e 1d                	jle    3d81 <gets+0x41>
      break;
    buf[i++] = c;
    3d64:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3d68:	8b 55 08             	mov    0x8(%ebp),%edx
    3d6b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    3d6d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    3d6f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    3d73:	74 1b                	je     3d90 <gets+0x50>
    3d75:	3c 0d                	cmp    $0xd,%al
    3d77:	74 17                	je     3d90 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3d79:	8d 5e 01             	lea    0x1(%esi),%ebx
    3d7c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3d7f:	7c cf                	jl     3d50 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3d81:	8b 45 08             	mov    0x8(%ebp),%eax
    3d84:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3d88:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3d8b:	5b                   	pop    %ebx
    3d8c:	5e                   	pop    %esi
    3d8d:	5f                   	pop    %edi
    3d8e:	5d                   	pop    %ebp
    3d8f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3d90:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3d93:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3d95:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3d99:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3d9c:	5b                   	pop    %ebx
    3d9d:	5e                   	pop    %esi
    3d9e:	5f                   	pop    %edi
    3d9f:	5d                   	pop    %ebp
    3da0:	c3                   	ret    
    3da1:	eb 0d                	jmp    3db0 <stat>
    3da3:	90                   	nop
    3da4:	90                   	nop
    3da5:	90                   	nop
    3da6:	90                   	nop
    3da7:	90                   	nop
    3da8:	90                   	nop
    3da9:	90                   	nop
    3daa:	90                   	nop
    3dab:	90                   	nop
    3dac:	90                   	nop
    3dad:	90                   	nop
    3dae:	90                   	nop
    3daf:	90                   	nop

00003db0 <stat>:

int
stat(const char *n, struct stat *st)
{
    3db0:	55                   	push   %ebp
    3db1:	89 e5                	mov    %esp,%ebp
    3db3:	56                   	push   %esi
    3db4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3db5:	83 ec 08             	sub    $0x8,%esp
    3db8:	6a 00                	push   $0x0
    3dba:	ff 75 08             	pushl  0x8(%ebp)
    3dbd:	e8 f0 00 00 00       	call   3eb2 <open>
  if(fd < 0)
    3dc2:	83 c4 10             	add    $0x10,%esp
    3dc5:	85 c0                	test   %eax,%eax
    3dc7:	78 27                	js     3df0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3dc9:	83 ec 08             	sub    $0x8,%esp
    3dcc:	ff 75 0c             	pushl  0xc(%ebp)
    3dcf:	89 c3                	mov    %eax,%ebx
    3dd1:	50                   	push   %eax
    3dd2:	e8 f3 00 00 00       	call   3eca <fstat>
    3dd7:	89 c6                	mov    %eax,%esi
  close(fd);
    3dd9:	89 1c 24             	mov    %ebx,(%esp)
    3ddc:	e8 b9 00 00 00       	call   3e9a <close>
  return r;
    3de1:	83 c4 10             	add    $0x10,%esp
    3de4:	89 f0                	mov    %esi,%eax
}
    3de6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3de9:	5b                   	pop    %ebx
    3dea:	5e                   	pop    %esi
    3deb:	5d                   	pop    %ebp
    3dec:	c3                   	ret    
    3ded:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    3df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3df5:	eb ef                	jmp    3de6 <stat+0x36>
    3df7:	89 f6                	mov    %esi,%esi
    3df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003e00 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    3e00:	55                   	push   %ebp
    3e01:	89 e5                	mov    %esp,%ebp
    3e03:	53                   	push   %ebx
    3e04:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3e07:	0f be 11             	movsbl (%ecx),%edx
    3e0a:	8d 42 d0             	lea    -0x30(%edx),%eax
    3e0d:	3c 09                	cmp    $0x9,%al
    3e0f:	b8 00 00 00 00       	mov    $0x0,%eax
    3e14:	77 1f                	ja     3e35 <atoi+0x35>
    3e16:	8d 76 00             	lea    0x0(%esi),%esi
    3e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    3e20:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3e23:	83 c1 01             	add    $0x1,%ecx
    3e26:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3e2a:	0f be 11             	movsbl (%ecx),%edx
    3e2d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3e30:	80 fb 09             	cmp    $0x9,%bl
    3e33:	76 eb                	jbe    3e20 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    3e35:	5b                   	pop    %ebx
    3e36:	5d                   	pop    %ebp
    3e37:	c3                   	ret    
    3e38:	90                   	nop
    3e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003e40 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3e40:	55                   	push   %ebp
    3e41:	89 e5                	mov    %esp,%ebp
    3e43:	56                   	push   %esi
    3e44:	53                   	push   %ebx
    3e45:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3e48:	8b 45 08             	mov    0x8(%ebp),%eax
    3e4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3e4e:	85 db                	test   %ebx,%ebx
    3e50:	7e 14                	jle    3e66 <memmove+0x26>
    3e52:	31 d2                	xor    %edx,%edx
    3e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    3e58:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    3e5c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3e5f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3e62:	39 da                	cmp    %ebx,%edx
    3e64:	75 f2                	jne    3e58 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    3e66:	5b                   	pop    %ebx
    3e67:	5e                   	pop    %esi
    3e68:	5d                   	pop    %ebp
    3e69:	c3                   	ret    

00003e6a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3e6a:	b8 01 00 00 00       	mov    $0x1,%eax
    3e6f:	cd 40                	int    $0x40
    3e71:	c3                   	ret    

00003e72 <exit>:
SYSCALL(exit)
    3e72:	b8 02 00 00 00       	mov    $0x2,%eax
    3e77:	cd 40                	int    $0x40
    3e79:	c3                   	ret    

00003e7a <wait>:
SYSCALL(wait)
    3e7a:	b8 03 00 00 00       	mov    $0x3,%eax
    3e7f:	cd 40                	int    $0x40
    3e81:	c3                   	ret    

00003e82 <pipe>:
SYSCALL(pipe)
    3e82:	b8 04 00 00 00       	mov    $0x4,%eax
    3e87:	cd 40                	int    $0x40
    3e89:	c3                   	ret    

00003e8a <read>:
SYSCALL(read)
    3e8a:	b8 05 00 00 00       	mov    $0x5,%eax
    3e8f:	cd 40                	int    $0x40
    3e91:	c3                   	ret    

00003e92 <write>:
SYSCALL(write)
    3e92:	b8 10 00 00 00       	mov    $0x10,%eax
    3e97:	cd 40                	int    $0x40
    3e99:	c3                   	ret    

00003e9a <close>:
SYSCALL(close)
    3e9a:	b8 15 00 00 00       	mov    $0x15,%eax
    3e9f:	cd 40                	int    $0x40
    3ea1:	c3                   	ret    

00003ea2 <kill>:
SYSCALL(kill)
    3ea2:	b8 06 00 00 00       	mov    $0x6,%eax
    3ea7:	cd 40                	int    $0x40
    3ea9:	c3                   	ret    

00003eaa <exec>:
SYSCALL(exec)
    3eaa:	b8 07 00 00 00       	mov    $0x7,%eax
    3eaf:	cd 40                	int    $0x40
    3eb1:	c3                   	ret    

00003eb2 <open>:
SYSCALL(open)
    3eb2:	b8 0f 00 00 00       	mov    $0xf,%eax
    3eb7:	cd 40                	int    $0x40
    3eb9:	c3                   	ret    

00003eba <mknod>:
SYSCALL(mknod)
    3eba:	b8 11 00 00 00       	mov    $0x11,%eax
    3ebf:	cd 40                	int    $0x40
    3ec1:	c3                   	ret    

00003ec2 <unlink>:
SYSCALL(unlink)
    3ec2:	b8 12 00 00 00       	mov    $0x12,%eax
    3ec7:	cd 40                	int    $0x40
    3ec9:	c3                   	ret    

00003eca <fstat>:
SYSCALL(fstat)
    3eca:	b8 08 00 00 00       	mov    $0x8,%eax
    3ecf:	cd 40                	int    $0x40
    3ed1:	c3                   	ret    

00003ed2 <link>:
SYSCALL(link)
    3ed2:	b8 13 00 00 00       	mov    $0x13,%eax
    3ed7:	cd 40                	int    $0x40
    3ed9:	c3                   	ret    

00003eda <mkdir>:
SYSCALL(mkdir)
    3eda:	b8 14 00 00 00       	mov    $0x14,%eax
    3edf:	cd 40                	int    $0x40
    3ee1:	c3                   	ret    

00003ee2 <chdir>:
SYSCALL(chdir)
    3ee2:	b8 09 00 00 00       	mov    $0x9,%eax
    3ee7:	cd 40                	int    $0x40
    3ee9:	c3                   	ret    

00003eea <dup>:
SYSCALL(dup)
    3eea:	b8 0a 00 00 00       	mov    $0xa,%eax
    3eef:	cd 40                	int    $0x40
    3ef1:	c3                   	ret    

00003ef2 <getpid>:
SYSCALL(getpid)
    3ef2:	b8 0b 00 00 00       	mov    $0xb,%eax
    3ef7:	cd 40                	int    $0x40
    3ef9:	c3                   	ret    

00003efa <memsize>:
SYSCALL(memsize)
    3efa:	b8 16 00 00 00       	mov    $0x16,%eax
    3eff:	cd 40                	int    $0x40
    3f01:	c3                   	ret    

00003f02 <sbrk>:
SYSCALL(sbrk)
    3f02:	b8 0c 00 00 00       	mov    $0xc,%eax
    3f07:	cd 40                	int    $0x40
    3f09:	c3                   	ret    

00003f0a <sleep>:
SYSCALL(sleep)
    3f0a:	b8 0d 00 00 00       	mov    $0xd,%eax
    3f0f:	cd 40                	int    $0x40
    3f11:	c3                   	ret    

00003f12 <uptime>:
SYSCALL(uptime)
    3f12:	b8 0e 00 00 00       	mov    $0xe,%eax
    3f17:	cd 40                	int    $0x40
    3f19:	c3                   	ret    

00003f1a <policy>:
SYSCALL(policy)
    3f1a:	b8 17 00 00 00       	mov    $0x17,%eax
    3f1f:	cd 40                	int    $0x40
    3f21:	c3                   	ret    

00003f22 <set_cfs_priority>:
SYSCALL(set_cfs_priority)
    3f22:	b8 19 00 00 00       	mov    $0x19,%eax
    3f27:	cd 40                	int    $0x40
    3f29:	c3                   	ret    

00003f2a <set_ps_priority>:
SYSCALL(set_ps_priority)
    3f2a:	b8 18 00 00 00       	mov    $0x18,%eax
    3f2f:	cd 40                	int    $0x40
    3f31:	c3                   	ret    

00003f32 <proc_info>:
SYSCALL(proc_info)
    3f32:	b8 1a 00 00 00       	mov    $0x1a,%eax
    3f37:	cd 40                	int    $0x40
    3f39:	c3                   	ret    
    3f3a:	66 90                	xchg   %ax,%ax
    3f3c:	66 90                	xchg   %ax,%ax
    3f3e:	66 90                	xchg   %ax,%ax

00003f40 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3f40:	55                   	push   %ebp
    3f41:	89 e5                	mov    %esp,%ebp
    3f43:	57                   	push   %edi
    3f44:	56                   	push   %esi
    3f45:	53                   	push   %ebx
    3f46:	89 c6                	mov    %eax,%esi
    3f48:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3f4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3f4e:	85 db                	test   %ebx,%ebx
    3f50:	74 7e                	je     3fd0 <printint+0x90>
    3f52:	89 d0                	mov    %edx,%eax
    3f54:	c1 e8 1f             	shr    $0x1f,%eax
    3f57:	84 c0                	test   %al,%al
    3f59:	74 75                	je     3fd0 <printint+0x90>
    neg = 1;
    x = -xx;
    3f5b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    3f5d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    3f64:	f7 d8                	neg    %eax
    3f66:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    3f69:	31 ff                	xor    %edi,%edi
    3f6b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    3f6e:	89 ce                	mov    %ecx,%esi
    3f70:	eb 08                	jmp    3f7a <printint+0x3a>
    3f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3f78:	89 cf                	mov    %ecx,%edi
    3f7a:	31 d2                	xor    %edx,%edx
    3f7c:	8d 4f 01             	lea    0x1(%edi),%ecx
    3f7f:	f7 f6                	div    %esi
    3f81:	0f b6 92 a0 5a 00 00 	movzbl 0x5aa0(%edx),%edx
  }while((x /= base) != 0);
    3f88:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3f8a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    3f8d:	75 e9                	jne    3f78 <printint+0x38>
  if(neg)
    3f8f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3f92:	8b 75 c0             	mov    -0x40(%ebp),%esi
    3f95:	85 c0                	test   %eax,%eax
    3f97:	74 08                	je     3fa1 <printint+0x61>
    buf[i++] = '-';
    3f99:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    3f9e:	8d 4f 02             	lea    0x2(%edi),%ecx
    3fa1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    3fa5:	8d 76 00             	lea    0x0(%esi),%esi
    3fa8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3fab:	83 ec 04             	sub    $0x4,%esp
    3fae:	83 ef 01             	sub    $0x1,%edi
    3fb1:	6a 01                	push   $0x1
    3fb3:	53                   	push   %ebx
    3fb4:	56                   	push   %esi
    3fb5:	88 45 d7             	mov    %al,-0x29(%ebp)
    3fb8:	e8 d5 fe ff ff       	call   3e92 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3fbd:	83 c4 10             	add    $0x10,%esp
    3fc0:	39 df                	cmp    %ebx,%edi
    3fc2:	75 e4                	jne    3fa8 <printint+0x68>
    putc(fd, buf[i]);
}
    3fc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3fc7:	5b                   	pop    %ebx
    3fc8:	5e                   	pop    %esi
    3fc9:	5f                   	pop    %edi
    3fca:	5d                   	pop    %ebp
    3fcb:	c3                   	ret    
    3fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3fd0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3fd2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3fd9:	eb 8b                	jmp    3f66 <printint+0x26>
    3fdb:	90                   	nop
    3fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003fe0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3fe0:	55                   	push   %ebp
    3fe1:	89 e5                	mov    %esp,%ebp
    3fe3:	57                   	push   %edi
    3fe4:	56                   	push   %esi
    3fe5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3fe6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3fe9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3fec:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3fef:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3ff2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3ff5:	0f b6 1e             	movzbl (%esi),%ebx
    3ff8:	83 c6 01             	add    $0x1,%esi
    3ffb:	84 db                	test   %bl,%bl
    3ffd:	0f 84 b0 00 00 00    	je     40b3 <printf+0xd3>
    4003:	31 d2                	xor    %edx,%edx
    4005:	eb 39                	jmp    4040 <printf+0x60>
    4007:	89 f6                	mov    %esi,%esi
    4009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    4010:	83 f8 25             	cmp    $0x25,%eax
    4013:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    4016:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    401b:	74 18                	je     4035 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    401d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    4020:	83 ec 04             	sub    $0x4,%esp
    4023:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    4026:	6a 01                	push   $0x1
    4028:	50                   	push   %eax
    4029:	57                   	push   %edi
    402a:	e8 63 fe ff ff       	call   3e92 <write>
    402f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    4032:	83 c4 10             	add    $0x10,%esp
    4035:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4038:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    403c:	84 db                	test   %bl,%bl
    403e:	74 73                	je     40b3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    4040:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    4042:	0f be cb             	movsbl %bl,%ecx
    4045:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    4048:	74 c6                	je     4010 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    404a:	83 fa 25             	cmp    $0x25,%edx
    404d:	75 e6                	jne    4035 <printf+0x55>
      if(c == 'd'){
    404f:	83 f8 64             	cmp    $0x64,%eax
    4052:	0f 84 f8 00 00 00    	je     4150 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    4058:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    405e:	83 f9 70             	cmp    $0x70,%ecx
    4061:	74 5d                	je     40c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    4063:	83 f8 73             	cmp    $0x73,%eax
    4066:	0f 84 84 00 00 00    	je     40f0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    406c:	83 f8 63             	cmp    $0x63,%eax
    406f:	0f 84 ea 00 00 00    	je     415f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    4075:	83 f8 25             	cmp    $0x25,%eax
    4078:	0f 84 c2 00 00 00    	je     4140 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    407e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    4081:	83 ec 04             	sub    $0x4,%esp
    4084:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    4088:	6a 01                	push   $0x1
    408a:	50                   	push   %eax
    408b:	57                   	push   %edi
    408c:	e8 01 fe ff ff       	call   3e92 <write>
    4091:	83 c4 0c             	add    $0xc,%esp
    4094:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    4097:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    409a:	6a 01                	push   $0x1
    409c:	50                   	push   %eax
    409d:	57                   	push   %edi
    409e:	83 c6 01             	add    $0x1,%esi
    40a1:	e8 ec fd ff ff       	call   3e92 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    40a6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    40aa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    40ad:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    40af:	84 db                	test   %bl,%bl
    40b1:	75 8d                	jne    4040 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    40b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    40b6:	5b                   	pop    %ebx
    40b7:	5e                   	pop    %esi
    40b8:	5f                   	pop    %edi
    40b9:	5d                   	pop    %ebp
    40ba:	c3                   	ret    
    40bb:	90                   	nop
    40bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    40c0:	83 ec 0c             	sub    $0xc,%esp
    40c3:	b9 10 00 00 00       	mov    $0x10,%ecx
    40c8:	6a 00                	push   $0x0
    40ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    40cd:	89 f8                	mov    %edi,%eax
    40cf:	8b 13                	mov    (%ebx),%edx
    40d1:	e8 6a fe ff ff       	call   3f40 <printint>
        ap++;
    40d6:	89 d8                	mov    %ebx,%eax
    40d8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    40db:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    40dd:	83 c0 04             	add    $0x4,%eax
    40e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    40e3:	e9 4d ff ff ff       	jmp    4035 <printf+0x55>
    40e8:	90                   	nop
    40e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    40f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    40f3:	8b 18                	mov    (%eax),%ebx
        ap++;
    40f5:	83 c0 04             	add    $0x4,%eax
    40f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    40fb:	b8 98 5a 00 00       	mov    $0x5a98,%eax
    4100:	85 db                	test   %ebx,%ebx
    4102:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    4105:	0f b6 03             	movzbl (%ebx),%eax
    4108:	84 c0                	test   %al,%al
    410a:	74 23                	je     412f <printf+0x14f>
    410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4110:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4113:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    4116:	83 ec 04             	sub    $0x4,%esp
    4119:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    411b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    411e:	50                   	push   %eax
    411f:	57                   	push   %edi
    4120:	e8 6d fd ff ff       	call   3e92 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    4125:	0f b6 03             	movzbl (%ebx),%eax
    4128:	83 c4 10             	add    $0x10,%esp
    412b:	84 c0                	test   %al,%al
    412d:	75 e1                	jne    4110 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    412f:	31 d2                	xor    %edx,%edx
    4131:	e9 ff fe ff ff       	jmp    4035 <printf+0x55>
    4136:	8d 76 00             	lea    0x0(%esi),%esi
    4139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4140:	83 ec 04             	sub    $0x4,%esp
    4143:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    4146:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    4149:	6a 01                	push   $0x1
    414b:	e9 4c ff ff ff       	jmp    409c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    4150:	83 ec 0c             	sub    $0xc,%esp
    4153:	b9 0a 00 00 00       	mov    $0xa,%ecx
    4158:	6a 01                	push   $0x1
    415a:	e9 6b ff ff ff       	jmp    40ca <printf+0xea>
    415f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4162:	83 ec 04             	sub    $0x4,%esp
    4165:	8b 03                	mov    (%ebx),%eax
    4167:	6a 01                	push   $0x1
    4169:	88 45 e4             	mov    %al,-0x1c(%ebp)
    416c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    416f:	50                   	push   %eax
    4170:	57                   	push   %edi
    4171:	e8 1c fd ff ff       	call   3e92 <write>
    4176:	e9 5b ff ff ff       	jmp    40d6 <printf+0xf6>
    417b:	66 90                	xchg   %ax,%ax
    417d:	66 90                	xchg   %ax,%ax
    417f:	90                   	nop

00004180 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4180:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4181:	a1 40 64 00 00       	mov    0x6440,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    4186:	89 e5                	mov    %esp,%ebp
    4188:	57                   	push   %edi
    4189:	56                   	push   %esi
    418a:	53                   	push   %ebx
    418b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    418e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4190:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4193:	39 c8                	cmp    %ecx,%eax
    4195:	73 19                	jae    41b0 <free+0x30>
    4197:	89 f6                	mov    %esi,%esi
    4199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    41a0:	39 d1                	cmp    %edx,%ecx
    41a2:	72 1c                	jb     41c0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    41a4:	39 d0                	cmp    %edx,%eax
    41a6:	73 18                	jae    41c0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    41a8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    41aa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    41ac:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    41ae:	72 f0                	jb     41a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    41b0:	39 d0                	cmp    %edx,%eax
    41b2:	72 f4                	jb     41a8 <free+0x28>
    41b4:	39 d1                	cmp    %edx,%ecx
    41b6:	73 f0                	jae    41a8 <free+0x28>
    41b8:	90                   	nop
    41b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    41c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    41c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    41c6:	39 d7                	cmp    %edx,%edi
    41c8:	74 19                	je     41e3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    41ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    41cd:	8b 50 04             	mov    0x4(%eax),%edx
    41d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    41d3:	39 f1                	cmp    %esi,%ecx
    41d5:	74 23                	je     41fa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    41d7:	89 08                	mov    %ecx,(%eax)
  freep = p;
    41d9:	a3 40 64 00 00       	mov    %eax,0x6440
}
    41de:	5b                   	pop    %ebx
    41df:	5e                   	pop    %esi
    41e0:	5f                   	pop    %edi
    41e1:	5d                   	pop    %ebp
    41e2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    41e3:	03 72 04             	add    0x4(%edx),%esi
    41e6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    41e9:	8b 10                	mov    (%eax),%edx
    41eb:	8b 12                	mov    (%edx),%edx
    41ed:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    41f0:	8b 50 04             	mov    0x4(%eax),%edx
    41f3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    41f6:	39 f1                	cmp    %esi,%ecx
    41f8:	75 dd                	jne    41d7 <free+0x57>
    p->s.size += bp->s.size;
    41fa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    41fd:	a3 40 64 00 00       	mov    %eax,0x6440
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    4202:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4205:	8b 53 f8             	mov    -0x8(%ebx),%edx
    4208:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    420a:	5b                   	pop    %ebx
    420b:	5e                   	pop    %esi
    420c:	5f                   	pop    %edi
    420d:	5d                   	pop    %ebp
    420e:	c3                   	ret    
    420f:	90                   	nop

00004210 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4210:	55                   	push   %ebp
    4211:	89 e5                	mov    %esp,%ebp
    4213:	57                   	push   %edi
    4214:	56                   	push   %esi
    4215:	53                   	push   %ebx
    4216:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4219:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    421c:	8b 15 40 64 00 00    	mov    0x6440,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4222:	8d 78 07             	lea    0x7(%eax),%edi
    4225:	c1 ef 03             	shr    $0x3,%edi
    4228:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    422b:	85 d2                	test   %edx,%edx
    422d:	0f 84 a3 00 00 00    	je     42d6 <malloc+0xc6>
    4233:	8b 02                	mov    (%edx),%eax
    4235:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    4238:	39 cf                	cmp    %ecx,%edi
    423a:	76 74                	jbe    42b0 <malloc+0xa0>
    423c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    4242:	be 00 10 00 00       	mov    $0x1000,%esi
    4247:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    424e:	0f 43 f7             	cmovae %edi,%esi
    4251:	ba 00 80 00 00       	mov    $0x8000,%edx
    4256:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    425c:	0f 46 da             	cmovbe %edx,%ebx
    425f:	eb 10                	jmp    4271 <malloc+0x61>
    4261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4268:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    426a:	8b 48 04             	mov    0x4(%eax),%ecx
    426d:	39 cf                	cmp    %ecx,%edi
    426f:	76 3f                	jbe    42b0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4271:	39 05 40 64 00 00    	cmp    %eax,0x6440
    4277:	89 c2                	mov    %eax,%edx
    4279:	75 ed                	jne    4268 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    427b:	83 ec 0c             	sub    $0xc,%esp
    427e:	53                   	push   %ebx
    427f:	e8 7e fc ff ff       	call   3f02 <sbrk>
  if(p == (char*)-1)
    4284:	83 c4 10             	add    $0x10,%esp
    4287:	83 f8 ff             	cmp    $0xffffffff,%eax
    428a:	74 1c                	je     42a8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    428c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    428f:	83 ec 0c             	sub    $0xc,%esp
    4292:	83 c0 08             	add    $0x8,%eax
    4295:	50                   	push   %eax
    4296:	e8 e5 fe ff ff       	call   4180 <free>
  return freep;
    429b:	8b 15 40 64 00 00    	mov    0x6440,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    42a1:	83 c4 10             	add    $0x10,%esp
    42a4:	85 d2                	test   %edx,%edx
    42a6:	75 c0                	jne    4268 <malloc+0x58>
        return 0;
    42a8:	31 c0                	xor    %eax,%eax
    42aa:	eb 1c                	jmp    42c8 <malloc+0xb8>
    42ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    42b0:	39 cf                	cmp    %ecx,%edi
    42b2:	74 1c                	je     42d0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    42b4:	29 f9                	sub    %edi,%ecx
    42b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    42b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    42bc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    42bf:	89 15 40 64 00 00    	mov    %edx,0x6440
      return (void*)(p + 1);
    42c5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    42c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    42cb:	5b                   	pop    %ebx
    42cc:	5e                   	pop    %esi
    42cd:	5f                   	pop    %edi
    42ce:	5d                   	pop    %ebp
    42cf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    42d0:	8b 08                	mov    (%eax),%ecx
    42d2:	89 0a                	mov    %ecx,(%edx)
    42d4:	eb e9                	jmp    42bf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    42d6:	c7 05 40 64 00 00 44 	movl   $0x6444,0x6440
    42dd:	64 00 00 
    42e0:	c7 05 44 64 00 00 44 	movl   $0x6444,0x6444
    42e7:	64 00 00 
    base.s.size = 0;
    42ea:	b8 44 64 00 00       	mov    $0x6444,%eax
    42ef:	c7 05 48 64 00 00 00 	movl   $0x0,0x6448
    42f6:	00 00 00 
    42f9:	e9 3e ff ff ff       	jmp    423c <malloc+0x2c>
