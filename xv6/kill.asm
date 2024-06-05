
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "usage: kill pid...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 d1 07 00 00       	push   $0x7d1
  21:	6a 02                	push   $0x2
  23:	e8 fa 03 00 00       	call   422 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 81 02 00 00       	call   2b1 <exit>
  }
  for(i=1; i<argc; i++)
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 2c                	jmp    65 <main+0x65>
    kill(atoi(argv[i]));
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 d0 01 00 00       	call   223 <atoi>
  53:	83 c4 10             	add    $0x10,%esp
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	50                   	push   %eax
  5a:	e8 82 02 00 00       	call   2e1 <kill>
  5f:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
  62:	ff 45 f4             	incl   -0xc(%ebp)
  65:	8b 45 f4             	mov    -0xc(%ebp),%eax
  68:	3b 03                	cmp    (%ebx),%eax
  6a:	7c cd                	jl     39 <main+0x39>
  exit();
  6c:	e8 40 02 00 00       	call   2b1 <exit>

00000071 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  71:	55                   	push   %ebp
  72:	89 e5                	mov    %esp,%ebp
  74:	57                   	push   %edi
  75:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  79:	8b 55 10             	mov    0x10(%ebp),%edx
  7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  7f:	89 cb                	mov    %ecx,%ebx
  81:	89 df                	mov    %ebx,%edi
  83:	89 d1                	mov    %edx,%ecx
  85:	fc                   	cld    
  86:	f3 aa                	rep stos %al,%es:(%edi)
  88:	89 ca                	mov    %ecx,%edx
  8a:	89 fb                	mov    %edi,%ebx
  8c:	89 5d 08             	mov    %ebx,0x8(%ebp)
  8f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  92:	90                   	nop
  93:	5b                   	pop    %ebx
  94:	5f                   	pop    %edi
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    

00000097 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  97:	55                   	push   %ebp
  98:	89 e5                	mov    %esp,%ebp
  9a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9d:	8b 45 08             	mov    0x8(%ebp),%eax
  a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a3:	90                   	nop
  a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  a7:	8d 42 01             	lea    0x1(%edx),%eax
  aa:	89 45 0c             	mov    %eax,0xc(%ebp)
  ad:	8b 45 08             	mov    0x8(%ebp),%eax
  b0:	8d 48 01             	lea    0x1(%eax),%ecx
  b3:	89 4d 08             	mov    %ecx,0x8(%ebp)
  b6:	8a 12                	mov    (%edx),%dl
  b8:	88 10                	mov    %dl,(%eax)
  ba:	8a 00                	mov    (%eax),%al
  bc:	84 c0                	test   %al,%al
  be:	75 e4                	jne    a4 <strcpy+0xd>
    ;
  return os;
  c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c3:	c9                   	leave  
  c4:	c3                   	ret    

000000c5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c5:	55                   	push   %ebp
  c6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c8:	eb 06                	jmp    d0 <strcmp+0xb>
    p++, q++;
  ca:	ff 45 08             	incl   0x8(%ebp)
  cd:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
  d0:	8b 45 08             	mov    0x8(%ebp),%eax
  d3:	8a 00                	mov    (%eax),%al
  d5:	84 c0                	test   %al,%al
  d7:	74 0e                	je     e7 <strcmp+0x22>
  d9:	8b 45 08             	mov    0x8(%ebp),%eax
  dc:	8a 10                	mov    (%eax),%dl
  de:	8b 45 0c             	mov    0xc(%ebp),%eax
  e1:	8a 00                	mov    (%eax),%al
  e3:	38 c2                	cmp    %al,%dl
  e5:	74 e3                	je     ca <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  e7:	8b 45 08             	mov    0x8(%ebp),%eax
  ea:	8a 00                	mov    (%eax),%al
  ec:	0f b6 d0             	movzbl %al,%edx
  ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  f2:	8a 00                	mov    (%eax),%al
  f4:	0f b6 c0             	movzbl %al,%eax
  f7:	29 c2                	sub    %eax,%edx
  f9:	89 d0                	mov    %edx,%eax
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    

