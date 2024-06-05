
_mkdir:     file format elf32-i386


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

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: mkdir files...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 ef 07 00 00       	push   $0x7ef
  21:	6a 02                	push   $0x2
  23:	e8 18 04 00 00       	call   440 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 9f 02 00 00       	call   2cf <exit>
  }

  for(i = 1; i < argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 4a                	jmp    83 <main+0x83>
    if(mkdir(argv[i]) < 0){
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 e4 02 00 00       	call   337 <mkdir>
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	79 26                	jns    80 <main+0x80>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  64:	8b 43 04             	mov    0x4(%ebx),%eax
  67:	01 d0                	add    %edx,%eax
  69:	8b 00                	mov    (%eax),%eax
  6b:	83 ec 04             	sub    $0x4,%esp
  6e:	50                   	push   %eax
  6f:	68 06 08 00 00       	push   $0x806
  74:	6a 02                	push   $0x2
  76:	e8 c5 03 00 00       	call   440 <printf>
  7b:	83 c4 10             	add    $0x10,%esp
      break;
  7e:	eb 0a                	jmp    8a <main+0x8a>
  for(i = 1; i < argc; i++){
  80:	ff 45 f4             	incl   -0xc(%ebp)
  83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  86:	3b 03                	cmp    (%ebx),%eax
  88:	7c af                	jl     39 <main+0x39>
    }
  }

  exit();
  8a:	e8 40 02 00 00       	call   2cf <exit>

0000008f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  8f:	55                   	push   %ebp
  90:	89 e5                	mov    %esp,%ebp
  92:	57                   	push   %edi
  93:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  94:	8b 4d 08             	mov    0x8(%ebp),%ecx
  97:	8b 55 10             	mov    0x10(%ebp),%edx
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	89 cb                	mov    %ecx,%ebx
  9f:	89 df                	mov    %ebx,%edi
  a1:	89 d1                	mov    %edx,%ecx
  a3:	fc                   	cld    
  a4:	f3 aa                	rep stos %al,%es:(%edi)
  a6:	89 ca                	mov    %ecx,%edx
  a8:	89 fb                	mov    %edi,%ebx
  aa:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ad:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b0:	90                   	nop
  b1:	5b                   	pop    %ebx
  b2:	5f                   	pop    %edi
  b3:	5d                   	pop    %ebp
  b4:	c3                   	ret    

000000b5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b5:	55                   	push   %ebp
  b6:	89 e5                	mov    %esp,%ebp
  b8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  bb:	8b 45 08             	mov    0x8(%ebp),%eax
  be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c1:	90                   	nop
  c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  c5:	8d 42 01             	lea    0x1(%edx),%eax
  c8:	89 45 0c             	mov    %eax,0xc(%ebp)
  cb:	8b 45 08             	mov    0x8(%ebp),%eax
  ce:	8d 48 01             	lea    0x1(%eax),%ecx
  d1:	89 4d 08             	mov    %ecx,0x8(%ebp)
  d4:	8a 12                	mov    (%edx),%dl
  d6:	88 10                	mov    %dl,(%eax)
  d8:	8a 00                	mov    (%eax),%al
  da:	84 c0                	test   %al,%al
  dc:	75 e4                	jne    c2 <strcpy+0xd>
    ;
  return os;
  de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e1:	c9                   	leave  
  e2:	c3                   	ret    

000000e3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e6:	eb 06                	jmp    ee <strcmp+0xb>
    p++, q++;
  e8:	ff 45 08             	incl   0x8(%ebp)
  eb:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
  ee:	8b 45 08             	mov    0x8(%ebp),%eax
  f1:	8a 00                	mov    (%eax),%al
  f3:	84 c0                	test   %al,%al
  f5:	74 0e                	je     105 <strcmp+0x22>
  f7:	8b 45 08             	mov    0x8(%ebp),%eax
  fa:	8a 10                	mov    (%eax),%dl
  fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  ff:	8a 00                	mov    (%eax),%al
 101:	38 c2                	cmp    %al,%dl
 103:	74 e3                	je     e8 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 105:	8b 45 08             	mov    0x8(%ebp),%eax
 108:	8a 00                	mov    (%eax),%al
 10a:	0f b6 d0             	movzbl %al,%edx
 10d:	8b 45 0c             	mov    0xc(%ebp),%eax
 110:	8a 00                	mov    (%eax),%al
 112:	0f b6 c0             	movzbl %al,%eax
 115:	29 c2                	sub    %eax,%edx
 117:	89 d0                	mov    %edx,%eax
}
 119:	5d                   	pop    %ebp
 11a:	c3                   	ret    

