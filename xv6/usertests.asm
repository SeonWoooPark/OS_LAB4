
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "iput test\n");
       6:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 fa 44 00 00       	push   $0x44fa
      13:	50                   	push   %eax
      14:	e8 1c 41 00 00       	call   4135 <printf>
      19:	83 c4 10             	add    $0x10,%esp

  if(mkdir("iputdir") < 0){
      1c:	83 ec 0c             	sub    $0xc,%esp
      1f:	68 05 45 00 00       	push   $0x4505
      24:	e8 03 40 00 00       	call   402c <mkdir>
      29:	83 c4 10             	add    $0x10,%esp
      2c:	85 c0                	test   %eax,%eax
      2e:	79 1b                	jns    4b <iputtest+0x4b>
    printf(stdout, "mkdir failed\n");
      30:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
      35:	83 ec 08             	sub    $0x8,%esp
      38:	68 0d 45 00 00       	push   $0x450d
      3d:	50                   	push   %eax
      3e:	e8 f2 40 00 00       	call   4135 <printf>
      43:	83 c4 10             	add    $0x10,%esp
    exit();
      46:	e8 79 3f 00 00       	call   3fc4 <exit>
  }
  if(chdir("iputdir") < 0){
      4b:	83 ec 0c             	sub    $0xc,%esp
      4e:	68 05 45 00 00       	push   $0x4505
      53:	e8 dc 3f 00 00       	call   4034 <chdir>
      58:	83 c4 10             	add    $0x10,%esp
      5b:	85 c0                	test   %eax,%eax
      5d:	79 1b                	jns    7a <iputtest+0x7a>
    printf(stdout, "chdir iputdir failed\n");
      5f:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
      64:	83 ec 08             	sub    $0x8,%esp
      67:	68 1b 45 00 00       	push   $0x451b
      6c:	50                   	push   %eax
      6d:	e8 c3 40 00 00       	call   4135 <printf>
      72:	83 c4 10             	add    $0x10,%esp
    exit();
      75:	e8 4a 3f 00 00       	call   3fc4 <exit>
  }
  if(unlink("../iputdir") < 0){
      7a:	83 ec 0c             	sub    $0xc,%esp
      7d:	68 31 45 00 00       	push   $0x4531
      82:	e8 8d 3f 00 00       	call   4014 <unlink>
      87:	83 c4 10             	add    $0x10,%esp
      8a:	85 c0                	test   %eax,%eax
      8c:	79 1b                	jns    a9 <iputtest+0xa9>
    printf(stdout, "unlink ../iputdir failed\n");
      8e:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
      93:	83 ec 08             	sub    $0x8,%esp
      96:	68 3c 45 00 00       	push   $0x453c
      9b:	50                   	push   %eax
      9c:	e8 94 40 00 00       	call   4135 <printf>
      a1:	83 c4 10             	add    $0x10,%esp
    exit();
      a4:	e8 1b 3f 00 00       	call   3fc4 <exit>
  }
  if(chdir("/") < 0){
      a9:	83 ec 0c             	sub    $0xc,%esp
      ac:	68 56 45 00 00       	push   $0x4556
      b1:	e8 7e 3f 00 00       	call   4034 <chdir>
      b6:	83 c4 10             	add    $0x10,%esp
      b9:	85 c0                	test   %eax,%eax
      bb:	79 1b                	jns    d8 <iputtest+0xd8>
    printf(stdout, "chdir / failed\n");
      bd:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
      c2:	83 ec 08             	sub    $0x8,%esp
      c5:	68 58 45 00 00       	push   $0x4558
      ca:	50                   	push   %eax
      cb:	e8 65 40 00 00       	call   4135 <printf>
      d0:	83 c4 10             	add    $0x10,%esp
    exit();
      d3:	e8 ec 3e 00 00       	call   3fc4 <exit>
  }
  printf(stdout, "iput test ok\n");
      d8:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
      dd:	83 ec 08             	sub    $0x8,%esp
      e0:	68 68 45 00 00       	push   $0x4568
      e5:	50                   	push   %eax
      e6:	e8 4a 40 00 00       	call   4135 <printf>
      eb:	83 c4 10             	add    $0x10,%esp
}
      ee:	90                   	nop
      ef:	c9                   	leave  
      f0:	c3                   	ret    

000000f1 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
      f1:	55                   	push   %ebp
      f2:	89 e5                	mov    %esp,%ebp
      f4:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
      f7:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
      fc:	83 ec 08             	sub    $0x8,%esp
      ff:	68 76 45 00 00       	push   $0x4576
     104:	50                   	push   %eax
     105:	e8 2b 40 00 00       	call   4135 <printf>
     10a:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     10d:	e8 aa 3e 00 00       	call   3fbc <fork>
     112:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     115:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     119:	79 1b                	jns    136 <exitiputtest+0x45>
    printf(stdout, "fork failed\n");
     11b:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     120:	83 ec 08             	sub    $0x8,%esp
     123:	68 85 45 00 00       	push   $0x4585
     128:	50                   	push   %eax
     129:	e8 07 40 00 00       	call   4135 <printf>
     12e:	83 c4 10             	add    $0x10,%esp
    exit();
     131:	e8 8e 3e 00 00       	call   3fc4 <exit>
  }
  if(pid == 0){
     136:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     13a:	0f 85 92 00 00 00    	jne    1d2 <exitiputtest+0xe1>
    if(mkdir("iputdir") < 0){
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 05 45 00 00       	push   $0x4505
     148:	e8 df 3e 00 00       	call   402c <mkdir>
     14d:	83 c4 10             	add    $0x10,%esp
     150:	85 c0                	test   %eax,%eax
     152:	79 1b                	jns    16f <exitiputtest+0x7e>
      printf(stdout, "mkdir failed\n");
     154:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     159:	83 ec 08             	sub    $0x8,%esp
     15c:	68 0d 45 00 00       	push   $0x450d
     161:	50                   	push   %eax
     162:	e8 ce 3f 00 00       	call   4135 <printf>
     167:	83 c4 10             	add    $0x10,%esp
      exit();
     16a:	e8 55 3e 00 00       	call   3fc4 <exit>
    }
    if(chdir("iputdir") < 0){
     16f:	83 ec 0c             	sub    $0xc,%esp
     172:	68 05 45 00 00       	push   $0x4505
     177:	e8 b8 3e 00 00       	call   4034 <chdir>
     17c:	83 c4 10             	add    $0x10,%esp
     17f:	85 c0                	test   %eax,%eax
     181:	79 1b                	jns    19e <exitiputtest+0xad>
      printf(stdout, "child chdir failed\n");
     183:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     188:	83 ec 08             	sub    $0x8,%esp
     18b:	68 92 45 00 00       	push   $0x4592
     190:	50                   	push   %eax
     191:	e8 9f 3f 00 00       	call   4135 <printf>
     196:	83 c4 10             	add    $0x10,%esp
      exit();
     199:	e8 26 3e 00 00       	call   3fc4 <exit>
    }
    if(unlink("../iputdir") < 0){
     19e:	83 ec 0c             	sub    $0xc,%esp
     1a1:	68 31 45 00 00       	push   $0x4531
     1a6:	e8 69 3e 00 00       	call   4014 <unlink>
     1ab:	83 c4 10             	add    $0x10,%esp
     1ae:	85 c0                	test   %eax,%eax
     1b0:	79 1b                	jns    1cd <exitiputtest+0xdc>
      printf(stdout, "unlink ../iputdir failed\n");
     1b2:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     1b7:	83 ec 08             	sub    $0x8,%esp
     1ba:	68 3c 45 00 00       	push   $0x453c
     1bf:	50                   	push   %eax
     1c0:	e8 70 3f 00 00       	call   4135 <printf>
     1c5:	83 c4 10             	add    $0x10,%esp
      exit();
     1c8:	e8 f7 3d 00 00       	call   3fc4 <exit>
    }
    exit();
     1cd:	e8 f2 3d 00 00       	call   3fc4 <exit>
  }
  wait();
     1d2:	e8 f5 3d 00 00       	call   3fcc <wait>
  printf(stdout, "exitiput test ok\n");
     1d7:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     1dc:	83 ec 08             	sub    $0x8,%esp
     1df:	68 a6 45 00 00       	push   $0x45a6
     1e4:	50                   	push   %eax
     1e5:	e8 4b 3f 00 00       	call   4135 <printf>
     1ea:	83 c4 10             	add    $0x10,%esp
}
     1ed:	90                   	nop
     1ee:	c9                   	leave  
     1ef:	c3                   	ret    

000001f0 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
     1f6:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     1fb:	83 ec 08             	sub    $0x8,%esp
     1fe:	68 b8 45 00 00       	push   $0x45b8
     203:	50                   	push   %eax
     204:	e8 2c 3f 00 00       	call   4135 <printf>
     209:	83 c4 10             	add    $0x10,%esp
  if(mkdir("oidir") < 0){
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	68 c7 45 00 00       	push   $0x45c7
     214:	e8 13 3e 00 00       	call   402c <mkdir>
     219:	83 c4 10             	add    $0x10,%esp
     21c:	85 c0                	test   %eax,%eax
     21e:	79 1b                	jns    23b <openiputtest+0x4b>
    printf(stdout, "mkdir oidir failed\n");
     220:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     225:	83 ec 08             	sub    $0x8,%esp
     228:	68 cd 45 00 00       	push   $0x45cd
     22d:	50                   	push   %eax
     22e:	e8 02 3f 00 00       	call   4135 <printf>
     233:	83 c4 10             	add    $0x10,%esp
    exit();
     236:	e8 89 3d 00 00       	call   3fc4 <exit>
  }
  pid = fork();
     23b:	e8 7c 3d 00 00       	call   3fbc <fork>
     240:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     243:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     247:	79 1b                	jns    264 <openiputtest+0x74>
    printf(stdout, "fork failed\n");
     249:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     24e:	83 ec 08             	sub    $0x8,%esp
     251:	68 85 45 00 00       	push   $0x4585
     256:	50                   	push   %eax
     257:	e8 d9 3e 00 00       	call   4135 <printf>
     25c:	83 c4 10             	add    $0x10,%esp
    exit();
     25f:	e8 60 3d 00 00       	call   3fc4 <exit>
  }
  if(pid == 0){
     264:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     268:	75 3b                	jne    2a5 <openiputtest+0xb5>
    int fd = open("oidir", O_RDWR);
     26a:	83 ec 08             	sub    $0x8,%esp
     26d:	6a 02                	push   $0x2
     26f:	68 c7 45 00 00       	push   $0x45c7
     274:	e8 8b 3d 00 00       	call   4004 <open>
     279:	83 c4 10             	add    $0x10,%esp
     27c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0){
     27f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     283:	78 1b                	js     2a0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     285:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     28a:	83 ec 08             	sub    $0x8,%esp
     28d:	68 e4 45 00 00       	push   $0x45e4
     292:	50                   	push   %eax
     293:	e8 9d 3e 00 00       	call   4135 <printf>
     298:	83 c4 10             	add    $0x10,%esp
      exit();
     29b:	e8 24 3d 00 00       	call   3fc4 <exit>
    }
    exit();
     2a0:	e8 1f 3d 00 00       	call   3fc4 <exit>
  }
  sleep(1);
     2a5:	83 ec 0c             	sub    $0xc,%esp
     2a8:	6a 01                	push   $0x1
     2aa:	e8 a5 3d 00 00       	call   4054 <sleep>
     2af:	83 c4 10             	add    $0x10,%esp
  if(unlink("oidir") != 0){
     2b2:	83 ec 0c             	sub    $0xc,%esp
     2b5:	68 c7 45 00 00       	push   $0x45c7
     2ba:	e8 55 3d 00 00       	call   4014 <unlink>
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	85 c0                	test   %eax,%eax
     2c4:	74 1b                	je     2e1 <openiputtest+0xf1>
    printf(stdout, "unlink failed\n");
     2c6:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     2cb:	83 ec 08             	sub    $0x8,%esp
     2ce:	68 08 46 00 00       	push   $0x4608
     2d3:	50                   	push   %eax
     2d4:	e8 5c 3e 00 00       	call   4135 <printf>
     2d9:	83 c4 10             	add    $0x10,%esp
    exit();
     2dc:	e8 e3 3c 00 00       	call   3fc4 <exit>
  }
  wait();
     2e1:	e8 e6 3c 00 00       	call   3fcc <wait>
  printf(stdout, "openiput test ok\n");
     2e6:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     2eb:	83 ec 08             	sub    $0x8,%esp
     2ee:	68 17 46 00 00       	push   $0x4617
     2f3:	50                   	push   %eax
     2f4:	e8 3c 3e 00 00       	call   4135 <printf>
     2f9:	83 c4 10             	add    $0x10,%esp
}
     2fc:	90                   	nop
     2fd:	c9                   	leave  
     2fe:	c3                   	ret    

000002ff <opentest>:

// simple file system tests

void
opentest(void)
{
     2ff:	55                   	push   %ebp
     300:	89 e5                	mov    %esp,%ebp
     302:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
     305:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     30a:	83 ec 08             	sub    $0x8,%esp
     30d:	68 29 46 00 00       	push   $0x4629
     312:	50                   	push   %eax
     313:	e8 1d 3e 00 00       	call   4135 <printf>
     318:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
     31b:	83 ec 08             	sub    $0x8,%esp
     31e:	6a 00                	push   $0x0
     320:	68 e4 44 00 00       	push   $0x44e4
     325:	e8 da 3c 00 00       	call   4004 <open>
     32a:	83 c4 10             	add    $0x10,%esp
     32d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
     330:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     334:	79 1b                	jns    351 <opentest+0x52>
    printf(stdout, "open echo failed!\n");
     336:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     33b:	83 ec 08             	sub    $0x8,%esp
     33e:	68 34 46 00 00       	push   $0x4634
     343:	50                   	push   %eax
     344:	e8 ec 3d 00 00       	call   4135 <printf>
     349:	83 c4 10             	add    $0x10,%esp
    exit();
     34c:	e8 73 3c 00 00       	call   3fc4 <exit>
  }
  close(fd);
     351:	83 ec 0c             	sub    $0xc,%esp
     354:	ff 75 f4             	pushl  -0xc(%ebp)
     357:	e8 90 3c 00 00       	call   3fec <close>
     35c:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
     35f:	83 ec 08             	sub    $0x8,%esp
     362:	6a 00                	push   $0x0
     364:	68 47 46 00 00       	push   $0x4647
     369:	e8 96 3c 00 00       	call   4004 <open>
     36e:	83 c4 10             	add    $0x10,%esp
     371:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
     374:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     378:	78 1b                	js     395 <opentest+0x96>
    printf(stdout, "open doesnotexist succeeded!\n");
     37a:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     37f:	83 ec 08             	sub    $0x8,%esp
     382:	68 54 46 00 00       	push   $0x4654
     387:	50                   	push   %eax
     388:	e8 a8 3d 00 00       	call   4135 <printf>
     38d:	83 c4 10             	add    $0x10,%esp
    exit();
     390:	e8 2f 3c 00 00       	call   3fc4 <exit>
  }
  printf(stdout, "open test ok\n");
     395:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     39a:	83 ec 08             	sub    $0x8,%esp
     39d:	68 72 46 00 00       	push   $0x4672
     3a2:	50                   	push   %eax
     3a3:	e8 8d 3d 00 00       	call   4135 <printf>
     3a8:	83 c4 10             	add    $0x10,%esp
}
     3ab:	90                   	nop
     3ac:	c9                   	leave  
     3ad:	c3                   	ret    

000003ae <writetest>:

void
writetest(void)
{
     3ae:	55                   	push   %ebp
     3af:	89 e5                	mov    %esp,%ebp
     3b1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     3b4:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     3b9:	83 ec 08             	sub    $0x8,%esp
     3bc:	68 80 46 00 00       	push   $0x4680
     3c1:	50                   	push   %eax
     3c2:	e8 6e 3d 00 00       	call   4135 <printf>
     3c7:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
     3ca:	83 ec 08             	sub    $0x8,%esp
     3cd:	68 02 02 00 00       	push   $0x202
     3d2:	68 91 46 00 00       	push   $0x4691
     3d7:	e8 28 3c 00 00       	call   4004 <open>
     3dc:	83 c4 10             	add    $0x10,%esp
     3df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     3e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3e6:	78 22                	js     40a <writetest+0x5c>
    printf(stdout, "creat small succeeded; ok\n");
     3e8:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     3ed:	83 ec 08             	sub    $0x8,%esp
     3f0:	68 97 46 00 00       	push   $0x4697
     3f5:	50                   	push   %eax
     3f6:	e8 3a 3d 00 00       	call   4135 <printf>
     3fb:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     3fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     405:	e9 8e 00 00 00       	jmp    498 <writetest+0xea>
    printf(stdout, "error: creat small failed!\n");
     40a:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     40f:	83 ec 08             	sub    $0x8,%esp
     412:	68 b2 46 00 00       	push   $0x46b2
     417:	50                   	push   %eax
     418:	e8 18 3d 00 00       	call   4135 <printf>
     41d:	83 c4 10             	add    $0x10,%esp
    exit();
     420:	e8 9f 3b 00 00       	call   3fc4 <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     425:	83 ec 04             	sub    $0x4,%esp
     428:	6a 0a                	push   $0xa
     42a:	68 ce 46 00 00       	push   $0x46ce
     42f:	ff 75 f0             	pushl  -0x10(%ebp)
     432:	e8 ad 3b 00 00       	call   3fe4 <write>
     437:	83 c4 10             	add    $0x10,%esp
     43a:	83 f8 0a             	cmp    $0xa,%eax
     43d:	74 1e                	je     45d <writetest+0xaf>
      printf(stdout, "error: write aa %d new file failed\n", i);
     43f:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     444:	83 ec 04             	sub    $0x4,%esp
     447:	ff 75 f4             	pushl  -0xc(%ebp)
     44a:	68 dc 46 00 00       	push   $0x46dc
     44f:	50                   	push   %eax
     450:	e8 e0 3c 00 00       	call   4135 <printf>
     455:	83 c4 10             	add    $0x10,%esp
      exit();
     458:	e8 67 3b 00 00       	call   3fc4 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     45d:	83 ec 04             	sub    $0x4,%esp
     460:	6a 0a                	push   $0xa
     462:	68 00 47 00 00       	push   $0x4700
     467:	ff 75 f0             	pushl  -0x10(%ebp)
     46a:	e8 75 3b 00 00       	call   3fe4 <write>
     46f:	83 c4 10             	add    $0x10,%esp
     472:	83 f8 0a             	cmp    $0xa,%eax
     475:	74 1e                	je     495 <writetest+0xe7>
      printf(stdout, "error: write bb %d new file failed\n", i);
     477:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     47c:	83 ec 04             	sub    $0x4,%esp
     47f:	ff 75 f4             	pushl  -0xc(%ebp)
     482:	68 0c 47 00 00       	push   $0x470c
     487:	50                   	push   %eax
     488:	e8 a8 3c 00 00       	call   4135 <printf>
     48d:	83 c4 10             	add    $0x10,%esp
      exit();
     490:	e8 2f 3b 00 00       	call   3fc4 <exit>
  for(i = 0; i < 100; i++){
     495:	ff 45 f4             	incl   -0xc(%ebp)
     498:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     49c:	7e 87                	jle    425 <writetest+0x77>
    }
  }
  printf(stdout, "writes ok\n");
     49e:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     4a3:	83 ec 08             	sub    $0x8,%esp
     4a6:	68 30 47 00 00       	push   $0x4730
     4ab:	50                   	push   %eax
     4ac:	e8 84 3c 00 00       	call   4135 <printf>
     4b1:	83 c4 10             	add    $0x10,%esp
  close(fd);
     4b4:	83 ec 0c             	sub    $0xc,%esp
     4b7:	ff 75 f0             	pushl  -0x10(%ebp)
     4ba:	e8 2d 3b 00 00       	call   3fec <close>
     4bf:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     4c2:	83 ec 08             	sub    $0x8,%esp
     4c5:	6a 00                	push   $0x0
     4c7:	68 91 46 00 00       	push   $0x4691
     4cc:	e8 33 3b 00 00       	call   4004 <open>
     4d1:	83 c4 10             	add    $0x10,%esp
     4d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     4d7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4db:	78 3c                	js     519 <writetest+0x16b>
    printf(stdout, "open small succeeded ok\n");
     4dd:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     4e2:	83 ec 08             	sub    $0x8,%esp
     4e5:	68 3b 47 00 00       	push   $0x473b
     4ea:	50                   	push   %eax
     4eb:	e8 45 3c 00 00       	call   4135 <printf>
     4f0:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     4f3:	83 ec 04             	sub    $0x4,%esp
     4f6:	68 d0 07 00 00       	push   $0x7d0
     4fb:	68 60 5d 00 00       	push   $0x5d60
     500:	ff 75 f0             	pushl  -0x10(%ebp)
     503:	e8 d4 3a 00 00       	call   3fdc <read>
     508:	83 c4 10             	add    $0x10,%esp
     50b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     50e:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     515:	75 57                	jne    56e <writetest+0x1c0>
     517:	eb 1b                	jmp    534 <writetest+0x186>
    printf(stdout, "error: open small failed!\n");
     519:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     51e:	83 ec 08             	sub    $0x8,%esp
     521:	68 54 47 00 00       	push   $0x4754
     526:	50                   	push   %eax
     527:	e8 09 3c 00 00       	call   4135 <printf>
     52c:	83 c4 10             	add    $0x10,%esp
    exit();
     52f:	e8 90 3a 00 00       	call   3fc4 <exit>
    printf(stdout, "read succeeded ok\n");
     534:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     539:	83 ec 08             	sub    $0x8,%esp
     53c:	68 6f 47 00 00       	push   $0x476f
     541:	50                   	push   %eax
     542:	e8 ee 3b 00 00       	call   4135 <printf>
     547:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     54a:	83 ec 0c             	sub    $0xc,%esp
     54d:	ff 75 f0             	pushl  -0x10(%ebp)
     550:	e8 97 3a 00 00       	call   3fec <close>
     555:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     558:	83 ec 0c             	sub    $0xc,%esp
     55b:	68 91 46 00 00       	push   $0x4691
     560:	e8 af 3a 00 00       	call   4014 <unlink>
     565:	83 c4 10             	add    $0x10,%esp
     568:	85 c0                	test   %eax,%eax
     56a:	79 38                	jns    5a4 <writetest+0x1f6>
     56c:	eb 1b                	jmp    589 <writetest+0x1db>
    printf(stdout, "read failed\n");
     56e:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     573:	83 ec 08             	sub    $0x8,%esp
     576:	68 82 47 00 00       	push   $0x4782
     57b:	50                   	push   %eax
     57c:	e8 b4 3b 00 00       	call   4135 <printf>
     581:	83 c4 10             	add    $0x10,%esp
    exit();
     584:	e8 3b 3a 00 00       	call   3fc4 <exit>
    printf(stdout, "unlink small failed\n");
     589:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     58e:	83 ec 08             	sub    $0x8,%esp
     591:	68 8f 47 00 00       	push   $0x478f
     596:	50                   	push   %eax
     597:	e8 99 3b 00 00       	call   4135 <printf>
     59c:	83 c4 10             	add    $0x10,%esp
    exit();
     59f:	e8 20 3a 00 00       	call   3fc4 <exit>
  }
  printf(stdout, "small file test ok\n");
     5a4:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     5a9:	83 ec 08             	sub    $0x8,%esp
     5ac:	68 a4 47 00 00       	push   $0x47a4
     5b1:	50                   	push   %eax
     5b2:	e8 7e 3b 00 00       	call   4135 <printf>
     5b7:	83 c4 10             	add    $0x10,%esp
}
     5ba:	90                   	nop
     5bb:	c9                   	leave  
     5bc:	c3                   	ret    

000005bd <writetest1>:

void
writetest1(void)
{
     5bd:	55                   	push   %ebp
     5be:	89 e5                	mov    %esp,%ebp
     5c0:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     5c3:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     5c8:	83 ec 08             	sub    $0x8,%esp
     5cb:	68 b8 47 00 00       	push   $0x47b8
     5d0:	50                   	push   %eax
     5d1:	e8 5f 3b 00 00       	call   4135 <printf>
     5d6:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     5d9:	83 ec 08             	sub    $0x8,%esp
     5dc:	68 02 02 00 00       	push   $0x202
     5e1:	68 c8 47 00 00       	push   $0x47c8
     5e6:	e8 19 3a 00 00       	call   4004 <open>
     5eb:	83 c4 10             	add    $0x10,%esp
     5ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     5f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5f5:	79 1b                	jns    612 <writetest1+0x55>
    printf(stdout, "error: creat big failed!\n");
     5f7:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     5fc:	83 ec 08             	sub    $0x8,%esp
     5ff:	68 cc 47 00 00       	push   $0x47cc
     604:	50                   	push   %eax
     605:	e8 2b 3b 00 00       	call   4135 <printf>
     60a:	83 c4 10             	add    $0x10,%esp
    exit();
     60d:	e8 b2 39 00 00       	call   3fc4 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     612:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     619:	eb 4a                	jmp    665 <writetest1+0xa8>
    ((int*)buf)[0] = i;
     61b:	ba 60 5d 00 00       	mov    $0x5d60,%edx
     620:	8b 45 f4             	mov    -0xc(%ebp),%eax
     623:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
     625:	83 ec 04             	sub    $0x4,%esp
     628:	68 00 02 00 00       	push   $0x200
     62d:	68 60 5d 00 00       	push   $0x5d60
     632:	ff 75 ec             	pushl  -0x14(%ebp)
     635:	e8 aa 39 00 00       	call   3fe4 <write>
     63a:	83 c4 10             	add    $0x10,%esp
     63d:	3d 00 02 00 00       	cmp    $0x200,%eax
     642:	74 1e                	je     662 <writetest1+0xa5>
      printf(stdout, "error: write big file failed\n", i);
     644:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     649:	83 ec 04             	sub    $0x4,%esp
     64c:	ff 75 f4             	pushl  -0xc(%ebp)
     64f:	68 e6 47 00 00       	push   $0x47e6
     654:	50                   	push   %eax
     655:	e8 db 3a 00 00       	call   4135 <printf>
     65a:	83 c4 10             	add    $0x10,%esp
      exit();
     65d:	e8 62 39 00 00       	call   3fc4 <exit>
  for(i = 0; i < MAXFILE; i++){
     662:	ff 45 f4             	incl   -0xc(%ebp)
     665:	8b 45 f4             	mov    -0xc(%ebp),%eax
     668:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     66d:	76 ac                	jbe    61b <writetest1+0x5e>
    }
  }

  close(fd);
     66f:	83 ec 0c             	sub    $0xc,%esp
     672:	ff 75 ec             	pushl  -0x14(%ebp)
     675:	e8 72 39 00 00       	call   3fec <close>
     67a:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     67d:	83 ec 08             	sub    $0x8,%esp
     680:	6a 00                	push   $0x0
     682:	68 c8 47 00 00       	push   $0x47c8
     687:	e8 78 39 00 00       	call   4004 <open>
     68c:	83 c4 10             	add    $0x10,%esp
     68f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     692:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     696:	79 1b                	jns    6b3 <writetest1+0xf6>
    printf(stdout, "error: open big failed!\n");
     698:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     69d:	83 ec 08             	sub    $0x8,%esp
     6a0:	68 04 48 00 00       	push   $0x4804
     6a5:	50                   	push   %eax
     6a6:	e8 8a 3a 00 00       	call   4135 <printf>
     6ab:	83 c4 10             	add    $0x10,%esp
    exit();
     6ae:	e8 11 39 00 00       	call   3fc4 <exit>
  }

  n = 0;
     6b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     6ba:	83 ec 04             	sub    $0x4,%esp
     6bd:	68 00 02 00 00       	push   $0x200
     6c2:	68 60 5d 00 00       	push   $0x5d60
     6c7:	ff 75 ec             	pushl  -0x14(%ebp)
     6ca:	e8 0d 39 00 00       	call   3fdc <read>
     6cf:	83 c4 10             	add    $0x10,%esp
     6d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     6d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6d9:	75 27                	jne    702 <writetest1+0x145>
      if(n == MAXFILE - 1){
     6db:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     6e2:	75 7c                	jne    760 <writetest1+0x1a3>
        printf(stdout, "read only %d blocks from big", n);
     6e4:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     6e9:	83 ec 04             	sub    $0x4,%esp
     6ec:	ff 75 f0             	pushl  -0x10(%ebp)
     6ef:	68 1d 48 00 00       	push   $0x481d
     6f4:	50                   	push   %eax
     6f5:	e8 3b 3a 00 00       	call   4135 <printf>
     6fa:	83 c4 10             	add    $0x10,%esp
        exit();
     6fd:	e8 c2 38 00 00       	call   3fc4 <exit>
      }
      break;
    } else if(i != 512){
     702:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     709:	74 1e                	je     729 <writetest1+0x16c>
      printf(stdout, "read failed %d\n", i);
     70b:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     710:	83 ec 04             	sub    $0x4,%esp
     713:	ff 75 f4             	pushl  -0xc(%ebp)
     716:	68 3a 48 00 00       	push   $0x483a
     71b:	50                   	push   %eax
     71c:	e8 14 3a 00 00       	call   4135 <printf>
     721:	83 c4 10             	add    $0x10,%esp
      exit();
     724:	e8 9b 38 00 00       	call   3fc4 <exit>
    }
    if(((int*)buf)[0] != n){
     729:	b8 60 5d 00 00       	mov    $0x5d60,%eax
     72e:	8b 00                	mov    (%eax),%eax
     730:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     733:	74 23                	je     758 <writetest1+0x19b>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     735:	b8 60 5d 00 00       	mov    $0x5d60,%eax
      printf(stdout, "read content of block %d is %d\n",
     73a:	8b 10                	mov    (%eax),%edx
     73c:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     741:	52                   	push   %edx
     742:	ff 75 f0             	pushl  -0x10(%ebp)
     745:	68 4c 48 00 00       	push   $0x484c
     74a:	50                   	push   %eax
     74b:	e8 e5 39 00 00       	call   4135 <printf>
     750:	83 c4 10             	add    $0x10,%esp
      exit();
     753:	e8 6c 38 00 00       	call   3fc4 <exit>
    }
    n++;
     758:	ff 45 f0             	incl   -0x10(%ebp)
    i = read(fd, buf, 512);
     75b:	e9 5a ff ff ff       	jmp    6ba <writetest1+0xfd>
      break;
     760:	90                   	nop
  }
  close(fd);
     761:	83 ec 0c             	sub    $0xc,%esp
     764:	ff 75 ec             	pushl  -0x14(%ebp)
     767:	e8 80 38 00 00       	call   3fec <close>
     76c:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     76f:	83 ec 0c             	sub    $0xc,%esp
     772:	68 c8 47 00 00       	push   $0x47c8
     777:	e8 98 38 00 00       	call   4014 <unlink>
     77c:	83 c4 10             	add    $0x10,%esp
     77f:	85 c0                	test   %eax,%eax
     781:	79 1b                	jns    79e <writetest1+0x1e1>
    printf(stdout, "unlink big failed\n");
     783:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     788:	83 ec 08             	sub    $0x8,%esp
     78b:	68 6c 48 00 00       	push   $0x486c
     790:	50                   	push   %eax
     791:	e8 9f 39 00 00       	call   4135 <printf>
     796:	83 c4 10             	add    $0x10,%esp
    exit();
     799:	e8 26 38 00 00       	call   3fc4 <exit>
  }
  printf(stdout, "big files ok\n");
     79e:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     7a3:	83 ec 08             	sub    $0x8,%esp
     7a6:	68 7f 48 00 00       	push   $0x487f
     7ab:	50                   	push   %eax
     7ac:	e8 84 39 00 00       	call   4135 <printf>
     7b1:	83 c4 10             	add    $0x10,%esp
}
     7b4:	90                   	nop
     7b5:	c9                   	leave  
     7b6:	c3                   	ret    

000007b7 <createtest>:

void
createtest(void)
{
     7b7:	55                   	push   %ebp
     7b8:	89 e5                	mov    %esp,%ebp
     7ba:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     7bd:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     7c2:	83 ec 08             	sub    $0x8,%esp
     7c5:	68 90 48 00 00       	push   $0x4890
     7ca:	50                   	push   %eax
     7cb:	e8 65 39 00 00       	call   4135 <printf>
     7d0:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     7d3:	c6 05 60 7d 00 00 61 	movb   $0x61,0x7d60
  name[2] = '\0';
     7da:	c6 05 62 7d 00 00 00 	movb   $0x0,0x7d62
  for(i = 0; i < 52; i++){
     7e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     7e8:	eb 34                	jmp    81e <createtest+0x67>
    name[1] = '0' + i;
     7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ed:	83 c0 30             	add    $0x30,%eax
     7f0:	a2 61 7d 00 00       	mov    %al,0x7d61
    fd = open(name, O_CREATE|O_RDWR);
     7f5:	83 ec 08             	sub    $0x8,%esp
     7f8:	68 02 02 00 00       	push   $0x202
     7fd:	68 60 7d 00 00       	push   $0x7d60
     802:	e8 fd 37 00 00       	call   4004 <open>
     807:	83 c4 10             	add    $0x10,%esp
     80a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     80d:	83 ec 0c             	sub    $0xc,%esp
     810:	ff 75 f0             	pushl  -0x10(%ebp)
     813:	e8 d4 37 00 00       	call   3fec <close>
     818:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     81b:	ff 45 f4             	incl   -0xc(%ebp)
     81e:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     822:	7e c6                	jle    7ea <createtest+0x33>
  }
  name[0] = 'a';
     824:	c6 05 60 7d 00 00 61 	movb   $0x61,0x7d60
  name[2] = '\0';
     82b:	c6 05 62 7d 00 00 00 	movb   $0x0,0x7d62
  for(i = 0; i < 52; i++){
     832:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     839:	eb 1e                	jmp    859 <createtest+0xa2>
    name[1] = '0' + i;
     83b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83e:	83 c0 30             	add    $0x30,%eax
     841:	a2 61 7d 00 00       	mov    %al,0x7d61
    unlink(name);
     846:	83 ec 0c             	sub    $0xc,%esp
     849:	68 60 7d 00 00       	push   $0x7d60
     84e:	e8 c1 37 00 00       	call   4014 <unlink>
     853:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     856:	ff 45 f4             	incl   -0xc(%ebp)
     859:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     85d:	7e dc                	jle    83b <createtest+0x84>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     85f:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     864:	83 ec 08             	sub    $0x8,%esp
     867:	68 b8 48 00 00       	push   $0x48b8
     86c:	50                   	push   %eax
     86d:	e8 c3 38 00 00       	call   4135 <printf>
     872:	83 c4 10             	add    $0x10,%esp
}
     875:	90                   	nop
     876:	c9                   	leave  
     877:	c3                   	ret    

00000878 <dirtest>:

void dirtest(void)
{
     878:	55                   	push   %ebp
     879:	89 e5                	mov    %esp,%ebp
     87b:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     87e:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     883:	83 ec 08             	sub    $0x8,%esp
     886:	68 de 48 00 00       	push   $0x48de
     88b:	50                   	push   %eax
     88c:	e8 a4 38 00 00       	call   4135 <printf>
     891:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     894:	83 ec 0c             	sub    $0xc,%esp
     897:	68 ea 48 00 00       	push   $0x48ea
     89c:	e8 8b 37 00 00       	call   402c <mkdir>
     8a1:	83 c4 10             	add    $0x10,%esp
     8a4:	85 c0                	test   %eax,%eax
     8a6:	79 1b                	jns    8c3 <dirtest+0x4b>
    printf(stdout, "mkdir failed\n");
     8a8:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     8ad:	83 ec 08             	sub    $0x8,%esp
     8b0:	68 0d 45 00 00       	push   $0x450d
     8b5:	50                   	push   %eax
     8b6:	e8 7a 38 00 00       	call   4135 <printf>
     8bb:	83 c4 10             	add    $0x10,%esp
    exit();
     8be:	e8 01 37 00 00       	call   3fc4 <exit>
  }

  if(chdir("dir0") < 0){
     8c3:	83 ec 0c             	sub    $0xc,%esp
     8c6:	68 ea 48 00 00       	push   $0x48ea
     8cb:	e8 64 37 00 00       	call   4034 <chdir>
     8d0:	83 c4 10             	add    $0x10,%esp
     8d3:	85 c0                	test   %eax,%eax
     8d5:	79 1b                	jns    8f2 <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
     8d7:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     8dc:	83 ec 08             	sub    $0x8,%esp
     8df:	68 ef 48 00 00       	push   $0x48ef
     8e4:	50                   	push   %eax
     8e5:	e8 4b 38 00 00       	call   4135 <printf>
     8ea:	83 c4 10             	add    $0x10,%esp
    exit();
     8ed:	e8 d2 36 00 00       	call   3fc4 <exit>
  }

  if(chdir("..") < 0){
     8f2:	83 ec 0c             	sub    $0xc,%esp
     8f5:	68 02 49 00 00       	push   $0x4902
     8fa:	e8 35 37 00 00       	call   4034 <chdir>
     8ff:	83 c4 10             	add    $0x10,%esp
     902:	85 c0                	test   %eax,%eax
     904:	79 1b                	jns    921 <dirtest+0xa9>
    printf(stdout, "chdir .. failed\n");
     906:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     90b:	83 ec 08             	sub    $0x8,%esp
     90e:	68 05 49 00 00       	push   $0x4905
     913:	50                   	push   %eax
     914:	e8 1c 38 00 00       	call   4135 <printf>
     919:	83 c4 10             	add    $0x10,%esp
    exit();
     91c:	e8 a3 36 00 00       	call   3fc4 <exit>
  }

  if(unlink("dir0") < 0){
     921:	83 ec 0c             	sub    $0xc,%esp
     924:	68 ea 48 00 00       	push   $0x48ea
     929:	e8 e6 36 00 00       	call   4014 <unlink>
     92e:	83 c4 10             	add    $0x10,%esp
     931:	85 c0                	test   %eax,%eax
     933:	79 1b                	jns    950 <dirtest+0xd8>
    printf(stdout, "unlink dir0 failed\n");
     935:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     93a:	83 ec 08             	sub    $0x8,%esp
     93d:	68 16 49 00 00       	push   $0x4916
     942:	50                   	push   %eax
     943:	e8 ed 37 00 00       	call   4135 <printf>
     948:	83 c4 10             	add    $0x10,%esp
    exit();
     94b:	e8 74 36 00 00       	call   3fc4 <exit>
  }
  printf(stdout, "mkdir test ok\n");
     950:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     955:	83 ec 08             	sub    $0x8,%esp
     958:	68 2a 49 00 00       	push   $0x492a
     95d:	50                   	push   %eax
     95e:	e8 d2 37 00 00       	call   4135 <printf>
     963:	83 c4 10             	add    $0x10,%esp
}
     966:	90                   	nop
     967:	c9                   	leave  
     968:	c3                   	ret    

