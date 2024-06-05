
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
  11:	e8 4e 02 00 00       	call   264 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 d8 02 00 00       	call   2fc <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 40 02 00 00       	call   26c <exit>

0000002c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	57                   	push   %edi
  30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  31:	8b 4d 08             	mov    0x8(%ebp),%ecx
  34:	8b 55 10             	mov    0x10(%ebp),%edx
  37:	8b 45 0c             	mov    0xc(%ebp),%eax
  3a:	89 cb                	mov    %ecx,%ebx
  3c:	89 df                	mov    %ebx,%edi
  3e:	89 d1                	mov    %edx,%ecx
  40:	fc                   	cld    
  41:	f3 aa                	rep stos %al,%es:(%edi)
  43:	89 ca                	mov    %ecx,%edx
  45:	89 fb                	mov    %edi,%ebx
  47:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4d:	90                   	nop
  4e:	5b                   	pop    %ebx
  4f:	5f                   	pop    %edi
  50:	5d                   	pop    %ebp
  51:	c3                   	ret    

00000052 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  52:	55                   	push   %ebp
  53:	89 e5                	mov    %esp,%ebp
  55:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  58:	8b 45 08             	mov    0x8(%ebp),%eax
  5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  5e:	90                   	nop
  5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  62:	8d 42 01             	lea    0x1(%edx),%eax
  65:	89 45 0c             	mov    %eax,0xc(%ebp)
  68:	8b 45 08             	mov    0x8(%ebp),%eax
  6b:	8d 48 01             	lea    0x1(%eax),%ecx
  6e:	89 4d 08             	mov    %ecx,0x8(%ebp)
  71:	8a 12                	mov    (%edx),%dl
  73:	88 10                	mov    %dl,(%eax)
  75:	8a 00                	mov    (%eax),%al
  77:	84 c0                	test   %al,%al
  79:	75 e4                	jne    5f <strcpy+0xd>
    ;
  return os;
  7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7e:	c9                   	leave  
  7f:	c3                   	ret    

00000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  83:	eb 06                	jmp    8b <strcmp+0xb>
    p++, q++;
  85:	ff 45 08             	incl   0x8(%ebp)
  88:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
  8b:	8b 45 08             	mov    0x8(%ebp),%eax
  8e:	8a 00                	mov    (%eax),%al
  90:	84 c0                	test   %al,%al
  92:	74 0e                	je     a2 <strcmp+0x22>
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	8a 10                	mov    (%eax),%dl
  99:	8b 45 0c             	mov    0xc(%ebp),%eax
  9c:	8a 00                	mov    (%eax),%al
  9e:	38 c2                	cmp    %al,%dl
  a0:	74 e3                	je     85 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  a2:	8b 45 08             	mov    0x8(%ebp),%eax
  a5:	8a 00                	mov    (%eax),%al
  a7:	0f b6 d0             	movzbl %al,%edx
  aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  ad:	8a 00                	mov    (%eax),%al
  af:	0f b6 c0             	movzbl %al,%eax
  b2:	29 c2                	sub    %eax,%edx
  b4:	89 d0                	mov    %edx,%eax
}
  b6:	5d                   	pop    %ebp
  b7:	c3                   	ret    

000000b8 <strlen>:

uint
strlen(char *s)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  c5:	eb 03                	jmp    ca <strlen+0x12>
  c7:	ff 45 fc             	incl   -0x4(%ebp)
  ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  cd:	8b 45 08             	mov    0x8(%ebp),%eax
  d0:	01 d0                	add    %edx,%eax
  d2:	8a 00                	mov    (%eax),%al
  d4:	84 c0                	test   %al,%al
  d6:	75 ef                	jne    c7 <strlen+0xf>
    ;
  return n;
  d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  db:	c9                   	leave  
  dc:	c3                   	ret    

000000dd <memset>:

