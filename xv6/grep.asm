
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;

  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
   d:	e9 aa 00 00 00       	jmp    bc <grep+0xbc>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
  18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1b:	05 e0 0a 00 00       	add    $0xae0,%eax
  20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  23:	c7 45 f0 e0 0a 00 00 	movl   $0xae0,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  2a:	eb 40                	jmp    6c <grep+0x6c>
      *q = 0;
  2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  2f:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  32:	83 ec 08             	sub    $0x8,%esp
  35:	ff 75 f0             	pushl  -0x10(%ebp)
  38:	ff 75 08             	pushl  0x8(%ebp)
  3b:	e8 8a 01 00 00       	call   1ca <match>
  40:	83 c4 10             	add    $0x10,%esp
  43:	85 c0                	test   %eax,%eax
  45:	74 1e                	je     65 <grep+0x65>
        *q = '\n';
  47:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4a:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  50:	40                   	inc    %eax
  51:	2b 45 f0             	sub    -0x10(%ebp),%eax
  54:	83 ec 04             	sub    $0x4,%esp
  57:	50                   	push   %eax
  58:	ff 75 f0             	pushl  -0x10(%ebp)
  5b:	6a 01                	push   $0x1
  5d:	e8 0e 05 00 00       	call   570 <write>
  62:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  65:	8b 45 e8             	mov    -0x18(%ebp),%eax
  68:	40                   	inc    %eax
  69:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  6c:	83 ec 08             	sub    $0x8,%esp
  6f:	6a 0a                	push   $0xa
  71:	ff 75 f0             	pushl  -0x10(%ebp)
  74:	e8 62 03 00 00       	call   3db <strchr>
  79:	83 c4 10             	add    $0x10,%esp
  7c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  7f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  83:	75 a7                	jne    2c <grep+0x2c>
    }
    if(p == buf)
  85:	81 7d f0 e0 0a 00 00 	cmpl   $0xae0,-0x10(%ebp)
  8c:	75 07                	jne    95 <grep+0x95>
      m = 0;
  8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  95:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  99:	7e 21                	jle    bc <grep+0xbc>
      m -= p - buf;
  9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  9e:	2d e0 0a 00 00       	sub    $0xae0,%eax
  a3:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  a6:	83 ec 04             	sub    $0x4,%esp
  a9:	ff 75 f4             	pushl  -0xc(%ebp)
  ac:	ff 75 f0             	pushl  -0x10(%ebp)
  af:	68 e0 0a 00 00       	push   $0xae0
  b4:	e8 53 04 00 00       	call   50c <memmove>
  b9:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  bf:	ba ff 03 00 00       	mov    $0x3ff,%edx
  c4:	29 c2                	sub    %eax,%edx
  c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c9:	05 e0 0a 00 00       	add    $0xae0,%eax
  ce:	83 ec 04             	sub    $0x4,%esp
  d1:	52                   	push   %edx
  d2:	50                   	push   %eax
  d3:	ff 75 0c             	pushl  0xc(%ebp)
  d6:	e8 8d 04 00 00       	call   568 <read>
  db:	83 c4 10             	add    $0x10,%esp
  de:	89 45 ec             	mov    %eax,-0x14(%ebp)
  e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  e5:	0f 8f 27 ff ff ff    	jg     12 <grep+0x12>
    }
  }
}
  eb:	90                   	nop
  ec:	90                   	nop
  ed:	c9                   	leave  
  ee:	c3                   	ret    

000000ef <main>:

int
main(int argc, char *argv[])
{
  ef:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f3:	83 e4 f0             	and    $0xfffffff0,%esp
  f6:	ff 71 fc             	pushl  -0x4(%ecx)
  f9:	55                   	push   %ebp
  fa:	89 e5                	mov    %esp,%ebp
  fc:	53                   	push   %ebx
  fd:	51                   	push   %ecx
  fe:	83 ec 10             	sub    $0x10,%esp
 101:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
 103:	83 3b 01             	cmpl   $0x1,(%ebx)
 106:	7f 17                	jg     11f <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
 108:	83 ec 08             	sub    $0x8,%esp
 10b:	68 70 0a 00 00       	push   $0xa70
 110:	6a 02                	push   $0x2
 112:	e8 aa 05 00 00       	call   6c1 <printf>
 117:	83 c4 10             	add    $0x10,%esp
    exit();
 11a:	e8 31 04 00 00       	call   550 <exit>
  }
  pattern = argv[1];
 11f:	8b 43 04             	mov    0x4(%ebx),%eax
 122:	8b 40 04             	mov    0x4(%eax),%eax
 125:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(argc <= 2){
 128:	83 3b 02             	cmpl   $0x2,(%ebx)
 12b:	7f 15                	jg     142 <main+0x53>
    grep(pattern, 0);
 12d:	83 ec 08             	sub    $0x8,%esp
 130:	6a 00                	push   $0x0
 132:	ff 75 f0             	pushl  -0x10(%ebp)
 135:	e8 c6 fe ff ff       	call   0 <grep>
 13a:	83 c4 10             	add    $0x10,%esp
    exit();
 13d:	e8 0e 04 00 00       	call   550 <exit>
  }

  for(i = 2; i < argc; i++){
 142:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 149:	eb 73                	jmp    1be <main+0xcf>
    if((fd = open(argv[i], 0)) < 0){
 14b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 14e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 155:	8b 43 04             	mov    0x4(%ebx),%eax
 158:	01 d0                	add    %edx,%eax
 15a:	8b 00                	mov    (%eax),%eax
 15c:	83 ec 08             	sub    $0x8,%esp
 15f:	6a 00                	push   $0x0
 161:	50                   	push   %eax
 162:	e8 29 04 00 00       	call   590 <open>
 167:	83 c4 10             	add    $0x10,%esp
 16a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 16d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 171:	79 29                	jns    19c <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
 173:	8b 45 f4             	mov    -0xc(%ebp),%eax
 176:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 17d:	8b 43 04             	mov    0x4(%ebx),%eax
 180:	01 d0                	add    %edx,%eax
 182:	8b 00                	mov    (%eax),%eax
 184:	83 ec 04             	sub    $0x4,%esp
 187:	50                   	push   %eax
 188:	68 90 0a 00 00       	push   $0xa90
 18d:	6a 01                	push   $0x1
 18f:	e8 2d 05 00 00       	call   6c1 <printf>
 194:	83 c4 10             	add    $0x10,%esp
      exit();
 197:	e8 b4 03 00 00       	call   550 <exit>
    }
    grep(pattern, fd);
 19c:	83 ec 08             	sub    $0x8,%esp
 19f:	ff 75 ec             	pushl  -0x14(%ebp)
 1a2:	ff 75 f0             	pushl  -0x10(%ebp)
 1a5:	e8 56 fe ff ff       	call   0 <grep>
 1aa:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1ad:	83 ec 0c             	sub    $0xc,%esp
 1b0:	ff 75 ec             	pushl  -0x14(%ebp)
 1b3:	e8 c0 03 00 00       	call   578 <close>
 1b8:	83 c4 10             	add    $0x10,%esp
  for(i = 2; i < argc; i++){
 1bb:	ff 45 f4             	incl   -0xc(%ebp)
 1be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c1:	3b 03                	cmp    (%ebx),%eax
 1c3:	7c 86                	jl     14b <main+0x5c>
  }
  exit();
 1c5:	e8 86 03 00 00       	call   550 <exit>

000001ca <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1ca:	55                   	push   %ebp
 1cb:	89 e5                	mov    %esp,%ebp
 1cd:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	8a 00                	mov    (%eax),%al
 1d5:	3c 5e                	cmp    $0x5e,%al
 1d7:	75 15                	jne    1ee <match+0x24>
    return matchhere(re+1, text);
 1d9:	8b 45 08             	mov    0x8(%ebp),%eax
 1dc:	40                   	inc    %eax
 1dd:	83 ec 08             	sub    $0x8,%esp
 1e0:	ff 75 0c             	pushl  0xc(%ebp)
 1e3:	50                   	push   %eax
 1e4:	e8 37 00 00 00       	call   220 <matchhere>
 1e9:	83 c4 10             	add    $0x10,%esp
 1ec:	eb 30                	jmp    21e <match+0x54>
  do{  // must look at empty string
    if(matchhere(re, text))
 1ee:	83 ec 08             	sub    $0x8,%esp
 1f1:	ff 75 0c             	pushl  0xc(%ebp)
 1f4:	ff 75 08             	pushl  0x8(%ebp)
 1f7:	e8 24 00 00 00       	call   220 <matchhere>
 1fc:	83 c4 10             	add    $0x10,%esp
 1ff:	85 c0                	test   %eax,%eax
 201:	74 07                	je     20a <match+0x40>
      return 1;
 203:	b8 01 00 00 00       	mov    $0x1,%eax
 208:	eb 14                	jmp    21e <match+0x54>
  }while(*text++ != '\0');
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	8d 50 01             	lea    0x1(%eax),%edx
 210:	89 55 0c             	mov    %edx,0xc(%ebp)
 213:	8a 00                	mov    (%eax),%al
 215:	84 c0                	test   %al,%al
 217:	75 d5                	jne    1ee <match+0x24>
  return 0;
 219:	b8 00 00 00 00       	mov    $0x0,%eax
}
 21e:	c9                   	leave  
 21f:	c3                   	ret    

00000220 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	8a 00                	mov    (%eax),%al
 22b:	84 c0                	test   %al,%al
 22d:	75 0a                	jne    239 <matchhere+0x19>
    return 1;
 22f:	b8 01 00 00 00       	mov    $0x1,%eax
 234:	e9 8a 00 00 00       	jmp    2c3 <matchhere+0xa3>
  if(re[1] == '*')
 239:	8b 45 08             	mov    0x8(%ebp),%eax
 23c:	40                   	inc    %eax
 23d:	8a 00                	mov    (%eax),%al
 23f:	3c 2a                	cmp    $0x2a,%al
 241:	75 20                	jne    263 <matchhere+0x43>
    return matchstar(re[0], re+2, text);
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	8d 50 02             	lea    0x2(%eax),%edx
 249:	8b 45 08             	mov    0x8(%ebp),%eax
 24c:	8a 00                	mov    (%eax),%al
 24e:	0f be c0             	movsbl %al,%eax
 251:	83 ec 04             	sub    $0x4,%esp
 254:	ff 75 0c             	pushl  0xc(%ebp)
 257:	52                   	push   %edx
 258:	50                   	push   %eax
 259:	e8 67 00 00 00       	call   2c5 <matchstar>
 25e:	83 c4 10             	add    $0x10,%esp
 261:	eb 60                	jmp    2c3 <matchhere+0xa3>
  if(re[0] == '$' && re[1] == '\0')
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	8a 00                	mov    (%eax),%al
 268:	3c 24                	cmp    $0x24,%al
 26a:	75 19                	jne    285 <matchhere+0x65>
 26c:	8b 45 08             	mov    0x8(%ebp),%eax
 26f:	40                   	inc    %eax
 270:	8a 00                	mov    (%eax),%al
 272:	84 c0                	test   %al,%al
 274:	75 0f                	jne    285 <matchhere+0x65>
    return *text == '\0';
 276:	8b 45 0c             	mov    0xc(%ebp),%eax
 279:	8a 00                	mov    (%eax),%al
 27b:	84 c0                	test   %al,%al
 27d:	0f 94 c0             	sete   %al
 280:	0f b6 c0             	movzbl %al,%eax
 283:	eb 3e                	jmp    2c3 <matchhere+0xa3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 285:	8b 45 0c             	mov    0xc(%ebp),%eax
 288:	8a 00                	mov    (%eax),%al
 28a:	84 c0                	test   %al,%al
 28c:	74 30                	je     2be <matchhere+0x9e>
 28e:	8b 45 08             	mov    0x8(%ebp),%eax
 291:	8a 00                	mov    (%eax),%al
 293:	3c 2e                	cmp    $0x2e,%al
 295:	74 0e                	je     2a5 <matchhere+0x85>
 297:	8b 45 08             	mov    0x8(%ebp),%eax
 29a:	8a 10                	mov    (%eax),%dl
 29c:	8b 45 0c             	mov    0xc(%ebp),%eax
 29f:	8a 00                	mov    (%eax),%al
 2a1:	38 c2                	cmp    %al,%dl
 2a3:	75 19                	jne    2be <matchhere+0x9e>
    return matchhere(re+1, text+1);
 2a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a8:	8d 50 01             	lea    0x1(%eax),%edx
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	40                   	inc    %eax
 2af:	83 ec 08             	sub    $0x8,%esp
 2b2:	52                   	push   %edx
 2b3:	50                   	push   %eax
 2b4:	e8 67 ff ff ff       	call   220 <matchhere>
 2b9:	83 c4 10             	add    $0x10,%esp
 2bc:	eb 05                	jmp    2c3 <matchhere+0xa3>
  return 0;
 2be:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c3:	c9                   	leave  
 2c4:	c3                   	ret    