00000969 <exectest>:

void
exectest(void)
{
     969:	55                   	push   %ebp
     96a:	89 e5                	mov    %esp,%ebp
     96c:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     96f:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     974:	83 ec 08             	sub    $0x8,%esp
     977:	68 39 49 00 00       	push   $0x4939
     97c:	50                   	push   %eax
     97d:	e8 b3 37 00 00       	call   4135 <printf>
     982:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     985:	83 ec 08             	sub    $0x8,%esp
     988:	68 28 5d 00 00       	push   $0x5d28
     98d:	68 e4 44 00 00       	push   $0x44e4
     992:	e8 65 36 00 00       	call   3ffc <exec>
     997:	83 c4 10             	add    $0x10,%esp
     99a:	85 c0                	test   %eax,%eax
     99c:	79 1b                	jns    9b9 <exectest+0x50>
    printf(stdout, "exec echo failed\n");
     99e:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
     9a3:	83 ec 08             	sub    $0x8,%esp
     9a6:	68 44 49 00 00       	push   $0x4944
     9ab:	50                   	push   %eax
     9ac:	e8 84 37 00 00       	call   4135 <printf>
     9b1:	83 c4 10             	add    $0x10,%esp
    exit();
     9b4:	e8 0b 36 00 00       	call   3fc4 <exit>
  }
}
     9b9:	90                   	nop
     9ba:	c9                   	leave  
     9bb:	c3                   	ret    

000009bc <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     9bc:	55                   	push   %ebp
     9bd:	89 e5                	mov    %esp,%ebp
     9bf:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     9c2:	83 ec 0c             	sub    $0xc,%esp
     9c5:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9c8:	50                   	push   %eax
     9c9:	e8 06 36 00 00       	call   3fd4 <pipe>
     9ce:	83 c4 10             	add    $0x10,%esp
     9d1:	85 c0                	test   %eax,%eax
     9d3:	74 17                	je     9ec <pipe1+0x30>
    printf(1, "pipe() failed\n");
     9d5:	83 ec 08             	sub    $0x8,%esp
     9d8:	68 56 49 00 00       	push   $0x4956
     9dd:	6a 01                	push   $0x1
     9df:	e8 51 37 00 00       	call   4135 <printf>
     9e4:	83 c4 10             	add    $0x10,%esp
    exit();
     9e7:	e8 d8 35 00 00       	call   3fc4 <exit>
  }
  pid = fork();
     9ec:	e8 cb 35 00 00       	call   3fbc <fork>
     9f1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     9f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     9fb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     9ff:	0f 85 87 00 00 00    	jne    a8c <pipe1+0xd0>
    close(fds[0]);
     a05:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a08:	83 ec 0c             	sub    $0xc,%esp
     a0b:	50                   	push   %eax
     a0c:	e8 db 35 00 00       	call   3fec <close>
     a11:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     a14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     a1b:	eb 64                	jmp    a81 <pipe1+0xc5>
      for(i = 0; i < 1033; i++)
     a1d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a24:	eb 18                	jmp    a3e <pipe1+0x82>
        buf[i] = seq++;
     a26:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a29:	8d 50 01             	lea    0x1(%eax),%edx
     a2c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     a2f:	88 c2                	mov    %al,%dl
     a31:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a34:	05 60 5d 00 00       	add    $0x5d60,%eax
     a39:	88 10                	mov    %dl,(%eax)
      for(i = 0; i < 1033; i++)
     a3b:	ff 45 f0             	incl   -0x10(%ebp)
     a3e:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     a45:	7e df                	jle    a26 <pipe1+0x6a>
      if(write(fds[1], buf, 1033) != 1033){
     a47:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a4a:	83 ec 04             	sub    $0x4,%esp
     a4d:	68 09 04 00 00       	push   $0x409
     a52:	68 60 5d 00 00       	push   $0x5d60
     a57:	50                   	push   %eax
     a58:	e8 87 35 00 00       	call   3fe4 <write>
     a5d:	83 c4 10             	add    $0x10,%esp
     a60:	3d 09 04 00 00       	cmp    $0x409,%eax
     a65:	74 17                	je     a7e <pipe1+0xc2>
        printf(1, "pipe1 oops 1\n");
     a67:	83 ec 08             	sub    $0x8,%esp
     a6a:	68 65 49 00 00       	push   $0x4965
     a6f:	6a 01                	push   $0x1
     a71:	e8 bf 36 00 00       	call   4135 <printf>
     a76:	83 c4 10             	add    $0x10,%esp
        exit();
     a79:	e8 46 35 00 00       	call   3fc4 <exit>
    for(n = 0; n < 5; n++){
     a7e:	ff 45 ec             	incl   -0x14(%ebp)
     a81:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     a85:	7e 96                	jle    a1d <pipe1+0x61>
      }
    }
    exit();
     a87:	e8 38 35 00 00       	call   3fc4 <exit>
  } else if(pid > 0){
     a8c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     a90:	0f 8e f7 00 00 00    	jle    b8d <pipe1+0x1d1>
    close(fds[1]);
     a96:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a99:	83 ec 0c             	sub    $0xc,%esp
     a9c:	50                   	push   %eax
     a9d:	e8 4a 35 00 00       	call   3fec <close>
     aa2:	83 c4 10             	add    $0x10,%esp
    total = 0;
     aa5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     aac:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     ab3:	eb 69                	jmp    b1e <pipe1+0x162>
      for(i = 0; i < n; i++){
     ab5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     abc:	eb 39                	jmp    af7 <pipe1+0x13b>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     abe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac1:	05 60 5d 00 00       	add    $0x5d60,%eax
     ac6:	8a 00                	mov    (%eax),%al
     ac8:	0f be c8             	movsbl %al,%ecx
     acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ace:	8d 50 01             	lea    0x1(%eax),%edx
     ad1:	89 55 f4             	mov    %edx,-0xc(%ebp)
     ad4:	31 c8                	xor    %ecx,%eax
     ad6:	0f b6 c0             	movzbl %al,%eax
     ad9:	85 c0                	test   %eax,%eax
     adb:	74 17                	je     af4 <pipe1+0x138>
          printf(1, "pipe1 oops 2\n");
     add:	83 ec 08             	sub    $0x8,%esp
     ae0:	68 73 49 00 00       	push   $0x4973
     ae5:	6a 01                	push   $0x1
     ae7:	e8 49 36 00 00       	call   4135 <printf>
     aec:	83 c4 10             	add    $0x10,%esp
     aef:	e9 b0 00 00 00       	jmp    ba4 <pipe1+0x1e8>
      for(i = 0; i < n; i++){
     af4:	ff 45 f0             	incl   -0x10(%ebp)
     af7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     afa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     afd:	7c bf                	jl     abe <pipe1+0x102>
          return;
        }
      }
      total += n;
     aff:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b02:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     b05:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b08:	01 c0                	add    %eax,%eax
     b0a:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc > sizeof(buf))
     b0d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b10:	3d 00 20 00 00       	cmp    $0x2000,%eax
     b15:	76 07                	jbe    b1e <pipe1+0x162>
        cc = sizeof(buf);
     b17:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     b1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b21:	83 ec 04             	sub    $0x4,%esp
     b24:	ff 75 e8             	pushl  -0x18(%ebp)
     b27:	68 60 5d 00 00       	push   $0x5d60
     b2c:	50                   	push   %eax
     b2d:	e8 aa 34 00 00       	call   3fdc <read>
     b32:	83 c4 10             	add    $0x10,%esp
     b35:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b38:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b3c:	0f 8f 73 ff ff ff    	jg     ab5 <pipe1+0xf9>
    }
    if(total != 5 * 1033){
     b42:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     b49:	74 1a                	je     b65 <pipe1+0x1a9>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b4b:	83 ec 04             	sub    $0x4,%esp
     b4e:	ff 75 e4             	pushl  -0x1c(%ebp)
     b51:	68 81 49 00 00       	push   $0x4981
     b56:	6a 01                	push   $0x1
     b58:	e8 d8 35 00 00       	call   4135 <printf>
     b5d:	83 c4 10             	add    $0x10,%esp
      exit();
     b60:	e8 5f 34 00 00       	call   3fc4 <exit>
    }
    close(fds[0]);
     b65:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b68:	83 ec 0c             	sub    $0xc,%esp
     b6b:	50                   	push   %eax
     b6c:	e8 7b 34 00 00       	call   3fec <close>
     b71:	83 c4 10             	add    $0x10,%esp
    wait();
     b74:	e8 53 34 00 00       	call   3fcc <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     b79:	83 ec 08             	sub    $0x8,%esp
     b7c:	68 a7 49 00 00       	push   $0x49a7
     b81:	6a 01                	push   $0x1
     b83:	e8 ad 35 00 00       	call   4135 <printf>
     b88:	83 c4 10             	add    $0x10,%esp
     b8b:	eb 17                	jmp    ba4 <pipe1+0x1e8>
    printf(1, "fork() failed\n");
     b8d:	83 ec 08             	sub    $0x8,%esp
     b90:	68 98 49 00 00       	push   $0x4998
     b95:	6a 01                	push   $0x1
     b97:	e8 99 35 00 00       	call   4135 <printf>
     b9c:	83 c4 10             	add    $0x10,%esp
    exit();
     b9f:	e8 20 34 00 00       	call   3fc4 <exit>
}
     ba4:	c9                   	leave  
     ba5:	c3                   	ret    

00000ba6 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     ba6:	55                   	push   %ebp
     ba7:	89 e5                	mov    %esp,%ebp
     ba9:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     bac:	83 ec 08             	sub    $0x8,%esp
     baf:	68 b1 49 00 00       	push   $0x49b1
     bb4:	6a 01                	push   $0x1
     bb6:	e8 7a 35 00 00       	call   4135 <printf>
     bbb:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     bbe:	e8 f9 33 00 00       	call   3fbc <fork>
     bc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     bc6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bca:	75 03                	jne    bcf <preempt+0x29>
    for(;;)
     bcc:	90                   	nop
     bcd:	eb fd                	jmp    bcc <preempt+0x26>
      ;

  pid2 = fork();
     bcf:	e8 e8 33 00 00       	call   3fbc <fork>
     bd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     bd7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     bdb:	75 03                	jne    be0 <preempt+0x3a>
    for(;;)
     bdd:	90                   	nop
     bde:	eb fd                	jmp    bdd <preempt+0x37>
      ;

  pipe(pfds);
     be0:	83 ec 0c             	sub    $0xc,%esp
     be3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     be6:	50                   	push   %eax
     be7:	e8 e8 33 00 00       	call   3fd4 <pipe>
     bec:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     bef:	e8 c8 33 00 00       	call   3fbc <fork>
     bf4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     bf7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bfb:	75 4e                	jne    c4b <preempt+0xa5>
    close(pfds[0]);
     bfd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c00:	83 ec 0c             	sub    $0xc,%esp
     c03:	50                   	push   %eax
     c04:	e8 e3 33 00 00       	call   3fec <close>
     c09:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     c0c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c0f:	83 ec 04             	sub    $0x4,%esp
     c12:	6a 01                	push   $0x1
     c14:	68 bb 49 00 00       	push   $0x49bb
     c19:	50                   	push   %eax
     c1a:	e8 c5 33 00 00       	call   3fe4 <write>
     c1f:	83 c4 10             	add    $0x10,%esp
     c22:	83 f8 01             	cmp    $0x1,%eax
     c25:	74 12                	je     c39 <preempt+0x93>
      printf(1, "preempt write error");
     c27:	83 ec 08             	sub    $0x8,%esp
     c2a:	68 bd 49 00 00       	push   $0x49bd
     c2f:	6a 01                	push   $0x1
     c31:	e8 ff 34 00 00       	call   4135 <printf>
     c36:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c39:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c3c:	83 ec 0c             	sub    $0xc,%esp
     c3f:	50                   	push   %eax
     c40:	e8 a7 33 00 00       	call   3fec <close>
     c45:	83 c4 10             	add    $0x10,%esp
    for(;;)
     c48:	90                   	nop
     c49:	eb fd                	jmp    c48 <preempt+0xa2>
      ;
  }

  close(pfds[1]);
     c4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c4e:	83 ec 0c             	sub    $0xc,%esp
     c51:	50                   	push   %eax
     c52:	e8 95 33 00 00       	call   3fec <close>
     c57:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c5d:	83 ec 04             	sub    $0x4,%esp
     c60:	68 00 20 00 00       	push   $0x2000
     c65:	68 60 5d 00 00       	push   $0x5d60
     c6a:	50                   	push   %eax
     c6b:	e8 6c 33 00 00       	call   3fdc <read>
     c70:	83 c4 10             	add    $0x10,%esp
     c73:	83 f8 01             	cmp    $0x1,%eax
     c76:	74 14                	je     c8c <preempt+0xe6>
    printf(1, "preempt read error");
     c78:	83 ec 08             	sub    $0x8,%esp
     c7b:	68 d1 49 00 00       	push   $0x49d1
     c80:	6a 01                	push   $0x1
     c82:	e8 ae 34 00 00       	call   4135 <printf>
     c87:	83 c4 10             	add    $0x10,%esp
     c8a:	eb 7e                	jmp    d0a <preempt+0x164>
    return;
  }
  close(pfds[0]);
     c8c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c8f:	83 ec 0c             	sub    $0xc,%esp
     c92:	50                   	push   %eax
     c93:	e8 54 33 00 00       	call   3fec <close>
     c98:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     c9b:	83 ec 08             	sub    $0x8,%esp
     c9e:	68 e4 49 00 00       	push   $0x49e4
     ca3:	6a 01                	push   $0x1
     ca5:	e8 8b 34 00 00       	call   4135 <printf>
     caa:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     cad:	83 ec 0c             	sub    $0xc,%esp
     cb0:	ff 75 f4             	pushl  -0xc(%ebp)
     cb3:	e8 3c 33 00 00       	call   3ff4 <kill>
     cb8:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     cbb:	83 ec 0c             	sub    $0xc,%esp
     cbe:	ff 75 f0             	pushl  -0x10(%ebp)
     cc1:	e8 2e 33 00 00       	call   3ff4 <kill>
     cc6:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     cc9:	83 ec 0c             	sub    $0xc,%esp
     ccc:	ff 75 ec             	pushl  -0x14(%ebp)
     ccf:	e8 20 33 00 00       	call   3ff4 <kill>
     cd4:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     cd7:	83 ec 08             	sub    $0x8,%esp
     cda:	68 ed 49 00 00       	push   $0x49ed
     cdf:	6a 01                	push   $0x1
     ce1:	e8 4f 34 00 00       	call   4135 <printf>
     ce6:	83 c4 10             	add    $0x10,%esp
  wait();
     ce9:	e8 de 32 00 00       	call   3fcc <wait>
  wait();
     cee:	e8 d9 32 00 00       	call   3fcc <wait>
  wait();
     cf3:	e8 d4 32 00 00       	call   3fcc <wait>
  printf(1, "preempt ok\n");
     cf8:	83 ec 08             	sub    $0x8,%esp
     cfb:	68 f6 49 00 00       	push   $0x49f6
     d00:	6a 01                	push   $0x1
     d02:	e8 2e 34 00 00       	call   4135 <printf>
     d07:	83 c4 10             	add    $0x10,%esp
}
     d0a:	c9                   	leave  
     d0b:	c3                   	ret    

00000d0c <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     d0c:	55                   	push   %ebp
     d0d:	89 e5                	mov    %esp,%ebp
     d0f:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     d12:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d19:	eb 4e                	jmp    d69 <exitwait+0x5d>
    pid = fork();
     d1b:	e8 9c 32 00 00       	call   3fbc <fork>
     d20:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     d23:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d27:	79 14                	jns    d3d <exitwait+0x31>
      printf(1, "fork failed\n");
     d29:	83 ec 08             	sub    $0x8,%esp
     d2c:	68 85 45 00 00       	push   $0x4585
     d31:	6a 01                	push   $0x1
     d33:	e8 fd 33 00 00       	call   4135 <printf>
     d38:	83 c4 10             	add    $0x10,%esp
      return;
     d3b:	eb 44                	jmp    d81 <exitwait+0x75>
    }
    if(pid){
     d3d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d41:	74 1e                	je     d61 <exitwait+0x55>
      if(wait() != pid){
     d43:	e8 84 32 00 00       	call   3fcc <wait>
     d48:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     d4b:	74 19                	je     d66 <exitwait+0x5a>
        printf(1, "wait wrong pid\n");
     d4d:	83 ec 08             	sub    $0x8,%esp
     d50:	68 02 4a 00 00       	push   $0x4a02
     d55:	6a 01                	push   $0x1
     d57:	e8 d9 33 00 00       	call   4135 <printf>
     d5c:	83 c4 10             	add    $0x10,%esp
        return;
     d5f:	eb 20                	jmp    d81 <exitwait+0x75>
      }
    } else {
      exit();
     d61:	e8 5e 32 00 00       	call   3fc4 <exit>
  for(i = 0; i < 100; i++){
     d66:	ff 45 f4             	incl   -0xc(%ebp)
     d69:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     d6d:	7e ac                	jle    d1b <exitwait+0xf>
    }
  }
  printf(1, "exitwait ok\n");
     d6f:	83 ec 08             	sub    $0x8,%esp
     d72:	68 12 4a 00 00       	push   $0x4a12
     d77:	6a 01                	push   $0x1
     d79:	e8 b7 33 00 00       	call   4135 <printf>
     d7e:	83 c4 10             	add    $0x10,%esp
}
     d81:	c9                   	leave  
     d82:	c3                   	ret    

00000d83 <mem>:

void
mem(void)
{
     d83:	55                   	push   %ebp
     d84:	89 e5                	mov    %esp,%ebp
     d86:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     d89:	83 ec 08             	sub    $0x8,%esp
     d8c:	68 1f 4a 00 00       	push   $0x4a1f
     d91:	6a 01                	push   $0x1
     d93:	e8 9d 33 00 00       	call   4135 <printf>
     d98:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     d9b:	e8 a4 32 00 00       	call   4044 <getpid>
     da0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     da3:	e8 14 32 00 00       	call   3fbc <fork>
     da8:	89 45 ec             	mov    %eax,-0x14(%ebp)
     dab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     daf:	0f 85 b7 00 00 00    	jne    e6c <mem+0xe9>
    m1 = 0;
     db5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     dbc:	eb 0e                	jmp    dcc <mem+0x49>
      *(char**)m2 = m1;
     dbe:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     dc4:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     dc6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     dcc:	83 ec 0c             	sub    $0xc,%esp
     dcf:	68 11 27 00 00       	push   $0x2711
     dd4:	e8 2a 36 00 00       	call   4403 <malloc>
     dd9:	83 c4 10             	add    $0x10,%esp
     ddc:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ddf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     de3:	75 d9                	jne    dbe <mem+0x3b>
    }
    while(m1){
     de5:	eb 1c                	jmp    e03 <mem+0x80>
      m2 = *(char**)m1;
     de7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dea:	8b 00                	mov    (%eax),%eax
     dec:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     def:	83 ec 0c             	sub    $0xc,%esp
     df2:	ff 75 f4             	pushl  -0xc(%ebp)
     df5:	e8 c7 34 00 00       	call   42c1 <free>
     dfa:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     dfd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e00:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(m1){
     e03:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e07:	75 de                	jne    de7 <mem+0x64>
    }
    m1 = malloc(1024*20);
     e09:	83 ec 0c             	sub    $0xc,%esp
     e0c:	68 00 50 00 00       	push   $0x5000
     e11:	e8 ed 35 00 00       	call   4403 <malloc>
     e16:	83 c4 10             	add    $0x10,%esp
     e19:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     e1c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e20:	75 25                	jne    e47 <mem+0xc4>
      printf(1, "couldn't allocate mem?!!\n");
     e22:	83 ec 08             	sub    $0x8,%esp
     e25:	68 29 4a 00 00       	push   $0x4a29
     e2a:	6a 01                	push   $0x1
     e2c:	e8 04 33 00 00       	call   4135 <printf>
     e31:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     e34:	83 ec 0c             	sub    $0xc,%esp
     e37:	ff 75 f0             	pushl  -0x10(%ebp)
     e3a:	e8 b5 31 00 00       	call   3ff4 <kill>
     e3f:	83 c4 10             	add    $0x10,%esp
      exit();
     e42:	e8 7d 31 00 00       	call   3fc4 <exit>
    }
    free(m1);
     e47:	83 ec 0c             	sub    $0xc,%esp
     e4a:	ff 75 f4             	pushl  -0xc(%ebp)
     e4d:	e8 6f 34 00 00       	call   42c1 <free>
     e52:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     e55:	83 ec 08             	sub    $0x8,%esp
     e58:	68 43 4a 00 00       	push   $0x4a43
     e5d:	6a 01                	push   $0x1
     e5f:	e8 d1 32 00 00       	call   4135 <printf>
     e64:	83 c4 10             	add    $0x10,%esp
    exit();
     e67:	e8 58 31 00 00       	call   3fc4 <exit>
  } else {
    wait();
     e6c:	e8 5b 31 00 00       	call   3fcc <wait>
  }
}
     e71:	90                   	nop
     e72:	c9                   	leave  
     e73:	c3                   	ret    

00000e74 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     e74:	55                   	push   %ebp
     e75:	89 e5                	mov    %esp,%ebp
     e77:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     e7a:	83 ec 08             	sub    $0x8,%esp
     e7d:	68 4b 4a 00 00       	push   $0x4a4b
     e82:	6a 01                	push   $0x1
     e84:	e8 ac 32 00 00       	call   4135 <printf>
     e89:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     e8c:	83 ec 0c             	sub    $0xc,%esp
     e8f:	68 5a 4a 00 00       	push   $0x4a5a
     e94:	e8 7b 31 00 00       	call   4014 <unlink>
     e99:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e9c:	83 ec 08             	sub    $0x8,%esp
     e9f:	68 02 02 00 00       	push   $0x202
     ea4:	68 5a 4a 00 00       	push   $0x4a5a
     ea9:	e8 56 31 00 00       	call   4004 <open>
     eae:	83 c4 10             	add    $0x10,%esp
     eb1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     eb4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     eb8:	79 17                	jns    ed1 <sharedfd+0x5d>
    printf(1, "fstests: cannot open sharedfd for writing");
     eba:	83 ec 08             	sub    $0x8,%esp
     ebd:	68 64 4a 00 00       	push   $0x4a64
     ec2:	6a 01                	push   $0x1
     ec4:	e8 6c 32 00 00       	call   4135 <printf>
     ec9:	83 c4 10             	add    $0x10,%esp
    return;
     ecc:	e9 7e 01 00 00       	jmp    104f <sharedfd+0x1db>
  }
  pid = fork();
     ed1:	e8 e6 30 00 00       	call   3fbc <fork>
     ed6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ed9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     edd:	75 07                	jne    ee6 <sharedfd+0x72>
     edf:	b8 63 00 00 00       	mov    $0x63,%eax
     ee4:	eb 05                	jmp    eeb <sharedfd+0x77>
     ee6:	b8 70 00 00 00       	mov    $0x70,%eax
     eeb:	83 ec 04             	sub    $0x4,%esp
     eee:	6a 0a                	push   $0xa
     ef0:	50                   	push   %eax
     ef1:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ef4:	50                   	push   %eax
     ef5:	e8 3b 2f 00 00       	call   3e35 <memset>
     efa:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
     efd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f04:	eb 30                	jmp    f36 <sharedfd+0xc2>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     f06:	83 ec 04             	sub    $0x4,%esp
     f09:	6a 0a                	push   $0xa
     f0b:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     f0e:	50                   	push   %eax
     f0f:	ff 75 e8             	pushl  -0x18(%ebp)
     f12:	e8 cd 30 00 00       	call   3fe4 <write>
     f17:	83 c4 10             	add    $0x10,%esp
     f1a:	83 f8 0a             	cmp    $0xa,%eax
     f1d:	74 14                	je     f33 <sharedfd+0xbf>
      printf(1, "fstests: write sharedfd failed\n");
     f1f:	83 ec 08             	sub    $0x8,%esp
     f22:	68 90 4a 00 00       	push   $0x4a90
     f27:	6a 01                	push   $0x1
     f29:	e8 07 32 00 00       	call   4135 <printf>
     f2e:	83 c4 10             	add    $0x10,%esp
      break;
     f31:	eb 0c                	jmp    f3f <sharedfd+0xcb>
  for(i = 0; i < 1000; i++){
     f33:	ff 45 f4             	incl   -0xc(%ebp)
     f36:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     f3d:	7e c7                	jle    f06 <sharedfd+0x92>
    }
  }
  if(pid == 0)
     f3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     f43:	75 05                	jne    f4a <sharedfd+0xd6>
    exit();
     f45:	e8 7a 30 00 00       	call   3fc4 <exit>
  else
    wait();
     f4a:	e8 7d 30 00 00       	call   3fcc <wait>
  close(fd);
     f4f:	83 ec 0c             	sub    $0xc,%esp
     f52:	ff 75 e8             	pushl  -0x18(%ebp)
     f55:	e8 92 30 00 00       	call   3fec <close>
     f5a:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
     f5d:	83 ec 08             	sub    $0x8,%esp
     f60:	6a 00                	push   $0x0
     f62:	68 5a 4a 00 00       	push   $0x4a5a
     f67:	e8 98 30 00 00       	call   4004 <open>
     f6c:	83 c4 10             	add    $0x10,%esp
     f6f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     f72:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     f76:	79 17                	jns    f8f <sharedfd+0x11b>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     f78:	83 ec 08             	sub    $0x8,%esp
     f7b:	68 b0 4a 00 00       	push   $0x4ab0
     f80:	6a 01                	push   $0x1
     f82:	e8 ae 31 00 00       	call   4135 <printf>
     f87:	83 c4 10             	add    $0x10,%esp
    return;
     f8a:	e9 c0 00 00 00       	jmp    104f <sharedfd+0x1db>
  }
  nc = np = 0;
     f8f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f96:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f99:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f9c:	eb 36                	jmp    fd4 <sharedfd+0x160>
    for(i = 0; i < sizeof(buf); i++){
     f9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     fa5:	eb 25                	jmp    fcc <sharedfd+0x158>
      if(buf[i] == 'c')
     fa7:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     faa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fad:	01 d0                	add    %edx,%eax
     faf:	8a 00                	mov    (%eax),%al
     fb1:	3c 63                	cmp    $0x63,%al
     fb3:	75 03                	jne    fb8 <sharedfd+0x144>
        nc++;
     fb5:	ff 45 f0             	incl   -0x10(%ebp)
      if(buf[i] == 'p')
     fb8:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     fbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fbe:	01 d0                	add    %edx,%eax
     fc0:	8a 00                	mov    (%eax),%al
     fc2:	3c 70                	cmp    $0x70,%al
     fc4:	75 03                	jne    fc9 <sharedfd+0x155>
        np++;
     fc6:	ff 45 ec             	incl   -0x14(%ebp)
    for(i = 0; i < sizeof(buf); i++){
     fc9:	ff 45 f4             	incl   -0xc(%ebp)
     fcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fcf:	83 f8 09             	cmp    $0x9,%eax
     fd2:	76 d3                	jbe    fa7 <sharedfd+0x133>
  while((n = read(fd, buf, sizeof(buf))) > 0){
     fd4:	83 ec 04             	sub    $0x4,%esp
     fd7:	6a 0a                	push   $0xa
     fd9:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     fdc:	50                   	push   %eax
     fdd:	ff 75 e8             	pushl  -0x18(%ebp)
     fe0:	e8 f7 2f 00 00       	call   3fdc <read>
     fe5:	83 c4 10             	add    $0x10,%esp
     fe8:	89 45 e0             	mov    %eax,-0x20(%ebp)
     feb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     fef:	7f ad                	jg     f9e <sharedfd+0x12a>
    }
  }
  close(fd);
     ff1:	83 ec 0c             	sub    $0xc,%esp
     ff4:	ff 75 e8             	pushl  -0x18(%ebp)
     ff7:	e8 f0 2f 00 00       	call   3fec <close>
     ffc:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
     fff:	83 ec 0c             	sub    $0xc,%esp
    1002:	68 5a 4a 00 00       	push   $0x4a5a
    1007:	e8 08 30 00 00       	call   4014 <unlink>
    100c:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
    100f:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
    1016:	75 1d                	jne    1035 <sharedfd+0x1c1>
    1018:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
    101f:	75 14                	jne    1035 <sharedfd+0x1c1>
    printf(1, "sharedfd ok\n");
    1021:	83 ec 08             	sub    $0x8,%esp
    1024:	68 db 4a 00 00       	push   $0x4adb
    1029:	6a 01                	push   $0x1
    102b:	e8 05 31 00 00       	call   4135 <printf>
    1030:	83 c4 10             	add    $0x10,%esp
    1033:	eb 1a                	jmp    104f <sharedfd+0x1db>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1035:	ff 75 ec             	pushl  -0x14(%ebp)
    1038:	ff 75 f0             	pushl  -0x10(%ebp)
    103b:	68 e8 4a 00 00       	push   $0x4ae8
    1040:	6a 01                	push   $0x1
    1042:	e8 ee 30 00 00       	call   4135 <printf>
    1047:	83 c4 10             	add    $0x10,%esp
    exit();
    104a:	e8 75 2f 00 00       	call   3fc4 <exit>
  }
}
    104f:	c9                   	leave  
    1050:	c3                   	ret    

00001051 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1051:	55                   	push   %ebp
    1052:	89 e5                	mov    %esp,%ebp
    1054:	57                   	push   %edi
    1055:	56                   	push   %esi
    1056:	53                   	push   %ebx
    1057:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    105a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    105d:	bb 64 4b 00 00       	mov    $0x4b64,%ebx
    1062:	ba 04 00 00 00       	mov    $0x4,%edx
    1067:	89 c7                	mov    %eax,%edi
    1069:	89 de                	mov    %ebx,%esi
    106b:	89 d1                	mov    %edx,%ecx
    106d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  char *fname;

  printf(1, "fourfiles test\n");
    106f:	83 ec 08             	sub    $0x8,%esp
    1072:	68 fd 4a 00 00       	push   $0x4afd
    1077:	6a 01                	push   $0x1
    1079:	e8 b7 30 00 00       	call   4135 <printf>
    107e:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    1081:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    1088:	e9 ee 00 00 00       	jmp    117b <fourfiles+0x12a>
    fname = names[pi];
    108d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1090:	8b 44 85 b8          	mov    -0x48(%ebp,%eax,4),%eax
    1094:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unlink(fname);
    1097:	83 ec 0c             	sub    $0xc,%esp
    109a:	ff 75 d4             	pushl  -0x2c(%ebp)
    109d:	e8 72 2f 00 00       	call   4014 <unlink>
    10a2:	83 c4 10             	add    $0x10,%esp

    pid = fork();
    10a5:	e8 12 2f 00 00       	call   3fbc <fork>
    10aa:	89 45 c8             	mov    %eax,-0x38(%ebp)
    if(pid < 0){
    10ad:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
    10b1:	79 17                	jns    10ca <fourfiles+0x79>
      printf(1, "fork failed\n");
    10b3:	83 ec 08             	sub    $0x8,%esp
    10b6:	68 85 45 00 00       	push   $0x4585
    10bb:	6a 01                	push   $0x1
    10bd:	e8 73 30 00 00       	call   4135 <printf>
    10c2:	83 c4 10             	add    $0x10,%esp
      exit();
    10c5:	e8 fa 2e 00 00       	call   3fc4 <exit>
    }

    if(pid == 0){
    10ca:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
    10ce:	0f 85 a4 00 00 00    	jne    1178 <fourfiles+0x127>
      fd = open(fname, O_CREATE | O_RDWR);
    10d4:	83 ec 08             	sub    $0x8,%esp
    10d7:	68 02 02 00 00       	push   $0x202
    10dc:	ff 75 d4             	pushl  -0x2c(%ebp)
    10df:	e8 20 2f 00 00       	call   4004 <open>
    10e4:	83 c4 10             	add    $0x10,%esp
    10e7:	89 45 d0             	mov    %eax,-0x30(%ebp)
      if(fd < 0){
    10ea:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
    10ee:	79 17                	jns    1107 <fourfiles+0xb6>
        printf(1, "create failed\n");
    10f0:	83 ec 08             	sub    $0x8,%esp
    10f3:	68 0d 4b 00 00       	push   $0x4b0d
    10f8:	6a 01                	push   $0x1
    10fa:	e8 36 30 00 00       	call   4135 <printf>
    10ff:	83 c4 10             	add    $0x10,%esp
        exit();
    1102:	e8 bd 2e 00 00       	call   3fc4 <exit>
      }

      memset(buf, '0'+pi, 512);
    1107:	8b 45 d8             	mov    -0x28(%ebp),%eax
    110a:	83 c0 30             	add    $0x30,%eax
    110d:	83 ec 04             	sub    $0x4,%esp
    1110:	68 00 02 00 00       	push   $0x200
    1115:	50                   	push   %eax
    1116:	68 60 5d 00 00       	push   $0x5d60
    111b:	e8 15 2d 00 00       	call   3e35 <memset>
    1120:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
    1123:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    112a:	eb 41                	jmp    116d <fourfiles+0x11c>
        if((n = write(fd, buf, 500)) != 500){
    112c:	83 ec 04             	sub    $0x4,%esp
    112f:	68 f4 01 00 00       	push   $0x1f4
    1134:	68 60 5d 00 00       	push   $0x5d60
    1139:	ff 75 d0             	pushl  -0x30(%ebp)
    113c:	e8 a3 2e 00 00       	call   3fe4 <write>
    1141:	83 c4 10             	add    $0x10,%esp
    1144:	89 45 cc             	mov    %eax,-0x34(%ebp)
    1147:	81 7d cc f4 01 00 00 	cmpl   $0x1f4,-0x34(%ebp)
    114e:	74 1a                	je     116a <fourfiles+0x119>
          printf(1, "write failed %d\n", n);
    1150:	83 ec 04             	sub    $0x4,%esp
    1153:	ff 75 cc             	pushl  -0x34(%ebp)
    1156:	68 1c 4b 00 00       	push   $0x4b1c
    115b:	6a 01                	push   $0x1
    115d:	e8 d3 2f 00 00       	call   4135 <printf>
    1162:	83 c4 10             	add    $0x10,%esp
          exit();
    1165:	e8 5a 2e 00 00       	call   3fc4 <exit>
      for(i = 0; i < 12; i++){
    116a:	ff 45 e4             	incl   -0x1c(%ebp)
    116d:	83 7d e4 0b          	cmpl   $0xb,-0x1c(%ebp)
    1171:	7e b9                	jle    112c <fourfiles+0xdb>
        }
      }
      exit();
    1173:	e8 4c 2e 00 00       	call   3fc4 <exit>
  for(pi = 0; pi < 4; pi++){
    1178:	ff 45 d8             	incl   -0x28(%ebp)
    117b:	83 7d d8 03          	cmpl   $0x3,-0x28(%ebp)
    117f:	0f 8e 08 ff ff ff    	jle    108d <fourfiles+0x3c>
    }
  }

  for(pi = 0; pi < 4; pi++){
    1185:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    118c:	eb 08                	jmp    1196 <fourfiles+0x145>
    wait();
    118e:	e8 39 2e 00 00       	call   3fcc <wait>
  for(pi = 0; pi < 4; pi++){
    1193:	ff 45 d8             	incl   -0x28(%ebp)
    1196:	83 7d d8 03          	cmpl   $0x3,-0x28(%ebp)
    119a:	7e f2                	jle    118e <fourfiles+0x13d>
  }

  for(i = 0; i < 2; i++){
    119c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    11a3:	e9 d1 00 00 00       	jmp    1279 <fourfiles+0x228>
    fname = names[i];
    11a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11ab:	8b 44 85 b8          	mov    -0x48(%ebp,%eax,4),%eax
    11af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    fd = open(fname, 0);
    11b2:	83 ec 08             	sub    $0x8,%esp
    11b5:	6a 00                	push   $0x0
    11b7:	ff 75 d4             	pushl  -0x2c(%ebp)
    11ba:	e8 45 2e 00 00       	call   4004 <open>
    11bf:	83 c4 10             	add    $0x10,%esp
    11c2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    total = 0;
    11c5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    11cc:	eb 48                	jmp    1216 <fourfiles+0x1c5>
      for(j = 0; j < n; j++){
    11ce:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    11d5:	eb 31                	jmp    1208 <fourfiles+0x1b7>
        if(buf[j] != '0'+i){
    11d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11da:	05 60 5d 00 00       	add    $0x5d60,%eax
    11df:	8a 00                	mov    (%eax),%al
    11e1:	0f be d0             	movsbl %al,%edx
    11e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11e7:	83 c0 30             	add    $0x30,%eax
    11ea:	39 c2                	cmp    %eax,%edx
    11ec:	74 17                	je     1205 <fourfiles+0x1b4>
          printf(1, "wrong char\n");
    11ee:	83 ec 08             	sub    $0x8,%esp
    11f1:	68 2d 4b 00 00       	push   $0x4b2d
    11f6:	6a 01                	push   $0x1
    11f8:	e8 38 2f 00 00       	call   4135 <printf>
    11fd:	83 c4 10             	add    $0x10,%esp
          exit();
    1200:	e8 bf 2d 00 00       	call   3fc4 <exit>
      for(j = 0; j < n; j++){
    1205:	ff 45 e0             	incl   -0x20(%ebp)
    1208:	8b 45 e0             	mov    -0x20(%ebp),%eax
    120b:	3b 45 cc             	cmp    -0x34(%ebp),%eax
    120e:	7c c7                	jl     11d7 <fourfiles+0x186>
        }
      }
      total += n;
    1210:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1213:	01 45 dc             	add    %eax,-0x24(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1216:	83 ec 04             	sub    $0x4,%esp
    1219:	68 00 20 00 00       	push   $0x2000
    121e:	68 60 5d 00 00       	push   $0x5d60
    1223:	ff 75 d0             	pushl  -0x30(%ebp)
    1226:	e8 b1 2d 00 00       	call   3fdc <read>
    122b:	83 c4 10             	add    $0x10,%esp
    122e:	89 45 cc             	mov    %eax,-0x34(%ebp)
    1231:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
    1235:	7f 97                	jg     11ce <fourfiles+0x17d>
    }
    close(fd);
    1237:	83 ec 0c             	sub    $0xc,%esp
    123a:	ff 75 d0             	pushl  -0x30(%ebp)
    123d:	e8 aa 2d 00 00       	call   3fec <close>
    1242:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
    1245:	81 7d dc 70 17 00 00 	cmpl   $0x1770,-0x24(%ebp)
    124c:	74 1a                	je     1268 <fourfiles+0x217>
      printf(1, "wrong length %d\n", total);
    124e:	83 ec 04             	sub    $0x4,%esp
    1251:	ff 75 dc             	pushl  -0x24(%ebp)
    1254:	68 39 4b 00 00       	push   $0x4b39
    1259:	6a 01                	push   $0x1
    125b:	e8 d5 2e 00 00       	call   4135 <printf>
    1260:	83 c4 10             	add    $0x10,%esp
      exit();
    1263:	e8 5c 2d 00 00       	call   3fc4 <exit>
    }
    unlink(fname);
    1268:	83 ec 0c             	sub    $0xc,%esp
    126b:	ff 75 d4             	pushl  -0x2c(%ebp)
    126e:	e8 a1 2d 00 00       	call   4014 <unlink>
    1273:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 2; i++){
    1276:	ff 45 e4             	incl   -0x1c(%ebp)
    1279:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    127d:	0f 8e 25 ff ff ff    	jle    11a8 <fourfiles+0x157>
  }

  printf(1, "fourfiles ok\n");
    1283:	83 ec 08             	sub    $0x8,%esp
    1286:	68 4a 4b 00 00       	push   $0x4b4a
    128b:	6a 01                	push   $0x1
    128d:	e8 a3 2e 00 00       	call   4135 <printf>
    1292:	83 c4 10             	add    $0x10,%esp
}
    1295:	90                   	nop
    1296:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1299:	5b                   	pop    %ebx
    129a:	5e                   	pop    %esi
    129b:	5f                   	pop    %edi
    129c:	5d                   	pop    %ebp
    129d:	c3                   	ret    