void*
memset(void *dst, int c, uint n)
{
  dd:	55                   	push   %ebp
  de:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  e0:	8b 45 10             	mov    0x10(%ebp),%eax
  e3:	50                   	push   %eax
  e4:	ff 75 0c             	pushl  0xc(%ebp)
  e7:	ff 75 08             	pushl  0x8(%ebp)
  ea:	e8 3d ff ff ff       	call   2c <stosb>
  ef:	83 c4 0c             	add    $0xc,%esp
  return dst;
  f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  f5:	c9                   	leave  
  f6:	c3                   	ret    

000000f7 <strchr>:

char*
strchr(const char *s, char c)
{
  f7:	55                   	push   %ebp
  f8:	89 e5                	mov    %esp,%ebp
  fa:	83 ec 04             	sub    $0x4,%esp
  fd:	8b 45 0c             	mov    0xc(%ebp),%eax
 100:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 103:	eb 12                	jmp    117 <strchr+0x20>
    if(*s == c)
 105:	8b 45 08             	mov    0x8(%ebp),%eax
 108:	8a 00                	mov    (%eax),%al
 10a:	38 45 fc             	cmp    %al,-0x4(%ebp)
 10d:	75 05                	jne    114 <strchr+0x1d>
      return (char*)s;
 10f:	8b 45 08             	mov    0x8(%ebp),%eax
 112:	eb 11                	jmp    125 <strchr+0x2e>
  for(; *s; s++)
 114:	ff 45 08             	incl   0x8(%ebp)
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	8a 00                	mov    (%eax),%al
 11c:	84 c0                	test   %al,%al
 11e:	75 e5                	jne    105 <strchr+0xe>
  return 0;
 120:	b8 00 00 00 00       	mov    $0x0,%eax
}
 125:	c9                   	leave  
 126:	c3                   	ret    

00000127 <gets>:

char*
gets(char *buf, int max)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 134:	eb 3f                	jmp    175 <gets+0x4e>
    cc = read(0, &c, 1);
 136:	83 ec 04             	sub    $0x4,%esp
 139:	6a 01                	push   $0x1
 13b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 13e:	50                   	push   %eax
 13f:	6a 00                	push   $0x0
 141:	e8 3e 01 00 00       	call   284 <read>
 146:	83 c4 10             	add    $0x10,%esp
 149:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 14c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 150:	7e 2e                	jle    180 <gets+0x59>
      break;
    buf[i++] = c;
 152:	8b 45 f4             	mov    -0xc(%ebp),%eax
 155:	8d 50 01             	lea    0x1(%eax),%edx
 158:	89 55 f4             	mov    %edx,-0xc(%ebp)
 15b:	89 c2                	mov    %eax,%edx
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
 160:	01 c2                	add    %eax,%edx
 162:	8a 45 ef             	mov    -0x11(%ebp),%al
 165:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 167:	8a 45 ef             	mov    -0x11(%ebp),%al
 16a:	3c 0a                	cmp    $0xa,%al
 16c:	74 13                	je     181 <gets+0x5a>
 16e:	8a 45 ef             	mov    -0x11(%ebp),%al
 171:	3c 0d                	cmp    $0xd,%al
 173:	74 0c                	je     181 <gets+0x5a>
  for(i=0; i+1 < max; ){
 175:	8b 45 f4             	mov    -0xc(%ebp),%eax
 178:	40                   	inc    %eax
 179:	39 45 0c             	cmp    %eax,0xc(%ebp)
 17c:	7f b8                	jg     136 <gets+0xf>
 17e:	eb 01                	jmp    181 <gets+0x5a>
      break;
 180:	90                   	nop
      break;
  }
  buf[i] = '\0';
 181:	8b 55 f4             	mov    -0xc(%ebp),%edx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	01 d0                	add    %edx,%eax
 189:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 18f:	c9                   	leave  
 190:	c3                   	ret    

00000191 <stat>:

int
stat(char *n, struct stat *st)
{
 191:	55                   	push   %ebp
 192:	89 e5                	mov    %esp,%ebp
 194:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 197:	83 ec 08             	sub    $0x8,%esp
 19a:	6a 00                	push   $0x0
 19c:	ff 75 08             	pushl  0x8(%ebp)
 19f:	e8 08 01 00 00       	call   2ac <open>
 1a4:	83 c4 10             	add    $0x10,%esp
 1a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1ae:	79 07                	jns    1b7 <stat+0x26>
    return -1;
 1b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b5:	eb 25                	jmp    1dc <stat+0x4b>
  r = fstat(fd, st);
 1b7:	83 ec 08             	sub    $0x8,%esp
 1ba:	ff 75 0c             	pushl  0xc(%ebp)
 1bd:	ff 75 f4             	pushl  -0xc(%ebp)
 1c0:	e8 ff 00 00 00       	call   2c4 <fstat>
 1c5:	83 c4 10             	add    $0x10,%esp
 1c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1cb:	83 ec 0c             	sub    $0xc,%esp
 1ce:	ff 75 f4             	pushl  -0xc(%ebp)
 1d1:	e8 be 00 00 00       	call   294 <close>
 1d6:	83 c4 10             	add    $0x10,%esp
  return r;
 1d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1dc:	c9                   	leave  
 1dd:	c3                   	ret    

000001de <atoi>:

int
atoi(const char *s)
{
 1de:	55                   	push   %ebp
 1df:	89 e5                	mov    %esp,%ebp
 1e1:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1eb:	eb 24                	jmp    211 <atoi+0x33>
    n = n*10 + *s++ - '0';
 1ed:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f0:	89 d0                	mov    %edx,%eax
 1f2:	c1 e0 02             	shl    $0x2,%eax
 1f5:	01 d0                	add    %edx,%eax
 1f7:	01 c0                	add    %eax,%eax
 1f9:	89 c1                	mov    %eax,%ecx
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	8d 50 01             	lea    0x1(%eax),%edx
 201:	89 55 08             	mov    %edx,0x8(%ebp)
 204:	8a 00                	mov    (%eax),%al
 206:	0f be c0             	movsbl %al,%eax
 209:	01 c8                	add    %ecx,%eax
 20b:	83 e8 30             	sub    $0x30,%eax
 20e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 211:	8b 45 08             	mov    0x8(%ebp),%eax
 214:	8a 00                	mov    (%eax),%al
 216:	3c 2f                	cmp    $0x2f,%al
 218:	7e 09                	jle    223 <atoi+0x45>
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	8a 00                	mov    (%eax),%al
 21f:	3c 39                	cmp    $0x39,%al
 221:	7e ca                	jle    1ed <atoi+0xf>
  return n;
 223:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 226:	c9                   	leave  
 227:	c3                   	ret    

00000228 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 228:	55                   	push   %ebp
 229:	89 e5                	mov    %esp,%ebp
 22b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 22e:	8b 45 08             	mov    0x8(%ebp),%eax
 231:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 234:	8b 45 0c             	mov    0xc(%ebp),%eax
 237:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 23a:	eb 16                	jmp    252 <memmove+0x2a>
    *dst++ = *src++;
 23c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 23f:	8d 42 01             	lea    0x1(%edx),%eax
 242:	89 45 f8             	mov    %eax,-0x8(%ebp)
 245:	8b 45 fc             	mov    -0x4(%ebp),%eax
 248:	8d 48 01             	lea    0x1(%eax),%ecx
 24b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 24e:	8a 12                	mov    (%edx),%dl
 250:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 252:	8b 45 10             	mov    0x10(%ebp),%eax
 255:	8d 50 ff             	lea    -0x1(%eax),%edx
 258:	89 55 10             	mov    %edx,0x10(%ebp)
 25b:	85 c0                	test   %eax,%eax
 25d:	7f dd                	jg     23c <memmove+0x14>
  return vdst;
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 262:	c9                   	leave  
 263:	c3                   	ret    

00000264 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 264:	b8 01 00 00 00       	mov    $0x1,%eax
 269:	cd 40                	int    $0x40
 26b:	c3                   	ret    

0000026c <exit>:
SYSCALL(exit)
 26c:	b8 02 00 00 00       	mov    $0x2,%eax
 271:	cd 40                	int    $0x40
 273:	c3                   	ret    

00000274 <wait>:
SYSCALL(wait)
 274:	b8 03 00 00 00       	mov    $0x3,%eax
 279:	cd 40                	int    $0x40
 27b:	c3                   	ret    

0000027c <pipe>:
SYSCALL(pipe)
 27c:	b8 04 00 00 00       	mov    $0x4,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret    

00000284 <read>:
SYSCALL(read)
 284:	b8 05 00 00 00       	mov    $0x5,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <write>:
SYSCALL(write)
 28c:	b8 10 00 00 00       	mov    $0x10,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <close>:
SYSCALL(close)
 294:	b8 15 00 00 00       	mov    $0x15,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <kill>:
SYSCALL(kill)
 29c:	b8 06 00 00 00       	mov    $0x6,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <exec>:
SYSCALL(exec)
 2a4:	b8 07 00 00 00       	mov    $0x7,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <open>:
SYSCALL(open)
 2ac:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <mknod>:
SYSCALL(mknod)
 2b4:	b8 11 00 00 00       	mov    $0x11,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <unlink>:
SYSCALL(unlink)
 2bc:	b8 12 00 00 00       	mov    $0x12,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <fstat>:
SYSCALL(fstat)
 2c4:	b8 08 00 00 00       	mov    $0x8,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <link>:
SYSCALL(link)
 2cc:	b8 13 00 00 00       	mov    $0x13,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <mkdir>:
SYSCALL(mkdir)
 2d4:	b8 14 00 00 00       	mov    $0x14,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <chdir>:
SYSCALL(chdir)
 2dc:	b8 09 00 00 00       	mov    $0x9,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <dup>:
SYSCALL(dup)
 2e4:	b8 0a 00 00 00       	mov    $0xa,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <getpid>:
SYSCALL(getpid)
 2ec:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <sbrk>:
SYSCALL(sbrk)
 2f4:	b8 0c 00 00 00       	mov    $0xc,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <sleep>:
SYSCALL(sleep)
 2fc:	b8 0d 00 00 00       	mov    $0xd,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <uptime>:
SYSCALL(uptime)
 304:	b8 0e 00 00 00       	mov    $0xe,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 30c:	55                   	push   %ebp
 30d:	89 e5                	mov    %esp,%ebp
 30f:	83 ec 18             	sub    $0x18,%esp
 312:	8b 45 0c             	mov    0xc(%ebp),%eax
 315:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 318:	83 ec 04             	sub    $0x4,%esp
 31b:	6a 01                	push   $0x1
 31d:	8d 45 f4             	lea    -0xc(%ebp),%eax
 320:	50                   	push   %eax
 321:	ff 75 08             	pushl  0x8(%ebp)
 324:	e8 63 ff ff ff       	call   28c <write>
 329:	83 c4 10             	add    $0x10,%esp
}
 32c:	90                   	nop
 32d:	c9                   	leave  
 32e:	c3                   	ret    

0000032f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 32f:	55                   	push   %ebp
 330:	89 e5                	mov    %esp,%ebp
 332:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 335:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 33c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 340:	74 17                	je     359 <printint+0x2a>
 342:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 346:	79 11                	jns    359 <printint+0x2a>
    neg = 1;
 348:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 34f:	8b 45 0c             	mov    0xc(%ebp),%eax
 352:	f7 d8                	neg    %eax
 354:	89 45 ec             	mov    %eax,-0x14(%ebp)
 357:	eb 06                	jmp    35f <printint+0x30>
  } else {
    x = xx;
 359:	8b 45 0c             	mov    0xc(%ebp),%eax
 35c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 35f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 366:	8b 4d 10             	mov    0x10(%ebp),%ecx
 369:	8b 45 ec             	mov    -0x14(%ebp),%eax
 36c:	ba 00 00 00 00       	mov    $0x0,%edx
 371:	f7 f1                	div    %ecx
 373:	89 d1                	mov    %edx,%ecx
 375:	8b 45 f4             	mov    -0xc(%ebp),%eax
 378:	8d 50 01             	lea    0x1(%eax),%edx
 37b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 37e:	8a 91 94 07 00 00    	mov    0x794(%ecx),%dl
 384:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 388:	8b 4d 10             	mov    0x10(%ebp),%ecx
 38b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 38e:	ba 00 00 00 00       	mov    $0x0,%edx
 393:	f7 f1                	div    %ecx
 395:	89 45 ec             	mov    %eax,-0x14(%ebp)
 398:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 39c:	75 c8                	jne    366 <printint+0x37>
  if(neg)
 39e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3a2:	74 2c                	je     3d0 <printint+0xa1>
    buf[i++] = '-';
 3a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a7:	8d 50 01             	lea    0x1(%eax),%edx
 3aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3ad:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3b2:	eb 1c                	jmp    3d0 <printint+0xa1>
    putc(fd, buf[i]);
 3b4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ba:	01 d0                	add    %edx,%eax
 3bc:	8a 00                	mov    (%eax),%al
 3be:	0f be c0             	movsbl %al,%eax
 3c1:	83 ec 08             	sub    $0x8,%esp
 3c4:	50                   	push   %eax
 3c5:	ff 75 08             	pushl  0x8(%ebp)
 3c8:	e8 3f ff ff ff       	call   30c <putc>
 3cd:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 3d0:	ff 4d f4             	decl   -0xc(%ebp)
 3d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3d7:	79 db                	jns    3b4 <printint+0x85>
}
 3d9:	90                   	nop
 3da:	90                   	nop
 3db:	c9                   	leave  
 3dc:	c3                   	ret    

000003dd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3dd:	55                   	push   %ebp
 3de:	89 e5                	mov    %esp,%ebp
 3e0:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 3ea:	8d 45 0c             	lea    0xc(%ebp),%eax
 3ed:	83 c0 04             	add    $0x4,%eax
 3f0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 3f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3fa:	e9 54 01 00 00       	jmp    553 <printf+0x176>
    c = fmt[i] & 0xff;
 3ff:	8b 55 0c             	mov    0xc(%ebp),%edx
 402:	8b 45 f0             	mov    -0x10(%ebp),%eax
 405:	01 d0                	add    %edx,%eax
 407:	8a 00                	mov    (%eax),%al
 409:	0f be c0             	movsbl %al,%eax
 40c:	25 ff 00 00 00       	and    $0xff,%eax
 411:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 414:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 418:	75 2c                	jne    446 <printf+0x69>
      if(c == '%'){
 41a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 41e:	75 0c                	jne    42c <printf+0x4f>
        state = '%';
 420:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 427:	e9 24 01 00 00       	jmp    550 <printf+0x173>
      } else {
        putc(fd, c);
 42c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 42f:	0f be c0             	movsbl %al,%eax
 432:	83 ec 08             	sub    $0x8,%esp
 435:	50                   	push   %eax
 436:	ff 75 08             	pushl  0x8(%ebp)
 439:	e8 ce fe ff ff       	call   30c <putc>
 43e:	83 c4 10             	add    $0x10,%esp
 441:	e9 0a 01 00 00       	jmp    550 <printf+0x173>
      }
    } else if(state == '%'){
 446:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 44a:	0f 85 00 01 00 00    	jne    550 <printf+0x173>
      if(c == 'd'){
 450:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 454:	75 1e                	jne    474 <printf+0x97>
        printint(fd, *ap, 10, 1);
 456:	8b 45 e8             	mov    -0x18(%ebp),%eax
 459:	8b 00                	mov    (%eax),%eax
 45b:	6a 01                	push   $0x1
 45d:	6a 0a                	push   $0xa
 45f:	50                   	push   %eax
 460:	ff 75 08             	pushl  0x8(%ebp)
 463:	e8 c7 fe ff ff       	call   32f <printint>
 468:	83 c4 10             	add    $0x10,%esp
        ap++;
 46b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 46f:	e9 d5 00 00 00       	jmp    549 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 474:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 478:	74 06                	je     480 <printf+0xa3>
 47a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 47e:	75 1e                	jne    49e <printf+0xc1>
        printint(fd, *ap, 16, 0);
 480:	8b 45 e8             	mov    -0x18(%ebp),%eax
 483:	8b 00                	mov    (%eax),%eax
 485:	6a 00                	push   $0x0
 487:	6a 10                	push   $0x10
 489:	50                   	push   %eax
 48a:	ff 75 08             	pushl  0x8(%ebp)
 48d:	e8 9d fe ff ff       	call   32f <printint>
 492:	83 c4 10             	add    $0x10,%esp
        ap++;
 495:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 499:	e9 ab 00 00 00       	jmp    549 <printf+0x16c>
      } else if(c == 's'){
 49e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4a2:	75 40                	jne    4e4 <printf+0x107>
        s = (char*)*ap;
 4a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a7:	8b 00                	mov    (%eax),%eax
 4a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b4:	75 23                	jne    4d9 <printf+0xfc>
          s = "(null)";
 4b6:	c7 45 f4 8c 07 00 00 	movl   $0x78c,-0xc(%ebp)
        while(*s != 0){
 4bd:	eb 1a                	jmp    4d9 <printf+0xfc>
          putc(fd, *s);
 4bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c2:	8a 00                	mov    (%eax),%al
 4c4:	0f be c0             	movsbl %al,%eax
 4c7:	83 ec 08             	sub    $0x8,%esp
 4ca:	50                   	push   %eax
 4cb:	ff 75 08             	pushl  0x8(%ebp)
 4ce:	e8 39 fe ff ff       	call   30c <putc>
 4d3:	83 c4 10             	add    $0x10,%esp
          s++;
 4d6:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 4d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4dc:	8a 00                	mov    (%eax),%al
 4de:	84 c0                	test   %al,%al
 4e0:	75 dd                	jne    4bf <printf+0xe2>
 4e2:	eb 65                	jmp    549 <printf+0x16c>
        }
      } else if(c == 'c'){
 4e4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 4e8:	75 1d                	jne    507 <printf+0x12a>
        putc(fd, *ap);
 4ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ed:	8b 00                	mov    (%eax),%eax
 4ef:	0f be c0             	movsbl %al,%eax
 4f2:	83 ec 08             	sub    $0x8,%esp
 4f5:	50                   	push   %eax
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 0e fe ff ff       	call   30c <putc>
 4fe:	83 c4 10             	add    $0x10,%esp
        ap++;
 501:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 505:	eb 42                	jmp    549 <printf+0x16c>
      } else if(c == '%'){
 507:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 50b:	75 17                	jne    524 <printf+0x147>
        putc(fd, c);
 50d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 510:	0f be c0             	movsbl %al,%eax
 513:	83 ec 08             	sub    $0x8,%esp
 516:	50                   	push   %eax
 517:	ff 75 08             	pushl  0x8(%ebp)
 51a:	e8 ed fd ff ff       	call   30c <putc>
 51f:	83 c4 10             	add    $0x10,%esp
 522:	eb 25                	jmp    549 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 524:	83 ec 08             	sub    $0x8,%esp
 527:	6a 25                	push   $0x25
 529:	ff 75 08             	pushl  0x8(%ebp)
 52c:	e8 db fd ff ff       	call   30c <putc>
 531:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 534:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 537:	0f be c0             	movsbl %al,%eax
 53a:	83 ec 08             	sub    $0x8,%esp
 53d:	50                   	push   %eax
 53e:	ff 75 08             	pushl  0x8(%ebp)
 541:	e8 c6 fd ff ff       	call   30c <putc>
 546:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 549:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 550:	ff 45 f0             	incl   -0x10(%ebp)
 553:	8b 55 0c             	mov    0xc(%ebp),%edx
 556:	8b 45 f0             	mov    -0x10(%ebp),%eax
 559:	01 d0                	add    %edx,%eax
 55b:	8a 00                	mov    (%eax),%al
 55d:	84 c0                	test   %al,%al
 55f:	0f 85 9a fe ff ff    	jne    3ff <printf+0x22>
    }
  }
}
 565:	90                   	nop
 566:	90                   	nop
 567:	c9                   	leave  
 568:	c3                   	ret    

