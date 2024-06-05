
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 64 08 00 00       	push   $0x864
  1b:	e8 61 03 00 00       	call   381 <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 64 08 00 00       	push   $0x864
  33:	e8 51 03 00 00       	call   389 <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 64 08 00 00       	push   $0x864
  45:	e8 37 03 00 00       	call   381 <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 62 03 00 00       	call   3b9 <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 55 03 00 00       	call   3b9 <dup>
  64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 6c 08 00 00       	push   $0x86c
  6f:	6a 01                	push   $0x1
  71:	e8 3c 04 00 00       	call   4b2 <printf>
  76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  79:	e8 bb 02 00 00       	call   339 <fork>
  7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
  87:	83 ec 08             	sub    $0x8,%esp
  8a:	68 7f 08 00 00       	push   $0x87f
  8f:	6a 01                	push   $0x1
  91:	e8 1c 04 00 00       	call   4b2 <printf>
  96:	83 c4 10             	add    $0x10,%esp
      exit();
  99:	e8 a3 02 00 00       	call   341 <exit>
    }
    if(pid == 0){
  9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a2:	75 3e                	jne    e2 <main+0xe2>
      exec("sh", argv);
  a4:	83 ec 08             	sub    $0x8,%esp
  a7:	68 b8 08 00 00       	push   $0x8b8
  ac:	68 61 08 00 00       	push   $0x861
  b1:	e8 c3 02 00 00       	call   379 <exec>
  b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	68 92 08 00 00       	push   $0x892
  c1:	6a 01                	push   $0x1
  c3:	e8 ea 03 00 00       	call   4b2 <printf>
  c8:	83 c4 10             	add    $0x10,%esp
      exit();
  cb:	e8 71 02 00 00       	call   341 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  d0:	83 ec 08             	sub    $0x8,%esp
  d3:	68 a8 08 00 00       	push   $0x8a8
  d8:	6a 01                	push   $0x1
  da:	e8 d3 03 00 00       	call   4b2 <printf>
  df:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
  e2:	e8 62 02 00 00       	call   349 <wait>
  e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  ee:	0f 88 73 ff ff ff    	js     67 <main+0x67>
  f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  fa:	75 d4                	jne    d0 <main+0xd0>
    printf(1, "init: starting sh\n");
  fc:	e9 66 ff ff ff       	jmp    67 <main+0x67>

00000101 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	57                   	push   %edi
 105:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 55 10             	mov    0x10(%ebp),%edx
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
 10f:	89 cb                	mov    %ecx,%ebx
 111:	89 df                	mov    %ebx,%edi
 113:	89 d1                	mov    %edx,%ecx
 115:	fc                   	cld    
 116:	f3 aa                	rep stos %al,%es:(%edi)
 118:	89 ca                	mov    %ecx,%edx
 11a:	89 fb                	mov    %edi,%ebx
 11c:	89 5d 08             	mov    %ebx,0x8(%ebp)
 11f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 122:	90                   	nop
 123:	5b                   	pop    %ebx
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    

00000127 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 12d:	8b 45 08             	mov    0x8(%ebp),%eax
 130:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 133:	90                   	nop
 134:	8b 55 0c             	mov    0xc(%ebp),%edx
 137:	8d 42 01             	lea    0x1(%edx),%eax
 13a:	89 45 0c             	mov    %eax,0xc(%ebp)
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
 140:	8d 48 01             	lea    0x1(%eax),%ecx
 143:	89 4d 08             	mov    %ecx,0x8(%ebp)
 146:	8a 12                	mov    (%edx),%dl
 148:	88 10                	mov    %dl,(%eax)
 14a:	8a 00                	mov    (%eax),%al
 14c:	84 c0                	test   %al,%al
 14e:	75 e4                	jne    134 <strcpy+0xd>
    ;
  return os;
 150:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 153:	c9                   	leave  
 154:	c3                   	ret    

00000155 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 155:	55                   	push   %ebp
 156:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 158:	eb 06                	jmp    160 <strcmp+0xb>
    p++, q++;
 15a:	ff 45 08             	incl   0x8(%ebp)
 15d:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	8a 00                	mov    (%eax),%al
 165:	84 c0                	test   %al,%al
 167:	74 0e                	je     177 <strcmp+0x22>
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	8a 10                	mov    (%eax),%dl
 16e:	8b 45 0c             	mov    0xc(%ebp),%eax
 171:	8a 00                	mov    (%eax),%al
 173:	38 c2                	cmp    %al,%dl
 175:	74 e3                	je     15a <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 177:	8b 45 08             	mov    0x8(%ebp),%eax
 17a:	8a 00                	mov    (%eax),%al
 17c:	0f b6 d0             	movzbl %al,%edx
 17f:	8b 45 0c             	mov    0xc(%ebp),%eax
 182:	8a 00                	mov    (%eax),%al
 184:	0f b6 c0             	movzbl %al,%eax
 187:	29 c2                	sub    %eax,%edx
 189:	89 d0                	mov    %edx,%eax
}
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    