000000fd <strlen>:

uint
strlen(char *s)
{
  fd:	55                   	push   %ebp
  fe:	89 e5                	mov    %esp,%ebp
 100:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 103:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10a:	eb 03                	jmp    10f <strlen+0x12>
 10c:	ff 45 fc             	incl   -0x4(%ebp)
 10f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 112:	8b 45 08             	mov    0x8(%ebp),%eax
 115:	01 d0                	add    %edx,%eax
 117:	8a 00                	mov    (%eax),%al
 119:	84 c0                	test   %al,%al
 11b:	75 ef                	jne    10c <strlen+0xf>
    ;
  return n;
 11d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 120:	c9                   	leave  
 121:	c3                   	ret    

00000122 <memset>:

void*
memset(void *dst, int c, uint n)
{
 122:	55                   	push   %ebp
 123:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 125:	8b 45 10             	mov    0x10(%ebp),%eax
 128:	50                   	push   %eax
 129:	ff 75 0c             	pushl  0xc(%ebp)
 12c:	ff 75 08             	pushl  0x8(%ebp)
 12f:	e8 3d ff ff ff       	call   71 <stosb>
 134:	83 c4 0c             	add    $0xc,%esp
  return dst;
 137:	8b 45 08             	mov    0x8(%ebp),%eax
}
 13a:	c9                   	leave  
 13b:	c3                   	ret    

0000013c <strchr>:

char*
strchr(const char *s, char c)
{
 13c:	55                   	push   %ebp
 13d:	89 e5                	mov    %esp,%ebp
 13f:	83 ec 04             	sub    $0x4,%esp
 142:	8b 45 0c             	mov    0xc(%ebp),%eax
 145:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 148:	eb 12                	jmp    15c <strchr+0x20>
    if(*s == c)
 14a:	8b 45 08             	mov    0x8(%ebp),%eax
 14d:	8a 00                	mov    (%eax),%al
 14f:	38 45 fc             	cmp    %al,-0x4(%ebp)
 152:	75 05                	jne    159 <strchr+0x1d>
      return (char*)s;
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	eb 11                	jmp    16a <strchr+0x2e>
  for(; *s; s++)
 159:	ff 45 08             	incl   0x8(%ebp)
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	8a 00                	mov    (%eax),%al
 161:	84 c0                	test   %al,%al
 163:	75 e5                	jne    14a <strchr+0xe>
  return 0;
 165:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16a:	c9                   	leave  
 16b:	c3                   	ret    

0000016c <gets>:

char*
gets(char *buf, int max)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 172:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 179:	eb 3f                	jmp    1ba <gets+0x4e>
    cc = read(0, &c, 1);
 17b:	83 ec 04             	sub    $0x4,%esp
 17e:	6a 01                	push   $0x1
 180:	8d 45 ef             	lea    -0x11(%ebp),%eax
 183:	50                   	push   %eax
 184:	6a 00                	push   $0x0
 186:	e8 3e 01 00 00       	call   2c9 <read>
 18b:	83 c4 10             	add    $0x10,%esp
 18e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 191:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 195:	7e 2e                	jle    1c5 <gets+0x59>
      break;
    buf[i++] = c;
 197:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19a:	8d 50 01             	lea    0x1(%eax),%edx
 19d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a0:	89 c2                	mov    %eax,%edx
 1a2:	8b 45 08             	mov    0x8(%ebp),%eax
 1a5:	01 c2                	add    %eax,%edx
 1a7:	8a 45 ef             	mov    -0x11(%ebp),%al
 1aa:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ac:	8a 45 ef             	mov    -0x11(%ebp),%al
 1af:	3c 0a                	cmp    $0xa,%al
 1b1:	74 13                	je     1c6 <gets+0x5a>
 1b3:	8a 45 ef             	mov    -0x11(%ebp),%al
 1b6:	3c 0d                	cmp    $0xd,%al
 1b8:	74 0c                	je     1c6 <gets+0x5a>
  for(i=0; i+1 < max; ){
 1ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1bd:	40                   	inc    %eax
 1be:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1c1:	7f b8                	jg     17b <gets+0xf>
 1c3:	eb 01                	jmp    1c6 <gets+0x5a>
      break;
 1c5:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1c9:	8b 45 08             	mov    0x8(%ebp),%eax
 1cc:	01 d0                	add    %edx,%eax
 1ce:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d4:	c9                   	leave  
 1d5:	c3                   	ret    

000001d6 <stat>:

int
stat(char *n, struct stat *st)
{
 1d6:	55                   	push   %ebp
 1d7:	89 e5                	mov    %esp,%ebp
 1d9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1dc:	83 ec 08             	sub    $0x8,%esp
 1df:	6a 00                	push   $0x0
 1e1:	ff 75 08             	pushl  0x8(%ebp)
 1e4:	e8 08 01 00 00       	call   2f1 <open>
 1e9:	83 c4 10             	add    $0x10,%esp
 1ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1f3:	79 07                	jns    1fc <stat+0x26>
    return -1;
 1f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1fa:	eb 25                	jmp    221 <stat+0x4b>
  r = fstat(fd, st);
 1fc:	83 ec 08             	sub    $0x8,%esp
 1ff:	ff 75 0c             	pushl  0xc(%ebp)
 202:	ff 75 f4             	pushl  -0xc(%ebp)
 205:	e8 ff 00 00 00       	call   309 <fstat>
 20a:	83 c4 10             	add    $0x10,%esp
 20d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 210:	83 ec 0c             	sub    $0xc,%esp
 213:	ff 75 f4             	pushl  -0xc(%ebp)
 216:	e8 be 00 00 00       	call   2d9 <close>
 21b:	83 c4 10             	add    $0x10,%esp
  return r;
 21e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 221:	c9                   	leave  
 222:	c3                   	ret    

00000223 <atoi>:

int
atoi(const char *s)
{
 223:	55                   	push   %ebp
 224:	89 e5                	mov    %esp,%ebp
 226:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 229:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 230:	eb 24                	jmp    256 <atoi+0x33>
    n = n*10 + *s++ - '0';
 232:	8b 55 fc             	mov    -0x4(%ebp),%edx
 235:	89 d0                	mov    %edx,%eax
 237:	c1 e0 02             	shl    $0x2,%eax
 23a:	01 d0                	add    %edx,%eax
 23c:	01 c0                	add    %eax,%eax
 23e:	89 c1                	mov    %eax,%ecx
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	8d 50 01             	lea    0x1(%eax),%edx
 246:	89 55 08             	mov    %edx,0x8(%ebp)
 249:	8a 00                	mov    (%eax),%al
 24b:	0f be c0             	movsbl %al,%eax
 24e:	01 c8                	add    %ecx,%eax
 250:	83 e8 30             	sub    $0x30,%eax
 253:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	8a 00                	mov    (%eax),%al
 25b:	3c 2f                	cmp    $0x2f,%al
 25d:	7e 09                	jle    268 <atoi+0x45>
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
 262:	8a 00                	mov    (%eax),%al
 264:	3c 39                	cmp    $0x39,%al
 266:	7e ca                	jle    232 <atoi+0xf>
  return n;
 268:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 26b:	c9                   	leave  
 26c:	c3                   	ret    

0000026d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 26d:	55                   	push   %ebp
 26e:	89 e5                	mov    %esp,%ebp
 270:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 279:	8b 45 0c             	mov    0xc(%ebp),%eax
 27c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 27f:	eb 16                	jmp    297 <memmove+0x2a>
    *dst++ = *src++;
 281:	8b 55 f8             	mov    -0x8(%ebp),%edx
 284:	8d 42 01             	lea    0x1(%edx),%eax
 287:	89 45 f8             	mov    %eax,-0x8(%ebp)
 28a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 28d:	8d 48 01             	lea    0x1(%eax),%ecx
 290:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 293:	8a 12                	mov    (%edx),%dl
 295:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 297:	8b 45 10             	mov    0x10(%ebp),%eax
 29a:	8d 50 ff             	lea    -0x1(%eax),%edx
 29d:	89 55 10             	mov    %edx,0x10(%ebp)
 2a0:	85 c0                	test   %eax,%eax
 2a2:	7f dd                	jg     281 <memmove+0x14>
  return vdst;
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a7:	c9                   	leave  
 2a8:	c3                   	ret    

000002a9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2a9:	b8 01 00 00 00       	mov    $0x1,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <exit>:
SYSCALL(exit)
 2b1:	b8 02 00 00 00       	mov    $0x2,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <wait>:
SYSCALL(wait)
 2b9:	b8 03 00 00 00       	mov    $0x3,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <pipe>:
SYSCALL(pipe)
 2c1:	b8 04 00 00 00       	mov    $0x4,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <read>:
SYSCALL(read)
 2c9:	b8 05 00 00 00       	mov    $0x5,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <write>:
SYSCALL(write)
 2d1:	b8 10 00 00 00       	mov    $0x10,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <close>:
SYSCALL(close)
 2d9:	b8 15 00 00 00       	mov    $0x15,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <kill>:
SYSCALL(kill)
 2e1:	b8 06 00 00 00       	mov    $0x6,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <exec>:
SYSCALL(exec)
 2e9:	b8 07 00 00 00       	mov    $0x7,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <open>:
SYSCALL(open)
 2f1:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <mknod>:
SYSCALL(mknod)
 2f9:	b8 11 00 00 00       	mov    $0x11,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <unlink>:
SYSCALL(unlink)
 301:	b8 12 00 00 00       	mov    $0x12,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <fstat>:
SYSCALL(fstat)
 309:	b8 08 00 00 00       	mov    $0x8,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <link>:
SYSCALL(link)
 311:	b8 13 00 00 00       	mov    $0x13,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <mkdir>:
SYSCALL(mkdir)
 319:	b8 14 00 00 00       	mov    $0x14,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <chdir>:
SYSCALL(chdir)
 321:	b8 09 00 00 00       	mov    $0x9,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <dup>:
SYSCALL(dup)
 329:	b8 0a 00 00 00       	mov    $0xa,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <getpid>:
SYSCALL(getpid)
 331:	b8 0b 00 00 00       	mov    $0xb,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <sbrk>:
SYSCALL(sbrk)
 339:	b8 0c 00 00 00       	mov    $0xc,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <sleep>:
SYSCALL(sleep)
 341:	b8 0d 00 00 00       	mov    $0xd,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <uptime>:
SYSCALL(uptime)
 349:	b8 0e 00 00 00       	mov    $0xe,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 351:	55                   	push   %ebp
 352:	89 e5                	mov    %esp,%ebp
 354:	83 ec 18             	sub    $0x18,%esp
 357:	8b 45 0c             	mov    0xc(%ebp),%eax
 35a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 35d:	83 ec 04             	sub    $0x4,%esp
 360:	6a 01                	push   $0x1
 362:	8d 45 f4             	lea    -0xc(%ebp),%eax
 365:	50                   	push   %eax
 366:	ff 75 08             	pushl  0x8(%ebp)
 369:	e8 63 ff ff ff       	call   2d1 <write>
 36e:	83 c4 10             	add    $0x10,%esp
}
 371:	90                   	nop
 372:	c9                   	leave  
 373:	c3                   	ret    

00000374 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 374:	55                   	push   %ebp
 375:	89 e5                	mov    %esp,%ebp
 377:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 37a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 381:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 385:	74 17                	je     39e <printint+0x2a>
 387:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 38b:	79 11                	jns    39e <printint+0x2a>
    neg = 1;
 38d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 394:	8b 45 0c             	mov    0xc(%ebp),%eax
 397:	f7 d8                	neg    %eax
 399:	89 45 ec             	mov    %eax,-0x14(%ebp)
 39c:	eb 06                	jmp    3a4 <printint+0x30>
  } else {
    x = xx;
 39e:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b1:	ba 00 00 00 00       	mov    $0x0,%edx
 3b6:	f7 f1                	div    %ecx
 3b8:	89 d1                	mov    %edx,%ecx
 3ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3bd:	8d 50 01             	lea    0x1(%eax),%edx
 3c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3c3:	8a 91 ec 07 00 00    	mov    0x7ec(%ecx),%dl
 3c9:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3cd:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d3:	ba 00 00 00 00       	mov    $0x0,%edx
 3d8:	f7 f1                	div    %ecx
 3da:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3e1:	75 c8                	jne    3ab <printint+0x37>
  if(neg)
 3e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3e7:	74 2c                	je     415 <printint+0xa1>
    buf[i++] = '-';
 3e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ec:	8d 50 01             	lea    0x1(%eax),%edx
 3ef:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3f2:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3f7:	eb 1c                	jmp    415 <printint+0xa1>
    putc(fd, buf[i]);
 3f9:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ff:	01 d0                	add    %edx,%eax
 401:	8a 00                	mov    (%eax),%al
 403:	0f be c0             	movsbl %al,%eax
 406:	83 ec 08             	sub    $0x8,%esp
 409:	50                   	push   %eax
 40a:	ff 75 08             	pushl  0x8(%ebp)
 40d:	e8 3f ff ff ff       	call   351 <putc>
 412:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 415:	ff 4d f4             	decl   -0xc(%ebp)
 418:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 41c:	79 db                	jns    3f9 <printint+0x85>
}
 41e:	90                   	nop
 41f:	90                   	nop
 420:	c9                   	leave  
 421:	c3                   	ret    

00000422 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 422:	55                   	push   %ebp
 423:	89 e5                	mov    %esp,%ebp
 425:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 428:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 42f:	8d 45 0c             	lea    0xc(%ebp),%eax
 432:	83 c0 04             	add    $0x4,%eax
 435:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 438:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 43f:	e9 54 01 00 00       	jmp    598 <printf+0x176>
    c = fmt[i] & 0xff;
 444:	8b 55 0c             	mov    0xc(%ebp),%edx
 447:	8b 45 f0             	mov    -0x10(%ebp),%eax
 44a:	01 d0                	add    %edx,%eax
 44c:	8a 00                	mov    (%eax),%al
 44e:	0f be c0             	movsbl %al,%eax
 451:	25 ff 00 00 00       	and    $0xff,%eax
 456:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 459:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45d:	75 2c                	jne    48b <printf+0x69>
      if(c == '%'){
 45f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 463:	75 0c                	jne    471 <printf+0x4f>
        state = '%';
 465:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 46c:	e9 24 01 00 00       	jmp    595 <printf+0x173>
      } else {
        putc(fd, c);
 471:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 474:	0f be c0             	movsbl %al,%eax
 477:	83 ec 08             	sub    $0x8,%esp
 47a:	50                   	push   %eax
 47b:	ff 75 08             	pushl  0x8(%ebp)
 47e:	e8 ce fe ff ff       	call   351 <putc>
 483:	83 c4 10             	add    $0x10,%esp
 486:	e9 0a 01 00 00       	jmp    595 <printf+0x173>
      }
    } else if(state == '%'){
 48b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 48f:	0f 85 00 01 00 00    	jne    595 <printf+0x173>
      if(c == 'd'){
 495:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 499:	75 1e                	jne    4b9 <printf+0x97>
        printint(fd, *ap, 10, 1);
 49b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 49e:	8b 00                	mov    (%eax),%eax
 4a0:	6a 01                	push   $0x1
 4a2:	6a 0a                	push   $0xa
 4a4:	50                   	push   %eax
 4a5:	ff 75 08             	pushl  0x8(%ebp)
 4a8:	e8 c7 fe ff ff       	call   374 <printint>
 4ad:	83 c4 10             	add    $0x10,%esp
        ap++;
 4b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b4:	e9 d5 00 00 00       	jmp    58e <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 4b9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4bd:	74 06                	je     4c5 <printf+0xa3>
 4bf:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4c3:	75 1e                	jne    4e3 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 4c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c8:	8b 00                	mov    (%eax),%eax
 4ca:	6a 00                	push   $0x0
 4cc:	6a 10                	push   $0x10
 4ce:	50                   	push   %eax
 4cf:	ff 75 08             	pushl  0x8(%ebp)
 4d2:	e8 9d fe ff ff       	call   374 <printint>
 4d7:	83 c4 10             	add    $0x10,%esp
        ap++;
 4da:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4de:	e9 ab 00 00 00       	jmp    58e <printf+0x16c>
      } else if(c == 's'){
 4e3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4e7:	75 40                	jne    529 <printf+0x107>
        s = (char*)*ap;
 4e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ec:	8b 00                	mov    (%eax),%eax
 4ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4f1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f9:	75 23                	jne    51e <printf+0xfc>
          s = "(null)";
 4fb:	c7 45 f4 e5 07 00 00 	movl   $0x7e5,-0xc(%ebp)
        while(*s != 0){
 502:	eb 1a                	jmp    51e <printf+0xfc>
          putc(fd, *s);
 504:	8b 45 f4             	mov    -0xc(%ebp),%eax
 507:	8a 00                	mov    (%eax),%al
 509:	0f be c0             	movsbl %al,%eax
 50c:	83 ec 08             	sub    $0x8,%esp
 50f:	50                   	push   %eax
 510:	ff 75 08             	pushl  0x8(%ebp)
 513:	e8 39 fe ff ff       	call   351 <putc>
 518:	83 c4 10             	add    $0x10,%esp
          s++;
 51b:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 51e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 521:	8a 00                	mov    (%eax),%al
 523:	84 c0                	test   %al,%al
 525:	75 dd                	jne    504 <printf+0xe2>
 527:	eb 65                	jmp    58e <printf+0x16c>
        }
      } else if(c == 'c'){
 529:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 52d:	75 1d                	jne    54c <printf+0x12a>
        putc(fd, *ap);
 52f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 532:	8b 00                	mov    (%eax),%eax
 534:	0f be c0             	movsbl %al,%eax
 537:	83 ec 08             	sub    $0x8,%esp
 53a:	50                   	push   %eax
 53b:	ff 75 08             	pushl  0x8(%ebp)
 53e:	e8 0e fe ff ff       	call   351 <putc>
 543:	83 c4 10             	add    $0x10,%esp
        ap++;
 546:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54a:	eb 42                	jmp    58e <printf+0x16c>
      } else if(c == '%'){
 54c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 550:	75 17                	jne    569 <printf+0x147>
        putc(fd, c);
 552:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 555:	0f be c0             	movsbl %al,%eax
 558:	83 ec 08             	sub    $0x8,%esp
 55b:	50                   	push   %eax
 55c:	ff 75 08             	pushl  0x8(%ebp)
 55f:	e8 ed fd ff ff       	call   351 <putc>
 564:	83 c4 10             	add    $0x10,%esp
 567:	eb 25                	jmp    58e <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 569:	83 ec 08             	sub    $0x8,%esp
 56c:	6a 25                	push   $0x25
 56e:	ff 75 08             	pushl  0x8(%ebp)
 571:	e8 db fd ff ff       	call   351 <putc>
 576:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 579:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57c:	0f be c0             	movsbl %al,%eax
 57f:	83 ec 08             	sub    $0x8,%esp
 582:	50                   	push   %eax
 583:	ff 75 08             	pushl  0x8(%ebp)
 586:	e8 c6 fd ff ff       	call   351 <putc>
 58b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 58e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 595:	ff 45 f0             	incl   -0x10(%ebp)
 598:	8b 55 0c             	mov    0xc(%ebp),%edx
 59b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 59e:	01 d0                	add    %edx,%eax
 5a0:	8a 00                	mov    (%eax),%al
 5a2:	84 c0                	test   %al,%al
 5a4:	0f 85 9a fe ff ff    	jne    444 <printf+0x22>
    }
  }
}
 5aa:	90                   	nop
 5ab:	90                   	nop
 5ac:	c9                   	leave  
 5ad:	c3                   	ret    

000005ae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ae:	55                   	push   %ebp
 5af:	89 e5                	mov    %esp,%ebp
 5b1:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b4:	8b 45 08             	mov    0x8(%ebp),%eax
 5b7:	83 e8 08             	sub    $0x8,%eax
 5ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5bd:	a1 08 08 00 00       	mov    0x808,%eax
 5c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c5:	eb 24                	jmp    5eb <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ca:	8b 00                	mov    (%eax),%eax
 5cc:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5cf:	72 12                	jb     5e3 <free+0x35>
 5d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d4:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5d7:	72 24                	jb     5fd <free+0x4f>
 5d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5dc:	8b 00                	mov    (%eax),%eax
 5de:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5e1:	72 1a                	jb     5fd <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e6:	8b 00                	mov    (%eax),%eax
 5e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ee:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5f1:	73 d4                	jae    5c7 <free+0x19>
 5f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f6:	8b 00                	mov    (%eax),%eax
 5f8:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5fb:	73 ca                	jae    5c7 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 600:	8b 40 04             	mov    0x4(%eax),%eax
 603:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60d:	01 c2                	add    %eax,%edx
 60f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 612:	8b 00                	mov    (%eax),%eax
 614:	39 c2                	cmp    %eax,%edx
 616:	75 24                	jne    63c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 618:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61b:	8b 50 04             	mov    0x4(%eax),%edx
 61e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 621:	8b 00                	mov    (%eax),%eax
 623:	8b 40 04             	mov    0x4(%eax),%eax
 626:	01 c2                	add    %eax,%edx
 628:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 62e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 631:	8b 00                	mov    (%eax),%eax
 633:	8b 10                	mov    (%eax),%edx
 635:	8b 45 f8             	mov    -0x8(%ebp),%eax
 638:	89 10                	mov    %edx,(%eax)
 63a:	eb 0a                	jmp    646 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 63c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63f:	8b 10                	mov    (%eax),%edx
 641:	8b 45 f8             	mov    -0x8(%ebp),%eax
 644:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 646:	8b 45 fc             	mov    -0x4(%ebp),%eax
 649:	8b 40 04             	mov    0x4(%eax),%eax
 64c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	01 d0                	add    %edx,%eax
 658:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 65b:	75 20                	jne    67d <free+0xcf>
    p->s.size += bp->s.size;
 65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 660:	8b 50 04             	mov    0x4(%eax),%edx
 663:	8b 45 f8             	mov    -0x8(%ebp),%eax
 666:	8b 40 04             	mov    0x4(%eax),%eax
 669:	01 c2                	add    %eax,%edx
 66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 671:	8b 45 f8             	mov    -0x8(%ebp),%eax
 674:	8b 10                	mov    (%eax),%edx
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	89 10                	mov    %edx,(%eax)
 67b:	eb 08                	jmp    685 <free+0xd7>
  } else
    p->s.ptr = bp;
 67d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 680:	8b 55 f8             	mov    -0x8(%ebp),%edx
 683:	89 10                	mov    %edx,(%eax)
  freep = p;
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	a3 08 08 00 00       	mov    %eax,0x808
}
 68d:	90                   	nop
 68e:	c9                   	leave  
 68f:	c3                   	ret    

