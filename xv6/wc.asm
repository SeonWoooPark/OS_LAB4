
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 63                	jmp    85 <wc+0x85>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 52                	jmp    7d <wc+0x7d>
      c++;
  2b:	ff 45 e8             	incl   -0x18(%ebp)
      if(buf[i] == '\n')
  2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  31:	05 80 09 00 00       	add    $0x980,%eax
  36:	8a 00                	mov    (%eax),%al
  38:	3c 0a                	cmp    $0xa,%al
  3a:	75 03                	jne    3f <wc+0x3f>
        l++;
  3c:	ff 45 f0             	incl   -0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  42:	05 80 09 00 00       	add    $0x980,%eax
  47:	8a 00                	mov    (%eax),%al
  49:	0f be c0             	movsbl %al,%eax
  4c:	83 ec 08             	sub    $0x8,%esp
  4f:	50                   	push   %eax
  50:	68 16 09 00 00       	push   $0x916
  55:	e8 27 02 00 00       	call   281 <strchr>
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	85 c0                	test   %eax,%eax
  5f:	74 09                	je     6a <wc+0x6a>
        inword = 0;
  61:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  68:	eb 10                	jmp    7a <wc+0x7a>
      else if(!inword){
  6a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  6e:	75 0a                	jne    7a <wc+0x7a>
        w++;
  70:	ff 45 ec             	incl   -0x14(%ebp)
        inword = 1;
  73:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
  7a:	ff 45 f4             	incl   -0xc(%ebp)
  7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  83:	7c a6                	jl     2b <wc+0x2b>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  85:	83 ec 04             	sub    $0x4,%esp
  88:	68 00 02 00 00       	push   $0x200
  8d:	68 80 09 00 00       	push   $0x980
  92:	ff 75 08             	pushl  0x8(%ebp)
  95:	e8 74 03 00 00       	call   40e <read>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  a4:	0f 8f 78 ff ff ff    	jg     22 <wc+0x22>
      }
    }
  }
  if(n < 0){
  aa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  ae:	79 17                	jns    c7 <wc+0xc7>
    printf(1, "wc: read error\n");
  b0:	83 ec 08             	sub    $0x8,%esp
  b3:	68 1c 09 00 00       	push   $0x91c
  b8:	6a 01                	push   $0x1
  ba:	e8 a8 04 00 00       	call   567 <printf>
  bf:	83 c4 10             	add    $0x10,%esp
    exit();
  c2:	e8 2f 03 00 00       	call   3f6 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  c7:	83 ec 08             	sub    $0x8,%esp
  ca:	ff 75 0c             	pushl  0xc(%ebp)
  cd:	ff 75 e8             	pushl  -0x18(%ebp)
  d0:	ff 75 ec             	pushl  -0x14(%ebp)
  d3:	ff 75 f0             	pushl  -0x10(%ebp)
  d6:	68 2c 09 00 00       	push   $0x92c
  db:	6a 01                	push   $0x1
  dd:	e8 85 04 00 00       	call   567 <printf>
  e2:	83 c4 20             	add    $0x20,%esp
}
  e5:	90                   	nop
  e6:	c9                   	leave  
  e7:	c3                   	ret    

000000e8 <main>:

int
main(int argc, char *argv[])
{
  e8:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  ec:	83 e4 f0             	and    $0xfffffff0,%esp
  ef:	ff 71 fc             	pushl  -0x4(%ecx)
  f2:	55                   	push   %ebp
  f3:	89 e5                	mov    %esp,%ebp
  f5:	53                   	push   %ebx
  f6:	51                   	push   %ecx
  f7:	83 ec 10             	sub    $0x10,%esp
  fa:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  fc:	83 3b 01             	cmpl   $0x1,(%ebx)
  ff:	7f 17                	jg     118 <main+0x30>
    wc(0, "");
 101:	83 ec 08             	sub    $0x8,%esp
 104:	68 39 09 00 00       	push   $0x939
 109:	6a 00                	push   $0x0
 10b:	e8 f0 fe ff ff       	call   0 <wc>
 110:	83 c4 10             	add    $0x10,%esp
    exit();
 113:	e8 de 02 00 00       	call   3f6 <exit>
  }

  for(i = 1; i < argc; i++){
 118:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 11f:	e9 82 00 00 00       	jmp    1a6 <main+0xbe>
    if((fd = open(argv[i], 0)) < 0){
 124:	8b 45 f4             	mov    -0xc(%ebp),%eax
 127:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 12e:	8b 43 04             	mov    0x4(%ebx),%eax
 131:	01 d0                	add    %edx,%eax
 133:	8b 00                	mov    (%eax),%eax
 135:	83 ec 08             	sub    $0x8,%esp
 138:	6a 00                	push   $0x0
 13a:	50                   	push   %eax
 13b:	e8 f6 02 00 00       	call   436 <open>
 140:	83 c4 10             	add    $0x10,%esp
 143:	89 45 f0             	mov    %eax,-0x10(%ebp)
 146:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 14a:	79 29                	jns    175 <main+0x8d>
      printf(1, "wc: cannot open %s\n", argv[i]);
 14c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 14f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 156:	8b 43 04             	mov    0x4(%ebx),%eax
 159:	01 d0                	add    %edx,%eax
 15b:	8b 00                	mov    (%eax),%eax
 15d:	83 ec 04             	sub    $0x4,%esp
 160:	50                   	push   %eax
 161:	68 3a 09 00 00       	push   $0x93a
 166:	6a 01                	push   $0x1
 168:	e8 fa 03 00 00       	call   567 <printf>
 16d:	83 c4 10             	add    $0x10,%esp
      exit();
 170:	e8 81 02 00 00       	call   3f6 <exit>
    }
    wc(fd, argv[i]);
 175:	8b 45 f4             	mov    -0xc(%ebp),%eax
 178:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 17f:	8b 43 04             	mov    0x4(%ebx),%eax
 182:	01 d0                	add    %edx,%eax
 184:	8b 00                	mov    (%eax),%eax
 186:	83 ec 08             	sub    $0x8,%esp
 189:	50                   	push   %eax
 18a:	ff 75 f0             	pushl  -0x10(%ebp)
 18d:	e8 6e fe ff ff       	call   0 <wc>
 192:	83 c4 10             	add    $0x10,%esp
    close(fd);
 195:	83 ec 0c             	sub    $0xc,%esp
 198:	ff 75 f0             	pushl  -0x10(%ebp)
 19b:	e8 7e 02 00 00       	call   41e <close>
 1a0:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 1a3:	ff 45 f4             	incl   -0xc(%ebp)
 1a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a9:	3b 03                	cmp    (%ebx),%eax
 1ab:	0f 8c 73 ff ff ff    	jl     124 <main+0x3c>
  }
  exit();
 1b1:	e8 40 02 00 00       	call   3f6 <exit>

