
_echo:     file format elf32-i386


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
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  for(i = 1; i < argc; i++)
  14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  1b:	eb 39                	jmp    56 <main+0x56>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  20:	40                   	inc    %eax
  21:	39 03                	cmp    %eax,(%ebx)
  23:	7e 07                	jle    2c <main+0x2c>
  25:	ba c2 07 00 00       	mov    $0x7c2,%edx
  2a:	eb 05                	jmp    31 <main+0x31>
  2c:	ba c4 07 00 00       	mov    $0x7c4,%edx
  31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  34:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  3b:	8b 43 04             	mov    0x4(%ebx),%eax
  3e:	01 c8                	add    %ecx,%eax
  40:	8b 00                	mov    (%eax),%eax
  42:	52                   	push   %edx
  43:	50                   	push   %eax
  44:	68 c6 07 00 00       	push   $0x7c6
  49:	6a 01                	push   $0x1
  4b:	e8 c3 03 00 00       	call   413 <printf>
  50:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++)
  53:	ff 45 f4             	incl   -0xc(%ebp)
  56:	8b 45 f4             	mov    -0xc(%ebp),%eax
  59:	3b 03                	cmp    (%ebx),%eax
  5b:	7c c0                	jl     1d <main+0x1d>
  exit();
  5d:	e8 40 02 00 00       	call   2a2 <exit>

00000062 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  62:	55                   	push   %ebp
  63:	89 e5                	mov    %esp,%ebp
  65:	57                   	push   %edi
  66:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  67:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6a:	8b 55 10             	mov    0x10(%ebp),%edx
  6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  70:	89 cb                	mov    %ecx,%ebx
  72:	89 df                	mov    %ebx,%edi
  74:	89 d1                	mov    %edx,%ecx
  76:	fc                   	cld    
  77:	f3 aa                	rep stos %al,%es:(%edi)
  79:	89 ca                	mov    %ecx,%edx
  7b:	89 fb                	mov    %edi,%ebx
  7d:	89 5d 08             	mov    %ebx,0x8(%ebp)
  80:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  83:	90                   	nop
  84:	5b                   	pop    %ebx
  85:	5f                   	pop    %edi
  86:	5d                   	pop    %ebp
  87:	c3                   	ret    

00000088 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  88:	55                   	push   %ebp
  89:	89 e5                	mov    %esp,%ebp
  8b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  8e:	8b 45 08             	mov    0x8(%ebp),%eax
  91:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  94:	90                   	nop
  95:	8b 55 0c             	mov    0xc(%ebp),%edx
  98:	8d 42 01             	lea    0x1(%edx),%eax
  9b:	89 45 0c             	mov    %eax,0xc(%ebp)
  9e:	8b 45 08             	mov    0x8(%ebp),%eax
  a1:	8d 48 01             	lea    0x1(%eax),%ecx
  a4:	89 4d 08             	mov    %ecx,0x8(%ebp)
  a7:	8a 12                	mov    (%edx),%dl
  a9:	88 10                	mov    %dl,(%eax)
  ab:	8a 00                	mov    (%eax),%al
  ad:	84 c0                	test   %al,%al
  af:	75 e4                	jne    95 <strcpy+0xd>
    ;
  return os;
  b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b4:	c9                   	leave  
  b5:	c3                   	ret    

000000b6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b6:	55                   	push   %ebp
  b7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  b9:	eb 06                	jmp    c1 <strcmp+0xb>
    p++, q++;
  bb:	ff 45 08             	incl   0x8(%ebp)
  be:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
  c1:	8b 45 08             	mov    0x8(%ebp),%eax
  c4:	8a 00                	mov    (%eax),%al
  c6:	84 c0                	test   %al,%al
  c8:	74 0e                	je     d8 <strcmp+0x22>
  ca:	8b 45 08             	mov    0x8(%ebp),%eax
  cd:	8a 10                	mov    (%eax),%dl
  cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  d2:	8a 00                	mov    (%eax),%al
  d4:	38 c2                	cmp    %al,%dl
  d6:	74 e3                	je     bb <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	8a 00                	mov    (%eax),%al
  dd:	0f b6 d0             	movzbl %al,%edx
  e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  e3:	8a 00                	mov    (%eax),%al
  e5:	0f b6 c0             	movzbl %al,%eax
  e8:	29 c2                	sub    %eax,%edx
  ea:	89 d0                	mov    %edx,%eax
}
  ec:	5d                   	pop    %ebp
  ed:	c3                   	ret    