0000018d <strlen>:

uint
strlen(char *s)
{
 18d:	55                   	push   %ebp
 18e:	89 e5                	mov    %esp,%ebp
 190:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 193:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 19a:	eb 03                	jmp    19f <strlen+0x12>
 19c:	ff 45 fc             	incl   -0x4(%ebp)
 19f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1a2:	8b 45 08             	mov    0x8(%ebp),%eax
 1a5:	01 d0                	add    %edx,%eax
 1a7:	8a 00                	mov    (%eax),%al
 1a9:	84 c0                	test   %al,%al
 1ab:	75 ef                	jne    19c <strlen+0xf>
    ;
  return n;
 1ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1b0:	c9                   	leave  
 1b1:	c3                   	ret    

000001b2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b2:	55                   	push   %ebp
 1b3:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1b5:	8b 45 10             	mov    0x10(%ebp),%eax
 1b8:	50                   	push   %eax
 1b9:	ff 75 0c             	pushl  0xc(%ebp)
 1bc:	ff 75 08             	pushl  0x8(%ebp)
 1bf:	e8 3d ff ff ff       	call   101 <stosb>
 1c4:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ca:	c9                   	leave  
 1cb:	c3                   	ret    

000001cc <strchr>:

char*
strchr(const char *s, char c)
{
 1cc:	55                   	push   %ebp
 1cd:	89 e5                	mov    %esp,%ebp
 1cf:	83 ec 04             	sub    $0x4,%esp
 1d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d5:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1d8:	eb 12                	jmp    1ec <strchr+0x20>
    if(*s == c)
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	8a 00                	mov    (%eax),%al
 1df:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1e2:	75 05                	jne    1e9 <strchr+0x1d>
      return (char*)s;
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	eb 11                	jmp    1fa <strchr+0x2e>
  for(; *s; s++)
 1e9:	ff 45 08             	incl   0x8(%ebp)
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	8a 00                	mov    (%eax),%al
 1f1:	84 c0                	test   %al,%al
 1f3:	75 e5                	jne    1da <strchr+0xe>
  return 0;
 1f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1fa:	c9                   	leave  
 1fb:	c3                   	ret    

000001fc <gets>:

char*
gets(char *buf, int max)
{
 1fc:	55                   	push   %ebp
 1fd:	89 e5                	mov    %esp,%ebp
 1ff:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 202:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 209:	eb 3f                	jmp    24a <gets+0x4e>
    cc = read(0, &c, 1);
 20b:	83 ec 04             	sub    $0x4,%esp
 20e:	6a 01                	push   $0x1
 210:	8d 45 ef             	lea    -0x11(%ebp),%eax
 213:	50                   	push   %eax
 214:	6a 00                	push   $0x0
 216:	e8 3e 01 00 00       	call   359 <read>
 21b:	83 c4 10             	add    $0x10,%esp
 21e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 221:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 225:	7e 2e                	jle    255 <gets+0x59>
      break;
    buf[i++] = c;
 227:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22a:	8d 50 01             	lea    0x1(%eax),%edx
 22d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 230:	89 c2                	mov    %eax,%edx
 232:	8b 45 08             	mov    0x8(%ebp),%eax
 235:	01 c2                	add    %eax,%edx
 237:	8a 45 ef             	mov    -0x11(%ebp),%al
 23a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 23c:	8a 45 ef             	mov    -0x11(%ebp),%al
 23f:	3c 0a                	cmp    $0xa,%al
 241:	74 13                	je     256 <gets+0x5a>
 243:	8a 45 ef             	mov    -0x11(%ebp),%al
 246:	3c 0d                	cmp    $0xd,%al
 248:	74 0c                	je     256 <gets+0x5a>
  for(i=0; i+1 < max; ){
 24a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24d:	40                   	inc    %eax
 24e:	39 45 0c             	cmp    %eax,0xc(%ebp)
 251:	7f b8                	jg     20b <gets+0xf>
 253:	eb 01                	jmp    256 <gets+0x5a>
      break;
 255:	90                   	nop
      break;
  }
  buf[i] = '\0';
 256:	8b 55 f4             	mov    -0xc(%ebp),%edx
 259:	8b 45 08             	mov    0x8(%ebp),%eax
 25c:	01 d0                	add    %edx,%eax
 25e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 261:	8b 45 08             	mov    0x8(%ebp),%eax
}
 264:	c9                   	leave  
 265:	c3                   	ret    

00000266 <stat>:

int
stat(char *n, struct stat *st)
{
 266:	55                   	push   %ebp
 267:	89 e5                	mov    %esp,%ebp
 269:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 26c:	83 ec 08             	sub    $0x8,%esp
 26f:	6a 00                	push   $0x0
 271:	ff 75 08             	pushl  0x8(%ebp)
 274:	e8 08 01 00 00       	call   381 <open>
 279:	83 c4 10             	add    $0x10,%esp
 27c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 27f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 283:	79 07                	jns    28c <stat+0x26>
    return -1;
 285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 28a:	eb 25                	jmp    2b1 <stat+0x4b>
  r = fstat(fd, st);
 28c:	83 ec 08             	sub    $0x8,%esp
 28f:	ff 75 0c             	pushl  0xc(%ebp)
 292:	ff 75 f4             	pushl  -0xc(%ebp)
 295:	e8 ff 00 00 00       	call   399 <fstat>
 29a:	83 c4 10             	add    $0x10,%esp
 29d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2a0:	83 ec 0c             	sub    $0xc,%esp
 2a3:	ff 75 f4             	pushl  -0xc(%ebp)
 2a6:	e8 be 00 00 00       	call   369 <close>
 2ab:	83 c4 10             	add    $0x10,%esp
  return r;
 2ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2b1:	c9                   	leave  
 2b2:	c3                   	ret    

000002b3 <atoi>:

int
atoi(const char *s)
{
 2b3:	55                   	push   %ebp
 2b4:	89 e5                	mov    %esp,%ebp
 2b6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2c0:	eb 24                	jmp    2e6 <atoi+0x33>
    n = n*10 + *s++ - '0';
 2c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c5:	89 d0                	mov    %edx,%eax
 2c7:	c1 e0 02             	shl    $0x2,%eax
 2ca:	01 d0                	add    %edx,%eax
 2cc:	01 c0                	add    %eax,%eax
 2ce:	89 c1                	mov    %eax,%ecx
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	8d 50 01             	lea    0x1(%eax),%edx
 2d6:	89 55 08             	mov    %edx,0x8(%ebp)
 2d9:	8a 00                	mov    (%eax),%al
 2db:	0f be c0             	movsbl %al,%eax
 2de:	01 c8                	add    %ecx,%eax
 2e0:	83 e8 30             	sub    $0x30,%eax
 2e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e6:	8b 45 08             	mov    0x8(%ebp),%eax
 2e9:	8a 00                	mov    (%eax),%al
 2eb:	3c 2f                	cmp    $0x2f,%al
 2ed:	7e 09                	jle    2f8 <atoi+0x45>
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	8a 00                	mov    (%eax),%al
 2f4:	3c 39                	cmp    $0x39,%al
 2f6:	7e ca                	jle    2c2 <atoi+0xf>
  return n;
 2f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2fb:	c9                   	leave  
 2fc:	c3                   	ret    

000002fd <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2fd:	55                   	push   %ebp
 2fe:	89 e5                	mov    %esp,%ebp
 300:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 309:	8b 45 0c             	mov    0xc(%ebp),%eax
 30c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 30f:	eb 16                	jmp    327 <memmove+0x2a>
    *dst++ = *src++;
 311:	8b 55 f8             	mov    -0x8(%ebp),%edx
 314:	8d 42 01             	lea    0x1(%edx),%eax
 317:	89 45 f8             	mov    %eax,-0x8(%ebp)
 31a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 31d:	8d 48 01             	lea    0x1(%eax),%ecx
 320:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 323:	8a 12                	mov    (%edx),%dl
 325:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 327:	8b 45 10             	mov    0x10(%ebp),%eax
 32a:	8d 50 ff             	lea    -0x1(%eax),%edx
 32d:	89 55 10             	mov    %edx,0x10(%ebp)
 330:	85 c0                	test   %eax,%eax
 332:	7f dd                	jg     311 <memmove+0x14>
  return vdst;
 334:	8b 45 08             	mov    0x8(%ebp),%eax
}
 337:	c9                   	leave  
 338:	c3                   	ret    

00000339 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 339:	b8 01 00 00 00       	mov    $0x1,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <exit>:
SYSCALL(exit)
 341:	b8 02 00 00 00       	mov    $0x2,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <wait>:
SYSCALL(wait)
 349:	b8 03 00 00 00       	mov    $0x3,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <pipe>:
SYSCALL(pipe)
 351:	b8 04 00 00 00       	mov    $0x4,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <read>:
SYSCALL(read)
 359:	b8 05 00 00 00       	mov    $0x5,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <write>:
SYSCALL(write)
 361:	b8 10 00 00 00       	mov    $0x10,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <close>:
SYSCALL(close)
 369:	b8 15 00 00 00       	mov    $0x15,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <kill>:
SYSCALL(kill)
 371:	b8 06 00 00 00       	mov    $0x6,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <exec>:
SYSCALL(exec)
 379:	b8 07 00 00 00       	mov    $0x7,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <open>:
SYSCALL(open)
 381:	b8 0f 00 00 00       	mov    $0xf,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <mknod>:
SYSCALL(mknod)
 389:	b8 11 00 00 00       	mov    $0x11,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <unlink>:
SYSCALL(unlink)
 391:	b8 12 00 00 00       	mov    $0x12,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <fstat>:
SYSCALL(fstat)
 399:	b8 08 00 00 00       	mov    $0x8,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <link>:
SYSCALL(link)
 3a1:	b8 13 00 00 00       	mov    $0x13,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <mkdir>:
SYSCALL(mkdir)
 3a9:	b8 14 00 00 00       	mov    $0x14,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <chdir>:
SYSCALL(chdir)
 3b1:	b8 09 00 00 00       	mov    $0x9,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <dup>:
SYSCALL(dup)
 3b9:	b8 0a 00 00 00       	mov    $0xa,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <getpid>:
SYSCALL(getpid)
 3c1:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <sbrk>:
SYSCALL(sbrk)
 3c9:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <sleep>:
SYSCALL(sleep)
 3d1:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <uptime>:
SYSCALL(uptime)
 3d9:	b8 0e 00 00 00       	mov    $0xe,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e1:	55                   	push   %ebp
 3e2:	89 e5                	mov    %esp,%ebp
 3e4:	83 ec 18             	sub    $0x18,%esp
 3e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ea:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3ed:	83 ec 04             	sub    $0x4,%esp
 3f0:	6a 01                	push   $0x1
 3f2:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3f5:	50                   	push   %eax
 3f6:	ff 75 08             	pushl  0x8(%ebp)
 3f9:	e8 63 ff ff ff       	call   361 <write>
 3fe:	83 c4 10             	add    $0x10,%esp
}
 401:	90                   	nop
 402:	c9                   	leave  
 403:	c3                   	ret    

00000404 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
 407:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 40a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 411:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 415:	74 17                	je     42e <printint+0x2a>
 417:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 41b:	79 11                	jns    42e <printint+0x2a>
    neg = 1;
 41d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 424:	8b 45 0c             	mov    0xc(%ebp),%eax
 427:	f7 d8                	neg    %eax
 429:	89 45 ec             	mov    %eax,-0x14(%ebp)
 42c:	eb 06                	jmp    434 <printint+0x30>
  } else {
    x = xx;
 42e:	8b 45 0c             	mov    0xc(%ebp),%eax
 431:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 434:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 43b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 43e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 441:	ba 00 00 00 00       	mov    $0x0,%edx
 446:	f7 f1                	div    %ecx
 448:	89 d1                	mov    %edx,%ecx
 44a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 44d:	8d 50 01             	lea    0x1(%eax),%edx
 450:	89 55 f4             	mov    %edx,-0xc(%ebp)
 453:	8a 91 c0 08 00 00    	mov    0x8c0(%ecx),%dl
 459:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 45d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 460:	8b 45 ec             	mov    -0x14(%ebp),%eax
 463:	ba 00 00 00 00       	mov    $0x0,%edx
 468:	f7 f1                	div    %ecx
 46a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 46d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 471:	75 c8                	jne    43b <printint+0x37>
  if(neg)
 473:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 477:	74 2c                	je     4a5 <printint+0xa1>
    buf[i++] = '-';
 479:	8b 45 f4             	mov    -0xc(%ebp),%eax
 47c:	8d 50 01             	lea    0x1(%eax),%edx
 47f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 482:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 487:	eb 1c                	jmp    4a5 <printint+0xa1>
    putc(fd, buf[i]);
 489:	8d 55 dc             	lea    -0x24(%ebp),%edx
 48c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48f:	01 d0                	add    %edx,%eax
 491:	8a 00                	mov    (%eax),%al
 493:	0f be c0             	movsbl %al,%eax
 496:	83 ec 08             	sub    $0x8,%esp
 499:	50                   	push   %eax
 49a:	ff 75 08             	pushl  0x8(%ebp)
 49d:	e8 3f ff ff ff       	call   3e1 <putc>
 4a2:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4a5:	ff 4d f4             	decl   -0xc(%ebp)
 4a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ac:	79 db                	jns    489 <printint+0x85>
}
 4ae:	90                   	nop
 4af:	90                   	nop
 4b0:	c9                   	leave  
 4b1:	c3                   	ret    

000004b2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b2:	55                   	push   %ebp
 4b3:	89 e5                	mov    %esp,%ebp
 4b5:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4bf:	8d 45 0c             	lea    0xc(%ebp),%eax
 4c2:	83 c0 04             	add    $0x4,%eax
 4c5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4cf:	e9 54 01 00 00       	jmp    628 <printf+0x176>
    c = fmt[i] & 0xff;
 4d4:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4da:	01 d0                	add    %edx,%eax
 4dc:	8a 00                	mov    (%eax),%al
 4de:	0f be c0             	movsbl %al,%eax
 4e1:	25 ff 00 00 00       	and    $0xff,%eax
 4e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ed:	75 2c                	jne    51b <printf+0x69>
      if(c == '%'){
 4ef:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f3:	75 0c                	jne    501 <printf+0x4f>
        state = '%';
 4f5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4fc:	e9 24 01 00 00       	jmp    625 <printf+0x173>
      } else {
        putc(fd, c);
 501:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 504:	0f be c0             	movsbl %al,%eax
 507:	83 ec 08             	sub    $0x8,%esp
 50a:	50                   	push   %eax
 50b:	ff 75 08             	pushl  0x8(%ebp)
 50e:	e8 ce fe ff ff       	call   3e1 <putc>
 513:	83 c4 10             	add    $0x10,%esp
 516:	e9 0a 01 00 00       	jmp    625 <printf+0x173>
      }
    } else if(state == '%'){
 51b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 51f:	0f 85 00 01 00 00    	jne    625 <printf+0x173>
      if(c == 'd'){
 525:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 529:	75 1e                	jne    549 <printf+0x97>
        printint(fd, *ap, 10, 1);
 52b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52e:	8b 00                	mov    (%eax),%eax
 530:	6a 01                	push   $0x1
 532:	6a 0a                	push   $0xa
 534:	50                   	push   %eax
 535:	ff 75 08             	pushl  0x8(%ebp)
 538:	e8 c7 fe ff ff       	call   404 <printint>
 53d:	83 c4 10             	add    $0x10,%esp
        ap++;
 540:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 544:	e9 d5 00 00 00       	jmp    61e <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 549:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54d:	74 06                	je     555 <printf+0xa3>
 54f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 553:	75 1e                	jne    573 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 555:	8b 45 e8             	mov    -0x18(%ebp),%eax
 558:	8b 00                	mov    (%eax),%eax
 55a:	6a 00                	push   $0x0
 55c:	6a 10                	push   $0x10
 55e:	50                   	push   %eax
 55f:	ff 75 08             	pushl  0x8(%ebp)
 562:	e8 9d fe ff ff       	call   404 <printint>
 567:	83 c4 10             	add    $0x10,%esp
        ap++;
 56a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56e:	e9 ab 00 00 00       	jmp    61e <printf+0x16c>
      } else if(c == 's'){
 573:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 577:	75 40                	jne    5b9 <printf+0x107>
        s = (char*)*ap;
 579:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57c:	8b 00                	mov    (%eax),%eax
 57e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 581:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 585:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 589:	75 23                	jne    5ae <printf+0xfc>
          s = "(null)";
 58b:	c7 45 f4 b1 08 00 00 	movl   $0x8b1,-0xc(%ebp)
        while(*s != 0){
 592:	eb 1a                	jmp    5ae <printf+0xfc>
          putc(fd, *s);
 594:	8b 45 f4             	mov    -0xc(%ebp),%eax
 597:	8a 00                	mov    (%eax),%al
 599:	0f be c0             	movsbl %al,%eax
 59c:	83 ec 08             	sub    $0x8,%esp
 59f:	50                   	push   %eax
 5a0:	ff 75 08             	pushl  0x8(%ebp)
 5a3:	e8 39 fe ff ff       	call   3e1 <putc>
 5a8:	83 c4 10             	add    $0x10,%esp
          s++;
 5ab:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 5ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b1:	8a 00                	mov    (%eax),%al
 5b3:	84 c0                	test   %al,%al
 5b5:	75 dd                	jne    594 <printf+0xe2>
 5b7:	eb 65                	jmp    61e <printf+0x16c>
        }
      } else if(c == 'c'){
 5b9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5bd:	75 1d                	jne    5dc <printf+0x12a>
        putc(fd, *ap);
 5bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c2:	8b 00                	mov    (%eax),%eax
 5c4:	0f be c0             	movsbl %al,%eax
 5c7:	83 ec 08             	sub    $0x8,%esp
 5ca:	50                   	push   %eax
 5cb:	ff 75 08             	pushl  0x8(%ebp)
 5ce:	e8 0e fe ff ff       	call   3e1 <putc>
 5d3:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5da:	eb 42                	jmp    61e <printf+0x16c>
      } else if(c == '%'){
 5dc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5e0:	75 17                	jne    5f9 <printf+0x147>
        putc(fd, c);
 5e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e5:	0f be c0             	movsbl %al,%eax
 5e8:	83 ec 08             	sub    $0x8,%esp
 5eb:	50                   	push   %eax
 5ec:	ff 75 08             	pushl  0x8(%ebp)
 5ef:	e8 ed fd ff ff       	call   3e1 <putc>
 5f4:	83 c4 10             	add    $0x10,%esp
 5f7:	eb 25                	jmp    61e <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f9:	83 ec 08             	sub    $0x8,%esp
 5fc:	6a 25                	push   $0x25
 5fe:	ff 75 08             	pushl  0x8(%ebp)
 601:	e8 db fd ff ff       	call   3e1 <putc>
 606:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 609:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60c:	0f be c0             	movsbl %al,%eax
 60f:	83 ec 08             	sub    $0x8,%esp
 612:	50                   	push   %eax
 613:	ff 75 08             	pushl  0x8(%ebp)
 616:	e8 c6 fd ff ff       	call   3e1 <putc>
 61b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 61e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 625:	ff 45 f0             	incl   -0x10(%ebp)
 628:	8b 55 0c             	mov    0xc(%ebp),%edx
 62b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62e:	01 d0                	add    %edx,%eax
 630:	8a 00                	mov    (%eax),%al
 632:	84 c0                	test   %al,%al
 634:	0f 85 9a fe ff ff    	jne    4d4 <printf+0x22>
    }
  }
}
 63a:	90                   	nop
 63b:	90                   	nop
 63c:	c9                   	leave  
 63d:	c3                   	ret    