00000690 <morecore>:

static Header*
morecore(uint nu)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 696:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 69d:	77 07                	ja     6a6 <morecore+0x16>
    nu = 4096;
 69f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6a6:	8b 45 08             	mov    0x8(%ebp),%eax
 6a9:	c1 e0 03             	shl    $0x3,%eax
 6ac:	83 ec 0c             	sub    $0xc,%esp
 6af:	50                   	push   %eax
 6b0:	e8 84 fc ff ff       	call   339 <sbrk>
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6bb:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6bf:	75 07                	jne    6c8 <morecore+0x38>
    return 0;
 6c1:	b8 00 00 00 00       	mov    $0x0,%eax
 6c6:	eb 26                	jmp    6ee <morecore+0x5e>
  hp = (Header*)p;
 6c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d1:	8b 55 08             	mov    0x8(%ebp),%edx
 6d4:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6da:	83 c0 08             	add    $0x8,%eax
 6dd:	83 ec 0c             	sub    $0xc,%esp
 6e0:	50                   	push   %eax
 6e1:	e8 c8 fe ff ff       	call   5ae <free>
 6e6:	83 c4 10             	add    $0x10,%esp
  return freep;
 6e9:	a1 08 08 00 00       	mov    0x808,%eax
}
 6ee:	c9                   	leave  
 6ef:	c3                   	ret    