000000ee <strlen>:

uint
strlen(char *s)
{
  ee:	55                   	push   %ebp
  ef:	89 e5                	mov    %esp,%ebp
  f1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  fb:	eb 03                	jmp    100 <strlen+0x12>
  fd:	ff 45 fc             	incl   -0x4(%ebp)
 100:	8b 55 fc             	mov    -0x4(%ebp),%edx
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	01 d0                	add    %edx,%eax
 108:	8a 00                	mov    (%eax),%al
 10a:	84 c0                	test   %al,%al
 10c:	75 ef                	jne    fd <strlen+0xf>
    ;
  return n;
 10e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 111:	c9                   	leave  
 112:	c3                   	ret    

00000113 <memset>:

void*
memset(void *dst, int c, uint n)
{
 113:	55                   	push   %ebp
 114:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 116:	8b 45 10             	mov    0x10(%ebp),%eax
 119:	50                   	push   %eax
 11a:	ff 75 0c             	pushl  0xc(%ebp)
 11d:	ff 75 08             	pushl  0x8(%ebp)
 120:	e8 3d ff ff ff       	call   62 <stosb>
 125:	83 c4 0c             	add    $0xc,%esp
  return dst;
 128:	8b 45 08             	mov    0x8(%ebp),%eax
}
 12b:	c9                   	leave  
 12c:	c3                   	ret    

0000012d <strchr>:

char*
strchr(const char *s, char c)
{
 12d:	55                   	push   %ebp
 12e:	89 e5                	mov    %esp,%ebp
 130:	83 ec 04             	sub    $0x4,%esp
 133:	8b 45 0c             	mov    0xc(%ebp),%eax
 136:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 139:	eb 12                	jmp    14d <strchr+0x20>
    if(*s == c)
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	8a 00                	mov    (%eax),%al
 140:	38 45 fc             	cmp    %al,-0x4(%ebp)
 143:	75 05                	jne    14a <strchr+0x1d>
      return (char*)s;
 145:	8b 45 08             	mov    0x8(%ebp),%eax
 148:	eb 11                	jmp    15b <strchr+0x2e>
  for(; *s; s++)
 14a:	ff 45 08             	incl   0x8(%ebp)
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	8a 00                	mov    (%eax),%al
 152:	84 c0                	test   %al,%al
 154:	75 e5                	jne    13b <strchr+0xe>
  return 0;
 156:	b8 00 00 00 00       	mov    $0x0,%eax
}
 15b:	c9                   	leave  
 15c:	c3                   	ret    

0000015d <gets>:

char*
gets(char *buf, int max)
{
 15d:	55                   	push   %ebp
 15e:	89 e5                	mov    %esp,%ebp
 160:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 163:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 16a:	eb 3f                	jmp    1ab <gets+0x4e>
    cc = read(0, &c, 1);
 16c:	83 ec 04             	sub    $0x4,%esp
 16f:	6a 01                	push   $0x1
 171:	8d 45 ef             	lea    -0x11(%ebp),%eax
 174:	50                   	push   %eax
 175:	6a 00                	push   $0x0
 177:	e8 3e 01 00 00       	call   2ba <read>
 17c:	83 c4 10             	add    $0x10,%esp
 17f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 182:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 186:	7e 2e                	jle    1b6 <gets+0x59>
      break;
    buf[i++] = c;
 188:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18b:	8d 50 01             	lea    0x1(%eax),%edx
 18e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 191:	89 c2                	mov    %eax,%edx
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	01 c2                	add    %eax,%edx
 198:	8a 45 ef             	mov    -0x11(%ebp),%al
 19b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 19d:	8a 45 ef             	mov    -0x11(%ebp),%al
 1a0:	3c 0a                	cmp    $0xa,%al
 1a2:	74 13                	je     1b7 <gets+0x5a>
 1a4:	8a 45 ef             	mov    -0x11(%ebp),%al
 1a7:	3c 0d                	cmp    $0xd,%al
 1a9:	74 0c                	je     1b7 <gets+0x5a>
  for(i=0; i+1 < max; ){
 1ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ae:	40                   	inc    %eax
 1af:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1b2:	7f b8                	jg     16c <gets+0xf>
 1b4:	eb 01                	jmp    1b7 <gets+0x5a>
      break;
 1b6:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	01 d0                	add    %edx,%eax
 1bf:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1c5:	c9                   	leave  
 1c6:	c3                   	ret    

000001c7 <stat>:

int
stat(char *n, struct stat *st)
{
 1c7:	55                   	push   %ebp
 1c8:	89 e5                	mov    %esp,%ebp
 1ca:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1cd:	83 ec 08             	sub    $0x8,%esp
 1d0:	6a 00                	push   $0x0
 1d2:	ff 75 08             	pushl  0x8(%ebp)
 1d5:	e8 08 01 00 00       	call   2e2 <open>
 1da:	83 c4 10             	add    $0x10,%esp
 1dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1e4:	79 07                	jns    1ed <stat+0x26>
    return -1;
 1e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1eb:	eb 25                	jmp    212 <stat+0x4b>
  r = fstat(fd, st);
 1ed:	83 ec 08             	sub    $0x8,%esp
 1f0:	ff 75 0c             	pushl  0xc(%ebp)
 1f3:	ff 75 f4             	pushl  -0xc(%ebp)
 1f6:	e8 ff 00 00 00       	call   2fa <fstat>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 201:	83 ec 0c             	sub    $0xc,%esp
 204:	ff 75 f4             	pushl  -0xc(%ebp)
 207:	e8 be 00 00 00       	call   2ca <close>
 20c:	83 c4 10             	add    $0x10,%esp
  return r;
 20f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 212:	c9                   	leave  
 213:	c3                   	ret    

00000214 <atoi>:

int
atoi(const char *s)
{
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 21a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 221:	eb 24                	jmp    247 <atoi+0x33>
    n = n*10 + *s++ - '0';
 223:	8b 55 fc             	mov    -0x4(%ebp),%edx
 226:	89 d0                	mov    %edx,%eax
 228:	c1 e0 02             	shl    $0x2,%eax
 22b:	01 d0                	add    %edx,%eax
 22d:	01 c0                	add    %eax,%eax
 22f:	89 c1                	mov    %eax,%ecx
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	8d 50 01             	lea    0x1(%eax),%edx
 237:	89 55 08             	mov    %edx,0x8(%ebp)
 23a:	8a 00                	mov    (%eax),%al
 23c:	0f be c0             	movsbl %al,%eax
 23f:	01 c8                	add    %ecx,%eax
 241:	83 e8 30             	sub    $0x30,%eax
 244:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	8a 00                	mov    (%eax),%al
 24c:	3c 2f                	cmp    $0x2f,%al
 24e:	7e 09                	jle    259 <atoi+0x45>
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	8a 00                	mov    (%eax),%al
 255:	3c 39                	cmp    $0x39,%al
 257:	7e ca                	jle    223 <atoi+0xf>
  return n;
 259:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 25c:	c9                   	leave  
 25d:	c3                   	ret    

0000025e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 25e:	55                   	push   %ebp
 25f:	89 e5                	mov    %esp,%ebp
 261:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 26a:	8b 45 0c             	mov    0xc(%ebp),%eax
 26d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 270:	eb 16                	jmp    288 <memmove+0x2a>
    *dst++ = *src++;
 272:	8b 55 f8             	mov    -0x8(%ebp),%edx
 275:	8d 42 01             	lea    0x1(%edx),%eax
 278:	89 45 f8             	mov    %eax,-0x8(%ebp)
 27b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 27e:	8d 48 01             	lea    0x1(%eax),%ecx
 281:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 284:	8a 12                	mov    (%edx),%dl
 286:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 288:	8b 45 10             	mov    0x10(%ebp),%eax
 28b:	8d 50 ff             	lea    -0x1(%eax),%edx
 28e:	89 55 10             	mov    %edx,0x10(%ebp)
 291:	85 c0                	test   %eax,%eax
 293:	7f dd                	jg     272 <memmove+0x14>
  return vdst;
 295:	8b 45 08             	mov    0x8(%ebp),%eax
}
 298:	c9                   	leave  
 299:	c3                   	ret    

0000029a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29a:	b8 01 00 00 00       	mov    $0x1,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <exit>:
SYSCALL(exit)
 2a2:	b8 02 00 00 00       	mov    $0x2,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <wait>:
SYSCALL(wait)
 2aa:	b8 03 00 00 00       	mov    $0x3,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <pipe>:
SYSCALL(pipe)
 2b2:	b8 04 00 00 00       	mov    $0x4,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <read>:
SYSCALL(read)
 2ba:	b8 05 00 00 00       	mov    $0x5,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <write>:
SYSCALL(write)
 2c2:	b8 10 00 00 00       	mov    $0x10,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <close>:
SYSCALL(close)
 2ca:	b8 15 00 00 00       	mov    $0x15,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <kill>:
SYSCALL(kill)
 2d2:	b8 06 00 00 00       	mov    $0x6,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <exec>:
SYSCALL(exec)
 2da:	b8 07 00 00 00       	mov    $0x7,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <open>:
SYSCALL(open)
 2e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mknod>:
SYSCALL(mknod)
 2ea:	b8 11 00 00 00       	mov    $0x11,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <unlink>:
SYSCALL(unlink)
 2f2:	b8 12 00 00 00       	mov    $0x12,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <fstat>:
SYSCALL(fstat)
 2fa:	b8 08 00 00 00       	mov    $0x8,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <link>:
SYSCALL(link)
 302:	b8 13 00 00 00       	mov    $0x13,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mkdir>:
SYSCALL(mkdir)
 30a:	b8 14 00 00 00       	mov    $0x14,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <chdir>:
SYSCALL(chdir)
 312:	b8 09 00 00 00       	mov    $0x9,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <dup>:
SYSCALL(dup)
 31a:	b8 0a 00 00 00       	mov    $0xa,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <getpid>:
SYSCALL(getpid)
 322:	b8 0b 00 00 00       	mov    $0xb,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <sbrk>:
SYSCALL(sbrk)
 32a:	b8 0c 00 00 00       	mov    $0xc,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <sleep>:
SYSCALL(sleep)
 332:	b8 0d 00 00 00       	mov    $0xd,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <uptime>:
SYSCALL(uptime)
 33a:	b8 0e 00 00 00       	mov    $0xe,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 342:	55                   	push   %ebp
 343:	89 e5                	mov    %esp,%ebp
 345:	83 ec 18             	sub    $0x18,%esp
 348:	8b 45 0c             	mov    0xc(%ebp),%eax
 34b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 34e:	83 ec 04             	sub    $0x4,%esp
 351:	6a 01                	push   $0x1
 353:	8d 45 f4             	lea    -0xc(%ebp),%eax
 356:	50                   	push   %eax
 357:	ff 75 08             	pushl  0x8(%ebp)
 35a:	e8 63 ff ff ff       	call   2c2 <write>
 35f:	83 c4 10             	add    $0x10,%esp
}
 362:	90                   	nop
 363:	c9                   	leave  
 364:	c3                   	ret    

00000365 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 365:	55                   	push   %ebp
 366:	89 e5                	mov    %esp,%ebp
 368:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 36b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 372:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 376:	74 17                	je     38f <printint+0x2a>
 378:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 37c:	79 11                	jns    38f <printint+0x2a>
    neg = 1;
 37e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 385:	8b 45 0c             	mov    0xc(%ebp),%eax
 388:	f7 d8                	neg    %eax
 38a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 38d:	eb 06                	jmp    395 <printint+0x30>
  } else {
    x = xx;
 38f:	8b 45 0c             	mov    0xc(%ebp),%eax
 392:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 395:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 39c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 39f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3a2:	ba 00 00 00 00       	mov    $0x0,%edx
 3a7:	f7 f1                	div    %ecx
 3a9:	89 d1                	mov    %edx,%ecx
 3ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ae:	8d 50 01             	lea    0x1(%eax),%edx
 3b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3b4:	8a 91 d4 07 00 00    	mov    0x7d4(%ecx),%dl
 3ba:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3be:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c4:	ba 00 00 00 00       	mov    $0x0,%edx
 3c9:	f7 f1                	div    %ecx
 3cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3d2:	75 c8                	jne    39c <printint+0x37>
  if(neg)
 3d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3d8:	74 2c                	je     406 <printint+0xa1>
    buf[i++] = '-';
 3da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3dd:	8d 50 01             	lea    0x1(%eax),%edx
 3e0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3e3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3e8:	eb 1c                	jmp    406 <printint+0xa1>
    putc(fd, buf[i]);
 3ea:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f0:	01 d0                	add    %edx,%eax
 3f2:	8a 00                	mov    (%eax),%al
 3f4:	0f be c0             	movsbl %al,%eax
 3f7:	83 ec 08             	sub    $0x8,%esp
 3fa:	50                   	push   %eax
 3fb:	ff 75 08             	pushl  0x8(%ebp)
 3fe:	e8 3f ff ff ff       	call   342 <putc>
 403:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 406:	ff 4d f4             	decl   -0xc(%ebp)
 409:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 40d:	79 db                	jns    3ea <printint+0x85>
}
 40f:	90                   	nop
 410:	90                   	nop
 411:	c9                   	leave  
 412:	c3                   	ret    

00000413 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 413:	55                   	push   %ebp
 414:	89 e5                	mov    %esp,%ebp
 416:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 419:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 420:	8d 45 0c             	lea    0xc(%ebp),%eax
 423:	83 c0 04             	add    $0x4,%eax
 426:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 429:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 430:	e9 54 01 00 00       	jmp    589 <printf+0x176>
    c = fmt[i] & 0xff;
 435:	8b 55 0c             	mov    0xc(%ebp),%edx
 438:	8b 45 f0             	mov    -0x10(%ebp),%eax
 43b:	01 d0                	add    %edx,%eax
 43d:	8a 00                	mov    (%eax),%al
 43f:	0f be c0             	movsbl %al,%eax
 442:	25 ff 00 00 00       	and    $0xff,%eax
 447:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 44a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 44e:	75 2c                	jne    47c <printf+0x69>
      if(c == '%'){
 450:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 454:	75 0c                	jne    462 <printf+0x4f>
        state = '%';
 456:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 45d:	e9 24 01 00 00       	jmp    586 <printf+0x173>
      } else {
        putc(fd, c);
 462:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 465:	0f be c0             	movsbl %al,%eax
 468:	83 ec 08             	sub    $0x8,%esp
 46b:	50                   	push   %eax
 46c:	ff 75 08             	pushl  0x8(%ebp)
 46f:	e8 ce fe ff ff       	call   342 <putc>
 474:	83 c4 10             	add    $0x10,%esp
 477:	e9 0a 01 00 00       	jmp    586 <printf+0x173>
      }
    } else if(state == '%'){
 47c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 480:	0f 85 00 01 00 00    	jne    586 <printf+0x173>
      if(c == 'd'){
 486:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 48a:	75 1e                	jne    4aa <printf+0x97>
        printint(fd, *ap, 10, 1);
 48c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 48f:	8b 00                	mov    (%eax),%eax
 491:	6a 01                	push   $0x1
 493:	6a 0a                	push   $0xa
 495:	50                   	push   %eax
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 c7 fe ff ff       	call   365 <printint>
 49e:	83 c4 10             	add    $0x10,%esp
        ap++;
 4a1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4a5:	e9 d5 00 00 00       	jmp    57f <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 4aa:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4ae:	74 06                	je     4b6 <printf+0xa3>
 4b0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4b4:	75 1e                	jne    4d4 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 4b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b9:	8b 00                	mov    (%eax),%eax
 4bb:	6a 00                	push   $0x0
 4bd:	6a 10                	push   $0x10
 4bf:	50                   	push   %eax
 4c0:	ff 75 08             	pushl  0x8(%ebp)
 4c3:	e8 9d fe ff ff       	call   365 <printint>
 4c8:	83 c4 10             	add    $0x10,%esp
        ap++;
 4cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4cf:	e9 ab 00 00 00       	jmp    57f <printf+0x16c>
      } else if(c == 's'){
 4d4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4d8:	75 40                	jne    51a <printf+0x107>
        s = (char*)*ap;
 4da:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4dd:	8b 00                	mov    (%eax),%eax
 4df:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ea:	75 23                	jne    50f <printf+0xfc>
          s = "(null)";
 4ec:	c7 45 f4 cb 07 00 00 	movl   $0x7cb,-0xc(%ebp)
        while(*s != 0){
 4f3:	eb 1a                	jmp    50f <printf+0xfc>
          putc(fd, *s);
 4f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f8:	8a 00                	mov    (%eax),%al
 4fa:	0f be c0             	movsbl %al,%eax
 4fd:	83 ec 08             	sub    $0x8,%esp
 500:	50                   	push   %eax
 501:	ff 75 08             	pushl  0x8(%ebp)
 504:	e8 39 fe ff ff       	call   342 <putc>
 509:	83 c4 10             	add    $0x10,%esp
          s++;
 50c:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 50f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 512:	8a 00                	mov    (%eax),%al
 514:	84 c0                	test   %al,%al
 516:	75 dd                	jne    4f5 <printf+0xe2>
 518:	eb 65                	jmp    57f <printf+0x16c>
        }
      } else if(c == 'c'){
 51a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 51e:	75 1d                	jne    53d <printf+0x12a>
        putc(fd, *ap);
 520:	8b 45 e8             	mov    -0x18(%ebp),%eax
 523:	8b 00                	mov    (%eax),%eax
 525:	0f be c0             	movsbl %al,%eax
 528:	83 ec 08             	sub    $0x8,%esp
 52b:	50                   	push   %eax
 52c:	ff 75 08             	pushl  0x8(%ebp)
 52f:	e8 0e fe ff ff       	call   342 <putc>
 534:	83 c4 10             	add    $0x10,%esp
        ap++;
 537:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53b:	eb 42                	jmp    57f <printf+0x16c>
      } else if(c == '%'){
 53d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 541:	75 17                	jne    55a <printf+0x147>
        putc(fd, c);
 543:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 546:	0f be c0             	movsbl %al,%eax
 549:	83 ec 08             	sub    $0x8,%esp
 54c:	50                   	push   %eax
 54d:	ff 75 08             	pushl  0x8(%ebp)
 550:	e8 ed fd ff ff       	call   342 <putc>
 555:	83 c4 10             	add    $0x10,%esp
 558:	eb 25                	jmp    57f <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 55a:	83 ec 08             	sub    $0x8,%esp
 55d:	6a 25                	push   $0x25
 55f:	ff 75 08             	pushl  0x8(%ebp)
 562:	e8 db fd ff ff       	call   342 <putc>
 567:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 56a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56d:	0f be c0             	movsbl %al,%eax
 570:	83 ec 08             	sub    $0x8,%esp
 573:	50                   	push   %eax
 574:	ff 75 08             	pushl  0x8(%ebp)
 577:	e8 c6 fd ff ff       	call   342 <putc>
 57c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 57f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 586:	ff 45 f0             	incl   -0x10(%ebp)
 589:	8b 55 0c             	mov    0xc(%ebp),%edx
 58c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 58f:	01 d0                	add    %edx,%eax
 591:	8a 00                	mov    (%eax),%al
 593:	84 c0                	test   %al,%al
 595:	0f 85 9a fe ff ff    	jne    435 <printf+0x22>
    }
  }
}
 59b:	90                   	nop
 59c:	90                   	nop
 59d:	c9                   	leave  
 59e:	c3                   	ret    

