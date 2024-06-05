
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	83 ec 0c             	sub    $0xc,%esp
   a:	ff 75 08             	pushl  0x8(%ebp)
   d:	e8 b6 03 00 00       	call   3c8 <strlen>
  12:	83 c4 10             	add    $0x10,%esp
  15:	8b 55 08             	mov    0x8(%ebp),%edx
  18:	01 d0                	add    %edx,%eax
  1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1d:	eb 03                	jmp    22 <fmtname+0x22>
  1f:	ff 4d f4             	decl   -0xc(%ebp)
  22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  25:	3b 45 08             	cmp    0x8(%ebp),%eax
  28:	72 09                	jb     33 <fmtname+0x33>
  2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  2d:	8a 00                	mov    (%eax),%al
  2f:	3c 2f                	cmp    $0x2f,%al
  31:	75 ec                	jne    1f <fmtname+0x1f>
    ;
  p++;
  33:	ff 45 f4             	incl   -0xc(%ebp)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	83 ec 0c             	sub    $0xc,%esp
  39:	ff 75 f4             	pushl  -0xc(%ebp)
  3c:	e8 87 03 00 00       	call   3c8 <strlen>
  41:	83 c4 10             	add    $0x10,%esp
  44:	83 f8 0d             	cmp    $0xd,%eax
  47:	76 05                	jbe    4e <fmtname+0x4e>
    return p;
  49:	8b 45 f4             	mov    -0xc(%ebp),%eax
  4c:	eb 60                	jmp    ae <fmtname+0xae>
  memmove(buf, p, strlen(p));
  4e:	83 ec 0c             	sub    $0xc,%esp
  51:	ff 75 f4             	pushl  -0xc(%ebp)
  54:	e8 6f 03 00 00       	call   3c8 <strlen>
  59:	83 c4 10             	add    $0x10,%esp
  5c:	83 ec 04             	sub    $0x4,%esp
  5f:	50                   	push   %eax
  60:	ff 75 f4             	pushl  -0xc(%ebp)
  63:	68 04 0b 00 00       	push   $0xb04
  68:	e8 cb 04 00 00       	call   538 <memmove>
  6d:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  70:	83 ec 0c             	sub    $0xc,%esp
  73:	ff 75 f4             	pushl  -0xc(%ebp)
  76:	e8 4d 03 00 00       	call   3c8 <strlen>
  7b:	83 c4 10             	add    $0x10,%esp
  7e:	ba 0e 00 00 00       	mov    $0xe,%edx
  83:	89 d3                	mov    %edx,%ebx
  85:	29 c3                	sub    %eax,%ebx
  87:	83 ec 0c             	sub    $0xc,%esp
  8a:	ff 75 f4             	pushl  -0xc(%ebp)
  8d:	e8 36 03 00 00       	call   3c8 <strlen>
  92:	83 c4 10             	add    $0x10,%esp
  95:	05 04 0b 00 00       	add    $0xb04,%eax
  9a:	83 ec 04             	sub    $0x4,%esp
  9d:	53                   	push   %ebx
  9e:	6a 20                	push   $0x20
  a0:	50                   	push   %eax
  a1:	e8 47 03 00 00       	call   3ed <memset>
  a6:	83 c4 10             	add    $0x10,%esp
  return buf;
  a9:	b8 04 0b 00 00       	mov    $0xb04,%eax
}
  ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b1:	c9                   	leave  
  b2:	c3                   	ret    

000000b3 <ls>:

void
ls(char *path)
{
  b3:	55                   	push   %ebp
  b4:	89 e5                	mov    %esp,%ebp
  b6:	57                   	push   %edi
  b7:	56                   	push   %esi
  b8:	53                   	push   %ebx
  b9:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  bf:	83 ec 08             	sub    $0x8,%esp
  c2:	6a 00                	push   $0x0
  c4:	ff 75 08             	pushl  0x8(%ebp)
  c7:	e8 f0 04 00 00       	call   5bc <open>
  cc:	83 c4 10             	add    $0x10,%esp
  cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  d6:	79 1a                	jns    f2 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
  d8:	83 ec 04             	sub    $0x4,%esp
  db:	ff 75 08             	pushl  0x8(%ebp)
  de:	68 9c 0a 00 00       	push   $0xa9c
  e3:	6a 02                	push   $0x2
  e5:	e8 03 06 00 00       	call   6ed <printf>
  ea:	83 c4 10             	add    $0x10,%esp
    return;
  ed:	e9 df 01 00 00       	jmp    2d1 <ls+0x21e>
  }

  if(fstat(fd, &st) < 0){
  f2:	83 ec 08             	sub    $0x8,%esp
  f5:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
  fb:	50                   	push   %eax
  fc:	ff 75 e4             	pushl  -0x1c(%ebp)
  ff:	e8 d0 04 00 00       	call   5d4 <fstat>
 104:	83 c4 10             	add    $0x10,%esp
 107:	85 c0                	test   %eax,%eax
 109:	79 28                	jns    133 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
 10b:	83 ec 04             	sub    $0x4,%esp
 10e:	ff 75 08             	pushl  0x8(%ebp)
 111:	68 b0 0a 00 00       	push   $0xab0
 116:	6a 02                	push   $0x2
 118:	e8 d0 05 00 00       	call   6ed <printf>
 11d:	83 c4 10             	add    $0x10,%esp
    close(fd);
 120:	83 ec 0c             	sub    $0xc,%esp
 123:	ff 75 e4             	pushl  -0x1c(%ebp)
 126:	e8 79 04 00 00       	call   5a4 <close>
 12b:	83 c4 10             	add    $0x10,%esp
    return;
 12e:	e9 9e 01 00 00       	jmp    2d1 <ls+0x21e>
  }

  switch(st.type){
 133:	8b 85 bc fd ff ff    	mov    -0x244(%ebp),%eax
 139:	98                   	cwtl   
 13a:	83 f8 01             	cmp    $0x1,%eax
 13d:	74 47                	je     186 <ls+0xd3>
 13f:	83 f8 02             	cmp    $0x2,%eax
 142:	0f 85 7b 01 00 00    	jne    2c3 <ls+0x210>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 148:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 14e:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 154:	8b 85 bc fd ff ff    	mov    -0x244(%ebp),%eax
 15a:	0f bf d8             	movswl %ax,%ebx
 15d:	83 ec 0c             	sub    $0xc,%esp
 160:	ff 75 08             	pushl  0x8(%ebp)
 163:	e8 98 fe ff ff       	call   0 <fmtname>
 168:	83 c4 10             	add    $0x10,%esp
 16b:	83 ec 08             	sub    $0x8,%esp
 16e:	57                   	push   %edi
 16f:	56                   	push   %esi
 170:	53                   	push   %ebx
 171:	50                   	push   %eax
 172:	68 c4 0a 00 00       	push   $0xac4
 177:	6a 01                	push   $0x1
 179:	e8 6f 05 00 00       	call   6ed <printf>
 17e:	83 c4 20             	add    $0x20,%esp
    break;
 181:	e9 3d 01 00 00       	jmp    2c3 <ls+0x210>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 186:	83 ec 0c             	sub    $0xc,%esp
 189:	ff 75 08             	pushl  0x8(%ebp)
 18c:	e8 37 02 00 00       	call   3c8 <strlen>
 191:	83 c4 10             	add    $0x10,%esp
 194:	83 c0 10             	add    $0x10,%eax
 197:	3d 00 02 00 00       	cmp    $0x200,%eax
 19c:	76 17                	jbe    1b5 <ls+0x102>
      printf(1, "ls: path too long\n");
 19e:	83 ec 08             	sub    $0x8,%esp
 1a1:	68 d1 0a 00 00       	push   $0xad1
 1a6:	6a 01                	push   $0x1
 1a8:	e8 40 05 00 00       	call   6ed <printf>
 1ad:	83 c4 10             	add    $0x10,%esp
      break;
 1b0:	e9 0e 01 00 00       	jmp    2c3 <ls+0x210>
    }
    strcpy(buf, path);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	ff 75 08             	pushl  0x8(%ebp)
 1bb:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1c1:	50                   	push   %eax
 1c2:	e8 9b 01 00 00       	call   362 <strcpy>
 1c7:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1ca:	83 ec 0c             	sub    $0xc,%esp
 1cd:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1d3:	50                   	push   %eax
 1d4:	e8 ef 01 00 00       	call   3c8 <strlen>
 1d9:	83 c4 10             	add    $0x10,%esp
 1dc:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
 1e2:	01 d0                	add    %edx,%eax
 1e4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1ea:	8d 50 01             	lea    0x1(%eax),%edx
 1ed:	89 55 e0             	mov    %edx,-0x20(%ebp)
 1f0:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f3:	e9 aa 00 00 00       	jmp    2a2 <ls+0x1ef>
      if(de.inum == 0)
 1f8:	8b 85 d0 fd ff ff    	mov    -0x230(%ebp),%eax
 1fe:	66 85 c0             	test   %ax,%ax
 201:	0f 84 9a 00 00 00    	je     2a1 <ls+0x1ee>
        continue;
      memmove(p, de.name, DIRSIZ);
 207:	83 ec 04             	sub    $0x4,%esp
 20a:	6a 0e                	push   $0xe
 20c:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 212:	83 c0 02             	add    $0x2,%eax
 215:	50                   	push   %eax
 216:	ff 75 e0             	pushl  -0x20(%ebp)
 219:	e8 1a 03 00 00       	call   538 <memmove>
 21e:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
 221:	8b 45 e0             	mov    -0x20(%ebp),%eax
 224:	83 c0 0e             	add    $0xe,%eax
 227:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 22a:	83 ec 08             	sub    $0x8,%esp
 22d:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 233:	50                   	push   %eax
 234:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 23a:	50                   	push   %eax
 23b:	e8 61 02 00 00       	call   4a1 <stat>
 240:	83 c4 10             	add    $0x10,%esp
 243:	85 c0                	test   %eax,%eax
 245:	79 1b                	jns    262 <ls+0x1af>
        printf(1, "ls: cannot stat %s\n", buf);
 247:	83 ec 04             	sub    $0x4,%esp
 24a:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 250:	50                   	push   %eax
 251:	68 b0 0a 00 00       	push   $0xab0
 256:	6a 01                	push   $0x1
 258:	e8 90 04 00 00       	call   6ed <printf>
 25d:	83 c4 10             	add    $0x10,%esp
        continue;
 260:	eb 40                	jmp    2a2 <ls+0x1ef>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 262:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 268:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 26e:	8b 85 bc fd ff ff    	mov    -0x244(%ebp),%eax
 274:	0f bf d8             	movswl %ax,%ebx
 277:	83 ec 0c             	sub    $0xc,%esp
 27a:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 280:	50                   	push   %eax
 281:	e8 7a fd ff ff       	call   0 <fmtname>
 286:	83 c4 10             	add    $0x10,%esp
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	57                   	push   %edi
 28d:	56                   	push   %esi
 28e:	53                   	push   %ebx
 28f:	50                   	push   %eax
 290:	68 c4 0a 00 00       	push   $0xac4
 295:	6a 01                	push   $0x1
 297:	e8 51 04 00 00       	call   6ed <printf>
 29c:	83 c4 20             	add    $0x20,%esp
 29f:	eb 01                	jmp    2a2 <ls+0x1ef>
        continue;
 2a1:	90                   	nop
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2a2:	83 ec 04             	sub    $0x4,%esp
 2a5:	6a 10                	push   $0x10
 2a7:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2ad:	50                   	push   %eax
 2ae:	ff 75 e4             	pushl  -0x1c(%ebp)
 2b1:	e8 de 02 00 00       	call   594 <read>
 2b6:	83 c4 10             	add    $0x10,%esp
 2b9:	83 f8 10             	cmp    $0x10,%eax
 2bc:	0f 84 36 ff ff ff    	je     1f8 <ls+0x145>
    }
    break;
 2c2:	90                   	nop
  }
  close(fd);
 2c3:	83 ec 0c             	sub    $0xc,%esp
 2c6:	ff 75 e4             	pushl  -0x1c(%ebp)
 2c9:	e8 d6 02 00 00       	call   5a4 <close>
 2ce:	83 c4 10             	add    $0x10,%esp
}
 2d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2d4:	5b                   	pop    %ebx
 2d5:	5e                   	pop    %esi
 2d6:	5f                   	pop    %edi
 2d7:	5d                   	pop    %ebp
 2d8:	c3                   	ret    