0000063e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 63e:	55                   	push   %ebp
 63f:	89 e5                	mov    %esp,%ebp
 641:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 644:	8b 45 08             	mov    0x8(%ebp),%eax
 647:	83 e8 08             	sub    $0x8,%eax
 64a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64d:	a1 dc 08 00 00       	mov    0x8dc,%eax
 652:	89 45 fc             	mov    %eax,-0x4(%ebp)
 655:	eb 24                	jmp    67b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 657:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65a:	8b 00                	mov    (%eax),%eax
 65c:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 65f:	72 12                	jb     673 <free+0x35>
 661:	8b 45 f8             	mov    -0x8(%ebp),%eax
 664:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 667:	72 24                	jb     68d <free+0x4f>
 669:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66c:	8b 00                	mov    (%eax),%eax
 66e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 671:	72 1a                	jb     68d <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 673:	8b 45 fc             	mov    -0x4(%ebp),%eax
 676:	8b 00                	mov    (%eax),%eax
 678:	89 45 fc             	mov    %eax,-0x4(%ebp)
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 681:	73 d4                	jae    657 <free+0x19>
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 68b:	73 ca                	jae    657 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	8b 40 04             	mov    0x4(%eax),%eax
 693:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 69a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69d:	01 c2                	add    %eax,%edx
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	8b 00                	mov    (%eax),%eax
 6a4:	39 c2                	cmp    %eax,%edx
 6a6:	75 24                	jne    6cc <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ab:	8b 50 04             	mov    0x4(%eax),%edx
 6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b1:	8b 00                	mov    (%eax),%eax
 6b3:	8b 40 04             	mov    0x4(%eax),%eax
 6b6:	01 c2                	add    %eax,%edx
 6b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bb:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c1:	8b 00                	mov    (%eax),%eax
 6c3:	8b 10                	mov    (%eax),%edx
 6c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c8:	89 10                	mov    %edx,(%eax)
 6ca:	eb 0a                	jmp    6d6 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cf:	8b 10                	mov    (%eax),%edx
 6d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d4:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d9:	8b 40 04             	mov    0x4(%eax),%eax
 6dc:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e6:	01 d0                	add    %edx,%eax
 6e8:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6eb:	75 20                	jne    70d <free+0xcf>
    p->s.size += bp->s.size;
 6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f0:	8b 50 04             	mov    0x4(%eax),%edx
 6f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f6:	8b 40 04             	mov    0x4(%eax),%eax
 6f9:	01 c2                	add    %eax,%edx
 6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fe:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 701:	8b 45 f8             	mov    -0x8(%ebp),%eax
 704:	8b 10                	mov    (%eax),%edx
 706:	8b 45 fc             	mov    -0x4(%ebp),%eax
 709:	89 10                	mov    %edx,(%eax)
 70b:	eb 08                	jmp    715 <free+0xd7>
  } else
    p->s.ptr = bp;
 70d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 710:	8b 55 f8             	mov    -0x8(%ebp),%edx
 713:	89 10                	mov    %edx,(%eax)
  freep = p;
 715:	8b 45 fc             	mov    -0x4(%ebp),%eax
 718:	a3 dc 08 00 00       	mov    %eax,0x8dc
}
 71d:	90                   	nop
 71e:	c9                   	leave  
 71f:	c3                   	ret    