0000129e <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    129e:	55                   	push   %ebp
    129f:	89 e5                	mov    %esp,%ebp
    12a1:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    12a4:	83 ec 08             	sub    $0x8,%esp
    12a7:	68 74 4b 00 00       	push   $0x4b74
    12ac:	6a 01                	push   $0x1
    12ae:	e8 82 2e 00 00       	call   4135 <printf>
    12b3:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    12b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12bd:	e9 f4 00 00 00       	jmp    13b6 <createdelete+0x118>
    pid = fork();
    12c2:	e8 f5 2c 00 00       	call   3fbc <fork>
    12c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    12ca:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    12ce:	79 17                	jns    12e7 <createdelete+0x49>
      printf(1, "fork failed\n");
    12d0:	83 ec 08             	sub    $0x8,%esp
    12d3:	68 85 45 00 00       	push   $0x4585
    12d8:	6a 01                	push   $0x1
    12da:	e8 56 2e 00 00       	call   4135 <printf>
    12df:	83 c4 10             	add    $0x10,%esp
      exit();
    12e2:	e8 dd 2c 00 00       	call   3fc4 <exit>
    }

    if(pid == 0){
    12e7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    12eb:	0f 85 c2 00 00 00    	jne    13b3 <createdelete+0x115>
      name[0] = 'p' + pi;
    12f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12f4:	83 c0 70             	add    $0x70,%eax
    12f7:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    12fa:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    12fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1305:	e9 9a 00 00 00       	jmp    13a4 <createdelete+0x106>
        name[1] = '0' + i;
    130a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    130d:	83 c0 30             	add    $0x30,%eax
    1310:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1313:	83 ec 08             	sub    $0x8,%esp
    1316:	68 02 02 00 00       	push   $0x202
    131b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    131e:	50                   	push   %eax
    131f:	e8 e0 2c 00 00       	call   4004 <open>
    1324:	83 c4 10             	add    $0x10,%esp
    1327:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if(fd < 0){
    132a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    132e:	79 17                	jns    1347 <createdelete+0xa9>
          printf(1, "create failed\n");
    1330:	83 ec 08             	sub    $0x8,%esp
    1333:	68 0d 4b 00 00       	push   $0x4b0d
    1338:	6a 01                	push   $0x1
    133a:	e8 f6 2d 00 00       	call   4135 <printf>
    133f:	83 c4 10             	add    $0x10,%esp
          exit();
    1342:	e8 7d 2c 00 00       	call   3fc4 <exit>
        }
        close(fd);
    1347:	83 ec 0c             	sub    $0xc,%esp
    134a:	ff 75 ec             	pushl  -0x14(%ebp)
    134d:	e8 9a 2c 00 00       	call   3fec <close>
    1352:	83 c4 10             	add    $0x10,%esp
        if(i > 0 && (i % 2 ) == 0){
    1355:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1359:	7e 46                	jle    13a1 <createdelete+0x103>
    135b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135e:	83 e0 01             	and    $0x1,%eax
    1361:	85 c0                	test   %eax,%eax
    1363:	75 3c                	jne    13a1 <createdelete+0x103>
          name[1] = '0' + (i / 2);
    1365:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1368:	89 c2                	mov    %eax,%edx
    136a:	c1 ea 1f             	shr    $0x1f,%edx
    136d:	01 d0                	add    %edx,%eax
    136f:	d1 f8                	sar    %eax
    1371:	83 c0 30             	add    $0x30,%eax
    1374:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1377:	83 ec 0c             	sub    $0xc,%esp
    137a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    137d:	50                   	push   %eax
    137e:	e8 91 2c 00 00       	call   4014 <unlink>
    1383:	83 c4 10             	add    $0x10,%esp
    1386:	85 c0                	test   %eax,%eax
    1388:	79 17                	jns    13a1 <createdelete+0x103>
            printf(1, "unlink failed\n");
    138a:	83 ec 08             	sub    $0x8,%esp
    138d:	68 08 46 00 00       	push   $0x4608
    1392:	6a 01                	push   $0x1
    1394:	e8 9c 2d 00 00       	call   4135 <printf>
    1399:	83 c4 10             	add    $0x10,%esp
            exit();
    139c:	e8 23 2c 00 00       	call   3fc4 <exit>
      for(i = 0; i < N; i++){
    13a1:	ff 45 f4             	incl   -0xc(%ebp)
    13a4:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    13a8:	0f 8e 5c ff ff ff    	jle    130a <createdelete+0x6c>
          }
        }
      }
      exit();
    13ae:	e8 11 2c 00 00       	call   3fc4 <exit>
  for(pi = 0; pi < 4; pi++){
    13b3:	ff 45 f0             	incl   -0x10(%ebp)
    13b6:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13ba:	0f 8e 02 ff ff ff    	jle    12c2 <createdelete+0x24>
    }
  }

  for(pi = 0; pi < 4; pi++){
    13c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13c7:	eb 08                	jmp    13d1 <createdelete+0x133>
    wait();
    13c9:	e8 fe 2b 00 00       	call   3fcc <wait>
  for(pi = 0; pi < 4; pi++){
    13ce:	ff 45 f0             	incl   -0x10(%ebp)
    13d1:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13d5:	7e f2                	jle    13c9 <createdelete+0x12b>
  }

  name[0] = name[1] = name[2] = 0;
    13d7:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13db:	8a 45 ca             	mov    -0x36(%ebp),%al
    13de:	88 45 c9             	mov    %al,-0x37(%ebp)
    13e1:	8a 45 c9             	mov    -0x37(%ebp),%al
    13e4:	88 45 c8             	mov    %al,-0x38(%ebp)
  for(i = 0; i < N; i++){
    13e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13ee:	e9 b0 00 00 00       	jmp    14a3 <createdelete+0x205>
    for(pi = 0; pi < 4; pi++){
    13f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13fa:	e9 97 00 00 00       	jmp    1496 <createdelete+0x1f8>
      name[0] = 'p' + pi;
    13ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1402:	83 c0 70             	add    $0x70,%eax
    1405:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1408:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140b:	83 c0 30             	add    $0x30,%eax
    140e:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1411:	83 ec 08             	sub    $0x8,%esp
    1414:	6a 00                	push   $0x0
    1416:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1419:	50                   	push   %eax
    141a:	e8 e5 2b 00 00       	call   4004 <open>
    141f:	83 c4 10             	add    $0x10,%esp
    1422:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    1425:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1429:	74 06                	je     1431 <createdelete+0x193>
    142b:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    142f:	7e 21                	jle    1452 <createdelete+0x1b4>
    1431:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1435:	79 1b                	jns    1452 <createdelete+0x1b4>
        printf(1, "oops createdelete %s didn't exist\n", name);
    1437:	83 ec 04             	sub    $0x4,%esp
    143a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    143d:	50                   	push   %eax
    143e:	68 88 4b 00 00       	push   $0x4b88
    1443:	6a 01                	push   $0x1
    1445:	e8 eb 2c 00 00       	call   4135 <printf>
    144a:	83 c4 10             	add    $0x10,%esp
        exit();
    144d:	e8 72 2b 00 00       	call   3fc4 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1452:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1456:	7e 27                	jle    147f <createdelete+0x1e1>
    1458:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    145c:	7f 21                	jg     147f <createdelete+0x1e1>
    145e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1462:	78 1b                	js     147f <createdelete+0x1e1>
        printf(1, "oops createdelete %s did exist\n", name);
    1464:	83 ec 04             	sub    $0x4,%esp
    1467:	8d 45 c8             	lea    -0x38(%ebp),%eax
    146a:	50                   	push   %eax
    146b:	68 ac 4b 00 00       	push   $0x4bac
    1470:	6a 01                	push   $0x1
    1472:	e8 be 2c 00 00       	call   4135 <printf>
    1477:	83 c4 10             	add    $0x10,%esp
        exit();
    147a:	e8 45 2b 00 00       	call   3fc4 <exit>
      }
      if(fd >= 0)
    147f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1483:	78 0e                	js     1493 <createdelete+0x1f5>
        close(fd);
    1485:	83 ec 0c             	sub    $0xc,%esp
    1488:	ff 75 ec             	pushl  -0x14(%ebp)
    148b:	e8 5c 2b 00 00       	call   3fec <close>
    1490:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    1493:	ff 45 f0             	incl   -0x10(%ebp)
    1496:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    149a:	0f 8e 5f ff ff ff    	jle    13ff <createdelete+0x161>
  for(i = 0; i < N; i++){
    14a0:	ff 45 f4             	incl   -0xc(%ebp)
    14a3:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    14a7:	0f 8e 46 ff ff ff    	jle    13f3 <createdelete+0x155>
    }
  }

  for(i = 0; i < N; i++){
    14ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14b4:	eb 36                	jmp    14ec <createdelete+0x24e>
    for(pi = 0; pi < 4; pi++){
    14b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14bd:	eb 24                	jmp    14e3 <createdelete+0x245>
      name[0] = 'p' + i;
    14bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c2:	83 c0 70             	add    $0x70,%eax
    14c5:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    14c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cb:	83 c0 30             	add    $0x30,%eax
    14ce:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    14d1:	83 ec 0c             	sub    $0xc,%esp
    14d4:	8d 45 c8             	lea    -0x38(%ebp),%eax
    14d7:	50                   	push   %eax
    14d8:	e8 37 2b 00 00       	call   4014 <unlink>
    14dd:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    14e0:	ff 45 f0             	incl   -0x10(%ebp)
    14e3:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    14e7:	7e d6                	jle    14bf <createdelete+0x221>
  for(i = 0; i < N; i++){
    14e9:	ff 45 f4             	incl   -0xc(%ebp)
    14ec:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    14f0:	7e c4                	jle    14b6 <createdelete+0x218>
    }
  }

  printf(1, "createdelete ok\n");
    14f2:	83 ec 08             	sub    $0x8,%esp
    14f5:	68 cc 4b 00 00       	push   $0x4bcc
    14fa:	6a 01                	push   $0x1
    14fc:	e8 34 2c 00 00       	call   4135 <printf>
    1501:	83 c4 10             	add    $0x10,%esp
}
    1504:	90                   	nop
    1505:	c9                   	leave  
    1506:	c3                   	ret    

00001507 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1507:	55                   	push   %ebp
    1508:	89 e5                	mov    %esp,%ebp
    150a:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    150d:	83 ec 08             	sub    $0x8,%esp
    1510:	68 dd 4b 00 00       	push   $0x4bdd
    1515:	6a 01                	push   $0x1
    1517:	e8 19 2c 00 00       	call   4135 <printf>
    151c:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    151f:	83 ec 08             	sub    $0x8,%esp
    1522:	68 02 02 00 00       	push   $0x202
    1527:	68 ee 4b 00 00       	push   $0x4bee
    152c:	e8 d3 2a 00 00       	call   4004 <open>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1537:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    153b:	79 17                	jns    1554 <unlinkread+0x4d>
    printf(1, "create unlinkread failed\n");
    153d:	83 ec 08             	sub    $0x8,%esp
    1540:	68 f9 4b 00 00       	push   $0x4bf9
    1545:	6a 01                	push   $0x1
    1547:	e8 e9 2b 00 00       	call   4135 <printf>
    154c:	83 c4 10             	add    $0x10,%esp
    exit();
    154f:	e8 70 2a 00 00       	call   3fc4 <exit>
  }
  write(fd, "hello", 5);
    1554:	83 ec 04             	sub    $0x4,%esp
    1557:	6a 05                	push   $0x5
    1559:	68 13 4c 00 00       	push   $0x4c13
    155e:	ff 75 f4             	pushl  -0xc(%ebp)
    1561:	e8 7e 2a 00 00       	call   3fe4 <write>
    1566:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1569:	83 ec 0c             	sub    $0xc,%esp
    156c:	ff 75 f4             	pushl  -0xc(%ebp)
    156f:	e8 78 2a 00 00       	call   3fec <close>
    1574:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    1577:	83 ec 08             	sub    $0x8,%esp
    157a:	6a 02                	push   $0x2
    157c:	68 ee 4b 00 00       	push   $0x4bee
    1581:	e8 7e 2a 00 00       	call   4004 <open>
    1586:	83 c4 10             	add    $0x10,%esp
    1589:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    158c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1590:	79 17                	jns    15a9 <unlinkread+0xa2>
    printf(1, "open unlinkread failed\n");
    1592:	83 ec 08             	sub    $0x8,%esp
    1595:	68 19 4c 00 00       	push   $0x4c19
    159a:	6a 01                	push   $0x1
    159c:	e8 94 2b 00 00       	call   4135 <printf>
    15a1:	83 c4 10             	add    $0x10,%esp
    exit();
    15a4:	e8 1b 2a 00 00       	call   3fc4 <exit>
  }
  if(unlink("unlinkread") != 0){
    15a9:	83 ec 0c             	sub    $0xc,%esp
    15ac:	68 ee 4b 00 00       	push   $0x4bee
    15b1:	e8 5e 2a 00 00       	call   4014 <unlink>
    15b6:	83 c4 10             	add    $0x10,%esp
    15b9:	85 c0                	test   %eax,%eax
    15bb:	74 17                	je     15d4 <unlinkread+0xcd>
    printf(1, "unlink unlinkread failed\n");
    15bd:	83 ec 08             	sub    $0x8,%esp
    15c0:	68 31 4c 00 00       	push   $0x4c31
    15c5:	6a 01                	push   $0x1
    15c7:	e8 69 2b 00 00       	call   4135 <printf>
    15cc:	83 c4 10             	add    $0x10,%esp
    exit();
    15cf:	e8 f0 29 00 00       	call   3fc4 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    15d4:	83 ec 08             	sub    $0x8,%esp
    15d7:	68 02 02 00 00       	push   $0x202
    15dc:	68 ee 4b 00 00       	push   $0x4bee
    15e1:	e8 1e 2a 00 00       	call   4004 <open>
    15e6:	83 c4 10             	add    $0x10,%esp
    15e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    15ec:	83 ec 04             	sub    $0x4,%esp
    15ef:	6a 03                	push   $0x3
    15f1:	68 4b 4c 00 00       	push   $0x4c4b
    15f6:	ff 75 f0             	pushl  -0x10(%ebp)
    15f9:	e8 e6 29 00 00       	call   3fe4 <write>
    15fe:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    1601:	83 ec 0c             	sub    $0xc,%esp
    1604:	ff 75 f0             	pushl  -0x10(%ebp)
    1607:	e8 e0 29 00 00       	call   3fec <close>
    160c:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    160f:	83 ec 04             	sub    $0x4,%esp
    1612:	68 00 20 00 00       	push   $0x2000
    1617:	68 60 5d 00 00       	push   $0x5d60
    161c:	ff 75 f4             	pushl  -0xc(%ebp)
    161f:	e8 b8 29 00 00       	call   3fdc <read>
    1624:	83 c4 10             	add    $0x10,%esp
    1627:	83 f8 05             	cmp    $0x5,%eax
    162a:	74 17                	je     1643 <unlinkread+0x13c>
    printf(1, "unlinkread read failed");
    162c:	83 ec 08             	sub    $0x8,%esp
    162f:	68 4f 4c 00 00       	push   $0x4c4f
    1634:	6a 01                	push   $0x1
    1636:	e8 fa 2a 00 00       	call   4135 <printf>
    163b:	83 c4 10             	add    $0x10,%esp
    exit();
    163e:	e8 81 29 00 00       	call   3fc4 <exit>
  }
  if(buf[0] != 'h'){
    1643:	a0 60 5d 00 00       	mov    0x5d60,%al
    1648:	3c 68                	cmp    $0x68,%al
    164a:	74 17                	je     1663 <unlinkread+0x15c>
    printf(1, "unlinkread wrong data\n");
    164c:	83 ec 08             	sub    $0x8,%esp
    164f:	68 66 4c 00 00       	push   $0x4c66
    1654:	6a 01                	push   $0x1
    1656:	e8 da 2a 00 00       	call   4135 <printf>
    165b:	83 c4 10             	add    $0x10,%esp
    exit();
    165e:	e8 61 29 00 00       	call   3fc4 <exit>
  }
  if(write(fd, buf, 10) != 10){
    1663:	83 ec 04             	sub    $0x4,%esp
    1666:	6a 0a                	push   $0xa
    1668:	68 60 5d 00 00       	push   $0x5d60
    166d:	ff 75 f4             	pushl  -0xc(%ebp)
    1670:	e8 6f 29 00 00       	call   3fe4 <write>
    1675:	83 c4 10             	add    $0x10,%esp
    1678:	83 f8 0a             	cmp    $0xa,%eax
    167b:	74 17                	je     1694 <unlinkread+0x18d>
    printf(1, "unlinkread write failed\n");
    167d:	83 ec 08             	sub    $0x8,%esp
    1680:	68 7d 4c 00 00       	push   $0x4c7d
    1685:	6a 01                	push   $0x1
    1687:	e8 a9 2a 00 00       	call   4135 <printf>
    168c:	83 c4 10             	add    $0x10,%esp
    exit();
    168f:	e8 30 29 00 00       	call   3fc4 <exit>
  }
  close(fd);
    1694:	83 ec 0c             	sub    $0xc,%esp
    1697:	ff 75 f4             	pushl  -0xc(%ebp)
    169a:	e8 4d 29 00 00       	call   3fec <close>
    169f:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    16a2:	83 ec 0c             	sub    $0xc,%esp
    16a5:	68 ee 4b 00 00       	push   $0x4bee
    16aa:	e8 65 29 00 00       	call   4014 <unlink>
    16af:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    16b2:	83 ec 08             	sub    $0x8,%esp
    16b5:	68 96 4c 00 00       	push   $0x4c96
    16ba:	6a 01                	push   $0x1
    16bc:	e8 74 2a 00 00       	call   4135 <printf>
    16c1:	83 c4 10             	add    $0x10,%esp
}
    16c4:	90                   	nop
    16c5:	c9                   	leave  
    16c6:	c3                   	ret    

000016c7 <linktest>:

void
linktest(void)
{
    16c7:	55                   	push   %ebp
    16c8:	89 e5                	mov    %esp,%ebp
    16ca:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    16cd:	83 ec 08             	sub    $0x8,%esp
    16d0:	68 a5 4c 00 00       	push   $0x4ca5
    16d5:	6a 01                	push   $0x1
    16d7:	e8 59 2a 00 00       	call   4135 <printf>
    16dc:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    16df:	83 ec 0c             	sub    $0xc,%esp
    16e2:	68 af 4c 00 00       	push   $0x4caf
    16e7:	e8 28 29 00 00       	call   4014 <unlink>
    16ec:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    16ef:	83 ec 0c             	sub    $0xc,%esp
    16f2:	68 b3 4c 00 00       	push   $0x4cb3
    16f7:	e8 18 29 00 00       	call   4014 <unlink>
    16fc:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    16ff:	83 ec 08             	sub    $0x8,%esp
    1702:	68 02 02 00 00       	push   $0x202
    1707:	68 af 4c 00 00       	push   $0x4caf
    170c:	e8 f3 28 00 00       	call   4004 <open>
    1711:	83 c4 10             	add    $0x10,%esp
    1714:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1717:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    171b:	79 17                	jns    1734 <linktest+0x6d>
    printf(1, "create lf1 failed\n");
    171d:	83 ec 08             	sub    $0x8,%esp
    1720:	68 b7 4c 00 00       	push   $0x4cb7
    1725:	6a 01                	push   $0x1
    1727:	e8 09 2a 00 00       	call   4135 <printf>
    172c:	83 c4 10             	add    $0x10,%esp
    exit();
    172f:	e8 90 28 00 00       	call   3fc4 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    1734:	83 ec 04             	sub    $0x4,%esp
    1737:	6a 05                	push   $0x5
    1739:	68 13 4c 00 00       	push   $0x4c13
    173e:	ff 75 f4             	pushl  -0xc(%ebp)
    1741:	e8 9e 28 00 00       	call   3fe4 <write>
    1746:	83 c4 10             	add    $0x10,%esp
    1749:	83 f8 05             	cmp    $0x5,%eax
    174c:	74 17                	je     1765 <linktest+0x9e>
    printf(1, "write lf1 failed\n");
    174e:	83 ec 08             	sub    $0x8,%esp
    1751:	68 ca 4c 00 00       	push   $0x4cca
    1756:	6a 01                	push   $0x1
    1758:	e8 d8 29 00 00       	call   4135 <printf>
    175d:	83 c4 10             	add    $0x10,%esp
    exit();
    1760:	e8 5f 28 00 00       	call   3fc4 <exit>
  }
  close(fd);
    1765:	83 ec 0c             	sub    $0xc,%esp
    1768:	ff 75 f4             	pushl  -0xc(%ebp)
    176b:	e8 7c 28 00 00       	call   3fec <close>
    1770:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    1773:	83 ec 08             	sub    $0x8,%esp
    1776:	68 b3 4c 00 00       	push   $0x4cb3
    177b:	68 af 4c 00 00       	push   $0x4caf
    1780:	e8 9f 28 00 00       	call   4024 <link>
    1785:	83 c4 10             	add    $0x10,%esp
    1788:	85 c0                	test   %eax,%eax
    178a:	79 17                	jns    17a3 <linktest+0xdc>
    printf(1, "link lf1 lf2 failed\n");
    178c:	83 ec 08             	sub    $0x8,%esp
    178f:	68 dc 4c 00 00       	push   $0x4cdc
    1794:	6a 01                	push   $0x1
    1796:	e8 9a 29 00 00       	call   4135 <printf>
    179b:	83 c4 10             	add    $0x10,%esp
    exit();
    179e:	e8 21 28 00 00       	call   3fc4 <exit>
  }
  unlink("lf1");
    17a3:	83 ec 0c             	sub    $0xc,%esp
    17a6:	68 af 4c 00 00       	push   $0x4caf
    17ab:	e8 64 28 00 00       	call   4014 <unlink>
    17b0:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    17b3:	83 ec 08             	sub    $0x8,%esp
    17b6:	6a 00                	push   $0x0
    17b8:	68 af 4c 00 00       	push   $0x4caf
    17bd:	e8 42 28 00 00       	call   4004 <open>
    17c2:	83 c4 10             	add    $0x10,%esp
    17c5:	85 c0                	test   %eax,%eax
    17c7:	78 17                	js     17e0 <linktest+0x119>
    printf(1, "unlinked lf1 but it is still there!\n");
    17c9:	83 ec 08             	sub    $0x8,%esp
    17cc:	68 f4 4c 00 00       	push   $0x4cf4
    17d1:	6a 01                	push   $0x1
    17d3:	e8 5d 29 00 00       	call   4135 <printf>
    17d8:	83 c4 10             	add    $0x10,%esp
    exit();
    17db:	e8 e4 27 00 00       	call   3fc4 <exit>
  }

  fd = open("lf2", 0);
    17e0:	83 ec 08             	sub    $0x8,%esp
    17e3:	6a 00                	push   $0x0
    17e5:	68 b3 4c 00 00       	push   $0x4cb3
    17ea:	e8 15 28 00 00       	call   4004 <open>
    17ef:	83 c4 10             	add    $0x10,%esp
    17f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    17f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17f9:	79 17                	jns    1812 <linktest+0x14b>
    printf(1, "open lf2 failed\n");
    17fb:	83 ec 08             	sub    $0x8,%esp
    17fe:	68 19 4d 00 00       	push   $0x4d19
    1803:	6a 01                	push   $0x1
    1805:	e8 2b 29 00 00       	call   4135 <printf>
    180a:	83 c4 10             	add    $0x10,%esp
    exit();
    180d:	e8 b2 27 00 00       	call   3fc4 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1812:	83 ec 04             	sub    $0x4,%esp
    1815:	68 00 20 00 00       	push   $0x2000
    181a:	68 60 5d 00 00       	push   $0x5d60
    181f:	ff 75 f4             	pushl  -0xc(%ebp)
    1822:	e8 b5 27 00 00       	call   3fdc <read>
    1827:	83 c4 10             	add    $0x10,%esp
    182a:	83 f8 05             	cmp    $0x5,%eax
    182d:	74 17                	je     1846 <linktest+0x17f>
    printf(1, "read lf2 failed\n");
    182f:	83 ec 08             	sub    $0x8,%esp
    1832:	68 2a 4d 00 00       	push   $0x4d2a
    1837:	6a 01                	push   $0x1
    1839:	e8 f7 28 00 00       	call   4135 <printf>
    183e:	83 c4 10             	add    $0x10,%esp
    exit();
    1841:	e8 7e 27 00 00       	call   3fc4 <exit>
  }
  close(fd);
    1846:	83 ec 0c             	sub    $0xc,%esp
    1849:	ff 75 f4             	pushl  -0xc(%ebp)
    184c:	e8 9b 27 00 00       	call   3fec <close>
    1851:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    1854:	83 ec 08             	sub    $0x8,%esp
    1857:	68 b3 4c 00 00       	push   $0x4cb3
    185c:	68 b3 4c 00 00       	push   $0x4cb3
    1861:	e8 be 27 00 00       	call   4024 <link>
    1866:	83 c4 10             	add    $0x10,%esp
    1869:	85 c0                	test   %eax,%eax
    186b:	78 17                	js     1884 <linktest+0x1bd>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    186d:	83 ec 08             	sub    $0x8,%esp
    1870:	68 3b 4d 00 00       	push   $0x4d3b
    1875:	6a 01                	push   $0x1
    1877:	e8 b9 28 00 00       	call   4135 <printf>
    187c:	83 c4 10             	add    $0x10,%esp
    exit();
    187f:	e8 40 27 00 00       	call   3fc4 <exit>
  }

  unlink("lf2");
    1884:	83 ec 0c             	sub    $0xc,%esp
    1887:	68 b3 4c 00 00       	push   $0x4cb3
    188c:	e8 83 27 00 00       	call   4014 <unlink>
    1891:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    1894:	83 ec 08             	sub    $0x8,%esp
    1897:	68 af 4c 00 00       	push   $0x4caf
    189c:	68 b3 4c 00 00       	push   $0x4cb3
    18a1:	e8 7e 27 00 00       	call   4024 <link>
    18a6:	83 c4 10             	add    $0x10,%esp
    18a9:	85 c0                	test   %eax,%eax
    18ab:	78 17                	js     18c4 <linktest+0x1fd>
    printf(1, "link non-existant succeeded! oops\n");
    18ad:	83 ec 08             	sub    $0x8,%esp
    18b0:	68 5c 4d 00 00       	push   $0x4d5c
    18b5:	6a 01                	push   $0x1
    18b7:	e8 79 28 00 00       	call   4135 <printf>
    18bc:	83 c4 10             	add    $0x10,%esp
    exit();
    18bf:	e8 00 27 00 00       	call   3fc4 <exit>
  }

  if(link(".", "lf1") >= 0){
    18c4:	83 ec 08             	sub    $0x8,%esp
    18c7:	68 af 4c 00 00       	push   $0x4caf
    18cc:	68 7f 4d 00 00       	push   $0x4d7f
    18d1:	e8 4e 27 00 00       	call   4024 <link>
    18d6:	83 c4 10             	add    $0x10,%esp
    18d9:	85 c0                	test   %eax,%eax
    18db:	78 17                	js     18f4 <linktest+0x22d>
    printf(1, "link . lf1 succeeded! oops\n");
    18dd:	83 ec 08             	sub    $0x8,%esp
    18e0:	68 81 4d 00 00       	push   $0x4d81
    18e5:	6a 01                	push   $0x1
    18e7:	e8 49 28 00 00       	call   4135 <printf>
    18ec:	83 c4 10             	add    $0x10,%esp
    exit();
    18ef:	e8 d0 26 00 00       	call   3fc4 <exit>
  }

  printf(1, "linktest ok\n");
    18f4:	83 ec 08             	sub    $0x8,%esp
    18f7:	68 9d 4d 00 00       	push   $0x4d9d
    18fc:	6a 01                	push   $0x1
    18fe:	e8 32 28 00 00       	call   4135 <printf>
    1903:	83 c4 10             	add    $0x10,%esp
}
    1906:	90                   	nop
    1907:	c9                   	leave  
    1908:	c3                   	ret    