000002d9 <main>:

int
main(int argc, char *argv[])
{
 2d9:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2dd:	83 e4 f0             	and    $0xfffffff0,%esp
 2e0:	ff 71 fc             	pushl  -0x4(%ecx)
 2e3:	55                   	push   %ebp
 2e4:	89 e5                	mov    %esp,%ebp
 2e6:	53                   	push   %ebx
 2e7:	51                   	push   %ecx
 2e8:	83 ec 10             	sub    $0x10,%esp
 2eb:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
 2ed:	83 3b 01             	cmpl   $0x1,(%ebx)
 2f0:	7f 15                	jg     307 <main+0x2e>
    ls(".");
 2f2:	83 ec 0c             	sub    $0xc,%esp
 2f5:	68 e4 0a 00 00       	push   $0xae4
 2fa:	e8 b4 fd ff ff       	call   b3 <ls>
 2ff:	83 c4 10             	add    $0x10,%esp
    exit();
 302:	e8 75 02 00 00       	call   57c <exit>
  }
  for(i=1; i<argc; i++)
 307:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 30e:	eb 20                	jmp    330 <main+0x57>
    ls(argv[i]);
 310:	8b 45 f4             	mov    -0xc(%ebp),%eax
 313:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 31a:	8b 43 04             	mov    0x4(%ebx),%eax
 31d:	01 d0                	add    %edx,%eax
 31f:	8b 00                	mov    (%eax),%eax
 321:	83 ec 0c             	sub    $0xc,%esp
 324:	50                   	push   %eax
 325:	e8 89 fd ff ff       	call   b3 <ls>
 32a:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
 32d:	ff 45 f4             	incl   -0xc(%ebp)
 330:	8b 45 f4             	mov    -0xc(%ebp),%eax
 333:	3b 03                	cmp    (%ebx),%eax
 335:	7c d9                	jl     310 <main+0x37>
  exit();
 337:	e8 40 02 00 00       	call   57c <exit>

0000033c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 33c:	55                   	push   %ebp
 33d:	89 e5                	mov    %esp,%ebp
 33f:	57                   	push   %edi
 340:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 341:	8b 4d 08             	mov    0x8(%ebp),%ecx
 344:	8b 55 10             	mov    0x10(%ebp),%edx
 347:	8b 45 0c             	mov    0xc(%ebp),%eax
 34a:	89 cb                	mov    %ecx,%ebx
 34c:	89 df                	mov    %ebx,%edi
 34e:	89 d1                	mov    %edx,%ecx
 350:	fc                   	cld    
 351:	f3 aa                	rep stos %al,%es:(%edi)
 353:	89 ca                	mov    %ecx,%edx
 355:	89 fb                	mov    %edi,%ebx
 357:	89 5d 08             	mov    %ebx,0x8(%ebp)
 35a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 35d:	90                   	nop
 35e:	5b                   	pop    %ebx
 35f:	5f                   	pop    %edi
 360:	5d                   	pop    %ebp
 361:	c3                   	ret    

00000362 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 362:	55                   	push   %ebp
 363:	89 e5                	mov    %esp,%ebp
 365:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 36e:	90                   	nop
 36f:	8b 55 0c             	mov    0xc(%ebp),%edx
 372:	8d 42 01             	lea    0x1(%edx),%eax
 375:	89 45 0c             	mov    %eax,0xc(%ebp)
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	8d 48 01             	lea    0x1(%eax),%ecx
 37e:	89 4d 08             	mov    %ecx,0x8(%ebp)
 381:	8a 12                	mov    (%edx),%dl
 383:	88 10                	mov    %dl,(%eax)
 385:	8a 00                	mov    (%eax),%al
 387:	84 c0                	test   %al,%al
 389:	75 e4                	jne    36f <strcpy+0xd>
    ;
  return os;
 38b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 38e:	c9                   	leave  
 38f:	c3                   	ret    

00000390 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 393:	eb 06                	jmp    39b <strcmp+0xb>
    p++, q++;
 395:	ff 45 08             	incl   0x8(%ebp)
 398:	ff 45 0c             	incl   0xc(%ebp)
  while(*p && *p == *q)
 39b:	8b 45 08             	mov    0x8(%ebp),%eax
 39e:	8a 00                	mov    (%eax),%al
 3a0:	84 c0                	test   %al,%al
 3a2:	74 0e                	je     3b2 <strcmp+0x22>
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	8a 10                	mov    (%eax),%dl
 3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ac:	8a 00                	mov    (%eax),%al
 3ae:	38 c2                	cmp    %al,%dl
 3b0:	74 e3                	je     395 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 3b2:	8b 45 08             	mov    0x8(%ebp),%eax
 3b5:	8a 00                	mov    (%eax),%al
 3b7:	0f b6 d0             	movzbl %al,%edx
 3ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bd:	8a 00                	mov    (%eax),%al
 3bf:	0f b6 c0             	movzbl %al,%eax
 3c2:	29 c2                	sub    %eax,%edx
 3c4:	89 d0                	mov    %edx,%eax
}
 3c6:	5d                   	pop    %ebp
 3c7:	c3                   	ret    

000003c8 <strlen>:

uint
strlen(char *s)
{
 3c8:	55                   	push   %ebp
 3c9:	89 e5                	mov    %esp,%ebp
 3cb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3d5:	eb 03                	jmp    3da <strlen+0x12>
 3d7:	ff 45 fc             	incl   -0x4(%ebp)
 3da:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	01 d0                	add    %edx,%eax
 3e2:	8a 00                	mov    (%eax),%al
 3e4:	84 c0                	test   %al,%al
 3e6:	75 ef                	jne    3d7 <strlen+0xf>
    ;
  return n;
 3e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3eb:	c9                   	leave  
 3ec:	c3                   	ret    

000003ed <memset>:

void*
memset(void *dst, int c, uint n)
{
 3ed:	55                   	push   %ebp
 3ee:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3f0:	8b 45 10             	mov    0x10(%ebp),%eax
 3f3:	50                   	push   %eax
 3f4:	ff 75 0c             	pushl  0xc(%ebp)
 3f7:	ff 75 08             	pushl  0x8(%ebp)
 3fa:	e8 3d ff ff ff       	call   33c <stosb>
 3ff:	83 c4 0c             	add    $0xc,%esp
  return dst;
 402:	8b 45 08             	mov    0x8(%ebp),%eax
}
 405:	c9                   	leave  
 406:	c3                   	ret    

00000407 <strchr>:

char*
strchr(const char *s, char c)
{
 407:	55                   	push   %ebp
 408:	89 e5                	mov    %esp,%ebp
 40a:	83 ec 04             	sub    $0x4,%esp
 40d:	8b 45 0c             	mov    0xc(%ebp),%eax
 410:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 413:	eb 12                	jmp    427 <strchr+0x20>
    if(*s == c)
 415:	8b 45 08             	mov    0x8(%ebp),%eax
 418:	8a 00                	mov    (%eax),%al
 41a:	38 45 fc             	cmp    %al,-0x4(%ebp)
 41d:	75 05                	jne    424 <strchr+0x1d>
      return (char*)s;
 41f:	8b 45 08             	mov    0x8(%ebp),%eax
 422:	eb 11                	jmp    435 <strchr+0x2e>
  for(; *s; s++)
 424:	ff 45 08             	incl   0x8(%ebp)
 427:	8b 45 08             	mov    0x8(%ebp),%eax
 42a:	8a 00                	mov    (%eax),%al
 42c:	84 c0                	test   %al,%al
 42e:	75 e5                	jne    415 <strchr+0xe>
  return 0;
 430:	b8 00 00 00 00       	mov    $0x0,%eax
}
 435:	c9                   	leave  
 436:	c3                   	ret    

00000437 <gets>:

char*
gets(char *buf, int max)
{
 437:	55                   	push   %ebp
 438:	89 e5                	mov    %esp,%ebp
 43a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 444:	eb 3f                	jmp    485 <gets+0x4e>
    cc = read(0, &c, 1);
 446:	83 ec 04             	sub    $0x4,%esp
 449:	6a 01                	push   $0x1
 44b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 44e:	50                   	push   %eax
 44f:	6a 00                	push   $0x0
 451:	e8 3e 01 00 00       	call   594 <read>
 456:	83 c4 10             	add    $0x10,%esp
 459:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 45c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 460:	7e 2e                	jle    490 <gets+0x59>
      break;
    buf[i++] = c;
 462:	8b 45 f4             	mov    -0xc(%ebp),%eax
 465:	8d 50 01             	lea    0x1(%eax),%edx
 468:	89 55 f4             	mov    %edx,-0xc(%ebp)
 46b:	89 c2                	mov    %eax,%edx
 46d:	8b 45 08             	mov    0x8(%ebp),%eax
 470:	01 c2                	add    %eax,%edx
 472:	8a 45 ef             	mov    -0x11(%ebp),%al
 475:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 477:	8a 45 ef             	mov    -0x11(%ebp),%al
 47a:	3c 0a                	cmp    $0xa,%al
 47c:	74 13                	je     491 <gets+0x5a>
 47e:	8a 45 ef             	mov    -0x11(%ebp),%al
 481:	3c 0d                	cmp    $0xd,%al
 483:	74 0c                	je     491 <gets+0x5a>
  for(i=0; i+1 < max; ){
 485:	8b 45 f4             	mov    -0xc(%ebp),%eax
 488:	40                   	inc    %eax
 489:	39 45 0c             	cmp    %eax,0xc(%ebp)
 48c:	7f b8                	jg     446 <gets+0xf>
 48e:	eb 01                	jmp    491 <gets+0x5a>
      break;
 490:	90                   	nop
      break;
  }
  buf[i] = '\0';
 491:	8b 55 f4             	mov    -0xc(%ebp),%edx
 494:	8b 45 08             	mov    0x8(%ebp),%eax
 497:	01 d0                	add    %edx,%eax
 499:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 49c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 49f:	c9                   	leave  
 4a0:	c3                   	ret    

000004a1 <stat>:

int
stat(char *n, struct stat *st)
{
 4a1:	55                   	push   %ebp
 4a2:	89 e5                	mov    %esp,%ebp
 4a4:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a7:	83 ec 08             	sub    $0x8,%esp
 4aa:	6a 00                	push   $0x0
 4ac:	ff 75 08             	pushl  0x8(%ebp)
 4af:	e8 08 01 00 00       	call   5bc <open>
 4b4:	83 c4 10             	add    $0x10,%esp
 4b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4be:	79 07                	jns    4c7 <stat+0x26>
    return -1;
 4c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4c5:	eb 25                	jmp    4ec <stat+0x4b>
  r = fstat(fd, st);
 4c7:	83 ec 08             	sub    $0x8,%esp
 4ca:	ff 75 0c             	pushl  0xc(%ebp)
 4cd:	ff 75 f4             	pushl  -0xc(%ebp)
 4d0:	e8 ff 00 00 00       	call   5d4 <fstat>
 4d5:	83 c4 10             	add    $0x10,%esp
 4d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4db:	83 ec 0c             	sub    $0xc,%esp
 4de:	ff 75 f4             	pushl  -0xc(%ebp)
 4e1:	e8 be 00 00 00       	call   5a4 <close>
 4e6:	83 c4 10             	add    $0x10,%esp
  return r;
 4e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4ec:	c9                   	leave  
 4ed:	c3                   	ret    

000004ee <atoi>:

int
atoi(const char *s)
{
 4ee:	55                   	push   %ebp
 4ef:	89 e5                	mov    %esp,%ebp
 4f1:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 4f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 4fb:	eb 24                	jmp    521 <atoi+0x33>
    n = n*10 + *s++ - '0';
 4fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
 500:	89 d0                	mov    %edx,%eax
 502:	c1 e0 02             	shl    $0x2,%eax
 505:	01 d0                	add    %edx,%eax
 507:	01 c0                	add    %eax,%eax
 509:	89 c1                	mov    %eax,%ecx
 50b:	8b 45 08             	mov    0x8(%ebp),%eax
 50e:	8d 50 01             	lea    0x1(%eax),%edx
 511:	89 55 08             	mov    %edx,0x8(%ebp)
 514:	8a 00                	mov    (%eax),%al
 516:	0f be c0             	movsbl %al,%eax
 519:	01 c8                	add    %ecx,%eax
 51b:	83 e8 30             	sub    $0x30,%eax
 51e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 521:	8b 45 08             	mov    0x8(%ebp),%eax
 524:	8a 00                	mov    (%eax),%al
 526:	3c 2f                	cmp    $0x2f,%al
 528:	7e 09                	jle    533 <atoi+0x45>
 52a:	8b 45 08             	mov    0x8(%ebp),%eax
 52d:	8a 00                	mov    (%eax),%al
 52f:	3c 39                	cmp    $0x39,%al
 531:	7e ca                	jle    4fd <atoi+0xf>
  return n;
 533:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 536:	c9                   	leave  
 537:	c3                   	ret    

00000538 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 538:	55                   	push   %ebp
 539:	89 e5                	mov    %esp,%ebp
 53b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 53e:	8b 45 08             	mov    0x8(%ebp),%eax
 541:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 544:	8b 45 0c             	mov    0xc(%ebp),%eax
 547:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 54a:	eb 16                	jmp    562 <memmove+0x2a>
    *dst++ = *src++;
 54c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 54f:	8d 42 01             	lea    0x1(%edx),%eax
 552:	89 45 f8             	mov    %eax,-0x8(%ebp)
 555:	8b 45 fc             	mov    -0x4(%ebp),%eax
 558:	8d 48 01             	lea    0x1(%eax),%ecx
 55b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 55e:	8a 12                	mov    (%edx),%dl
 560:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 562:	8b 45 10             	mov    0x10(%ebp),%eax
 565:	8d 50 ff             	lea    -0x1(%eax),%edx
 568:	89 55 10             	mov    %edx,0x10(%ebp)
 56b:	85 c0                	test   %eax,%eax
 56d:	7f dd                	jg     54c <memmove+0x14>
  return vdst;
 56f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 572:	c9                   	leave  
 573:	c3                   	ret    

00000574 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 574:	b8 01 00 00 00       	mov    $0x1,%eax
 579:	cd 40                	int    $0x40
 57b:	c3                   	ret    

0000057c <exit>:
SYSCALL(exit)
 57c:	b8 02 00 00 00       	mov    $0x2,%eax
 581:	cd 40                	int    $0x40
 583:	c3                   	ret    

00000584 <wait>:
SYSCALL(wait)
 584:	b8 03 00 00 00       	mov    $0x3,%eax
 589:	cd 40                	int    $0x40
 58b:	c3                   	ret    

0000058c <pipe>:
SYSCALL(pipe)
 58c:	b8 04 00 00 00       	mov    $0x4,%eax
 591:	cd 40                	int    $0x40
 593:	c3                   	ret    

00000594 <read>:
SYSCALL(read)
 594:	b8 05 00 00 00       	mov    $0x5,%eax
 599:	cd 40                	int    $0x40
 59b:	c3                   	ret    

0000059c <write>:
SYSCALL(write)
 59c:	b8 10 00 00 00       	mov    $0x10,%eax
 5a1:	cd 40                	int    $0x40
 5a3:	c3                   	ret    

000005a4 <close>:
SYSCALL(close)
 5a4:	b8 15 00 00 00       	mov    $0x15,%eax
 5a9:	cd 40                	int    $0x40
 5ab:	c3                   	ret    

000005ac <kill>:
SYSCALL(kill)
 5ac:	b8 06 00 00 00       	mov    $0x6,%eax
 5b1:	cd 40                	int    $0x40
 5b3:	c3                   	ret    

000005b4 <exec>:
SYSCALL(exec)
 5b4:	b8 07 00 00 00       	mov    $0x7,%eax
 5b9:	cd 40                	int    $0x40
 5bb:	c3                   	ret    

000005bc <open>:
SYSCALL(open)
 5bc:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c1:	cd 40                	int    $0x40
 5c3:	c3                   	ret    

000005c4 <mknod>:
SYSCALL(mknod)
 5c4:	b8 11 00 00 00       	mov    $0x11,%eax
 5c9:	cd 40                	int    $0x40
 5cb:	c3                   	ret    

000005cc <unlink>:
SYSCALL(unlink)
 5cc:	b8 12 00 00 00       	mov    $0x12,%eax
 5d1:	cd 40                	int    $0x40
 5d3:	c3                   	ret    

000005d4 <fstat>:
SYSCALL(fstat)
 5d4:	b8 08 00 00 00       	mov    $0x8,%eax
 5d9:	cd 40                	int    $0x40
 5db:	c3                   	ret    

000005dc <link>:
SYSCALL(link)
 5dc:	b8 13 00 00 00       	mov    $0x13,%eax
 5e1:	cd 40                	int    $0x40
 5e3:	c3                   	ret    

000005e4 <mkdir>:
SYSCALL(mkdir)
 5e4:	b8 14 00 00 00       	mov    $0x14,%eax
 5e9:	cd 40                	int    $0x40
 5eb:	c3                   	ret    

000005ec <chdir>:
SYSCALL(chdir)
 5ec:	b8 09 00 00 00       	mov    $0x9,%eax
 5f1:	cd 40                	int    $0x40
 5f3:	c3                   	ret    

000005f4 <dup>:
SYSCALL(dup)
 5f4:	b8 0a 00 00 00       	mov    $0xa,%eax
 5f9:	cd 40                	int    $0x40
 5fb:	c3                   	ret    

000005fc <getpid>:
SYSCALL(getpid)
 5fc:	b8 0b 00 00 00       	mov    $0xb,%eax
 601:	cd 40                	int    $0x40
 603:	c3                   	ret    

00000604 <sbrk>:
SYSCALL(sbrk)
 604:	b8 0c 00 00 00       	mov    $0xc,%eax
 609:	cd 40                	int    $0x40
 60b:	c3                   	ret    

0000060c <sleep>:
SYSCALL(sleep)
 60c:	b8 0d 00 00 00       	mov    $0xd,%eax
 611:	cd 40                	int    $0x40
 613:	c3                   	ret    

00000614 <uptime>:
SYSCALL(uptime)
 614:	b8 0e 00 00 00       	mov    $0xe,%eax
 619:	cd 40                	int    $0x40
 61b:	c3                   	ret    

0000061c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 61c:	55                   	push   %ebp
 61d:	89 e5                	mov    %esp,%ebp
 61f:	83 ec 18             	sub    $0x18,%esp
 622:	8b 45 0c             	mov    0xc(%ebp),%eax
 625:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 628:	83 ec 04             	sub    $0x4,%esp
 62b:	6a 01                	push   $0x1
 62d:	8d 45 f4             	lea    -0xc(%ebp),%eax
 630:	50                   	push   %eax
 631:	ff 75 08             	pushl  0x8(%ebp)
 634:	e8 63 ff ff ff       	call   59c <write>
 639:	83 c4 10             	add    $0x10,%esp
}
 63c:	90                   	nop
 63d:	c9                   	leave  
 63e:	c3                   	ret    

0000063f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 63f:	55                   	push   %ebp
 640:	89 e5                	mov    %esp,%ebp
 642:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 645:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 64c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 650:	74 17                	je     669 <printint+0x2a>
 652:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 656:	79 11                	jns    669 <printint+0x2a>
    neg = 1;
 658:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 65f:	8b 45 0c             	mov    0xc(%ebp),%eax
 662:	f7 d8                	neg    %eax
 664:	89 45 ec             	mov    %eax,-0x14(%ebp)
 667:	eb 06                	jmp    66f <printint+0x30>
  } else {
    x = xx;
 669:	8b 45 0c             	mov    0xc(%ebp),%eax
 66c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 66f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 676:	8b 4d 10             	mov    0x10(%ebp),%ecx
 679:	8b 45 ec             	mov    -0x14(%ebp),%eax
 67c:	ba 00 00 00 00       	mov    $0x0,%edx
 681:	f7 f1                	div    %ecx
 683:	89 d1                	mov    %edx,%ecx
 685:	8b 45 f4             	mov    -0xc(%ebp),%eax
 688:	8d 50 01             	lea    0x1(%eax),%edx
 68b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 68e:	8a 91 f0 0a 00 00    	mov    0xaf0(%ecx),%dl
 694:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 698:	8b 4d 10             	mov    0x10(%ebp),%ecx
 69b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 69e:	ba 00 00 00 00       	mov    $0x0,%edx
 6a3:	f7 f1                	div    %ecx
 6a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6ac:	75 c8                	jne    676 <printint+0x37>
  if(neg)
 6ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6b2:	74 2c                	je     6e0 <printint+0xa1>
    buf[i++] = '-';
 6b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b7:	8d 50 01             	lea    0x1(%eax),%edx
 6ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6bd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6c2:	eb 1c                	jmp    6e0 <printint+0xa1>
    putc(fd, buf[i]);
 6c4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ca:	01 d0                	add    %edx,%eax
 6cc:	8a 00                	mov    (%eax),%al
 6ce:	0f be c0             	movsbl %al,%eax
 6d1:	83 ec 08             	sub    $0x8,%esp
 6d4:	50                   	push   %eax
 6d5:	ff 75 08             	pushl  0x8(%ebp)
 6d8:	e8 3f ff ff ff       	call   61c <putc>
 6dd:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 6e0:	ff 4d f4             	decl   -0xc(%ebp)
 6e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e7:	79 db                	jns    6c4 <printint+0x85>
}
 6e9:	90                   	nop
 6ea:	90                   	nop
 6eb:	c9                   	leave  
 6ec:	c3                   	ret    

000006ed <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6ed:	55                   	push   %ebp
 6ee:	89 e5                	mov    %esp,%ebp
 6f0:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6f3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6fa:	8d 45 0c             	lea    0xc(%ebp),%eax
 6fd:	83 c0 04             	add    $0x4,%eax
 700:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 703:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 70a:	e9 54 01 00 00       	jmp    863 <printf+0x176>
    c = fmt[i] & 0xff;
 70f:	8b 55 0c             	mov    0xc(%ebp),%edx
 712:	8b 45 f0             	mov    -0x10(%ebp),%eax
 715:	01 d0                	add    %edx,%eax
 717:	8a 00                	mov    (%eax),%al
 719:	0f be c0             	movsbl %al,%eax
 71c:	25 ff 00 00 00       	and    $0xff,%eax
 721:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 724:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 728:	75 2c                	jne    756 <printf+0x69>
      if(c == '%'){
 72a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 72e:	75 0c                	jne    73c <printf+0x4f>
        state = '%';
 730:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 737:	e9 24 01 00 00       	jmp    860 <printf+0x173>
      } else {
        putc(fd, c);
 73c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 73f:	0f be c0             	movsbl %al,%eax
 742:	83 ec 08             	sub    $0x8,%esp
 745:	50                   	push   %eax
 746:	ff 75 08             	pushl  0x8(%ebp)
 749:	e8 ce fe ff ff       	call   61c <putc>
 74e:	83 c4 10             	add    $0x10,%esp
 751:	e9 0a 01 00 00       	jmp    860 <printf+0x173>
      }
    } else if(state == '%'){
 756:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 75a:	0f 85 00 01 00 00    	jne    860 <printf+0x173>
      if(c == 'd'){
 760:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 764:	75 1e                	jne    784 <printf+0x97>
        printint(fd, *ap, 10, 1);
 766:	8b 45 e8             	mov    -0x18(%ebp),%eax
 769:	8b 00                	mov    (%eax),%eax
 76b:	6a 01                	push   $0x1
 76d:	6a 0a                	push   $0xa
 76f:	50                   	push   %eax
 770:	ff 75 08             	pushl  0x8(%ebp)
 773:	e8 c7 fe ff ff       	call   63f <printint>
 778:	83 c4 10             	add    $0x10,%esp
        ap++;
 77b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 77f:	e9 d5 00 00 00       	jmp    859 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 784:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 788:	74 06                	je     790 <printf+0xa3>
 78a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 78e:	75 1e                	jne    7ae <printf+0xc1>
        printint(fd, *ap, 16, 0);
 790:	8b 45 e8             	mov    -0x18(%ebp),%eax
 793:	8b 00                	mov    (%eax),%eax
 795:	6a 00                	push   $0x0
 797:	6a 10                	push   $0x10
 799:	50                   	push   %eax
 79a:	ff 75 08             	pushl  0x8(%ebp)
 79d:	e8 9d fe ff ff       	call   63f <printint>
 7a2:	83 c4 10             	add    $0x10,%esp
        ap++;
 7a5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7a9:	e9 ab 00 00 00       	jmp    859 <printf+0x16c>
      } else if(c == 's'){
 7ae:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7b2:	75 40                	jne    7f4 <printf+0x107>
        s = (char*)*ap;
 7b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7b7:	8b 00                	mov    (%eax),%eax
 7b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7c4:	75 23                	jne    7e9 <printf+0xfc>
          s = "(null)";
 7c6:	c7 45 f4 e6 0a 00 00 	movl   $0xae6,-0xc(%ebp)
        while(*s != 0){
 7cd:	eb 1a                	jmp    7e9 <printf+0xfc>
          putc(fd, *s);
 7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d2:	8a 00                	mov    (%eax),%al
 7d4:	0f be c0             	movsbl %al,%eax
 7d7:	83 ec 08             	sub    $0x8,%esp
 7da:	50                   	push   %eax
 7db:	ff 75 08             	pushl  0x8(%ebp)
 7de:	e8 39 fe ff ff       	call   61c <putc>
 7e3:	83 c4 10             	add    $0x10,%esp
          s++;
 7e6:	ff 45 f4             	incl   -0xc(%ebp)
        while(*s != 0){
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	8a 00                	mov    (%eax),%al
 7ee:	84 c0                	test   %al,%al
 7f0:	75 dd                	jne    7cf <printf+0xe2>
 7f2:	eb 65                	jmp    859 <printf+0x16c>
        }
      } else if(c == 'c'){
 7f4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7f8:	75 1d                	jne    817 <printf+0x12a>
        putc(fd, *ap);
 7fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7fd:	8b 00                	mov    (%eax),%eax
 7ff:	0f be c0             	movsbl %al,%eax
 802:	83 ec 08             	sub    $0x8,%esp
 805:	50                   	push   %eax
 806:	ff 75 08             	pushl  0x8(%ebp)
 809:	e8 0e fe ff ff       	call   61c <putc>
 80e:	83 c4 10             	add    $0x10,%esp
        ap++;
 811:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 815:	eb 42                	jmp    859 <printf+0x16c>
      } else if(c == '%'){
 817:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 81b:	75 17                	jne    834 <printf+0x147>
        putc(fd, c);
 81d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 820:	0f be c0             	movsbl %al,%eax
 823:	83 ec 08             	sub    $0x8,%esp
 826:	50                   	push   %eax
 827:	ff 75 08             	pushl  0x8(%ebp)
 82a:	e8 ed fd ff ff       	call   61c <putc>
 82f:	83 c4 10             	add    $0x10,%esp
 832:	eb 25                	jmp    859 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 834:	83 ec 08             	sub    $0x8,%esp
 837:	6a 25                	push   $0x25
 839:	ff 75 08             	pushl  0x8(%ebp)
 83c:	e8 db fd ff ff       	call   61c <putc>
 841:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 844:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 847:	0f be c0             	movsbl %al,%eax
 84a:	83 ec 08             	sub    $0x8,%esp
 84d:	50                   	push   %eax
 84e:	ff 75 08             	pushl  0x8(%ebp)
 851:	e8 c6 fd ff ff       	call   61c <putc>
 856:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 859:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 860:	ff 45 f0             	incl   -0x10(%ebp)
 863:	8b 55 0c             	mov    0xc(%ebp),%edx
 866:	8b 45 f0             	mov    -0x10(%ebp),%eax
 869:	01 d0                	add    %edx,%eax
 86b:	8a 00                	mov    (%eax),%al
 86d:	84 c0                	test   %al,%al
 86f:	0f 85 9a fe ff ff    	jne    70f <printf+0x22>
    }
  }
}
 875:	90                   	nop
 876:	90                   	nop
 877:	c9                   	leave  
 878:	c3                   	ret    

00000879 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 879:	55                   	push   %ebp
 87a:	89 e5                	mov    %esp,%ebp
 87c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 87f:	8b 45 08             	mov    0x8(%ebp),%eax
 882:	83 e8 08             	sub    $0x8,%eax
 885:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 888:	a1 1c 0b 00 00       	mov    0xb1c,%eax
 88d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 890:	eb 24                	jmp    8b6 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 892:	8b 45 fc             	mov    -0x4(%ebp),%eax
 895:	8b 00                	mov    (%eax),%eax
 897:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 89a:	72 12                	jb     8ae <free+0x35>
 89c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 8a2:	72 24                	jb     8c8 <free+0x4f>
 8a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a7:	8b 00                	mov    (%eax),%eax
 8a9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 8ac:	72 1a                	jb     8c8 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b1:	8b 00                	mov    (%eax),%eax
 8b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b9:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 8bc:	73 d4                	jae    892 <free+0x19>
 8be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c1:	8b 00                	mov    (%eax),%eax
 8c3:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 8c6:	73 ca                	jae    892 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8cb:	8b 40 04             	mov    0x4(%eax),%eax
 8ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d8:	01 c2                	add    %eax,%edx
 8da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8dd:	8b 00                	mov    (%eax),%eax
 8df:	39 c2                	cmp    %eax,%edx
 8e1:	75 24                	jne    907 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e6:	8b 50 04             	mov    0x4(%eax),%edx
 8e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ec:	8b 00                	mov    (%eax),%eax
 8ee:	8b 40 04             	mov    0x4(%eax),%eax
 8f1:	01 c2                	add    %eax,%edx
 8f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f6:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fc:	8b 00                	mov    (%eax),%eax
 8fe:	8b 10                	mov    (%eax),%edx
 900:	8b 45 f8             	mov    -0x8(%ebp),%eax
 903:	89 10                	mov    %edx,(%eax)
 905:	eb 0a                	jmp    911 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 907:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90a:	8b 10                	mov    (%eax),%edx
 90c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 911:	8b 45 fc             	mov    -0x4(%ebp),%eax
 914:	8b 40 04             	mov    0x4(%eax),%eax
 917:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 91e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 921:	01 d0                	add    %edx,%eax
 923:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 926:	75 20                	jne    948 <free+0xcf>
    p->s.size += bp->s.size;
 928:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92b:	8b 50 04             	mov    0x4(%eax),%edx
 92e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 931:	8b 40 04             	mov    0x4(%eax),%eax
 934:	01 c2                	add    %eax,%edx
 936:	8b 45 fc             	mov    -0x4(%ebp),%eax
 939:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 93c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93f:	8b 10                	mov    (%eax),%edx
 941:	8b 45 fc             	mov    -0x4(%ebp),%eax
 944:	89 10                	mov    %edx,(%eax)
 946:	eb 08                	jmp    950 <free+0xd7>
  } else
    p->s.ptr = bp;
 948:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 94e:	89 10                	mov    %edx,(%eax)
  freep = p;
 950:	8b 45 fc             	mov    -0x4(%ebp),%eax
 953:	a3 1c 0b 00 00       	mov    %eax,0xb1c
}
 958:	90                   	nop
 959:	c9                   	leave  
 95a:	c3                   	ret    