0000011b <strlen>:

uint
strlen(char *s)
{
 11b:	55                   	push   %ebp
 11c:	89 e5                	mov    %esp,%ebp
 11e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 121:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 128:	eb 03                	jmp    12d <strlen+0x12>
 12a:	ff 45 fc             	incl   -0x4(%ebp)
 12d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 130:	8b 45 08             	mov    0x8(%ebp),%eax
 133:	01 d0                	add    %edx,%eax
 135:	8a 00                	mov    (%eax),%al
 137:	84 c0                	test   %al,%al
 139:	75 ef                	jne    12a <strlen+0xf>
    ;
  return n;
 13b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 13e:	c9                   	leave  
 13f:	c3                   	ret    

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 143:	8b 45 10             	mov    0x10(%ebp),%eax
 146:	50                   	push   %eax
 147:	ff 75 0c             	pushl  0xc(%ebp)
 14a:	ff 75 08             	pushl  0x8(%ebp)
 14d:	e8 3d ff ff ff       	call   8f <stosb>
 152:	83 c4 0c             	add    $0xc,%esp
  return dst;
 155:	8b 45 08             	mov    0x8(%ebp),%eax
}
 158:	c9                   	leave  
 159:	c3                   	ret    

0000015a <strchr>:

char*
strchr(const char *s, char c)
{
 15a:	55                   	push   %ebp
 15b:	89 e5                	mov    %esp,%ebp
 15d:	83 ec 04             	sub    $0x4,%esp
 160:	8b 45 0c             	mov    0xc(%ebp),%eax
 163:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 166:	eb 12                	jmp    17a <strchr+0x20>
    if(*s == c)
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	8a 00                	mov    (%eax),%al
 16d:	38 45 fc             	cmp    %al,-0x4(%ebp)
 170:	75 05                	jne    177 <strchr+0x1d>
      return (char*)s;
 172:	8b 45 08             	mov    0x8(%ebp),%eax
 175:	eb 11                	jmp    188 <strchr+0x2e>
  for(; *s; s++)
 177:	ff 45 08             	incl   0x8(%ebp)
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	8a 00                	mov    (%eax),%al
 17f:	84 c0                	test   %al,%al
 181:	75 e5                	jne    168 <strchr+0xe>
  return 0;
 183:	b8 00 00 00 00       	mov    $0x0,%eax
}
 188:	c9                   	leave  
 189:	c3                   	ret    

0000018a <gets>:

char*
gets(char *buf, int max)
{
 18a:	55                   	push   %ebp
 18b:	89 e5                	mov    %esp,%ebp
 18d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 190:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 197:	eb 3f                	jmp    1d8 <gets+0x4e>
    cc = read(0, &c, 1);
 199:	83 ec 04             	sub    $0x4,%esp
 19c:	6a 01                	push   $0x1
 19e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a1:	50                   	push   %eax
 1a2:	6a 00                	push   $0x0
 1a4:	e8 3e 01 00 00       	call   2e7 <read>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1b3:	7e 2e                	jle    1e3 <gets+0x59>
      break;
    buf[i++] = c;
 1b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b8:	8d 50 01             	lea    0x1(%eax),%edx
 1bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1be:	89 c2                	mov    %eax,%edx
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	01 c2                	add    %eax,%edx
 1c5:	8a 45 ef             	mov    -0x11(%ebp),%al
 1c8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ca:	8a 45 ef             	mov    -0x11(%ebp),%al
 1cd:	3c 0a                	cmp    $0xa,%al
 1cf:	74 13                	je     1e4 <gets+0x5a>
 1d1:	8a 45 ef             	mov    -0x11(%ebp),%al
 1d4:	3c 0d                	cmp    $0xd,%al
 1d6:	74 0c                	je     1e4 <gets+0x5a>
  for(i=0; i+1 < max; ){
 1d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1db:	40                   	inc    %eax
 1dc:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1df:	7f b8                	jg     199 <gets+0xf>
 1e1:	eb 01                	jmp    1e4 <gets+0x5a>
      break;
 1e3:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ea:	01 d0                	add    %edx,%eax
 1ec:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f2:	c9                   	leave  
 1f3:	c3                   	ret    

000001f4 <stat>:

int
stat(char *n, struct stat *st)
{
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fa:	83 ec 08             	sub    $0x8,%esp
 1fd:	6a 00                	push   $0x0
 1ff:	ff 75 08             	pushl  0x8(%ebp)
 202:	e8 08 01 00 00       	call   30f <open>
 207:	83 c4 10             	add    $0x10,%esp
 20a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 20d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 211:	79 07                	jns    21a <stat+0x26>
    return -1;
 213:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 218:	eb 25                	jmp    23f <stat+0x4b>
  r = fstat(fd, st);
 21a:	83 ec 08             	sub    $0x8,%esp
 21d:	ff 75 0c             	pushl  0xc(%ebp)
 220:	ff 75 f4             	pushl  -0xc(%ebp)
 223:	e8 ff 00 00 00       	call   327 <fstat>
 228:	83 c4 10             	add    $0x10,%esp
 22b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22e:	83 ec 0c             	sub    $0xc,%esp
 231:	ff 75 f4             	pushl  -0xc(%ebp)
 234:	e8 be 00 00 00       	call   2f7 <close>
 239:	83 c4 10             	add    $0x10,%esp
  return r;
 23c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 23f:	c9                   	leave  
 240:	c3                   	ret    

00000241 <atoi>:

int
atoi(const char *s)
{
 241:	55                   	push   %ebp
 242:	89 e5                	mov    %esp,%ebp
 244:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 247:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24e:	eb 24                	jmp    274 <atoi+0x33>
    n = n*10 + *s++ - '0';
 250:	8b 55 fc             	mov    -0x4(%ebp),%edx
 253:	89 d0                	mov    %edx,%eax
 255:	c1 e0 02             	shl    $0x2,%eax
 258:	01 d0                	add    %edx,%eax
 25a:	01 c0                	add    %eax,%eax
 25c:	89 c1                	mov    %eax,%ecx
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	8d 50 01             	lea    0x1(%eax),%edx
 264:	89 55 08             	mov    %edx,0x8(%ebp)
 267:	8a 00                	mov    (%eax),%al
 269:	0f be c0             	movsbl %al,%eax
 26c:	01 c8                	add    %ecx,%eax
 26e:	83 e8 30             	sub    $0x30,%eax
 271:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	8a 00                	mov    (%eax),%al
 279:	3c 2f                	cmp    $0x2f,%al
 27b:	7e 09                	jle    286 <atoi+0x45>
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	8a 00                	mov    (%eax),%al
 282:	3c 39                	cmp    $0x39,%al
 284:	7e ca                	jle    250 <atoi+0xf>
  return n;
 286:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 297:	8b 45 0c             	mov    0xc(%ebp),%eax
 29a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 29d:	eb 16                	jmp    2b5 <memmove+0x2a>
    *dst++ = *src++;
 29f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2a2:	8d 42 01             	lea    0x1(%edx),%eax
 2a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2ab:	8d 48 01             	lea    0x1(%eax),%ecx
 2ae:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2b1:	8a 12                	mov    (%edx),%dl
 2b3:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2b5:	8b 45 10             	mov    0x10(%ebp),%eax
 2b8:	8d 50 ff             	lea    -0x1(%eax),%edx
 2bb:	89 55 10             	mov    %edx,0x10(%ebp)
 2be:	85 c0                	test   %eax,%eax
 2c0:	7f dd                	jg     29f <memmove+0x14>
  return vdst;
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c5:	c9                   	leave  
 2c6:	c3                   	ret    

000002c7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c7:	b8 01 00 00 00       	mov    $0x1,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <exit>:
SYSCALL(exit)
 2cf:	b8 02 00 00 00       	mov    $0x2,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <wait>:
SYSCALL(wait)
 2d7:	b8 03 00 00 00       	mov    $0x3,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <pipe>:
SYSCALL(pipe)
 2df:	b8 04 00 00 00       	mov    $0x4,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <read>:
SYSCALL(read)
 2e7:	b8 05 00 00 00       	mov    $0x5,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <write>:
SYSCALL(write)
 2ef:	b8 10 00 00 00       	mov    $0x10,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <close>:
SYSCALL(close)
 2f7:	b8 15 00 00 00       	mov    $0x15,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <kill>:
SYSCALL(kill)
 2ff:	b8 06 00 00 00       	mov    $0x6,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <exec>:
SYSCALL(exec)
 307:	b8 07 00 00 00       	mov    $0x7,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <open>:
SYSCALL(open)
 30f:	b8 0f 00 00 00       	mov    $0xf,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <mknod>:
SYSCALL(mknod)
 317:	b8 11 00 00 00       	mov    $0x11,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <unlink>:
SYSCALL(unlink)
 31f:	b8 12 00 00 00       	mov    $0x12,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <fstat>:
SYSCALL(fstat)
 327:	b8 08 00 00 00       	mov    $0x8,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <link>:
SYSCALL(link)
 32f:	b8 13 00 00 00       	mov    $0x13,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <mkdir>:
SYSCALL(mkdir)
 337:	b8 14 00 00 00       	mov    $0x14,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <chdir>:
SYSCALL(chdir)
 33f:	b8 09 00 00 00       	mov    $0x9,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <dup>:
SYSCALL(dup)
 347:	b8 0a 00 00 00       	mov    $0xa,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <getpid>:
SYSCALL(getpid)
 34f:	b8 0b 00 00 00       	mov    $0xb,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <sbrk>:
SYSCALL(sbrk)
 357:	b8 0c 00 00 00       	mov    $0xc,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <sleep>:
SYSCALL(sleep)
 35f:	b8 0d 00 00 00       	mov    $0xd,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <uptime>:
SYSCALL(uptime)
 367:	b8 0e 00 00 00       	mov    $0xe,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 36f:	55                   	push   %ebp
 370:	89 e5                	mov    %esp,%ebp
 372:	83 ec 18             	sub    $0x18,%esp
 375:	8b 45 0c             	mov    0xc(%ebp),%eax
 378:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 37b:	83 ec 04             	sub    $0x4,%esp
 37e:	6a 01                	push   $0x1
 380:	8d 45 f4             	lea    -0xc(%ebp),%eax
 383:	50                   	push   %eax
 384:	ff 75 08             	pushl  0x8(%ebp)
 387:	e8 63 ff ff ff       	call   2ef <write>
 38c:	83 c4 10             	add    $0x10,%esp
}
 38f:	90                   	nop
 390:	c9                   	leave  
 391:	c3                   	ret    

00000392 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 392:	55                   	push   %ebp
 393:	89 e5                	mov    %esp,%ebp
 395:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 398:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 39f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3a3:	74 17                	je     3bc <printint+0x2a>
 3a5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3a9:	79 11                	jns    3bc <printint+0x2a>
    neg = 1;
 3ab:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b5:	f7 d8                	neg    %eax
 3b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ba:	eb 06                	jmp    3c2 <printint+0x30>
  } else {
    x = xx;
 3bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3cf:	ba 00 00 00 00       	mov    $0x0,%edx
 3d4:	f7 f1                	div    %ecx
 3d6:	89 d1                	mov    %edx,%ecx
 3d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3db:	8d 50 01             	lea    0x1(%eax),%edx
 3de:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3e1:	8a 91 2c 08 00 00    	mov    0x82c(%ecx),%dl
 3e7:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f1:	ba 00 00 00 00       	mov    $0x0,%edx
 3f6:	f7 f1                	div    %ecx
 3f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3ff:	75 c8                	jne    3c9 <printint+0x37>
  if(neg)
 401:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 405:	74 2c                	je     433 <printint+0xa1>
    buf[i++] = '-';
 407:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40a:	8d 50 01             	lea    0x1(%eax),%edx
 40d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 410:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 415:	eb 1c                	jmp    433 <printint+0xa1>
    putc(fd, buf[i]);
 417:	8d 55 dc             	lea    -0x24(%ebp),%edx
 41a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 41d:	01 d0                	add    %edx,%eax
 41f:	8a 00                	mov    (%eax),%al
 421:	0f be c0             	movsbl %al,%eax
 424:	83 ec 08             	sub    $0x8,%esp
 427:	50                   	push   %eax
 428:	ff 75 08             	pushl  0x8(%ebp)
 42b:	e8 3f ff ff ff       	call   36f <putc>
 430:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 433:	ff 4d f4             	decl   -0xc(%ebp)
 436:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 43a:	79 db                	jns    417 <printint+0x85>
}
 43c:	90                   	nop
 43d:	90                   	nop
 43e:	c9                   	leave  
 43f:	c3                   	ret    

00000440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 446:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 44d:	8d 45 0c             	lea    0xc(%ebp),%eax
 450:	83 c0 04             	add    $0x4,%eax
 453:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 456:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 45d:	e9 54 01 00 00       	jmp    5b6 <printf+0x176>
    c = fmt[i] & 0xff;
 462:	8b 55 0c             	mov    0xc(%ebp),%edx
 465:	8b 45 f0             	mov    -0x10(%ebp),%eax
 468:	01 d0                	add    %edx,%eax
 46a:	8a 00                	mov    (%eax),%al
 46c:	0f be c0             	movsbl %al,%eax
 46f:	25 ff 00 00 00       	and    $0xff,%eax
 474:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 477:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47b:	75 2c                	jne    4a9 <printf+0x69>
      if(c == '%'){
 47d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 481:	75 0c                	jne    48f <printf+0x4f>
        state = '%';
 483:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 48a:	e9 24 01 00 00       	jmp    5b3 <printf+0x173>
      } else {
        putc(fd, c);
 48f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 492:	0f be c0             	movsbl %al,%eax
 495:	83 ec 08             	sub    $0x8,%esp
 498:	50                   	push   %eax
 499:	ff 75 08             	pushl  0x8(%ebp)
 49c:	e8 ce fe ff ff       	call   36f <putc>
 4a1:	83 c4 10             	add    $0x10,%esp
 4a4:	e9 0a 01 00 00       	jmp    5b3 <printf+0x173>
      }
    } else if(state == '%'){
 4a9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4ad:	0f 85 00 01 00 00    	jne    5b3 <printf+0x173>
      if(c == 'd'){
 4b3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4b7:	75 1e                	jne    4d7 <printf+0x97>
        printint(fd, *ap, 10, 1);
 4b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4bc:	8b 00                	mov    (%eax),%eax
 4be:	6a 01                	push   $0x1
 4c0:	6a 0a                	push   $0xa
 4c2:	50                   	push   %eax
 4c3:	ff 75 08             	pushl  0x8(%ebp)
 4c6:	e8 c7 fe ff ff       	call   392 <printint>
 4cb:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d2:	e9 d5 00 00 00       	jmp    5ac <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 4d7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4db:	74 06                	je     4e3 <printf+0xa3>
 4dd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e1:	75 1e                	jne    501 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 4e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e6:	8b 00                	mov    (%eax),%eax
 4e8:	6a 00                	push   $0x0
 4ea:	6a 10                	push   $0x10
 4ec:	50                   	push   %eax
 4ed:	ff 75 08             	pushl  0x8(%ebp)
 4f0:	e8 9d fe ff ff       	call   392 <printint>
 4f5:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fc:	e9 ab 00 00 00       	jmp    5ac <printf+0x16c>
      } else if(c == 's'){
 501:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 505:	75 40                	jne    547 <printf+0x107>
        s = (char*)*ap;
 507:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50a:	8b 00                	mov    (%eax),%eax
 50c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 50f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 513:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 517:	75 23                	jne    53c <printf+0xfc>
          s = "(null)";
 519:	c7 45 f4 22 08 00 00 	movl   $0x822,-0xc(%ebp)
        while(*s != 0){
 520:	eb 1a                	jmp    53c <printf+0xfc>
          putc(fd, *s);
 522:	8b 45 f4             	mov    -0xc(%ebp),%eax
 525:	8a 00                	mov    (%eax),%al
 527:	0f be c0             	movsbl %al,%eax
 52a:	83 ec 08             	sub    $0x8,%esp
 52d:	50                   	push   %eax
 52e:	ff 75 08             	pushl  0x8(%ebp)
 531:	e8 39 fe ff ff       	call   36f <putc>
 536:	83 c4 10             	add    $0x10,%esp
          s++;
 539:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 53c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53f:	8a 00                	mov    (%eax),%al
 541:	84 c0                	test   %al,%al
 543:	75 dd                	jne    522 <printf+0xe2>
 545:	eb 65                	jmp    5ac <printf+0x16c>
        }
      } else if(c == 'c'){
 547:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 54b:	75 1d                	jne    56a <printf+0x12a>
        putc(fd, *ap);
 54d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 550:	8b 00                	mov    (%eax),%eax
 552:	0f be c0             	movsbl %al,%eax
 555:	83 ec 08             	sub    $0x8,%esp
 558:	50                   	push   %eax
 559:	ff 75 08             	pushl  0x8(%ebp)
 55c:	e8 0e fe ff ff       	call   36f <putc>
 561:	83 c4 10             	add    $0x10,%esp
        ap++;
 564:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 568:	eb 42                	jmp    5ac <printf+0x16c>
      } else if(c == '%'){
 56a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 56e:	75 17                	jne    587 <printf+0x147>
        putc(fd, c);
 570:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 573:	0f be c0             	movsbl %al,%eax
 576:	83 ec 08             	sub    $0x8,%esp
 579:	50                   	push   %eax
 57a:	ff 75 08             	pushl  0x8(%ebp)
 57d:	e8 ed fd ff ff       	call   36f <putc>
 582:	83 c4 10             	add    $0x10,%esp
 585:	eb 25                	jmp    5ac <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 587:	83 ec 08             	sub    $0x8,%esp
 58a:	6a 25                	push   $0x25
 58c:	ff 75 08             	pushl  0x8(%ebp)
 58f:	e8 db fd ff ff       	call   36f <putc>
 594:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 597:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59a:	0f be c0             	movsbl %al,%eax
 59d:	83 ec 08             	sub    $0x8,%esp
 5a0:	50                   	push   %eax
 5a1:	ff 75 08             	pushl  0x8(%ebp)
 5a4:	e8 c6 fd ff ff       	call   36f <putc>
 5a9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5b3:	ff 45 f0             	incl   -0x10(%ebp)
 5b6:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5bc:	01 d0                	add    %edx,%eax
 5be:	8a 00                	mov    (%eax),%al
 5c0:	84 c0                	test   %al,%al
 5c2:	0f 85 9a fe ff ff    	jne    462 <printf+0x22>
    }
  }
}
 5c8:	90                   	nop
 5c9:	90                   	nop
 5ca:	c9                   	leave  
 5cb:	c3                   	ret    