000006f0 <malloc>:

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f6:	8b 45 08             	mov    0x8(%ebp),%eax
 6f9:	83 c0 07             	add    $0x7,%eax
 6fc:	c1 e8 03             	shr    $0x3,%eax
 6ff:	40                   	inc    %eax
 700:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 703:	a1 08 08 00 00       	mov    0x808,%eax
 708:	89 45 f0             	mov    %eax,-0x10(%ebp)
 70b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 70f:	75 23                	jne    734 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 711:	c7 45 f0 00 08 00 00 	movl   $0x800,-0x10(%ebp)
 718:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71b:	a3 08 08 00 00       	mov    %eax,0x808
 720:	a1 08 08 00 00       	mov    0x808,%eax
 725:	a3 00 08 00 00       	mov    %eax,0x800
    base.s.size = 0;
 72a:	c7 05 04 08 00 00 00 	movl   $0x0,0x804
 731:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 734:	8b 45 f0             	mov    -0x10(%ebp),%eax
 737:	8b 00                	mov    (%eax),%eax
 739:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 73c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73f:	8b 40 04             	mov    0x4(%eax),%eax
 742:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 745:	72 4d                	jb     794 <malloc+0xa4>
      if(p->s.size == nunits)
 747:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74a:	8b 40 04             	mov    0x4(%eax),%eax
 74d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 750:	75 0c                	jne    75e <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 752:	8b 45 f4             	mov    -0xc(%ebp),%eax
 755:	8b 10                	mov    (%eax),%edx
 757:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75a:	89 10                	mov    %edx,(%eax)
 75c:	eb 26                	jmp    784 <malloc+0x94>
      else {
        p->s.size -= nunits;
 75e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 761:	8b 40 04             	mov    0x4(%eax),%eax
 764:	2b 45 ec             	sub    -0x14(%ebp),%eax
 767:	89 c2                	mov    %eax,%edx
 769:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	8b 40 04             	mov    0x4(%eax),%eax
 775:	c1 e0 03             	shl    $0x3,%eax
 778:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 77b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 781:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 784:	8b 45 f0             	mov    -0x10(%ebp),%eax
 787:	a3 08 08 00 00       	mov    %eax,0x808
      return (void*)(p + 1);
 78c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78f:	83 c0 08             	add    $0x8,%eax
 792:	eb 3b                	jmp    7cf <malloc+0xdf>
    }
    if(p == freep)
 794:	a1 08 08 00 00       	mov    0x808,%eax
 799:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 79c:	75 1e                	jne    7bc <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 79e:	83 ec 0c             	sub    $0xc,%esp
 7a1:	ff 75 ec             	pushl  -0x14(%ebp)
 7a4:	e8 e7 fe ff ff       	call   690 <morecore>
 7a9:	83 c4 10             	add    $0x10,%esp
 7ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b3:	75 07                	jne    7bc <malloc+0xcc>
        return 0;
 7b5:	b8 00 00 00 00       	mov    $0x0,%eax
 7ba:	eb 13                	jmp    7cf <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ca:	e9 6d ff ff ff       	jmp    73c <malloc+0x4c>
  }
}
 7cf:	c9                   	leave  
 7d0:	c3                   	ret    
