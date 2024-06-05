
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 97 0e 00 00       	call   ea8 <exit>

  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 f4 13 00 00 	mov    0x13f4(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 c8 13 00 00       	push   $0x13c8
      2c:	e8 65 03 00 00       	call   396 <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 5f 0e 00 00       	call   ea8 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 81 0e 00 00       	call   ee0 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 cf 13 00 00       	push   $0x13cf
      71:	6a 02                	push   $0x2
      73:	e8 a1 0f 00 00       	call   1019 <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 e8             	mov    %eax,-0x18(%ebp)
    close(rcmd->fd);
      86:	8b 45 e8             	mov    -0x18(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 3b 0e 00 00       	call   ed0 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 e8             	mov    -0x18(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 3a 0e 00 00       	call   ee8 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 df 13 00 00       	push   $0x13df
      c4:	6a 02                	push   $0x2
      c6:	e8 4e 0f 00 00       	call   1019 <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 d5 0d 00 00       	call   ea8 <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fork1() == 0)
      f0:	e8 c1 02 00 00       	call   3b6 <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 a0 0d 00 00       	call   eb0 <wait>
    runcmd(lcmd->right);
     110:	8b 45 f0             	mov    -0x10(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 7f 0d 00 00       	call   eb8 <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 ef 13 00 00       	push   $0x13ef
     148:	e8 49 02 00 00       	call   396 <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 61 02 00 00       	call   3b6 <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 6d 0d 00 00       	call   ed0 <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 ae 0d 00 00       	call   f20 <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 4f 0d 00 00       	call   ed0 <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 40 0d 00 00       	call   ed0 <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 ec             	mov    -0x14(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 0c 02 00 00       	call   3b6 <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 18 0d 00 00       	call   ed0 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 59 0d 00 00       	call   f20 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 fa 0c 00 00       	call   ed0 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 eb 0c 00 00       	call   ed0 <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 ca 0c 00 00       	call   ed0 <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 bb 0c 00 00       	call   ed0 <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 93 0c 00 00       	call   eb0 <wait>
    wait();
     21d:	e8 8e 0c 00 00       	call   eb0 <wait>
    break;
     222:	eb 22                	jmp    246 <runcmd+0x246>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(fork1() == 0)
     22a:	e8 87 01 00 00       	call   3b6 <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
      runcmd(bcmd->cmd);
     233:	8b 45 f4             	mov    -0xc(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	90                   	nop
  }
  exit();
     246:	e8 5d 0c 00 00       	call   ea8 <exit>

0000024b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     251:	83 ec 08             	sub    $0x8,%esp
     254:	68 0c 14 00 00       	push   $0x140c
     259:	6a 02                	push   $0x2
     25b:	e8 b9 0d 00 00       	call   1019 <printf>
     260:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     263:	8b 45 0c             	mov    0xc(%ebp),%eax
     266:	83 ec 04             	sub    $0x4,%esp
     269:	50                   	push   %eax
     26a:	6a 00                	push   $0x0
     26c:	ff 75 08             	pushl  0x8(%ebp)
     26f:	e8 a5 0a 00 00       	call   d19 <memset>
     274:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     277:	83 ec 08             	sub    $0x8,%esp
     27a:	ff 75 0c             	pushl  0xc(%ebp)
     27d:	ff 75 08             	pushl  0x8(%ebp)
     280:	e8 de 0a 00 00       	call   d63 <gets>
     285:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     288:	8b 45 08             	mov    0x8(%ebp),%eax
     28b:	8a 00                	mov    (%eax),%al
     28d:	84 c0                	test   %al,%al
     28f:	75 07                	jne    298 <getcmd+0x4d>
    return -1;
     291:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     296:	eb 05                	jmp    29d <getcmd+0x52>
  return 0;
     298:	b8 00 00 00 00       	mov    $0x0,%eax
}
     29d:	c9                   	leave  
     29e:	c3                   	ret    

0000029f <main>:

int
main(void)
{
     29f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2a3:	83 e4 f0             	and    $0xfffffff0,%esp
     2a6:	ff 71 fc             	pushl  -0x4(%ecx)
     2a9:	55                   	push   %ebp
     2aa:	89 e5                	mov    %esp,%ebp
     2ac:	51                   	push   %ecx
     2ad:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
     2b0:	eb 16                	jmp    2c8 <main+0x29>
    if(fd >= 3){
     2b2:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     2b6:	7e 10                	jle    2c8 <main+0x29>
      close(fd);
     2b8:	83 ec 0c             	sub    $0xc,%esp
     2bb:	ff 75 f4             	pushl  -0xc(%ebp)
     2be:	e8 0d 0c 00 00       	call   ed0 <close>
     2c3:	83 c4 10             	add    $0x10,%esp
      break;
     2c6:	eb 1b                	jmp    2e3 <main+0x44>
  while((fd = open("console", O_RDWR)) >= 0){
     2c8:	83 ec 08             	sub    $0x8,%esp
     2cb:	6a 02                	push   $0x2
     2cd:	68 0f 14 00 00       	push   $0x140f
     2d2:	e8 11 0c 00 00       	call   ee8 <open>
     2d7:	83 c4 10             	add    $0x10,%esp
     2da:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e1:	79 cf                	jns    2b2 <main+0x13>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2e3:	e9 8f 00 00 00       	jmp    377 <main+0xd8>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2e8:	a0 00 15 00 00       	mov    0x1500,%al
     2ed:	3c 63                	cmp    $0x63,%al
     2ef:	75 59                	jne    34a <main+0xab>
     2f1:	a0 01 15 00 00       	mov    0x1501,%al
     2f6:	3c 64                	cmp    $0x64,%al
     2f8:	75 50                	jne    34a <main+0xab>
     2fa:	a0 02 15 00 00       	mov    0x1502,%al
     2ff:	3c 20                	cmp    $0x20,%al
     301:	75 47                	jne    34a <main+0xab>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     303:	83 ec 0c             	sub    $0xc,%esp
     306:	68 00 15 00 00       	push   $0x1500
     30b:	e8 e4 09 00 00       	call   cf4 <strlen>
     310:	83 c4 10             	add    $0x10,%esp
     313:	48                   	dec    %eax
     314:	c6 80 00 15 00 00 00 	movb   $0x0,0x1500(%eax)
      if(chdir(buf+3) < 0)
     31b:	b8 03 15 00 00       	mov    $0x1503,%eax
     320:	83 ec 0c             	sub    $0xc,%esp
     323:	50                   	push   %eax
     324:	e8 ef 0b 00 00       	call   f18 <chdir>
     329:	83 c4 10             	add    $0x10,%esp
     32c:	85 c0                	test   %eax,%eax
     32e:	79 46                	jns    376 <main+0xd7>
        printf(2, "cannot cd %s\n", buf+3);
     330:	b8 03 15 00 00       	mov    $0x1503,%eax
     335:	83 ec 04             	sub    $0x4,%esp
     338:	50                   	push   %eax
     339:	68 17 14 00 00       	push   $0x1417
     33e:	6a 02                	push   $0x2
     340:	e8 d4 0c 00 00       	call   1019 <printf>
     345:	83 c4 10             	add    $0x10,%esp
      continue;
     348:	eb 2c                	jmp    376 <main+0xd7>
    }
    if(fork1() == 0)
     34a:	e8 67 00 00 00       	call   3b6 <fork1>
     34f:	85 c0                	test   %eax,%eax
     351:	75 1c                	jne    36f <main+0xd0>
      runcmd(parsecmd(buf));
     353:	83 ec 0c             	sub    $0xc,%esp
     356:	68 00 15 00 00       	push   $0x1500
     35b:	e8 9c 03 00 00       	call   6fc <parsecmd>
     360:	83 c4 10             	add    $0x10,%esp
     363:	83 ec 0c             	sub    $0xc,%esp
     366:	50                   	push   %eax
     367:	e8 94 fc ff ff       	call   0 <runcmd>
     36c:	83 c4 10             	add    $0x10,%esp
    wait();
     36f:	e8 3c 0b 00 00       	call   eb0 <wait>
     374:	eb 01                	jmp    377 <main+0xd8>
      continue;
     376:	90                   	nop
  while(getcmd(buf, sizeof(buf)) >= 0){
     377:	83 ec 08             	sub    $0x8,%esp
     37a:	6a 64                	push   $0x64
     37c:	68 00 15 00 00       	push   $0x1500
     381:	e8 c5 fe ff ff       	call   24b <getcmd>
     386:	83 c4 10             	add    $0x10,%esp
     389:	85 c0                	test   %eax,%eax
     38b:	0f 89 57 ff ff ff    	jns    2e8 <main+0x49>
  }
  exit();
     391:	e8 12 0b 00 00       	call   ea8 <exit>

00000396 <panic>:
}

void
panic(char *s)
{
     396:	55                   	push   %ebp
     397:	89 e5                	mov    %esp,%ebp
     399:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     39c:	83 ec 04             	sub    $0x4,%esp
     39f:	ff 75 08             	pushl  0x8(%ebp)
     3a2:	68 25 14 00 00       	push   $0x1425
     3a7:	6a 02                	push   $0x2
     3a9:	e8 6b 0c 00 00       	call   1019 <printf>
     3ae:	83 c4 10             	add    $0x10,%esp
  exit();
     3b1:	e8 f2 0a 00 00       	call   ea8 <exit>

000003b6 <fork1>:
}

int
fork1(void)
{
     3b6:	55                   	push   %ebp
     3b7:	89 e5                	mov    %esp,%ebp
     3b9:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
     3bc:	e8 df 0a 00 00       	call   ea0 <fork>
     3c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     3c4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     3c8:	75 10                	jne    3da <fork1+0x24>
    panic("fork");
     3ca:	83 ec 0c             	sub    $0xc,%esp
     3cd:	68 29 14 00 00       	push   $0x1429
     3d2:	e8 bf ff ff ff       	call   396 <panic>
     3d7:	83 c4 10             	add    $0x10,%esp
  return pid;
     3da:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3dd:	c9                   	leave  
     3de:	c3                   	ret    

000003df <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3df:	55                   	push   %ebp
     3e0:	89 e5                	mov    %esp,%ebp
     3e2:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e5:	83 ec 0c             	sub    $0xc,%esp
     3e8:	6a 54                	push   $0x54
     3ea:	e8 f8 0e 00 00       	call   12e7 <malloc>
     3ef:	83 c4 10             	add    $0x10,%esp
     3f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3f5:	83 ec 04             	sub    $0x4,%esp
     3f8:	6a 54                	push   $0x54
     3fa:	6a 00                	push   $0x0
     3fc:	ff 75 f4             	pushl  -0xc(%ebp)
     3ff:	e8 15 09 00 00       	call   d19 <memset>
     404:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     407:	8b 45 f4             	mov    -0xc(%ebp),%eax
     40a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     410:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     413:	c9                   	leave  
     414:	c3                   	ret    

00000415 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     415:	55                   	push   %ebp
     416:	89 e5                	mov    %esp,%ebp
     418:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     41b:	83 ec 0c             	sub    $0xc,%esp
     41e:	6a 18                	push   $0x18
     420:	e8 c2 0e 00 00       	call   12e7 <malloc>
     425:	83 c4 10             	add    $0x10,%esp
     428:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     42b:	83 ec 04             	sub    $0x4,%esp
     42e:	6a 18                	push   $0x18
     430:	6a 00                	push   $0x0
     432:	ff 75 f4             	pushl  -0xc(%ebp)
     435:	e8 df 08 00 00       	call   d19 <memset>
     43a:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     43d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     440:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     446:	8b 45 f4             	mov    -0xc(%ebp),%eax
     449:	8b 55 08             	mov    0x8(%ebp),%edx
     44c:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     44f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     452:	8b 55 0c             	mov    0xc(%ebp),%edx
     455:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     458:	8b 45 f4             	mov    -0xc(%ebp),%eax
     45b:	8b 55 10             	mov    0x10(%ebp),%edx
     45e:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     461:	8b 45 f4             	mov    -0xc(%ebp),%eax
     464:	8b 55 14             	mov    0x14(%ebp),%edx
     467:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     46a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46d:	8b 55 18             	mov    0x18(%ebp),%edx
     470:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     473:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     476:	c9                   	leave  
     477:	c3                   	ret    

00000478 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     478:	55                   	push   %ebp
     479:	89 e5                	mov    %esp,%ebp
     47b:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     47e:	83 ec 0c             	sub    $0xc,%esp
     481:	6a 0c                	push   $0xc
     483:	e8 5f 0e 00 00       	call   12e7 <malloc>
     488:	83 c4 10             	add    $0x10,%esp
     48b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     48e:	83 ec 04             	sub    $0x4,%esp
     491:	6a 0c                	push   $0xc
     493:	6a 00                	push   $0x0
     495:	ff 75 f4             	pushl  -0xc(%ebp)
     498:	e8 7c 08 00 00       	call   d19 <memset>
     49d:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     4a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a3:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     4a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4ac:	8b 55 08             	mov    0x8(%ebp),%edx
     4af:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b5:	8b 55 0c             	mov    0xc(%ebp),%edx
     4b8:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4be:	c9                   	leave  
     4bf:	c3                   	ret    

000004c0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4c6:	83 ec 0c             	sub    $0xc,%esp
     4c9:	6a 0c                	push   $0xc
     4cb:	e8 17 0e 00 00       	call   12e7 <malloc>
     4d0:	83 c4 10             	add    $0x10,%esp
     4d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4d6:	83 ec 04             	sub    $0x4,%esp
     4d9:	6a 0c                	push   $0xc
     4db:	6a 00                	push   $0x0
     4dd:	ff 75 f4             	pushl  -0xc(%ebp)
     4e0:	e8 34 08 00 00       	call   d19 <memset>
     4e5:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     4e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4eb:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f4:	8b 55 08             	mov    0x8(%ebp),%edx
     4f7:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4fd:	8b 55 0c             	mov    0xc(%ebp),%edx
     500:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     503:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     506:	c9                   	leave  
     507:	c3                   	ret    

00000508 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     508:	55                   	push   %ebp
     509:	89 e5                	mov    %esp,%ebp
     50b:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     50e:	83 ec 0c             	sub    $0xc,%esp
     511:	6a 08                	push   $0x8
     513:	e8 cf 0d 00 00       	call   12e7 <malloc>
     518:	83 c4 10             	add    $0x10,%esp
     51b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     51e:	83 ec 04             	sub    $0x4,%esp
     521:	6a 08                	push   $0x8
     523:	6a 00                	push   $0x0
     525:	ff 75 f4             	pushl  -0xc(%ebp)
     528:	e8 ec 07 00 00       	call   d19 <memset>
     52d:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     530:	8b 45 f4             	mov    -0xc(%ebp),%eax
     533:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     539:	8b 45 f4             	mov    -0xc(%ebp),%eax
     53c:	8b 55 08             	mov    0x8(%ebp),%edx
     53f:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     542:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     545:	c9                   	leave  
     546:	c3                   	ret    

00000547 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     547:	55                   	push   %ebp
     548:	89 e5                	mov    %esp,%ebp
     54a:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;

  s = *ps;
     54d:	8b 45 08             	mov    0x8(%ebp),%eax
     550:	8b 00                	mov    (%eax),%eax
     552:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     555:	eb 03                	jmp    55a <gettoken+0x13>
    s++;
     557:	ff 45 f4             	incl   -0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     55a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     560:	73 1d                	jae    57f <gettoken+0x38>
     562:	8b 45 f4             	mov    -0xc(%ebp),%eax
     565:	8a 00                	mov    (%eax),%al
     567:	0f be c0             	movsbl %al,%eax
     56a:	83 ec 08             	sub    $0x8,%esp
     56d:	50                   	push   %eax
     56e:	68 c0 14 00 00       	push   $0x14c0
     573:	e8 bb 07 00 00       	call   d33 <strchr>
     578:	83 c4 10             	add    $0x10,%esp
     57b:	85 c0                	test   %eax,%eax
     57d:	75 d8                	jne    557 <gettoken+0x10>
  if(q)
     57f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     583:	74 08                	je     58d <gettoken+0x46>
    *q = s;
     585:	8b 45 10             	mov    0x10(%ebp),%eax
     588:	8b 55 f4             	mov    -0xc(%ebp),%edx
     58b:	89 10                	mov    %edx,(%eax)
  ret = *s;
     58d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     590:	8a 00                	mov    (%eax),%al
     592:	0f be c0             	movsbl %al,%eax
     595:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     598:	8b 45 f4             	mov    -0xc(%ebp),%eax
     59b:	8a 00                	mov    (%eax),%al
     59d:	0f be c0             	movsbl %al,%eax
     5a0:	83 f8 7c             	cmp    $0x7c,%eax
     5a3:	74 2c                	je     5d1 <gettoken+0x8a>
     5a5:	83 f8 7c             	cmp    $0x7c,%eax
     5a8:	7f 44                	jg     5ee <gettoken+0xa7>
     5aa:	83 f8 3e             	cmp    $0x3e,%eax
     5ad:	74 27                	je     5d6 <gettoken+0x8f>
     5af:	83 f8 3e             	cmp    $0x3e,%eax
     5b2:	7f 3a                	jg     5ee <gettoken+0xa7>
     5b4:	83 f8 3c             	cmp    $0x3c,%eax
     5b7:	7f 35                	jg     5ee <gettoken+0xa7>
     5b9:	83 f8 3b             	cmp    $0x3b,%eax
     5bc:	7d 13                	jge    5d1 <gettoken+0x8a>
     5be:	83 f8 29             	cmp    $0x29,%eax
     5c1:	7f 2b                	jg     5ee <gettoken+0xa7>
     5c3:	83 f8 28             	cmp    $0x28,%eax
     5c6:	7d 09                	jge    5d1 <gettoken+0x8a>
     5c8:	85 c0                	test   %eax,%eax
     5ca:	74 72                	je     63e <gettoken+0xf7>
     5cc:	83 f8 26             	cmp    $0x26,%eax
     5cf:	75 1d                	jne    5ee <gettoken+0xa7>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5d1:	ff 45 f4             	incl   -0xc(%ebp)
    break;
     5d4:	eb 6f                	jmp    645 <gettoken+0xfe>
  case '>':
    s++;
     5d6:	ff 45 f4             	incl   -0xc(%ebp)
    if(*s == '>'){
     5d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5dc:	8a 00                	mov    (%eax),%al
     5de:	3c 3e                	cmp    $0x3e,%al
     5e0:	75 5f                	jne    641 <gettoken+0xfa>
      ret = '+';
     5e2:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5e9:	ff 45 f4             	incl   -0xc(%ebp)
    }
    break;
     5ec:	eb 53                	jmp    641 <gettoken+0xfa>
  default:
    ret = 'a';
     5ee:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f5:	eb 03                	jmp    5fa <gettoken+0xb3>
      s++;
     5f7:	ff 45 f4             	incl   -0xc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     600:	73 42                	jae    644 <gettoken+0xfd>
     602:	8b 45 f4             	mov    -0xc(%ebp),%eax
     605:	8a 00                	mov    (%eax),%al
     607:	0f be c0             	movsbl %al,%eax
     60a:	83 ec 08             	sub    $0x8,%esp
     60d:	50                   	push   %eax
     60e:	68 c0 14 00 00       	push   $0x14c0
     613:	e8 1b 07 00 00       	call   d33 <strchr>
     618:	83 c4 10             	add    $0x10,%esp
     61b:	85 c0                	test   %eax,%eax
     61d:	75 25                	jne    644 <gettoken+0xfd>
     61f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     622:	8a 00                	mov    (%eax),%al
     624:	0f be c0             	movsbl %al,%eax
     627:	83 ec 08             	sub    $0x8,%esp
     62a:	50                   	push   %eax
     62b:	68 c8 14 00 00       	push   $0x14c8
     630:	e8 fe 06 00 00       	call   d33 <strchr>
     635:	83 c4 10             	add    $0x10,%esp
     638:	85 c0                	test   %eax,%eax
     63a:	74 bb                	je     5f7 <gettoken+0xb0>
    break;
     63c:	eb 06                	jmp    644 <gettoken+0xfd>
    break;
     63e:	90                   	nop
     63f:	eb 04                	jmp    645 <gettoken+0xfe>
    break;
     641:	90                   	nop
     642:	eb 01                	jmp    645 <gettoken+0xfe>
    break;
     644:	90                   	nop
  }
  if(eq)
     645:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     649:	74 0d                	je     658 <gettoken+0x111>
    *eq = s;
     64b:	8b 45 14             	mov    0x14(%ebp),%eax
     64e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     651:	89 10                	mov    %edx,(%eax)

  while(s < es && strchr(whitespace, *s))
     653:	eb 03                	jmp    658 <gettoken+0x111>
    s++;
     655:	ff 45 f4             	incl   -0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     658:	8b 45 f4             	mov    -0xc(%ebp),%eax
     65b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     65e:	73 1d                	jae    67d <gettoken+0x136>
     660:	8b 45 f4             	mov    -0xc(%ebp),%eax
     663:	8a 00                	mov    (%eax),%al
     665:	0f be c0             	movsbl %al,%eax
     668:	83 ec 08             	sub    $0x8,%esp
     66b:	50                   	push   %eax
     66c:	68 c0 14 00 00       	push   $0x14c0
     671:	e8 bd 06 00 00       	call   d33 <strchr>
     676:	83 c4 10             	add    $0x10,%esp
     679:	85 c0                	test   %eax,%eax
     67b:	75 d8                	jne    655 <gettoken+0x10e>
  *ps = s;
     67d:	8b 45 08             	mov    0x8(%ebp),%eax
     680:	8b 55 f4             	mov    -0xc(%ebp),%edx
     683:	89 10                	mov    %edx,(%eax)
  return ret;
     685:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     688:	c9                   	leave  
     689:	c3                   	ret    

0000068a <peek>:

int
peek(char **ps, char *es, char *toks)
{
     68a:	55                   	push   %ebp
     68b:	89 e5                	mov    %esp,%ebp
     68d:	83 ec 18             	sub    $0x18,%esp
  char *s;

  s = *ps;
     690:	8b 45 08             	mov    0x8(%ebp),%eax
     693:	8b 00                	mov    (%eax),%eax
     695:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     698:	eb 03                	jmp    69d <peek+0x13>
    s++;
     69a:	ff 45 f4             	incl   -0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     69d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6a3:	73 1d                	jae    6c2 <peek+0x38>
     6a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a8:	8a 00                	mov    (%eax),%al
     6aa:	0f be c0             	movsbl %al,%eax
     6ad:	83 ec 08             	sub    $0x8,%esp
     6b0:	50                   	push   %eax
     6b1:	68 c0 14 00 00       	push   $0x14c0
     6b6:	e8 78 06 00 00       	call   d33 <strchr>
     6bb:	83 c4 10             	add    $0x10,%esp
     6be:	85 c0                	test   %eax,%eax
     6c0:	75 d8                	jne    69a <peek+0x10>
  *ps = s;
     6c2:	8b 45 08             	mov    0x8(%ebp),%eax
     6c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6c8:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6cd:	8a 00                	mov    (%eax),%al
     6cf:	84 c0                	test   %al,%al
     6d1:	74 22                	je     6f5 <peek+0x6b>
     6d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d6:	8a 00                	mov    (%eax),%al
     6d8:	0f be c0             	movsbl %al,%eax
     6db:	83 ec 08             	sub    $0x8,%esp
     6de:	50                   	push   %eax
     6df:	ff 75 10             	pushl  0x10(%ebp)
     6e2:	e8 4c 06 00 00       	call   d33 <strchr>
     6e7:	83 c4 10             	add    $0x10,%esp
     6ea:	85 c0                	test   %eax,%eax
     6ec:	74 07                	je     6f5 <peek+0x6b>
     6ee:	b8 01 00 00 00       	mov    $0x1,%eax
     6f3:	eb 05                	jmp    6fa <peek+0x70>
     6f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
     6fa:	c9                   	leave  
     6fb:	c3                   	ret    

000006fc <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     6fc:	55                   	push   %ebp
     6fd:	89 e5                	mov    %esp,%ebp
     6ff:	53                   	push   %ebx
     700:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     703:	8b 5d 08             	mov    0x8(%ebp),%ebx
     706:	8b 45 08             	mov    0x8(%ebp),%eax
     709:	83 ec 0c             	sub    $0xc,%esp
     70c:	50                   	push   %eax
     70d:	e8 e2 05 00 00       	call   cf4 <strlen>
     712:	83 c4 10             	add    $0x10,%esp
     715:	01 d8                	add    %ebx,%eax
     717:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     71a:	83 ec 08             	sub    $0x8,%esp
     71d:	ff 75 f4             	pushl  -0xc(%ebp)
     720:	8d 45 08             	lea    0x8(%ebp),%eax
     723:	50                   	push   %eax
     724:	e8 61 00 00 00       	call   78a <parseline>
     729:	83 c4 10             	add    $0x10,%esp
     72c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     72f:	83 ec 04             	sub    $0x4,%esp
     732:	68 2e 14 00 00       	push   $0x142e
     737:	ff 75 f4             	pushl  -0xc(%ebp)
     73a:	8d 45 08             	lea    0x8(%ebp),%eax
     73d:	50                   	push   %eax
     73e:	e8 47 ff ff ff       	call   68a <peek>
     743:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     746:	8b 45 08             	mov    0x8(%ebp),%eax
     749:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     74c:	74 26                	je     774 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     74e:	8b 45 08             	mov    0x8(%ebp),%eax
     751:	83 ec 04             	sub    $0x4,%esp
     754:	50                   	push   %eax
     755:	68 2f 14 00 00       	push   $0x142f
     75a:	6a 02                	push   $0x2
     75c:	e8 b8 08 00 00       	call   1019 <printf>
     761:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     764:	83 ec 0c             	sub    $0xc,%esp
     767:	68 3e 14 00 00       	push   $0x143e
     76c:	e8 25 fc ff ff       	call   396 <panic>
     771:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     774:	83 ec 0c             	sub    $0xc,%esp
     777:	ff 75 f0             	pushl  -0x10(%ebp)
     77a:	e8 ee 03 00 00       	call   b6d <nulterminate>
     77f:	83 c4 10             	add    $0x10,%esp
  return cmd;
     782:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     785:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     788:	c9                   	leave  
     789:	c3                   	ret    

0000078a <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     78a:	55                   	push   %ebp
     78b:	89 e5                	mov    %esp,%ebp
     78d:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     790:	83 ec 08             	sub    $0x8,%esp
     793:	ff 75 0c             	pushl  0xc(%ebp)
     796:	ff 75 08             	pushl  0x8(%ebp)
     799:	e8 99 00 00 00       	call   837 <parsepipe>
     79e:	83 c4 10             	add    $0x10,%esp
     7a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7a4:	eb 23                	jmp    7c9 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     7a6:	6a 00                	push   $0x0
     7a8:	6a 00                	push   $0x0
     7aa:	ff 75 0c             	pushl  0xc(%ebp)
     7ad:	ff 75 08             	pushl  0x8(%ebp)
     7b0:	e8 92 fd ff ff       	call   547 <gettoken>
     7b5:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     7b8:	83 ec 0c             	sub    $0xc,%esp
     7bb:	ff 75 f4             	pushl  -0xc(%ebp)
     7be:	e8 45 fd ff ff       	call   508 <backcmd>
     7c3:	83 c4 10             	add    $0x10,%esp
     7c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7c9:	83 ec 04             	sub    $0x4,%esp
     7cc:	68 45 14 00 00       	push   $0x1445
     7d1:	ff 75 0c             	pushl  0xc(%ebp)
     7d4:	ff 75 08             	pushl  0x8(%ebp)
     7d7:	e8 ae fe ff ff       	call   68a <peek>
     7dc:	83 c4 10             	add    $0x10,%esp
     7df:	85 c0                	test   %eax,%eax
     7e1:	75 c3                	jne    7a6 <parseline+0x1c>
  }
  if(peek(ps, es, ";")){
     7e3:	83 ec 04             	sub    $0x4,%esp
     7e6:	68 47 14 00 00       	push   $0x1447
     7eb:	ff 75 0c             	pushl  0xc(%ebp)
     7ee:	ff 75 08             	pushl  0x8(%ebp)
     7f1:	e8 94 fe ff ff       	call   68a <peek>
     7f6:	83 c4 10             	add    $0x10,%esp
     7f9:	85 c0                	test   %eax,%eax
     7fb:	74 35                	je     832 <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     7fd:	6a 00                	push   $0x0
     7ff:	6a 00                	push   $0x0
     801:	ff 75 0c             	pushl  0xc(%ebp)
     804:	ff 75 08             	pushl  0x8(%ebp)
     807:	e8 3b fd ff ff       	call   547 <gettoken>
     80c:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     80f:	83 ec 08             	sub    $0x8,%esp
     812:	ff 75 0c             	pushl  0xc(%ebp)
     815:	ff 75 08             	pushl  0x8(%ebp)
     818:	e8 6d ff ff ff       	call   78a <parseline>
     81d:	83 c4 10             	add    $0x10,%esp
     820:	83 ec 08             	sub    $0x8,%esp
     823:	50                   	push   %eax
     824:	ff 75 f4             	pushl  -0xc(%ebp)
     827:	e8 94 fc ff ff       	call   4c0 <listcmd>
     82c:	83 c4 10             	add    $0x10,%esp
     82f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     832:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     835:	c9                   	leave  
     836:	c3                   	ret    

00000837 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     837:	55                   	push   %ebp
     838:	89 e5                	mov    %esp,%ebp
     83a:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     83d:	83 ec 08             	sub    $0x8,%esp
     840:	ff 75 0c             	pushl  0xc(%ebp)
     843:	ff 75 08             	pushl  0x8(%ebp)
     846:	e8 f0 01 00 00       	call   a3b <parseexec>
     84b:	83 c4 10             	add    $0x10,%esp
     84e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     851:	83 ec 04             	sub    $0x4,%esp
     854:	68 49 14 00 00       	push   $0x1449
     859:	ff 75 0c             	pushl  0xc(%ebp)
     85c:	ff 75 08             	pushl  0x8(%ebp)
     85f:	e8 26 fe ff ff       	call   68a <peek>
     864:	83 c4 10             	add    $0x10,%esp
     867:	85 c0                	test   %eax,%eax
     869:	74 35                	je     8a0 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     86b:	6a 00                	push   $0x0
     86d:	6a 00                	push   $0x0
     86f:	ff 75 0c             	pushl  0xc(%ebp)
     872:	ff 75 08             	pushl  0x8(%ebp)
     875:	e8 cd fc ff ff       	call   547 <gettoken>
     87a:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     87d:	83 ec 08             	sub    $0x8,%esp
     880:	ff 75 0c             	pushl  0xc(%ebp)
     883:	ff 75 08             	pushl  0x8(%ebp)
     886:	e8 ac ff ff ff       	call   837 <parsepipe>
     88b:	83 c4 10             	add    $0x10,%esp
     88e:	83 ec 08             	sub    $0x8,%esp
     891:	50                   	push   %eax
     892:	ff 75 f4             	pushl  -0xc(%ebp)
     895:	e8 de fb ff ff       	call   478 <pipecmd>
     89a:	83 c4 10             	add    $0x10,%esp
     89d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     8a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8a3:	c9                   	leave  
     8a4:	c3                   	ret    

000008a5 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8a5:	55                   	push   %ebp
     8a6:	89 e5                	mov    %esp,%ebp
     8a8:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8ab:	e9 ba 00 00 00       	jmp    96a <parseredirs+0xc5>
    tok = gettoken(ps, es, 0, 0);
     8b0:	6a 00                	push   $0x0
     8b2:	6a 00                	push   $0x0
     8b4:	ff 75 10             	pushl  0x10(%ebp)
     8b7:	ff 75 0c             	pushl  0xc(%ebp)
     8ba:	e8 88 fc ff ff       	call   547 <gettoken>
     8bf:	83 c4 10             	add    $0x10,%esp
     8c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     8c5:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8c8:	50                   	push   %eax
     8c9:	8d 45 f0             	lea    -0x10(%ebp),%eax
     8cc:	50                   	push   %eax
     8cd:	ff 75 10             	pushl  0x10(%ebp)
     8d0:	ff 75 0c             	pushl  0xc(%ebp)
     8d3:	e8 6f fc ff ff       	call   547 <gettoken>
     8d8:	83 c4 10             	add    $0x10,%esp
     8db:	83 f8 61             	cmp    $0x61,%eax
     8de:	74 10                	je     8f0 <parseredirs+0x4b>
      panic("missing file for redirection");
     8e0:	83 ec 0c             	sub    $0xc,%esp
     8e3:	68 4b 14 00 00       	push   $0x144b
     8e8:	e8 a9 fa ff ff       	call   396 <panic>
     8ed:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     8f0:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     8f4:	74 31                	je     927 <parseredirs+0x82>
     8f6:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     8fa:	7f 6e                	jg     96a <parseredirs+0xc5>
     8fc:	83 7d f4 2b          	cmpl   $0x2b,-0xc(%ebp)
     900:	74 47                	je     949 <parseredirs+0xa4>
     902:	83 7d f4 3c          	cmpl   $0x3c,-0xc(%ebp)
     906:	75 62                	jne    96a <parseredirs+0xc5>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     908:	8b 55 ec             	mov    -0x14(%ebp),%edx
     90b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     90e:	83 ec 0c             	sub    $0xc,%esp
     911:	6a 00                	push   $0x0
     913:	6a 00                	push   $0x0
     915:	52                   	push   %edx
     916:	50                   	push   %eax
     917:	ff 75 08             	pushl  0x8(%ebp)
     91a:	e8 f6 fa ff ff       	call   415 <redircmd>
     91f:	83 c4 20             	add    $0x20,%esp
     922:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     925:	eb 43                	jmp    96a <parseredirs+0xc5>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     927:	8b 55 ec             	mov    -0x14(%ebp),%edx
     92a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     92d:	83 ec 0c             	sub    $0xc,%esp
     930:	6a 01                	push   $0x1
     932:	68 01 02 00 00       	push   $0x201
     937:	52                   	push   %edx
     938:	50                   	push   %eax
     939:	ff 75 08             	pushl  0x8(%ebp)
     93c:	e8 d4 fa ff ff       	call   415 <redircmd>
     941:	83 c4 20             	add    $0x20,%esp
     944:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     947:	eb 21                	jmp    96a <parseredirs+0xc5>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     949:	8b 55 ec             	mov    -0x14(%ebp),%edx
     94c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     94f:	83 ec 0c             	sub    $0xc,%esp
     952:	6a 01                	push   $0x1
     954:	68 01 02 00 00       	push   $0x201
     959:	52                   	push   %edx
     95a:	50                   	push   %eax
     95b:	ff 75 08             	pushl  0x8(%ebp)
     95e:	e8 b2 fa ff ff       	call   415 <redircmd>
     963:	83 c4 20             	add    $0x20,%esp
     966:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     969:	90                   	nop
  while(peek(ps, es, "<>")){
     96a:	83 ec 04             	sub    $0x4,%esp
     96d:	68 68 14 00 00       	push   $0x1468
     972:	ff 75 10             	pushl  0x10(%ebp)
     975:	ff 75 0c             	pushl  0xc(%ebp)
     978:	e8 0d fd ff ff       	call   68a <peek>
     97d:	83 c4 10             	add    $0x10,%esp
     980:	85 c0                	test   %eax,%eax
     982:	0f 85 28 ff ff ff    	jne    8b0 <parseredirs+0xb>
    }
  }
  return cmd;
     988:	8b 45 08             	mov    0x8(%ebp),%eax
}
     98b:	c9                   	leave  
     98c:	c3                   	ret    

0000098d <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     98d:	55                   	push   %ebp
     98e:	89 e5                	mov    %esp,%ebp
     990:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     993:	83 ec 04             	sub    $0x4,%esp
     996:	68 6b 14 00 00       	push   $0x146b
     99b:	ff 75 0c             	pushl  0xc(%ebp)
     99e:	ff 75 08             	pushl  0x8(%ebp)
     9a1:	e8 e4 fc ff ff       	call   68a <peek>
     9a6:	83 c4 10             	add    $0x10,%esp
     9a9:	85 c0                	test   %eax,%eax
     9ab:	75 10                	jne    9bd <parseblock+0x30>
    panic("parseblock");
     9ad:	83 ec 0c             	sub    $0xc,%esp
     9b0:	68 6d 14 00 00       	push   $0x146d
     9b5:	e8 dc f9 ff ff       	call   396 <panic>
     9ba:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     9bd:	6a 00                	push   $0x0
     9bf:	6a 00                	push   $0x0
     9c1:	ff 75 0c             	pushl  0xc(%ebp)
     9c4:	ff 75 08             	pushl  0x8(%ebp)
     9c7:	e8 7b fb ff ff       	call   547 <gettoken>
     9cc:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     9cf:	83 ec 08             	sub    $0x8,%esp
     9d2:	ff 75 0c             	pushl  0xc(%ebp)
     9d5:	ff 75 08             	pushl  0x8(%ebp)
     9d8:	e8 ad fd ff ff       	call   78a <parseline>
     9dd:	83 c4 10             	add    $0x10,%esp
     9e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     9e3:	83 ec 04             	sub    $0x4,%esp
     9e6:	68 78 14 00 00       	push   $0x1478
     9eb:	ff 75 0c             	pushl  0xc(%ebp)
     9ee:	ff 75 08             	pushl  0x8(%ebp)
     9f1:	e8 94 fc ff ff       	call   68a <peek>
     9f6:	83 c4 10             	add    $0x10,%esp
     9f9:	85 c0                	test   %eax,%eax
     9fb:	75 10                	jne    a0d <parseblock+0x80>
    panic("syntax - missing )");
     9fd:	83 ec 0c             	sub    $0xc,%esp
     a00:	68 7a 14 00 00       	push   $0x147a
     a05:	e8 8c f9 ff ff       	call   396 <panic>
     a0a:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     a0d:	6a 00                	push   $0x0
     a0f:	6a 00                	push   $0x0
     a11:	ff 75 0c             	pushl  0xc(%ebp)
     a14:	ff 75 08             	pushl  0x8(%ebp)
     a17:	e8 2b fb ff ff       	call   547 <gettoken>
     a1c:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     a1f:	83 ec 04             	sub    $0x4,%esp
     a22:	ff 75 0c             	pushl  0xc(%ebp)
     a25:	ff 75 08             	pushl  0x8(%ebp)
     a28:	ff 75 f4             	pushl  -0xc(%ebp)
     a2b:	e8 75 fe ff ff       	call   8a5 <parseredirs>
     a30:	83 c4 10             	add    $0x10,%esp
     a33:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a39:	c9                   	leave  
     a3a:	c3                   	ret    

00000a3b <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     a3b:	55                   	push   %ebp
     a3c:	89 e5                	mov    %esp,%ebp
     a3e:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     a41:	83 ec 04             	sub    $0x4,%esp
     a44:	68 6b 14 00 00       	push   $0x146b
     a49:	ff 75 0c             	pushl  0xc(%ebp)
     a4c:	ff 75 08             	pushl  0x8(%ebp)
     a4f:	e8 36 fc ff ff       	call   68a <peek>
     a54:	83 c4 10             	add    $0x10,%esp
     a57:	85 c0                	test   %eax,%eax
     a59:	74 16                	je     a71 <parseexec+0x36>
    return parseblock(ps, es);
     a5b:	83 ec 08             	sub    $0x8,%esp
     a5e:	ff 75 0c             	pushl  0xc(%ebp)
     a61:	ff 75 08             	pushl  0x8(%ebp)
     a64:	e8 24 ff ff ff       	call   98d <parseblock>
     a69:	83 c4 10             	add    $0x10,%esp
     a6c:	e9 fa 00 00 00       	jmp    b6b <parseexec+0x130>

  ret = execcmd();
     a71:	e8 69 f9 ff ff       	call   3df <execcmd>
     a76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     a79:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a7c:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     a7f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     a86:	83 ec 04             	sub    $0x4,%esp
     a89:	ff 75 0c             	pushl  0xc(%ebp)
     a8c:	ff 75 08             	pushl  0x8(%ebp)
     a8f:	ff 75 f0             	pushl  -0x10(%ebp)
     a92:	e8 0e fe ff ff       	call   8a5 <parseredirs>
     a97:	83 c4 10             	add    $0x10,%esp
     a9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     a9d:	e9 86 00 00 00       	jmp    b28 <parseexec+0xed>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     aa2:	8d 45 e0             	lea    -0x20(%ebp),%eax
     aa5:	50                   	push   %eax
     aa6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     aa9:	50                   	push   %eax
     aaa:	ff 75 0c             	pushl  0xc(%ebp)
     aad:	ff 75 08             	pushl  0x8(%ebp)
     ab0:	e8 92 fa ff ff       	call   547 <gettoken>
     ab5:	83 c4 10             	add    $0x10,%esp
     ab8:	89 45 e8             	mov    %eax,-0x18(%ebp)
     abb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     abf:	0f 84 83 00 00 00    	je     b48 <parseexec+0x10d>
      break;
    if(tok != 'a')
     ac5:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     ac9:	74 10                	je     adb <parseexec+0xa0>
      panic("syntax");
     acb:	83 ec 0c             	sub    $0xc,%esp
     ace:	68 3e 14 00 00       	push   $0x143e
     ad3:	e8 be f8 ff ff       	call   396 <panic>
     ad8:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     adb:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     ade:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ae1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ae4:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     ae8:	8b 55 e0             	mov    -0x20(%ebp),%edx
     aeb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     aee:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     af1:	83 c1 08             	add    $0x8,%ecx
     af4:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     af8:	ff 45 f4             	incl   -0xc(%ebp)
    if(argc >= MAXARGS)
     afb:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     aff:	7e 10                	jle    b11 <parseexec+0xd6>
      panic("too many args");
     b01:	83 ec 0c             	sub    $0xc,%esp
     b04:	68 8d 14 00 00       	push   $0x148d
     b09:	e8 88 f8 ff ff       	call   396 <panic>
     b0e:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     b11:	83 ec 04             	sub    $0x4,%esp
     b14:	ff 75 0c             	pushl  0xc(%ebp)
     b17:	ff 75 08             	pushl  0x8(%ebp)
     b1a:	ff 75 f0             	pushl  -0x10(%ebp)
     b1d:	e8 83 fd ff ff       	call   8a5 <parseredirs>
     b22:	83 c4 10             	add    $0x10,%esp
     b25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     b28:	83 ec 04             	sub    $0x4,%esp
     b2b:	68 9b 14 00 00       	push   $0x149b
     b30:	ff 75 0c             	pushl  0xc(%ebp)
     b33:	ff 75 08             	pushl  0x8(%ebp)
     b36:	e8 4f fb ff ff       	call   68a <peek>
     b3b:	83 c4 10             	add    $0x10,%esp
     b3e:	85 c0                	test   %eax,%eax
     b40:	0f 84 5c ff ff ff    	je     aa2 <parseexec+0x67>
     b46:	eb 01                	jmp    b49 <parseexec+0x10e>
      break;
     b48:	90                   	nop
  }
  cmd->argv[argc] = 0;
     b49:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b4f:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     b56:	00 
  cmd->eargv[argc] = 0;
     b57:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b5d:	83 c2 08             	add    $0x8,%edx
     b60:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     b67:	00 
  return ret;
     b68:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b6b:	c9                   	leave  
     b6c:	c3                   	ret    

00000b6d <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b6d:	55                   	push   %ebp
     b6e:	89 e5                	mov    %esp,%ebp
     b70:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b73:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b77:	75 0a                	jne    b83 <nulterminate+0x16>
    return 0;
     b79:	b8 00 00 00 00       	mov    $0x0,%eax
     b7e:	e9 e3 00 00 00       	jmp    c66 <nulterminate+0xf9>

  switch(cmd->type){
     b83:	8b 45 08             	mov    0x8(%ebp),%eax
     b86:	8b 00                	mov    (%eax),%eax
     b88:	83 f8 05             	cmp    $0x5,%eax
     b8b:	0f 87 d2 00 00 00    	ja     c63 <nulterminate+0xf6>
     b91:	8b 04 85 a0 14 00 00 	mov    0x14a0(,%eax,4),%eax
     b98:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     b9a:	8b 45 08             	mov    0x8(%ebp),%eax
     b9d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     ba0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ba7:	eb 13                	jmp    bbc <nulterminate+0x4f>
      *ecmd->eargv[i] = 0;
     ba9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bac:	8b 55 f4             	mov    -0xc(%ebp),%edx
     baf:	83 c2 08             	add    $0x8,%edx
     bb2:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     bb6:	c6 00 00             	movb   $0x0,(%eax)
    for(i=0; ecmd->argv[i]; i++)
     bb9:	ff 45 f4             	incl   -0xc(%ebp)
     bbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bc2:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     bc6:	85 c0                	test   %eax,%eax
     bc8:	75 df                	jne    ba9 <nulterminate+0x3c>
    break;
     bca:	e9 94 00 00 00       	jmp    c63 <nulterminate+0xf6>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     bcf:	8b 45 08             	mov    0x8(%ebp),%eax
     bd2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(rcmd->cmd);
     bd5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bd8:	8b 40 04             	mov    0x4(%eax),%eax
     bdb:	83 ec 0c             	sub    $0xc,%esp
     bde:	50                   	push   %eax
     bdf:	e8 89 ff ff ff       	call   b6d <nulterminate>
     be4:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     be7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bea:	8b 40 0c             	mov    0xc(%eax),%eax
     bed:	c6 00 00             	movb   $0x0,(%eax)
    break;
     bf0:	eb 71                	jmp    c63 <nulterminate+0xf6>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     bf2:	8b 45 08             	mov    0x8(%ebp),%eax
     bf5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     bf8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bfb:	8b 40 04             	mov    0x4(%eax),%eax
     bfe:	83 ec 0c             	sub    $0xc,%esp
     c01:	50                   	push   %eax
     c02:	e8 66 ff ff ff       	call   b6d <nulterminate>
     c07:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     c0a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c0d:	8b 40 08             	mov    0x8(%eax),%eax
     c10:	83 ec 0c             	sub    $0xc,%esp
     c13:	50                   	push   %eax
     c14:	e8 54 ff ff ff       	call   b6d <nulterminate>
     c19:	83 c4 10             	add    $0x10,%esp
    break;
     c1c:	eb 45                	jmp    c63 <nulterminate+0xf6>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     c1e:	8b 45 08             	mov    0x8(%ebp),%eax
     c21:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(lcmd->left);
     c24:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c27:	8b 40 04             	mov    0x4(%eax),%eax
     c2a:	83 ec 0c             	sub    $0xc,%esp
     c2d:	50                   	push   %eax
     c2e:	e8 3a ff ff ff       	call   b6d <nulterminate>
     c33:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     c36:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c39:	8b 40 08             	mov    0x8(%eax),%eax
     c3c:	83 ec 0c             	sub    $0xc,%esp
     c3f:	50                   	push   %eax
     c40:	e8 28 ff ff ff       	call   b6d <nulterminate>
     c45:	83 c4 10             	add    $0x10,%esp
    break;
     c48:	eb 19                	jmp    c63 <nulterminate+0xf6>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     c4a:	8b 45 08             	mov    0x8(%ebp),%eax
     c4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    nulterminate(bcmd->cmd);
     c50:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c53:	8b 40 04             	mov    0x4(%eax),%eax
     c56:	83 ec 0c             	sub    $0xc,%esp
     c59:	50                   	push   %eax
     c5a:	e8 0e ff ff ff       	call   b6d <nulterminate>
     c5f:	83 c4 10             	add    $0x10,%esp
    break;
     c62:	90                   	nop
  }
  return cmd;
     c63:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c66:	c9                   	leave  
     c67:	c3                   	ret    

00000c68 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     c68:	55                   	push   %ebp
     c69:	89 e5                	mov    %esp,%ebp
     c6b:	57                   	push   %edi
     c6c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     c6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c70:	8b 55 10             	mov    0x10(%ebp),%edx
     c73:	8b 45 0c             	mov    0xc(%ebp),%eax
     c76:	89 cb                	mov    %ecx,%ebx
     c78:	89 df                	mov    %ebx,%edi
     c7a:	89 d1                	mov    %edx,%ecx
     c7c:	fc                   	cld    
     c7d:	f3 aa                	rep stos %al,%es:(%edi)
     c7f:	89 ca                	mov    %ecx,%edx
     c81:	89 fb                	mov    %edi,%ebx
     c83:	89 5d 08             	mov    %ebx,0x8(%ebp)
     c86:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     c89:	90                   	nop
     c8a:	5b                   	pop    %ebx
     c8b:	5f                   	pop    %edi
     c8c:	5d                   	pop    %ebp
     c8d:	c3                   	ret    

00000c8e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     c8e:	55                   	push   %ebp
     c8f:	89 e5                	mov    %esp,%ebp
     c91:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     c94:	8b 45 08             	mov    0x8(%ebp),%eax
     c97:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     c9a:	90                   	nop
     c9b:	8b 55 0c             	mov    0xc(%ebp),%edx
     c9e:	8d 42 01             	lea    0x1(%edx),%eax
     ca1:	89 45 0c             	mov    %eax,0xc(%ebp)
     ca4:	8b 45 08             	mov    0x8(%ebp),%eax
     ca7:	8d 48 01             	lea    0x1(%eax),%ecx
     caa:	89 4d 08             	mov    %ecx,0x8(%ebp)
     cad:	8a 12                	mov    (%edx),%dl
     caf:	88 10                	mov    %dl,(%eax)
     cb1:	8a 00                	mov    (%eax),%al
     cb3:	84 c0                	test   %al,%al
     cb5:	75 e4                	jne    c9b <strcpy+0xd>
    ;
  return os;
     cb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     cba:	c9                   	leave  
     cbb:	c3                   	ret    

00000cbc <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cbc:	55                   	push   %ebp
     cbd:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     cbf:	eb 06                	jmp    cc7 <strcmp+0xb>
    p++, q++;
     cc1:	ff 45 08             	incl   0x8(%ebp)
     cc4:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
     cc7:	8b 45 08             	mov    0x8(%ebp),%eax
     cca:	8a 00                	mov    (%eax),%al
     ccc:	84 c0                	test   %al,%al
     cce:	74 0e                	je     cde <strcmp+0x22>
     cd0:	8b 45 08             	mov    0x8(%ebp),%eax
     cd3:	8a 10                	mov    (%eax),%dl
     cd5:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd8:	8a 00                	mov    (%eax),%al
     cda:	38 c2                	cmp    %al,%dl
     cdc:	74 e3                	je     cc1 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     cde:	8b 45 08             	mov    0x8(%ebp),%eax
     ce1:	8a 00                	mov    (%eax),%al
     ce3:	0f b6 d0             	movzbl %al,%edx
     ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce9:	8a 00                	mov    (%eax),%al
     ceb:	0f b6 c0             	movzbl %al,%eax
     cee:	29 c2                	sub    %eax,%edx
     cf0:	89 d0                	mov    %edx,%eax
}
     cf2:	5d                   	pop    %ebp
     cf3:	c3                   	ret    

00000cf4 <strlen>:

uint
strlen(char *s)
{
     cf4:	55                   	push   %ebp
     cf5:	89 e5                	mov    %esp,%ebp
     cf7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     cfa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d01:	eb 03                	jmp    d06 <strlen+0x12>
     d03:	ff 45 fc             	incl   -0x4(%ebp)
     d06:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d09:	8b 45 08             	mov    0x8(%ebp),%eax
     d0c:	01 d0                	add    %edx,%eax
     d0e:	8a 00                	mov    (%eax),%al
     d10:	84 c0                	test   %al,%al
     d12:	75 ef                	jne    d03 <strlen+0xf>
    ;
  return n;
     d14:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d17:	c9                   	leave  
     d18:	c3                   	ret    

00000d19 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d19:	55                   	push   %ebp
     d1a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     d1c:	8b 45 10             	mov    0x10(%ebp),%eax
     d1f:	50                   	push   %eax
     d20:	ff 75 0c             	pushl  0xc(%ebp)
     d23:	ff 75 08             	pushl  0x8(%ebp)
     d26:	e8 3d ff ff ff       	call   c68 <stosb>
     d2b:	83 c4 0c             	add    $0xc,%esp
  return dst;
     d2e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d31:	c9                   	leave  
     d32:	c3                   	ret    

00000d33 <strchr>:

char*
strchr(const char *s, char c)
{
     d33:	55                   	push   %ebp
     d34:	89 e5                	mov    %esp,%ebp
     d36:	83 ec 04             	sub    $0x4,%esp
     d39:	8b 45 0c             	mov    0xc(%ebp),%eax
     d3c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     d3f:	eb 12                	jmp    d53 <strchr+0x20>
    if(*s == c)
     d41:	8b 45 08             	mov    0x8(%ebp),%eax
     d44:	8a 00                	mov    (%eax),%al
     d46:	38 45 fc             	cmp    %al,-0x4(%ebp)
     d49:	75 05                	jne    d50 <strchr+0x1d>
      return (char*)s;
     d4b:	8b 45 08             	mov    0x8(%ebp),%eax
     d4e:	eb 11                	jmp    d61 <strchr+0x2e>
  for(; *s; s++)
     d50:	ff 45 08             	incl   0x8(%ebp)
     d53:	8b 45 08             	mov    0x8(%ebp),%eax
     d56:	8a 00                	mov    (%eax),%al
     d58:	84 c0                	test   %al,%al
     d5a:	75 e5                	jne    d41 <strchr+0xe>
  return 0;
     d5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d61:	c9                   	leave  
     d62:	c3                   	ret    

00000d63 <gets>:

char*
gets(char *buf, int max)
{
     d63:	55                   	push   %ebp
     d64:	89 e5                	mov    %esp,%ebp
     d66:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d69:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d70:	eb 3f                	jmp    db1 <gets+0x4e>
    cc = read(0, &c, 1);
     d72:	83 ec 04             	sub    $0x4,%esp
     d75:	6a 01                	push   $0x1
     d77:	8d 45 ef             	lea    -0x11(%ebp),%eax
     d7a:	50                   	push   %eax
     d7b:	6a 00                	push   $0x0
     d7d:	e8 3e 01 00 00       	call   ec0 <read>
     d82:	83 c4 10             	add    $0x10,%esp
     d85:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     d88:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d8c:	7e 2e                	jle    dbc <gets+0x59>
      break;
    buf[i++] = c;
     d8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d91:	8d 50 01             	lea    0x1(%eax),%edx
     d94:	89 55 f4             	mov    %edx,-0xc(%ebp)
     d97:	89 c2                	mov    %eax,%edx
     d99:	8b 45 08             	mov    0x8(%ebp),%eax
     d9c:	01 c2                	add    %eax,%edx
     d9e:	8a 45 ef             	mov    -0x11(%ebp),%al
     da1:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     da3:	8a 45 ef             	mov    -0x11(%ebp),%al
     da6:	3c 0a                	cmp    $0xa,%al
     da8:	74 13                	je     dbd <gets+0x5a>
     daa:	8a 45 ef             	mov    -0x11(%ebp),%al
     dad:	3c 0d                	cmp    $0xd,%al
     daf:	74 0c                	je     dbd <gets+0x5a>
  for(i=0; i+1 < max; ){
     db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db4:	40                   	inc    %eax
     db5:	39 45 0c             	cmp    %eax,0xc(%ebp)
     db8:	7f b8                	jg     d72 <gets+0xf>
     dba:	eb 01                	jmp    dbd <gets+0x5a>
      break;
     dbc:	90                   	nop
      break;
  }
  buf[i] = '\0';
     dbd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     dc0:	8b 45 08             	mov    0x8(%ebp),%eax
     dc3:	01 d0                	add    %edx,%eax
     dc5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     dc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     dcb:	c9                   	leave  
     dcc:	c3                   	ret    

00000dcd <stat>:

int
stat(char *n, struct stat *st)
{
     dcd:	55                   	push   %ebp
     dce:	89 e5                	mov    %esp,%ebp
     dd0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     dd3:	83 ec 08             	sub    $0x8,%esp
     dd6:	6a 00                	push   $0x0
     dd8:	ff 75 08             	pushl  0x8(%ebp)
     ddb:	e8 08 01 00 00       	call   ee8 <open>
     de0:	83 c4 10             	add    $0x10,%esp
     de3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     de6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dea:	79 07                	jns    df3 <stat+0x26>
    return -1;
     dec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     df1:	eb 25                	jmp    e18 <stat+0x4b>
  r = fstat(fd, st);
     df3:	83 ec 08             	sub    $0x8,%esp
     df6:	ff 75 0c             	pushl  0xc(%ebp)
     df9:	ff 75 f4             	pushl  -0xc(%ebp)
     dfc:	e8 ff 00 00 00       	call   f00 <fstat>
     e01:	83 c4 10             	add    $0x10,%esp
     e04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     e07:	83 ec 0c             	sub    $0xc,%esp
     e0a:	ff 75 f4             	pushl  -0xc(%ebp)
     e0d:	e8 be 00 00 00       	call   ed0 <close>
     e12:	83 c4 10             	add    $0x10,%esp
  return r;
     e15:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e18:	c9                   	leave  
     e19:	c3                   	ret    

00000e1a <atoi>:

int
atoi(const char *s)
{
     e1a:	55                   	push   %ebp
     e1b:	89 e5                	mov    %esp,%ebp
     e1d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     e20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e27:	eb 24                	jmp    e4d <atoi+0x33>
    n = n*10 + *s++ - '0';
     e29:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e2c:	89 d0                	mov    %edx,%eax
     e2e:	c1 e0 02             	shl    $0x2,%eax
     e31:	01 d0                	add    %edx,%eax
     e33:	01 c0                	add    %eax,%eax
     e35:	89 c1                	mov    %eax,%ecx
     e37:	8b 45 08             	mov    0x8(%ebp),%eax
     e3a:	8d 50 01             	lea    0x1(%eax),%edx
     e3d:	89 55 08             	mov    %edx,0x8(%ebp)
     e40:	8a 00                	mov    (%eax),%al
     e42:	0f be c0             	movsbl %al,%eax
     e45:	01 c8                	add    %ecx,%eax
     e47:	83 e8 30             	sub    $0x30,%eax
     e4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e4d:	8b 45 08             	mov    0x8(%ebp),%eax
     e50:	8a 00                	mov    (%eax),%al
     e52:	3c 2f                	cmp    $0x2f,%al
     e54:	7e 09                	jle    e5f <atoi+0x45>
     e56:	8b 45 08             	mov    0x8(%ebp),%eax
     e59:	8a 00                	mov    (%eax),%al
     e5b:	3c 39                	cmp    $0x39,%al
     e5d:	7e ca                	jle    e29 <atoi+0xf>
  return n;
     e5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e62:	c9                   	leave  
     e63:	c3                   	ret    

00000e64 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e64:	55                   	push   %ebp
     e65:	89 e5                	mov    %esp,%ebp
     e67:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     e6a:	8b 45 08             	mov    0x8(%ebp),%eax
     e6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     e70:	8b 45 0c             	mov    0xc(%ebp),%eax
     e73:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     e76:	eb 16                	jmp    e8e <memmove+0x2a>
    *dst++ = *src++;
     e78:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e7b:	8d 42 01             	lea    0x1(%edx),%eax
     e7e:	89 45 f8             	mov    %eax,-0x8(%ebp)
     e81:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e84:	8d 48 01             	lea    0x1(%eax),%ecx
     e87:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     e8a:	8a 12                	mov    (%edx),%dl
     e8c:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     e8e:	8b 45 10             	mov    0x10(%ebp),%eax
     e91:	8d 50 ff             	lea    -0x1(%eax),%edx
     e94:	89 55 10             	mov    %edx,0x10(%ebp)
     e97:	85 c0                	test   %eax,%eax
     e99:	7f dd                	jg     e78 <memmove+0x14>
  return vdst;
     e9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e9e:	c9                   	leave  
     e9f:	c3                   	ret    

00000ea0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     ea0:	b8 01 00 00 00       	mov    $0x1,%eax
     ea5:	cd 40                	int    $0x40
     ea7:	c3                   	ret    

00000ea8 <exit>:
SYSCALL(exit)
     ea8:	b8 02 00 00 00       	mov    $0x2,%eax
     ead:	cd 40                	int    $0x40
     eaf:	c3                   	ret    

00000eb0 <wait>:
SYSCALL(wait)
     eb0:	b8 03 00 00 00       	mov    $0x3,%eax
     eb5:	cd 40                	int    $0x40
     eb7:	c3                   	ret    

00000eb8 <pipe>:
SYSCALL(pipe)
     eb8:	b8 04 00 00 00       	mov    $0x4,%eax
     ebd:	cd 40                	int    $0x40
     ebf:	c3                   	ret    

00000ec0 <read>:
SYSCALL(read)
     ec0:	b8 05 00 00 00       	mov    $0x5,%eax
     ec5:	cd 40                	int    $0x40
     ec7:	c3                   	ret    

00000ec8 <write>:
SYSCALL(write)
     ec8:	b8 10 00 00 00       	mov    $0x10,%eax
     ecd:	cd 40                	int    $0x40
     ecf:	c3                   	ret    

00000ed0 <close>:
SYSCALL(close)
     ed0:	b8 15 00 00 00       	mov    $0x15,%eax
     ed5:	cd 40                	int    $0x40
     ed7:	c3                   	ret    

00000ed8 <kill>:
SYSCALL(kill)
     ed8:	b8 06 00 00 00       	mov    $0x6,%eax
     edd:	cd 40                	int    $0x40
     edf:	c3                   	ret    

00000ee0 <exec>:
SYSCALL(exec)
     ee0:	b8 07 00 00 00       	mov    $0x7,%eax
     ee5:	cd 40                	int    $0x40
     ee7:	c3                   	ret    

00000ee8 <open>:
SYSCALL(open)
     ee8:	b8 0f 00 00 00       	mov    $0xf,%eax
     eed:	cd 40                	int    $0x40
     eef:	c3                   	ret    

00000ef0 <mknod>:
SYSCALL(mknod)
     ef0:	b8 11 00 00 00       	mov    $0x11,%eax
     ef5:	cd 40                	int    $0x40
     ef7:	c3                   	ret    

00000ef8 <unlink>:
SYSCALL(unlink)
     ef8:	b8 12 00 00 00       	mov    $0x12,%eax
     efd:	cd 40                	int    $0x40
     eff:	c3                   	ret    

00000f00 <fstat>:
SYSCALL(fstat)
     f00:	b8 08 00 00 00       	mov    $0x8,%eax
     f05:	cd 40                	int    $0x40
     f07:	c3                   	ret    

00000f08 <link>:
SYSCALL(link)
     f08:	b8 13 00 00 00       	mov    $0x13,%eax
     f0d:	cd 40                	int    $0x40
     f0f:	c3                   	ret    

00000f10 <mkdir>:
SYSCALL(mkdir)
     f10:	b8 14 00 00 00       	mov    $0x14,%eax
     f15:	cd 40                	int    $0x40
     f17:	c3                   	ret    

00000f18 <chdir>:
SYSCALL(chdir)
     f18:	b8 09 00 00 00       	mov    $0x9,%eax
     f1d:	cd 40                	int    $0x40
     f1f:	c3                   	ret    

00000f20 <dup>:
SYSCALL(dup)
     f20:	b8 0a 00 00 00       	mov    $0xa,%eax
     f25:	cd 40                	int    $0x40
     f27:	c3                   	ret    

00000f28 <getpid>:
SYSCALL(getpid)
     f28:	b8 0b 00 00 00       	mov    $0xb,%eax
     f2d:	cd 40                	int    $0x40
     f2f:	c3                   	ret    

00000f30 <sbrk>:
SYSCALL(sbrk)
     f30:	b8 0c 00 00 00       	mov    $0xc,%eax
     f35:	cd 40                	int    $0x40
     f37:	c3                   	ret    

00000f38 <sleep>:
SYSCALL(sleep)
     f38:	b8 0d 00 00 00       	mov    $0xd,%eax
     f3d:	cd 40                	int    $0x40
     f3f:	c3                   	ret    

00000f40 <uptime>:
SYSCALL(uptime)
     f40:	b8 0e 00 00 00       	mov    $0xe,%eax
     f45:	cd 40                	int    $0x40
     f47:	c3                   	ret    

00000f48 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f48:	55                   	push   %ebp
     f49:	89 e5                	mov    %esp,%ebp
     f4b:	83 ec 18             	sub    $0x18,%esp
     f4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f51:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     f54:	83 ec 04             	sub    $0x4,%esp
     f57:	6a 01                	push   $0x1
     f59:	8d 45 f4             	lea    -0xc(%ebp),%eax
     f5c:	50                   	push   %eax
     f5d:	ff 75 08             	pushl  0x8(%ebp)
     f60:	e8 63 ff ff ff       	call   ec8 <write>
     f65:	83 c4 10             	add    $0x10,%esp
}
     f68:	90                   	nop
     f69:	c9                   	leave  
     f6a:	c3                   	ret    

00000f6b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f6b:	55                   	push   %ebp
     f6c:	89 e5                	mov    %esp,%ebp
     f6e:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     f71:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     f78:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     f7c:	74 17                	je     f95 <printint+0x2a>
     f7e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f82:	79 11                	jns    f95 <printint+0x2a>
    neg = 1;
     f84:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f8e:	f7 d8                	neg    %eax
     f90:	89 45 ec             	mov    %eax,-0x14(%ebp)
     f93:	eb 06                	jmp    f9b <printint+0x30>
  } else {
    x = xx;
     f95:	8b 45 0c             	mov    0xc(%ebp),%eax
     f98:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     f9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     fa2:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fa5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fa8:	ba 00 00 00 00       	mov    $0x0,%edx
     fad:	f7 f1                	div    %ecx
     faf:	89 d1                	mov    %edx,%ecx
     fb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb4:	8d 50 01             	lea    0x1(%eax),%edx
     fb7:	89 55 f4             	mov    %edx,-0xc(%ebp)
     fba:	8a 91 d0 14 00 00    	mov    0x14d0(%ecx),%dl
     fc0:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     fc4:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fc7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fca:	ba 00 00 00 00       	mov    $0x0,%edx
     fcf:	f7 f1                	div    %ecx
     fd1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     fd4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fd8:	75 c8                	jne    fa2 <printint+0x37>
  if(neg)
     fda:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fde:	74 2c                	je     100c <printint+0xa1>
    buf[i++] = '-';
     fe0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fe3:	8d 50 01             	lea    0x1(%eax),%edx
     fe6:	89 55 f4             	mov    %edx,-0xc(%ebp)
     fe9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     fee:	eb 1c                	jmp    100c <printint+0xa1>
    putc(fd, buf[i]);
     ff0:	8d 55 dc             	lea    -0x24(%ebp),%edx
     ff3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ff6:	01 d0                	add    %edx,%eax
     ff8:	8a 00                	mov    (%eax),%al
     ffa:	0f be c0             	movsbl %al,%eax
     ffd:	83 ec 08             	sub    $0x8,%esp
    1000:	50                   	push   %eax
    1001:	ff 75 08             	pushl  0x8(%ebp)
    1004:	e8 3f ff ff ff       	call   f48 <putc>
    1009:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    100c:	ff 4d f4             	decl   -0xc(%ebp)
    100f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1013:	79 db                	jns    ff0 <printint+0x85>
}
    1015:	90                   	nop
    1016:	90                   	nop
    1017:	c9                   	leave  
    1018:	c3                   	ret    

00001019 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1019:	55                   	push   %ebp
    101a:	89 e5                	mov    %esp,%ebp
    101c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    101f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1026:	8d 45 0c             	lea    0xc(%ebp),%eax
    1029:	83 c0 04             	add    $0x4,%eax
    102c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    102f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1036:	e9 54 01 00 00       	jmp    118f <printf+0x176>
    c = fmt[i] & 0xff;
    103b:	8b 55 0c             	mov    0xc(%ebp),%edx
    103e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1041:	01 d0                	add    %edx,%eax
    1043:	8a 00                	mov    (%eax),%al
    1045:	0f be c0             	movsbl %al,%eax
    1048:	25 ff 00 00 00       	and    $0xff,%eax
    104d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1050:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1054:	75 2c                	jne    1082 <printf+0x69>
      if(c == '%'){
    1056:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    105a:	75 0c                	jne    1068 <printf+0x4f>
        state = '%';
    105c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1063:	e9 24 01 00 00       	jmp    118c <printf+0x173>
      } else {
        putc(fd, c);
    1068:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    106b:	0f be c0             	movsbl %al,%eax
    106e:	83 ec 08             	sub    $0x8,%esp
    1071:	50                   	push   %eax
    1072:	ff 75 08             	pushl  0x8(%ebp)
    1075:	e8 ce fe ff ff       	call   f48 <putc>
    107a:	83 c4 10             	add    $0x10,%esp
    107d:	e9 0a 01 00 00       	jmp    118c <printf+0x173>
      }
    } else if(state == '%'){
    1082:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1086:	0f 85 00 01 00 00    	jne    118c <printf+0x173>
      if(c == 'd'){
    108c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1090:	75 1e                	jne    10b0 <printf+0x97>
        printint(fd, *ap, 10, 1);
    1092:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1095:	8b 00                	mov    (%eax),%eax
    1097:	6a 01                	push   $0x1
    1099:	6a 0a                	push   $0xa
    109b:	50                   	push   %eax
    109c:	ff 75 08             	pushl  0x8(%ebp)
    109f:	e8 c7 fe ff ff       	call   f6b <printint>
    10a4:	83 c4 10             	add    $0x10,%esp
        ap++;
    10a7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    10ab:	e9 d5 00 00 00       	jmp    1185 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
    10b0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    10b4:	74 06                	je     10bc <printf+0xa3>
    10b6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    10ba:	75 1e                	jne    10da <printf+0xc1>
        printint(fd, *ap, 16, 0);
    10bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10bf:	8b 00                	mov    (%eax),%eax
    10c1:	6a 00                	push   $0x0
    10c3:	6a 10                	push   $0x10
    10c5:	50                   	push   %eax
    10c6:	ff 75 08             	pushl  0x8(%ebp)
    10c9:	e8 9d fe ff ff       	call   f6b <printint>
    10ce:	83 c4 10             	add    $0x10,%esp
        ap++;
    10d1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    10d5:	e9 ab 00 00 00       	jmp    1185 <printf+0x16c>
      } else if(c == 's'){
    10da:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    10de:	75 40                	jne    1120 <printf+0x107>
        s = (char*)*ap;
    10e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10e3:	8b 00                	mov    (%eax),%eax
    10e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    10e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    10ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10f0:	75 23                	jne    1115 <printf+0xfc>
          s = "(null)";
    10f2:	c7 45 f4 b8 14 00 00 	movl   $0x14b8,-0xc(%ebp)
        while(*s != 0){
    10f9:	eb 1a                	jmp    1115 <printf+0xfc>
          putc(fd, *s);
    10fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10fe:	8a 00                	mov    (%eax),%al
    1100:	0f be c0             	movsbl %al,%eax
    1103:	83 ec 08             	sub    $0x8,%esp
    1106:	50                   	push   %eax
    1107:	ff 75 08             	pushl  0x8(%ebp)
    110a:	e8 39 fe ff ff       	call   f48 <putc>
    110f:	83 c4 10             	add    $0x10,%esp
          s++;
    1112:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
    1115:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1118:	8a 00                	mov    (%eax),%al
    111a:	84 c0                	test   %al,%al
    111c:	75 dd                	jne    10fb <printf+0xe2>
    111e:	eb 65                	jmp    1185 <printf+0x16c>
        }
      } else if(c == 'c'){
    1120:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1124:	75 1d                	jne    1143 <printf+0x12a>
        putc(fd, *ap);
    1126:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1129:	8b 00                	mov    (%eax),%eax
    112b:	0f be c0             	movsbl %al,%eax
    112e:	83 ec 08             	sub    $0x8,%esp
    1131:	50                   	push   %eax
    1132:	ff 75 08             	pushl  0x8(%ebp)
    1135:	e8 0e fe ff ff       	call   f48 <putc>
    113a:	83 c4 10             	add    $0x10,%esp
        ap++;
    113d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1141:	eb 42                	jmp    1185 <printf+0x16c>
      } else if(c == '%'){
    1143:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1147:	75 17                	jne    1160 <printf+0x147>
        putc(fd, c);
    1149:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    114c:	0f be c0             	movsbl %al,%eax
    114f:	83 ec 08             	sub    $0x8,%esp
    1152:	50                   	push   %eax
    1153:	ff 75 08             	pushl  0x8(%ebp)
    1156:	e8 ed fd ff ff       	call   f48 <putc>
    115b:	83 c4 10             	add    $0x10,%esp
    115e:	eb 25                	jmp    1185 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1160:	83 ec 08             	sub    $0x8,%esp
    1163:	6a 25                	push   $0x25
    1165:	ff 75 08             	pushl  0x8(%ebp)
    1168:	e8 db fd ff ff       	call   f48 <putc>
    116d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1170:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1173:	0f be c0             	movsbl %al,%eax
    1176:	83 ec 08             	sub    $0x8,%esp
    1179:	50                   	push   %eax
    117a:	ff 75 08             	pushl  0x8(%ebp)
    117d:	e8 c6 fd ff ff       	call   f48 <putc>
    1182:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1185:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    118c:	ff 45 f0             	incl   -0x10(%ebp)
    118f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1192:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1195:	01 d0                	add    %edx,%eax
    1197:	8a 00                	mov    (%eax),%al
    1199:	84 c0                	test   %al,%al
    119b:	0f 85 9a fe ff ff    	jne    103b <printf+0x22>
    }
  }
}
    11a1:	90                   	nop
    11a2:	90                   	nop
    11a3:	c9                   	leave  
    11a4:	c3                   	ret    

000011a5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11a5:	55                   	push   %ebp
    11a6:	89 e5                	mov    %esp,%ebp
    11a8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11ab:	8b 45 08             	mov    0x8(%ebp),%eax
    11ae:	83 e8 08             	sub    $0x8,%eax
    11b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11b4:	a1 6c 15 00 00       	mov    0x156c,%eax
    11b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11bc:	eb 24                	jmp    11e2 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11be:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11c1:	8b 00                	mov    (%eax),%eax
    11c3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    11c6:	72 12                	jb     11da <free+0x35>
    11c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11cb:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    11ce:	72 24                	jb     11f4 <free+0x4f>
    11d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11d3:	8b 00                	mov    (%eax),%eax
    11d5:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    11d8:	72 1a                	jb     11f4 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11da:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11dd:	8b 00                	mov    (%eax),%eax
    11df:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11e5:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    11e8:	73 d4                	jae    11be <free+0x19>
    11ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11ed:	8b 00                	mov    (%eax),%eax
    11ef:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    11f2:	73 ca                	jae    11be <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    11f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11f7:	8b 40 04             	mov    0x4(%eax),%eax
    11fa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1201:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1204:	01 c2                	add    %eax,%edx
    1206:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1209:	8b 00                	mov    (%eax),%eax
    120b:	39 c2                	cmp    %eax,%edx
    120d:	75 24                	jne    1233 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    120f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1212:	8b 50 04             	mov    0x4(%eax),%edx
    1215:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1218:	8b 00                	mov    (%eax),%eax
    121a:	8b 40 04             	mov    0x4(%eax),%eax
    121d:	01 c2                	add    %eax,%edx
    121f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1222:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1225:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1228:	8b 00                	mov    (%eax),%eax
    122a:	8b 10                	mov    (%eax),%edx
    122c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    122f:	89 10                	mov    %edx,(%eax)
    1231:	eb 0a                	jmp    123d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1233:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1236:	8b 10                	mov    (%eax),%edx
    1238:	8b 45 f8             	mov    -0x8(%ebp),%eax
    123b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    123d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1240:	8b 40 04             	mov    0x4(%eax),%eax
    1243:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    124a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    124d:	01 d0                	add    %edx,%eax
    124f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1252:	75 20                	jne    1274 <free+0xcf>
    p->s.size += bp->s.size;
    1254:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1257:	8b 50 04             	mov    0x4(%eax),%edx
    125a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    125d:	8b 40 04             	mov    0x4(%eax),%eax
    1260:	01 c2                	add    %eax,%edx
    1262:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1265:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1268:	8b 45 f8             	mov    -0x8(%ebp),%eax
    126b:	8b 10                	mov    (%eax),%edx
    126d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1270:	89 10                	mov    %edx,(%eax)
    1272:	eb 08                	jmp    127c <free+0xd7>
  } else
    p->s.ptr = bp;
    1274:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1277:	8b 55 f8             	mov    -0x8(%ebp),%edx
    127a:	89 10                	mov    %edx,(%eax)
  freep = p;
    127c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    127f:	a3 6c 15 00 00       	mov    %eax,0x156c
}
    1284:	90                   	nop
    1285:	c9                   	leave  
    1286:	c3                   	ret    