00000720 <morecore>:

static Header*
morecore(uint nu)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 726:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 72d:	77 07                	ja     736 <morecore+0x16>
    nu = 4096;
 72f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 736:	8b 45 08             	mov    0x8(%ebp),%eax
 739:	c1 e0 03             	shl    $0x3,%eax
 73c:	83 ec 0c             	sub    $0xc,%esp
 73f:	50                   	push   %eax
 740:	e8 84 fc ff ff       	call   3c9 <sbrk>
 745:	83 c4 10             	add    $0x10,%esp
 748:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 74b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 74f:	75 07                	jne    758 <morecore+0x38>
    return 0;
 751:	b8 00 00 00 00       	mov    $0x0,%eax
 756:	eb 26                	jmp    77e <morecore+0x5e>
  hp = (Header*)p;
 758:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 75e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 761:	8b 55 08             	mov    0x8(%ebp),%edx
 764:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 767:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76a:	83 c0 08             	add    $0x8,%eax
 76d:	83 ec 0c             	sub    $0xc,%esp
 770:	50                   	push   %eax
 771:	e8 c8 fe ff ff       	call   63e <free>
 776:	83 c4 10             	add    $0x10,%esp
  return freep;
 779:	a1 dc 08 00 00       	mov    0x8dc,%eax
}
 77e:	c9                   	leave  
 77f:	c3                   	ret    