000002c5 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2c5:	55                   	push   %ebp
 2c6:	89 e5                	mov    %esp,%ebp
 2c8:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2cb:	83 ec 08             	sub    $0x8,%esp
 2ce:	ff 75 10             	pushl  0x10(%ebp)
 2d1:	ff 75 0c             	pushl  0xc(%ebp)
 2d4:	e8 47 ff ff ff       	call   220 <matchhere>
 2d9:	83 c4 10             	add    $0x10,%esp
 2dc:	85 c0                	test   %eax,%eax
 2de:	74 07                	je     2e7 <matchstar+0x22>
      return 1;
 2e0:	b8 01 00 00 00       	mov    $0x1,%eax
 2e5:	eb 27                	jmp    30e <matchstar+0x49>
  }while(*text!='\0' && (*text++==c || c=='.'));
 2e7:	8b 45 10             	mov    0x10(%ebp),%eax
 2ea:	8a 00                	mov    (%eax),%al
 2ec:	84 c0                	test   %al,%al
 2ee:	74 19                	je     309 <matchstar+0x44>
 2f0:	8b 45 10             	mov    0x10(%ebp),%eax
 2f3:	8d 50 01             	lea    0x1(%eax),%edx
 2f6:	89 55 10             	mov    %edx,0x10(%ebp)
 2f9:	8a 00                	mov    (%eax),%al
 2fb:	0f be c0             	movsbl %al,%eax
 2fe:	39 45 08             	cmp    %eax,0x8(%ebp)
 301:	74 c8                	je     2cb <matchstar+0x6>
 303:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 307:	74 c2                	je     2cb <matchstar+0x6>
  return 0;
 309:	b8 00 00 00 00       	mov    $0x0,%eax
}
 30e:	c9                   	leave  
 30f:	c3                   	ret    

00000310 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 315:	8b 4d 08             	mov    0x8(%ebp),%ecx
 318:	8b 55 10             	mov    0x10(%ebp),%edx
 31b:	8b 45 0c             	mov    0xc(%ebp),%eax
 31e:	89 cb                	mov    %ecx,%ebx
 320:	89 df                	mov    %ebx,%edi
 322:	89 d1                	mov    %edx,%ecx
 324:	fc                   	cld    
 325:	f3 aa                	rep stos %al,%es:(%edi)
 327:	89 ca                	mov    %ecx,%edx
 329:	89 fb                	mov    %edi,%ebx
 32b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 32e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 331:	90                   	nop
 332:	5b                   	pop    %ebx
 333:	5f                   	pop    %edi
 334:	5d                   	pop    %ebp
 335:	c3                   	ret    

00000336 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 336:	55                   	push   %ebp
 337:	89 e5                	mov    %esp,%ebp
 339:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 33c:	8b 45 08             	mov    0x8(%ebp),%eax
 33f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 342:	90                   	nop
 343:	8b 55 0c             	mov    0xc(%ebp),%edx
 346:	8d 42 01             	lea    0x1(%edx),%eax
 349:	89 45 0c             	mov    %eax,0xc(%ebp)
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
 34f:	8d 48 01             	lea    0x1(%eax),%ecx
 352:	89 4d 08             	mov    %ecx,0x8(%ebp)
 355:	8a 12                	mov    (%edx),%dl
 357:	88 10                	mov    %dl,(%eax)
 359:	8a 00                	mov    (%eax),%al
 35b:	84 c0                	test   %al,%al
 35d:	75 e4                	jne    343 <strcpy+0xd>
    ;
  return os;
 35f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 362:	c9                   	leave  
 363:	c3                   	ret    

00000364 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 367:	eb 06                	jmp    36f <strcmp+0xb>
    p++, q++;
 369:	ff 45 08             	incl   0x8(%ebp)
 36c:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
 36f:	8b 45 08             	mov    0x8(%ebp),%eax
 372:	8a 00                	mov    (%eax),%al
 374:	84 c0                	test   %al,%al
 376:	74 0e                	je     386 <strcmp+0x22>
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	8a 10                	mov    (%eax),%dl
 37d:	8b 45 0c             	mov    0xc(%ebp),%eax
 380:	8a 00                	mov    (%eax),%al
 382:	38 c2                	cmp    %al,%dl
 384:	74 e3                	je     369 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 386:	8b 45 08             	mov    0x8(%ebp),%eax
 389:	8a 00                	mov    (%eax),%al
 38b:	0f b6 d0             	movzbl %al,%edx
 38e:	8b 45 0c             	mov    0xc(%ebp),%eax
 391:	8a 00                	mov    (%eax),%al
 393:	0f b6 c0             	movzbl %al,%eax
 396:	29 c2                	sub    %eax,%edx
 398:	89 d0                	mov    %edx,%eax
}
 39a:	5d                   	pop    %ebp
 39b:	c3                   	ret    