000005cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5cc:	55                   	push   %ebp
 5cd:	89 e5                	mov    %esp,%ebp
 5cf:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d2:	8b 45 08             	mov    0x8(%ebp),%eax
 5d5:	83 e8 08             	sub    $0x8,%eax
 5d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5db:	a1 48 08 00 00       	mov    0x848,%eax
 5e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e3:	eb 24                	jmp    609 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e8:	8b 00                	mov    (%eax),%eax
 5ea:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5ed:	72 12                	jb     601 <free+0x35>
 5ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f2:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5f5:	72 24                	jb     61b <free+0x4f>
 5f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fa:	8b 00                	mov    (%eax),%eax
 5fc:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5ff:	72 1a                	jb     61b <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	8b 45 fc             	mov    -0x4(%ebp),%eax
 604:	8b 00                	mov    (%eax),%eax
 606:	89 45 fc             	mov    %eax,-0x4(%ebp)
 609:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60c:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 60f:	73 d4                	jae    5e5 <free+0x19>
 611:	8b 45 fc             	mov    -0x4(%ebp),%eax
 614:	8b 00                	mov    (%eax),%eax
 616:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 619:	73 ca                	jae    5e5 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 61b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61e:	8b 40 04             	mov    0x4(%eax),%eax
 621:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 628:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62b:	01 c2                	add    %eax,%edx
 62d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 630:	8b 00                	mov    (%eax),%eax
 632:	39 c2                	cmp    %eax,%edx
 634:	75 24                	jne    65a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 636:	8b 45 f8             	mov    -0x8(%ebp),%eax
 639:	8b 50 04             	mov    0x4(%eax),%edx
 63c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63f:	8b 00                	mov    (%eax),%eax
 641:	8b 40 04             	mov    0x4(%eax),%eax
 644:	01 c2                	add    %eax,%edx
 646:	8b 45 f8             	mov    -0x8(%ebp),%eax
 649:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64f:	8b 00                	mov    (%eax),%eax
 651:	8b 10                	mov    (%eax),%edx
 653:	8b 45 f8             	mov    -0x8(%ebp),%eax
 656:	89 10                	mov    %edx,(%eax)
 658:	eb 0a                	jmp    664 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65d:	8b 10                	mov    (%eax),%edx
 65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 662:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 664:	8b 45 fc             	mov    -0x4(%ebp),%eax
 667:	8b 40 04             	mov    0x4(%eax),%eax
 66a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	01 d0                	add    %edx,%eax
 676:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 679:	75 20                	jne    69b <free+0xcf>
    p->s.size += bp->s.size;
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	8b 50 04             	mov    0x4(%eax),%edx
 681:	8b 45 f8             	mov    -0x8(%ebp),%eax
 684:	8b 40 04             	mov    0x4(%eax),%eax
 687:	01 c2                	add    %eax,%edx
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 692:	8b 10                	mov    (%eax),%edx
 694:	8b 45 fc             	mov    -0x4(%ebp),%eax
 697:	89 10                	mov    %edx,(%eax)
 699:	eb 08                	jmp    6a3 <free+0xd7>
  } else
    p->s.ptr = bp;
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6a1:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a6:	a3 48 08 00 00       	mov    %eax,0x848
}
 6ab:	90                   	nop
 6ac:	c9                   	leave  
 6ad:	c3                   	ret    

