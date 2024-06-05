
_ln:     file format elf32-i386


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
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  11:	83 3b 03             	cmpl   $0x3,(%ebx)
  14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 d4 07 00 00       	push   $0x7d4
  1e:	6a 02                	push   $0x2
  20:	e8 00 04 00 00       	call   425 <printf>
  25:	83 c4 10             	add    $0x10,%esp
    exit();
  28:	e8 87 02 00 00       	call   2b4 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2d:	8b 43 04             	mov    0x4(%ebx),%eax
  30:	83 c0 08             	add    $0x8,%eax
  33:	8b 10                	mov    (%eax),%edx
  35:	8b 43 04             	mov    0x4(%ebx),%eax
  38:	83 c0 04             	add    $0x4,%eax
  3b:	8b 00                	mov    (%eax),%eax
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	52                   	push   %edx
  41:	50                   	push   %eax
  42:	e8 cd 02 00 00       	call   314 <link>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax
  4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	83 c0 08             	add    $0x8,%eax
  54:	8b 10                	mov    (%eax),%edx
  56:	8b 43 04             	mov    0x4(%ebx),%eax
  59:	83 c0 04             	add    $0x4,%eax
  5c:	8b 00                	mov    (%eax),%eax
  5e:	52                   	push   %edx
  5f:	50                   	push   %eax
  60:	68 e7 07 00 00       	push   $0x7e7
  65:	6a 02                	push   $0x2
  67:	e8 b9 03 00 00       	call   425 <printf>
  6c:	83 c4 10             	add    $0x10,%esp
  exit();
  6f:	e8 40 02 00 00       	call   2b4 <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	57                   	push   %edi
  78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  79:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7c:	8b 55 10             	mov    0x10(%ebp),%edx
  7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  82:	89 cb                	mov    %ecx,%ebx
  84:	89 df                	mov    %ebx,%edi
  86:	89 d1                	mov    %edx,%ecx
  88:	fc                   	cld    
  89:	f3 aa                	rep stos %al,%es:(%edi)
  8b:	89 ca                	mov    %ecx,%edx
  8d:	89 fb                	mov    %edi,%ebx
  8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  95:	90                   	nop
  96:	5b                   	pop    %ebx
  97:	5f                   	pop    %edi
  98:	5d                   	pop    %ebp
  99:	c3                   	ret    

0000009a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  9a:	55                   	push   %ebp
  9b:	89 e5                	mov    %esp,%ebp
  9d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a6:	90                   	nop
  a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  aa:	8d 42 01             	lea    0x1(%edx),%eax
  ad:	89 45 0c             	mov    %eax,0xc(%ebp)
  b0:	8b 45 08             	mov    0x8(%ebp),%eax
  b3:	8d 48 01             	lea    0x1(%eax),%ecx
  b6:	89 4d 08             	mov    %ecx,0x8(%ebp)
  b9:	8a 12                	mov    (%edx),%dl
  bb:	88 10                	mov    %dl,(%eax)
  bd:	8a 00                	mov    (%eax),%al
  bf:	84 c0                	test   %al,%al
  c1:	75 e4                	jne    a7 <strcpy+0xd>
    ;
  return os;
  c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c6:	c9                   	leave  
  c7:	c3                   	ret    