0000095b <morecore>:

static Header*
morecore(uint nu)
{
 95b:	55                   	push   %ebp
 95c:	89 e5                	mov    %esp,%ebp
 95e:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 961:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 968:	77 07                	ja     971 <morecore+0x16>
    nu = 4096;
 96a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 971:	8b 45 08             	mov    0x8(%ebp),%eax
 974:	c1 e0 03             	shl    $0x3,%eax
 977:	83 ec 0c             	sub    $0xc,%esp
 97a:	50                   	push   %eax
 97b:	e8 84 fc ff ff       	call   604 <sbrk>
 980:	83 c4 10             	add    $0x10,%esp
 983:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 986:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 98a:	75 07                	jne    993 <morecore+0x38>
    return 0;
 98c:	b8 00 00 00 00       	mov    $0x0,%eax
 991:	eb 26                	jmp    9b9 <morecore+0x5e>
  hp = (Header*)p;
 993:	8b 45 f4             	mov    -0xc(%ebp),%eax
 996:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 999:	8b 45 f0             	mov    -0x10(%ebp),%eax
 99c:	8b 55 08             	mov    0x8(%ebp),%edx
 99f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a5:	83 c0 08             	add    $0x8,%eax
 9a8:	83 ec 0c             	sub    $0xc,%esp
 9ab:	50                   	push   %eax
 9ac:	e8 c8 fe ff ff       	call   879 <free>
 9b1:	83 c4 10             	add    $0x10,%esp
  return freep;
 9b4:	a1 1c 0b 00 00       	mov    0xb1c,%eax
}
 9b9:	c9                   	leave  
 9ba:	c3                   	ret    

