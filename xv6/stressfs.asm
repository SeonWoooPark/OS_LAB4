
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 28 02 00 00    	sub    $0x228,%esp
  int fd, i;
  char path[] = "stressfs0";
  17:	8d 45 d6             	lea    -0x2a(%ebp),%eax
  1a:	bb d5 08 00 00       	mov    $0x8d5,%ebx
  1f:	ba 0a 00 00 00       	mov    $0xa,%edx
  24:	89 c7                	mov    %eax,%edi
  26:	89 de                	mov    %ebx,%esi
  28:	89 d1                	mov    %edx,%ecx
  2a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  char data[512];

  printf(1, "stressfs starting\n");
  2c:	83 ec 08             	sub    $0x8,%esp
  2f:	68 b2 08 00 00       	push   $0x8b2
  34:	6a 01                	push   $0x1
  36:	e8 c8 04 00 00       	call   503 <printf>
  3b:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
  3e:	83 ec 04             	sub    $0x4,%esp
  41:	68 00 02 00 00       	push   $0x200
  46:	6a 61                	push   $0x61
  48:	8d 85 d6 fd ff ff    	lea    -0x22a(%ebp),%eax
  4e:	50                   	push   %eax
  4f:	e8 af 01 00 00       	call   203 <memset>
  54:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  57:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  5e:	eb 0c                	jmp    6c <main+0x6c>
    if(fork() > 0)
  60:	e8 25 03 00 00       	call   38a <fork>
  65:	85 c0                	test   %eax,%eax
  67:	7f 0b                	jg     74 <main+0x74>
  for(i = 0; i < 4; i++)
  69:	ff 45 e4             	incl   -0x1c(%ebp)
  6c:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  70:	7e ee                	jle    60 <main+0x60>
  72:	eb 01                	jmp    75 <main+0x75>
      break;
  74:	90                   	nop

  printf(1, "write %d\n", i);
  75:	83 ec 04             	sub    $0x4,%esp
  78:	ff 75 e4             	pushl  -0x1c(%ebp)
  7b:	68 c5 08 00 00       	push   $0x8c5
  80:	6a 01                	push   $0x1
  82:	e8 7c 04 00 00       	call   503 <printf>
  87:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
  8a:	8a 45 de             	mov    -0x22(%ebp),%al
  8d:	88 c2                	mov    %al,%dl
  8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  92:	01 d0                	add    %edx,%eax
  94:	88 45 de             	mov    %al,-0x22(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  97:	83 ec 08             	sub    $0x8,%esp
  9a:	68 02 02 00 00       	push   $0x202
  9f:	8d 45 d6             	lea    -0x2a(%ebp),%eax
  a2:	50                   	push   %eax
  a3:	e8 2a 03 00 00       	call   3d2 <open>
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < 20; i++)
  ae:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  b5:	eb 1d                	jmp    d4 <main+0xd4>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	8d 85 d6 fd ff ff    	lea    -0x22a(%ebp),%eax
  c5:	50                   	push   %eax
  c6:	ff 75 e0             	pushl  -0x20(%ebp)
  c9:	e8 e4 02 00 00       	call   3b2 <write>
  ce:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++)
  d1:	ff 45 e4             	incl   -0x1c(%ebp)
  d4:	83 7d e4 13          	cmpl   $0x13,-0x1c(%ebp)
  d8:	7e dd                	jle    b7 <main+0xb7>
  close(fd);
  da:	83 ec 0c             	sub    $0xc,%esp
  dd:	ff 75 e0             	pushl  -0x20(%ebp)
  e0:	e8 d5 02 00 00       	call   3ba <close>
  e5:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
  e8:	83 ec 08             	sub    $0x8,%esp
  eb:	68 cf 08 00 00       	push   $0x8cf
  f0:	6a 01                	push   $0x1
  f2:	e8 0c 04 00 00       	call   503 <printf>
  f7:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
  fa:	83 ec 08             	sub    $0x8,%esp
  fd:	6a 00                	push   $0x0
  ff:	8d 45 d6             	lea    -0x2a(%ebp),%eax
 102:	50                   	push   %eax
 103:	e8 ca 02 00 00       	call   3d2 <open>
 108:	83 c4 10             	add    $0x10,%esp
 10b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for (i = 0; i < 20; i++)
 10e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 115:	eb 1d                	jmp    134 <main+0x134>
    read(fd, data, sizeof(data));
 117:	83 ec 04             	sub    $0x4,%esp
 11a:	68 00 02 00 00       	push   $0x200
 11f:	8d 85 d6 fd ff ff    	lea    -0x22a(%ebp),%eax
 125:	50                   	push   %eax
 126:	ff 75 e0             	pushl  -0x20(%ebp)
 129:	e8 7c 02 00 00       	call   3aa <read>
 12e:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 20; i++)
 131:	ff 45 e4             	incl   -0x1c(%ebp)
 134:	83 7d e4 13          	cmpl   $0x13,-0x1c(%ebp)
 138:	7e dd                	jle    117 <main+0x117>
  close(fd);
 13a:	83 ec 0c             	sub    $0xc,%esp
 13d:	ff 75 e0             	pushl  -0x20(%ebp)
 140:	e8 75 02 00 00       	call   3ba <close>
 145:	83 c4 10             	add    $0x10,%esp

  wait();
 148:	e8 4d 02 00 00       	call   39a <wait>

  exit();
 14d:	e8 40 02 00 00       	call   392 <exit>

