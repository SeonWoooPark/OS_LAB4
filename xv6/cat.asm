
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   6:	eb 31                	jmp    39 <cat+0x39>
    if (write(1, buf, n) != n) {
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	pushl  -0xc(%ebp)
   e:	68 e0 08 00 00       	push   $0x8e0
  13:	6a 01                	push   $0x1
  15:	e8 70 03 00 00       	call   38a <write>
  1a:	83 c4 10             	add    $0x10,%esp
  1d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  20:	74 17                	je     39 <cat+0x39>
      printf(1, "cat: write error\n");
  22:	83 ec 08             	sub    $0x8,%esp
  25:	68 8a 08 00 00       	push   $0x88a
  2a:	6a 01                	push   $0x1
  2c:	e8 aa 04 00 00       	call   4db <printf>
  31:	83 c4 10             	add    $0x10,%esp
      exit();
  34:	e8 31 03 00 00       	call   36a <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  39:	83 ec 04             	sub    $0x4,%esp
  3c:	68 00 02 00 00       	push   $0x200
  41:	68 e0 08 00 00       	push   $0x8e0
  46:	ff 75 08             	pushl  0x8(%ebp)
  49:	e8 34 03 00 00       	call   382 <read>
  4e:	83 c4 10             	add    $0x10,%esp
  51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  58:	7f ae                	jg     8 <cat+0x8>
    }
  }
  if(n < 0){
  5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  5e:	79 17                	jns    77 <cat+0x77>
    printf(1, "cat: read error\n");
  60:	83 ec 08             	sub    $0x8,%esp
  63:	68 9c 08 00 00       	push   $0x89c
  68:	6a 01                	push   $0x1
  6a:	e8 6c 04 00 00       	call   4db <printf>
  6f:	83 c4 10             	add    $0x10,%esp
    exit();
  72:	e8 f3 02 00 00       	call   36a <exit>
  }
}
  77:	90                   	nop
  78:	c9                   	leave  
  79:	c3                   	ret    

0000007a <main>:

int
main(int argc, char *argv[])
{
  7a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  7e:	83 e4 f0             	and    $0xfffffff0,%esp
  81:	ff 71 fc             	pushl  -0x4(%ecx)
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	53                   	push   %ebx
  88:	51                   	push   %ecx
  89:	83 ec 10             	sub    $0x10,%esp
  8c:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  8e:	83 3b 01             	cmpl   $0x1,(%ebx)
  91:	7f 12                	jg     a5 <main+0x2b>
    cat(0);
  93:	83 ec 0c             	sub    $0xc,%esp
  96:	6a 00                	push   $0x0
  98:	e8 63 ff ff ff       	call   0 <cat>
  9d:	83 c4 10             	add    $0x10,%esp
    exit();
  a0:	e8 c5 02 00 00       	call   36a <exit>
  }

  for(i = 1; i < argc; i++){
  a5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  ac:	eb 70                	jmp    11e <main+0xa4>
    if((fd = open(argv[i], 0)) < 0){
  ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  b8:	8b 43 04             	mov    0x4(%ebx),%eax
  bb:	01 d0                	add    %edx,%eax
  bd:	8b 00                	mov    (%eax),%eax
  bf:	83 ec 08             	sub    $0x8,%esp
  c2:	6a 00                	push   $0x0
  c4:	50                   	push   %eax
  c5:	e8 e0 02 00 00       	call   3aa <open>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  d4:	79 29                	jns    ff <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
  d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  e0:	8b 43 04             	mov    0x4(%ebx),%eax
  e3:	01 d0                	add    %edx,%eax
  e5:	8b 00                	mov    (%eax),%eax
  e7:	83 ec 04             	sub    $0x4,%esp
  ea:	50                   	push   %eax
  eb:	68 ad 08 00 00       	push   $0x8ad
  f0:	6a 01                	push   $0x1
  f2:	e8 e4 03 00 00       	call   4db <printf>
  f7:	83 c4 10             	add    $0x10,%esp
      exit();
  fa:	e8 6b 02 00 00       	call   36a <exit>
    }
    cat(fd);
  ff:	83 ec 0c             	sub    $0xc,%esp
 102:	ff 75 f0             	pushl  -0x10(%ebp)
 105:	e8 f6 fe ff ff       	call   0 <cat>
 10a:	83 c4 10             	add    $0x10,%esp
    close(fd);
 10d:	83 ec 0c             	sub    $0xc,%esp
 110:	ff 75 f0             	pushl  -0x10(%ebp)
 113:	e8 7a 02 00 00       	call   392 <close>
 118:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 11b:	ff 45 f4             	incl   -0xc(%ebp)
 11e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 121:	3b 03                	cmp    (%ebx),%eax
 123:	7c 89                	jl     ae <main+0x34>
  }
  exit();
 125:	e8 40 02 00 00       	call   36a <exit>