00000780 <malloc>:

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 786:	8b 45 08             	mov    0x8(%ebp),%eax
 789:	83 c0 07             	add    $0x7,%eax
 78c:	c1 e8 03             	shr    $0x3,%eax
 78f:	40                   	inc    %eax
 790:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 793:	a1 dc 08 00 00       	mov    0x8dc,%eax
 798:	89 45 f0             	mov    %eax,-0x10(%ebp)
 79b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79f:	75 23                	jne    7c4 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 7a1:	c7 45 f0 d4 08 00 00 	movl   $0x8d4,-0x10(%ebp)
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	a3 dc 08 00 00       	mov    %eax,0x8dc
 7b0:	a1 dc 08 00 00       	mov    0x8dc,%eax
 7b5:	a3 d4 08 00 00       	mov    %eax,0x8d4
    base.s.size = 0;
 7ba:	c7 05 d8 08 00 00 00 	movl   $0x0,0x8d8
 7c1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c7:	8b 00                	mov    (%eax),%eax
 7c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cf:	8b 40 04             	mov    0x4(%eax),%eax
 7d2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d5:	72 4d                	jb     824 <malloc+0xa4>
      if(p->s.size == nunits)
 7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7da:	8b 40 04             	mov    0x4(%eax),%eax
 7dd:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7e0:	75 0c                	jne    7ee <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e5:	8b 10                	mov    (%eax),%edx
 7e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ea:	89 10                	mov    %edx,(%eax)
 7ec:	eb 26                	jmp    814 <malloc+0x94>
      else {
        p->s.size -= nunits;
 7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f1:	8b 40 04             	mov    0x4(%eax),%eax
 7f4:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f7:	89 c2                	mov    %eax,%edx
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 802:	8b 40 04             	mov    0x4(%eax),%eax
 805:	c1 e0 03             	shl    $0x3,%eax
 808:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 811:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 814:	8b 45 f0             	mov    -0x10(%ebp),%eax
 817:	a3 dc 08 00 00       	mov    %eax,0x8dc
      return (void*)(p + 1);
 81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81f:	83 c0 08             	add    $0x8,%eax
 822:	eb 3b                	jmp    85f <malloc+0xdf>
    }
    if(p == freep)
 824:	a1 dc 08 00 00       	mov    0x8dc,%eax
 829:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 82c:	75 1e                	jne    84c <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 82e:	83 ec 0c             	sub    $0xc,%esp
 831:	ff 75 ec             	pushl  -0x14(%ebp)
 834:	e8 e7 fe ff ff       	call   720 <morecore>
 839:	83 c4 10             	add    $0x10,%esp
 83c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 843:	75 07                	jne    84c <malloc+0xcc>
        return 0;
 845:	b8 00 00 00 00       	mov    $0x0,%eax
 84a:	eb 13                	jmp    85f <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 852:	8b 45 f4             	mov    -0xc(%ebp),%eax
 855:	8b 00                	mov    (%eax),%eax
 857:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 85a:	e9 6d ff ff ff       	jmp    7cc <malloc+0x4c>
  }
}
 85f:	c9                   	leave  
 860:	c3                   	ret    