0000059f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 59f:	55                   	push   %ebp
 5a0:	89 e5                	mov    %esp,%ebp
 5a2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	83 e8 08             	sub    $0x8,%eax
 5ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ae:	a1 f0 07 00 00       	mov    0x7f0,%eax
 5b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5b6:	eb 24                	jmp    5dc <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5bb:	8b 00                	mov    (%eax),%eax
 5bd:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5c0:	72 12                	jb     5d4 <free+0x35>
 5c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c5:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5c8:	72 24                	jb     5ee <free+0x4f>
 5ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cd:	8b 00                	mov    (%eax),%eax
 5cf:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5d2:	72 1a                	jb     5ee <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d7:	8b 00                	mov    (%eax),%eax
 5d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5df:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5e2:	73 d4                	jae    5b8 <free+0x19>
 5e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e7:	8b 00                	mov    (%eax),%eax
 5e9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5ec:	73 ca                	jae    5b8 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f1:	8b 40 04             	mov    0x4(%eax),%eax
 5f4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fe:	01 c2                	add    %eax,%edx
 600:	8b 45 fc             	mov    -0x4(%ebp),%eax
 603:	8b 00                	mov    (%eax),%eax
 605:	39 c2                	cmp    %eax,%edx
 607:	75 24                	jne    62d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 609:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60c:	8b 50 04             	mov    0x4(%eax),%edx
 60f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 612:	8b 00                	mov    (%eax),%eax
 614:	8b 40 04             	mov    0x4(%eax),%eax
 617:	01 c2                	add    %eax,%edx
 619:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 61f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 622:	8b 00                	mov    (%eax),%eax
 624:	8b 10                	mov    (%eax),%edx
 626:	8b 45 f8             	mov    -0x8(%ebp),%eax
 629:	89 10                	mov    %edx,(%eax)
 62b:	eb 0a                	jmp    637 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 62d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 630:	8b 10                	mov    (%eax),%edx
 632:	8b 45 f8             	mov    -0x8(%ebp),%eax
 635:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 637:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63a:	8b 40 04             	mov    0x4(%eax),%eax
 63d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 644:	8b 45 fc             	mov    -0x4(%ebp),%eax
 647:	01 d0                	add    %edx,%eax
 649:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 64c:	75 20                	jne    66e <free+0xcf>
    p->s.size += bp->s.size;
 64e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 651:	8b 50 04             	mov    0x4(%eax),%edx
 654:	8b 45 f8             	mov    -0x8(%ebp),%eax
 657:	8b 40 04             	mov    0x4(%eax),%eax
 65a:	01 c2                	add    %eax,%edx
 65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 662:	8b 45 f8             	mov    -0x8(%ebp),%eax
 665:	8b 10                	mov    (%eax),%edx
 667:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66a:	89 10                	mov    %edx,(%eax)
 66c:	eb 08                	jmp    676 <free+0xd7>
  } else
    p->s.ptr = bp;
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	8b 55 f8             	mov    -0x8(%ebp),%edx
 674:	89 10                	mov    %edx,(%eax)
  freep = p;
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	a3 f0 07 00 00       	mov    %eax,0x7f0
}
 67e:	90                   	nop
 67f:	c9                   	leave  
 680:	c3                   	ret    