0000039c <strlen>:

uint
strlen(char *s)
{
 39c:	55                   	push   %ebp
 39d:	89 e5                	mov    %esp,%ebp
 39f:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3a9:	eb 03                	jmp    3ae <strlen+0x12>
 3ab:	ff 45 fc             	incl   -0x4(%ebp)
 3ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3b1:	8b 45 08             	mov    0x8(%ebp),%eax
 3b4:	01 d0                	add    %edx,%eax
 3b6:	8a 00                	mov    (%eax),%al
 3b8:	84 c0                	test   %al,%al
 3ba:	75 ef                	jne    3ab <strlen+0xf>
    ;
  return n;
 3bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3bf:	c9                   	leave  
 3c0:	c3                   	ret    

000003c1 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3c1:	55                   	push   %ebp
 3c2:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3c4:	8b 45 10             	mov    0x10(%ebp),%eax
 3c7:	50                   	push   %eax
 3c8:	ff 75 0c             	pushl  0xc(%ebp)
 3cb:	ff 75 08             	pushl  0x8(%ebp)
 3ce:	e8 3d ff ff ff       	call   310 <stosb>
 3d3:	83 c4 0c             	add    $0xc,%esp
  return dst;
 3d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3d9:	c9                   	leave  
 3da:	c3                   	ret    

000003db <strchr>:

char*
strchr(const char *s, char c)
{
 3db:	55                   	push   %ebp
 3dc:	89 e5                	mov    %esp,%ebp
 3de:	83 ec 04             	sub    $0x4,%esp
 3e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e4:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 3e7:	eb 12                	jmp    3fb <strchr+0x20>
    if(*s == c)
 3e9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ec:	8a 00                	mov    (%eax),%al
 3ee:	38 45 fc             	cmp    %al,-0x4(%ebp)
 3f1:	75 05                	jne    3f8 <strchr+0x1d>
      return (char*)s;
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	eb 11                	jmp    409 <strchr+0x2e>
  for(; *s; s++)
 3f8:	ff 45 08             	incl   0x8(%ebp)
 3fb:	8b 45 08             	mov    0x8(%ebp),%eax
 3fe:	8a 00                	mov    (%eax),%al
 400:	84 c0                	test   %al,%al
 402:	75 e5                	jne    3e9 <strchr+0xe>
  return 0;
 404:	b8 00 00 00 00       	mov    $0x0,%eax
}
 409:	c9                   	leave  
 40a:	c3                   	ret    

0000040b <gets>:

char*
gets(char *buf, int max)
{
 40b:	55                   	push   %ebp
 40c:	89 e5                	mov    %esp,%ebp
 40e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 411:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 418:	eb 3f                	jmp    459 <gets+0x4e>
    cc = read(0, &c, 1);
 41a:	83 ec 04             	sub    $0x4,%esp
 41d:	6a 01                	push   $0x1
 41f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 422:	50                   	push   %eax
 423:	6a 00                	push   $0x0
 425:	e8 3e 01 00 00       	call   568 <read>
 42a:	83 c4 10             	add    $0x10,%esp
 42d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 430:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 434:	7e 2e                	jle    464 <gets+0x59>
      break;
    buf[i++] = c;
 436:	8b 45 f4             	mov    -0xc(%ebp),%eax
 439:	8d 50 01             	lea    0x1(%eax),%edx
 43c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 43f:	89 c2                	mov    %eax,%edx
 441:	8b 45 08             	mov    0x8(%ebp),%eax
 444:	01 c2                	add    %eax,%edx
 446:	8a 45 ef             	mov    -0x11(%ebp),%al
 449:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 44b:	8a 45 ef             	mov    -0x11(%ebp),%al
 44e:	3c 0a                	cmp    $0xa,%al
 450:	74 13                	je     465 <gets+0x5a>
 452:	8a 45 ef             	mov    -0x11(%ebp),%al
 455:	3c 0d                	cmp    $0xd,%al
 457:	74 0c                	je     465 <gets+0x5a>
  for(i=0; i+1 < max; ){
 459:	8b 45 f4             	mov    -0xc(%ebp),%eax
 45c:	40                   	inc    %eax
 45d:	39 45 0c             	cmp    %eax,0xc(%ebp)
 460:	7f b8                	jg     41a <gets+0xf>
 462:	eb 01                	jmp    465 <gets+0x5a>
      break;
 464:	90                   	nop
      break;
  }
  buf[i] = '\0';
 465:	8b 55 f4             	mov    -0xc(%ebp),%edx
 468:	8b 45 08             	mov    0x8(%ebp),%eax
 46b:	01 d0                	add    %edx,%eax
 46d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 470:	8b 45 08             	mov    0x8(%ebp),%eax
}
 473:	c9                   	leave  
 474:	c3                   	ret    

00000475 <stat>:

int
stat(char *n, struct stat *st)
{
 475:	55                   	push   %ebp
 476:	89 e5                	mov    %esp,%ebp
 478:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 47b:	83 ec 08             	sub    $0x8,%esp
 47e:	6a 00                	push   $0x0
 480:	ff 75 08             	pushl  0x8(%ebp)
 483:	e8 08 01 00 00       	call   590 <open>
 488:	83 c4 10             	add    $0x10,%esp
 48b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 48e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 492:	79 07                	jns    49b <stat+0x26>
    return -1;
 494:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 499:	eb 25                	jmp    4c0 <stat+0x4b>
  r = fstat(fd, st);
 49b:	83 ec 08             	sub    $0x8,%esp
 49e:	ff 75 0c             	pushl  0xc(%ebp)
 4a1:	ff 75 f4             	pushl  -0xc(%ebp)
 4a4:	e8 ff 00 00 00       	call   5a8 <fstat>
 4a9:	83 c4 10             	add    $0x10,%esp
 4ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4af:	83 ec 0c             	sub    $0xc,%esp
 4b2:	ff 75 f4             	pushl  -0xc(%ebp)
 4b5:	e8 be 00 00 00       	call   578 <close>
 4ba:	83 c4 10             	add    $0x10,%esp
  return r;
 4bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4c0:	c9                   	leave  
 4c1:	c3                   	ret    

000004c2 <atoi>:

int
atoi(const char *s)
{
 4c2:	55                   	push   %ebp
 4c3:	89 e5                	mov    %esp,%ebp
 4c5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 4c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 4cf:	eb 24                	jmp    4f5 <atoi+0x33>
    n = n*10 + *s++ - '0';
 4d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 4d4:	89 d0                	mov    %edx,%eax
 4d6:	c1 e0 02             	shl    $0x2,%eax
 4d9:	01 d0                	add    %edx,%eax
 4db:	01 c0                	add    %eax,%eax
 4dd:	89 c1                	mov    %eax,%ecx
 4df:	8b 45 08             	mov    0x8(%ebp),%eax
 4e2:	8d 50 01             	lea    0x1(%eax),%edx
 4e5:	89 55 08             	mov    %edx,0x8(%ebp)
 4e8:	8a 00                	mov    (%eax),%al
 4ea:	0f be c0             	movsbl %al,%eax
 4ed:	01 c8                	add    %ecx,%eax
 4ef:	83 e8 30             	sub    $0x30,%eax
 4f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 4f5:	8b 45 08             	mov    0x8(%ebp),%eax
 4f8:	8a 00                	mov    (%eax),%al
 4fa:	3c 2f                	cmp    $0x2f,%al
 4fc:	7e 09                	jle    507 <atoi+0x45>
 4fe:	8b 45 08             	mov    0x8(%ebp),%eax
 501:	8a 00                	mov    (%eax),%al
 503:	3c 39                	cmp    $0x39,%al
 505:	7e ca                	jle    4d1 <atoi+0xf>
  return n;
 507:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 50a:	c9                   	leave  
 50b:	c3                   	ret    

0000050c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 50c:	55                   	push   %ebp
 50d:	89 e5                	mov    %esp,%ebp
 50f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 512:	8b 45 08             	mov    0x8(%ebp),%eax
 515:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 518:	8b 45 0c             	mov    0xc(%ebp),%eax
 51b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 51e:	eb 16                	jmp    536 <memmove+0x2a>
    *dst++ = *src++;
 520:	8b 55 f8             	mov    -0x8(%ebp),%edx
 523:	8d 42 01             	lea    0x1(%edx),%eax
 526:	89 45 f8             	mov    %eax,-0x8(%ebp)
 529:	8b 45 fc             	mov    -0x4(%ebp),%eax
 52c:	8d 48 01             	lea    0x1(%eax),%ecx
 52f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 532:	8a 12                	mov    (%edx),%dl
 534:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 536:	8b 45 10             	mov    0x10(%ebp),%eax
 539:	8d 50 ff             	lea    -0x1(%eax),%edx
 53c:	89 55 10             	mov    %edx,0x10(%ebp)
 53f:	85 c0                	test   %eax,%eax
 541:	7f dd                	jg     520 <memmove+0x14>
  return vdst;
 543:	8b 45 08             	mov    0x8(%ebp),%eax
}
 546:	c9                   	leave  
 547:	c3                   	ret    

00000548 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 548:	b8 01 00 00 00       	mov    $0x1,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret    

00000550 <exit>:
SYSCALL(exit)
 550:	b8 02 00 00 00       	mov    $0x2,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <wait>:
SYSCALL(wait)
 558:	b8 03 00 00 00       	mov    $0x3,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <pipe>:
SYSCALL(pipe)
 560:	b8 04 00 00 00       	mov    $0x4,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <read>:
SYSCALL(read)
 568:	b8 05 00 00 00       	mov    $0x5,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <write>:
SYSCALL(write)
 570:	b8 10 00 00 00       	mov    $0x10,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <close>:
SYSCALL(close)
 578:	b8 15 00 00 00       	mov    $0x15,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <kill>:
SYSCALL(kill)
 580:	b8 06 00 00 00       	mov    $0x6,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <exec>:
SYSCALL(exec)
 588:	b8 07 00 00 00       	mov    $0x7,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <open>:
SYSCALL(open)
 590:	b8 0f 00 00 00       	mov    $0xf,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <mknod>:
SYSCALL(mknod)
 598:	b8 11 00 00 00       	mov    $0x11,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <unlink>:
SYSCALL(unlink)
 5a0:	b8 12 00 00 00       	mov    $0x12,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <fstat>:
SYSCALL(fstat)
 5a8:	b8 08 00 00 00       	mov    $0x8,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <link>:
SYSCALL(link)
 5b0:	b8 13 00 00 00       	mov    $0x13,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <mkdir>:
SYSCALL(mkdir)
 5b8:	b8 14 00 00 00       	mov    $0x14,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <chdir>:
SYSCALL(chdir)
 5c0:	b8 09 00 00 00       	mov    $0x9,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <dup>:
SYSCALL(dup)
 5c8:	b8 0a 00 00 00       	mov    $0xa,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <getpid>:
SYSCALL(getpid)
 5d0:	b8 0b 00 00 00       	mov    $0xb,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <sbrk>:
SYSCALL(sbrk)
 5d8:	b8 0c 00 00 00       	mov    $0xc,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <sleep>:
SYSCALL(sleep)
 5e0:	b8 0d 00 00 00       	mov    $0xd,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <uptime>:
SYSCALL(uptime)
 5e8:	b8 0e 00 00 00       	mov    $0xe,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	83 ec 18             	sub    $0x18,%esp
 5f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5fc:	83 ec 04             	sub    $0x4,%esp
 5ff:	6a 01                	push   $0x1
 601:	8d 45 f4             	lea    -0xc(%ebp),%eax
 604:	50                   	push   %eax
 605:	ff 75 08             	pushl  0x8(%ebp)
 608:	e8 63 ff ff ff       	call   570 <write>
 60d:	83 c4 10             	add    $0x10,%esp
}
 610:	90                   	nop
 611:	c9                   	leave  
 612:	c3                   	ret    

00000613 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 613:	55                   	push   %ebp
 614:	89 e5                	mov    %esp,%ebp
 616:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 619:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 620:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 624:	74 17                	je     63d <printint+0x2a>
 626:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 62a:	79 11                	jns    63d <printint+0x2a>
    neg = 1;
 62c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 633:	8b 45 0c             	mov    0xc(%ebp),%eax
 636:	f7 d8                	neg    %eax
 638:	89 45 ec             	mov    %eax,-0x14(%ebp)
 63b:	eb 06                	jmp    643 <printint+0x30>
  } else {
    x = xx;
 63d:	8b 45 0c             	mov    0xc(%ebp),%eax
 640:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 643:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 64a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 64d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 650:	ba 00 00 00 00       	mov    $0x0,%edx
 655:	f7 f1                	div    %ecx
 657:	89 d1                	mov    %edx,%ecx
 659:	8b 45 f4             	mov    -0xc(%ebp),%eax
 65c:	8d 50 01             	lea    0x1(%eax),%edx
 65f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 662:	8a 91 b0 0a 00 00    	mov    0xab0(%ecx),%dl
 668:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 66c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 66f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 672:	ba 00 00 00 00       	mov    $0x0,%edx
 677:	f7 f1                	div    %ecx
 679:	89 45 ec             	mov    %eax,-0x14(%ebp)
 67c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 680:	75 c8                	jne    64a <printint+0x37>
  if(neg)
 682:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 686:	74 2c                	je     6b4 <printint+0xa1>
    buf[i++] = '-';
 688:	8b 45 f4             	mov    -0xc(%ebp),%eax
 68b:	8d 50 01             	lea    0x1(%eax),%edx
 68e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 691:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 696:	eb 1c                	jmp    6b4 <printint+0xa1>
    putc(fd, buf[i]);
 698:	8d 55 dc             	lea    -0x24(%ebp),%edx
 69b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 69e:	01 d0                	add    %edx,%eax
 6a0:	8a 00                	mov    (%eax),%al
 6a2:	0f be c0             	movsbl %al,%eax
 6a5:	83 ec 08             	sub    $0x8,%esp
 6a8:	50                   	push   %eax
 6a9:	ff 75 08             	pushl  0x8(%ebp)
 6ac:	e8 3f ff ff ff       	call   5f0 <putc>
 6b1:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 6b4:	ff 4d f4             	decl   -0xc(%ebp)
 6b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6bb:	79 db                	jns    698 <printint+0x85>
}
 6bd:	90                   	nop
 6be:	90                   	nop
 6bf:	c9                   	leave  
 6c0:	c3                   	ret    