00000152 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 152:	55                   	push   %ebp
 153:	89 e5                	mov    %esp,%ebp
 155:	57                   	push   %edi
 156:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 157:	8b 4d 08             	mov    0x8(%ebp),%ecx
 15a:	8b 55 10             	mov    0x10(%ebp),%edx
 15d:	8b 45 0c             	mov    0xc(%ebp),%eax
 160:	89 cb                	mov    %ecx,%ebx
 162:	89 df                	mov    %ebx,%edi
 164:	89 d1                	mov    %edx,%ecx
 166:	fc                   	cld    
 167:	f3 aa                	rep stos %al,%es:(%edi)
 169:	89 ca                	mov    %ecx,%edx
 16b:	89 fb                	mov    %edi,%ebx
 16d:	89 5d 08             	mov    %ebx,0x8(%ebp)
 170:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 173:	90                   	nop
 174:	5b                   	pop    %ebx
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    

00000178 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 178:	55                   	push   %ebp
 179:	89 e5                	mov    %esp,%ebp
 17b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 184:	90                   	nop
 185:	8b 55 0c             	mov    0xc(%ebp),%edx
 188:	8d 42 01             	lea    0x1(%edx),%eax
 18b:	89 45 0c             	mov    %eax,0xc(%ebp)
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	8d 48 01             	lea    0x1(%eax),%ecx
 194:	89 4d 08             	mov    %ecx,0x8(%ebp)
 197:	8a 12                	mov    (%edx),%dl
 199:	88 10                	mov    %dl,(%eax)
 19b:	8a 00                	mov    (%eax),%al
 19d:	84 c0                	test   %al,%al
 19f:	75 e4                	jne    185 <strcpy+0xd>
    ;
  return os;
 1a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1a4:	c9                   	leave  
 1a5:	c3                   	ret    

000001a6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a6:	55                   	push   %ebp
 1a7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1a9:	eb 06                	jmp    1b1 <strcmp+0xb>
    p++, q++;
 1ab:	ff 45 08             	incl   0x8(%ebp)
 1ae:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	8a 00                	mov    (%eax),%al
 1b6:	84 c0                	test   %al,%al
 1b8:	74 0e                	je     1c8 <strcmp+0x22>
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	8a 10                	mov    (%eax),%dl
 1bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c2:	8a 00                	mov    (%eax),%al
 1c4:	38 c2                	cmp    %al,%dl
 1c6:	74 e3                	je     1ab <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
 1cb:	8a 00                	mov    (%eax),%al
 1cd:	0f b6 d0             	movzbl %al,%edx
 1d0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d3:	8a 00                	mov    (%eax),%al
 1d5:	0f b6 c0             	movzbl %al,%eax
 1d8:	29 c2                	sub    %eax,%edx
 1da:	89 d0                	mov    %edx,%eax
}
 1dc:	5d                   	pop    %ebp
 1dd:	c3                   	ret    

000001de <strlen>:

uint
strlen(char *s)
{
 1de:	55                   	push   %ebp
 1df:	89 e5                	mov    %esp,%ebp
 1e1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1eb:	eb 03                	jmp    1f0 <strlen+0x12>
 1ed:	ff 45 fc             	incl   -0x4(%ebp)
 1f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 d0                	add    %edx,%eax
 1f8:	8a 00                	mov    (%eax),%al
 1fa:	84 c0                	test   %al,%al
 1fc:	75 ef                	jne    1ed <strlen+0xf>
    ;
  return n;
 1fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 201:	c9                   	leave  
 202:	c3                   	ret    

00000203 <memset>:

void*
memset(void *dst, int c, uint n)
{
 203:	55                   	push   %ebp
 204:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 206:	8b 45 10             	mov    0x10(%ebp),%eax
 209:	50                   	push   %eax
 20a:	ff 75 0c             	pushl  0xc(%ebp)
 20d:	ff 75 08             	pushl  0x8(%ebp)
 210:	e8 3d ff ff ff       	call   152 <stosb>
 215:	83 c4 0c             	add    $0xc,%esp
  return dst;
 218:	8b 45 08             	mov    0x8(%ebp),%eax
}
 21b:	c9                   	leave  
 21c:	c3                   	ret    

0000021d <strchr>:

char*
strchr(const char *s, char c)
{
 21d:	55                   	push   %ebp
 21e:	89 e5                	mov    %esp,%ebp
 220:	83 ec 04             	sub    $0x4,%esp
 223:	8b 45 0c             	mov    0xc(%ebp),%eax
 226:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 229:	eb 12                	jmp    23d <strchr+0x20>
    if(*s == c)
 22b:	8b 45 08             	mov    0x8(%ebp),%eax
 22e:	8a 00                	mov    (%eax),%al
 230:	38 45 fc             	cmp    %al,-0x4(%ebp)
 233:	75 05                	jne    23a <strchr+0x1d>
      return (char*)s;
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	eb 11                	jmp    24b <strchr+0x2e>
  for(; *s; s++)
 23a:	ff 45 08             	incl   0x8(%ebp)
 23d:	8b 45 08             	mov    0x8(%ebp),%eax
 240:	8a 00                	mov    (%eax),%al
 242:	84 c0                	test   %al,%al
 244:	75 e5                	jne    22b <strchr+0xe>
  return 0;
 246:	b8 00 00 00 00       	mov    $0x0,%eax
}
 24b:	c9                   	leave  
 24c:	c3                   	ret    

0000024d <gets>:

char*
gets(char *buf, int max)
{
 24d:	55                   	push   %ebp
 24e:	89 e5                	mov    %esp,%ebp
 250:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 253:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 25a:	eb 3f                	jmp    29b <gets+0x4e>
    cc = read(0, &c, 1);
 25c:	83 ec 04             	sub    $0x4,%esp
 25f:	6a 01                	push   $0x1
 261:	8d 45 ef             	lea    -0x11(%ebp),%eax
 264:	50                   	push   %eax
 265:	6a 00                	push   $0x0
 267:	e8 3e 01 00 00       	call   3aa <read>
 26c:	83 c4 10             	add    $0x10,%esp
 26f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 272:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 276:	7e 2e                	jle    2a6 <gets+0x59>
      break;
    buf[i++] = c;
 278:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27b:	8d 50 01             	lea    0x1(%eax),%edx
 27e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 281:	89 c2                	mov    %eax,%edx
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	01 c2                	add    %eax,%edx
 288:	8a 45 ef             	mov    -0x11(%ebp),%al
 28b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 28d:	8a 45 ef             	mov    -0x11(%ebp),%al
 290:	3c 0a                	cmp    $0xa,%al
 292:	74 13                	je     2a7 <gets+0x5a>
 294:	8a 45 ef             	mov    -0x11(%ebp),%al
 297:	3c 0d                	cmp    $0xd,%al
 299:	74 0c                	je     2a7 <gets+0x5a>
  for(i=0; i+1 < max; ){
 29b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 29e:	40                   	inc    %eax
 29f:	39 45 0c             	cmp    %eax,0xc(%ebp)
 2a2:	7f b8                	jg     25c <gets+0xf>
 2a4:	eb 01                	jmp    2a7 <gets+0x5a>
      break;
 2a6:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2aa:	8b 45 08             	mov    0x8(%ebp),%eax
 2ad:	01 d0                	add    %edx,%eax
 2af:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b5:	c9                   	leave  
 2b6:	c3                   	ret    

000002b7 <stat>:

int
stat(char *n, struct stat *st)
{
 2b7:	55                   	push   %ebp
 2b8:	89 e5                	mov    %esp,%ebp
 2ba:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2bd:	83 ec 08             	sub    $0x8,%esp
 2c0:	6a 00                	push   $0x0
 2c2:	ff 75 08             	pushl  0x8(%ebp)
 2c5:	e8 08 01 00 00       	call   3d2 <open>
 2ca:	83 c4 10             	add    $0x10,%esp
 2cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2d4:	79 07                	jns    2dd <stat+0x26>
    return -1;
 2d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2db:	eb 25                	jmp    302 <stat+0x4b>
  r = fstat(fd, st);
 2dd:	83 ec 08             	sub    $0x8,%esp
 2e0:	ff 75 0c             	pushl  0xc(%ebp)
 2e3:	ff 75 f4             	pushl  -0xc(%ebp)
 2e6:	e8 ff 00 00 00       	call   3ea <fstat>
 2eb:	83 c4 10             	add    $0x10,%esp
 2ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2f1:	83 ec 0c             	sub    $0xc,%esp
 2f4:	ff 75 f4             	pushl  -0xc(%ebp)
 2f7:	e8 be 00 00 00       	call   3ba <close>
 2fc:	83 c4 10             	add    $0x10,%esp
  return r;
 2ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 302:	c9                   	leave  
 303:	c3                   	ret    

00000304 <atoi>:

int
atoi(const char *s)
{
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 30a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 311:	eb 24                	jmp    337 <atoi+0x33>
    n = n*10 + *s++ - '0';
 313:	8b 55 fc             	mov    -0x4(%ebp),%edx
 316:	89 d0                	mov    %edx,%eax
 318:	c1 e0 02             	shl    $0x2,%eax
 31b:	01 d0                	add    %edx,%eax
 31d:	01 c0                	add    %eax,%eax
 31f:	89 c1                	mov    %eax,%ecx
 321:	8b 45 08             	mov    0x8(%ebp),%eax
 324:	8d 50 01             	lea    0x1(%eax),%edx
 327:	89 55 08             	mov    %edx,0x8(%ebp)
 32a:	8a 00                	mov    (%eax),%al
 32c:	0f be c0             	movsbl %al,%eax
 32f:	01 c8                	add    %ecx,%eax
 331:	83 e8 30             	sub    $0x30,%eax
 334:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	8a 00                	mov    (%eax),%al
 33c:	3c 2f                	cmp    $0x2f,%al
 33e:	7e 09                	jle    349 <atoi+0x45>
 340:	8b 45 08             	mov    0x8(%ebp),%eax
 343:	8a 00                	mov    (%eax),%al
 345:	3c 39                	cmp    $0x39,%al
 347:	7e ca                	jle    313 <atoi+0xf>
  return n;
 349:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 34c:	c9                   	leave  
 34d:	c3                   	ret    

0000034e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 34e:	55                   	push   %ebp
 34f:	89 e5                	mov    %esp,%ebp
 351:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 360:	eb 16                	jmp    378 <memmove+0x2a>
    *dst++ = *src++;
 362:	8b 55 f8             	mov    -0x8(%ebp),%edx
 365:	8d 42 01             	lea    0x1(%edx),%eax
 368:	89 45 f8             	mov    %eax,-0x8(%ebp)
 36b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 36e:	8d 48 01             	lea    0x1(%eax),%ecx
 371:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 374:	8a 12                	mov    (%edx),%dl
 376:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 378:	8b 45 10             	mov    0x10(%ebp),%eax
 37b:	8d 50 ff             	lea    -0x1(%eax),%edx
 37e:	89 55 10             	mov    %edx,0x10(%ebp)
 381:	85 c0                	test   %eax,%eax
 383:	7f dd                	jg     362 <memmove+0x14>
  return vdst;
 385:	8b 45 08             	mov    0x8(%ebp),%eax
}
 388:	c9                   	leave  
 389:	c3                   	ret    

0000038a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exit>:
SYSCALL(exit)
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <wait>:
SYSCALL(wait)
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <pipe>:
SYSCALL(pipe)
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <read>:
SYSCALL(read)
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <write>:
SYSCALL(write)
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <close>:
SYSCALL(close)
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <kill>:
SYSCALL(kill)
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <exec>:
SYSCALL(exec)
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <open>:
SYSCALL(open)
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mknod>:
SYSCALL(mknod)
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <unlink>:
SYSCALL(unlink)
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <fstat>:
SYSCALL(fstat)
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <link>:
SYSCALL(link)
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mkdir>:
SYSCALL(mkdir)
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <chdir>:
SYSCALL(chdir)
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <dup>:
SYSCALL(dup)
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getpid>:
SYSCALL(getpid)
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sbrk>:
SYSCALL(sbrk)
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sleep>:
SYSCALL(sleep)
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <uptime>:
SYSCALL(uptime)
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 432:	55                   	push   %ebp
 433:	89 e5                	mov    %esp,%ebp
 435:	83 ec 18             	sub    $0x18,%esp
 438:	8b 45 0c             	mov    0xc(%ebp),%eax
 43b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 43e:	83 ec 04             	sub    $0x4,%esp
 441:	6a 01                	push   $0x1
 443:	8d 45 f4             	lea    -0xc(%ebp),%eax
 446:	50                   	push   %eax
 447:	ff 75 08             	pushl  0x8(%ebp)
 44a:	e8 63 ff ff ff       	call   3b2 <write>
 44f:	83 c4 10             	add    $0x10,%esp
}
 452:	90                   	nop
 453:	c9                   	leave  
 454:	c3                   	ret    

00000455 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 455:	55                   	push   %ebp
 456:	89 e5                	mov    %esp,%ebp
 458:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 45b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 462:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 466:	74 17                	je     47f <printint+0x2a>
 468:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 46c:	79 11                	jns    47f <printint+0x2a>
    neg = 1;
 46e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 475:	8b 45 0c             	mov    0xc(%ebp),%eax
 478:	f7 d8                	neg    %eax
 47a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47d:	eb 06                	jmp    485 <printint+0x30>
  } else {
    x = xx;
 47f:	8b 45 0c             	mov    0xc(%ebp),%eax
 482:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 485:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 48c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 48f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 492:	ba 00 00 00 00       	mov    $0x0,%edx
 497:	f7 f1                	div    %ecx
 499:	89 d1                	mov    %edx,%ecx
 49b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49e:	8d 50 01             	lea    0x1(%eax),%edx
 4a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a4:	8a 91 e8 08 00 00    	mov    0x8e8(%ecx),%dl
 4aa:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 4ae:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4b4:	ba 00 00 00 00       	mov    $0x0,%edx
 4b9:	f7 f1                	div    %ecx
 4bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4be:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4c2:	75 c8                	jne    48c <printint+0x37>
  if(neg)
 4c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4c8:	74 2c                	je     4f6 <printint+0xa1>
    buf[i++] = '-';
 4ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4cd:	8d 50 01             	lea    0x1(%eax),%edx
 4d0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4d3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4d8:	eb 1c                	jmp    4f6 <printint+0xa1>
    putc(fd, buf[i]);
 4da:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e0:	01 d0                	add    %edx,%eax
 4e2:	8a 00                	mov    (%eax),%al
 4e4:	0f be c0             	movsbl %al,%eax
 4e7:	83 ec 08             	sub    $0x8,%esp
 4ea:	50                   	push   %eax
 4eb:	ff 75 08             	pushl  0x8(%ebp)
 4ee:	e8 3f ff ff ff       	call   432 <putc>
 4f3:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4f6:	ff 4d f4             	decl   -0xc(%ebp)
 4f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4fd:	79 db                	jns    4da <printint+0x85>
}
 4ff:	90                   	nop
 500:	90                   	nop
 501:	c9                   	leave  
 502:	c3                   	ret    

00000503 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 503:	55                   	push   %ebp
 504:	89 e5                	mov    %esp,%ebp
 506:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 509:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 510:	8d 45 0c             	lea    0xc(%ebp),%eax
 513:	83 c0 04             	add    $0x4,%eax
 516:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 519:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 520:	e9 54 01 00 00       	jmp    679 <printf+0x176>
    c = fmt[i] & 0xff;
 525:	8b 55 0c             	mov    0xc(%ebp),%edx
 528:	8b 45 f0             	mov    -0x10(%ebp),%eax
 52b:	01 d0                	add    %edx,%eax
 52d:	8a 00                	mov    (%eax),%al
 52f:	0f be c0             	movsbl %al,%eax
 532:	25 ff 00 00 00       	and    $0xff,%eax
 537:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 53a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 53e:	75 2c                	jne    56c <printf+0x69>
      if(c == '%'){
 540:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 544:	75 0c                	jne    552 <printf+0x4f>
        state = '%';
 546:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 54d:	e9 24 01 00 00       	jmp    676 <printf+0x173>
      } else {
        putc(fd, c);
 552:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 555:	0f be c0             	movsbl %al,%eax
 558:	83 ec 08             	sub    $0x8,%esp
 55b:	50                   	push   %eax
 55c:	ff 75 08             	pushl  0x8(%ebp)
 55f:	e8 ce fe ff ff       	call   432 <putc>
 564:	83 c4 10             	add    $0x10,%esp
 567:	e9 0a 01 00 00       	jmp    676 <printf+0x173>
      }
    } else if(state == '%'){
 56c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 570:	0f 85 00 01 00 00    	jne    676 <printf+0x173>
      if(c == 'd'){
 576:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 57a:	75 1e                	jne    59a <printf+0x97>
        printint(fd, *ap, 10, 1);
 57c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57f:	8b 00                	mov    (%eax),%eax
 581:	6a 01                	push   $0x1
 583:	6a 0a                	push   $0xa
 585:	50                   	push   %eax
 586:	ff 75 08             	pushl  0x8(%ebp)
 589:	e8 c7 fe ff ff       	call   455 <printint>
 58e:	83 c4 10             	add    $0x10,%esp
        ap++;
 591:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 595:	e9 d5 00 00 00       	jmp    66f <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 59a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 59e:	74 06                	je     5a6 <printf+0xa3>
 5a0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5a4:	75 1e                	jne    5c4 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 5a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a9:	8b 00                	mov    (%eax),%eax
 5ab:	6a 00                	push   $0x0
 5ad:	6a 10                	push   $0x10
 5af:	50                   	push   %eax
 5b0:	ff 75 08             	pushl  0x8(%ebp)
 5b3:	e8 9d fe ff ff       	call   455 <printint>
 5b8:	83 c4 10             	add    $0x10,%esp
        ap++;
 5bb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5bf:	e9 ab 00 00 00       	jmp    66f <printf+0x16c>
      } else if(c == 's'){
 5c4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5c8:	75 40                	jne    60a <printf+0x107>
        s = (char*)*ap;
 5ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cd:	8b 00                	mov    (%eax),%eax
 5cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5da:	75 23                	jne    5ff <printf+0xfc>
          s = "(null)";
 5dc:	c7 45 f4 df 08 00 00 	movl   $0x8df,-0xc(%ebp)
        while(*s != 0){
 5e3:	eb 1a                	jmp    5ff <printf+0xfc>
          putc(fd, *s);
 5e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e8:	8a 00                	mov    (%eax),%al
 5ea:	0f be c0             	movsbl %al,%eax
 5ed:	83 ec 08             	sub    $0x8,%esp
 5f0:	50                   	push   %eax
 5f1:	ff 75 08             	pushl  0x8(%ebp)
 5f4:	e8 39 fe ff ff       	call   432 <putc>
 5f9:	83 c4 10             	add    $0x10,%esp
          s++;
 5fc:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 5ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 602:	8a 00                	mov    (%eax),%al
 604:	84 c0                	test   %al,%al
 606:	75 dd                	jne    5e5 <printf+0xe2>
 608:	eb 65                	jmp    66f <printf+0x16c>
        }
      } else if(c == 'c'){
 60a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 60e:	75 1d                	jne    62d <printf+0x12a>
        putc(fd, *ap);
 610:	8b 45 e8             	mov    -0x18(%ebp),%eax
 613:	8b 00                	mov    (%eax),%eax
 615:	0f be c0             	movsbl %al,%eax
 618:	83 ec 08             	sub    $0x8,%esp
 61b:	50                   	push   %eax
 61c:	ff 75 08             	pushl  0x8(%ebp)
 61f:	e8 0e fe ff ff       	call   432 <putc>
 624:	83 c4 10             	add    $0x10,%esp
        ap++;
 627:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 62b:	eb 42                	jmp    66f <printf+0x16c>
      } else if(c == '%'){
 62d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 631:	75 17                	jne    64a <printf+0x147>
        putc(fd, c);
 633:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 636:	0f be c0             	movsbl %al,%eax
 639:	83 ec 08             	sub    $0x8,%esp
 63c:	50                   	push   %eax
 63d:	ff 75 08             	pushl  0x8(%ebp)
 640:	e8 ed fd ff ff       	call   432 <putc>
 645:	83 c4 10             	add    $0x10,%esp
 648:	eb 25                	jmp    66f <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 64a:	83 ec 08             	sub    $0x8,%esp
 64d:	6a 25                	push   $0x25
 64f:	ff 75 08             	pushl  0x8(%ebp)
 652:	e8 db fd ff ff       	call   432 <putc>
 657:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 65a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 65d:	0f be c0             	movsbl %al,%eax
 660:	83 ec 08             	sub    $0x8,%esp
 663:	50                   	push   %eax
 664:	ff 75 08             	pushl  0x8(%ebp)
 667:	e8 c6 fd ff ff       	call   432 <putc>
 66c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 66f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 676:	ff 45 f0             	incl   -0x10(%ebp)
 679:	8b 55 0c             	mov    0xc(%ebp),%edx
 67c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 67f:	01 d0                	add    %edx,%eax
 681:	8a 00                	mov    (%eax),%al
 683:	84 c0                	test   %al,%al
 685:	0f 85 9a fe ff ff    	jne    525 <printf+0x22>
    }
  }
}
 68b:	90                   	nop
 68c:	90                   	nop
 68d:	c9                   	leave  
 68e:	c3                   	ret    