00001909 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1909:	55                   	push   %ebp
    190a:	89 e5                	mov    %esp,%ebp
    190c:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    190f:	83 ec 08             	sub    $0x8,%esp
    1912:	68 aa 4d 00 00       	push   $0x4daa
    1917:	6a 01                	push   $0x1
    1919:	e8 17 28 00 00       	call   4135 <printf>
    191e:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    1921:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1925:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1929:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1930:	e9 d5 00 00 00       	jmp    1a0a <concreate+0x101>
    file[1] = '0' + i;
    1935:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1938:	83 c0 30             	add    $0x30,%eax
    193b:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    193e:	83 ec 0c             	sub    $0xc,%esp
    1941:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1944:	50                   	push   %eax
    1945:	e8 ca 26 00 00       	call   4014 <unlink>
    194a:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    194d:	e8 6a 26 00 00       	call   3fbc <fork>
    1952:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid && (i % 3) == 1){
    1955:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1959:	74 28                	je     1983 <concreate+0x7a>
    195b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195e:	b9 03 00 00 00       	mov    $0x3,%ecx
    1963:	99                   	cltd   
    1964:	f7 f9                	idiv   %ecx
    1966:	89 d0                	mov    %edx,%eax
    1968:	83 f8 01             	cmp    $0x1,%eax
    196b:	75 16                	jne    1983 <concreate+0x7a>
      link("C0", file);
    196d:	83 ec 08             	sub    $0x8,%esp
    1970:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1973:	50                   	push   %eax
    1974:	68 ba 4d 00 00       	push   $0x4dba
    1979:	e8 a6 26 00 00       	call   4024 <link>
    197e:	83 c4 10             	add    $0x10,%esp
    1981:	eb 74                	jmp    19f7 <concreate+0xee>
    } else if(pid == 0 && (i % 5) == 1){
    1983:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1987:	75 28                	jne    19b1 <concreate+0xa8>
    1989:	8b 45 f4             	mov    -0xc(%ebp),%eax
    198c:	b9 05 00 00 00       	mov    $0x5,%ecx
    1991:	99                   	cltd   
    1992:	f7 f9                	idiv   %ecx
    1994:	89 d0                	mov    %edx,%eax
    1996:	83 f8 01             	cmp    $0x1,%eax
    1999:	75 16                	jne    19b1 <concreate+0xa8>
      link("C0", file);
    199b:	83 ec 08             	sub    $0x8,%esp
    199e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19a1:	50                   	push   %eax
    19a2:	68 ba 4d 00 00       	push   $0x4dba
    19a7:	e8 78 26 00 00       	call   4024 <link>
    19ac:	83 c4 10             	add    $0x10,%esp
    19af:	eb 46                	jmp    19f7 <concreate+0xee>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    19b1:	83 ec 08             	sub    $0x8,%esp
    19b4:	68 02 02 00 00       	push   $0x202
    19b9:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19bc:	50                   	push   %eax
    19bd:	e8 42 26 00 00       	call   4004 <open>
    19c2:	83 c4 10             	add    $0x10,%esp
    19c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(fd < 0){
    19c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19cc:	79 1b                	jns    19e9 <concreate+0xe0>
        printf(1, "concreate create %s failed\n", file);
    19ce:	83 ec 04             	sub    $0x4,%esp
    19d1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19d4:	50                   	push   %eax
    19d5:	68 bd 4d 00 00       	push   $0x4dbd
    19da:	6a 01                	push   $0x1
    19dc:	e8 54 27 00 00       	call   4135 <printf>
    19e1:	83 c4 10             	add    $0x10,%esp
        exit();
    19e4:	e8 db 25 00 00       	call   3fc4 <exit>
      }
      close(fd);
    19e9:	83 ec 0c             	sub    $0xc,%esp
    19ec:	ff 75 ec             	pushl  -0x14(%ebp)
    19ef:	e8 f8 25 00 00       	call   3fec <close>
    19f4:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    19f7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    19fb:	75 05                	jne    1a02 <concreate+0xf9>
      exit();
    19fd:	e8 c2 25 00 00       	call   3fc4 <exit>
    else
      wait();
    1a02:	e8 c5 25 00 00       	call   3fcc <wait>
  for(i = 0; i < 40; i++){
    1a07:	ff 45 f4             	incl   -0xc(%ebp)
    1a0a:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1a0e:	0f 8e 21 ff ff ff    	jle    1935 <concreate+0x2c>
  }

  memset(fa, 0, sizeof(fa));
    1a14:	83 ec 04             	sub    $0x4,%esp
    1a17:	6a 28                	push   $0x28
    1a19:	6a 00                	push   $0x0
    1a1b:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1a1e:	50                   	push   %eax
    1a1f:	e8 11 24 00 00       	call   3e35 <memset>
    1a24:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    1a27:	83 ec 08             	sub    $0x8,%esp
    1a2a:	6a 00                	push   $0x0
    1a2c:	68 7f 4d 00 00       	push   $0x4d7f
    1a31:	e8 ce 25 00 00       	call   4004 <open>
    1a36:	83 c4 10             	add    $0x10,%esp
    1a39:	89 45 ec             	mov    %eax,-0x14(%ebp)
  n = 0;
    1a3c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1a43:	e9 8f 00 00 00       	jmp    1ad7 <concreate+0x1ce>
    if(de.inum == 0)
    1a48:	8b 45 ac             	mov    -0x54(%ebp),%eax
    1a4b:	66 85 c0             	test   %ax,%ax
    1a4e:	0f 84 82 00 00 00    	je     1ad6 <concreate+0x1cd>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1a54:	8a 45 ae             	mov    -0x52(%ebp),%al
    1a57:	3c 43                	cmp    $0x43,%al
    1a59:	75 7c                	jne    1ad7 <concreate+0x1ce>
    1a5b:	8a 45 b0             	mov    -0x50(%ebp),%al
    1a5e:	84 c0                	test   %al,%al
    1a60:	75 75                	jne    1ad7 <concreate+0x1ce>
      i = de.name[1] - '0';
    1a62:	8a 45 af             	mov    -0x51(%ebp),%al
    1a65:	0f be c0             	movsbl %al,%eax
    1a68:	83 e8 30             	sub    $0x30,%eax
    1a6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1a6e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a72:	78 08                	js     1a7c <concreate+0x173>
    1a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a77:	83 f8 27             	cmp    $0x27,%eax
    1a7a:	76 1e                	jbe    1a9a <concreate+0x191>
        printf(1, "concreate weird file %s\n", de.name);
    1a7c:	83 ec 04             	sub    $0x4,%esp
    1a7f:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1a82:	83 c0 02             	add    $0x2,%eax
    1a85:	50                   	push   %eax
    1a86:	68 d9 4d 00 00       	push   $0x4dd9
    1a8b:	6a 01                	push   $0x1
    1a8d:	e8 a3 26 00 00       	call   4135 <printf>
    1a92:	83 c4 10             	add    $0x10,%esp
        exit();
    1a95:	e8 2a 25 00 00       	call   3fc4 <exit>
      }
      if(fa[i]){
    1a9a:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa0:	01 d0                	add    %edx,%eax
    1aa2:	8a 00                	mov    (%eax),%al
    1aa4:	84 c0                	test   %al,%al
    1aa6:	74 1e                	je     1ac6 <concreate+0x1bd>
        printf(1, "concreate duplicate file %s\n", de.name);
    1aa8:	83 ec 04             	sub    $0x4,%esp
    1aab:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1aae:	83 c0 02             	add    $0x2,%eax
    1ab1:	50                   	push   %eax
    1ab2:	68 f2 4d 00 00       	push   $0x4df2
    1ab7:	6a 01                	push   $0x1
    1ab9:	e8 77 26 00 00       	call   4135 <printf>
    1abe:	83 c4 10             	add    $0x10,%esp
        exit();
    1ac1:	e8 fe 24 00 00       	call   3fc4 <exit>
      }
      fa[i] = 1;
    1ac6:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1acc:	01 d0                	add    %edx,%eax
    1ace:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1ad1:	ff 45 f0             	incl   -0x10(%ebp)
    1ad4:	eb 01                	jmp    1ad7 <concreate+0x1ce>
      continue;
    1ad6:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1ad7:	83 ec 04             	sub    $0x4,%esp
    1ada:	6a 10                	push   $0x10
    1adc:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1adf:	50                   	push   %eax
    1ae0:	ff 75 ec             	pushl  -0x14(%ebp)
    1ae3:	e8 f4 24 00 00       	call   3fdc <read>
    1ae8:	83 c4 10             	add    $0x10,%esp
    1aeb:	85 c0                	test   %eax,%eax
    1aed:	0f 8f 55 ff ff ff    	jg     1a48 <concreate+0x13f>
    }
  }
  close(fd);
    1af3:	83 ec 0c             	sub    $0xc,%esp
    1af6:	ff 75 ec             	pushl  -0x14(%ebp)
    1af9:	e8 ee 24 00 00       	call   3fec <close>
    1afe:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    1b01:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1b05:	74 17                	je     1b1e <concreate+0x215>
    printf(1, "concreate not enough files in directory listing\n");
    1b07:	83 ec 08             	sub    $0x8,%esp
    1b0a:	68 10 4e 00 00       	push   $0x4e10
    1b0f:	6a 01                	push   $0x1
    1b11:	e8 1f 26 00 00       	call   4135 <printf>
    1b16:	83 c4 10             	add    $0x10,%esp
    exit();
    1b19:	e8 a6 24 00 00       	call   3fc4 <exit>
  }

  for(i = 0; i < 40; i++){
    1b1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b25:	e9 22 01 00 00       	jmp    1c4c <concreate+0x343>
    file[1] = '0' + i;
    1b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b2d:	83 c0 30             	add    $0x30,%eax
    1b30:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    1b33:	e8 84 24 00 00       	call   3fbc <fork>
    1b38:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    1b3b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1b3f:	79 17                	jns    1b58 <concreate+0x24f>
      printf(1, "fork failed\n");
    1b41:	83 ec 08             	sub    $0x8,%esp
    1b44:	68 85 45 00 00       	push   $0x4585
    1b49:	6a 01                	push   $0x1
    1b4b:	e8 e5 25 00 00       	call   4135 <printf>
    1b50:	83 c4 10             	add    $0x10,%esp
      exit();
    1b53:	e8 6c 24 00 00       	call   3fc4 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1b58:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b5b:	b9 03 00 00 00       	mov    $0x3,%ecx
    1b60:	99                   	cltd   
    1b61:	f7 f9                	idiv   %ecx
    1b63:	89 d0                	mov    %edx,%eax
    1b65:	85 c0                	test   %eax,%eax
    1b67:	75 06                	jne    1b6f <concreate+0x266>
    1b69:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1b6d:	74 18                	je     1b87 <concreate+0x27e>
       ((i % 3) == 1 && pid != 0)){
    1b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b72:	b9 03 00 00 00       	mov    $0x3,%ecx
    1b77:	99                   	cltd   
    1b78:	f7 f9                	idiv   %ecx
    1b7a:	89 d0                	mov    %edx,%eax
    if(((i % 3) == 0 && pid == 0) ||
    1b7c:	83 f8 01             	cmp    $0x1,%eax
    1b7f:	75 7c                	jne    1bfd <concreate+0x2f4>
       ((i % 3) == 1 && pid != 0)){
    1b81:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1b85:	74 76                	je     1bfd <concreate+0x2f4>
      close(open(file, 0));
    1b87:	83 ec 08             	sub    $0x8,%esp
    1b8a:	6a 00                	push   $0x0
    1b8c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1b8f:	50                   	push   %eax
    1b90:	e8 6f 24 00 00       	call   4004 <open>
    1b95:	83 c4 10             	add    $0x10,%esp
    1b98:	83 ec 0c             	sub    $0xc,%esp
    1b9b:	50                   	push   %eax
    1b9c:	e8 4b 24 00 00       	call   3fec <close>
    1ba1:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1ba4:	83 ec 08             	sub    $0x8,%esp
    1ba7:	6a 00                	push   $0x0
    1ba9:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bac:	50                   	push   %eax
    1bad:	e8 52 24 00 00       	call   4004 <open>
    1bb2:	83 c4 10             	add    $0x10,%esp
    1bb5:	83 ec 0c             	sub    $0xc,%esp
    1bb8:	50                   	push   %eax
    1bb9:	e8 2e 24 00 00       	call   3fec <close>
    1bbe:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1bc1:	83 ec 08             	sub    $0x8,%esp
    1bc4:	6a 00                	push   $0x0
    1bc6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bc9:	50                   	push   %eax
    1bca:	e8 35 24 00 00       	call   4004 <open>
    1bcf:	83 c4 10             	add    $0x10,%esp
    1bd2:	83 ec 0c             	sub    $0xc,%esp
    1bd5:	50                   	push   %eax
    1bd6:	e8 11 24 00 00       	call   3fec <close>
    1bdb:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1bde:	83 ec 08             	sub    $0x8,%esp
    1be1:	6a 00                	push   $0x0
    1be3:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1be6:	50                   	push   %eax
    1be7:	e8 18 24 00 00       	call   4004 <open>
    1bec:	83 c4 10             	add    $0x10,%esp
    1bef:	83 ec 0c             	sub    $0xc,%esp
    1bf2:	50                   	push   %eax
    1bf3:	e8 f4 23 00 00       	call   3fec <close>
    1bf8:	83 c4 10             	add    $0x10,%esp
    1bfb:	eb 3c                	jmp    1c39 <concreate+0x330>
    } else {
      unlink(file);
    1bfd:	83 ec 0c             	sub    $0xc,%esp
    1c00:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c03:	50                   	push   %eax
    1c04:	e8 0b 24 00 00       	call   4014 <unlink>
    1c09:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1c0c:	83 ec 0c             	sub    $0xc,%esp
    1c0f:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c12:	50                   	push   %eax
    1c13:	e8 fc 23 00 00       	call   4014 <unlink>
    1c18:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1c1b:	83 ec 0c             	sub    $0xc,%esp
    1c1e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c21:	50                   	push   %eax
    1c22:	e8 ed 23 00 00       	call   4014 <unlink>
    1c27:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1c2a:	83 ec 0c             	sub    $0xc,%esp
    1c2d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c30:	50                   	push   %eax
    1c31:	e8 de 23 00 00       	call   4014 <unlink>
    1c36:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1c39:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1c3d:	75 05                	jne    1c44 <concreate+0x33b>
      exit();
    1c3f:	e8 80 23 00 00       	call   3fc4 <exit>
    else
      wait();
    1c44:	e8 83 23 00 00       	call   3fcc <wait>
  for(i = 0; i < 40; i++){
    1c49:	ff 45 f4             	incl   -0xc(%ebp)
    1c4c:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1c50:	0f 8e d4 fe ff ff    	jle    1b2a <concreate+0x221>
  }

  printf(1, "concreate ok\n");
    1c56:	83 ec 08             	sub    $0x8,%esp
    1c59:	68 41 4e 00 00       	push   $0x4e41
    1c5e:	6a 01                	push   $0x1
    1c60:	e8 d0 24 00 00       	call   4135 <printf>
    1c65:	83 c4 10             	add    $0x10,%esp
}
    1c68:	90                   	nop
    1c69:	c9                   	leave  
    1c6a:	c3                   	ret    

00001c6b <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1c6b:	55                   	push   %ebp
    1c6c:	89 e5                	mov    %esp,%ebp
    1c6e:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1c71:	83 ec 08             	sub    $0x8,%esp
    1c74:	68 4f 4e 00 00       	push   $0x4e4f
    1c79:	6a 01                	push   $0x1
    1c7b:	e8 b5 24 00 00       	call   4135 <printf>
    1c80:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1c83:	83 ec 0c             	sub    $0xc,%esp
    1c86:	68 bb 49 00 00       	push   $0x49bb
    1c8b:	e8 84 23 00 00       	call   4014 <unlink>
    1c90:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1c93:	e8 24 23 00 00       	call   3fbc <fork>
    1c98:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1c9b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c9f:	79 17                	jns    1cb8 <linkunlink+0x4d>
    printf(1, "fork failed\n");
    1ca1:	83 ec 08             	sub    $0x8,%esp
    1ca4:	68 85 45 00 00       	push   $0x4585
    1ca9:	6a 01                	push   $0x1
    1cab:	e8 85 24 00 00       	call   4135 <printf>
    1cb0:	83 c4 10             	add    $0x10,%esp
    exit();
    1cb3:	e8 0c 23 00 00       	call   3fc4 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1cb8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1cbc:	74 07                	je     1cc5 <linkunlink+0x5a>
    1cbe:	b8 01 00 00 00       	mov    $0x1,%eax
    1cc3:	eb 05                	jmp    1cca <linkunlink+0x5f>
    1cc5:	b8 61 00 00 00       	mov    $0x61,%eax
    1cca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1ccd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1cd4:	e9 af 00 00 00       	jmp    1d88 <linkunlink+0x11d>
    x = x * 1103515245 + 12345;
    1cd9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1cdc:	89 ca                	mov    %ecx,%edx
    1cde:	89 d0                	mov    %edx,%eax
    1ce0:	c1 e0 09             	shl    $0x9,%eax
    1ce3:	89 c2                	mov    %eax,%edx
    1ce5:	29 ca                	sub    %ecx,%edx
    1ce7:	c1 e2 02             	shl    $0x2,%edx
    1cea:	01 ca                	add    %ecx,%edx
    1cec:	89 d0                	mov    %edx,%eax
    1cee:	c1 e0 09             	shl    $0x9,%eax
    1cf1:	29 d0                	sub    %edx,%eax
    1cf3:	01 c0                	add    %eax,%eax
    1cf5:	01 c8                	add    %ecx,%eax
    1cf7:	89 c2                	mov    %eax,%edx
    1cf9:	c1 e2 05             	shl    $0x5,%edx
    1cfc:	01 d0                	add    %edx,%eax
    1cfe:	c1 e0 02             	shl    $0x2,%eax
    1d01:	29 c8                	sub    %ecx,%eax
    1d03:	c1 e0 02             	shl    $0x2,%eax
    1d06:	01 c8                	add    %ecx,%eax
    1d08:	05 39 30 00 00       	add    $0x3039,%eax
    1d0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1d10:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d13:	b9 03 00 00 00       	mov    $0x3,%ecx
    1d18:	ba 00 00 00 00       	mov    $0x0,%edx
    1d1d:	f7 f1                	div    %ecx
    1d1f:	89 d0                	mov    %edx,%eax
    1d21:	85 c0                	test   %eax,%eax
    1d23:	75 23                	jne    1d48 <linkunlink+0xdd>
      close(open("x", O_RDWR | O_CREATE));
    1d25:	83 ec 08             	sub    $0x8,%esp
    1d28:	68 02 02 00 00       	push   $0x202
    1d2d:	68 bb 49 00 00       	push   $0x49bb
    1d32:	e8 cd 22 00 00       	call   4004 <open>
    1d37:	83 c4 10             	add    $0x10,%esp
    1d3a:	83 ec 0c             	sub    $0xc,%esp
    1d3d:	50                   	push   %eax
    1d3e:	e8 a9 22 00 00       	call   3fec <close>
    1d43:	83 c4 10             	add    $0x10,%esp
    1d46:	eb 3d                	jmp    1d85 <linkunlink+0x11a>
    } else if((x % 3) == 1){
    1d48:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d4b:	b9 03 00 00 00       	mov    $0x3,%ecx
    1d50:	ba 00 00 00 00       	mov    $0x0,%edx
    1d55:	f7 f1                	div    %ecx
    1d57:	89 d0                	mov    %edx,%eax
    1d59:	83 f8 01             	cmp    $0x1,%eax
    1d5c:	75 17                	jne    1d75 <linkunlink+0x10a>
      link("cat", "x");
    1d5e:	83 ec 08             	sub    $0x8,%esp
    1d61:	68 bb 49 00 00       	push   $0x49bb
    1d66:	68 60 4e 00 00       	push   $0x4e60
    1d6b:	e8 b4 22 00 00       	call   4024 <link>
    1d70:	83 c4 10             	add    $0x10,%esp
    1d73:	eb 10                	jmp    1d85 <linkunlink+0x11a>
    } else {
      unlink("x");
    1d75:	83 ec 0c             	sub    $0xc,%esp
    1d78:	68 bb 49 00 00       	push   $0x49bb
    1d7d:	e8 92 22 00 00       	call   4014 <unlink>
    1d82:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1d85:	ff 45 f4             	incl   -0xc(%ebp)
    1d88:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1d8c:	0f 8e 47 ff ff ff    	jle    1cd9 <linkunlink+0x6e>
    }
  }

  if(pid)
    1d92:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d96:	74 07                	je     1d9f <linkunlink+0x134>
    wait();
    1d98:	e8 2f 22 00 00       	call   3fcc <wait>
    1d9d:	eb 05                	jmp    1da4 <linkunlink+0x139>
  else
    exit();
    1d9f:	e8 20 22 00 00       	call   3fc4 <exit>

  printf(1, "linkunlink ok\n");
    1da4:	83 ec 08             	sub    $0x8,%esp
    1da7:	68 64 4e 00 00       	push   $0x4e64
    1dac:	6a 01                	push   $0x1
    1dae:	e8 82 23 00 00       	call   4135 <printf>
    1db3:	83 c4 10             	add    $0x10,%esp
}
    1db6:	90                   	nop
    1db7:	c9                   	leave  
    1db8:	c3                   	ret    

00001db9 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1db9:	55                   	push   %ebp
    1dba:	89 e5                	mov    %esp,%ebp
    1dbc:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1dbf:	83 ec 08             	sub    $0x8,%esp
    1dc2:	68 73 4e 00 00       	push   $0x4e73
    1dc7:	6a 01                	push   $0x1
    1dc9:	e8 67 23 00 00       	call   4135 <printf>
    1dce:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    1dd1:	83 ec 0c             	sub    $0xc,%esp
    1dd4:	68 80 4e 00 00       	push   $0x4e80
    1dd9:	e8 36 22 00 00       	call   4014 <unlink>
    1dde:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    1de1:	83 ec 08             	sub    $0x8,%esp
    1de4:	68 00 02 00 00       	push   $0x200
    1de9:	68 80 4e 00 00       	push   $0x4e80
    1dee:	e8 11 22 00 00       	call   4004 <open>
    1df3:	83 c4 10             	add    $0x10,%esp
    1df6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1df9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1dfd:	79 17                	jns    1e16 <bigdir+0x5d>
    printf(1, "bigdir create failed\n");
    1dff:	83 ec 08             	sub    $0x8,%esp
    1e02:	68 83 4e 00 00       	push   $0x4e83
    1e07:	6a 01                	push   $0x1
    1e09:	e8 27 23 00 00       	call   4135 <printf>
    1e0e:	83 c4 10             	add    $0x10,%esp
    exit();
    1e11:	e8 ae 21 00 00       	call   3fc4 <exit>
  }
  close(fd);
    1e16:	83 ec 0c             	sub    $0xc,%esp
    1e19:	ff 75 f0             	pushl  -0x10(%ebp)
    1e1c:	e8 cb 21 00 00       	call   3fec <close>
    1e21:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1e24:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e2b:	eb 64                	jmp    1e91 <bigdir+0xd8>
    name[0] = 'x';
    1e2d:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e34:	85 c0                	test   %eax,%eax
    1e36:	79 03                	jns    1e3b <bigdir+0x82>
    1e38:	83 c0 3f             	add    $0x3f,%eax
    1e3b:	c1 f8 06             	sar    $0x6,%eax
    1e3e:	83 c0 30             	add    $0x30,%eax
    1e41:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1e44:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e47:	25 3f 00 00 80       	and    $0x8000003f,%eax
    1e4c:	85 c0                	test   %eax,%eax
    1e4e:	79 05                	jns    1e55 <bigdir+0x9c>
    1e50:	48                   	dec    %eax
    1e51:	83 c8 c0             	or     $0xffffffc0,%eax
    1e54:	40                   	inc    %eax
    1e55:	83 c0 30             	add    $0x30,%eax
    1e58:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1e5b:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1e5f:	83 ec 08             	sub    $0x8,%esp
    1e62:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1e65:	50                   	push   %eax
    1e66:	68 80 4e 00 00       	push   $0x4e80
    1e6b:	e8 b4 21 00 00       	call   4024 <link>
    1e70:	83 c4 10             	add    $0x10,%esp
    1e73:	85 c0                	test   %eax,%eax
    1e75:	74 17                	je     1e8e <bigdir+0xd5>
      printf(1, "bigdir link failed\n");
    1e77:	83 ec 08             	sub    $0x8,%esp
    1e7a:	68 99 4e 00 00       	push   $0x4e99
    1e7f:	6a 01                	push   $0x1
    1e81:	e8 af 22 00 00       	call   4135 <printf>
    1e86:	83 c4 10             	add    $0x10,%esp
      exit();
    1e89:	e8 36 21 00 00       	call   3fc4 <exit>
  for(i = 0; i < 500; i++){
    1e8e:	ff 45 f4             	incl   -0xc(%ebp)
    1e91:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1e98:	7e 93                	jle    1e2d <bigdir+0x74>
    }
  }

  unlink("bd");
    1e9a:	83 ec 0c             	sub    $0xc,%esp
    1e9d:	68 80 4e 00 00       	push   $0x4e80
    1ea2:	e8 6d 21 00 00       	call   4014 <unlink>
    1ea7:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1eaa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1eb1:	eb 5f                	jmp    1f12 <bigdir+0x159>
    name[0] = 'x';
    1eb3:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1eb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eba:	85 c0                	test   %eax,%eax
    1ebc:	79 03                	jns    1ec1 <bigdir+0x108>
    1ebe:	83 c0 3f             	add    $0x3f,%eax
    1ec1:	c1 f8 06             	sar    $0x6,%eax
    1ec4:	83 c0 30             	add    $0x30,%eax
    1ec7:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1eca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ecd:	25 3f 00 00 80       	and    $0x8000003f,%eax
    1ed2:	85 c0                	test   %eax,%eax
    1ed4:	79 05                	jns    1edb <bigdir+0x122>
    1ed6:	48                   	dec    %eax
    1ed7:	83 c8 c0             	or     $0xffffffc0,%eax
    1eda:	40                   	inc    %eax
    1edb:	83 c0 30             	add    $0x30,%eax
    1ede:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1ee1:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1ee5:	83 ec 0c             	sub    $0xc,%esp
    1ee8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1eeb:	50                   	push   %eax
    1eec:	e8 23 21 00 00       	call   4014 <unlink>
    1ef1:	83 c4 10             	add    $0x10,%esp
    1ef4:	85 c0                	test   %eax,%eax
    1ef6:	74 17                	je     1f0f <bigdir+0x156>
      printf(1, "bigdir unlink failed");
    1ef8:	83 ec 08             	sub    $0x8,%esp
    1efb:	68 ad 4e 00 00       	push   $0x4ead
    1f00:	6a 01                	push   $0x1
    1f02:	e8 2e 22 00 00       	call   4135 <printf>
    1f07:	83 c4 10             	add    $0x10,%esp
      exit();
    1f0a:	e8 b5 20 00 00       	call   3fc4 <exit>
  for(i = 0; i < 500; i++){
    1f0f:	ff 45 f4             	incl   -0xc(%ebp)
    1f12:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1f19:	7e 98                	jle    1eb3 <bigdir+0xfa>
    }
  }

  printf(1, "bigdir ok\n");
    1f1b:	83 ec 08             	sub    $0x8,%esp
    1f1e:	68 c2 4e 00 00       	push   $0x4ec2
    1f23:	6a 01                	push   $0x1
    1f25:	e8 0b 22 00 00       	call   4135 <printf>
    1f2a:	83 c4 10             	add    $0x10,%esp
}
    1f2d:	90                   	nop
    1f2e:	c9                   	leave  
    1f2f:	c3                   	ret    

00001f30 <subdir>:

void
subdir(void)
{
    1f30:	55                   	push   %ebp
    1f31:	89 e5                	mov    %esp,%ebp
    1f33:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1f36:	83 ec 08             	sub    $0x8,%esp
    1f39:	68 cd 4e 00 00       	push   $0x4ecd
    1f3e:	6a 01                	push   $0x1
    1f40:	e8 f0 21 00 00       	call   4135 <printf>
    1f45:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    1f48:	83 ec 0c             	sub    $0xc,%esp
    1f4b:	68 da 4e 00 00       	push   $0x4eda
    1f50:	e8 bf 20 00 00       	call   4014 <unlink>
    1f55:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    1f58:	83 ec 0c             	sub    $0xc,%esp
    1f5b:	68 dd 4e 00 00       	push   $0x4edd
    1f60:	e8 c7 20 00 00       	call   402c <mkdir>
    1f65:	83 c4 10             	add    $0x10,%esp
    1f68:	85 c0                	test   %eax,%eax
    1f6a:	74 17                	je     1f83 <subdir+0x53>
    printf(1, "subdir mkdir dd failed\n");
    1f6c:	83 ec 08             	sub    $0x8,%esp
    1f6f:	68 e0 4e 00 00       	push   $0x4ee0
    1f74:	6a 01                	push   $0x1
    1f76:	e8 ba 21 00 00       	call   4135 <printf>
    1f7b:	83 c4 10             	add    $0x10,%esp
    exit();
    1f7e:	e8 41 20 00 00       	call   3fc4 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1f83:	83 ec 08             	sub    $0x8,%esp
    1f86:	68 02 02 00 00       	push   $0x202
    1f8b:	68 f8 4e 00 00       	push   $0x4ef8
    1f90:	e8 6f 20 00 00       	call   4004 <open>
    1f95:	83 c4 10             	add    $0x10,%esp
    1f98:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1f9b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f9f:	79 17                	jns    1fb8 <subdir+0x88>
    printf(1, "create dd/ff failed\n");
    1fa1:	83 ec 08             	sub    $0x8,%esp
    1fa4:	68 fe 4e 00 00       	push   $0x4efe
    1fa9:	6a 01                	push   $0x1
    1fab:	e8 85 21 00 00       	call   4135 <printf>
    1fb0:	83 c4 10             	add    $0x10,%esp
    exit();
    1fb3:	e8 0c 20 00 00       	call   3fc4 <exit>
  }
  write(fd, "ff", 2);
    1fb8:	83 ec 04             	sub    $0x4,%esp
    1fbb:	6a 02                	push   $0x2
    1fbd:	68 da 4e 00 00       	push   $0x4eda
    1fc2:	ff 75 f4             	pushl  -0xc(%ebp)
    1fc5:	e8 1a 20 00 00       	call   3fe4 <write>
    1fca:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1fcd:	83 ec 0c             	sub    $0xc,%esp
    1fd0:	ff 75 f4             	pushl  -0xc(%ebp)
    1fd3:	e8 14 20 00 00       	call   3fec <close>
    1fd8:	83 c4 10             	add    $0x10,%esp

  if(unlink("dd") >= 0){
    1fdb:	83 ec 0c             	sub    $0xc,%esp
    1fde:	68 dd 4e 00 00       	push   $0x4edd
    1fe3:	e8 2c 20 00 00       	call   4014 <unlink>
    1fe8:	83 c4 10             	add    $0x10,%esp
    1feb:	85 c0                	test   %eax,%eax
    1fed:	78 17                	js     2006 <subdir+0xd6>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1fef:	83 ec 08             	sub    $0x8,%esp
    1ff2:	68 14 4f 00 00       	push   $0x4f14
    1ff7:	6a 01                	push   $0x1
    1ff9:	e8 37 21 00 00       	call   4135 <printf>
    1ffe:	83 c4 10             	add    $0x10,%esp
    exit();
    2001:	e8 be 1f 00 00       	call   3fc4 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    2006:	83 ec 0c             	sub    $0xc,%esp
    2009:	68 3a 4f 00 00       	push   $0x4f3a
    200e:	e8 19 20 00 00       	call   402c <mkdir>
    2013:	83 c4 10             	add    $0x10,%esp
    2016:	85 c0                	test   %eax,%eax
    2018:	74 17                	je     2031 <subdir+0x101>
    printf(1, "subdir mkdir dd/dd failed\n");
    201a:	83 ec 08             	sub    $0x8,%esp
    201d:	68 41 4f 00 00       	push   $0x4f41
    2022:	6a 01                	push   $0x1
    2024:	e8 0c 21 00 00       	call   4135 <printf>
    2029:	83 c4 10             	add    $0x10,%esp
    exit();
    202c:	e8 93 1f 00 00       	call   3fc4 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2031:	83 ec 08             	sub    $0x8,%esp
    2034:	68 02 02 00 00       	push   $0x202
    2039:	68 5c 4f 00 00       	push   $0x4f5c
    203e:	e8 c1 1f 00 00       	call   4004 <open>
    2043:	83 c4 10             	add    $0x10,%esp
    2046:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2049:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    204d:	79 17                	jns    2066 <subdir+0x136>
    printf(1, "create dd/dd/ff failed\n");
    204f:	83 ec 08             	sub    $0x8,%esp
    2052:	68 65 4f 00 00       	push   $0x4f65
    2057:	6a 01                	push   $0x1
    2059:	e8 d7 20 00 00       	call   4135 <printf>
    205e:	83 c4 10             	add    $0x10,%esp
    exit();
    2061:	e8 5e 1f 00 00       	call   3fc4 <exit>
  }
  write(fd, "FF", 2);
    2066:	83 ec 04             	sub    $0x4,%esp
    2069:	6a 02                	push   $0x2
    206b:	68 7d 4f 00 00       	push   $0x4f7d
    2070:	ff 75 f4             	pushl  -0xc(%ebp)
    2073:	e8 6c 1f 00 00       	call   3fe4 <write>
    2078:	83 c4 10             	add    $0x10,%esp
  close(fd);
    207b:	83 ec 0c             	sub    $0xc,%esp
    207e:	ff 75 f4             	pushl  -0xc(%ebp)
    2081:	e8 66 1f 00 00       	call   3fec <close>
    2086:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    2089:	83 ec 08             	sub    $0x8,%esp
    208c:	6a 00                	push   $0x0
    208e:	68 80 4f 00 00       	push   $0x4f80
    2093:	e8 6c 1f 00 00       	call   4004 <open>
    2098:	83 c4 10             	add    $0x10,%esp
    209b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    209e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20a2:	79 17                	jns    20bb <subdir+0x18b>
    printf(1, "open dd/dd/../ff failed\n");
    20a4:	83 ec 08             	sub    $0x8,%esp
    20a7:	68 8c 4f 00 00       	push   $0x4f8c
    20ac:	6a 01                	push   $0x1
    20ae:	e8 82 20 00 00       	call   4135 <printf>
    20b3:	83 c4 10             	add    $0x10,%esp
    exit();
    20b6:	e8 09 1f 00 00       	call   3fc4 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    20bb:	83 ec 04             	sub    $0x4,%esp
    20be:	68 00 20 00 00       	push   $0x2000
    20c3:	68 60 5d 00 00       	push   $0x5d60
    20c8:	ff 75 f4             	pushl  -0xc(%ebp)
    20cb:	e8 0c 1f 00 00       	call   3fdc <read>
    20d0:	83 c4 10             	add    $0x10,%esp
    20d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    20d6:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    20da:	75 09                	jne    20e5 <subdir+0x1b5>
    20dc:	a0 60 5d 00 00       	mov    0x5d60,%al
    20e1:	3c 66                	cmp    $0x66,%al
    20e3:	74 17                	je     20fc <subdir+0x1cc>
    printf(1, "dd/dd/../ff wrong content\n");
    20e5:	83 ec 08             	sub    $0x8,%esp
    20e8:	68 a5 4f 00 00       	push   $0x4fa5
    20ed:	6a 01                	push   $0x1
    20ef:	e8 41 20 00 00       	call   4135 <printf>
    20f4:	83 c4 10             	add    $0x10,%esp
    exit();
    20f7:	e8 c8 1e 00 00       	call   3fc4 <exit>
  }
  close(fd);
    20fc:	83 ec 0c             	sub    $0xc,%esp
    20ff:	ff 75 f4             	pushl  -0xc(%ebp)
    2102:	e8 e5 1e 00 00       	call   3fec <close>
    2107:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    210a:	83 ec 08             	sub    $0x8,%esp
    210d:	68 c0 4f 00 00       	push   $0x4fc0
    2112:	68 5c 4f 00 00       	push   $0x4f5c
    2117:	e8 08 1f 00 00       	call   4024 <link>
    211c:	83 c4 10             	add    $0x10,%esp
    211f:	85 c0                	test   %eax,%eax
    2121:	74 17                	je     213a <subdir+0x20a>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2123:	83 ec 08             	sub    $0x8,%esp
    2126:	68 cc 4f 00 00       	push   $0x4fcc
    212b:	6a 01                	push   $0x1
    212d:	e8 03 20 00 00       	call   4135 <printf>
    2132:	83 c4 10             	add    $0x10,%esp
    exit();
    2135:	e8 8a 1e 00 00       	call   3fc4 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    213a:	83 ec 0c             	sub    $0xc,%esp
    213d:	68 5c 4f 00 00       	push   $0x4f5c
    2142:	e8 cd 1e 00 00       	call   4014 <unlink>
    2147:	83 c4 10             	add    $0x10,%esp
    214a:	85 c0                	test   %eax,%eax
    214c:	74 17                	je     2165 <subdir+0x235>
    printf(1, "unlink dd/dd/ff failed\n");
    214e:	83 ec 08             	sub    $0x8,%esp
    2151:	68 ed 4f 00 00       	push   $0x4fed
    2156:	6a 01                	push   $0x1
    2158:	e8 d8 1f 00 00       	call   4135 <printf>
    215d:	83 c4 10             	add    $0x10,%esp
    exit();
    2160:	e8 5f 1e 00 00       	call   3fc4 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2165:	83 ec 08             	sub    $0x8,%esp
    2168:	6a 00                	push   $0x0
    216a:	68 5c 4f 00 00       	push   $0x4f5c
    216f:	e8 90 1e 00 00       	call   4004 <open>
    2174:	83 c4 10             	add    $0x10,%esp
    2177:	85 c0                	test   %eax,%eax
    2179:	78 17                	js     2192 <subdir+0x262>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    217b:	83 ec 08             	sub    $0x8,%esp
    217e:	68 08 50 00 00       	push   $0x5008
    2183:	6a 01                	push   $0x1
    2185:	e8 ab 1f 00 00       	call   4135 <printf>
    218a:	83 c4 10             	add    $0x10,%esp
    exit();
    218d:	e8 32 1e 00 00       	call   3fc4 <exit>
  }

  if(chdir("dd") != 0){
    2192:	83 ec 0c             	sub    $0xc,%esp
    2195:	68 dd 4e 00 00       	push   $0x4edd
    219a:	e8 95 1e 00 00       	call   4034 <chdir>
    219f:	83 c4 10             	add    $0x10,%esp
    21a2:	85 c0                	test   %eax,%eax
    21a4:	74 17                	je     21bd <subdir+0x28d>
    printf(1, "chdir dd failed\n");
    21a6:	83 ec 08             	sub    $0x8,%esp
    21a9:	68 2c 50 00 00       	push   $0x502c
    21ae:	6a 01                	push   $0x1
    21b0:	e8 80 1f 00 00       	call   4135 <printf>
    21b5:	83 c4 10             	add    $0x10,%esp
    exit();
    21b8:	e8 07 1e 00 00       	call   3fc4 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    21bd:	83 ec 0c             	sub    $0xc,%esp
    21c0:	68 3d 50 00 00       	push   $0x503d
    21c5:	e8 6a 1e 00 00       	call   4034 <chdir>
    21ca:	83 c4 10             	add    $0x10,%esp
    21cd:	85 c0                	test   %eax,%eax
    21cf:	74 17                	je     21e8 <subdir+0x2b8>
    printf(1, "chdir dd/../../dd failed\n");
    21d1:	83 ec 08             	sub    $0x8,%esp
    21d4:	68 49 50 00 00       	push   $0x5049
    21d9:	6a 01                	push   $0x1
    21db:	e8 55 1f 00 00       	call   4135 <printf>
    21e0:	83 c4 10             	add    $0x10,%esp
    exit();
    21e3:	e8 dc 1d 00 00       	call   3fc4 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    21e8:	83 ec 0c             	sub    $0xc,%esp
    21eb:	68 63 50 00 00       	push   $0x5063
    21f0:	e8 3f 1e 00 00       	call   4034 <chdir>
    21f5:	83 c4 10             	add    $0x10,%esp
    21f8:	85 c0                	test   %eax,%eax
    21fa:	74 17                	je     2213 <subdir+0x2e3>
    printf(1, "chdir dd/../../dd failed\n");
    21fc:	83 ec 08             	sub    $0x8,%esp
    21ff:	68 49 50 00 00       	push   $0x5049
    2204:	6a 01                	push   $0x1
    2206:	e8 2a 1f 00 00       	call   4135 <printf>
    220b:	83 c4 10             	add    $0x10,%esp
    exit();
    220e:	e8 b1 1d 00 00       	call   3fc4 <exit>
  }
  if(chdir("./..") != 0){
    2213:	83 ec 0c             	sub    $0xc,%esp
    2216:	68 72 50 00 00       	push   $0x5072
    221b:	e8 14 1e 00 00       	call   4034 <chdir>
    2220:	83 c4 10             	add    $0x10,%esp
    2223:	85 c0                	test   %eax,%eax
    2225:	74 17                	je     223e <subdir+0x30e>
    printf(1, "chdir ./.. failed\n");
    2227:	83 ec 08             	sub    $0x8,%esp
    222a:	68 77 50 00 00       	push   $0x5077
    222f:	6a 01                	push   $0x1
    2231:	e8 ff 1e 00 00       	call   4135 <printf>
    2236:	83 c4 10             	add    $0x10,%esp
    exit();
    2239:	e8 86 1d 00 00       	call   3fc4 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    223e:	83 ec 08             	sub    $0x8,%esp
    2241:	6a 00                	push   $0x0
    2243:	68 c0 4f 00 00       	push   $0x4fc0
    2248:	e8 b7 1d 00 00       	call   4004 <open>
    224d:	83 c4 10             	add    $0x10,%esp
    2250:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2253:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2257:	79 17                	jns    2270 <subdir+0x340>
    printf(1, "open dd/dd/ffff failed\n");
    2259:	83 ec 08             	sub    $0x8,%esp
    225c:	68 8a 50 00 00       	push   $0x508a
    2261:	6a 01                	push   $0x1
    2263:	e8 cd 1e 00 00       	call   4135 <printf>
    2268:	83 c4 10             	add    $0x10,%esp
    exit();
    226b:	e8 54 1d 00 00       	call   3fc4 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    2270:	83 ec 04             	sub    $0x4,%esp
    2273:	68 00 20 00 00       	push   $0x2000
    2278:	68 60 5d 00 00       	push   $0x5d60
    227d:	ff 75 f4             	pushl  -0xc(%ebp)
    2280:	e8 57 1d 00 00       	call   3fdc <read>
    2285:	83 c4 10             	add    $0x10,%esp
    2288:	83 f8 02             	cmp    $0x2,%eax
    228b:	74 17                	je     22a4 <subdir+0x374>
    printf(1, "read dd/dd/ffff wrong len\n");
    228d:	83 ec 08             	sub    $0x8,%esp
    2290:	68 a2 50 00 00       	push   $0x50a2
    2295:	6a 01                	push   $0x1
    2297:	e8 99 1e 00 00       	call   4135 <printf>
    229c:	83 c4 10             	add    $0x10,%esp
    exit();
    229f:	e8 20 1d 00 00       	call   3fc4 <exit>
  }
  close(fd);
    22a4:	83 ec 0c             	sub    $0xc,%esp
    22a7:	ff 75 f4             	pushl  -0xc(%ebp)
    22aa:	e8 3d 1d 00 00       	call   3fec <close>
    22af:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    22b2:	83 ec 08             	sub    $0x8,%esp
    22b5:	6a 00                	push   $0x0
    22b7:	68 5c 4f 00 00       	push   $0x4f5c
    22bc:	e8 43 1d 00 00       	call   4004 <open>
    22c1:	83 c4 10             	add    $0x10,%esp
    22c4:	85 c0                	test   %eax,%eax
    22c6:	78 17                	js     22df <subdir+0x3af>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    22c8:	83 ec 08             	sub    $0x8,%esp
    22cb:	68 c0 50 00 00       	push   $0x50c0
    22d0:	6a 01                	push   $0x1
    22d2:	e8 5e 1e 00 00       	call   4135 <printf>
    22d7:	83 c4 10             	add    $0x10,%esp
    exit();
    22da:	e8 e5 1c 00 00       	call   3fc4 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    22df:	83 ec 08             	sub    $0x8,%esp
    22e2:	68 02 02 00 00       	push   $0x202
    22e7:	68 e5 50 00 00       	push   $0x50e5
    22ec:	e8 13 1d 00 00       	call   4004 <open>
    22f1:	83 c4 10             	add    $0x10,%esp
    22f4:	85 c0                	test   %eax,%eax
    22f6:	78 17                	js     230f <subdir+0x3df>
    printf(1, "create dd/ff/ff succeeded!\n");
    22f8:	83 ec 08             	sub    $0x8,%esp
    22fb:	68 ee 50 00 00       	push   $0x50ee
    2300:	6a 01                	push   $0x1
    2302:	e8 2e 1e 00 00       	call   4135 <printf>
    2307:	83 c4 10             	add    $0x10,%esp
    exit();
    230a:	e8 b5 1c 00 00       	call   3fc4 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    230f:	83 ec 08             	sub    $0x8,%esp
    2312:	68 02 02 00 00       	push   $0x202
    2317:	68 0a 51 00 00       	push   $0x510a
    231c:	e8 e3 1c 00 00       	call   4004 <open>
    2321:	83 c4 10             	add    $0x10,%esp
    2324:	85 c0                	test   %eax,%eax
    2326:	78 17                	js     233f <subdir+0x40f>
    printf(1, "create dd/xx/ff succeeded!\n");
    2328:	83 ec 08             	sub    $0x8,%esp
    232b:	68 13 51 00 00       	push   $0x5113
    2330:	6a 01                	push   $0x1
    2332:	e8 fe 1d 00 00       	call   4135 <printf>
    2337:	83 c4 10             	add    $0x10,%esp
    exit();
    233a:	e8 85 1c 00 00       	call   3fc4 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    233f:	83 ec 08             	sub    $0x8,%esp
    2342:	68 00 02 00 00       	push   $0x200
    2347:	68 dd 4e 00 00       	push   $0x4edd
    234c:	e8 b3 1c 00 00       	call   4004 <open>
    2351:	83 c4 10             	add    $0x10,%esp
    2354:	85 c0                	test   %eax,%eax
    2356:	78 17                	js     236f <subdir+0x43f>
    printf(1, "create dd succeeded!\n");
    2358:	83 ec 08             	sub    $0x8,%esp
    235b:	68 2f 51 00 00       	push   $0x512f
    2360:	6a 01                	push   $0x1
    2362:	e8 ce 1d 00 00       	call   4135 <printf>
    2367:	83 c4 10             	add    $0x10,%esp
    exit();
    236a:	e8 55 1c 00 00       	call   3fc4 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    236f:	83 ec 08             	sub    $0x8,%esp
    2372:	6a 02                	push   $0x2
    2374:	68 dd 4e 00 00       	push   $0x4edd
    2379:	e8 86 1c 00 00       	call   4004 <open>
    237e:	83 c4 10             	add    $0x10,%esp
    2381:	85 c0                	test   %eax,%eax
    2383:	78 17                	js     239c <subdir+0x46c>
    printf(1, "open dd rdwr succeeded!\n");
    2385:	83 ec 08             	sub    $0x8,%esp
    2388:	68 45 51 00 00       	push   $0x5145
    238d:	6a 01                	push   $0x1
    238f:	e8 a1 1d 00 00       	call   4135 <printf>
    2394:	83 c4 10             	add    $0x10,%esp
    exit();
    2397:	e8 28 1c 00 00       	call   3fc4 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    239c:	83 ec 08             	sub    $0x8,%esp
    239f:	6a 01                	push   $0x1
    23a1:	68 dd 4e 00 00       	push   $0x4edd
    23a6:	e8 59 1c 00 00       	call   4004 <open>
    23ab:	83 c4 10             	add    $0x10,%esp
    23ae:	85 c0                	test   %eax,%eax
    23b0:	78 17                	js     23c9 <subdir+0x499>
    printf(1, "open dd wronly succeeded!\n");
    23b2:	83 ec 08             	sub    $0x8,%esp
    23b5:	68 5e 51 00 00       	push   $0x515e
    23ba:	6a 01                	push   $0x1
    23bc:	e8 74 1d 00 00       	call   4135 <printf>
    23c1:	83 c4 10             	add    $0x10,%esp
    exit();
    23c4:	e8 fb 1b 00 00       	call   3fc4 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    23c9:	83 ec 08             	sub    $0x8,%esp
    23cc:	68 79 51 00 00       	push   $0x5179
    23d1:	68 e5 50 00 00       	push   $0x50e5
    23d6:	e8 49 1c 00 00       	call   4024 <link>
    23db:	83 c4 10             	add    $0x10,%esp
    23de:	85 c0                	test   %eax,%eax
    23e0:	75 17                	jne    23f9 <subdir+0x4c9>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    23e2:	83 ec 08             	sub    $0x8,%esp
    23e5:	68 84 51 00 00       	push   $0x5184
    23ea:	6a 01                	push   $0x1
    23ec:	e8 44 1d 00 00       	call   4135 <printf>
    23f1:	83 c4 10             	add    $0x10,%esp
    exit();
    23f4:	e8 cb 1b 00 00       	call   3fc4 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    23f9:	83 ec 08             	sub    $0x8,%esp
    23fc:	68 79 51 00 00       	push   $0x5179
    2401:	68 0a 51 00 00       	push   $0x510a
    2406:	e8 19 1c 00 00       	call   4024 <link>
    240b:	83 c4 10             	add    $0x10,%esp
    240e:	85 c0                	test   %eax,%eax
    2410:	75 17                	jne    2429 <subdir+0x4f9>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2412:	83 ec 08             	sub    $0x8,%esp
    2415:	68 a8 51 00 00       	push   $0x51a8
    241a:	6a 01                	push   $0x1
    241c:	e8 14 1d 00 00       	call   4135 <printf>
    2421:	83 c4 10             	add    $0x10,%esp
    exit();
    2424:	e8 9b 1b 00 00       	call   3fc4 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2429:	83 ec 08             	sub    $0x8,%esp
    242c:	68 c0 4f 00 00       	push   $0x4fc0
    2431:	68 f8 4e 00 00       	push   $0x4ef8
    2436:	e8 e9 1b 00 00       	call   4024 <link>
    243b:	83 c4 10             	add    $0x10,%esp
    243e:	85 c0                	test   %eax,%eax
    2440:	75 17                	jne    2459 <subdir+0x529>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2442:	83 ec 08             	sub    $0x8,%esp
    2445:	68 cc 51 00 00       	push   $0x51cc
    244a:	6a 01                	push   $0x1
    244c:	e8 e4 1c 00 00       	call   4135 <printf>
    2451:	83 c4 10             	add    $0x10,%esp
    exit();
    2454:	e8 6b 1b 00 00       	call   3fc4 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    2459:	83 ec 0c             	sub    $0xc,%esp
    245c:	68 e5 50 00 00       	push   $0x50e5
    2461:	e8 c6 1b 00 00       	call   402c <mkdir>
    2466:	83 c4 10             	add    $0x10,%esp
    2469:	85 c0                	test   %eax,%eax
    246b:	75 17                	jne    2484 <subdir+0x554>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    246d:	83 ec 08             	sub    $0x8,%esp
    2470:	68 ee 51 00 00       	push   $0x51ee
    2475:	6a 01                	push   $0x1
    2477:	e8 b9 1c 00 00       	call   4135 <printf>
    247c:	83 c4 10             	add    $0x10,%esp
    exit();
    247f:	e8 40 1b 00 00       	call   3fc4 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2484:	83 ec 0c             	sub    $0xc,%esp
    2487:	68 0a 51 00 00       	push   $0x510a
    248c:	e8 9b 1b 00 00       	call   402c <mkdir>
    2491:	83 c4 10             	add    $0x10,%esp
    2494:	85 c0                	test   %eax,%eax
    2496:	75 17                	jne    24af <subdir+0x57f>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2498:	83 ec 08             	sub    $0x8,%esp
    249b:	68 09 52 00 00       	push   $0x5209
    24a0:	6a 01                	push   $0x1
    24a2:	e8 8e 1c 00 00       	call   4135 <printf>
    24a7:	83 c4 10             	add    $0x10,%esp
    exit();
    24aa:	e8 15 1b 00 00       	call   3fc4 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    24af:	83 ec 0c             	sub    $0xc,%esp
    24b2:	68 c0 4f 00 00       	push   $0x4fc0
    24b7:	e8 70 1b 00 00       	call   402c <mkdir>
    24bc:	83 c4 10             	add    $0x10,%esp
    24bf:	85 c0                	test   %eax,%eax
    24c1:	75 17                	jne    24da <subdir+0x5aa>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    24c3:	83 ec 08             	sub    $0x8,%esp
    24c6:	68 24 52 00 00       	push   $0x5224
    24cb:	6a 01                	push   $0x1
    24cd:	e8 63 1c 00 00       	call   4135 <printf>
    24d2:	83 c4 10             	add    $0x10,%esp
    exit();
    24d5:	e8 ea 1a 00 00       	call   3fc4 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    24da:	83 ec 0c             	sub    $0xc,%esp
    24dd:	68 0a 51 00 00       	push   $0x510a
    24e2:	e8 2d 1b 00 00       	call   4014 <unlink>
    24e7:	83 c4 10             	add    $0x10,%esp
    24ea:	85 c0                	test   %eax,%eax
    24ec:	75 17                	jne    2505 <subdir+0x5d5>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    24ee:	83 ec 08             	sub    $0x8,%esp
    24f1:	68 41 52 00 00       	push   $0x5241
    24f6:	6a 01                	push   $0x1
    24f8:	e8 38 1c 00 00       	call   4135 <printf>
    24fd:	83 c4 10             	add    $0x10,%esp
    exit();
    2500:	e8 bf 1a 00 00       	call   3fc4 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    2505:	83 ec 0c             	sub    $0xc,%esp
    2508:	68 e5 50 00 00       	push   $0x50e5
    250d:	e8 02 1b 00 00       	call   4014 <unlink>
    2512:	83 c4 10             	add    $0x10,%esp
    2515:	85 c0                	test   %eax,%eax
    2517:	75 17                	jne    2530 <subdir+0x600>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2519:	83 ec 08             	sub    $0x8,%esp
    251c:	68 5d 52 00 00       	push   $0x525d
    2521:	6a 01                	push   $0x1
    2523:	e8 0d 1c 00 00       	call   4135 <printf>
    2528:	83 c4 10             	add    $0x10,%esp
    exit();
    252b:	e8 94 1a 00 00       	call   3fc4 <exit>
  }
  if(chdir("dd/ff") == 0){
    2530:	83 ec 0c             	sub    $0xc,%esp
    2533:	68 f8 4e 00 00       	push   $0x4ef8
    2538:	e8 f7 1a 00 00       	call   4034 <chdir>
    253d:	83 c4 10             	add    $0x10,%esp
    2540:	85 c0                	test   %eax,%eax
    2542:	75 17                	jne    255b <subdir+0x62b>
    printf(1, "chdir dd/ff succeeded!\n");
    2544:	83 ec 08             	sub    $0x8,%esp
    2547:	68 79 52 00 00       	push   $0x5279
    254c:	6a 01                	push   $0x1
    254e:	e8 e2 1b 00 00       	call   4135 <printf>
    2553:	83 c4 10             	add    $0x10,%esp
    exit();
    2556:	e8 69 1a 00 00       	call   3fc4 <exit>
  }
  if(chdir("dd/xx") == 0){
    255b:	83 ec 0c             	sub    $0xc,%esp
    255e:	68 91 52 00 00       	push   $0x5291
    2563:	e8 cc 1a 00 00       	call   4034 <chdir>
    2568:	83 c4 10             	add    $0x10,%esp
    256b:	85 c0                	test   %eax,%eax
    256d:	75 17                	jne    2586 <subdir+0x656>
    printf(1, "chdir dd/xx succeeded!\n");
    256f:	83 ec 08             	sub    $0x8,%esp
    2572:	68 97 52 00 00       	push   $0x5297
    2577:	6a 01                	push   $0x1
    2579:	e8 b7 1b 00 00       	call   4135 <printf>
    257e:	83 c4 10             	add    $0x10,%esp
    exit();
    2581:	e8 3e 1a 00 00       	call   3fc4 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2586:	83 ec 0c             	sub    $0xc,%esp
    2589:	68 c0 4f 00 00       	push   $0x4fc0
    258e:	e8 81 1a 00 00       	call   4014 <unlink>
    2593:	83 c4 10             	add    $0x10,%esp
    2596:	85 c0                	test   %eax,%eax
    2598:	74 17                	je     25b1 <subdir+0x681>
    printf(1, "unlink dd/dd/ff failed\n");
    259a:	83 ec 08             	sub    $0x8,%esp
    259d:	68 ed 4f 00 00       	push   $0x4fed
    25a2:	6a 01                	push   $0x1
    25a4:	e8 8c 1b 00 00       	call   4135 <printf>
    25a9:	83 c4 10             	add    $0x10,%esp
    exit();
    25ac:	e8 13 1a 00 00       	call   3fc4 <exit>
  }
  if(unlink("dd/ff") != 0){
    25b1:	83 ec 0c             	sub    $0xc,%esp
    25b4:	68 f8 4e 00 00       	push   $0x4ef8
    25b9:	e8 56 1a 00 00       	call   4014 <unlink>
    25be:	83 c4 10             	add    $0x10,%esp
    25c1:	85 c0                	test   %eax,%eax
    25c3:	74 17                	je     25dc <subdir+0x6ac>
    printf(1, "unlink dd/ff failed\n");
    25c5:	83 ec 08             	sub    $0x8,%esp
    25c8:	68 af 52 00 00       	push   $0x52af
    25cd:	6a 01                	push   $0x1
    25cf:	e8 61 1b 00 00       	call   4135 <printf>
    25d4:	83 c4 10             	add    $0x10,%esp
    exit();
    25d7:	e8 e8 19 00 00       	call   3fc4 <exit>
  }
  if(unlink("dd") == 0){
    25dc:	83 ec 0c             	sub    $0xc,%esp
    25df:	68 dd 4e 00 00       	push   $0x4edd
    25e4:	e8 2b 1a 00 00       	call   4014 <unlink>
    25e9:	83 c4 10             	add    $0x10,%esp
    25ec:	85 c0                	test   %eax,%eax
    25ee:	75 17                	jne    2607 <subdir+0x6d7>
    printf(1, "unlink non-empty dd succeeded!\n");
    25f0:	83 ec 08             	sub    $0x8,%esp
    25f3:	68 c4 52 00 00       	push   $0x52c4
    25f8:	6a 01                	push   $0x1
    25fa:	e8 36 1b 00 00       	call   4135 <printf>
    25ff:	83 c4 10             	add    $0x10,%esp
    exit();
    2602:	e8 bd 19 00 00       	call   3fc4 <exit>
  }
  if(unlink("dd/dd") < 0){
    2607:	83 ec 0c             	sub    $0xc,%esp
    260a:	68 e4 52 00 00       	push   $0x52e4
    260f:	e8 00 1a 00 00       	call   4014 <unlink>
    2614:	83 c4 10             	add    $0x10,%esp
    2617:	85 c0                	test   %eax,%eax
    2619:	79 17                	jns    2632 <subdir+0x702>
    printf(1, "unlink dd/dd failed\n");
    261b:	83 ec 08             	sub    $0x8,%esp
    261e:	68 ea 52 00 00       	push   $0x52ea
    2623:	6a 01                	push   $0x1
    2625:	e8 0b 1b 00 00       	call   4135 <printf>
    262a:	83 c4 10             	add    $0x10,%esp
    exit();
    262d:	e8 92 19 00 00       	call   3fc4 <exit>
  }
  if(unlink("dd") < 0){
    2632:	83 ec 0c             	sub    $0xc,%esp
    2635:	68 dd 4e 00 00       	push   $0x4edd
    263a:	e8 d5 19 00 00       	call   4014 <unlink>
    263f:	83 c4 10             	add    $0x10,%esp
    2642:	85 c0                	test   %eax,%eax
    2644:	79 17                	jns    265d <subdir+0x72d>
    printf(1, "unlink dd failed\n");
    2646:	83 ec 08             	sub    $0x8,%esp
    2649:	68 ff 52 00 00       	push   $0x52ff
    264e:	6a 01                	push   $0x1
    2650:	e8 e0 1a 00 00       	call   4135 <printf>
    2655:	83 c4 10             	add    $0x10,%esp
    exit();
    2658:	e8 67 19 00 00       	call   3fc4 <exit>
  }

  printf(1, "subdir ok\n");
    265d:	83 ec 08             	sub    $0x8,%esp
    2660:	68 11 53 00 00       	push   $0x5311
    2665:	6a 01                	push   $0x1
    2667:	e8 c9 1a 00 00       	call   4135 <printf>
    266c:	83 c4 10             	add    $0x10,%esp
}
    266f:	90                   	nop
    2670:	c9                   	leave  
    2671:	c3                   	ret    