000009bb <malloc>:

void*
malloc(uint nbytes)
{
 9bb:	55                   	push   %ebp
 9bc:	89 e5                	mov    %esp,%ebp
 9be:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c1:	8b 45 08             	mov    0x8(%ebp),%eax
 9c4:	83 c0 07             	add    $0x7,%eax
 9c7:	c1 e8 03             	shr    $0x3,%eax
 9ca:	40                   	inc    %eax
 9cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9ce:	a1 1c 0b 00 00       	mov    0xb1c,%eax
 9d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9da:	75 23                	jne    9ff <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 9dc:	c7 45 f0 14 0b 00 00 	movl   $0xb14,-0x10(%ebp)
 9e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e6:	a3 1c 0b 00 00       	mov    %eax,0xb1c
 9eb:	a1 1c 0b 00 00       	mov    0xb1c,%eax
 9f0:	a3 14 0b 00 00       	mov    %eax,0xb14
    base.s.size = 0;
 9f5:	c7 05 18 0b 00 00 00 	movl   $0x0,0xb18
 9fc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a02:	8b 00                	mov    (%eax),%eax
 a04:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0a:	8b 40 04             	mov    0x4(%eax),%eax
 a0d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a10:	72 4d                	jb     a5f <malloc+0xa4>
      if(p->s.size == nunits)
 a12:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a15:	8b 40 04             	mov    0x4(%eax),%eax
 a18:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 a1b:	75 0c                	jne    a29 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 a1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a20:	8b 10                	mov    (%eax),%edx
 a22:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a25:	89 10                	mov    %edx,(%eax)
 a27:	eb 26                	jmp    a4f <malloc+0x94>
      else {
        p->s.size -= nunits;
 a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2c:	8b 40 04             	mov    0x4(%eax),%eax
 a2f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a32:	89 c2                	mov    %eax,%edx
 a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a37:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3d:	8b 40 04             	mov    0x4(%eax),%eax
 a40:	c1 e0 03             	shl    $0x3,%eax
 a43:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a49:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a4c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a52:	a3 1c 0b 00 00       	mov    %eax,0xb1c
      return (void*)(p + 1);
 a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5a:	83 c0 08             	add    $0x8,%eax
 a5d:	eb 3b                	jmp    a9a <malloc+0xdf>
    }
    if(p == freep)
 a5f:	a1 1c 0b 00 00       	mov    0xb1c,%eax
 a64:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a67:	75 1e                	jne    a87 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 a69:	83 ec 0c             	sub    $0xc,%esp
 a6c:	ff 75 ec             	pushl  -0x14(%ebp)
 a6f:	e8 e7 fe ff ff       	call   95b <morecore>
 a74:	83 c4 10             	add    $0x10,%esp
 a77:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a7a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a7e:	75 07                	jne    a87 <malloc+0xcc>
        return 0;
 a80:	b8 00 00 00 00       	mov    $0x0,%eax
 a85:	eb 13                	jmp    a9a <malloc+0xdf>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a90:	8b 00                	mov    (%eax),%eax
 a92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a95:	e9 6d ff ff ff       	jmp    a07 <malloc+0x4c>
  }
}
 a9a:	c9                   	leave  
 a9b:	c3                   	ret    