0000068f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 68f:	55                   	push   %ebp
 690:	89 e5                	mov    %esp,%ebp
 692:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 695:	8b 45 08             	mov    0x8(%ebp),%eax
 698:	83 e8 08             	sub    $0x8,%eax
 69b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69e:	a1 04 09 00 00       	mov    0x904,%eax
 6a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a6:	eb 24                	jmp    6cc <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ab:	8b 00                	mov    (%eax),%eax
 6ad:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 6b0:	72 12                	jb     6c4 <free+0x35>
 6b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b5:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 6b8:	72 24                	jb     6de <free+0x4f>
 6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bd:	8b 00                	mov    (%eax),%eax
 6bf:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6c2:	72 1a                	jb     6de <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cf:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 6d2:	73 d4                	jae    6a8 <free+0x19>
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6dc:	73 ca                	jae    6a8 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	8b 40 04             	mov    0x4(%eax),%eax
 6e4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ee:	01 c2                	add    %eax,%edx
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 00                	mov    (%eax),%eax
 6f5:	39 c2                	cmp    %eax,%edx
 6f7:	75 24                	jne    71d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fc:	8b 50 04             	mov    0x4(%eax),%edx
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	8b 00                	mov    (%eax),%eax
 704:	8b 40 04             	mov    0x4(%eax),%eax
 707:	01 c2                	add    %eax,%edx
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 70f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 712:	8b 00                	mov    (%eax),%eax
 714:	8b 10                	mov    (%eax),%edx
 716:	8b 45 f8             	mov    -0x8(%ebp),%eax
 719:	89 10                	mov    %edx,(%eax)
 71b:	eb 0a                	jmp    727 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	8b 10                	mov    (%eax),%edx
 722:	8b 45 f8             	mov    -0x8(%ebp),%eax
 725:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	8b 40 04             	mov    0x4(%eax),%eax
 72d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 734:	8b 45 fc             	mov    -0x4(%ebp),%eax
 737:	01 d0                	add    %edx,%eax
 739:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 73c:	75 20                	jne    75e <free+0xcf>
    p->s.size += bp->s.size;
 73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 741:	8b 50 04             	mov    0x4(%eax),%edx
 744:	8b 45 f8             	mov    -0x8(%ebp),%eax
 747:	8b 40 04             	mov    0x4(%eax),%eax
 74a:	01 c2                	add    %eax,%edx
 74c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 752:	8b 45 f8             	mov    -0x8(%ebp),%eax
 755:	8b 10                	mov    (%eax),%edx
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	89 10                	mov    %edx,(%eax)
 75c:	eb 08                	jmp    766 <free+0xd7>
  } else
    p->s.ptr = bp;
 75e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 761:	8b 55 f8             	mov    -0x8(%ebp),%edx
 764:	89 10                	mov    %edx,(%eax)
  freep = p;
 766:	8b 45 fc             	mov    -0x4(%ebp),%eax
 769:	a3 04 09 00 00       	mov    %eax,0x904
}
 76e:	90                   	nop
 76f:	c9                   	leave  
 770:	c3                   	ret    