000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  cb:	eb 06                	jmp    d3 <strcmp+0xb>
    p++, q++;
  cd:	ff 45 08             	incl   0x8(%ebp)
  d0:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	8a 00                	mov    (%eax),%al
  d8:	84 c0                	test   %al,%al
  da:	74 0e                	je     ea <strcmp+0x22>
  dc:	8b 45 08             	mov    0x8(%ebp),%eax
  df:	8a 10                	mov    (%eax),%dl
  e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  e4:	8a 00                	mov    (%eax),%al
  e6:	38 c2                	cmp    %al,%dl
  e8:	74 e3                	je     cd <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  ea:	8b 45 08             	mov    0x8(%ebp),%eax
  ed:	8a 00                	mov    (%eax),%al
  ef:	0f b6 d0             	movzbl %al,%edx
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	8a 00                	mov    (%eax),%al
  f7:	0f b6 c0             	movzbl %al,%eax
  fa:	29 c2                	sub    %eax,%edx
  fc:	89 d0                	mov    %edx,%eax
}
  fe:	5d                   	pop    %ebp
  ff:	c3                   	ret    

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 106:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10d:	eb 03                	jmp    112 <strlen+0x12>
 10f:	ff 45 fc             	incl   -0x4(%ebp)
 112:	8b 55 fc             	mov    -0x4(%ebp),%edx
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	01 d0                	add    %edx,%eax
 11a:	8a 00                	mov    (%eax),%al
 11c:	84 c0                	test   %al,%al
 11e:	75 ef                	jne    10f <strlen+0xf>
    ;
  return n;
 120:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 123:	c9                   	leave  
 124:	c3                   	ret    

00000125 <memset>:

void*
memset(void *dst, int c, uint n)
{
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 128:	8b 45 10             	mov    0x10(%ebp),%eax
 12b:	50                   	push   %eax
 12c:	ff 75 0c             	pushl  0xc(%ebp)
 12f:	ff 75 08             	pushl  0x8(%ebp)
 132:	e8 3d ff ff ff       	call   74 <stosb>
 137:	83 c4 0c             	add    $0xc,%esp
  return dst;
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 13d:	c9                   	leave  
 13e:	c3                   	ret    

0000013f <strchr>:

char*
strchr(const char *s, char c)
{
 13f:	55                   	push   %ebp
 140:	89 e5                	mov    %esp,%ebp
 142:	83 ec 04             	sub    $0x4,%esp
 145:	8b 45 0c             	mov    0xc(%ebp),%eax
 148:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 14b:	eb 12                	jmp    15f <strchr+0x20>
    if(*s == c)
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	8a 00                	mov    (%eax),%al
 152:	38 45 fc             	cmp    %al,-0x4(%ebp)
 155:	75 05                	jne    15c <strchr+0x1d>
      return (char*)s;
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	eb 11                	jmp    16d <strchr+0x2e>
  for(; *s; s++)
 15c:	ff 45 08             	incl   0x8(%ebp)
 15f:	8b 45 08             	mov    0x8(%ebp),%eax
 162:	8a 00                	mov    (%eax),%al
 164:	84 c0                	test   %al,%al
 166:	75 e5                	jne    14d <strchr+0xe>
  return 0;
 168:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16d:	c9                   	leave  
 16e:	c3                   	ret    

0000016f <gets>:

char*
gets(char *buf, int max)
{
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 175:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 17c:	eb 3f                	jmp    1bd <gets+0x4e>
    cc = read(0, &c, 1);
 17e:	83 ec 04             	sub    $0x4,%esp
 181:	6a 01                	push   $0x1
 183:	8d 45 ef             	lea    -0x11(%ebp),%eax
 186:	50                   	push   %eax
 187:	6a 00                	push   $0x0
 189:	e8 3e 01 00 00       	call   2cc <read>
 18e:	83 c4 10             	add    $0x10,%esp
 191:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 194:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 198:	7e 2e                	jle    1c8 <gets+0x59>
      break;
    buf[i++] = c;
 19a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19d:	8d 50 01             	lea    0x1(%eax),%edx
 1a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a3:	89 c2                	mov    %eax,%edx
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
 1a8:	01 c2                	add    %eax,%edx
 1aa:	8a 45 ef             	mov    -0x11(%ebp),%al
 1ad:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1af:	8a 45 ef             	mov    -0x11(%ebp),%al
 1b2:	3c 0a                	cmp    $0xa,%al
 1b4:	74 13                	je     1c9 <gets+0x5a>
 1b6:	8a 45 ef             	mov    -0x11(%ebp),%al
 1b9:	3c 0d                	cmp    $0xd,%al
 1bb:	74 0c                	je     1c9 <gets+0x5a>
  for(i=0; i+1 < max; ){
 1bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c0:	40                   	inc    %eax
 1c1:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1c4:	7f b8                	jg     17e <gets+0xf>
 1c6:	eb 01                	jmp    1c9 <gets+0x5a>
      break;
 1c8:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
 1cf:	01 d0                	add    %edx,%eax
 1d1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d7:	c9                   	leave  
 1d8:	c3                   	ret    

000001d9 <stat>:

int
stat(char *n, struct stat *st)
{
 1d9:	55                   	push   %ebp
 1da:	89 e5                	mov    %esp,%ebp
 1dc:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1df:	83 ec 08             	sub    $0x8,%esp
 1e2:	6a 00                	push   $0x0
 1e4:	ff 75 08             	pushl  0x8(%ebp)
 1e7:	e8 08 01 00 00       	call   2f4 <open>
 1ec:	83 c4 10             	add    $0x10,%esp
 1ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1f6:	79 07                	jns    1ff <stat+0x26>
    return -1;
 1f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1fd:	eb 25                	jmp    224 <stat+0x4b>
  r = fstat(fd, st);
 1ff:	83 ec 08             	sub    $0x8,%esp
 202:	ff 75 0c             	pushl  0xc(%ebp)
 205:	ff 75 f4             	pushl  -0xc(%ebp)
 208:	e8 ff 00 00 00       	call   30c <fstat>
 20d:	83 c4 10             	add    $0x10,%esp
 210:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 213:	83 ec 0c             	sub    $0xc,%esp
 216:	ff 75 f4             	pushl  -0xc(%ebp)
 219:	e8 be 00 00 00       	call   2dc <close>
 21e:	83 c4 10             	add    $0x10,%esp
  return r;
 221:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 224:	c9                   	leave  
 225:	c3                   	ret    

00000226 <atoi>:

int
atoi(const char *s)
{
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 22c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 233:	eb 24                	jmp    259 <atoi+0x33>
    n = n*10 + *s++ - '0';
 235:	8b 55 fc             	mov    -0x4(%ebp),%edx
 238:	89 d0                	mov    %edx,%eax
 23a:	c1 e0 02             	shl    $0x2,%eax
 23d:	01 d0                	add    %edx,%eax
 23f:	01 c0                	add    %eax,%eax
 241:	89 c1                	mov    %eax,%ecx
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	8d 50 01             	lea    0x1(%eax),%edx
 249:	89 55 08             	mov    %edx,0x8(%ebp)
 24c:	8a 00                	mov    (%eax),%al
 24e:	0f be c0             	movsbl %al,%eax
 251:	01 c8                	add    %ecx,%eax
 253:	83 e8 30             	sub    $0x30,%eax
 256:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 259:	8b 45 08             	mov    0x8(%ebp),%eax
 25c:	8a 00                	mov    (%eax),%al
 25e:	3c 2f                	cmp    $0x2f,%al
 260:	7e 09                	jle    26b <atoi+0x45>
 262:	8b 45 08             	mov    0x8(%ebp),%eax
 265:	8a 00                	mov    (%eax),%al
 267:	3c 39                	cmp    $0x39,%al
 269:	7e ca                	jle    235 <atoi+0xf>
  return n;
 26b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 26e:	c9                   	leave  
 26f:	c3                   	ret    

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 27c:	8b 45 0c             	mov    0xc(%ebp),%eax
 27f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 282:	eb 16                	jmp    29a <memmove+0x2a>
    *dst++ = *src++;
 284:	8b 55 f8             	mov    -0x8(%ebp),%edx
 287:	8d 42 01             	lea    0x1(%edx),%eax
 28a:	89 45 f8             	mov    %eax,-0x8(%ebp)
 28d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 290:	8d 48 01             	lea    0x1(%eax),%ecx
 293:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 296:	8a 12                	mov    (%edx),%dl
 298:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 29a:	8b 45 10             	mov    0x10(%ebp),%eax
 29d:	8d 50 ff             	lea    -0x1(%eax),%edx
 2a0:	89 55 10             	mov    %edx,0x10(%ebp)
 2a3:	85 c0                	test   %eax,%eax
 2a5:	7f dd                	jg     284 <memmove+0x14>
  return vdst;
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2aa:	c9                   	leave  
 2ab:	c3                   	ret    

000002ac <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ac:	b8 01 00 00 00       	mov    $0x1,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <exit>:
SYSCALL(exit)
 2b4:	b8 02 00 00 00       	mov    $0x2,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <wait>:
SYSCALL(wait)
 2bc:	b8 03 00 00 00       	mov    $0x3,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <pipe>:
SYSCALL(pipe)
 2c4:	b8 04 00 00 00       	mov    $0x4,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <read>:
SYSCALL(read)
 2cc:	b8 05 00 00 00       	mov    $0x5,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <write>:
SYSCALL(write)
 2d4:	b8 10 00 00 00       	mov    $0x10,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <close>:
SYSCALL(close)
 2dc:	b8 15 00 00 00       	mov    $0x15,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <kill>:
SYSCALL(kill)
 2e4:	b8 06 00 00 00       	mov    $0x6,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <exec>:
SYSCALL(exec)
 2ec:	b8 07 00 00 00       	mov    $0x7,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <open>:
SYSCALL(open)
 2f4:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <mknod>:
SYSCALL(mknod)
 2fc:	b8 11 00 00 00       	mov    $0x11,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <unlink>:
SYSCALL(unlink)
 304:	b8 12 00 00 00       	mov    $0x12,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <fstat>:
SYSCALL(fstat)
 30c:	b8 08 00 00 00       	mov    $0x8,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <link>:
SYSCALL(link)
 314:	b8 13 00 00 00       	mov    $0x13,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <mkdir>:
SYSCALL(mkdir)
 31c:	b8 14 00 00 00       	mov    $0x14,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <chdir>:
SYSCALL(chdir)
 324:	b8 09 00 00 00       	mov    $0x9,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <dup>:
SYSCALL(dup)
 32c:	b8 0a 00 00 00       	mov    $0xa,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <getpid>:
SYSCALL(getpid)
 334:	b8 0b 00 00 00       	mov    $0xb,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <sbrk>:
SYSCALL(sbrk)
 33c:	b8 0c 00 00 00       	mov    $0xc,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <sleep>:
SYSCALL(sleep)
 344:	b8 0d 00 00 00       	mov    $0xd,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <uptime>:
SYSCALL(uptime)
 34c:	b8 0e 00 00 00       	mov    $0xe,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	83 ec 18             	sub    $0x18,%esp
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 360:	83 ec 04             	sub    $0x4,%esp
 363:	6a 01                	push   $0x1
 365:	8d 45 f4             	lea    -0xc(%ebp),%eax
 368:	50                   	push   %eax
 369:	ff 75 08             	pushl  0x8(%ebp)
 36c:	e8 63 ff ff ff       	call   2d4 <write>
 371:	83 c4 10             	add    $0x10,%esp
}
 374:	90                   	nop
 375:	c9                   	leave  
 376:	c3                   	ret    

00000377 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 377:	55                   	push   %ebp
 378:	89 e5                	mov    %esp,%ebp
 37a:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 37d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 384:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 388:	74 17                	je     3a1 <printint+0x2a>
 38a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 38e:	79 11                	jns    3a1 <printint+0x2a>
    neg = 1;
 390:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 397:	8b 45 0c             	mov    0xc(%ebp),%eax
 39a:	f7 d8                	neg    %eax
 39c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 39f:	eb 06                	jmp    3a7 <printint+0x30>
  } else {
    x = xx;
 3a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ae:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b4:	ba 00 00 00 00       	mov    $0x0,%edx
 3b9:	f7 f1                	div    %ecx
 3bb:	89 d1                	mov    %edx,%ecx
 3bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3c0:	8d 50 01             	lea    0x1(%eax),%edx
 3c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3c6:	8a 91 04 08 00 00    	mov    0x804(%ecx),%dl
 3cc:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3d0:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d6:	ba 00 00 00 00       	mov    $0x0,%edx
 3db:	f7 f1                	div    %ecx
 3dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3e4:	75 c8                	jne    3ae <printint+0x37>
  if(neg)
 3e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3ea:	74 2c                	je     418 <printint+0xa1>
    buf[i++] = '-';
 3ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ef:	8d 50 01             	lea    0x1(%eax),%edx
 3f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3f5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3fa:	eb 1c                	jmp    418 <printint+0xa1>
    putc(fd, buf[i]);
 3fc:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 402:	01 d0                	add    %edx,%eax
 404:	8a 00                	mov    (%eax),%al
 406:	0f be c0             	movsbl %al,%eax
 409:	83 ec 08             	sub    $0x8,%esp
 40c:	50                   	push   %eax
 40d:	ff 75 08             	pushl  0x8(%ebp)
 410:	e8 3f ff ff ff       	call   354 <putc>
 415:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 418:	ff 4d f4             	decl   -0xc(%ebp)
 41b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 41f:	79 db                	jns    3fc <printint+0x85>
}
 421:	90                   	nop
 422:	90                   	nop
 423:	c9                   	leave  
 424:	c3                   	ret    

00000425 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 425:	55                   	push   %ebp
 426:	89 e5                	mov    %esp,%ebp
 428:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 42b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 432:	8d 45 0c             	lea    0xc(%ebp),%eax
 435:	83 c0 04             	add    $0x4,%eax
 438:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 43b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 442:	e9 54 01 00 00       	jmp    59b <printf+0x176>
    c = fmt[i] & 0xff;
 447:	8b 55 0c             	mov    0xc(%ebp),%edx
 44a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 44d:	01 d0                	add    %edx,%eax
 44f:	8a 00                	mov    (%eax),%al
 451:	0f be c0             	movsbl %al,%eax
 454:	25 ff 00 00 00       	and    $0xff,%eax
 459:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 45c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 460:	75 2c                	jne    48e <printf+0x69>
      if(c == '%'){
 462:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 466:	75 0c                	jne    474 <printf+0x4f>
        state = '%';
 468:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 46f:	e9 24 01 00 00       	jmp    598 <printf+0x173>
      } else {
        putc(fd, c);
 474:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 477:	0f be c0             	movsbl %al,%eax
 47a:	83 ec 08             	sub    $0x8,%esp
 47d:	50                   	push   %eax
 47e:	ff 75 08             	pushl  0x8(%ebp)
 481:	e8 ce fe ff ff       	call   354 <putc>
 486:	83 c4 10             	add    $0x10,%esp
 489:	e9 0a 01 00 00       	jmp    598 <printf+0x173>
      }
    } else if(state == '%'){
 48e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 492:	0f 85 00 01 00 00    	jne    598 <printf+0x173>
      if(c == 'd'){
 498:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 49c:	75 1e                	jne    4bc <printf+0x97>
        printint(fd, *ap, 10, 1);
 49e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a1:	8b 00                	mov    (%eax),%eax
 4a3:	6a 01                	push   $0x1
 4a5:	6a 0a                	push   $0xa
 4a7:	50                   	push   %eax
 4a8:	ff 75 08             	pushl  0x8(%ebp)
 4ab:	e8 c7 fe ff ff       	call   377 <printint>
 4b0:	83 c4 10             	add    $0x10,%esp
        ap++;
 4b3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b7:	e9 d5 00 00 00       	jmp    591 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 4bc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4c0:	74 06                	je     4c8 <printf+0xa3>
 4c2:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4c6:	75 1e                	jne    4e6 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 4c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4cb:	8b 00                	mov    (%eax),%eax
 4cd:	6a 00                	push   $0x0
 4cf:	6a 10                	push   $0x10
 4d1:	50                   	push   %eax
 4d2:	ff 75 08             	pushl  0x8(%ebp)
 4d5:	e8 9d fe ff ff       	call   377 <printint>
 4da:	83 c4 10             	add    $0x10,%esp
        ap++;
 4dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e1:	e9 ab 00 00 00       	jmp    591 <printf+0x16c>
      } else if(c == 's'){
 4e6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4ea:	75 40                	jne    52c <printf+0x107>
        s = (char*)*ap;
 4ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ef:	8b 00                	mov    (%eax),%eax
 4f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4fc:	75 23                	jne    521 <printf+0xfc>
          s = "(null)";
 4fe:	c7 45 f4 fb 07 00 00 	movl   $0x7fb,-0xc(%ebp)
        while(*s != 0){
 505:	eb 1a                	jmp    521 <printf+0xfc>
          putc(fd, *s);
 507:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50a:	8a 00                	mov    (%eax),%al
 50c:	0f be c0             	movsbl %al,%eax
 50f:	83 ec 08             	sub    $0x8,%esp
 512:	50                   	push   %eax
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	e8 39 fe ff ff       	call   354 <putc>
 51b:	83 c4 10             	add    $0x10,%esp
          s++;
 51e:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 521:	8b 45 f4             	mov    -0xc(%ebp),%eax
 524:	8a 00                	mov    (%eax),%al
 526:	84 c0                	test   %al,%al
 528:	75 dd                	jne    507 <printf+0xe2>
 52a:	eb 65                	jmp    591 <printf+0x16c>
        }
      } else if(c == 'c'){
 52c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 530:	75 1d                	jne    54f <printf+0x12a>
        putc(fd, *ap);
 532:	8b 45 e8             	mov    -0x18(%ebp),%eax
 535:	8b 00                	mov    (%eax),%eax
 537:	0f be c0             	movsbl %al,%eax
 53a:	83 ec 08             	sub    $0x8,%esp
 53d:	50                   	push   %eax
 53e:	ff 75 08             	pushl  0x8(%ebp)
 541:	e8 0e fe ff ff       	call   354 <putc>
 546:	83 c4 10             	add    $0x10,%esp
        ap++;
 549:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54d:	eb 42                	jmp    591 <printf+0x16c>
      } else if(c == '%'){
 54f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 553:	75 17                	jne    56c <printf+0x147>
        putc(fd, c);
 555:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 558:	0f be c0             	movsbl %al,%eax
 55b:	83 ec 08             	sub    $0x8,%esp
 55e:	50                   	push   %eax
 55f:	ff 75 08             	pushl  0x8(%ebp)
 562:	e8 ed fd ff ff       	call   354 <putc>
 567:	83 c4 10             	add    $0x10,%esp
 56a:	eb 25                	jmp    591 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 56c:	83 ec 08             	sub    $0x8,%esp
 56f:	6a 25                	push   $0x25
 571:	ff 75 08             	pushl  0x8(%ebp)
 574:	e8 db fd ff ff       	call   354 <putc>
 579:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 57c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57f:	0f be c0             	movsbl %al,%eax
 582:	83 ec 08             	sub    $0x8,%esp
 585:	50                   	push   %eax
 586:	ff 75 08             	pushl  0x8(%ebp)
 589:	e8 c6 fd ff ff       	call   354 <putc>
 58e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 591:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 598:	ff 45 f0             	incl   -0x10(%ebp)
 59b:	8b 55 0c             	mov    0xc(%ebp),%edx
 59e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5a1:	01 d0                	add    %edx,%eax
 5a3:	8a 00                	mov    (%eax),%al
 5a5:	84 c0                	test   %al,%al
 5a7:	0f 85 9a fe ff ff    	jne    447 <printf+0x22>
    }
  }
}
 5ad:	90                   	nop
 5ae:	90                   	nop
 5af:	c9                   	leave  
 5b0:	c3                   	ret    

000005b1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b1:	55                   	push   %ebp
 5b2:	89 e5                	mov    %esp,%ebp
 5b4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ba:	83 e8 08             	sub    $0x8,%eax
 5bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c0:	a1 20 08 00 00       	mov    0x820,%eax
 5c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c8:	eb 24                	jmp    5ee <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cd:	8b 00                	mov    (%eax),%eax
 5cf:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5d2:	72 12                	jb     5e6 <free+0x35>
 5d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d7:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5da:	72 24                	jb     600 <free+0x4f>
 5dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5df:	8b 00                	mov    (%eax),%eax
 5e1:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5e4:	72 1a                	jb     600 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e9:	8b 00                	mov    (%eax),%eax
 5eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f1:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5f4:	73 d4                	jae    5ca <free+0x19>
 5f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f9:	8b 00                	mov    (%eax),%eax
 5fb:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5fe:	73 ca                	jae    5ca <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 600:	8b 45 f8             	mov    -0x8(%ebp),%eax
 603:	8b 40 04             	mov    0x4(%eax),%eax
 606:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 610:	01 c2                	add    %eax,%edx
 612:	8b 45 fc             	mov    -0x4(%ebp),%eax
 615:	8b 00                	mov    (%eax),%eax
 617:	39 c2                	cmp    %eax,%edx
 619:	75 24                	jne    63f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 61b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61e:	8b 50 04             	mov    0x4(%eax),%edx
 621:	8b 45 fc             	mov    -0x4(%ebp),%eax
 624:	8b 00                	mov    (%eax),%eax
 626:	8b 40 04             	mov    0x4(%eax),%eax
 629:	01 c2                	add    %eax,%edx
 62b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 631:	8b 45 fc             	mov    -0x4(%ebp),%eax
 634:	8b 00                	mov    (%eax),%eax
 636:	8b 10                	mov    (%eax),%edx
 638:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63b:	89 10                	mov    %edx,(%eax)
 63d:	eb 0a                	jmp    649 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 63f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 642:	8b 10                	mov    (%eax),%edx
 644:	8b 45 f8             	mov    -0x8(%ebp),%eax
 647:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 40 04             	mov    0x4(%eax),%eax
 64f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 656:	8b 45 fc             	mov    -0x4(%ebp),%eax
 659:	01 d0                	add    %edx,%eax
 65b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 65e:	75 20                	jne    680 <free+0xcf>
    p->s.size += bp->s.size;
 660:	8b 45 fc             	mov    -0x4(%ebp),%eax
 663:	8b 50 04             	mov    0x4(%eax),%edx
 666:	8b 45 f8             	mov    -0x8(%ebp),%eax
 669:	8b 40 04             	mov    0x4(%eax),%eax
 66c:	01 c2                	add    %eax,%edx
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 674:	8b 45 f8             	mov    -0x8(%ebp),%eax
 677:	8b 10                	mov    (%eax),%edx
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	89 10                	mov    %edx,(%eax)
 67e:	eb 08                	jmp    688 <free+0xd7>
  } else
    p->s.ptr = bp;
 680:	8b 45 fc             	mov    -0x4(%ebp),%eax
 683:	8b 55 f8             	mov    -0x8(%ebp),%edx
 686:	89 10                	mov    %edx,(%eax)
  freep = p;
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	a3 20 08 00 00       	mov    %eax,0x820
}
 690:	90                   	nop
 691:	c9                   	leave  
 692:	c3                   	ret    