00002672 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2672:	55                   	push   %ebp
    2673:	89 e5                	mov    %esp,%ebp
    2675:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    2678:	83 ec 08             	sub    $0x8,%esp
    267b:	68 1c 53 00 00       	push   $0x531c
    2680:	6a 01                	push   $0x1
    2682:	e8 ae 1a 00 00       	call   4135 <printf>
    2687:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    268a:	83 ec 0c             	sub    $0xc,%esp
    268d:	68 2b 53 00 00       	push   $0x532b
    2692:	e8 7d 19 00 00       	call   4014 <unlink>
    2697:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    269a:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    26a1:	e9 a7 00 00 00       	jmp    274d <bigwrite+0xdb>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    26a6:	83 ec 08             	sub    $0x8,%esp
    26a9:	68 02 02 00 00       	push   $0x202
    26ae:	68 2b 53 00 00       	push   $0x532b
    26b3:	e8 4c 19 00 00       	call   4004 <open>
    26b8:	83 c4 10             	add    $0x10,%esp
    26bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    26be:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    26c2:	79 17                	jns    26db <bigwrite+0x69>
      printf(1, "cannot create bigwrite\n");
    26c4:	83 ec 08             	sub    $0x8,%esp
    26c7:	68 34 53 00 00       	push   $0x5334
    26cc:	6a 01                	push   $0x1
    26ce:	e8 62 1a 00 00       	call   4135 <printf>
    26d3:	83 c4 10             	add    $0x10,%esp
      exit();
    26d6:	e8 e9 18 00 00       	call   3fc4 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    26db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    26e2:	eb 3e                	jmp    2722 <bigwrite+0xb0>
      int cc = write(fd, buf, sz);
    26e4:	83 ec 04             	sub    $0x4,%esp
    26e7:	ff 75 f4             	pushl  -0xc(%ebp)
    26ea:	68 60 5d 00 00       	push   $0x5d60
    26ef:	ff 75 ec             	pushl  -0x14(%ebp)
    26f2:	e8 ed 18 00 00       	call   3fe4 <write>
    26f7:	83 c4 10             	add    $0x10,%esp
    26fa:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    26fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2700:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2703:	74 1a                	je     271f <bigwrite+0xad>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2705:	ff 75 e8             	pushl  -0x18(%ebp)
    2708:	ff 75 f4             	pushl  -0xc(%ebp)
    270b:	68 4c 53 00 00       	push   $0x534c
    2710:	6a 01                	push   $0x1
    2712:	e8 1e 1a 00 00       	call   4135 <printf>
    2717:	83 c4 10             	add    $0x10,%esp
        exit();
    271a:	e8 a5 18 00 00       	call   3fc4 <exit>
    for(i = 0; i < 2; i++){
    271f:	ff 45 f0             	incl   -0x10(%ebp)
    2722:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    2726:	7e bc                	jle    26e4 <bigwrite+0x72>
      }
    }
    close(fd);
    2728:	83 ec 0c             	sub    $0xc,%esp
    272b:	ff 75 ec             	pushl  -0x14(%ebp)
    272e:	e8 b9 18 00 00       	call   3fec <close>
    2733:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    2736:	83 ec 0c             	sub    $0xc,%esp
    2739:	68 2b 53 00 00       	push   $0x532b
    273e:	e8 d1 18 00 00       	call   4014 <unlink>
    2743:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    2746:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    274d:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    2754:	0f 8e 4c ff ff ff    	jle    26a6 <bigwrite+0x34>
  }

  printf(1, "bigwrite ok\n");
    275a:	83 ec 08             	sub    $0x8,%esp
    275d:	68 5e 53 00 00       	push   $0x535e
    2762:	6a 01                	push   $0x1
    2764:	e8 cc 19 00 00       	call   4135 <printf>
    2769:	83 c4 10             	add    $0x10,%esp
}
    276c:	90                   	nop
    276d:	c9                   	leave  
    276e:	c3                   	ret    

0000276f <bigfile>:

void
bigfile(void)
{
    276f:	55                   	push   %ebp
    2770:	89 e5                	mov    %esp,%ebp
    2772:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2775:	83 ec 08             	sub    $0x8,%esp
    2778:	68 6b 53 00 00       	push   $0x536b
    277d:	6a 01                	push   $0x1
    277f:	e8 b1 19 00 00       	call   4135 <printf>
    2784:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    2787:	83 ec 0c             	sub    $0xc,%esp
    278a:	68 79 53 00 00       	push   $0x5379
    278f:	e8 80 18 00 00       	call   4014 <unlink>
    2794:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    2797:	83 ec 08             	sub    $0x8,%esp
    279a:	68 02 02 00 00       	push   $0x202
    279f:	68 79 53 00 00       	push   $0x5379
    27a4:	e8 5b 18 00 00       	call   4004 <open>
    27a9:	83 c4 10             	add    $0x10,%esp
    27ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    27af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    27b3:	79 17                	jns    27cc <bigfile+0x5d>
    printf(1, "cannot create bigfile");
    27b5:	83 ec 08             	sub    $0x8,%esp
    27b8:	68 81 53 00 00       	push   $0x5381
    27bd:	6a 01                	push   $0x1
    27bf:	e8 71 19 00 00       	call   4135 <printf>
    27c4:	83 c4 10             	add    $0x10,%esp
    exit();
    27c7:	e8 f8 17 00 00       	call   3fc4 <exit>
  }
  for(i = 0; i < 20; i++){
    27cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    27d3:	eb 51                	jmp    2826 <bigfile+0xb7>
    memset(buf, i, 600);
    27d5:	83 ec 04             	sub    $0x4,%esp
    27d8:	68 58 02 00 00       	push   $0x258
    27dd:	ff 75 f4             	pushl  -0xc(%ebp)
    27e0:	68 60 5d 00 00       	push   $0x5d60
    27e5:	e8 4b 16 00 00       	call   3e35 <memset>
    27ea:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    27ed:	83 ec 04             	sub    $0x4,%esp
    27f0:	68 58 02 00 00       	push   $0x258
    27f5:	68 60 5d 00 00       	push   $0x5d60
    27fa:	ff 75 ec             	pushl  -0x14(%ebp)
    27fd:	e8 e2 17 00 00       	call   3fe4 <write>
    2802:	83 c4 10             	add    $0x10,%esp
    2805:	3d 58 02 00 00       	cmp    $0x258,%eax
    280a:	74 17                	je     2823 <bigfile+0xb4>
      printf(1, "write bigfile failed\n");
    280c:	83 ec 08             	sub    $0x8,%esp
    280f:	68 97 53 00 00       	push   $0x5397
    2814:	6a 01                	push   $0x1
    2816:	e8 1a 19 00 00       	call   4135 <printf>
    281b:	83 c4 10             	add    $0x10,%esp
      exit();
    281e:	e8 a1 17 00 00       	call   3fc4 <exit>
  for(i = 0; i < 20; i++){
    2823:	ff 45 f4             	incl   -0xc(%ebp)
    2826:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    282a:	7e a9                	jle    27d5 <bigfile+0x66>
    }
  }
  close(fd);
    282c:	83 ec 0c             	sub    $0xc,%esp
    282f:	ff 75 ec             	pushl  -0x14(%ebp)
    2832:	e8 b5 17 00 00       	call   3fec <close>
    2837:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    283a:	83 ec 08             	sub    $0x8,%esp
    283d:	6a 00                	push   $0x0
    283f:	68 79 53 00 00       	push   $0x5379
    2844:	e8 bb 17 00 00       	call   4004 <open>
    2849:	83 c4 10             	add    $0x10,%esp
    284c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    284f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2853:	79 17                	jns    286c <bigfile+0xfd>
    printf(1, "cannot open bigfile\n");
    2855:	83 ec 08             	sub    $0x8,%esp
    2858:	68 ad 53 00 00       	push   $0x53ad
    285d:	6a 01                	push   $0x1
    285f:	e8 d1 18 00 00       	call   4135 <printf>
    2864:	83 c4 10             	add    $0x10,%esp
    exit();
    2867:	e8 58 17 00 00       	call   3fc4 <exit>
  }
  total = 0;
    286c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    2873:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    287a:	83 ec 04             	sub    $0x4,%esp
    287d:	68 2c 01 00 00       	push   $0x12c
    2882:	68 60 5d 00 00       	push   $0x5d60
    2887:	ff 75 ec             	pushl  -0x14(%ebp)
    288a:	e8 4d 17 00 00       	call   3fdc <read>
    288f:	83 c4 10             	add    $0x10,%esp
    2892:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    2895:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2899:	79 17                	jns    28b2 <bigfile+0x143>
      printf(1, "read bigfile failed\n");
    289b:	83 ec 08             	sub    $0x8,%esp
    289e:	68 c2 53 00 00       	push   $0x53c2
    28a3:	6a 01                	push   $0x1
    28a5:	e8 8b 18 00 00       	call   4135 <printf>
    28aa:	83 c4 10             	add    $0x10,%esp
      exit();
    28ad:	e8 12 17 00 00       	call   3fc4 <exit>
    }
    if(cc == 0)
    28b2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    28b6:	74 75                	je     292d <bigfile+0x1be>
      break;
    if(cc != 300){
    28b8:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    28bf:	74 17                	je     28d8 <bigfile+0x169>
      printf(1, "short read bigfile\n");
    28c1:	83 ec 08             	sub    $0x8,%esp
    28c4:	68 d7 53 00 00       	push   $0x53d7
    28c9:	6a 01                	push   $0x1
    28cb:	e8 65 18 00 00       	call   4135 <printf>
    28d0:	83 c4 10             	add    $0x10,%esp
      exit();
    28d3:	e8 ec 16 00 00       	call   3fc4 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    28d8:	a0 60 5d 00 00       	mov    0x5d60,%al
    28dd:	0f be d0             	movsbl %al,%edx
    28e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28e3:	89 c1                	mov    %eax,%ecx
    28e5:	c1 e9 1f             	shr    $0x1f,%ecx
    28e8:	01 c8                	add    %ecx,%eax
    28ea:	d1 f8                	sar    %eax
    28ec:	39 c2                	cmp    %eax,%edx
    28ee:	75 18                	jne    2908 <bigfile+0x199>
    28f0:	a0 8b 5e 00 00       	mov    0x5e8b,%al
    28f5:	0f be d0             	movsbl %al,%edx
    28f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28fb:	89 c1                	mov    %eax,%ecx
    28fd:	c1 e9 1f             	shr    $0x1f,%ecx
    2900:	01 c8                	add    %ecx,%eax
    2902:	d1 f8                	sar    %eax
    2904:	39 c2                	cmp    %eax,%edx
    2906:	74 17                	je     291f <bigfile+0x1b0>
      printf(1, "read bigfile wrong data\n");
    2908:	83 ec 08             	sub    $0x8,%esp
    290b:	68 eb 53 00 00       	push   $0x53eb
    2910:	6a 01                	push   $0x1
    2912:	e8 1e 18 00 00       	call   4135 <printf>
    2917:	83 c4 10             	add    $0x10,%esp
      exit();
    291a:	e8 a5 16 00 00       	call   3fc4 <exit>
    }
    total += cc;
    291f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2922:	01 45 f0             	add    %eax,-0x10(%ebp)
  for(i = 0; ; i++){
    2925:	ff 45 f4             	incl   -0xc(%ebp)
    cc = read(fd, buf, 300);
    2928:	e9 4d ff ff ff       	jmp    287a <bigfile+0x10b>
      break;
    292d:	90                   	nop
  }
  close(fd);
    292e:	83 ec 0c             	sub    $0xc,%esp
    2931:	ff 75 ec             	pushl  -0x14(%ebp)
    2934:	e8 b3 16 00 00       	call   3fec <close>
    2939:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    293c:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    2943:	74 17                	je     295c <bigfile+0x1ed>
    printf(1, "read bigfile wrong total\n");
    2945:	83 ec 08             	sub    $0x8,%esp
    2948:	68 04 54 00 00       	push   $0x5404
    294d:	6a 01                	push   $0x1
    294f:	e8 e1 17 00 00       	call   4135 <printf>
    2954:	83 c4 10             	add    $0x10,%esp
    exit();
    2957:	e8 68 16 00 00       	call   3fc4 <exit>
  }
  unlink("bigfile");
    295c:	83 ec 0c             	sub    $0xc,%esp
    295f:	68 79 53 00 00       	push   $0x5379
    2964:	e8 ab 16 00 00       	call   4014 <unlink>
    2969:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    296c:	83 ec 08             	sub    $0x8,%esp
    296f:	68 1e 54 00 00       	push   $0x541e
    2974:	6a 01                	push   $0x1
    2976:	e8 ba 17 00 00       	call   4135 <printf>
    297b:	83 c4 10             	add    $0x10,%esp
}
    297e:	90                   	nop
    297f:	c9                   	leave  
    2980:	c3                   	ret    

00002981 <fourteen>:

void
fourteen(void)
{
    2981:	55                   	push   %ebp
    2982:	89 e5                	mov    %esp,%ebp
    2984:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2987:	83 ec 08             	sub    $0x8,%esp
    298a:	68 2f 54 00 00       	push   $0x542f
    298f:	6a 01                	push   $0x1
    2991:	e8 9f 17 00 00       	call   4135 <printf>
    2996:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    2999:	83 ec 0c             	sub    $0xc,%esp
    299c:	68 3e 54 00 00       	push   $0x543e
    29a1:	e8 86 16 00 00       	call   402c <mkdir>
    29a6:	83 c4 10             	add    $0x10,%esp
    29a9:	85 c0                	test   %eax,%eax
    29ab:	74 17                	je     29c4 <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    29ad:	83 ec 08             	sub    $0x8,%esp
    29b0:	68 4d 54 00 00       	push   $0x544d
    29b5:	6a 01                	push   $0x1
    29b7:	e8 79 17 00 00       	call   4135 <printf>
    29bc:	83 c4 10             	add    $0x10,%esp
    exit();
    29bf:	e8 00 16 00 00       	call   3fc4 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    29c4:	83 ec 0c             	sub    $0xc,%esp
    29c7:	68 6c 54 00 00       	push   $0x546c
    29cc:	e8 5b 16 00 00       	call   402c <mkdir>
    29d1:	83 c4 10             	add    $0x10,%esp
    29d4:	85 c0                	test   %eax,%eax
    29d6:	74 17                	je     29ef <fourteen+0x6e>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    29d8:	83 ec 08             	sub    $0x8,%esp
    29db:	68 8c 54 00 00       	push   $0x548c
    29e0:	6a 01                	push   $0x1
    29e2:	e8 4e 17 00 00       	call   4135 <printf>
    29e7:	83 c4 10             	add    $0x10,%esp
    exit();
    29ea:	e8 d5 15 00 00       	call   3fc4 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    29ef:	83 ec 08             	sub    $0x8,%esp
    29f2:	68 00 02 00 00       	push   $0x200
    29f7:	68 bc 54 00 00       	push   $0x54bc
    29fc:	e8 03 16 00 00       	call   4004 <open>
    2a01:	83 c4 10             	add    $0x10,%esp
    2a04:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a07:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a0b:	79 17                	jns    2a24 <fourteen+0xa3>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2a0d:	83 ec 08             	sub    $0x8,%esp
    2a10:	68 ec 54 00 00       	push   $0x54ec
    2a15:	6a 01                	push   $0x1
    2a17:	e8 19 17 00 00       	call   4135 <printf>
    2a1c:	83 c4 10             	add    $0x10,%esp
    exit();
    2a1f:	e8 a0 15 00 00       	call   3fc4 <exit>
  }
  close(fd);
    2a24:	83 ec 0c             	sub    $0xc,%esp
    2a27:	ff 75 f4             	pushl  -0xc(%ebp)
    2a2a:	e8 bd 15 00 00       	call   3fec <close>
    2a2f:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2a32:	83 ec 08             	sub    $0x8,%esp
    2a35:	6a 00                	push   $0x0
    2a37:	68 2c 55 00 00       	push   $0x552c
    2a3c:	e8 c3 15 00 00       	call   4004 <open>
    2a41:	83 c4 10             	add    $0x10,%esp
    2a44:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a4b:	79 17                	jns    2a64 <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2a4d:	83 ec 08             	sub    $0x8,%esp
    2a50:	68 5c 55 00 00       	push   $0x555c
    2a55:	6a 01                	push   $0x1
    2a57:	e8 d9 16 00 00       	call   4135 <printf>
    2a5c:	83 c4 10             	add    $0x10,%esp
    exit();
    2a5f:	e8 60 15 00 00       	call   3fc4 <exit>
  }
  close(fd);
    2a64:	83 ec 0c             	sub    $0xc,%esp
    2a67:	ff 75 f4             	pushl  -0xc(%ebp)
    2a6a:	e8 7d 15 00 00       	call   3fec <close>
    2a6f:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    2a72:	83 ec 0c             	sub    $0xc,%esp
    2a75:	68 96 55 00 00       	push   $0x5596
    2a7a:	e8 ad 15 00 00       	call   402c <mkdir>
    2a7f:	83 c4 10             	add    $0x10,%esp
    2a82:	85 c0                	test   %eax,%eax
    2a84:	75 17                	jne    2a9d <fourteen+0x11c>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2a86:	83 ec 08             	sub    $0x8,%esp
    2a89:	68 b4 55 00 00       	push   $0x55b4
    2a8e:	6a 01                	push   $0x1
    2a90:	e8 a0 16 00 00       	call   4135 <printf>
    2a95:	83 c4 10             	add    $0x10,%esp
    exit();
    2a98:	e8 27 15 00 00       	call   3fc4 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2a9d:	83 ec 0c             	sub    $0xc,%esp
    2aa0:	68 e4 55 00 00       	push   $0x55e4
    2aa5:	e8 82 15 00 00       	call   402c <mkdir>
    2aaa:	83 c4 10             	add    $0x10,%esp
    2aad:	85 c0                	test   %eax,%eax
    2aaf:	75 17                	jne    2ac8 <fourteen+0x147>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2ab1:	83 ec 08             	sub    $0x8,%esp
    2ab4:	68 04 56 00 00       	push   $0x5604
    2ab9:	6a 01                	push   $0x1
    2abb:	e8 75 16 00 00       	call   4135 <printf>
    2ac0:	83 c4 10             	add    $0x10,%esp
    exit();
    2ac3:	e8 fc 14 00 00       	call   3fc4 <exit>
  }

  printf(1, "fourteen ok\n");
    2ac8:	83 ec 08             	sub    $0x8,%esp
    2acb:	68 35 56 00 00       	push   $0x5635
    2ad0:	6a 01                	push   $0x1
    2ad2:	e8 5e 16 00 00       	call   4135 <printf>
    2ad7:	83 c4 10             	add    $0x10,%esp
}
    2ada:	90                   	nop
    2adb:	c9                   	leave  
    2adc:	c3                   	ret    

00002add <rmdot>:

void
rmdot(void)
{
    2add:	55                   	push   %ebp
    2ade:	89 e5                	mov    %esp,%ebp
    2ae0:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    2ae3:	83 ec 08             	sub    $0x8,%esp
    2ae6:	68 42 56 00 00       	push   $0x5642
    2aeb:	6a 01                	push   $0x1
    2aed:	e8 43 16 00 00       	call   4135 <printf>
    2af2:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    2af5:	83 ec 0c             	sub    $0xc,%esp
    2af8:	68 4e 56 00 00       	push   $0x564e
    2afd:	e8 2a 15 00 00       	call   402c <mkdir>
    2b02:	83 c4 10             	add    $0x10,%esp
    2b05:	85 c0                	test   %eax,%eax
    2b07:	74 17                	je     2b20 <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    2b09:	83 ec 08             	sub    $0x8,%esp
    2b0c:	68 53 56 00 00       	push   $0x5653
    2b11:	6a 01                	push   $0x1
    2b13:	e8 1d 16 00 00       	call   4135 <printf>
    2b18:	83 c4 10             	add    $0x10,%esp
    exit();
    2b1b:	e8 a4 14 00 00       	call   3fc4 <exit>
  }
  if(chdir("dots") != 0){
    2b20:	83 ec 0c             	sub    $0xc,%esp
    2b23:	68 4e 56 00 00       	push   $0x564e
    2b28:	e8 07 15 00 00       	call   4034 <chdir>
    2b2d:	83 c4 10             	add    $0x10,%esp
    2b30:	85 c0                	test   %eax,%eax
    2b32:	74 17                	je     2b4b <rmdot+0x6e>
    printf(1, "chdir dots failed\n");
    2b34:	83 ec 08             	sub    $0x8,%esp
    2b37:	68 66 56 00 00       	push   $0x5666
    2b3c:	6a 01                	push   $0x1
    2b3e:	e8 f2 15 00 00       	call   4135 <printf>
    2b43:	83 c4 10             	add    $0x10,%esp
    exit();
    2b46:	e8 79 14 00 00       	call   3fc4 <exit>
  }
  if(unlink(".") == 0){
    2b4b:	83 ec 0c             	sub    $0xc,%esp
    2b4e:	68 7f 4d 00 00       	push   $0x4d7f
    2b53:	e8 bc 14 00 00       	call   4014 <unlink>
    2b58:	83 c4 10             	add    $0x10,%esp
    2b5b:	85 c0                	test   %eax,%eax
    2b5d:	75 17                	jne    2b76 <rmdot+0x99>
    printf(1, "rm . worked!\n");
    2b5f:	83 ec 08             	sub    $0x8,%esp
    2b62:	68 79 56 00 00       	push   $0x5679
    2b67:	6a 01                	push   $0x1
    2b69:	e8 c7 15 00 00       	call   4135 <printf>
    2b6e:	83 c4 10             	add    $0x10,%esp
    exit();
    2b71:	e8 4e 14 00 00       	call   3fc4 <exit>
  }
  if(unlink("..") == 0){
    2b76:	83 ec 0c             	sub    $0xc,%esp
    2b79:	68 02 49 00 00       	push   $0x4902
    2b7e:	e8 91 14 00 00       	call   4014 <unlink>
    2b83:	83 c4 10             	add    $0x10,%esp
    2b86:	85 c0                	test   %eax,%eax
    2b88:	75 17                	jne    2ba1 <rmdot+0xc4>
    printf(1, "rm .. worked!\n");
    2b8a:	83 ec 08             	sub    $0x8,%esp
    2b8d:	68 87 56 00 00       	push   $0x5687
    2b92:	6a 01                	push   $0x1
    2b94:	e8 9c 15 00 00       	call   4135 <printf>
    2b99:	83 c4 10             	add    $0x10,%esp
    exit();
    2b9c:	e8 23 14 00 00       	call   3fc4 <exit>
  }
  if(chdir("/") != 0){
    2ba1:	83 ec 0c             	sub    $0xc,%esp
    2ba4:	68 56 45 00 00       	push   $0x4556
    2ba9:	e8 86 14 00 00       	call   4034 <chdir>
    2bae:	83 c4 10             	add    $0x10,%esp
    2bb1:	85 c0                	test   %eax,%eax
    2bb3:	74 17                	je     2bcc <rmdot+0xef>
    printf(1, "chdir / failed\n");
    2bb5:	83 ec 08             	sub    $0x8,%esp
    2bb8:	68 58 45 00 00       	push   $0x4558
    2bbd:	6a 01                	push   $0x1
    2bbf:	e8 71 15 00 00       	call   4135 <printf>
    2bc4:	83 c4 10             	add    $0x10,%esp
    exit();
    2bc7:	e8 f8 13 00 00       	call   3fc4 <exit>
  }
  if(unlink("dots/.") == 0){
    2bcc:	83 ec 0c             	sub    $0xc,%esp
    2bcf:	68 96 56 00 00       	push   $0x5696
    2bd4:	e8 3b 14 00 00       	call   4014 <unlink>
    2bd9:	83 c4 10             	add    $0x10,%esp
    2bdc:	85 c0                	test   %eax,%eax
    2bde:	75 17                	jne    2bf7 <rmdot+0x11a>
    printf(1, "unlink dots/. worked!\n");
    2be0:	83 ec 08             	sub    $0x8,%esp
    2be3:	68 9d 56 00 00       	push   $0x569d
    2be8:	6a 01                	push   $0x1
    2bea:	e8 46 15 00 00       	call   4135 <printf>
    2bef:	83 c4 10             	add    $0x10,%esp
    exit();
    2bf2:	e8 cd 13 00 00       	call   3fc4 <exit>
  }
  if(unlink("dots/..") == 0){
    2bf7:	83 ec 0c             	sub    $0xc,%esp
    2bfa:	68 b4 56 00 00       	push   $0x56b4
    2bff:	e8 10 14 00 00       	call   4014 <unlink>
    2c04:	83 c4 10             	add    $0x10,%esp
    2c07:	85 c0                	test   %eax,%eax
    2c09:	75 17                	jne    2c22 <rmdot+0x145>
    printf(1, "unlink dots/.. worked!\n");
    2c0b:	83 ec 08             	sub    $0x8,%esp
    2c0e:	68 bc 56 00 00       	push   $0x56bc
    2c13:	6a 01                	push   $0x1
    2c15:	e8 1b 15 00 00       	call   4135 <printf>
    2c1a:	83 c4 10             	add    $0x10,%esp
    exit();
    2c1d:	e8 a2 13 00 00       	call   3fc4 <exit>
  }
  if(unlink("dots") != 0){
    2c22:	83 ec 0c             	sub    $0xc,%esp
    2c25:	68 4e 56 00 00       	push   $0x564e
    2c2a:	e8 e5 13 00 00       	call   4014 <unlink>
    2c2f:	83 c4 10             	add    $0x10,%esp
    2c32:	85 c0                	test   %eax,%eax
    2c34:	74 17                	je     2c4d <rmdot+0x170>
    printf(1, "unlink dots failed!\n");
    2c36:	83 ec 08             	sub    $0x8,%esp
    2c39:	68 d4 56 00 00       	push   $0x56d4
    2c3e:	6a 01                	push   $0x1
    2c40:	e8 f0 14 00 00       	call   4135 <printf>
    2c45:	83 c4 10             	add    $0x10,%esp
    exit();
    2c48:	e8 77 13 00 00       	call   3fc4 <exit>
  }
  printf(1, "rmdot ok\n");
    2c4d:	83 ec 08             	sub    $0x8,%esp
    2c50:	68 e9 56 00 00       	push   $0x56e9
    2c55:	6a 01                	push   $0x1
    2c57:	e8 d9 14 00 00       	call   4135 <printf>
    2c5c:	83 c4 10             	add    $0x10,%esp
}
    2c5f:	90                   	nop
    2c60:	c9                   	leave  
    2c61:	c3                   	ret    

00002c62 <dirfile>:

void
dirfile(void)
{
    2c62:	55                   	push   %ebp
    2c63:	89 e5                	mov    %esp,%ebp
    2c65:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    2c68:	83 ec 08             	sub    $0x8,%esp
    2c6b:	68 f3 56 00 00       	push   $0x56f3
    2c70:	6a 01                	push   $0x1
    2c72:	e8 be 14 00 00       	call   4135 <printf>
    2c77:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    2c7a:	83 ec 08             	sub    $0x8,%esp
    2c7d:	68 00 02 00 00       	push   $0x200
    2c82:	68 00 57 00 00       	push   $0x5700
    2c87:	e8 78 13 00 00       	call   4004 <open>
    2c8c:	83 c4 10             	add    $0x10,%esp
    2c8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2c92:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2c96:	79 17                	jns    2caf <dirfile+0x4d>
    printf(1, "create dirfile failed\n");
    2c98:	83 ec 08             	sub    $0x8,%esp
    2c9b:	68 08 57 00 00       	push   $0x5708
    2ca0:	6a 01                	push   $0x1
    2ca2:	e8 8e 14 00 00       	call   4135 <printf>
    2ca7:	83 c4 10             	add    $0x10,%esp
    exit();
    2caa:	e8 15 13 00 00       	call   3fc4 <exit>
  }
  close(fd);
    2caf:	83 ec 0c             	sub    $0xc,%esp
    2cb2:	ff 75 f4             	pushl  -0xc(%ebp)
    2cb5:	e8 32 13 00 00       	call   3fec <close>
    2cba:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    2cbd:	83 ec 0c             	sub    $0xc,%esp
    2cc0:	68 00 57 00 00       	push   $0x5700
    2cc5:	e8 6a 13 00 00       	call   4034 <chdir>
    2cca:	83 c4 10             	add    $0x10,%esp
    2ccd:	85 c0                	test   %eax,%eax
    2ccf:	75 17                	jne    2ce8 <dirfile+0x86>
    printf(1, "chdir dirfile succeeded!\n");
    2cd1:	83 ec 08             	sub    $0x8,%esp
    2cd4:	68 1f 57 00 00       	push   $0x571f
    2cd9:	6a 01                	push   $0x1
    2cdb:	e8 55 14 00 00       	call   4135 <printf>
    2ce0:	83 c4 10             	add    $0x10,%esp
    exit();
    2ce3:	e8 dc 12 00 00       	call   3fc4 <exit>
  }
  fd = open("dirfile/xx", 0);
    2ce8:	83 ec 08             	sub    $0x8,%esp
    2ceb:	6a 00                	push   $0x0
    2ced:	68 39 57 00 00       	push   $0x5739
    2cf2:	e8 0d 13 00 00       	call   4004 <open>
    2cf7:	83 c4 10             	add    $0x10,%esp
    2cfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2cfd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d01:	78 17                	js     2d1a <dirfile+0xb8>
    printf(1, "create dirfile/xx succeeded!\n");
    2d03:	83 ec 08             	sub    $0x8,%esp
    2d06:	68 44 57 00 00       	push   $0x5744
    2d0b:	6a 01                	push   $0x1
    2d0d:	e8 23 14 00 00       	call   4135 <printf>
    2d12:	83 c4 10             	add    $0x10,%esp
    exit();
    2d15:	e8 aa 12 00 00       	call   3fc4 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2d1a:	83 ec 08             	sub    $0x8,%esp
    2d1d:	68 00 02 00 00       	push   $0x200
    2d22:	68 39 57 00 00       	push   $0x5739
    2d27:	e8 d8 12 00 00       	call   4004 <open>
    2d2c:	83 c4 10             	add    $0x10,%esp
    2d2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2d32:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d36:	78 17                	js     2d4f <dirfile+0xed>
    printf(1, "create dirfile/xx succeeded!\n");
    2d38:	83 ec 08             	sub    $0x8,%esp
    2d3b:	68 44 57 00 00       	push   $0x5744
    2d40:	6a 01                	push   $0x1
    2d42:	e8 ee 13 00 00       	call   4135 <printf>
    2d47:	83 c4 10             	add    $0x10,%esp
    exit();
    2d4a:	e8 75 12 00 00       	call   3fc4 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2d4f:	83 ec 0c             	sub    $0xc,%esp
    2d52:	68 39 57 00 00       	push   $0x5739
    2d57:	e8 d0 12 00 00       	call   402c <mkdir>
    2d5c:	83 c4 10             	add    $0x10,%esp
    2d5f:	85 c0                	test   %eax,%eax
    2d61:	75 17                	jne    2d7a <dirfile+0x118>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2d63:	83 ec 08             	sub    $0x8,%esp
    2d66:	68 62 57 00 00       	push   $0x5762
    2d6b:	6a 01                	push   $0x1
    2d6d:	e8 c3 13 00 00       	call   4135 <printf>
    2d72:	83 c4 10             	add    $0x10,%esp
    exit();
    2d75:	e8 4a 12 00 00       	call   3fc4 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2d7a:	83 ec 0c             	sub    $0xc,%esp
    2d7d:	68 39 57 00 00       	push   $0x5739
    2d82:	e8 8d 12 00 00       	call   4014 <unlink>
    2d87:	83 c4 10             	add    $0x10,%esp
    2d8a:	85 c0                	test   %eax,%eax
    2d8c:	75 17                	jne    2da5 <dirfile+0x143>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2d8e:	83 ec 08             	sub    $0x8,%esp
    2d91:	68 7f 57 00 00       	push   $0x577f
    2d96:	6a 01                	push   $0x1
    2d98:	e8 98 13 00 00       	call   4135 <printf>
    2d9d:	83 c4 10             	add    $0x10,%esp
    exit();
    2da0:	e8 1f 12 00 00       	call   3fc4 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2da5:	83 ec 08             	sub    $0x8,%esp
    2da8:	68 39 57 00 00       	push   $0x5739
    2dad:	68 9d 57 00 00       	push   $0x579d
    2db2:	e8 6d 12 00 00       	call   4024 <link>
    2db7:	83 c4 10             	add    $0x10,%esp
    2dba:	85 c0                	test   %eax,%eax
    2dbc:	75 17                	jne    2dd5 <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    2dbe:	83 ec 08             	sub    $0x8,%esp
    2dc1:	68 a4 57 00 00       	push   $0x57a4
    2dc6:	6a 01                	push   $0x1
    2dc8:	e8 68 13 00 00       	call   4135 <printf>
    2dcd:	83 c4 10             	add    $0x10,%esp
    exit();
    2dd0:	e8 ef 11 00 00       	call   3fc4 <exit>
  }
  if(unlink("dirfile") != 0){
    2dd5:	83 ec 0c             	sub    $0xc,%esp
    2dd8:	68 00 57 00 00       	push   $0x5700
    2ddd:	e8 32 12 00 00       	call   4014 <unlink>
    2de2:	83 c4 10             	add    $0x10,%esp
    2de5:	85 c0                	test   %eax,%eax
    2de7:	74 17                	je     2e00 <dirfile+0x19e>
    printf(1, "unlink dirfile failed!\n");
    2de9:	83 ec 08             	sub    $0x8,%esp
    2dec:	68 c3 57 00 00       	push   $0x57c3
    2df1:	6a 01                	push   $0x1
    2df3:	e8 3d 13 00 00       	call   4135 <printf>
    2df8:	83 c4 10             	add    $0x10,%esp
    exit();
    2dfb:	e8 c4 11 00 00       	call   3fc4 <exit>
  }

  fd = open(".", O_RDWR);
    2e00:	83 ec 08             	sub    $0x8,%esp
    2e03:	6a 02                	push   $0x2
    2e05:	68 7f 4d 00 00       	push   $0x4d7f
    2e0a:	e8 f5 11 00 00       	call   4004 <open>
    2e0f:	83 c4 10             	add    $0x10,%esp
    2e12:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2e15:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e19:	78 17                	js     2e32 <dirfile+0x1d0>
    printf(1, "open . for writing succeeded!\n");
    2e1b:	83 ec 08             	sub    $0x8,%esp
    2e1e:	68 dc 57 00 00       	push   $0x57dc
    2e23:	6a 01                	push   $0x1
    2e25:	e8 0b 13 00 00       	call   4135 <printf>
    2e2a:	83 c4 10             	add    $0x10,%esp
    exit();
    2e2d:	e8 92 11 00 00       	call   3fc4 <exit>
  }
  fd = open(".", 0);
    2e32:	83 ec 08             	sub    $0x8,%esp
    2e35:	6a 00                	push   $0x0
    2e37:	68 7f 4d 00 00       	push   $0x4d7f
    2e3c:	e8 c3 11 00 00       	call   4004 <open>
    2e41:	83 c4 10             	add    $0x10,%esp
    2e44:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2e47:	83 ec 04             	sub    $0x4,%esp
    2e4a:	6a 01                	push   $0x1
    2e4c:	68 bb 49 00 00       	push   $0x49bb
    2e51:	ff 75 f4             	pushl  -0xc(%ebp)
    2e54:	e8 8b 11 00 00       	call   3fe4 <write>
    2e59:	83 c4 10             	add    $0x10,%esp
    2e5c:	85 c0                	test   %eax,%eax
    2e5e:	7e 17                	jle    2e77 <dirfile+0x215>
    printf(1, "write . succeeded!\n");
    2e60:	83 ec 08             	sub    $0x8,%esp
    2e63:	68 fb 57 00 00       	push   $0x57fb
    2e68:	6a 01                	push   $0x1
    2e6a:	e8 c6 12 00 00       	call   4135 <printf>
    2e6f:	83 c4 10             	add    $0x10,%esp
    exit();
    2e72:	e8 4d 11 00 00       	call   3fc4 <exit>
  }
  close(fd);
    2e77:	83 ec 0c             	sub    $0xc,%esp
    2e7a:	ff 75 f4             	pushl  -0xc(%ebp)
    2e7d:	e8 6a 11 00 00       	call   3fec <close>
    2e82:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    2e85:	83 ec 08             	sub    $0x8,%esp
    2e88:	68 0f 58 00 00       	push   $0x580f
    2e8d:	6a 01                	push   $0x1
    2e8f:	e8 a1 12 00 00       	call   4135 <printf>
    2e94:	83 c4 10             	add    $0x10,%esp
}
    2e97:	90                   	nop
    2e98:	c9                   	leave  
    2e99:	c3                   	ret    

00002e9a <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2e9a:	55                   	push   %ebp
    2e9b:	89 e5                	mov    %esp,%ebp
    2e9d:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2ea0:	83 ec 08             	sub    $0x8,%esp
    2ea3:	68 1f 58 00 00       	push   $0x581f
    2ea8:	6a 01                	push   $0x1
    2eaa:	e8 86 12 00 00       	call   4135 <printf>
    2eaf:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2eb2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2eb9:	e9 e6 00 00 00       	jmp    2fa4 <iref+0x10a>
    if(mkdir("irefd") != 0){
    2ebe:	83 ec 0c             	sub    $0xc,%esp
    2ec1:	68 30 58 00 00       	push   $0x5830
    2ec6:	e8 61 11 00 00       	call   402c <mkdir>
    2ecb:	83 c4 10             	add    $0x10,%esp
    2ece:	85 c0                	test   %eax,%eax
    2ed0:	74 17                	je     2ee9 <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2ed2:	83 ec 08             	sub    $0x8,%esp
    2ed5:	68 36 58 00 00       	push   $0x5836
    2eda:	6a 01                	push   $0x1
    2edc:	e8 54 12 00 00       	call   4135 <printf>
    2ee1:	83 c4 10             	add    $0x10,%esp
      exit();
    2ee4:	e8 db 10 00 00       	call   3fc4 <exit>
    }
    if(chdir("irefd") != 0){
    2ee9:	83 ec 0c             	sub    $0xc,%esp
    2eec:	68 30 58 00 00       	push   $0x5830
    2ef1:	e8 3e 11 00 00       	call   4034 <chdir>
    2ef6:	83 c4 10             	add    $0x10,%esp
    2ef9:	85 c0                	test   %eax,%eax
    2efb:	74 17                	je     2f14 <iref+0x7a>
      printf(1, "chdir irefd failed\n");
    2efd:	83 ec 08             	sub    $0x8,%esp
    2f00:	68 4a 58 00 00       	push   $0x584a
    2f05:	6a 01                	push   $0x1
    2f07:	e8 29 12 00 00       	call   4135 <printf>
    2f0c:	83 c4 10             	add    $0x10,%esp
      exit();
    2f0f:	e8 b0 10 00 00       	call   3fc4 <exit>
    }

    mkdir("");
    2f14:	83 ec 0c             	sub    $0xc,%esp
    2f17:	68 5e 58 00 00       	push   $0x585e
    2f1c:	e8 0b 11 00 00       	call   402c <mkdir>
    2f21:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    2f24:	83 ec 08             	sub    $0x8,%esp
    2f27:	68 5e 58 00 00       	push   $0x585e
    2f2c:	68 9d 57 00 00       	push   $0x579d
    2f31:	e8 ee 10 00 00       	call   4024 <link>
    2f36:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    2f39:	83 ec 08             	sub    $0x8,%esp
    2f3c:	68 00 02 00 00       	push   $0x200
    2f41:	68 5e 58 00 00       	push   $0x585e
    2f46:	e8 b9 10 00 00       	call   4004 <open>
    2f4b:	83 c4 10             	add    $0x10,%esp
    2f4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2f51:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2f55:	78 0e                	js     2f65 <iref+0xcb>
      close(fd);
    2f57:	83 ec 0c             	sub    $0xc,%esp
    2f5a:	ff 75 f0             	pushl  -0x10(%ebp)
    2f5d:	e8 8a 10 00 00       	call   3fec <close>
    2f62:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2f65:	83 ec 08             	sub    $0x8,%esp
    2f68:	68 00 02 00 00       	push   $0x200
    2f6d:	68 5f 58 00 00       	push   $0x585f
    2f72:	e8 8d 10 00 00       	call   4004 <open>
    2f77:	83 c4 10             	add    $0x10,%esp
    2f7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2f7d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2f81:	78 0e                	js     2f91 <iref+0xf7>
      close(fd);
    2f83:	83 ec 0c             	sub    $0xc,%esp
    2f86:	ff 75 f0             	pushl  -0x10(%ebp)
    2f89:	e8 5e 10 00 00       	call   3fec <close>
    2f8e:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2f91:	83 ec 0c             	sub    $0xc,%esp
    2f94:	68 5f 58 00 00       	push   $0x585f
    2f99:	e8 76 10 00 00       	call   4014 <unlink>
    2f9e:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 50 + 1; i++){
    2fa1:	ff 45 f4             	incl   -0xc(%ebp)
    2fa4:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2fa8:	0f 8e 10 ff ff ff    	jle    2ebe <iref+0x24>
  }

  chdir("/");
    2fae:	83 ec 0c             	sub    $0xc,%esp
    2fb1:	68 56 45 00 00       	push   $0x4556
    2fb6:	e8 79 10 00 00       	call   4034 <chdir>
    2fbb:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    2fbe:	83 ec 08             	sub    $0x8,%esp
    2fc1:	68 62 58 00 00       	push   $0x5862
    2fc6:	6a 01                	push   $0x1
    2fc8:	e8 68 11 00 00       	call   4135 <printf>
    2fcd:	83 c4 10             	add    $0x10,%esp
}
    2fd0:	90                   	nop
    2fd1:	c9                   	leave  
    2fd2:	c3                   	ret    

00002fd3 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2fd3:	55                   	push   %ebp
    2fd4:	89 e5                	mov    %esp,%ebp
    2fd6:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    2fd9:	83 ec 08             	sub    $0x8,%esp
    2fdc:	68 76 58 00 00       	push   $0x5876
    2fe1:	6a 01                	push   $0x1
    2fe3:	e8 4d 11 00 00       	call   4135 <printf>
    2fe8:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    2feb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2ff2:	eb 1c                	jmp    3010 <forktest+0x3d>
    pid = fork();
    2ff4:	e8 c3 0f 00 00       	call   3fbc <fork>
    2ff9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    2ffc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3000:	78 19                	js     301b <forktest+0x48>
      break;
    if(pid == 0)
    3002:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3006:	75 05                	jne    300d <forktest+0x3a>
      exit();
    3008:	e8 b7 0f 00 00       	call   3fc4 <exit>
  for(n=0; n<1000; n++){
    300d:	ff 45 f4             	incl   -0xc(%ebp)
    3010:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    3017:	7e db                	jle    2ff4 <forktest+0x21>
    3019:	eb 01                	jmp    301c <forktest+0x49>
      break;
    301b:	90                   	nop
  }

  if(n == 1000){
    301c:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    3023:	75 3a                	jne    305f <forktest+0x8c>
    printf(1, "fork claimed to work 1000 times!\n");
    3025:	83 ec 08             	sub    $0x8,%esp
    3028:	68 84 58 00 00       	push   $0x5884
    302d:	6a 01                	push   $0x1
    302f:	e8 01 11 00 00       	call   4135 <printf>
    3034:	83 c4 10             	add    $0x10,%esp
    exit();
    3037:	e8 88 0f 00 00       	call   3fc4 <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
    303c:	e8 8b 0f 00 00       	call   3fcc <wait>
    3041:	85 c0                	test   %eax,%eax
    3043:	79 17                	jns    305c <forktest+0x89>
      printf(1, "wait stopped early\n");
    3045:	83 ec 08             	sub    $0x8,%esp
    3048:	68 a6 58 00 00       	push   $0x58a6
    304d:	6a 01                	push   $0x1
    304f:	e8 e1 10 00 00       	call   4135 <printf>
    3054:	83 c4 10             	add    $0x10,%esp
      exit();
    3057:	e8 68 0f 00 00       	call   3fc4 <exit>
  for(; n > 0; n--){
    305c:	ff 4d f4             	decl   -0xc(%ebp)
    305f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3063:	7f d7                	jg     303c <forktest+0x69>
    }
  }

  if(wait() != -1){
    3065:	e8 62 0f 00 00       	call   3fcc <wait>
    306a:	83 f8 ff             	cmp    $0xffffffff,%eax
    306d:	74 17                	je     3086 <forktest+0xb3>
    printf(1, "wait got too many\n");
    306f:	83 ec 08             	sub    $0x8,%esp
    3072:	68 ba 58 00 00       	push   $0x58ba
    3077:	6a 01                	push   $0x1
    3079:	e8 b7 10 00 00       	call   4135 <printf>
    307e:	83 c4 10             	add    $0x10,%esp
    exit();
    3081:	e8 3e 0f 00 00       	call   3fc4 <exit>
  }

  printf(1, "fork test OK\n");
    3086:	83 ec 08             	sub    $0x8,%esp
    3089:	68 cd 58 00 00       	push   $0x58cd
    308e:	6a 01                	push   $0x1
    3090:	e8 a0 10 00 00       	call   4135 <printf>
    3095:	83 c4 10             	add    $0x10,%esp
}
    3098:	90                   	nop
    3099:	c9                   	leave  
    309a:	c3                   	ret    

0000309b <sbrktest>:

void
sbrktest(void)
{
    309b:	55                   	push   %ebp
    309c:	89 e5                	mov    %esp,%ebp
    309e:	83 ec 68             	sub    $0x68,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    30a1:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    30a6:	83 ec 08             	sub    $0x8,%esp
    30a9:	68 db 58 00 00       	push   $0x58db
    30ae:	50                   	push   %eax
    30af:	e8 81 10 00 00       	call   4135 <printf>
    30b4:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    30b7:	83 ec 0c             	sub    $0xc,%esp
    30ba:	6a 00                	push   $0x0
    30bc:	e8 8b 0f 00 00       	call   404c <sbrk>
    30c1:	83 c4 10             	add    $0x10,%esp
    30c4:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    30c7:	83 ec 0c             	sub    $0xc,%esp
    30ca:	6a 00                	push   $0x0
    30cc:	e8 7b 0f 00 00       	call   404c <sbrk>
    30d1:	83 c4 10             	add    $0x10,%esp
    30d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){
    30d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    30de:	eb 4c                	jmp    312c <sbrktest+0x91>
    b = sbrk(1);
    30e0:	83 ec 0c             	sub    $0xc,%esp
    30e3:	6a 01                	push   $0x1
    30e5:	e8 62 0f 00 00       	call   404c <sbrk>
    30ea:	83 c4 10             	add    $0x10,%esp
    30ed:	89 45 d0             	mov    %eax,-0x30(%ebp)
    if(b != a){
    30f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    30f3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    30f6:	74 24                	je     311c <sbrktest+0x81>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    30f8:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    30fd:	83 ec 0c             	sub    $0xc,%esp
    3100:	ff 75 d0             	pushl  -0x30(%ebp)
    3103:	ff 75 f4             	pushl  -0xc(%ebp)
    3106:	ff 75 f0             	pushl  -0x10(%ebp)
    3109:	68 e6 58 00 00       	push   $0x58e6
    310e:	50                   	push   %eax
    310f:	e8 21 10 00 00       	call   4135 <printf>
    3114:	83 c4 20             	add    $0x20,%esp
      exit();
    3117:	e8 a8 0e 00 00       	call   3fc4 <exit>
    }
    *b = 1;
    311c:	8b 45 d0             	mov    -0x30(%ebp),%eax
    311f:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    3122:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3125:	40                   	inc    %eax
    3126:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; i < 5000; i++){
    3129:	ff 45 f0             	incl   -0x10(%ebp)
    312c:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    3133:	7e ab                	jle    30e0 <sbrktest+0x45>
  }
  pid = fork();
    3135:	e8 82 0e 00 00       	call   3fbc <fork>
    313a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
    313d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3141:	79 1b                	jns    315e <sbrktest+0xc3>
    printf(stdout, "sbrk test fork failed\n");
    3143:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3148:	83 ec 08             	sub    $0x8,%esp
    314b:	68 01 59 00 00       	push   $0x5901
    3150:	50                   	push   %eax
    3151:	e8 df 0f 00 00       	call   4135 <printf>
    3156:	83 c4 10             	add    $0x10,%esp
    exit();
    3159:	e8 66 0e 00 00       	call   3fc4 <exit>
  }
  c = sbrk(1);
    315e:	83 ec 0c             	sub    $0xc,%esp
    3161:	6a 01                	push   $0x1
    3163:	e8 e4 0e 00 00       	call   404c <sbrk>
    3168:	83 c4 10             	add    $0x10,%esp
    316b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  c = sbrk(1);
    316e:	83 ec 0c             	sub    $0xc,%esp
    3171:	6a 01                	push   $0x1
    3173:	e8 d4 0e 00 00       	call   404c <sbrk>
    3178:	83 c4 10             	add    $0x10,%esp
    317b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a + 1){
    317e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3181:	40                   	inc    %eax
    3182:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    3185:	74 1b                	je     31a2 <sbrktest+0x107>
    printf(stdout, "sbrk test failed post-fork\n");
    3187:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    318c:	83 ec 08             	sub    $0x8,%esp
    318f:	68 18 59 00 00       	push   $0x5918
    3194:	50                   	push   %eax
    3195:	e8 9b 0f 00 00       	call   4135 <printf>
    319a:	83 c4 10             	add    $0x10,%esp
    exit();
    319d:	e8 22 0e 00 00       	call   3fc4 <exit>
  }
  if(pid == 0)
    31a2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    31a6:	75 05                	jne    31ad <sbrktest+0x112>
    exit();
    31a8:	e8 17 0e 00 00       	call   3fc4 <exit>
  wait();
    31ad:	e8 1a 0e 00 00       	call   3fcc <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    31b2:	83 ec 0c             	sub    $0xc,%esp
    31b5:	6a 00                	push   $0x0
    31b7:	e8 90 0e 00 00       	call   404c <sbrk>
    31bc:	83 c4 10             	add    $0x10,%esp
    31bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    31c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    31c5:	ba 00 00 40 06       	mov    $0x6400000,%edx
    31ca:	29 c2                	sub    %eax,%edx
    31cc:	89 55 e0             	mov    %edx,-0x20(%ebp)
  p = sbrk(amt);
    31cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    31d2:	83 ec 0c             	sub    $0xc,%esp
    31d5:	50                   	push   %eax
    31d6:	e8 71 0e 00 00       	call   404c <sbrk>
    31db:	83 c4 10             	add    $0x10,%esp
    31de:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if (p != a) {
    31e1:	8b 45 dc             	mov    -0x24(%ebp),%eax
    31e4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    31e7:	74 1b                	je     3204 <sbrktest+0x169>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    31e9:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    31ee:	83 ec 08             	sub    $0x8,%esp
    31f1:	68 34 59 00 00       	push   $0x5934
    31f6:	50                   	push   %eax
    31f7:	e8 39 0f 00 00       	call   4135 <printf>
    31fc:	83 c4 10             	add    $0x10,%esp
    exit();
    31ff:	e8 c0 0d 00 00       	call   3fc4 <exit>
  }
  lastaddr = (char*) (BIG-1);
    3204:	c7 45 d8 ff ff 3f 06 	movl   $0x63fffff,-0x28(%ebp)
  *lastaddr = 99;
    320b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    320e:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    3211:	83 ec 0c             	sub    $0xc,%esp
    3214:	6a 00                	push   $0x0
    3216:	e8 31 0e 00 00       	call   404c <sbrk>
    321b:	83 c4 10             	add    $0x10,%esp
    321e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    3221:	83 ec 0c             	sub    $0xc,%esp
    3224:	68 00 f0 ff ff       	push   $0xfffff000
    3229:	e8 1e 0e 00 00       	call   404c <sbrk>
    322e:	83 c4 10             	add    $0x10,%esp
    3231:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c == (char*)0xffffffff){
    3234:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    3238:	75 1b                	jne    3255 <sbrktest+0x1ba>
    printf(stdout, "sbrk could not deallocate\n");
    323a:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    323f:	83 ec 08             	sub    $0x8,%esp
    3242:	68 72 59 00 00       	push   $0x5972
    3247:	50                   	push   %eax
    3248:	e8 e8 0e 00 00       	call   4135 <printf>
    324d:	83 c4 10             	add    $0x10,%esp
    exit();
    3250:	e8 6f 0d 00 00       	call   3fc4 <exit>
  }
  c = sbrk(0);
    3255:	83 ec 0c             	sub    $0xc,%esp
    3258:	6a 00                	push   $0x0
    325a:	e8 ed 0d 00 00       	call   404c <sbrk>
    325f:	83 c4 10             	add    $0x10,%esp
    3262:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a - 4096){
    3265:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3268:	2d 00 10 00 00       	sub    $0x1000,%eax
    326d:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    3270:	74 1e                	je     3290 <sbrktest+0x1f5>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3272:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3277:	ff 75 e4             	pushl  -0x1c(%ebp)
    327a:	ff 75 f4             	pushl  -0xc(%ebp)
    327d:	68 90 59 00 00       	push   $0x5990
    3282:	50                   	push   %eax
    3283:	e8 ad 0e 00 00       	call   4135 <printf>
    3288:	83 c4 10             	add    $0x10,%esp
    exit();
    328b:	e8 34 0d 00 00       	call   3fc4 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    3290:	83 ec 0c             	sub    $0xc,%esp
    3293:	6a 00                	push   $0x0
    3295:	e8 b2 0d 00 00       	call   404c <sbrk>
    329a:	83 c4 10             	add    $0x10,%esp
    329d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    32a0:	83 ec 0c             	sub    $0xc,%esp
    32a3:	68 00 10 00 00       	push   $0x1000
    32a8:	e8 9f 0d 00 00       	call   404c <sbrk>
    32ad:	83 c4 10             	add    $0x10,%esp
    32b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    32b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    32b6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    32b9:	75 1a                	jne    32d5 <sbrktest+0x23a>
    32bb:	83 ec 0c             	sub    $0xc,%esp
    32be:	6a 00                	push   $0x0
    32c0:	e8 87 0d 00 00       	call   404c <sbrk>
    32c5:	83 c4 10             	add    $0x10,%esp
    32c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    32cb:	81 c2 00 10 00 00    	add    $0x1000,%edx
    32d1:	39 d0                	cmp    %edx,%eax
    32d3:	74 1e                	je     32f3 <sbrktest+0x258>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    32d5:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    32da:	ff 75 e4             	pushl  -0x1c(%ebp)
    32dd:	ff 75 f4             	pushl  -0xc(%ebp)
    32e0:	68 c8 59 00 00       	push   $0x59c8
    32e5:	50                   	push   %eax
    32e6:	e8 4a 0e 00 00       	call   4135 <printf>
    32eb:	83 c4 10             	add    $0x10,%esp
    exit();
    32ee:	e8 d1 0c 00 00       	call   3fc4 <exit>
  }
  if(*lastaddr == 99){
    32f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    32f6:	8a 00                	mov    (%eax),%al
    32f8:	3c 63                	cmp    $0x63,%al
    32fa:	75 1b                	jne    3317 <sbrktest+0x27c>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    32fc:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3301:	83 ec 08             	sub    $0x8,%esp
    3304:	68 f0 59 00 00       	push   $0x59f0
    3309:	50                   	push   %eax
    330a:	e8 26 0e 00 00       	call   4135 <printf>
    330f:	83 c4 10             	add    $0x10,%esp
    exit();
    3312:	e8 ad 0c 00 00       	call   3fc4 <exit>
  }

  a = sbrk(0);
    3317:	83 ec 0c             	sub    $0xc,%esp
    331a:	6a 00                	push   $0x0
    331c:	e8 2b 0d 00 00       	call   404c <sbrk>
    3321:	83 c4 10             	add    $0x10,%esp
    3324:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    3327:	83 ec 0c             	sub    $0xc,%esp
    332a:	6a 00                	push   $0x0
    332c:	e8 1b 0d 00 00       	call   404c <sbrk>
    3331:	83 c4 10             	add    $0x10,%esp
    3334:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3337:	29 c2                	sub    %eax,%edx
    3339:	83 ec 0c             	sub    $0xc,%esp
    333c:	52                   	push   %edx
    333d:	e8 0a 0d 00 00       	call   404c <sbrk>
    3342:	83 c4 10             	add    $0x10,%esp
    3345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a){
    3348:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    334b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    334e:	74 1e                	je     336e <sbrktest+0x2d3>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3350:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3355:	ff 75 e4             	pushl  -0x1c(%ebp)
    3358:	ff 75 f4             	pushl  -0xc(%ebp)
    335b:	68 20 5a 00 00       	push   $0x5a20
    3360:	50                   	push   %eax
    3361:	e8 cf 0d 00 00       	call   4135 <printf>
    3366:	83 c4 10             	add    $0x10,%esp
    exit();
    3369:	e8 56 0c 00 00       	call   3fc4 <exit>
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    336e:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    3375:	eb 75                	jmp    33ec <sbrktest+0x351>
    ppid = getpid();
    3377:	e8 c8 0c 00 00       	call   4044 <getpid>
    337c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    pid = fork();
    337f:	e8 38 0c 00 00       	call   3fbc <fork>
    3384:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    3387:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    338b:	79 1b                	jns    33a8 <sbrktest+0x30d>
      printf(stdout, "fork failed\n");
    338d:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3392:	83 ec 08             	sub    $0x8,%esp
    3395:	68 85 45 00 00       	push   $0x4585
    339a:	50                   	push   %eax
    339b:	e8 95 0d 00 00       	call   4135 <printf>
    33a0:	83 c4 10             	add    $0x10,%esp
      exit();
    33a3:	e8 1c 0c 00 00       	call   3fc4 <exit>
    }
    if(pid == 0){
    33a8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    33ac:	75 32                	jne    33e0 <sbrktest+0x345>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    33ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33b1:	8a 00                	mov    (%eax),%al
    33b3:	0f be d0             	movsbl %al,%edx
    33b6:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    33bb:	52                   	push   %edx
    33bc:	ff 75 f4             	pushl  -0xc(%ebp)
    33bf:	68 41 5a 00 00       	push   $0x5a41
    33c4:	50                   	push   %eax
    33c5:	e8 6b 0d 00 00       	call   4135 <printf>
    33ca:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    33cd:	83 ec 0c             	sub    $0xc,%esp
    33d0:	ff 75 d4             	pushl  -0x2c(%ebp)
    33d3:	e8 1c 0c 00 00       	call   3ff4 <kill>
    33d8:	83 c4 10             	add    $0x10,%esp
      exit();
    33db:	e8 e4 0b 00 00       	call   3fc4 <exit>
    }
    wait();
    33e0:	e8 e7 0b 00 00       	call   3fcc <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    33e5:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    33ec:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    33f3:	76 82                	jbe    3377 <sbrktest+0x2dc>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    33f5:	83 ec 0c             	sub    $0xc,%esp
    33f8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    33fb:	50                   	push   %eax
    33fc:	e8 d3 0b 00 00       	call   3fd4 <pipe>
    3401:	83 c4 10             	add    $0x10,%esp
    3404:	85 c0                	test   %eax,%eax
    3406:	74 17                	je     341f <sbrktest+0x384>
    printf(1, "pipe() failed\n");
    3408:	83 ec 08             	sub    $0x8,%esp
    340b:	68 56 49 00 00       	push   $0x4956
    3410:	6a 01                	push   $0x1
    3412:	e8 1e 0d 00 00       	call   4135 <printf>
    3417:	83 c4 10             	add    $0x10,%esp
    exit();
    341a:	e8 a5 0b 00 00       	call   3fc4 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    341f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3426:	e9 85 00 00 00       	jmp    34b0 <sbrktest+0x415>
    if((pids[i] = fork()) == 0){
    342b:	e8 8c 0b 00 00       	call   3fbc <fork>
    3430:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3433:	89 44 95 a0          	mov    %eax,-0x60(%ebp,%edx,4)
    3437:	8b 45 f0             	mov    -0x10(%ebp),%eax
    343a:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    343e:	85 c0                	test   %eax,%eax
    3440:	75 4a                	jne    348c <sbrktest+0x3f1>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    3442:	83 ec 0c             	sub    $0xc,%esp
    3445:	6a 00                	push   $0x0
    3447:	e8 00 0c 00 00       	call   404c <sbrk>
    344c:	83 c4 10             	add    $0x10,%esp
    344f:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3454:	29 c2                	sub    %eax,%edx
    3456:	89 d0                	mov    %edx,%eax
    3458:	83 ec 0c             	sub    $0xc,%esp
    345b:	50                   	push   %eax
    345c:	e8 eb 0b 00 00       	call   404c <sbrk>
    3461:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    3464:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3467:	83 ec 04             	sub    $0x4,%esp
    346a:	6a 01                	push   $0x1
    346c:	68 bb 49 00 00       	push   $0x49bb
    3471:	50                   	push   %eax
    3472:	e8 6d 0b 00 00       	call   3fe4 <write>
    3477:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    347a:	83 ec 0c             	sub    $0xc,%esp
    347d:	68 e8 03 00 00       	push   $0x3e8
    3482:	e8 cd 0b 00 00       	call   4054 <sleep>
    3487:	83 c4 10             	add    $0x10,%esp
    348a:	eb ee                	jmp    347a <sbrktest+0x3df>
    }
    if(pids[i] != -1)
    348c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    348f:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3493:	83 f8 ff             	cmp    $0xffffffff,%eax
    3496:	74 15                	je     34ad <sbrktest+0x412>
      read(fds[0], &scratch, 1);
    3498:	8b 45 c8             	mov    -0x38(%ebp),%eax
    349b:	83 ec 04             	sub    $0x4,%esp
    349e:	6a 01                	push   $0x1
    34a0:	8d 55 9f             	lea    -0x61(%ebp),%edx
    34a3:	52                   	push   %edx
    34a4:	50                   	push   %eax
    34a5:	e8 32 0b 00 00       	call   3fdc <read>
    34aa:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    34ad:	ff 45 f0             	incl   -0x10(%ebp)
    34b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34b3:	83 f8 09             	cmp    $0x9,%eax
    34b6:	0f 86 6f ff ff ff    	jbe    342b <sbrktest+0x390>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    34bc:	83 ec 0c             	sub    $0xc,%esp
    34bf:	68 00 10 00 00       	push   $0x1000
    34c4:	e8 83 0b 00 00       	call   404c <sbrk>
    34c9:	83 c4 10             	add    $0x10,%esp
    34cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    34cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    34d6:	eb 2a                	jmp    3502 <sbrktest+0x467>
    if(pids[i] == -1)
    34d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34db:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    34df:	83 f8 ff             	cmp    $0xffffffff,%eax
    34e2:	74 1a                	je     34fe <sbrktest+0x463>
      continue;
    kill(pids[i]);
    34e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34e7:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    34eb:	83 ec 0c             	sub    $0xc,%esp
    34ee:	50                   	push   %eax
    34ef:	e8 00 0b 00 00       	call   3ff4 <kill>
    34f4:	83 c4 10             	add    $0x10,%esp
    wait();
    34f7:	e8 d0 0a 00 00       	call   3fcc <wait>
    34fc:	eb 01                	jmp    34ff <sbrktest+0x464>
      continue;
    34fe:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    34ff:	ff 45 f0             	incl   -0x10(%ebp)
    3502:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3505:	83 f8 09             	cmp    $0x9,%eax
    3508:	76 ce                	jbe    34d8 <sbrktest+0x43d>
  }
  if(c == (char*)0xffffffff){
    350a:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    350e:	75 1b                	jne    352b <sbrktest+0x490>
    printf(stdout, "failed sbrk leaked memory\n");
    3510:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3515:	83 ec 08             	sub    $0x8,%esp
    3518:	68 5a 5a 00 00       	push   $0x5a5a
    351d:	50                   	push   %eax
    351e:	e8 12 0c 00 00       	call   4135 <printf>
    3523:	83 c4 10             	add    $0x10,%esp
    exit();
    3526:	e8 99 0a 00 00       	call   3fc4 <exit>
  }

  if(sbrk(0) > oldbrk)
    352b:	83 ec 0c             	sub    $0xc,%esp
    352e:	6a 00                	push   $0x0
    3530:	e8 17 0b 00 00       	call   404c <sbrk>
    3535:	83 c4 10             	add    $0x10,%esp
    3538:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    353b:	73 1e                	jae    355b <sbrktest+0x4c0>
    sbrk(-(sbrk(0) - oldbrk));
    353d:	83 ec 0c             	sub    $0xc,%esp
    3540:	6a 00                	push   $0x0
    3542:	e8 05 0b 00 00       	call   404c <sbrk>
    3547:	83 c4 10             	add    $0x10,%esp
    354a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    354d:	29 c2                	sub    %eax,%edx
    354f:	83 ec 0c             	sub    $0xc,%esp
    3552:	52                   	push   %edx
    3553:	e8 f4 0a 00 00       	call   404c <sbrk>
    3558:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    355b:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3560:	83 ec 08             	sub    $0x8,%esp
    3563:	68 75 5a 00 00       	push   $0x5a75
    3568:	50                   	push   %eax
    3569:	e8 c7 0b 00 00       	call   4135 <printf>
    356e:	83 c4 10             	add    $0x10,%esp
}
    3571:	90                   	nop
    3572:	c9                   	leave  
    3573:	c3                   	ret    