0000012a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 12a:	55                   	push   %ebp
 12b:	89 e5                	mov    %esp,%ebp
 12d:	57                   	push   %edi
 12e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 12f:	8b 4d 08             	mov    0x8(%ebp),%ecx
 132:	8b 55 10             	mov    0x10(%ebp),%edx
 135:	8b 45 0c             	mov    0xc(%ebp),%eax
 138:	89 cb                	mov    %ecx,%ebx
 13a:	89 df                	mov    %ebx,%edi
 13c:	89 d1                	mov    %edx,%ecx
 13e:	fc                   	cld    
 13f:	f3 aa                	rep stos %al,%es:(%edi)
 141:	89 ca                	mov    %ecx,%edx
 143:	89 fb                	mov    %edi,%ebx
 145:	89 5d 08             	mov    %ebx,0x8(%ebp)
 148:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 14b:	90                   	nop
 14c:	5b                   	pop    %ebx
 14d:	5f                   	pop    %edi
 14e:	5d                   	pop    %ebp
 14f:	c3                   	ret    

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 156:	8b 45 08             	mov    0x8(%ebp),%eax
 159:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 15c:	90                   	nop
 15d:	8b 55 0c             	mov    0xc(%ebp),%edx
 160:	8d 42 01             	lea    0x1(%edx),%eax
 163:	89 45 0c             	mov    %eax,0xc(%ebp)
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	8d 48 01             	lea    0x1(%eax),%ecx
 16c:	89 4d 08             	mov    %ecx,0x8(%ebp)
 16f:	8a 12                	mov    (%edx),%dl
 171:	88 10                	mov    %dl,(%eax)
 173:	8a 00                	mov    (%eax),%al
 175:	84 c0                	test   %al,%al
 177:	75 e4                	jne    15d <strcpy+0xd>
    ;
  return os;
 179:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 17c:	c9                   	leave  
 17d:	c3                   	ret    

0000017e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 181:	eb 06                	jmp    189 <strcmp+0xb>
    p++, q++;
 183:	ff 45 08             	incl   0x8(%ebp)
 186:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	8a 00                	mov    (%eax),%al
 18e:	84 c0                	test   %al,%al
 190:	74 0e                	je     1a0 <strcmp+0x22>
 192:	8b 45 08             	mov    0x8(%ebp),%eax
 195:	8a 10                	mov    (%eax),%dl
 197:	8b 45 0c             	mov    0xc(%ebp),%eax
 19a:	8a 00                	mov    (%eax),%al
 19c:	38 c2                	cmp    %al,%dl
 19e:	74 e3                	je     183 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
 1a3:	8a 00                	mov    (%eax),%al
 1a5:	0f b6 d0             	movzbl %al,%edx
 1a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ab:	8a 00                	mov    (%eax),%al
 1ad:	0f b6 c0             	movzbl %al,%eax
 1b0:	29 c2                	sub    %eax,%edx
 1b2:	89 d0                	mov    %edx,%eax
}
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    

000001b6 <strlen>:

uint
strlen(char *s)
{
 1b6:	55                   	push   %ebp
 1b7:	89 e5                	mov    %esp,%ebp
 1b9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c3:	eb 03                	jmp    1c8 <strlen+0x12>
 1c5:	ff 45 fc             	incl   -0x4(%ebp)
 1c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	01 d0                	add    %edx,%eax
 1d0:	8a 00                	mov    (%eax),%al
 1d2:	84 c0                	test   %al,%al
 1d4:	75 ef                	jne    1c5 <strlen+0xf>
    ;
  return n;
 1d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d9:	c9                   	leave  
 1da:	c3                   	ret    

000001db <memset>:

void*
memset(void *dst, int c, uint n)
{
 1db:	55                   	push   %ebp
 1dc:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1de:	8b 45 10             	mov    0x10(%ebp),%eax
 1e1:	50                   	push   %eax
 1e2:	ff 75 0c             	pushl  0xc(%ebp)
 1e5:	ff 75 08             	pushl  0x8(%ebp)
 1e8:	e8 3d ff ff ff       	call   12a <stosb>
 1ed:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f3:	c9                   	leave  
 1f4:	c3                   	ret    

000001f5 <strchr>:

char*
strchr(const char *s, char c)
{
 1f5:	55                   	push   %ebp
 1f6:	89 e5                	mov    %esp,%ebp
 1f8:	83 ec 04             	sub    $0x4,%esp
 1fb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fe:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 201:	eb 12                	jmp    215 <strchr+0x20>
    if(*s == c)
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	8a 00                	mov    (%eax),%al
 208:	38 45 fc             	cmp    %al,-0x4(%ebp)
 20b:	75 05                	jne    212 <strchr+0x1d>
      return (char*)s;
 20d:	8b 45 08             	mov    0x8(%ebp),%eax
 210:	eb 11                	jmp    223 <strchr+0x2e>
  for(; *s; s++)
 212:	ff 45 08             	incl   0x8(%ebp)
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	8a 00                	mov    (%eax),%al
 21a:	84 c0                	test   %al,%al
 21c:	75 e5                	jne    203 <strchr+0xe>
  return 0;
 21e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 223:	c9                   	leave  
 224:	c3                   	ret    

00000225 <gets>:

char*
gets(char *buf, int max)
{
 225:	55                   	push   %ebp
 226:	89 e5                	mov    %esp,%ebp
 228:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 232:	eb 3f                	jmp    273 <gets+0x4e>
    cc = read(0, &c, 1);
 234:	83 ec 04             	sub    $0x4,%esp
 237:	6a 01                	push   $0x1
 239:	8d 45 ef             	lea    -0x11(%ebp),%eax
 23c:	50                   	push   %eax
 23d:	6a 00                	push   $0x0
 23f:	e8 3e 01 00 00       	call   382 <read>
 244:	83 c4 10             	add    $0x10,%esp
 247:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 24e:	7e 2e                	jle    27e <gets+0x59>
      break;
    buf[i++] = c;
 250:	8b 45 f4             	mov    -0xc(%ebp),%eax
 253:	8d 50 01             	lea    0x1(%eax),%edx
 256:	89 55 f4             	mov    %edx,-0xc(%ebp)
 259:	89 c2                	mov    %eax,%edx
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	01 c2                	add    %eax,%edx
 260:	8a 45 ef             	mov    -0x11(%ebp),%al
 263:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 265:	8a 45 ef             	mov    -0x11(%ebp),%al
 268:	3c 0a                	cmp    $0xa,%al
 26a:	74 13                	je     27f <gets+0x5a>
 26c:	8a 45 ef             	mov    -0x11(%ebp),%al
 26f:	3c 0d                	cmp    $0xd,%al
 271:	74 0c                	je     27f <gets+0x5a>
  for(i=0; i+1 < max; ){
 273:	8b 45 f4             	mov    -0xc(%ebp),%eax
 276:	40                   	inc    %eax
 277:	39 45 0c             	cmp    %eax,0xc(%ebp)
 27a:	7f b8                	jg     234 <gets+0xf>
 27c:	eb 01                	jmp    27f <gets+0x5a>
      break;
 27e:	90                   	nop
      break;
  }
  buf[i] = '\0';
 27f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	01 d0                	add    %edx,%eax
 287:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 28d:	c9                   	leave  
 28e:	c3                   	ret    

0000028f <stat>:

int
stat(char *n, struct stat *st)
{
 28f:	55                   	push   %ebp
 290:	89 e5                	mov    %esp,%ebp
 292:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	pushl  0x8(%ebp)
 29d:	e8 08 01 00 00       	call   3aa <open>
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2ac:	79 07                	jns    2b5 <stat+0x26>
    return -1;
 2ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2b3:	eb 25                	jmp    2da <stat+0x4b>
  r = fstat(fd, st);
 2b5:	83 ec 08             	sub    $0x8,%esp
 2b8:	ff 75 0c             	pushl  0xc(%ebp)
 2bb:	ff 75 f4             	pushl  -0xc(%ebp)
 2be:	e8 ff 00 00 00       	call   3c2 <fstat>
 2c3:	83 c4 10             	add    $0x10,%esp
 2c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2c9:	83 ec 0c             	sub    $0xc,%esp
 2cc:	ff 75 f4             	pushl  -0xc(%ebp)
 2cf:	e8 be 00 00 00       	call   392 <close>
 2d4:	83 c4 10             	add    $0x10,%esp
  return r;
 2d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2da:	c9                   	leave  
 2db:	c3                   	ret    

000002dc <atoi>:

int
atoi(const char *s)
{
 2dc:	55                   	push   %ebp
 2dd:	89 e5                	mov    %esp,%ebp
 2df:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e9:	eb 24                	jmp    30f <atoi+0x33>
    n = n*10 + *s++ - '0';
 2eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2ee:	89 d0                	mov    %edx,%eax
 2f0:	c1 e0 02             	shl    $0x2,%eax
 2f3:	01 d0                	add    %edx,%eax
 2f5:	01 c0                	add    %eax,%eax
 2f7:	89 c1                	mov    %eax,%ecx
 2f9:	8b 45 08             	mov    0x8(%ebp),%eax
 2fc:	8d 50 01             	lea    0x1(%eax),%edx
 2ff:	89 55 08             	mov    %edx,0x8(%ebp)
 302:	8a 00                	mov    (%eax),%al
 304:	0f be c0             	movsbl %al,%eax
 307:	01 c8                	add    %ecx,%eax
 309:	83 e8 30             	sub    $0x30,%eax
 30c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
 312:	8a 00                	mov    (%eax),%al
 314:	3c 2f                	cmp    $0x2f,%al
 316:	7e 09                	jle    321 <atoi+0x45>
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	8a 00                	mov    (%eax),%al
 31d:	3c 39                	cmp    $0x39,%al
 31f:	7e ca                	jle    2eb <atoi+0xf>
  return n;
 321:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 324:	c9                   	leave  
 325:	c3                   	ret    

00000326 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 326:	55                   	push   %ebp
 327:	89 e5                	mov    %esp,%ebp
 329:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 32c:	8b 45 08             	mov    0x8(%ebp),%eax
 32f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 332:	8b 45 0c             	mov    0xc(%ebp),%eax
 335:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 338:	eb 16                	jmp    350 <memmove+0x2a>
    *dst++ = *src++;
 33a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 33d:	8d 42 01             	lea    0x1(%edx),%eax
 340:	89 45 f8             	mov    %eax,-0x8(%ebp)
 343:	8b 45 fc             	mov    -0x4(%ebp),%eax
 346:	8d 48 01             	lea    0x1(%eax),%ecx
 349:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 34c:	8a 12                	mov    (%edx),%dl
 34e:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 350:	8b 45 10             	mov    0x10(%ebp),%eax
 353:	8d 50 ff             	lea    -0x1(%eax),%edx
 356:	89 55 10             	mov    %edx,0x10(%ebp)
 359:	85 c0                	test   %eax,%eax
 35b:	7f dd                	jg     33a <memmove+0x14>
  return vdst;
 35d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 360:	c9                   	leave  
 361:	c3                   	ret    

00000362 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 362:	b8 01 00 00 00       	mov    $0x1,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <exit>:
SYSCALL(exit)
 36a:	b8 02 00 00 00       	mov    $0x2,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <wait>:
SYSCALL(wait)
 372:	b8 03 00 00 00       	mov    $0x3,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <pipe>:
SYSCALL(pipe)
 37a:	b8 04 00 00 00       	mov    $0x4,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <read>:
SYSCALL(read)
 382:	b8 05 00 00 00       	mov    $0x5,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <write>:
SYSCALL(write)
 38a:	b8 10 00 00 00       	mov    $0x10,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <close>:
SYSCALL(close)
 392:	b8 15 00 00 00       	mov    $0x15,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <kill>:
SYSCALL(kill)
 39a:	b8 06 00 00 00       	mov    $0x6,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <exec>:
SYSCALL(exec)
 3a2:	b8 07 00 00 00       	mov    $0x7,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <open>:
SYSCALL(open)
 3aa:	b8 0f 00 00 00       	mov    $0xf,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <mknod>:
SYSCALL(mknod)
 3b2:	b8 11 00 00 00       	mov    $0x11,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <unlink>:
SYSCALL(unlink)
 3ba:	b8 12 00 00 00       	mov    $0x12,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <fstat>:
SYSCALL(fstat)
 3c2:	b8 08 00 00 00       	mov    $0x8,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <link>:
SYSCALL(link)
 3ca:	b8 13 00 00 00       	mov    $0x13,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <mkdir>:
SYSCALL(mkdir)
 3d2:	b8 14 00 00 00       	mov    $0x14,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <chdir>:
SYSCALL(chdir)
 3da:	b8 09 00 00 00       	mov    $0x9,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <dup>:
SYSCALL(dup)
 3e2:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <getpid>:
SYSCALL(getpid)
 3ea:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <sbrk>:
SYSCALL(sbrk)
 3f2:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <sleep>:
SYSCALL(sleep)
 3fa:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <uptime>:
SYSCALL(uptime)
 402:	b8 0e 00 00 00       	mov    $0xe,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40a:	55                   	push   %ebp
 40b:	89 e5                	mov    %esp,%ebp
 40d:	83 ec 18             	sub    $0x18,%esp
 410:	8b 45 0c             	mov    0xc(%ebp),%eax
 413:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 416:	83 ec 04             	sub    $0x4,%esp
 419:	6a 01                	push   $0x1
 41b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 41e:	50                   	push   %eax
 41f:	ff 75 08             	pushl  0x8(%ebp)
 422:	e8 63 ff ff ff       	call   38a <write>
 427:	83 c4 10             	add    $0x10,%esp
}
 42a:	90                   	nop
 42b:	c9                   	leave  
 42c:	c3                   	ret    

0000042d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 42d:	55                   	push   %ebp
 42e:	89 e5                	mov    %esp,%ebp
 430:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 433:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 43a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 43e:	74 17                	je     457 <printint+0x2a>
 440:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 444:	79 11                	jns    457 <printint+0x2a>
    neg = 1;
 446:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 44d:	8b 45 0c             	mov    0xc(%ebp),%eax
 450:	f7 d8                	neg    %eax
 452:	89 45 ec             	mov    %eax,-0x14(%ebp)
 455:	eb 06                	jmp    45d <printint+0x30>
  } else {
    x = xx;
 457:	8b 45 0c             	mov    0xc(%ebp),%eax
 45a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 45d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 464:	8b 4d 10             	mov    0x10(%ebp),%ecx
 467:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46a:	ba 00 00 00 00       	mov    $0x0,%edx
 46f:	f7 f1                	div    %ecx
 471:	89 d1                	mov    %edx,%ecx
 473:	8b 45 f4             	mov    -0xc(%ebp),%eax
 476:	8d 50 01             	lea    0x1(%eax),%edx
 479:	89 55 f4             	mov    %edx,-0xc(%ebp)
 47c:	8a 91 cc 08 00 00    	mov    0x8cc(%ecx),%dl
 482:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 486:	8b 4d 10             	mov    0x10(%ebp),%ecx
 489:	8b 45 ec             	mov    -0x14(%ebp),%eax
 48c:	ba 00 00 00 00       	mov    $0x0,%edx
 491:	f7 f1                	div    %ecx
 493:	89 45 ec             	mov    %eax,-0x14(%ebp)
 496:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 49a:	75 c8                	jne    464 <printint+0x37>
  if(neg)
 49c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4a0:	74 2c                	je     4ce <printint+0xa1>
    buf[i++] = '-';
 4a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a5:	8d 50 01             	lea    0x1(%eax),%edx
 4a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4ab:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4b0:	eb 1c                	jmp    4ce <printint+0xa1>
    putc(fd, buf[i]);
 4b2:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4b8:	01 d0                	add    %edx,%eax
 4ba:	8a 00                	mov    (%eax),%al
 4bc:	0f be c0             	movsbl %al,%eax
 4bf:	83 ec 08             	sub    $0x8,%esp
 4c2:	50                   	push   %eax
 4c3:	ff 75 08             	pushl  0x8(%ebp)
 4c6:	e8 3f ff ff ff       	call   40a <putc>
 4cb:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4ce:	ff 4d f4             	decl   -0xc(%ebp)
 4d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4d5:	79 db                	jns    4b2 <printint+0x85>
}
 4d7:	90                   	nop
 4d8:	90                   	nop
 4d9:	c9                   	leave  
 4da:	c3                   	ret    

000004db <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4db:	55                   	push   %ebp
 4dc:	89 e5                	mov    %esp,%ebp
 4de:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4e1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4e8:	8d 45 0c             	lea    0xc(%ebp),%eax
 4eb:	83 c0 04             	add    $0x4,%eax
 4ee:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4f1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4f8:	e9 54 01 00 00       	jmp    651 <printf+0x176>
    c = fmt[i] & 0xff;
 4fd:	8b 55 0c             	mov    0xc(%ebp),%edx
 500:	8b 45 f0             	mov    -0x10(%ebp),%eax
 503:	01 d0                	add    %edx,%eax
 505:	8a 00                	mov    (%eax),%al
 507:	0f be c0             	movsbl %al,%eax
 50a:	25 ff 00 00 00       	and    $0xff,%eax
 50f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 512:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 516:	75 2c                	jne    544 <printf+0x69>
      if(c == '%'){
 518:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 51c:	75 0c                	jne    52a <printf+0x4f>
        state = '%';
 51e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 525:	e9 24 01 00 00       	jmp    64e <printf+0x173>
      } else {
        putc(fd, c);
 52a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 52d:	0f be c0             	movsbl %al,%eax
 530:	83 ec 08             	sub    $0x8,%esp
 533:	50                   	push   %eax
 534:	ff 75 08             	pushl  0x8(%ebp)
 537:	e8 ce fe ff ff       	call   40a <putc>
 53c:	83 c4 10             	add    $0x10,%esp
 53f:	e9 0a 01 00 00       	jmp    64e <printf+0x173>
      }
    } else if(state == '%'){
 544:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 548:	0f 85 00 01 00 00    	jne    64e <printf+0x173>
      if(c == 'd'){
 54e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 552:	75 1e                	jne    572 <printf+0x97>
        printint(fd, *ap, 10, 1);
 554:	8b 45 e8             	mov    -0x18(%ebp),%eax
 557:	8b 00                	mov    (%eax),%eax
 559:	6a 01                	push   $0x1
 55b:	6a 0a                	push   $0xa
 55d:	50                   	push   %eax
 55e:	ff 75 08             	pushl  0x8(%ebp)
 561:	e8 c7 fe ff ff       	call   42d <printint>
 566:	83 c4 10             	add    $0x10,%esp
        ap++;
 569:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56d:	e9 d5 00 00 00       	jmp    647 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 572:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 576:	74 06                	je     57e <printf+0xa3>
 578:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 57c:	75 1e                	jne    59c <printf+0xc1>
        printint(fd, *ap, 16, 0);
 57e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 581:	8b 00                	mov    (%eax),%eax
 583:	6a 00                	push   $0x0
 585:	6a 10                	push   $0x10
 587:	50                   	push   %eax
 588:	ff 75 08             	pushl  0x8(%ebp)
 58b:	e8 9d fe ff ff       	call   42d <printint>
 590:	83 c4 10             	add    $0x10,%esp
        ap++;
 593:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 597:	e9 ab 00 00 00       	jmp    647 <printf+0x16c>
      } else if(c == 's'){
 59c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5a0:	75 40                	jne    5e2 <printf+0x107>
        s = (char*)*ap;
 5a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a5:	8b 00                	mov    (%eax),%eax
 5a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5b2:	75 23                	jne    5d7 <printf+0xfc>
          s = "(null)";
 5b4:	c7 45 f4 c2 08 00 00 	movl   $0x8c2,-0xc(%ebp)
        while(*s != 0){
 5bb:	eb 1a                	jmp    5d7 <printf+0xfc>
          putc(fd, *s);
 5bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c0:	8a 00                	mov    (%eax),%al
 5c2:	0f be c0             	movsbl %al,%eax
 5c5:	83 ec 08             	sub    $0x8,%esp
 5c8:	50                   	push   %eax
 5c9:	ff 75 08             	pushl  0x8(%ebp)
 5cc:	e8 39 fe ff ff       	call   40a <putc>
 5d1:	83 c4 10             	add    $0x10,%esp
          s++;
 5d4:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 5d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5da:	8a 00                	mov    (%eax),%al
 5dc:	84 c0                	test   %al,%al
 5de:	75 dd                	jne    5bd <printf+0xe2>
 5e0:	eb 65                	jmp    647 <printf+0x16c>
        }
      } else if(c == 'c'){
 5e2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5e6:	75 1d                	jne    605 <printf+0x12a>
        putc(fd, *ap);
 5e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5eb:	8b 00                	mov    (%eax),%eax
 5ed:	0f be c0             	movsbl %al,%eax
 5f0:	83 ec 08             	sub    $0x8,%esp
 5f3:	50                   	push   %eax
 5f4:	ff 75 08             	pushl  0x8(%ebp)
 5f7:	e8 0e fe ff ff       	call   40a <putc>
 5fc:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 603:	eb 42                	jmp    647 <printf+0x16c>
      } else if(c == '%'){
 605:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 609:	75 17                	jne    622 <printf+0x147>
        putc(fd, c);
 60b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60e:	0f be c0             	movsbl %al,%eax
 611:	83 ec 08             	sub    $0x8,%esp
 614:	50                   	push   %eax
 615:	ff 75 08             	pushl  0x8(%ebp)
 618:	e8 ed fd ff ff       	call   40a <putc>
 61d:	83 c4 10             	add    $0x10,%esp
 620:	eb 25                	jmp    647 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 622:	83 ec 08             	sub    $0x8,%esp
 625:	6a 25                	push   $0x25
 627:	ff 75 08             	pushl  0x8(%ebp)
 62a:	e8 db fd ff ff       	call   40a <putc>
 62f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 632:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 635:	0f be c0             	movsbl %al,%eax
 638:	83 ec 08             	sub    $0x8,%esp
 63b:	50                   	push   %eax
 63c:	ff 75 08             	pushl  0x8(%ebp)
 63f:	e8 c6 fd ff ff       	call   40a <putc>
 644:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 647:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 64e:	ff 45 f0             	incl   -0x10(%ebp)
 651:	8b 55 0c             	mov    0xc(%ebp),%edx
 654:	8b 45 f0             	mov    -0x10(%ebp),%eax
 657:	01 d0                	add    %edx,%eax
 659:	8a 00                	mov    (%eax),%al
 65b:	84 c0                	test   %al,%al
 65d:	0f 85 9a fe ff ff    	jne    4fd <printf+0x22>
    }
  }
}
 663:	90                   	nop
 664:	90                   	nop
 665:	c9                   	leave  
 666:	c3                   	ret    

00000667 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 667:	55                   	push   %ebp
 668:	89 e5                	mov    %esp,%ebp
 66a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 66d:	8b 45 08             	mov    0x8(%ebp),%eax
 670:	83 e8 08             	sub    $0x8,%eax
 673:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 676:	a1 e8 0a 00 00       	mov    0xae8,%eax
 67b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 67e:	eb 24                	jmp    6a4 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	8b 45 fc             	mov    -0x4(%ebp),%eax
 683:	8b 00                	mov    (%eax),%eax
 685:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 688:	72 12                	jb     69c <free+0x35>
 68a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68d:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 690:	72 24                	jb     6b6 <free+0x4f>
 692:	8b 45 fc             	mov    -0x4(%ebp),%eax
 695:	8b 00                	mov    (%eax),%eax
 697:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 69a:	72 1a                	jb     6b6 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	8b 00                	mov    (%eax),%eax
 6a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a7:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 6aa:	73 d4                	jae    680 <free+0x19>
 6ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6af:	8b 00                	mov    (%eax),%eax
 6b1:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6b4:	73 ca                	jae    680 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b9:	8b 40 04             	mov    0x4(%eax),%eax
 6bc:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c6:	01 c2                	add    %eax,%edx
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 00                	mov    (%eax),%eax
 6cd:	39 c2                	cmp    %eax,%edx
 6cf:	75 24                	jne    6f5 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d4:	8b 50 04             	mov    0x4(%eax),%edx
 6d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6da:	8b 00                	mov    (%eax),%eax
 6dc:	8b 40 04             	mov    0x4(%eax),%eax
 6df:	01 c2                	add    %eax,%edx
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ea:	8b 00                	mov    (%eax),%eax
 6ec:	8b 10                	mov    (%eax),%edx
 6ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f1:	89 10                	mov    %edx,(%eax)
 6f3:	eb 0a                	jmp    6ff <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	8b 10                	mov    (%eax),%edx
 6fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fd:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	8b 40 04             	mov    0x4(%eax),%eax
 705:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	01 d0                	add    %edx,%eax
 711:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 714:	75 20                	jne    736 <free+0xcf>
    p->s.size += bp->s.size;
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	8b 50 04             	mov    0x4(%eax),%edx
 71c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71f:	8b 40 04             	mov    0x4(%eax),%eax
 722:	01 c2                	add    %eax,%edx
 724:	8b 45 fc             	mov    -0x4(%ebp),%eax
 727:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 72a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72d:	8b 10                	mov    (%eax),%edx
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	89 10                	mov    %edx,(%eax)
 734:	eb 08                	jmp    73e <free+0xd7>
  } else
    p->s.ptr = bp;
 736:	8b 45 fc             	mov    -0x4(%ebp),%eax
 739:	8b 55 f8             	mov    -0x8(%ebp),%edx
 73c:	89 10                	mov    %edx,(%eax)
  freep = p;
 73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 741:	a3 e8 0a 00 00       	mov    %eax,0xae8
}
 746:	90                   	nop
 747:	c9                   	leave  
 748:	c3                   	ret    