00000771 <morecore>:

static Header*
morecore(uint nu)
{
 771:	55                   	push   %ebp
 772:	89 e5                	mov    %esp,%ebp
 774:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 777:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 77e:	77 07                	ja     787 <morecore+0x16>
    nu = 4096;
 780:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 787:	8b 45 08             	mov    0x8(%ebp),%eax
 78a:	c1 e0 03             	shl    $0x3,%eax
 78d:	83 ec 0c             	sub    $0xc,%esp
 790:	50                   	push   %eax
 791:	e8 84 fc ff ff       	call   41a <sbrk>
 796:	83 c4 10             	add    $0x10,%esp
 799:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 79c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7a0:	75 07                	jne    7a9 <morecore+0x38>
    return 0;
 7a2:	b8 00 00 00 00       	mov    $0x0,%eax
 7a7:	eb 26                	jmp    7cf <morecore+0x5e>
  hp = (Header*)p;
 7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b2:	8b 55 08             	mov    0x8(%ebp),%edx
 7b5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bb:	83 c0 08             	add    $0x8,%eax
 7be:	83 ec 0c             	sub    $0xc,%esp
 7c1:	50                   	push   %eax
 7c2:	e8 c8 fe ff ff       	call   68f <free>
 7c7:	83 c4 10             	add    $0x10,%esp
  return freep;
 7ca:	a1 04 09 00 00       	mov    0x904,%eax
}
 7cf:	c9                   	leave  
 7d0:	c3                   	ret    