00000569 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 569:	55                   	push   %ebp
 56a:	89 e5                	mov    %esp,%ebp
 56c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 56f:	8b 45 08             	mov    0x8(%ebp),%eax
 572:	83 e8 08             	sub    $0x8,%eax
 575:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 578:	a1 b0 07 00 00       	mov    0x7b0,%eax
 57d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 580:	eb 24                	jmp    5a6 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 582:	8b 45 fc             	mov    -0x4(%ebp),%eax
 585:	8b 00                	mov    (%eax),%eax
 587:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 58a:	72 12                	jb     59e <free+0x35>
 58c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 58f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 592:	72 24                	jb     5b8 <free+0x4f>
 594:	8b 45 fc             	mov    -0x4(%ebp),%eax
 597:	8b 00                	mov    (%eax),%eax
 599:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 59c:	72 1a                	jb     5b8 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 59e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5a1:	8b 00                	mov    (%eax),%eax
 5a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5a9:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5ac:	73 d4                	jae    582 <free+0x19>
 5ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5b1:	8b 00                	mov    (%eax),%eax
 5b3:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5b6:	73 ca                	jae    582 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5bb:	8b 40 04             	mov    0x4(%eax),%eax
 5be:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c8:	01 c2                	add    %eax,%edx
 5ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cd:	8b 00                	mov    (%eax),%eax
 5cf:	39 c2                	cmp    %eax,%edx
 5d1:	75 24                	jne    5f7 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 5d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d6:	8b 50 04             	mov    0x4(%eax),%edx
 5d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5dc:	8b 00                	mov    (%eax),%eax
 5de:	8b 40 04             	mov    0x4(%eax),%eax
 5e1:	01 c2                	add    %eax,%edx
 5e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e6:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 5e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ec:	8b 00                	mov    (%eax),%eax
 5ee:	8b 10                	mov    (%eax),%edx
 5f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f3:	89 10                	mov    %edx,(%eax)
 5f5:	eb 0a                	jmp    601 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 5f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fa:	8b 10                	mov    (%eax),%edx
 5fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ff:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 601:	8b 45 fc             	mov    -0x4(%ebp),%eax
 604:	8b 40 04             	mov    0x4(%eax),%eax
 607:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 611:	01 d0                	add    %edx,%eax
 613:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 616:	75 20                	jne    638 <free+0xcf>
    p->s.size += bp->s.size;
 618:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61b:	8b 50 04             	mov    0x4(%eax),%edx
 61e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 621:	8b 40 04             	mov    0x4(%eax),%eax
 624:	01 c2                	add    %eax,%edx
 626:	8b 45 fc             	mov    -0x4(%ebp),%eax
 629:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 62c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62f:	8b 10                	mov    (%eax),%edx
 631:	8b 45 fc             	mov    -0x4(%ebp),%eax
 634:	89 10                	mov    %edx,(%eax)
 636:	eb 08                	jmp    640 <free+0xd7>
  } else
    p->s.ptr = bp;
 638:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 63e:	89 10                	mov    %edx,(%eax)
  freep = p;
 640:	8b 45 fc             	mov    -0x4(%ebp),%eax
 643:	a3 b0 07 00 00       	mov    %eax,0x7b0
}
 648:	90                   	nop
 649:	c9                   	leave  
 64a:	c3                   	ret    