000006c1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6c1:	55                   	push   %ebp
 6c2:	89 e5                	mov    %esp,%ebp
 6c4:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6ce:	8d 45 0c             	lea    0xc(%ebp),%eax
 6d1:	83 c0 04             	add    $0x4,%eax
 6d4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6de:	e9 54 01 00 00       	jmp    837 <printf+0x176>
    c = fmt[i] & 0xff;
 6e3:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e9:	01 d0                	add    %edx,%eax
 6eb:	8a 00                	mov    (%eax),%al
 6ed:	0f be c0             	movsbl %al,%eax
 6f0:	25 ff 00 00 00       	and    $0xff,%eax
 6f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6fc:	75 2c                	jne    72a <printf+0x69>
      if(c == '%'){
 6fe:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 702:	75 0c                	jne    710 <printf+0x4f>
        state = '%';
 704:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 70b:	e9 24 01 00 00       	jmp    834 <printf+0x173>
      } else {
        putc(fd, c);
 710:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 713:	0f be c0             	movsbl %al,%eax
 716:	83 ec 08             	sub    $0x8,%esp
 719:	50                   	push   %eax
 71a:	ff 75 08             	pushl  0x8(%ebp)
 71d:	e8 ce fe ff ff       	call   5f0 <putc>
 722:	83 c4 10             	add    $0x10,%esp
 725:	e9 0a 01 00 00       	jmp    834 <printf+0x173>
      }
    } else if(state == '%'){
 72a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 72e:	0f 85 00 01 00 00    	jne    834 <printf+0x173>
      if(c == 'd'){
 734:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 738:	75 1e                	jne    758 <printf+0x97>
        printint(fd, *ap, 10, 1);
 73a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 73d:	8b 00                	mov    (%eax),%eax
 73f:	6a 01                	push   $0x1
 741:	6a 0a                	push   $0xa
 743:	50                   	push   %eax
 744:	ff 75 08             	pushl  0x8(%ebp)
 747:	e8 c7 fe ff ff       	call   613 <printint>
 74c:	83 c4 10             	add    $0x10,%esp
        ap++;
 74f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 753:	e9 d5 00 00 00       	jmp    82d <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 758:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 75c:	74 06                	je     764 <printf+0xa3>
 75e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 762:	75 1e                	jne    782 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 764:	8b 45 e8             	mov    -0x18(%ebp),%eax
 767:	8b 00                	mov    (%eax),%eax
 769:	6a 00                	push   $0x0
 76b:	6a 10                	push   $0x10
 76d:	50                   	push   %eax
 76e:	ff 75 08             	pushl  0x8(%ebp)
 771:	e8 9d fe ff ff       	call   613 <printint>
 776:	83 c4 10             	add    $0x10,%esp
        ap++;
 779:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 77d:	e9 ab 00 00 00       	jmp    82d <printf+0x16c>
      } else if(c == 's'){
 782:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 786:	75 40                	jne    7c8 <printf+0x107>
        s = (char*)*ap;
 788:	8b 45 e8             	mov    -0x18(%ebp),%eax
 78b:	8b 00                	mov    (%eax),%eax
 78d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 790:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 794:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 798:	75 23                	jne    7bd <printf+0xfc>
          s = "(null)";
 79a:	c7 45 f4 a6 0a 00 00 	movl   $0xaa6,-0xc(%ebp)
        while(*s != 0){
 7a1:	eb 1a                	jmp    7bd <printf+0xfc>
          putc(fd, *s);
 7a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a6:	8a 00                	mov    (%eax),%al
 7a8:	0f be c0             	movsbl %al,%eax
 7ab:	83 ec 08             	sub    $0x8,%esp
 7ae:	50                   	push   %eax
 7af:	ff 75 08             	pushl  0x8(%ebp)
 7b2:	e8 39 fe ff ff       	call   5f0 <putc>
 7b7:	83 c4 10             	add    $0x10,%esp
          s++;
 7ba:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c0:	8a 00                	mov    (%eax),%al
 7c2:	84 c0                	test   %al,%al
 7c4:	75 dd                	jne    7a3 <printf+0xe2>
 7c6:	eb 65                	jmp    82d <printf+0x16c>
        }
      } else if(c == 'c'){
 7c8:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7cc:	75 1d                	jne    7eb <printf+0x12a>
        putc(fd, *ap);
 7ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7d1:	8b 00                	mov    (%eax),%eax
 7d3:	0f be c0             	movsbl %al,%eax
 7d6:	83 ec 08             	sub    $0x8,%esp
 7d9:	50                   	push   %eax
 7da:	ff 75 08             	pushl  0x8(%ebp)
 7dd:	e8 0e fe ff ff       	call   5f0 <putc>
 7e2:	83 c4 10             	add    $0x10,%esp
        ap++;
 7e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7e9:	eb 42                	jmp    82d <printf+0x16c>
      } else if(c == '%'){
 7eb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7ef:	75 17                	jne    808 <printf+0x147>
        putc(fd, c);
 7f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7f4:	0f be c0             	movsbl %al,%eax
 7f7:	83 ec 08             	sub    $0x8,%esp
 7fa:	50                   	push   %eax
 7fb:	ff 75 08             	pushl  0x8(%ebp)
 7fe:	e8 ed fd ff ff       	call   5f0 <putc>
 803:	83 c4 10             	add    $0x10,%esp
 806:	eb 25                	jmp    82d <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 808:	83 ec 08             	sub    $0x8,%esp
 80b:	6a 25                	push   $0x25
 80d:	ff 75 08             	pushl  0x8(%ebp)
 810:	e8 db fd ff ff       	call   5f0 <putc>
 815:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 818:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 81b:	0f be c0             	movsbl %al,%eax
 81e:	83 ec 08             	sub    $0x8,%esp
 821:	50                   	push   %eax
 822:	ff 75 08             	pushl  0x8(%ebp)
 825:	e8 c6 fd ff ff       	call   5f0 <putc>
 82a:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 82d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 834:	ff 45 f0             	incl   -0x10(%ebp)
 837:	8b 55 0c             	mov    0xc(%ebp),%edx
 83a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83d:	01 d0                	add    %edx,%eax
 83f:	8a 00                	mov    (%eax),%al
 841:	84 c0                	test   %al,%al
 843:	0f 85 9a fe ff ff    	jne    6e3 <printf+0x22>
    }
  }
}
 849:	90                   	nop
 84a:	90                   	nop
 84b:	c9                   	leave  
 84c:	c3                   	ret    