000006ae <morecore>:

static Header*
morecore(uint nu)
{
 6ae:	55                   	push   %ebp
 6af:	89 e5                	mov    %esp,%ebp
 6b1:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6b4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6bb:	77 07                	ja     6c4 <morecore+0x16>
    nu = 4096;
 6bd:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6c4:	8b 45 08             	mov    0x8(%ebp),%eax
 6c7:	c1 e0 03             	shl    $0x3,%eax
 6ca:	83 ec 0c             	sub    $0xc,%esp
 6cd:	50                   	push   %eax
 6ce:	e8 84 fc ff ff       	call   357 <sbrk>
 6d3:	83 c4 10             	add    $0x10,%esp
 6d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6d9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6dd:	75 07                	jne    6e6 <morecore+0x38>
    return 0;
 6df:	b8 00 00 00 00       	mov    $0x0,%eax
 6e4:	eb 26                	jmp    70c <morecore+0x5e>
  hp = (Header*)p;
 6e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ef:	8b 55 08             	mov    0x8(%ebp),%edx
 6f2:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f8:	83 c0 08             	add    $0x8,%eax
 6fb:	83 ec 0c             	sub    $0xc,%esp
 6fe:	50                   	push   %eax
 6ff:	e8 c8 fe ff ff       	call   5cc <free>
 704:	83 c4 10             	add    $0x10,%esp
  return freep;
 707:	a1 48 08 00 00       	mov    0x848,%eax
}
 70c:	c9                   	leave  
 70d:	c3                   	ret    