00000749 <morecore>:

static Header*
morecore(uint nu)
{
 749:	55                   	push   %ebp
 74a:	89 e5                	mov    %esp,%ebp
 74c:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 74f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 756:	77 07                	ja     75f <morecore+0x16>
    nu = 4096;
 758:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 75f:	8b 45 08             	mov    0x8(%ebp),%eax
 762:	c1 e0 03             	shl    $0x3,%eax
 765:	83 ec 0c             	sub    $0xc,%esp
 768:	50                   	push   %eax
 769:	e8 84 fc ff ff       	call   3f2 <sbrk>
 76e:	83 c4 10             	add    $0x10,%esp
 771:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 774:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 778:	75 07                	jne    781 <morecore+0x38>
    return 0;
 77a:	b8 00 00 00 00       	mov    $0x0,%eax
 77f:	eb 26                	jmp    7a7 <morecore+0x5e>
  hp = (Header*)p;
 781:	8b 45 f4             	mov    -0xc(%ebp),%eax
 784:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 787:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78a:	8b 55 08             	mov    0x8(%ebp),%edx
 78d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 790:	8b 45 f0             	mov    -0x10(%ebp),%eax
 793:	83 c0 08             	add    $0x8,%eax
 796:	83 ec 0c             	sub    $0xc,%esp
 799:	50                   	push   %eax
 79a:	e8 c8 fe ff ff       	call   667 <free>
 79f:	83 c4 10             	add    $0x10,%esp
  return freep;
 7a2:	a1 e8 0a 00 00       	mov    0xae8,%eax
}
 7a7:	c9                   	leave  
 7a8:	c3                   	ret    