00000681 <morecore>:

static Header*
morecore(uint nu)
{
 681:	55                   	push   %ebp
 682:	89 e5                	mov    %esp,%ebp
 684:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 687:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 68e:	77 07                	ja     697 <morecore+0x16>
    nu = 4096;
 690:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 697:	8b 45 08             	mov    0x8(%ebp),%eax
 69a:	c1 e0 03             	shl    $0x3,%eax
 69d:	83 ec 0c             	sub    $0xc,%esp
 6a0:	50                   	push   %eax
 6a1:	e8 84 fc ff ff       	call   32a <sbrk>
 6a6:	83 c4 10             	add    $0x10,%esp
 6a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6ac:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6b0:	75 07                	jne    6b9 <morecore+0x38>
    return 0;
 6b2:	b8 00 00 00 00       	mov    $0x0,%eax
 6b7:	eb 26                	jmp    6df <morecore+0x5e>
  hp = (Header*)p;
 6b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c2:	8b 55 08             	mov    0x8(%ebp),%edx
 6c5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6cb:	83 c0 08             	add    $0x8,%eax
 6ce:	83 ec 0c             	sub    $0xc,%esp
 6d1:	50                   	push   %eax
 6d2:	e8 c8 fe ff ff       	call   59f <free>
 6d7:	83 c4 10             	add    $0x10,%esp
  return freep;
 6da:	a1 f0 07 00 00       	mov    0x7f0,%eax
}
 6df:	c9                   	leave  
 6e0:	c3                   	ret    