0000070e <malloc>:

void*
malloc(uint nbytes)
{
 70e:	55                   	push   %ebp
 70f:	89 e5                	mov    %esp,%ebp
 711:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 714:	8b 45 08             	mov    0x8(%ebp),%eax
 717:	83 c0 07             	add    $0x7,%eax
 71a:	c1 e8 03             	shr    $0x3,%eax
 71d:	40                   	inc    %eax
 71e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 721:	a1 48 08 00 00       	mov    0x848,%eax
 726:	89 45 f0             	mov    %eax,-0x10(%ebp)
 729:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 72d:	75 23                	jne    752 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 72f:	c7 45 f0 40 08 00 00 	movl   $0x840,-0x10(%ebp)
 736:	8b 45 f0             	mov    -0x10(%ebp),%eax
 739:	a3 48 08 00 00       	mov    %eax,0x848
 73e:	a1 48 08 00 00       	mov    0x848,%eax
 743:	a3 40 08 00 00       	mov    %eax,0x840
    base.s.size = 0;
 748:	c7 05 44 08 00 00 00 	movl   $0x0,0x844
 74f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 752:	8b 45 f0             	mov    -0x10(%ebp),%eax
 755:	8b 00                	mov    (%eax),%eax
 757:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75d:	8b 40 04             	mov    0x4(%eax),%eax
 760:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 763:	72 4d                	jb     7b2 <malloc+0xa4>
      if(p->s.size == nunits)
 765:	8b 45 f4             	mov    -0xc(%ebp),%eax
 768:	8b 40 04             	mov    0x4(%eax),%eax
 76b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 76e:	75 0c                	jne    77c <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 770:	8b 45 f4             	mov    -0xc(%ebp),%eax
 773:	8b 10                	mov    (%eax),%edx
 775:	8b 45 f0             	mov    -0x10(%ebp),%eax
 778:	89 10                	mov    %edx,(%eax)
 77a:	eb 26                	jmp    7a2 <malloc+0x94>
      else {
        p->s.size -= nunits;
 77c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77f:	8b 40 04             	mov    0x4(%eax),%eax
 782:	2b 45 ec             	sub    -0x14(%ebp),%eax
 785:	89 c2                	mov    %eax,%edx
 787:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 78d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 790:	8b 40 04             	mov    0x4(%eax),%eax
 793:	c1 e0 03             	shl    $0x3,%eax
 796:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 799:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 79f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a5:	a3 48 08 00 00       	mov    %eax,0x848
      return (void*)(p + 1);
 7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ad:	83 c0 08             	add    $0x8,%eax
 7b0:	eb 3b                	jmp    7ed <malloc+0xdf>
    }
    if(p == freep)
 7b2:	a1 48 08 00 00       	mov    0x848,%eax
 7b7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7ba:	75 1e                	jne    7da <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 7bc:	83 ec 0c             	sub    $0xc,%esp
 7bf:	ff 75 ec             	pushl  -0x14(%ebp)
 7c2:	e8 e7 fe ff ff       	call   6ae <morecore>
 7c7:	83 c4 10             	add    $0x10,%esp
 7ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d1:	75 07                	jne    7da <malloc+0xcc>
        return 0;
 7d3:	b8 00 00 00 00       	mov    $0x0,%eax
 7d8:	eb 13                	jmp    7ed <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 00                	mov    (%eax),%eax
 7e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7e8:	e9 6d ff ff ff       	jmp    75a <malloc+0x4c>
  }
}
 7ed:	c9                   	leave  
 7ee:	c3                   	ret    