00003574 <validateint>:

void
validateint(int *p)
{
    3574:	55                   	push   %ebp
    3575:	89 e5                	mov    %esp,%ebp
    3577:	53                   	push   %ebx
    3578:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    357b:	b8 0d 00 00 00       	mov    $0xd,%eax
    3580:	8b 55 08             	mov    0x8(%ebp),%edx
    3583:	89 d1                	mov    %edx,%ecx
    3585:	89 e3                	mov    %esp,%ebx
    3587:	89 cc                	mov    %ecx,%esp
    3589:	cd 40                	int    $0x40
    358b:	89 dc                	mov    %ebx,%esp
    358d:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3590:	90                   	nop
    3591:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3594:	c9                   	leave  
    3595:	c3                   	ret    

00003596 <validatetest>:

void
validatetest(void)
{
    3596:	55                   	push   %ebp
    3597:	89 e5                	mov    %esp,%ebp
    3599:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    359c:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    35a1:	83 ec 08             	sub    $0x8,%esp
    35a4:	68 83 5a 00 00       	push   $0x5a83
    35a9:	50                   	push   %eax
    35aa:	e8 86 0b 00 00       	call   4135 <printf>
    35af:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    35b2:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    35b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    35c0:	e9 8a 00 00 00       	jmp    364f <validatetest+0xb9>
    if((pid = fork()) == 0){
    35c5:	e8 f2 09 00 00       	call   3fbc <fork>
    35ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
    35cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    35d1:	75 14                	jne    35e7 <validatetest+0x51>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    35d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    35d6:	83 ec 0c             	sub    $0xc,%esp
    35d9:	50                   	push   %eax
    35da:	e8 95 ff ff ff       	call   3574 <validateint>
    35df:	83 c4 10             	add    $0x10,%esp
      exit();
    35e2:	e8 dd 09 00 00       	call   3fc4 <exit>
    }
    sleep(0);
    35e7:	83 ec 0c             	sub    $0xc,%esp
    35ea:	6a 00                	push   $0x0
    35ec:	e8 63 0a 00 00       	call   4054 <sleep>
    35f1:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    35f4:	83 ec 0c             	sub    $0xc,%esp
    35f7:	6a 00                	push   $0x0
    35f9:	e8 56 0a 00 00       	call   4054 <sleep>
    35fe:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    3601:	83 ec 0c             	sub    $0xc,%esp
    3604:	ff 75 ec             	pushl  -0x14(%ebp)
    3607:	e8 e8 09 00 00       	call   3ff4 <kill>
    360c:	83 c4 10             	add    $0x10,%esp
    wait();
    360f:	e8 b8 09 00 00       	call   3fcc <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3614:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3617:	83 ec 08             	sub    $0x8,%esp
    361a:	50                   	push   %eax
    361b:	68 92 5a 00 00       	push   $0x5a92
    3620:	e8 ff 09 00 00       	call   4024 <link>
    3625:	83 c4 10             	add    $0x10,%esp
    3628:	83 f8 ff             	cmp    $0xffffffff,%eax
    362b:	74 1b                	je     3648 <validatetest+0xb2>
      printf(stdout, "link should not succeed\n");
    362d:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3632:	83 ec 08             	sub    $0x8,%esp
    3635:	68 9d 5a 00 00       	push   $0x5a9d
    363a:	50                   	push   %eax
    363b:	e8 f5 0a 00 00       	call   4135 <printf>
    3640:	83 c4 10             	add    $0x10,%esp
      exit();
    3643:	e8 7c 09 00 00       	call   3fc4 <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    3648:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    364f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3652:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3655:	0f 83 6a ff ff ff    	jae    35c5 <validatetest+0x2f>
    }
  }

  printf(stdout, "validate ok\n");
    365b:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    3660:	83 ec 08             	sub    $0x8,%esp
    3663:	68 b6 5a 00 00       	push   $0x5ab6
    3668:	50                   	push   %eax
    3669:	e8 c7 0a 00 00       	call   4135 <printf>
    366e:	83 c4 10             	add    $0x10,%esp
}
    3671:	90                   	nop
    3672:	c9                   	leave  
    3673:	c3                   	ret    

00003674 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3674:	55                   	push   %ebp
    3675:	89 e5                	mov    %esp,%ebp
    3677:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    367a:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    367f:	83 ec 08             	sub    $0x8,%esp
    3682:	68 c3 5a 00 00       	push   $0x5ac3
    3687:	50                   	push   %eax
    3688:	e8 a8 0a 00 00       	call   4135 <printf>
    368d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3690:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3697:	eb 2c                	jmp    36c5 <bsstest+0x51>
    if(uninit[i] != '\0'){
    3699:	8b 45 f4             	mov    -0xc(%ebp),%eax
    369c:	05 80 7d 00 00       	add    $0x7d80,%eax
    36a1:	8a 00                	mov    (%eax),%al
    36a3:	84 c0                	test   %al,%al
    36a5:	74 1b                	je     36c2 <bsstest+0x4e>
      printf(stdout, "bss test failed\n");
    36a7:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    36ac:	83 ec 08             	sub    $0x8,%esp
    36af:	68 cd 5a 00 00       	push   $0x5acd
    36b4:	50                   	push   %eax
    36b5:	e8 7b 0a 00 00       	call   4135 <printf>
    36ba:	83 c4 10             	add    $0x10,%esp
      exit();
    36bd:	e8 02 09 00 00       	call   3fc4 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    36c2:	ff 45 f4             	incl   -0xc(%ebp)
    36c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    36c8:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    36cd:	76 ca                	jbe    3699 <bsstest+0x25>
    }
  }
  printf(stdout, "bss test ok\n");
    36cf:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    36d4:	83 ec 08             	sub    $0x8,%esp
    36d7:	68 de 5a 00 00       	push   $0x5ade
    36dc:	50                   	push   %eax
    36dd:	e8 53 0a 00 00       	call   4135 <printf>
    36e2:	83 c4 10             	add    $0x10,%esp
}
    36e5:	90                   	nop
    36e6:	c9                   	leave  
    36e7:	c3                   	ret    

000036e8 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    36e8:	55                   	push   %ebp
    36e9:	89 e5                	mov    %esp,%ebp
    36eb:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    36ee:	83 ec 0c             	sub    $0xc,%esp
    36f1:	68 eb 5a 00 00       	push   $0x5aeb
    36f6:	e8 19 09 00 00       	call   4014 <unlink>
    36fb:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    36fe:	e8 b9 08 00 00       	call   3fbc <fork>
    3703:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    3706:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    370a:	0f 85 96 00 00 00    	jne    37a6 <bigargtest+0xbe>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3710:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3717:	eb 11                	jmp    372a <bigargtest+0x42>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3719:	8b 45 f4             	mov    -0xc(%ebp),%eax
    371c:	c7 04 85 a0 a4 00 00 	movl   $0x5af8,0xa4a0(,%eax,4)
    3723:	f8 5a 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3727:	ff 45 f4             	incl   -0xc(%ebp)
    372a:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    372e:	7e e9                	jle    3719 <bigargtest+0x31>
    args[MAXARG-1] = 0;
    3730:	c7 05 1c a5 00 00 00 	movl   $0x0,0xa51c
    3737:	00 00 00 
    printf(stdout, "bigarg test\n");
    373a:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    373f:	83 ec 08             	sub    $0x8,%esp
    3742:	68 d5 5b 00 00       	push   $0x5bd5
    3747:	50                   	push   %eax
    3748:	e8 e8 09 00 00       	call   4135 <printf>
    374d:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    3750:	83 ec 08             	sub    $0x8,%esp
    3753:	68 a0 a4 00 00       	push   $0xa4a0
    3758:	68 e4 44 00 00       	push   $0x44e4
    375d:	e8 9a 08 00 00       	call   3ffc <exec>
    3762:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    3765:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    376a:	83 ec 08             	sub    $0x8,%esp
    376d:	68 e2 5b 00 00       	push   $0x5be2
    3772:	50                   	push   %eax
    3773:	e8 bd 09 00 00       	call   4135 <printf>
    3778:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    377b:	83 ec 08             	sub    $0x8,%esp
    377e:	68 00 02 00 00       	push   $0x200
    3783:	68 eb 5a 00 00       	push   $0x5aeb
    3788:	e8 77 08 00 00       	call   4004 <open>
    378d:	83 c4 10             	add    $0x10,%esp
    3790:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    3793:	83 ec 0c             	sub    $0xc,%esp
    3796:	ff 75 ec             	pushl  -0x14(%ebp)
    3799:	e8 4e 08 00 00       	call   3fec <close>
    379e:	83 c4 10             	add    $0x10,%esp
    exit();
    37a1:	e8 1e 08 00 00       	call   3fc4 <exit>
  } else if(pid < 0){
    37a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    37aa:	79 1b                	jns    37c7 <bigargtest+0xdf>
    printf(stdout, "bigargtest: fork failed\n");
    37ac:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    37b1:	83 ec 08             	sub    $0x8,%esp
    37b4:	68 f2 5b 00 00       	push   $0x5bf2
    37b9:	50                   	push   %eax
    37ba:	e8 76 09 00 00       	call   4135 <printf>
    37bf:	83 c4 10             	add    $0x10,%esp
    exit();
    37c2:	e8 fd 07 00 00       	call   3fc4 <exit>
  }
  wait();
    37c7:	e8 00 08 00 00       	call   3fcc <wait>
  fd = open("bigarg-ok", 0);
    37cc:	83 ec 08             	sub    $0x8,%esp
    37cf:	6a 00                	push   $0x0
    37d1:	68 eb 5a 00 00       	push   $0x5aeb
    37d6:	e8 29 08 00 00       	call   4004 <open>
    37db:	83 c4 10             	add    $0x10,%esp
    37de:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    37e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    37e5:	79 1b                	jns    3802 <bigargtest+0x11a>
    printf(stdout, "bigarg test failed!\n");
    37e7:	a1 3c 5d 00 00       	mov    0x5d3c,%eax
    37ec:	83 ec 08             	sub    $0x8,%esp
    37ef:	68 0b 5c 00 00       	push   $0x5c0b
    37f4:	50                   	push   %eax
    37f5:	e8 3b 09 00 00       	call   4135 <printf>
    37fa:	83 c4 10             	add    $0x10,%esp
    exit();
    37fd:	e8 c2 07 00 00       	call   3fc4 <exit>
  }
  close(fd);
    3802:	83 ec 0c             	sub    $0xc,%esp
    3805:	ff 75 ec             	pushl  -0x14(%ebp)
    3808:	e8 df 07 00 00       	call   3fec <close>
    380d:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    3810:	83 ec 0c             	sub    $0xc,%esp
    3813:	68 eb 5a 00 00       	push   $0x5aeb
    3818:	e8 f7 07 00 00       	call   4014 <unlink>
    381d:	83 c4 10             	add    $0x10,%esp
}
    3820:	90                   	nop
    3821:	c9                   	leave  
    3822:	c3                   	ret    

00003823 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3823:	55                   	push   %ebp
    3824:	89 e5                	mov    %esp,%ebp
    3826:	53                   	push   %ebx
    3827:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    382a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    3831:	83 ec 08             	sub    $0x8,%esp
    3834:	68 20 5c 00 00       	push   $0x5c20
    3839:	6a 01                	push   $0x1
    383b:	e8 f5 08 00 00       	call   4135 <printf>
    3840:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    3843:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    384a:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    384e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3851:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3856:	f7 e9                	imul   %ecx
    3858:	c1 fa 06             	sar    $0x6,%edx
    385b:	89 c8                	mov    %ecx,%eax
    385d:	c1 f8 1f             	sar    $0x1f,%eax
    3860:	29 c2                	sub    %eax,%edx
    3862:	88 d0                	mov    %dl,%al
    3864:	83 c0 30             	add    $0x30,%eax
    3867:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    386a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    386d:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3872:	f7 eb                	imul   %ebx
    3874:	c1 fa 06             	sar    $0x6,%edx
    3877:	89 d8                	mov    %ebx,%eax
    3879:	c1 f8 1f             	sar    $0x1f,%eax
    387c:	89 d1                	mov    %edx,%ecx
    387e:	29 c1                	sub    %eax,%ecx
    3880:	89 c8                	mov    %ecx,%eax
    3882:	c1 e0 02             	shl    $0x2,%eax
    3885:	01 c8                	add    %ecx,%eax
    3887:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    388e:	01 d0                	add    %edx,%eax
    3890:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3897:	01 d0                	add    %edx,%eax
    3899:	c1 e0 03             	shl    $0x3,%eax
    389c:	29 c3                	sub    %eax,%ebx
    389e:	89 d9                	mov    %ebx,%ecx
    38a0:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    38a5:	f7 e9                	imul   %ecx
    38a7:	c1 fa 05             	sar    $0x5,%edx
    38aa:	89 c8                	mov    %ecx,%eax
    38ac:	c1 f8 1f             	sar    $0x1f,%eax
    38af:	29 c2                	sub    %eax,%edx
    38b1:	88 d0                	mov    %dl,%al
    38b3:	83 c0 30             	add    $0x30,%eax
    38b6:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    38b9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    38bc:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    38c1:	f7 eb                	imul   %ebx
    38c3:	c1 fa 05             	sar    $0x5,%edx
    38c6:	89 d8                	mov    %ebx,%eax
    38c8:	c1 f8 1f             	sar    $0x1f,%eax
    38cb:	89 d1                	mov    %edx,%ecx
    38cd:	29 c1                	sub    %eax,%ecx
    38cf:	89 c8                	mov    %ecx,%eax
    38d1:	c1 e0 02             	shl    $0x2,%eax
    38d4:	01 c8                	add    %ecx,%eax
    38d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    38dd:	01 d0                	add    %edx,%eax
    38df:	c1 e0 02             	shl    $0x2,%eax
    38e2:	29 c3                	sub    %eax,%ebx
    38e4:	89 d9                	mov    %ebx,%ecx
    38e6:	b8 67 66 66 66       	mov    $0x66666667,%eax
    38eb:	f7 e9                	imul   %ecx
    38ed:	c1 fa 02             	sar    $0x2,%edx
    38f0:	89 c8                	mov    %ecx,%eax
    38f2:	c1 f8 1f             	sar    $0x1f,%eax
    38f5:	29 c2                	sub    %eax,%edx
    38f7:	88 d0                	mov    %dl,%al
    38f9:	83 c0 30             	add    $0x30,%eax
    38fc:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    38ff:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3902:	b8 67 66 66 66       	mov    $0x66666667,%eax
    3907:	f7 e9                	imul   %ecx
    3909:	c1 fa 02             	sar    $0x2,%edx
    390c:	89 c8                	mov    %ecx,%eax
    390e:	c1 f8 1f             	sar    $0x1f,%eax
    3911:	29 c2                	sub    %eax,%edx
    3913:	89 d0                	mov    %edx,%eax
    3915:	c1 e0 02             	shl    $0x2,%eax
    3918:	01 d0                	add    %edx,%eax
    391a:	01 c0                	add    %eax,%eax
    391c:	29 c1                	sub    %eax,%ecx
    391e:	89 ca                	mov    %ecx,%edx
    3920:	88 d0                	mov    %dl,%al
    3922:	83 c0 30             	add    $0x30,%eax
    3925:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3928:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    392c:	83 ec 04             	sub    $0x4,%esp
    392f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3932:	50                   	push   %eax
    3933:	68 2d 5c 00 00       	push   $0x5c2d
    3938:	6a 01                	push   $0x1
    393a:	e8 f6 07 00 00       	call   4135 <printf>
    393f:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3942:	83 ec 08             	sub    $0x8,%esp
    3945:	68 02 02 00 00       	push   $0x202
    394a:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    394d:	50                   	push   %eax
    394e:	e8 b1 06 00 00       	call   4004 <open>
    3953:	83 c4 10             	add    $0x10,%esp
    3956:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    3959:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    395d:	79 18                	jns    3977 <fsfull+0x154>
      printf(1, "open %s failed\n", name);
    395f:	83 ec 04             	sub    $0x4,%esp
    3962:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3965:	50                   	push   %eax
    3966:	68 39 5c 00 00       	push   $0x5c39
    396b:	6a 01                	push   $0x1
    396d:	e8 c3 07 00 00       	call   4135 <printf>
    3972:	83 c4 10             	add    $0x10,%esp
      break;
    3975:	eb 69                	jmp    39e0 <fsfull+0x1bd>
    }
    int total = 0;
    3977:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    397e:	83 ec 04             	sub    $0x4,%esp
    3981:	68 00 02 00 00       	push   $0x200
    3986:	68 60 5d 00 00       	push   $0x5d60
    398b:	ff 75 e8             	pushl  -0x18(%ebp)
    398e:	e8 51 06 00 00       	call   3fe4 <write>
    3993:	83 c4 10             	add    $0x10,%esp
    3996:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    3999:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    39a0:	7e 0b                	jle    39ad <fsfull+0x18a>
        break;
      total += cc;
    39a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    39a5:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    39a8:	ff 45 f0             	incl   -0x10(%ebp)
    while(1){
    39ab:	eb d1                	jmp    397e <fsfull+0x15b>
        break;
    39ad:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    39ae:	83 ec 04             	sub    $0x4,%esp
    39b1:	ff 75 ec             	pushl  -0x14(%ebp)
    39b4:	68 49 5c 00 00       	push   $0x5c49
    39b9:	6a 01                	push   $0x1
    39bb:	e8 75 07 00 00       	call   4135 <printf>
    39c0:	83 c4 10             	add    $0x10,%esp
    close(fd);
    39c3:	83 ec 0c             	sub    $0xc,%esp
    39c6:	ff 75 e8             	pushl  -0x18(%ebp)
    39c9:	e8 1e 06 00 00       	call   3fec <close>
    39ce:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    39d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    39d5:	74 08                	je     39df <fsfull+0x1bc>
  for(nfiles = 0; ; nfiles++){
    39d7:	ff 45 f4             	incl   -0xc(%ebp)
    39da:	e9 6b fe ff ff       	jmp    384a <fsfull+0x27>
      break;
    39df:	90                   	nop
  }

  while(nfiles >= 0){
    39e0:	e9 f4 00 00 00       	jmp    3ad9 <fsfull+0x2b6>
    char name[64];
    name[0] = 'f';
    39e5:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    39e9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    39ec:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    39f1:	f7 e9                	imul   %ecx
    39f3:	c1 fa 06             	sar    $0x6,%edx
    39f6:	89 c8                	mov    %ecx,%eax
    39f8:	c1 f8 1f             	sar    $0x1f,%eax
    39fb:	29 c2                	sub    %eax,%edx
    39fd:	88 d0                	mov    %dl,%al
    39ff:	83 c0 30             	add    $0x30,%eax
    3a02:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3a05:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3a08:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3a0d:	f7 eb                	imul   %ebx
    3a0f:	c1 fa 06             	sar    $0x6,%edx
    3a12:	89 d8                	mov    %ebx,%eax
    3a14:	c1 f8 1f             	sar    $0x1f,%eax
    3a17:	89 d1                	mov    %edx,%ecx
    3a19:	29 c1                	sub    %eax,%ecx
    3a1b:	89 c8                	mov    %ecx,%eax
    3a1d:	c1 e0 02             	shl    $0x2,%eax
    3a20:	01 c8                	add    %ecx,%eax
    3a22:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3a29:	01 d0                	add    %edx,%eax
    3a2b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3a32:	01 d0                	add    %edx,%eax
    3a34:	c1 e0 03             	shl    $0x3,%eax
    3a37:	29 c3                	sub    %eax,%ebx
    3a39:	89 d9                	mov    %ebx,%ecx
    3a3b:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3a40:	f7 e9                	imul   %ecx
    3a42:	c1 fa 05             	sar    $0x5,%edx
    3a45:	89 c8                	mov    %ecx,%eax
    3a47:	c1 f8 1f             	sar    $0x1f,%eax
    3a4a:	29 c2                	sub    %eax,%edx
    3a4c:	88 d0                	mov    %dl,%al
    3a4e:	83 c0 30             	add    $0x30,%eax
    3a51:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3a54:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3a57:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3a5c:	f7 eb                	imul   %ebx
    3a5e:	c1 fa 05             	sar    $0x5,%edx
    3a61:	89 d8                	mov    %ebx,%eax
    3a63:	c1 f8 1f             	sar    $0x1f,%eax
    3a66:	89 d1                	mov    %edx,%ecx
    3a68:	29 c1                	sub    %eax,%ecx
    3a6a:	89 c8                	mov    %ecx,%eax
    3a6c:	c1 e0 02             	shl    $0x2,%eax
    3a6f:	01 c8                	add    %ecx,%eax
    3a71:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3a78:	01 d0                	add    %edx,%eax
    3a7a:	c1 e0 02             	shl    $0x2,%eax
    3a7d:	29 c3                	sub    %eax,%ebx
    3a7f:	89 d9                	mov    %ebx,%ecx
    3a81:	b8 67 66 66 66       	mov    $0x66666667,%eax
    3a86:	f7 e9                	imul   %ecx
    3a88:	c1 fa 02             	sar    $0x2,%edx
    3a8b:	89 c8                	mov    %ecx,%eax
    3a8d:	c1 f8 1f             	sar    $0x1f,%eax
    3a90:	29 c2                	sub    %eax,%edx
    3a92:	88 d0                	mov    %dl,%al
    3a94:	83 c0 30             	add    $0x30,%eax
    3a97:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3a9a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3a9d:	b8 67 66 66 66       	mov    $0x66666667,%eax
    3aa2:	f7 e9                	imul   %ecx
    3aa4:	c1 fa 02             	sar    $0x2,%edx
    3aa7:	89 c8                	mov    %ecx,%eax
    3aa9:	c1 f8 1f             	sar    $0x1f,%eax
    3aac:	29 c2                	sub    %eax,%edx
    3aae:	89 d0                	mov    %edx,%eax
    3ab0:	c1 e0 02             	shl    $0x2,%eax
    3ab3:	01 d0                	add    %edx,%eax
    3ab5:	01 c0                	add    %eax,%eax
    3ab7:	29 c1                	sub    %eax,%ecx
    3ab9:	89 ca                	mov    %ecx,%edx
    3abb:	88 d0                	mov    %dl,%al
    3abd:	83 c0 30             	add    $0x30,%eax
    3ac0:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3ac3:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    3ac7:	83 ec 0c             	sub    $0xc,%esp
    3aca:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3acd:	50                   	push   %eax
    3ace:	e8 41 05 00 00       	call   4014 <unlink>
    3ad3:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    3ad6:	ff 4d f4             	decl   -0xc(%ebp)
  while(nfiles >= 0){
    3ad9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3add:	0f 89 02 ff ff ff    	jns    39e5 <fsfull+0x1c2>
  }

  printf(1, "fsfull test finished\n");
    3ae3:	83 ec 08             	sub    $0x8,%esp
    3ae6:	68 59 5c 00 00       	push   $0x5c59
    3aeb:	6a 01                	push   $0x1
    3aed:	e8 43 06 00 00       	call   4135 <printf>
    3af2:	83 c4 10             	add    $0x10,%esp
}
    3af5:	90                   	nop
    3af6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3af9:	c9                   	leave  
    3afa:	c3                   	ret    

00003afb <uio>:

void
uio()
{
    3afb:	55                   	push   %ebp
    3afc:	89 e5                	mov    %esp,%ebp
    3afe:	83 ec 18             	sub    $0x18,%esp
  #define RTC_ADDR 0x70
  #define RTC_DATA 0x71

  ushort port = 0;
    3b01:	66 c7 45 f6 00 00    	movw   $0x0,-0xa(%ebp)
  uchar val = 0;
    3b07:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
  int pid;

  printf(1, "uio test\n");
    3b0b:	83 ec 08             	sub    $0x8,%esp
    3b0e:	68 6f 5c 00 00       	push   $0x5c6f
    3b13:	6a 01                	push   $0x1
    3b15:	e8 1b 06 00 00       	call   4135 <printf>
    3b1a:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    3b1d:	e8 9a 04 00 00       	call   3fbc <fork>
    3b22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    3b25:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3b29:	75 39                	jne    3b64 <uio+0x69>
    port = RTC_ADDR;
    3b2b:	66 c7 45 f6 70 00    	movw   $0x70,-0xa(%ebp)
    val = 0x09;  /* year */
    3b31:	c6 45 f5 09          	movb   $0x9,-0xb(%ebp)
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3b35:	8a 45 f5             	mov    -0xb(%ebp),%al
    3b38:	66 8b 55 f6          	mov    -0xa(%ebp),%dx
    3b3c:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    3b3d:	66 c7 45 f6 71 00    	movw   $0x71,-0xa(%ebp)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3b43:	66 8b 45 f6          	mov    -0xa(%ebp),%ax
    3b47:	89 c2                	mov    %eax,%edx
    3b49:	ec                   	in     (%dx),%al
    3b4a:	88 45 f5             	mov    %al,-0xb(%ebp)
    printf(1, "uio: uio succeeded; test FAILED\n");
    3b4d:	83 ec 08             	sub    $0x8,%esp
    3b50:	68 7c 5c 00 00       	push   $0x5c7c
    3b55:	6a 01                	push   $0x1
    3b57:	e8 d9 05 00 00       	call   4135 <printf>
    3b5c:	83 c4 10             	add    $0x10,%esp
    exit();
    3b5f:	e8 60 04 00 00       	call   3fc4 <exit>
  } else if(pid < 0){
    3b64:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3b68:	79 17                	jns    3b81 <uio+0x86>
    printf (1, "fork failed\n");
    3b6a:	83 ec 08             	sub    $0x8,%esp
    3b6d:	68 85 45 00 00       	push   $0x4585
    3b72:	6a 01                	push   $0x1
    3b74:	e8 bc 05 00 00       	call   4135 <printf>
    3b79:	83 c4 10             	add    $0x10,%esp
    exit();
    3b7c:	e8 43 04 00 00       	call   3fc4 <exit>
  }
  wait();
    3b81:	e8 46 04 00 00       	call   3fcc <wait>
  printf(1, "uio test done\n");
    3b86:	83 ec 08             	sub    $0x8,%esp
    3b89:	68 9d 5c 00 00       	push   $0x5c9d
    3b8e:	6a 01                	push   $0x1
    3b90:	e8 a0 05 00 00       	call   4135 <printf>
    3b95:	83 c4 10             	add    $0x10,%esp
}
    3b98:	90                   	nop
    3b99:	c9                   	leave  
    3b9a:	c3                   	ret    

00003b9b <argptest>:

void argptest()
{
    3b9b:	55                   	push   %ebp
    3b9c:	89 e5                	mov    %esp,%ebp
    3b9e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  fd = open("init", O_RDONLY);
    3ba1:	83 ec 08             	sub    $0x8,%esp
    3ba4:	6a 00                	push   $0x0
    3ba6:	68 ac 5c 00 00       	push   $0x5cac
    3bab:	e8 54 04 00 00       	call   4004 <open>
    3bb0:	83 c4 10             	add    $0x10,%esp
    3bb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (fd < 0) {
    3bb6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3bba:	79 17                	jns    3bd3 <argptest+0x38>
    printf(2, "open failed\n");
    3bbc:	83 ec 08             	sub    $0x8,%esp
    3bbf:	68 b1 5c 00 00       	push   $0x5cb1
    3bc4:	6a 02                	push   $0x2
    3bc6:	e8 6a 05 00 00       	call   4135 <printf>
    3bcb:	83 c4 10             	add    $0x10,%esp
    exit();
    3bce:	e8 f1 03 00 00       	call   3fc4 <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    3bd3:	83 ec 0c             	sub    $0xc,%esp
    3bd6:	6a 00                	push   $0x0
    3bd8:	e8 6f 04 00 00       	call   404c <sbrk>
    3bdd:	83 c4 10             	add    $0x10,%esp
    3be0:	48                   	dec    %eax
    3be1:	83 ec 04             	sub    $0x4,%esp
    3be4:	6a ff                	push   $0xffffffff
    3be6:	50                   	push   %eax
    3be7:	ff 75 f4             	pushl  -0xc(%ebp)
    3bea:	e8 ed 03 00 00       	call   3fdc <read>
    3bef:	83 c4 10             	add    $0x10,%esp
  close(fd);
    3bf2:	83 ec 0c             	sub    $0xc,%esp
    3bf5:	ff 75 f4             	pushl  -0xc(%ebp)
    3bf8:	e8 ef 03 00 00       	call   3fec <close>
    3bfd:	83 c4 10             	add    $0x10,%esp
  printf(1, "arg test passed\n");
    3c00:	83 ec 08             	sub    $0x8,%esp
    3c03:	68 be 5c 00 00       	push   $0x5cbe
    3c08:	6a 01                	push   $0x1
    3c0a:	e8 26 05 00 00       	call   4135 <printf>
    3c0f:	83 c4 10             	add    $0x10,%esp
}
    3c12:	90                   	nop
    3c13:	c9                   	leave  
    3c14:	c3                   	ret    

00003c15 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3c15:	55                   	push   %ebp
    3c16:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3c18:	8b 15 40 5d 00 00    	mov    0x5d40,%edx
    3c1e:	89 d0                	mov    %edx,%eax
    3c20:	01 c0                	add    %eax,%eax
    3c22:	01 d0                	add    %edx,%eax
    3c24:	c1 e0 02             	shl    $0x2,%eax
    3c27:	01 d0                	add    %edx,%eax
    3c29:	c1 e0 08             	shl    $0x8,%eax
    3c2c:	01 d0                	add    %edx,%eax
    3c2e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
    3c35:	01 c8                	add    %ecx,%eax
    3c37:	c1 e0 02             	shl    $0x2,%eax
    3c3a:	01 d0                	add    %edx,%eax
    3c3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3c43:	01 d0                	add    %edx,%eax
    3c45:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3c4c:	01 d0                	add    %edx,%eax
    3c4e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3c53:	a3 40 5d 00 00       	mov    %eax,0x5d40
  return randstate;
    3c58:	a1 40 5d 00 00       	mov    0x5d40,%eax
}
    3c5d:	5d                   	pop    %ebp
    3c5e:	c3                   	ret    

00003c5f <main>:

int
main(int argc, char *argv[])
{
    3c5f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3c63:	83 e4 f0             	and    $0xfffffff0,%esp
    3c66:	ff 71 fc             	pushl  -0x4(%ecx)
    3c69:	55                   	push   %ebp
    3c6a:	89 e5                	mov    %esp,%ebp
    3c6c:	51                   	push   %ecx
    3c6d:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    3c70:	83 ec 08             	sub    $0x8,%esp
    3c73:	68 cf 5c 00 00       	push   $0x5ccf
    3c78:	6a 01                	push   $0x1
    3c7a:	e8 b6 04 00 00       	call   4135 <printf>
    3c7f:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    3c82:	83 ec 08             	sub    $0x8,%esp
    3c85:	6a 00                	push   $0x0
    3c87:	68 e3 5c 00 00       	push   $0x5ce3
    3c8c:	e8 73 03 00 00       	call   4004 <open>
    3c91:	83 c4 10             	add    $0x10,%esp
    3c94:	85 c0                	test   %eax,%eax
    3c96:	78 17                	js     3caf <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3c98:	83 ec 08             	sub    $0x8,%esp
    3c9b:	68 f4 5c 00 00       	push   $0x5cf4
    3ca0:	6a 01                	push   $0x1
    3ca2:	e8 8e 04 00 00       	call   4135 <printf>
    3ca7:	83 c4 10             	add    $0x10,%esp
    exit();
    3caa:	e8 15 03 00 00       	call   3fc4 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3caf:	83 ec 08             	sub    $0x8,%esp
    3cb2:	68 00 02 00 00       	push   $0x200
    3cb7:	68 e3 5c 00 00       	push   $0x5ce3
    3cbc:	e8 43 03 00 00       	call   4004 <open>
    3cc1:	83 c4 10             	add    $0x10,%esp
    3cc4:	83 ec 0c             	sub    $0xc,%esp
    3cc7:	50                   	push   %eax
    3cc8:	e8 1f 03 00 00       	call   3fec <close>
    3ccd:	83 c4 10             	add    $0x10,%esp

  argptest();
    3cd0:	e8 c6 fe ff ff       	call   3b9b <argptest>
  createdelete();
    3cd5:	e8 c4 d5 ff ff       	call   129e <createdelete>
  linkunlink();
    3cda:	e8 8c df ff ff       	call   1c6b <linkunlink>
  concreate();
    3cdf:	e8 25 dc ff ff       	call   1909 <concreate>
  fourfiles();
    3ce4:	e8 68 d3 ff ff       	call   1051 <fourfiles>
  sharedfd();
    3ce9:	e8 86 d1 ff ff       	call   e74 <sharedfd>

  bigargtest();
    3cee:	e8 f5 f9 ff ff       	call   36e8 <bigargtest>
  bigwrite();
    3cf3:	e8 7a e9 ff ff       	call   2672 <bigwrite>
  bigargtest();
    3cf8:	e8 eb f9 ff ff       	call   36e8 <bigargtest>
  bsstest();
    3cfd:	e8 72 f9 ff ff       	call   3674 <bsstest>
  sbrktest();
    3d02:	e8 94 f3 ff ff       	call   309b <sbrktest>
  validatetest();
    3d07:	e8 8a f8 ff ff       	call   3596 <validatetest>

  opentest();
    3d0c:	e8 ee c5 ff ff       	call   2ff <opentest>
  writetest();
    3d11:	e8 98 c6 ff ff       	call   3ae <writetest>
  writetest1();
    3d16:	e8 a2 c8 ff ff       	call   5bd <writetest1>
  createtest();
    3d1b:	e8 97 ca ff ff       	call   7b7 <createtest>

  openiputtest();
    3d20:	e8 cb c4 ff ff       	call   1f0 <openiputtest>
  exitiputtest();
    3d25:	e8 c7 c3 ff ff       	call   f1 <exitiputtest>
  iputtest();
    3d2a:	e8 d1 c2 ff ff       	call   0 <iputtest>

  mem();
    3d2f:	e8 4f d0 ff ff       	call   d83 <mem>
  pipe1();
    3d34:	e8 83 cc ff ff       	call   9bc <pipe1>
  preempt();
    3d39:	e8 68 ce ff ff       	call   ba6 <preempt>
  exitwait();
    3d3e:	e8 c9 cf ff ff       	call   d0c <exitwait>

  rmdot();
    3d43:	e8 95 ed ff ff       	call   2add <rmdot>
  fourteen();
    3d48:	e8 34 ec ff ff       	call   2981 <fourteen>
  bigfile();
    3d4d:	e8 1d ea ff ff       	call   276f <bigfile>
  subdir();
    3d52:	e8 d9 e1 ff ff       	call   1f30 <subdir>
  linktest();
    3d57:	e8 6b d9 ff ff       	call   16c7 <linktest>
  unlinkread();
    3d5c:	e8 a6 d7 ff ff       	call   1507 <unlinkread>
  dirfile();
    3d61:	e8 fc ee ff ff       	call   2c62 <dirfile>
  iref();
    3d66:	e8 2f f1 ff ff       	call   2e9a <iref>
  forktest();
    3d6b:	e8 63 f2 ff ff       	call   2fd3 <forktest>
  bigdir(); // slow
    3d70:	e8 44 e0 ff ff       	call   1db9 <bigdir>

  uio();
    3d75:	e8 81 fd ff ff       	call   3afb <uio>

  exectest();
    3d7a:	e8 ea cb ff ff       	call   969 <exectest>

  exit();
    3d7f:	e8 40 02 00 00       	call   3fc4 <exit>

00003d84 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3d84:	55                   	push   %ebp
    3d85:	89 e5                	mov    %esp,%ebp
    3d87:	57                   	push   %edi
    3d88:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    3d89:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3d8c:	8b 55 10             	mov    0x10(%ebp),%edx
    3d8f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d92:	89 cb                	mov    %ecx,%ebx
    3d94:	89 df                	mov    %ebx,%edi
    3d96:	89 d1                	mov    %edx,%ecx
    3d98:	fc                   	cld    
    3d99:	f3 aa                	rep stos %al,%es:(%edi)
    3d9b:	89 ca                	mov    %ecx,%edx
    3d9d:	89 fb                	mov    %edi,%ebx
    3d9f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    3da2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3da5:	90                   	nop
    3da6:	5b                   	pop    %ebx
    3da7:	5f                   	pop    %edi
    3da8:	5d                   	pop    %ebp
    3da9:	c3                   	ret    

00003daa <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3daa:	55                   	push   %ebp
    3dab:	89 e5                	mov    %esp,%ebp
    3dad:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    3db0:	8b 45 08             	mov    0x8(%ebp),%eax
    3db3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    3db6:	90                   	nop
    3db7:	8b 55 0c             	mov    0xc(%ebp),%edx
    3dba:	8d 42 01             	lea    0x1(%edx),%eax
    3dbd:	89 45 0c             	mov    %eax,0xc(%ebp)
    3dc0:	8b 45 08             	mov    0x8(%ebp),%eax
    3dc3:	8d 48 01             	lea    0x1(%eax),%ecx
    3dc6:	89 4d 08             	mov    %ecx,0x8(%ebp)
    3dc9:	8a 12                	mov    (%edx),%dl
    3dcb:	88 10                	mov    %dl,(%eax)
    3dcd:	8a 00                	mov    (%eax),%al
    3dcf:	84 c0                	test   %al,%al
    3dd1:	75 e4                	jne    3db7 <strcpy+0xd>
    ;
  return os;
    3dd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3dd6:	c9                   	leave  
    3dd7:	c3                   	ret    

00003dd8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3dd8:	55                   	push   %ebp
    3dd9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3ddb:	eb 06                	jmp    3de3 <strcmp+0xb>
    p++, q++;
    3ddd:	ff 45 08             	incl   0x8(%ebp)
    3de0:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
    3de3:	8b 45 08             	mov    0x8(%ebp),%eax
    3de6:	8a 00                	mov    (%eax),%al
    3de8:	84 c0                	test   %al,%al
    3dea:	74 0e                	je     3dfa <strcmp+0x22>
    3dec:	8b 45 08             	mov    0x8(%ebp),%eax
    3def:	8a 10                	mov    (%eax),%dl
    3df1:	8b 45 0c             	mov    0xc(%ebp),%eax
    3df4:	8a 00                	mov    (%eax),%al
    3df6:	38 c2                	cmp    %al,%dl
    3df8:	74 e3                	je     3ddd <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
    3dfa:	8b 45 08             	mov    0x8(%ebp),%eax
    3dfd:	8a 00                	mov    (%eax),%al
    3dff:	0f b6 d0             	movzbl %al,%edx
    3e02:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e05:	8a 00                	mov    (%eax),%al
    3e07:	0f b6 c0             	movzbl %al,%eax
    3e0a:	29 c2                	sub    %eax,%edx
    3e0c:	89 d0                	mov    %edx,%eax
}
    3e0e:	5d                   	pop    %ebp
    3e0f:	c3                   	ret    

00003e10 <strlen>:

uint
strlen(char *s)
{
    3e10:	55                   	push   %ebp
    3e11:	89 e5                	mov    %esp,%ebp
    3e13:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3e16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3e1d:	eb 03                	jmp    3e22 <strlen+0x12>
    3e1f:	ff 45 fc             	incl   -0x4(%ebp)
    3e22:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3e25:	8b 45 08             	mov    0x8(%ebp),%eax
    3e28:	01 d0                	add    %edx,%eax
    3e2a:	8a 00                	mov    (%eax),%al
    3e2c:	84 c0                	test   %al,%al
    3e2e:	75 ef                	jne    3e1f <strlen+0xf>
    ;
  return n;
    3e30:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3e33:	c9                   	leave  
    3e34:	c3                   	ret    

00003e35 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3e35:	55                   	push   %ebp
    3e36:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    3e38:	8b 45 10             	mov    0x10(%ebp),%eax
    3e3b:	50                   	push   %eax
    3e3c:	ff 75 0c             	pushl  0xc(%ebp)
    3e3f:	ff 75 08             	pushl  0x8(%ebp)
    3e42:	e8 3d ff ff ff       	call   3d84 <stosb>
    3e47:	83 c4 0c             	add    $0xc,%esp
  return dst;
    3e4a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3e4d:	c9                   	leave  
    3e4e:	c3                   	ret    

00003e4f <strchr>:

char*
strchr(const char *s, char c)
{
    3e4f:	55                   	push   %ebp
    3e50:	89 e5                	mov    %esp,%ebp
    3e52:	83 ec 04             	sub    $0x4,%esp
    3e55:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e58:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3e5b:	eb 12                	jmp    3e6f <strchr+0x20>
    if(*s == c)
    3e5d:	8b 45 08             	mov    0x8(%ebp),%eax
    3e60:	8a 00                	mov    (%eax),%al
    3e62:	38 45 fc             	cmp    %al,-0x4(%ebp)
    3e65:	75 05                	jne    3e6c <strchr+0x1d>
      return (char*)s;
    3e67:	8b 45 08             	mov    0x8(%ebp),%eax
    3e6a:	eb 11                	jmp    3e7d <strchr+0x2e>
  for(; *s; s++)
    3e6c:	ff 45 08             	incl   0x8(%ebp)
    3e6f:	8b 45 08             	mov    0x8(%ebp),%eax
    3e72:	8a 00                	mov    (%eax),%al
    3e74:	84 c0                	test   %al,%al
    3e76:	75 e5                	jne    3e5d <strchr+0xe>
  return 0;
    3e78:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3e7d:	c9                   	leave  
    3e7e:	c3                   	ret    

00003e7f <gets>:

char*
gets(char *buf, int max)
{
    3e7f:	55                   	push   %ebp
    3e80:	89 e5                	mov    %esp,%ebp
    3e82:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3e85:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3e8c:	eb 3f                	jmp    3ecd <gets+0x4e>
    cc = read(0, &c, 1);
    3e8e:	83 ec 04             	sub    $0x4,%esp
    3e91:	6a 01                	push   $0x1
    3e93:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3e96:	50                   	push   %eax
    3e97:	6a 00                	push   $0x0
    3e99:	e8 3e 01 00 00       	call   3fdc <read>
    3e9e:	83 c4 10             	add    $0x10,%esp
    3ea1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3ea4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3ea8:	7e 2e                	jle    3ed8 <gets+0x59>
      break;
    buf[i++] = c;
    3eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ead:	8d 50 01             	lea    0x1(%eax),%edx
    3eb0:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3eb3:	89 c2                	mov    %eax,%edx
    3eb5:	8b 45 08             	mov    0x8(%ebp),%eax
    3eb8:	01 c2                	add    %eax,%edx
    3eba:	8a 45 ef             	mov    -0x11(%ebp),%al
    3ebd:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3ebf:	8a 45 ef             	mov    -0x11(%ebp),%al
    3ec2:	3c 0a                	cmp    $0xa,%al
    3ec4:	74 13                	je     3ed9 <gets+0x5a>
    3ec6:	8a 45 ef             	mov    -0x11(%ebp),%al
    3ec9:	3c 0d                	cmp    $0xd,%al
    3ecb:	74 0c                	je     3ed9 <gets+0x5a>
  for(i=0; i+1 < max; ){
    3ecd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ed0:	40                   	inc    %eax
    3ed1:	39 45 0c             	cmp    %eax,0xc(%ebp)
    3ed4:	7f b8                	jg     3e8e <gets+0xf>
    3ed6:	eb 01                	jmp    3ed9 <gets+0x5a>
      break;
    3ed8:	90                   	nop
      break;
  }
  buf[i] = '\0';
    3ed9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3edc:	8b 45 08             	mov    0x8(%ebp),%eax
    3edf:	01 d0                	add    %edx,%eax
    3ee1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3ee4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3ee7:	c9                   	leave  
    3ee8:	c3                   	ret    

00003ee9 <stat>:

int
stat(char *n, struct stat *st)
{
    3ee9:	55                   	push   %ebp
    3eea:	89 e5                	mov    %esp,%ebp
    3eec:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3eef:	83 ec 08             	sub    $0x8,%esp
    3ef2:	6a 00                	push   $0x0
    3ef4:	ff 75 08             	pushl  0x8(%ebp)
    3ef7:	e8 08 01 00 00       	call   4004 <open>
    3efc:	83 c4 10             	add    $0x10,%esp
    3eff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3f02:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3f06:	79 07                	jns    3f0f <stat+0x26>
    return -1;
    3f08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3f0d:	eb 25                	jmp    3f34 <stat+0x4b>
  r = fstat(fd, st);
    3f0f:	83 ec 08             	sub    $0x8,%esp
    3f12:	ff 75 0c             	pushl  0xc(%ebp)
    3f15:	ff 75 f4             	pushl  -0xc(%ebp)
    3f18:	e8 ff 00 00 00       	call   401c <fstat>
    3f1d:	83 c4 10             	add    $0x10,%esp
    3f20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3f23:	83 ec 0c             	sub    $0xc,%esp
    3f26:	ff 75 f4             	pushl  -0xc(%ebp)
    3f29:	e8 be 00 00 00       	call   3fec <close>
    3f2e:	83 c4 10             	add    $0x10,%esp
  return r;
    3f31:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3f34:	c9                   	leave  
    3f35:	c3                   	ret    

00003f36 <atoi>:

int
atoi(const char *s)
{
    3f36:	55                   	push   %ebp
    3f37:	89 e5                	mov    %esp,%ebp
    3f39:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3f3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3f43:	eb 24                	jmp    3f69 <atoi+0x33>
    n = n*10 + *s++ - '0';
    3f45:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3f48:	89 d0                	mov    %edx,%eax
    3f4a:	c1 e0 02             	shl    $0x2,%eax
    3f4d:	01 d0                	add    %edx,%eax
    3f4f:	01 c0                	add    %eax,%eax
    3f51:	89 c1                	mov    %eax,%ecx
    3f53:	8b 45 08             	mov    0x8(%ebp),%eax
    3f56:	8d 50 01             	lea    0x1(%eax),%edx
    3f59:	89 55 08             	mov    %edx,0x8(%ebp)
    3f5c:	8a 00                	mov    (%eax),%al
    3f5e:	0f be c0             	movsbl %al,%eax
    3f61:	01 c8                	add    %ecx,%eax
    3f63:	83 e8 30             	sub    $0x30,%eax
    3f66:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3f69:	8b 45 08             	mov    0x8(%ebp),%eax
    3f6c:	8a 00                	mov    (%eax),%al
    3f6e:	3c 2f                	cmp    $0x2f,%al
    3f70:	7e 09                	jle    3f7b <atoi+0x45>
    3f72:	8b 45 08             	mov    0x8(%ebp),%eax
    3f75:	8a 00                	mov    (%eax),%al
    3f77:	3c 39                	cmp    $0x39,%al
    3f79:	7e ca                	jle    3f45 <atoi+0xf>
  return n;
    3f7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3f7e:	c9                   	leave  
    3f7f:	c3                   	ret    

00003f80 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3f80:	55                   	push   %ebp
    3f81:	89 e5                	mov    %esp,%ebp
    3f83:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
    3f86:	8b 45 08             	mov    0x8(%ebp),%eax
    3f89:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f8f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3f92:	eb 16                	jmp    3faa <memmove+0x2a>
    *dst++ = *src++;
    3f94:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3f97:	8d 42 01             	lea    0x1(%edx),%eax
    3f9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3f9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fa0:	8d 48 01             	lea    0x1(%eax),%ecx
    3fa3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    3fa6:	8a 12                	mov    (%edx),%dl
    3fa8:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    3faa:	8b 45 10             	mov    0x10(%ebp),%eax
    3fad:	8d 50 ff             	lea    -0x1(%eax),%edx
    3fb0:	89 55 10             	mov    %edx,0x10(%ebp)
    3fb3:	85 c0                	test   %eax,%eax
    3fb5:	7f dd                	jg     3f94 <memmove+0x14>
  return vdst;
    3fb7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3fba:	c9                   	leave  
    3fbb:	c3                   	ret    

00003fbc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3fbc:	b8 01 00 00 00       	mov    $0x1,%eax
    3fc1:	cd 40                	int    $0x40
    3fc3:	c3                   	ret    

00003fc4 <exit>:
SYSCALL(exit)
    3fc4:	b8 02 00 00 00       	mov    $0x2,%eax
    3fc9:	cd 40                	int    $0x40
    3fcb:	c3                   	ret    

00003fcc <wait>:
SYSCALL(wait)
    3fcc:	b8 03 00 00 00       	mov    $0x3,%eax
    3fd1:	cd 40                	int    $0x40
    3fd3:	c3                   	ret    

00003fd4 <pipe>:
SYSCALL(pipe)
    3fd4:	b8 04 00 00 00       	mov    $0x4,%eax
    3fd9:	cd 40                	int    $0x40
    3fdb:	c3                   	ret    

00003fdc <read>:
SYSCALL(read)
    3fdc:	b8 05 00 00 00       	mov    $0x5,%eax
    3fe1:	cd 40                	int    $0x40
    3fe3:	c3                   	ret    

00003fe4 <write>:
SYSCALL(write)
    3fe4:	b8 10 00 00 00       	mov    $0x10,%eax
    3fe9:	cd 40                	int    $0x40
    3feb:	c3                   	ret    

00003fec <close>:
SYSCALL(close)
    3fec:	b8 15 00 00 00       	mov    $0x15,%eax
    3ff1:	cd 40                	int    $0x40
    3ff3:	c3                   	ret    

00003ff4 <kill>:
SYSCALL(kill)
    3ff4:	b8 06 00 00 00       	mov    $0x6,%eax
    3ff9:	cd 40                	int    $0x40
    3ffb:	c3                   	ret    

00003ffc <exec>:
SYSCALL(exec)
    3ffc:	b8 07 00 00 00       	mov    $0x7,%eax
    4001:	cd 40                	int    $0x40
    4003:	c3                   	ret    

00004004 <open>:
SYSCALL(open)
    4004:	b8 0f 00 00 00       	mov    $0xf,%eax
    4009:	cd 40                	int    $0x40
    400b:	c3                   	ret    

0000400c <mknod>:
SYSCALL(mknod)
    400c:	b8 11 00 00 00       	mov    $0x11,%eax
    4011:	cd 40                	int    $0x40
    4013:	c3                   	ret    

00004014 <unlink>:
SYSCALL(unlink)
    4014:	b8 12 00 00 00       	mov    $0x12,%eax
    4019:	cd 40                	int    $0x40
    401b:	c3                   	ret    

0000401c <fstat>:
SYSCALL(fstat)
    401c:	b8 08 00 00 00       	mov    $0x8,%eax
    4021:	cd 40                	int    $0x40
    4023:	c3                   	ret    

00004024 <link>:
SYSCALL(link)
    4024:	b8 13 00 00 00       	mov    $0x13,%eax
    4029:	cd 40                	int    $0x40
    402b:	c3                   	ret    

0000402c <mkdir>:
SYSCALL(mkdir)
    402c:	b8 14 00 00 00       	mov    $0x14,%eax
    4031:	cd 40                	int    $0x40
    4033:	c3                   	ret    

00004034 <chdir>:
SYSCALL(chdir)
    4034:	b8 09 00 00 00       	mov    $0x9,%eax
    4039:	cd 40                	int    $0x40
    403b:	c3                   	ret    

0000403c <dup>:
SYSCALL(dup)
    403c:	b8 0a 00 00 00       	mov    $0xa,%eax
    4041:	cd 40                	int    $0x40
    4043:	c3                   	ret    

00004044 <getpid>:
SYSCALL(getpid)
    4044:	b8 0b 00 00 00       	mov    $0xb,%eax
    4049:	cd 40                	int    $0x40
    404b:	c3                   	ret    

0000404c <sbrk>:
SYSCALL(sbrk)
    404c:	b8 0c 00 00 00       	mov    $0xc,%eax
    4051:	cd 40                	int    $0x40
    4053:	c3                   	ret    

00004054 <sleep>:
SYSCALL(sleep)
    4054:	b8 0d 00 00 00       	mov    $0xd,%eax
    4059:	cd 40                	int    $0x40
    405b:	c3                   	ret    

0000405c <uptime>:
SYSCALL(uptime)
    405c:	b8 0e 00 00 00       	mov    $0xe,%eax
    4061:	cd 40                	int    $0x40
    4063:	c3                   	ret    

00004064 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    4064:	55                   	push   %ebp
    4065:	89 e5                	mov    %esp,%ebp
    4067:	83 ec 18             	sub    $0x18,%esp
    406a:	8b 45 0c             	mov    0xc(%ebp),%eax
    406d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    4070:	83 ec 04             	sub    $0x4,%esp
    4073:	6a 01                	push   $0x1
    4075:	8d 45 f4             	lea    -0xc(%ebp),%eax
    4078:	50                   	push   %eax
    4079:	ff 75 08             	pushl  0x8(%ebp)
    407c:	e8 63 ff ff ff       	call   3fe4 <write>
    4081:	83 c4 10             	add    $0x10,%esp
}
    4084:	90                   	nop
    4085:	c9                   	leave  
    4086:	c3                   	ret    

00004087 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4087:	55                   	push   %ebp
    4088:	89 e5                	mov    %esp,%ebp
    408a:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    408d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    4094:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    4098:	74 17                	je     40b1 <printint+0x2a>
    409a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    409e:	79 11                	jns    40b1 <printint+0x2a>
    neg = 1;
    40a0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    40a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    40aa:	f7 d8                	neg    %eax
    40ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
    40af:	eb 06                	jmp    40b7 <printint+0x30>
  } else {
    x = xx;
    40b1:	8b 45 0c             	mov    0xc(%ebp),%eax
    40b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    40b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    40be:	8b 4d 10             	mov    0x10(%ebp),%ecx
    40c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    40c4:	ba 00 00 00 00       	mov    $0x0,%edx
    40c9:	f7 f1                	div    %ecx
    40cb:	89 d1                	mov    %edx,%ecx
    40cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40d0:	8d 50 01             	lea    0x1(%eax),%edx
    40d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
    40d6:	8a 91 44 5d 00 00    	mov    0x5d44(%ecx),%dl
    40dc:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    40e0:	8b 4d 10             	mov    0x10(%ebp),%ecx
    40e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    40e6:	ba 00 00 00 00       	mov    $0x0,%edx
    40eb:	f7 f1                	div    %ecx
    40ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    40f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    40f4:	75 c8                	jne    40be <printint+0x37>
  if(neg)
    40f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    40fa:	74 2c                	je     4128 <printint+0xa1>
    buf[i++] = '-';
    40fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40ff:	8d 50 01             	lea    0x1(%eax),%edx
    4102:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4105:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    410a:	eb 1c                	jmp    4128 <printint+0xa1>
    putc(fd, buf[i]);
    410c:	8d 55 dc             	lea    -0x24(%ebp),%edx
    410f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4112:	01 d0                	add    %edx,%eax
    4114:	8a 00                	mov    (%eax),%al
    4116:	0f be c0             	movsbl %al,%eax
    4119:	83 ec 08             	sub    $0x8,%esp
    411c:	50                   	push   %eax
    411d:	ff 75 08             	pushl  0x8(%ebp)
    4120:	e8 3f ff ff ff       	call   4064 <putc>
    4125:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    4128:	ff 4d f4             	decl   -0xc(%ebp)
    412b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    412f:	79 db                	jns    410c <printint+0x85>
}
    4131:	90                   	nop
    4132:	90                   	nop
    4133:	c9                   	leave  
    4134:	c3                   	ret    

00004135 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4135:	55                   	push   %ebp
    4136:	89 e5                	mov    %esp,%ebp
    4138:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    413b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    4142:	8d 45 0c             	lea    0xc(%ebp),%eax
    4145:	83 c0 04             	add    $0x4,%eax
    4148:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    414b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4152:	e9 54 01 00 00       	jmp    42ab <printf+0x176>
    c = fmt[i] & 0xff;
    4157:	8b 55 0c             	mov    0xc(%ebp),%edx
    415a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    415d:	01 d0                	add    %edx,%eax
    415f:	8a 00                	mov    (%eax),%al
    4161:	0f be c0             	movsbl %al,%eax
    4164:	25 ff 00 00 00       	and    $0xff,%eax
    4169:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    416c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4170:	75 2c                	jne    419e <printf+0x69>
      if(c == '%'){
    4172:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4176:	75 0c                	jne    4184 <printf+0x4f>
        state = '%';
    4178:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    417f:	e9 24 01 00 00       	jmp    42a8 <printf+0x173>
      } else {
        putc(fd, c);
    4184:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4187:	0f be c0             	movsbl %al,%eax
    418a:	83 ec 08             	sub    $0x8,%esp
    418d:	50                   	push   %eax
    418e:	ff 75 08             	pushl  0x8(%ebp)
    4191:	e8 ce fe ff ff       	call   4064 <putc>
    4196:	83 c4 10             	add    $0x10,%esp
    4199:	e9 0a 01 00 00       	jmp    42a8 <printf+0x173>
      }
    } else if(state == '%'){
    419e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    41a2:	0f 85 00 01 00 00    	jne    42a8 <printf+0x173>
      if(c == 'd'){
    41a8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    41ac:	75 1e                	jne    41cc <printf+0x97>
        printint(fd, *ap, 10, 1);
    41ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
    41b1:	8b 00                	mov    (%eax),%eax
    41b3:	6a 01                	push   $0x1
    41b5:	6a 0a                	push   $0xa
    41b7:	50                   	push   %eax
    41b8:	ff 75 08             	pushl  0x8(%ebp)
    41bb:	e8 c7 fe ff ff       	call   4087 <printint>
    41c0:	83 c4 10             	add    $0x10,%esp
        ap++;
    41c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    41c7:	e9 d5 00 00 00       	jmp    42a1 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
    41cc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    41d0:	74 06                	je     41d8 <printf+0xa3>
    41d2:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    41d6:	75 1e                	jne    41f6 <printf+0xc1>
        printint(fd, *ap, 16, 0);
    41d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    41db:	8b 00                	mov    (%eax),%eax
    41dd:	6a 00                	push   $0x0
    41df:	6a 10                	push   $0x10
    41e1:	50                   	push   %eax
    41e2:	ff 75 08             	pushl  0x8(%ebp)
    41e5:	e8 9d fe ff ff       	call   4087 <printint>
    41ea:	83 c4 10             	add    $0x10,%esp
        ap++;
    41ed:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    41f1:	e9 ab 00 00 00       	jmp    42a1 <printf+0x16c>
      } else if(c == 's'){
    41f6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    41fa:	75 40                	jne    423c <printf+0x107>
        s = (char*)*ap;
    41fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    41ff:	8b 00                	mov    (%eax),%eax
    4201:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    4204:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    4208:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    420c:	75 23                	jne    4231 <printf+0xfc>
          s = "(null)";
    420e:	c7 45 f4 1e 5d 00 00 	movl   $0x5d1e,-0xc(%ebp)
        while(*s != 0){
    4215:	eb 1a                	jmp    4231 <printf+0xfc>
          putc(fd, *s);
    4217:	8b 45 f4             	mov    -0xc(%ebp),%eax
    421a:	8a 00                	mov    (%eax),%al
    421c:	0f be c0             	movsbl %al,%eax
    421f:	83 ec 08             	sub    $0x8,%esp
    4222:	50                   	push   %eax
    4223:	ff 75 08             	pushl  0x8(%ebp)
    4226:	e8 39 fe ff ff       	call   4064 <putc>
    422b:	83 c4 10             	add    $0x10,%esp
          s++;
    422e:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
    4231:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4234:	8a 00                	mov    (%eax),%al
    4236:	84 c0                	test   %al,%al
    4238:	75 dd                	jne    4217 <printf+0xe2>
    423a:	eb 65                	jmp    42a1 <printf+0x16c>
        }
      } else if(c == 'c'){
    423c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    4240:	75 1d                	jne    425f <printf+0x12a>
        putc(fd, *ap);
    4242:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4245:	8b 00                	mov    (%eax),%eax
    4247:	0f be c0             	movsbl %al,%eax
    424a:	83 ec 08             	sub    $0x8,%esp
    424d:	50                   	push   %eax
    424e:	ff 75 08             	pushl  0x8(%ebp)
    4251:	e8 0e fe ff ff       	call   4064 <putc>
    4256:	83 c4 10             	add    $0x10,%esp
        ap++;
    4259:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    425d:	eb 42                	jmp    42a1 <printf+0x16c>
      } else if(c == '%'){
    425f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4263:	75 17                	jne    427c <printf+0x147>
        putc(fd, c);
    4265:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4268:	0f be c0             	movsbl %al,%eax
    426b:	83 ec 08             	sub    $0x8,%esp
    426e:	50                   	push   %eax
    426f:	ff 75 08             	pushl  0x8(%ebp)
    4272:	e8 ed fd ff ff       	call   4064 <putc>
    4277:	83 c4 10             	add    $0x10,%esp
    427a:	eb 25                	jmp    42a1 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    427c:	83 ec 08             	sub    $0x8,%esp
    427f:	6a 25                	push   $0x25
    4281:	ff 75 08             	pushl  0x8(%ebp)
    4284:	e8 db fd ff ff       	call   4064 <putc>
    4289:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    428c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    428f:	0f be c0             	movsbl %al,%eax
    4292:	83 ec 08             	sub    $0x8,%esp
    4295:	50                   	push   %eax
    4296:	ff 75 08             	pushl  0x8(%ebp)
    4299:	e8 c6 fd ff ff       	call   4064 <putc>
    429e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    42a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    42a8:	ff 45 f0             	incl   -0x10(%ebp)
    42ab:	8b 55 0c             	mov    0xc(%ebp),%edx
    42ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    42b1:	01 d0                	add    %edx,%eax
    42b3:	8a 00                	mov    (%eax),%al
    42b5:	84 c0                	test   %al,%al
    42b7:	0f 85 9a fe ff ff    	jne    4157 <printf+0x22>
    }
  }
}
    42bd:	90                   	nop
    42be:	90                   	nop
    42bf:	c9                   	leave  
    42c0:	c3                   	ret    

000042c1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    42c1:	55                   	push   %ebp
    42c2:	89 e5                	mov    %esp,%ebp
    42c4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    42c7:	8b 45 08             	mov    0x8(%ebp),%eax
    42ca:	83 e8 08             	sub    $0x8,%eax
    42cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    42d0:	a1 28 a5 00 00       	mov    0xa528,%eax
    42d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    42d8:	eb 24                	jmp    42fe <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    42da:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42dd:	8b 00                	mov    (%eax),%eax
    42df:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    42e2:	72 12                	jb     42f6 <free+0x35>
    42e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42e7:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    42ea:	72 24                	jb     4310 <free+0x4f>
    42ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42ef:	8b 00                	mov    (%eax),%eax
    42f1:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    42f4:	72 1a                	jb     4310 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    42f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42f9:	8b 00                	mov    (%eax),%eax
    42fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    42fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4301:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    4304:	73 d4                	jae    42da <free+0x19>
    4306:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4309:	8b 00                	mov    (%eax),%eax
    430b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    430e:	73 ca                	jae    42da <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    4310:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4313:	8b 40 04             	mov    0x4(%eax),%eax
    4316:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    431d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4320:	01 c2                	add    %eax,%edx
    4322:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4325:	8b 00                	mov    (%eax),%eax
    4327:	39 c2                	cmp    %eax,%edx
    4329:	75 24                	jne    434f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    432b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    432e:	8b 50 04             	mov    0x4(%eax),%edx
    4331:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4334:	8b 00                	mov    (%eax),%eax
    4336:	8b 40 04             	mov    0x4(%eax),%eax
    4339:	01 c2                	add    %eax,%edx
    433b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    433e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    4341:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4344:	8b 00                	mov    (%eax),%eax
    4346:	8b 10                	mov    (%eax),%edx
    4348:	8b 45 f8             	mov    -0x8(%ebp),%eax
    434b:	89 10                	mov    %edx,(%eax)
    434d:	eb 0a                	jmp    4359 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    434f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4352:	8b 10                	mov    (%eax),%edx
    4354:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4357:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    4359:	8b 45 fc             	mov    -0x4(%ebp),%eax
    435c:	8b 40 04             	mov    0x4(%eax),%eax
    435f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4366:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4369:	01 d0                	add    %edx,%eax
    436b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    436e:	75 20                	jne    4390 <free+0xcf>
    p->s.size += bp->s.size;
    4370:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4373:	8b 50 04             	mov    0x4(%eax),%edx
    4376:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4379:	8b 40 04             	mov    0x4(%eax),%eax
    437c:	01 c2                	add    %eax,%edx
    437e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4381:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4384:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4387:	8b 10                	mov    (%eax),%edx
    4389:	8b 45 fc             	mov    -0x4(%ebp),%eax
    438c:	89 10                	mov    %edx,(%eax)
    438e:	eb 08                	jmp    4398 <free+0xd7>
  } else
    p->s.ptr = bp;
    4390:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4393:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4396:	89 10                	mov    %edx,(%eax)
  freep = p;
    4398:	8b 45 fc             	mov    -0x4(%ebp),%eax
    439b:	a3 28 a5 00 00       	mov    %eax,0xa528
}
    43a0:	90                   	nop
    43a1:	c9                   	leave  
    43a2:	c3                   	ret    

000043a3 <morecore>:

static Header*
morecore(uint nu)
{
    43a3:	55                   	push   %ebp
    43a4:	89 e5                	mov    %esp,%ebp
    43a6:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    43a9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    43b0:	77 07                	ja     43b9 <morecore+0x16>
    nu = 4096;
    43b2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    43b9:	8b 45 08             	mov    0x8(%ebp),%eax
    43bc:	c1 e0 03             	shl    $0x3,%eax
    43bf:	83 ec 0c             	sub    $0xc,%esp
    43c2:	50                   	push   %eax
    43c3:	e8 84 fc ff ff       	call   404c <sbrk>
    43c8:	83 c4 10             	add    $0x10,%esp
    43cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    43ce:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    43d2:	75 07                	jne    43db <morecore+0x38>
    return 0;
    43d4:	b8 00 00 00 00       	mov    $0x0,%eax
    43d9:	eb 26                	jmp    4401 <morecore+0x5e>
  hp = (Header*)p;
    43db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    43e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43e4:	8b 55 08             	mov    0x8(%ebp),%edx
    43e7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    43ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43ed:	83 c0 08             	add    $0x8,%eax
    43f0:	83 ec 0c             	sub    $0xc,%esp
    43f3:	50                   	push   %eax
    43f4:	e8 c8 fe ff ff       	call   42c1 <free>
    43f9:	83 c4 10             	add    $0x10,%esp
  return freep;
    43fc:	a1 28 a5 00 00       	mov    0xa528,%eax
}
    4401:	c9                   	leave  
    4402:	c3                   	ret    

00004403 <malloc>:

void*
malloc(uint nbytes)
{
    4403:	55                   	push   %ebp
    4404:	89 e5                	mov    %esp,%ebp
    4406:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4409:	8b 45 08             	mov    0x8(%ebp),%eax
    440c:	83 c0 07             	add    $0x7,%eax
    440f:	c1 e8 03             	shr    $0x3,%eax
    4412:	40                   	inc    %eax
    4413:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    4416:	a1 28 a5 00 00       	mov    0xa528,%eax
    441b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    441e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4422:	75 23                	jne    4447 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
    4424:	c7 45 f0 20 a5 00 00 	movl   $0xa520,-0x10(%ebp)
    442b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    442e:	a3 28 a5 00 00       	mov    %eax,0xa528
    4433:	a1 28 a5 00 00       	mov    0xa528,%eax
    4438:	a3 20 a5 00 00       	mov    %eax,0xa520
    base.s.size = 0;
    443d:	c7 05 24 a5 00 00 00 	movl   $0x0,0xa524
    4444:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4447:	8b 45 f0             	mov    -0x10(%ebp),%eax
    444a:	8b 00                	mov    (%eax),%eax
    444c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    444f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4452:	8b 40 04             	mov    0x4(%eax),%eax
    4455:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4458:	72 4d                	jb     44a7 <malloc+0xa4>
      if(p->s.size == nunits)
    445a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    445d:	8b 40 04             	mov    0x4(%eax),%eax
    4460:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    4463:	75 0c                	jne    4471 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
    4465:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4468:	8b 10                	mov    (%eax),%edx
    446a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    446d:	89 10                	mov    %edx,(%eax)
    446f:	eb 26                	jmp    4497 <malloc+0x94>
      else {
        p->s.size -= nunits;
    4471:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4474:	8b 40 04             	mov    0x4(%eax),%eax
    4477:	2b 45 ec             	sub    -0x14(%ebp),%eax
    447a:	89 c2                	mov    %eax,%edx
    447c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    447f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4482:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4485:	8b 40 04             	mov    0x4(%eax),%eax
    4488:	c1 e0 03             	shl    $0x3,%eax
    448b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    448e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4491:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4494:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    4497:	8b 45 f0             	mov    -0x10(%ebp),%eax
    449a:	a3 28 a5 00 00       	mov    %eax,0xa528
      return (void*)(p + 1);
    449f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44a2:	83 c0 08             	add    $0x8,%eax
    44a5:	eb 3b                	jmp    44e2 <malloc+0xdf>
    }
    if(p == freep)
    44a7:	a1 28 a5 00 00       	mov    0xa528,%eax
    44ac:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    44af:	75 1e                	jne    44cf <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
    44b1:	83 ec 0c             	sub    $0xc,%esp
    44b4:	ff 75 ec             	pushl  -0x14(%ebp)
    44b7:	e8 e7 fe ff ff       	call   43a3 <morecore>
    44bc:	83 c4 10             	add    $0x10,%esp
    44bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    44c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    44c6:	75 07                	jne    44cf <malloc+0xcc>
        return 0;
    44c8:	b8 00 00 00 00       	mov    $0x0,%eax
    44cd:	eb 13                	jmp    44e2 <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    44cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    44d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44d8:	8b 00                	mov    (%eax),%eax
    44da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    44dd:	e9 6d ff ff ff       	jmp    444f <malloc+0x4c>
  }
}
    44e2:	c9                   	leave  
    44e3:	c3                   	ret    