0000084d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 84d:	55                   	push   %ebp
 84e:	89 e5                	mov    %esp,%ebp
 850:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 853:	8b 45 08             	mov    0x8(%ebp),%eax
 856:	83 e8 08             	sub    $0x8,%eax
 859:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85c:	a1 e8 0e 00 00       	mov    0xee8,%eax
 861:	89 45 fc             	mov    %eax,-0x4(%ebp)
 864:	eb 24                	jmp    88a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 866:	8b 45 fc             	mov    -0x4(%ebp),%eax
 869:	8b 00                	mov    (%eax),%eax
 86b:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 86e:	72 12                	jb     882 <free+0x35>
 870:	8b 45 f8             	mov    -0x8(%ebp),%eax
 873:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 876:	72 24                	jb     89c <free+0x4f>
 878:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87b:	8b 00                	mov    (%eax),%eax
 87d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 880:	72 1a                	jb     89c <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 882:	8b 45 fc             	mov    -0x4(%ebp),%eax
 885:	8b 00                	mov    (%eax),%eax
 887:	89 45 fc             	mov    %eax,-0x4(%ebp)
 88a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 88d:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 890:	73 d4                	jae    866 <free+0x19>
 892:	8b 45 fc             	mov    -0x4(%ebp),%eax
 895:	8b 00                	mov    (%eax),%eax
 897:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 89a:	73 ca                	jae    866 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 89c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89f:	8b 40 04             	mov    0x4(%eax),%eax
 8a2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ac:	01 c2                	add    %eax,%edx
 8ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b1:	8b 00                	mov    (%eax),%eax
 8b3:	39 c2                	cmp    %eax,%edx
 8b5:	75 24                	jne    8db <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ba:	8b 50 04             	mov    0x4(%eax),%edx
 8bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c0:	8b 00                	mov    (%eax),%eax
 8c2:	8b 40 04             	mov    0x4(%eax),%eax
 8c5:	01 c2                	add    %eax,%edx
 8c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ca:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d0:	8b 00                	mov    (%eax),%eax
 8d2:	8b 10                	mov    (%eax),%edx
 8d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d7:	89 10                	mov    %edx,(%eax)
 8d9:	eb 0a                	jmp    8e5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8de:	8b 10                	mov    (%eax),%edx
 8e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e8:	8b 40 04             	mov    0x4(%eax),%eax
 8eb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f5:	01 d0                	add    %edx,%eax
 8f7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 8fa:	75 20                	jne    91c <free+0xcf>
    p->s.size += bp->s.size;
 8fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ff:	8b 50 04             	mov    0x4(%eax),%edx
 902:	8b 45 f8             	mov    -0x8(%ebp),%eax
 905:	8b 40 04             	mov    0x4(%eax),%eax
 908:	01 c2                	add    %eax,%edx
 90a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 910:	8b 45 f8             	mov    -0x8(%ebp),%eax
 913:	8b 10                	mov    (%eax),%edx
 915:	8b 45 fc             	mov    -0x4(%ebp),%eax
 918:	89 10                	mov    %edx,(%eax)
 91a:	eb 08                	jmp    924 <free+0xd7>
  } else
    p->s.ptr = bp;
 91c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 922:	89 10                	mov    %edx,(%eax)
  freep = p;
 924:	8b 45 fc             	mov    -0x4(%ebp),%eax
 927:	a3 e8 0e 00 00       	mov    %eax,0xee8
}
 92c:	90                   	nop
 92d:	c9                   	leave  
 92e:	c3                   	ret    