00001287 <morecore>:

static Header*
morecore(uint nu)
{
    1287:	55                   	push   %ebp
    1288:	89 e5                	mov    %esp,%ebp
    128a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    128d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1294:	77 07                	ja     129d <morecore+0x16>
    nu = 4096;
    1296:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    129d:	8b 45 08             	mov    0x8(%ebp),%eax
    12a0:	c1 e0 03             	shl    $0x3,%eax
    12a3:	83 ec 0c             	sub    $0xc,%esp
    12a6:	50                   	push   %eax
    12a7:	e8 84 fc ff ff       	call   f30 <sbrk>
    12ac:	83 c4 10             	add    $0x10,%esp
    12af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    12b2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    12b6:	75 07                	jne    12bf <morecore+0x38>
    return 0;
    12b8:	b8 00 00 00 00       	mov    $0x0,%eax
    12bd:	eb 26                	jmp    12e5 <morecore+0x5e>
  hp = (Header*)p;
    12bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    12c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12c8:	8b 55 08             	mov    0x8(%ebp),%edx
    12cb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    12ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12d1:	83 c0 08             	add    $0x8,%eax
    12d4:	83 ec 0c             	sub    $0xc,%esp
    12d7:	50                   	push   %eax
    12d8:	e8 c8 fe ff ff       	call   11a5 <free>
    12dd:	83 c4 10             	add    $0x10,%esp
  return freep;
    12e0:	a1 6c 15 00 00       	mov    0x156c,%eax
}
    12e5:	c9                   	leave  
    12e6:	c3                   	ret    