000001b6 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b6:	55                   	push   %ebp
 1b7:	89 e5                	mov    %esp,%ebp
 1b9:	57                   	push   %edi
 1ba:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1be:	8b 55 10             	mov    0x10(%ebp),%edx
 1c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c4:	89 cb                	mov    %ecx,%ebx
 1c6:	89 df                	mov    %ebx,%edi
 1c8:	89 d1                	mov    %edx,%ecx
 1ca:	fc                   	cld    
 1cb:	f3 aa                	rep stos %al,%es:(%edi)
 1cd:	89 ca                	mov    %ecx,%edx
 1cf:	89 fb                	mov    %edi,%ebx
 1d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d7:	90                   	nop
 1d8:	5b                   	pop    %ebx
 1d9:	5f                   	pop    %edi
 1da:	5d                   	pop    %ebp
 1db:	c3                   	ret    

000001dc <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e8:	90                   	nop
 1e9:	8b 55 0c             	mov    0xc(%ebp),%edx
 1ec:	8d 42 01             	lea    0x1(%edx),%eax
 1ef:	89 45 0c             	mov    %eax,0xc(%ebp)
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
 1f5:	8d 48 01             	lea    0x1(%eax),%ecx
 1f8:	89 4d 08             	mov    %ecx,0x8(%ebp)
 1fb:	8a 12                	mov    (%edx),%dl
 1fd:	88 10                	mov    %dl,(%eax)
 1ff:	8a 00                	mov    (%eax),%al
 201:	84 c0                	test   %al,%al
 203:	75 e4                	jne    1e9 <strcpy+0xd>
    ;
  return os;
 205:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 208:	c9                   	leave  
 209:	c3                   	ret    

0000020a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 20a:	55                   	push   %ebp
 20b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 20d:	eb 06                	jmp    215 <strcmp+0xb>
    p++, q++;
 20f:	ff 45 08             	incl   0x8(%ebp)
 212:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	8a 00                	mov    (%eax),%al
 21a:	84 c0                	test   %al,%al
 21c:	74 0e                	je     22c <strcmp+0x22>
 21e:	8b 45 08             	mov    0x8(%ebp),%eax
 221:	8a 10                	mov    (%eax),%dl
 223:	8b 45 0c             	mov    0xc(%ebp),%eax
 226:	8a 00                	mov    (%eax),%al
 228:	38 c2                	cmp    %al,%dl
 22a:	74 e3                	je     20f <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	8a 00                	mov    (%eax),%al
 231:	0f b6 d0             	movzbl %al,%edx
 234:	8b 45 0c             	mov    0xc(%ebp),%eax
 237:	8a 00                	mov    (%eax),%al
 239:	0f b6 c0             	movzbl %al,%eax
 23c:	29 c2                	sub    %eax,%edx
 23e:	89 d0                	mov    %edx,%eax
}
 240:	5d                   	pop    %ebp
 241:	c3                   	ret    

00000242 <strlen>:

uint
strlen(char *s)
{
 242:	55                   	push   %ebp
 243:	89 e5                	mov    %esp,%ebp
 245:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 24f:	eb 03                	jmp    254 <strlen+0x12>
 251:	ff 45 fc             	incl   -0x4(%ebp)
 254:	8b 55 fc             	mov    -0x4(%ebp),%edx
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	01 d0                	add    %edx,%eax
 25c:	8a 00                	mov    (%eax),%al
 25e:	84 c0                	test   %al,%al
 260:	75 ef                	jne    251 <strlen+0xf>
    ;
  return n;
 262:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 265:	c9                   	leave  
 266:	c3                   	ret    

00000267 <memset>:

void*
memset(void *dst, int c, uint n)
{
 267:	55                   	push   %ebp
 268:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 26a:	8b 45 10             	mov    0x10(%ebp),%eax
 26d:	50                   	push   %eax
 26e:	ff 75 0c             	pushl  0xc(%ebp)
 271:	ff 75 08             	pushl  0x8(%ebp)
 274:	e8 3d ff ff ff       	call   1b6 <stosb>
 279:	83 c4 0c             	add    $0xc,%esp
  return dst;
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27f:	c9                   	leave  
 280:	c3                   	ret    

00000281 <strchr>:

char*
strchr(const char *s, char c)
{
 281:	55                   	push   %ebp
 282:	89 e5                	mov    %esp,%ebp
 284:	83 ec 04             	sub    $0x4,%esp
 287:	8b 45 0c             	mov    0xc(%ebp),%eax
 28a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 28d:	eb 12                	jmp    2a1 <strchr+0x20>
    if(*s == c)
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	8a 00                	mov    (%eax),%al
 294:	38 45 fc             	cmp    %al,-0x4(%ebp)
 297:	75 05                	jne    29e <strchr+0x1d>
      return (char*)s;
 299:	8b 45 08             	mov    0x8(%ebp),%eax
 29c:	eb 11                	jmp    2af <strchr+0x2e>
  for(; *s; s++)
 29e:	ff 45 08             	incl   0x8(%ebp)
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	8a 00                	mov    (%eax),%al
 2a6:	84 c0                	test   %al,%al
 2a8:	75 e5                	jne    28f <strchr+0xe>
  return 0;
 2aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2af:	c9                   	leave  
 2b0:	c3                   	ret    

000002b1 <gets>:

char*
gets(char *buf, int max)
{
 2b1:	55                   	push   %ebp
 2b2:	89 e5                	mov    %esp,%ebp
 2b4:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2be:	eb 3f                	jmp    2ff <gets+0x4e>
    cc = read(0, &c, 1);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	6a 01                	push   $0x1
 2c5:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2c8:	50                   	push   %eax
 2c9:	6a 00                	push   $0x0
 2cb:	e8 3e 01 00 00       	call   40e <read>
 2d0:	83 c4 10             	add    $0x10,%esp
 2d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2da:	7e 2e                	jle    30a <gets+0x59>
      break;
    buf[i++] = c;
 2dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2df:	8d 50 01             	lea    0x1(%eax),%edx
 2e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2e5:	89 c2                	mov    %eax,%edx
 2e7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ea:	01 c2                	add    %eax,%edx
 2ec:	8a 45 ef             	mov    -0x11(%ebp),%al
 2ef:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2f1:	8a 45 ef             	mov    -0x11(%ebp),%al
 2f4:	3c 0a                	cmp    $0xa,%al
 2f6:	74 13                	je     30b <gets+0x5a>
 2f8:	8a 45 ef             	mov    -0x11(%ebp),%al
 2fb:	3c 0d                	cmp    $0xd,%al
 2fd:	74 0c                	je     30b <gets+0x5a>
  for(i=0; i+1 < max; ){
 2ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 302:	40                   	inc    %eax
 303:	39 45 0c             	cmp    %eax,0xc(%ebp)
 306:	7f b8                	jg     2c0 <gets+0xf>
 308:	eb 01                	jmp    30b <gets+0x5a>
      break;
 30a:	90                   	nop
      break;
  }
  buf[i] = '\0';
 30b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 30e:	8b 45 08             	mov    0x8(%ebp),%eax
 311:	01 d0                	add    %edx,%eax
 313:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 316:	8b 45 08             	mov    0x8(%ebp),%eax
}
 319:	c9                   	leave  
 31a:	c3                   	ret    

0000031b <stat>:

int
stat(char *n, struct stat *st)
{
 31b:	55                   	push   %ebp
 31c:	89 e5                	mov    %esp,%ebp
 31e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 321:	83 ec 08             	sub    $0x8,%esp
 324:	6a 00                	push   $0x0
 326:	ff 75 08             	pushl  0x8(%ebp)
 329:	e8 08 01 00 00       	call   436 <open>
 32e:	83 c4 10             	add    $0x10,%esp
 331:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 334:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 338:	79 07                	jns    341 <stat+0x26>
    return -1;
 33a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 33f:	eb 25                	jmp    366 <stat+0x4b>
  r = fstat(fd, st);
 341:	83 ec 08             	sub    $0x8,%esp
 344:	ff 75 0c             	pushl  0xc(%ebp)
 347:	ff 75 f4             	pushl  -0xc(%ebp)
 34a:	e8 ff 00 00 00       	call   44e <fstat>
 34f:	83 c4 10             	add    $0x10,%esp
 352:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 355:	83 ec 0c             	sub    $0xc,%esp
 358:	ff 75 f4             	pushl  -0xc(%ebp)
 35b:	e8 be 00 00 00       	call   41e <close>
 360:	83 c4 10             	add    $0x10,%esp
  return r;
 363:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 366:	c9                   	leave  
 367:	c3                   	ret    

00000368 <atoi>:

int
atoi(const char *s)
{
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 36e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 375:	eb 24                	jmp    39b <atoi+0x33>
    n = n*10 + *s++ - '0';
 377:	8b 55 fc             	mov    -0x4(%ebp),%edx
 37a:	89 d0                	mov    %edx,%eax
 37c:	c1 e0 02             	shl    $0x2,%eax
 37f:	01 d0                	add    %edx,%eax
 381:	01 c0                	add    %eax,%eax
 383:	89 c1                	mov    %eax,%ecx
 385:	8b 45 08             	mov    0x8(%ebp),%eax
 388:	8d 50 01             	lea    0x1(%eax),%edx
 38b:	89 55 08             	mov    %edx,0x8(%ebp)
 38e:	8a 00                	mov    (%eax),%al
 390:	0f be c0             	movsbl %al,%eax
 393:	01 c8                	add    %ecx,%eax
 395:	83 e8 30             	sub    $0x30,%eax
 398:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 39b:	8b 45 08             	mov    0x8(%ebp),%eax
 39e:	8a 00                	mov    (%eax),%al
 3a0:	3c 2f                	cmp    $0x2f,%al
 3a2:	7e 09                	jle    3ad <atoi+0x45>
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	8a 00                	mov    (%eax),%al
 3a9:	3c 39                	cmp    $0x39,%al
 3ab:	7e ca                	jle    377 <atoi+0xf>
  return n;
 3ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3b0:	c9                   	leave  
 3b1:	c3                   	ret    

000003b2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b2:	55                   	push   %ebp
 3b3:	89 e5                	mov    %esp,%ebp
 3b5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 3b8:	8b 45 08             	mov    0x8(%ebp),%eax
 3bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3be:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3c4:	eb 16                	jmp    3dc <memmove+0x2a>
    *dst++ = *src++;
 3c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3c9:	8d 42 01             	lea    0x1(%edx),%eax
 3cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3d2:	8d 48 01             	lea    0x1(%eax),%ecx
 3d5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 3d8:	8a 12                	mov    (%edx),%dl
 3da:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3dc:	8b 45 10             	mov    0x10(%ebp),%eax
 3df:	8d 50 ff             	lea    -0x1(%eax),%edx
 3e2:	89 55 10             	mov    %edx,0x10(%ebp)
 3e5:	85 c0                	test   %eax,%eax
 3e7:	7f dd                	jg     3c6 <memmove+0x14>
  return vdst;
 3e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3ec:	c9                   	leave  
 3ed:	c3                   	ret    

000003ee <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ee:	b8 01 00 00 00       	mov    $0x1,%eax
 3f3:	cd 40                	int    $0x40
 3f5:	c3                   	ret    

000003f6 <exit>:
SYSCALL(exit)
 3f6:	b8 02 00 00 00       	mov    $0x2,%eax
 3fb:	cd 40                	int    $0x40
 3fd:	c3                   	ret    

000003fe <wait>:
SYSCALL(wait)
 3fe:	b8 03 00 00 00       	mov    $0x3,%eax
 403:	cd 40                	int    $0x40
 405:	c3                   	ret    

00000406 <pipe>:
SYSCALL(pipe)
 406:	b8 04 00 00 00       	mov    $0x4,%eax
 40b:	cd 40                	int    $0x40
 40d:	c3                   	ret    

0000040e <read>:
SYSCALL(read)
 40e:	b8 05 00 00 00       	mov    $0x5,%eax
 413:	cd 40                	int    $0x40
 415:	c3                   	ret    

00000416 <write>:
SYSCALL(write)
 416:	b8 10 00 00 00       	mov    $0x10,%eax
 41b:	cd 40                	int    $0x40
 41d:	c3                   	ret    

0000041e <close>:
SYSCALL(close)
 41e:	b8 15 00 00 00       	mov    $0x15,%eax
 423:	cd 40                	int    $0x40
 425:	c3                   	ret    

00000426 <kill>:
SYSCALL(kill)
 426:	b8 06 00 00 00       	mov    $0x6,%eax
 42b:	cd 40                	int    $0x40
 42d:	c3                   	ret    

0000042e <exec>:
SYSCALL(exec)
 42e:	b8 07 00 00 00       	mov    $0x7,%eax
 433:	cd 40                	int    $0x40
 435:	c3                   	ret    

00000436 <open>:
SYSCALL(open)
 436:	b8 0f 00 00 00       	mov    $0xf,%eax
 43b:	cd 40                	int    $0x40
 43d:	c3                   	ret    

0000043e <mknod>:
SYSCALL(mknod)
 43e:	b8 11 00 00 00       	mov    $0x11,%eax
 443:	cd 40                	int    $0x40
 445:	c3                   	ret    

00000446 <unlink>:
SYSCALL(unlink)
 446:	b8 12 00 00 00       	mov    $0x12,%eax
 44b:	cd 40                	int    $0x40
 44d:	c3                   	ret    

0000044e <fstat>:
SYSCALL(fstat)
 44e:	b8 08 00 00 00       	mov    $0x8,%eax
 453:	cd 40                	int    $0x40
 455:	c3                   	ret    

00000456 <link>:
SYSCALL(link)
 456:	b8 13 00 00 00       	mov    $0x13,%eax
 45b:	cd 40                	int    $0x40
 45d:	c3                   	ret    

0000045e <mkdir>:
SYSCALL(mkdir)
 45e:	b8 14 00 00 00       	mov    $0x14,%eax
 463:	cd 40                	int    $0x40
 465:	c3                   	ret    

00000466 <chdir>:
SYSCALL(chdir)
 466:	b8 09 00 00 00       	mov    $0x9,%eax
 46b:	cd 40                	int    $0x40
 46d:	c3                   	ret    

0000046e <dup>:
SYSCALL(dup)
 46e:	b8 0a 00 00 00       	mov    $0xa,%eax
 473:	cd 40                	int    $0x40
 475:	c3                   	ret    

00000476 <getpid>:
SYSCALL(getpid)
 476:	b8 0b 00 00 00       	mov    $0xb,%eax
 47b:	cd 40                	int    $0x40
 47d:	c3                   	ret    

0000047e <sbrk>:
SYSCALL(sbrk)
 47e:	b8 0c 00 00 00       	mov    $0xc,%eax
 483:	cd 40                	int    $0x40
 485:	c3                   	ret    

00000486 <sleep>:
SYSCALL(sleep)
 486:	b8 0d 00 00 00       	mov    $0xd,%eax
 48b:	cd 40                	int    $0x40
 48d:	c3                   	ret    

0000048e <uptime>:
SYSCALL(uptime)
 48e:	b8 0e 00 00 00       	mov    $0xe,%eax
 493:	cd 40                	int    $0x40
 495:	c3                   	ret    

00000496 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 496:	55                   	push   %ebp
 497:	89 e5                	mov    %esp,%ebp
 499:	83 ec 18             	sub    $0x18,%esp
 49c:	8b 45 0c             	mov    0xc(%ebp),%eax
 49f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4a2:	83 ec 04             	sub    $0x4,%esp
 4a5:	6a 01                	push   $0x1
 4a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4aa:	50                   	push   %eax
 4ab:	ff 75 08             	pushl  0x8(%ebp)
 4ae:	e8 63 ff ff ff       	call   416 <write>
 4b3:	83 c4 10             	add    $0x10,%esp
}
 4b6:	90                   	nop
 4b7:	c9                   	leave  
 4b8:	c3                   	ret    

000004b9 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b9:	55                   	push   %ebp
 4ba:	89 e5                	mov    %esp,%ebp
 4bc:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4c6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4ca:	74 17                	je     4e3 <printint+0x2a>
 4cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4d0:	79 11                	jns    4e3 <printint+0x2a>
    neg = 1;
 4d2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4d9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4dc:	f7 d8                	neg    %eax
 4de:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4e1:	eb 06                	jmp    4e9 <printint+0x30>
  } else {
    x = xx;
 4e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4f0:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4f6:	ba 00 00 00 00       	mov    $0x0,%edx
 4fb:	f7 f1                	div    %ecx
 4fd:	89 d1                	mov    %edx,%ecx
 4ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 502:	8d 50 01             	lea    0x1(%eax),%edx
 505:	89 55 f4             	mov    %edx,-0xc(%ebp)
 508:	8a 91 58 09 00 00    	mov    0x958(%ecx),%dl
 50e:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 512:	8b 4d 10             	mov    0x10(%ebp),%ecx
 515:	8b 45 ec             	mov    -0x14(%ebp),%eax
 518:	ba 00 00 00 00       	mov    $0x0,%edx
 51d:	f7 f1                	div    %ecx
 51f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 522:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 526:	75 c8                	jne    4f0 <printint+0x37>
  if(neg)
 528:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 52c:	74 2c                	je     55a <printint+0xa1>
    buf[i++] = '-';
 52e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 531:	8d 50 01             	lea    0x1(%eax),%edx
 534:	89 55 f4             	mov    %edx,-0xc(%ebp)
 537:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 53c:	eb 1c                	jmp    55a <printint+0xa1>
    putc(fd, buf[i]);
 53e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 541:	8b 45 f4             	mov    -0xc(%ebp),%eax
 544:	01 d0                	add    %edx,%eax
 546:	8a 00                	mov    (%eax),%al
 548:	0f be c0             	movsbl %al,%eax
 54b:	83 ec 08             	sub    $0x8,%esp
 54e:	50                   	push   %eax
 54f:	ff 75 08             	pushl  0x8(%ebp)
 552:	e8 3f ff ff ff       	call   496 <putc>
 557:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 55a:	ff 4d f4             	decl   -0xc(%ebp)
 55d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 561:	79 db                	jns    53e <printint+0x85>
}
 563:	90                   	nop
 564:	90                   	nop
 565:	c9                   	leave  
 566:	c3                   	ret    

00000567 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 567:	55                   	push   %ebp
 568:	89 e5                	mov    %esp,%ebp
 56a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 56d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 574:	8d 45 0c             	lea    0xc(%ebp),%eax
 577:	83 c0 04             	add    $0x4,%eax
 57a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 57d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 584:	e9 54 01 00 00       	jmp    6dd <printf+0x176>
    c = fmt[i] & 0xff;
 589:	8b 55 0c             	mov    0xc(%ebp),%edx
 58c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 58f:	01 d0                	add    %edx,%eax
 591:	8a 00                	mov    (%eax),%al
 593:	0f be c0             	movsbl %al,%eax
 596:	25 ff 00 00 00       	and    $0xff,%eax
 59b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 59e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5a2:	75 2c                	jne    5d0 <printf+0x69>
      if(c == '%'){
 5a4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5a8:	75 0c                	jne    5b6 <printf+0x4f>
        state = '%';
 5aa:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5b1:	e9 24 01 00 00       	jmp    6da <printf+0x173>
      } else {
        putc(fd, c);
 5b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b9:	0f be c0             	movsbl %al,%eax
 5bc:	83 ec 08             	sub    $0x8,%esp
 5bf:	50                   	push   %eax
 5c0:	ff 75 08             	pushl  0x8(%ebp)
 5c3:	e8 ce fe ff ff       	call   496 <putc>
 5c8:	83 c4 10             	add    $0x10,%esp
 5cb:	e9 0a 01 00 00       	jmp    6da <printf+0x173>
      }
    } else if(state == '%'){
 5d0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5d4:	0f 85 00 01 00 00    	jne    6da <printf+0x173>
      if(c == 'd'){
 5da:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5de:	75 1e                	jne    5fe <printf+0x97>
        printint(fd, *ap, 10, 1);
 5e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e3:	8b 00                	mov    (%eax),%eax
 5e5:	6a 01                	push   $0x1
 5e7:	6a 0a                	push   $0xa
 5e9:	50                   	push   %eax
 5ea:	ff 75 08             	pushl  0x8(%ebp)
 5ed:	e8 c7 fe ff ff       	call   4b9 <printint>
 5f2:	83 c4 10             	add    $0x10,%esp
        ap++;
 5f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f9:	e9 d5 00 00 00       	jmp    6d3 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 5fe:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 602:	74 06                	je     60a <printf+0xa3>
 604:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 608:	75 1e                	jne    628 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 60a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60d:	8b 00                	mov    (%eax),%eax
 60f:	6a 00                	push   $0x0
 611:	6a 10                	push   $0x10
 613:	50                   	push   %eax
 614:	ff 75 08             	pushl  0x8(%ebp)
 617:	e8 9d fe ff ff       	call   4b9 <printint>
 61c:	83 c4 10             	add    $0x10,%esp
        ap++;
 61f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 623:	e9 ab 00 00 00       	jmp    6d3 <printf+0x16c>
      } else if(c == 's'){
 628:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 62c:	75 40                	jne    66e <printf+0x107>
        s = (char*)*ap;
 62e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 631:	8b 00                	mov    (%eax),%eax
 633:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 636:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 63a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 63e:	75 23                	jne    663 <printf+0xfc>
          s = "(null)";
 640:	c7 45 f4 4e 09 00 00 	movl   $0x94e,-0xc(%ebp)
        while(*s != 0){
 647:	eb 1a                	jmp    663 <printf+0xfc>
          putc(fd, *s);
 649:	8b 45 f4             	mov    -0xc(%ebp),%eax
 64c:	8a 00                	mov    (%eax),%al
 64e:	0f be c0             	movsbl %al,%eax
 651:	83 ec 08             	sub    $0x8,%esp
 654:	50                   	push   %eax
 655:	ff 75 08             	pushl  0x8(%ebp)
 658:	e8 39 fe ff ff       	call   496 <putc>
 65d:	83 c4 10             	add    $0x10,%esp
          s++;
 660:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 663:	8b 45 f4             	mov    -0xc(%ebp),%eax
 666:	8a 00                	mov    (%eax),%al
 668:	84 c0                	test   %al,%al
 66a:	75 dd                	jne    649 <printf+0xe2>
 66c:	eb 65                	jmp    6d3 <printf+0x16c>
        }
      } else if(c == 'c'){
 66e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 672:	75 1d                	jne    691 <printf+0x12a>
        putc(fd, *ap);
 674:	8b 45 e8             	mov    -0x18(%ebp),%eax
 677:	8b 00                	mov    (%eax),%eax
 679:	0f be c0             	movsbl %al,%eax
 67c:	83 ec 08             	sub    $0x8,%esp
 67f:	50                   	push   %eax
 680:	ff 75 08             	pushl  0x8(%ebp)
 683:	e8 0e fe ff ff       	call   496 <putc>
 688:	83 c4 10             	add    $0x10,%esp
        ap++;
 68b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68f:	eb 42                	jmp    6d3 <printf+0x16c>
      } else if(c == '%'){
 691:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 695:	75 17                	jne    6ae <printf+0x147>
        putc(fd, c);
 697:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 69a:	0f be c0             	movsbl %al,%eax
 69d:	83 ec 08             	sub    $0x8,%esp
 6a0:	50                   	push   %eax
 6a1:	ff 75 08             	pushl  0x8(%ebp)
 6a4:	e8 ed fd ff ff       	call   496 <putc>
 6a9:	83 c4 10             	add    $0x10,%esp
 6ac:	eb 25                	jmp    6d3 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ae:	83 ec 08             	sub    $0x8,%esp
 6b1:	6a 25                	push   $0x25
 6b3:	ff 75 08             	pushl  0x8(%ebp)
 6b6:	e8 db fd ff ff       	call   496 <putc>
 6bb:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6c1:	0f be c0             	movsbl %al,%eax
 6c4:	83 ec 08             	sub    $0x8,%esp
 6c7:	50                   	push   %eax
 6c8:	ff 75 08             	pushl  0x8(%ebp)
 6cb:	e8 c6 fd ff ff       	call   496 <putc>
 6d0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6d3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 6da:	ff 45 f0             	incl   -0x10(%ebp)
 6dd:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e3:	01 d0                	add    %edx,%eax
 6e5:	8a 00                	mov    (%eax),%al
 6e7:	84 c0                	test   %al,%al
 6e9:	0f 85 9a fe ff ff    	jne    589 <printf+0x22>
    }
  }
}
 6ef:	90                   	nop
 6f0:	90                   	nop
 6f1:	c9                   	leave  
 6f2:	c3                   	ret    

000006f3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f3:	55                   	push   %ebp
 6f4:	89 e5                	mov    %esp,%ebp
 6f6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
 6fc:	83 e8 08             	sub    $0x8,%eax
 6ff:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 702:	a1 88 0b 00 00       	mov    0xb88,%eax
 707:	89 45 fc             	mov    %eax,-0x4(%ebp)
 70a:	eb 24                	jmp    730 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	8b 00                	mov    (%eax),%eax
 711:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 714:	72 12                	jb     728 <free+0x35>
 716:	8b 45 f8             	mov    -0x8(%ebp),%eax
 719:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 71c:	72 24                	jb     742 <free+0x4f>
 71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 721:	8b 00                	mov    (%eax),%eax
 723:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 726:	72 1a                	jb     742 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 728:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72b:	8b 00                	mov    (%eax),%eax
 72d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 730:	8b 45 f8             	mov    -0x8(%ebp),%eax
 733:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 736:	73 d4                	jae    70c <free+0x19>
 738:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73b:	8b 00                	mov    (%eax),%eax
 73d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 740:	73 ca                	jae    70c <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 742:	8b 45 f8             	mov    -0x8(%ebp),%eax
 745:	8b 40 04             	mov    0x4(%eax),%eax
 748:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 74f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 752:	01 c2                	add    %eax,%edx
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	8b 00                	mov    (%eax),%eax
 759:	39 c2                	cmp    %eax,%edx
 75b:	75 24                	jne    781 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 75d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 760:	8b 50 04             	mov    0x4(%eax),%edx
 763:	8b 45 fc             	mov    -0x4(%ebp),%eax
 766:	8b 00                	mov    (%eax),%eax
 768:	8b 40 04             	mov    0x4(%eax),%eax
 76b:	01 c2                	add    %eax,%edx
 76d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 770:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 773:	8b 45 fc             	mov    -0x4(%ebp),%eax
 776:	8b 00                	mov    (%eax),%eax
 778:	8b 10                	mov    (%eax),%edx
 77a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77d:	89 10                	mov    %edx,(%eax)
 77f:	eb 0a                	jmp    78b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 781:	8b 45 fc             	mov    -0x4(%ebp),%eax
 784:	8b 10                	mov    (%eax),%edx
 786:	8b 45 f8             	mov    -0x8(%ebp),%eax
 789:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 78b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78e:	8b 40 04             	mov    0x4(%eax),%eax
 791:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	01 d0                	add    %edx,%eax
 79d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7a0:	75 20                	jne    7c2 <free+0xcf>
    p->s.size += bp->s.size;
 7a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a5:	8b 50 04             	mov    0x4(%eax),%edx
 7a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ab:	8b 40 04             	mov    0x4(%eax),%eax
 7ae:	01 c2                	add    %eax,%edx
 7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b9:	8b 10                	mov    (%eax),%edx
 7bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7be:	89 10                	mov    %edx,(%eax)
 7c0:	eb 08                	jmp    7ca <free+0xd7>
  } else
    p->s.ptr = bp;
 7c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7c8:	89 10                	mov    %edx,(%eax)
  freep = p;
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	a3 88 0b 00 00       	mov    %eax,0xb88
}
 7d2:	90                   	nop
 7d3:	c9                   	leave  
 7d4:	c3                   	ret    