0000092f <morecore>:

static Header*
morecore(uint nu)
{
 92f:	55                   	push   %ebp
 930:	89 e5                	mov    %esp,%ebp
 932:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 935:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 93c:	77 07                	ja     945 <morecore+0x16>
    nu = 4096;
 93e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 945:	8b 45 08             	mov    0x8(%ebp),%eax
 948:	c1 e0 03             	shl    $0x3,%eax
 94b:	83 ec 0c             	sub    $0xc,%esp
 94e:	50                   	push   %eax
 94f:	e8 84 fc ff ff       	call   5d8 <sbrk>
 954:	83 c4 10             	add    $0x10,%esp
 957:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 95a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 95e:	75 07                	jne    967 <morecore+0x38>
    return 0;
 960:	b8 00 00 00 00       	mov    $0x0,%eax
 965:	eb 26                	jmp    98d <morecore+0x5e>
  hp = (Header*)p;
 967:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 96d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 970:	8b 55 08             	mov    0x8(%ebp),%edx
 973:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 976:	8b 45 f0             	mov    -0x10(%ebp),%eax
 979:	83 c0 08             	add    $0x8,%eax
 97c:	83 ec 0c             	sub    $0xc,%esp
 97f:	50                   	push   %eax
 980:	e8 c8 fe ff ff       	call   84d <free>
 985:	83 c4 10             	add    $0x10,%esp
  return freep;
 988:	a1 e8 0e 00 00       	mov    0xee8,%eax
}
 98d:	c9                   	leave  
 98e:	c3                   	ret    