000007d1 <malloc>:

void*
malloc(uint nbytes)
{
 7d1:	55                   	push   %ebp
 7d2:	89 e5                	mov    %esp,%ebp
 7d4:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d7:	8b 45 08             	mov    0x8(%ebp),%eax
 7da:	83 c0 07             	add    $0x7,%eax
 7dd:	c1 e8 03             	shr    $0x3,%eax
 7e0:	40                   	inc    %eax
 7e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7e4:	a1 04 09 00 00       	mov    0x904,%eax
 7e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7f0:	75 23                	jne    815 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 7f2:	c7 45 f0 fc 08 00 00 	movl   $0x8fc,-0x10(%ebp)
 7f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fc:	a3 04 09 00 00       	mov    %eax,0x904
 801:	a1 04 09 00 00       	mov    0x904,%eax
 806:	a3 fc 08 00 00       	mov    %eax,0x8fc
    base.s.size = 0;
 80b:	c7 05 00 09 00 00 00 	movl   $0x0,0x900
 812:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 815:	8b 45 f0             	mov    -0x10(%ebp),%eax
 818:	8b 00                	mov    (%eax),%eax
 81a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	8b 40 04             	mov    0x4(%eax),%eax
 823:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 826:	72 4d                	jb     875 <malloc+0xa4>
      if(p->s.size == nunits)
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 40 04             	mov    0x4(%eax),%eax
 82e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 831:	75 0c                	jne    83f <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	8b 10                	mov    (%eax),%edx
 838:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83b:	89 10                	mov    %edx,(%eax)
 83d:	eb 26                	jmp    865 <malloc+0x94>
      else {
        p->s.size -= nunits;
 83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 842:	8b 40 04             	mov    0x4(%eax),%eax
 845:	2b 45 ec             	sub    -0x14(%ebp),%eax
 848:	89 c2                	mov    %eax,%edx
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 40 04             	mov    0x4(%eax),%eax
 856:	c1 e0 03             	shl    $0x3,%eax
 859:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 85c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 862:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 865:	8b 45 f0             	mov    -0x10(%ebp),%eax
 868:	a3 04 09 00 00       	mov    %eax,0x904
      return (void*)(p + 1);
 86d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 870:	83 c0 08             	add    $0x8,%eax
 873:	eb 3b                	jmp    8b0 <malloc+0xdf>
    }
    if(p == freep)
 875:	a1 04 09 00 00       	mov    0x904,%eax
 87a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 87d:	75 1e                	jne    89d <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 87f:	83 ec 0c             	sub    $0xc,%esp
 882:	ff 75 ec             	pushl  -0x14(%ebp)
 885:	e8 e7 fe ff ff       	call   771 <morecore>
 88a:	83 c4 10             	add    $0x10,%esp
 88d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 890:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 894:	75 07                	jne    89d <malloc+0xcc>
        return 0;
 896:	b8 00 00 00 00       	mov    $0x0,%eax
 89b:	eb 13                	jmp    8b0 <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a6:	8b 00                	mov    (%eax),%eax
 8a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8ab:	e9 6d ff ff ff       	jmp    81d <malloc+0x4c>
  }
}
 8b0:	c9                   	leave  
 8b1:	c3                   	ret    