000012e7 <malloc>:

void*
malloc(uint nbytes)
{
    12e7:	55                   	push   %ebp
    12e8:	89 e5                	mov    %esp,%ebp
    12ea:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12ed:	8b 45 08             	mov    0x8(%ebp),%eax
    12f0:	83 c0 07             	add    $0x7,%eax
    12f3:	c1 e8 03             	shr    $0x3,%eax
    12f6:	40                   	inc    %eax
    12f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    12fa:	a1 6c 15 00 00       	mov    0x156c,%eax
    12ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1302:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1306:	75 23                	jne    132b <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
    1308:	c7 45 f0 64 15 00 00 	movl   $0x1564,-0x10(%ebp)
    130f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1312:	a3 6c 15 00 00       	mov    %eax,0x156c
    1317:	a1 6c 15 00 00       	mov    0x156c,%eax
    131c:	a3 64 15 00 00       	mov    %eax,0x1564
    base.s.size = 0;
    1321:	c7 05 68 15 00 00 00 	movl   $0x0,0x1568
    1328:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    132b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    132e:	8b 00                	mov    (%eax),%eax
    1330:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1333:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1336:	8b 40 04             	mov    0x4(%eax),%eax
    1339:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    133c:	72 4d                	jb     138b <malloc+0xa4>
      if(p->s.size == nunits)
    133e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1341:	8b 40 04             	mov    0x4(%eax),%eax
    1344:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1347:	75 0c                	jne    1355 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
    1349:	8b 45 f4             	mov    -0xc(%ebp),%eax
    134c:	8b 10                	mov    (%eax),%edx
    134e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1351:	89 10                	mov    %edx,(%eax)
    1353:	eb 26                	jmp    137b <malloc+0x94>
      else {
        p->s.size -= nunits;
    1355:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1358:	8b 40 04             	mov    0x4(%eax),%eax
    135b:	2b 45 ec             	sub    -0x14(%ebp),%eax
    135e:	89 c2                	mov    %eax,%edx
    1360:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1363:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1366:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1369:	8b 40 04             	mov    0x4(%eax),%eax
    136c:	c1 e0 03             	shl    $0x3,%eax
    136f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1372:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1375:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1378:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    137b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    137e:	a3 6c 15 00 00       	mov    %eax,0x156c
      return (void*)(p + 1);
    1383:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1386:	83 c0 08             	add    $0x8,%eax
    1389:	eb 3b                	jmp    13c6 <malloc+0xdf>
    }
    if(p == freep)
    138b:	a1 6c 15 00 00       	mov    0x156c,%eax
    1390:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1393:	75 1e                	jne    13b3 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
    1395:	83 ec 0c             	sub    $0xc,%esp
    1398:	ff 75 ec             	pushl  -0x14(%ebp)
    139b:	e8 e7 fe ff ff       	call   1287 <morecore>
    13a0:	83 c4 10             	add    $0x10,%esp
    13a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13aa:	75 07                	jne    13b3 <malloc+0xcc>
        return 0;
    13ac:	b8 00 00 00 00       	mov    $0x0,%eax
    13b1:	eb 13                	jmp    13c6 <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    13b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13bc:	8b 00                	mov    (%eax),%eax
    13be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    13c1:	e9 6d ff ff ff       	jmp    1333 <malloc+0x4c>
  }
}
    13c6:	c9                   	leave  
    13c7:	c3                   	ret    