000007d5 <morecore>:

static Header*
morecore(uint nu)
{
 7d5:	55                   	push   %ebp
 7d6:	89 e5                	mov    %esp,%ebp
 7d8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7db:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e2:	77 07                	ja     7eb <morecore+0x16>
    nu = 4096;
 7e4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7eb:	8b 45 08             	mov    0x8(%ebp),%eax
 7ee:	c1 e0 03             	shl    $0x3,%eax
 7f1:	83 ec 0c             	sub    $0xc,%esp
 7f4:	50                   	push   %eax
 7f5:	e8 84 fc ff ff       	call   47e <sbrk>
 7fa:	83 c4 10             	add    $0x10,%esp
 7fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 800:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 804:	75 07                	jne    80d <morecore+0x38>
    return 0;
 806:	b8 00 00 00 00       	mov    $0x0,%eax
 80b:	eb 26                	jmp    833 <morecore+0x5e>
  hp = (Header*)p;
 80d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 810:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 813:	8b 45 f0             	mov    -0x10(%ebp),%eax
 816:	8b 55 08             	mov    0x8(%ebp),%edx
 819:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 81c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81f:	83 c0 08             	add    $0x8,%eax
 822:	83 ec 0c             	sub    $0xc,%esp
 825:	50                   	push   %eax
 826:	e8 c8 fe ff ff       	call   6f3 <free>
 82b:	83 c4 10             	add    $0x10,%esp
  return freep;
 82e:	a1 88 0b 00 00       	mov    0xb88,%eax
}
 833:	c9                   	leave  
 834:	c3                   	ret    