0000064b <morecore>:

static Header*
morecore(uint nu)
{
 64b:	55                   	push   %ebp
 64c:	89 e5                	mov    %esp,%ebp
 64e:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 651:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 658:	77 07                	ja     661 <morecore+0x16>
    nu = 4096;
 65a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 661:	8b 45 08             	mov    0x8(%ebp),%eax
 664:	c1 e0 03             	shl    $0x3,%eax
 667:	83 ec 0c             	sub    $0xc,%esp
 66a:	50                   	push   %eax
 66b:	e8 84 fc ff ff       	call   2f4 <sbrk>
 670:	83 c4 10             	add    $0x10,%esp
 673:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 676:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 67a:	75 07                	jne    683 <morecore+0x38>
    return 0;
 67c:	b8 00 00 00 00       	mov    $0x0,%eax
 681:	eb 26                	jmp    6a9 <morecore+0x5e>
  hp = (Header*)p;
 683:	8b 45 f4             	mov    -0xc(%ebp),%eax
 686:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 689:	8b 45 f0             	mov    -0x10(%ebp),%eax
 68c:	8b 55 08             	mov    0x8(%ebp),%edx
 68f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 692:	8b 45 f0             	mov    -0x10(%ebp),%eax
 695:	83 c0 08             	add    $0x8,%eax
 698:	83 ec 0c             	sub    $0xc,%esp
 69b:	50                   	push   %eax
 69c:	e8 c8 fe ff ff       	call   569 <free>
 6a1:	83 c4 10             	add    $0x10,%esp
  return freep;
 6a4:	a1 b0 07 00 00       	mov    0x7b0,%eax
}
 6a9:	c9                   	leave  
 6aa:	c3                   	ret    

