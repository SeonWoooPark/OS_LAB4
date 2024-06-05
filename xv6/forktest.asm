
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
  write(fd, s, strlen(s));
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	ff 75 0c             	pushl  0xc(%ebp)
   c:	e8 81 01 00 00       	call   192 <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	ff 75 0c             	pushl  0xc(%ebp)
  1b:	ff 75 08             	pushl  0x8(%ebp)
  1e:	e8 43 03 00 00       	call   366 <write>
  23:	83 c4 10             	add    $0x10,%esp
}
  26:	90                   	nop
  27:	c9                   	leave  
  28:	c3                   	ret    

00000029 <forktest>:

void
forktest(void)
{
  29:	55                   	push   %ebp
  2a:	89 e5                	mov    %esp,%ebp
  2c:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	68 e8 03 00 00       	push   $0x3e8
  37:	6a 01                	push   $0x1
  39:	e8 c2 ff ff ff       	call   0 <printf>
  3e:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  48:	eb 1c                	jmp    66 <forktest+0x3d>
    pid = fork();
  4a:	e8 ef 02 00 00       	call   33e <fork>
  4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  56:	78 19                	js     71 <forktest+0x48>
      break;
    if(pid == 0)
  58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  5c:	75 05                	jne    63 <forktest+0x3a>
      exit();
  5e:	e8 e3 02 00 00       	call   346 <exit>
  for(n=0; n<N; n++){
  63:	ff 45 f4             	incl   -0xc(%ebp)
  66:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  6d:	7e db                	jle    4a <forktest+0x21>
  6f:	eb 01                	jmp    72 <forktest+0x49>
      break;
  71:	90                   	nop
  }

  if(n == N){
  72:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  79:	75 3f                	jne    ba <forktest+0x91>
    printf(1, "fork claimed to work N times!\n", N);
  7b:	83 ec 04             	sub    $0x4,%esp
  7e:	68 e8 03 00 00       	push   $0x3e8
  83:	68 f4 03 00 00       	push   $0x3f4
  88:	6a 01                	push   $0x1
  8a:	e8 71 ff ff ff       	call   0 <printf>
  8f:	83 c4 10             	add    $0x10,%esp
    exit();
  92:	e8 af 02 00 00       	call   346 <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
  97:	e8 b2 02 00 00       	call   34e <wait>
  9c:	85 c0                	test   %eax,%eax
  9e:	79 17                	jns    b7 <forktest+0x8e>
      printf(1, "wait stopped early\n");
  a0:	83 ec 08             	sub    $0x8,%esp
  a3:	68 13 04 00 00       	push   $0x413
  a8:	6a 01                	push   $0x1
  aa:	e8 51 ff ff ff       	call   0 <printf>
  af:	83 c4 10             	add    $0x10,%esp
      exit();
  b2:	e8 8f 02 00 00       	call   346 <exit>
  for(; n > 0; n--){
  b7:	ff 4d f4             	decl   -0xc(%ebp)
  ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  be:	7f d7                	jg     97 <forktest+0x6e>
    }
  }

  if(wait() != -1){
  c0:	e8 89 02 00 00       	call   34e <wait>
  c5:	83 f8 ff             	cmp    $0xffffffff,%eax
  c8:	74 17                	je     e1 <forktest+0xb8>
    printf(1, "wait got too many\n");
  ca:	83 ec 08             	sub    $0x8,%esp
  cd:	68 27 04 00 00       	push   $0x427
  d2:	6a 01                	push   $0x1
  d4:	e8 27 ff ff ff       	call   0 <printf>
  d9:	83 c4 10             	add    $0x10,%esp
    exit();
  dc:	e8 65 02 00 00       	call   346 <exit>
  }

  printf(1, "fork test OK\n");
  e1:	83 ec 08             	sub    $0x8,%esp
  e4:	68 3a 04 00 00       	push   $0x43a
  e9:	6a 01                	push   $0x1
  eb:	e8 10 ff ff ff       	call   0 <printf>
  f0:	83 c4 10             	add    $0x10,%esp
}
  f3:	90                   	nop
  f4:	c9                   	leave  
  f5:	c3                   	ret    

000000f6 <main>:

int
main(void)
{
  f6:	55                   	push   %ebp
  f7:	89 e5                	mov    %esp,%ebp
  f9:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
  fc:	e8 28 ff ff ff       	call   29 <forktest>
  exit();
 101:	e8 40 02 00 00       	call   346 <exit>

00000106 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 106:	55                   	push   %ebp
 107:	89 e5                	mov    %esp,%ebp
 109:	57                   	push   %edi
 10a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 10b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 10e:	8b 55 10             	mov    0x10(%ebp),%edx
 111:	8b 45 0c             	mov    0xc(%ebp),%eax
 114:	89 cb                	mov    %ecx,%ebx
 116:	89 df                	mov    %ebx,%edi
 118:	89 d1                	mov    %edx,%ecx
 11a:	fc                   	cld    
 11b:	f3 aa                	rep stos %al,%es:(%edi)
 11d:	89 ca                	mov    %ecx,%edx
 11f:	89 fb                	mov    %edi,%ebx
 121:	89 5d 08             	mov    %ebx,0x8(%ebp)
 124:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 127:	90                   	nop
 128:	5b                   	pop    %ebx
 129:	5f                   	pop    %edi
 12a:	5d                   	pop    %ebp
 12b:	c3                   	ret    

0000012c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 132:	8b 45 08             	mov    0x8(%ebp),%eax
 135:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 138:	90                   	nop
 139:	8b 55 0c             	mov    0xc(%ebp),%edx
 13c:	8d 42 01             	lea    0x1(%edx),%eax
 13f:	89 45 0c             	mov    %eax,0xc(%ebp)
 142:	8b 45 08             	mov    0x8(%ebp),%eax
 145:	8d 48 01             	lea    0x1(%eax),%ecx
 148:	89 4d 08             	mov    %ecx,0x8(%ebp)
 14b:	8a 12                	mov    (%edx),%dl
 14d:	88 10                	mov    %dl,(%eax)
 14f:	8a 00                	mov    (%eax),%al
 151:	84 c0                	test   %al,%al
 153:	75 e4                	jne    139 <strcpy+0xd>
    ;
  return os;
 155:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 158:	c9                   	leave  
 159:	c3                   	ret    

0000015a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 15a:	55                   	push   %ebp
 15b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 15d:	eb 06                	jmp    165 <strcmp+0xb>
    p++, q++;
 15f:	ff 45 08             	incl   0x8(%ebp)
 162:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
 165:	8b 45 08             	mov    0x8(%ebp),%eax
 168:	8a 00                	mov    (%eax),%al
 16a:	84 c0                	test   %al,%al
 16c:	74 0e                	je     17c <strcmp+0x22>
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	8a 10                	mov    (%eax),%dl
 173:	8b 45 0c             	mov    0xc(%ebp),%eax
 176:	8a 00                	mov    (%eax),%al
 178:	38 c2                	cmp    %al,%dl
 17a:	74 e3                	je     15f <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	8a 00                	mov    (%eax),%al
 181:	0f b6 d0             	movzbl %al,%edx
 184:	8b 45 0c             	mov    0xc(%ebp),%eax
 187:	8a 00                	mov    (%eax),%al
 189:	0f b6 c0             	movzbl %al,%eax
 18c:	29 c2                	sub    %eax,%edx
 18e:	89 d0                	mov    %edx,%eax
}
 190:	5d                   	pop    %ebp
 191:	c3                   	ret    

00000192 <strlen>:

uint
strlen(char *s)
{
 192:	55                   	push   %ebp
 193:	89 e5                	mov    %esp,%ebp
 195:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 198:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 19f:	eb 03                	jmp    1a4 <strlen+0x12>
 1a1:	ff 45 fc             	incl   -0x4(%ebp)
 1a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	01 d0                	add    %edx,%eax
 1ac:	8a 00                	mov    (%eax),%al
 1ae:	84 c0                	test   %al,%al
 1b0:	75 ef                	jne    1a1 <strlen+0xf>
    ;
  return n;
 1b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1b5:	c9                   	leave  
 1b6:	c3                   	ret    

000001b7 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b7:	55                   	push   %ebp
 1b8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1ba:	8b 45 10             	mov    0x10(%ebp),%eax
 1bd:	50                   	push   %eax
 1be:	ff 75 0c             	pushl  0xc(%ebp)
 1c1:	ff 75 08             	pushl  0x8(%ebp)
 1c4:	e8 3d ff ff ff       	call   106 <stosb>
 1c9:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1cf:	c9                   	leave  
 1d0:	c3                   	ret    

000001d1 <strchr>:

char*
strchr(const char *s, char c)
{
 1d1:	55                   	push   %ebp
 1d2:	89 e5                	mov    %esp,%ebp
 1d4:	83 ec 04             	sub    $0x4,%esp
 1d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1da:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1dd:	eb 12                	jmp    1f1 <strchr+0x20>
    if(*s == c)
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	8a 00                	mov    (%eax),%al
 1e4:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1e7:	75 05                	jne    1ee <strchr+0x1d>
      return (char*)s;
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	eb 11                	jmp    1ff <strchr+0x2e>
  for(; *s; s++)
 1ee:	ff 45 08             	incl   0x8(%ebp)
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	8a 00                	mov    (%eax),%al
 1f6:	84 c0                	test   %al,%al
 1f8:	75 e5                	jne    1df <strchr+0xe>
  return 0;
 1fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ff:	c9                   	leave  
 200:	c3                   	ret    

00000201 <gets>:

char*
gets(char *buf, int max)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 207:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 20e:	eb 3f                	jmp    24f <gets+0x4e>
    cc = read(0, &c, 1);
 210:	83 ec 04             	sub    $0x4,%esp
 213:	6a 01                	push   $0x1
 215:	8d 45 ef             	lea    -0x11(%ebp),%eax
 218:	50                   	push   %eax
 219:	6a 00                	push   $0x0
 21b:	e8 3e 01 00 00       	call   35e <read>
 220:	83 c4 10             	add    $0x10,%esp
 223:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 226:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 22a:	7e 2e                	jle    25a <gets+0x59>
      break;
    buf[i++] = c;
 22c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22f:	8d 50 01             	lea    0x1(%eax),%edx
 232:	89 55 f4             	mov    %edx,-0xc(%ebp)
 235:	89 c2                	mov    %eax,%edx
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	01 c2                	add    %eax,%edx
 23c:	8a 45 ef             	mov    -0x11(%ebp),%al
 23f:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 241:	8a 45 ef             	mov    -0x11(%ebp),%al
 244:	3c 0a                	cmp    $0xa,%al
 246:	74 13                	je     25b <gets+0x5a>
 248:	8a 45 ef             	mov    -0x11(%ebp),%al
 24b:	3c 0d                	cmp    $0xd,%al
 24d:	74 0c                	je     25b <gets+0x5a>
  for(i=0; i+1 < max; ){
 24f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 252:	40                   	inc    %eax
 253:	39 45 0c             	cmp    %eax,0xc(%ebp)
 256:	7f b8                	jg     210 <gets+0xf>
 258:	eb 01                	jmp    25b <gets+0x5a>
      break;
 25a:	90                   	nop
      break;
  }
  buf[i] = '\0';
 25b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	01 d0                	add    %edx,%eax
 263:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 266:	8b 45 08             	mov    0x8(%ebp),%eax
}
 269:	c9                   	leave  
 26a:	c3                   	ret    

0000026b <stat>:

int
stat(char *n, struct stat *st)
{
 26b:	55                   	push   %ebp
 26c:	89 e5                	mov    %esp,%ebp
 26e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 271:	83 ec 08             	sub    $0x8,%esp
 274:	6a 00                	push   $0x0
 276:	ff 75 08             	pushl  0x8(%ebp)
 279:	e8 08 01 00 00       	call   386 <open>
 27e:	83 c4 10             	add    $0x10,%esp
 281:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 284:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 288:	79 07                	jns    291 <stat+0x26>
    return -1;
 28a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 28f:	eb 25                	jmp    2b6 <stat+0x4b>
  r = fstat(fd, st);
 291:	83 ec 08             	sub    $0x8,%esp
 294:	ff 75 0c             	pushl  0xc(%ebp)
 297:	ff 75 f4             	pushl  -0xc(%ebp)
 29a:	e8 ff 00 00 00       	call   39e <fstat>
 29f:	83 c4 10             	add    $0x10,%esp
 2a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2a5:	83 ec 0c             	sub    $0xc,%esp
 2a8:	ff 75 f4             	pushl  -0xc(%ebp)
 2ab:	e8 be 00 00 00       	call   36e <close>
 2b0:	83 c4 10             	add    $0x10,%esp
  return r;
 2b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2b6:	c9                   	leave  
 2b7:	c3                   	ret    

000002b8 <atoi>:

int
atoi(const char *s)
{
 2b8:	55                   	push   %ebp
 2b9:	89 e5                	mov    %esp,%ebp
 2bb:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2c5:	eb 24                	jmp    2eb <atoi+0x33>
    n = n*10 + *s++ - '0';
 2c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2ca:	89 d0                	mov    %edx,%eax
 2cc:	c1 e0 02             	shl    $0x2,%eax
 2cf:	01 d0                	add    %edx,%eax
 2d1:	01 c0                	add    %eax,%eax
 2d3:	89 c1                	mov    %eax,%ecx
 2d5:	8b 45 08             	mov    0x8(%ebp),%eax
 2d8:	8d 50 01             	lea    0x1(%eax),%edx
 2db:	89 55 08             	mov    %edx,0x8(%ebp)
 2de:	8a 00                	mov    (%eax),%al
 2e0:	0f be c0             	movsbl %al,%eax
 2e3:	01 c8                	add    %ecx,%eax
 2e5:	83 e8 30             	sub    $0x30,%eax
 2e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ee:	8a 00                	mov    (%eax),%al
 2f0:	3c 2f                	cmp    $0x2f,%al
 2f2:	7e 09                	jle    2fd <atoi+0x45>
 2f4:	8b 45 08             	mov    0x8(%ebp),%eax
 2f7:	8a 00                	mov    (%eax),%al
 2f9:	3c 39                	cmp    $0x39,%al
 2fb:	7e ca                	jle    2c7 <atoi+0xf>
  return n;
 2fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 300:	c9                   	leave  
 301:	c3                   	ret    

00000302 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 302:	55                   	push   %ebp
 303:	89 e5                	mov    %esp,%ebp
 305:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 30e:	8b 45 0c             	mov    0xc(%ebp),%eax
 311:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 314:	eb 16                	jmp    32c <memmove+0x2a>
    *dst++ = *src++;
 316:	8b 55 f8             	mov    -0x8(%ebp),%edx
 319:	8d 42 01             	lea    0x1(%edx),%eax
 31c:	89 45 f8             	mov    %eax,-0x8(%ebp)
 31f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 322:	8d 48 01             	lea    0x1(%eax),%ecx
 325:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 328:	8a 12                	mov    (%edx),%dl
 32a:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 32c:	8b 45 10             	mov    0x10(%ebp),%eax
 32f:	8d 50 ff             	lea    -0x1(%eax),%edx
 332:	89 55 10             	mov    %edx,0x10(%ebp)
 335:	85 c0                	test   %eax,%eax
 337:	7f dd                	jg     316 <memmove+0x14>
  return vdst;
 339:	8b 45 08             	mov    0x8(%ebp),%eax
}
 33c:	c9                   	leave  
 33d:	c3                   	ret    

0000033e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33e:	b8 01 00 00 00       	mov    $0x1,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <exit>:
SYSCALL(exit)
 346:	b8 02 00 00 00       	mov    $0x2,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <wait>:
SYSCALL(wait)
 34e:	b8 03 00 00 00       	mov    $0x3,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <pipe>:
SYSCALL(pipe)
 356:	b8 04 00 00 00       	mov    $0x4,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <read>:
SYSCALL(read)
 35e:	b8 05 00 00 00       	mov    $0x5,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <write>:
SYSCALL(write)
 366:	b8 10 00 00 00       	mov    $0x10,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <close>:
SYSCALL(close)
 36e:	b8 15 00 00 00       	mov    $0x15,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <kill>:
SYSCALL(kill)
 376:	b8 06 00 00 00       	mov    $0x6,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <exec>:
SYSCALL(exec)
 37e:	b8 07 00 00 00       	mov    $0x7,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <open>:
SYSCALL(open)
 386:	b8 0f 00 00 00       	mov    $0xf,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <mknod>:
SYSCALL(mknod)
 38e:	b8 11 00 00 00       	mov    $0x11,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <unlink>:
SYSCALL(unlink)
 396:	b8 12 00 00 00       	mov    $0x12,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <fstat>:
SYSCALL(fstat)
 39e:	b8 08 00 00 00       	mov    $0x8,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <link>:
SYSCALL(link)
 3a6:	b8 13 00 00 00       	mov    $0x13,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <mkdir>:
SYSCALL(mkdir)
 3ae:	b8 14 00 00 00       	mov    $0x14,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <chdir>:
SYSCALL(chdir)
 3b6:	b8 09 00 00 00       	mov    $0x9,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <dup>:
SYSCALL(dup)
 3be:	b8 0a 00 00 00       	mov    $0xa,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <getpid>:
SYSCALL(getpid)
 3c6:	b8 0b 00 00 00       	mov    $0xb,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <sbrk>:
SYSCALL(sbrk)
 3ce:	b8 0c 00 00 00       	mov    $0xc,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <sleep>:
SYSCALL(sleep)
 3d6:	b8 0d 00 00 00       	mov    $0xd,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret    

000003de <uptime>:
SYSCALL(uptime)
 3de:	b8 0e 00 00 00       	mov    $0xe,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret    