00000835 <malloc>:

void*
malloc(uint nbytes)
{
 835:	55                   	push   %ebp
 836:	89 e5                	mov    %esp,%ebp
 838:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83b:	8b 45 08             	mov    0x8(%ebp),%eax
 83e:	83 c0 07             	add    $0x7,%eax
 841:	c1 e8 03             	shr    $0x3,%eax
 844:	40                   	inc    %eax
 845:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 848:	a1 88 0b 00 00       	mov    0xb88,%eax
 84d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 850:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 854:	75 23                	jne    879 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 856:	c7 45 f0 80 0b 00 00 	movl   $0xb80,-0x10(%ebp)
 85d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 860:	a3 88 0b 00 00       	mov    %eax,0xb88
 865:	a1 88 0b 00 00       	mov    0xb88,%eax
 86a:	a3 80 0b 00 00       	mov    %eax,0xb80
    base.s.size = 0;
 86f:	c7 05 84 0b 00 00 00 	movl   $0x0,0xb84
 876:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 879:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87c:	8b 00                	mov    (%eax),%eax
 87e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 881:	8b 45 f4             	mov    -0xc(%ebp),%eax
 884:	8b 40 04             	mov    0x4(%eax),%eax
 887:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 88a:	72 4d                	jb     8d9 <malloc+0xa4>
      if(p->s.size == nunits)
 88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88f:	8b 40 04             	mov    0x4(%eax),%eax
 892:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 895:	75 0c                	jne    8a3 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 897:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89a:	8b 10                	mov    (%eax),%edx
 89c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89f:	89 10                	mov    %edx,(%eax)
 8a1:	eb 26                	jmp    8c9 <malloc+0x94>
      else {
        p->s.size -= nunits;
 8a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a6:	8b 40 04             	mov    0x4(%eax),%eax
 8a9:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8ac:	89 c2                	mov    %eax,%edx
 8ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b7:	8b 40 04             	mov    0x4(%eax),%eax
 8ba:	c1 e0 03             	shl    $0x3,%eax
 8bd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c3:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8c6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8cc:	a3 88 0b 00 00       	mov    %eax,0xb88
      return (void*)(p + 1);
 8d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d4:	83 c0 08             	add    $0x8,%eax
 8d7:	eb 3b                	jmp    914 <malloc+0xdf>
    }
    if(p == freep)
 8d9:	a1 88 0b 00 00       	mov    0xb88,%eax
 8de:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8e1:	75 1e                	jne    901 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 8e3:	83 ec 0c             	sub    $0xc,%esp
 8e6:	ff 75 ec             	pushl  -0x14(%ebp)
 8e9:	e8 e7 fe ff ff       	call   7d5 <morecore>
 8ee:	83 c4 10             	add    $0x10,%esp
 8f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8f8:	75 07                	jne    901 <malloc+0xcc>
        return 0;
 8fa:	b8 00 00 00 00       	mov    $0x0,%eax
 8ff:	eb 13                	jmp    914 <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 901:	8b 45 f4             	mov    -0xc(%ebp),%eax
 904:	89 45 f0             	mov    %eax,-0x10(%ebp)
 907:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90a:	8b 00                	mov    (%eax),%eax
 90c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 90f:	e9 6d ff ff ff       	jmp    881 <malloc+0x4c>
  }
}
 914:	c9                   	leave  
 915:	c3                   	ret    