000006ab <malloc>:

void*
malloc(uint nbytes)
{
 6ab:	55                   	push   %ebp
 6ac:	89 e5                	mov    %esp,%ebp
 6ae:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b1:	8b 45 08             	mov    0x8(%ebp),%eax
 6b4:	83 c0 07             	add    $0x7,%eax
 6b7:	c1 e8 03             	shr    $0x3,%eax
 6ba:	40                   	inc    %eax
 6bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6be:	a1 b0 07 00 00       	mov    0x7b0,%eax
 6c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6c6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6ca:	75 23                	jne    6ef <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 6cc:	c7 45 f0 a8 07 00 00 	movl   $0x7a8,-0x10(%ebp)
 6d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d6:	a3 b0 07 00 00       	mov    %eax,0x7b0
 6db:	a1 b0 07 00 00       	mov    0x7b0,%eax
 6e0:	a3 a8 07 00 00       	mov    %eax,0x7a8
    base.s.size = 0;
 6e5:	c7 05 ac 07 00 00 00 	movl   $0x0,0x7ac
 6ec:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f2:	8b 00                	mov    (%eax),%eax
 6f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 6f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fa:	8b 40 04             	mov    0x4(%eax),%eax
 6fd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 700:	72 4d                	jb     74f <malloc+0xa4>
      if(p->s.size == nunits)
 702:	8b 45 f4             	mov    -0xc(%ebp),%eax
 705:	8b 40 04             	mov    0x4(%eax),%eax
 708:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 70b:	75 0c                	jne    719 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 70d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 710:	8b 10                	mov    (%eax),%edx
 712:	8b 45 f0             	mov    -0x10(%ebp),%eax
 715:	89 10                	mov    %edx,(%eax)
 717:	eb 26                	jmp    73f <malloc+0x94>
      else {
        p->s.size -= nunits;
 719:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71c:	8b 40 04             	mov    0x4(%eax),%eax
 71f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 722:	89 c2                	mov    %eax,%edx
 724:	8b 45 f4             	mov    -0xc(%ebp),%eax
 727:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 72a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72d:	8b 40 04             	mov    0x4(%eax),%eax
 730:	c1 e0 03             	shl    $0x3,%eax
 733:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 736:	8b 45 f4             	mov    -0xc(%ebp),%eax
 739:	8b 55 ec             	mov    -0x14(%ebp),%edx
 73c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 73f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 742:	a3 b0 07 00 00       	mov    %eax,0x7b0
      return (void*)(p + 1);
 747:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74a:	83 c0 08             	add    $0x8,%eax
 74d:	eb 3b                	jmp    78a <malloc+0xdf>
    }
    if(p == freep)
 74f:	a1 b0 07 00 00       	mov    0x7b0,%eax
 754:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 757:	75 1e                	jne    777 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 759:	83 ec 0c             	sub    $0xc,%esp
 75c:	ff 75 ec             	pushl  -0x14(%ebp)
 75f:	e8 e7 fe ff ff       	call   64b <morecore>
 764:	83 c4 10             	add    $0x10,%esp
 767:	89 45 f4             	mov    %eax,-0xc(%ebp)
 76a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 76e:	75 07                	jne    777 <malloc+0xcc>
        return 0;
 770:	b8 00 00 00 00       	mov    $0x0,%eax
 775:	eb 13                	jmp    78a <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 777:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	8b 00                	mov    (%eax),%eax
 782:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 785:	e9 6d ff ff ff       	jmp    6f7 <malloc+0x4c>
  }
}
 78a:	c9                   	leave  
 78b:	c3                   	ret    