000007a9 <malloc>:

void*
malloc(uint nbytes)
{
 7a9:	55                   	push   %ebp
 7aa:	89 e5                	mov    %esp,%ebp
 7ac:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7af:	8b 45 08             	mov    0x8(%ebp),%eax
 7b2:	83 c0 07             	add    $0x7,%eax
 7b5:	c1 e8 03             	shr    $0x3,%eax
 7b8:	40                   	inc    %eax
 7b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7bc:	a1 e8 0a 00 00       	mov    0xae8,%eax
 7c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7c8:	75 23                	jne    7ed <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 7ca:	c7 45 f0 e0 0a 00 00 	movl   $0xae0,-0x10(%ebp)
 7d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d4:	a3 e8 0a 00 00       	mov    %eax,0xae8
 7d9:	a1 e8 0a 00 00       	mov    0xae8,%eax
 7de:	a3 e0 0a 00 00       	mov    %eax,0xae0
    base.s.size = 0;
 7e3:	c7 05 e4 0a 00 00 00 	movl   $0x0,0xae4
 7ea:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f0:	8b 00                	mov    (%eax),%eax
 7f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f8:	8b 40 04             	mov    0x4(%eax),%eax
 7fb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7fe:	72 4d                	jb     84d <malloc+0xa4>
      if(p->s.size == nunits)
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	8b 40 04             	mov    0x4(%eax),%eax
 806:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 809:	75 0c                	jne    817 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	8b 10                	mov    (%eax),%edx
 810:	8b 45 f0             	mov    -0x10(%ebp),%eax
 813:	89 10                	mov    %edx,(%eax)
 815:	eb 26                	jmp    83d <malloc+0x94>
      else {
        p->s.size -= nunits;
 817:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81a:	8b 40 04             	mov    0x4(%eax),%eax
 81d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 820:	89 c2                	mov    %eax,%edx
 822:	8b 45 f4             	mov    -0xc(%ebp),%eax
 825:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 40 04             	mov    0x4(%eax),%eax
 82e:	c1 e0 03             	shl    $0x3,%eax
 831:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 834:	8b 45 f4             	mov    -0xc(%ebp),%eax
 837:	8b 55 ec             	mov    -0x14(%ebp),%edx
 83a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 83d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 840:	a3 e8 0a 00 00       	mov    %eax,0xae8
      return (void*)(p + 1);
 845:	8b 45 f4             	mov    -0xc(%ebp),%eax
 848:	83 c0 08             	add    $0x8,%eax
 84b:	eb 3b                	jmp    888 <malloc+0xdf>
    }
    if(p == freep)
 84d:	a1 e8 0a 00 00       	mov    0xae8,%eax
 852:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 855:	75 1e                	jne    875 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 857:	83 ec 0c             	sub    $0xc,%esp
 85a:	ff 75 ec             	pushl  -0x14(%ebp)
 85d:	e8 e7 fe ff ff       	call   749 <morecore>
 862:	83 c4 10             	add    $0x10,%esp
 865:	89 45 f4             	mov    %eax,-0xc(%ebp)
 868:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 86c:	75 07                	jne    875 <malloc+0xcc>
        return 0;
 86e:	b8 00 00 00 00       	mov    $0x0,%eax
 873:	eb 13                	jmp    888 <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 875:	8b 45 f4             	mov    -0xc(%ebp),%eax
 878:	89 45 f0             	mov    %eax,-0x10(%ebp)
 87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87e:	8b 00                	mov    (%eax),%eax
 880:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 883:	e9 6d ff ff ff       	jmp    7f5 <malloc+0x4c>
  }
}
 888:	c9                   	leave  
 889:	c3                   	ret    