00000693 <morecore>:

static Header*
morecore(uint nu)
{
 693:	55                   	push   %ebp
 694:	89 e5                	mov    %esp,%ebp
 696:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 699:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6a0:	77 07                	ja     6a9 <morecore+0x16>
    nu = 4096;
 6a2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ac:	c1 e0 03             	shl    $0x3,%eax
 6af:	83 ec 0c             	sub    $0xc,%esp
 6b2:	50                   	push   %eax
 6b3:	e8 84 fc ff ff       	call   33c <sbrk>
 6b8:	83 c4 10             	add    $0x10,%esp
 6bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6be:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6c2:	75 07                	jne    6cb <morecore+0x38>
    return 0;
 6c4:	b8 00 00 00 00       	mov    $0x0,%eax
 6c9:	eb 26                	jmp    6f1 <morecore+0x5e>
  hp = (Header*)p;
 6cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d4:	8b 55 08             	mov    0x8(%ebp),%edx
 6d7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6dd:	83 c0 08             	add    $0x8,%eax
 6e0:	83 ec 0c             	sub    $0xc,%esp
 6e3:	50                   	push   %eax
 6e4:	e8 c8 fe ff ff       	call   5b1 <free>
 6e9:	83 c4 10             	add    $0x10,%esp
  return freep;
 6ec:	a1 20 08 00 00       	mov    0x820,%eax
}
 6f1:	c9                   	leave  
 6f2:	c3                   	ret    