0000098f <malloc>:

void*
malloc(uint nbytes)
{
 98f:	55                   	push   %ebp
 990:	89 e5                	mov    %esp,%ebp
 992:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 995:	8b 45 08             	mov    0x8(%ebp),%eax
 998:	83 c0 07             	add    $0x7,%eax
 99b:	c1 e8 03             	shr    $0x3,%eax
 99e:	40                   	inc    %eax
 99f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9a2:	a1 e8 0e 00 00       	mov    0xee8,%eax
 9a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9ae:	75 23                	jne    9d3 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 9b0:	c7 45 f0 e0 0e 00 00 	movl   $0xee0,-0x10(%ebp)
 9b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ba:	a3 e8 0e 00 00       	mov    %eax,0xee8
 9bf:	a1 e8 0e 00 00       	mov    0xee8,%eax
 9c4:	a3 e0 0e 00 00       	mov    %eax,0xee0
    base.s.size = 0;
 9c9:	c7 05 e4 0e 00 00 00 	movl   $0x0,0xee4
 9d0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d6:	8b 00                	mov    (%eax),%eax
 9d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9de:	8b 40 04             	mov    0x4(%eax),%eax
 9e1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9e4:	72 4d                	jb     a33 <malloc+0xa4>
      if(p->s.size == nunits)
 9e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e9:	8b 40 04             	mov    0x4(%eax),%eax
 9ec:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 9ef:	75 0c                	jne    9fd <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 9f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f4:	8b 10                	mov    (%eax),%edx
 9f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f9:	89 10                	mov    %edx,(%eax)
 9fb:	eb 26                	jmp    a23 <malloc+0x94>
      else {
        p->s.size -= nunits;
 9fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a00:	8b 40 04             	mov    0x4(%eax),%eax
 a03:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a06:	89 c2                	mov    %eax,%edx
 a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a11:	8b 40 04             	mov    0x4(%eax),%eax
 a14:	c1 e0 03             	shl    $0x3,%eax
 a17:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a20:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a26:	a3 e8 0e 00 00       	mov    %eax,0xee8
      return (void*)(p + 1);
 a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2e:	83 c0 08             	add    $0x8,%eax
 a31:	eb 3b                	jmp    a6e <malloc+0xdf>
    }
    if(p == freep)
 a33:	a1 e8 0e 00 00       	mov    0xee8,%eax
 a38:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a3b:	75 1e                	jne    a5b <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 a3d:	83 ec 0c             	sub    $0xc,%esp
 a40:	ff 75 ec             	pushl  -0x14(%ebp)
 a43:	e8 e7 fe ff ff       	call   92f <morecore>
 a48:	83 c4 10             	add    $0x10,%esp
 a4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a52:	75 07                	jne    a5b <malloc+0xcc>
        return 0;
 a54:	b8 00 00 00 00       	mov    $0x0,%eax
 a59:	eb 13                	jmp    a6e <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a64:	8b 00                	mov    (%eax),%eax
 a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a69:	e9 6d ff ff ff       	jmp    9db <malloc+0x4c>
  }
}
 a6e:	c9                   	leave  
 a6f:	c3                   	ret    