000006e1 <malloc>:

void*
malloc(uint nbytes)
{
 6e1:	55                   	push   %ebp
 6e2:	89 e5                	mov    %esp,%ebp
 6e4:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e7:	8b 45 08             	mov    0x8(%ebp),%eax
 6ea:	83 c0 07             	add    $0x7,%eax
 6ed:	c1 e8 03             	shr    $0x3,%eax
 6f0:	40                   	inc    %eax
 6f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6f4:	a1 f0 07 00 00       	mov    0x7f0,%eax
 6f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 700:	75 23                	jne    725 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 702:	c7 45 f0 e8 07 00 00 	movl   $0x7e8,-0x10(%ebp)
 709:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70c:	a3 f0 07 00 00       	mov    %eax,0x7f0
 711:	a1 f0 07 00 00       	mov    0x7f0,%eax
 716:	a3 e8 07 00 00       	mov    %eax,0x7e8
    base.s.size = 0;
 71b:	c7 05 ec 07 00 00 00 	movl   $0x0,0x7ec
 722:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 725:	8b 45 f0             	mov    -0x10(%ebp),%eax
 728:	8b 00                	mov    (%eax),%eax
 72a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	8b 40 04             	mov    0x4(%eax),%eax
 733:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 736:	72 4d                	jb     785 <malloc+0xa4>
      if(p->s.size == nunits)
 738:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 741:	75 0c                	jne    74f <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 743:	8b 45 f4             	mov    -0xc(%ebp),%eax
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74b:	89 10                	mov    %edx,(%eax)
 74d:	eb 26                	jmp    775 <malloc+0x94>
      else {
        p->s.size -= nunits;
 74f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 752:	8b 40 04             	mov    0x4(%eax),%eax
 755:	2b 45 ec             	sub    -0x14(%ebp),%eax
 758:	89 c2                	mov    %eax,%edx
 75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	8b 40 04             	mov    0x4(%eax),%eax
 766:	c1 e0 03             	shl    $0x3,%eax
 769:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 76c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 772:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 775:	8b 45 f0             	mov    -0x10(%ebp),%eax
 778:	a3 f0 07 00 00       	mov    %eax,0x7f0
      return (void*)(p + 1);
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	83 c0 08             	add    $0x8,%eax
 783:	eb 3b                	jmp    7c0 <malloc+0xdf>
    }
    if(p == freep)
 785:	a1 f0 07 00 00       	mov    0x7f0,%eax
 78a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 78d:	75 1e                	jne    7ad <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 78f:	83 ec 0c             	sub    $0xc,%esp
 792:	ff 75 ec             	pushl  -0x14(%ebp)
 795:	e8 e7 fe ff ff       	call   681 <morecore>
 79a:	83 c4 10             	add    $0x10,%esp
 79d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a4:	75 07                	jne    7ad <malloc+0xcc>
        return 0;
 7a6:	b8 00 00 00 00       	mov    $0x0,%eax
 7ab:	eb 13                	jmp    7c0 <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b6:	8b 00                	mov    (%eax),%eax
 7b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7bb:	e9 6d ff ff ff       	jmp    72d <malloc+0x4c>
  }
}
 7c0:	c9                   	leave  
 7c1:	c3                   	ret    