000006f3 <malloc>:

void*
malloc(uint nbytes)
{
 6f3:	55                   	push   %ebp
 6f4:	89 e5                	mov    %esp,%ebp
 6f6:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
 6fc:	83 c0 07             	add    $0x7,%eax
 6ff:	c1 e8 03             	shr    $0x3,%eax
 702:	40                   	inc    %eax
 703:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 706:	a1 20 08 00 00       	mov    0x820,%eax
 70b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 70e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 712:	75 23                	jne    737 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 714:	c7 45 f0 18 08 00 00 	movl   $0x818,-0x10(%ebp)
 71b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71e:	a3 20 08 00 00       	mov    %eax,0x820
 723:	a1 20 08 00 00       	mov    0x820,%eax
 728:	a3 18 08 00 00       	mov    %eax,0x818
    base.s.size = 0;
 72d:	c7 05 1c 08 00 00 00 	movl   $0x0,0x81c
 734:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 737:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73a:	8b 00                	mov    (%eax),%eax
 73c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 73f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 742:	8b 40 04             	mov    0x4(%eax),%eax
 745:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 748:	72 4d                	jb     797 <malloc+0xa4>
      if(p->s.size == nunits)
 74a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74d:	8b 40 04             	mov    0x4(%eax),%eax
 750:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 753:	75 0c                	jne    761 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 755:	8b 45 f4             	mov    -0xc(%ebp),%eax
 758:	8b 10                	mov    (%eax),%edx
 75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75d:	89 10                	mov    %edx,(%eax)
 75f:	eb 26                	jmp    787 <malloc+0x94>
      else {
        p->s.size -= nunits;
 761:	8b 45 f4             	mov    -0xc(%ebp),%eax
 764:	8b 40 04             	mov    0x4(%eax),%eax
 767:	2b 45 ec             	sub    -0x14(%ebp),%eax
 76a:	89 c2                	mov    %eax,%edx
 76c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	8b 40 04             	mov    0x4(%eax),%eax
 778:	c1 e0 03             	shl    $0x3,%eax
 77b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 781:	8b 55 ec             	mov    -0x14(%ebp),%edx
 784:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 787:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78a:	a3 20 08 00 00       	mov    %eax,0x820
      return (void*)(p + 1);
 78f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 792:	83 c0 08             	add    $0x8,%eax
 795:	eb 3b                	jmp    7d2 <malloc+0xdf>
    }
    if(p == freep)
 797:	a1 20 08 00 00       	mov    0x820,%eax
 79c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 79f:	75 1e                	jne    7bf <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 7a1:	83 ec 0c             	sub    $0xc,%esp
 7a4:	ff 75 ec             	pushl  -0x14(%ebp)
 7a7:	e8 e7 fe ff ff       	call   693 <morecore>
 7ac:	83 c4 10             	add    $0x10,%esp
 7af:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b6:	75 07                	jne    7bf <malloc+0xcc>
        return 0;
 7b8:	b8 00 00 00 00       	mov    $0x0,%eax
 7bd:	eb 13                	jmp    7d2 <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	8b 00                	mov    (%eax),%eax
 7ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7cd:	e9 6d ff ff ff       	jmp    73f <malloc+0x4c>
  }
}
 7d2:	c9                   	leave  
 7d3:	c3                   	ret    
