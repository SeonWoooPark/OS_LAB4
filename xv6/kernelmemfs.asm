
kernelmemfs:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <wait_main>:
8010000c:	00 00                	add    %al,(%eax)
	...

80100010 <entry>:
  .long 0
# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  #Set Data Segment
  mov $0x10,%ax
80100010:	66 b8 10 00          	mov    $0x10,%ax
  mov %ax,%ds
80100014:	8e d8                	mov    %eax,%ds
  mov %ax,%es
80100016:	8e c0                	mov    %eax,%es
  mov %ax,%ss
80100018:	8e d0                	mov    %eax,%ss
  mov $0,%ax
8010001a:	66 b8 00 00          	mov    $0x0,%ax
  mov %ax,%fs
8010001e:	8e e0                	mov    %eax,%fs
  mov %ax,%gs
80100020:	8e e8                	mov    %eax,%gs

  #Turn off paing
  movl %cr0,%eax
80100022:	0f 20 c0             	mov    %cr0,%eax
  andl $0x7fffffff,%eax
80100025:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
  movl %eax,%cr0 
8010002a:	0f 22 c0             	mov    %eax,%cr0

  #Set Page Table Base Address
  movl    $(V2P_WO(entrypgdir)), %eax
8010002d:	b8 00 d0 10 00       	mov    $0x10d000,%eax
  movl    %eax, %cr3
80100032:	0f 22 d8             	mov    %eax,%cr3
  
  #Disable IA32e mode
  movl $0x0c0000080,%ecx
80100035:	b9 80 00 00 c0       	mov    $0xc0000080,%ecx
  rdmsr
8010003a:	0f 32                	rdmsr  
  andl $0xFFFFFEFF,%eax
8010003c:	25 ff fe ff ff       	and    $0xfffffeff,%eax
  wrmsr
80100041:	0f 30                	wrmsr  

  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
80100043:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
80100046:	83 c8 10             	or     $0x10,%eax
  andl    $0xFFFFFFDF, %eax
80100049:	83 e0 df             	and    $0xffffffdf,%eax
  movl    %eax, %cr4
8010004c:	0f 22 e0             	mov    %eax,%cr4

  #Turn on Paging
  movl    %cr0, %eax
8010004f:	0f 20 c0             	mov    %cr0,%eax
  orl     $0x80010001, %eax
80100052:	0d 01 00 01 80       	or     $0x80010001,%eax
  movl    %eax, %cr0
80100057:	0f 22 c0             	mov    %eax,%cr0




  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
8010005a:	bc 80 6f 19 80       	mov    $0x80196f80,%esp
  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
#  jz .waiting_main
  movl $main, %edx
8010005f:	ba d6 32 10 80       	mov    $0x801032d6,%edx
  jmp %edx
80100064:	ff e2                	jmp    *%edx

80100066 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100066:	55                   	push   %ebp
80100067:	89 e5                	mov    %esp,%ebp
80100069:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010006c:	83 ec 08             	sub    $0x8,%esp
8010006f:	68 40 9e 10 80       	push   $0x80109e40
80100074:	68 00 c0 18 80       	push   $0x8018c000
80100079:	e8 f5 45 00 00       	call   80104673 <initlock>
8010007e:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100081:	c7 05 4c 07 19 80 fc 	movl   $0x801906fc,0x8019074c
80100088:	06 19 80 
  bcache.head.next = &bcache.head;
8010008b:	c7 05 50 07 19 80 fc 	movl   $0x801906fc,0x80190750
80100092:	06 19 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100095:	c7 45 f4 34 c0 18 80 	movl   $0x8018c034,-0xc(%ebp)
8010009c:	eb 47                	jmp    801000e5 <binit+0x7f>
    b->next = bcache.head.next;
8010009e:	8b 15 50 07 19 80    	mov    0x80190750,%edx
801000a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000a7:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
801000aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ad:	c7 40 50 fc 06 19 80 	movl   $0x801906fc,0x50(%eax)
    initsleeplock(&b->lock, "buffer");
801000b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000b7:	83 c0 0c             	add    $0xc,%eax
801000ba:	83 ec 08             	sub    $0x8,%esp
801000bd:	68 47 9e 10 80       	push   $0x80109e47
801000c2:	50                   	push   %eax
801000c3:	e8 4e 44 00 00       	call   80104516 <initsleeplock>
801000c8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000cb:	a1 50 07 19 80       	mov    0x80190750,%eax
801000d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801000d3:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801000d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d9:	a3 50 07 19 80       	mov    %eax,0x80190750
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000de:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000e5:	b8 fc 06 19 80       	mov    $0x801906fc,%eax
801000ea:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000ed:	72 af                	jb     8010009e <binit+0x38>
  }
}
801000ef:	90                   	nop
801000f0:	90                   	nop
801000f1:	c9                   	leave  
801000f2:	c3                   	ret    

801000f3 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000f3:	55                   	push   %ebp
801000f4:	89 e5                	mov    %esp,%ebp
801000f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000f9:	83 ec 0c             	sub    $0xc,%esp
801000fc:	68 00 c0 18 80       	push   $0x8018c000
80100101:	e8 8f 45 00 00       	call   80104695 <acquire>
80100106:	83 c4 10             	add    $0x10,%esp

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100109:	a1 50 07 19 80       	mov    0x80190750,%eax
8010010e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100111:	eb 58                	jmp    8010016b <bget+0x78>
    if(b->dev == dev && b->blockno == blockno){
80100113:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100116:	8b 40 04             	mov    0x4(%eax),%eax
80100119:	39 45 08             	cmp    %eax,0x8(%ebp)
8010011c:	75 44                	jne    80100162 <bget+0x6f>
8010011e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100121:	8b 40 08             	mov    0x8(%eax),%eax
80100124:	39 45 0c             	cmp    %eax,0xc(%ebp)
80100127:	75 39                	jne    80100162 <bget+0x6f>
      b->refcnt++;
80100129:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010012c:	8b 40 4c             	mov    0x4c(%eax),%eax
8010012f:	8d 50 01             	lea    0x1(%eax),%edx
80100132:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100135:	89 50 4c             	mov    %edx,0x4c(%eax)
      release(&bcache.lock);
80100138:	83 ec 0c             	sub    $0xc,%esp
8010013b:	68 00 c0 18 80       	push   $0x8018c000
80100140:	e8 be 45 00 00       	call   80104703 <release>
80100145:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100148:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014b:	83 c0 0c             	add    $0xc,%eax
8010014e:	83 ec 0c             	sub    $0xc,%esp
80100151:	50                   	push   %eax
80100152:	e8 fb 43 00 00       	call   80104552 <acquiresleep>
80100157:	83 c4 10             	add    $0x10,%esp
      return b;
8010015a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015d:	e9 9d 00 00 00       	jmp    801001ff <bget+0x10c>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100162:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100165:	8b 40 54             	mov    0x54(%eax),%eax
80100168:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010016b:	81 7d f4 fc 06 19 80 	cmpl   $0x801906fc,-0xc(%ebp)
80100172:	75 9f                	jne    80100113 <bget+0x20>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100174:	a1 4c 07 19 80       	mov    0x8019074c,%eax
80100179:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010017c:	eb 6b                	jmp    801001e9 <bget+0xf6>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010017e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100181:	8b 40 4c             	mov    0x4c(%eax),%eax
80100184:	85 c0                	test   %eax,%eax
80100186:	75 58                	jne    801001e0 <bget+0xed>
80100188:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010018b:	8b 00                	mov    (%eax),%eax
8010018d:	83 e0 04             	and    $0x4,%eax
80100190:	85 c0                	test   %eax,%eax
80100192:	75 4c                	jne    801001e0 <bget+0xed>
      b->dev = dev;
80100194:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100197:	8b 55 08             	mov    0x8(%ebp),%edx
8010019a:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
8010019d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001a0:	8b 55 0c             	mov    0xc(%ebp),%edx
801001a3:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = 0;
801001a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      b->refcnt = 1;
801001af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001b2:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
      release(&bcache.lock);
801001b9:	83 ec 0c             	sub    $0xc,%esp
801001bc:	68 00 c0 18 80       	push   $0x8018c000
801001c1:	e8 3d 45 00 00       	call   80104703 <release>
801001c6:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
801001c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001cc:	83 c0 0c             	add    $0xc,%eax
801001cf:	83 ec 0c             	sub    $0xc,%esp
801001d2:	50                   	push   %eax
801001d3:	e8 7a 43 00 00       	call   80104552 <acquiresleep>
801001d8:	83 c4 10             	add    $0x10,%esp
      return b;
801001db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001de:	eb 1f                	jmp    801001ff <bget+0x10c>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801001e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001e3:	8b 40 50             	mov    0x50(%eax),%eax
801001e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001e9:	81 7d f4 fc 06 19 80 	cmpl   $0x801906fc,-0xc(%ebp)
801001f0:	75 8c                	jne    8010017e <bget+0x8b>
    }
  }
  panic("bget: no buffers");
801001f2:	83 ec 0c             	sub    $0xc,%esp
801001f5:	68 4e 9e 10 80       	push   $0x80109e4e
801001fa:	e8 a0 03 00 00       	call   8010059f <panic>
}
801001ff:	c9                   	leave  
80100200:	c3                   	ret    

80100201 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
80100201:	55                   	push   %ebp
80100202:	89 e5                	mov    %esp,%ebp
80100204:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
80100207:	83 ec 08             	sub    $0x8,%esp
8010020a:	ff 75 0c             	pushl  0xc(%ebp)
8010020d:	ff 75 08             	pushl  0x8(%ebp)
80100210:	e8 de fe ff ff       	call   801000f3 <bget>
80100215:	83 c4 10             	add    $0x10,%esp
80100218:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((b->flags & B_VALID) == 0) {
8010021b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010021e:	8b 00                	mov    (%eax),%eax
80100220:	83 e0 02             	and    $0x2,%eax
80100223:	85 c0                	test   %eax,%eax
80100225:	75 0e                	jne    80100235 <bread+0x34>
    iderw(b);
80100227:	83 ec 0c             	sub    $0xc,%esp
8010022a:	ff 75 f4             	pushl  -0xc(%ebp)
8010022d:	e8 02 9b 00 00       	call   80109d34 <iderw>
80100232:	83 c4 10             	add    $0x10,%esp
  }
  return b;
80100235:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80100238:	c9                   	leave  
80100239:	c3                   	ret    

8010023a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
8010023a:	55                   	push   %ebp
8010023b:	89 e5                	mov    %esp,%ebp
8010023d:	83 ec 08             	sub    $0x8,%esp
  if(!holdingsleep(&b->lock))
80100240:	8b 45 08             	mov    0x8(%ebp),%eax
80100243:	83 c0 0c             	add    $0xc,%eax
80100246:	83 ec 0c             	sub    $0xc,%esp
80100249:	50                   	push   %eax
8010024a:	e8 b5 43 00 00       	call   80104604 <holdingsleep>
8010024f:	83 c4 10             	add    $0x10,%esp
80100252:	85 c0                	test   %eax,%eax
80100254:	75 0d                	jne    80100263 <bwrite+0x29>
    panic("bwrite");
80100256:	83 ec 0c             	sub    $0xc,%esp
80100259:	68 5f 9e 10 80       	push   $0x80109e5f
8010025e:	e8 3c 03 00 00       	call   8010059f <panic>
  b->flags |= B_DIRTY;
80100263:	8b 45 08             	mov    0x8(%ebp),%eax
80100266:	8b 00                	mov    (%eax),%eax
80100268:	83 c8 04             	or     $0x4,%eax
8010026b:	89 c2                	mov    %eax,%edx
8010026d:	8b 45 08             	mov    0x8(%ebp),%eax
80100270:	89 10                	mov    %edx,(%eax)
  iderw(b);
80100272:	83 ec 0c             	sub    $0xc,%esp
80100275:	ff 75 08             	pushl  0x8(%ebp)
80100278:	e8 b7 9a 00 00       	call   80109d34 <iderw>
8010027d:	83 c4 10             	add    $0x10,%esp
}
80100280:	90                   	nop
80100281:	c9                   	leave  
80100282:	c3                   	ret    

80100283 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100283:	55                   	push   %ebp
80100284:	89 e5                	mov    %esp,%ebp
80100286:	83 ec 08             	sub    $0x8,%esp
  if(!holdingsleep(&b->lock))
80100289:	8b 45 08             	mov    0x8(%ebp),%eax
8010028c:	83 c0 0c             	add    $0xc,%eax
8010028f:	83 ec 0c             	sub    $0xc,%esp
80100292:	50                   	push   %eax
80100293:	e8 6c 43 00 00       	call   80104604 <holdingsleep>
80100298:	83 c4 10             	add    $0x10,%esp
8010029b:	85 c0                	test   %eax,%eax
8010029d:	75 0d                	jne    801002ac <brelse+0x29>
    panic("brelse");
8010029f:	83 ec 0c             	sub    $0xc,%esp
801002a2:	68 66 9e 10 80       	push   $0x80109e66
801002a7:	e8 f3 02 00 00       	call   8010059f <panic>

  releasesleep(&b->lock);
801002ac:	8b 45 08             	mov    0x8(%ebp),%eax
801002af:	83 c0 0c             	add    $0xc,%eax
801002b2:	83 ec 0c             	sub    $0xc,%esp
801002b5:	50                   	push   %eax
801002b6:	e8 fb 42 00 00       	call   801045b6 <releasesleep>
801002bb:	83 c4 10             	add    $0x10,%esp

  acquire(&bcache.lock);
801002be:	83 ec 0c             	sub    $0xc,%esp
801002c1:	68 00 c0 18 80       	push   $0x8018c000
801002c6:	e8 ca 43 00 00       	call   80104695 <acquire>
801002cb:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
801002ce:	8b 45 08             	mov    0x8(%ebp),%eax
801002d1:	8b 40 4c             	mov    0x4c(%eax),%eax
801002d4:	8d 50 ff             	lea    -0x1(%eax),%edx
801002d7:	8b 45 08             	mov    0x8(%ebp),%eax
801002da:	89 50 4c             	mov    %edx,0x4c(%eax)
  if (b->refcnt == 0) {
801002dd:	8b 45 08             	mov    0x8(%ebp),%eax
801002e0:	8b 40 4c             	mov    0x4c(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	75 47                	jne    8010032e <brelse+0xab>
    // no one is waiting for it.
    b->next->prev = b->prev;
801002e7:	8b 45 08             	mov    0x8(%ebp),%eax
801002ea:	8b 40 54             	mov    0x54(%eax),%eax
801002ed:	8b 55 08             	mov    0x8(%ebp),%edx
801002f0:	8b 52 50             	mov    0x50(%edx),%edx
801002f3:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
801002f6:	8b 45 08             	mov    0x8(%ebp),%eax
801002f9:	8b 40 50             	mov    0x50(%eax),%eax
801002fc:	8b 55 08             	mov    0x8(%ebp),%edx
801002ff:	8b 52 54             	mov    0x54(%edx),%edx
80100302:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100305:	8b 15 50 07 19 80    	mov    0x80190750,%edx
8010030b:	8b 45 08             	mov    0x8(%ebp),%eax
8010030e:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
80100311:	8b 45 08             	mov    0x8(%ebp),%eax
80100314:	c7 40 50 fc 06 19 80 	movl   $0x801906fc,0x50(%eax)
    bcache.head.next->prev = b;
8010031b:	a1 50 07 19 80       	mov    0x80190750,%eax
80100320:	8b 55 08             	mov    0x8(%ebp),%edx
80100323:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
80100326:	8b 45 08             	mov    0x8(%ebp),%eax
80100329:	a3 50 07 19 80       	mov    %eax,0x80190750
  }
  
  release(&bcache.lock);
8010032e:	83 ec 0c             	sub    $0xc,%esp
80100331:	68 00 c0 18 80       	push   $0x8018c000
80100336:	e8 c8 43 00 00       	call   80104703 <release>
8010033b:	83 c4 10             	add    $0x10,%esp
}
8010033e:	90                   	nop
8010033f:	c9                   	leave  
80100340:	c3                   	ret    

80100341 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100341:	55                   	push   %ebp
80100342:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100344:	fa                   	cli    
}
80100345:	90                   	nop
80100346:	5d                   	pop    %ebp
80100347:	c3                   	ret    

80100348 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100348:	55                   	push   %ebp
80100349:	89 e5                	mov    %esp,%ebp
8010034b:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010034e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100352:	74 1c                	je     80100370 <printint+0x28>
80100354:	8b 45 08             	mov    0x8(%ebp),%eax
80100357:	c1 e8 1f             	shr    $0x1f,%eax
8010035a:	0f b6 c0             	movzbl %al,%eax
8010035d:	89 45 10             	mov    %eax,0x10(%ebp)
80100360:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100364:	74 0a                	je     80100370 <printint+0x28>
    x = -xx;
80100366:	8b 45 08             	mov    0x8(%ebp),%eax
80100369:	f7 d8                	neg    %eax
8010036b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010036e:	eb 06                	jmp    80100376 <printint+0x2e>
  else
    x = xx;
80100370:	8b 45 08             	mov    0x8(%ebp),%eax
80100373:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100376:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
8010037d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100380:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100383:	ba 00 00 00 00       	mov    $0x0,%edx
80100388:	f7 f1                	div    %ecx
8010038a:	89 d1                	mov    %edx,%ecx
8010038c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010038f:	8d 50 01             	lea    0x1(%eax),%edx
80100392:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100395:	8a 91 04 c0 10 80    	mov    -0x7fef3ffc(%ecx),%dl
8010039b:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
8010039f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801003a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801003a5:	ba 00 00 00 00       	mov    $0x0,%edx
801003aa:	f7 f1                	div    %ecx
801003ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
801003af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801003b3:	75 c8                	jne    8010037d <printint+0x35>

  if(sign)
801003b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801003b9:	74 29                	je     801003e4 <printint+0x9c>
    buf[i++] = '-';
801003bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003be:	8d 50 01             	lea    0x1(%eax),%edx
801003c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003c4:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
801003c9:	eb 19                	jmp    801003e4 <printint+0x9c>
    consputc(buf[i]);
801003cb:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003d1:	01 d0                	add    %edx,%eax
801003d3:	8a 00                	mov    (%eax),%al
801003d5:	0f be c0             	movsbl %al,%eax
801003d8:	83 ec 0c             	sub    $0xc,%esp
801003db:	50                   	push   %eax
801003dc:	e8 6a 03 00 00       	call   8010074b <consputc>
801003e1:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
801003e4:	ff 4d f4             	decl   -0xc(%ebp)
801003e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003eb:	79 de                	jns    801003cb <printint+0x83>
}
801003ed:	90                   	nop
801003ee:	90                   	nop
801003ef:	c9                   	leave  
801003f0:	c3                   	ret    

801003f1 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003f1:	55                   	push   %ebp
801003f2:	89 e5                	mov    %esp,%ebp
801003f4:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003f7:	a1 34 0a 19 80       	mov    0x80190a34,%eax
801003fc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003ff:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100403:	74 10                	je     80100415 <cprintf+0x24>
    acquire(&cons.lock);
80100405:	83 ec 0c             	sub    $0xc,%esp
80100408:	68 00 0a 19 80       	push   $0x80190a00
8010040d:	e8 83 42 00 00       	call   80104695 <acquire>
80100412:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100415:	8b 45 08             	mov    0x8(%ebp),%eax
80100418:	85 c0                	test   %eax,%eax
8010041a:	75 0d                	jne    80100429 <cprintf+0x38>
    panic("null fmt");
8010041c:	83 ec 0c             	sub    $0xc,%esp
8010041f:	68 6d 9e 10 80       	push   $0x80109e6d
80100424:	e8 76 01 00 00       	call   8010059f <panic>


  argp = (uint*)(void*)(&fmt + 1);
80100429:	8d 45 0c             	lea    0xc(%ebp),%eax
8010042c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010042f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100436:	e9 29 01 00 00       	jmp    80100564 <cprintf+0x173>
    if(c != '%'){
8010043b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010043f:	74 13                	je     80100454 <cprintf+0x63>
      consputc(c);
80100441:	83 ec 0c             	sub    $0xc,%esp
80100444:	ff 75 e4             	pushl  -0x1c(%ebp)
80100447:	e8 ff 02 00 00       	call   8010074b <consputc>
8010044c:	83 c4 10             	add    $0x10,%esp
      continue;
8010044f:	e9 0d 01 00 00       	jmp    80100561 <cprintf+0x170>
    }
    c = fmt[++i] & 0xff;
80100454:	8b 55 08             	mov    0x8(%ebp),%edx
80100457:	ff 45 f4             	incl   -0xc(%ebp)
8010045a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010045d:	01 d0                	add    %edx,%eax
8010045f:	8a 00                	mov    (%eax),%al
80100461:	0f be c0             	movsbl %al,%eax
80100464:	25 ff 00 00 00       	and    $0xff,%eax
80100469:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010046c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100470:	0f 84 0f 01 00 00    	je     80100585 <cprintf+0x194>
      break;
    switch(c){
80100476:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
8010047a:	74 5e                	je     801004da <cprintf+0xe9>
8010047c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
80100480:	0f 8f bf 00 00 00    	jg     80100545 <cprintf+0x154>
80100486:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
8010048a:	74 6b                	je     801004f7 <cprintf+0x106>
8010048c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
80100490:	0f 8f af 00 00 00    	jg     80100545 <cprintf+0x154>
80100496:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
8010049a:	74 3e                	je     801004da <cprintf+0xe9>
8010049c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
801004a0:	0f 8f 9f 00 00 00    	jg     80100545 <cprintf+0x154>
801004a6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
801004aa:	0f 84 86 00 00 00    	je     80100536 <cprintf+0x145>
801004b0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
801004b4:	0f 85 8b 00 00 00    	jne    80100545 <cprintf+0x154>
    case 'd':
      printint(*argp++, 10, 1);
801004ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004bd:	8d 50 04             	lea    0x4(%eax),%edx
801004c0:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004c3:	8b 00                	mov    (%eax),%eax
801004c5:	83 ec 04             	sub    $0x4,%esp
801004c8:	6a 01                	push   $0x1
801004ca:	6a 0a                	push   $0xa
801004cc:	50                   	push   %eax
801004cd:	e8 76 fe ff ff       	call   80100348 <printint>
801004d2:	83 c4 10             	add    $0x10,%esp
      break;
801004d5:	e9 87 00 00 00       	jmp    80100561 <cprintf+0x170>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801004da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004dd:	8d 50 04             	lea    0x4(%eax),%edx
801004e0:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004e3:	8b 00                	mov    (%eax),%eax
801004e5:	83 ec 04             	sub    $0x4,%esp
801004e8:	6a 00                	push   $0x0
801004ea:	6a 10                	push   $0x10
801004ec:	50                   	push   %eax
801004ed:	e8 56 fe ff ff       	call   80100348 <printint>
801004f2:	83 c4 10             	add    $0x10,%esp
      break;
801004f5:	eb 6a                	jmp    80100561 <cprintf+0x170>
    case 's':
      if((s = (char*)*argp++) == 0)
801004f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004fa:	8d 50 04             	lea    0x4(%eax),%edx
801004fd:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100500:	8b 00                	mov    (%eax),%eax
80100502:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100505:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100509:	75 20                	jne    8010052b <cprintf+0x13a>
        s = "(null)";
8010050b:	c7 45 ec 76 9e 10 80 	movl   $0x80109e76,-0x14(%ebp)
      for(; *s; s++)
80100512:	eb 17                	jmp    8010052b <cprintf+0x13a>
        consputc(*s);
80100514:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100517:	8a 00                	mov    (%eax),%al
80100519:	0f be c0             	movsbl %al,%eax
8010051c:	83 ec 0c             	sub    $0xc,%esp
8010051f:	50                   	push   %eax
80100520:	e8 26 02 00 00       	call   8010074b <consputc>
80100525:	83 c4 10             	add    $0x10,%esp
      for(; *s; s++)
80100528:	ff 45 ec             	incl   -0x14(%ebp)
8010052b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010052e:	8a 00                	mov    (%eax),%al
80100530:	84 c0                	test   %al,%al
80100532:	75 e0                	jne    80100514 <cprintf+0x123>
      break;
80100534:	eb 2b                	jmp    80100561 <cprintf+0x170>
    case '%':
      consputc('%');
80100536:	83 ec 0c             	sub    $0xc,%esp
80100539:	6a 25                	push   $0x25
8010053b:	e8 0b 02 00 00       	call   8010074b <consputc>
80100540:	83 c4 10             	add    $0x10,%esp
      break;
80100543:	eb 1c                	jmp    80100561 <cprintf+0x170>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100545:	83 ec 0c             	sub    $0xc,%esp
80100548:	6a 25                	push   $0x25
8010054a:	e8 fc 01 00 00       	call   8010074b <consputc>
8010054f:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100552:	83 ec 0c             	sub    $0xc,%esp
80100555:	ff 75 e4             	pushl  -0x1c(%ebp)
80100558:	e8 ee 01 00 00       	call   8010074b <consputc>
8010055d:	83 c4 10             	add    $0x10,%esp
      break;
80100560:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100561:	ff 45 f4             	incl   -0xc(%ebp)
80100564:	8b 55 08             	mov    0x8(%ebp),%edx
80100567:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010056a:	01 d0                	add    %edx,%eax
8010056c:	8a 00                	mov    (%eax),%al
8010056e:	0f be c0             	movsbl %al,%eax
80100571:	25 ff 00 00 00       	and    $0xff,%eax
80100576:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100579:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010057d:	0f 85 b8 fe ff ff    	jne    8010043b <cprintf+0x4a>
80100583:	eb 01                	jmp    80100586 <cprintf+0x195>
      break;
80100585:	90                   	nop
    }
  }

  if(locking)
80100586:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010058a:	74 10                	je     8010059c <cprintf+0x1ab>
    release(&cons.lock);
8010058c:	83 ec 0c             	sub    $0xc,%esp
8010058f:	68 00 0a 19 80       	push   $0x80190a00
80100594:	e8 6a 41 00 00       	call   80104703 <release>
80100599:	83 c4 10             	add    $0x10,%esp
}
8010059c:	90                   	nop
8010059d:	c9                   	leave  
8010059e:	c3                   	ret    

8010059f <panic>:

void
panic(char *s)
{
8010059f:	55                   	push   %ebp
801005a0:	89 e5                	mov    %esp,%ebp
801005a2:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];

  cli();
801005a5:	e8 97 fd ff ff       	call   80100341 <cli>
  cons.locking = 0;
801005aa:	c7 05 34 0a 19 80 00 	movl   $0x0,0x80190a34
801005b1:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
801005b4:	e8 ca 24 00 00       	call   80102a83 <lapicid>
801005b9:	83 ec 08             	sub    $0x8,%esp
801005bc:	50                   	push   %eax
801005bd:	68 7d 9e 10 80       	push   $0x80109e7d
801005c2:	e8 2a fe ff ff       	call   801003f1 <cprintf>
801005c7:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
801005ca:	8b 45 08             	mov    0x8(%ebp),%eax
801005cd:	83 ec 0c             	sub    $0xc,%esp
801005d0:	50                   	push   %eax
801005d1:	e8 1b fe ff ff       	call   801003f1 <cprintf>
801005d6:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005d9:	83 ec 0c             	sub    $0xc,%esp
801005dc:	68 91 9e 10 80       	push   $0x80109e91
801005e1:	e8 0b fe ff ff       	call   801003f1 <cprintf>
801005e6:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005e9:	83 ec 08             	sub    $0x8,%esp
801005ec:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005ef:	50                   	push   %eax
801005f0:	8d 45 08             	lea    0x8(%ebp),%eax
801005f3:	50                   	push   %eax
801005f4:	e8 5c 41 00 00       	call   80104755 <getcallerpcs>
801005f9:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100603:	eb 1b                	jmp    80100620 <panic+0x81>
    cprintf(" %p", pcs[i]);
80100605:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100608:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
8010060c:	83 ec 08             	sub    $0x8,%esp
8010060f:	50                   	push   %eax
80100610:	68 93 9e 10 80       	push   $0x80109e93
80100615:	e8 d7 fd ff ff       	call   801003f1 <cprintf>
8010061a:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
8010061d:	ff 45 f4             	incl   -0xc(%ebp)
80100620:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80100624:	7e df                	jle    80100605 <panic+0x66>
  panicked = 1; // freeze other CPU
80100626:	c7 05 ec 09 19 80 01 	movl   $0x1,0x801909ec
8010062d:	00 00 00 
  for(;;)
80100630:	90                   	nop
80100631:	eb fd                	jmp    80100630 <panic+0x91>

80100633 <graphic_putc>:

#define CONSOLE_HORIZONTAL_MAX 53
#define CONSOLE_VERTICAL_MAX 20
int console_pos = CONSOLE_HORIZONTAL_MAX*(CONSOLE_VERTICAL_MAX);
//int console_pos = 0;
void graphic_putc(int c){
80100633:	55                   	push   %ebp
80100634:	89 e5                	mov    %esp,%ebp
80100636:	83 ec 18             	sub    $0x18,%esp
  if(c == '\n'){
80100639:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010063d:	75 51                	jne    80100690 <graphic_putc+0x5d>
    console_pos += CONSOLE_HORIZONTAL_MAX - console_pos%CONSOLE_HORIZONTAL_MAX;
8010063f:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80100644:	b9 35 00 00 00       	mov    $0x35,%ecx
80100649:	99                   	cltd   
8010064a:	f7 f9                	idiv   %ecx
8010064c:	89 d0                	mov    %edx,%eax
8010064e:	ba 35 00 00 00       	mov    $0x35,%edx
80100653:	29 c2                	sub    %eax,%edx
80100655:	a1 00 c0 10 80       	mov    0x8010c000,%eax
8010065a:	01 d0                	add    %edx,%eax
8010065c:	a3 00 c0 10 80       	mov    %eax,0x8010c000
    if(console_pos >= CONSOLE_VERTICAL_MAX * CONSOLE_HORIZONTAL_MAX){
80100661:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80100666:	3d 23 04 00 00       	cmp    $0x423,%eax
8010066b:	0f 8e d7 00 00 00    	jle    80100748 <graphic_putc+0x115>
      console_pos -= CONSOLE_HORIZONTAL_MAX;
80100671:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80100676:	83 e8 35             	sub    $0x35,%eax
80100679:	a3 00 c0 10 80       	mov    %eax,0x8010c000
      graphic_scroll_up(30);
8010067e:	83 ec 0c             	sub    $0xc,%esp
80100681:	6a 1e                	push   $0x1e
80100683:	e8 53 76 00 00       	call   80107cdb <graphic_scroll_up>
80100688:	83 c4 10             	add    $0x10,%esp
    int x = (console_pos%CONSOLE_HORIZONTAL_MAX)*FONT_WIDTH + 2;
    int y = (console_pos/CONSOLE_HORIZONTAL_MAX)*FONT_HEIGHT;
    font_render(x,y,c);
    console_pos++;
  }
}
8010068b:	e9 b8 00 00 00       	jmp    80100748 <graphic_putc+0x115>
  }else if(c == BACKSPACE){
80100690:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100697:	75 1d                	jne    801006b6 <graphic_putc+0x83>
    if(console_pos>0) --console_pos;
80100699:	a1 00 c0 10 80       	mov    0x8010c000,%eax
8010069e:	85 c0                	test   %eax,%eax
801006a0:	0f 8e a2 00 00 00    	jle    80100748 <graphic_putc+0x115>
801006a6:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801006ab:	48                   	dec    %eax
801006ac:	a3 00 c0 10 80       	mov    %eax,0x8010c000
}
801006b1:	e9 92 00 00 00       	jmp    80100748 <graphic_putc+0x115>
    if(console_pos >= CONSOLE_VERTICAL_MAX * CONSOLE_HORIZONTAL_MAX){
801006b6:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801006bb:	3d 23 04 00 00       	cmp    $0x423,%eax
801006c0:	7e 1a                	jle    801006dc <graphic_putc+0xa9>
      console_pos -= CONSOLE_HORIZONTAL_MAX;
801006c2:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801006c7:	83 e8 35             	sub    $0x35,%eax
801006ca:	a3 00 c0 10 80       	mov    %eax,0x8010c000
      graphic_scroll_up(30);
801006cf:	83 ec 0c             	sub    $0xc,%esp
801006d2:	6a 1e                	push   $0x1e
801006d4:	e8 02 76 00 00       	call   80107cdb <graphic_scroll_up>
801006d9:	83 c4 10             	add    $0x10,%esp
    int x = (console_pos%CONSOLE_HORIZONTAL_MAX)*FONT_WIDTH + 2;
801006dc:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801006e1:	b9 35 00 00 00       	mov    $0x35,%ecx
801006e6:	99                   	cltd   
801006e7:	f7 f9                	idiv   %ecx
801006e9:	89 d0                	mov    %edx,%eax
801006eb:	01 c0                	add    %eax,%eax
801006ed:	01 d0                	add    %edx,%eax
801006ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801006f6:	01 d0                	add    %edx,%eax
801006f8:	83 c0 02             	add    $0x2,%eax
801006fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int y = (console_pos/CONSOLE_HORIZONTAL_MAX)*FONT_HEIGHT;
801006fe:	8b 0d 00 c0 10 80    	mov    0x8010c000,%ecx
80100704:	b8 ed 73 48 4d       	mov    $0x4d4873ed,%eax
80100709:	f7 e9                	imul   %ecx
8010070b:	c1 fa 04             	sar    $0x4,%edx
8010070e:	89 c8                	mov    %ecx,%eax
80100710:	c1 f8 1f             	sar    $0x1f,%eax
80100713:	29 c2                	sub    %eax,%edx
80100715:	89 d0                	mov    %edx,%eax
80100717:	01 c0                	add    %eax,%eax
80100719:	01 d0                	add    %edx,%eax
8010071b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100722:	01 d0                	add    %edx,%eax
80100724:	01 c0                	add    %eax,%eax
80100726:	89 45 f0             	mov    %eax,-0x10(%ebp)
    font_render(x,y,c);
80100729:	83 ec 04             	sub    $0x4,%esp
8010072c:	ff 75 08             	pushl  0x8(%ebp)
8010072f:	ff 75 f0             	pushl  -0x10(%ebp)
80100732:	ff 75 f4             	pushl  -0xc(%ebp)
80100735:	e8 10 76 00 00       	call   80107d4a <font_render>
8010073a:	83 c4 10             	add    $0x10,%esp
    console_pos++;
8010073d:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80100742:	40                   	inc    %eax
80100743:	a3 00 c0 10 80       	mov    %eax,0x8010c000
}
80100748:	90                   	nop
80100749:	c9                   	leave  
8010074a:	c3                   	ret    

8010074b <consputc>:


void
consputc(int c)
{
8010074b:	55                   	push   %ebp
8010074c:	89 e5                	mov    %esp,%ebp
8010074e:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100751:	a1 ec 09 19 80       	mov    0x801909ec,%eax
80100756:	85 c0                	test   %eax,%eax
80100758:	74 08                	je     80100762 <consputc+0x17>
    cli();
8010075a:	e8 e2 fb ff ff       	call   80100341 <cli>
    for(;;)
8010075f:	90                   	nop
80100760:	eb fd                	jmp    8010075f <consputc+0x14>
      ;
  }

  if(c == BACKSPACE){
80100762:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100769:	75 29                	jne    80100794 <consputc+0x49>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010076b:	83 ec 0c             	sub    $0xc,%esp
8010076e:	6a 08                	push   $0x8
80100770:	e8 1b 5a 00 00       	call   80106190 <uartputc>
80100775:	83 c4 10             	add    $0x10,%esp
80100778:	83 ec 0c             	sub    $0xc,%esp
8010077b:	6a 20                	push   $0x20
8010077d:	e8 0e 5a 00 00       	call   80106190 <uartputc>
80100782:	83 c4 10             	add    $0x10,%esp
80100785:	83 ec 0c             	sub    $0xc,%esp
80100788:	6a 08                	push   $0x8
8010078a:	e8 01 5a 00 00       	call   80106190 <uartputc>
8010078f:	83 c4 10             	add    $0x10,%esp
80100792:	eb 0e                	jmp    801007a2 <consputc+0x57>
  } else {
    uartputc(c);
80100794:	83 ec 0c             	sub    $0xc,%esp
80100797:	ff 75 08             	pushl  0x8(%ebp)
8010079a:	e8 f1 59 00 00       	call   80106190 <uartputc>
8010079f:	83 c4 10             	add    $0x10,%esp
  }
  graphic_putc(c);
801007a2:	83 ec 0c             	sub    $0xc,%esp
801007a5:	ff 75 08             	pushl  0x8(%ebp)
801007a8:	e8 86 fe ff ff       	call   80100633 <graphic_putc>
801007ad:	83 c4 10             	add    $0x10,%esp
}
801007b0:	90                   	nop
801007b1:	c9                   	leave  
801007b2:	c3                   	ret    

801007b3 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007b3:	55                   	push   %ebp
801007b4:	89 e5                	mov    %esp,%ebp
801007b6:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
801007b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 00 0a 19 80       	push   $0x80190a00
801007c8:	e8 c8 3e 00 00       	call   80104695 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801007d0:	e9 4d 01 00 00       	jmp    80100922 <consoleintr+0x16f>
    switch(c){
801007d5:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
801007d9:	74 7c                	je     80100857 <consoleintr+0xa4>
801007db:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
801007df:	0f 8f a5 00 00 00    	jg     8010088a <consoleintr+0xd7>
801007e5:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
801007e9:	74 41                	je     8010082c <consoleintr+0x79>
801007eb:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
801007ef:	0f 8f 95 00 00 00    	jg     8010088a <consoleintr+0xd7>
801007f5:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
801007f9:	74 5c                	je     80100857 <consoleintr+0xa4>
801007fb:	83 7d f0 10          	cmpl   $0x10,-0x10(%ebp)
801007ff:	0f 85 85 00 00 00    	jne    8010088a <consoleintr+0xd7>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100805:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
8010080c:	e9 11 01 00 00       	jmp    80100922 <consoleintr+0x16f>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100811:	a1 e8 09 19 80       	mov    0x801909e8,%eax
80100816:	48                   	dec    %eax
80100817:	a3 e8 09 19 80       	mov    %eax,0x801909e8
        consputc(BACKSPACE);
8010081c:	83 ec 0c             	sub    $0xc,%esp
8010081f:	68 00 01 00 00       	push   $0x100
80100824:	e8 22 ff ff ff       	call   8010074b <consputc>
80100829:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
8010082c:	8b 15 e8 09 19 80    	mov    0x801909e8,%edx
80100832:	a1 e4 09 19 80       	mov    0x801909e4,%eax
80100837:	39 c2                	cmp    %eax,%edx
80100839:	0f 84 dc 00 00 00    	je     8010091b <consoleintr+0x168>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010083f:	a1 e8 09 19 80       	mov    0x801909e8,%eax
80100844:	48                   	dec    %eax
80100845:	83 e0 7f             	and    $0x7f,%eax
80100848:	8a 80 60 09 19 80    	mov    -0x7fe6f6a0(%eax),%al
      while(input.e != input.w &&
8010084e:	3c 0a                	cmp    $0xa,%al
80100850:	75 bf                	jne    80100811 <consoleintr+0x5e>
      }
      break;
80100852:	e9 c4 00 00 00       	jmp    8010091b <consoleintr+0x168>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100857:	8b 15 e8 09 19 80    	mov    0x801909e8,%edx
8010085d:	a1 e4 09 19 80       	mov    0x801909e4,%eax
80100862:	39 c2                	cmp    %eax,%edx
80100864:	0f 84 b4 00 00 00    	je     8010091e <consoleintr+0x16b>
        input.e--;
8010086a:	a1 e8 09 19 80       	mov    0x801909e8,%eax
8010086f:	48                   	dec    %eax
80100870:	a3 e8 09 19 80       	mov    %eax,0x801909e8
        consputc(BACKSPACE);
80100875:	83 ec 0c             	sub    $0xc,%esp
80100878:	68 00 01 00 00       	push   $0x100
8010087d:	e8 c9 fe ff ff       	call   8010074b <consputc>
80100882:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100885:	e9 94 00 00 00       	jmp    8010091e <consoleintr+0x16b>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010088a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010088e:	0f 84 8d 00 00 00    	je     80100921 <consoleintr+0x16e>
80100894:	8b 15 e8 09 19 80    	mov    0x801909e8,%edx
8010089a:	a1 e0 09 19 80       	mov    0x801909e0,%eax
8010089f:	29 c2                	sub    %eax,%edx
801008a1:	83 fa 7f             	cmp    $0x7f,%edx
801008a4:	77 7b                	ja     80100921 <consoleintr+0x16e>
        c = (c == '\r') ? '\n' : c;
801008a6:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801008aa:	74 05                	je     801008b1 <consoleintr+0xfe>
801008ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008af:	eb 05                	jmp    801008b6 <consoleintr+0x103>
801008b1:	b8 0a 00 00 00       	mov    $0xa,%eax
801008b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008b9:	a1 e8 09 19 80       	mov    0x801909e8,%eax
801008be:	8d 50 01             	lea    0x1(%eax),%edx
801008c1:	89 15 e8 09 19 80    	mov    %edx,0x801909e8
801008c7:	83 e0 7f             	and    $0x7f,%eax
801008ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
801008cd:	88 90 60 09 19 80    	mov    %dl,-0x7fe6f6a0(%eax)
        consputc(c);
801008d3:	83 ec 0c             	sub    $0xc,%esp
801008d6:	ff 75 f0             	pushl  -0x10(%ebp)
801008d9:	e8 6d fe ff ff       	call   8010074b <consputc>
801008de:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e1:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801008e5:	74 18                	je     801008ff <consoleintr+0x14c>
801008e7:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801008eb:	74 12                	je     801008ff <consoleintr+0x14c>
801008ed:	8b 15 e8 09 19 80    	mov    0x801909e8,%edx
801008f3:	a1 e0 09 19 80       	mov    0x801909e0,%eax
801008f8:	83 e8 80             	sub    $0xffffff80,%eax
801008fb:	39 c2                	cmp    %eax,%edx
801008fd:	75 22                	jne    80100921 <consoleintr+0x16e>
          input.w = input.e;
801008ff:	a1 e8 09 19 80       	mov    0x801909e8,%eax
80100904:	a3 e4 09 19 80       	mov    %eax,0x801909e4
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
8010090c:	68 e0 09 19 80       	push   $0x801909e0
80100911:	e8 4c 3a 00 00       	call   80104362 <wakeup>
80100916:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100919:	eb 06                	jmp    80100921 <consoleintr+0x16e>
      break;
8010091b:	90                   	nop
8010091c:	eb 04                	jmp    80100922 <consoleintr+0x16f>
      break;
8010091e:	90                   	nop
8010091f:	eb 01                	jmp    80100922 <consoleintr+0x16f>
      break;
80100921:	90                   	nop
  while((c = getc()) >= 0){
80100922:	8b 45 08             	mov    0x8(%ebp),%eax
80100925:	ff d0                	call   *%eax
80100927:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010092a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010092e:	0f 89 a1 fe ff ff    	jns    801007d5 <consoleintr+0x22>
    }
  }
  release(&cons.lock);
80100934:	83 ec 0c             	sub    $0xc,%esp
80100937:	68 00 0a 19 80       	push   $0x80190a00
8010093c:	e8 c2 3d 00 00       	call   80104703 <release>
80100941:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
80100944:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100948:	74 05                	je     8010094f <consoleintr+0x19c>
    procdump();  // now call procdump() wo. cons.lock held
8010094a:	e8 ce 3a 00 00       	call   8010441d <procdump>
  }
}
8010094f:	90                   	nop
80100950:	c9                   	leave  
80100951:	c3                   	ret    

80100952 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100952:	55                   	push   %ebp
80100953:	89 e5                	mov    %esp,%ebp
80100955:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100958:	83 ec 0c             	sub    $0xc,%esp
8010095b:	ff 75 08             	pushl  0x8(%ebp)
8010095e:	e8 3b 11 00 00       	call   80101a9e <iunlock>
80100963:	83 c4 10             	add    $0x10,%esp
  target = n;
80100966:	8b 45 10             	mov    0x10(%ebp),%eax
80100969:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
8010096c:	83 ec 0c             	sub    $0xc,%esp
8010096f:	68 00 0a 19 80       	push   $0x80190a00
80100974:	e8 1c 3d 00 00       	call   80104695 <acquire>
80100979:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
8010097c:	e9 a7 00 00 00       	jmp    80100a28 <consoleread+0xd6>
    while(input.r == input.w){
      if(myproc()->killed){
80100981:	e8 50 30 00 00       	call   801039d6 <myproc>
80100986:	8b 40 24             	mov    0x24(%eax),%eax
80100989:	85 c0                	test   %eax,%eax
8010098b:	74 28                	je     801009b5 <consoleread+0x63>
        release(&cons.lock);
8010098d:	83 ec 0c             	sub    $0xc,%esp
80100990:	68 00 0a 19 80       	push   $0x80190a00
80100995:	e8 69 3d 00 00       	call   80104703 <release>
8010099a:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
8010099d:	83 ec 0c             	sub    $0xc,%esp
801009a0:	ff 75 08             	pushl  0x8(%ebp)
801009a3:	e8 e6 0f 00 00       	call   8010198e <ilock>
801009a8:	83 c4 10             	add    $0x10,%esp
        return -1;
801009ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009b0:	e9 a7 00 00 00       	jmp    80100a5c <consoleread+0x10a>
      }
      sleep(&input.r, &cons.lock);
801009b5:	83 ec 08             	sub    $0x8,%esp
801009b8:	68 00 0a 19 80       	push   $0x80190a00
801009bd:	68 e0 09 19 80       	push   $0x801909e0
801009c2:	e8 b4 38 00 00       	call   8010427b <sleep>
801009c7:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
801009ca:	8b 15 e0 09 19 80    	mov    0x801909e0,%edx
801009d0:	a1 e4 09 19 80       	mov    0x801909e4,%eax
801009d5:	39 c2                	cmp    %eax,%edx
801009d7:	74 a8                	je     80100981 <consoleread+0x2f>
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009d9:	a1 e0 09 19 80       	mov    0x801909e0,%eax
801009de:	8d 50 01             	lea    0x1(%eax),%edx
801009e1:	89 15 e0 09 19 80    	mov    %edx,0x801909e0
801009e7:	83 e0 7f             	and    $0x7f,%eax
801009ea:	8a 80 60 09 19 80    	mov    -0x7fe6f6a0(%eax),%al
801009f0:	0f be c0             	movsbl %al,%eax
801009f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
801009f6:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801009fa:	75 15                	jne    80100a11 <consoleread+0xbf>
      if(n < target){
801009fc:	8b 45 10             	mov    0x10(%ebp),%eax
801009ff:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a02:	73 2c                	jae    80100a30 <consoleread+0xde>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a04:	a1 e0 09 19 80       	mov    0x801909e0,%eax
80100a09:	48                   	dec    %eax
80100a0a:	a3 e0 09 19 80       	mov    %eax,0x801909e0
      }
      break;
80100a0f:	eb 1f                	jmp    80100a30 <consoleread+0xde>
    }
    *dst++ = c;
80100a11:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a14:	8d 50 01             	lea    0x1(%eax),%edx
80100a17:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a1a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a1d:	88 10                	mov    %dl,(%eax)
    --n;
80100a1f:	ff 4d 10             	decl   0x10(%ebp)
    if(c == '\n')
80100a22:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a26:	74 0b                	je     80100a33 <consoleread+0xe1>
  while(n > 0){
80100a28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a2c:	7f 9c                	jg     801009ca <consoleread+0x78>
80100a2e:	eb 04                	jmp    80100a34 <consoleread+0xe2>
      break;
80100a30:	90                   	nop
80100a31:	eb 01                	jmp    80100a34 <consoleread+0xe2>
      break;
80100a33:	90                   	nop
  }
  release(&cons.lock);
80100a34:	83 ec 0c             	sub    $0xc,%esp
80100a37:	68 00 0a 19 80       	push   $0x80190a00
80100a3c:	e8 c2 3c 00 00       	call   80104703 <release>
80100a41:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a44:	83 ec 0c             	sub    $0xc,%esp
80100a47:	ff 75 08             	pushl  0x8(%ebp)
80100a4a:	e8 3f 0f 00 00       	call   8010198e <ilock>
80100a4f:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a52:	8b 45 10             	mov    0x10(%ebp),%eax
80100a55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a58:	29 c2                	sub    %eax,%edx
80100a5a:	89 d0                	mov    %edx,%eax
}
80100a5c:	c9                   	leave  
80100a5d:	c3                   	ret    

80100a5e <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a5e:	55                   	push   %ebp
80100a5f:	89 e5                	mov    %esp,%ebp
80100a61:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100a64:	83 ec 0c             	sub    $0xc,%esp
80100a67:	ff 75 08             	pushl  0x8(%ebp)
80100a6a:	e8 2f 10 00 00       	call   80101a9e <iunlock>
80100a6f:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100a72:	83 ec 0c             	sub    $0xc,%esp
80100a75:	68 00 0a 19 80       	push   $0x80190a00
80100a7a:	e8 16 3c 00 00       	call   80104695 <acquire>
80100a7f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100a82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a89:	eb 1f                	jmp    80100aaa <consolewrite+0x4c>
    consputc(buf[i] & 0xff);
80100a8b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a91:	01 d0                	add    %edx,%eax
80100a93:	8a 00                	mov    (%eax),%al
80100a95:	0f be c0             	movsbl %al,%eax
80100a98:	0f b6 c0             	movzbl %al,%eax
80100a9b:	83 ec 0c             	sub    $0xc,%esp
80100a9e:	50                   	push   %eax
80100a9f:	e8 a7 fc ff ff       	call   8010074b <consputc>
80100aa4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100aa7:	ff 45 f4             	incl   -0xc(%ebp)
80100aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100aad:	3b 45 10             	cmp    0x10(%ebp),%eax
80100ab0:	7c d9                	jl     80100a8b <consolewrite+0x2d>
  release(&cons.lock);
80100ab2:	83 ec 0c             	sub    $0xc,%esp
80100ab5:	68 00 0a 19 80       	push   $0x80190a00
80100aba:	e8 44 3c 00 00       	call   80104703 <release>
80100abf:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ac2:	83 ec 0c             	sub    $0xc,%esp
80100ac5:	ff 75 08             	pushl  0x8(%ebp)
80100ac8:	e8 c1 0e 00 00       	call   8010198e <ilock>
80100acd:	83 c4 10             	add    $0x10,%esp

  return n;
80100ad0:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ad3:	c9                   	leave  
80100ad4:	c3                   	ret    

80100ad5 <consoleinit>:

void
consoleinit(void)
{
80100ad5:	55                   	push   %ebp
80100ad6:	89 e5                	mov    %esp,%ebp
80100ad8:	83 ec 18             	sub    $0x18,%esp
  panicked = 0;
80100adb:	c7 05 ec 09 19 80 00 	movl   $0x0,0x801909ec
80100ae2:	00 00 00 
  initlock(&cons.lock, "console");
80100ae5:	83 ec 08             	sub    $0x8,%esp
80100ae8:	68 97 9e 10 80       	push   $0x80109e97
80100aed:	68 00 0a 19 80       	push   $0x80190a00
80100af2:	e8 7c 3b 00 00       	call   80104673 <initlock>
80100af7:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100afa:	c7 05 4c 0a 19 80 5e 	movl   $0x80100a5e,0x80190a4c
80100b01:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b04:	c7 05 48 0a 19 80 52 	movl   $0x80100952,0x80190a48
80100b0b:	09 10 80 
  
  char *p;
  for(p="Starting XV6_UEFI...\n"; *p; p++)
80100b0e:	c7 45 f4 9f 9e 10 80 	movl   $0x80109e9f,-0xc(%ebp)
80100b15:	eb 17                	jmp    80100b2e <consoleinit+0x59>
    graphic_putc(*p);
80100b17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b1a:	8a 00                	mov    (%eax),%al
80100b1c:	0f be c0             	movsbl %al,%eax
80100b1f:	83 ec 0c             	sub    $0xc,%esp
80100b22:	50                   	push   %eax
80100b23:	e8 0b fb ff ff       	call   80100633 <graphic_putc>
80100b28:	83 c4 10             	add    $0x10,%esp
  for(p="Starting XV6_UEFI...\n"; *p; p++)
80100b2b:	ff 45 f4             	incl   -0xc(%ebp)
80100b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b31:	8a 00                	mov    (%eax),%al
80100b33:	84 c0                	test   %al,%al
80100b35:	75 e0                	jne    80100b17 <consoleinit+0x42>
  
  cons.locking = 1;
80100b37:	c7 05 34 0a 19 80 01 	movl   $0x1,0x80190a34
80100b3e:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100b41:	83 ec 08             	sub    $0x8,%esp
80100b44:	6a 00                	push   $0x0
80100b46:	6a 01                	push   $0x1
80100b48:	e8 77 1a 00 00       	call   801025c4 <ioapicenable>
80100b4d:	83 c4 10             	add    $0x10,%esp
}
80100b50:	90                   	nop
80100b51:	c9                   	leave  
80100b52:	c3                   	ret    

80100b53 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b53:	55                   	push   %ebp
80100b54:	89 e5                	mov    %esp,%ebp
80100b56:	81 ec 18 01 00 00    	sub    $0x118,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100b5c:	e8 75 2e 00 00       	call   801039d6 <myproc>
80100b61:	89 45 d0             	mov    %eax,-0x30(%ebp)

  begin_op();
80100b64:	e8 50 24 00 00       	call   80102fb9 <begin_op>

  if((ip = namei(path)) == 0){
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff 75 08             	pushl  0x8(%ebp)
80100b6f:	e8 44 19 00 00       	call   801024b8 <namei>
80100b74:	83 c4 10             	add    $0x10,%esp
80100b77:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b7a:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b7e:	75 1f                	jne    80100b9f <exec+0x4c>
    end_op();
80100b80:	e8 be 24 00 00       	call   80103043 <end_op>
    cprintf("exec: fail\n");
80100b85:	83 ec 0c             	sub    $0xc,%esp
80100b88:	68 b5 9e 10 80       	push   $0x80109eb5
80100b8d:	e8 5f f8 ff ff       	call   801003f1 <cprintf>
80100b92:	83 c4 10             	add    $0x10,%esp
    return -1;
80100b95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b9a:	e9 e3 03 00 00       	jmp    80100f82 <exec+0x42f>
  }
  ilock(ip);
80100b9f:	83 ec 0c             	sub    $0xc,%esp
80100ba2:	ff 75 d8             	pushl  -0x28(%ebp)
80100ba5:	e8 e4 0d 00 00       	call   8010198e <ilock>
80100baa:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100bad:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100bb4:	6a 34                	push   $0x34
80100bb6:	6a 00                	push   $0x0
80100bb8:	8d 85 08 ff ff ff    	lea    -0xf8(%ebp),%eax
80100bbe:	50                   	push   %eax
80100bbf:	ff 75 d8             	pushl  -0x28(%ebp)
80100bc2:	e8 ad 12 00 00       	call   80101e74 <readi>
80100bc7:	83 c4 10             	add    $0x10,%esp
80100bca:	83 f8 34             	cmp    $0x34,%eax
80100bcd:	0f 85 58 03 00 00    	jne    80100f2b <exec+0x3d8>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100bd3:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
80100bd9:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100bde:	0f 85 4a 03 00 00    	jne    80100f2e <exec+0x3db>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100be4:	e8 83 65 00 00       	call   8010716c <setupkvm>
80100be9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bec:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bf0:	0f 84 3b 03 00 00    	je     80100f31 <exec+0x3de>
    goto bad;

  // Load program into memory.
  sz = 0;
80100bf6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bfd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100c04:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
80100c0a:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c0d:	e9 dd 00 00 00       	jmp    80100cef <exec+0x19c>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c12:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c15:	6a 20                	push   $0x20
80100c17:	50                   	push   %eax
80100c18:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
80100c1e:	50                   	push   %eax
80100c1f:	ff 75 d8             	pushl  -0x28(%ebp)
80100c22:	e8 4d 12 00 00       	call   80101e74 <readi>
80100c27:	83 c4 10             	add    $0x10,%esp
80100c2a:	83 f8 20             	cmp    $0x20,%eax
80100c2d:	0f 85 01 03 00 00    	jne    80100f34 <exec+0x3e1>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c33:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
80100c39:	83 f8 01             	cmp    $0x1,%eax
80100c3c:	0f 85 a0 00 00 00    	jne    80100ce2 <exec+0x18f>
      continue;
    if(ph.memsz < ph.filesz)
80100c42:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c48:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
80100c4e:	39 c2                	cmp    %eax,%edx
80100c50:	0f 82 e1 02 00 00    	jb     80100f37 <exec+0x3e4>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c56:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c5c:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c62:	01 c2                	add    %eax,%edx
80100c64:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c6a:	39 c2                	cmp    %eax,%edx
80100c6c:	0f 82 c8 02 00 00    	jb     80100f3a <exec+0x3e7>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c72:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c78:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c7e:	01 d0                	add    %edx,%eax
80100c80:	83 ec 04             	sub    $0x4,%esp
80100c83:	50                   	push   %eax
80100c84:	ff 75 e0             	pushl  -0x20(%ebp)
80100c87:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c8a:	e8 c9 68 00 00       	call   80107558 <allocuvm>
80100c8f:	83 c4 10             	add    $0x10,%esp
80100c92:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c95:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c99:	0f 84 9e 02 00 00    	je     80100f3d <exec+0x3ea>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100c9f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ca5:	25 ff 0f 00 00       	and    $0xfff,%eax
80100caa:	85 c0                	test   %eax,%eax
80100cac:	0f 85 8e 02 00 00    	jne    80100f40 <exec+0x3ed>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100cb2:	8b 95 f8 fe ff ff    	mov    -0x108(%ebp),%edx
80100cb8:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100cbe:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100cc4:	83 ec 0c             	sub    $0xc,%esp
80100cc7:	52                   	push   %edx
80100cc8:	50                   	push   %eax
80100cc9:	ff 75 d8             	pushl  -0x28(%ebp)
80100ccc:	51                   	push   %ecx
80100ccd:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cd0:	e8 b7 67 00 00       	call   8010748c <loaduvm>
80100cd5:	83 c4 20             	add    $0x20,%esp
80100cd8:	85 c0                	test   %eax,%eax
80100cda:	0f 88 63 02 00 00    	js     80100f43 <exec+0x3f0>
80100ce0:	eb 01                	jmp    80100ce3 <exec+0x190>
      continue;
80100ce2:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ce3:	ff 45 ec             	incl   -0x14(%ebp)
80100ce6:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100ce9:	83 c0 20             	add    $0x20,%eax
80100cec:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100cef:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
80100cf5:	0f b7 c0             	movzwl %ax,%eax
80100cf8:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100cfb:	0f 8c 11 ff ff ff    	jl     80100c12 <exec+0xbf>
      goto bad;
  }
  iunlockput(ip);
80100d01:	83 ec 0c             	sub    $0xc,%esp
80100d04:	ff 75 d8             	pushl  -0x28(%ebp)
80100d07:	e8 b0 0e 00 00       	call   80101bbc <iunlockput>
80100d0c:	83 c4 10             	add    $0x10,%esp
  end_op();
80100d0f:	e8 2f 23 00 00       	call   80103043 <end_op>
  ip = 0;
80100d14:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d1e:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d23:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100d28:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d2e:	05 00 20 00 00       	add    $0x2000,%eax
80100d33:	83 ec 04             	sub    $0x4,%esp
80100d36:	50                   	push   %eax
80100d37:	ff 75 e0             	pushl  -0x20(%ebp)
80100d3a:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d3d:	e8 16 68 00 00       	call   80107558 <allocuvm>
80100d42:	83 c4 10             	add    $0x10,%esp
80100d45:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d48:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d4c:	0f 84 f4 01 00 00    	je     80100f46 <exec+0x3f3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d52:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d55:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d5a:	83 ec 08             	sub    $0x8,%esp
80100d5d:	50                   	push   %eax
80100d5e:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d61:	e8 51 6a 00 00       	call   801077b7 <clearpteu>
80100d66:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d69:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d6c:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d6f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d76:	e9 91 00 00 00       	jmp    80100e0c <exec+0x2b9>
    if(argc >= MAXARG)
80100d7b:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d7f:	0f 87 c4 01 00 00    	ja     80100f49 <exec+0x3f6>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d85:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d88:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d92:	01 d0                	add    %edx,%eax
80100d94:	8b 00                	mov    (%eax),%eax
80100d96:	83 ec 0c             	sub    $0xc,%esp
80100d99:	50                   	push   %eax
80100d9a:	e8 9d 3d 00 00       	call   80104b3c <strlen>
80100d9f:	83 c4 10             	add    $0x10,%esp
80100da2:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100da5:	29 c2                	sub    %eax,%edx
80100da7:	8d 42 ff             	lea    -0x1(%edx),%eax
80100daa:	83 e0 fc             	and    $0xfffffffc,%eax
80100dad:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100db0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100db3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dba:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dbd:	01 d0                	add    %edx,%eax
80100dbf:	8b 00                	mov    (%eax),%eax
80100dc1:	83 ec 0c             	sub    $0xc,%esp
80100dc4:	50                   	push   %eax
80100dc5:	e8 72 3d 00 00       	call   80104b3c <strlen>
80100dca:	83 c4 10             	add    $0x10,%esp
80100dcd:	40                   	inc    %eax
80100dce:	89 c2                	mov    %eax,%edx
80100dd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80100dda:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ddd:	01 c8                	add    %ecx,%eax
80100ddf:	8b 00                	mov    (%eax),%eax
80100de1:	52                   	push   %edx
80100de2:	50                   	push   %eax
80100de3:	ff 75 dc             	pushl  -0x24(%ebp)
80100de6:	ff 75 d4             	pushl  -0x2c(%ebp)
80100de9:	e8 68 6b 00 00       	call   80107956 <copyout>
80100dee:	83 c4 10             	add    $0x10,%esp
80100df1:	85 c0                	test   %eax,%eax
80100df3:	0f 88 53 01 00 00    	js     80100f4c <exec+0x3f9>
      goto bad;
    ustack[3+argc] = sp;
80100df9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfc:	8d 50 03             	lea    0x3(%eax),%edx
80100dff:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e02:	89 84 95 3c ff ff ff 	mov    %eax,-0xc4(%ebp,%edx,4)
  for(argc = 0; argv[argc]; argc++) {
80100e09:	ff 45 e4             	incl   -0x1c(%ebp)
80100e0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e0f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e16:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e19:	01 d0                	add    %edx,%eax
80100e1b:	8b 00                	mov    (%eax),%eax
80100e1d:	85 c0                	test   %eax,%eax
80100e1f:	0f 85 56 ff ff ff    	jne    80100d7b <exec+0x228>
  }
  ustack[3+argc] = 0;
80100e25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e28:	83 c0 03             	add    $0x3,%eax
80100e2b:	c7 84 85 3c ff ff ff 	movl   $0x0,-0xc4(%ebp,%eax,4)
80100e32:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e36:	c7 85 3c ff ff ff ff 	movl   $0xffffffff,-0xc4(%ebp)
80100e3d:	ff ff ff 
  ustack[1] = argc;
80100e40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e43:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e4c:	40                   	inc    %eax
80100e4d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e54:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e57:	29 d0                	sub    %edx,%eax
80100e59:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)

  sp -= (3+argc+1) * 4;
80100e5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e62:	83 c0 04             	add    $0x4,%eax
80100e65:	c1 e0 02             	shl    $0x2,%eax
80100e68:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e6e:	83 c0 04             	add    $0x4,%eax
80100e71:	c1 e0 02             	shl    $0x2,%eax
80100e74:	50                   	push   %eax
80100e75:	8d 85 3c ff ff ff    	lea    -0xc4(%ebp),%eax
80100e7b:	50                   	push   %eax
80100e7c:	ff 75 dc             	pushl  -0x24(%ebp)
80100e7f:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e82:	e8 cf 6a 00 00       	call   80107956 <copyout>
80100e87:	83 c4 10             	add    $0x10,%esp
80100e8a:	85 c0                	test   %eax,%eax
80100e8c:	0f 88 bd 00 00 00    	js     80100f4f <exec+0x3fc>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e92:	8b 45 08             	mov    0x8(%ebp),%eax
80100e95:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e9e:	eb 13                	jmp    80100eb3 <exec+0x360>
    if(*s == '/')
80100ea0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ea3:	8a 00                	mov    (%eax),%al
80100ea5:	3c 2f                	cmp    $0x2f,%al
80100ea7:	75 07                	jne    80100eb0 <exec+0x35d>
      last = s+1;
80100ea9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eac:	40                   	inc    %eax
80100ead:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(last=s=path; *s; s++)
80100eb0:	ff 45 f4             	incl   -0xc(%ebp)
80100eb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eb6:	8a 00                	mov    (%eax),%al
80100eb8:	84 c0                	test   %al,%al
80100eba:	75 e4                	jne    80100ea0 <exec+0x34d>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ebc:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ebf:	83 c0 6c             	add    $0x6c,%eax
80100ec2:	83 ec 04             	sub    $0x4,%esp
80100ec5:	6a 10                	push   $0x10
80100ec7:	ff 75 f0             	pushl  -0x10(%ebp)
80100eca:	50                   	push   %eax
80100ecb:	e8 24 3c 00 00       	call   80104af4 <safestrcpy>
80100ed0:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100ed3:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ed6:	8b 40 04             	mov    0x4(%eax),%eax
80100ed9:	89 45 cc             	mov    %eax,-0x34(%ebp)
  curproc->pgdir = pgdir;
80100edc:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100edf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100ee2:	89 50 04             	mov    %edx,0x4(%eax)
  curproc->sz = sz;
80100ee5:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ee8:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100eeb:	89 10                	mov    %edx,(%eax)
  curproc->tf->eip = elf.entry;  // main
80100eed:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ef0:	8b 40 18             	mov    0x18(%eax),%eax
80100ef3:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
80100ef9:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100efc:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100eff:	8b 40 18             	mov    0x18(%eax),%eax
80100f02:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100f05:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(curproc);
80100f08:	83 ec 0c             	sub    $0xc,%esp
80100f0b:	ff 75 d0             	pushl  -0x30(%ebp)
80100f0e:	e8 77 63 00 00       	call   8010728a <switchuvm>
80100f13:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f16:	83 ec 0c             	sub    $0xc,%esp
80100f19:	ff 75 cc             	pushl  -0x34(%ebp)
80100f1c:	e8 fe 67 00 00       	call   8010771f <freevm>
80100f21:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f24:	b8 00 00 00 00       	mov    $0x0,%eax
80100f29:	eb 57                	jmp    80100f82 <exec+0x42f>
    goto bad;
80100f2b:	90                   	nop
80100f2c:	eb 22                	jmp    80100f50 <exec+0x3fd>
    goto bad;
80100f2e:	90                   	nop
80100f2f:	eb 1f                	jmp    80100f50 <exec+0x3fd>
    goto bad;
80100f31:	90                   	nop
80100f32:	eb 1c                	jmp    80100f50 <exec+0x3fd>
      goto bad;
80100f34:	90                   	nop
80100f35:	eb 19                	jmp    80100f50 <exec+0x3fd>
      goto bad;
80100f37:	90                   	nop
80100f38:	eb 16                	jmp    80100f50 <exec+0x3fd>
      goto bad;
80100f3a:	90                   	nop
80100f3b:	eb 13                	jmp    80100f50 <exec+0x3fd>
      goto bad;
80100f3d:	90                   	nop
80100f3e:	eb 10                	jmp    80100f50 <exec+0x3fd>
      goto bad;
80100f40:	90                   	nop
80100f41:	eb 0d                	jmp    80100f50 <exec+0x3fd>
      goto bad;
80100f43:	90                   	nop
80100f44:	eb 0a                	jmp    80100f50 <exec+0x3fd>
    goto bad;
80100f46:	90                   	nop
80100f47:	eb 07                	jmp    80100f50 <exec+0x3fd>
      goto bad;
80100f49:	90                   	nop
80100f4a:	eb 04                	jmp    80100f50 <exec+0x3fd>
      goto bad;
80100f4c:	90                   	nop
80100f4d:	eb 01                	jmp    80100f50 <exec+0x3fd>
    goto bad;
80100f4f:	90                   	nop

 bad:
  if(pgdir)
80100f50:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f54:	74 0e                	je     80100f64 <exec+0x411>
    freevm(pgdir);
80100f56:	83 ec 0c             	sub    $0xc,%esp
80100f59:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f5c:	e8 be 67 00 00       	call   8010771f <freevm>
80100f61:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100f64:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f68:	74 13                	je     80100f7d <exec+0x42a>
    iunlockput(ip);
80100f6a:	83 ec 0c             	sub    $0xc,%esp
80100f6d:	ff 75 d8             	pushl  -0x28(%ebp)
80100f70:	e8 47 0c 00 00       	call   80101bbc <iunlockput>
80100f75:	83 c4 10             	add    $0x10,%esp
    end_op();
80100f78:	e8 c6 20 00 00       	call   80103043 <end_op>
  }
  return -1;
80100f7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f82:	c9                   	leave  
80100f83:	c3                   	ret    

80100f84 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f84:	55                   	push   %ebp
80100f85:	89 e5                	mov    %esp,%ebp
80100f87:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100f8a:	83 ec 08             	sub    $0x8,%esp
80100f8d:	68 c1 9e 10 80       	push   $0x80109ec1
80100f92:	68 a0 0a 19 80       	push   $0x80190aa0
80100f97:	e8 d7 36 00 00       	call   80104673 <initlock>
80100f9c:	83 c4 10             	add    $0x10,%esp
}
80100f9f:	90                   	nop
80100fa0:	c9                   	leave  
80100fa1:	c3                   	ret    

80100fa2 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100fa2:	55                   	push   %ebp
80100fa3:	89 e5                	mov    %esp,%ebp
80100fa5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	68 a0 0a 19 80       	push   $0x80190aa0
80100fb0:	e8 e0 36 00 00       	call   80104695 <acquire>
80100fb5:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fb8:	c7 45 f4 d4 0a 19 80 	movl   $0x80190ad4,-0xc(%ebp)
80100fbf:	eb 2d                	jmp    80100fee <filealloc+0x4c>
    if(f->ref == 0){
80100fc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fc4:	8b 40 04             	mov    0x4(%eax),%eax
80100fc7:	85 c0                	test   %eax,%eax
80100fc9:	75 1f                	jne    80100fea <filealloc+0x48>
      f->ref = 1;
80100fcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fce:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100fd5:	83 ec 0c             	sub    $0xc,%esp
80100fd8:	68 a0 0a 19 80       	push   $0x80190aa0
80100fdd:	e8 21 37 00 00       	call   80104703 <release>
80100fe2:	83 c4 10             	add    $0x10,%esp
      return f;
80100fe5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fe8:	eb 23                	jmp    8010100d <filealloc+0x6b>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fea:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fee:	b8 34 14 19 80       	mov    $0x80191434,%eax
80100ff3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100ff6:	72 c9                	jb     80100fc1 <filealloc+0x1f>
    }
  }
  release(&ftable.lock);
80100ff8:	83 ec 0c             	sub    $0xc,%esp
80100ffb:	68 a0 0a 19 80       	push   $0x80190aa0
80101000:	e8 fe 36 00 00       	call   80104703 <release>
80101005:	83 c4 10             	add    $0x10,%esp
  return 0;
80101008:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010100d:	c9                   	leave  
8010100e:	c3                   	ret    

8010100f <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
8010100f:	55                   	push   %ebp
80101010:	89 e5                	mov    %esp,%ebp
80101012:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80101015:	83 ec 0c             	sub    $0xc,%esp
80101018:	68 a0 0a 19 80       	push   $0x80190aa0
8010101d:	e8 73 36 00 00       	call   80104695 <acquire>
80101022:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101025:	8b 45 08             	mov    0x8(%ebp),%eax
80101028:	8b 40 04             	mov    0x4(%eax),%eax
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 0d                	jg     8010103c <filedup+0x2d>
    panic("filedup");
8010102f:	83 ec 0c             	sub    $0xc,%esp
80101032:	68 c8 9e 10 80       	push   $0x80109ec8
80101037:	e8 63 f5 ff ff       	call   8010059f <panic>
  f->ref++;
8010103c:	8b 45 08             	mov    0x8(%ebp),%eax
8010103f:	8b 40 04             	mov    0x4(%eax),%eax
80101042:	8d 50 01             	lea    0x1(%eax),%edx
80101045:	8b 45 08             	mov    0x8(%ebp),%eax
80101048:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
8010104b:	83 ec 0c             	sub    $0xc,%esp
8010104e:	68 a0 0a 19 80       	push   $0x80190aa0
80101053:	e8 ab 36 00 00       	call   80104703 <release>
80101058:	83 c4 10             	add    $0x10,%esp
  return f;
8010105b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010105e:	c9                   	leave  
8010105f:	c3                   	ret    

80101060 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101060:	55                   	push   %ebp
80101061:	89 e5                	mov    %esp,%ebp
80101063:	57                   	push   %edi
80101064:	56                   	push   %esi
80101065:	53                   	push   %ebx
80101066:	83 ec 2c             	sub    $0x2c,%esp
  struct file ff;

  acquire(&ftable.lock);
80101069:	83 ec 0c             	sub    $0xc,%esp
8010106c:	68 a0 0a 19 80       	push   $0x80190aa0
80101071:	e8 1f 36 00 00       	call   80104695 <acquire>
80101076:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101079:	8b 45 08             	mov    0x8(%ebp),%eax
8010107c:	8b 40 04             	mov    0x4(%eax),%eax
8010107f:	85 c0                	test   %eax,%eax
80101081:	7f 0d                	jg     80101090 <fileclose+0x30>
    panic("fileclose");
80101083:	83 ec 0c             	sub    $0xc,%esp
80101086:	68 d0 9e 10 80       	push   $0x80109ed0
8010108b:	e8 0f f5 ff ff       	call   8010059f <panic>
  if(--f->ref > 0){
80101090:	8b 45 08             	mov    0x8(%ebp),%eax
80101093:	8b 40 04             	mov    0x4(%eax),%eax
80101096:	8d 50 ff             	lea    -0x1(%eax),%edx
80101099:	8b 45 08             	mov    0x8(%ebp),%eax
8010109c:	89 50 04             	mov    %edx,0x4(%eax)
8010109f:	8b 45 08             	mov    0x8(%ebp),%eax
801010a2:	8b 40 04             	mov    0x4(%eax),%eax
801010a5:	85 c0                	test   %eax,%eax
801010a7:	7e 12                	jle    801010bb <fileclose+0x5b>
    release(&ftable.lock);
801010a9:	83 ec 0c             	sub    $0xc,%esp
801010ac:	68 a0 0a 19 80       	push   $0x80190aa0
801010b1:	e8 4d 36 00 00       	call   80104703 <release>
801010b6:	83 c4 10             	add    $0x10,%esp
801010b9:	eb 79                	jmp    80101134 <fileclose+0xd4>
    return;
  }
  ff = *f;
801010bb:	8b 55 08             	mov    0x8(%ebp),%edx
801010be:	8d 45 d0             	lea    -0x30(%ebp),%eax
801010c1:	89 d3                	mov    %edx,%ebx
801010c3:	ba 06 00 00 00       	mov    $0x6,%edx
801010c8:	89 c7                	mov    %eax,%edi
801010ca:	89 de                	mov    %ebx,%esi
801010cc:	89 d1                	mov    %edx,%ecx
801010ce:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  f->ref = 0;
801010d0:	8b 45 08             	mov    0x8(%ebp),%eax
801010d3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801010da:	8b 45 08             	mov    0x8(%ebp),%eax
801010dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801010e3:	83 ec 0c             	sub    $0xc,%esp
801010e6:	68 a0 0a 19 80       	push   $0x80190aa0
801010eb:	e8 13 36 00 00       	call   80104703 <release>
801010f0:	83 c4 10             	add    $0x10,%esp

  if(ff.type == FD_PIPE)
801010f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
801010f6:	83 f8 01             	cmp    $0x1,%eax
801010f9:	75 18                	jne    80101113 <fileclose+0xb3>
    pipeclose(ff.pipe, ff.writable);
801010fb:	8a 45 d9             	mov    -0x27(%ebp),%al
801010fe:	0f be d0             	movsbl %al,%edx
80101101:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101104:	83 ec 08             	sub    $0x8,%esp
80101107:	52                   	push   %edx
80101108:	50                   	push   %eax
80101109:	e8 29 25 00 00       	call   80103637 <pipeclose>
8010110e:	83 c4 10             	add    $0x10,%esp
80101111:	eb 21                	jmp    80101134 <fileclose+0xd4>
  else if(ff.type == FD_INODE){
80101113:	8b 45 d0             	mov    -0x30(%ebp),%eax
80101116:	83 f8 02             	cmp    $0x2,%eax
80101119:	75 19                	jne    80101134 <fileclose+0xd4>
    begin_op();
8010111b:	e8 99 1e 00 00       	call   80102fb9 <begin_op>
    iput(ff.ip);
80101120:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101123:	83 ec 0c             	sub    $0xc,%esp
80101126:	50                   	push   %eax
80101127:	e8 c0 09 00 00       	call   80101aec <iput>
8010112c:	83 c4 10             	add    $0x10,%esp
    end_op();
8010112f:	e8 0f 1f 00 00       	call   80103043 <end_op>
  }
}
80101134:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101137:	5b                   	pop    %ebx
80101138:	5e                   	pop    %esi
80101139:	5f                   	pop    %edi
8010113a:	5d                   	pop    %ebp
8010113b:	c3                   	ret    

8010113c <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
8010113c:	55                   	push   %ebp
8010113d:	89 e5                	mov    %esp,%ebp
8010113f:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
80101142:	8b 45 08             	mov    0x8(%ebp),%eax
80101145:	8b 00                	mov    (%eax),%eax
80101147:	83 f8 02             	cmp    $0x2,%eax
8010114a:	75 40                	jne    8010118c <filestat+0x50>
    ilock(f->ip);
8010114c:	8b 45 08             	mov    0x8(%ebp),%eax
8010114f:	8b 40 10             	mov    0x10(%eax),%eax
80101152:	83 ec 0c             	sub    $0xc,%esp
80101155:	50                   	push   %eax
80101156:	e8 33 08 00 00       	call   8010198e <ilock>
8010115b:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
8010115e:	8b 45 08             	mov    0x8(%ebp),%eax
80101161:	8b 40 10             	mov    0x10(%eax),%eax
80101164:	83 ec 08             	sub    $0x8,%esp
80101167:	ff 75 0c             	pushl  0xc(%ebp)
8010116a:	50                   	push   %eax
8010116b:	e8 bf 0c 00 00       	call   80101e2f <stati>
80101170:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101173:	8b 45 08             	mov    0x8(%ebp),%eax
80101176:	8b 40 10             	mov    0x10(%eax),%eax
80101179:	83 ec 0c             	sub    $0xc,%esp
8010117c:	50                   	push   %eax
8010117d:	e8 1c 09 00 00       	call   80101a9e <iunlock>
80101182:	83 c4 10             	add    $0x10,%esp
    return 0;
80101185:	b8 00 00 00 00       	mov    $0x0,%eax
8010118a:	eb 05                	jmp    80101191 <filestat+0x55>
  }
  return -1;
8010118c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101191:	c9                   	leave  
80101192:	c3                   	ret    

80101193 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101193:	55                   	push   %ebp
80101194:	89 e5                	mov    %esp,%ebp
80101196:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101199:	8b 45 08             	mov    0x8(%ebp),%eax
8010119c:	8a 40 08             	mov    0x8(%eax),%al
8010119f:	84 c0                	test   %al,%al
801011a1:	75 0a                	jne    801011ad <fileread+0x1a>
    return -1;
801011a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011a8:	e9 9b 00 00 00       	jmp    80101248 <fileread+0xb5>
  if(f->type == FD_PIPE)
801011ad:	8b 45 08             	mov    0x8(%ebp),%eax
801011b0:	8b 00                	mov    (%eax),%eax
801011b2:	83 f8 01             	cmp    $0x1,%eax
801011b5:	75 1a                	jne    801011d1 <fileread+0x3e>
    return piperead(f->pipe, addr, n);
801011b7:	8b 45 08             	mov    0x8(%ebp),%eax
801011ba:	8b 40 0c             	mov    0xc(%eax),%eax
801011bd:	83 ec 04             	sub    $0x4,%esp
801011c0:	ff 75 10             	pushl  0x10(%ebp)
801011c3:	ff 75 0c             	pushl  0xc(%ebp)
801011c6:	50                   	push   %eax
801011c7:	e8 16 26 00 00       	call   801037e2 <piperead>
801011cc:	83 c4 10             	add    $0x10,%esp
801011cf:	eb 77                	jmp    80101248 <fileread+0xb5>
  if(f->type == FD_INODE){
801011d1:	8b 45 08             	mov    0x8(%ebp),%eax
801011d4:	8b 00                	mov    (%eax),%eax
801011d6:	83 f8 02             	cmp    $0x2,%eax
801011d9:	75 60                	jne    8010123b <fileread+0xa8>
    ilock(f->ip);
801011db:	8b 45 08             	mov    0x8(%ebp),%eax
801011de:	8b 40 10             	mov    0x10(%eax),%eax
801011e1:	83 ec 0c             	sub    $0xc,%esp
801011e4:	50                   	push   %eax
801011e5:	e8 a4 07 00 00       	call   8010198e <ilock>
801011ea:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011ed:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011f0:	8b 45 08             	mov    0x8(%ebp),%eax
801011f3:	8b 50 14             	mov    0x14(%eax),%edx
801011f6:	8b 45 08             	mov    0x8(%ebp),%eax
801011f9:	8b 40 10             	mov    0x10(%eax),%eax
801011fc:	51                   	push   %ecx
801011fd:	52                   	push   %edx
801011fe:	ff 75 0c             	pushl  0xc(%ebp)
80101201:	50                   	push   %eax
80101202:	e8 6d 0c 00 00       	call   80101e74 <readi>
80101207:	83 c4 10             	add    $0x10,%esp
8010120a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010120d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101211:	7e 11                	jle    80101224 <fileread+0x91>
      f->off += r;
80101213:	8b 45 08             	mov    0x8(%ebp),%eax
80101216:	8b 50 14             	mov    0x14(%eax),%edx
80101219:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010121c:	01 c2                	add    %eax,%edx
8010121e:	8b 45 08             	mov    0x8(%ebp),%eax
80101221:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101224:	8b 45 08             	mov    0x8(%ebp),%eax
80101227:	8b 40 10             	mov    0x10(%eax),%eax
8010122a:	83 ec 0c             	sub    $0xc,%esp
8010122d:	50                   	push   %eax
8010122e:	e8 6b 08 00 00       	call   80101a9e <iunlock>
80101233:	83 c4 10             	add    $0x10,%esp
    return r;
80101236:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101239:	eb 0d                	jmp    80101248 <fileread+0xb5>
  }
  panic("fileread");
8010123b:	83 ec 0c             	sub    $0xc,%esp
8010123e:	68 da 9e 10 80       	push   $0x80109eda
80101243:	e8 57 f3 ff ff       	call   8010059f <panic>
}
80101248:	c9                   	leave  
80101249:	c3                   	ret    

8010124a <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
8010124a:	55                   	push   %ebp
8010124b:	89 e5                	mov    %esp,%ebp
8010124d:	53                   	push   %ebx
8010124e:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
80101251:	8b 45 08             	mov    0x8(%ebp),%eax
80101254:	8a 40 09             	mov    0x9(%eax),%al
80101257:	84 c0                	test   %al,%al
80101259:	75 0a                	jne    80101265 <filewrite+0x1b>
    return -1;
8010125b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101260:	e9 1b 01 00 00       	jmp    80101380 <filewrite+0x136>
  if(f->type == FD_PIPE)
80101265:	8b 45 08             	mov    0x8(%ebp),%eax
80101268:	8b 00                	mov    (%eax),%eax
8010126a:	83 f8 01             	cmp    $0x1,%eax
8010126d:	75 1d                	jne    8010128c <filewrite+0x42>
    return pipewrite(f->pipe, addr, n);
8010126f:	8b 45 08             	mov    0x8(%ebp),%eax
80101272:	8b 40 0c             	mov    0xc(%eax),%eax
80101275:	83 ec 04             	sub    $0x4,%esp
80101278:	ff 75 10             	pushl  0x10(%ebp)
8010127b:	ff 75 0c             	pushl  0xc(%ebp)
8010127e:	50                   	push   %eax
8010127f:	e8 5e 24 00 00       	call   801036e2 <pipewrite>
80101284:	83 c4 10             	add    $0x10,%esp
80101287:	e9 f4 00 00 00       	jmp    80101380 <filewrite+0x136>
  if(f->type == FD_INODE){
8010128c:	8b 45 08             	mov    0x8(%ebp),%eax
8010128f:	8b 00                	mov    (%eax),%eax
80101291:	83 f8 02             	cmp    $0x2,%eax
80101294:	0f 85 d9 00 00 00    	jne    80101373 <filewrite+0x129>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
8010129a:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
801012a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
801012a8:	e9 a3 00 00 00       	jmp    80101350 <filewrite+0x106>
      int n1 = n - i;
801012ad:	8b 45 10             	mov    0x10(%ebp),%eax
801012b0:	2b 45 f4             	sub    -0xc(%ebp),%eax
801012b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
801012b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012b9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801012bc:	7e 06                	jle    801012c4 <filewrite+0x7a>
        n1 = max;
801012be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801012c1:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
801012c4:	e8 f0 1c 00 00       	call   80102fb9 <begin_op>
      ilock(f->ip);
801012c9:	8b 45 08             	mov    0x8(%ebp),%eax
801012cc:	8b 40 10             	mov    0x10(%eax),%eax
801012cf:	83 ec 0c             	sub    $0xc,%esp
801012d2:	50                   	push   %eax
801012d3:	e8 b6 06 00 00       	call   8010198e <ilock>
801012d8:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801012db:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012de:	8b 45 08             	mov    0x8(%ebp),%eax
801012e1:	8b 50 14             	mov    0x14(%eax),%edx
801012e4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801012ea:	01 c3                	add    %eax,%ebx
801012ec:	8b 45 08             	mov    0x8(%ebp),%eax
801012ef:	8b 40 10             	mov    0x10(%eax),%eax
801012f2:	51                   	push   %ecx
801012f3:	52                   	push   %edx
801012f4:	53                   	push   %ebx
801012f5:	50                   	push   %eax
801012f6:	e8 d4 0c 00 00       	call   80101fcf <writei>
801012fb:	83 c4 10             	add    $0x10,%esp
801012fe:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101301:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101305:	7e 11                	jle    80101318 <filewrite+0xce>
        f->off += r;
80101307:	8b 45 08             	mov    0x8(%ebp),%eax
8010130a:	8b 50 14             	mov    0x14(%eax),%edx
8010130d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101310:	01 c2                	add    %eax,%edx
80101312:	8b 45 08             	mov    0x8(%ebp),%eax
80101315:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
80101318:	8b 45 08             	mov    0x8(%ebp),%eax
8010131b:	8b 40 10             	mov    0x10(%eax),%eax
8010131e:	83 ec 0c             	sub    $0xc,%esp
80101321:	50                   	push   %eax
80101322:	e8 77 07 00 00       	call   80101a9e <iunlock>
80101327:	83 c4 10             	add    $0x10,%esp
      end_op();
8010132a:	e8 14 1d 00 00       	call   80103043 <end_op>

      if(r < 0)
8010132f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101333:	78 29                	js     8010135e <filewrite+0x114>
        break;
      if(r != n1)
80101335:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101338:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010133b:	74 0d                	je     8010134a <filewrite+0x100>
        panic("short filewrite");
8010133d:	83 ec 0c             	sub    $0xc,%esp
80101340:	68 e3 9e 10 80       	push   $0x80109ee3
80101345:	e8 55 f2 ff ff       	call   8010059f <panic>
      i += r;
8010134a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010134d:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
80101350:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101353:	3b 45 10             	cmp    0x10(%ebp),%eax
80101356:	0f 8c 51 ff ff ff    	jl     801012ad <filewrite+0x63>
8010135c:	eb 01                	jmp    8010135f <filewrite+0x115>
        break;
8010135e:	90                   	nop
    }
    return i == n ? n : -1;
8010135f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101362:	3b 45 10             	cmp    0x10(%ebp),%eax
80101365:	75 05                	jne    8010136c <filewrite+0x122>
80101367:	8b 45 10             	mov    0x10(%ebp),%eax
8010136a:	eb 14                	jmp    80101380 <filewrite+0x136>
8010136c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101371:	eb 0d                	jmp    80101380 <filewrite+0x136>
  }
  panic("filewrite");
80101373:	83 ec 0c             	sub    $0xc,%esp
80101376:	68 f3 9e 10 80       	push   $0x80109ef3
8010137b:	e8 1f f2 ff ff       	call   8010059f <panic>
}
80101380:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101383:	c9                   	leave  
80101384:	c3                   	ret    

80101385 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101385:	55                   	push   %ebp
80101386:	89 e5                	mov    %esp,%ebp
80101388:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
8010138b:	8b 45 08             	mov    0x8(%ebp),%eax
8010138e:	83 ec 08             	sub    $0x8,%esp
80101391:	6a 01                	push   $0x1
80101393:	50                   	push   %eax
80101394:	e8 68 ee ff ff       	call   80100201 <bread>
80101399:	83 c4 10             	add    $0x10,%esp
8010139c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010139f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013a2:	83 c0 5c             	add    $0x5c,%eax
801013a5:	83 ec 04             	sub    $0x4,%esp
801013a8:	6a 1c                	push   $0x1c
801013aa:	50                   	push   %eax
801013ab:	ff 75 0c             	pushl  0xc(%ebp)
801013ae:	e8 0b 36 00 00       	call   801049be <memmove>
801013b3:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013b6:	83 ec 0c             	sub    $0xc,%esp
801013b9:	ff 75 f4             	pushl  -0xc(%ebp)
801013bc:	e8 c2 ee ff ff       	call   80100283 <brelse>
801013c1:	83 c4 10             	add    $0x10,%esp
}
801013c4:	90                   	nop
801013c5:	c9                   	leave  
801013c6:	c3                   	ret    

801013c7 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801013c7:	55                   	push   %ebp
801013c8:	89 e5                	mov    %esp,%ebp
801013ca:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, bno);
801013cd:	8b 55 0c             	mov    0xc(%ebp),%edx
801013d0:	8b 45 08             	mov    0x8(%ebp),%eax
801013d3:	83 ec 08             	sub    $0x8,%esp
801013d6:	52                   	push   %edx
801013d7:	50                   	push   %eax
801013d8:	e8 24 ee ff ff       	call   80100201 <bread>
801013dd:	83 c4 10             	add    $0x10,%esp
801013e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013e6:	83 c0 5c             	add    $0x5c,%eax
801013e9:	83 ec 04             	sub    $0x4,%esp
801013ec:	68 00 02 00 00       	push   $0x200
801013f1:	6a 00                	push   $0x0
801013f3:	50                   	push   %eax
801013f4:	e8 0c 35 00 00       	call   80104905 <memset>
801013f9:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013fc:	83 ec 0c             	sub    $0xc,%esp
801013ff:	ff 75 f4             	pushl  -0xc(%ebp)
80101402:	e8 e4 1d 00 00       	call   801031eb <log_write>
80101407:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010140a:	83 ec 0c             	sub    $0xc,%esp
8010140d:	ff 75 f4             	pushl  -0xc(%ebp)
80101410:	e8 6e ee ff ff       	call   80100283 <brelse>
80101415:	83 c4 10             	add    $0x10,%esp
}
80101418:	90                   	nop
80101419:	c9                   	leave  
8010141a:	c3                   	ret    

8010141b <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010141b:	55                   	push   %ebp
8010141c:	89 e5                	mov    %esp,%ebp
8010141e:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
80101421:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101428:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010142f:	e9 04 01 00 00       	jmp    80101538 <balloc+0x11d>
    bp = bread(dev, BBLOCK(b, sb));
80101434:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101437:	85 c0                	test   %eax,%eax
80101439:	79 05                	jns    80101440 <balloc+0x25>
8010143b:	05 ff 0f 00 00       	add    $0xfff,%eax
80101440:	c1 f8 0c             	sar    $0xc,%eax
80101443:	89 c2                	mov    %eax,%edx
80101445:	a1 58 14 19 80       	mov    0x80191458,%eax
8010144a:	01 d0                	add    %edx,%eax
8010144c:	83 ec 08             	sub    $0x8,%esp
8010144f:	50                   	push   %eax
80101450:	ff 75 08             	pushl  0x8(%ebp)
80101453:	e8 a9 ed ff ff       	call   80100201 <bread>
80101458:	83 c4 10             	add    $0x10,%esp
8010145b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010145e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101465:	e9 99 00 00 00       	jmp    80101503 <balloc+0xe8>
      m = 1 << (bi % 8);
8010146a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010146d:	83 e0 07             	and    $0x7,%eax
80101470:	ba 01 00 00 00       	mov    $0x1,%edx
80101475:	88 c1                	mov    %al,%cl
80101477:	d3 e2                	shl    %cl,%edx
80101479:	89 d0                	mov    %edx,%eax
8010147b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010147e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101481:	85 c0                	test   %eax,%eax
80101483:	79 03                	jns    80101488 <balloc+0x6d>
80101485:	83 c0 07             	add    $0x7,%eax
80101488:	c1 f8 03             	sar    $0x3,%eax
8010148b:	89 c2                	mov    %eax,%edx
8010148d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101490:	8a 44 10 5c          	mov    0x5c(%eax,%edx,1),%al
80101494:	0f b6 c0             	movzbl %al,%eax
80101497:	23 45 e8             	and    -0x18(%ebp),%eax
8010149a:	85 c0                	test   %eax,%eax
8010149c:	75 62                	jne    80101500 <balloc+0xe5>
        bp->data[bi/8] |= m;  // Mark block in use.
8010149e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014a1:	85 c0                	test   %eax,%eax
801014a3:	79 03                	jns    801014a8 <balloc+0x8d>
801014a5:	83 c0 07             	add    $0x7,%eax
801014a8:	c1 f8 03             	sar    $0x3,%eax
801014ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014ae:	8a 54 02 5c          	mov    0x5c(%edx,%eax,1),%dl
801014b2:	88 d1                	mov    %dl,%cl
801014b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014b7:	09 ca                	or     %ecx,%edx
801014b9:	88 d1                	mov    %dl,%cl
801014bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014be:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
        log_write(bp);
801014c2:	83 ec 0c             	sub    $0xc,%esp
801014c5:	ff 75 ec             	pushl  -0x14(%ebp)
801014c8:	e8 1e 1d 00 00       	call   801031eb <log_write>
801014cd:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801014d0:	83 ec 0c             	sub    $0xc,%esp
801014d3:	ff 75 ec             	pushl  -0x14(%ebp)
801014d6:	e8 a8 ed ff ff       	call   80100283 <brelse>
801014db:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014de:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014e4:	01 c2                	add    %eax,%edx
801014e6:	8b 45 08             	mov    0x8(%ebp),%eax
801014e9:	83 ec 08             	sub    $0x8,%esp
801014ec:	52                   	push   %edx
801014ed:	50                   	push   %eax
801014ee:	e8 d4 fe ff ff       	call   801013c7 <bzero>
801014f3:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801014f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014fc:	01 d0                	add    %edx,%eax
801014fe:	eb 55                	jmp    80101555 <balloc+0x13a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101500:	ff 45 f0             	incl   -0x10(%ebp)
80101503:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010150a:	7f 17                	jg     80101523 <balloc+0x108>
8010150c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010150f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101512:	01 d0                	add    %edx,%eax
80101514:	89 c2                	mov    %eax,%edx
80101516:	a1 40 14 19 80       	mov    0x80191440,%eax
8010151b:	39 c2                	cmp    %eax,%edx
8010151d:	0f 82 47 ff ff ff    	jb     8010146a <balloc+0x4f>
      }
    }
    brelse(bp);
80101523:	83 ec 0c             	sub    $0xc,%esp
80101526:	ff 75 ec             	pushl  -0x14(%ebp)
80101529:	e8 55 ed ff ff       	call   80100283 <brelse>
8010152e:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
80101531:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101538:	a1 40 14 19 80       	mov    0x80191440,%eax
8010153d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101540:	39 c2                	cmp    %eax,%edx
80101542:	0f 82 ec fe ff ff    	jb     80101434 <balloc+0x19>
  }
  panic("balloc: out of blocks");
80101548:	83 ec 0c             	sub    $0xc,%esp
8010154b:	68 00 9f 10 80       	push   $0x80109f00
80101550:	e8 4a f0 ff ff       	call   8010059f <panic>
}
80101555:	c9                   	leave  
80101556:	c3                   	ret    

80101557 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101557:	55                   	push   %ebp
80101558:	89 e5                	mov    %esp,%ebp
8010155a:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
8010155d:	83 ec 08             	sub    $0x8,%esp
80101560:	68 40 14 19 80       	push   $0x80191440
80101565:	ff 75 08             	pushl  0x8(%ebp)
80101568:	e8 18 fe ff ff       	call   80101385 <readsb>
8010156d:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101570:	8b 45 0c             	mov    0xc(%ebp),%eax
80101573:	c1 e8 0c             	shr    $0xc,%eax
80101576:	89 c2                	mov    %eax,%edx
80101578:	a1 58 14 19 80       	mov    0x80191458,%eax
8010157d:	01 c2                	add    %eax,%edx
8010157f:	8b 45 08             	mov    0x8(%ebp),%eax
80101582:	83 ec 08             	sub    $0x8,%esp
80101585:	52                   	push   %edx
80101586:	50                   	push   %eax
80101587:	e8 75 ec ff ff       	call   80100201 <bread>
8010158c:	83 c4 10             	add    $0x10,%esp
8010158f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101592:	8b 45 0c             	mov    0xc(%ebp),%eax
80101595:	25 ff 0f 00 00       	and    $0xfff,%eax
8010159a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010159d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015a0:	83 e0 07             	and    $0x7,%eax
801015a3:	ba 01 00 00 00       	mov    $0x1,%edx
801015a8:	88 c1                	mov    %al,%cl
801015aa:	d3 e2                	shl    %cl,%edx
801015ac:	89 d0                	mov    %edx,%eax
801015ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801015b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015b4:	85 c0                	test   %eax,%eax
801015b6:	79 03                	jns    801015bb <bfree+0x64>
801015b8:	83 c0 07             	add    $0x7,%eax
801015bb:	c1 f8 03             	sar    $0x3,%eax
801015be:	89 c2                	mov    %eax,%edx
801015c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015c3:	8a 44 10 5c          	mov    0x5c(%eax,%edx,1),%al
801015c7:	0f b6 c0             	movzbl %al,%eax
801015ca:	23 45 ec             	and    -0x14(%ebp),%eax
801015cd:	85 c0                	test   %eax,%eax
801015cf:	75 0d                	jne    801015de <bfree+0x87>
    panic("freeing free block");
801015d1:	83 ec 0c             	sub    $0xc,%esp
801015d4:	68 16 9f 10 80       	push   $0x80109f16
801015d9:	e8 c1 ef ff ff       	call   8010059f <panic>
  bp->data[bi/8] &= ~m;
801015de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015e1:	85 c0                	test   %eax,%eax
801015e3:	79 03                	jns    801015e8 <bfree+0x91>
801015e5:	83 c0 07             	add    $0x7,%eax
801015e8:	c1 f8 03             	sar    $0x3,%eax
801015eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015ee:	8a 54 02 5c          	mov    0x5c(%edx,%eax,1),%dl
801015f2:	88 d1                	mov    %dl,%cl
801015f4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015f7:	f7 d2                	not    %edx
801015f9:	21 ca                	and    %ecx,%edx
801015fb:	88 d1                	mov    %dl,%cl
801015fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101600:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
  log_write(bp);
80101604:	83 ec 0c             	sub    $0xc,%esp
80101607:	ff 75 f4             	pushl  -0xc(%ebp)
8010160a:	e8 dc 1b 00 00       	call   801031eb <log_write>
8010160f:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101612:	83 ec 0c             	sub    $0xc,%esp
80101615:	ff 75 f4             	pushl  -0xc(%ebp)
80101618:	e8 66 ec ff ff       	call   80100283 <brelse>
8010161d:	83 c4 10             	add    $0x10,%esp
}
80101620:	90                   	nop
80101621:	c9                   	leave  
80101622:	c3                   	ret    

80101623 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101623:	55                   	push   %ebp
80101624:	89 e5                	mov    %esp,%ebp
80101626:	57                   	push   %edi
80101627:	56                   	push   %esi
80101628:	53                   	push   %ebx
80101629:	83 ec 2c             	sub    $0x2c,%esp
  int i = 0;
8010162c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  
  initlock(&icache.lock, "icache");
80101633:	83 ec 08             	sub    $0x8,%esp
80101636:	68 29 9f 10 80       	push   $0x80109f29
8010163b:	68 60 14 19 80       	push   $0x80191460
80101640:	e8 2e 30 00 00       	call   80104673 <initlock>
80101645:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
80101648:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010164f:	eb 2c                	jmp    8010167d <iinit+0x5a>
    initsleeplock(&icache.inode[i].lock, "inode");
80101651:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101654:	89 d0                	mov    %edx,%eax
80101656:	c1 e0 03             	shl    $0x3,%eax
80101659:	01 d0                	add    %edx,%eax
8010165b:	c1 e0 04             	shl    $0x4,%eax
8010165e:	83 c0 30             	add    $0x30,%eax
80101661:	05 60 14 19 80       	add    $0x80191460,%eax
80101666:	83 c0 10             	add    $0x10,%eax
80101669:	83 ec 08             	sub    $0x8,%esp
8010166c:	68 30 9f 10 80       	push   $0x80109f30
80101671:	50                   	push   %eax
80101672:	e8 9f 2e 00 00       	call   80104516 <initsleeplock>
80101677:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
8010167a:	ff 45 e4             	incl   -0x1c(%ebp)
8010167d:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
80101681:	7e ce                	jle    80101651 <iinit+0x2e>
  }

  readsb(dev, &sb);
80101683:	83 ec 08             	sub    $0x8,%esp
80101686:	68 40 14 19 80       	push   $0x80191440
8010168b:	ff 75 08             	pushl  0x8(%ebp)
8010168e:	e8 f2 fc ff ff       	call   80101385 <readsb>
80101693:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101696:	a1 58 14 19 80       	mov    0x80191458,%eax
8010169b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010169e:	8b 3d 54 14 19 80    	mov    0x80191454,%edi
801016a4:	8b 35 50 14 19 80    	mov    0x80191450,%esi
801016aa:	8b 1d 4c 14 19 80    	mov    0x8019144c,%ebx
801016b0:	8b 0d 48 14 19 80    	mov    0x80191448,%ecx
801016b6:	8b 15 44 14 19 80    	mov    0x80191444,%edx
801016bc:	a1 40 14 19 80       	mov    0x80191440,%eax
801016c1:	ff 75 d4             	pushl  -0x2c(%ebp)
801016c4:	57                   	push   %edi
801016c5:	56                   	push   %esi
801016c6:	53                   	push   %ebx
801016c7:	51                   	push   %ecx
801016c8:	52                   	push   %edx
801016c9:	50                   	push   %eax
801016ca:	68 38 9f 10 80       	push   $0x80109f38
801016cf:	e8 1d ed ff ff       	call   801003f1 <cprintf>
801016d4:	83 c4 20             	add    $0x20,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801016d7:	90                   	nop
801016d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016db:	5b                   	pop    %ebx
801016dc:	5e                   	pop    %esi
801016dd:	5f                   	pop    %edi
801016de:	5d                   	pop    %ebp
801016df:	c3                   	ret    

801016e0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	83 ec 28             	sub    $0x28,%esp
801016e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801016e9:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016ed:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801016f4:	e9 9b 00 00 00       	jmp    80101794 <ialloc+0xb4>
    bp = bread(dev, IBLOCK(inum, sb));
801016f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016fc:	c1 e8 03             	shr    $0x3,%eax
801016ff:	89 c2                	mov    %eax,%edx
80101701:	a1 54 14 19 80       	mov    0x80191454,%eax
80101706:	01 d0                	add    %edx,%eax
80101708:	83 ec 08             	sub    $0x8,%esp
8010170b:	50                   	push   %eax
8010170c:	ff 75 08             	pushl  0x8(%ebp)
8010170f:	e8 ed ea ff ff       	call   80100201 <bread>
80101714:	83 c4 10             	add    $0x10,%esp
80101717:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
8010171a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010171d:	8d 50 5c             	lea    0x5c(%eax),%edx
80101720:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101723:	83 e0 07             	and    $0x7,%eax
80101726:	c1 e0 06             	shl    $0x6,%eax
80101729:	01 d0                	add    %edx,%eax
8010172b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
8010172e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101731:	8b 00                	mov    (%eax),%eax
80101733:	66 85 c0             	test   %ax,%ax
80101736:	75 4b                	jne    80101783 <ialloc+0xa3>
      memset(dip, 0, sizeof(*dip));
80101738:	83 ec 04             	sub    $0x4,%esp
8010173b:	6a 40                	push   $0x40
8010173d:	6a 00                	push   $0x0
8010173f:	ff 75 ec             	pushl  -0x14(%ebp)
80101742:	e8 be 31 00 00       	call   80104905 <memset>
80101747:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
8010174a:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010174d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101750:	66 89 02             	mov    %ax,(%edx)
      log_write(bp);   // mark it allocated on the disk
80101753:	83 ec 0c             	sub    $0xc,%esp
80101756:	ff 75 f0             	pushl  -0x10(%ebp)
80101759:	e8 8d 1a 00 00       	call   801031eb <log_write>
8010175e:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
80101761:	83 ec 0c             	sub    $0xc,%esp
80101764:	ff 75 f0             	pushl  -0x10(%ebp)
80101767:	e8 17 eb ff ff       	call   80100283 <brelse>
8010176c:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
8010176f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101772:	83 ec 08             	sub    $0x8,%esp
80101775:	50                   	push   %eax
80101776:	ff 75 08             	pushl  0x8(%ebp)
80101779:	e8 f4 00 00 00       	call   80101872 <iget>
8010177e:	83 c4 10             	add    $0x10,%esp
80101781:	eb 2e                	jmp    801017b1 <ialloc+0xd1>
    }
    brelse(bp);
80101783:	83 ec 0c             	sub    $0xc,%esp
80101786:	ff 75 f0             	pushl  -0x10(%ebp)
80101789:	e8 f5 ea ff ff       	call   80100283 <brelse>
8010178e:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101791:	ff 45 f4             	incl   -0xc(%ebp)
80101794:	a1 48 14 19 80       	mov    0x80191448,%eax
80101799:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010179c:	39 c2                	cmp    %eax,%edx
8010179e:	0f 82 55 ff ff ff    	jb     801016f9 <ialloc+0x19>
  }
  panic("ialloc: no inodes");
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	68 8b 9f 10 80       	push   $0x80109f8b
801017ac:	e8 ee ed ff ff       	call   8010059f <panic>
}
801017b1:	c9                   	leave  
801017b2:	c3                   	ret    

801017b3 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801017b3:	55                   	push   %ebp
801017b4:	89 e5                	mov    %esp,%ebp
801017b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017b9:	8b 45 08             	mov    0x8(%ebp),%eax
801017bc:	8b 40 04             	mov    0x4(%eax),%eax
801017bf:	c1 e8 03             	shr    $0x3,%eax
801017c2:	89 c2                	mov    %eax,%edx
801017c4:	a1 54 14 19 80       	mov    0x80191454,%eax
801017c9:	01 c2                	add    %eax,%edx
801017cb:	8b 45 08             	mov    0x8(%ebp),%eax
801017ce:	8b 00                	mov    (%eax),%eax
801017d0:	83 ec 08             	sub    $0x8,%esp
801017d3:	52                   	push   %edx
801017d4:	50                   	push   %eax
801017d5:	e8 27 ea ff ff       	call   80100201 <bread>
801017da:	83 c4 10             	add    $0x10,%esp
801017dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017e3:	8d 50 5c             	lea    0x5c(%eax),%edx
801017e6:	8b 45 08             	mov    0x8(%ebp),%eax
801017e9:	8b 40 04             	mov    0x4(%eax),%eax
801017ec:	83 e0 07             	and    $0x7,%eax
801017ef:	c1 e0 06             	shl    $0x6,%eax
801017f2:	01 d0                	add    %edx,%eax
801017f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801017f7:	8b 45 08             	mov    0x8(%ebp),%eax
801017fa:	8b 40 50             	mov    0x50(%eax),%eax
801017fd:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101800:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
80101803:	8b 45 08             	mov    0x8(%ebp),%eax
80101806:	66 8b 40 52          	mov    0x52(%eax),%ax
8010180a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010180d:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
80101811:	8b 45 08             	mov    0x8(%ebp),%eax
80101814:	8b 40 54             	mov    0x54(%eax),%eax
80101817:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010181a:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
8010181e:	8b 45 08             	mov    0x8(%ebp),%eax
80101821:	66 8b 40 56          	mov    0x56(%eax),%ax
80101825:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101828:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
8010182c:	8b 45 08             	mov    0x8(%ebp),%eax
8010182f:	8b 50 58             	mov    0x58(%eax),%edx
80101832:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101835:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101838:	8b 45 08             	mov    0x8(%ebp),%eax
8010183b:	8d 50 5c             	lea    0x5c(%eax),%edx
8010183e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101841:	83 c0 0c             	add    $0xc,%eax
80101844:	83 ec 04             	sub    $0x4,%esp
80101847:	6a 34                	push   $0x34
80101849:	52                   	push   %edx
8010184a:	50                   	push   %eax
8010184b:	e8 6e 31 00 00       	call   801049be <memmove>
80101850:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101853:	83 ec 0c             	sub    $0xc,%esp
80101856:	ff 75 f4             	pushl  -0xc(%ebp)
80101859:	e8 8d 19 00 00       	call   801031eb <log_write>
8010185e:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101861:	83 ec 0c             	sub    $0xc,%esp
80101864:	ff 75 f4             	pushl  -0xc(%ebp)
80101867:	e8 17 ea ff ff       	call   80100283 <brelse>
8010186c:	83 c4 10             	add    $0x10,%esp
}
8010186f:	90                   	nop
80101870:	c9                   	leave  
80101871:	c3                   	ret    

80101872 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101872:	55                   	push   %ebp
80101873:	89 e5                	mov    %esp,%ebp
80101875:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101878:	83 ec 0c             	sub    $0xc,%esp
8010187b:	68 60 14 19 80       	push   $0x80191460
80101880:	e8 10 2e 00 00       	call   80104695 <acquire>
80101885:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101888:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010188f:	c7 45 f4 94 14 19 80 	movl   $0x80191494,-0xc(%ebp)
80101896:	eb 60                	jmp    801018f8 <iget+0x86>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101898:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010189b:	8b 40 08             	mov    0x8(%eax),%eax
8010189e:	85 c0                	test   %eax,%eax
801018a0:	7e 39                	jle    801018db <iget+0x69>
801018a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a5:	8b 00                	mov    (%eax),%eax
801018a7:	39 45 08             	cmp    %eax,0x8(%ebp)
801018aa:	75 2f                	jne    801018db <iget+0x69>
801018ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018af:	8b 40 04             	mov    0x4(%eax),%eax
801018b2:	39 45 0c             	cmp    %eax,0xc(%ebp)
801018b5:	75 24                	jne    801018db <iget+0x69>
      ip->ref++;
801018b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ba:	8b 40 08             	mov    0x8(%eax),%eax
801018bd:	8d 50 01             	lea    0x1(%eax),%edx
801018c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c3:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801018c6:	83 ec 0c             	sub    $0xc,%esp
801018c9:	68 60 14 19 80       	push   $0x80191460
801018ce:	e8 30 2e 00 00       	call   80104703 <release>
801018d3:	83 c4 10             	add    $0x10,%esp
      return ip;
801018d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d9:	eb 77                	jmp    80101952 <iget+0xe0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801018db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018df:	75 10                	jne    801018f1 <iget+0x7f>
801018e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018e4:	8b 40 08             	mov    0x8(%eax),%eax
801018e7:	85 c0                	test   %eax,%eax
801018e9:	75 06                	jne    801018f1 <iget+0x7f>
      empty = ip;
801018eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018f1:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
801018f8:	81 7d f4 b4 30 19 80 	cmpl   $0x801930b4,-0xc(%ebp)
801018ff:	72 97                	jb     80101898 <iget+0x26>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101901:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101905:	75 0d                	jne    80101914 <iget+0xa2>
    panic("iget: no inodes");
80101907:	83 ec 0c             	sub    $0xc,%esp
8010190a:	68 9d 9f 10 80       	push   $0x80109f9d
8010190f:	e8 8b ec ff ff       	call   8010059f <panic>

  ip = empty;
80101914:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101917:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
8010191a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010191d:	8b 55 08             	mov    0x8(%ebp),%edx
80101920:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101922:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101925:	8b 55 0c             	mov    0xc(%ebp),%edx
80101928:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
8010192b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010192e:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
80101935:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101938:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
8010193f:	83 ec 0c             	sub    $0xc,%esp
80101942:	68 60 14 19 80       	push   $0x80191460
80101947:	e8 b7 2d 00 00       	call   80104703 <release>
8010194c:	83 c4 10             	add    $0x10,%esp

  return ip;
8010194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101952:	c9                   	leave  
80101953:	c3                   	ret    

80101954 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101954:	55                   	push   %ebp
80101955:	89 e5                	mov    %esp,%ebp
80101957:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
8010195a:	83 ec 0c             	sub    $0xc,%esp
8010195d:	68 60 14 19 80       	push   $0x80191460
80101962:	e8 2e 2d 00 00       	call   80104695 <acquire>
80101967:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
8010196a:	8b 45 08             	mov    0x8(%ebp),%eax
8010196d:	8b 40 08             	mov    0x8(%eax),%eax
80101970:	8d 50 01             	lea    0x1(%eax),%edx
80101973:	8b 45 08             	mov    0x8(%ebp),%eax
80101976:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101979:	83 ec 0c             	sub    $0xc,%esp
8010197c:	68 60 14 19 80       	push   $0x80191460
80101981:	e8 7d 2d 00 00       	call   80104703 <release>
80101986:	83 c4 10             	add    $0x10,%esp
  return ip;
80101989:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010198c:	c9                   	leave  
8010198d:	c3                   	ret    

8010198e <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
8010198e:	55                   	push   %ebp
8010198f:	89 e5                	mov    %esp,%ebp
80101991:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101994:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101998:	74 0a                	je     801019a4 <ilock+0x16>
8010199a:	8b 45 08             	mov    0x8(%ebp),%eax
8010199d:	8b 40 08             	mov    0x8(%eax),%eax
801019a0:	85 c0                	test   %eax,%eax
801019a2:	7f 0d                	jg     801019b1 <ilock+0x23>
    panic("ilock");
801019a4:	83 ec 0c             	sub    $0xc,%esp
801019a7:	68 ad 9f 10 80       	push   $0x80109fad
801019ac:	e8 ee eb ff ff       	call   8010059f <panic>

  acquiresleep(&ip->lock);
801019b1:	8b 45 08             	mov    0x8(%ebp),%eax
801019b4:	83 c0 0c             	add    $0xc,%eax
801019b7:	83 ec 0c             	sub    $0xc,%esp
801019ba:	50                   	push   %eax
801019bb:	e8 92 2b 00 00       	call   80104552 <acquiresleep>
801019c0:	83 c4 10             	add    $0x10,%esp

  if(ip->valid == 0){
801019c3:	8b 45 08             	mov    0x8(%ebp),%eax
801019c6:	8b 40 4c             	mov    0x4c(%eax),%eax
801019c9:	85 c0                	test   %eax,%eax
801019cb:	0f 85 ca 00 00 00    	jne    80101a9b <ilock+0x10d>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019d1:	8b 45 08             	mov    0x8(%ebp),%eax
801019d4:	8b 40 04             	mov    0x4(%eax),%eax
801019d7:	c1 e8 03             	shr    $0x3,%eax
801019da:	89 c2                	mov    %eax,%edx
801019dc:	a1 54 14 19 80       	mov    0x80191454,%eax
801019e1:	01 c2                	add    %eax,%edx
801019e3:	8b 45 08             	mov    0x8(%ebp),%eax
801019e6:	8b 00                	mov    (%eax),%eax
801019e8:	83 ec 08             	sub    $0x8,%esp
801019eb:	52                   	push   %edx
801019ec:	50                   	push   %eax
801019ed:	e8 0f e8 ff ff       	call   80100201 <bread>
801019f2:	83 c4 10             	add    $0x10,%esp
801019f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019fb:	8d 50 5c             	lea    0x5c(%eax),%edx
801019fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101a01:	8b 40 04             	mov    0x4(%eax),%eax
80101a04:	83 e0 07             	and    $0x7,%eax
80101a07:	c1 e0 06             	shl    $0x6,%eax
80101a0a:	01 d0                	add    %edx,%eax
80101a0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101a0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a12:	8b 00                	mov    (%eax),%eax
80101a14:	8b 55 08             	mov    0x8(%ebp),%edx
80101a17:	66 89 42 50          	mov    %ax,0x50(%edx)
    ip->major = dip->major;
80101a1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a1e:	66 8b 40 02          	mov    0x2(%eax),%ax
80101a22:	8b 55 08             	mov    0x8(%ebp),%edx
80101a25:	66 89 42 52          	mov    %ax,0x52(%edx)
    ip->minor = dip->minor;
80101a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a2c:	8b 40 04             	mov    0x4(%eax),%eax
80101a2f:	8b 55 08             	mov    0x8(%ebp),%edx
80101a32:	66 89 42 54          	mov    %ax,0x54(%edx)
    ip->nlink = dip->nlink;
80101a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a39:	66 8b 40 06          	mov    0x6(%eax),%ax
80101a3d:	8b 55 08             	mov    0x8(%ebp),%edx
80101a40:	66 89 42 56          	mov    %ax,0x56(%edx)
    ip->size = dip->size;
80101a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a47:	8b 50 08             	mov    0x8(%eax),%edx
80101a4a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4d:	89 50 58             	mov    %edx,0x58(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a50:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a53:	8d 50 0c             	lea    0xc(%eax),%edx
80101a56:	8b 45 08             	mov    0x8(%ebp),%eax
80101a59:	83 c0 5c             	add    $0x5c,%eax
80101a5c:	83 ec 04             	sub    $0x4,%esp
80101a5f:	6a 34                	push   $0x34
80101a61:	52                   	push   %edx
80101a62:	50                   	push   %eax
80101a63:	e8 56 2f 00 00       	call   801049be <memmove>
80101a68:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101a6b:	83 ec 0c             	sub    $0xc,%esp
80101a6e:	ff 75 f4             	pushl  -0xc(%ebp)
80101a71:	e8 0d e8 ff ff       	call   80100283 <brelse>
80101a76:	83 c4 10             	add    $0x10,%esp
    ip->valid = 1;
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
    if(ip->type == 0)
80101a83:	8b 45 08             	mov    0x8(%ebp),%eax
80101a86:	8b 40 50             	mov    0x50(%eax),%eax
80101a89:	66 85 c0             	test   %ax,%ax
80101a8c:	75 0d                	jne    80101a9b <ilock+0x10d>
      panic("ilock: no type");
80101a8e:	83 ec 0c             	sub    $0xc,%esp
80101a91:	68 b3 9f 10 80       	push   $0x80109fb3
80101a96:	e8 04 eb ff ff       	call   8010059f <panic>
  }
}
80101a9b:	90                   	nop
80101a9c:	c9                   	leave  
80101a9d:	c3                   	ret    

80101a9e <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a9e:	55                   	push   %ebp
80101a9f:	89 e5                	mov    %esp,%ebp
80101aa1:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101aa4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101aa8:	74 20                	je     80101aca <iunlock+0x2c>
80101aaa:	8b 45 08             	mov    0x8(%ebp),%eax
80101aad:	83 c0 0c             	add    $0xc,%eax
80101ab0:	83 ec 0c             	sub    $0xc,%esp
80101ab3:	50                   	push   %eax
80101ab4:	e8 4b 2b 00 00       	call   80104604 <holdingsleep>
80101ab9:	83 c4 10             	add    $0x10,%esp
80101abc:	85 c0                	test   %eax,%eax
80101abe:	74 0a                	je     80101aca <iunlock+0x2c>
80101ac0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac3:	8b 40 08             	mov    0x8(%eax),%eax
80101ac6:	85 c0                	test   %eax,%eax
80101ac8:	7f 0d                	jg     80101ad7 <iunlock+0x39>
    panic("iunlock");
80101aca:	83 ec 0c             	sub    $0xc,%esp
80101acd:	68 c2 9f 10 80       	push   $0x80109fc2
80101ad2:	e8 c8 ea ff ff       	call   8010059f <panic>

  releasesleep(&ip->lock);
80101ad7:	8b 45 08             	mov    0x8(%ebp),%eax
80101ada:	83 c0 0c             	add    $0xc,%eax
80101add:	83 ec 0c             	sub    $0xc,%esp
80101ae0:	50                   	push   %eax
80101ae1:	e8 d0 2a 00 00       	call   801045b6 <releasesleep>
80101ae6:	83 c4 10             	add    $0x10,%esp
}
80101ae9:	90                   	nop
80101aea:	c9                   	leave  
80101aeb:	c3                   	ret    

80101aec <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101aec:	55                   	push   %ebp
80101aed:	89 e5                	mov    %esp,%ebp
80101aef:	83 ec 18             	sub    $0x18,%esp
  acquiresleep(&ip->lock);
80101af2:	8b 45 08             	mov    0x8(%ebp),%eax
80101af5:	83 c0 0c             	add    $0xc,%eax
80101af8:	83 ec 0c             	sub    $0xc,%esp
80101afb:	50                   	push   %eax
80101afc:	e8 51 2a 00 00       	call   80104552 <acquiresleep>
80101b01:	83 c4 10             	add    $0x10,%esp
  if(ip->valid && ip->nlink == 0){
80101b04:	8b 45 08             	mov    0x8(%ebp),%eax
80101b07:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b0a:	85 c0                	test   %eax,%eax
80101b0c:	74 6a                	je     80101b78 <iput+0x8c>
80101b0e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b11:	66 8b 40 56          	mov    0x56(%eax),%ax
80101b15:	66 85 c0             	test   %ax,%ax
80101b18:	75 5e                	jne    80101b78 <iput+0x8c>
    acquire(&icache.lock);
80101b1a:	83 ec 0c             	sub    $0xc,%esp
80101b1d:	68 60 14 19 80       	push   $0x80191460
80101b22:	e8 6e 2b 00 00       	call   80104695 <acquire>
80101b27:	83 c4 10             	add    $0x10,%esp
    int r = ip->ref;
80101b2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b2d:	8b 40 08             	mov    0x8(%eax),%eax
80101b30:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&icache.lock);
80101b33:	83 ec 0c             	sub    $0xc,%esp
80101b36:	68 60 14 19 80       	push   $0x80191460
80101b3b:	e8 c3 2b 00 00       	call   80104703 <release>
80101b40:	83 c4 10             	add    $0x10,%esp
    if(r == 1){
80101b43:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80101b47:	75 2f                	jne    80101b78 <iput+0x8c>
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
80101b49:	83 ec 0c             	sub    $0xc,%esp
80101b4c:	ff 75 08             	pushl  0x8(%ebp)
80101b4f:	e8 ad 01 00 00       	call   80101d01 <itrunc>
80101b54:	83 c4 10             	add    $0x10,%esp
      ip->type = 0;
80101b57:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5a:	66 c7 40 50 00 00    	movw   $0x0,0x50(%eax)
      iupdate(ip);
80101b60:	83 ec 0c             	sub    $0xc,%esp
80101b63:	ff 75 08             	pushl  0x8(%ebp)
80101b66:	e8 48 fc ff ff       	call   801017b3 <iupdate>
80101b6b:	83 c4 10             	add    $0x10,%esp
      ip->valid = 0;
80101b6e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b71:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
    }
  }
  releasesleep(&ip->lock);
80101b78:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7b:	83 c0 0c             	add    $0xc,%eax
80101b7e:	83 ec 0c             	sub    $0xc,%esp
80101b81:	50                   	push   %eax
80101b82:	e8 2f 2a 00 00       	call   801045b6 <releasesleep>
80101b87:	83 c4 10             	add    $0x10,%esp

  acquire(&icache.lock);
80101b8a:	83 ec 0c             	sub    $0xc,%esp
80101b8d:	68 60 14 19 80       	push   $0x80191460
80101b92:	e8 fe 2a 00 00       	call   80104695 <acquire>
80101b97:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
80101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9d:	8b 40 08             	mov    0x8(%eax),%eax
80101ba0:	8d 50 ff             	lea    -0x1(%eax),%edx
80101ba3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba6:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101ba9:	83 ec 0c             	sub    $0xc,%esp
80101bac:	68 60 14 19 80       	push   $0x80191460
80101bb1:	e8 4d 2b 00 00       	call   80104703 <release>
80101bb6:	83 c4 10             	add    $0x10,%esp
}
80101bb9:	90                   	nop
80101bba:	c9                   	leave  
80101bbb:	c3                   	ret    

80101bbc <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101bbc:	55                   	push   %ebp
80101bbd:	89 e5                	mov    %esp,%ebp
80101bbf:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101bc2:	83 ec 0c             	sub    $0xc,%esp
80101bc5:	ff 75 08             	pushl  0x8(%ebp)
80101bc8:	e8 d1 fe ff ff       	call   80101a9e <iunlock>
80101bcd:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101bd0:	83 ec 0c             	sub    $0xc,%esp
80101bd3:	ff 75 08             	pushl  0x8(%ebp)
80101bd6:	e8 11 ff ff ff       	call   80101aec <iput>
80101bdb:	83 c4 10             	add    $0x10,%esp
}
80101bde:	90                   	nop
80101bdf:	c9                   	leave  
80101be0:	c3                   	ret    

80101be1 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101be1:	55                   	push   %ebp
80101be2:	89 e5                	mov    %esp,%ebp
80101be4:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101be7:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101beb:	77 42                	ja     80101c2f <bmap+0x4e>
    if((addr = ip->addrs[bn]) == 0)
80101bed:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf0:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bf3:	83 c2 14             	add    $0x14,%edx
80101bf6:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101bfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bfd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c01:	75 24                	jne    80101c27 <bmap+0x46>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c03:	8b 45 08             	mov    0x8(%ebp),%eax
80101c06:	8b 00                	mov    (%eax),%eax
80101c08:	83 ec 0c             	sub    $0xc,%esp
80101c0b:	50                   	push   %eax
80101c0c:	e8 0a f8 ff ff       	call   8010141b <balloc>
80101c11:	83 c4 10             	add    $0x10,%esp
80101c14:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c17:	8b 45 08             	mov    0x8(%ebp),%eax
80101c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c1d:	8d 4a 14             	lea    0x14(%edx),%ecx
80101c20:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c23:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c2a:	e9 d0 00 00 00       	jmp    80101cff <bmap+0x11e>
  }
  bn -= NDIRECT;
80101c2f:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101c33:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c37:	0f 87 b5 00 00 00    	ja     80101cf2 <bmap+0x111>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101c3d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c40:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101c46:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c49:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c4d:	75 20                	jne    80101c6f <bmap+0x8e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c52:	8b 00                	mov    (%eax),%eax
80101c54:	83 ec 0c             	sub    $0xc,%esp
80101c57:	50                   	push   %eax
80101c58:	e8 be f7 ff ff       	call   8010141b <balloc>
80101c5d:	83 c4 10             	add    $0x10,%esp
80101c60:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c63:	8b 45 08             	mov    0x8(%ebp),%eax
80101c66:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c69:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
80101c6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c72:	8b 00                	mov    (%eax),%eax
80101c74:	83 ec 08             	sub    $0x8,%esp
80101c77:	ff 75 f4             	pushl  -0xc(%ebp)
80101c7a:	50                   	push   %eax
80101c7b:	e8 81 e5 ff ff       	call   80100201 <bread>
80101c80:	83 c4 10             	add    $0x10,%esp
80101c83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101c86:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c89:	83 c0 5c             	add    $0x5c,%eax
80101c8c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101c8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c99:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c9c:	01 d0                	add    %edx,%eax
80101c9e:	8b 00                	mov    (%eax),%eax
80101ca0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ca3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101ca7:	75 36                	jne    80101cdf <bmap+0xfe>
      a[bn] = addr = balloc(ip->dev);
80101ca9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cac:	8b 00                	mov    (%eax),%eax
80101cae:	83 ec 0c             	sub    $0xc,%esp
80101cb1:	50                   	push   %eax
80101cb2:	e8 64 f7 ff ff       	call   8010141b <balloc>
80101cb7:	83 c4 10             	add    $0x10,%esp
80101cba:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cbd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cc0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101cc7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cca:	01 c2                	add    %eax,%edx
80101ccc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ccf:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101cd1:	83 ec 0c             	sub    $0xc,%esp
80101cd4:	ff 75 f0             	pushl  -0x10(%ebp)
80101cd7:	e8 0f 15 00 00       	call   801031eb <log_write>
80101cdc:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101cdf:	83 ec 0c             	sub    $0xc,%esp
80101ce2:	ff 75 f0             	pushl  -0x10(%ebp)
80101ce5:	e8 99 e5 ff ff       	call   80100283 <brelse>
80101cea:	83 c4 10             	add    $0x10,%esp
    return addr;
80101ced:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cf0:	eb 0d                	jmp    80101cff <bmap+0x11e>
  }

  panic("bmap: out of range");
80101cf2:	83 ec 0c             	sub    $0xc,%esp
80101cf5:	68 ca 9f 10 80       	push   $0x80109fca
80101cfa:	e8 a0 e8 ff ff       	call   8010059f <panic>
}
80101cff:	c9                   	leave  
80101d00:	c3                   	ret    

80101d01 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d01:	55                   	push   %ebp
80101d02:	89 e5                	mov    %esp,%ebp
80101d04:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d07:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d0e:	eb 44                	jmp    80101d54 <itrunc+0x53>
    if(ip->addrs[i]){
80101d10:	8b 45 08             	mov    0x8(%ebp),%eax
80101d13:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d16:	83 c2 14             	add    $0x14,%edx
80101d19:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d1d:	85 c0                	test   %eax,%eax
80101d1f:	74 30                	je     80101d51 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101d21:	8b 45 08             	mov    0x8(%ebp),%eax
80101d24:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d27:	83 c2 14             	add    $0x14,%edx
80101d2a:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d2e:	8b 55 08             	mov    0x8(%ebp),%edx
80101d31:	8b 12                	mov    (%edx),%edx
80101d33:	83 ec 08             	sub    $0x8,%esp
80101d36:	50                   	push   %eax
80101d37:	52                   	push   %edx
80101d38:	e8 1a f8 ff ff       	call   80101557 <bfree>
80101d3d:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101d40:	8b 45 08             	mov    0x8(%ebp),%eax
80101d43:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d46:	83 c2 14             	add    $0x14,%edx
80101d49:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d50:	00 
  for(i = 0; i < NDIRECT; i++){
80101d51:	ff 45 f4             	incl   -0xc(%ebp)
80101d54:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d58:	7e b6                	jle    80101d10 <itrunc+0xf>
    }
  }

  if(ip->addrs[NDIRECT]){
80101d5a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d5d:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101d63:	85 c0                	test   %eax,%eax
80101d65:	0f 84 a9 00 00 00    	je     80101e14 <itrunc+0x113>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d6e:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101d74:	8b 45 08             	mov    0x8(%ebp),%eax
80101d77:	8b 00                	mov    (%eax),%eax
80101d79:	83 ec 08             	sub    $0x8,%esp
80101d7c:	52                   	push   %edx
80101d7d:	50                   	push   %eax
80101d7e:	e8 7e e4 ff ff       	call   80100201 <bread>
80101d83:	83 c4 10             	add    $0x10,%esp
80101d86:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101d89:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d8c:	83 c0 5c             	add    $0x5c,%eax
80101d8f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d92:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d99:	eb 3b                	jmp    80101dd6 <itrunc+0xd5>
      if(a[j])
80101d9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d9e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101da5:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101da8:	01 d0                	add    %edx,%eax
80101daa:	8b 00                	mov    (%eax),%eax
80101dac:	85 c0                	test   %eax,%eax
80101dae:	74 23                	je     80101dd3 <itrunc+0xd2>
        bfree(ip->dev, a[j]);
80101db0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101db3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101dba:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101dbd:	01 d0                	add    %edx,%eax
80101dbf:	8b 00                	mov    (%eax),%eax
80101dc1:	8b 55 08             	mov    0x8(%ebp),%edx
80101dc4:	8b 12                	mov    (%edx),%edx
80101dc6:	83 ec 08             	sub    $0x8,%esp
80101dc9:	50                   	push   %eax
80101dca:	52                   	push   %edx
80101dcb:	e8 87 f7 ff ff       	call   80101557 <bfree>
80101dd0:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
80101dd3:	ff 45 f0             	incl   -0x10(%ebp)
80101dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dd9:	83 f8 7f             	cmp    $0x7f,%eax
80101ddc:	76 bd                	jbe    80101d9b <itrunc+0x9a>
    }
    brelse(bp);
80101dde:	83 ec 0c             	sub    $0xc,%esp
80101de1:	ff 75 ec             	pushl  -0x14(%ebp)
80101de4:	e8 9a e4 ff ff       	call   80100283 <brelse>
80101de9:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101dec:	8b 45 08             	mov    0x8(%ebp),%eax
80101def:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101df5:	8b 55 08             	mov    0x8(%ebp),%edx
80101df8:	8b 12                	mov    (%edx),%edx
80101dfa:	83 ec 08             	sub    $0x8,%esp
80101dfd:	50                   	push   %eax
80101dfe:	52                   	push   %edx
80101dff:	e8 53 f7 ff ff       	call   80101557 <bfree>
80101e04:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101e07:	8b 45 08             	mov    0x8(%ebp),%eax
80101e0a:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80101e11:	00 00 00 
  }

  ip->size = 0;
80101e14:	8b 45 08             	mov    0x8(%ebp),%eax
80101e17:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  iupdate(ip);
80101e1e:	83 ec 0c             	sub    $0xc,%esp
80101e21:	ff 75 08             	pushl  0x8(%ebp)
80101e24:	e8 8a f9 ff ff       	call   801017b3 <iupdate>
80101e29:	83 c4 10             	add    $0x10,%esp
}
80101e2c:	90                   	nop
80101e2d:	c9                   	leave  
80101e2e:	c3                   	ret    

80101e2f <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101e2f:	55                   	push   %ebp
80101e30:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101e32:	8b 45 08             	mov    0x8(%ebp),%eax
80101e35:	8b 00                	mov    (%eax),%eax
80101e37:	89 c2                	mov    %eax,%edx
80101e39:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e3c:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101e3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e42:	8b 50 04             	mov    0x4(%eax),%edx
80101e45:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e48:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101e4b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4e:	8b 40 50             	mov    0x50(%eax),%eax
80101e51:	8b 55 0c             	mov    0xc(%ebp),%edx
80101e54:	66 89 02             	mov    %ax,(%edx)
  st->nlink = ip->nlink;
80101e57:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5a:	66 8b 40 56          	mov    0x56(%eax),%ax
80101e5e:	8b 55 0c             	mov    0xc(%ebp),%edx
80101e61:	66 89 42 0c          	mov    %ax,0xc(%edx)
  st->size = ip->size;
80101e65:	8b 45 08             	mov    0x8(%ebp),%eax
80101e68:	8b 50 58             	mov    0x58(%eax),%edx
80101e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e6e:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e71:	90                   	nop
80101e72:	5d                   	pop    %ebp
80101e73:	c3                   	ret    

80101e74 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e74:	55                   	push   %ebp
80101e75:	89 e5                	mov    %esp,%ebp
80101e77:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e7a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e7d:	8b 40 50             	mov    0x50(%eax),%eax
80101e80:	66 83 f8 03          	cmp    $0x3,%ax
80101e84:	75 5c                	jne    80101ee2 <readi+0x6e>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e86:	8b 45 08             	mov    0x8(%ebp),%eax
80101e89:	66 8b 40 52          	mov    0x52(%eax),%ax
80101e8d:	66 85 c0             	test   %ax,%ax
80101e90:	78 20                	js     80101eb2 <readi+0x3e>
80101e92:	8b 45 08             	mov    0x8(%ebp),%eax
80101e95:	66 8b 40 52          	mov    0x52(%eax),%ax
80101e99:	66 83 f8 09          	cmp    $0x9,%ax
80101e9d:	7f 13                	jg     80101eb2 <readi+0x3e>
80101e9f:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea2:	66 8b 40 52          	mov    0x52(%eax),%ax
80101ea6:	98                   	cwtl   
80101ea7:	8b 04 c5 40 0a 19 80 	mov    -0x7fe6f5c0(,%eax,8),%eax
80101eae:	85 c0                	test   %eax,%eax
80101eb0:	75 0a                	jne    80101ebc <readi+0x48>
      return -1;
80101eb2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb7:	e9 11 01 00 00       	jmp    80101fcd <readi+0x159>
    return devsw[ip->major].read(ip, dst, n);
80101ebc:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebf:	66 8b 40 52          	mov    0x52(%eax),%ax
80101ec3:	98                   	cwtl   
80101ec4:	8b 04 c5 40 0a 19 80 	mov    -0x7fe6f5c0(,%eax,8),%eax
80101ecb:	8b 55 14             	mov    0x14(%ebp),%edx
80101ece:	83 ec 04             	sub    $0x4,%esp
80101ed1:	52                   	push   %edx
80101ed2:	ff 75 0c             	pushl  0xc(%ebp)
80101ed5:	ff 75 08             	pushl  0x8(%ebp)
80101ed8:	ff d0                	call   *%eax
80101eda:	83 c4 10             	add    $0x10,%esp
80101edd:	e9 eb 00 00 00       	jmp    80101fcd <readi+0x159>
  }

  if(off > ip->size || off + n < off)
80101ee2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee5:	8b 40 58             	mov    0x58(%eax),%eax
80101ee8:	3b 45 10             	cmp    0x10(%ebp),%eax
80101eeb:	72 0d                	jb     80101efa <readi+0x86>
80101eed:	8b 55 10             	mov    0x10(%ebp),%edx
80101ef0:	8b 45 14             	mov    0x14(%ebp),%eax
80101ef3:	01 d0                	add    %edx,%eax
80101ef5:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ef8:	73 0a                	jae    80101f04 <readi+0x90>
    return -1;
80101efa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eff:	e9 c9 00 00 00       	jmp    80101fcd <readi+0x159>
  if(off + n > ip->size)
80101f04:	8b 55 10             	mov    0x10(%ebp),%edx
80101f07:	8b 45 14             	mov    0x14(%ebp),%eax
80101f0a:	01 c2                	add    %eax,%edx
80101f0c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0f:	8b 40 58             	mov    0x58(%eax),%eax
80101f12:	39 d0                	cmp    %edx,%eax
80101f14:	73 0c                	jae    80101f22 <readi+0xae>
    n = ip->size - off;
80101f16:	8b 45 08             	mov    0x8(%ebp),%eax
80101f19:	8b 40 58             	mov    0x58(%eax),%eax
80101f1c:	2b 45 10             	sub    0x10(%ebp),%eax
80101f1f:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f29:	e9 90 00 00 00       	jmp    80101fbe <readi+0x14a>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f2e:	8b 45 10             	mov    0x10(%ebp),%eax
80101f31:	c1 e8 09             	shr    $0x9,%eax
80101f34:	83 ec 08             	sub    $0x8,%esp
80101f37:	50                   	push   %eax
80101f38:	ff 75 08             	pushl  0x8(%ebp)
80101f3b:	e8 a1 fc ff ff       	call   80101be1 <bmap>
80101f40:	83 c4 10             	add    $0x10,%esp
80101f43:	8b 55 08             	mov    0x8(%ebp),%edx
80101f46:	8b 12                	mov    (%edx),%edx
80101f48:	83 ec 08             	sub    $0x8,%esp
80101f4b:	50                   	push   %eax
80101f4c:	52                   	push   %edx
80101f4d:	e8 af e2 ff ff       	call   80100201 <bread>
80101f52:	83 c4 10             	add    $0x10,%esp
80101f55:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f58:	8b 45 10             	mov    0x10(%ebp),%eax
80101f5b:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f60:	ba 00 02 00 00       	mov    $0x200,%edx
80101f65:	89 d1                	mov    %edx,%ecx
80101f67:	29 c1                	sub    %eax,%ecx
80101f69:	8b 45 14             	mov    0x14(%ebp),%eax
80101f6c:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101f6f:	89 c2                	mov    %eax,%edx
80101f71:	89 c8                	mov    %ecx,%eax
80101f73:	39 c2                	cmp    %eax,%edx
80101f75:	73 02                	jae    80101f79 <readi+0x105>
80101f77:	89 d0                	mov    %edx,%eax
80101f79:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101f7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f7f:	8d 50 5c             	lea    0x5c(%eax),%edx
80101f82:	8b 45 10             	mov    0x10(%ebp),%eax
80101f85:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f8a:	01 d0                	add    %edx,%eax
80101f8c:	83 ec 04             	sub    $0x4,%esp
80101f8f:	ff 75 ec             	pushl  -0x14(%ebp)
80101f92:	50                   	push   %eax
80101f93:	ff 75 0c             	pushl  0xc(%ebp)
80101f96:	e8 23 2a 00 00       	call   801049be <memmove>
80101f9b:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101f9e:	83 ec 0c             	sub    $0xc,%esp
80101fa1:	ff 75 f0             	pushl  -0x10(%ebp)
80101fa4:	e8 da e2 ff ff       	call   80100283 <brelse>
80101fa9:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fac:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101faf:	01 45 f4             	add    %eax,-0xc(%ebp)
80101fb2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fb5:	01 45 10             	add    %eax,0x10(%ebp)
80101fb8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fbb:	01 45 0c             	add    %eax,0xc(%ebp)
80101fbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fc1:	3b 45 14             	cmp    0x14(%ebp),%eax
80101fc4:	0f 82 64 ff ff ff    	jb     80101f2e <readi+0xba>
  }
  return n;
80101fca:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101fcd:	c9                   	leave  
80101fce:	c3                   	ret    

80101fcf <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101fcf:	55                   	push   %ebp
80101fd0:	89 e5                	mov    %esp,%ebp
80101fd2:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fd5:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd8:	8b 40 50             	mov    0x50(%eax),%eax
80101fdb:	66 83 f8 03          	cmp    $0x3,%ax
80101fdf:	75 5c                	jne    8010203d <writei+0x6e>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101fe1:	8b 45 08             	mov    0x8(%ebp),%eax
80101fe4:	66 8b 40 52          	mov    0x52(%eax),%ax
80101fe8:	66 85 c0             	test   %ax,%ax
80101feb:	78 20                	js     8010200d <writei+0x3e>
80101fed:	8b 45 08             	mov    0x8(%ebp),%eax
80101ff0:	66 8b 40 52          	mov    0x52(%eax),%ax
80101ff4:	66 83 f8 09          	cmp    $0x9,%ax
80101ff8:	7f 13                	jg     8010200d <writei+0x3e>
80101ffa:	8b 45 08             	mov    0x8(%ebp),%eax
80101ffd:	66 8b 40 52          	mov    0x52(%eax),%ax
80102001:	98                   	cwtl   
80102002:	8b 04 c5 44 0a 19 80 	mov    -0x7fe6f5bc(,%eax,8),%eax
80102009:	85 c0                	test   %eax,%eax
8010200b:	75 0a                	jne    80102017 <writei+0x48>
      return -1;
8010200d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102012:	e9 42 01 00 00       	jmp    80102159 <writei+0x18a>
    return devsw[ip->major].write(ip, src, n);
80102017:	8b 45 08             	mov    0x8(%ebp),%eax
8010201a:	66 8b 40 52          	mov    0x52(%eax),%ax
8010201e:	98                   	cwtl   
8010201f:	8b 04 c5 44 0a 19 80 	mov    -0x7fe6f5bc(,%eax,8),%eax
80102026:	8b 55 14             	mov    0x14(%ebp),%edx
80102029:	83 ec 04             	sub    $0x4,%esp
8010202c:	52                   	push   %edx
8010202d:	ff 75 0c             	pushl  0xc(%ebp)
80102030:	ff 75 08             	pushl  0x8(%ebp)
80102033:	ff d0                	call   *%eax
80102035:	83 c4 10             	add    $0x10,%esp
80102038:	e9 1c 01 00 00       	jmp    80102159 <writei+0x18a>
  }

  if(off > ip->size || off + n < off)
8010203d:	8b 45 08             	mov    0x8(%ebp),%eax
80102040:	8b 40 58             	mov    0x58(%eax),%eax
80102043:	3b 45 10             	cmp    0x10(%ebp),%eax
80102046:	72 0d                	jb     80102055 <writei+0x86>
80102048:	8b 55 10             	mov    0x10(%ebp),%edx
8010204b:	8b 45 14             	mov    0x14(%ebp),%eax
8010204e:	01 d0                	add    %edx,%eax
80102050:	3b 45 10             	cmp    0x10(%ebp),%eax
80102053:	73 0a                	jae    8010205f <writei+0x90>
    return -1;
80102055:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010205a:	e9 fa 00 00 00       	jmp    80102159 <writei+0x18a>
  if(off + n > MAXFILE*BSIZE)
8010205f:	8b 55 10             	mov    0x10(%ebp),%edx
80102062:	8b 45 14             	mov    0x14(%ebp),%eax
80102065:	01 d0                	add    %edx,%eax
80102067:	3d 00 18 01 00       	cmp    $0x11800,%eax
8010206c:	76 0a                	jbe    80102078 <writei+0xa9>
    return -1;
8010206e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102073:	e9 e1 00 00 00       	jmp    80102159 <writei+0x18a>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102078:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010207f:	e9 9e 00 00 00       	jmp    80102122 <writei+0x153>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102084:	8b 45 10             	mov    0x10(%ebp),%eax
80102087:	c1 e8 09             	shr    $0x9,%eax
8010208a:	83 ec 08             	sub    $0x8,%esp
8010208d:	50                   	push   %eax
8010208e:	ff 75 08             	pushl  0x8(%ebp)
80102091:	e8 4b fb ff ff       	call   80101be1 <bmap>
80102096:	83 c4 10             	add    $0x10,%esp
80102099:	8b 55 08             	mov    0x8(%ebp),%edx
8010209c:	8b 12                	mov    (%edx),%edx
8010209e:	83 ec 08             	sub    $0x8,%esp
801020a1:	50                   	push   %eax
801020a2:	52                   	push   %edx
801020a3:	e8 59 e1 ff ff       	call   80100201 <bread>
801020a8:	83 c4 10             	add    $0x10,%esp
801020ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801020ae:	8b 45 10             	mov    0x10(%ebp),%eax
801020b1:	25 ff 01 00 00       	and    $0x1ff,%eax
801020b6:	ba 00 02 00 00       	mov    $0x200,%edx
801020bb:	89 d1                	mov    %edx,%ecx
801020bd:	29 c1                	sub    %eax,%ecx
801020bf:	8b 45 14             	mov    0x14(%ebp),%eax
801020c2:	2b 45 f4             	sub    -0xc(%ebp),%eax
801020c5:	89 c2                	mov    %eax,%edx
801020c7:	89 c8                	mov    %ecx,%eax
801020c9:	39 c2                	cmp    %eax,%edx
801020cb:	73 02                	jae    801020cf <writei+0x100>
801020cd:	89 d0                	mov    %edx,%eax
801020cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801020d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020d5:	8d 50 5c             	lea    0x5c(%eax),%edx
801020d8:	8b 45 10             	mov    0x10(%ebp),%eax
801020db:	25 ff 01 00 00       	and    $0x1ff,%eax
801020e0:	01 d0                	add    %edx,%eax
801020e2:	83 ec 04             	sub    $0x4,%esp
801020e5:	ff 75 ec             	pushl  -0x14(%ebp)
801020e8:	ff 75 0c             	pushl  0xc(%ebp)
801020eb:	50                   	push   %eax
801020ec:	e8 cd 28 00 00       	call   801049be <memmove>
801020f1:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
801020f4:	83 ec 0c             	sub    $0xc,%esp
801020f7:	ff 75 f0             	pushl  -0x10(%ebp)
801020fa:	e8 ec 10 00 00       	call   801031eb <log_write>
801020ff:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102102:	83 ec 0c             	sub    $0xc,%esp
80102105:	ff 75 f0             	pushl  -0x10(%ebp)
80102108:	e8 76 e1 ff ff       	call   80100283 <brelse>
8010210d:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102110:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102113:	01 45 f4             	add    %eax,-0xc(%ebp)
80102116:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102119:	01 45 10             	add    %eax,0x10(%ebp)
8010211c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010211f:	01 45 0c             	add    %eax,0xc(%ebp)
80102122:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102125:	3b 45 14             	cmp    0x14(%ebp),%eax
80102128:	0f 82 56 ff ff ff    	jb     80102084 <writei+0xb5>
  }

  if(n > 0 && off > ip->size){
8010212e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102132:	74 22                	je     80102156 <writei+0x187>
80102134:	8b 45 08             	mov    0x8(%ebp),%eax
80102137:	8b 40 58             	mov    0x58(%eax),%eax
8010213a:	3b 45 10             	cmp    0x10(%ebp),%eax
8010213d:	73 17                	jae    80102156 <writei+0x187>
    ip->size = off;
8010213f:	8b 45 08             	mov    0x8(%ebp),%eax
80102142:	8b 55 10             	mov    0x10(%ebp),%edx
80102145:	89 50 58             	mov    %edx,0x58(%eax)
    iupdate(ip);
80102148:	83 ec 0c             	sub    $0xc,%esp
8010214b:	ff 75 08             	pushl  0x8(%ebp)
8010214e:	e8 60 f6 ff ff       	call   801017b3 <iupdate>
80102153:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102156:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102159:	c9                   	leave  
8010215a:	c3                   	ret    

8010215b <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010215b:	55                   	push   %ebp
8010215c:	89 e5                	mov    %esp,%ebp
8010215e:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
80102161:	83 ec 04             	sub    $0x4,%esp
80102164:	6a 0e                	push   $0xe
80102166:	ff 75 0c             	pushl  0xc(%ebp)
80102169:	ff 75 08             	pushl  0x8(%ebp)
8010216c:	e8 df 28 00 00       	call   80104a50 <strncmp>
80102171:	83 c4 10             	add    $0x10,%esp
}
80102174:	c9                   	leave  
80102175:	c3                   	ret    

80102176 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102176:	55                   	push   %ebp
80102177:	89 e5                	mov    %esp,%ebp
80102179:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010217c:	8b 45 08             	mov    0x8(%ebp),%eax
8010217f:	8b 40 50             	mov    0x50(%eax),%eax
80102182:	66 83 f8 01          	cmp    $0x1,%ax
80102186:	74 0d                	je     80102195 <dirlookup+0x1f>
    panic("dirlookup not DIR");
80102188:	83 ec 0c             	sub    $0xc,%esp
8010218b:	68 dd 9f 10 80       	push   $0x80109fdd
80102190:	e8 0a e4 ff ff       	call   8010059f <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102195:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010219c:	eb 79                	jmp    80102217 <dirlookup+0xa1>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010219e:	6a 10                	push   $0x10
801021a0:	ff 75 f4             	pushl  -0xc(%ebp)
801021a3:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021a6:	50                   	push   %eax
801021a7:	ff 75 08             	pushl  0x8(%ebp)
801021aa:	e8 c5 fc ff ff       	call   80101e74 <readi>
801021af:	83 c4 10             	add    $0x10,%esp
801021b2:	83 f8 10             	cmp    $0x10,%eax
801021b5:	74 0d                	je     801021c4 <dirlookup+0x4e>
      panic("dirlookup read");
801021b7:	83 ec 0c             	sub    $0xc,%esp
801021ba:	68 ef 9f 10 80       	push   $0x80109fef
801021bf:	e8 db e3 ff ff       	call   8010059f <panic>
    if(de.inum == 0)
801021c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801021c7:	66 85 c0             	test   %ax,%ax
801021ca:	74 46                	je     80102212 <dirlookup+0x9c>
      continue;
    if(namecmp(name, de.name) == 0){
801021cc:	83 ec 08             	sub    $0x8,%esp
801021cf:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021d2:	83 c0 02             	add    $0x2,%eax
801021d5:	50                   	push   %eax
801021d6:	ff 75 0c             	pushl  0xc(%ebp)
801021d9:	e8 7d ff ff ff       	call   8010215b <namecmp>
801021de:	83 c4 10             	add    $0x10,%esp
801021e1:	85 c0                	test   %eax,%eax
801021e3:	75 2e                	jne    80102213 <dirlookup+0x9d>
      // entry matches path element
      if(poff)
801021e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801021e9:	74 08                	je     801021f3 <dirlookup+0x7d>
        *poff = off;
801021eb:	8b 45 10             	mov    0x10(%ebp),%eax
801021ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021f1:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
801021f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801021f6:	0f b7 c0             	movzwl %ax,%eax
801021f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801021fc:	8b 45 08             	mov    0x8(%ebp),%eax
801021ff:	8b 00                	mov    (%eax),%eax
80102201:	83 ec 08             	sub    $0x8,%esp
80102204:	ff 75 f0             	pushl  -0x10(%ebp)
80102207:	50                   	push   %eax
80102208:	e8 65 f6 ff ff       	call   80101872 <iget>
8010220d:	83 c4 10             	add    $0x10,%esp
80102210:	eb 19                	jmp    8010222b <dirlookup+0xb5>
      continue;
80102212:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
80102213:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102217:	8b 45 08             	mov    0x8(%ebp),%eax
8010221a:	8b 40 58             	mov    0x58(%eax),%eax
8010221d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102220:	0f 82 78 ff ff ff    	jb     8010219e <dirlookup+0x28>
    }
  }

  return 0;
80102226:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010222b:	c9                   	leave  
8010222c:	c3                   	ret    

8010222d <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010222d:	55                   	push   %ebp
8010222e:	89 e5                	mov    %esp,%ebp
80102230:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102233:	83 ec 04             	sub    $0x4,%esp
80102236:	6a 00                	push   $0x0
80102238:	ff 75 0c             	pushl  0xc(%ebp)
8010223b:	ff 75 08             	pushl  0x8(%ebp)
8010223e:	e8 33 ff ff ff       	call   80102176 <dirlookup>
80102243:	83 c4 10             	add    $0x10,%esp
80102246:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102249:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010224d:	74 18                	je     80102267 <dirlink+0x3a>
    iput(ip);
8010224f:	83 ec 0c             	sub    $0xc,%esp
80102252:	ff 75 f0             	pushl  -0x10(%ebp)
80102255:	e8 92 f8 ff ff       	call   80101aec <iput>
8010225a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010225d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102262:	e9 9b 00 00 00       	jmp    80102302 <dirlink+0xd5>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102267:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010226e:	eb 38                	jmp    801022a8 <dirlink+0x7b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102270:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102273:	6a 10                	push   $0x10
80102275:	50                   	push   %eax
80102276:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102279:	50                   	push   %eax
8010227a:	ff 75 08             	pushl  0x8(%ebp)
8010227d:	e8 f2 fb ff ff       	call   80101e74 <readi>
80102282:	83 c4 10             	add    $0x10,%esp
80102285:	83 f8 10             	cmp    $0x10,%eax
80102288:	74 0d                	je     80102297 <dirlink+0x6a>
      panic("dirlink read");
8010228a:	83 ec 0c             	sub    $0xc,%esp
8010228d:	68 fe 9f 10 80       	push   $0x80109ffe
80102292:	e8 08 e3 ff ff       	call   8010059f <panic>
    if(de.inum == 0)
80102297:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010229a:	66 85 c0             	test   %ax,%ax
8010229d:	74 18                	je     801022b7 <dirlink+0x8a>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010229f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022a2:	83 c0 10             	add    $0x10,%eax
801022a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801022a8:	8b 45 08             	mov    0x8(%ebp),%eax
801022ab:	8b 40 58             	mov    0x58(%eax),%eax
801022ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
801022b1:	39 c2                	cmp    %eax,%edx
801022b3:	72 bb                	jb     80102270 <dirlink+0x43>
801022b5:	eb 01                	jmp    801022b8 <dirlink+0x8b>
      break;
801022b7:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801022b8:	83 ec 04             	sub    $0x4,%esp
801022bb:	6a 0e                	push   $0xe
801022bd:	ff 75 0c             	pushl  0xc(%ebp)
801022c0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022c3:	83 c0 02             	add    $0x2,%eax
801022c6:	50                   	push   %eax
801022c7:	e8 d2 27 00 00       	call   80104a9e <strncpy>
801022cc:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
801022cf:	8b 45 10             	mov    0x10(%ebp),%eax
801022d2:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d9:	6a 10                	push   $0x10
801022db:	50                   	push   %eax
801022dc:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022df:	50                   	push   %eax
801022e0:	ff 75 08             	pushl  0x8(%ebp)
801022e3:	e8 e7 fc ff ff       	call   80101fcf <writei>
801022e8:	83 c4 10             	add    $0x10,%esp
801022eb:	83 f8 10             	cmp    $0x10,%eax
801022ee:	74 0d                	je     801022fd <dirlink+0xd0>
    panic("dirlink");
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	68 0b a0 10 80       	push   $0x8010a00b
801022f8:	e8 a2 e2 ff ff       	call   8010059f <panic>

  return 0;
801022fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102302:	c9                   	leave  
80102303:	c3                   	ret    

80102304 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102304:	55                   	push   %ebp
80102305:	89 e5                	mov    %esp,%ebp
80102307:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
8010230a:	eb 03                	jmp    8010230f <skipelem+0xb>
    path++;
8010230c:	ff 45 08             	incl   0x8(%ebp)
  while(*path == '/')
8010230f:	8b 45 08             	mov    0x8(%ebp),%eax
80102312:	8a 00                	mov    (%eax),%al
80102314:	3c 2f                	cmp    $0x2f,%al
80102316:	74 f4                	je     8010230c <skipelem+0x8>
  if(*path == 0)
80102318:	8b 45 08             	mov    0x8(%ebp),%eax
8010231b:	8a 00                	mov    (%eax),%al
8010231d:	84 c0                	test   %al,%al
8010231f:	75 07                	jne    80102328 <skipelem+0x24>
    return 0;
80102321:	b8 00 00 00 00       	mov    $0x0,%eax
80102326:	eb 72                	jmp    8010239a <skipelem+0x96>
  s = path;
80102328:	8b 45 08             	mov    0x8(%ebp),%eax
8010232b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
8010232e:	eb 03                	jmp    80102333 <skipelem+0x2f>
    path++;
80102330:	ff 45 08             	incl   0x8(%ebp)
  while(*path != '/' && *path != 0)
80102333:	8b 45 08             	mov    0x8(%ebp),%eax
80102336:	8a 00                	mov    (%eax),%al
80102338:	3c 2f                	cmp    $0x2f,%al
8010233a:	74 09                	je     80102345 <skipelem+0x41>
8010233c:	8b 45 08             	mov    0x8(%ebp),%eax
8010233f:	8a 00                	mov    (%eax),%al
80102341:	84 c0                	test   %al,%al
80102343:	75 eb                	jne    80102330 <skipelem+0x2c>
  len = path - s;
80102345:	8b 45 08             	mov    0x8(%ebp),%eax
80102348:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010234b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
8010234e:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102352:	7e 15                	jle    80102369 <skipelem+0x65>
    memmove(name, s, DIRSIZ);
80102354:	83 ec 04             	sub    $0x4,%esp
80102357:	6a 0e                	push   $0xe
80102359:	ff 75 f4             	pushl  -0xc(%ebp)
8010235c:	ff 75 0c             	pushl  0xc(%ebp)
8010235f:	e8 5a 26 00 00       	call   801049be <memmove>
80102364:	83 c4 10             	add    $0x10,%esp
80102367:	eb 25                	jmp    8010238e <skipelem+0x8a>
  else {
    memmove(name, s, len);
80102369:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010236c:	83 ec 04             	sub    $0x4,%esp
8010236f:	50                   	push   %eax
80102370:	ff 75 f4             	pushl  -0xc(%ebp)
80102373:	ff 75 0c             	pushl  0xc(%ebp)
80102376:	e8 43 26 00 00       	call   801049be <memmove>
8010237b:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
8010237e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102381:	8b 45 0c             	mov    0xc(%ebp),%eax
80102384:	01 d0                	add    %edx,%eax
80102386:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102389:	eb 03                	jmp    8010238e <skipelem+0x8a>
    path++;
8010238b:	ff 45 08             	incl   0x8(%ebp)
  while(*path == '/')
8010238e:	8b 45 08             	mov    0x8(%ebp),%eax
80102391:	8a 00                	mov    (%eax),%al
80102393:	3c 2f                	cmp    $0x2f,%al
80102395:	74 f4                	je     8010238b <skipelem+0x87>
  return path;
80102397:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010239a:	c9                   	leave  
8010239b:	c3                   	ret    

8010239c <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
8010239c:	55                   	push   %ebp
8010239d:	89 e5                	mov    %esp,%ebp
8010239f:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
801023a2:	8b 45 08             	mov    0x8(%ebp),%eax
801023a5:	8a 00                	mov    (%eax),%al
801023a7:	3c 2f                	cmp    $0x2f,%al
801023a9:	75 17                	jne    801023c2 <namex+0x26>
    ip = iget(ROOTDEV, ROOTINO);
801023ab:	83 ec 08             	sub    $0x8,%esp
801023ae:	6a 01                	push   $0x1
801023b0:	6a 01                	push   $0x1
801023b2:	e8 bb f4 ff ff       	call   80101872 <iget>
801023b7:	83 c4 10             	add    $0x10,%esp
801023ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023bd:	e9 b8 00 00 00       	jmp    8010247a <namex+0xde>
  else
    ip = idup(myproc()->cwd);
801023c2:	e8 0f 16 00 00       	call   801039d6 <myproc>
801023c7:	8b 40 68             	mov    0x68(%eax),%eax
801023ca:	83 ec 0c             	sub    $0xc,%esp
801023cd:	50                   	push   %eax
801023ce:	e8 81 f5 ff ff       	call   80101954 <idup>
801023d3:	83 c4 10             	add    $0x10,%esp
801023d6:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
801023d9:	e9 9c 00 00 00       	jmp    8010247a <namex+0xde>
    ilock(ip);
801023de:	83 ec 0c             	sub    $0xc,%esp
801023e1:	ff 75 f4             	pushl  -0xc(%ebp)
801023e4:	e8 a5 f5 ff ff       	call   8010198e <ilock>
801023e9:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
801023ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023ef:	8b 40 50             	mov    0x50(%eax),%eax
801023f2:	66 83 f8 01          	cmp    $0x1,%ax
801023f6:	74 18                	je     80102410 <namex+0x74>
      iunlockput(ip);
801023f8:	83 ec 0c             	sub    $0xc,%esp
801023fb:	ff 75 f4             	pushl  -0xc(%ebp)
801023fe:	e8 b9 f7 ff ff       	call   80101bbc <iunlockput>
80102403:	83 c4 10             	add    $0x10,%esp
      return 0;
80102406:	b8 00 00 00 00       	mov    $0x0,%eax
8010240b:	e9 a6 00 00 00       	jmp    801024b6 <namex+0x11a>
    }
    if(nameiparent && *path == '\0'){
80102410:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102414:	74 1f                	je     80102435 <namex+0x99>
80102416:	8b 45 08             	mov    0x8(%ebp),%eax
80102419:	8a 00                	mov    (%eax),%al
8010241b:	84 c0                	test   %al,%al
8010241d:	75 16                	jne    80102435 <namex+0x99>
      // Stop one level early.
      iunlock(ip);
8010241f:	83 ec 0c             	sub    $0xc,%esp
80102422:	ff 75 f4             	pushl  -0xc(%ebp)
80102425:	e8 74 f6 ff ff       	call   80101a9e <iunlock>
8010242a:	83 c4 10             	add    $0x10,%esp
      return ip;
8010242d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102430:	e9 81 00 00 00       	jmp    801024b6 <namex+0x11a>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102435:	83 ec 04             	sub    $0x4,%esp
80102438:	6a 00                	push   $0x0
8010243a:	ff 75 10             	pushl  0x10(%ebp)
8010243d:	ff 75 f4             	pushl  -0xc(%ebp)
80102440:	e8 31 fd ff ff       	call   80102176 <dirlookup>
80102445:	83 c4 10             	add    $0x10,%esp
80102448:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010244b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010244f:	75 15                	jne    80102466 <namex+0xca>
      iunlockput(ip);
80102451:	83 ec 0c             	sub    $0xc,%esp
80102454:	ff 75 f4             	pushl  -0xc(%ebp)
80102457:	e8 60 f7 ff ff       	call   80101bbc <iunlockput>
8010245c:	83 c4 10             	add    $0x10,%esp
      return 0;
8010245f:	b8 00 00 00 00       	mov    $0x0,%eax
80102464:	eb 50                	jmp    801024b6 <namex+0x11a>
    }
    iunlockput(ip);
80102466:	83 ec 0c             	sub    $0xc,%esp
80102469:	ff 75 f4             	pushl  -0xc(%ebp)
8010246c:	e8 4b f7 ff ff       	call   80101bbc <iunlockput>
80102471:	83 c4 10             	add    $0x10,%esp
    ip = next;
80102474:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102477:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
8010247a:	83 ec 08             	sub    $0x8,%esp
8010247d:	ff 75 10             	pushl  0x10(%ebp)
80102480:	ff 75 08             	pushl  0x8(%ebp)
80102483:	e8 7c fe ff ff       	call   80102304 <skipelem>
80102488:	83 c4 10             	add    $0x10,%esp
8010248b:	89 45 08             	mov    %eax,0x8(%ebp)
8010248e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102492:	0f 85 46 ff ff ff    	jne    801023de <namex+0x42>
  }
  if(nameiparent){
80102498:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010249c:	74 15                	je     801024b3 <namex+0x117>
    iput(ip);
8010249e:	83 ec 0c             	sub    $0xc,%esp
801024a1:	ff 75 f4             	pushl  -0xc(%ebp)
801024a4:	e8 43 f6 ff ff       	call   80101aec <iput>
801024a9:	83 c4 10             	add    $0x10,%esp
    return 0;
801024ac:	b8 00 00 00 00       	mov    $0x0,%eax
801024b1:	eb 03                	jmp    801024b6 <namex+0x11a>
  }
  return ip;
801024b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801024b6:	c9                   	leave  
801024b7:	c3                   	ret    

801024b8 <namei>:

struct inode*
namei(char *path)
{
801024b8:	55                   	push   %ebp
801024b9:	89 e5                	mov    %esp,%ebp
801024bb:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801024be:	83 ec 04             	sub    $0x4,%esp
801024c1:	8d 45 ea             	lea    -0x16(%ebp),%eax
801024c4:	50                   	push   %eax
801024c5:	6a 00                	push   $0x0
801024c7:	ff 75 08             	pushl  0x8(%ebp)
801024ca:	e8 cd fe ff ff       	call   8010239c <namex>
801024cf:	83 c4 10             	add    $0x10,%esp
}
801024d2:	c9                   	leave  
801024d3:	c3                   	ret    

801024d4 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801024d4:	55                   	push   %ebp
801024d5:	89 e5                	mov    %esp,%ebp
801024d7:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
801024da:	83 ec 04             	sub    $0x4,%esp
801024dd:	ff 75 0c             	pushl  0xc(%ebp)
801024e0:	6a 01                	push   $0x1
801024e2:	ff 75 08             	pushl  0x8(%ebp)
801024e5:	e8 b2 fe ff ff       	call   8010239c <namex>
801024ea:	83 c4 10             	add    $0x10,%esp
}
801024ed:	c9                   	leave  
801024ee:	c3                   	ret    

801024ef <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
801024ef:	55                   	push   %ebp
801024f0:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801024f2:	a1 b4 30 19 80       	mov    0x801930b4,%eax
801024f7:	8b 55 08             	mov    0x8(%ebp),%edx
801024fa:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
801024fc:	a1 b4 30 19 80       	mov    0x801930b4,%eax
80102501:	8b 40 10             	mov    0x10(%eax),%eax
}
80102504:	5d                   	pop    %ebp
80102505:	c3                   	ret    

80102506 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102506:	55                   	push   %ebp
80102507:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102509:	a1 b4 30 19 80       	mov    0x801930b4,%eax
8010250e:	8b 55 08             	mov    0x8(%ebp),%edx
80102511:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102513:	a1 b4 30 19 80       	mov    0x801930b4,%eax
80102518:	8b 55 0c             	mov    0xc(%ebp),%edx
8010251b:	89 50 10             	mov    %edx,0x10(%eax)
}
8010251e:	90                   	nop
8010251f:	5d                   	pop    %ebp
80102520:	c3                   	ret    

80102521 <ioapicinit>:

void
ioapicinit(void)
{
80102521:	55                   	push   %ebp
80102522:	89 e5                	mov    %esp,%ebp
80102524:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102527:	c7 05 b4 30 19 80 00 	movl   $0xfec00000,0x801930b4
8010252e:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102531:	6a 01                	push   $0x1
80102533:	e8 b7 ff ff ff       	call   801024ef <ioapicread>
80102538:	83 c4 04             	add    $0x4,%esp
8010253b:	c1 e8 10             	shr    $0x10,%eax
8010253e:	25 ff 00 00 00       	and    $0xff,%eax
80102543:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102546:	6a 00                	push   $0x0
80102548:	e8 a2 ff ff ff       	call   801024ef <ioapicread>
8010254d:	83 c4 04             	add    $0x4,%esp
80102550:	c1 e8 18             	shr    $0x18,%eax
80102553:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102556:	a0 44 5c 19 80       	mov    0x80195c44,%al
8010255b:	0f b6 c0             	movzbl %al,%eax
8010255e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80102561:	74 10                	je     80102573 <ioapicinit+0x52>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102563:	83 ec 0c             	sub    $0xc,%esp
80102566:	68 14 a0 10 80       	push   $0x8010a014
8010256b:	e8 81 de ff ff       	call   801003f1 <cprintf>
80102570:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102573:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010257a:	eb 3c                	jmp    801025b8 <ioapicinit+0x97>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010257c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010257f:	83 c0 20             	add    $0x20,%eax
80102582:	0d 00 00 01 00       	or     $0x10000,%eax
80102587:	89 c2                	mov    %eax,%edx
80102589:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010258c:	83 c0 08             	add    $0x8,%eax
8010258f:	01 c0                	add    %eax,%eax
80102591:	83 ec 08             	sub    $0x8,%esp
80102594:	52                   	push   %edx
80102595:	50                   	push   %eax
80102596:	e8 6b ff ff ff       	call   80102506 <ioapicwrite>
8010259b:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
8010259e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801025a1:	83 c0 08             	add    $0x8,%eax
801025a4:	01 c0                	add    %eax,%eax
801025a6:	40                   	inc    %eax
801025a7:	83 ec 08             	sub    $0x8,%esp
801025aa:	6a 00                	push   $0x0
801025ac:	50                   	push   %eax
801025ad:	e8 54 ff ff ff       	call   80102506 <ioapicwrite>
801025b2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
801025b5:	ff 45 f4             	incl   -0xc(%ebp)
801025b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801025bb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801025be:	7e bc                	jle    8010257c <ioapicinit+0x5b>
  }
}
801025c0:	90                   	nop
801025c1:	90                   	nop
801025c2:	c9                   	leave  
801025c3:	c3                   	ret    

801025c4 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801025c4:	55                   	push   %ebp
801025c5:	89 e5                	mov    %esp,%ebp
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801025c7:	8b 45 08             	mov    0x8(%ebp),%eax
801025ca:	83 c0 20             	add    $0x20,%eax
801025cd:	89 c2                	mov    %eax,%edx
801025cf:	8b 45 08             	mov    0x8(%ebp),%eax
801025d2:	83 c0 08             	add    $0x8,%eax
801025d5:	01 c0                	add    %eax,%eax
801025d7:	52                   	push   %edx
801025d8:	50                   	push   %eax
801025d9:	e8 28 ff ff ff       	call   80102506 <ioapicwrite>
801025de:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801025e4:	c1 e0 18             	shl    $0x18,%eax
801025e7:	89 c2                	mov    %eax,%edx
801025e9:	8b 45 08             	mov    0x8(%ebp),%eax
801025ec:	83 c0 08             	add    $0x8,%eax
801025ef:	01 c0                	add    %eax,%eax
801025f1:	40                   	inc    %eax
801025f2:	52                   	push   %edx
801025f3:	50                   	push   %eax
801025f4:	e8 0d ff ff ff       	call   80102506 <ioapicwrite>
801025f9:	83 c4 08             	add    $0x8,%esp
}
801025fc:	90                   	nop
801025fd:	c9                   	leave  
801025fe:	c3                   	ret    

801025ff <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801025ff:	55                   	push   %ebp
80102600:	89 e5                	mov    %esp,%ebp
80102602:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102605:	83 ec 08             	sub    $0x8,%esp
80102608:	68 46 a0 10 80       	push   $0x8010a046
8010260d:	68 c0 30 19 80       	push   $0x801930c0
80102612:	e8 5c 20 00 00       	call   80104673 <initlock>
80102617:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
8010261a:	c7 05 f4 30 19 80 00 	movl   $0x0,0x801930f4
80102621:	00 00 00 
  freerange(vstart, vend);
80102624:	83 ec 08             	sub    $0x8,%esp
80102627:	ff 75 0c             	pushl  0xc(%ebp)
8010262a:	ff 75 08             	pushl  0x8(%ebp)
8010262d:	e8 2a 00 00 00       	call   8010265c <freerange>
80102632:	83 c4 10             	add    $0x10,%esp
}
80102635:	90                   	nop
80102636:	c9                   	leave  
80102637:	c3                   	ret    

80102638 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102638:	55                   	push   %ebp
80102639:	89 e5                	mov    %esp,%ebp
8010263b:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
8010263e:	83 ec 08             	sub    $0x8,%esp
80102641:	ff 75 0c             	pushl  0xc(%ebp)
80102644:	ff 75 08             	pushl  0x8(%ebp)
80102647:	e8 10 00 00 00       	call   8010265c <freerange>
8010264c:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
8010264f:	c7 05 f4 30 19 80 01 	movl   $0x1,0x801930f4
80102656:	00 00 00 
}
80102659:	90                   	nop
8010265a:	c9                   	leave  
8010265b:	c3                   	ret    

8010265c <freerange>:

void
freerange(void *vstart, void *vend)
{
8010265c:	55                   	push   %ebp
8010265d:	89 e5                	mov    %esp,%ebp
8010265f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102662:	8b 45 08             	mov    0x8(%ebp),%eax
80102665:	05 ff 0f 00 00       	add    $0xfff,%eax
8010266a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010266f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102672:	eb 15                	jmp    80102689 <freerange+0x2d>
    kfree(p);
80102674:	83 ec 0c             	sub    $0xc,%esp
80102677:	ff 75 f4             	pushl  -0xc(%ebp)
8010267a:	e8 1b 00 00 00       	call   8010269a <kfree>
8010267f:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102682:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102689:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010268c:	05 00 10 00 00       	add    $0x1000,%eax
80102691:	39 45 0c             	cmp    %eax,0xc(%ebp)
80102694:	73 de                	jae    80102674 <freerange+0x18>
}
80102696:	90                   	nop
80102697:	90                   	nop
80102698:	c9                   	leave  
80102699:	c3                   	ret    

8010269a <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
8010269a:	55                   	push   %ebp
8010269b:	89 e5                	mov    %esp,%ebp
8010269d:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801026a0:	8b 45 08             	mov    0x8(%ebp),%eax
801026a3:	25 ff 0f 00 00       	and    $0xfff,%eax
801026a8:	85 c0                	test   %eax,%eax
801026aa:	75 18                	jne    801026c4 <kfree+0x2a>
801026ac:	81 7d 08 00 70 19 80 	cmpl   $0x80197000,0x8(%ebp)
801026b3:	72 0f                	jb     801026c4 <kfree+0x2a>
801026b5:	8b 45 08             	mov    0x8(%ebp),%eax
801026b8:	05 00 00 00 80       	add    $0x80000000,%eax
801026bd:	3d ff ff ff 1f       	cmp    $0x1fffffff,%eax
801026c2:	76 0d                	jbe    801026d1 <kfree+0x37>
    panic("kfree");
801026c4:	83 ec 0c             	sub    $0xc,%esp
801026c7:	68 4b a0 10 80       	push   $0x8010a04b
801026cc:	e8 ce de ff ff       	call   8010059f <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801026d1:	83 ec 04             	sub    $0x4,%esp
801026d4:	68 00 10 00 00       	push   $0x1000
801026d9:	6a 01                	push   $0x1
801026db:	ff 75 08             	pushl  0x8(%ebp)
801026de:	e8 22 22 00 00       	call   80104905 <memset>
801026e3:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
801026e6:	a1 f4 30 19 80       	mov    0x801930f4,%eax
801026eb:	85 c0                	test   %eax,%eax
801026ed:	74 10                	je     801026ff <kfree+0x65>
    acquire(&kmem.lock);
801026ef:	83 ec 0c             	sub    $0xc,%esp
801026f2:	68 c0 30 19 80       	push   $0x801930c0
801026f7:	e8 99 1f 00 00       	call   80104695 <acquire>
801026fc:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
801026ff:	8b 45 08             	mov    0x8(%ebp),%eax
80102702:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102705:	8b 15 f8 30 19 80    	mov    0x801930f8,%edx
8010270b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010270e:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102710:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102713:	a3 f8 30 19 80       	mov    %eax,0x801930f8
  if(kmem.use_lock)
80102718:	a1 f4 30 19 80       	mov    0x801930f4,%eax
8010271d:	85 c0                	test   %eax,%eax
8010271f:	74 10                	je     80102731 <kfree+0x97>
    release(&kmem.lock);
80102721:	83 ec 0c             	sub    $0xc,%esp
80102724:	68 c0 30 19 80       	push   $0x801930c0
80102729:	e8 d5 1f 00 00       	call   80104703 <release>
8010272e:	83 c4 10             	add    $0x10,%esp
}
80102731:	90                   	nop
80102732:	c9                   	leave  
80102733:	c3                   	ret    

80102734 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102734:	55                   	push   %ebp
80102735:	89 e5                	mov    %esp,%ebp
80102737:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
8010273a:	a1 f4 30 19 80       	mov    0x801930f4,%eax
8010273f:	85 c0                	test   %eax,%eax
80102741:	74 10                	je     80102753 <kalloc+0x1f>
    acquire(&kmem.lock);
80102743:	83 ec 0c             	sub    $0xc,%esp
80102746:	68 c0 30 19 80       	push   $0x801930c0
8010274b:	e8 45 1f 00 00       	call   80104695 <acquire>
80102750:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102753:	a1 f8 30 19 80       	mov    0x801930f8,%eax
80102758:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
8010275b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010275f:	74 0a                	je     8010276b <kalloc+0x37>
    kmem.freelist = r->next;
80102761:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102764:	8b 00                	mov    (%eax),%eax
80102766:	a3 f8 30 19 80       	mov    %eax,0x801930f8
  if(kmem.use_lock)
8010276b:	a1 f4 30 19 80       	mov    0x801930f4,%eax
80102770:	85 c0                	test   %eax,%eax
80102772:	74 10                	je     80102784 <kalloc+0x50>
    release(&kmem.lock);
80102774:	83 ec 0c             	sub    $0xc,%esp
80102777:	68 c0 30 19 80       	push   $0x801930c0
8010277c:	e8 82 1f 00 00       	call   80104703 <release>
80102781:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102784:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102787:	c9                   	leave  
80102788:	c3                   	ret    

80102789 <inb>:
{
80102789:	55                   	push   %ebp
8010278a:	89 e5                	mov    %esp,%ebp
8010278c:	83 ec 14             	sub    $0x14,%esp
8010278f:	8b 45 08             	mov    0x8(%ebp),%eax
80102792:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102796:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102799:	89 c2                	mov    %eax,%edx
8010279b:	ec                   	in     (%dx),%al
8010279c:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010279f:	8a 45 ff             	mov    -0x1(%ebp),%al
}
801027a2:	c9                   	leave  
801027a3:	c3                   	ret    

801027a4 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801027a4:	55                   	push   %ebp
801027a5:	89 e5                	mov    %esp,%ebp
801027a7:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
801027aa:	6a 64                	push   $0x64
801027ac:	e8 d8 ff ff ff       	call   80102789 <inb>
801027b1:	83 c4 04             	add    $0x4,%esp
801027b4:	0f b6 c0             	movzbl %al,%eax
801027b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
801027ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027bd:	83 e0 01             	and    $0x1,%eax
801027c0:	85 c0                	test   %eax,%eax
801027c2:	75 0a                	jne    801027ce <kbdgetc+0x2a>
    return -1;
801027c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801027c9:	e9 1f 01 00 00       	jmp    801028ed <kbdgetc+0x149>
  data = inb(KBDATAP);
801027ce:	6a 60                	push   $0x60
801027d0:	e8 b4 ff ff ff       	call   80102789 <inb>
801027d5:	83 c4 04             	add    $0x4,%esp
801027d8:	0f b6 c0             	movzbl %al,%eax
801027db:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
801027de:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
801027e5:	75 17                	jne    801027fe <kbdgetc+0x5a>
    shift |= E0ESC;
801027e7:	a1 fc 30 19 80       	mov    0x801930fc,%eax
801027ec:	83 c8 40             	or     $0x40,%eax
801027ef:	a3 fc 30 19 80       	mov    %eax,0x801930fc
    return 0;
801027f4:	b8 00 00 00 00       	mov    $0x0,%eax
801027f9:	e9 ef 00 00 00       	jmp    801028ed <kbdgetc+0x149>
  } else if(data & 0x80){
801027fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102801:	25 80 00 00 00       	and    $0x80,%eax
80102806:	85 c0                	test   %eax,%eax
80102808:	74 44                	je     8010284e <kbdgetc+0xaa>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010280a:	a1 fc 30 19 80       	mov    0x801930fc,%eax
8010280f:	83 e0 40             	and    $0x40,%eax
80102812:	85 c0                	test   %eax,%eax
80102814:	75 08                	jne    8010281e <kbdgetc+0x7a>
80102816:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102819:	83 e0 7f             	and    $0x7f,%eax
8010281c:	eb 03                	jmp    80102821 <kbdgetc+0x7d>
8010281e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102821:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102824:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102827:	05 20 c0 10 80       	add    $0x8010c020,%eax
8010282c:	8a 00                	mov    (%eax),%al
8010282e:	83 c8 40             	or     $0x40,%eax
80102831:	0f b6 c0             	movzbl %al,%eax
80102834:	f7 d0                	not    %eax
80102836:	89 c2                	mov    %eax,%edx
80102838:	a1 fc 30 19 80       	mov    0x801930fc,%eax
8010283d:	21 d0                	and    %edx,%eax
8010283f:	a3 fc 30 19 80       	mov    %eax,0x801930fc
    return 0;
80102844:	b8 00 00 00 00       	mov    $0x0,%eax
80102849:	e9 9f 00 00 00       	jmp    801028ed <kbdgetc+0x149>
  } else if(shift & E0ESC){
8010284e:	a1 fc 30 19 80       	mov    0x801930fc,%eax
80102853:	83 e0 40             	and    $0x40,%eax
80102856:	85 c0                	test   %eax,%eax
80102858:	74 14                	je     8010286e <kbdgetc+0xca>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010285a:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102861:	a1 fc 30 19 80       	mov    0x801930fc,%eax
80102866:	83 e0 bf             	and    $0xffffffbf,%eax
80102869:	a3 fc 30 19 80       	mov    %eax,0x801930fc
  }

  shift |= shiftcode[data];
8010286e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102871:	05 20 c0 10 80       	add    $0x8010c020,%eax
80102876:	8a 00                	mov    (%eax),%al
80102878:	0f b6 d0             	movzbl %al,%edx
8010287b:	a1 fc 30 19 80       	mov    0x801930fc,%eax
80102880:	09 d0                	or     %edx,%eax
80102882:	a3 fc 30 19 80       	mov    %eax,0x801930fc
  shift ^= togglecode[data];
80102887:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010288a:	05 20 c1 10 80       	add    $0x8010c120,%eax
8010288f:	8a 00                	mov    (%eax),%al
80102891:	0f b6 d0             	movzbl %al,%edx
80102894:	a1 fc 30 19 80       	mov    0x801930fc,%eax
80102899:	31 d0                	xor    %edx,%eax
8010289b:	a3 fc 30 19 80       	mov    %eax,0x801930fc
  c = charcode[shift & (CTL | SHIFT)][data];
801028a0:	a1 fc 30 19 80       	mov    0x801930fc,%eax
801028a5:	83 e0 03             	and    $0x3,%eax
801028a8:	8b 14 85 20 c5 10 80 	mov    -0x7fef3ae0(,%eax,4),%edx
801028af:	8b 45 fc             	mov    -0x4(%ebp),%eax
801028b2:	01 d0                	add    %edx,%eax
801028b4:	8a 00                	mov    (%eax),%al
801028b6:	0f b6 c0             	movzbl %al,%eax
801028b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
801028bc:	a1 fc 30 19 80       	mov    0x801930fc,%eax
801028c1:	83 e0 08             	and    $0x8,%eax
801028c4:	85 c0                	test   %eax,%eax
801028c6:	74 22                	je     801028ea <kbdgetc+0x146>
    if('a' <= c && c <= 'z')
801028c8:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
801028cc:	76 0c                	jbe    801028da <kbdgetc+0x136>
801028ce:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
801028d2:	77 06                	ja     801028da <kbdgetc+0x136>
      c += 'A' - 'a';
801028d4:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
801028d8:	eb 10                	jmp    801028ea <kbdgetc+0x146>
    else if('A' <= c && c <= 'Z')
801028da:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
801028de:	76 0a                	jbe    801028ea <kbdgetc+0x146>
801028e0:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
801028e4:	77 04                	ja     801028ea <kbdgetc+0x146>
      c += 'a' - 'A';
801028e6:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
801028ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801028ed:	c9                   	leave  
801028ee:	c3                   	ret    

801028ef <kbdintr>:

void
kbdintr(void)
{
801028ef:	55                   	push   %ebp
801028f0:	89 e5                	mov    %esp,%ebp
801028f2:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
801028f5:	83 ec 0c             	sub    $0xc,%esp
801028f8:	68 a4 27 10 80       	push   $0x801027a4
801028fd:	e8 b1 de ff ff       	call   801007b3 <consoleintr>
80102902:	83 c4 10             	add    $0x10,%esp
}
80102905:	90                   	nop
80102906:	c9                   	leave  
80102907:	c3                   	ret    

80102908 <inb>:
{
80102908:	55                   	push   %ebp
80102909:	89 e5                	mov    %esp,%ebp
8010290b:	83 ec 14             	sub    $0x14,%esp
8010290e:	8b 45 08             	mov    0x8(%ebp),%eax
80102911:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102915:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102918:	89 c2                	mov    %eax,%edx
8010291a:	ec                   	in     (%dx),%al
8010291b:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010291e:	8a 45 ff             	mov    -0x1(%ebp),%al
}
80102921:	c9                   	leave  
80102922:	c3                   	ret    

80102923 <outb>:
{
80102923:	55                   	push   %ebp
80102924:	89 e5                	mov    %esp,%ebp
80102926:	83 ec 08             	sub    $0x8,%esp
80102929:	8b 45 08             	mov    0x8(%ebp),%eax
8010292c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010292f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80102933:	88 d0                	mov    %dl,%al
80102935:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102938:	8a 45 f8             	mov    -0x8(%ebp),%al
8010293b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010293e:	ee                   	out    %al,(%dx)
}
8010293f:	90                   	nop
80102940:	c9                   	leave  
80102941:	c3                   	ret    

80102942 <lapicw>:
volatile uint *lapic;  // Initialized in mp.c

//PAGEBREAK!
static void
lapicw(int index, int value)
{
80102942:	55                   	push   %ebp
80102943:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102945:	a1 00 31 19 80       	mov    0x80193100,%eax
8010294a:	8b 55 08             	mov    0x8(%ebp),%edx
8010294d:	c1 e2 02             	shl    $0x2,%edx
80102950:	01 c2                	add    %eax,%edx
80102952:	8b 45 0c             	mov    0xc(%ebp),%eax
80102955:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102957:	a1 00 31 19 80       	mov    0x80193100,%eax
8010295c:	83 c0 20             	add    $0x20,%eax
8010295f:	8b 00                	mov    (%eax),%eax
}
80102961:	90                   	nop
80102962:	5d                   	pop    %ebp
80102963:	c3                   	ret    

80102964 <lapicinit>:

void
lapicinit(void)
{
80102964:	55                   	push   %ebp
80102965:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102967:	a1 00 31 19 80       	mov    0x80193100,%eax
8010296c:	85 c0                	test   %eax,%eax
8010296e:	0f 84 0c 01 00 00    	je     80102a80 <lapicinit+0x11c>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102974:	68 3f 01 00 00       	push   $0x13f
80102979:	6a 3c                	push   $0x3c
8010297b:	e8 c2 ff ff ff       	call   80102942 <lapicw>
80102980:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102983:	6a 0b                	push   $0xb
80102985:	68 f8 00 00 00       	push   $0xf8
8010298a:	e8 b3 ff ff ff       	call   80102942 <lapicw>
8010298f:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102992:	68 20 00 02 00       	push   $0x20020
80102997:	68 c8 00 00 00       	push   $0xc8
8010299c:	e8 a1 ff ff ff       	call   80102942 <lapicw>
801029a1:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
801029a4:	68 80 96 98 00       	push   $0x989680
801029a9:	68 e0 00 00 00       	push   $0xe0
801029ae:	e8 8f ff ff ff       	call   80102942 <lapicw>
801029b3:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
801029b6:	68 00 00 01 00       	push   $0x10000
801029bb:	68 d4 00 00 00       	push   $0xd4
801029c0:	e8 7d ff ff ff       	call   80102942 <lapicw>
801029c5:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
801029c8:	68 00 00 01 00       	push   $0x10000
801029cd:	68 d8 00 00 00       	push   $0xd8
801029d2:	e8 6b ff ff ff       	call   80102942 <lapicw>
801029d7:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801029da:	a1 00 31 19 80       	mov    0x80193100,%eax
801029df:	83 c0 30             	add    $0x30,%eax
801029e2:	8b 00                	mov    (%eax),%eax
801029e4:	c1 e8 10             	shr    $0x10,%eax
801029e7:	25 fc 00 00 00       	and    $0xfc,%eax
801029ec:	85 c0                	test   %eax,%eax
801029ee:	74 12                	je     80102a02 <lapicinit+0x9e>
    lapicw(PCINT, MASKED);
801029f0:	68 00 00 01 00       	push   $0x10000
801029f5:	68 d0 00 00 00       	push   $0xd0
801029fa:	e8 43 ff ff ff       	call   80102942 <lapicw>
801029ff:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102a02:	6a 33                	push   $0x33
80102a04:	68 dc 00 00 00       	push   $0xdc
80102a09:	e8 34 ff ff ff       	call   80102942 <lapicw>
80102a0e:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102a11:	6a 00                	push   $0x0
80102a13:	68 a0 00 00 00       	push   $0xa0
80102a18:	e8 25 ff ff ff       	call   80102942 <lapicw>
80102a1d:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102a20:	6a 00                	push   $0x0
80102a22:	68 a0 00 00 00       	push   $0xa0
80102a27:	e8 16 ff ff ff       	call   80102942 <lapicw>
80102a2c:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102a2f:	6a 00                	push   $0x0
80102a31:	6a 2c                	push   $0x2c
80102a33:	e8 0a ff ff ff       	call   80102942 <lapicw>
80102a38:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102a3b:	6a 00                	push   $0x0
80102a3d:	68 c4 00 00 00       	push   $0xc4
80102a42:	e8 fb fe ff ff       	call   80102942 <lapicw>
80102a47:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102a4a:	68 00 85 08 00       	push   $0x88500
80102a4f:	68 c0 00 00 00       	push   $0xc0
80102a54:	e8 e9 fe ff ff       	call   80102942 <lapicw>
80102a59:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102a5c:	90                   	nop
80102a5d:	a1 00 31 19 80       	mov    0x80193100,%eax
80102a62:	05 00 03 00 00       	add    $0x300,%eax
80102a67:	8b 00                	mov    (%eax),%eax
80102a69:	25 00 10 00 00       	and    $0x1000,%eax
80102a6e:	85 c0                	test   %eax,%eax
80102a70:	75 eb                	jne    80102a5d <lapicinit+0xf9>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102a72:	6a 00                	push   $0x0
80102a74:	6a 20                	push   $0x20
80102a76:	e8 c7 fe ff ff       	call   80102942 <lapicw>
80102a7b:	83 c4 08             	add    $0x8,%esp
80102a7e:	eb 01                	jmp    80102a81 <lapicinit+0x11d>
    return;
80102a80:	90                   	nop
}
80102a81:	c9                   	leave  
80102a82:	c3                   	ret    

80102a83 <lapicid>:

int
lapicid(void)
{
80102a83:	55                   	push   %ebp
80102a84:	89 e5                	mov    %esp,%ebp

  if (!lapic){
80102a86:	a1 00 31 19 80       	mov    0x80193100,%eax
80102a8b:	85 c0                	test   %eax,%eax
80102a8d:	75 07                	jne    80102a96 <lapicid+0x13>
    return 0;
80102a8f:	b8 00 00 00 00       	mov    $0x0,%eax
80102a94:	eb 0d                	jmp    80102aa3 <lapicid+0x20>
  }
  return lapic[ID] >> 24;
80102a96:	a1 00 31 19 80       	mov    0x80193100,%eax
80102a9b:	83 c0 20             	add    $0x20,%eax
80102a9e:	8b 00                	mov    (%eax),%eax
80102aa0:	c1 e8 18             	shr    $0x18,%eax
}
80102aa3:	5d                   	pop    %ebp
80102aa4:	c3                   	ret    

80102aa5 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102aa5:	55                   	push   %ebp
80102aa6:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102aa8:	a1 00 31 19 80       	mov    0x80193100,%eax
80102aad:	85 c0                	test   %eax,%eax
80102aaf:	74 0c                	je     80102abd <lapiceoi+0x18>
    lapicw(EOI, 0);
80102ab1:	6a 00                	push   $0x0
80102ab3:	6a 2c                	push   $0x2c
80102ab5:	e8 88 fe ff ff       	call   80102942 <lapicw>
80102aba:	83 c4 08             	add    $0x8,%esp
}
80102abd:	90                   	nop
80102abe:	c9                   	leave  
80102abf:	c3                   	ret    

80102ac0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
}
80102ac3:	90                   	nop
80102ac4:	5d                   	pop    %ebp
80102ac5:	c3                   	ret    

80102ac6 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ac6:	55                   	push   %ebp
80102ac7:	89 e5                	mov    %esp,%ebp
80102ac9:	83 ec 14             	sub    $0x14,%esp
80102acc:	8b 45 08             	mov    0x8(%ebp),%eax
80102acf:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80102ad2:	6a 0f                	push   $0xf
80102ad4:	6a 70                	push   $0x70
80102ad6:	e8 48 fe ff ff       	call   80102923 <outb>
80102adb:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80102ade:	6a 0a                	push   $0xa
80102ae0:	6a 71                	push   $0x71
80102ae2:	e8 3c fe ff ff       	call   80102923 <outb>
80102ae7:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102aea:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80102af1:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102af4:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102af9:	8b 45 0c             	mov    0xc(%ebp),%eax
80102afc:	c1 e8 04             	shr    $0x4,%eax
80102aff:	89 c1                	mov    %eax,%ecx
80102b01:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102b04:	8d 50 02             	lea    0x2(%eax),%edx
80102b07:	89 c8                	mov    %ecx,%eax
80102b09:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102b0c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102b10:	c1 e0 18             	shl    $0x18,%eax
80102b13:	50                   	push   %eax
80102b14:	68 c4 00 00 00       	push   $0xc4
80102b19:	e8 24 fe ff ff       	call   80102942 <lapicw>
80102b1e:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102b21:	68 00 c5 00 00       	push   $0xc500
80102b26:	68 c0 00 00 00       	push   $0xc0
80102b2b:	e8 12 fe ff ff       	call   80102942 <lapicw>
80102b30:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80102b33:	68 c8 00 00 00       	push   $0xc8
80102b38:	e8 83 ff ff ff       	call   80102ac0 <microdelay>
80102b3d:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80102b40:	68 00 85 00 00       	push   $0x8500
80102b45:	68 c0 00 00 00       	push   $0xc0
80102b4a:	e8 f3 fd ff ff       	call   80102942 <lapicw>
80102b4f:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80102b52:	6a 64                	push   $0x64
80102b54:	e8 67 ff ff ff       	call   80102ac0 <microdelay>
80102b59:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102b5c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80102b63:	eb 3c                	jmp    80102ba1 <lapicstartap+0xdb>
    lapicw(ICRHI, apicid<<24);
80102b65:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102b69:	c1 e0 18             	shl    $0x18,%eax
80102b6c:	50                   	push   %eax
80102b6d:	68 c4 00 00 00       	push   $0xc4
80102b72:	e8 cb fd ff ff       	call   80102942 <lapicw>
80102b77:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b7a:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b7d:	c1 e8 0c             	shr    $0xc,%eax
80102b80:	80 cc 06             	or     $0x6,%ah
80102b83:	50                   	push   %eax
80102b84:	68 c0 00 00 00       	push   $0xc0
80102b89:	e8 b4 fd ff ff       	call   80102942 <lapicw>
80102b8e:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80102b91:	68 c8 00 00 00       	push   $0xc8
80102b96:	e8 25 ff ff ff       	call   80102ac0 <microdelay>
80102b9b:	83 c4 04             	add    $0x4,%esp
  for(i = 0; i < 2; i++){
80102b9e:	ff 45 fc             	incl   -0x4(%ebp)
80102ba1:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80102ba5:	7e be                	jle    80102b65 <lapicstartap+0x9f>
  }
}
80102ba7:	90                   	nop
80102ba8:	90                   	nop
80102ba9:	c9                   	leave  
80102baa:	c3                   	ret    

80102bab <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
80102bab:	55                   	push   %ebp
80102bac:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
80102bae:	8b 45 08             	mov    0x8(%ebp),%eax
80102bb1:	0f b6 c0             	movzbl %al,%eax
80102bb4:	50                   	push   %eax
80102bb5:	6a 70                	push   $0x70
80102bb7:	e8 67 fd ff ff       	call   80102923 <outb>
80102bbc:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80102bbf:	68 c8 00 00 00       	push   $0xc8
80102bc4:	e8 f7 fe ff ff       	call   80102ac0 <microdelay>
80102bc9:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
80102bcc:	6a 71                	push   $0x71
80102bce:	e8 35 fd ff ff       	call   80102908 <inb>
80102bd3:	83 c4 04             	add    $0x4,%esp
80102bd6:	0f b6 c0             	movzbl %al,%eax
}
80102bd9:	c9                   	leave  
80102bda:	c3                   	ret    

80102bdb <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
80102bdb:	55                   	push   %ebp
80102bdc:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
80102bde:	6a 00                	push   $0x0
80102be0:	e8 c6 ff ff ff       	call   80102bab <cmos_read>
80102be5:	83 c4 04             	add    $0x4,%esp
80102be8:	8b 55 08             	mov    0x8(%ebp),%edx
80102beb:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
80102bed:	6a 02                	push   $0x2
80102bef:	e8 b7 ff ff ff       	call   80102bab <cmos_read>
80102bf4:	83 c4 04             	add    $0x4,%esp
80102bf7:	8b 55 08             	mov    0x8(%ebp),%edx
80102bfa:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
80102bfd:	6a 04                	push   $0x4
80102bff:	e8 a7 ff ff ff       	call   80102bab <cmos_read>
80102c04:	83 c4 04             	add    $0x4,%esp
80102c07:	8b 55 08             	mov    0x8(%ebp),%edx
80102c0a:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
80102c0d:	6a 07                	push   $0x7
80102c0f:	e8 97 ff ff ff       	call   80102bab <cmos_read>
80102c14:	83 c4 04             	add    $0x4,%esp
80102c17:	8b 55 08             	mov    0x8(%ebp),%edx
80102c1a:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
80102c1d:	6a 08                	push   $0x8
80102c1f:	e8 87 ff ff ff       	call   80102bab <cmos_read>
80102c24:	83 c4 04             	add    $0x4,%esp
80102c27:	8b 55 08             	mov    0x8(%ebp),%edx
80102c2a:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
80102c2d:	6a 09                	push   $0x9
80102c2f:	e8 77 ff ff ff       	call   80102bab <cmos_read>
80102c34:	83 c4 04             	add    $0x4,%esp
80102c37:	8b 55 08             	mov    0x8(%ebp),%edx
80102c3a:	89 42 14             	mov    %eax,0x14(%edx)
}
80102c3d:	90                   	nop
80102c3e:	c9                   	leave  
80102c3f:	c3                   	ret    

80102c40 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	57                   	push   %edi
80102c44:	56                   	push   %esi
80102c45:	53                   	push   %ebx
80102c46:	83 ec 4c             	sub    $0x4c,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
80102c49:	6a 0b                	push   $0xb
80102c4b:	e8 5b ff ff ff       	call   80102bab <cmos_read>
80102c50:	83 c4 04             	add    $0x4,%esp
80102c53:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  bcd = (sb & (1 << 2)) == 0;
80102c56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102c59:	83 e0 04             	and    $0x4,%eax
80102c5c:	85 c0                	test   %eax,%eax
80102c5e:	0f 94 c0             	sete   %al
80102c61:	0f b6 c0             	movzbl %al,%eax
80102c64:	89 45 e0             	mov    %eax,-0x20(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
80102c67:	8d 45 c8             	lea    -0x38(%ebp),%eax
80102c6a:	50                   	push   %eax
80102c6b:	e8 6b ff ff ff       	call   80102bdb <fill_rtcdate>
80102c70:	83 c4 04             	add    $0x4,%esp
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c73:	6a 0a                	push   $0xa
80102c75:	e8 31 ff ff ff       	call   80102bab <cmos_read>
80102c7a:	83 c4 04             	add    $0x4,%esp
80102c7d:	25 80 00 00 00       	and    $0x80,%eax
80102c82:	85 c0                	test   %eax,%eax
80102c84:	75 27                	jne    80102cad <cmostime+0x6d>
        continue;
    fill_rtcdate(&t2);
80102c86:	8d 45 b0             	lea    -0x50(%ebp),%eax
80102c89:	50                   	push   %eax
80102c8a:	e8 4c ff ff ff       	call   80102bdb <fill_rtcdate>
80102c8f:	83 c4 04             	add    $0x4,%esp
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c92:	83 ec 04             	sub    $0x4,%esp
80102c95:	6a 18                	push   $0x18
80102c97:	8d 45 b0             	lea    -0x50(%ebp),%eax
80102c9a:	50                   	push   %eax
80102c9b:	8d 45 c8             	lea    -0x38(%ebp),%eax
80102c9e:	50                   	push   %eax
80102c9f:	e8 c8 1c 00 00       	call   8010496c <memcmp>
80102ca4:	83 c4 10             	add    $0x10,%esp
80102ca7:	85 c0                	test   %eax,%eax
80102ca9:	74 05                	je     80102cb0 <cmostime+0x70>
80102cab:	eb ba                	jmp    80102c67 <cmostime+0x27>
        continue;
80102cad:	90                   	nop
    fill_rtcdate(&t1);
80102cae:	eb b7                	jmp    80102c67 <cmostime+0x27>
      break;
80102cb0:	90                   	nop
  }

  // convert
  if(bcd) {
80102cb1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80102cb5:	0f 84 b4 00 00 00    	je     80102d6f <cmostime+0x12f>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102cbb:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102cbe:	c1 e8 04             	shr    $0x4,%eax
80102cc1:	89 c2                	mov    %eax,%edx
80102cc3:	89 d0                	mov    %edx,%eax
80102cc5:	c1 e0 02             	shl    $0x2,%eax
80102cc8:	01 d0                	add    %edx,%eax
80102cca:	01 c0                	add    %eax,%eax
80102ccc:	89 c2                	mov    %eax,%edx
80102cce:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102cd1:	83 e0 0f             	and    $0xf,%eax
80102cd4:	01 d0                	add    %edx,%eax
80102cd6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(minute);
80102cd9:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102cdc:	c1 e8 04             	shr    $0x4,%eax
80102cdf:	89 c2                	mov    %eax,%edx
80102ce1:	89 d0                	mov    %edx,%eax
80102ce3:	c1 e0 02             	shl    $0x2,%eax
80102ce6:	01 d0                	add    %edx,%eax
80102ce8:	01 c0                	add    %eax,%eax
80102cea:	89 c2                	mov    %eax,%edx
80102cec:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102cef:	83 e0 0f             	and    $0xf,%eax
80102cf2:	01 d0                	add    %edx,%eax
80102cf4:	89 45 cc             	mov    %eax,-0x34(%ebp)
    CONV(hour  );
80102cf7:	8b 45 d0             	mov    -0x30(%ebp),%eax
80102cfa:	c1 e8 04             	shr    $0x4,%eax
80102cfd:	89 c2                	mov    %eax,%edx
80102cff:	89 d0                	mov    %edx,%eax
80102d01:	c1 e0 02             	shl    $0x2,%eax
80102d04:	01 d0                	add    %edx,%eax
80102d06:	01 c0                	add    %eax,%eax
80102d08:	89 c2                	mov    %eax,%edx
80102d0a:	8b 45 d0             	mov    -0x30(%ebp),%eax
80102d0d:	83 e0 0f             	and    $0xf,%eax
80102d10:	01 d0                	add    %edx,%eax
80102d12:	89 45 d0             	mov    %eax,-0x30(%ebp)
    CONV(day   );
80102d15:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80102d18:	c1 e8 04             	shr    $0x4,%eax
80102d1b:	89 c2                	mov    %eax,%edx
80102d1d:	89 d0                	mov    %edx,%eax
80102d1f:	c1 e0 02             	shl    $0x2,%eax
80102d22:	01 d0                	add    %edx,%eax
80102d24:	01 c0                	add    %eax,%eax
80102d26:	89 c2                	mov    %eax,%edx
80102d28:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80102d2b:	83 e0 0f             	and    $0xf,%eax
80102d2e:	01 d0                	add    %edx,%eax
80102d30:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    CONV(month );
80102d33:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102d36:	c1 e8 04             	shr    $0x4,%eax
80102d39:	89 c2                	mov    %eax,%edx
80102d3b:	89 d0                	mov    %edx,%eax
80102d3d:	c1 e0 02             	shl    $0x2,%eax
80102d40:	01 d0                	add    %edx,%eax
80102d42:	01 c0                	add    %eax,%eax
80102d44:	89 c2                	mov    %eax,%edx
80102d46:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102d49:	83 e0 0f             	and    $0xf,%eax
80102d4c:	01 d0                	add    %edx,%eax
80102d4e:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(year  );
80102d51:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102d54:	c1 e8 04             	shr    $0x4,%eax
80102d57:	89 c2                	mov    %eax,%edx
80102d59:	89 d0                	mov    %edx,%eax
80102d5b:	c1 e0 02             	shl    $0x2,%eax
80102d5e:	01 d0                	add    %edx,%eax
80102d60:	01 c0                	add    %eax,%eax
80102d62:	89 c2                	mov    %eax,%edx
80102d64:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102d67:	83 e0 0f             	and    $0xf,%eax
80102d6a:	01 d0                	add    %edx,%eax
80102d6c:	89 45 dc             	mov    %eax,-0x24(%ebp)
#undef     CONV
  }

  *r = t1;
80102d6f:	8b 45 08             	mov    0x8(%ebp),%eax
80102d72:	89 c3                	mov    %eax,%ebx
80102d74:	8d 45 c8             	lea    -0x38(%ebp),%eax
80102d77:	ba 06 00 00 00       	mov    $0x6,%edx
80102d7c:	89 df                	mov    %ebx,%edi
80102d7e:	89 c6                	mov    %eax,%esi
80102d80:	89 d1                	mov    %edx,%ecx
80102d82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
80102d84:	8b 45 08             	mov    0x8(%ebp),%eax
80102d87:	8b 40 14             	mov    0x14(%eax),%eax
80102d8a:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
80102d90:	8b 45 08             	mov    0x8(%ebp),%eax
80102d93:	89 50 14             	mov    %edx,0x14(%eax)
}
80102d96:	90                   	nop
80102d97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d9a:	5b                   	pop    %ebx
80102d9b:	5e                   	pop    %esi
80102d9c:	5f                   	pop    %edi
80102d9d:	5d                   	pop    %ebp
80102d9e:	c3                   	ret    

80102d9f <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102d9f:	55                   	push   %ebp
80102da0:	89 e5                	mov    %esp,%ebp
80102da2:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102da5:	83 ec 08             	sub    $0x8,%esp
80102da8:	68 51 a0 10 80       	push   $0x8010a051
80102dad:	68 20 31 19 80       	push   $0x80193120
80102db2:	e8 bc 18 00 00       	call   80104673 <initlock>
80102db7:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
80102dba:	83 ec 08             	sub    $0x8,%esp
80102dbd:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102dc0:	50                   	push   %eax
80102dc1:	ff 75 08             	pushl  0x8(%ebp)
80102dc4:	e8 bc e5 ff ff       	call   80101385 <readsb>
80102dc9:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
80102dcc:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102dcf:	a3 54 31 19 80       	mov    %eax,0x80193154
  log.size = sb.nlog;
80102dd4:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102dd7:	a3 58 31 19 80       	mov    %eax,0x80193158
  log.dev = dev;
80102ddc:	8b 45 08             	mov    0x8(%ebp),%eax
80102ddf:	a3 64 31 19 80       	mov    %eax,0x80193164
  recover_from_log();
80102de4:	e8 ae 01 00 00       	call   80102f97 <recover_from_log>
}
80102de9:	90                   	nop
80102dea:	c9                   	leave  
80102deb:	c3                   	ret    

80102dec <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102dec:	55                   	push   %ebp
80102ded:	89 e5                	mov    %esp,%ebp
80102def:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102df2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102df9:	e9 92 00 00 00       	jmp    80102e90 <install_trans+0xa4>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102dfe:	8b 15 54 31 19 80    	mov    0x80193154,%edx
80102e04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e07:	01 d0                	add    %edx,%eax
80102e09:	40                   	inc    %eax
80102e0a:	89 c2                	mov    %eax,%edx
80102e0c:	a1 64 31 19 80       	mov    0x80193164,%eax
80102e11:	83 ec 08             	sub    $0x8,%esp
80102e14:	52                   	push   %edx
80102e15:	50                   	push   %eax
80102e16:	e8 e6 d3 ff ff       	call   80100201 <bread>
80102e1b:	83 c4 10             	add    $0x10,%esp
80102e1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e24:	83 c0 10             	add    $0x10,%eax
80102e27:	8b 04 85 2c 31 19 80 	mov    -0x7fe6ced4(,%eax,4),%eax
80102e2e:	89 c2                	mov    %eax,%edx
80102e30:	a1 64 31 19 80       	mov    0x80193164,%eax
80102e35:	83 ec 08             	sub    $0x8,%esp
80102e38:	52                   	push   %edx
80102e39:	50                   	push   %eax
80102e3a:	e8 c2 d3 ff ff       	call   80100201 <bread>
80102e3f:	83 c4 10             	add    $0x10,%esp
80102e42:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e45:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102e48:	8d 50 5c             	lea    0x5c(%eax),%edx
80102e4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102e4e:	83 c0 5c             	add    $0x5c,%eax
80102e51:	83 ec 04             	sub    $0x4,%esp
80102e54:	68 00 02 00 00       	push   $0x200
80102e59:	52                   	push   %edx
80102e5a:	50                   	push   %eax
80102e5b:	e8 5e 1b 00 00       	call   801049be <memmove>
80102e60:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80102e63:	83 ec 0c             	sub    $0xc,%esp
80102e66:	ff 75 ec             	pushl  -0x14(%ebp)
80102e69:	e8 cc d3 ff ff       	call   8010023a <bwrite>
80102e6e:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf);
80102e71:	83 ec 0c             	sub    $0xc,%esp
80102e74:	ff 75 f0             	pushl  -0x10(%ebp)
80102e77:	e8 07 d4 ff ff       	call   80100283 <brelse>
80102e7c:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
80102e7f:	83 ec 0c             	sub    $0xc,%esp
80102e82:	ff 75 ec             	pushl  -0x14(%ebp)
80102e85:	e8 f9 d3 ff ff       	call   80100283 <brelse>
80102e8a:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80102e8d:	ff 45 f4             	incl   -0xc(%ebp)
80102e90:	a1 68 31 19 80       	mov    0x80193168,%eax
80102e95:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102e98:	0f 8c 60 ff ff ff    	jl     80102dfe <install_trans+0x12>
  }
}
80102e9e:	90                   	nop
80102e9f:	90                   	nop
80102ea0:	c9                   	leave  
80102ea1:	c3                   	ret    

80102ea2 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80102ea2:	55                   	push   %ebp
80102ea3:	89 e5                	mov    %esp,%ebp
80102ea5:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ea8:	a1 54 31 19 80       	mov    0x80193154,%eax
80102ead:	89 c2                	mov    %eax,%edx
80102eaf:	a1 64 31 19 80       	mov    0x80193164,%eax
80102eb4:	83 ec 08             	sub    $0x8,%esp
80102eb7:	52                   	push   %edx
80102eb8:	50                   	push   %eax
80102eb9:	e8 43 d3 ff ff       	call   80100201 <bread>
80102ebe:	83 c4 10             	add    $0x10,%esp
80102ec1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80102ec4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102ec7:	83 c0 5c             	add    $0x5c,%eax
80102eca:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80102ecd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102ed0:	8b 00                	mov    (%eax),%eax
80102ed2:	a3 68 31 19 80       	mov    %eax,0x80193168
  for (i = 0; i < log.lh.n; i++) {
80102ed7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102ede:	eb 1a                	jmp    80102efa <read_head+0x58>
    log.lh.block[i] = lh->block[i];
80102ee0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102ee3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102ee6:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80102eea:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102eed:	83 c2 10             	add    $0x10,%edx
80102ef0:	89 04 95 2c 31 19 80 	mov    %eax,-0x7fe6ced4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102ef7:	ff 45 f4             	incl   -0xc(%ebp)
80102efa:	a1 68 31 19 80       	mov    0x80193168,%eax
80102eff:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102f02:	7c dc                	jl     80102ee0 <read_head+0x3e>
  }
  brelse(buf);
80102f04:	83 ec 0c             	sub    $0xc,%esp
80102f07:	ff 75 f0             	pushl  -0x10(%ebp)
80102f0a:	e8 74 d3 ff ff       	call   80100283 <brelse>
80102f0f:	83 c4 10             	add    $0x10,%esp
}
80102f12:	90                   	nop
80102f13:	c9                   	leave  
80102f14:	c3                   	ret    

80102f15 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102f15:	55                   	push   %ebp
80102f16:	89 e5                	mov    %esp,%ebp
80102f18:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80102f1b:	a1 54 31 19 80       	mov    0x80193154,%eax
80102f20:	89 c2                	mov    %eax,%edx
80102f22:	a1 64 31 19 80       	mov    0x80193164,%eax
80102f27:	83 ec 08             	sub    $0x8,%esp
80102f2a:	52                   	push   %edx
80102f2b:	50                   	push   %eax
80102f2c:	e8 d0 d2 ff ff       	call   80100201 <bread>
80102f31:	83 c4 10             	add    $0x10,%esp
80102f34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80102f37:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102f3a:	83 c0 5c             	add    $0x5c,%eax
80102f3d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80102f40:	8b 15 68 31 19 80    	mov    0x80193168,%edx
80102f46:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102f49:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102f4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102f52:	eb 1a                	jmp    80102f6e <write_head+0x59>
    hb->block[i] = log.lh.block[i];
80102f54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f57:	83 c0 10             	add    $0x10,%eax
80102f5a:	8b 0c 85 2c 31 19 80 	mov    -0x7fe6ced4(,%eax,4),%ecx
80102f61:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102f64:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102f67:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102f6b:	ff 45 f4             	incl   -0xc(%ebp)
80102f6e:	a1 68 31 19 80       	mov    0x80193168,%eax
80102f73:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102f76:	7c dc                	jl     80102f54 <write_head+0x3f>
  }
  bwrite(buf);
80102f78:	83 ec 0c             	sub    $0xc,%esp
80102f7b:	ff 75 f0             	pushl  -0x10(%ebp)
80102f7e:	e8 b7 d2 ff ff       	call   8010023a <bwrite>
80102f83:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80102f86:	83 ec 0c             	sub    $0xc,%esp
80102f89:	ff 75 f0             	pushl  -0x10(%ebp)
80102f8c:	e8 f2 d2 ff ff       	call   80100283 <brelse>
80102f91:	83 c4 10             	add    $0x10,%esp
}
80102f94:	90                   	nop
80102f95:	c9                   	leave  
80102f96:	c3                   	ret    

80102f97 <recover_from_log>:

static void
recover_from_log(void)
{
80102f97:	55                   	push   %ebp
80102f98:	89 e5                	mov    %esp,%ebp
80102f9a:	83 ec 08             	sub    $0x8,%esp
  read_head();
80102f9d:	e8 00 ff ff ff       	call   80102ea2 <read_head>
  install_trans(); // if committed, copy from log to disk
80102fa2:	e8 45 fe ff ff       	call   80102dec <install_trans>
  log.lh.n = 0;
80102fa7:	c7 05 68 31 19 80 00 	movl   $0x0,0x80193168
80102fae:	00 00 00 
  write_head(); // clear the log
80102fb1:	e8 5f ff ff ff       	call   80102f15 <write_head>
}
80102fb6:	90                   	nop
80102fb7:	c9                   	leave  
80102fb8:	c3                   	ret    

80102fb9 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80102fb9:	55                   	push   %ebp
80102fba:	89 e5                	mov    %esp,%ebp
80102fbc:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
80102fbf:	83 ec 0c             	sub    $0xc,%esp
80102fc2:	68 20 31 19 80       	push   $0x80193120
80102fc7:	e8 c9 16 00 00       	call   80104695 <acquire>
80102fcc:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
80102fcf:	a1 60 31 19 80       	mov    0x80193160,%eax
80102fd4:	85 c0                	test   %eax,%eax
80102fd6:	74 17                	je     80102fef <begin_op+0x36>
      sleep(&log, &log.lock);
80102fd8:	83 ec 08             	sub    $0x8,%esp
80102fdb:	68 20 31 19 80       	push   $0x80193120
80102fe0:	68 20 31 19 80       	push   $0x80193120
80102fe5:	e8 91 12 00 00       	call   8010427b <sleep>
80102fea:	83 c4 10             	add    $0x10,%esp
80102fed:	eb e0                	jmp    80102fcf <begin_op+0x16>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102fef:	8b 15 68 31 19 80    	mov    0x80193168,%edx
80102ff5:	a1 5c 31 19 80       	mov    0x8019315c,%eax
80102ffa:	8d 48 01             	lea    0x1(%eax),%ecx
80102ffd:	89 c8                	mov    %ecx,%eax
80102fff:	c1 e0 02             	shl    $0x2,%eax
80103002:	01 c8                	add    %ecx,%eax
80103004:	01 c0                	add    %eax,%eax
80103006:	01 d0                	add    %edx,%eax
80103008:	83 f8 1e             	cmp    $0x1e,%eax
8010300b:	7e 17                	jle    80103024 <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
8010300d:	83 ec 08             	sub    $0x8,%esp
80103010:	68 20 31 19 80       	push   $0x80193120
80103015:	68 20 31 19 80       	push   $0x80193120
8010301a:	e8 5c 12 00 00       	call   8010427b <sleep>
8010301f:	83 c4 10             	add    $0x10,%esp
80103022:	eb ab                	jmp    80102fcf <begin_op+0x16>
    } else {
      log.outstanding += 1;
80103024:	a1 5c 31 19 80       	mov    0x8019315c,%eax
80103029:	40                   	inc    %eax
8010302a:	a3 5c 31 19 80       	mov    %eax,0x8019315c
      release(&log.lock);
8010302f:	83 ec 0c             	sub    $0xc,%esp
80103032:	68 20 31 19 80       	push   $0x80193120
80103037:	e8 c7 16 00 00       	call   80104703 <release>
8010303c:	83 c4 10             	add    $0x10,%esp
      break;
8010303f:	90                   	nop
    }
  }
}
80103040:	90                   	nop
80103041:	c9                   	leave  
80103042:	c3                   	ret    

80103043 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103043:	55                   	push   %ebp
80103044:	89 e5                	mov    %esp,%ebp
80103046:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
80103049:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
80103050:	83 ec 0c             	sub    $0xc,%esp
80103053:	68 20 31 19 80       	push   $0x80193120
80103058:	e8 38 16 00 00       	call   80104695 <acquire>
8010305d:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103060:	a1 5c 31 19 80       	mov    0x8019315c,%eax
80103065:	48                   	dec    %eax
80103066:	a3 5c 31 19 80       	mov    %eax,0x8019315c
  if(log.committing)
8010306b:	a1 60 31 19 80       	mov    0x80193160,%eax
80103070:	85 c0                	test   %eax,%eax
80103072:	74 0d                	je     80103081 <end_op+0x3e>
    panic("log.committing");
80103074:	83 ec 0c             	sub    $0xc,%esp
80103077:	68 55 a0 10 80       	push   $0x8010a055
8010307c:	e8 1e d5 ff ff       	call   8010059f <panic>
  if(log.outstanding == 0){
80103081:	a1 5c 31 19 80       	mov    0x8019315c,%eax
80103086:	85 c0                	test   %eax,%eax
80103088:	75 13                	jne    8010309d <end_op+0x5a>
    do_commit = 1;
8010308a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
80103091:	c7 05 60 31 19 80 01 	movl   $0x1,0x80193160
80103098:	00 00 00 
8010309b:	eb 10                	jmp    801030ad <end_op+0x6a>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
8010309d:	83 ec 0c             	sub    $0xc,%esp
801030a0:	68 20 31 19 80       	push   $0x80193120
801030a5:	e8 b8 12 00 00       	call   80104362 <wakeup>
801030aa:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
801030ad:	83 ec 0c             	sub    $0xc,%esp
801030b0:	68 20 31 19 80       	push   $0x80193120
801030b5:	e8 49 16 00 00       	call   80104703 <release>
801030ba:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
801030bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801030c1:	74 3f                	je     80103102 <end_op+0xbf>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
801030c3:	e8 f3 00 00 00       	call   801031bb <commit>
    acquire(&log.lock);
801030c8:	83 ec 0c             	sub    $0xc,%esp
801030cb:	68 20 31 19 80       	push   $0x80193120
801030d0:	e8 c0 15 00 00       	call   80104695 <acquire>
801030d5:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
801030d8:	c7 05 60 31 19 80 00 	movl   $0x0,0x80193160
801030df:	00 00 00 
    wakeup(&log);
801030e2:	83 ec 0c             	sub    $0xc,%esp
801030e5:	68 20 31 19 80       	push   $0x80193120
801030ea:	e8 73 12 00 00       	call   80104362 <wakeup>
801030ef:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
801030f2:	83 ec 0c             	sub    $0xc,%esp
801030f5:	68 20 31 19 80       	push   $0x80193120
801030fa:	e8 04 16 00 00       	call   80104703 <release>
801030ff:	83 c4 10             	add    $0x10,%esp
  }
}
80103102:	90                   	nop
80103103:	c9                   	leave  
80103104:	c3                   	ret    

80103105 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
80103105:	55                   	push   %ebp
80103106:	89 e5                	mov    %esp,%ebp
80103108:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010310b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103112:	e9 92 00 00 00       	jmp    801031a9 <write_log+0xa4>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103117:	8b 15 54 31 19 80    	mov    0x80193154,%edx
8010311d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103120:	01 d0                	add    %edx,%eax
80103122:	40                   	inc    %eax
80103123:	89 c2                	mov    %eax,%edx
80103125:	a1 64 31 19 80       	mov    0x80193164,%eax
8010312a:	83 ec 08             	sub    $0x8,%esp
8010312d:	52                   	push   %edx
8010312e:	50                   	push   %eax
8010312f:	e8 cd d0 ff ff       	call   80100201 <bread>
80103134:	83 c4 10             	add    $0x10,%esp
80103137:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010313a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010313d:	83 c0 10             	add    $0x10,%eax
80103140:	8b 04 85 2c 31 19 80 	mov    -0x7fe6ced4(,%eax,4),%eax
80103147:	89 c2                	mov    %eax,%edx
80103149:	a1 64 31 19 80       	mov    0x80193164,%eax
8010314e:	83 ec 08             	sub    $0x8,%esp
80103151:	52                   	push   %edx
80103152:	50                   	push   %eax
80103153:	e8 a9 d0 ff ff       	call   80100201 <bread>
80103158:	83 c4 10             	add    $0x10,%esp
8010315b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
8010315e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103161:	8d 50 5c             	lea    0x5c(%eax),%edx
80103164:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103167:	83 c0 5c             	add    $0x5c,%eax
8010316a:	83 ec 04             	sub    $0x4,%esp
8010316d:	68 00 02 00 00       	push   $0x200
80103172:	52                   	push   %edx
80103173:	50                   	push   %eax
80103174:	e8 45 18 00 00       	call   801049be <memmove>
80103179:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
8010317c:	83 ec 0c             	sub    $0xc,%esp
8010317f:	ff 75 f0             	pushl  -0x10(%ebp)
80103182:	e8 b3 d0 ff ff       	call   8010023a <bwrite>
80103187:	83 c4 10             	add    $0x10,%esp
    brelse(from);
8010318a:	83 ec 0c             	sub    $0xc,%esp
8010318d:	ff 75 ec             	pushl  -0x14(%ebp)
80103190:	e8 ee d0 ff ff       	call   80100283 <brelse>
80103195:	83 c4 10             	add    $0x10,%esp
    brelse(to);
80103198:	83 ec 0c             	sub    $0xc,%esp
8010319b:	ff 75 f0             	pushl  -0x10(%ebp)
8010319e:	e8 e0 d0 ff ff       	call   80100283 <brelse>
801031a3:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
801031a6:	ff 45 f4             	incl   -0xc(%ebp)
801031a9:	a1 68 31 19 80       	mov    0x80193168,%eax
801031ae:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801031b1:	0f 8c 60 ff ff ff    	jl     80103117 <write_log+0x12>
  }
}
801031b7:	90                   	nop
801031b8:	90                   	nop
801031b9:	c9                   	leave  
801031ba:	c3                   	ret    

801031bb <commit>:

static void
commit()
{
801031bb:	55                   	push   %ebp
801031bc:	89 e5                	mov    %esp,%ebp
801031be:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
801031c1:	a1 68 31 19 80       	mov    0x80193168,%eax
801031c6:	85 c0                	test   %eax,%eax
801031c8:	7e 1e                	jle    801031e8 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
801031ca:	e8 36 ff ff ff       	call   80103105 <write_log>
    write_head();    // Write header to disk -- the real commit
801031cf:	e8 41 fd ff ff       	call   80102f15 <write_head>
    install_trans(); // Now install writes to home locations
801031d4:	e8 13 fc ff ff       	call   80102dec <install_trans>
    log.lh.n = 0;
801031d9:	c7 05 68 31 19 80 00 	movl   $0x0,0x80193168
801031e0:	00 00 00 
    write_head();    // Erase the transaction from the log
801031e3:	e8 2d fd ff ff       	call   80102f15 <write_head>
  }
}
801031e8:	90                   	nop
801031e9:	c9                   	leave  
801031ea:	c3                   	ret    

801031eb <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801031eb:	55                   	push   %ebp
801031ec:	89 e5                	mov    %esp,%ebp
801031ee:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801031f1:	a1 68 31 19 80       	mov    0x80193168,%eax
801031f6:	83 f8 1d             	cmp    $0x1d,%eax
801031f9:	7f 10                	jg     8010320b <log_write+0x20>
801031fb:	8b 15 68 31 19 80    	mov    0x80193168,%edx
80103201:	a1 58 31 19 80       	mov    0x80193158,%eax
80103206:	48                   	dec    %eax
80103207:	39 c2                	cmp    %eax,%edx
80103209:	7c 0d                	jl     80103218 <log_write+0x2d>
    panic("too big a transaction");
8010320b:	83 ec 0c             	sub    $0xc,%esp
8010320e:	68 64 a0 10 80       	push   $0x8010a064
80103213:	e8 87 d3 ff ff       	call   8010059f <panic>
  if (log.outstanding < 1)
80103218:	a1 5c 31 19 80       	mov    0x8019315c,%eax
8010321d:	85 c0                	test   %eax,%eax
8010321f:	7f 0d                	jg     8010322e <log_write+0x43>
    panic("log_write outside of trans");
80103221:	83 ec 0c             	sub    $0xc,%esp
80103224:	68 7a a0 10 80       	push   $0x8010a07a
80103229:	e8 71 d3 ff ff       	call   8010059f <panic>

  acquire(&log.lock);
8010322e:	83 ec 0c             	sub    $0xc,%esp
80103231:	68 20 31 19 80       	push   $0x80193120
80103236:	e8 5a 14 00 00       	call   80104695 <acquire>
8010323b:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
8010323e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103245:	eb 1c                	jmp    80103263 <log_write+0x78>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103247:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010324a:	83 c0 10             	add    $0x10,%eax
8010324d:	8b 04 85 2c 31 19 80 	mov    -0x7fe6ced4(,%eax,4),%eax
80103254:	89 c2                	mov    %eax,%edx
80103256:	8b 45 08             	mov    0x8(%ebp),%eax
80103259:	8b 40 08             	mov    0x8(%eax),%eax
8010325c:	39 c2                	cmp    %eax,%edx
8010325e:	74 0f                	je     8010326f <log_write+0x84>
  for (i = 0; i < log.lh.n; i++) {
80103260:	ff 45 f4             	incl   -0xc(%ebp)
80103263:	a1 68 31 19 80       	mov    0x80193168,%eax
80103268:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010326b:	7c da                	jl     80103247 <log_write+0x5c>
8010326d:	eb 01                	jmp    80103270 <log_write+0x85>
      break;
8010326f:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
80103270:	8b 45 08             	mov    0x8(%ebp),%eax
80103273:	8b 40 08             	mov    0x8(%eax),%eax
80103276:	89 c2                	mov    %eax,%edx
80103278:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010327b:	83 c0 10             	add    $0x10,%eax
8010327e:	89 14 85 2c 31 19 80 	mov    %edx,-0x7fe6ced4(,%eax,4)
  if (i == log.lh.n)
80103285:	a1 68 31 19 80       	mov    0x80193168,%eax
8010328a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010328d:	75 0b                	jne    8010329a <log_write+0xaf>
    log.lh.n++;
8010328f:	a1 68 31 19 80       	mov    0x80193168,%eax
80103294:	40                   	inc    %eax
80103295:	a3 68 31 19 80       	mov    %eax,0x80193168
  b->flags |= B_DIRTY; // prevent eviction
8010329a:	8b 45 08             	mov    0x8(%ebp),%eax
8010329d:	8b 00                	mov    (%eax),%eax
8010329f:	83 c8 04             	or     $0x4,%eax
801032a2:	89 c2                	mov    %eax,%edx
801032a4:	8b 45 08             	mov    0x8(%ebp),%eax
801032a7:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
801032a9:	83 ec 0c             	sub    $0xc,%esp
801032ac:	68 20 31 19 80       	push   $0x80193120
801032b1:	e8 4d 14 00 00       	call   80104703 <release>
801032b6:	83 c4 10             	add    $0x10,%esp
}
801032b9:	90                   	nop
801032ba:	c9                   	leave  
801032bb:	c3                   	ret    

801032bc <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801032bc:	55                   	push   %ebp
801032bd:	89 e5                	mov    %esp,%ebp
801032bf:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801032c2:	8b 55 08             	mov    0x8(%ebp),%edx
801032c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801032c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
801032cb:	f0 87 02             	lock xchg %eax,(%edx)
801032ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801032d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801032d4:	c9                   	leave  
801032d5:	c3                   	ret    

801032d6 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801032d6:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801032da:	83 e4 f0             	and    $0xfffffff0,%esp
801032dd:	ff 71 fc             	pushl  -0x4(%ecx)
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	51                   	push   %ecx
801032e4:	83 ec 04             	sub    $0x4,%esp
  graphic_init();
801032e7:	e8 37 49 00 00       	call   80107c23 <graphic_init>
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801032ec:	83 ec 08             	sub    $0x8,%esp
801032ef:	68 00 00 40 80       	push   $0x80400000
801032f4:	68 00 70 19 80       	push   $0x80197000
801032f9:	e8 01 f3 ff ff       	call   801025ff <kinit1>
801032fe:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
80103301:	e8 53 3f 00 00       	call   80107259 <kvmalloc>
  mpinit_uefi();
80103306:	e8 e9 46 00 00       	call   801079f4 <mpinit_uefi>
  lapicinit();     // interrupt controller
8010330b:	e8 54 f6 ff ff       	call   80102964 <lapicinit>
  seginit();       // segment descriptors
80103310:	e8 f7 39 00 00       	call   80106d0c <seginit>
  picinit();    // disable pic
80103315:	e8 a4 01 00 00       	call   801034be <picinit>
  ioapicinit();    // another interrupt controller
8010331a:	e8 02 f2 ff ff       	call   80102521 <ioapicinit>
  consoleinit();   // console hardware
8010331f:	e8 b1 d7 ff ff       	call   80100ad5 <consoleinit>
  uartinit();      // serial port
80103324:	e8 83 2d 00 00       	call   801060ac <uartinit>
  pinit();         // process table
80103329:	e8 c5 05 00 00       	call   801038f3 <pinit>
  tvinit();        // trap vectors
8010332e:	e8 6b 29 00 00       	call   80105c9e <tvinit>
  binit();         // buffer cache
80103333:	e8 2e cd ff ff       	call   80100066 <binit>
  fileinit();      // file table
80103338:	e8 47 dc ff ff       	call   80100f84 <fileinit>
  ideinit();       // disk 
8010333d:	e8 cf 69 00 00       	call   80109d11 <ideinit>
  startothers();   // start other processors
80103342:	e8 8a 00 00 00       	call   801033d1 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103347:	83 ec 08             	sub    $0x8,%esp
8010334a:	68 00 00 00 a0       	push   $0xa0000000
8010334f:	68 00 00 40 80       	push   $0x80400000
80103354:	e8 df f2 ff ff       	call   80102638 <kinit2>
80103359:	83 c4 10             	add    $0x10,%esp
  pci_init();
8010335c:	e8 3d 4b 00 00       	call   80107e9e <pci_init>
  arp_scan();
80103361:	e8 46 58 00 00       	call   80108bac <arp_scan>
  //i8254_recv();
  userinit();      // first user process
80103366:	e8 98 07 00 00       	call   80103b03 <userinit>

  mpmain();        // finish this processor's setup
8010336b:	e8 1a 00 00 00       	call   8010338a <mpmain>

80103370 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103376:	e8 f6 3e 00 00       	call   80107271 <switchkvm>
  seginit();
8010337b:	e8 8c 39 00 00       	call   80106d0c <seginit>
  lapicinit();
80103380:	e8 df f5 ff ff       	call   80102964 <lapicinit>
  mpmain();
80103385:	e8 00 00 00 00       	call   8010338a <mpmain>

8010338a <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
8010338a:	55                   	push   %ebp
8010338b:	89 e5                	mov    %esp,%ebp
8010338d:	53                   	push   %ebx
8010338e:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103391:	e8 7b 05 00 00       	call   80103911 <cpuid>
80103396:	89 c3                	mov    %eax,%ebx
80103398:	e8 74 05 00 00       	call   80103911 <cpuid>
8010339d:	83 ec 04             	sub    $0x4,%esp
801033a0:	53                   	push   %ebx
801033a1:	50                   	push   %eax
801033a2:	68 95 a0 10 80       	push   $0x8010a095
801033a7:	e8 45 d0 ff ff       	call   801003f1 <cprintf>
801033ac:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
801033af:	e8 49 2a 00 00       	call   80105dfd <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801033b4:	e8 97 05 00 00       	call   80103950 <mycpu>
801033b9:	05 a0 00 00 00       	add    $0xa0,%eax
801033be:	83 ec 08             	sub    $0x8,%esp
801033c1:	6a 01                	push   $0x1
801033c3:	50                   	push   %eax
801033c4:	e8 f3 fe ff ff       	call   801032bc <xchg>
801033c9:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
801033cc:	e8 b9 0c 00 00       	call   8010408a <scheduler>

801033d1 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801033d1:	55                   	push   %ebp
801033d2:	89 e5                	mov    %esp,%ebp
801033d4:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
801033d7:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801033de:	b8 8a 00 00 00       	mov    $0x8a,%eax
801033e3:	83 ec 04             	sub    $0x4,%esp
801033e6:	50                   	push   %eax
801033e7:	68 18 e5 10 80       	push   $0x8010e518
801033ec:	ff 75 f0             	pushl  -0x10(%ebp)
801033ef:	e8 ca 15 00 00       	call   801049be <memmove>
801033f4:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
801033f7:	c7 45 f4 80 59 19 80 	movl   $0x80195980,-0xc(%ebp)
801033fe:	eb 78                	jmp    80103478 <startothers+0xa7>
    if(c == mycpu()){  // We've started already.
80103400:	e8 4b 05 00 00       	call   80103950 <mycpu>
80103405:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103408:	74 66                	je     80103470 <startothers+0x9f>
      continue;
    }
    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
8010340a:	e8 25 f3 ff ff       	call   80102734 <kalloc>
8010340f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103412:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103415:	83 e8 04             	sub    $0x4,%eax
80103418:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010341b:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103421:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103423:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103426:	83 e8 08             	sub    $0x8,%eax
80103429:	c7 00 70 33 10 80    	movl   $0x80103370,(%eax)
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010342f:	b8 00 d0 10 80       	mov    $0x8010d000,%eax
80103434:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
8010343a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010343d:	83 e8 0c             	sub    $0xc,%eax
80103440:	89 10                	mov    %edx,(%eax)

    lapicstartap(c->apicid, V2P(code));
80103442:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103445:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
8010344b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010344e:	8a 00                	mov    (%eax),%al
80103450:	0f b6 c0             	movzbl %al,%eax
80103453:	83 ec 08             	sub    $0x8,%esp
80103456:	52                   	push   %edx
80103457:	50                   	push   %eax
80103458:	e8 69 f6 ff ff       	call   80102ac6 <lapicstartap>
8010345d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103460:	90                   	nop
80103461:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103464:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
8010346a:	85 c0                	test   %eax,%eax
8010346c:	74 f3                	je     80103461 <startothers+0x90>
8010346e:	eb 01                	jmp    80103471 <startothers+0xa0>
      continue;
80103470:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
80103471:	81 45 f4 b0 00 00 00 	addl   $0xb0,-0xc(%ebp)
80103478:	a1 40 5c 19 80       	mov    0x80195c40,%eax
8010347d:	89 c2                	mov    %eax,%edx
8010347f:	89 d0                	mov    %edx,%eax
80103481:	c1 e0 02             	shl    $0x2,%eax
80103484:	01 d0                	add    %edx,%eax
80103486:	01 c0                	add    %eax,%eax
80103488:	01 d0                	add    %edx,%eax
8010348a:	c1 e0 04             	shl    $0x4,%eax
8010348d:	05 80 59 19 80       	add    $0x80195980,%eax
80103492:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103495:	0f 82 65 ff ff ff    	jb     80103400 <startothers+0x2f>
      ;
  }
}
8010349b:	90                   	nop
8010349c:	90                   	nop
8010349d:	c9                   	leave  
8010349e:	c3                   	ret    

8010349f <outb>:
{
8010349f:	55                   	push   %ebp
801034a0:	89 e5                	mov    %esp,%ebp
801034a2:	83 ec 08             	sub    $0x8,%esp
801034a5:	8b 45 08             	mov    0x8(%ebp),%eax
801034a8:	8b 55 0c             	mov    0xc(%ebp),%edx
801034ab:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801034af:	88 d0                	mov    %dl,%al
801034b1:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034b4:	8a 45 f8             	mov    -0x8(%ebp),%al
801034b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
801034ba:	ee                   	out    %al,(%dx)
}
801034bb:	90                   	nop
801034bc:	c9                   	leave  
801034bd:	c3                   	ret    

801034be <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801034be:	55                   	push   %ebp
801034bf:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
801034c1:	68 ff 00 00 00       	push   $0xff
801034c6:	6a 21                	push   $0x21
801034c8:	e8 d2 ff ff ff       	call   8010349f <outb>
801034cd:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
801034d0:	68 ff 00 00 00       	push   $0xff
801034d5:	68 a1 00 00 00       	push   $0xa1
801034da:	e8 c0 ff ff ff       	call   8010349f <outb>
801034df:	83 c4 08             	add    $0x8,%esp
}
801034e2:	90                   	nop
801034e3:	c9                   	leave  
801034e4:	c3                   	ret    

801034e5 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801034e5:	55                   	push   %ebp
801034e6:	89 e5                	mov    %esp,%ebp
801034e8:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
801034eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
801034f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801034f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801034fb:	8b 45 0c             	mov    0xc(%ebp),%eax
801034fe:	8b 10                	mov    (%eax),%edx
80103500:	8b 45 08             	mov    0x8(%ebp),%eax
80103503:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103505:	e8 98 da ff ff       	call   80100fa2 <filealloc>
8010350a:	8b 55 08             	mov    0x8(%ebp),%edx
8010350d:	89 02                	mov    %eax,(%edx)
8010350f:	8b 45 08             	mov    0x8(%ebp),%eax
80103512:	8b 00                	mov    (%eax),%eax
80103514:	85 c0                	test   %eax,%eax
80103516:	0f 84 c8 00 00 00    	je     801035e4 <pipealloc+0xff>
8010351c:	e8 81 da ff ff       	call   80100fa2 <filealloc>
80103521:	8b 55 0c             	mov    0xc(%ebp),%edx
80103524:	89 02                	mov    %eax,(%edx)
80103526:	8b 45 0c             	mov    0xc(%ebp),%eax
80103529:	8b 00                	mov    (%eax),%eax
8010352b:	85 c0                	test   %eax,%eax
8010352d:	0f 84 b1 00 00 00    	je     801035e4 <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103533:	e8 fc f1 ff ff       	call   80102734 <kalloc>
80103538:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010353b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010353f:	0f 84 a2 00 00 00    	je     801035e7 <pipealloc+0x102>
    goto bad;
  p->readopen = 1;
80103545:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103548:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010354f:	00 00 00 
  p->writeopen = 1;
80103552:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103555:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010355c:	00 00 00 
  p->nwrite = 0;
8010355f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103562:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103569:	00 00 00 
  p->nread = 0;
8010356c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010356f:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103576:	00 00 00 
  initlock(&p->lock, "pipe");
80103579:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010357c:	83 ec 08             	sub    $0x8,%esp
8010357f:	68 a9 a0 10 80       	push   $0x8010a0a9
80103584:	50                   	push   %eax
80103585:	e8 e9 10 00 00       	call   80104673 <initlock>
8010358a:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010358d:	8b 45 08             	mov    0x8(%ebp),%eax
80103590:	8b 00                	mov    (%eax),%eax
80103592:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103598:	8b 45 08             	mov    0x8(%ebp),%eax
8010359b:	8b 00                	mov    (%eax),%eax
8010359d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801035a1:	8b 45 08             	mov    0x8(%ebp),%eax
801035a4:	8b 00                	mov    (%eax),%eax
801035a6:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801035aa:	8b 45 08             	mov    0x8(%ebp),%eax
801035ad:	8b 00                	mov    (%eax),%eax
801035af:	8b 55 f4             	mov    -0xc(%ebp),%edx
801035b2:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801035b5:	8b 45 0c             	mov    0xc(%ebp),%eax
801035b8:	8b 00                	mov    (%eax),%eax
801035ba:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801035c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801035c3:	8b 00                	mov    (%eax),%eax
801035c5:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801035c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801035cc:	8b 00                	mov    (%eax),%eax
801035ce:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801035d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801035d5:	8b 00                	mov    (%eax),%eax
801035d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801035da:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
801035dd:	b8 00 00 00 00       	mov    $0x0,%eax
801035e2:	eb 51                	jmp    80103635 <pipealloc+0x150>
    goto bad;
801035e4:	90                   	nop
801035e5:	eb 01                	jmp    801035e8 <pipealloc+0x103>
    goto bad;
801035e7:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
801035e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801035ec:	74 0e                	je     801035fc <pipealloc+0x117>
    kfree((char*)p);
801035ee:	83 ec 0c             	sub    $0xc,%esp
801035f1:	ff 75 f4             	pushl  -0xc(%ebp)
801035f4:	e8 a1 f0 ff ff       	call   8010269a <kfree>
801035f9:	83 c4 10             	add    $0x10,%esp
  if(*f0)
801035fc:	8b 45 08             	mov    0x8(%ebp),%eax
801035ff:	8b 00                	mov    (%eax),%eax
80103601:	85 c0                	test   %eax,%eax
80103603:	74 11                	je     80103616 <pipealloc+0x131>
    fileclose(*f0);
80103605:	8b 45 08             	mov    0x8(%ebp),%eax
80103608:	8b 00                	mov    (%eax),%eax
8010360a:	83 ec 0c             	sub    $0xc,%esp
8010360d:	50                   	push   %eax
8010360e:	e8 4d da ff ff       	call   80101060 <fileclose>
80103613:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103616:	8b 45 0c             	mov    0xc(%ebp),%eax
80103619:	8b 00                	mov    (%eax),%eax
8010361b:	85 c0                	test   %eax,%eax
8010361d:	74 11                	je     80103630 <pipealloc+0x14b>
    fileclose(*f1);
8010361f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103622:	8b 00                	mov    (%eax),%eax
80103624:	83 ec 0c             	sub    $0xc,%esp
80103627:	50                   	push   %eax
80103628:	e8 33 da ff ff       	call   80101060 <fileclose>
8010362d:	83 c4 10             	add    $0x10,%esp
  return -1;
80103630:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103635:	c9                   	leave  
80103636:	c3                   	ret    

80103637 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103637:	55                   	push   %ebp
80103638:	89 e5                	mov    %esp,%ebp
8010363a:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
8010363d:	8b 45 08             	mov    0x8(%ebp),%eax
80103640:	83 ec 0c             	sub    $0xc,%esp
80103643:	50                   	push   %eax
80103644:	e8 4c 10 00 00       	call   80104695 <acquire>
80103649:	83 c4 10             	add    $0x10,%esp
  if(writable){
8010364c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103650:	74 23                	je     80103675 <pipeclose+0x3e>
    p->writeopen = 0;
80103652:	8b 45 08             	mov    0x8(%ebp),%eax
80103655:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
8010365c:	00 00 00 
    wakeup(&p->nread);
8010365f:	8b 45 08             	mov    0x8(%ebp),%eax
80103662:	05 34 02 00 00       	add    $0x234,%eax
80103667:	83 ec 0c             	sub    $0xc,%esp
8010366a:	50                   	push   %eax
8010366b:	e8 f2 0c 00 00       	call   80104362 <wakeup>
80103670:	83 c4 10             	add    $0x10,%esp
80103673:	eb 21                	jmp    80103696 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80103675:	8b 45 08             	mov    0x8(%ebp),%eax
80103678:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
8010367f:	00 00 00 
    wakeup(&p->nwrite);
80103682:	8b 45 08             	mov    0x8(%ebp),%eax
80103685:	05 38 02 00 00       	add    $0x238,%eax
8010368a:	83 ec 0c             	sub    $0xc,%esp
8010368d:	50                   	push   %eax
8010368e:	e8 cf 0c 00 00       	call   80104362 <wakeup>
80103693:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103696:	8b 45 08             	mov    0x8(%ebp),%eax
80103699:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010369f:	85 c0                	test   %eax,%eax
801036a1:	75 2c                	jne    801036cf <pipeclose+0x98>
801036a3:	8b 45 08             	mov    0x8(%ebp),%eax
801036a6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801036ac:	85 c0                	test   %eax,%eax
801036ae:	75 1f                	jne    801036cf <pipeclose+0x98>
    release(&p->lock);
801036b0:	8b 45 08             	mov    0x8(%ebp),%eax
801036b3:	83 ec 0c             	sub    $0xc,%esp
801036b6:	50                   	push   %eax
801036b7:	e8 47 10 00 00       	call   80104703 <release>
801036bc:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
801036bf:	83 ec 0c             	sub    $0xc,%esp
801036c2:	ff 75 08             	pushl  0x8(%ebp)
801036c5:	e8 d0 ef ff ff       	call   8010269a <kfree>
801036ca:	83 c4 10             	add    $0x10,%esp
801036cd:	eb 10                	jmp    801036df <pipeclose+0xa8>
  } else
    release(&p->lock);
801036cf:	8b 45 08             	mov    0x8(%ebp),%eax
801036d2:	83 ec 0c             	sub    $0xc,%esp
801036d5:	50                   	push   %eax
801036d6:	e8 28 10 00 00       	call   80104703 <release>
801036db:	83 c4 10             	add    $0x10,%esp
}
801036de:	90                   	nop
801036df:	90                   	nop
801036e0:	c9                   	leave  
801036e1:	c3                   	ret    

801036e2 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801036e2:	55                   	push   %ebp
801036e3:	89 e5                	mov    %esp,%ebp
801036e5:	53                   	push   %ebx
801036e6:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
801036e9:	8b 45 08             	mov    0x8(%ebp),%eax
801036ec:	83 ec 0c             	sub    $0xc,%esp
801036ef:	50                   	push   %eax
801036f0:	e8 a0 0f 00 00       	call   80104695 <acquire>
801036f5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
801036f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801036ff:	e9 ab 00 00 00       	jmp    801037af <pipewrite+0xcd>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
80103704:	8b 45 08             	mov    0x8(%ebp),%eax
80103707:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010370d:	85 c0                	test   %eax,%eax
8010370f:	74 0c                	je     8010371d <pipewrite+0x3b>
80103711:	e8 c0 02 00 00       	call   801039d6 <myproc>
80103716:	8b 40 24             	mov    0x24(%eax),%eax
80103719:	85 c0                	test   %eax,%eax
8010371b:	74 19                	je     80103736 <pipewrite+0x54>
        release(&p->lock);
8010371d:	8b 45 08             	mov    0x8(%ebp),%eax
80103720:	83 ec 0c             	sub    $0xc,%esp
80103723:	50                   	push   %eax
80103724:	e8 da 0f 00 00       	call   80104703 <release>
80103729:	83 c4 10             	add    $0x10,%esp
        return -1;
8010372c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103731:	e9 a7 00 00 00       	jmp    801037dd <pipewrite+0xfb>
      }
      wakeup(&p->nread);
80103736:	8b 45 08             	mov    0x8(%ebp),%eax
80103739:	05 34 02 00 00       	add    $0x234,%eax
8010373e:	83 ec 0c             	sub    $0xc,%esp
80103741:	50                   	push   %eax
80103742:	e8 1b 0c 00 00       	call   80104362 <wakeup>
80103747:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010374a:	8b 45 08             	mov    0x8(%ebp),%eax
8010374d:	8b 55 08             	mov    0x8(%ebp),%edx
80103750:	81 c2 38 02 00 00    	add    $0x238,%edx
80103756:	83 ec 08             	sub    $0x8,%esp
80103759:	50                   	push   %eax
8010375a:	52                   	push   %edx
8010375b:	e8 1b 0b 00 00       	call   8010427b <sleep>
80103760:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103763:	8b 45 08             	mov    0x8(%ebp),%eax
80103766:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
8010376c:	8b 45 08             	mov    0x8(%ebp),%eax
8010376f:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103775:	05 00 02 00 00       	add    $0x200,%eax
8010377a:	39 c2                	cmp    %eax,%edx
8010377c:	74 86                	je     80103704 <pipewrite+0x22>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010377e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103781:	8b 45 0c             	mov    0xc(%ebp),%eax
80103784:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80103787:	8b 45 08             	mov    0x8(%ebp),%eax
8010378a:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103790:	8d 48 01             	lea    0x1(%eax),%ecx
80103793:	8b 55 08             	mov    0x8(%ebp),%edx
80103796:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
8010379c:	25 ff 01 00 00       	and    $0x1ff,%eax
801037a1:	89 c1                	mov    %eax,%ecx
801037a3:	8a 13                	mov    (%ebx),%dl
801037a5:	8b 45 08             	mov    0x8(%ebp),%eax
801037a8:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
  for(i = 0; i < n; i++){
801037ac:	ff 45 f4             	incl   -0xc(%ebp)
801037af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037b2:	3b 45 10             	cmp    0x10(%ebp),%eax
801037b5:	7c ac                	jl     80103763 <pipewrite+0x81>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801037b7:	8b 45 08             	mov    0x8(%ebp),%eax
801037ba:	05 34 02 00 00       	add    $0x234,%eax
801037bf:	83 ec 0c             	sub    $0xc,%esp
801037c2:	50                   	push   %eax
801037c3:	e8 9a 0b 00 00       	call   80104362 <wakeup>
801037c8:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801037cb:	8b 45 08             	mov    0x8(%ebp),%eax
801037ce:	83 ec 0c             	sub    $0xc,%esp
801037d1:	50                   	push   %eax
801037d2:	e8 2c 0f 00 00       	call   80104703 <release>
801037d7:	83 c4 10             	add    $0x10,%esp
  return n;
801037da:	8b 45 10             	mov    0x10(%ebp),%eax
}
801037dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037e0:	c9                   	leave  
801037e1:	c3                   	ret    

801037e2 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801037e2:	55                   	push   %ebp
801037e3:	89 e5                	mov    %esp,%ebp
801037e5:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801037e8:	8b 45 08             	mov    0x8(%ebp),%eax
801037eb:	83 ec 0c             	sub    $0xc,%esp
801037ee:	50                   	push   %eax
801037ef:	e8 a1 0e 00 00       	call   80104695 <acquire>
801037f4:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037f7:	eb 3e                	jmp    80103837 <piperead+0x55>
    if(myproc()->killed){
801037f9:	e8 d8 01 00 00       	call   801039d6 <myproc>
801037fe:	8b 40 24             	mov    0x24(%eax),%eax
80103801:	85 c0                	test   %eax,%eax
80103803:	74 19                	je     8010381e <piperead+0x3c>
      release(&p->lock);
80103805:	8b 45 08             	mov    0x8(%ebp),%eax
80103808:	83 ec 0c             	sub    $0xc,%esp
8010380b:	50                   	push   %eax
8010380c:	e8 f2 0e 00 00       	call   80104703 <release>
80103811:	83 c4 10             	add    $0x10,%esp
      return -1;
80103814:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103819:	e9 bc 00 00 00       	jmp    801038da <piperead+0xf8>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010381e:	8b 45 08             	mov    0x8(%ebp),%eax
80103821:	8b 55 08             	mov    0x8(%ebp),%edx
80103824:	81 c2 34 02 00 00    	add    $0x234,%edx
8010382a:	83 ec 08             	sub    $0x8,%esp
8010382d:	50                   	push   %eax
8010382e:	52                   	push   %edx
8010382f:	e8 47 0a 00 00       	call   8010427b <sleep>
80103834:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103837:	8b 45 08             	mov    0x8(%ebp),%eax
8010383a:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103840:	8b 45 08             	mov    0x8(%ebp),%eax
80103843:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103849:	39 c2                	cmp    %eax,%edx
8010384b:	75 0d                	jne    8010385a <piperead+0x78>
8010384d:	8b 45 08             	mov    0x8(%ebp),%eax
80103850:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103856:	85 c0                	test   %eax,%eax
80103858:	75 9f                	jne    801037f9 <piperead+0x17>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010385a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103861:	eb 46                	jmp    801038a9 <piperead+0xc7>
    if(p->nread == p->nwrite)
80103863:	8b 45 08             	mov    0x8(%ebp),%eax
80103866:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010386c:	8b 45 08             	mov    0x8(%ebp),%eax
8010386f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103875:	39 c2                	cmp    %eax,%edx
80103877:	74 3a                	je     801038b3 <piperead+0xd1>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103879:	8b 45 08             	mov    0x8(%ebp),%eax
8010387c:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103882:	8d 48 01             	lea    0x1(%eax),%ecx
80103885:	8b 55 08             	mov    0x8(%ebp),%edx
80103888:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
8010388e:	25 ff 01 00 00       	and    $0x1ff,%eax
80103893:	89 c1                	mov    %eax,%ecx
80103895:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103898:	8b 45 0c             	mov    0xc(%ebp),%eax
8010389b:	01 c2                	add    %eax,%edx
8010389d:	8b 45 08             	mov    0x8(%ebp),%eax
801038a0:	8a 44 08 34          	mov    0x34(%eax,%ecx,1),%al
801038a4:	88 02                	mov    %al,(%edx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801038a6:	ff 45 f4             	incl   -0xc(%ebp)
801038a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038ac:	3b 45 10             	cmp    0x10(%ebp),%eax
801038af:	7c b2                	jl     80103863 <piperead+0x81>
801038b1:	eb 01                	jmp    801038b4 <piperead+0xd2>
      break;
801038b3:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801038b4:	8b 45 08             	mov    0x8(%ebp),%eax
801038b7:	05 38 02 00 00       	add    $0x238,%eax
801038bc:	83 ec 0c             	sub    $0xc,%esp
801038bf:	50                   	push   %eax
801038c0:	e8 9d 0a 00 00       	call   80104362 <wakeup>
801038c5:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801038c8:	8b 45 08             	mov    0x8(%ebp),%eax
801038cb:	83 ec 0c             	sub    $0xc,%esp
801038ce:	50                   	push   %eax
801038cf:	e8 2f 0e 00 00       	call   80104703 <release>
801038d4:	83 c4 10             	add    $0x10,%esp
  return i;
801038d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801038da:	c9                   	leave  
801038db:	c3                   	ret    

801038dc <readeflags>:
{
801038dc:	55                   	push   %ebp
801038dd:	89 e5                	mov    %esp,%ebp
801038df:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038e2:	9c                   	pushf  
801038e3:	58                   	pop    %eax
801038e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801038e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801038ea:	c9                   	leave  
801038eb:	c3                   	ret    

801038ec <sti>:
{
801038ec:	55                   	push   %ebp
801038ed:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801038ef:	fb                   	sti    
}
801038f0:	90                   	nop
801038f1:	5d                   	pop    %ebp
801038f2:	c3                   	ret    

801038f3 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801038f3:	55                   	push   %ebp
801038f4:	89 e5                	mov    %esp,%ebp
801038f6:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
801038f9:	83 ec 08             	sub    $0x8,%esp
801038fc:	68 b0 a0 10 80       	push   $0x8010a0b0
80103901:	68 00 32 19 80       	push   $0x80193200
80103906:	e8 68 0d 00 00       	call   80104673 <initlock>
8010390b:	83 c4 10             	add    $0x10,%esp
}
8010390e:	90                   	nop
8010390f:	c9                   	leave  
80103910:	c3                   	ret    

80103911 <cpuid>:

// Must be called with interrupts disabled
int
cpuid() {
80103911:	55                   	push   %ebp
80103912:	89 e5                	mov    %esp,%ebp
80103914:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103917:	e8 34 00 00 00       	call   80103950 <mycpu>
8010391c:	2d 80 59 19 80       	sub    $0x80195980,%eax
80103921:	c1 f8 04             	sar    $0x4,%eax
80103924:	89 c1                	mov    %eax,%ecx
80103926:	89 ca                	mov    %ecx,%edx
80103928:	c1 e2 03             	shl    $0x3,%edx
8010392b:	01 ca                	add    %ecx,%edx
8010392d:	89 d0                	mov    %edx,%eax
8010392f:	c1 e0 05             	shl    $0x5,%eax
80103932:	29 d0                	sub    %edx,%eax
80103934:	c1 e0 02             	shl    $0x2,%eax
80103937:	01 c8                	add    %ecx,%eax
80103939:	c1 e0 03             	shl    $0x3,%eax
8010393c:	01 c8                	add    %ecx,%eax
8010393e:	89 c2                	mov    %eax,%edx
80103940:	c1 e2 0f             	shl    $0xf,%edx
80103943:	29 c2                	sub    %eax,%edx
80103945:	c1 e2 02             	shl    $0x2,%edx
80103948:	01 ca                	add    %ecx,%edx
8010394a:	89 d0                	mov    %edx,%eax
8010394c:	f7 d8                	neg    %eax
}
8010394e:	c9                   	leave  
8010394f:	c3                   	ret    

80103950 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	83 ec 18             	sub    $0x18,%esp
  int apicid, i;
  
  if(readeflags()&FL_IF){
80103956:	e8 81 ff ff ff       	call   801038dc <readeflags>
8010395b:	25 00 02 00 00       	and    $0x200,%eax
80103960:	85 c0                	test   %eax,%eax
80103962:	74 0d                	je     80103971 <mycpu+0x21>
    panic("mycpu called with interrupts enabled\n");
80103964:	83 ec 0c             	sub    $0xc,%esp
80103967:	68 b8 a0 10 80       	push   $0x8010a0b8
8010396c:	e8 2e cc ff ff       	call   8010059f <panic>
  }

  apicid = lapicid();
80103971:	e8 0d f1 ff ff       	call   80102a83 <lapicid>
80103976:	89 45 f0             	mov    %eax,-0x10(%ebp)
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103979:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103980:	eb 3b                	jmp    801039bd <mycpu+0x6d>
    if (cpus[i].apicid == apicid){
80103982:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103985:	89 d0                	mov    %edx,%eax
80103987:	c1 e0 02             	shl    $0x2,%eax
8010398a:	01 d0                	add    %edx,%eax
8010398c:	01 c0                	add    %eax,%eax
8010398e:	01 d0                	add    %edx,%eax
80103990:	c1 e0 04             	shl    $0x4,%eax
80103993:	05 80 59 19 80       	add    $0x80195980,%eax
80103998:	8a 00                	mov    (%eax),%al
8010399a:	0f b6 c0             	movzbl %al,%eax
8010399d:	39 45 f0             	cmp    %eax,-0x10(%ebp)
801039a0:	75 18                	jne    801039ba <mycpu+0x6a>
      return &cpus[i];
801039a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801039a5:	89 d0                	mov    %edx,%eax
801039a7:	c1 e0 02             	shl    $0x2,%eax
801039aa:	01 d0                	add    %edx,%eax
801039ac:	01 c0                	add    %eax,%eax
801039ae:	01 d0                	add    %edx,%eax
801039b0:	c1 e0 04             	shl    $0x4,%eax
801039b3:	05 80 59 19 80       	add    $0x80195980,%eax
801039b8:	eb 1a                	jmp    801039d4 <mycpu+0x84>
  for (i = 0; i < ncpu; ++i) {
801039ba:	ff 45 f4             	incl   -0xc(%ebp)
801039bd:	a1 40 5c 19 80       	mov    0x80195c40,%eax
801039c2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801039c5:	7c bb                	jl     80103982 <mycpu+0x32>
    }
  }
  panic("unknown apicid\n");
801039c7:	83 ec 0c             	sub    $0xc,%esp
801039ca:	68 de a0 10 80       	push   $0x8010a0de
801039cf:	e8 cb cb ff ff       	call   8010059f <panic>
}
801039d4:	c9                   	leave  
801039d5:	c3                   	ret    

801039d6 <myproc>:

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801039d6:	55                   	push   %ebp
801039d7:	89 e5                	mov    %esp,%ebp
801039d9:	83 ec 18             	sub    $0x18,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801039dc:	e8 1d 0e 00 00       	call   801047fe <pushcli>
  c = mycpu();
801039e1:	e8 6a ff ff ff       	call   80103950 <mycpu>
801039e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  p = c->proc;
801039e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039ec:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801039f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  popcli();
801039f5:	e8 4f 0e 00 00       	call   80104849 <popcli>
  return p;
801039fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801039fd:	c9                   	leave  
801039fe:	c3                   	ret    

801039ff <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801039ff:	55                   	push   %ebp
80103a00:	89 e5                	mov    %esp,%ebp
80103a02:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80103a05:	83 ec 0c             	sub    $0xc,%esp
80103a08:	68 00 32 19 80       	push   $0x80193200
80103a0d:	e8 83 0c 00 00       	call   80104695 <acquire>
80103a12:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a15:	c7 45 f4 34 32 19 80 	movl   $0x80193234,-0xc(%ebp)
80103a1c:	eb 0e                	jmp    80103a2c <allocproc+0x2d>
    if(p->state == UNUSED){
80103a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a21:	8b 40 0c             	mov    0xc(%eax),%eax
80103a24:	85 c0                	test   %eax,%eax
80103a26:	74 27                	je     80103a4f <allocproc+0x50>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a28:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80103a2c:	81 7d f4 34 51 19 80 	cmpl   $0x80195134,-0xc(%ebp)
80103a33:	72 e9                	jb     80103a1e <allocproc+0x1f>
      goto found;
    }

  release(&ptable.lock);
80103a35:	83 ec 0c             	sub    $0xc,%esp
80103a38:	68 00 32 19 80       	push   $0x80193200
80103a3d:	e8 c1 0c 00 00       	call   80104703 <release>
80103a42:	83 c4 10             	add    $0x10,%esp
  return 0;
80103a45:	b8 00 00 00 00       	mov    $0x0,%eax
80103a4a:	e9 b2 00 00 00       	jmp    80103b01 <allocproc+0x102>
      goto found;
80103a4f:	90                   	nop

found:
  p->state = EMBRYO;
80103a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a53:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80103a5a:	a1 00 e0 10 80       	mov    0x8010e000,%eax
80103a5f:	8d 50 01             	lea    0x1(%eax),%edx
80103a62:	89 15 00 e0 10 80    	mov    %edx,0x8010e000
80103a68:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103a6b:	89 42 10             	mov    %eax,0x10(%edx)

  release(&ptable.lock);
80103a6e:	83 ec 0c             	sub    $0xc,%esp
80103a71:	68 00 32 19 80       	push   $0x80193200
80103a76:	e8 88 0c 00 00       	call   80104703 <release>
80103a7b:	83 c4 10             	add    $0x10,%esp


  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103a7e:	e8 b1 ec ff ff       	call   80102734 <kalloc>
80103a83:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103a86:	89 42 08             	mov    %eax,0x8(%edx)
80103a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a8c:	8b 40 08             	mov    0x8(%eax),%eax
80103a8f:	85 c0                	test   %eax,%eax
80103a91:	75 11                	jne    80103aa4 <allocproc+0xa5>
    p->state = UNUSED;
80103a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a96:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80103a9d:	b8 00 00 00 00       	mov    $0x0,%eax
80103aa2:	eb 5d                	jmp    80103b01 <allocproc+0x102>
  }
  sp = p->kstack + KSTACKSIZE;
80103aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aa7:	8b 40 08             	mov    0x8(%eax),%eax
80103aaa:	05 00 10 00 00       	add    $0x1000,%eax
80103aaf:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103ab2:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
80103ab6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ab9:	8b 55 f0             	mov    -0x10(%ebp),%edx
80103abc:	89 50 18             	mov    %edx,0x18(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80103abf:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
80103ac3:	ba 5a 5c 10 80       	mov    $0x80105c5a,%edx
80103ac8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103acb:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80103acd:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80103ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ad4:	8b 55 f0             	mov    -0x10(%ebp),%edx
80103ad7:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80103ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103add:	8b 40 1c             	mov    0x1c(%eax),%eax
80103ae0:	83 ec 04             	sub    $0x4,%esp
80103ae3:	6a 14                	push   $0x14
80103ae5:	6a 00                	push   $0x0
80103ae7:	50                   	push   %eax
80103ae8:	e8 18 0e 00 00       	call   80104905 <memset>
80103aed:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103af0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103af3:	8b 40 1c             	mov    0x1c(%eax),%eax
80103af6:	ba 35 42 10 80       	mov    $0x80104235,%edx
80103afb:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80103afe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103b01:	c9                   	leave  
80103b02:	c3                   	ret    

80103b03 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103b03:	55                   	push   %ebp
80103b04:	89 e5                	mov    %esp,%ebp
80103b06:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103b09:	e8 f1 fe ff ff       	call   801039ff <allocproc>
80103b0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  initproc = p;
80103b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b14:	a3 34 51 19 80       	mov    %eax,0x80195134
  if((p->pgdir = setupkvm()) == 0){
80103b19:	e8 4e 36 00 00       	call   8010716c <setupkvm>
80103b1e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103b21:	89 42 04             	mov    %eax,0x4(%edx)
80103b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b27:	8b 40 04             	mov    0x4(%eax),%eax
80103b2a:	85 c0                	test   %eax,%eax
80103b2c:	75 0d                	jne    80103b3b <userinit+0x38>
    panic("userinit: out of memory?");
80103b2e:	83 ec 0c             	sub    $0xc,%esp
80103b31:	68 ee a0 10 80       	push   $0x8010a0ee
80103b36:	e8 64 ca ff ff       	call   8010059f <panic>
  }
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b3b:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b43:	8b 40 04             	mov    0x4(%eax),%eax
80103b46:	83 ec 04             	sub    $0x4,%esp
80103b49:	52                   	push   %edx
80103b4a:	68 ec e4 10 80       	push   $0x8010e4ec
80103b4f:	50                   	push   %eax
80103b50:	e8 c7 38 00 00       	call   8010741c <inituvm>
80103b55:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80103b58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b5b:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80103b61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b64:	8b 40 18             	mov    0x18(%eax),%eax
80103b67:	83 ec 04             	sub    $0x4,%esp
80103b6a:	6a 4c                	push   $0x4c
80103b6c:	6a 00                	push   $0x0
80103b6e:	50                   	push   %eax
80103b6f:	e8 91 0d 00 00       	call   80104905 <memset>
80103b74:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b7a:	8b 40 18             	mov    0x18(%eax),%eax
80103b7d:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b86:	8b 40 18             	mov    0x18(%eax),%eax
80103b89:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b92:	8b 40 18             	mov    0x18(%eax),%eax
80103b95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103b98:	8b 52 18             	mov    0x18(%edx),%edx
80103b9b:	8b 40 2c             	mov    0x2c(%eax),%eax
80103b9e:	66 89 42 28          	mov    %ax,0x28(%edx)
  p->tf->ss = p->tf->ds;
80103ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ba5:	8b 40 18             	mov    0x18(%eax),%eax
80103ba8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103bab:	8b 52 18             	mov    0x18(%edx),%edx
80103bae:	8b 40 2c             	mov    0x2c(%eax),%eax
80103bb1:	66 89 42 48          	mov    %ax,0x48(%edx)
  p->tf->eflags = FL_IF;
80103bb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bb8:	8b 40 18             	mov    0x18(%eax),%eax
80103bbb:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103bc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bc5:	8b 40 18             	mov    0x18(%eax),%eax
80103bc8:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bd2:	8b 40 18             	mov    0x18(%eax),%eax
80103bd5:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bdf:	83 c0 6c             	add    $0x6c,%eax
80103be2:	83 ec 04             	sub    $0x4,%esp
80103be5:	6a 10                	push   $0x10
80103be7:	68 07 a1 10 80       	push   $0x8010a107
80103bec:	50                   	push   %eax
80103bed:	e8 02 0f 00 00       	call   80104af4 <safestrcpy>
80103bf2:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80103bf5:	83 ec 0c             	sub    $0xc,%esp
80103bf8:	68 10 a1 10 80       	push   $0x8010a110
80103bfd:	e8 b6 e8 ff ff       	call   801024b8 <namei>
80103c02:	83 c4 10             	add    $0x10,%esp
80103c05:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c08:	89 42 68             	mov    %eax,0x68(%edx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103c0b:	83 ec 0c             	sub    $0xc,%esp
80103c0e:	68 00 32 19 80       	push   $0x80193200
80103c13:	e8 7d 0a 00 00       	call   80104695 <acquire>
80103c18:	83 c4 10             	add    $0x10,%esp

  p->state = RUNNABLE;
80103c1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c1e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80103c25:	83 ec 0c             	sub    $0xc,%esp
80103c28:	68 00 32 19 80       	push   $0x80193200
80103c2d:	e8 d1 0a 00 00       	call   80104703 <release>
80103c32:	83 c4 10             	add    $0x10,%esp
}
80103c35:	90                   	nop
80103c36:	c9                   	leave  
80103c37:	c3                   	ret    

80103c38 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103c38:	55                   	push   %ebp
80103c39:	89 e5                	mov    %esp,%ebp
80103c3b:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  struct proc *curproc = myproc();
80103c3e:	e8 93 fd ff ff       	call   801039d6 <myproc>
80103c43:	89 45 f0             	mov    %eax,-0x10(%ebp)

  sz = curproc->sz;
80103c46:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c49:	8b 00                	mov    (%eax),%eax
80103c4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80103c4e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80103c52:	7e 2e                	jle    80103c82 <growproc+0x4a>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c54:	8b 55 08             	mov    0x8(%ebp),%edx
80103c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c5a:	01 c2                	add    %eax,%edx
80103c5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c5f:	8b 40 04             	mov    0x4(%eax),%eax
80103c62:	83 ec 04             	sub    $0x4,%esp
80103c65:	52                   	push   %edx
80103c66:	ff 75 f4             	pushl  -0xc(%ebp)
80103c69:	50                   	push   %eax
80103c6a:	e8 e9 38 00 00       	call   80107558 <allocuvm>
80103c6f:	83 c4 10             	add    $0x10,%esp
80103c72:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c75:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c79:	75 3b                	jne    80103cb6 <growproc+0x7e>
      return -1;
80103c7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c80:	eb 4f                	jmp    80103cd1 <growproc+0x99>
  } else if(n < 0){
80103c82:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80103c86:	79 2e                	jns    80103cb6 <growproc+0x7e>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c88:	8b 55 08             	mov    0x8(%ebp),%edx
80103c8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c8e:	01 c2                	add    %eax,%edx
80103c90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c93:	8b 40 04             	mov    0x4(%eax),%eax
80103c96:	83 ec 04             	sub    $0x4,%esp
80103c99:	52                   	push   %edx
80103c9a:	ff 75 f4             	pushl  -0xc(%ebp)
80103c9d:	50                   	push   %eax
80103c9e:	e8 ba 39 00 00       	call   8010765d <deallocuvm>
80103ca3:	83 c4 10             	add    $0x10,%esp
80103ca6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103ca9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103cad:	75 07                	jne    80103cb6 <growproc+0x7e>
      return -1;
80103caf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cb4:	eb 1b                	jmp    80103cd1 <growproc+0x99>
  }
  curproc->sz = sz;
80103cb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cbc:	89 10                	mov    %edx,(%eax)
  switchuvm(curproc);
80103cbe:	83 ec 0c             	sub    $0xc,%esp
80103cc1:	ff 75 f0             	pushl  -0x10(%ebp)
80103cc4:	e8 c1 35 00 00       	call   8010728a <switchuvm>
80103cc9:	83 c4 10             	add    $0x10,%esp
  return 0;
80103ccc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103cd1:	c9                   	leave  
80103cd2:	c3                   	ret    

80103cd3 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103cd3:	55                   	push   %ebp
80103cd4:	89 e5                	mov    %esp,%ebp
80103cd6:	57                   	push   %edi
80103cd7:	56                   	push   %esi
80103cd8:	53                   	push   %ebx
80103cd9:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
80103cdc:	e8 f5 fc ff ff       	call   801039d6 <myproc>
80103ce1:	89 45 e0             	mov    %eax,-0x20(%ebp)

  // Allocate process.
  if((np = allocproc()) == 0){
80103ce4:	e8 16 fd ff ff       	call   801039ff <allocproc>
80103ce9:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103cec:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
80103cf0:	75 0a                	jne    80103cfc <fork+0x29>
    return -1;
80103cf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cf7:	e9 47 01 00 00       	jmp    80103e43 <fork+0x170>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103cfc:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103cff:	8b 10                	mov    (%eax),%edx
80103d01:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d04:	8b 40 04             	mov    0x4(%eax),%eax
80103d07:	83 ec 08             	sub    $0x8,%esp
80103d0a:	52                   	push   %edx
80103d0b:	50                   	push   %eax
80103d0c:	e8 e7 3a 00 00       	call   801077f8 <copyuvm>
80103d11:	83 c4 10             	add    $0x10,%esp
80103d14:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103d17:	89 42 04             	mov    %eax,0x4(%edx)
80103d1a:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d1d:	8b 40 04             	mov    0x4(%eax),%eax
80103d20:	85 c0                	test   %eax,%eax
80103d22:	75 30                	jne    80103d54 <fork+0x81>
    kfree(np->kstack);
80103d24:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d27:	8b 40 08             	mov    0x8(%eax),%eax
80103d2a:	83 ec 0c             	sub    $0xc,%esp
80103d2d:	50                   	push   %eax
80103d2e:	e8 67 e9 ff ff       	call   8010269a <kfree>
80103d33:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80103d36:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d39:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80103d40:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d43:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80103d4a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d4f:	e9 ef 00 00 00       	jmp    80103e43 <fork+0x170>
  }
  np->sz = curproc->sz;
80103d54:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d57:	8b 10                	mov    (%eax),%edx
80103d59:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d5c:	89 10                	mov    %edx,(%eax)
  np->parent = curproc;
80103d5e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d61:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103d64:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *curproc->tf;
80103d67:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d6a:	8b 48 18             	mov    0x18(%eax),%ecx
80103d6d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d70:	8b 40 18             	mov    0x18(%eax),%eax
80103d73:	89 c2                	mov    %eax,%edx
80103d75:	89 cb                	mov    %ecx,%ebx
80103d77:	b8 13 00 00 00       	mov    $0x13,%eax
80103d7c:	89 d7                	mov    %edx,%edi
80103d7e:	89 de                	mov    %ebx,%esi
80103d80:	89 c1                	mov    %eax,%ecx
80103d82:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103d84:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d87:	8b 40 18             	mov    0x18(%eax),%eax
80103d8a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80103d91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80103d98:	eb 3a                	jmp    80103dd4 <fork+0x101>
    if(curproc->ofile[i])
80103d9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103d9d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103da0:	83 c2 08             	add    $0x8,%edx
80103da3:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80103da7:	85 c0                	test   %eax,%eax
80103da9:	74 26                	je     80103dd1 <fork+0xfe>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103dab:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103dae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103db1:	83 c2 08             	add    $0x8,%edx
80103db4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80103db8:	83 ec 0c             	sub    $0xc,%esp
80103dbb:	50                   	push   %eax
80103dbc:	e8 4e d2 ff ff       	call   8010100f <filedup>
80103dc1:	83 c4 10             	add    $0x10,%esp
80103dc4:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103dc7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103dca:	83 c1 08             	add    $0x8,%ecx
80103dcd:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  for(i = 0; i < NOFILE; i++)
80103dd1:	ff 45 e4             	incl   -0x1c(%ebp)
80103dd4:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80103dd8:	7e c0                	jle    80103d9a <fork+0xc7>
  np->cwd = idup(curproc->cwd);
80103dda:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103ddd:	8b 40 68             	mov    0x68(%eax),%eax
80103de0:	83 ec 0c             	sub    $0xc,%esp
80103de3:	50                   	push   %eax
80103de4:	e8 6b db ff ff       	call   80101954 <idup>
80103de9:	83 c4 10             	add    $0x10,%esp
80103dec:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103def:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103df2:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103df5:	8d 50 6c             	lea    0x6c(%eax),%edx
80103df8:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103dfb:	83 c0 6c             	add    $0x6c,%eax
80103dfe:	83 ec 04             	sub    $0x4,%esp
80103e01:	6a 10                	push   $0x10
80103e03:	52                   	push   %edx
80103e04:	50                   	push   %eax
80103e05:	e8 ea 0c 00 00       	call   80104af4 <safestrcpy>
80103e0a:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
80103e0d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103e10:	8b 40 10             	mov    0x10(%eax),%eax
80103e13:	89 45 d8             	mov    %eax,-0x28(%ebp)

  acquire(&ptable.lock);
80103e16:	83 ec 0c             	sub    $0xc,%esp
80103e19:	68 00 32 19 80       	push   $0x80193200
80103e1e:	e8 72 08 00 00       	call   80104695 <acquire>
80103e23:	83 c4 10             	add    $0x10,%esp

  np->state = RUNNABLE;
80103e26:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103e29:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80103e30:	83 ec 0c             	sub    $0xc,%esp
80103e33:	68 00 32 19 80       	push   $0x80193200
80103e38:	e8 c6 08 00 00       	call   80104703 <release>
80103e3d:	83 c4 10             	add    $0x10,%esp

  return pid;
80103e40:	8b 45 d8             	mov    -0x28(%ebp),%eax
}
80103e43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e46:	5b                   	pop    %ebx
80103e47:	5e                   	pop    %esi
80103e48:	5f                   	pop    %edi
80103e49:	5d                   	pop    %ebp
80103e4a:	c3                   	ret    

80103e4b <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103e4b:	55                   	push   %ebp
80103e4c:	89 e5                	mov    %esp,%ebp
80103e4e:	83 ec 18             	sub    $0x18,%esp
  struct proc *curproc = myproc();
80103e51:	e8 80 fb ff ff       	call   801039d6 <myproc>
80103e56:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103e59:	a1 34 51 19 80       	mov    0x80195134,%eax
80103e5e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80103e61:	75 0d                	jne    80103e70 <exit+0x25>
    panic("init exiting");
80103e63:	83 ec 0c             	sub    $0xc,%esp
80103e66:	68 12 a1 10 80       	push   $0x8010a112
80103e6b:	e8 2f c7 ff ff       	call   8010059f <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103e70:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80103e77:	eb 3e                	jmp    80103eb7 <exit+0x6c>
    if(curproc->ofile[fd]){
80103e79:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103e7c:	8b 55 f0             	mov    -0x10(%ebp),%edx
80103e7f:	83 c2 08             	add    $0x8,%edx
80103e82:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80103e86:	85 c0                	test   %eax,%eax
80103e88:	74 2a                	je     80103eb4 <exit+0x69>
      fileclose(curproc->ofile[fd]);
80103e8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103e8d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80103e90:	83 c2 08             	add    $0x8,%edx
80103e93:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80103e97:	83 ec 0c             	sub    $0xc,%esp
80103e9a:	50                   	push   %eax
80103e9b:	e8 c0 d1 ff ff       	call   80101060 <fileclose>
80103ea0:	83 c4 10             	add    $0x10,%esp
      curproc->ofile[fd] = 0;
80103ea3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103ea6:	8b 55 f0             	mov    -0x10(%ebp),%edx
80103ea9:	83 c2 08             	add    $0x8,%edx
80103eac:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80103eb3:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103eb4:	ff 45 f0             	incl   -0x10(%ebp)
80103eb7:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80103ebb:	7e bc                	jle    80103e79 <exit+0x2e>
    }
  }

  begin_op();
80103ebd:	e8 f7 f0 ff ff       	call   80102fb9 <begin_op>
  iput(curproc->cwd);
80103ec2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103ec5:	8b 40 68             	mov    0x68(%eax),%eax
80103ec8:	83 ec 0c             	sub    $0xc,%esp
80103ecb:	50                   	push   %eax
80103ecc:	e8 1b dc ff ff       	call   80101aec <iput>
80103ed1:	83 c4 10             	add    $0x10,%esp
  end_op();
80103ed4:	e8 6a f1 ff ff       	call   80103043 <end_op>
  curproc->cwd = 0;
80103ed9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103edc:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80103ee3:	83 ec 0c             	sub    $0xc,%esp
80103ee6:	68 00 32 19 80       	push   $0x80193200
80103eeb:	e8 a5 07 00 00       	call   80104695 <acquire>
80103ef0:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103ef3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103ef6:	8b 40 14             	mov    0x14(%eax),%eax
80103ef9:	83 ec 0c             	sub    $0xc,%esp
80103efc:	50                   	push   %eax
80103efd:	e8 20 04 00 00       	call   80104322 <wakeup1>
80103f02:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f05:	c7 45 f4 34 32 19 80 	movl   $0x80193234,-0xc(%ebp)
80103f0c:	eb 37                	jmp    80103f45 <exit+0xfa>
    if(p->parent == curproc){
80103f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f11:	8b 40 14             	mov    0x14(%eax),%eax
80103f14:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80103f17:	75 28                	jne    80103f41 <exit+0xf6>
      p->parent = initproc;
80103f19:	8b 15 34 51 19 80    	mov    0x80195134,%edx
80103f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f22:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80103f25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f28:	8b 40 0c             	mov    0xc(%eax),%eax
80103f2b:	83 f8 05             	cmp    $0x5,%eax
80103f2e:	75 11                	jne    80103f41 <exit+0xf6>
        wakeup1(initproc);
80103f30:	a1 34 51 19 80       	mov    0x80195134,%eax
80103f35:	83 ec 0c             	sub    $0xc,%esp
80103f38:	50                   	push   %eax
80103f39:	e8 e4 03 00 00       	call   80104322 <wakeup1>
80103f3e:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f41:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80103f45:	81 7d f4 34 51 19 80 	cmpl   $0x80195134,-0xc(%ebp)
80103f4c:	72 c0                	jb     80103f0e <exit+0xc3>
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103f4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103f51:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80103f58:	e8 e5 01 00 00       	call   80104142 <sched>
  panic("zombie exit");
80103f5d:	83 ec 0c             	sub    $0xc,%esp
80103f60:	68 1f a1 10 80       	push   $0x8010a11f
80103f65:	e8 35 c6 ff ff       	call   8010059f <panic>

80103f6a <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103f6a:	55                   	push   %ebp
80103f6b:	89 e5                	mov    %esp,%ebp
80103f6d:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103f70:	e8 61 fa ff ff       	call   801039d6 <myproc>
80103f75:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
  acquire(&ptable.lock);
80103f78:	83 ec 0c             	sub    $0xc,%esp
80103f7b:	68 00 32 19 80       	push   $0x80193200
80103f80:	e8 10 07 00 00       	call   80104695 <acquire>
80103f85:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103f88:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f8f:	c7 45 f4 34 32 19 80 	movl   $0x80193234,-0xc(%ebp)
80103f96:	e9 a1 00 00 00       	jmp    8010403c <wait+0xd2>
      if(p->parent != curproc)
80103f9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f9e:	8b 40 14             	mov    0x14(%eax),%eax
80103fa1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80103fa4:	0f 85 8d 00 00 00    	jne    80104037 <wait+0xcd>
        continue;
      havekids = 1;
80103faa:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80103fb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fb4:	8b 40 0c             	mov    0xc(%eax),%eax
80103fb7:	83 f8 05             	cmp    $0x5,%eax
80103fba:	75 7c                	jne    80104038 <wait+0xce>
        // Found one.
        pid = p->pid;
80103fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fbf:	8b 40 10             	mov    0x10(%eax),%eax
80103fc2:	89 45 e8             	mov    %eax,-0x18(%ebp)
        kfree(p->kstack);
80103fc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fc8:	8b 40 08             	mov    0x8(%eax),%eax
80103fcb:	83 ec 0c             	sub    $0xc,%esp
80103fce:	50                   	push   %eax
80103fcf:	e8 c6 e6 ff ff       	call   8010269a <kfree>
80103fd4:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80103fd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fda:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80103fe1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fe4:	8b 40 04             	mov    0x4(%eax),%eax
80103fe7:	83 ec 0c             	sub    $0xc,%esp
80103fea:	50                   	push   %eax
80103feb:	e8 2f 37 00 00       	call   8010771f <freevm>
80103ff0:	83 c4 10             	add    $0x10,%esp
        p->pid = 0;
80103ff3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ff6:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80103ffd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104000:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104007:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010400a:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
8010400e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104011:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->state = UNUSED;
80104018:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010401b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        release(&ptable.lock);
80104022:	83 ec 0c             	sub    $0xc,%esp
80104025:	68 00 32 19 80       	push   $0x80193200
8010402a:	e8 d4 06 00 00       	call   80104703 <release>
8010402f:	83 c4 10             	add    $0x10,%esp
        return pid;
80104032:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104035:	eb 51                	jmp    80104088 <wait+0x11e>
        continue;
80104037:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104038:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010403c:	81 7d f4 34 51 19 80 	cmpl   $0x80195134,-0xc(%ebp)
80104043:	0f 82 52 ff ff ff    	jb     80103f9b <wait+0x31>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104049:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010404d:	74 0a                	je     80104059 <wait+0xef>
8010404f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104052:	8b 40 24             	mov    0x24(%eax),%eax
80104055:	85 c0                	test   %eax,%eax
80104057:	74 17                	je     80104070 <wait+0x106>
      release(&ptable.lock);
80104059:	83 ec 0c             	sub    $0xc,%esp
8010405c:	68 00 32 19 80       	push   $0x80193200
80104061:	e8 9d 06 00 00       	call   80104703 <release>
80104066:	83 c4 10             	add    $0x10,%esp
      return -1;
80104069:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010406e:	eb 18                	jmp    80104088 <wait+0x11e>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104070:	83 ec 08             	sub    $0x8,%esp
80104073:	68 00 32 19 80       	push   $0x80193200
80104078:	ff 75 ec             	pushl  -0x14(%ebp)
8010407b:	e8 fb 01 00 00       	call   8010427b <sleep>
80104080:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104083:	e9 00 ff ff ff       	jmp    80103f88 <wait+0x1e>
  }
}
80104088:	c9                   	leave  
80104089:	c3                   	ret    

8010408a <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
8010408a:	55                   	push   %ebp
8010408b:	89 e5                	mov    %esp,%ebp
8010408d:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80104090:	e8 bb f8 ff ff       	call   80103950 <mycpu>
80104095:	89 45 f0             	mov    %eax,-0x10(%ebp)
  c->proc = 0;
80104098:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010409b:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801040a2:	00 00 00 
  
  for(;;){
    // Enable interrupts on this processor.
    sti();
801040a5:	e8 42 f8 ff ff       	call   801038ec <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801040aa:	83 ec 0c             	sub    $0xc,%esp
801040ad:	68 00 32 19 80       	push   $0x80193200
801040b2:	e8 de 05 00 00       	call   80104695 <acquire>
801040b7:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ba:	c7 45 f4 34 32 19 80 	movl   $0x80193234,-0xc(%ebp)
801040c1:	eb 61                	jmp    80104124 <scheduler+0x9a>
      if(p->state != RUNNABLE)
801040c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040c6:	8b 40 0c             	mov    0xc(%eax),%eax
801040c9:	83 f8 03             	cmp    $0x3,%eax
801040cc:	75 51                	jne    8010411f <scheduler+0x95>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
801040ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801040d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040d4:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
      switchuvm(p);
801040da:	83 ec 0c             	sub    $0xc,%esp
801040dd:	ff 75 f4             	pushl  -0xc(%ebp)
801040e0:	e8 a5 31 00 00       	call   8010728a <switchuvm>
801040e5:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
801040e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040eb:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)

      swtch(&(c->scheduler), p->context);
801040f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f5:	8b 40 1c             	mov    0x1c(%eax),%eax
801040f8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801040fb:	83 c2 04             	add    $0x4,%edx
801040fe:	83 ec 08             	sub    $0x8,%esp
80104101:	50                   	push   %eax
80104102:	52                   	push   %edx
80104103:	e8 59 0a 00 00       	call   80104b61 <swtch>
80104108:	83 c4 10             	add    $0x10,%esp
      switchkvm();
8010410b:	e8 61 31 00 00       	call   80107271 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80104110:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104113:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010411a:	00 00 00 
8010411d:	eb 01                	jmp    80104120 <scheduler+0x96>
        continue;
8010411f:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104120:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104124:	81 7d f4 34 51 19 80 	cmpl   $0x80195134,-0xc(%ebp)
8010412b:	72 96                	jb     801040c3 <scheduler+0x39>
    }
    release(&ptable.lock);
8010412d:	83 ec 0c             	sub    $0xc,%esp
80104130:	68 00 32 19 80       	push   $0x80193200
80104135:	e8 c9 05 00 00       	call   80104703 <release>
8010413a:	83 c4 10             	add    $0x10,%esp
    sti();
8010413d:	e9 63 ff ff ff       	jmp    801040a5 <scheduler+0x1b>

80104142 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104142:	55                   	push   %ebp
80104143:	89 e5                	mov    %esp,%ebp
80104145:	83 ec 18             	sub    $0x18,%esp
  int intena;
  struct proc *p = myproc();
80104148:	e8 89 f8 ff ff       	call   801039d6 <myproc>
8010414d:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(!holding(&ptable.lock))
80104150:	83 ec 0c             	sub    $0xc,%esp
80104153:	68 00 32 19 80       	push   $0x80193200
80104158:	e8 71 06 00 00       	call   801047ce <holding>
8010415d:	83 c4 10             	add    $0x10,%esp
80104160:	85 c0                	test   %eax,%eax
80104162:	75 0d                	jne    80104171 <sched+0x2f>
    panic("sched ptable.lock");
80104164:	83 ec 0c             	sub    $0xc,%esp
80104167:	68 2b a1 10 80       	push   $0x8010a12b
8010416c:	e8 2e c4 ff ff       	call   8010059f <panic>
  if(mycpu()->ncli != 1)
80104171:	e8 da f7 ff ff       	call   80103950 <mycpu>
80104176:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
8010417c:	83 f8 01             	cmp    $0x1,%eax
8010417f:	74 0d                	je     8010418e <sched+0x4c>
    panic("sched locks");
80104181:	83 ec 0c             	sub    $0xc,%esp
80104184:	68 3d a1 10 80       	push   $0x8010a13d
80104189:	e8 11 c4 ff ff       	call   8010059f <panic>
  if(p->state == RUNNING)
8010418e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104191:	8b 40 0c             	mov    0xc(%eax),%eax
80104194:	83 f8 04             	cmp    $0x4,%eax
80104197:	75 0d                	jne    801041a6 <sched+0x64>
    panic("sched running");
80104199:	83 ec 0c             	sub    $0xc,%esp
8010419c:	68 49 a1 10 80       	push   $0x8010a149
801041a1:	e8 f9 c3 ff ff       	call   8010059f <panic>
  if(readeflags()&FL_IF)
801041a6:	e8 31 f7 ff ff       	call   801038dc <readeflags>
801041ab:	25 00 02 00 00       	and    $0x200,%eax
801041b0:	85 c0                	test   %eax,%eax
801041b2:	74 0d                	je     801041c1 <sched+0x7f>
    panic("sched interruptible");
801041b4:	83 ec 0c             	sub    $0xc,%esp
801041b7:	68 57 a1 10 80       	push   $0x8010a157
801041bc:	e8 de c3 ff ff       	call   8010059f <panic>
  intena = mycpu()->intena;
801041c1:	e8 8a f7 ff ff       	call   80103950 <mycpu>
801041c6:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801041cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  swtch(&p->context, mycpu()->scheduler);
801041cf:	e8 7c f7 ff ff       	call   80103950 <mycpu>
801041d4:	8b 40 04             	mov    0x4(%eax),%eax
801041d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041da:	83 c2 1c             	add    $0x1c,%edx
801041dd:	83 ec 08             	sub    $0x8,%esp
801041e0:	50                   	push   %eax
801041e1:	52                   	push   %edx
801041e2:	e8 7a 09 00 00       	call   80104b61 <swtch>
801041e7:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801041ea:	e8 61 f7 ff ff       	call   80103950 <mycpu>
801041ef:	8b 55 f0             	mov    -0x10(%ebp),%edx
801041f2:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
}
801041f8:	90                   	nop
801041f9:	c9                   	leave  
801041fa:	c3                   	ret    

801041fb <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
801041fb:	55                   	push   %ebp
801041fc:	89 e5                	mov    %esp,%ebp
801041fe:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104201:	83 ec 0c             	sub    $0xc,%esp
80104204:	68 00 32 19 80       	push   $0x80193200
80104209:	e8 87 04 00 00       	call   80104695 <acquire>
8010420e:	83 c4 10             	add    $0x10,%esp
  myproc()->state = RUNNABLE;
80104211:	e8 c0 f7 ff ff       	call   801039d6 <myproc>
80104216:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
8010421d:	e8 20 ff ff ff       	call   80104142 <sched>
  release(&ptable.lock);
80104222:	83 ec 0c             	sub    $0xc,%esp
80104225:	68 00 32 19 80       	push   $0x80193200
8010422a:	e8 d4 04 00 00       	call   80104703 <release>
8010422f:	83 c4 10             	add    $0x10,%esp
}
80104232:	90                   	nop
80104233:	c9                   	leave  
80104234:	c3                   	ret    

80104235 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104235:	55                   	push   %ebp
80104236:	89 e5                	mov    %esp,%ebp
80104238:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
8010423b:	83 ec 0c             	sub    $0xc,%esp
8010423e:	68 00 32 19 80       	push   $0x80193200
80104243:	e8 bb 04 00 00       	call   80104703 <release>
80104248:	83 c4 10             	add    $0x10,%esp

  if (first) {
8010424b:	a1 04 e0 10 80       	mov    0x8010e004,%eax
80104250:	85 c0                	test   %eax,%eax
80104252:	74 24                	je     80104278 <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80104254:	c7 05 04 e0 10 80 00 	movl   $0x0,0x8010e004
8010425b:	00 00 00 
    iinit(ROOTDEV);
8010425e:	83 ec 0c             	sub    $0xc,%esp
80104261:	6a 01                	push   $0x1
80104263:	e8 bb d3 ff ff       	call   80101623 <iinit>
80104268:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
8010426b:	83 ec 0c             	sub    $0xc,%esp
8010426e:	6a 01                	push   $0x1
80104270:	e8 2a eb ff ff       	call   80102d9f <initlog>
80104275:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80104278:	90                   	nop
80104279:	c9                   	leave  
8010427a:	c3                   	ret    

8010427b <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
8010427b:	55                   	push   %ebp
8010427c:	89 e5                	mov    %esp,%ebp
8010427e:	83 ec 18             	sub    $0x18,%esp
  struct proc *p = myproc();
80104281:	e8 50 f7 ff ff       	call   801039d6 <myproc>
80104286:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  if(p == 0)
80104289:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010428d:	75 0d                	jne    8010429c <sleep+0x21>
    panic("sleep");
8010428f:	83 ec 0c             	sub    $0xc,%esp
80104292:	68 6b a1 10 80       	push   $0x8010a16b
80104297:	e8 03 c3 ff ff       	call   8010059f <panic>

  if(lk == 0)
8010429c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801042a0:	75 0d                	jne    801042af <sleep+0x34>
    panic("sleep without lk");
801042a2:	83 ec 0c             	sub    $0xc,%esp
801042a5:	68 71 a1 10 80       	push   $0x8010a171
801042aa:	e8 f0 c2 ff ff       	call   8010059f <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
801042af:	81 7d 0c 00 32 19 80 	cmpl   $0x80193200,0xc(%ebp)
801042b6:	74 1e                	je     801042d6 <sleep+0x5b>
    acquire(&ptable.lock);  //DOC: sleeplock1
801042b8:	83 ec 0c             	sub    $0xc,%esp
801042bb:	68 00 32 19 80       	push   $0x80193200
801042c0:	e8 d0 03 00 00       	call   80104695 <acquire>
801042c5:	83 c4 10             	add    $0x10,%esp
    release(lk);
801042c8:	83 ec 0c             	sub    $0xc,%esp
801042cb:	ff 75 0c             	pushl  0xc(%ebp)
801042ce:	e8 30 04 00 00       	call   80104703 <release>
801042d3:	83 c4 10             	add    $0x10,%esp
  }
  // Go to sleep.
  p->chan = chan;
801042d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042d9:	8b 55 08             	mov    0x8(%ebp),%edx
801042dc:	89 50 20             	mov    %edx,0x20(%eax)
  p->state = SLEEPING;
801042df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042e2:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
801042e9:	e8 54 fe ff ff       	call   80104142 <sched>

  // Tidy up.
  p->chan = 0;
801042ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042f1:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
801042f8:	81 7d 0c 00 32 19 80 	cmpl   $0x80193200,0xc(%ebp)
801042ff:	74 1e                	je     8010431f <sleep+0xa4>
    release(&ptable.lock);
80104301:	83 ec 0c             	sub    $0xc,%esp
80104304:	68 00 32 19 80       	push   $0x80193200
80104309:	e8 f5 03 00 00       	call   80104703 <release>
8010430e:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104311:	83 ec 0c             	sub    $0xc,%esp
80104314:	ff 75 0c             	pushl  0xc(%ebp)
80104317:	e8 79 03 00 00       	call   80104695 <acquire>
8010431c:	83 c4 10             	add    $0x10,%esp
  }
}
8010431f:	90                   	nop
80104320:	c9                   	leave  
80104321:	c3                   	ret    

80104322 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104322:	55                   	push   %ebp
80104323:	89 e5                	mov    %esp,%ebp
80104325:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104328:	c7 45 fc 34 32 19 80 	movl   $0x80193234,-0x4(%ebp)
8010432f:	eb 24                	jmp    80104355 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104331:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104334:	8b 40 0c             	mov    0xc(%eax),%eax
80104337:	83 f8 02             	cmp    $0x2,%eax
8010433a:	75 15                	jne    80104351 <wakeup1+0x2f>
8010433c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010433f:	8b 40 20             	mov    0x20(%eax),%eax
80104342:	39 45 08             	cmp    %eax,0x8(%ebp)
80104345:	75 0a                	jne    80104351 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104347:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010434a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104351:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104355:	81 7d fc 34 51 19 80 	cmpl   $0x80195134,-0x4(%ebp)
8010435c:	72 d3                	jb     80104331 <wakeup1+0xf>
}
8010435e:	90                   	nop
8010435f:	90                   	nop
80104360:	c9                   	leave  
80104361:	c3                   	ret    

80104362 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104362:	55                   	push   %ebp
80104363:	89 e5                	mov    %esp,%ebp
80104365:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104368:	83 ec 0c             	sub    $0xc,%esp
8010436b:	68 00 32 19 80       	push   $0x80193200
80104370:	e8 20 03 00 00       	call   80104695 <acquire>
80104375:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104378:	83 ec 0c             	sub    $0xc,%esp
8010437b:	ff 75 08             	pushl  0x8(%ebp)
8010437e:	e8 9f ff ff ff       	call   80104322 <wakeup1>
80104383:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104386:	83 ec 0c             	sub    $0xc,%esp
80104389:	68 00 32 19 80       	push   $0x80193200
8010438e:	e8 70 03 00 00       	call   80104703 <release>
80104393:	83 c4 10             	add    $0x10,%esp
}
80104396:	90                   	nop
80104397:	c9                   	leave  
80104398:	c3                   	ret    

80104399 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104399:	55                   	push   %ebp
8010439a:	89 e5                	mov    %esp,%ebp
8010439c:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
8010439f:	83 ec 0c             	sub    $0xc,%esp
801043a2:	68 00 32 19 80       	push   $0x80193200
801043a7:	e8 e9 02 00 00       	call   80104695 <acquire>
801043ac:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043af:	c7 45 f4 34 32 19 80 	movl   $0x80193234,-0xc(%ebp)
801043b6:	eb 45                	jmp    801043fd <kill+0x64>
    if(p->pid == pid){
801043b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043bb:	8b 40 10             	mov    0x10(%eax),%eax
801043be:	39 45 08             	cmp    %eax,0x8(%ebp)
801043c1:	75 36                	jne    801043f9 <kill+0x60>
      p->killed = 1;
801043c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043c6:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801043cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043d0:	8b 40 0c             	mov    0xc(%eax),%eax
801043d3:	83 f8 02             	cmp    $0x2,%eax
801043d6:	75 0a                	jne    801043e2 <kill+0x49>
        p->state = RUNNABLE;
801043d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043db:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801043e2:	83 ec 0c             	sub    $0xc,%esp
801043e5:	68 00 32 19 80       	push   $0x80193200
801043ea:	e8 14 03 00 00       	call   80104703 <release>
801043ef:	83 c4 10             	add    $0x10,%esp
      return 0;
801043f2:	b8 00 00 00 00       	mov    $0x0,%eax
801043f7:	eb 22                	jmp    8010441b <kill+0x82>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043f9:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801043fd:	81 7d f4 34 51 19 80 	cmpl   $0x80195134,-0xc(%ebp)
80104404:	72 b2                	jb     801043b8 <kill+0x1f>
    }
  }
  release(&ptable.lock);
80104406:	83 ec 0c             	sub    $0xc,%esp
80104409:	68 00 32 19 80       	push   $0x80193200
8010440e:	e8 f0 02 00 00       	call   80104703 <release>
80104413:	83 c4 10             	add    $0x10,%esp
  return -1;
80104416:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010441b:	c9                   	leave  
8010441c:	c3                   	ret    

8010441d <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
8010441d:	55                   	push   %ebp
8010441e:	89 e5                	mov    %esp,%ebp
80104420:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104423:	c7 45 f0 34 32 19 80 	movl   $0x80193234,-0x10(%ebp)
8010442a:	e9 d6 00 00 00       	jmp    80104505 <procdump+0xe8>
    if(p->state == UNUSED)
8010442f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104432:	8b 40 0c             	mov    0xc(%eax),%eax
80104435:	85 c0                	test   %eax,%eax
80104437:	0f 84 c3 00 00 00    	je     80104500 <procdump+0xe3>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010443d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104440:	8b 40 0c             	mov    0xc(%eax),%eax
80104443:	83 f8 05             	cmp    $0x5,%eax
80104446:	77 23                	ja     8010446b <procdump+0x4e>
80104448:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010444b:	8b 40 0c             	mov    0xc(%eax),%eax
8010444e:	8b 04 85 08 e0 10 80 	mov    -0x7fef1ff8(,%eax,4),%eax
80104455:	85 c0                	test   %eax,%eax
80104457:	74 12                	je     8010446b <procdump+0x4e>
      state = states[p->state];
80104459:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010445c:	8b 40 0c             	mov    0xc(%eax),%eax
8010445f:	8b 04 85 08 e0 10 80 	mov    -0x7fef1ff8(,%eax,4),%eax
80104466:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104469:	eb 07                	jmp    80104472 <procdump+0x55>
    else
      state = "???";
8010446b:	c7 45 ec 82 a1 10 80 	movl   $0x8010a182,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104472:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104475:	8d 50 6c             	lea    0x6c(%eax),%edx
80104478:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010447b:	8b 40 10             	mov    0x10(%eax),%eax
8010447e:	52                   	push   %edx
8010447f:	ff 75 ec             	pushl  -0x14(%ebp)
80104482:	50                   	push   %eax
80104483:	68 86 a1 10 80       	push   $0x8010a186
80104488:	e8 64 bf ff ff       	call   801003f1 <cprintf>
8010448d:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104490:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104493:	8b 40 0c             	mov    0xc(%eax),%eax
80104496:	83 f8 02             	cmp    $0x2,%eax
80104499:	75 53                	jne    801044ee <procdump+0xd1>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010449b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010449e:	8b 40 1c             	mov    0x1c(%eax),%eax
801044a1:	8b 40 0c             	mov    0xc(%eax),%eax
801044a4:	83 c0 08             	add    $0x8,%eax
801044a7:	89 c2                	mov    %eax,%edx
801044a9:	83 ec 08             	sub    $0x8,%esp
801044ac:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801044af:	50                   	push   %eax
801044b0:	52                   	push   %edx
801044b1:	e8 9f 02 00 00       	call   80104755 <getcallerpcs>
801044b6:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801044b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801044c0:	eb 1b                	jmp    801044dd <procdump+0xc0>
        cprintf(" %p", pc[i]);
801044c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c5:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801044c9:	83 ec 08             	sub    $0x8,%esp
801044cc:	50                   	push   %eax
801044cd:	68 8f a1 10 80       	push   $0x8010a18f
801044d2:	e8 1a bf ff ff       	call   801003f1 <cprintf>
801044d7:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801044da:	ff 45 f4             	incl   -0xc(%ebp)
801044dd:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801044e1:	7f 0b                	jg     801044ee <procdump+0xd1>
801044e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044e6:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801044ea:	85 c0                	test   %eax,%eax
801044ec:	75 d4                	jne    801044c2 <procdump+0xa5>
    }
    cprintf("\n");
801044ee:	83 ec 0c             	sub    $0xc,%esp
801044f1:	68 93 a1 10 80       	push   $0x8010a193
801044f6:	e8 f6 be ff ff       	call   801003f1 <cprintf>
801044fb:	83 c4 10             	add    $0x10,%esp
801044fe:	eb 01                	jmp    80104501 <procdump+0xe4>
      continue;
80104500:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104501:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104505:	81 7d f0 34 51 19 80 	cmpl   $0x80195134,-0x10(%ebp)
8010450c:	0f 82 1d ff ff ff    	jb     8010442f <procdump+0x12>
  }
}
80104512:	90                   	nop
80104513:	90                   	nop
80104514:	c9                   	leave  
80104515:	c3                   	ret    

80104516 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104516:	55                   	push   %ebp
80104517:	89 e5                	mov    %esp,%ebp
80104519:	83 ec 08             	sub    $0x8,%esp
  initlock(&lk->lk, "sleep lock");
8010451c:	8b 45 08             	mov    0x8(%ebp),%eax
8010451f:	83 c0 04             	add    $0x4,%eax
80104522:	83 ec 08             	sub    $0x8,%esp
80104525:	68 bf a1 10 80       	push   $0x8010a1bf
8010452a:	50                   	push   %eax
8010452b:	e8 43 01 00 00       	call   80104673 <initlock>
80104530:	83 c4 10             	add    $0x10,%esp
  lk->name = name;
80104533:	8b 45 08             	mov    0x8(%ebp),%eax
80104536:	8b 55 0c             	mov    0xc(%ebp),%edx
80104539:	89 50 38             	mov    %edx,0x38(%eax)
  lk->locked = 0;
8010453c:	8b 45 08             	mov    0x8(%ebp),%eax
8010453f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80104545:	8b 45 08             	mov    0x8(%ebp),%eax
80104548:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
}
8010454f:	90                   	nop
80104550:	c9                   	leave  
80104551:	c3                   	ret    

80104552 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104552:	55                   	push   %ebp
80104553:	89 e5                	mov    %esp,%ebp
80104555:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80104558:	8b 45 08             	mov    0x8(%ebp),%eax
8010455b:	83 c0 04             	add    $0x4,%eax
8010455e:	83 ec 0c             	sub    $0xc,%esp
80104561:	50                   	push   %eax
80104562:	e8 2e 01 00 00       	call   80104695 <acquire>
80104567:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
8010456a:	eb 15                	jmp    80104581 <acquiresleep+0x2f>
    sleep(lk, &lk->lk);
8010456c:	8b 45 08             	mov    0x8(%ebp),%eax
8010456f:	83 c0 04             	add    $0x4,%eax
80104572:	83 ec 08             	sub    $0x8,%esp
80104575:	50                   	push   %eax
80104576:	ff 75 08             	pushl  0x8(%ebp)
80104579:	e8 fd fc ff ff       	call   8010427b <sleep>
8010457e:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80104581:	8b 45 08             	mov    0x8(%ebp),%eax
80104584:	8b 00                	mov    (%eax),%eax
80104586:	85 c0                	test   %eax,%eax
80104588:	75 e2                	jne    8010456c <acquiresleep+0x1a>
  }
  lk->locked = 1;
8010458a:	8b 45 08             	mov    0x8(%ebp),%eax
8010458d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->pid = myproc()->pid;
80104593:	e8 3e f4 ff ff       	call   801039d6 <myproc>
80104598:	8b 50 10             	mov    0x10(%eax),%edx
8010459b:	8b 45 08             	mov    0x8(%ebp),%eax
8010459e:	89 50 3c             	mov    %edx,0x3c(%eax)
  release(&lk->lk);
801045a1:	8b 45 08             	mov    0x8(%ebp),%eax
801045a4:	83 c0 04             	add    $0x4,%eax
801045a7:	83 ec 0c             	sub    $0xc,%esp
801045aa:	50                   	push   %eax
801045ab:	e8 53 01 00 00       	call   80104703 <release>
801045b0:	83 c4 10             	add    $0x10,%esp
}
801045b3:	90                   	nop
801045b4:	c9                   	leave  
801045b5:	c3                   	ret    

801045b6 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801045b6:	55                   	push   %ebp
801045b7:	89 e5                	mov    %esp,%ebp
801045b9:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
801045bc:	8b 45 08             	mov    0x8(%ebp),%eax
801045bf:	83 c0 04             	add    $0x4,%eax
801045c2:	83 ec 0c             	sub    $0xc,%esp
801045c5:	50                   	push   %eax
801045c6:	e8 ca 00 00 00       	call   80104695 <acquire>
801045cb:	83 c4 10             	add    $0x10,%esp
  lk->locked = 0;
801045ce:	8b 45 08             	mov    0x8(%ebp),%eax
801045d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
801045d7:	8b 45 08             	mov    0x8(%ebp),%eax
801045da:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
  wakeup(lk);
801045e1:	83 ec 0c             	sub    $0xc,%esp
801045e4:	ff 75 08             	pushl  0x8(%ebp)
801045e7:	e8 76 fd ff ff       	call   80104362 <wakeup>
801045ec:	83 c4 10             	add    $0x10,%esp
  release(&lk->lk);
801045ef:	8b 45 08             	mov    0x8(%ebp),%eax
801045f2:	83 c0 04             	add    $0x4,%eax
801045f5:	83 ec 0c             	sub    $0xc,%esp
801045f8:	50                   	push   %eax
801045f9:	e8 05 01 00 00       	call   80104703 <release>
801045fe:	83 c4 10             	add    $0x10,%esp
}
80104601:	90                   	nop
80104602:	c9                   	leave  
80104603:	c3                   	ret    

80104604 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104604:	55                   	push   %ebp
80104605:	89 e5                	mov    %esp,%ebp
80104607:	83 ec 18             	sub    $0x18,%esp
  int r;
  
  acquire(&lk->lk);
8010460a:	8b 45 08             	mov    0x8(%ebp),%eax
8010460d:	83 c0 04             	add    $0x4,%eax
80104610:	83 ec 0c             	sub    $0xc,%esp
80104613:	50                   	push   %eax
80104614:	e8 7c 00 00 00       	call   80104695 <acquire>
80104619:	83 c4 10             	add    $0x10,%esp
  r = lk->locked;
8010461c:	8b 45 08             	mov    0x8(%ebp),%eax
8010461f:	8b 00                	mov    (%eax),%eax
80104621:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
80104624:	8b 45 08             	mov    0x8(%ebp),%eax
80104627:	83 c0 04             	add    $0x4,%eax
8010462a:	83 ec 0c             	sub    $0xc,%esp
8010462d:	50                   	push   %eax
8010462e:	e8 d0 00 00 00       	call   80104703 <release>
80104633:	83 c4 10             	add    $0x10,%esp
  return r;
80104636:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104639:	c9                   	leave  
8010463a:	c3                   	ret    

8010463b <readeflags>:
{
8010463b:	55                   	push   %ebp
8010463c:	89 e5                	mov    %esp,%ebp
8010463e:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104641:	9c                   	pushf  
80104642:	58                   	pop    %eax
80104643:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104646:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104649:	c9                   	leave  
8010464a:	c3                   	ret    

8010464b <cli>:
{
8010464b:	55                   	push   %ebp
8010464c:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010464e:	fa                   	cli    
}
8010464f:	90                   	nop
80104650:	5d                   	pop    %ebp
80104651:	c3                   	ret    

80104652 <sti>:
{
80104652:	55                   	push   %ebp
80104653:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104655:	fb                   	sti    
}
80104656:	90                   	nop
80104657:	5d                   	pop    %ebp
80104658:	c3                   	ret    

80104659 <xchg>:
{
80104659:	55                   	push   %ebp
8010465a:	89 e5                	mov    %esp,%ebp
8010465c:	83 ec 10             	sub    $0x10,%esp
  asm volatile("lock; xchgl %0, %1" :
8010465f:	8b 55 08             	mov    0x8(%ebp),%edx
80104662:	8b 45 0c             	mov    0xc(%ebp),%eax
80104665:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104668:	f0 87 02             	lock xchg %eax,(%edx)
8010466b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
8010466e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104671:	c9                   	leave  
80104672:	c3                   	ret    

80104673 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104673:	55                   	push   %ebp
80104674:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104676:	8b 45 08             	mov    0x8(%ebp),%eax
80104679:	8b 55 0c             	mov    0xc(%ebp),%edx
8010467c:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
8010467f:	8b 45 08             	mov    0x8(%ebp),%eax
80104682:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104688:	8b 45 08             	mov    0x8(%ebp),%eax
8010468b:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104692:	90                   	nop
80104693:	5d                   	pop    %ebp
80104694:	c3                   	ret    

80104695 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104695:	55                   	push   %ebp
80104696:	89 e5                	mov    %esp,%ebp
80104698:	53                   	push   %ebx
80104699:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
8010469c:	e8 5d 01 00 00       	call   801047fe <pushcli>
  if(holding(lk)){
801046a1:	8b 45 08             	mov    0x8(%ebp),%eax
801046a4:	83 ec 0c             	sub    $0xc,%esp
801046a7:	50                   	push   %eax
801046a8:	e8 21 01 00 00       	call   801047ce <holding>
801046ad:	83 c4 10             	add    $0x10,%esp
801046b0:	85 c0                	test   %eax,%eax
801046b2:	74 0d                	je     801046c1 <acquire+0x2c>
    panic("acquire");
801046b4:	83 ec 0c             	sub    $0xc,%esp
801046b7:	68 ca a1 10 80       	push   $0x8010a1ca
801046bc:	e8 de be ff ff       	call   8010059f <panic>
  }

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801046c1:	90                   	nop
801046c2:	8b 45 08             	mov    0x8(%ebp),%eax
801046c5:	83 ec 08             	sub    $0x8,%esp
801046c8:	6a 01                	push   $0x1
801046ca:	50                   	push   %eax
801046cb:	e8 89 ff ff ff       	call   80104659 <xchg>
801046d0:	83 c4 10             	add    $0x10,%esp
801046d3:	85 c0                	test   %eax,%eax
801046d5:	75 eb                	jne    801046c2 <acquire+0x2d>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801046d7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801046dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046df:	e8 6c f2 ff ff       	call   80103950 <mycpu>
801046e4:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
801046e7:	8b 45 08             	mov    0x8(%ebp),%eax
801046ea:	83 c0 0c             	add    $0xc,%eax
801046ed:	83 ec 08             	sub    $0x8,%esp
801046f0:	50                   	push   %eax
801046f1:	8d 45 08             	lea    0x8(%ebp),%eax
801046f4:	50                   	push   %eax
801046f5:	e8 5b 00 00 00       	call   80104755 <getcallerpcs>
801046fa:	83 c4 10             	add    $0x10,%esp
}
801046fd:	90                   	nop
801046fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104701:	c9                   	leave  
80104702:	c3                   	ret    

80104703 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104703:	55                   	push   %ebp
80104704:	89 e5                	mov    %esp,%ebp
80104706:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104709:	83 ec 0c             	sub    $0xc,%esp
8010470c:	ff 75 08             	pushl  0x8(%ebp)
8010470f:	e8 ba 00 00 00       	call   801047ce <holding>
80104714:	83 c4 10             	add    $0x10,%esp
80104717:	85 c0                	test   %eax,%eax
80104719:	75 0d                	jne    80104728 <release+0x25>
    panic("release");
8010471b:	83 ec 0c             	sub    $0xc,%esp
8010471e:	68 d2 a1 10 80       	push   $0x8010a1d2
80104723:	e8 77 be ff ff       	call   8010059f <panic>

  lk->pcs[0] = 0;
80104728:	8b 45 08             	mov    0x8(%ebp),%eax
8010472b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104732:	8b 45 08             	mov    0x8(%ebp),%eax
80104735:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010473c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104741:	8b 45 08             	mov    0x8(%ebp),%eax
80104744:	8b 55 08             	mov    0x8(%ebp),%edx
80104747:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
8010474d:	e8 f7 00 00 00       	call   80104849 <popcli>
}
80104752:	90                   	nop
80104753:	c9                   	leave  
80104754:	c3                   	ret    

80104755 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104755:	55                   	push   %ebp
80104756:	89 e5                	mov    %esp,%ebp
80104758:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010475b:	8b 45 08             	mov    0x8(%ebp),%eax
8010475e:	83 e8 08             	sub    $0x8,%eax
80104761:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104764:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
8010476b:	eb 37                	jmp    801047a4 <getcallerpcs+0x4f>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010476d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104771:	74 51                	je     801047c4 <getcallerpcs+0x6f>
80104773:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
8010477a:	76 48                	jbe    801047c4 <getcallerpcs+0x6f>
8010477c:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104780:	74 42                	je     801047c4 <getcallerpcs+0x6f>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104782:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104785:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010478c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010478f:	01 c2                	add    %eax,%edx
80104791:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104794:	8b 40 04             	mov    0x4(%eax),%eax
80104797:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104799:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010479c:	8b 00                	mov    (%eax),%eax
8010479e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801047a1:	ff 45 f8             	incl   -0x8(%ebp)
801047a4:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801047a8:	7e c3                	jle    8010476d <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
801047aa:	eb 18                	jmp    801047c4 <getcallerpcs+0x6f>
    pcs[i] = 0;
801047ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
801047af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801047b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801047b9:	01 d0                	add    %edx,%eax
801047bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801047c1:	ff 45 f8             	incl   -0x8(%ebp)
801047c4:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801047c8:	7e e2                	jle    801047ac <getcallerpcs+0x57>
}
801047ca:	90                   	nop
801047cb:	90                   	nop
801047cc:	c9                   	leave  
801047cd:	c3                   	ret    

801047ce <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801047ce:	55                   	push   %ebp
801047cf:	89 e5                	mov    %esp,%ebp
801047d1:	53                   	push   %ebx
801047d2:	83 ec 04             	sub    $0x4,%esp
  return lock->locked && lock->cpu == mycpu();
801047d5:	8b 45 08             	mov    0x8(%ebp),%eax
801047d8:	8b 00                	mov    (%eax),%eax
801047da:	85 c0                	test   %eax,%eax
801047dc:	74 16                	je     801047f4 <holding+0x26>
801047de:	8b 45 08             	mov    0x8(%ebp),%eax
801047e1:	8b 58 08             	mov    0x8(%eax),%ebx
801047e4:	e8 67 f1 ff ff       	call   80103950 <mycpu>
801047e9:	39 c3                	cmp    %eax,%ebx
801047eb:	75 07                	jne    801047f4 <holding+0x26>
801047ed:	b8 01 00 00 00       	mov    $0x1,%eax
801047f2:	eb 05                	jmp    801047f9 <holding+0x2b>
801047f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801047f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047fc:	c9                   	leave  
801047fd:	c3                   	ret    

801047fe <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801047fe:	55                   	push   %ebp
801047ff:	89 e5                	mov    %esp,%ebp
80104801:	83 ec 18             	sub    $0x18,%esp
  int eflags;

  eflags = readeflags();
80104804:	e8 32 fe ff ff       	call   8010463b <readeflags>
80104809:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cli();
8010480c:	e8 3a fe ff ff       	call   8010464b <cli>
  if(mycpu()->ncli == 0)
80104811:	e8 3a f1 ff ff       	call   80103950 <mycpu>
80104816:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
8010481c:	85 c0                	test   %eax,%eax
8010481e:	75 14                	jne    80104834 <pushcli+0x36>
    mycpu()->intena = eflags & FL_IF;
80104820:	e8 2b f1 ff ff       	call   80103950 <mycpu>
80104825:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104828:	81 e2 00 02 00 00    	and    $0x200,%edx
8010482e:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
  mycpu()->ncli += 1;
80104834:	e8 17 f1 ff ff       	call   80103950 <mycpu>
80104839:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
8010483f:	42                   	inc    %edx
80104840:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
}
80104846:	90                   	nop
80104847:	c9                   	leave  
80104848:	c3                   	ret    

80104849 <popcli>:

void
popcli(void)
{
80104849:	55                   	push   %ebp
8010484a:	89 e5                	mov    %esp,%ebp
8010484c:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
8010484f:	e8 e7 fd ff ff       	call   8010463b <readeflags>
80104854:	25 00 02 00 00       	and    $0x200,%eax
80104859:	85 c0                	test   %eax,%eax
8010485b:	74 0d                	je     8010486a <popcli+0x21>
    panic("popcli - interruptible");
8010485d:	83 ec 0c             	sub    $0xc,%esp
80104860:	68 da a1 10 80       	push   $0x8010a1da
80104865:	e8 35 bd ff ff       	call   8010059f <panic>
  if(--mycpu()->ncli < 0)
8010486a:	e8 e1 f0 ff ff       	call   80103950 <mycpu>
8010486f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104875:	4a                   	dec    %edx
80104876:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
8010487c:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104882:	85 c0                	test   %eax,%eax
80104884:	79 0d                	jns    80104893 <popcli+0x4a>
    panic("popcli");
80104886:	83 ec 0c             	sub    $0xc,%esp
80104889:	68 f1 a1 10 80       	push   $0x8010a1f1
8010488e:	e8 0c bd ff ff       	call   8010059f <panic>
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104893:	e8 b8 f0 ff ff       	call   80103950 <mycpu>
80104898:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
8010489e:	85 c0                	test   %eax,%eax
801048a0:	75 14                	jne    801048b6 <popcli+0x6d>
801048a2:	e8 a9 f0 ff ff       	call   80103950 <mycpu>
801048a7:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801048ad:	85 c0                	test   %eax,%eax
801048af:	74 05                	je     801048b6 <popcli+0x6d>
    sti();
801048b1:	e8 9c fd ff ff       	call   80104652 <sti>
}
801048b6:	90                   	nop
801048b7:	c9                   	leave  
801048b8:	c3                   	ret    

801048b9 <stosb>:
{
801048b9:	55                   	push   %ebp
801048ba:	89 e5                	mov    %esp,%ebp
801048bc:	57                   	push   %edi
801048bd:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
801048be:	8b 4d 08             	mov    0x8(%ebp),%ecx
801048c1:	8b 55 10             	mov    0x10(%ebp),%edx
801048c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801048c7:	89 cb                	mov    %ecx,%ebx
801048c9:	89 df                	mov    %ebx,%edi
801048cb:	89 d1                	mov    %edx,%ecx
801048cd:	fc                   	cld    
801048ce:	f3 aa                	rep stos %al,%es:(%edi)
801048d0:	89 ca                	mov    %ecx,%edx
801048d2:	89 fb                	mov    %edi,%ebx
801048d4:	89 5d 08             	mov    %ebx,0x8(%ebp)
801048d7:	89 55 10             	mov    %edx,0x10(%ebp)
}
801048da:	90                   	nop
801048db:	5b                   	pop    %ebx
801048dc:	5f                   	pop    %edi
801048dd:	5d                   	pop    %ebp
801048de:	c3                   	ret    

801048df <stosl>:
{
801048df:	55                   	push   %ebp
801048e0:	89 e5                	mov    %esp,%ebp
801048e2:	57                   	push   %edi
801048e3:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
801048e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
801048e7:	8b 55 10             	mov    0x10(%ebp),%edx
801048ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ed:	89 cb                	mov    %ecx,%ebx
801048ef:	89 df                	mov    %ebx,%edi
801048f1:	89 d1                	mov    %edx,%ecx
801048f3:	fc                   	cld    
801048f4:	f3 ab                	rep stos %eax,%es:(%edi)
801048f6:	89 ca                	mov    %ecx,%edx
801048f8:	89 fb                	mov    %edi,%ebx
801048fa:	89 5d 08             	mov    %ebx,0x8(%ebp)
801048fd:	89 55 10             	mov    %edx,0x10(%ebp)
}
80104900:	90                   	nop
80104901:	5b                   	pop    %ebx
80104902:	5f                   	pop    %edi
80104903:	5d                   	pop    %ebp
80104904:	c3                   	ret    

80104905 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104905:	55                   	push   %ebp
80104906:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80104908:	8b 45 08             	mov    0x8(%ebp),%eax
8010490b:	83 e0 03             	and    $0x3,%eax
8010490e:	85 c0                	test   %eax,%eax
80104910:	75 43                	jne    80104955 <memset+0x50>
80104912:	8b 45 10             	mov    0x10(%ebp),%eax
80104915:	83 e0 03             	and    $0x3,%eax
80104918:	85 c0                	test   %eax,%eax
8010491a:	75 39                	jne    80104955 <memset+0x50>
    c &= 0xFF;
8010491c:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104923:	8b 45 10             	mov    0x10(%ebp),%eax
80104926:	c1 e8 02             	shr    $0x2,%eax
80104929:	89 c2                	mov    %eax,%edx
8010492b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010492e:	c1 e0 18             	shl    $0x18,%eax
80104931:	89 c1                	mov    %eax,%ecx
80104933:	8b 45 0c             	mov    0xc(%ebp),%eax
80104936:	c1 e0 10             	shl    $0x10,%eax
80104939:	09 c1                	or     %eax,%ecx
8010493b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010493e:	c1 e0 08             	shl    $0x8,%eax
80104941:	09 c8                	or     %ecx,%eax
80104943:	0b 45 0c             	or     0xc(%ebp),%eax
80104946:	52                   	push   %edx
80104947:	50                   	push   %eax
80104948:	ff 75 08             	pushl  0x8(%ebp)
8010494b:	e8 8f ff ff ff       	call   801048df <stosl>
80104950:	83 c4 0c             	add    $0xc,%esp
80104953:	eb 12                	jmp    80104967 <memset+0x62>
  } else
    stosb(dst, c, n);
80104955:	8b 45 10             	mov    0x10(%ebp),%eax
80104958:	50                   	push   %eax
80104959:	ff 75 0c             	pushl  0xc(%ebp)
8010495c:	ff 75 08             	pushl  0x8(%ebp)
8010495f:	e8 55 ff ff ff       	call   801048b9 <stosb>
80104964:	83 c4 0c             	add    $0xc,%esp
  return dst;
80104967:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010496a:	c9                   	leave  
8010496b:	c3                   	ret    

8010496c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010496c:	55                   	push   %ebp
8010496d:	89 e5                	mov    %esp,%ebp
8010496f:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;

  s1 = v1;
80104972:	8b 45 08             	mov    0x8(%ebp),%eax
80104975:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80104978:	8b 45 0c             	mov    0xc(%ebp),%eax
8010497b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
8010497e:	eb 28                	jmp    801049a8 <memcmp+0x3c>
    if(*s1 != *s2)
80104980:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104983:	8a 10                	mov    (%eax),%dl
80104985:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104988:	8a 00                	mov    (%eax),%al
8010498a:	38 c2                	cmp    %al,%dl
8010498c:	74 14                	je     801049a2 <memcmp+0x36>
      return *s1 - *s2;
8010498e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104991:	8a 00                	mov    (%eax),%al
80104993:	0f b6 d0             	movzbl %al,%edx
80104996:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104999:	8a 00                	mov    (%eax),%al
8010499b:	0f b6 c0             	movzbl %al,%eax
8010499e:	29 c2                	sub    %eax,%edx
801049a0:	eb 18                	jmp    801049ba <memcmp+0x4e>
    s1++, s2++;
801049a2:	ff 45 fc             	incl   -0x4(%ebp)
801049a5:	ff 45 f8             	incl   -0x8(%ebp)
  while(n-- > 0){
801049a8:	8b 45 10             	mov    0x10(%ebp),%eax
801049ab:	8d 50 ff             	lea    -0x1(%eax),%edx
801049ae:	89 55 10             	mov    %edx,0x10(%ebp)
801049b1:	85 c0                	test   %eax,%eax
801049b3:	75 cb                	jne    80104980 <memcmp+0x14>
  }

  return 0;
801049b5:	ba 00 00 00 00       	mov    $0x0,%edx
}
801049ba:	89 d0                	mov    %edx,%eax
801049bc:	c9                   	leave  
801049bd:	c3                   	ret    

801049be <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801049be:	55                   	push   %ebp
801049bf:	89 e5                	mov    %esp,%ebp
801049c1:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
801049c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801049c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
801049ca:	8b 45 08             	mov    0x8(%ebp),%eax
801049cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
801049d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801049d3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801049d6:	73 50                	jae    80104a28 <memmove+0x6a>
801049d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
801049db:	8b 45 10             	mov    0x10(%ebp),%eax
801049de:	01 d0                	add    %edx,%eax
801049e0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
801049e3:	73 43                	jae    80104a28 <memmove+0x6a>
    s += n;
801049e5:	8b 45 10             	mov    0x10(%ebp),%eax
801049e8:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
801049eb:	8b 45 10             	mov    0x10(%ebp),%eax
801049ee:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801049f1:	eb 10                	jmp    80104a03 <memmove+0x45>
      *--d = *--s;
801049f3:	ff 4d fc             	decl   -0x4(%ebp)
801049f6:	ff 4d f8             	decl   -0x8(%ebp)
801049f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801049fc:	8a 10                	mov    (%eax),%dl
801049fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104a01:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80104a03:	8b 45 10             	mov    0x10(%ebp),%eax
80104a06:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a09:	89 55 10             	mov    %edx,0x10(%ebp)
80104a0c:	85 c0                	test   %eax,%eax
80104a0e:	75 e3                	jne    801049f3 <memmove+0x35>
  if(s < d && s + n > d){
80104a10:	eb 23                	jmp    80104a35 <memmove+0x77>
  } else
    while(n-- > 0)
      *d++ = *s++;
80104a12:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104a15:	8d 42 01             	lea    0x1(%edx),%eax
80104a18:	89 45 fc             	mov    %eax,-0x4(%ebp)
80104a1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104a1e:	8d 48 01             	lea    0x1(%eax),%ecx
80104a21:	89 4d f8             	mov    %ecx,-0x8(%ebp)
80104a24:	8a 12                	mov    (%edx),%dl
80104a26:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80104a28:	8b 45 10             	mov    0x10(%ebp),%eax
80104a2b:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a2e:	89 55 10             	mov    %edx,0x10(%ebp)
80104a31:	85 c0                	test   %eax,%eax
80104a33:	75 dd                	jne    80104a12 <memmove+0x54>

  return dst;
80104a35:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104a38:	c9                   	leave  
80104a39:	c3                   	ret    

80104a3a <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104a3a:	55                   	push   %ebp
80104a3b:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80104a3d:	ff 75 10             	pushl  0x10(%ebp)
80104a40:	ff 75 0c             	pushl  0xc(%ebp)
80104a43:	ff 75 08             	pushl  0x8(%ebp)
80104a46:	e8 73 ff ff ff       	call   801049be <memmove>
80104a4b:	83 c4 0c             	add    $0xc,%esp
}
80104a4e:	c9                   	leave  
80104a4f:	c3                   	ret    

80104a50 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80104a53:	eb 09                	jmp    80104a5e <strncmp+0xe>
    n--, p++, q++;
80104a55:	ff 4d 10             	decl   0x10(%ebp)
80104a58:	ff 45 08             	incl   0x8(%ebp)
80104a5b:	ff 45 0c             	incl   0xc(%ebp)
  while(n > 0 && *p && *p == *q)
80104a5e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104a62:	74 17                	je     80104a7b <strncmp+0x2b>
80104a64:	8b 45 08             	mov    0x8(%ebp),%eax
80104a67:	8a 00                	mov    (%eax),%al
80104a69:	84 c0                	test   %al,%al
80104a6b:	74 0e                	je     80104a7b <strncmp+0x2b>
80104a6d:	8b 45 08             	mov    0x8(%ebp),%eax
80104a70:	8a 10                	mov    (%eax),%dl
80104a72:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a75:	8a 00                	mov    (%eax),%al
80104a77:	38 c2                	cmp    %al,%dl
80104a79:	74 da                	je     80104a55 <strncmp+0x5>
  if(n == 0)
80104a7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104a7f:	75 07                	jne    80104a88 <strncmp+0x38>
    return 0;
80104a81:	ba 00 00 00 00       	mov    $0x0,%edx
80104a86:	eb 12                	jmp    80104a9a <strncmp+0x4a>
  return (uchar)*p - (uchar)*q;
80104a88:	8b 45 08             	mov    0x8(%ebp),%eax
80104a8b:	8a 00                	mov    (%eax),%al
80104a8d:	0f b6 d0             	movzbl %al,%edx
80104a90:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a93:	8a 00                	mov    (%eax),%al
80104a95:	0f b6 c0             	movzbl %al,%eax
80104a98:	29 c2                	sub    %eax,%edx
}
80104a9a:	89 d0                	mov    %edx,%eax
80104a9c:	5d                   	pop    %ebp
80104a9d:	c3                   	ret    

80104a9e <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104a9e:	55                   	push   %ebp
80104a9f:	89 e5                	mov    %esp,%ebp
80104aa1:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80104aa4:	8b 45 08             	mov    0x8(%ebp),%eax
80104aa7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80104aaa:	90                   	nop
80104aab:	8b 45 10             	mov    0x10(%ebp),%eax
80104aae:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ab1:	89 55 10             	mov    %edx,0x10(%ebp)
80104ab4:	85 c0                	test   %eax,%eax
80104ab6:	7e 2a                	jle    80104ae2 <strncpy+0x44>
80104ab8:	8b 55 0c             	mov    0xc(%ebp),%edx
80104abb:	8d 42 01             	lea    0x1(%edx),%eax
80104abe:	89 45 0c             	mov    %eax,0xc(%ebp)
80104ac1:	8b 45 08             	mov    0x8(%ebp),%eax
80104ac4:	8d 48 01             	lea    0x1(%eax),%ecx
80104ac7:	89 4d 08             	mov    %ecx,0x8(%ebp)
80104aca:	8a 12                	mov    (%edx),%dl
80104acc:	88 10                	mov    %dl,(%eax)
80104ace:	8a 00                	mov    (%eax),%al
80104ad0:	84 c0                	test   %al,%al
80104ad2:	75 d7                	jne    80104aab <strncpy+0xd>
    ;
  while(n-- > 0)
80104ad4:	eb 0c                	jmp    80104ae2 <strncpy+0x44>
    *s++ = 0;
80104ad6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ad9:	8d 50 01             	lea    0x1(%eax),%edx
80104adc:	89 55 08             	mov    %edx,0x8(%ebp)
80104adf:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
80104ae2:	8b 45 10             	mov    0x10(%ebp),%eax
80104ae5:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ae8:	89 55 10             	mov    %edx,0x10(%ebp)
80104aeb:	85 c0                	test   %eax,%eax
80104aed:	7f e7                	jg     80104ad6 <strncpy+0x38>
  return os;
80104aef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104af2:	c9                   	leave  
80104af3:	c3                   	ret    

80104af4 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104af4:	55                   	push   %ebp
80104af5:	89 e5                	mov    %esp,%ebp
80104af7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80104afa:	8b 45 08             	mov    0x8(%ebp),%eax
80104afd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80104b00:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104b04:	7f 05                	jg     80104b0b <safestrcpy+0x17>
    return os;
80104b06:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104b09:	eb 2f                	jmp    80104b3a <safestrcpy+0x46>
  while(--n > 0 && (*s++ = *t++) != 0)
80104b0b:	90                   	nop
80104b0c:	ff 4d 10             	decl   0x10(%ebp)
80104b0f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104b13:	7e 1c                	jle    80104b31 <safestrcpy+0x3d>
80104b15:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b18:	8d 42 01             	lea    0x1(%edx),%eax
80104b1b:	89 45 0c             	mov    %eax,0xc(%ebp)
80104b1e:	8b 45 08             	mov    0x8(%ebp),%eax
80104b21:	8d 48 01             	lea    0x1(%eax),%ecx
80104b24:	89 4d 08             	mov    %ecx,0x8(%ebp)
80104b27:	8a 12                	mov    (%edx),%dl
80104b29:	88 10                	mov    %dl,(%eax)
80104b2b:	8a 00                	mov    (%eax),%al
80104b2d:	84 c0                	test   %al,%al
80104b2f:	75 db                	jne    80104b0c <safestrcpy+0x18>
    ;
  *s = 0;
80104b31:	8b 45 08             	mov    0x8(%ebp),%eax
80104b34:	c6 00 00             	movb   $0x0,(%eax)
  return os;
80104b37:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104b3a:	c9                   	leave  
80104b3b:	c3                   	ret    

80104b3c <strlen>:

int
strlen(const char *s)
{
80104b3c:	55                   	push   %ebp
80104b3d:	89 e5                	mov    %esp,%ebp
80104b3f:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80104b42:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80104b49:	eb 03                	jmp    80104b4e <strlen+0x12>
80104b4b:	ff 45 fc             	incl   -0x4(%ebp)
80104b4e:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104b51:	8b 45 08             	mov    0x8(%ebp),%eax
80104b54:	01 d0                	add    %edx,%eax
80104b56:	8a 00                	mov    (%eax),%al
80104b58:	84 c0                	test   %al,%al
80104b5a:	75 ef                	jne    80104b4b <strlen+0xf>
    ;
  return n;
80104b5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104b5f:	c9                   	leave  
80104b60:	c3                   	ret    

80104b61 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104b61:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104b65:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104b69:	55                   	push   %ebp
  pushl %ebx
80104b6a:	53                   	push   %ebx
  pushl %esi
80104b6b:	56                   	push   %esi
  pushl %edi
80104b6c:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104b6d:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104b6f:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80104b71:	5f                   	pop    %edi
  popl %esi
80104b72:	5e                   	pop    %esi
  popl %ebx
80104b73:	5b                   	pop    %ebx
  popl %ebp
80104b74:	5d                   	pop    %ebp
  ret
80104b75:	c3                   	ret    

80104b76 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104b76:	55                   	push   %ebp
80104b77:	89 e5                	mov    %esp,%ebp
80104b79:	83 ec 18             	sub    $0x18,%esp
  struct proc *curproc = myproc();
80104b7c:	e8 55 ee ff ff       	call   801039d6 <myproc>
80104b81:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b87:	8b 00                	mov    (%eax),%eax
80104b89:	39 45 08             	cmp    %eax,0x8(%ebp)
80104b8c:	73 0f                	jae    80104b9d <fetchint+0x27>
80104b8e:	8b 45 08             	mov    0x8(%ebp),%eax
80104b91:	8d 50 04             	lea    0x4(%eax),%edx
80104b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b97:	8b 00                	mov    (%eax),%eax
80104b99:	39 d0                	cmp    %edx,%eax
80104b9b:	73 07                	jae    80104ba4 <fetchint+0x2e>
    return -1;
80104b9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ba2:	eb 0f                	jmp    80104bb3 <fetchint+0x3d>
  *ip = *(int*)(addr);
80104ba4:	8b 45 08             	mov    0x8(%ebp),%eax
80104ba7:	8b 10                	mov    (%eax),%edx
80104ba9:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bac:	89 10                	mov    %edx,(%eax)
  return 0;
80104bae:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104bb3:	c9                   	leave  
80104bb4:	c3                   	ret    

80104bb5 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104bb5:	55                   	push   %ebp
80104bb6:	89 e5                	mov    %esp,%ebp
80104bb8:	83 ec 18             	sub    $0x18,%esp
  char *s, *ep;
  struct proc *curproc = myproc();
80104bbb:	e8 16 ee ff ff       	call   801039d6 <myproc>
80104bc0:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(addr >= curproc->sz)
80104bc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bc6:	8b 00                	mov    (%eax),%eax
80104bc8:	39 45 08             	cmp    %eax,0x8(%ebp)
80104bcb:	72 07                	jb     80104bd4 <fetchstr+0x1f>
    return -1;
80104bcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bd2:	eb 3f                	jmp    80104c13 <fetchstr+0x5e>
  *pp = (char*)addr;
80104bd4:	8b 55 08             	mov    0x8(%ebp),%edx
80104bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bda:	89 10                	mov    %edx,(%eax)
  ep = (char*)curproc->sz;
80104bdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bdf:	8b 00                	mov    (%eax),%eax
80104be1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(s = *pp; s < ep; s++){
80104be4:	8b 45 0c             	mov    0xc(%ebp),%eax
80104be7:	8b 00                	mov    (%eax),%eax
80104be9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104bec:	eb 18                	jmp    80104c06 <fetchstr+0x51>
    if(*s == 0)
80104bee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf1:	8a 00                	mov    (%eax),%al
80104bf3:	84 c0                	test   %al,%al
80104bf5:	75 0c                	jne    80104c03 <fetchstr+0x4e>
      return s - *pp;
80104bf7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bfa:	8b 10                	mov    (%eax),%edx
80104bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bff:	29 d0                	sub    %edx,%eax
80104c01:	eb 10                	jmp    80104c13 <fetchstr+0x5e>
  for(s = *pp; s < ep; s++){
80104c03:	ff 45 f4             	incl   -0xc(%ebp)
80104c06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c09:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80104c0c:	72 e0                	jb     80104bee <fetchstr+0x39>
  }
  return -1;
80104c0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c13:	c9                   	leave  
80104c14:	c3                   	ret    

80104c15 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104c15:	55                   	push   %ebp
80104c16:	89 e5                	mov    %esp,%ebp
80104c18:	83 ec 08             	sub    $0x8,%esp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c1b:	e8 b6 ed ff ff       	call   801039d6 <myproc>
80104c20:	8b 40 18             	mov    0x18(%eax),%eax
80104c23:	8b 40 44             	mov    0x44(%eax),%eax
80104c26:	8b 55 08             	mov    0x8(%ebp),%edx
80104c29:	c1 e2 02             	shl    $0x2,%edx
80104c2c:	01 d0                	add    %edx,%eax
80104c2e:	83 c0 04             	add    $0x4,%eax
80104c31:	83 ec 08             	sub    $0x8,%esp
80104c34:	ff 75 0c             	pushl  0xc(%ebp)
80104c37:	50                   	push   %eax
80104c38:	e8 39 ff ff ff       	call   80104b76 <fetchint>
80104c3d:	83 c4 10             	add    $0x10,%esp
}
80104c40:	c9                   	leave  
80104c41:	c3                   	ret    

80104c42 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104c42:	55                   	push   %ebp
80104c43:	89 e5                	mov    %esp,%ebp
80104c45:	83 ec 18             	sub    $0x18,%esp
  int i;
  struct proc *curproc = myproc();
80104c48:	e8 89 ed ff ff       	call   801039d6 <myproc>
80104c4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 
  if(argint(n, &i) < 0)
80104c50:	83 ec 08             	sub    $0x8,%esp
80104c53:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c56:	50                   	push   %eax
80104c57:	ff 75 08             	pushl  0x8(%ebp)
80104c5a:	e8 b6 ff ff ff       	call   80104c15 <argint>
80104c5f:	83 c4 10             	add    $0x10,%esp
80104c62:	85 c0                	test   %eax,%eax
80104c64:	79 07                	jns    80104c6d <argptr+0x2b>
    return -1;
80104c66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c6b:	eb 3b                	jmp    80104ca8 <argptr+0x66>
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104c6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104c71:	78 1f                	js     80104c92 <argptr+0x50>
80104c73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c76:	8b 00                	mov    (%eax),%eax
80104c78:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104c7b:	39 c2                	cmp    %eax,%edx
80104c7d:	73 13                	jae    80104c92 <argptr+0x50>
80104c7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c82:	89 c2                	mov    %eax,%edx
80104c84:	8b 45 10             	mov    0x10(%ebp),%eax
80104c87:	01 c2                	add    %eax,%edx
80104c89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c8c:	8b 00                	mov    (%eax),%eax
80104c8e:	39 d0                	cmp    %edx,%eax
80104c90:	73 07                	jae    80104c99 <argptr+0x57>
    return -1;
80104c92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c97:	eb 0f                	jmp    80104ca8 <argptr+0x66>
  *pp = (char*)i;
80104c99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c9c:	89 c2                	mov    %eax,%edx
80104c9e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ca1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ca3:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104ca8:	c9                   	leave  
80104ca9:	c3                   	ret    

80104caa <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104caa:	55                   	push   %ebp
80104cab:	89 e5                	mov    %esp,%ebp
80104cad:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104cb0:	83 ec 08             	sub    $0x8,%esp
80104cb3:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cb6:	50                   	push   %eax
80104cb7:	ff 75 08             	pushl  0x8(%ebp)
80104cba:	e8 56 ff ff ff       	call   80104c15 <argint>
80104cbf:	83 c4 10             	add    $0x10,%esp
80104cc2:	85 c0                	test   %eax,%eax
80104cc4:	79 07                	jns    80104ccd <argstr+0x23>
    return -1;
80104cc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ccb:	eb 12                	jmp    80104cdf <argstr+0x35>
  return fetchstr(addr, pp);
80104ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd0:	83 ec 08             	sub    $0x8,%esp
80104cd3:	ff 75 0c             	pushl  0xc(%ebp)
80104cd6:	50                   	push   %eax
80104cd7:	e8 d9 fe ff ff       	call   80104bb5 <fetchstr>
80104cdc:	83 c4 10             	add    $0x10,%esp
}
80104cdf:	c9                   	leave  
80104ce0:	c3                   	ret    

80104ce1 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104ce1:	55                   	push   %ebp
80104ce2:	89 e5                	mov    %esp,%ebp
80104ce4:	83 ec 18             	sub    $0x18,%esp
  int num;
  struct proc *curproc = myproc();
80104ce7:	e8 ea ec ff ff       	call   801039d6 <myproc>
80104cec:	89 45 f4             	mov    %eax,-0xc(%ebp)

  num = curproc->tf->eax;
80104cef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cf2:	8b 40 18             	mov    0x18(%eax),%eax
80104cf5:	8b 40 1c             	mov    0x1c(%eax),%eax
80104cf8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104cfb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104cff:	7e 2f                	jle    80104d30 <syscall+0x4f>
80104d01:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d04:	83 f8 15             	cmp    $0x15,%eax
80104d07:	77 27                	ja     80104d30 <syscall+0x4f>
80104d09:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d0c:	8b 04 85 20 e0 10 80 	mov    -0x7fef1fe0(,%eax,4),%eax
80104d13:	85 c0                	test   %eax,%eax
80104d15:	74 19                	je     80104d30 <syscall+0x4f>
    curproc->tf->eax = syscalls[num]();
80104d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d1a:	8b 04 85 20 e0 10 80 	mov    -0x7fef1fe0(,%eax,4),%eax
80104d21:	ff d0                	call   *%eax
80104d23:	89 c2                	mov    %eax,%edx
80104d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d28:	8b 40 18             	mov    0x18(%eax),%eax
80104d2b:	89 50 1c             	mov    %edx,0x1c(%eax)
80104d2e:	eb 2c                	jmp    80104d5c <syscall+0x7b>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
80104d30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d33:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("%d %s: unknown sys call %d\n",
80104d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d39:	8b 40 10             	mov    0x10(%eax),%eax
80104d3c:	ff 75 f0             	pushl  -0x10(%ebp)
80104d3f:	52                   	push   %edx
80104d40:	50                   	push   %eax
80104d41:	68 f8 a1 10 80       	push   $0x8010a1f8
80104d46:	e8 a6 b6 ff ff       	call   801003f1 <cprintf>
80104d4b:	83 c4 10             	add    $0x10,%esp
    curproc->tf->eax = -1;
80104d4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d51:	8b 40 18             	mov    0x18(%eax),%eax
80104d54:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104d5b:	90                   	nop
80104d5c:	90                   	nop
80104d5d:	c9                   	leave  
80104d5e:	c3                   	ret    

80104d5f <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80104d5f:	55                   	push   %ebp
80104d60:	89 e5                	mov    %esp,%ebp
80104d62:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104d65:	83 ec 08             	sub    $0x8,%esp
80104d68:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d6b:	50                   	push   %eax
80104d6c:	ff 75 08             	pushl  0x8(%ebp)
80104d6f:	e8 a1 fe ff ff       	call   80104c15 <argint>
80104d74:	83 c4 10             	add    $0x10,%esp
80104d77:	85 c0                	test   %eax,%eax
80104d79:	79 07                	jns    80104d82 <argfd+0x23>
    return -1;
80104d7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d80:	eb 4f                	jmp    80104dd1 <argfd+0x72>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d82:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d85:	85 c0                	test   %eax,%eax
80104d87:	78 20                	js     80104da9 <argfd+0x4a>
80104d89:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d8c:	83 f8 0f             	cmp    $0xf,%eax
80104d8f:	7f 18                	jg     80104da9 <argfd+0x4a>
80104d91:	e8 40 ec ff ff       	call   801039d6 <myproc>
80104d96:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104d99:	83 c2 08             	add    $0x8,%edx
80104d9c:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104da0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104da3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104da7:	75 07                	jne    80104db0 <argfd+0x51>
    return -1;
80104da9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dae:	eb 21                	jmp    80104dd1 <argfd+0x72>
  if(pfd)
80104db0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104db4:	74 08                	je     80104dbe <argfd+0x5f>
    *pfd = fd;
80104db6:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104db9:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dbc:	89 10                	mov    %edx,(%eax)
  if(pf)
80104dbe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104dc2:	74 08                	je     80104dcc <argfd+0x6d>
    *pf = f;
80104dc4:	8b 45 10             	mov    0x10(%ebp),%eax
80104dc7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104dca:	89 10                	mov    %edx,(%eax)
  return 0;
80104dcc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104dd1:	c9                   	leave  
80104dd2:	c3                   	ret    

80104dd3 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80104dd3:	55                   	push   %ebp
80104dd4:	89 e5                	mov    %esp,%ebp
80104dd6:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct proc *curproc = myproc();
80104dd9:	e8 f8 eb ff ff       	call   801039d6 <myproc>
80104dde:	89 45 f0             	mov    %eax,-0x10(%ebp)

  for(fd = 0; fd < NOFILE; fd++){
80104de1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104de8:	eb 29                	jmp    80104e13 <fdalloc+0x40>
    if(curproc->ofile[fd] == 0){
80104dea:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ded:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104df0:	83 c2 08             	add    $0x8,%edx
80104df3:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104df7:	85 c0                	test   %eax,%eax
80104df9:	75 15                	jne    80104e10 <fdalloc+0x3d>
      curproc->ofile[fd] = f;
80104dfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104dfe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e01:	8d 4a 08             	lea    0x8(%edx),%ecx
80104e04:	8b 55 08             	mov    0x8(%ebp),%edx
80104e07:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80104e0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e0e:	eb 0e                	jmp    80104e1e <fdalloc+0x4b>
  for(fd = 0; fd < NOFILE; fd++){
80104e10:	ff 45 f4             	incl   -0xc(%ebp)
80104e13:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e17:	7e d1                	jle    80104dea <fdalloc+0x17>
    }
  }
  return -1;
80104e19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e1e:	c9                   	leave  
80104e1f:	c3                   	ret    

80104e20 <sys_dup>:

int
sys_dup(void)
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104e26:	83 ec 04             	sub    $0x4,%esp
80104e29:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e2c:	50                   	push   %eax
80104e2d:	6a 00                	push   $0x0
80104e2f:	6a 00                	push   $0x0
80104e31:	e8 29 ff ff ff       	call   80104d5f <argfd>
80104e36:	83 c4 10             	add    $0x10,%esp
80104e39:	85 c0                	test   %eax,%eax
80104e3b:	79 07                	jns    80104e44 <sys_dup+0x24>
    return -1;
80104e3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e42:	eb 31                	jmp    80104e75 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80104e44:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e47:	83 ec 0c             	sub    $0xc,%esp
80104e4a:	50                   	push   %eax
80104e4b:	e8 83 ff ff ff       	call   80104dd3 <fdalloc>
80104e50:	83 c4 10             	add    $0x10,%esp
80104e53:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104e56:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104e5a:	79 07                	jns    80104e63 <sys_dup+0x43>
    return -1;
80104e5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e61:	eb 12                	jmp    80104e75 <sys_dup+0x55>
  filedup(f);
80104e63:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e66:	83 ec 0c             	sub    $0xc,%esp
80104e69:	50                   	push   %eax
80104e6a:	e8 a0 c1 ff ff       	call   8010100f <filedup>
80104e6f:	83 c4 10             	add    $0x10,%esp
  return fd;
80104e72:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104e75:	c9                   	leave  
80104e76:	c3                   	ret    

80104e77 <sys_read>:

int
sys_read(void)
{
80104e77:	55                   	push   %ebp
80104e78:	89 e5                	mov    %esp,%ebp
80104e7a:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e7d:	83 ec 04             	sub    $0x4,%esp
80104e80:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e83:	50                   	push   %eax
80104e84:	6a 00                	push   $0x0
80104e86:	6a 00                	push   $0x0
80104e88:	e8 d2 fe ff ff       	call   80104d5f <argfd>
80104e8d:	83 c4 10             	add    $0x10,%esp
80104e90:	85 c0                	test   %eax,%eax
80104e92:	78 2e                	js     80104ec2 <sys_read+0x4b>
80104e94:	83 ec 08             	sub    $0x8,%esp
80104e97:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e9a:	50                   	push   %eax
80104e9b:	6a 02                	push   $0x2
80104e9d:	e8 73 fd ff ff       	call   80104c15 <argint>
80104ea2:	83 c4 10             	add    $0x10,%esp
80104ea5:	85 c0                	test   %eax,%eax
80104ea7:	78 19                	js     80104ec2 <sys_read+0x4b>
80104ea9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104eac:	83 ec 04             	sub    $0x4,%esp
80104eaf:	50                   	push   %eax
80104eb0:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104eb3:	50                   	push   %eax
80104eb4:	6a 01                	push   $0x1
80104eb6:	e8 87 fd ff ff       	call   80104c42 <argptr>
80104ebb:	83 c4 10             	add    $0x10,%esp
80104ebe:	85 c0                	test   %eax,%eax
80104ec0:	79 07                	jns    80104ec9 <sys_read+0x52>
    return -1;
80104ec2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ec7:	eb 17                	jmp    80104ee0 <sys_read+0x69>
  return fileread(f, p, n);
80104ec9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80104ecc:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104ecf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ed2:	83 ec 04             	sub    $0x4,%esp
80104ed5:	51                   	push   %ecx
80104ed6:	52                   	push   %edx
80104ed7:	50                   	push   %eax
80104ed8:	e8 b6 c2 ff ff       	call   80101193 <fileread>
80104edd:	83 c4 10             	add    $0x10,%esp
}
80104ee0:	c9                   	leave  
80104ee1:	c3                   	ret    

80104ee2 <sys_write>:

int
sys_write(void)
{
80104ee2:	55                   	push   %ebp
80104ee3:	89 e5                	mov    %esp,%ebp
80104ee5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ee8:	83 ec 04             	sub    $0x4,%esp
80104eeb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eee:	50                   	push   %eax
80104eef:	6a 00                	push   $0x0
80104ef1:	6a 00                	push   $0x0
80104ef3:	e8 67 fe ff ff       	call   80104d5f <argfd>
80104ef8:	83 c4 10             	add    $0x10,%esp
80104efb:	85 c0                	test   %eax,%eax
80104efd:	78 2e                	js     80104f2d <sys_write+0x4b>
80104eff:	83 ec 08             	sub    $0x8,%esp
80104f02:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f05:	50                   	push   %eax
80104f06:	6a 02                	push   $0x2
80104f08:	e8 08 fd ff ff       	call   80104c15 <argint>
80104f0d:	83 c4 10             	add    $0x10,%esp
80104f10:	85 c0                	test   %eax,%eax
80104f12:	78 19                	js     80104f2d <sys_write+0x4b>
80104f14:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f17:	83 ec 04             	sub    $0x4,%esp
80104f1a:	50                   	push   %eax
80104f1b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104f1e:	50                   	push   %eax
80104f1f:	6a 01                	push   $0x1
80104f21:	e8 1c fd ff ff       	call   80104c42 <argptr>
80104f26:	83 c4 10             	add    $0x10,%esp
80104f29:	85 c0                	test   %eax,%eax
80104f2b:	79 07                	jns    80104f34 <sys_write+0x52>
    return -1;
80104f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f32:	eb 17                	jmp    80104f4b <sys_write+0x69>
  return filewrite(f, p, n);
80104f34:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80104f37:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104f3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f3d:	83 ec 04             	sub    $0x4,%esp
80104f40:	51                   	push   %ecx
80104f41:	52                   	push   %edx
80104f42:	50                   	push   %eax
80104f43:	e8 02 c3 ff ff       	call   8010124a <filewrite>
80104f48:	83 c4 10             	add    $0x10,%esp
}
80104f4b:	c9                   	leave  
80104f4c:	c3                   	ret    

80104f4d <sys_close>:

int
sys_close(void)
{
80104f4d:	55                   	push   %ebp
80104f4e:	89 e5                	mov    %esp,%ebp
80104f50:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104f53:	83 ec 04             	sub    $0x4,%esp
80104f56:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f59:	50                   	push   %eax
80104f5a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f5d:	50                   	push   %eax
80104f5e:	6a 00                	push   $0x0
80104f60:	e8 fa fd ff ff       	call   80104d5f <argfd>
80104f65:	83 c4 10             	add    $0x10,%esp
80104f68:	85 c0                	test   %eax,%eax
80104f6a:	79 07                	jns    80104f73 <sys_close+0x26>
    return -1;
80104f6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f71:	eb 27                	jmp    80104f9a <sys_close+0x4d>
  myproc()->ofile[fd] = 0;
80104f73:	e8 5e ea ff ff       	call   801039d6 <myproc>
80104f78:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f7b:	83 c2 08             	add    $0x8,%edx
80104f7e:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104f85:	00 
  fileclose(f);
80104f86:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f89:	83 ec 0c             	sub    $0xc,%esp
80104f8c:	50                   	push   %eax
80104f8d:	e8 ce c0 ff ff       	call   80101060 <fileclose>
80104f92:	83 c4 10             	add    $0x10,%esp
  return 0;
80104f95:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104f9a:	c9                   	leave  
80104f9b:	c3                   	ret    

80104f9c <sys_fstat>:

int
sys_fstat(void)
{
80104f9c:	55                   	push   %ebp
80104f9d:	89 e5                	mov    %esp,%ebp
80104f9f:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104fa2:	83 ec 04             	sub    $0x4,%esp
80104fa5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fa8:	50                   	push   %eax
80104fa9:	6a 00                	push   $0x0
80104fab:	6a 00                	push   $0x0
80104fad:	e8 ad fd ff ff       	call   80104d5f <argfd>
80104fb2:	83 c4 10             	add    $0x10,%esp
80104fb5:	85 c0                	test   %eax,%eax
80104fb7:	78 17                	js     80104fd0 <sys_fstat+0x34>
80104fb9:	83 ec 04             	sub    $0x4,%esp
80104fbc:	6a 14                	push   $0x14
80104fbe:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fc1:	50                   	push   %eax
80104fc2:	6a 01                	push   $0x1
80104fc4:	e8 79 fc ff ff       	call   80104c42 <argptr>
80104fc9:	83 c4 10             	add    $0x10,%esp
80104fcc:	85 c0                	test   %eax,%eax
80104fce:	79 07                	jns    80104fd7 <sys_fstat+0x3b>
    return -1;
80104fd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fd5:	eb 13                	jmp    80104fea <sys_fstat+0x4e>
  return filestat(f, st);
80104fd7:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104fda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fdd:	83 ec 08             	sub    $0x8,%esp
80104fe0:	52                   	push   %edx
80104fe1:	50                   	push   %eax
80104fe2:	e8 55 c1 ff ff       	call   8010113c <filestat>
80104fe7:	83 c4 10             	add    $0x10,%esp
}
80104fea:	c9                   	leave  
80104feb:	c3                   	ret    

80104fec <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104fec:	55                   	push   %ebp
80104fed:	89 e5                	mov    %esp,%ebp
80104fef:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ff2:	83 ec 08             	sub    $0x8,%esp
80104ff5:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104ff8:	50                   	push   %eax
80104ff9:	6a 00                	push   $0x0
80104ffb:	e8 aa fc ff ff       	call   80104caa <argstr>
80105000:	83 c4 10             	add    $0x10,%esp
80105003:	85 c0                	test   %eax,%eax
80105005:	78 15                	js     8010501c <sys_link+0x30>
80105007:	83 ec 08             	sub    $0x8,%esp
8010500a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010500d:	50                   	push   %eax
8010500e:	6a 01                	push   $0x1
80105010:	e8 95 fc ff ff       	call   80104caa <argstr>
80105015:	83 c4 10             	add    $0x10,%esp
80105018:	85 c0                	test   %eax,%eax
8010501a:	79 0a                	jns    80105026 <sys_link+0x3a>
    return -1;
8010501c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105021:	e9 5f 01 00 00       	jmp    80105185 <sys_link+0x199>

  begin_op();
80105026:	e8 8e df ff ff       	call   80102fb9 <begin_op>
  if((ip = namei(old)) == 0){
8010502b:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010502e:	83 ec 0c             	sub    $0xc,%esp
80105031:	50                   	push   %eax
80105032:	e8 81 d4 ff ff       	call   801024b8 <namei>
80105037:	83 c4 10             	add    $0x10,%esp
8010503a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010503d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105041:	75 0f                	jne    80105052 <sys_link+0x66>
    end_op();
80105043:	e8 fb df ff ff       	call   80103043 <end_op>
    return -1;
80105048:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010504d:	e9 33 01 00 00       	jmp    80105185 <sys_link+0x199>
  }

  ilock(ip);
80105052:	83 ec 0c             	sub    $0xc,%esp
80105055:	ff 75 f4             	pushl  -0xc(%ebp)
80105058:	e8 31 c9 ff ff       	call   8010198e <ilock>
8010505d:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105060:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105063:	8b 40 50             	mov    0x50(%eax),%eax
80105066:	66 83 f8 01          	cmp    $0x1,%ax
8010506a:	75 1d                	jne    80105089 <sys_link+0x9d>
    iunlockput(ip);
8010506c:	83 ec 0c             	sub    $0xc,%esp
8010506f:	ff 75 f4             	pushl  -0xc(%ebp)
80105072:	e8 45 cb ff ff       	call   80101bbc <iunlockput>
80105077:	83 c4 10             	add    $0x10,%esp
    end_op();
8010507a:	e8 c4 df ff ff       	call   80103043 <end_op>
    return -1;
8010507f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105084:	e9 fc 00 00 00       	jmp    80105185 <sys_link+0x199>
  }

  ip->nlink++;
80105089:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010508c:	66 8b 40 56          	mov    0x56(%eax),%ax
80105090:	40                   	inc    %eax
80105091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105094:	66 89 42 56          	mov    %ax,0x56(%edx)
  iupdate(ip);
80105098:	83 ec 0c             	sub    $0xc,%esp
8010509b:	ff 75 f4             	pushl  -0xc(%ebp)
8010509e:	e8 10 c7 ff ff       	call   801017b3 <iupdate>
801050a3:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
801050a6:	83 ec 0c             	sub    $0xc,%esp
801050a9:	ff 75 f4             	pushl  -0xc(%ebp)
801050ac:	e8 ed c9 ff ff       	call   80101a9e <iunlock>
801050b1:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
801050b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801050b7:	83 ec 08             	sub    $0x8,%esp
801050ba:	8d 55 e2             	lea    -0x1e(%ebp),%edx
801050bd:	52                   	push   %edx
801050be:	50                   	push   %eax
801050bf:	e8 10 d4 ff ff       	call   801024d4 <nameiparent>
801050c4:	83 c4 10             	add    $0x10,%esp
801050c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801050ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801050ce:	74 71                	je     80105141 <sys_link+0x155>
    goto bad;
  ilock(dp);
801050d0:	83 ec 0c             	sub    $0xc,%esp
801050d3:	ff 75 f0             	pushl  -0x10(%ebp)
801050d6:	e8 b3 c8 ff ff       	call   8010198e <ilock>
801050db:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801050de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050e1:	8b 10                	mov    (%eax),%edx
801050e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050e6:	8b 00                	mov    (%eax),%eax
801050e8:	39 c2                	cmp    %eax,%edx
801050ea:	75 1d                	jne    80105109 <sys_link+0x11d>
801050ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050ef:	8b 40 04             	mov    0x4(%eax),%eax
801050f2:	83 ec 04             	sub    $0x4,%esp
801050f5:	50                   	push   %eax
801050f6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801050f9:	50                   	push   %eax
801050fa:	ff 75 f0             	pushl  -0x10(%ebp)
801050fd:	e8 2b d1 ff ff       	call   8010222d <dirlink>
80105102:	83 c4 10             	add    $0x10,%esp
80105105:	85 c0                	test   %eax,%eax
80105107:	79 10                	jns    80105119 <sys_link+0x12d>
    iunlockput(dp);
80105109:	83 ec 0c             	sub    $0xc,%esp
8010510c:	ff 75 f0             	pushl  -0x10(%ebp)
8010510f:	e8 a8 ca ff ff       	call   80101bbc <iunlockput>
80105114:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105117:	eb 29                	jmp    80105142 <sys_link+0x156>
  }
  iunlockput(dp);
80105119:	83 ec 0c             	sub    $0xc,%esp
8010511c:	ff 75 f0             	pushl  -0x10(%ebp)
8010511f:	e8 98 ca ff ff       	call   80101bbc <iunlockput>
80105124:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105127:	83 ec 0c             	sub    $0xc,%esp
8010512a:	ff 75 f4             	pushl  -0xc(%ebp)
8010512d:	e8 ba c9 ff ff       	call   80101aec <iput>
80105132:	83 c4 10             	add    $0x10,%esp

  end_op();
80105135:	e8 09 df ff ff       	call   80103043 <end_op>

  return 0;
8010513a:	b8 00 00 00 00       	mov    $0x0,%eax
8010513f:	eb 44                	jmp    80105185 <sys_link+0x199>
    goto bad;
80105141:	90                   	nop

bad:
  ilock(ip);
80105142:	83 ec 0c             	sub    $0xc,%esp
80105145:	ff 75 f4             	pushl  -0xc(%ebp)
80105148:	e8 41 c8 ff ff       	call   8010198e <ilock>
8010514d:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105150:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105153:	66 8b 40 56          	mov    0x56(%eax),%ax
80105157:	48                   	dec    %eax
80105158:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010515b:	66 89 42 56          	mov    %ax,0x56(%edx)
  iupdate(ip);
8010515f:	83 ec 0c             	sub    $0xc,%esp
80105162:	ff 75 f4             	pushl  -0xc(%ebp)
80105165:	e8 49 c6 ff ff       	call   801017b3 <iupdate>
8010516a:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
8010516d:	83 ec 0c             	sub    $0xc,%esp
80105170:	ff 75 f4             	pushl  -0xc(%ebp)
80105173:	e8 44 ca ff ff       	call   80101bbc <iunlockput>
80105178:	83 c4 10             	add    $0x10,%esp
  end_op();
8010517b:	e8 c3 de ff ff       	call   80103043 <end_op>
  return -1;
80105180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105185:	c9                   	leave  
80105186:	c3                   	ret    

80105187 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105187:	55                   	push   %ebp
80105188:	89 e5                	mov    %esp,%ebp
8010518a:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010518d:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105194:	eb 3f                	jmp    801051d5 <isdirempty+0x4e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105199:	6a 10                	push   $0x10
8010519b:	50                   	push   %eax
8010519c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010519f:	50                   	push   %eax
801051a0:	ff 75 08             	pushl  0x8(%ebp)
801051a3:	e8 cc cc ff ff       	call   80101e74 <readi>
801051a8:	83 c4 10             	add    $0x10,%esp
801051ab:	83 f8 10             	cmp    $0x10,%eax
801051ae:	74 0d                	je     801051bd <isdirempty+0x36>
      panic("isdirempty: readi");
801051b0:	83 ec 0c             	sub    $0xc,%esp
801051b3:	68 14 a2 10 80       	push   $0x8010a214
801051b8:	e8 e2 b3 ff ff       	call   8010059f <panic>
    if(de.inum != 0)
801051bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801051c0:	66 85 c0             	test   %ax,%ax
801051c3:	74 07                	je     801051cc <isdirempty+0x45>
      return 0;
801051c5:	b8 00 00 00 00       	mov    $0x0,%eax
801051ca:	eb 1b                	jmp    801051e7 <isdirempty+0x60>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801051cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051cf:	83 c0 10             	add    $0x10,%eax
801051d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801051d5:	8b 45 08             	mov    0x8(%ebp),%eax
801051d8:	8b 40 58             	mov    0x58(%eax),%eax
801051db:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051de:	39 c2                	cmp    %eax,%edx
801051e0:	72 b4                	jb     80105196 <isdirempty+0xf>
  }
  return 1;
801051e2:	b8 01 00 00 00       	mov    $0x1,%eax
}
801051e7:	c9                   	leave  
801051e8:	c3                   	ret    

801051e9 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801051e9:	55                   	push   %ebp
801051ea:	89 e5                	mov    %esp,%ebp
801051ec:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801051ef:	83 ec 08             	sub    $0x8,%esp
801051f2:	8d 45 cc             	lea    -0x34(%ebp),%eax
801051f5:	50                   	push   %eax
801051f6:	6a 00                	push   $0x0
801051f8:	e8 ad fa ff ff       	call   80104caa <argstr>
801051fd:	83 c4 10             	add    $0x10,%esp
80105200:	85 c0                	test   %eax,%eax
80105202:	79 0a                	jns    8010520e <sys_unlink+0x25>
    return -1;
80105204:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105209:	e9 b5 01 00 00       	jmp    801053c3 <sys_unlink+0x1da>

  begin_op();
8010520e:	e8 a6 dd ff ff       	call   80102fb9 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105213:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105216:	83 ec 08             	sub    $0x8,%esp
80105219:	8d 55 d2             	lea    -0x2e(%ebp),%edx
8010521c:	52                   	push   %edx
8010521d:	50                   	push   %eax
8010521e:	e8 b1 d2 ff ff       	call   801024d4 <nameiparent>
80105223:	83 c4 10             	add    $0x10,%esp
80105226:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105229:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010522d:	75 0f                	jne    8010523e <sys_unlink+0x55>
    end_op();
8010522f:	e8 0f de ff ff       	call   80103043 <end_op>
    return -1;
80105234:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105239:	e9 85 01 00 00       	jmp    801053c3 <sys_unlink+0x1da>
  }

  ilock(dp);
8010523e:	83 ec 0c             	sub    $0xc,%esp
80105241:	ff 75 f4             	pushl  -0xc(%ebp)
80105244:	e8 45 c7 ff ff       	call   8010198e <ilock>
80105249:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010524c:	83 ec 08             	sub    $0x8,%esp
8010524f:	68 26 a2 10 80       	push   $0x8010a226
80105254:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105257:	50                   	push   %eax
80105258:	e8 fe ce ff ff       	call   8010215b <namecmp>
8010525d:	83 c4 10             	add    $0x10,%esp
80105260:	85 c0                	test   %eax,%eax
80105262:	0f 84 3f 01 00 00    	je     801053a7 <sys_unlink+0x1be>
80105268:	83 ec 08             	sub    $0x8,%esp
8010526b:	68 28 a2 10 80       	push   $0x8010a228
80105270:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105273:	50                   	push   %eax
80105274:	e8 e2 ce ff ff       	call   8010215b <namecmp>
80105279:	83 c4 10             	add    $0x10,%esp
8010527c:	85 c0                	test   %eax,%eax
8010527e:	0f 84 23 01 00 00    	je     801053a7 <sys_unlink+0x1be>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105284:	83 ec 04             	sub    $0x4,%esp
80105287:	8d 45 c8             	lea    -0x38(%ebp),%eax
8010528a:	50                   	push   %eax
8010528b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
8010528e:	50                   	push   %eax
8010528f:	ff 75 f4             	pushl  -0xc(%ebp)
80105292:	e8 df ce ff ff       	call   80102176 <dirlookup>
80105297:	83 c4 10             	add    $0x10,%esp
8010529a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010529d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801052a1:	0f 84 03 01 00 00    	je     801053aa <sys_unlink+0x1c1>
    goto bad;
  ilock(ip);
801052a7:	83 ec 0c             	sub    $0xc,%esp
801052aa:	ff 75 f0             	pushl  -0x10(%ebp)
801052ad:	e8 dc c6 ff ff       	call   8010198e <ilock>
801052b2:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
801052b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052b8:	66 8b 40 56          	mov    0x56(%eax),%ax
801052bc:	66 85 c0             	test   %ax,%ax
801052bf:	7f 0d                	jg     801052ce <sys_unlink+0xe5>
    panic("unlink: nlink < 1");
801052c1:	83 ec 0c             	sub    $0xc,%esp
801052c4:	68 2b a2 10 80       	push   $0x8010a22b
801052c9:	e8 d1 b2 ff ff       	call   8010059f <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
801052ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052d1:	8b 40 50             	mov    0x50(%eax),%eax
801052d4:	66 83 f8 01          	cmp    $0x1,%ax
801052d8:	75 25                	jne    801052ff <sys_unlink+0x116>
801052da:	83 ec 0c             	sub    $0xc,%esp
801052dd:	ff 75 f0             	pushl  -0x10(%ebp)
801052e0:	e8 a2 fe ff ff       	call   80105187 <isdirempty>
801052e5:	83 c4 10             	add    $0x10,%esp
801052e8:	85 c0                	test   %eax,%eax
801052ea:	75 13                	jne    801052ff <sys_unlink+0x116>
    iunlockput(ip);
801052ec:	83 ec 0c             	sub    $0xc,%esp
801052ef:	ff 75 f0             	pushl  -0x10(%ebp)
801052f2:	e8 c5 c8 ff ff       	call   80101bbc <iunlockput>
801052f7:	83 c4 10             	add    $0x10,%esp
    goto bad;
801052fa:	e9 ac 00 00 00       	jmp    801053ab <sys_unlink+0x1c2>
  }

  memset(&de, 0, sizeof(de));
801052ff:	83 ec 04             	sub    $0x4,%esp
80105302:	6a 10                	push   $0x10
80105304:	6a 00                	push   $0x0
80105306:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105309:	50                   	push   %eax
8010530a:	e8 f6 f5 ff ff       	call   80104905 <memset>
8010530f:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105312:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105315:	6a 10                	push   $0x10
80105317:	50                   	push   %eax
80105318:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010531b:	50                   	push   %eax
8010531c:	ff 75 f4             	pushl  -0xc(%ebp)
8010531f:	e8 ab cc ff ff       	call   80101fcf <writei>
80105324:	83 c4 10             	add    $0x10,%esp
80105327:	83 f8 10             	cmp    $0x10,%eax
8010532a:	74 0d                	je     80105339 <sys_unlink+0x150>
    panic("unlink: writei");
8010532c:	83 ec 0c             	sub    $0xc,%esp
8010532f:	68 3d a2 10 80       	push   $0x8010a23d
80105334:	e8 66 b2 ff ff       	call   8010059f <panic>
  if(ip->type == T_DIR){
80105339:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010533c:	8b 40 50             	mov    0x50(%eax),%eax
8010533f:	66 83 f8 01          	cmp    $0x1,%ax
80105343:	75 1d                	jne    80105362 <sys_unlink+0x179>
    dp->nlink--;
80105345:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105348:	66 8b 40 56          	mov    0x56(%eax),%ax
8010534c:	48                   	dec    %eax
8010534d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105350:	66 89 42 56          	mov    %ax,0x56(%edx)
    iupdate(dp);
80105354:	83 ec 0c             	sub    $0xc,%esp
80105357:	ff 75 f4             	pushl  -0xc(%ebp)
8010535a:	e8 54 c4 ff ff       	call   801017b3 <iupdate>
8010535f:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105362:	83 ec 0c             	sub    $0xc,%esp
80105365:	ff 75 f4             	pushl  -0xc(%ebp)
80105368:	e8 4f c8 ff ff       	call   80101bbc <iunlockput>
8010536d:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105370:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105373:	66 8b 40 56          	mov    0x56(%eax),%ax
80105377:	48                   	dec    %eax
80105378:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010537b:	66 89 42 56          	mov    %ax,0x56(%edx)
  iupdate(ip);
8010537f:	83 ec 0c             	sub    $0xc,%esp
80105382:	ff 75 f0             	pushl  -0x10(%ebp)
80105385:	e8 29 c4 ff ff       	call   801017b3 <iupdate>
8010538a:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
8010538d:	83 ec 0c             	sub    $0xc,%esp
80105390:	ff 75 f0             	pushl  -0x10(%ebp)
80105393:	e8 24 c8 ff ff       	call   80101bbc <iunlockput>
80105398:	83 c4 10             	add    $0x10,%esp

  end_op();
8010539b:	e8 a3 dc ff ff       	call   80103043 <end_op>

  return 0;
801053a0:	b8 00 00 00 00       	mov    $0x0,%eax
801053a5:	eb 1c                	jmp    801053c3 <sys_unlink+0x1da>
    goto bad;
801053a7:	90                   	nop
801053a8:	eb 01                	jmp    801053ab <sys_unlink+0x1c2>
    goto bad;
801053aa:	90                   	nop

bad:
  iunlockput(dp);
801053ab:	83 ec 0c             	sub    $0xc,%esp
801053ae:	ff 75 f4             	pushl  -0xc(%ebp)
801053b1:	e8 06 c8 ff ff       	call   80101bbc <iunlockput>
801053b6:	83 c4 10             	add    $0x10,%esp
  end_op();
801053b9:	e8 85 dc ff ff       	call   80103043 <end_op>
  return -1;
801053be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053c3:	c9                   	leave  
801053c4:	c3                   	ret    

801053c5 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
801053c5:	55                   	push   %ebp
801053c6:	89 e5                	mov    %esp,%ebp
801053c8:	83 ec 38             	sub    $0x38,%esp
801053cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ce:	8b 4d 10             	mov    0x10(%ebp),%ecx
801053d1:	8b 55 14             	mov    0x14(%ebp),%edx
801053d4:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
801053d8:	89 c8                	mov    %ecx,%eax
801053da:	66 89 45 d0          	mov    %ax,-0x30(%ebp)
801053de:	89 d0                	mov    %edx,%eax
801053e0:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801053e4:	83 ec 08             	sub    $0x8,%esp
801053e7:	8d 45 de             	lea    -0x22(%ebp),%eax
801053ea:	50                   	push   %eax
801053eb:	ff 75 08             	pushl  0x8(%ebp)
801053ee:	e8 e1 d0 ff ff       	call   801024d4 <nameiparent>
801053f3:	83 c4 10             	add    $0x10,%esp
801053f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801053f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801053fd:	75 0a                	jne    80105409 <create+0x44>
    return 0;
801053ff:	b8 00 00 00 00       	mov    $0x0,%eax
80105404:	e9 89 01 00 00       	jmp    80105592 <create+0x1cd>
  ilock(dp);
80105409:	83 ec 0c             	sub    $0xc,%esp
8010540c:	ff 75 f4             	pushl  -0xc(%ebp)
8010540f:	e8 7a c5 ff ff       	call   8010198e <ilock>
80105414:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105417:	83 ec 04             	sub    $0x4,%esp
8010541a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010541d:	50                   	push   %eax
8010541e:	8d 45 de             	lea    -0x22(%ebp),%eax
80105421:	50                   	push   %eax
80105422:	ff 75 f4             	pushl  -0xc(%ebp)
80105425:	e8 4c cd ff ff       	call   80102176 <dirlookup>
8010542a:	83 c4 10             	add    $0x10,%esp
8010542d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105430:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105434:	74 4f                	je     80105485 <create+0xc0>
    iunlockput(dp);
80105436:	83 ec 0c             	sub    $0xc,%esp
80105439:	ff 75 f4             	pushl  -0xc(%ebp)
8010543c:	e8 7b c7 ff ff       	call   80101bbc <iunlockput>
80105441:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105444:	83 ec 0c             	sub    $0xc,%esp
80105447:	ff 75 f0             	pushl  -0x10(%ebp)
8010544a:	e8 3f c5 ff ff       	call   8010198e <ilock>
8010544f:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105452:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105457:	75 14                	jne    8010546d <create+0xa8>
80105459:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010545c:	8b 40 50             	mov    0x50(%eax),%eax
8010545f:	66 83 f8 02          	cmp    $0x2,%ax
80105463:	75 08                	jne    8010546d <create+0xa8>
      return ip;
80105465:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105468:	e9 25 01 00 00       	jmp    80105592 <create+0x1cd>
    iunlockput(ip);
8010546d:	83 ec 0c             	sub    $0xc,%esp
80105470:	ff 75 f0             	pushl  -0x10(%ebp)
80105473:	e8 44 c7 ff ff       	call   80101bbc <iunlockput>
80105478:	83 c4 10             	add    $0x10,%esp
    return 0;
8010547b:	b8 00 00 00 00       	mov    $0x0,%eax
80105480:	e9 0d 01 00 00       	jmp    80105592 <create+0x1cd>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105485:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105489:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010548c:	8b 00                	mov    (%eax),%eax
8010548e:	83 ec 08             	sub    $0x8,%esp
80105491:	52                   	push   %edx
80105492:	50                   	push   %eax
80105493:	e8 48 c2 ff ff       	call   801016e0 <ialloc>
80105498:	83 c4 10             	add    $0x10,%esp
8010549b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010549e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801054a2:	75 0d                	jne    801054b1 <create+0xec>
    panic("create: ialloc");
801054a4:	83 ec 0c             	sub    $0xc,%esp
801054a7:	68 4c a2 10 80       	push   $0x8010a24c
801054ac:	e8 ee b0 ff ff       	call   8010059f <panic>

  ilock(ip);
801054b1:	83 ec 0c             	sub    $0xc,%esp
801054b4:	ff 75 f0             	pushl  -0x10(%ebp)
801054b7:	e8 d2 c4 ff ff       	call   8010198e <ilock>
801054bc:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
801054bf:	8b 55 f0             	mov    -0x10(%ebp),%edx
801054c2:	8b 45 d0             	mov    -0x30(%ebp),%eax
801054c5:	66 89 42 52          	mov    %ax,0x52(%edx)
  ip->minor = minor;
801054c9:	8b 55 f0             	mov    -0x10(%ebp),%edx
801054cc:	8b 45 cc             	mov    -0x34(%ebp),%eax
801054cf:	66 89 42 54          	mov    %ax,0x54(%edx)
  ip->nlink = 1;
801054d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054d6:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
  iupdate(ip);
801054dc:	83 ec 0c             	sub    $0xc,%esp
801054df:	ff 75 f0             	pushl  -0x10(%ebp)
801054e2:	e8 cc c2 ff ff       	call   801017b3 <iupdate>
801054e7:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
801054ea:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801054ef:	75 66                	jne    80105557 <create+0x192>
    dp->nlink++;  // for ".."
801054f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054f4:	66 8b 40 56          	mov    0x56(%eax),%ax
801054f8:	40                   	inc    %eax
801054f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054fc:	66 89 42 56          	mov    %ax,0x56(%edx)
    iupdate(dp);
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	ff 75 f4             	pushl  -0xc(%ebp)
80105506:	e8 a8 c2 ff ff       	call   801017b3 <iupdate>
8010550b:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010550e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105511:	8b 40 04             	mov    0x4(%eax),%eax
80105514:	83 ec 04             	sub    $0x4,%esp
80105517:	50                   	push   %eax
80105518:	68 26 a2 10 80       	push   $0x8010a226
8010551d:	ff 75 f0             	pushl  -0x10(%ebp)
80105520:	e8 08 cd ff ff       	call   8010222d <dirlink>
80105525:	83 c4 10             	add    $0x10,%esp
80105528:	85 c0                	test   %eax,%eax
8010552a:	78 1e                	js     8010554a <create+0x185>
8010552c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010552f:	8b 40 04             	mov    0x4(%eax),%eax
80105532:	83 ec 04             	sub    $0x4,%esp
80105535:	50                   	push   %eax
80105536:	68 28 a2 10 80       	push   $0x8010a228
8010553b:	ff 75 f0             	pushl  -0x10(%ebp)
8010553e:	e8 ea cc ff ff       	call   8010222d <dirlink>
80105543:	83 c4 10             	add    $0x10,%esp
80105546:	85 c0                	test   %eax,%eax
80105548:	79 0d                	jns    80105557 <create+0x192>
      panic("create dots");
8010554a:	83 ec 0c             	sub    $0xc,%esp
8010554d:	68 5b a2 10 80       	push   $0x8010a25b
80105552:	e8 48 b0 ff ff       	call   8010059f <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105557:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010555a:	8b 40 04             	mov    0x4(%eax),%eax
8010555d:	83 ec 04             	sub    $0x4,%esp
80105560:	50                   	push   %eax
80105561:	8d 45 de             	lea    -0x22(%ebp),%eax
80105564:	50                   	push   %eax
80105565:	ff 75 f4             	pushl  -0xc(%ebp)
80105568:	e8 c0 cc ff ff       	call   8010222d <dirlink>
8010556d:	83 c4 10             	add    $0x10,%esp
80105570:	85 c0                	test   %eax,%eax
80105572:	79 0d                	jns    80105581 <create+0x1bc>
    panic("create: dirlink");
80105574:	83 ec 0c             	sub    $0xc,%esp
80105577:	68 67 a2 10 80       	push   $0x8010a267
8010557c:	e8 1e b0 ff ff       	call   8010059f <panic>

  iunlockput(dp);
80105581:	83 ec 0c             	sub    $0xc,%esp
80105584:	ff 75 f4             	pushl  -0xc(%ebp)
80105587:	e8 30 c6 ff ff       	call   80101bbc <iunlockput>
8010558c:	83 c4 10             	add    $0x10,%esp

  return ip;
8010558f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105592:	c9                   	leave  
80105593:	c3                   	ret    

80105594 <sys_open>:

int
sys_open(void)
{
80105594:	55                   	push   %ebp
80105595:	89 e5                	mov    %esp,%ebp
80105597:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010559a:	83 ec 08             	sub    $0x8,%esp
8010559d:	8d 45 e8             	lea    -0x18(%ebp),%eax
801055a0:	50                   	push   %eax
801055a1:	6a 00                	push   $0x0
801055a3:	e8 02 f7 ff ff       	call   80104caa <argstr>
801055a8:	83 c4 10             	add    $0x10,%esp
801055ab:	85 c0                	test   %eax,%eax
801055ad:	78 15                	js     801055c4 <sys_open+0x30>
801055af:	83 ec 08             	sub    $0x8,%esp
801055b2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055b5:	50                   	push   %eax
801055b6:	6a 01                	push   $0x1
801055b8:	e8 58 f6 ff ff       	call   80104c15 <argint>
801055bd:	83 c4 10             	add    $0x10,%esp
801055c0:	85 c0                	test   %eax,%eax
801055c2:	79 0a                	jns    801055ce <sys_open+0x3a>
    return -1;
801055c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055c9:	e9 60 01 00 00       	jmp    8010572e <sys_open+0x19a>

  begin_op();
801055ce:	e8 e6 d9 ff ff       	call   80102fb9 <begin_op>

  if(omode & O_CREATE){
801055d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801055d6:	25 00 02 00 00       	and    $0x200,%eax
801055db:	85 c0                	test   %eax,%eax
801055dd:	74 2a                	je     80105609 <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
801055df:	8b 45 e8             	mov    -0x18(%ebp),%eax
801055e2:	6a 00                	push   $0x0
801055e4:	6a 00                	push   $0x0
801055e6:	6a 02                	push   $0x2
801055e8:	50                   	push   %eax
801055e9:	e8 d7 fd ff ff       	call   801053c5 <create>
801055ee:	83 c4 10             	add    $0x10,%esp
801055f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
801055f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055f8:	75 74                	jne    8010566e <sys_open+0xda>
      end_op();
801055fa:	e8 44 da ff ff       	call   80103043 <end_op>
      return -1;
801055ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105604:	e9 25 01 00 00       	jmp    8010572e <sys_open+0x19a>
    }
  } else {
    if((ip = namei(path)) == 0){
80105609:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010560c:	83 ec 0c             	sub    $0xc,%esp
8010560f:	50                   	push   %eax
80105610:	e8 a3 ce ff ff       	call   801024b8 <namei>
80105615:	83 c4 10             	add    $0x10,%esp
80105618:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010561b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010561f:	75 0f                	jne    80105630 <sys_open+0x9c>
      end_op();
80105621:	e8 1d da ff ff       	call   80103043 <end_op>
      return -1;
80105626:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010562b:	e9 fe 00 00 00       	jmp    8010572e <sys_open+0x19a>
    }
    ilock(ip);
80105630:	83 ec 0c             	sub    $0xc,%esp
80105633:	ff 75 f4             	pushl  -0xc(%ebp)
80105636:	e8 53 c3 ff ff       	call   8010198e <ilock>
8010563b:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
8010563e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105641:	8b 40 50             	mov    0x50(%eax),%eax
80105644:	66 83 f8 01          	cmp    $0x1,%ax
80105648:	75 24                	jne    8010566e <sys_open+0xda>
8010564a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010564d:	85 c0                	test   %eax,%eax
8010564f:	74 1d                	je     8010566e <sys_open+0xda>
      iunlockput(ip);
80105651:	83 ec 0c             	sub    $0xc,%esp
80105654:	ff 75 f4             	pushl  -0xc(%ebp)
80105657:	e8 60 c5 ff ff       	call   80101bbc <iunlockput>
8010565c:	83 c4 10             	add    $0x10,%esp
      end_op();
8010565f:	e8 df d9 ff ff       	call   80103043 <end_op>
      return -1;
80105664:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105669:	e9 c0 00 00 00       	jmp    8010572e <sys_open+0x19a>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010566e:	e8 2f b9 ff ff       	call   80100fa2 <filealloc>
80105673:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105676:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010567a:	74 17                	je     80105693 <sys_open+0xff>
8010567c:	83 ec 0c             	sub    $0xc,%esp
8010567f:	ff 75 f0             	pushl  -0x10(%ebp)
80105682:	e8 4c f7 ff ff       	call   80104dd3 <fdalloc>
80105687:	83 c4 10             	add    $0x10,%esp
8010568a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010568d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105691:	79 2e                	jns    801056c1 <sys_open+0x12d>
    if(f)
80105693:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105697:	74 0e                	je     801056a7 <sys_open+0x113>
      fileclose(f);
80105699:	83 ec 0c             	sub    $0xc,%esp
8010569c:	ff 75 f0             	pushl  -0x10(%ebp)
8010569f:	e8 bc b9 ff ff       	call   80101060 <fileclose>
801056a4:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801056a7:	83 ec 0c             	sub    $0xc,%esp
801056aa:	ff 75 f4             	pushl  -0xc(%ebp)
801056ad:	e8 0a c5 ff ff       	call   80101bbc <iunlockput>
801056b2:	83 c4 10             	add    $0x10,%esp
    end_op();
801056b5:	e8 89 d9 ff ff       	call   80103043 <end_op>
    return -1;
801056ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056bf:	eb 6d                	jmp    8010572e <sys_open+0x19a>
  }
  iunlock(ip);
801056c1:	83 ec 0c             	sub    $0xc,%esp
801056c4:	ff 75 f4             	pushl  -0xc(%ebp)
801056c7:	e8 d2 c3 ff ff       	call   80101a9e <iunlock>
801056cc:	83 c4 10             	add    $0x10,%esp
  end_op();
801056cf:	e8 6f d9 ff ff       	call   80103043 <end_op>

  f->type = FD_INODE;
801056d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056d7:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
801056dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056e3:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
801056e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056e9:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
801056f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801056f3:	83 e0 01             	and    $0x1,%eax
801056f6:	85 c0                	test   %eax,%eax
801056f8:	0f 94 c0             	sete   %al
801056fb:	88 c2                	mov    %al,%dl
801056fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105700:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105703:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105706:	83 e0 01             	and    $0x1,%eax
80105709:	85 c0                	test   %eax,%eax
8010570b:	75 0a                	jne    80105717 <sys_open+0x183>
8010570d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105710:	83 e0 02             	and    $0x2,%eax
80105713:	85 c0                	test   %eax,%eax
80105715:	74 07                	je     8010571e <sys_open+0x18a>
80105717:	b8 01 00 00 00       	mov    $0x1,%eax
8010571c:	eb 05                	jmp    80105723 <sys_open+0x18f>
8010571e:	b8 00 00 00 00       	mov    $0x0,%eax
80105723:	88 c2                	mov    %al,%dl
80105725:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105728:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
8010572b:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
8010572e:	c9                   	leave  
8010572f:	c3                   	ret    

80105730 <sys_mkdir>:

int
sys_mkdir(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105736:	e8 7e d8 ff ff       	call   80102fb9 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010573b:	83 ec 08             	sub    $0x8,%esp
8010573e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105741:	50                   	push   %eax
80105742:	6a 00                	push   $0x0
80105744:	e8 61 f5 ff ff       	call   80104caa <argstr>
80105749:	83 c4 10             	add    $0x10,%esp
8010574c:	85 c0                	test   %eax,%eax
8010574e:	78 1b                	js     8010576b <sys_mkdir+0x3b>
80105750:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105753:	6a 00                	push   $0x0
80105755:	6a 00                	push   $0x0
80105757:	6a 01                	push   $0x1
80105759:	50                   	push   %eax
8010575a:	e8 66 fc ff ff       	call   801053c5 <create>
8010575f:	83 c4 10             	add    $0x10,%esp
80105762:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105765:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105769:	75 0c                	jne    80105777 <sys_mkdir+0x47>
    end_op();
8010576b:	e8 d3 d8 ff ff       	call   80103043 <end_op>
    return -1;
80105770:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105775:	eb 18                	jmp    8010578f <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105777:	83 ec 0c             	sub    $0xc,%esp
8010577a:	ff 75 f4             	pushl  -0xc(%ebp)
8010577d:	e8 3a c4 ff ff       	call   80101bbc <iunlockput>
80105782:	83 c4 10             	add    $0x10,%esp
  end_op();
80105785:	e8 b9 d8 ff ff       	call   80103043 <end_op>
  return 0;
8010578a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010578f:	c9                   	leave  
80105790:	c3                   	ret    

80105791 <sys_mknod>:

int
sys_mknod(void)
{
80105791:	55                   	push   %ebp
80105792:	89 e5                	mov    %esp,%ebp
80105794:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105797:	e8 1d d8 ff ff       	call   80102fb9 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010579c:	83 ec 08             	sub    $0x8,%esp
8010579f:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057a2:	50                   	push   %eax
801057a3:	6a 00                	push   $0x0
801057a5:	e8 00 f5 ff ff       	call   80104caa <argstr>
801057aa:	83 c4 10             	add    $0x10,%esp
801057ad:	85 c0                	test   %eax,%eax
801057af:	78 4f                	js     80105800 <sys_mknod+0x6f>
     argint(1, &major) < 0 ||
801057b1:	83 ec 08             	sub    $0x8,%esp
801057b4:	8d 45 ec             	lea    -0x14(%ebp),%eax
801057b7:	50                   	push   %eax
801057b8:	6a 01                	push   $0x1
801057ba:	e8 56 f4 ff ff       	call   80104c15 <argint>
801057bf:	83 c4 10             	add    $0x10,%esp
  if((argstr(0, &path)) < 0 ||
801057c2:	85 c0                	test   %eax,%eax
801057c4:	78 3a                	js     80105800 <sys_mknod+0x6f>
     argint(2, &minor) < 0 ||
801057c6:	83 ec 08             	sub    $0x8,%esp
801057c9:	8d 45 e8             	lea    -0x18(%ebp),%eax
801057cc:	50                   	push   %eax
801057cd:	6a 02                	push   $0x2
801057cf:	e8 41 f4 ff ff       	call   80104c15 <argint>
801057d4:	83 c4 10             	add    $0x10,%esp
     argint(1, &major) < 0 ||
801057d7:	85 c0                	test   %eax,%eax
801057d9:	78 25                	js     80105800 <sys_mknod+0x6f>
     (ip = create(path, T_DEV, major, minor)) == 0){
801057db:	8b 45 e8             	mov    -0x18(%ebp),%eax
801057de:	0f bf c8             	movswl %ax,%ecx
801057e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801057e4:	0f bf d0             	movswl %ax,%edx
801057e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057ea:	51                   	push   %ecx
801057eb:	52                   	push   %edx
801057ec:	6a 03                	push   $0x3
801057ee:	50                   	push   %eax
801057ef:	e8 d1 fb ff ff       	call   801053c5 <create>
801057f4:	83 c4 10             	add    $0x10,%esp
801057f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     argint(2, &minor) < 0 ||
801057fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801057fe:	75 0c                	jne    8010580c <sys_mknod+0x7b>
    end_op();
80105800:	e8 3e d8 ff ff       	call   80103043 <end_op>
    return -1;
80105805:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010580a:	eb 18                	jmp    80105824 <sys_mknod+0x93>
  }
  iunlockput(ip);
8010580c:	83 ec 0c             	sub    $0xc,%esp
8010580f:	ff 75 f4             	pushl  -0xc(%ebp)
80105812:	e8 a5 c3 ff ff       	call   80101bbc <iunlockput>
80105817:	83 c4 10             	add    $0x10,%esp
  end_op();
8010581a:	e8 24 d8 ff ff       	call   80103043 <end_op>
  return 0;
8010581f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105824:	c9                   	leave  
80105825:	c3                   	ret    

80105826 <sys_chdir>:

int
sys_chdir(void)
{
80105826:	55                   	push   %ebp
80105827:	89 e5                	mov    %esp,%ebp
80105829:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
8010582c:	e8 a5 e1 ff ff       	call   801039d6 <myproc>
80105831:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  begin_op();
80105834:	e8 80 d7 ff ff       	call   80102fb9 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105839:	83 ec 08             	sub    $0x8,%esp
8010583c:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010583f:	50                   	push   %eax
80105840:	6a 00                	push   $0x0
80105842:	e8 63 f4 ff ff       	call   80104caa <argstr>
80105847:	83 c4 10             	add    $0x10,%esp
8010584a:	85 c0                	test   %eax,%eax
8010584c:	78 18                	js     80105866 <sys_chdir+0x40>
8010584e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105851:	83 ec 0c             	sub    $0xc,%esp
80105854:	50                   	push   %eax
80105855:	e8 5e cc ff ff       	call   801024b8 <namei>
8010585a:	83 c4 10             	add    $0x10,%esp
8010585d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105860:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105864:	75 0c                	jne    80105872 <sys_chdir+0x4c>
    end_op();
80105866:	e8 d8 d7 ff ff       	call   80103043 <end_op>
    return -1;
8010586b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105870:	eb 67                	jmp    801058d9 <sys_chdir+0xb3>
  }
  ilock(ip);
80105872:	83 ec 0c             	sub    $0xc,%esp
80105875:	ff 75 f0             	pushl  -0x10(%ebp)
80105878:	e8 11 c1 ff ff       	call   8010198e <ilock>
8010587d:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80105880:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105883:	8b 40 50             	mov    0x50(%eax),%eax
80105886:	66 83 f8 01          	cmp    $0x1,%ax
8010588a:	74 1a                	je     801058a6 <sys_chdir+0x80>
    iunlockput(ip);
8010588c:	83 ec 0c             	sub    $0xc,%esp
8010588f:	ff 75 f0             	pushl  -0x10(%ebp)
80105892:	e8 25 c3 ff ff       	call   80101bbc <iunlockput>
80105897:	83 c4 10             	add    $0x10,%esp
    end_op();
8010589a:	e8 a4 d7 ff ff       	call   80103043 <end_op>
    return -1;
8010589f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058a4:	eb 33                	jmp    801058d9 <sys_chdir+0xb3>
  }
  iunlock(ip);
801058a6:	83 ec 0c             	sub    $0xc,%esp
801058a9:	ff 75 f0             	pushl  -0x10(%ebp)
801058ac:	e8 ed c1 ff ff       	call   80101a9e <iunlock>
801058b1:	83 c4 10             	add    $0x10,%esp
  iput(curproc->cwd);
801058b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058b7:	8b 40 68             	mov    0x68(%eax),%eax
801058ba:	83 ec 0c             	sub    $0xc,%esp
801058bd:	50                   	push   %eax
801058be:	e8 29 c2 ff ff       	call   80101aec <iput>
801058c3:	83 c4 10             	add    $0x10,%esp
  end_op();
801058c6:	e8 78 d7 ff ff       	call   80103043 <end_op>
  curproc->cwd = ip;
801058cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058ce:	8b 55 f0             	mov    -0x10(%ebp),%edx
801058d1:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
801058d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801058d9:	c9                   	leave  
801058da:	c3                   	ret    

801058db <sys_exec>:

int
sys_exec(void)
{
801058db:	55                   	push   %ebp
801058dc:	89 e5                	mov    %esp,%ebp
801058de:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801058e4:	83 ec 08             	sub    $0x8,%esp
801058e7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058ea:	50                   	push   %eax
801058eb:	6a 00                	push   $0x0
801058ed:	e8 b8 f3 ff ff       	call   80104caa <argstr>
801058f2:	83 c4 10             	add    $0x10,%esp
801058f5:	85 c0                	test   %eax,%eax
801058f7:	78 18                	js     80105911 <sys_exec+0x36>
801058f9:	83 ec 08             	sub    $0x8,%esp
801058fc:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80105902:	50                   	push   %eax
80105903:	6a 01                	push   $0x1
80105905:	e8 0b f3 ff ff       	call   80104c15 <argint>
8010590a:	83 c4 10             	add    $0x10,%esp
8010590d:	85 c0                	test   %eax,%eax
8010590f:	79 0a                	jns    8010591b <sys_exec+0x40>
    return -1;
80105911:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105916:	e9 c5 00 00 00       	jmp    801059e0 <sys_exec+0x105>
  }
  memset(argv, 0, sizeof(argv));
8010591b:	83 ec 04             	sub    $0x4,%esp
8010591e:	68 80 00 00 00       	push   $0x80
80105923:	6a 00                	push   $0x0
80105925:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010592b:	50                   	push   %eax
8010592c:	e8 d4 ef ff ff       	call   80104905 <memset>
80105931:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80105934:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010593b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010593e:	83 f8 1f             	cmp    $0x1f,%eax
80105941:	76 0a                	jbe    8010594d <sys_exec+0x72>
      return -1;
80105943:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105948:	e9 93 00 00 00       	jmp    801059e0 <sys_exec+0x105>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010594d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105950:	c1 e0 02             	shl    $0x2,%eax
80105953:	89 c2                	mov    %eax,%edx
80105955:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
8010595b:	01 c2                	add    %eax,%edx
8010595d:	83 ec 08             	sub    $0x8,%esp
80105960:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105966:	50                   	push   %eax
80105967:	52                   	push   %edx
80105968:	e8 09 f2 ff ff       	call   80104b76 <fetchint>
8010596d:	83 c4 10             	add    $0x10,%esp
80105970:	85 c0                	test   %eax,%eax
80105972:	79 07                	jns    8010597b <sys_exec+0xa0>
      return -1;
80105974:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105979:	eb 65                	jmp    801059e0 <sys_exec+0x105>
    if(uarg == 0){
8010597b:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80105981:	85 c0                	test   %eax,%eax
80105983:	75 27                	jne    801059ac <sys_exec+0xd1>
      argv[i] = 0;
80105985:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105988:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010598f:	00 00 00 00 
      break;
80105993:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105994:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105997:	83 ec 08             	sub    $0x8,%esp
8010599a:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
801059a0:	52                   	push   %edx
801059a1:	50                   	push   %eax
801059a2:	e8 ac b1 ff ff       	call   80100b53 <exec>
801059a7:	83 c4 10             	add    $0x10,%esp
801059aa:	eb 34                	jmp    801059e0 <sys_exec+0x105>
    if(fetchstr(uarg, &argv[i]) < 0)
801059ac:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801059b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059b5:	c1 e2 02             	shl    $0x2,%edx
801059b8:	01 c2                	add    %eax,%edx
801059ba:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801059c0:	83 ec 08             	sub    $0x8,%esp
801059c3:	52                   	push   %edx
801059c4:	50                   	push   %eax
801059c5:	e8 eb f1 ff ff       	call   80104bb5 <fetchstr>
801059ca:	83 c4 10             	add    $0x10,%esp
801059cd:	85 c0                	test   %eax,%eax
801059cf:	79 07                	jns    801059d8 <sys_exec+0xfd>
      return -1;
801059d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059d6:	eb 08                	jmp    801059e0 <sys_exec+0x105>
  for(i=0;; i++){
801059d8:	ff 45 f4             	incl   -0xc(%ebp)
    if(i >= NELEM(argv))
801059db:	e9 5b ff ff ff       	jmp    8010593b <sys_exec+0x60>
}
801059e0:	c9                   	leave  
801059e1:	c3                   	ret    

801059e2 <sys_pipe>:

int
sys_pipe(void)
{
801059e2:	55                   	push   %ebp
801059e3:	89 e5                	mov    %esp,%ebp
801059e5:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801059e8:	83 ec 04             	sub    $0x4,%esp
801059eb:	6a 08                	push   $0x8
801059ed:	8d 45 ec             	lea    -0x14(%ebp),%eax
801059f0:	50                   	push   %eax
801059f1:	6a 00                	push   $0x0
801059f3:	e8 4a f2 ff ff       	call   80104c42 <argptr>
801059f8:	83 c4 10             	add    $0x10,%esp
801059fb:	85 c0                	test   %eax,%eax
801059fd:	79 0a                	jns    80105a09 <sys_pipe+0x27>
    return -1;
801059ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a04:	e9 ae 00 00 00       	jmp    80105ab7 <sys_pipe+0xd5>
  if(pipealloc(&rf, &wf) < 0)
80105a09:	83 ec 08             	sub    $0x8,%esp
80105a0c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a0f:	50                   	push   %eax
80105a10:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105a13:	50                   	push   %eax
80105a14:	e8 cc da ff ff       	call   801034e5 <pipealloc>
80105a19:	83 c4 10             	add    $0x10,%esp
80105a1c:	85 c0                	test   %eax,%eax
80105a1e:	79 0a                	jns    80105a2a <sys_pipe+0x48>
    return -1;
80105a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a25:	e9 8d 00 00 00       	jmp    80105ab7 <sys_pipe+0xd5>
  fd0 = -1;
80105a2a:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a31:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105a34:	83 ec 0c             	sub    $0xc,%esp
80105a37:	50                   	push   %eax
80105a38:	e8 96 f3 ff ff       	call   80104dd3 <fdalloc>
80105a3d:	83 c4 10             	add    $0x10,%esp
80105a40:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a43:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a47:	78 18                	js     80105a61 <sys_pipe+0x7f>
80105a49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a4c:	83 ec 0c             	sub    $0xc,%esp
80105a4f:	50                   	push   %eax
80105a50:	e8 7e f3 ff ff       	call   80104dd3 <fdalloc>
80105a55:	83 c4 10             	add    $0x10,%esp
80105a58:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a5b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a5f:	79 3e                	jns    80105a9f <sys_pipe+0xbd>
    if(fd0 >= 0)
80105a61:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a65:	78 13                	js     80105a7a <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105a67:	e8 6a df ff ff       	call   801039d6 <myproc>
80105a6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a6f:	83 c2 08             	add    $0x8,%edx
80105a72:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105a79:	00 
    fileclose(rf);
80105a7a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105a7d:	83 ec 0c             	sub    $0xc,%esp
80105a80:	50                   	push   %eax
80105a81:	e8 da b5 ff ff       	call   80101060 <fileclose>
80105a86:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80105a89:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a8c:	83 ec 0c             	sub    $0xc,%esp
80105a8f:	50                   	push   %eax
80105a90:	e8 cb b5 ff ff       	call   80101060 <fileclose>
80105a95:	83 c4 10             	add    $0x10,%esp
    return -1;
80105a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a9d:	eb 18                	jmp    80105ab7 <sys_pipe+0xd5>
  }
  fd[0] = fd0;
80105a9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105aa2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aa5:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80105aa7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105aaa:	8d 50 04             	lea    0x4(%eax),%edx
80105aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ab0:	89 02                	mov    %eax,(%edx)
  return 0;
80105ab2:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ab7:	c9                   	leave  
80105ab8:	c3                   	ret    

80105ab9 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105ab9:	55                   	push   %ebp
80105aba:	89 e5                	mov    %esp,%ebp
80105abc:	83 ec 08             	sub    $0x8,%esp
  return fork();
80105abf:	e8 0f e2 ff ff       	call   80103cd3 <fork>
}
80105ac4:	c9                   	leave  
80105ac5:	c3                   	ret    

80105ac6 <sys_exit>:

int
sys_exit(void)
{
80105ac6:	55                   	push   %ebp
80105ac7:	89 e5                	mov    %esp,%ebp
80105ac9:	83 ec 08             	sub    $0x8,%esp
  exit();
80105acc:	e8 7a e3 ff ff       	call   80103e4b <exit>
  return 0;  // not reached
80105ad1:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ad6:	c9                   	leave  
80105ad7:	c3                   	ret    

80105ad8 <sys_wait>:

int
sys_wait(void)
{
80105ad8:	55                   	push   %ebp
80105ad9:	89 e5                	mov    %esp,%ebp
80105adb:	83 ec 08             	sub    $0x8,%esp
  return wait();
80105ade:	e8 87 e4 ff ff       	call   80103f6a <wait>
}
80105ae3:	c9                   	leave  
80105ae4:	c3                   	ret    

80105ae5 <sys_kill>:

int
sys_kill(void)
{
80105ae5:	55                   	push   %ebp
80105ae6:	89 e5                	mov    %esp,%ebp
80105ae8:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105aeb:	83 ec 08             	sub    $0x8,%esp
80105aee:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105af1:	50                   	push   %eax
80105af2:	6a 00                	push   $0x0
80105af4:	e8 1c f1 ff ff       	call   80104c15 <argint>
80105af9:	83 c4 10             	add    $0x10,%esp
80105afc:	85 c0                	test   %eax,%eax
80105afe:	79 07                	jns    80105b07 <sys_kill+0x22>
    return -1;
80105b00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b05:	eb 0f                	jmp    80105b16 <sys_kill+0x31>
  return kill(pid);
80105b07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b0a:	83 ec 0c             	sub    $0xc,%esp
80105b0d:	50                   	push   %eax
80105b0e:	e8 86 e8 ff ff       	call   80104399 <kill>
80105b13:	83 c4 10             	add    $0x10,%esp
}
80105b16:	c9                   	leave  
80105b17:	c3                   	ret    

80105b18 <sys_getpid>:

int
sys_getpid(void)
{
80105b18:	55                   	push   %ebp
80105b19:	89 e5                	mov    %esp,%ebp
80105b1b:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105b1e:	e8 b3 de ff ff       	call   801039d6 <myproc>
80105b23:	8b 40 10             	mov    0x10(%eax),%eax
}
80105b26:	c9                   	leave  
80105b27:	c3                   	ret    

80105b28 <sys_sbrk>:

int
sys_sbrk(void)
{
80105b28:	55                   	push   %ebp
80105b29:	89 e5                	mov    %esp,%ebp
80105b2b:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105b2e:	83 ec 08             	sub    $0x8,%esp
80105b31:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b34:	50                   	push   %eax
80105b35:	6a 00                	push   $0x0
80105b37:	e8 d9 f0 ff ff       	call   80104c15 <argint>
80105b3c:	83 c4 10             	add    $0x10,%esp
80105b3f:	85 c0                	test   %eax,%eax
80105b41:	79 07                	jns    80105b4a <sys_sbrk+0x22>
    return -1;
80105b43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b48:	eb 27                	jmp    80105b71 <sys_sbrk+0x49>
  addr = myproc()->sz;
80105b4a:	e8 87 de ff ff       	call   801039d6 <myproc>
80105b4f:	8b 00                	mov    (%eax),%eax
80105b51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80105b54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b57:	83 ec 0c             	sub    $0xc,%esp
80105b5a:	50                   	push   %eax
80105b5b:	e8 d8 e0 ff ff       	call   80103c38 <growproc>
80105b60:	83 c4 10             	add    $0x10,%esp
80105b63:	85 c0                	test   %eax,%eax
80105b65:	79 07                	jns    80105b6e <sys_sbrk+0x46>
    return -1;
80105b67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b6c:	eb 03                	jmp    80105b71 <sys_sbrk+0x49>
  return addr;
80105b6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105b71:	c9                   	leave  
80105b72:	c3                   	ret    

80105b73 <sys_sleep>:

int
sys_sleep(void)
{
80105b73:	55                   	push   %ebp
80105b74:	89 e5                	mov    %esp,%ebp
80105b76:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105b79:	83 ec 08             	sub    $0x8,%esp
80105b7c:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b7f:	50                   	push   %eax
80105b80:	6a 00                	push   $0x0
80105b82:	e8 8e f0 ff ff       	call   80104c15 <argint>
80105b87:	83 c4 10             	add    $0x10,%esp
80105b8a:	85 c0                	test   %eax,%eax
80105b8c:	79 07                	jns    80105b95 <sys_sleep+0x22>
    return -1;
80105b8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b93:	eb 78                	jmp    80105c0d <sys_sleep+0x9a>
  acquire(&tickslock);
80105b95:	83 ec 0c             	sub    $0xc,%esp
80105b98:	68 40 59 19 80       	push   $0x80195940
80105b9d:	e8 f3 ea ff ff       	call   80104695 <acquire>
80105ba2:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105ba5:	a1 74 59 19 80       	mov    0x80195974,%eax
80105baa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80105bad:	eb 38                	jmp    80105be7 <sys_sleep+0x74>
    if(myproc()->killed){
80105baf:	e8 22 de ff ff       	call   801039d6 <myproc>
80105bb4:	8b 40 24             	mov    0x24(%eax),%eax
80105bb7:	85 c0                	test   %eax,%eax
80105bb9:	74 17                	je     80105bd2 <sys_sleep+0x5f>
      release(&tickslock);
80105bbb:	83 ec 0c             	sub    $0xc,%esp
80105bbe:	68 40 59 19 80       	push   $0x80195940
80105bc3:	e8 3b eb ff ff       	call   80104703 <release>
80105bc8:	83 c4 10             	add    $0x10,%esp
      return -1;
80105bcb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bd0:	eb 3b                	jmp    80105c0d <sys_sleep+0x9a>
    }
    sleep(&ticks, &tickslock);
80105bd2:	83 ec 08             	sub    $0x8,%esp
80105bd5:	68 40 59 19 80       	push   $0x80195940
80105bda:	68 74 59 19 80       	push   $0x80195974
80105bdf:	e8 97 e6 ff ff       	call   8010427b <sleep>
80105be4:	83 c4 10             	add    $0x10,%esp
  while(ticks - ticks0 < n){
80105be7:	a1 74 59 19 80       	mov    0x80195974,%eax
80105bec:	2b 45 f4             	sub    -0xc(%ebp),%eax
80105bef:	89 c2                	mov    %eax,%edx
80105bf1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bf4:	39 c2                	cmp    %eax,%edx
80105bf6:	72 b7                	jb     80105baf <sys_sleep+0x3c>
  }
  release(&tickslock);
80105bf8:	83 ec 0c             	sub    $0xc,%esp
80105bfb:	68 40 59 19 80       	push   $0x80195940
80105c00:	e8 fe ea ff ff       	call   80104703 <release>
80105c05:	83 c4 10             	add    $0x10,%esp
  return 0;
80105c08:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105c0d:	c9                   	leave  
80105c0e:	c3                   	ret    

80105c0f <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105c0f:	55                   	push   %ebp
80105c10:	89 e5                	mov    %esp,%ebp
80105c12:	83 ec 18             	sub    $0x18,%esp
  uint xticks;

  acquire(&tickslock);
80105c15:	83 ec 0c             	sub    $0xc,%esp
80105c18:	68 40 59 19 80       	push   $0x80195940
80105c1d:	e8 73 ea ff ff       	call   80104695 <acquire>
80105c22:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80105c25:	a1 74 59 19 80       	mov    0x80195974,%eax
80105c2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80105c2d:	83 ec 0c             	sub    $0xc,%esp
80105c30:	68 40 59 19 80       	push   $0x80195940
80105c35:	e8 c9 ea ff ff       	call   80104703 <release>
80105c3a:	83 c4 10             	add    $0x10,%esp
  return xticks;
80105c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105c40:	c9                   	leave  
80105c41:	c3                   	ret    

80105c42 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105c42:	1e                   	push   %ds
  pushl %es
80105c43:	06                   	push   %es
  pushl %fs
80105c44:	0f a0                	push   %fs
  pushl %gs
80105c46:	0f a8                	push   %gs
  pushal
80105c48:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105c49:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105c4d:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105c4f:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105c51:	54                   	push   %esp
  call trap
80105c52:	e8 be 01 00 00       	call   80105e15 <trap>
  addl $4, %esp
80105c57:	83 c4 04             	add    $0x4,%esp

80105c5a <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105c5a:	61                   	popa   
  popl %gs
80105c5b:	0f a9                	pop    %gs
  popl %fs
80105c5d:	0f a1                	pop    %fs
  popl %es
80105c5f:	07                   	pop    %es
  popl %ds
80105c60:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105c61:	83 c4 08             	add    $0x8,%esp
  iret
80105c64:	cf                   	iret   

80105c65 <lidt>:
{
80105c65:	55                   	push   %ebp
80105c66:	89 e5                	mov    %esp,%ebp
80105c68:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80105c6b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c6e:	48                   	dec    %eax
80105c6f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105c73:	8b 45 08             	mov    0x8(%ebp),%eax
80105c76:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105c7a:	8b 45 08             	mov    0x8(%ebp),%eax
80105c7d:	c1 e8 10             	shr    $0x10,%eax
80105c80:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105c84:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105c87:	0f 01 18             	lidtl  (%eax)
}
80105c8a:	90                   	nop
80105c8b:	c9                   	leave  
80105c8c:	c3                   	ret    

80105c8d <rcr2>:

static inline uint
rcr2(void)
{
80105c8d:	55                   	push   %ebp
80105c8e:	89 e5                	mov    %esp,%ebp
80105c90:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105c93:	0f 20 d0             	mov    %cr2,%eax
80105c96:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80105c99:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105c9c:	c9                   	leave  
80105c9d:	c3                   	ret    

80105c9e <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105c9e:	55                   	push   %ebp
80105c9f:	89 e5                	mov    %esp,%ebp
80105ca1:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80105ca4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105cab:	e9 b8 00 00 00       	jmp    80105d68 <tvinit+0xca>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105cb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cb3:	8b 04 85 78 e0 10 80 	mov    -0x7fef1f88(,%eax,4),%eax
80105cba:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105cbd:	66 89 04 d5 40 51 19 	mov    %ax,-0x7fe6aec0(,%edx,8)
80105cc4:	80 
80105cc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cc8:	66 c7 04 c5 42 51 19 	movw   $0x8,-0x7fe6aebe(,%eax,8)
80105ccf:	80 08 00 
80105cd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd5:	8a 14 c5 44 51 19 80 	mov    -0x7fe6aebc(,%eax,8),%dl
80105cdc:	83 e2 e0             	and    $0xffffffe0,%edx
80105cdf:	88 14 c5 44 51 19 80 	mov    %dl,-0x7fe6aebc(,%eax,8)
80105ce6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ce9:	8a 14 c5 44 51 19 80 	mov    -0x7fe6aebc(,%eax,8),%dl
80105cf0:	83 e2 1f             	and    $0x1f,%edx
80105cf3:	88 14 c5 44 51 19 80 	mov    %dl,-0x7fe6aebc(,%eax,8)
80105cfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cfd:	8a 14 c5 45 51 19 80 	mov    -0x7fe6aebb(,%eax,8),%dl
80105d04:	83 e2 f0             	and    $0xfffffff0,%edx
80105d07:	83 ca 0e             	or     $0xe,%edx
80105d0a:	88 14 c5 45 51 19 80 	mov    %dl,-0x7fe6aebb(,%eax,8)
80105d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d14:	8a 14 c5 45 51 19 80 	mov    -0x7fe6aebb(,%eax,8),%dl
80105d1b:	83 e2 ef             	and    $0xffffffef,%edx
80105d1e:	88 14 c5 45 51 19 80 	mov    %dl,-0x7fe6aebb(,%eax,8)
80105d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d28:	8a 14 c5 45 51 19 80 	mov    -0x7fe6aebb(,%eax,8),%dl
80105d2f:	83 e2 9f             	and    $0xffffff9f,%edx
80105d32:	88 14 c5 45 51 19 80 	mov    %dl,-0x7fe6aebb(,%eax,8)
80105d39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d3c:	8a 14 c5 45 51 19 80 	mov    -0x7fe6aebb(,%eax,8),%dl
80105d43:	83 ca 80             	or     $0xffffff80,%edx
80105d46:	88 14 c5 45 51 19 80 	mov    %dl,-0x7fe6aebb(,%eax,8)
80105d4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d50:	8b 04 85 78 e0 10 80 	mov    -0x7fef1f88(,%eax,4),%eax
80105d57:	c1 e8 10             	shr    $0x10,%eax
80105d5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d5d:	66 89 04 d5 46 51 19 	mov    %ax,-0x7fe6aeba(,%edx,8)
80105d64:	80 
  for(i = 0; i < 256; i++)
80105d65:	ff 45 f4             	incl   -0xc(%ebp)
80105d68:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80105d6f:	0f 8e 3b ff ff ff    	jle    80105cb0 <tvinit+0x12>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d75:	a1 78 e1 10 80       	mov    0x8010e178,%eax
80105d7a:	66 a3 40 53 19 80    	mov    %ax,0x80195340
80105d80:	66 c7 05 42 53 19 80 	movw   $0x8,0x80195342
80105d87:	08 00 
80105d89:	a0 44 53 19 80       	mov    0x80195344,%al
80105d8e:	83 e0 e0             	and    $0xffffffe0,%eax
80105d91:	a2 44 53 19 80       	mov    %al,0x80195344
80105d96:	a0 44 53 19 80       	mov    0x80195344,%al
80105d9b:	83 e0 1f             	and    $0x1f,%eax
80105d9e:	a2 44 53 19 80       	mov    %al,0x80195344
80105da3:	a0 45 53 19 80       	mov    0x80195345,%al
80105da8:	83 c8 0f             	or     $0xf,%eax
80105dab:	a2 45 53 19 80       	mov    %al,0x80195345
80105db0:	a0 45 53 19 80       	mov    0x80195345,%al
80105db5:	83 e0 ef             	and    $0xffffffef,%eax
80105db8:	a2 45 53 19 80       	mov    %al,0x80195345
80105dbd:	a0 45 53 19 80       	mov    0x80195345,%al
80105dc2:	83 c8 60             	or     $0x60,%eax
80105dc5:	a2 45 53 19 80       	mov    %al,0x80195345
80105dca:	a0 45 53 19 80       	mov    0x80195345,%al
80105dcf:	83 c8 80             	or     $0xffffff80,%eax
80105dd2:	a2 45 53 19 80       	mov    %al,0x80195345
80105dd7:	a1 78 e1 10 80       	mov    0x8010e178,%eax
80105ddc:	c1 e8 10             	shr    $0x10,%eax
80105ddf:	66 a3 46 53 19 80    	mov    %ax,0x80195346

  initlock(&tickslock, "time");
80105de5:	83 ec 08             	sub    $0x8,%esp
80105de8:	68 78 a2 10 80       	push   $0x8010a278
80105ded:	68 40 59 19 80       	push   $0x80195940
80105df2:	e8 7c e8 ff ff       	call   80104673 <initlock>
80105df7:	83 c4 10             	add    $0x10,%esp
}
80105dfa:	90                   	nop
80105dfb:	c9                   	leave  
80105dfc:	c3                   	ret    

80105dfd <idtinit>:

void
idtinit(void)
{
80105dfd:	55                   	push   %ebp
80105dfe:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80105e00:	68 00 08 00 00       	push   $0x800
80105e05:	68 40 51 19 80       	push   $0x80195140
80105e0a:	e8 56 fe ff ff       	call   80105c65 <lidt>
80105e0f:	83 c4 08             	add    $0x8,%esp
}
80105e12:	90                   	nop
80105e13:	c9                   	leave  
80105e14:	c3                   	ret    

80105e15 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105e15:	55                   	push   %ebp
80105e16:	89 e5                	mov    %esp,%ebp
80105e18:	57                   	push   %edi
80105e19:	56                   	push   %esi
80105e1a:	53                   	push   %ebx
80105e1b:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80105e1e:	8b 45 08             	mov    0x8(%ebp),%eax
80105e21:	8b 40 30             	mov    0x30(%eax),%eax
80105e24:	83 f8 40             	cmp    $0x40,%eax
80105e27:	75 3b                	jne    80105e64 <trap+0x4f>
    if(myproc()->killed)
80105e29:	e8 a8 db ff ff       	call   801039d6 <myproc>
80105e2e:	8b 40 24             	mov    0x24(%eax),%eax
80105e31:	85 c0                	test   %eax,%eax
80105e33:	74 05                	je     80105e3a <trap+0x25>
      exit();
80105e35:	e8 11 e0 ff ff       	call   80103e4b <exit>
    myproc()->tf = tf;
80105e3a:	e8 97 db ff ff       	call   801039d6 <myproc>
80105e3f:	8b 55 08             	mov    0x8(%ebp),%edx
80105e42:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80105e45:	e8 97 ee ff ff       	call   80104ce1 <syscall>
    if(myproc()->killed)
80105e4a:	e8 87 db ff ff       	call   801039d6 <myproc>
80105e4f:	8b 40 24             	mov    0x24(%eax),%eax
80105e52:	85 c0                	test   %eax,%eax
80105e54:	0f 84 0f 02 00 00    	je     80106069 <trap+0x254>
      exit();
80105e5a:	e8 ec df ff ff       	call   80103e4b <exit>
    return;
80105e5f:	e9 05 02 00 00       	jmp    80106069 <trap+0x254>
  }

  switch(tf->trapno){
80105e64:	8b 45 08             	mov    0x8(%ebp),%eax
80105e67:	8b 40 30             	mov    0x30(%eax),%eax
80105e6a:	83 e8 20             	sub    $0x20,%eax
80105e6d:	83 f8 1f             	cmp    $0x1f,%eax
80105e70:	0f 87 c1 00 00 00    	ja     80105f37 <trap+0x122>
80105e76:	8b 04 85 20 a3 10 80 	mov    -0x7fef5ce0(,%eax,4),%eax
80105e7d:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105e7f:	e8 8d da ff ff       	call   80103911 <cpuid>
80105e84:	85 c0                	test   %eax,%eax
80105e86:	75 3b                	jne    80105ec3 <trap+0xae>
      acquire(&tickslock);
80105e88:	83 ec 0c             	sub    $0xc,%esp
80105e8b:	68 40 59 19 80       	push   $0x80195940
80105e90:	e8 00 e8 ff ff       	call   80104695 <acquire>
80105e95:	83 c4 10             	add    $0x10,%esp
      ticks++;
80105e98:	a1 74 59 19 80       	mov    0x80195974,%eax
80105e9d:	40                   	inc    %eax
80105e9e:	a3 74 59 19 80       	mov    %eax,0x80195974
      wakeup(&ticks);
80105ea3:	83 ec 0c             	sub    $0xc,%esp
80105ea6:	68 74 59 19 80       	push   $0x80195974
80105eab:	e8 b2 e4 ff ff       	call   80104362 <wakeup>
80105eb0:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80105eb3:	83 ec 0c             	sub    $0xc,%esp
80105eb6:	68 40 59 19 80       	push   $0x80195940
80105ebb:	e8 43 e8 ff ff       	call   80104703 <release>
80105ec0:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80105ec3:	e8 dd cb ff ff       	call   80102aa5 <lapiceoi>
    break;
80105ec8:	e9 1e 01 00 00       	jmp    80105feb <trap+0x1d6>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105ecd:	e8 5c 3e 00 00       	call   80109d2e <ideintr>
    lapiceoi();
80105ed2:	e8 ce cb ff ff       	call   80102aa5 <lapiceoi>
    break;
80105ed7:	e9 0f 01 00 00       	jmp    80105feb <trap+0x1d6>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105edc:	e8 0e ca ff ff       	call   801028ef <kbdintr>
    lapiceoi();
80105ee1:	e8 bf cb ff ff       	call   80102aa5 <lapiceoi>
    break;
80105ee6:	e9 00 01 00 00       	jmp    80105feb <trap+0x1d6>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105eeb:	e8 47 03 00 00       	call   80106237 <uartintr>
    lapiceoi();
80105ef0:	e8 b0 cb ff ff       	call   80102aa5 <lapiceoi>
    break;
80105ef5:	e9 f1 00 00 00       	jmp    80105feb <trap+0x1d6>
  case T_IRQ0 + 0xB:
    i8254_intr();
80105efa:	e8 2b 2b 00 00       	call   80108a2a <i8254_intr>
    lapiceoi();
80105eff:	e8 a1 cb ff ff       	call   80102aa5 <lapiceoi>
    break;
80105f04:	e9 e2 00 00 00       	jmp    80105feb <trap+0x1d6>
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f09:	8b 45 08             	mov    0x8(%ebp),%eax
80105f0c:	8b 70 38             	mov    0x38(%eax),%esi
            cpuid(), tf->cs, tf->eip);
80105f0f:	8b 45 08             	mov    0x8(%ebp),%eax
80105f12:	8b 40 3c             	mov    0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f15:	0f b7 d8             	movzwl %ax,%ebx
80105f18:	e8 f4 d9 ff ff       	call   80103911 <cpuid>
80105f1d:	56                   	push   %esi
80105f1e:	53                   	push   %ebx
80105f1f:	50                   	push   %eax
80105f20:	68 80 a2 10 80       	push   $0x8010a280
80105f25:	e8 c7 a4 ff ff       	call   801003f1 <cprintf>
80105f2a:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105f2d:	e8 73 cb ff ff       	call   80102aa5 <lapiceoi>
    break;
80105f32:	e9 b4 00 00 00       	jmp    80105feb <trap+0x1d6>

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105f37:	e8 9a da ff ff       	call   801039d6 <myproc>
80105f3c:	85 c0                	test   %eax,%eax
80105f3e:	74 10                	je     80105f50 <trap+0x13b>
80105f40:	8b 45 08             	mov    0x8(%ebp),%eax
80105f43:	8b 40 3c             	mov    0x3c(%eax),%eax
80105f46:	0f b7 c0             	movzwl %ax,%eax
80105f49:	83 e0 03             	and    $0x3,%eax
80105f4c:	85 c0                	test   %eax,%eax
80105f4e:	75 39                	jne    80105f89 <trap+0x174>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105f50:	e8 38 fd ff ff       	call   80105c8d <rcr2>
80105f55:	89 c3                	mov    %eax,%ebx
80105f57:	8b 45 08             	mov    0x8(%ebp),%eax
80105f5a:	8b 70 38             	mov    0x38(%eax),%esi
80105f5d:	e8 af d9 ff ff       	call   80103911 <cpuid>
80105f62:	8b 55 08             	mov    0x8(%ebp),%edx
80105f65:	8b 52 30             	mov    0x30(%edx),%edx
80105f68:	83 ec 0c             	sub    $0xc,%esp
80105f6b:	53                   	push   %ebx
80105f6c:	56                   	push   %esi
80105f6d:	50                   	push   %eax
80105f6e:	52                   	push   %edx
80105f6f:	68 a4 a2 10 80       	push   $0x8010a2a4
80105f74:	e8 78 a4 ff ff       	call   801003f1 <cprintf>
80105f79:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105f7c:	83 ec 0c             	sub    $0xc,%esp
80105f7f:	68 d6 a2 10 80       	push   $0x8010a2d6
80105f84:	e8 16 a6 ff ff       	call   8010059f <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f89:	e8 ff fc ff ff       	call   80105c8d <rcr2>
80105f8e:	89 c6                	mov    %eax,%esi
80105f90:	8b 45 08             	mov    0x8(%ebp),%eax
80105f93:	8b 40 38             	mov    0x38(%eax),%eax
80105f96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105f99:	e8 73 d9 ff ff       	call   80103911 <cpuid>
80105f9e:	89 c3                	mov    %eax,%ebx
80105fa0:	8b 45 08             	mov    0x8(%ebp),%eax
80105fa3:	8b 48 34             	mov    0x34(%eax),%ecx
80105fa6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80105fa9:	8b 45 08             	mov    0x8(%ebp),%eax
80105fac:	8b 78 30             	mov    0x30(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105faf:	e8 22 da ff ff       	call   801039d6 <myproc>
80105fb4:	8d 50 6c             	lea    0x6c(%eax),%edx
80105fb7:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105fba:	e8 17 da ff ff       	call   801039d6 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105fbf:	8b 40 10             	mov    0x10(%eax),%eax
80105fc2:	56                   	push   %esi
80105fc3:	ff 75 e4             	pushl  -0x1c(%ebp)
80105fc6:	53                   	push   %ebx
80105fc7:	ff 75 e0             	pushl  -0x20(%ebp)
80105fca:	57                   	push   %edi
80105fcb:	ff 75 dc             	pushl  -0x24(%ebp)
80105fce:	50                   	push   %eax
80105fcf:	68 dc a2 10 80       	push   $0x8010a2dc
80105fd4:	e8 18 a4 ff ff       	call   801003f1 <cprintf>
80105fd9:	83 c4 20             	add    $0x20,%esp
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105fdc:	e8 f5 d9 ff ff       	call   801039d6 <myproc>
80105fe1:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105fe8:	eb 01                	jmp    80105feb <trap+0x1d6>
    break;
80105fea:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105feb:	e8 e6 d9 ff ff       	call   801039d6 <myproc>
80105ff0:	85 c0                	test   %eax,%eax
80105ff2:	74 22                	je     80106016 <trap+0x201>
80105ff4:	e8 dd d9 ff ff       	call   801039d6 <myproc>
80105ff9:	8b 40 24             	mov    0x24(%eax),%eax
80105ffc:	85 c0                	test   %eax,%eax
80105ffe:	74 16                	je     80106016 <trap+0x201>
80106000:	8b 45 08             	mov    0x8(%ebp),%eax
80106003:	8b 40 3c             	mov    0x3c(%eax),%eax
80106006:	0f b7 c0             	movzwl %ax,%eax
80106009:	83 e0 03             	and    $0x3,%eax
8010600c:	83 f8 03             	cmp    $0x3,%eax
8010600f:	75 05                	jne    80106016 <trap+0x201>
    exit();
80106011:	e8 35 de ff ff       	call   80103e4b <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106016:	e8 bb d9 ff ff       	call   801039d6 <myproc>
8010601b:	85 c0                	test   %eax,%eax
8010601d:	74 1d                	je     8010603c <trap+0x227>
8010601f:	e8 b2 d9 ff ff       	call   801039d6 <myproc>
80106024:	8b 40 0c             	mov    0xc(%eax),%eax
80106027:	83 f8 04             	cmp    $0x4,%eax
8010602a:	75 10                	jne    8010603c <trap+0x227>
     tf->trapno == T_IRQ0+IRQ_TIMER)
8010602c:	8b 45 08             	mov    0x8(%ebp),%eax
8010602f:	8b 40 30             	mov    0x30(%eax),%eax
  if(myproc() && myproc()->state == RUNNING &&
80106032:	83 f8 20             	cmp    $0x20,%eax
80106035:	75 05                	jne    8010603c <trap+0x227>
    yield();
80106037:	e8 bf e1 ff ff       	call   801041fb <yield>

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010603c:	e8 95 d9 ff ff       	call   801039d6 <myproc>
80106041:	85 c0                	test   %eax,%eax
80106043:	74 25                	je     8010606a <trap+0x255>
80106045:	e8 8c d9 ff ff       	call   801039d6 <myproc>
8010604a:	8b 40 24             	mov    0x24(%eax),%eax
8010604d:	85 c0                	test   %eax,%eax
8010604f:	74 19                	je     8010606a <trap+0x255>
80106051:	8b 45 08             	mov    0x8(%ebp),%eax
80106054:	8b 40 3c             	mov    0x3c(%eax),%eax
80106057:	0f b7 c0             	movzwl %ax,%eax
8010605a:	83 e0 03             	and    $0x3,%eax
8010605d:	83 f8 03             	cmp    $0x3,%eax
80106060:	75 08                	jne    8010606a <trap+0x255>
    exit();
80106062:	e8 e4 dd ff ff       	call   80103e4b <exit>
80106067:	eb 01                	jmp    8010606a <trap+0x255>
    return;
80106069:	90                   	nop
}
8010606a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010606d:	5b                   	pop    %ebx
8010606e:	5e                   	pop    %esi
8010606f:	5f                   	pop    %edi
80106070:	5d                   	pop    %ebp
80106071:	c3                   	ret    

80106072 <inb>:
{
80106072:	55                   	push   %ebp
80106073:	89 e5                	mov    %esp,%ebp
80106075:	83 ec 14             	sub    $0x14,%esp
80106078:	8b 45 08             	mov    0x8(%ebp),%eax
8010607b:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010607f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106082:	89 c2                	mov    %eax,%edx
80106084:	ec                   	in     (%dx),%al
80106085:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106088:	8a 45 ff             	mov    -0x1(%ebp),%al
}
8010608b:	c9                   	leave  
8010608c:	c3                   	ret    

8010608d <outb>:
{
8010608d:	55                   	push   %ebp
8010608e:	89 e5                	mov    %esp,%ebp
80106090:	83 ec 08             	sub    $0x8,%esp
80106093:	8b 45 08             	mov    0x8(%ebp),%eax
80106096:	8b 55 0c             	mov    0xc(%ebp),%edx
80106099:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010609d:	88 d0                	mov    %dl,%al
8010609f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801060a2:	8a 45 f8             	mov    -0x8(%ebp),%al
801060a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
801060a8:	ee                   	out    %al,(%dx)
}
801060a9:	90                   	nop
801060aa:	c9                   	leave  
801060ab:	c3                   	ret    

801060ac <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801060ac:	55                   	push   %ebp
801060ad:	89 e5                	mov    %esp,%ebp
801060af:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801060b2:	6a 00                	push   $0x0
801060b4:	68 fa 03 00 00       	push   $0x3fa
801060b9:	e8 cf ff ff ff       	call   8010608d <outb>
801060be:	83 c4 08             	add    $0x8,%esp

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801060c1:	68 80 00 00 00       	push   $0x80
801060c6:	68 fb 03 00 00       	push   $0x3fb
801060cb:	e8 bd ff ff ff       	call   8010608d <outb>
801060d0:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
801060d3:	6a 0c                	push   $0xc
801060d5:	68 f8 03 00 00       	push   $0x3f8
801060da:	e8 ae ff ff ff       	call   8010608d <outb>
801060df:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
801060e2:	6a 00                	push   $0x0
801060e4:	68 f9 03 00 00       	push   $0x3f9
801060e9:	e8 9f ff ff ff       	call   8010608d <outb>
801060ee:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
801060f1:	6a 03                	push   $0x3
801060f3:	68 fb 03 00 00       	push   $0x3fb
801060f8:	e8 90 ff ff ff       	call   8010608d <outb>
801060fd:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106100:	6a 00                	push   $0x0
80106102:	68 fc 03 00 00       	push   $0x3fc
80106107:	e8 81 ff ff ff       	call   8010608d <outb>
8010610c:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
8010610f:	6a 01                	push   $0x1
80106111:	68 f9 03 00 00       	push   $0x3f9
80106116:	e8 72 ff ff ff       	call   8010608d <outb>
8010611b:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
8010611e:	68 fd 03 00 00       	push   $0x3fd
80106123:	e8 4a ff ff ff       	call   80106072 <inb>
80106128:	83 c4 04             	add    $0x4,%esp
8010612b:	3c ff                	cmp    $0xff,%al
8010612d:	74 5e                	je     8010618d <uartinit+0xe1>
    return;
  uart = 1;
8010612f:	c7 05 78 59 19 80 01 	movl   $0x1,0x80195978
80106136:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106139:	68 fa 03 00 00       	push   $0x3fa
8010613e:	e8 2f ff ff ff       	call   80106072 <inb>
80106143:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106146:	68 f8 03 00 00       	push   $0x3f8
8010614b:	e8 22 ff ff ff       	call   80106072 <inb>
80106150:	83 c4 04             	add    $0x4,%esp
  ioapicenable(IRQ_COM1, 0);
80106153:	83 ec 08             	sub    $0x8,%esp
80106156:	6a 00                	push   $0x0
80106158:	6a 04                	push   $0x4
8010615a:	e8 65 c4 ff ff       	call   801025c4 <ioapicenable>
8010615f:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106162:	c7 45 f4 a0 a3 10 80 	movl   $0x8010a3a0,-0xc(%ebp)
80106169:	eb 17                	jmp    80106182 <uartinit+0xd6>
    uartputc(*p);
8010616b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010616e:	8a 00                	mov    (%eax),%al
80106170:	0f be c0             	movsbl %al,%eax
80106173:	83 ec 0c             	sub    $0xc,%esp
80106176:	50                   	push   %eax
80106177:	e8 14 00 00 00       	call   80106190 <uartputc>
8010617c:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
8010617f:	ff 45 f4             	incl   -0xc(%ebp)
80106182:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106185:	8a 00                	mov    (%eax),%al
80106187:	84 c0                	test   %al,%al
80106189:	75 e0                	jne    8010616b <uartinit+0xbf>
8010618b:	eb 01                	jmp    8010618e <uartinit+0xe2>
    return;
8010618d:	90                   	nop
}
8010618e:	c9                   	leave  
8010618f:	c3                   	ret    

80106190 <uartputc>:

void
uartputc(int c)
{
80106190:	55                   	push   %ebp
80106191:	89 e5                	mov    %esp,%ebp
80106193:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106196:	a1 78 59 19 80       	mov    0x80195978,%eax
8010619b:	85 c0                	test   %eax,%eax
8010619d:	74 52                	je     801061f1 <uartputc+0x61>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010619f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801061a6:	eb 10                	jmp    801061b8 <uartputc+0x28>
    microdelay(10);
801061a8:	83 ec 0c             	sub    $0xc,%esp
801061ab:	6a 0a                	push   $0xa
801061ad:	e8 0e c9 ff ff       	call   80102ac0 <microdelay>
801061b2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061b5:	ff 45 f4             	incl   -0xc(%ebp)
801061b8:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
801061bc:	7f 1a                	jg     801061d8 <uartputc+0x48>
801061be:	83 ec 0c             	sub    $0xc,%esp
801061c1:	68 fd 03 00 00       	push   $0x3fd
801061c6:	e8 a7 fe ff ff       	call   80106072 <inb>
801061cb:	83 c4 10             	add    $0x10,%esp
801061ce:	0f b6 c0             	movzbl %al,%eax
801061d1:	83 e0 20             	and    $0x20,%eax
801061d4:	85 c0                	test   %eax,%eax
801061d6:	74 d0                	je     801061a8 <uartputc+0x18>
  outb(COM1+0, c);
801061d8:	8b 45 08             	mov    0x8(%ebp),%eax
801061db:	0f b6 c0             	movzbl %al,%eax
801061de:	83 ec 08             	sub    $0x8,%esp
801061e1:	50                   	push   %eax
801061e2:	68 f8 03 00 00       	push   $0x3f8
801061e7:	e8 a1 fe ff ff       	call   8010608d <outb>
801061ec:	83 c4 10             	add    $0x10,%esp
801061ef:	eb 01                	jmp    801061f2 <uartputc+0x62>
    return;
801061f1:	90                   	nop
}
801061f2:	c9                   	leave  
801061f3:	c3                   	ret    

801061f4 <uartgetc>:

static int
uartgetc(void)
{
801061f4:	55                   	push   %ebp
801061f5:	89 e5                	mov    %esp,%ebp
  if(!uart)
801061f7:	a1 78 59 19 80       	mov    0x80195978,%eax
801061fc:	85 c0                	test   %eax,%eax
801061fe:	75 07                	jne    80106207 <uartgetc+0x13>
    return -1;
80106200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106205:	eb 2e                	jmp    80106235 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106207:	68 fd 03 00 00       	push   $0x3fd
8010620c:	e8 61 fe ff ff       	call   80106072 <inb>
80106211:	83 c4 04             	add    $0x4,%esp
80106214:	0f b6 c0             	movzbl %al,%eax
80106217:	83 e0 01             	and    $0x1,%eax
8010621a:	85 c0                	test   %eax,%eax
8010621c:	75 07                	jne    80106225 <uartgetc+0x31>
    return -1;
8010621e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106223:	eb 10                	jmp    80106235 <uartgetc+0x41>
  return inb(COM1+0);
80106225:	68 f8 03 00 00       	push   $0x3f8
8010622a:	e8 43 fe ff ff       	call   80106072 <inb>
8010622f:	83 c4 04             	add    $0x4,%esp
80106232:	0f b6 c0             	movzbl %al,%eax
}
80106235:	c9                   	leave  
80106236:	c3                   	ret    

80106237 <uartintr>:

void
uartintr(void)
{
80106237:	55                   	push   %ebp
80106238:	89 e5                	mov    %esp,%ebp
8010623a:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
8010623d:	83 ec 0c             	sub    $0xc,%esp
80106240:	68 f4 61 10 80       	push   $0x801061f4
80106245:	e8 69 a5 ff ff       	call   801007b3 <consoleintr>
8010624a:	83 c4 10             	add    $0x10,%esp
}
8010624d:	90                   	nop
8010624e:	c9                   	leave  
8010624f:	c3                   	ret    

80106250 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106250:	6a 00                	push   $0x0
  pushl $0
80106252:	6a 00                	push   $0x0
  jmp alltraps
80106254:	e9 e9 f9 ff ff       	jmp    80105c42 <alltraps>

80106259 <vector1>:
.globl vector1
vector1:
  pushl $0
80106259:	6a 00                	push   $0x0
  pushl $1
8010625b:	6a 01                	push   $0x1
  jmp alltraps
8010625d:	e9 e0 f9 ff ff       	jmp    80105c42 <alltraps>

80106262 <vector2>:
.globl vector2
vector2:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $2
80106264:	6a 02                	push   $0x2
  jmp alltraps
80106266:	e9 d7 f9 ff ff       	jmp    80105c42 <alltraps>

8010626b <vector3>:
.globl vector3
vector3:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $3
8010626d:	6a 03                	push   $0x3
  jmp alltraps
8010626f:	e9 ce f9 ff ff       	jmp    80105c42 <alltraps>

80106274 <vector4>:
.globl vector4
vector4:
  pushl $0
80106274:	6a 00                	push   $0x0
  pushl $4
80106276:	6a 04                	push   $0x4
  jmp alltraps
80106278:	e9 c5 f9 ff ff       	jmp    80105c42 <alltraps>

8010627d <vector5>:
.globl vector5
vector5:
  pushl $0
8010627d:	6a 00                	push   $0x0
  pushl $5
8010627f:	6a 05                	push   $0x5
  jmp alltraps
80106281:	e9 bc f9 ff ff       	jmp    80105c42 <alltraps>

80106286 <vector6>:
.globl vector6
vector6:
  pushl $0
80106286:	6a 00                	push   $0x0
  pushl $6
80106288:	6a 06                	push   $0x6
  jmp alltraps
8010628a:	e9 b3 f9 ff ff       	jmp    80105c42 <alltraps>

8010628f <vector7>:
.globl vector7
vector7:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $7
80106291:	6a 07                	push   $0x7
  jmp alltraps
80106293:	e9 aa f9 ff ff       	jmp    80105c42 <alltraps>

80106298 <vector8>:
.globl vector8
vector8:
  pushl $8
80106298:	6a 08                	push   $0x8
  jmp alltraps
8010629a:	e9 a3 f9 ff ff       	jmp    80105c42 <alltraps>

8010629f <vector9>:
.globl vector9
vector9:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $9
801062a1:	6a 09                	push   $0x9
  jmp alltraps
801062a3:	e9 9a f9 ff ff       	jmp    80105c42 <alltraps>

801062a8 <vector10>:
.globl vector10
vector10:
  pushl $10
801062a8:	6a 0a                	push   $0xa
  jmp alltraps
801062aa:	e9 93 f9 ff ff       	jmp    80105c42 <alltraps>

801062af <vector11>:
.globl vector11
vector11:
  pushl $11
801062af:	6a 0b                	push   $0xb
  jmp alltraps
801062b1:	e9 8c f9 ff ff       	jmp    80105c42 <alltraps>

801062b6 <vector12>:
.globl vector12
vector12:
  pushl $12
801062b6:	6a 0c                	push   $0xc
  jmp alltraps
801062b8:	e9 85 f9 ff ff       	jmp    80105c42 <alltraps>

801062bd <vector13>:
.globl vector13
vector13:
  pushl $13
801062bd:	6a 0d                	push   $0xd
  jmp alltraps
801062bf:	e9 7e f9 ff ff       	jmp    80105c42 <alltraps>

801062c4 <vector14>:
.globl vector14
vector14:
  pushl $14
801062c4:	6a 0e                	push   $0xe
  jmp alltraps
801062c6:	e9 77 f9 ff ff       	jmp    80105c42 <alltraps>

801062cb <vector15>:
.globl vector15
vector15:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $15
801062cd:	6a 0f                	push   $0xf
  jmp alltraps
801062cf:	e9 6e f9 ff ff       	jmp    80105c42 <alltraps>

801062d4 <vector16>:
.globl vector16
vector16:
  pushl $0
801062d4:	6a 00                	push   $0x0
  pushl $16
801062d6:	6a 10                	push   $0x10
  jmp alltraps
801062d8:	e9 65 f9 ff ff       	jmp    80105c42 <alltraps>

801062dd <vector17>:
.globl vector17
vector17:
  pushl $17
801062dd:	6a 11                	push   $0x11
  jmp alltraps
801062df:	e9 5e f9 ff ff       	jmp    80105c42 <alltraps>

801062e4 <vector18>:
.globl vector18
vector18:
  pushl $0
801062e4:	6a 00                	push   $0x0
  pushl $18
801062e6:	6a 12                	push   $0x12
  jmp alltraps
801062e8:	e9 55 f9 ff ff       	jmp    80105c42 <alltraps>

801062ed <vector19>:
.globl vector19
vector19:
  pushl $0
801062ed:	6a 00                	push   $0x0
  pushl $19
801062ef:	6a 13                	push   $0x13
  jmp alltraps
801062f1:	e9 4c f9 ff ff       	jmp    80105c42 <alltraps>

801062f6 <vector20>:
.globl vector20
vector20:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $20
801062f8:	6a 14                	push   $0x14
  jmp alltraps
801062fa:	e9 43 f9 ff ff       	jmp    80105c42 <alltraps>

801062ff <vector21>:
.globl vector21
vector21:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $21
80106301:	6a 15                	push   $0x15
  jmp alltraps
80106303:	e9 3a f9 ff ff       	jmp    80105c42 <alltraps>

80106308 <vector22>:
.globl vector22
vector22:
  pushl $0
80106308:	6a 00                	push   $0x0
  pushl $22
8010630a:	6a 16                	push   $0x16
  jmp alltraps
8010630c:	e9 31 f9 ff ff       	jmp    80105c42 <alltraps>

80106311 <vector23>:
.globl vector23
vector23:
  pushl $0
80106311:	6a 00                	push   $0x0
  pushl $23
80106313:	6a 17                	push   $0x17
  jmp alltraps
80106315:	e9 28 f9 ff ff       	jmp    80105c42 <alltraps>

8010631a <vector24>:
.globl vector24
vector24:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $24
8010631c:	6a 18                	push   $0x18
  jmp alltraps
8010631e:	e9 1f f9 ff ff       	jmp    80105c42 <alltraps>

80106323 <vector25>:
.globl vector25
vector25:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $25
80106325:	6a 19                	push   $0x19
  jmp alltraps
80106327:	e9 16 f9 ff ff       	jmp    80105c42 <alltraps>

8010632c <vector26>:
.globl vector26
vector26:
  pushl $0
8010632c:	6a 00                	push   $0x0
  pushl $26
8010632e:	6a 1a                	push   $0x1a
  jmp alltraps
80106330:	e9 0d f9 ff ff       	jmp    80105c42 <alltraps>

80106335 <vector27>:
.globl vector27
vector27:
  pushl $0
80106335:	6a 00                	push   $0x0
  pushl $27
80106337:	6a 1b                	push   $0x1b
  jmp alltraps
80106339:	e9 04 f9 ff ff       	jmp    80105c42 <alltraps>

8010633e <vector28>:
.globl vector28
vector28:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $28
80106340:	6a 1c                	push   $0x1c
  jmp alltraps
80106342:	e9 fb f8 ff ff       	jmp    80105c42 <alltraps>

80106347 <vector29>:
.globl vector29
vector29:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $29
80106349:	6a 1d                	push   $0x1d
  jmp alltraps
8010634b:	e9 f2 f8 ff ff       	jmp    80105c42 <alltraps>

80106350 <vector30>:
.globl vector30
vector30:
  pushl $0
80106350:	6a 00                	push   $0x0
  pushl $30
80106352:	6a 1e                	push   $0x1e
  jmp alltraps
80106354:	e9 e9 f8 ff ff       	jmp    80105c42 <alltraps>

80106359 <vector31>:
.globl vector31
vector31:
  pushl $0
80106359:	6a 00                	push   $0x0
  pushl $31
8010635b:	6a 1f                	push   $0x1f
  jmp alltraps
8010635d:	e9 e0 f8 ff ff       	jmp    80105c42 <alltraps>

80106362 <vector32>:
.globl vector32
vector32:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $32
80106364:	6a 20                	push   $0x20
  jmp alltraps
80106366:	e9 d7 f8 ff ff       	jmp    80105c42 <alltraps>

8010636b <vector33>:
.globl vector33
vector33:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $33
8010636d:	6a 21                	push   $0x21
  jmp alltraps
8010636f:	e9 ce f8 ff ff       	jmp    80105c42 <alltraps>

80106374 <vector34>:
.globl vector34
vector34:
  pushl $0
80106374:	6a 00                	push   $0x0
  pushl $34
80106376:	6a 22                	push   $0x22
  jmp alltraps
80106378:	e9 c5 f8 ff ff       	jmp    80105c42 <alltraps>

8010637d <vector35>:
.globl vector35
vector35:
  pushl $0
8010637d:	6a 00                	push   $0x0
  pushl $35
8010637f:	6a 23                	push   $0x23
  jmp alltraps
80106381:	e9 bc f8 ff ff       	jmp    80105c42 <alltraps>

80106386 <vector36>:
.globl vector36
vector36:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $36
80106388:	6a 24                	push   $0x24
  jmp alltraps
8010638a:	e9 b3 f8 ff ff       	jmp    80105c42 <alltraps>

8010638f <vector37>:
.globl vector37
vector37:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $37
80106391:	6a 25                	push   $0x25
  jmp alltraps
80106393:	e9 aa f8 ff ff       	jmp    80105c42 <alltraps>

80106398 <vector38>:
.globl vector38
vector38:
  pushl $0
80106398:	6a 00                	push   $0x0
  pushl $38
8010639a:	6a 26                	push   $0x26
  jmp alltraps
8010639c:	e9 a1 f8 ff ff       	jmp    80105c42 <alltraps>

801063a1 <vector39>:
.globl vector39
vector39:
  pushl $0
801063a1:	6a 00                	push   $0x0
  pushl $39
801063a3:	6a 27                	push   $0x27
  jmp alltraps
801063a5:	e9 98 f8 ff ff       	jmp    80105c42 <alltraps>

801063aa <vector40>:
.globl vector40
vector40:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $40
801063ac:	6a 28                	push   $0x28
  jmp alltraps
801063ae:	e9 8f f8 ff ff       	jmp    80105c42 <alltraps>

801063b3 <vector41>:
.globl vector41
vector41:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $41
801063b5:	6a 29                	push   $0x29
  jmp alltraps
801063b7:	e9 86 f8 ff ff       	jmp    80105c42 <alltraps>

801063bc <vector42>:
.globl vector42
vector42:
  pushl $0
801063bc:	6a 00                	push   $0x0
  pushl $42
801063be:	6a 2a                	push   $0x2a
  jmp alltraps
801063c0:	e9 7d f8 ff ff       	jmp    80105c42 <alltraps>

801063c5 <vector43>:
.globl vector43
vector43:
  pushl $0
801063c5:	6a 00                	push   $0x0
  pushl $43
801063c7:	6a 2b                	push   $0x2b
  jmp alltraps
801063c9:	e9 74 f8 ff ff       	jmp    80105c42 <alltraps>

801063ce <vector44>:
.globl vector44
vector44:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $44
801063d0:	6a 2c                	push   $0x2c
  jmp alltraps
801063d2:	e9 6b f8 ff ff       	jmp    80105c42 <alltraps>

801063d7 <vector45>:
.globl vector45
vector45:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $45
801063d9:	6a 2d                	push   $0x2d
  jmp alltraps
801063db:	e9 62 f8 ff ff       	jmp    80105c42 <alltraps>

801063e0 <vector46>:
.globl vector46
vector46:
  pushl $0
801063e0:	6a 00                	push   $0x0
  pushl $46
801063e2:	6a 2e                	push   $0x2e
  jmp alltraps
801063e4:	e9 59 f8 ff ff       	jmp    80105c42 <alltraps>

801063e9 <vector47>:
.globl vector47
vector47:
  pushl $0
801063e9:	6a 00                	push   $0x0
  pushl $47
801063eb:	6a 2f                	push   $0x2f
  jmp alltraps
801063ed:	e9 50 f8 ff ff       	jmp    80105c42 <alltraps>

801063f2 <vector48>:
.globl vector48
vector48:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $48
801063f4:	6a 30                	push   $0x30
  jmp alltraps
801063f6:	e9 47 f8 ff ff       	jmp    80105c42 <alltraps>

801063fb <vector49>:
.globl vector49
vector49:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $49
801063fd:	6a 31                	push   $0x31
  jmp alltraps
801063ff:	e9 3e f8 ff ff       	jmp    80105c42 <alltraps>

80106404 <vector50>:
.globl vector50
vector50:
  pushl $0
80106404:	6a 00                	push   $0x0
  pushl $50
80106406:	6a 32                	push   $0x32
  jmp alltraps
80106408:	e9 35 f8 ff ff       	jmp    80105c42 <alltraps>

8010640d <vector51>:
.globl vector51
vector51:
  pushl $0
8010640d:	6a 00                	push   $0x0
  pushl $51
8010640f:	6a 33                	push   $0x33
  jmp alltraps
80106411:	e9 2c f8 ff ff       	jmp    80105c42 <alltraps>

80106416 <vector52>:
.globl vector52
vector52:
  pushl $0
80106416:	6a 00                	push   $0x0
  pushl $52
80106418:	6a 34                	push   $0x34
  jmp alltraps
8010641a:	e9 23 f8 ff ff       	jmp    80105c42 <alltraps>

8010641f <vector53>:
.globl vector53
vector53:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $53
80106421:	6a 35                	push   $0x35
  jmp alltraps
80106423:	e9 1a f8 ff ff       	jmp    80105c42 <alltraps>

80106428 <vector54>:
.globl vector54
vector54:
  pushl $0
80106428:	6a 00                	push   $0x0
  pushl $54
8010642a:	6a 36                	push   $0x36
  jmp alltraps
8010642c:	e9 11 f8 ff ff       	jmp    80105c42 <alltraps>

80106431 <vector55>:
.globl vector55
vector55:
  pushl $0
80106431:	6a 00                	push   $0x0
  pushl $55
80106433:	6a 37                	push   $0x37
  jmp alltraps
80106435:	e9 08 f8 ff ff       	jmp    80105c42 <alltraps>

8010643a <vector56>:
.globl vector56
vector56:
  pushl $0
8010643a:	6a 00                	push   $0x0
  pushl $56
8010643c:	6a 38                	push   $0x38
  jmp alltraps
8010643e:	e9 ff f7 ff ff       	jmp    80105c42 <alltraps>

80106443 <vector57>:
.globl vector57
vector57:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $57
80106445:	6a 39                	push   $0x39
  jmp alltraps
80106447:	e9 f6 f7 ff ff       	jmp    80105c42 <alltraps>

8010644c <vector58>:
.globl vector58
vector58:
  pushl $0
8010644c:	6a 00                	push   $0x0
  pushl $58
8010644e:	6a 3a                	push   $0x3a
  jmp alltraps
80106450:	e9 ed f7 ff ff       	jmp    80105c42 <alltraps>

80106455 <vector59>:
.globl vector59
vector59:
  pushl $0
80106455:	6a 00                	push   $0x0
  pushl $59
80106457:	6a 3b                	push   $0x3b
  jmp alltraps
80106459:	e9 e4 f7 ff ff       	jmp    80105c42 <alltraps>

8010645e <vector60>:
.globl vector60
vector60:
  pushl $0
8010645e:	6a 00                	push   $0x0
  pushl $60
80106460:	6a 3c                	push   $0x3c
  jmp alltraps
80106462:	e9 db f7 ff ff       	jmp    80105c42 <alltraps>

80106467 <vector61>:
.globl vector61
vector61:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $61
80106469:	6a 3d                	push   $0x3d
  jmp alltraps
8010646b:	e9 d2 f7 ff ff       	jmp    80105c42 <alltraps>

80106470 <vector62>:
.globl vector62
vector62:
  pushl $0
80106470:	6a 00                	push   $0x0
  pushl $62
80106472:	6a 3e                	push   $0x3e
  jmp alltraps
80106474:	e9 c9 f7 ff ff       	jmp    80105c42 <alltraps>

80106479 <vector63>:
.globl vector63
vector63:
  pushl $0
80106479:	6a 00                	push   $0x0
  pushl $63
8010647b:	6a 3f                	push   $0x3f
  jmp alltraps
8010647d:	e9 c0 f7 ff ff       	jmp    80105c42 <alltraps>

80106482 <vector64>:
.globl vector64
vector64:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $64
80106484:	6a 40                	push   $0x40
  jmp alltraps
80106486:	e9 b7 f7 ff ff       	jmp    80105c42 <alltraps>

8010648b <vector65>:
.globl vector65
vector65:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $65
8010648d:	6a 41                	push   $0x41
  jmp alltraps
8010648f:	e9 ae f7 ff ff       	jmp    80105c42 <alltraps>

80106494 <vector66>:
.globl vector66
vector66:
  pushl $0
80106494:	6a 00                	push   $0x0
  pushl $66
80106496:	6a 42                	push   $0x42
  jmp alltraps
80106498:	e9 a5 f7 ff ff       	jmp    80105c42 <alltraps>

8010649d <vector67>:
.globl vector67
vector67:
  pushl $0
8010649d:	6a 00                	push   $0x0
  pushl $67
8010649f:	6a 43                	push   $0x43
  jmp alltraps
801064a1:	e9 9c f7 ff ff       	jmp    80105c42 <alltraps>

801064a6 <vector68>:
.globl vector68
vector68:
  pushl $0
801064a6:	6a 00                	push   $0x0
  pushl $68
801064a8:	6a 44                	push   $0x44
  jmp alltraps
801064aa:	e9 93 f7 ff ff       	jmp    80105c42 <alltraps>

801064af <vector69>:
.globl vector69
vector69:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $69
801064b1:	6a 45                	push   $0x45
  jmp alltraps
801064b3:	e9 8a f7 ff ff       	jmp    80105c42 <alltraps>

801064b8 <vector70>:
.globl vector70
vector70:
  pushl $0
801064b8:	6a 00                	push   $0x0
  pushl $70
801064ba:	6a 46                	push   $0x46
  jmp alltraps
801064bc:	e9 81 f7 ff ff       	jmp    80105c42 <alltraps>

801064c1 <vector71>:
.globl vector71
vector71:
  pushl $0
801064c1:	6a 00                	push   $0x0
  pushl $71
801064c3:	6a 47                	push   $0x47
  jmp alltraps
801064c5:	e9 78 f7 ff ff       	jmp    80105c42 <alltraps>

801064ca <vector72>:
.globl vector72
vector72:
  pushl $0
801064ca:	6a 00                	push   $0x0
  pushl $72
801064cc:	6a 48                	push   $0x48
  jmp alltraps
801064ce:	e9 6f f7 ff ff       	jmp    80105c42 <alltraps>

801064d3 <vector73>:
.globl vector73
vector73:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $73
801064d5:	6a 49                	push   $0x49
  jmp alltraps
801064d7:	e9 66 f7 ff ff       	jmp    80105c42 <alltraps>

801064dc <vector74>:
.globl vector74
vector74:
  pushl $0
801064dc:	6a 00                	push   $0x0
  pushl $74
801064de:	6a 4a                	push   $0x4a
  jmp alltraps
801064e0:	e9 5d f7 ff ff       	jmp    80105c42 <alltraps>

801064e5 <vector75>:
.globl vector75
vector75:
  pushl $0
801064e5:	6a 00                	push   $0x0
  pushl $75
801064e7:	6a 4b                	push   $0x4b
  jmp alltraps
801064e9:	e9 54 f7 ff ff       	jmp    80105c42 <alltraps>

801064ee <vector76>:
.globl vector76
vector76:
  pushl $0
801064ee:	6a 00                	push   $0x0
  pushl $76
801064f0:	6a 4c                	push   $0x4c
  jmp alltraps
801064f2:	e9 4b f7 ff ff       	jmp    80105c42 <alltraps>

801064f7 <vector77>:
.globl vector77
vector77:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $77
801064f9:	6a 4d                	push   $0x4d
  jmp alltraps
801064fb:	e9 42 f7 ff ff       	jmp    80105c42 <alltraps>

80106500 <vector78>:
.globl vector78
vector78:
  pushl $0
80106500:	6a 00                	push   $0x0
  pushl $78
80106502:	6a 4e                	push   $0x4e
  jmp alltraps
80106504:	e9 39 f7 ff ff       	jmp    80105c42 <alltraps>

80106509 <vector79>:
.globl vector79
vector79:
  pushl $0
80106509:	6a 00                	push   $0x0
  pushl $79
8010650b:	6a 4f                	push   $0x4f
  jmp alltraps
8010650d:	e9 30 f7 ff ff       	jmp    80105c42 <alltraps>

80106512 <vector80>:
.globl vector80
vector80:
  pushl $0
80106512:	6a 00                	push   $0x0
  pushl $80
80106514:	6a 50                	push   $0x50
  jmp alltraps
80106516:	e9 27 f7 ff ff       	jmp    80105c42 <alltraps>

8010651b <vector81>:
.globl vector81
vector81:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $81
8010651d:	6a 51                	push   $0x51
  jmp alltraps
8010651f:	e9 1e f7 ff ff       	jmp    80105c42 <alltraps>

80106524 <vector82>:
.globl vector82
vector82:
  pushl $0
80106524:	6a 00                	push   $0x0
  pushl $82
80106526:	6a 52                	push   $0x52
  jmp alltraps
80106528:	e9 15 f7 ff ff       	jmp    80105c42 <alltraps>

8010652d <vector83>:
.globl vector83
vector83:
  pushl $0
8010652d:	6a 00                	push   $0x0
  pushl $83
8010652f:	6a 53                	push   $0x53
  jmp alltraps
80106531:	e9 0c f7 ff ff       	jmp    80105c42 <alltraps>

80106536 <vector84>:
.globl vector84
vector84:
  pushl $0
80106536:	6a 00                	push   $0x0
  pushl $84
80106538:	6a 54                	push   $0x54
  jmp alltraps
8010653a:	e9 03 f7 ff ff       	jmp    80105c42 <alltraps>

8010653f <vector85>:
.globl vector85
vector85:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $85
80106541:	6a 55                	push   $0x55
  jmp alltraps
80106543:	e9 fa f6 ff ff       	jmp    80105c42 <alltraps>

80106548 <vector86>:
.globl vector86
vector86:
  pushl $0
80106548:	6a 00                	push   $0x0
  pushl $86
8010654a:	6a 56                	push   $0x56
  jmp alltraps
8010654c:	e9 f1 f6 ff ff       	jmp    80105c42 <alltraps>

80106551 <vector87>:
.globl vector87
vector87:
  pushl $0
80106551:	6a 00                	push   $0x0
  pushl $87
80106553:	6a 57                	push   $0x57
  jmp alltraps
80106555:	e9 e8 f6 ff ff       	jmp    80105c42 <alltraps>

8010655a <vector88>:
.globl vector88
vector88:
  pushl $0
8010655a:	6a 00                	push   $0x0
  pushl $88
8010655c:	6a 58                	push   $0x58
  jmp alltraps
8010655e:	e9 df f6 ff ff       	jmp    80105c42 <alltraps>

80106563 <vector89>:
.globl vector89
vector89:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $89
80106565:	6a 59                	push   $0x59
  jmp alltraps
80106567:	e9 d6 f6 ff ff       	jmp    80105c42 <alltraps>

8010656c <vector90>:
.globl vector90
vector90:
  pushl $0
8010656c:	6a 00                	push   $0x0
  pushl $90
8010656e:	6a 5a                	push   $0x5a
  jmp alltraps
80106570:	e9 cd f6 ff ff       	jmp    80105c42 <alltraps>

80106575 <vector91>:
.globl vector91
vector91:
  pushl $0
80106575:	6a 00                	push   $0x0
  pushl $91
80106577:	6a 5b                	push   $0x5b
  jmp alltraps
80106579:	e9 c4 f6 ff ff       	jmp    80105c42 <alltraps>

8010657e <vector92>:
.globl vector92
vector92:
  pushl $0
8010657e:	6a 00                	push   $0x0
  pushl $92
80106580:	6a 5c                	push   $0x5c
  jmp alltraps
80106582:	e9 bb f6 ff ff       	jmp    80105c42 <alltraps>

80106587 <vector93>:
.globl vector93
vector93:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $93
80106589:	6a 5d                	push   $0x5d
  jmp alltraps
8010658b:	e9 b2 f6 ff ff       	jmp    80105c42 <alltraps>

80106590 <vector94>:
.globl vector94
vector94:
  pushl $0
80106590:	6a 00                	push   $0x0
  pushl $94
80106592:	6a 5e                	push   $0x5e
  jmp alltraps
80106594:	e9 a9 f6 ff ff       	jmp    80105c42 <alltraps>

80106599 <vector95>:
.globl vector95
vector95:
  pushl $0
80106599:	6a 00                	push   $0x0
  pushl $95
8010659b:	6a 5f                	push   $0x5f
  jmp alltraps
8010659d:	e9 a0 f6 ff ff       	jmp    80105c42 <alltraps>

801065a2 <vector96>:
.globl vector96
vector96:
  pushl $0
801065a2:	6a 00                	push   $0x0
  pushl $96
801065a4:	6a 60                	push   $0x60
  jmp alltraps
801065a6:	e9 97 f6 ff ff       	jmp    80105c42 <alltraps>

801065ab <vector97>:
.globl vector97
vector97:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $97
801065ad:	6a 61                	push   $0x61
  jmp alltraps
801065af:	e9 8e f6 ff ff       	jmp    80105c42 <alltraps>

801065b4 <vector98>:
.globl vector98
vector98:
  pushl $0
801065b4:	6a 00                	push   $0x0
  pushl $98
801065b6:	6a 62                	push   $0x62
  jmp alltraps
801065b8:	e9 85 f6 ff ff       	jmp    80105c42 <alltraps>

801065bd <vector99>:
.globl vector99
vector99:
  pushl $0
801065bd:	6a 00                	push   $0x0
  pushl $99
801065bf:	6a 63                	push   $0x63
  jmp alltraps
801065c1:	e9 7c f6 ff ff       	jmp    80105c42 <alltraps>

801065c6 <vector100>:
.globl vector100
vector100:
  pushl $0
801065c6:	6a 00                	push   $0x0
  pushl $100
801065c8:	6a 64                	push   $0x64
  jmp alltraps
801065ca:	e9 73 f6 ff ff       	jmp    80105c42 <alltraps>

801065cf <vector101>:
.globl vector101
vector101:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $101
801065d1:	6a 65                	push   $0x65
  jmp alltraps
801065d3:	e9 6a f6 ff ff       	jmp    80105c42 <alltraps>

801065d8 <vector102>:
.globl vector102
vector102:
  pushl $0
801065d8:	6a 00                	push   $0x0
  pushl $102
801065da:	6a 66                	push   $0x66
  jmp alltraps
801065dc:	e9 61 f6 ff ff       	jmp    80105c42 <alltraps>

801065e1 <vector103>:
.globl vector103
vector103:
  pushl $0
801065e1:	6a 00                	push   $0x0
  pushl $103
801065e3:	6a 67                	push   $0x67
  jmp alltraps
801065e5:	e9 58 f6 ff ff       	jmp    80105c42 <alltraps>

801065ea <vector104>:
.globl vector104
vector104:
  pushl $0
801065ea:	6a 00                	push   $0x0
  pushl $104
801065ec:	6a 68                	push   $0x68
  jmp alltraps
801065ee:	e9 4f f6 ff ff       	jmp    80105c42 <alltraps>

801065f3 <vector105>:
.globl vector105
vector105:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $105
801065f5:	6a 69                	push   $0x69
  jmp alltraps
801065f7:	e9 46 f6 ff ff       	jmp    80105c42 <alltraps>

801065fc <vector106>:
.globl vector106
vector106:
  pushl $0
801065fc:	6a 00                	push   $0x0
  pushl $106
801065fe:	6a 6a                	push   $0x6a
  jmp alltraps
80106600:	e9 3d f6 ff ff       	jmp    80105c42 <alltraps>

80106605 <vector107>:
.globl vector107
vector107:
  pushl $0
80106605:	6a 00                	push   $0x0
  pushl $107
80106607:	6a 6b                	push   $0x6b
  jmp alltraps
80106609:	e9 34 f6 ff ff       	jmp    80105c42 <alltraps>

8010660e <vector108>:
.globl vector108
vector108:
  pushl $0
8010660e:	6a 00                	push   $0x0
  pushl $108
80106610:	6a 6c                	push   $0x6c
  jmp alltraps
80106612:	e9 2b f6 ff ff       	jmp    80105c42 <alltraps>

80106617 <vector109>:
.globl vector109
vector109:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $109
80106619:	6a 6d                	push   $0x6d
  jmp alltraps
8010661b:	e9 22 f6 ff ff       	jmp    80105c42 <alltraps>

80106620 <vector110>:
.globl vector110
vector110:
  pushl $0
80106620:	6a 00                	push   $0x0
  pushl $110
80106622:	6a 6e                	push   $0x6e
  jmp alltraps
80106624:	e9 19 f6 ff ff       	jmp    80105c42 <alltraps>

80106629 <vector111>:
.globl vector111
vector111:
  pushl $0
80106629:	6a 00                	push   $0x0
  pushl $111
8010662b:	6a 6f                	push   $0x6f
  jmp alltraps
8010662d:	e9 10 f6 ff ff       	jmp    80105c42 <alltraps>

80106632 <vector112>:
.globl vector112
vector112:
  pushl $0
80106632:	6a 00                	push   $0x0
  pushl $112
80106634:	6a 70                	push   $0x70
  jmp alltraps
80106636:	e9 07 f6 ff ff       	jmp    80105c42 <alltraps>

8010663b <vector113>:
.globl vector113
vector113:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $113
8010663d:	6a 71                	push   $0x71
  jmp alltraps
8010663f:	e9 fe f5 ff ff       	jmp    80105c42 <alltraps>

80106644 <vector114>:
.globl vector114
vector114:
  pushl $0
80106644:	6a 00                	push   $0x0
  pushl $114
80106646:	6a 72                	push   $0x72
  jmp alltraps
80106648:	e9 f5 f5 ff ff       	jmp    80105c42 <alltraps>

8010664d <vector115>:
.globl vector115
vector115:
  pushl $0
8010664d:	6a 00                	push   $0x0
  pushl $115
8010664f:	6a 73                	push   $0x73
  jmp alltraps
80106651:	e9 ec f5 ff ff       	jmp    80105c42 <alltraps>

80106656 <vector116>:
.globl vector116
vector116:
  pushl $0
80106656:	6a 00                	push   $0x0
  pushl $116
80106658:	6a 74                	push   $0x74
  jmp alltraps
8010665a:	e9 e3 f5 ff ff       	jmp    80105c42 <alltraps>

8010665f <vector117>:
.globl vector117
vector117:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $117
80106661:	6a 75                	push   $0x75
  jmp alltraps
80106663:	e9 da f5 ff ff       	jmp    80105c42 <alltraps>

80106668 <vector118>:
.globl vector118
vector118:
  pushl $0
80106668:	6a 00                	push   $0x0
  pushl $118
8010666a:	6a 76                	push   $0x76
  jmp alltraps
8010666c:	e9 d1 f5 ff ff       	jmp    80105c42 <alltraps>

80106671 <vector119>:
.globl vector119
vector119:
  pushl $0
80106671:	6a 00                	push   $0x0
  pushl $119
80106673:	6a 77                	push   $0x77
  jmp alltraps
80106675:	e9 c8 f5 ff ff       	jmp    80105c42 <alltraps>

8010667a <vector120>:
.globl vector120
vector120:
  pushl $0
8010667a:	6a 00                	push   $0x0
  pushl $120
8010667c:	6a 78                	push   $0x78
  jmp alltraps
8010667e:	e9 bf f5 ff ff       	jmp    80105c42 <alltraps>

80106683 <vector121>:
.globl vector121
vector121:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $121
80106685:	6a 79                	push   $0x79
  jmp alltraps
80106687:	e9 b6 f5 ff ff       	jmp    80105c42 <alltraps>

8010668c <vector122>:
.globl vector122
vector122:
  pushl $0
8010668c:	6a 00                	push   $0x0
  pushl $122
8010668e:	6a 7a                	push   $0x7a
  jmp alltraps
80106690:	e9 ad f5 ff ff       	jmp    80105c42 <alltraps>

80106695 <vector123>:
.globl vector123
vector123:
  pushl $0
80106695:	6a 00                	push   $0x0
  pushl $123
80106697:	6a 7b                	push   $0x7b
  jmp alltraps
80106699:	e9 a4 f5 ff ff       	jmp    80105c42 <alltraps>

8010669e <vector124>:
.globl vector124
vector124:
  pushl $0
8010669e:	6a 00                	push   $0x0
  pushl $124
801066a0:	6a 7c                	push   $0x7c
  jmp alltraps
801066a2:	e9 9b f5 ff ff       	jmp    80105c42 <alltraps>

801066a7 <vector125>:
.globl vector125
vector125:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $125
801066a9:	6a 7d                	push   $0x7d
  jmp alltraps
801066ab:	e9 92 f5 ff ff       	jmp    80105c42 <alltraps>

801066b0 <vector126>:
.globl vector126
vector126:
  pushl $0
801066b0:	6a 00                	push   $0x0
  pushl $126
801066b2:	6a 7e                	push   $0x7e
  jmp alltraps
801066b4:	e9 89 f5 ff ff       	jmp    80105c42 <alltraps>

801066b9 <vector127>:
.globl vector127
vector127:
  pushl $0
801066b9:	6a 00                	push   $0x0
  pushl $127
801066bb:	6a 7f                	push   $0x7f
  jmp alltraps
801066bd:	e9 80 f5 ff ff       	jmp    80105c42 <alltraps>

801066c2 <vector128>:
.globl vector128
vector128:
  pushl $0
801066c2:	6a 00                	push   $0x0
  pushl $128
801066c4:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801066c9:	e9 74 f5 ff ff       	jmp    80105c42 <alltraps>

801066ce <vector129>:
.globl vector129
vector129:
  pushl $0
801066ce:	6a 00                	push   $0x0
  pushl $129
801066d0:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801066d5:	e9 68 f5 ff ff       	jmp    80105c42 <alltraps>

801066da <vector130>:
.globl vector130
vector130:
  pushl $0
801066da:	6a 00                	push   $0x0
  pushl $130
801066dc:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801066e1:	e9 5c f5 ff ff       	jmp    80105c42 <alltraps>

801066e6 <vector131>:
.globl vector131
vector131:
  pushl $0
801066e6:	6a 00                	push   $0x0
  pushl $131
801066e8:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801066ed:	e9 50 f5 ff ff       	jmp    80105c42 <alltraps>

801066f2 <vector132>:
.globl vector132
vector132:
  pushl $0
801066f2:	6a 00                	push   $0x0
  pushl $132
801066f4:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801066f9:	e9 44 f5 ff ff       	jmp    80105c42 <alltraps>

801066fe <vector133>:
.globl vector133
vector133:
  pushl $0
801066fe:	6a 00                	push   $0x0
  pushl $133
80106700:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106705:	e9 38 f5 ff ff       	jmp    80105c42 <alltraps>

8010670a <vector134>:
.globl vector134
vector134:
  pushl $0
8010670a:	6a 00                	push   $0x0
  pushl $134
8010670c:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106711:	e9 2c f5 ff ff       	jmp    80105c42 <alltraps>

80106716 <vector135>:
.globl vector135
vector135:
  pushl $0
80106716:	6a 00                	push   $0x0
  pushl $135
80106718:	68 87 00 00 00       	push   $0x87
  jmp alltraps
8010671d:	e9 20 f5 ff ff       	jmp    80105c42 <alltraps>

80106722 <vector136>:
.globl vector136
vector136:
  pushl $0
80106722:	6a 00                	push   $0x0
  pushl $136
80106724:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106729:	e9 14 f5 ff ff       	jmp    80105c42 <alltraps>

8010672e <vector137>:
.globl vector137
vector137:
  pushl $0
8010672e:	6a 00                	push   $0x0
  pushl $137
80106730:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106735:	e9 08 f5 ff ff       	jmp    80105c42 <alltraps>

8010673a <vector138>:
.globl vector138
vector138:
  pushl $0
8010673a:	6a 00                	push   $0x0
  pushl $138
8010673c:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106741:	e9 fc f4 ff ff       	jmp    80105c42 <alltraps>

80106746 <vector139>:
.globl vector139
vector139:
  pushl $0
80106746:	6a 00                	push   $0x0
  pushl $139
80106748:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
8010674d:	e9 f0 f4 ff ff       	jmp    80105c42 <alltraps>

80106752 <vector140>:
.globl vector140
vector140:
  pushl $0
80106752:	6a 00                	push   $0x0
  pushl $140
80106754:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106759:	e9 e4 f4 ff ff       	jmp    80105c42 <alltraps>

8010675e <vector141>:
.globl vector141
vector141:
  pushl $0
8010675e:	6a 00                	push   $0x0
  pushl $141
80106760:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106765:	e9 d8 f4 ff ff       	jmp    80105c42 <alltraps>

8010676a <vector142>:
.globl vector142
vector142:
  pushl $0
8010676a:	6a 00                	push   $0x0
  pushl $142
8010676c:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106771:	e9 cc f4 ff ff       	jmp    80105c42 <alltraps>

80106776 <vector143>:
.globl vector143
vector143:
  pushl $0
80106776:	6a 00                	push   $0x0
  pushl $143
80106778:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
8010677d:	e9 c0 f4 ff ff       	jmp    80105c42 <alltraps>

80106782 <vector144>:
.globl vector144
vector144:
  pushl $0
80106782:	6a 00                	push   $0x0
  pushl $144
80106784:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106789:	e9 b4 f4 ff ff       	jmp    80105c42 <alltraps>

8010678e <vector145>:
.globl vector145
vector145:
  pushl $0
8010678e:	6a 00                	push   $0x0
  pushl $145
80106790:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106795:	e9 a8 f4 ff ff       	jmp    80105c42 <alltraps>

8010679a <vector146>:
.globl vector146
vector146:
  pushl $0
8010679a:	6a 00                	push   $0x0
  pushl $146
8010679c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801067a1:	e9 9c f4 ff ff       	jmp    80105c42 <alltraps>

801067a6 <vector147>:
.globl vector147
vector147:
  pushl $0
801067a6:	6a 00                	push   $0x0
  pushl $147
801067a8:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801067ad:	e9 90 f4 ff ff       	jmp    80105c42 <alltraps>

801067b2 <vector148>:
.globl vector148
vector148:
  pushl $0
801067b2:	6a 00                	push   $0x0
  pushl $148
801067b4:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801067b9:	e9 84 f4 ff ff       	jmp    80105c42 <alltraps>

801067be <vector149>:
.globl vector149
vector149:
  pushl $0
801067be:	6a 00                	push   $0x0
  pushl $149
801067c0:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801067c5:	e9 78 f4 ff ff       	jmp    80105c42 <alltraps>

801067ca <vector150>:
.globl vector150
vector150:
  pushl $0
801067ca:	6a 00                	push   $0x0
  pushl $150
801067cc:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801067d1:	e9 6c f4 ff ff       	jmp    80105c42 <alltraps>

801067d6 <vector151>:
.globl vector151
vector151:
  pushl $0
801067d6:	6a 00                	push   $0x0
  pushl $151
801067d8:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801067dd:	e9 60 f4 ff ff       	jmp    80105c42 <alltraps>

801067e2 <vector152>:
.globl vector152
vector152:
  pushl $0
801067e2:	6a 00                	push   $0x0
  pushl $152
801067e4:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801067e9:	e9 54 f4 ff ff       	jmp    80105c42 <alltraps>

801067ee <vector153>:
.globl vector153
vector153:
  pushl $0
801067ee:	6a 00                	push   $0x0
  pushl $153
801067f0:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801067f5:	e9 48 f4 ff ff       	jmp    80105c42 <alltraps>

801067fa <vector154>:
.globl vector154
vector154:
  pushl $0
801067fa:	6a 00                	push   $0x0
  pushl $154
801067fc:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106801:	e9 3c f4 ff ff       	jmp    80105c42 <alltraps>

80106806 <vector155>:
.globl vector155
vector155:
  pushl $0
80106806:	6a 00                	push   $0x0
  pushl $155
80106808:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
8010680d:	e9 30 f4 ff ff       	jmp    80105c42 <alltraps>

80106812 <vector156>:
.globl vector156
vector156:
  pushl $0
80106812:	6a 00                	push   $0x0
  pushl $156
80106814:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106819:	e9 24 f4 ff ff       	jmp    80105c42 <alltraps>

8010681e <vector157>:
.globl vector157
vector157:
  pushl $0
8010681e:	6a 00                	push   $0x0
  pushl $157
80106820:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106825:	e9 18 f4 ff ff       	jmp    80105c42 <alltraps>

8010682a <vector158>:
.globl vector158
vector158:
  pushl $0
8010682a:	6a 00                	push   $0x0
  pushl $158
8010682c:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106831:	e9 0c f4 ff ff       	jmp    80105c42 <alltraps>

80106836 <vector159>:
.globl vector159
vector159:
  pushl $0
80106836:	6a 00                	push   $0x0
  pushl $159
80106838:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
8010683d:	e9 00 f4 ff ff       	jmp    80105c42 <alltraps>

80106842 <vector160>:
.globl vector160
vector160:
  pushl $0
80106842:	6a 00                	push   $0x0
  pushl $160
80106844:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106849:	e9 f4 f3 ff ff       	jmp    80105c42 <alltraps>

8010684e <vector161>:
.globl vector161
vector161:
  pushl $0
8010684e:	6a 00                	push   $0x0
  pushl $161
80106850:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106855:	e9 e8 f3 ff ff       	jmp    80105c42 <alltraps>

8010685a <vector162>:
.globl vector162
vector162:
  pushl $0
8010685a:	6a 00                	push   $0x0
  pushl $162
8010685c:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106861:	e9 dc f3 ff ff       	jmp    80105c42 <alltraps>

80106866 <vector163>:
.globl vector163
vector163:
  pushl $0
80106866:	6a 00                	push   $0x0
  pushl $163
80106868:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010686d:	e9 d0 f3 ff ff       	jmp    80105c42 <alltraps>

80106872 <vector164>:
.globl vector164
vector164:
  pushl $0
80106872:	6a 00                	push   $0x0
  pushl $164
80106874:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106879:	e9 c4 f3 ff ff       	jmp    80105c42 <alltraps>

8010687e <vector165>:
.globl vector165
vector165:
  pushl $0
8010687e:	6a 00                	push   $0x0
  pushl $165
80106880:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106885:	e9 b8 f3 ff ff       	jmp    80105c42 <alltraps>

8010688a <vector166>:
.globl vector166
vector166:
  pushl $0
8010688a:	6a 00                	push   $0x0
  pushl $166
8010688c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106891:	e9 ac f3 ff ff       	jmp    80105c42 <alltraps>

80106896 <vector167>:
.globl vector167
vector167:
  pushl $0
80106896:	6a 00                	push   $0x0
  pushl $167
80106898:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
8010689d:	e9 a0 f3 ff ff       	jmp    80105c42 <alltraps>

801068a2 <vector168>:
.globl vector168
vector168:
  pushl $0
801068a2:	6a 00                	push   $0x0
  pushl $168
801068a4:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801068a9:	e9 94 f3 ff ff       	jmp    80105c42 <alltraps>

801068ae <vector169>:
.globl vector169
vector169:
  pushl $0
801068ae:	6a 00                	push   $0x0
  pushl $169
801068b0:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801068b5:	e9 88 f3 ff ff       	jmp    80105c42 <alltraps>

801068ba <vector170>:
.globl vector170
vector170:
  pushl $0
801068ba:	6a 00                	push   $0x0
  pushl $170
801068bc:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801068c1:	e9 7c f3 ff ff       	jmp    80105c42 <alltraps>

801068c6 <vector171>:
.globl vector171
vector171:
  pushl $0
801068c6:	6a 00                	push   $0x0
  pushl $171
801068c8:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801068cd:	e9 70 f3 ff ff       	jmp    80105c42 <alltraps>

801068d2 <vector172>:
.globl vector172
vector172:
  pushl $0
801068d2:	6a 00                	push   $0x0
  pushl $172
801068d4:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801068d9:	e9 64 f3 ff ff       	jmp    80105c42 <alltraps>

801068de <vector173>:
.globl vector173
vector173:
  pushl $0
801068de:	6a 00                	push   $0x0
  pushl $173
801068e0:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801068e5:	e9 58 f3 ff ff       	jmp    80105c42 <alltraps>

801068ea <vector174>:
.globl vector174
vector174:
  pushl $0
801068ea:	6a 00                	push   $0x0
  pushl $174
801068ec:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801068f1:	e9 4c f3 ff ff       	jmp    80105c42 <alltraps>

801068f6 <vector175>:
.globl vector175
vector175:
  pushl $0
801068f6:	6a 00                	push   $0x0
  pushl $175
801068f8:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801068fd:	e9 40 f3 ff ff       	jmp    80105c42 <alltraps>

80106902 <vector176>:
.globl vector176
vector176:
  pushl $0
80106902:	6a 00                	push   $0x0
  pushl $176
80106904:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106909:	e9 34 f3 ff ff       	jmp    80105c42 <alltraps>

8010690e <vector177>:
.globl vector177
vector177:
  pushl $0
8010690e:	6a 00                	push   $0x0
  pushl $177
80106910:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106915:	e9 28 f3 ff ff       	jmp    80105c42 <alltraps>

8010691a <vector178>:
.globl vector178
vector178:
  pushl $0
8010691a:	6a 00                	push   $0x0
  pushl $178
8010691c:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106921:	e9 1c f3 ff ff       	jmp    80105c42 <alltraps>

80106926 <vector179>:
.globl vector179
vector179:
  pushl $0
80106926:	6a 00                	push   $0x0
  pushl $179
80106928:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
8010692d:	e9 10 f3 ff ff       	jmp    80105c42 <alltraps>

80106932 <vector180>:
.globl vector180
vector180:
  pushl $0
80106932:	6a 00                	push   $0x0
  pushl $180
80106934:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106939:	e9 04 f3 ff ff       	jmp    80105c42 <alltraps>

8010693e <vector181>:
.globl vector181
vector181:
  pushl $0
8010693e:	6a 00                	push   $0x0
  pushl $181
80106940:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106945:	e9 f8 f2 ff ff       	jmp    80105c42 <alltraps>

8010694a <vector182>:
.globl vector182
vector182:
  pushl $0
8010694a:	6a 00                	push   $0x0
  pushl $182
8010694c:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106951:	e9 ec f2 ff ff       	jmp    80105c42 <alltraps>

80106956 <vector183>:
.globl vector183
vector183:
  pushl $0
80106956:	6a 00                	push   $0x0
  pushl $183
80106958:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010695d:	e9 e0 f2 ff ff       	jmp    80105c42 <alltraps>

80106962 <vector184>:
.globl vector184
vector184:
  pushl $0
80106962:	6a 00                	push   $0x0
  pushl $184
80106964:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106969:	e9 d4 f2 ff ff       	jmp    80105c42 <alltraps>

8010696e <vector185>:
.globl vector185
vector185:
  pushl $0
8010696e:	6a 00                	push   $0x0
  pushl $185
80106970:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106975:	e9 c8 f2 ff ff       	jmp    80105c42 <alltraps>

8010697a <vector186>:
.globl vector186
vector186:
  pushl $0
8010697a:	6a 00                	push   $0x0
  pushl $186
8010697c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106981:	e9 bc f2 ff ff       	jmp    80105c42 <alltraps>

80106986 <vector187>:
.globl vector187
vector187:
  pushl $0
80106986:	6a 00                	push   $0x0
  pushl $187
80106988:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
8010698d:	e9 b0 f2 ff ff       	jmp    80105c42 <alltraps>

80106992 <vector188>:
.globl vector188
vector188:
  pushl $0
80106992:	6a 00                	push   $0x0
  pushl $188
80106994:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106999:	e9 a4 f2 ff ff       	jmp    80105c42 <alltraps>

8010699e <vector189>:
.globl vector189
vector189:
  pushl $0
8010699e:	6a 00                	push   $0x0
  pushl $189
801069a0:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801069a5:	e9 98 f2 ff ff       	jmp    80105c42 <alltraps>

801069aa <vector190>:
.globl vector190
vector190:
  pushl $0
801069aa:	6a 00                	push   $0x0
  pushl $190
801069ac:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801069b1:	e9 8c f2 ff ff       	jmp    80105c42 <alltraps>

801069b6 <vector191>:
.globl vector191
vector191:
  pushl $0
801069b6:	6a 00                	push   $0x0
  pushl $191
801069b8:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801069bd:	e9 80 f2 ff ff       	jmp    80105c42 <alltraps>

801069c2 <vector192>:
.globl vector192
vector192:
  pushl $0
801069c2:	6a 00                	push   $0x0
  pushl $192
801069c4:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801069c9:	e9 74 f2 ff ff       	jmp    80105c42 <alltraps>

801069ce <vector193>:
.globl vector193
vector193:
  pushl $0
801069ce:	6a 00                	push   $0x0
  pushl $193
801069d0:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801069d5:	e9 68 f2 ff ff       	jmp    80105c42 <alltraps>

801069da <vector194>:
.globl vector194
vector194:
  pushl $0
801069da:	6a 00                	push   $0x0
  pushl $194
801069dc:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801069e1:	e9 5c f2 ff ff       	jmp    80105c42 <alltraps>

801069e6 <vector195>:
.globl vector195
vector195:
  pushl $0
801069e6:	6a 00                	push   $0x0
  pushl $195
801069e8:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801069ed:	e9 50 f2 ff ff       	jmp    80105c42 <alltraps>

801069f2 <vector196>:
.globl vector196
vector196:
  pushl $0
801069f2:	6a 00                	push   $0x0
  pushl $196
801069f4:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801069f9:	e9 44 f2 ff ff       	jmp    80105c42 <alltraps>

801069fe <vector197>:
.globl vector197
vector197:
  pushl $0
801069fe:	6a 00                	push   $0x0
  pushl $197
80106a00:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106a05:	e9 38 f2 ff ff       	jmp    80105c42 <alltraps>

80106a0a <vector198>:
.globl vector198
vector198:
  pushl $0
80106a0a:	6a 00                	push   $0x0
  pushl $198
80106a0c:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106a11:	e9 2c f2 ff ff       	jmp    80105c42 <alltraps>

80106a16 <vector199>:
.globl vector199
vector199:
  pushl $0
80106a16:	6a 00                	push   $0x0
  pushl $199
80106a18:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106a1d:	e9 20 f2 ff ff       	jmp    80105c42 <alltraps>

80106a22 <vector200>:
.globl vector200
vector200:
  pushl $0
80106a22:	6a 00                	push   $0x0
  pushl $200
80106a24:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106a29:	e9 14 f2 ff ff       	jmp    80105c42 <alltraps>

80106a2e <vector201>:
.globl vector201
vector201:
  pushl $0
80106a2e:	6a 00                	push   $0x0
  pushl $201
80106a30:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106a35:	e9 08 f2 ff ff       	jmp    80105c42 <alltraps>

80106a3a <vector202>:
.globl vector202
vector202:
  pushl $0
80106a3a:	6a 00                	push   $0x0
  pushl $202
80106a3c:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106a41:	e9 fc f1 ff ff       	jmp    80105c42 <alltraps>

80106a46 <vector203>:
.globl vector203
vector203:
  pushl $0
80106a46:	6a 00                	push   $0x0
  pushl $203
80106a48:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106a4d:	e9 f0 f1 ff ff       	jmp    80105c42 <alltraps>

80106a52 <vector204>:
.globl vector204
vector204:
  pushl $0
80106a52:	6a 00                	push   $0x0
  pushl $204
80106a54:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106a59:	e9 e4 f1 ff ff       	jmp    80105c42 <alltraps>

80106a5e <vector205>:
.globl vector205
vector205:
  pushl $0
80106a5e:	6a 00                	push   $0x0
  pushl $205
80106a60:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106a65:	e9 d8 f1 ff ff       	jmp    80105c42 <alltraps>

80106a6a <vector206>:
.globl vector206
vector206:
  pushl $0
80106a6a:	6a 00                	push   $0x0
  pushl $206
80106a6c:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106a71:	e9 cc f1 ff ff       	jmp    80105c42 <alltraps>

80106a76 <vector207>:
.globl vector207
vector207:
  pushl $0
80106a76:	6a 00                	push   $0x0
  pushl $207
80106a78:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106a7d:	e9 c0 f1 ff ff       	jmp    80105c42 <alltraps>

80106a82 <vector208>:
.globl vector208
vector208:
  pushl $0
80106a82:	6a 00                	push   $0x0
  pushl $208
80106a84:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106a89:	e9 b4 f1 ff ff       	jmp    80105c42 <alltraps>

80106a8e <vector209>:
.globl vector209
vector209:
  pushl $0
80106a8e:	6a 00                	push   $0x0
  pushl $209
80106a90:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106a95:	e9 a8 f1 ff ff       	jmp    80105c42 <alltraps>

80106a9a <vector210>:
.globl vector210
vector210:
  pushl $0
80106a9a:	6a 00                	push   $0x0
  pushl $210
80106a9c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106aa1:	e9 9c f1 ff ff       	jmp    80105c42 <alltraps>

80106aa6 <vector211>:
.globl vector211
vector211:
  pushl $0
80106aa6:	6a 00                	push   $0x0
  pushl $211
80106aa8:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106aad:	e9 90 f1 ff ff       	jmp    80105c42 <alltraps>

80106ab2 <vector212>:
.globl vector212
vector212:
  pushl $0
80106ab2:	6a 00                	push   $0x0
  pushl $212
80106ab4:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106ab9:	e9 84 f1 ff ff       	jmp    80105c42 <alltraps>

80106abe <vector213>:
.globl vector213
vector213:
  pushl $0
80106abe:	6a 00                	push   $0x0
  pushl $213
80106ac0:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106ac5:	e9 78 f1 ff ff       	jmp    80105c42 <alltraps>

80106aca <vector214>:
.globl vector214
vector214:
  pushl $0
80106aca:	6a 00                	push   $0x0
  pushl $214
80106acc:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106ad1:	e9 6c f1 ff ff       	jmp    80105c42 <alltraps>

80106ad6 <vector215>:
.globl vector215
vector215:
  pushl $0
80106ad6:	6a 00                	push   $0x0
  pushl $215
80106ad8:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106add:	e9 60 f1 ff ff       	jmp    80105c42 <alltraps>

80106ae2 <vector216>:
.globl vector216
vector216:
  pushl $0
80106ae2:	6a 00                	push   $0x0
  pushl $216
80106ae4:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106ae9:	e9 54 f1 ff ff       	jmp    80105c42 <alltraps>

80106aee <vector217>:
.globl vector217
vector217:
  pushl $0
80106aee:	6a 00                	push   $0x0
  pushl $217
80106af0:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106af5:	e9 48 f1 ff ff       	jmp    80105c42 <alltraps>

80106afa <vector218>:
.globl vector218
vector218:
  pushl $0
80106afa:	6a 00                	push   $0x0
  pushl $218
80106afc:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106b01:	e9 3c f1 ff ff       	jmp    80105c42 <alltraps>

80106b06 <vector219>:
.globl vector219
vector219:
  pushl $0
80106b06:	6a 00                	push   $0x0
  pushl $219
80106b08:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106b0d:	e9 30 f1 ff ff       	jmp    80105c42 <alltraps>

80106b12 <vector220>:
.globl vector220
vector220:
  pushl $0
80106b12:	6a 00                	push   $0x0
  pushl $220
80106b14:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106b19:	e9 24 f1 ff ff       	jmp    80105c42 <alltraps>

80106b1e <vector221>:
.globl vector221
vector221:
  pushl $0
80106b1e:	6a 00                	push   $0x0
  pushl $221
80106b20:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106b25:	e9 18 f1 ff ff       	jmp    80105c42 <alltraps>

80106b2a <vector222>:
.globl vector222
vector222:
  pushl $0
80106b2a:	6a 00                	push   $0x0
  pushl $222
80106b2c:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106b31:	e9 0c f1 ff ff       	jmp    80105c42 <alltraps>

80106b36 <vector223>:
.globl vector223
vector223:
  pushl $0
80106b36:	6a 00                	push   $0x0
  pushl $223
80106b38:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106b3d:	e9 00 f1 ff ff       	jmp    80105c42 <alltraps>

80106b42 <vector224>:
.globl vector224
vector224:
  pushl $0
80106b42:	6a 00                	push   $0x0
  pushl $224
80106b44:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106b49:	e9 f4 f0 ff ff       	jmp    80105c42 <alltraps>

80106b4e <vector225>:
.globl vector225
vector225:
  pushl $0
80106b4e:	6a 00                	push   $0x0
  pushl $225
80106b50:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106b55:	e9 e8 f0 ff ff       	jmp    80105c42 <alltraps>

80106b5a <vector226>:
.globl vector226
vector226:
  pushl $0
80106b5a:	6a 00                	push   $0x0
  pushl $226
80106b5c:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106b61:	e9 dc f0 ff ff       	jmp    80105c42 <alltraps>

80106b66 <vector227>:
.globl vector227
vector227:
  pushl $0
80106b66:	6a 00                	push   $0x0
  pushl $227
80106b68:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106b6d:	e9 d0 f0 ff ff       	jmp    80105c42 <alltraps>

80106b72 <vector228>:
.globl vector228
vector228:
  pushl $0
80106b72:	6a 00                	push   $0x0
  pushl $228
80106b74:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106b79:	e9 c4 f0 ff ff       	jmp    80105c42 <alltraps>

80106b7e <vector229>:
.globl vector229
vector229:
  pushl $0
80106b7e:	6a 00                	push   $0x0
  pushl $229
80106b80:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106b85:	e9 b8 f0 ff ff       	jmp    80105c42 <alltraps>

80106b8a <vector230>:
.globl vector230
vector230:
  pushl $0
80106b8a:	6a 00                	push   $0x0
  pushl $230
80106b8c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106b91:	e9 ac f0 ff ff       	jmp    80105c42 <alltraps>

80106b96 <vector231>:
.globl vector231
vector231:
  pushl $0
80106b96:	6a 00                	push   $0x0
  pushl $231
80106b98:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106b9d:	e9 a0 f0 ff ff       	jmp    80105c42 <alltraps>

80106ba2 <vector232>:
.globl vector232
vector232:
  pushl $0
80106ba2:	6a 00                	push   $0x0
  pushl $232
80106ba4:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106ba9:	e9 94 f0 ff ff       	jmp    80105c42 <alltraps>

80106bae <vector233>:
.globl vector233
vector233:
  pushl $0
80106bae:	6a 00                	push   $0x0
  pushl $233
80106bb0:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106bb5:	e9 88 f0 ff ff       	jmp    80105c42 <alltraps>

80106bba <vector234>:
.globl vector234
vector234:
  pushl $0
80106bba:	6a 00                	push   $0x0
  pushl $234
80106bbc:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106bc1:	e9 7c f0 ff ff       	jmp    80105c42 <alltraps>

80106bc6 <vector235>:
.globl vector235
vector235:
  pushl $0
80106bc6:	6a 00                	push   $0x0
  pushl $235
80106bc8:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106bcd:	e9 70 f0 ff ff       	jmp    80105c42 <alltraps>

80106bd2 <vector236>:
.globl vector236
vector236:
  pushl $0
80106bd2:	6a 00                	push   $0x0
  pushl $236
80106bd4:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106bd9:	e9 64 f0 ff ff       	jmp    80105c42 <alltraps>

80106bde <vector237>:
.globl vector237
vector237:
  pushl $0
80106bde:	6a 00                	push   $0x0
  pushl $237
80106be0:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106be5:	e9 58 f0 ff ff       	jmp    80105c42 <alltraps>

80106bea <vector238>:
.globl vector238
vector238:
  pushl $0
80106bea:	6a 00                	push   $0x0
  pushl $238
80106bec:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106bf1:	e9 4c f0 ff ff       	jmp    80105c42 <alltraps>

80106bf6 <vector239>:
.globl vector239
vector239:
  pushl $0
80106bf6:	6a 00                	push   $0x0
  pushl $239
80106bf8:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106bfd:	e9 40 f0 ff ff       	jmp    80105c42 <alltraps>

80106c02 <vector240>:
.globl vector240
vector240:
  pushl $0
80106c02:	6a 00                	push   $0x0
  pushl $240
80106c04:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106c09:	e9 34 f0 ff ff       	jmp    80105c42 <alltraps>

80106c0e <vector241>:
.globl vector241
vector241:
  pushl $0
80106c0e:	6a 00                	push   $0x0
  pushl $241
80106c10:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106c15:	e9 28 f0 ff ff       	jmp    80105c42 <alltraps>

80106c1a <vector242>:
.globl vector242
vector242:
  pushl $0
80106c1a:	6a 00                	push   $0x0
  pushl $242
80106c1c:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106c21:	e9 1c f0 ff ff       	jmp    80105c42 <alltraps>

80106c26 <vector243>:
.globl vector243
vector243:
  pushl $0
80106c26:	6a 00                	push   $0x0
  pushl $243
80106c28:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106c2d:	e9 10 f0 ff ff       	jmp    80105c42 <alltraps>

80106c32 <vector244>:
.globl vector244
vector244:
  pushl $0
80106c32:	6a 00                	push   $0x0
  pushl $244
80106c34:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106c39:	e9 04 f0 ff ff       	jmp    80105c42 <alltraps>

80106c3e <vector245>:
.globl vector245
vector245:
  pushl $0
80106c3e:	6a 00                	push   $0x0
  pushl $245
80106c40:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106c45:	e9 f8 ef ff ff       	jmp    80105c42 <alltraps>

80106c4a <vector246>:
.globl vector246
vector246:
  pushl $0
80106c4a:	6a 00                	push   $0x0
  pushl $246
80106c4c:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106c51:	e9 ec ef ff ff       	jmp    80105c42 <alltraps>

80106c56 <vector247>:
.globl vector247
vector247:
  pushl $0
80106c56:	6a 00                	push   $0x0
  pushl $247
80106c58:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106c5d:	e9 e0 ef ff ff       	jmp    80105c42 <alltraps>

80106c62 <vector248>:
.globl vector248
vector248:
  pushl $0
80106c62:	6a 00                	push   $0x0
  pushl $248
80106c64:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106c69:	e9 d4 ef ff ff       	jmp    80105c42 <alltraps>

80106c6e <vector249>:
.globl vector249
vector249:
  pushl $0
80106c6e:	6a 00                	push   $0x0
  pushl $249
80106c70:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106c75:	e9 c8 ef ff ff       	jmp    80105c42 <alltraps>

80106c7a <vector250>:
.globl vector250
vector250:
  pushl $0
80106c7a:	6a 00                	push   $0x0
  pushl $250
80106c7c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106c81:	e9 bc ef ff ff       	jmp    80105c42 <alltraps>

80106c86 <vector251>:
.globl vector251
vector251:
  pushl $0
80106c86:	6a 00                	push   $0x0
  pushl $251
80106c88:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106c8d:	e9 b0 ef ff ff       	jmp    80105c42 <alltraps>

80106c92 <vector252>:
.globl vector252
vector252:
  pushl $0
80106c92:	6a 00                	push   $0x0
  pushl $252
80106c94:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106c99:	e9 a4 ef ff ff       	jmp    80105c42 <alltraps>

80106c9e <vector253>:
.globl vector253
vector253:
  pushl $0
80106c9e:	6a 00                	push   $0x0
  pushl $253
80106ca0:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106ca5:	e9 98 ef ff ff       	jmp    80105c42 <alltraps>

80106caa <vector254>:
.globl vector254
vector254:
  pushl $0
80106caa:	6a 00                	push   $0x0
  pushl $254
80106cac:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106cb1:	e9 8c ef ff ff       	jmp    80105c42 <alltraps>

80106cb6 <vector255>:
.globl vector255
vector255:
  pushl $0
80106cb6:	6a 00                	push   $0x0
  pushl $255
80106cb8:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106cbd:	e9 80 ef ff ff       	jmp    80105c42 <alltraps>

80106cc2 <lgdt>:
{
80106cc2:	55                   	push   %ebp
80106cc3:	89 e5                	mov    %esp,%ebp
80106cc5:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106cc8:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ccb:	48                   	dec    %eax
80106ccc:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106cd0:	8b 45 08             	mov    0x8(%ebp),%eax
80106cd3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80106cda:	c1 e8 10             	shr    $0x10,%eax
80106cdd:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106ce1:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106ce4:	0f 01 10             	lgdtl  (%eax)
}
80106ce7:	90                   	nop
80106ce8:	c9                   	leave  
80106ce9:	c3                   	ret    

80106cea <ltr>:
{
80106cea:	55                   	push   %ebp
80106ceb:	89 e5                	mov    %esp,%ebp
80106ced:	83 ec 04             	sub    $0x4,%esp
80106cf0:	8b 45 08             	mov    0x8(%ebp),%eax
80106cf3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80106cf7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106cfa:	0f 00 d8             	ltr    %ax
}
80106cfd:	90                   	nop
80106cfe:	c9                   	leave  
80106cff:	c3                   	ret    

80106d00 <lcr3>:

static inline void
lcr3(uint val)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d03:	8b 45 08             	mov    0x8(%ebp),%eax
80106d06:	0f 22 d8             	mov    %eax,%cr3
}
80106d09:	90                   	nop
80106d0a:	5d                   	pop    %ebp
80106d0b:	c3                   	ret    

80106d0c <seginit>:
extern struct gpu gpu;
// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106d0c:	55                   	push   %ebp
80106d0d:	89 e5                	mov    %esp,%ebp
80106d0f:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106d12:	e8 fa cb ff ff       	call   80103911 <cpuid>
80106d17:	89 c2                	mov    %eax,%edx
80106d19:	89 d0                	mov    %edx,%eax
80106d1b:	c1 e0 02             	shl    $0x2,%eax
80106d1e:	01 d0                	add    %edx,%eax
80106d20:	01 c0                	add    %eax,%eax
80106d22:	01 d0                	add    %edx,%eax
80106d24:	c1 e0 04             	shl    $0x4,%eax
80106d27:	05 80 59 19 80       	add    $0x80195980,%eax
80106d2c:	89 45 f4             	mov    %eax,-0xc(%ebp)

  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106d2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d32:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80106d38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d3b:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80106d41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d44:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80106d48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d4b:	8a 50 7d             	mov    0x7d(%eax),%dl
80106d4e:	83 e2 f0             	and    $0xfffffff0,%edx
80106d51:	83 ca 0a             	or     $0xa,%edx
80106d54:	88 50 7d             	mov    %dl,0x7d(%eax)
80106d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d5a:	8a 50 7d             	mov    0x7d(%eax),%dl
80106d5d:	83 ca 10             	or     $0x10,%edx
80106d60:	88 50 7d             	mov    %dl,0x7d(%eax)
80106d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d66:	8a 50 7d             	mov    0x7d(%eax),%dl
80106d69:	83 e2 9f             	and    $0xffffff9f,%edx
80106d6c:	88 50 7d             	mov    %dl,0x7d(%eax)
80106d6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d72:	8a 50 7d             	mov    0x7d(%eax),%dl
80106d75:	83 ca 80             	or     $0xffffff80,%edx
80106d78:	88 50 7d             	mov    %dl,0x7d(%eax)
80106d7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d7e:	8a 50 7e             	mov    0x7e(%eax),%dl
80106d81:	83 ca 0f             	or     $0xf,%edx
80106d84:	88 50 7e             	mov    %dl,0x7e(%eax)
80106d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d8a:	8a 50 7e             	mov    0x7e(%eax),%dl
80106d8d:	83 e2 ef             	and    $0xffffffef,%edx
80106d90:	88 50 7e             	mov    %dl,0x7e(%eax)
80106d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d96:	8a 50 7e             	mov    0x7e(%eax),%dl
80106d99:	83 e2 df             	and    $0xffffffdf,%edx
80106d9c:	88 50 7e             	mov    %dl,0x7e(%eax)
80106d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106da2:	8a 50 7e             	mov    0x7e(%eax),%dl
80106da5:	83 ca 40             	or     $0x40,%edx
80106da8:	88 50 7e             	mov    %dl,0x7e(%eax)
80106dab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106dae:	8a 50 7e             	mov    0x7e(%eax),%dl
80106db1:	83 ca 80             	or     $0xffffff80,%edx
80106db4:	88 50 7e             	mov    %dl,0x7e(%eax)
80106db7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106dba:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106dbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106dc1:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80106dc8:	ff ff 
80106dca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106dcd:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80106dd4:	00 00 
80106dd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106dd9:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80106de0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106de3:	8a 90 85 00 00 00    	mov    0x85(%eax),%dl
80106de9:	83 e2 f0             	and    $0xfffffff0,%edx
80106dec:	83 ca 02             	or     $0x2,%edx
80106def:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80106df5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106df8:	8a 90 85 00 00 00    	mov    0x85(%eax),%dl
80106dfe:	83 ca 10             	or     $0x10,%edx
80106e01:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80106e07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e0a:	8a 90 85 00 00 00    	mov    0x85(%eax),%dl
80106e10:	83 e2 9f             	and    $0xffffff9f,%edx
80106e13:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80106e19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e1c:	8a 90 85 00 00 00    	mov    0x85(%eax),%dl
80106e22:	83 ca 80             	or     $0xffffff80,%edx
80106e25:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80106e2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e2e:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
80106e34:	83 ca 0f             	or     $0xf,%edx
80106e37:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80106e3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e40:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
80106e46:	83 e2 ef             	and    $0xffffffef,%edx
80106e49:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80106e4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e52:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
80106e58:	83 e2 df             	and    $0xffffffdf,%edx
80106e5b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80106e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e64:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
80106e6a:	83 ca 40             	or     $0x40,%edx
80106e6d:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80106e73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e76:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
80106e7c:	83 ca 80             	or     $0xffffff80,%edx
80106e7f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80106e85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e88:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e92:	66 c7 80 88 00 00 00 	movw   $0xffff,0x88(%eax)
80106e99:	ff ff 
80106e9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e9e:	66 c7 80 8a 00 00 00 	movw   $0x0,0x8a(%eax)
80106ea5:	00 00 
80106ea7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106eaa:	c6 80 8c 00 00 00 00 	movb   $0x0,0x8c(%eax)
80106eb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106eb4:	8a 90 8d 00 00 00    	mov    0x8d(%eax),%dl
80106eba:	83 e2 f0             	and    $0xfffffff0,%edx
80106ebd:	83 ca 0a             	or     $0xa,%edx
80106ec0:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80106ec6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ec9:	8a 90 8d 00 00 00    	mov    0x8d(%eax),%dl
80106ecf:	83 ca 10             	or     $0x10,%edx
80106ed2:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80106ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106edb:	8a 90 8d 00 00 00    	mov    0x8d(%eax),%dl
80106ee1:	83 ca 60             	or     $0x60,%edx
80106ee4:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80106eea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106eed:	8a 90 8d 00 00 00    	mov    0x8d(%eax),%dl
80106ef3:	83 ca 80             	or     $0xffffff80,%edx
80106ef6:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80106efc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106eff:	8a 90 8e 00 00 00    	mov    0x8e(%eax),%dl
80106f05:	83 ca 0f             	or     $0xf,%edx
80106f08:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80106f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f11:	8a 90 8e 00 00 00    	mov    0x8e(%eax),%dl
80106f17:	83 e2 ef             	and    $0xffffffef,%edx
80106f1a:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80106f20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f23:	8a 90 8e 00 00 00    	mov    0x8e(%eax),%dl
80106f29:	83 e2 df             	and    $0xffffffdf,%edx
80106f2c:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80106f32:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f35:	8a 90 8e 00 00 00    	mov    0x8e(%eax),%dl
80106f3b:	83 ca 40             	or     $0x40,%edx
80106f3e:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80106f44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f47:	8a 90 8e 00 00 00    	mov    0x8e(%eax),%dl
80106f4d:	83 ca 80             	or     $0xffffff80,%edx
80106f50:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80106f56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f59:	c6 80 8f 00 00 00 00 	movb   $0x0,0x8f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f63:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80106f6a:	ff ff 
80106f6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f6f:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80106f76:	00 00 
80106f78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f7b:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80106f82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f85:	8a 90 95 00 00 00    	mov    0x95(%eax),%dl
80106f8b:	83 e2 f0             	and    $0xfffffff0,%edx
80106f8e:	83 ca 02             	or     $0x2,%edx
80106f91:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80106f97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f9a:	8a 90 95 00 00 00    	mov    0x95(%eax),%dl
80106fa0:	83 ca 10             	or     $0x10,%edx
80106fa3:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80106fa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fac:	8a 90 95 00 00 00    	mov    0x95(%eax),%dl
80106fb2:	83 ca 60             	or     $0x60,%edx
80106fb5:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80106fbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fbe:	8a 90 95 00 00 00    	mov    0x95(%eax),%dl
80106fc4:	83 ca 80             	or     $0xffffff80,%edx
80106fc7:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80106fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fd0:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
80106fd6:	83 ca 0f             	or     $0xf,%edx
80106fd9:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80106fdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fe2:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
80106fe8:	83 e2 ef             	and    $0xffffffef,%edx
80106feb:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80106ff1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ff4:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
80106ffa:	83 e2 df             	and    $0xffffffdf,%edx
80106ffd:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107003:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107006:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
8010700c:	83 ca 40             	or     $0x40,%edx
8010700f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107015:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107018:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
8010701e:	83 ca 80             	or     $0xffffff80,%edx
80107021:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107027:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010702a:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80107031:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107034:	83 c0 70             	add    $0x70,%eax
80107037:	83 ec 08             	sub    $0x8,%esp
8010703a:	6a 30                	push   $0x30
8010703c:	50                   	push   %eax
8010703d:	e8 80 fc ff ff       	call   80106cc2 <lgdt>
80107042:	83 c4 10             	add    $0x10,%esp
}
80107045:	90                   	nop
80107046:	c9                   	leave  
80107047:	c3                   	ret    

80107048 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107048:	55                   	push   %ebp
80107049:	89 e5                	mov    %esp,%ebp
8010704b:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010704e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107051:	c1 e8 16             	shr    $0x16,%eax
80107054:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010705b:	8b 45 08             	mov    0x8(%ebp),%eax
8010705e:	01 d0                	add    %edx,%eax
80107060:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107063:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107066:	8b 00                	mov    (%eax),%eax
80107068:	83 e0 01             	and    $0x1,%eax
8010706b:	85 c0                	test   %eax,%eax
8010706d:	74 14                	je     80107083 <walkpgdir+0x3b>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010706f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107072:	8b 00                	mov    (%eax),%eax
80107074:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107079:	05 00 00 00 80       	add    $0x80000000,%eax
8010707e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107081:	eb 42                	jmp    801070c5 <walkpgdir+0x7d>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107083:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107087:	74 0e                	je     80107097 <walkpgdir+0x4f>
80107089:	e8 a6 b6 ff ff       	call   80102734 <kalloc>
8010708e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107091:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107095:	75 07                	jne    8010709e <walkpgdir+0x56>
      return 0;
80107097:	b8 00 00 00 00       	mov    $0x0,%eax
8010709c:	eb 3e                	jmp    801070dc <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010709e:	83 ec 04             	sub    $0x4,%esp
801070a1:	68 00 10 00 00       	push   $0x1000
801070a6:	6a 00                	push   $0x0
801070a8:	ff 75 f4             	pushl  -0xc(%ebp)
801070ab:	e8 55 d8 ff ff       	call   80104905 <memset>
801070b0:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801070b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801070b6:	05 00 00 00 80       	add    $0x80000000,%eax
801070bb:	83 c8 07             	or     $0x7,%eax
801070be:	89 c2                	mov    %eax,%edx
801070c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801070c3:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
801070c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801070c8:	c1 e8 0c             	shr    $0xc,%eax
801070cb:	25 ff 03 00 00       	and    $0x3ff,%eax
801070d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801070d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801070da:	01 d0                	add    %edx,%eax
}
801070dc:	c9                   	leave  
801070dd:	c3                   	ret    

801070de <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801070de:	55                   	push   %ebp
801070df:	89 e5                	mov    %esp,%ebp
801070e1:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801070e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801070e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801070ef:	8b 55 0c             	mov    0xc(%ebp),%edx
801070f2:	8b 45 10             	mov    0x10(%ebp),%eax
801070f5:	01 d0                	add    %edx,%eax
801070f7:	48                   	dec    %eax
801070f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107100:	83 ec 04             	sub    $0x4,%esp
80107103:	6a 01                	push   $0x1
80107105:	ff 75 f4             	pushl  -0xc(%ebp)
80107108:	ff 75 08             	pushl  0x8(%ebp)
8010710b:	e8 38 ff ff ff       	call   80107048 <walkpgdir>
80107110:	83 c4 10             	add    $0x10,%esp
80107113:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107116:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010711a:	75 07                	jne    80107123 <mappages+0x45>
      return -1;
8010711c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107121:	eb 47                	jmp    8010716a <mappages+0x8c>
    if(*pte & PTE_P)
80107123:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107126:	8b 00                	mov    (%eax),%eax
80107128:	83 e0 01             	and    $0x1,%eax
8010712b:	85 c0                	test   %eax,%eax
8010712d:	74 0d                	je     8010713c <mappages+0x5e>
      panic("remap");
8010712f:	83 ec 0c             	sub    $0xc,%esp
80107132:	68 a8 a3 10 80       	push   $0x8010a3a8
80107137:	e8 63 94 ff ff       	call   8010059f <panic>
    *pte = pa | perm | PTE_P;
8010713c:	8b 45 18             	mov    0x18(%ebp),%eax
8010713f:	0b 45 14             	or     0x14(%ebp),%eax
80107142:	83 c8 01             	or     $0x1,%eax
80107145:	89 c2                	mov    %eax,%edx
80107147:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010714a:	89 10                	mov    %edx,(%eax)
    if(a == last)
8010714c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010714f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107152:	74 10                	je     80107164 <mappages+0x86>
      break;
    a += PGSIZE;
80107154:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
8010715b:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107162:	eb 9c                	jmp    80107100 <mappages+0x22>
      break;
80107164:	90                   	nop
  }
  return 0;
80107165:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010716a:	c9                   	leave  
8010716b:	c3                   	ret    

8010716c <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
8010716c:	55                   	push   %ebp
8010716d:	89 e5                	mov    %esp,%ebp
8010716f:	57                   	push   %edi
80107170:	56                   	push   %esi
80107171:	53                   	push   %ebx
80107172:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *pgdir;
  struct kmap *k;
  k = kmap;
80107175:	c7 45 e4 80 e4 10 80 	movl   $0x8010e480,-0x1c(%ebp)
  struct kmap vram = { (void*)(DEVSPACE - gpu.vram_size),gpu.pvram_addr,gpu.pvram_addr+gpu.vram_size, PTE_W};
8010717c:	a1 50 5c 19 80       	mov    0x80195c50,%eax
80107181:	ba 00 00 00 fe       	mov    $0xfe000000,%edx
80107186:	29 c2                	sub    %eax,%edx
80107188:	89 d0                	mov    %edx,%eax
8010718a:	89 45 d0             	mov    %eax,-0x30(%ebp)
8010718d:	a1 48 5c 19 80       	mov    0x80195c48,%eax
80107192:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80107195:	8b 15 48 5c 19 80    	mov    0x80195c48,%edx
8010719b:	a1 50 5c 19 80       	mov    0x80195c50,%eax
801071a0:	01 d0                	add    %edx,%eax
801071a2:	89 45 d8             	mov    %eax,-0x28(%ebp)
801071a5:	c7 45 dc 02 00 00 00 	movl   $0x2,-0x24(%ebp)
  k[3] = vram;
801071ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071af:	83 c0 30             	add    $0x30,%eax
801071b2:	89 c3                	mov    %eax,%ebx
801071b4:	8d 45 d0             	lea    -0x30(%ebp),%eax
801071b7:	ba 04 00 00 00       	mov    $0x4,%edx
801071bc:	89 df                	mov    %ebx,%edi
801071be:	89 c6                	mov    %eax,%esi
801071c0:	89 d1                	mov    %edx,%ecx
801071c2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  if((pgdir = (pde_t*)kalloc()) == 0){
801071c4:	e8 6b b5 ff ff       	call   80102734 <kalloc>
801071c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801071cc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801071d0:	75 07                	jne    801071d9 <setupkvm+0x6d>
    return 0;
801071d2:	b8 00 00 00 00       	mov    $0x0,%eax
801071d7:	eb 78                	jmp    80107251 <setupkvm+0xe5>
  }
  memset(pgdir, 0, PGSIZE);
801071d9:	83 ec 04             	sub    $0x4,%esp
801071dc:	68 00 10 00 00       	push   $0x1000
801071e1:	6a 00                	push   $0x0
801071e3:	ff 75 e0             	pushl  -0x20(%ebp)
801071e6:	e8 1a d7 ff ff       	call   80104905 <memset>
801071eb:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801071ee:	c7 45 e4 80 e4 10 80 	movl   $0x8010e480,-0x1c(%ebp)
801071f5:	eb 4e                	jmp    80107245 <setupkvm+0xd9>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801071f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071fa:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0) {
801071fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107200:	8b 50 04             	mov    0x4(%eax),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107203:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107206:	8b 58 08             	mov    0x8(%eax),%ebx
80107209:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010720c:	8b 40 04             	mov    0x4(%eax),%eax
8010720f:	29 c3                	sub    %eax,%ebx
80107211:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107214:	8b 00                	mov    (%eax),%eax
80107216:	83 ec 0c             	sub    $0xc,%esp
80107219:	51                   	push   %ecx
8010721a:	52                   	push   %edx
8010721b:	53                   	push   %ebx
8010721c:	50                   	push   %eax
8010721d:	ff 75 e0             	pushl  -0x20(%ebp)
80107220:	e8 b9 fe ff ff       	call   801070de <mappages>
80107225:	83 c4 20             	add    $0x20,%esp
80107228:	85 c0                	test   %eax,%eax
8010722a:	79 15                	jns    80107241 <setupkvm+0xd5>
      freevm(pgdir);
8010722c:	83 ec 0c             	sub    $0xc,%esp
8010722f:	ff 75 e0             	pushl  -0x20(%ebp)
80107232:	e8 e8 04 00 00       	call   8010771f <freevm>
80107237:	83 c4 10             	add    $0x10,%esp
      return 0;
8010723a:	b8 00 00 00 00       	mov    $0x0,%eax
8010723f:	eb 10                	jmp    80107251 <setupkvm+0xe5>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107241:	83 45 e4 10          	addl   $0x10,-0x1c(%ebp)
80107245:	81 7d e4 e0 e4 10 80 	cmpl   $0x8010e4e0,-0x1c(%ebp)
8010724c:	72 a9                	jb     801071f7 <setupkvm+0x8b>
    }
  return pgdir;
8010724e:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80107251:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107254:	5b                   	pop    %ebx
80107255:	5e                   	pop    %esi
80107256:	5f                   	pop    %edi
80107257:	5d                   	pop    %ebp
80107258:	c3                   	ret    

80107259 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107259:	55                   	push   %ebp
8010725a:	89 e5                	mov    %esp,%ebp
8010725c:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
8010725f:	e8 08 ff ff ff       	call   8010716c <setupkvm>
80107264:	a3 7c 59 19 80       	mov    %eax,0x8019597c
  switchkvm();
80107269:	e8 03 00 00 00       	call   80107271 <switchkvm>
}
8010726e:	90                   	nop
8010726f:	c9                   	leave  
80107270:	c3                   	ret    

80107271 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107271:	55                   	push   %ebp
80107272:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107274:	a1 7c 59 19 80       	mov    0x8019597c,%eax
80107279:	05 00 00 00 80       	add    $0x80000000,%eax
8010727e:	50                   	push   %eax
8010727f:	e8 7c fa ff ff       	call   80106d00 <lcr3>
80107284:	83 c4 04             	add    $0x4,%esp
}
80107287:	90                   	nop
80107288:	c9                   	leave  
80107289:	c3                   	ret    

8010728a <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
8010728a:	55                   	push   %ebp
8010728b:	89 e5                	mov    %esp,%ebp
8010728d:	56                   	push   %esi
8010728e:	53                   	push   %ebx
8010728f:	83 ec 10             	sub    $0x10,%esp
  if(p == 0)
80107292:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80107296:	75 0d                	jne    801072a5 <switchuvm+0x1b>
    panic("switchuvm: no process");
80107298:	83 ec 0c             	sub    $0xc,%esp
8010729b:	68 ae a3 10 80       	push   $0x8010a3ae
801072a0:	e8 fa 92 ff ff       	call   8010059f <panic>
  if(p->kstack == 0)
801072a5:	8b 45 08             	mov    0x8(%ebp),%eax
801072a8:	8b 40 08             	mov    0x8(%eax),%eax
801072ab:	85 c0                	test   %eax,%eax
801072ad:	75 0d                	jne    801072bc <switchuvm+0x32>
    panic("switchuvm: no kstack");
801072af:	83 ec 0c             	sub    $0xc,%esp
801072b2:	68 c4 a3 10 80       	push   $0x8010a3c4
801072b7:	e8 e3 92 ff ff       	call   8010059f <panic>
  if(p->pgdir == 0)
801072bc:	8b 45 08             	mov    0x8(%ebp),%eax
801072bf:	8b 40 04             	mov    0x4(%eax),%eax
801072c2:	85 c0                	test   %eax,%eax
801072c4:	75 0d                	jne    801072d3 <switchuvm+0x49>
    panic("switchuvm: no pgdir");
801072c6:	83 ec 0c             	sub    $0xc,%esp
801072c9:	68 d9 a3 10 80       	push   $0x8010a3d9
801072ce:	e8 cc 92 ff ff       	call   8010059f <panic>

  pushcli();
801072d3:	e8 26 d5 ff ff       	call   801047fe <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801072d8:	e8 73 c6 ff ff       	call   80103950 <mycpu>
801072dd:	89 c3                	mov    %eax,%ebx
801072df:	e8 6c c6 ff ff       	call   80103950 <mycpu>
801072e4:	83 c0 08             	add    $0x8,%eax
801072e7:	89 c6                	mov    %eax,%esi
801072e9:	e8 62 c6 ff ff       	call   80103950 <mycpu>
801072ee:	83 c0 08             	add    $0x8,%eax
801072f1:	c1 e8 10             	shr    $0x10,%eax
801072f4:	88 45 f7             	mov    %al,-0x9(%ebp)
801072f7:	e8 54 c6 ff ff       	call   80103950 <mycpu>
801072fc:	83 c0 08             	add    $0x8,%eax
801072ff:	c1 e8 18             	shr    $0x18,%eax
80107302:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80107309:	67 00 
8010730b:	66 89 b3 9a 00 00 00 	mov    %si,0x9a(%ebx)
80107312:	8a 4d f7             	mov    -0x9(%ebp),%cl
80107315:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
8010731b:	8a 93 9d 00 00 00    	mov    0x9d(%ebx),%dl
80107321:	83 e2 f0             	and    $0xfffffff0,%edx
80107324:	83 ca 09             	or     $0x9,%edx
80107327:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
8010732d:	8a 93 9d 00 00 00    	mov    0x9d(%ebx),%dl
80107333:	83 ca 10             	or     $0x10,%edx
80107336:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
8010733c:	8a 93 9d 00 00 00    	mov    0x9d(%ebx),%dl
80107342:	83 e2 9f             	and    $0xffffff9f,%edx
80107345:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
8010734b:	8a 93 9d 00 00 00    	mov    0x9d(%ebx),%dl
80107351:	83 ca 80             	or     $0xffffff80,%edx
80107354:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
8010735a:	8a 93 9e 00 00 00    	mov    0x9e(%ebx),%dl
80107360:	83 e2 f0             	and    $0xfffffff0,%edx
80107363:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
80107369:	8a 93 9e 00 00 00    	mov    0x9e(%ebx),%dl
8010736f:	83 e2 ef             	and    $0xffffffef,%edx
80107372:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
80107378:	8a 93 9e 00 00 00    	mov    0x9e(%ebx),%dl
8010737e:	83 e2 df             	and    $0xffffffdf,%edx
80107381:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
80107387:	8a 93 9e 00 00 00    	mov    0x9e(%ebx),%dl
8010738d:	83 ca 40             	or     $0x40,%edx
80107390:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
80107396:	8a 93 9e 00 00 00    	mov    0x9e(%ebx),%dl
8010739c:	83 e2 7f             	and    $0x7f,%edx
8010739f:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
801073a5:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
801073ab:	e8 a0 c5 ff ff       	call   80103950 <mycpu>
801073b0:	8a 90 9d 00 00 00    	mov    0x9d(%eax),%dl
801073b6:	83 e2 ef             	and    $0xffffffef,%edx
801073b9:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801073bf:	e8 8c c5 ff ff       	call   80103950 <mycpu>
801073c4:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801073ca:	8b 45 08             	mov    0x8(%ebp),%eax
801073cd:	8b 40 08             	mov    0x8(%eax),%eax
801073d0:	89 c3                	mov    %eax,%ebx
801073d2:	e8 79 c5 ff ff       	call   80103950 <mycpu>
801073d7:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
801073dd:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801073e0:	e8 6b c5 ff ff       	call   80103950 <mycpu>
801073e5:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  ltr(SEG_TSS << 3);
801073eb:	83 ec 0c             	sub    $0xc,%esp
801073ee:	6a 28                	push   $0x28
801073f0:	e8 f5 f8 ff ff       	call   80106cea <ltr>
801073f5:	83 c4 10             	add    $0x10,%esp
  lcr3(V2P(p->pgdir));  // switch to process's address space
801073f8:	8b 45 08             	mov    0x8(%ebp),%eax
801073fb:	8b 40 04             	mov    0x4(%eax),%eax
801073fe:	05 00 00 00 80       	add    $0x80000000,%eax
80107403:	83 ec 0c             	sub    $0xc,%esp
80107406:	50                   	push   %eax
80107407:	e8 f4 f8 ff ff       	call   80106d00 <lcr3>
8010740c:	83 c4 10             	add    $0x10,%esp
  popcli();
8010740f:	e8 35 d4 ff ff       	call   80104849 <popcli>
}
80107414:	90                   	nop
80107415:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107418:	5b                   	pop    %ebx
80107419:	5e                   	pop    %esi
8010741a:	5d                   	pop    %ebp
8010741b:	c3                   	ret    

8010741c <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010741c:	55                   	push   %ebp
8010741d:	89 e5                	mov    %esp,%ebp
8010741f:	83 ec 18             	sub    $0x18,%esp
  char *mem;

  if(sz >= PGSIZE)
80107422:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107429:	76 0d                	jbe    80107438 <inituvm+0x1c>
    panic("inituvm: more than a page");
8010742b:	83 ec 0c             	sub    $0xc,%esp
8010742e:	68 ed a3 10 80       	push   $0x8010a3ed
80107433:	e8 67 91 ff ff       	call   8010059f <panic>
  mem = kalloc();
80107438:	e8 f7 b2 ff ff       	call   80102734 <kalloc>
8010743d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107440:	83 ec 04             	sub    $0x4,%esp
80107443:	68 00 10 00 00       	push   $0x1000
80107448:	6a 00                	push   $0x0
8010744a:	ff 75 f4             	pushl  -0xc(%ebp)
8010744d:	e8 b3 d4 ff ff       	call   80104905 <memset>
80107452:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107455:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107458:	05 00 00 00 80       	add    $0x80000000,%eax
8010745d:	83 ec 0c             	sub    $0xc,%esp
80107460:	6a 06                	push   $0x6
80107462:	50                   	push   %eax
80107463:	68 00 10 00 00       	push   $0x1000
80107468:	6a 00                	push   $0x0
8010746a:	ff 75 08             	pushl  0x8(%ebp)
8010746d:	e8 6c fc ff ff       	call   801070de <mappages>
80107472:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107475:	83 ec 04             	sub    $0x4,%esp
80107478:	ff 75 10             	pushl  0x10(%ebp)
8010747b:	ff 75 0c             	pushl  0xc(%ebp)
8010747e:	ff 75 f4             	pushl  -0xc(%ebp)
80107481:	e8 38 d5 ff ff       	call   801049be <memmove>
80107486:	83 c4 10             	add    $0x10,%esp
}
80107489:	90                   	nop
8010748a:	c9                   	leave  
8010748b:	c3                   	ret    

8010748c <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
8010748c:	55                   	push   %ebp
8010748d:	89 e5                	mov    %esp,%ebp
8010748f:	83 ec 18             	sub    $0x18,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107492:	8b 45 0c             	mov    0xc(%ebp),%eax
80107495:	25 ff 0f 00 00       	and    $0xfff,%eax
8010749a:	85 c0                	test   %eax,%eax
8010749c:	74 0d                	je     801074ab <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
8010749e:	83 ec 0c             	sub    $0xc,%esp
801074a1:	68 08 a4 10 80       	push   $0x8010a408
801074a6:	e8 f4 90 ff ff       	call   8010059f <panic>
  for(i = 0; i < sz; i += PGSIZE){
801074ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801074b2:	e9 8e 00 00 00       	jmp    80107545 <loaduvm+0xb9>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801074b7:	8b 55 0c             	mov    0xc(%ebp),%edx
801074ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074bd:	01 d0                	add    %edx,%eax
801074bf:	83 ec 04             	sub    $0x4,%esp
801074c2:	6a 00                	push   $0x0
801074c4:	50                   	push   %eax
801074c5:	ff 75 08             	pushl  0x8(%ebp)
801074c8:	e8 7b fb ff ff       	call   80107048 <walkpgdir>
801074cd:	83 c4 10             	add    $0x10,%esp
801074d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
801074d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801074d7:	75 0d                	jne    801074e6 <loaduvm+0x5a>
      panic("loaduvm: address should exist");
801074d9:	83 ec 0c             	sub    $0xc,%esp
801074dc:	68 2b a4 10 80       	push   $0x8010a42b
801074e1:	e8 b9 90 ff ff       	call   8010059f <panic>
    pa = PTE_ADDR(*pte);
801074e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801074e9:	8b 00                	mov    (%eax),%eax
801074eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801074f0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
801074f3:	8b 45 18             	mov    0x18(%ebp),%eax
801074f6:	2b 45 f4             	sub    -0xc(%ebp),%eax
801074f9:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801074fe:	77 0b                	ja     8010750b <loaduvm+0x7f>
      n = sz - i;
80107500:	8b 45 18             	mov    0x18(%ebp),%eax
80107503:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107506:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107509:	eb 07                	jmp    80107512 <loaduvm+0x86>
    else
      n = PGSIZE;
8010750b:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107512:	8b 55 14             	mov    0x14(%ebp),%edx
80107515:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107518:	01 c2                	add    %eax,%edx
8010751a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010751d:	05 00 00 00 80       	add    $0x80000000,%eax
80107522:	ff 75 f0             	pushl  -0x10(%ebp)
80107525:	52                   	push   %edx
80107526:	50                   	push   %eax
80107527:	ff 75 10             	pushl  0x10(%ebp)
8010752a:	e8 45 a9 ff ff       	call   80101e74 <readi>
8010752f:	83 c4 10             	add    $0x10,%esp
80107532:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80107535:	74 07                	je     8010753e <loaduvm+0xb2>
      return -1;
80107537:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010753c:	eb 18                	jmp    80107556 <loaduvm+0xca>
  for(i = 0; i < sz; i += PGSIZE){
8010753e:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107545:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107548:	3b 45 18             	cmp    0x18(%ebp),%eax
8010754b:	0f 82 66 ff ff ff    	jb     801074b7 <loaduvm+0x2b>
  }
  return 0;
80107551:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107556:	c9                   	leave  
80107557:	c3                   	ret    

80107558 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107558:	55                   	push   %ebp
80107559:	89 e5                	mov    %esp,%ebp
8010755b:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010755e:	8b 45 10             	mov    0x10(%ebp),%eax
80107561:	85 c0                	test   %eax,%eax
80107563:	79 0a                	jns    8010756f <allocuvm+0x17>
    return 0;
80107565:	b8 00 00 00 00       	mov    $0x0,%eax
8010756a:	e9 ec 00 00 00       	jmp    8010765b <allocuvm+0x103>
  if(newsz < oldsz)
8010756f:	8b 45 10             	mov    0x10(%ebp),%eax
80107572:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107575:	73 08                	jae    8010757f <allocuvm+0x27>
    return oldsz;
80107577:	8b 45 0c             	mov    0xc(%ebp),%eax
8010757a:	e9 dc 00 00 00       	jmp    8010765b <allocuvm+0x103>

  a = PGROUNDUP(oldsz);
8010757f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107582:	05 ff 0f 00 00       	add    $0xfff,%eax
80107587:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010758c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010758f:	e9 b8 00 00 00       	jmp    8010764c <allocuvm+0xf4>
    mem = kalloc();
80107594:	e8 9b b1 ff ff       	call   80102734 <kalloc>
80107599:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
8010759c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801075a0:	75 2e                	jne    801075d0 <allocuvm+0x78>
      cprintf("allocuvm out of memory\n");
801075a2:	83 ec 0c             	sub    $0xc,%esp
801075a5:	68 49 a4 10 80       	push   $0x8010a449
801075aa:	e8 42 8e ff ff       	call   801003f1 <cprintf>
801075af:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
801075b2:	83 ec 04             	sub    $0x4,%esp
801075b5:	ff 75 0c             	pushl  0xc(%ebp)
801075b8:	ff 75 10             	pushl  0x10(%ebp)
801075bb:	ff 75 08             	pushl  0x8(%ebp)
801075be:	e8 9a 00 00 00       	call   8010765d <deallocuvm>
801075c3:	83 c4 10             	add    $0x10,%esp
      return 0;
801075c6:	b8 00 00 00 00       	mov    $0x0,%eax
801075cb:	e9 8b 00 00 00       	jmp    8010765b <allocuvm+0x103>
    }
    memset(mem, 0, PGSIZE);
801075d0:	83 ec 04             	sub    $0x4,%esp
801075d3:	68 00 10 00 00       	push   $0x1000
801075d8:	6a 00                	push   $0x0
801075da:	ff 75 f0             	pushl  -0x10(%ebp)
801075dd:	e8 23 d3 ff ff       	call   80104905 <memset>
801075e2:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801075e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801075e8:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801075ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075f1:	83 ec 0c             	sub    $0xc,%esp
801075f4:	6a 06                	push   $0x6
801075f6:	52                   	push   %edx
801075f7:	68 00 10 00 00       	push   $0x1000
801075fc:	50                   	push   %eax
801075fd:	ff 75 08             	pushl  0x8(%ebp)
80107600:	e8 d9 fa ff ff       	call   801070de <mappages>
80107605:	83 c4 20             	add    $0x20,%esp
80107608:	85 c0                	test   %eax,%eax
8010760a:	79 39                	jns    80107645 <allocuvm+0xed>
      cprintf("allocuvm out of memory (2)\n");
8010760c:	83 ec 0c             	sub    $0xc,%esp
8010760f:	68 61 a4 10 80       	push   $0x8010a461
80107614:	e8 d8 8d ff ff       	call   801003f1 <cprintf>
80107619:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
8010761c:	83 ec 04             	sub    $0x4,%esp
8010761f:	ff 75 0c             	pushl  0xc(%ebp)
80107622:	ff 75 10             	pushl  0x10(%ebp)
80107625:	ff 75 08             	pushl  0x8(%ebp)
80107628:	e8 30 00 00 00       	call   8010765d <deallocuvm>
8010762d:	83 c4 10             	add    $0x10,%esp
      kfree(mem);
80107630:	83 ec 0c             	sub    $0xc,%esp
80107633:	ff 75 f0             	pushl  -0x10(%ebp)
80107636:	e8 5f b0 ff ff       	call   8010269a <kfree>
8010763b:	83 c4 10             	add    $0x10,%esp
      return 0;
8010763e:	b8 00 00 00 00       	mov    $0x0,%eax
80107643:	eb 16                	jmp    8010765b <allocuvm+0x103>
  for(; a < newsz; a += PGSIZE){
80107645:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010764c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010764f:	3b 45 10             	cmp    0x10(%ebp),%eax
80107652:	0f 82 3c ff ff ff    	jb     80107594 <allocuvm+0x3c>
    }
  }
  return newsz;
80107658:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010765b:	c9                   	leave  
8010765c:	c3                   	ret    

8010765d <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010765d:	55                   	push   %ebp
8010765e:	89 e5                	mov    %esp,%ebp
80107660:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107663:	8b 45 10             	mov    0x10(%ebp),%eax
80107666:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107669:	72 08                	jb     80107673 <deallocuvm+0x16>
    return oldsz;
8010766b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010766e:	e9 aa 00 00 00       	jmp    8010771d <deallocuvm+0xc0>

  a = PGROUNDUP(newsz);
80107673:	8b 45 10             	mov    0x10(%ebp),%eax
80107676:	05 ff 0f 00 00       	add    $0xfff,%eax
8010767b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107680:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107683:	e9 86 00 00 00       	jmp    8010770e <deallocuvm+0xb1>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107688:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010768b:	83 ec 04             	sub    $0x4,%esp
8010768e:	6a 00                	push   $0x0
80107690:	50                   	push   %eax
80107691:	ff 75 08             	pushl  0x8(%ebp)
80107694:	e8 af f9 ff ff       	call   80107048 <walkpgdir>
80107699:	83 c4 10             	add    $0x10,%esp
8010769c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
8010769f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801076a3:	75 14                	jne    801076b9 <deallocuvm+0x5c>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801076a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a8:	c1 e8 16             	shr    $0x16,%eax
801076ab:	40                   	inc    %eax
801076ac:	c1 e0 16             	shl    $0x16,%eax
801076af:	2d 00 10 00 00       	sub    $0x1000,%eax
801076b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801076b7:	eb 4e                	jmp    80107707 <deallocuvm+0xaa>
    else if((*pte & PTE_P) != 0){
801076b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801076bc:	8b 00                	mov    (%eax),%eax
801076be:	83 e0 01             	and    $0x1,%eax
801076c1:	85 c0                	test   %eax,%eax
801076c3:	74 42                	je     80107707 <deallocuvm+0xaa>
      pa = PTE_ADDR(*pte);
801076c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801076c8:	8b 00                	mov    (%eax),%eax
801076ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801076cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801076d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801076d6:	75 0d                	jne    801076e5 <deallocuvm+0x88>
        panic("kfree");
801076d8:	83 ec 0c             	sub    $0xc,%esp
801076db:	68 7d a4 10 80       	push   $0x8010a47d
801076e0:	e8 ba 8e ff ff       	call   8010059f <panic>
      char *v = P2V(pa);
801076e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801076e8:	05 00 00 00 80       	add    $0x80000000,%eax
801076ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801076f0:	83 ec 0c             	sub    $0xc,%esp
801076f3:	ff 75 e8             	pushl  -0x18(%ebp)
801076f6:	e8 9f af ff ff       	call   8010269a <kfree>
801076fb:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801076fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107701:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107707:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010770e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107711:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107714:	0f 82 6e ff ff ff    	jb     80107688 <deallocuvm+0x2b>
    }
  }
  return newsz;
8010771a:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010771d:	c9                   	leave  
8010771e:	c3                   	ret    

8010771f <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
8010771f:	55                   	push   %ebp
80107720:	89 e5                	mov    %esp,%ebp
80107722:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80107725:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80107729:	75 0d                	jne    80107738 <freevm+0x19>
    panic("freevm: no pgdir");
8010772b:	83 ec 0c             	sub    $0xc,%esp
8010772e:	68 83 a4 10 80       	push   $0x8010a483
80107733:	e8 67 8e ff ff       	call   8010059f <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80107738:	83 ec 04             	sub    $0x4,%esp
8010773b:	6a 00                	push   $0x0
8010773d:	68 00 00 00 80       	push   $0x80000000
80107742:	ff 75 08             	pushl  0x8(%ebp)
80107745:	e8 13 ff ff ff       	call   8010765d <deallocuvm>
8010774a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010774d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107754:	eb 47                	jmp    8010779d <freevm+0x7e>
    if(pgdir[i] & PTE_P){
80107756:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107759:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107760:	8b 45 08             	mov    0x8(%ebp),%eax
80107763:	01 d0                	add    %edx,%eax
80107765:	8b 00                	mov    (%eax),%eax
80107767:	83 e0 01             	and    $0x1,%eax
8010776a:	85 c0                	test   %eax,%eax
8010776c:	74 2c                	je     8010779a <freevm+0x7b>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010776e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107771:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107778:	8b 45 08             	mov    0x8(%ebp),%eax
8010777b:	01 d0                	add    %edx,%eax
8010777d:	8b 00                	mov    (%eax),%eax
8010777f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107784:	05 00 00 00 80       	add    $0x80000000,%eax
80107789:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
8010778c:	83 ec 0c             	sub    $0xc,%esp
8010778f:	ff 75 f0             	pushl  -0x10(%ebp)
80107792:	e8 03 af ff ff       	call   8010269a <kfree>
80107797:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010779a:	ff 45 f4             	incl   -0xc(%ebp)
8010779d:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801077a4:	76 b0                	jbe    80107756 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801077a6:	83 ec 0c             	sub    $0xc,%esp
801077a9:	ff 75 08             	pushl  0x8(%ebp)
801077ac:	e8 e9 ae ff ff       	call   8010269a <kfree>
801077b1:	83 c4 10             	add    $0x10,%esp
}
801077b4:	90                   	nop
801077b5:	c9                   	leave  
801077b6:	c3                   	ret    

801077b7 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801077b7:	55                   	push   %ebp
801077b8:	89 e5                	mov    %esp,%ebp
801077ba:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801077bd:	83 ec 04             	sub    $0x4,%esp
801077c0:	6a 00                	push   $0x0
801077c2:	ff 75 0c             	pushl  0xc(%ebp)
801077c5:	ff 75 08             	pushl  0x8(%ebp)
801077c8:	e8 7b f8 ff ff       	call   80107048 <walkpgdir>
801077cd:	83 c4 10             	add    $0x10,%esp
801077d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801077d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801077d7:	75 0d                	jne    801077e6 <clearpteu+0x2f>
    panic("clearpteu");
801077d9:	83 ec 0c             	sub    $0xc,%esp
801077dc:	68 94 a4 10 80       	push   $0x8010a494
801077e1:	e8 b9 8d ff ff       	call   8010059f <panic>
  *pte &= ~PTE_U;
801077e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077e9:	8b 00                	mov    (%eax),%eax
801077eb:	83 e0 fb             	and    $0xfffffffb,%eax
801077ee:	89 c2                	mov    %eax,%edx
801077f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f3:	89 10                	mov    %edx,(%eax)
}
801077f5:	90                   	nop
801077f6:	c9                   	leave  
801077f7:	c3                   	ret    

801077f8 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801077f8:	55                   	push   %ebp
801077f9:	89 e5                	mov    %esp,%ebp
801077fb:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801077fe:	e8 69 f9 ff ff       	call   8010716c <setupkvm>
80107803:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107806:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010780a:	75 0a                	jne    80107816 <copyuvm+0x1e>
    return 0;
8010780c:	b8 00 00 00 00       	mov    $0x0,%eax
80107811:	e9 eb 00 00 00       	jmp    80107901 <copyuvm+0x109>
  for(i = 0; i < sz; i += PGSIZE){
80107816:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010781d:	e9 b7 00 00 00       	jmp    801078d9 <copyuvm+0xe1>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107822:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107825:	83 ec 04             	sub    $0x4,%esp
80107828:	6a 00                	push   $0x0
8010782a:	50                   	push   %eax
8010782b:	ff 75 08             	pushl  0x8(%ebp)
8010782e:	e8 15 f8 ff ff       	call   80107048 <walkpgdir>
80107833:	83 c4 10             	add    $0x10,%esp
80107836:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107839:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010783d:	75 0d                	jne    8010784c <copyuvm+0x54>
      panic("copyuvm: pte should exist");
8010783f:	83 ec 0c             	sub    $0xc,%esp
80107842:	68 9e a4 10 80       	push   $0x8010a49e
80107847:	e8 53 8d ff ff       	call   8010059f <panic>
    if(!(*pte & PTE_P))
8010784c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010784f:	8b 00                	mov    (%eax),%eax
80107851:	83 e0 01             	and    $0x1,%eax
80107854:	85 c0                	test   %eax,%eax
80107856:	75 0d                	jne    80107865 <copyuvm+0x6d>
      panic("copyuvm: page not present");
80107858:	83 ec 0c             	sub    $0xc,%esp
8010785b:	68 b8 a4 10 80       	push   $0x8010a4b8
80107860:	e8 3a 8d ff ff       	call   8010059f <panic>
    pa = PTE_ADDR(*pte);
80107865:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107868:	8b 00                	mov    (%eax),%eax
8010786a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010786f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80107872:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107875:	8b 00                	mov    (%eax),%eax
80107877:	25 ff 0f 00 00       	and    $0xfff,%eax
8010787c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010787f:	e8 b0 ae ff ff       	call   80102734 <kalloc>
80107884:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107887:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010788b:	74 5d                	je     801078ea <copyuvm+0xf2>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
8010788d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107890:	05 00 00 00 80       	add    $0x80000000,%eax
80107895:	83 ec 04             	sub    $0x4,%esp
80107898:	68 00 10 00 00       	push   $0x1000
8010789d:	50                   	push   %eax
8010789e:	ff 75 e0             	pushl  -0x20(%ebp)
801078a1:	e8 18 d1 ff ff       	call   801049be <memmove>
801078a6:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801078a9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801078ac:	8b 45 e0             	mov    -0x20(%ebp),%eax
801078af:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801078b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b8:	83 ec 0c             	sub    $0xc,%esp
801078bb:	52                   	push   %edx
801078bc:	51                   	push   %ecx
801078bd:	68 00 10 00 00       	push   $0x1000
801078c2:	50                   	push   %eax
801078c3:	ff 75 f0             	pushl  -0x10(%ebp)
801078c6:	e8 13 f8 ff ff       	call   801070de <mappages>
801078cb:	83 c4 20             	add    $0x20,%esp
801078ce:	85 c0                	test   %eax,%eax
801078d0:	78 1b                	js     801078ed <copyuvm+0xf5>
  for(i = 0; i < sz; i += PGSIZE){
801078d2:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801078d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078dc:	3b 45 0c             	cmp    0xc(%ebp),%eax
801078df:	0f 82 3d ff ff ff    	jb     80107822 <copyuvm+0x2a>
      goto bad;
  }
  return d;
801078e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801078e8:	eb 17                	jmp    80107901 <copyuvm+0x109>
      goto bad;
801078ea:	90                   	nop
801078eb:	eb 01                	jmp    801078ee <copyuvm+0xf6>
      goto bad;
801078ed:	90                   	nop

bad:
  freevm(d);
801078ee:	83 ec 0c             	sub    $0xc,%esp
801078f1:	ff 75 f0             	pushl  -0x10(%ebp)
801078f4:	e8 26 fe ff ff       	call   8010771f <freevm>
801078f9:	83 c4 10             	add    $0x10,%esp
  return 0;
801078fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107901:	c9                   	leave  
80107902:	c3                   	ret    

80107903 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107903:	55                   	push   %ebp
80107904:	89 e5                	mov    %esp,%ebp
80107906:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107909:	83 ec 04             	sub    $0x4,%esp
8010790c:	6a 00                	push   $0x0
8010790e:	ff 75 0c             	pushl  0xc(%ebp)
80107911:	ff 75 08             	pushl  0x8(%ebp)
80107914:	e8 2f f7 ff ff       	call   80107048 <walkpgdir>
80107919:	83 c4 10             	add    $0x10,%esp
8010791c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
8010791f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107922:	8b 00                	mov    (%eax),%eax
80107924:	83 e0 01             	and    $0x1,%eax
80107927:	85 c0                	test   %eax,%eax
80107929:	75 07                	jne    80107932 <uva2ka+0x2f>
    return 0;
8010792b:	b8 00 00 00 00       	mov    $0x0,%eax
80107930:	eb 22                	jmp    80107954 <uva2ka+0x51>
  if((*pte & PTE_U) == 0)
80107932:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107935:	8b 00                	mov    (%eax),%eax
80107937:	83 e0 04             	and    $0x4,%eax
8010793a:	85 c0                	test   %eax,%eax
8010793c:	75 07                	jne    80107945 <uva2ka+0x42>
    return 0;
8010793e:	b8 00 00 00 00       	mov    $0x0,%eax
80107943:	eb 0f                	jmp    80107954 <uva2ka+0x51>
  return (char*)P2V(PTE_ADDR(*pte));
80107945:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107948:	8b 00                	mov    (%eax),%eax
8010794a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010794f:	05 00 00 00 80       	add    $0x80000000,%eax
}
80107954:	c9                   	leave  
80107955:	c3                   	ret    

80107956 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107956:	55                   	push   %ebp
80107957:	89 e5                	mov    %esp,%ebp
80107959:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010795c:	8b 45 10             	mov    0x10(%ebp),%eax
8010795f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80107962:	eb 7f                	jmp    801079e3 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
80107964:	8b 45 0c             	mov    0xc(%ebp),%eax
80107967:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010796c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010796f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107972:	83 ec 08             	sub    $0x8,%esp
80107975:	50                   	push   %eax
80107976:	ff 75 08             	pushl  0x8(%ebp)
80107979:	e8 85 ff ff ff       	call   80107903 <uva2ka>
8010797e:	83 c4 10             	add    $0x10,%esp
80107981:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80107984:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80107988:	75 07                	jne    80107991 <copyout+0x3b>
      return -1;
8010798a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010798f:	eb 61                	jmp    801079f2 <copyout+0x9c>
    n = PGSIZE - (va - va0);
80107991:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107994:	2b 45 0c             	sub    0xc(%ebp),%eax
80107997:	05 00 10 00 00       	add    $0x1000,%eax
8010799c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010799f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801079a2:	39 45 14             	cmp    %eax,0x14(%ebp)
801079a5:	73 06                	jae    801079ad <copyout+0x57>
      n = len;
801079a7:	8b 45 14             	mov    0x14(%ebp),%eax
801079aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801079ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801079b0:	2b 45 ec             	sub    -0x14(%ebp),%eax
801079b3:	89 c2                	mov    %eax,%edx
801079b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801079b8:	01 d0                	add    %edx,%eax
801079ba:	83 ec 04             	sub    $0x4,%esp
801079bd:	ff 75 f0             	pushl  -0x10(%ebp)
801079c0:	ff 75 f4             	pushl  -0xc(%ebp)
801079c3:	50                   	push   %eax
801079c4:	e8 f5 cf ff ff       	call   801049be <memmove>
801079c9:	83 c4 10             	add    $0x10,%esp
    len -= n;
801079cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801079cf:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
801079d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801079d5:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
801079d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801079db:	05 00 10 00 00       	add    $0x1000,%eax
801079e0:	89 45 0c             	mov    %eax,0xc(%ebp)
  while(len > 0){
801079e3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801079e7:	0f 85 77 ff ff ff    	jne    80107964 <copyout+0xe>
  }
  return 0;
801079ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
801079f2:	c9                   	leave  
801079f3:	c3                   	ret    

801079f4 <mpinit_uefi>:

struct cpu cpus[NCPU];
int ncpu;
uchar ioapicid;
void mpinit_uefi(void)
{
801079f4:	55                   	push   %ebp
801079f5:	89 e5                	mov    %esp,%ebp
801079f7:	83 ec 20             	sub    $0x20,%esp
  struct boot_param *boot_param = (struct boot_param *)P2V_WO(BOOTPARAM);
801079fa:	c7 45 f8 00 00 05 80 	movl   $0x80050000,-0x8(%ebp)
  struct uefi_madt *madt = (struct uefi_madt*)(P2V_WO(boot_param->madt_addr));
80107a01:	8b 45 f8             	mov    -0x8(%ebp),%eax
80107a04:	8b 40 08             	mov    0x8(%eax),%eax
80107a07:	05 00 00 00 80       	add    $0x80000000,%eax
80107a0c:	89 45 f4             	mov    %eax,-0xc(%ebp)

  uint i=sizeof(struct uefi_madt);
80107a0f:	c7 45 fc 2c 00 00 00 	movl   $0x2c,-0x4(%ebp)
  struct uefi_lapic *lapic_entry;
  struct uefi_ioapic *ioapic;
  struct uefi_iso *iso;
  struct uefi_non_maskable_intr *non_mask_intr; 
  
  lapic = (uint *)(madt->lapic_addr);
80107a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a19:	8b 40 24             	mov    0x24(%eax),%eax
80107a1c:	a3 00 31 19 80       	mov    %eax,0x80193100
  ncpu = 0;
80107a21:	c7 05 40 5c 19 80 00 	movl   $0x0,0x80195c40
80107a28:	00 00 00 

  while(i<madt->len){
80107a2b:	e9 bb 00 00 00       	jmp    80107aeb <mpinit_uefi+0xf7>
    uchar *entry_type = ((uchar *)madt)+i;
80107a30:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107a33:	8b 45 fc             	mov    -0x4(%ebp),%eax
80107a36:	01 d0                	add    %edx,%eax
80107a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
    switch(*entry_type){
80107a3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a3e:	8a 00                	mov    (%eax),%al
80107a40:	0f b6 c0             	movzbl %al,%eax
80107a43:	83 f8 05             	cmp    $0x5,%eax
80107a46:	0f 87 9f 00 00 00    	ja     80107aeb <mpinit_uefi+0xf7>
80107a4c:	8b 04 85 d4 a4 10 80 	mov    -0x7fef5b2c(,%eax,4),%eax
80107a53:	ff e0                	jmp    *%eax
      case 0:
        lapic_entry = (struct uefi_lapic *)entry_type;
80107a55:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a58:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(ncpu < NCPU) {
80107a5b:	a1 40 5c 19 80       	mov    0x80195c40,%eax
80107a60:	83 f8 03             	cmp    $0x3,%eax
80107a63:	7f 2c                	jg     80107a91 <mpinit_uefi+0x9d>
          cpus[ncpu].apicid = lapic_entry->lapic_id;
80107a65:	8b 15 40 5c 19 80    	mov    0x80195c40,%edx
80107a6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107a6e:	8a 48 03             	mov    0x3(%eax),%cl
80107a71:	89 d0                	mov    %edx,%eax
80107a73:	c1 e0 02             	shl    $0x2,%eax
80107a76:	01 d0                	add    %edx,%eax
80107a78:	01 c0                	add    %eax,%eax
80107a7a:	01 d0                	add    %edx,%eax
80107a7c:	c1 e0 04             	shl    $0x4,%eax
80107a7f:	05 80 59 19 80       	add    $0x80195980,%eax
80107a84:	88 08                	mov    %cl,(%eax)
          ncpu++;
80107a86:	a1 40 5c 19 80       	mov    0x80195c40,%eax
80107a8b:	40                   	inc    %eax
80107a8c:	a3 40 5c 19 80       	mov    %eax,0x80195c40
        }
        i += lapic_entry->record_len;
80107a91:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107a94:	8a 40 01             	mov    0x1(%eax),%al
80107a97:	0f b6 c0             	movzbl %al,%eax
80107a9a:	01 45 fc             	add    %eax,-0x4(%ebp)
        break;
80107a9d:	eb 4c                	jmp    80107aeb <mpinit_uefi+0xf7>

      case 1:
        ioapic = (struct uefi_ioapic *)entry_type;
80107a9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107aa2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ioapicid = ioapic->ioapic_id;
80107aa5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107aa8:	8a 40 02             	mov    0x2(%eax),%al
80107aab:	a2 44 5c 19 80       	mov    %al,0x80195c44
        i += ioapic->record_len;
80107ab0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ab3:	8a 40 01             	mov    0x1(%eax),%al
80107ab6:	0f b6 c0             	movzbl %al,%eax
80107ab9:	01 45 fc             	add    %eax,-0x4(%ebp)
        break;
80107abc:	eb 2d                	jmp    80107aeb <mpinit_uefi+0xf7>

      case 2:
        iso = (struct uefi_iso *)entry_type;
80107abe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ac1:	89 45 e8             	mov    %eax,-0x18(%ebp)
        i += iso->record_len;
80107ac4:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107ac7:	8a 40 01             	mov    0x1(%eax),%al
80107aca:	0f b6 c0             	movzbl %al,%eax
80107acd:	01 45 fc             	add    %eax,-0x4(%ebp)
        break;
80107ad0:	eb 19                	jmp    80107aeb <mpinit_uefi+0xf7>

      case 4:
        non_mask_intr = (struct uefi_non_maskable_intr *)entry_type;
80107ad2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ad5:	89 45 ec             	mov    %eax,-0x14(%ebp)
        i += non_mask_intr->record_len;
80107ad8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107adb:	8a 40 01             	mov    0x1(%eax),%al
80107ade:	0f b6 c0             	movzbl %al,%eax
80107ae1:	01 45 fc             	add    %eax,-0x4(%ebp)
        break;
80107ae4:	eb 05                	jmp    80107aeb <mpinit_uefi+0xf7>

      case 5:
        i = i + 0xC;
80107ae6:	83 45 fc 0c          	addl   $0xc,-0x4(%ebp)
        break;
80107aea:	90                   	nop
  while(i<madt->len){
80107aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aee:	8b 40 04             	mov    0x4(%eax),%eax
80107af1:	39 45 fc             	cmp    %eax,-0x4(%ebp)
80107af4:	0f 82 36 ff ff ff    	jb     80107a30 <mpinit_uefi+0x3c>
    }
  }

}
80107afa:	90                   	nop
80107afb:	90                   	nop
80107afc:	c9                   	leave  
80107afd:	c3                   	ret    

80107afe <inb>:
{
80107afe:	55                   	push   %ebp
80107aff:	89 e5                	mov    %esp,%ebp
80107b01:	83 ec 14             	sub    $0x14,%esp
80107b04:	8b 45 08             	mov    0x8(%ebp),%eax
80107b07:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107b0b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b0e:	89 c2                	mov    %eax,%edx
80107b10:	ec                   	in     (%dx),%al
80107b11:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80107b14:	8a 45 ff             	mov    -0x1(%ebp),%al
}
80107b17:	c9                   	leave  
80107b18:	c3                   	ret    

80107b19 <outb>:
{
80107b19:	55                   	push   %ebp
80107b1a:	89 e5                	mov    %esp,%ebp
80107b1c:	83 ec 08             	sub    $0x8,%esp
80107b1f:	8b 45 08             	mov    0x8(%ebp),%eax
80107b22:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b25:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80107b29:	88 d0                	mov    %dl,%al
80107b2b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107b2e:	8a 45 f8             	mov    -0x8(%ebp),%al
80107b31:	8b 55 fc             	mov    -0x4(%ebp),%edx
80107b34:	ee                   	out    %al,(%dx)
}
80107b35:	90                   	nop
80107b36:	c9                   	leave  
80107b37:	c3                   	ret    

80107b38 <uart_debug>:
#include "proc.h"
#include "x86.h"

#define COM1    0x3f8

void uart_debug(char p){
80107b38:	55                   	push   %ebp
80107b39:	89 e5                	mov    %esp,%ebp
80107b3b:	83 ec 28             	sub    $0x28,%esp
80107b3e:	8b 45 08             	mov    0x8(%ebp),%eax
80107b41:	88 45 e4             	mov    %al,-0x1c(%ebp)
    // Turn off the FIFO
  outb(COM1+2, 0);
80107b44:	6a 00                	push   $0x0
80107b46:	68 fa 03 00 00       	push   $0x3fa
80107b4b:	e8 c9 ff ff ff       	call   80107b19 <outb>
80107b50:	83 c4 08             	add    $0x8,%esp

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80107b53:	68 80 00 00 00       	push   $0x80
80107b58:	68 fb 03 00 00       	push   $0x3fb
80107b5d:	e8 b7 ff ff ff       	call   80107b19 <outb>
80107b62:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80107b65:	6a 0c                	push   $0xc
80107b67:	68 f8 03 00 00       	push   $0x3f8
80107b6c:	e8 a8 ff ff ff       	call   80107b19 <outb>
80107b71:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80107b74:	6a 00                	push   $0x0
80107b76:	68 f9 03 00 00       	push   $0x3f9
80107b7b:	e8 99 ff ff ff       	call   80107b19 <outb>
80107b80:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80107b83:	6a 03                	push   $0x3
80107b85:	68 fb 03 00 00       	push   $0x3fb
80107b8a:	e8 8a ff ff ff       	call   80107b19 <outb>
80107b8f:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80107b92:	6a 00                	push   $0x0
80107b94:	68 fc 03 00 00       	push   $0x3fc
80107b99:	e8 7b ff ff ff       	call   80107b19 <outb>
80107b9e:	83 c4 08             	add    $0x8,%esp

  for(int i=0;i<128 && !(inb(COM1+5) & 0x20); i++) microdelay(10);
80107ba1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107ba8:	eb 10                	jmp    80107bba <uart_debug+0x82>
80107baa:	83 ec 0c             	sub    $0xc,%esp
80107bad:	6a 0a                	push   $0xa
80107baf:	e8 0c af ff ff       	call   80102ac0 <microdelay>
80107bb4:	83 c4 10             	add    $0x10,%esp
80107bb7:	ff 45 f4             	incl   -0xc(%ebp)
80107bba:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80107bbe:	7f 1a                	jg     80107bda <uart_debug+0xa2>
80107bc0:	83 ec 0c             	sub    $0xc,%esp
80107bc3:	68 fd 03 00 00       	push   $0x3fd
80107bc8:	e8 31 ff ff ff       	call   80107afe <inb>
80107bcd:	83 c4 10             	add    $0x10,%esp
80107bd0:	0f b6 c0             	movzbl %al,%eax
80107bd3:	83 e0 20             	and    $0x20,%eax
80107bd6:	85 c0                	test   %eax,%eax
80107bd8:	74 d0                	je     80107baa <uart_debug+0x72>
  outb(COM1+0, p);
80107bda:	8a 45 e4             	mov    -0x1c(%ebp),%al
80107bdd:	0f b6 c0             	movzbl %al,%eax
80107be0:	83 ec 08             	sub    $0x8,%esp
80107be3:	50                   	push   %eax
80107be4:	68 f8 03 00 00       	push   $0x3f8
80107be9:	e8 2b ff ff ff       	call   80107b19 <outb>
80107bee:	83 c4 10             	add    $0x10,%esp
}
80107bf1:	90                   	nop
80107bf2:	c9                   	leave  
80107bf3:	c3                   	ret    

80107bf4 <uart_debugs>:

void uart_debugs(char *p){
80107bf4:	55                   	push   %ebp
80107bf5:	89 e5                	mov    %esp,%ebp
80107bf7:	83 ec 08             	sub    $0x8,%esp
  while(*p){
80107bfa:	eb 1a                	jmp    80107c16 <uart_debugs+0x22>
    uart_debug(*p++);
80107bfc:	8b 45 08             	mov    0x8(%ebp),%eax
80107bff:	8d 50 01             	lea    0x1(%eax),%edx
80107c02:	89 55 08             	mov    %edx,0x8(%ebp)
80107c05:	8a 00                	mov    (%eax),%al
80107c07:	0f be c0             	movsbl %al,%eax
80107c0a:	83 ec 0c             	sub    $0xc,%esp
80107c0d:	50                   	push   %eax
80107c0e:	e8 25 ff ff ff       	call   80107b38 <uart_debug>
80107c13:	83 c4 10             	add    $0x10,%esp
  while(*p){
80107c16:	8b 45 08             	mov    0x8(%ebp),%eax
80107c19:	8a 00                	mov    (%eax),%al
80107c1b:	84 c0                	test   %al,%al
80107c1d:	75 dd                	jne    80107bfc <uart_debugs+0x8>
  }
}
80107c1f:	90                   	nop
80107c20:	90                   	nop
80107c21:	c9                   	leave  
80107c22:	c3                   	ret    

80107c23 <graphic_init>:
 * i%4 = 2 : red
 * i%4 = 3 : black
 */

struct gpu gpu;
void graphic_init(){
80107c23:	55                   	push   %ebp
80107c24:	89 e5                	mov    %esp,%ebp
80107c26:	83 ec 10             	sub    $0x10,%esp
  struct boot_param *boot_param = (struct boot_param *)P2V_WO(BOOTPARAM);
80107c29:	c7 45 fc 00 00 05 80 	movl   $0x80050000,-0x4(%ebp)
  gpu.pvram_addr = boot_param->graphic_config.frame_base;
80107c30:	8b 45 fc             	mov    -0x4(%ebp),%eax
80107c33:	8b 50 14             	mov    0x14(%eax),%edx
80107c36:	8b 40 10             	mov    0x10(%eax),%eax
80107c39:	a3 48 5c 19 80       	mov    %eax,0x80195c48
  gpu.vram_size = boot_param->graphic_config.frame_size;
80107c3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80107c41:	8b 50 1c             	mov    0x1c(%eax),%edx
80107c44:	8b 40 18             	mov    0x18(%eax),%eax
80107c47:	a3 50 5c 19 80       	mov    %eax,0x80195c50
  gpu.vvram_addr = DEVSPACE - gpu.vram_size;
80107c4c:	a1 50 5c 19 80       	mov    0x80195c50,%eax
80107c51:	ba 00 00 00 fe       	mov    $0xfe000000,%edx
80107c56:	29 c2                	sub    %eax,%edx
80107c58:	89 15 4c 5c 19 80    	mov    %edx,0x80195c4c
  gpu.horizontal_resolution = (uint)(boot_param->graphic_config.horizontal_resolution & 0xFFFFFFFF);
80107c5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80107c61:	8b 50 24             	mov    0x24(%eax),%edx
80107c64:	8b 40 20             	mov    0x20(%eax),%eax
80107c67:	a3 54 5c 19 80       	mov    %eax,0x80195c54
  gpu.vertical_resolution = (uint)(boot_param->graphic_config.vertical_resolution & 0xFFFFFFFF);
80107c6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80107c6f:	8b 50 2c             	mov    0x2c(%eax),%edx
80107c72:	8b 40 28             	mov    0x28(%eax),%eax
80107c75:	a3 58 5c 19 80       	mov    %eax,0x80195c58
  gpu.pixels_per_line = (uint)(boot_param->graphic_config.pixels_per_line & 0xFFFFFFFF);
80107c7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80107c7d:	8b 50 34             	mov    0x34(%eax),%edx
80107c80:	8b 40 30             	mov    0x30(%eax),%eax
80107c83:	a3 5c 5c 19 80       	mov    %eax,0x80195c5c
}
80107c88:	90                   	nop
80107c89:	c9                   	leave  
80107c8a:	c3                   	ret    

80107c8b <graphic_draw_pixel>:

void graphic_draw_pixel(int x,int y,struct graphic_pixel * buffer){
80107c8b:	55                   	push   %ebp
80107c8c:	89 e5                	mov    %esp,%ebp
80107c8e:	83 ec 10             	sub    $0x10,%esp
  int pixel_addr = (sizeof(struct graphic_pixel))*(y*gpu.pixels_per_line + x);
80107c91:	8b 15 5c 5c 19 80    	mov    0x80195c5c,%edx
80107c97:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c9a:	0f af d0             	imul   %eax,%edx
80107c9d:	8b 45 08             	mov    0x8(%ebp),%eax
80107ca0:	01 d0                	add    %edx,%eax
80107ca2:	c1 e0 02             	shl    $0x2,%eax
80107ca5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  struct graphic_pixel *pixel = (struct graphic_pixel *)(gpu.vvram_addr + pixel_addr);
80107ca8:	8b 15 4c 5c 19 80    	mov    0x80195c4c,%edx
80107cae:	8b 45 fc             	mov    -0x4(%ebp),%eax
80107cb1:	01 d0                	add    %edx,%eax
80107cb3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  pixel->blue = buffer->blue;
80107cb6:	8b 45 10             	mov    0x10(%ebp),%eax
80107cb9:	8a 10                	mov    (%eax),%dl
80107cbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
80107cbe:	88 10                	mov    %dl,(%eax)
  pixel->green = buffer->green;
80107cc0:	8b 45 10             	mov    0x10(%ebp),%eax
80107cc3:	8a 50 01             	mov    0x1(%eax),%dl
80107cc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
80107cc9:	88 50 01             	mov    %dl,0x1(%eax)
  pixel->red = buffer->red;
80107ccc:	8b 45 10             	mov    0x10(%ebp),%eax
80107ccf:	8a 50 02             	mov    0x2(%eax),%dl
80107cd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
80107cd5:	88 50 02             	mov    %dl,0x2(%eax)
}
80107cd8:	90                   	nop
80107cd9:	c9                   	leave  
80107cda:	c3                   	ret    

80107cdb <graphic_scroll_up>:

void graphic_scroll_up(int height){
80107cdb:	55                   	push   %ebp
80107cdc:	89 e5                	mov    %esp,%ebp
80107cde:	83 ec 18             	sub    $0x18,%esp
  int addr_diff = (sizeof(struct graphic_pixel))*gpu.pixels_per_line*height;
80107ce1:	8b 15 5c 5c 19 80    	mov    0x80195c5c,%edx
80107ce7:	8b 45 08             	mov    0x8(%ebp),%eax
80107cea:	0f af c2             	imul   %edx,%eax
80107ced:	c1 e0 02             	shl    $0x2,%eax
80107cf0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove((unsigned int *)gpu.vvram_addr,(unsigned int *)(gpu.vvram_addr + addr_diff),gpu.vram_size - addr_diff);
80107cf3:	8b 15 50 5c 19 80    	mov    0x80195c50,%edx
80107cf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cfc:	89 d1                	mov    %edx,%ecx
80107cfe:	29 c1                	sub    %eax,%ecx
80107d00:	8b 15 4c 5c 19 80    	mov    0x80195c4c,%edx
80107d06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d09:	01 d0                	add    %edx,%eax
80107d0b:	89 c2                	mov    %eax,%edx
80107d0d:	a1 4c 5c 19 80       	mov    0x80195c4c,%eax
80107d12:	83 ec 04             	sub    $0x4,%esp
80107d15:	51                   	push   %ecx
80107d16:	52                   	push   %edx
80107d17:	50                   	push   %eax
80107d18:	e8 a1 cc ff ff       	call   801049be <memmove>
80107d1d:	83 c4 10             	add    $0x10,%esp
  memset((unsigned int *)(gpu.vvram_addr + gpu.vram_size - addr_diff),0,addr_diff);
80107d20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d23:	8b 0d 4c 5c 19 80    	mov    0x80195c4c,%ecx
80107d29:	8b 15 50 5c 19 80    	mov    0x80195c50,%edx
80107d2f:	01 d1                	add    %edx,%ecx
80107d31:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107d34:	29 d1                	sub    %edx,%ecx
80107d36:	89 ca                	mov    %ecx,%edx
80107d38:	83 ec 04             	sub    $0x4,%esp
80107d3b:	50                   	push   %eax
80107d3c:	6a 00                	push   $0x0
80107d3e:	52                   	push   %edx
80107d3f:	e8 c1 cb ff ff       	call   80104905 <memset>
80107d44:	83 c4 10             	add    $0x10,%esp
}
80107d47:	90                   	nop
80107d48:	c9                   	leave  
80107d49:	c3                   	ret    

80107d4a <font_render>:
#include "font.h"


struct graphic_pixel black_pixel = {0x0,0x0,0x0,0x0};
struct graphic_pixel white_pixel = {0xFF,0xFF,0xFF,0x0};
void font_render(int x,int y,int index){
80107d4a:	55                   	push   %ebp
80107d4b:	89 e5                	mov    %esp,%ebp
80107d4d:	53                   	push   %ebx
80107d4e:	83 ec 14             	sub    $0x14,%esp
  int bin;
  for(int i=0;i<30;i++){
80107d51:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107d58:	e9 bd 00 00 00       	jmp    80107e1a <font_render+0xd0>
    for(int j=14;j>-1;j--){
80107d5d:	c7 45 f0 0e 00 00 00 	movl   $0xe,-0x10(%ebp)
80107d64:	e9 a4 00 00 00       	jmp    80107e0d <font_render+0xc3>
      bin = (font_bin[index-0x20][i])&(1 << j);
80107d69:	8b 45 10             	mov    0x10(%ebp),%eax
80107d6c:	8d 50 e0             	lea    -0x20(%eax),%edx
80107d6f:	89 d0                	mov    %edx,%eax
80107d71:	01 c0                	add    %eax,%eax
80107d73:	01 d0                	add    %edx,%eax
80107d75:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107d7c:	01 d0                	add    %edx,%eax
80107d7e:	01 c0                	add    %eax,%eax
80107d80:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107d83:	01 d0                	add    %edx,%eax
80107d85:	66 8b 84 00 00 a5 10 	mov    -0x7fef5b00(%eax,%eax,1),%ax
80107d8c:	80 
80107d8d:	0f b7 d0             	movzwl %ax,%edx
80107d90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d93:	bb 01 00 00 00       	mov    $0x1,%ebx
80107d98:	88 c1                	mov    %al,%cl
80107d9a:	d3 e3                	shl    %cl,%ebx
80107d9c:	89 d8                	mov    %ebx,%eax
80107d9e:	21 d0                	and    %edx,%eax
80107da0:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(bin == (1 << j)){
80107da3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107da6:	ba 01 00 00 00       	mov    $0x1,%edx
80107dab:	88 c1                	mov    %al,%cl
80107dad:	d3 e2                	shl    %cl,%edx
80107daf:	89 d0                	mov    %edx,%eax
80107db1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80107db4:	75 2b                	jne    80107de1 <font_render+0x97>
        graphic_draw_pixel(x+(14-j),y+i,&white_pixel);
80107db6:	8b 55 0c             	mov    0xc(%ebp),%edx
80107db9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dbc:	01 c2                	add    %eax,%edx
80107dbe:	b8 0e 00 00 00       	mov    $0xe,%eax
80107dc3:	2b 45 f0             	sub    -0x10(%ebp),%eax
80107dc6:	89 c1                	mov    %eax,%ecx
80107dc8:	8b 45 08             	mov    0x8(%ebp),%eax
80107dcb:	01 c8                	add    %ecx,%eax
80107dcd:	83 ec 04             	sub    $0x4,%esp
80107dd0:	68 e0 e4 10 80       	push   $0x8010e4e0
80107dd5:	52                   	push   %edx
80107dd6:	50                   	push   %eax
80107dd7:	e8 af fe ff ff       	call   80107c8b <graphic_draw_pixel>
80107ddc:	83 c4 10             	add    $0x10,%esp
80107ddf:	eb 29                	jmp    80107e0a <font_render+0xc0>
      } else {
        graphic_draw_pixel(x+(14-j),y+i,&black_pixel);
80107de1:	8b 55 0c             	mov    0xc(%ebp),%edx
80107de4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107de7:	01 c2                	add    %eax,%edx
80107de9:	b8 0e 00 00 00       	mov    $0xe,%eax
80107dee:	2b 45 f0             	sub    -0x10(%ebp),%eax
80107df1:	89 c1                	mov    %eax,%ecx
80107df3:	8b 45 08             	mov    0x8(%ebp),%eax
80107df6:	01 c8                	add    %ecx,%eax
80107df8:	83 ec 04             	sub    $0x4,%esp
80107dfb:	68 60 5c 19 80       	push   $0x80195c60
80107e00:	52                   	push   %edx
80107e01:	50                   	push   %eax
80107e02:	e8 84 fe ff ff       	call   80107c8b <graphic_draw_pixel>
80107e07:	83 c4 10             	add    $0x10,%esp
    for(int j=14;j>-1;j--){
80107e0a:	ff 4d f0             	decl   -0x10(%ebp)
80107e0d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107e11:	0f 89 52 ff ff ff    	jns    80107d69 <font_render+0x1f>
  for(int i=0;i<30;i++){
80107e17:	ff 45 f4             	incl   -0xc(%ebp)
80107e1a:	83 7d f4 1d          	cmpl   $0x1d,-0xc(%ebp)
80107e1e:	0f 8e 39 ff ff ff    	jle    80107d5d <font_render+0x13>
      }
    }
  }
}
80107e24:	90                   	nop
80107e25:	90                   	nop
80107e26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107e29:	c9                   	leave  
80107e2a:	c3                   	ret    

80107e2b <font_render_string>:

void font_render_string(char *string,int row){
80107e2b:	55                   	push   %ebp
80107e2c:	89 e5                	mov    %esp,%ebp
80107e2e:	53                   	push   %ebx
80107e2f:	83 ec 14             	sub    $0x14,%esp
  int i = 0;
80107e32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(string[i] && i < 52){
80107e39:	eb 49                	jmp    80107e84 <font_render_string+0x59>
    font_render(i*15+2,row*30,string[i]);
80107e3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107e3e:	8b 45 08             	mov    0x8(%ebp),%eax
80107e41:	01 d0                	add    %edx,%eax
80107e43:	8a 00                	mov    (%eax),%al
80107e45:	0f be d0             	movsbl %al,%edx
80107e48:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107e4b:	89 c8                	mov    %ecx,%eax
80107e4d:	01 c0                	add    %eax,%eax
80107e4f:	01 c8                	add    %ecx,%eax
80107e51:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80107e58:	01 c8                	add    %ecx,%eax
80107e5a:	01 c0                	add    %eax,%eax
80107e5c:	89 c3                	mov    %eax,%ebx
80107e5e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80107e61:	89 c8                	mov    %ecx,%eax
80107e63:	01 c0                	add    %eax,%eax
80107e65:	01 c8                	add    %ecx,%eax
80107e67:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80107e6e:	01 c8                	add    %ecx,%eax
80107e70:	83 c0 02             	add    $0x2,%eax
80107e73:	83 ec 04             	sub    $0x4,%esp
80107e76:	52                   	push   %edx
80107e77:	53                   	push   %ebx
80107e78:	50                   	push   %eax
80107e79:	e8 cc fe ff ff       	call   80107d4a <font_render>
80107e7e:	83 c4 10             	add    $0x10,%esp
    i++;
80107e81:	ff 45 f4             	incl   -0xc(%ebp)
  while(string[i] && i < 52){
80107e84:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107e87:	8b 45 08             	mov    0x8(%ebp),%eax
80107e8a:	01 d0                	add    %edx,%eax
80107e8c:	8a 00                	mov    (%eax),%al
80107e8e:	84 c0                	test   %al,%al
80107e90:	74 06                	je     80107e98 <font_render_string+0x6d>
80107e92:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
80107e96:	7e a3                	jle    80107e3b <font_render_string+0x10>
  }
}
80107e98:	90                   	nop
80107e99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107e9c:	c9                   	leave  
80107e9d:	c3                   	ret    

80107e9e <pci_init>:
#include "pci.h"
#include "defs.h"
#include "types.h"
#include "i8254.h"

void pci_init(){
80107e9e:	55                   	push   %ebp
80107e9f:	89 e5                	mov    %esp,%ebp
80107ea1:	53                   	push   %ebx
80107ea2:	83 ec 14             	sub    $0x14,%esp
  uint data;
  for(int i=0;i<256;i++){
80107ea5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107eac:	eb 68                	jmp    80107f16 <pci_init+0x78>
    for(int j=0;j<32;j++){
80107eae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80107eb5:	eb 56                	jmp    80107f0d <pci_init+0x6f>
      for(int k=0;k<8;k++){
80107eb7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80107ebe:	eb 44                	jmp    80107f04 <pci_init+0x66>
      pci_access_config(i,j,k,0,&data);
80107ec0:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80107ec3:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107ec6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec9:	83 ec 0c             	sub    $0xc,%esp
80107ecc:	8d 5d e8             	lea    -0x18(%ebp),%ebx
80107ecf:	53                   	push   %ebx
80107ed0:	6a 00                	push   $0x0
80107ed2:	51                   	push   %ecx
80107ed3:	52                   	push   %edx
80107ed4:	50                   	push   %eax
80107ed5:	e8 ad 00 00 00       	call   80107f87 <pci_access_config>
80107eda:	83 c4 20             	add    $0x20,%esp
      if((data&0xFFFF) != 0xFFFF){
80107edd:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107ee0:	0f b7 c0             	movzwl %ax,%eax
80107ee3:	3d ff ff 00 00       	cmp    $0xffff,%eax
80107ee8:	74 17                	je     80107f01 <pci_init+0x63>
        pci_init_device(i,j,k);
80107eea:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80107eed:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107ef0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ef3:	83 ec 04             	sub    $0x4,%esp
80107ef6:	51                   	push   %ecx
80107ef7:	52                   	push   %edx
80107ef8:	50                   	push   %eax
80107ef9:	e8 34 01 00 00       	call   80108032 <pci_init_device>
80107efe:	83 c4 10             	add    $0x10,%esp
      for(int k=0;k<8;k++){
80107f01:	ff 45 ec             	incl   -0x14(%ebp)
80107f04:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
80107f08:	7e b6                	jle    80107ec0 <pci_init+0x22>
    for(int j=0;j<32;j++){
80107f0a:	ff 45 f0             	incl   -0x10(%ebp)
80107f0d:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
80107f11:	7e a4                	jle    80107eb7 <pci_init+0x19>
  for(int i=0;i<256;i++){
80107f13:	ff 45 f4             	incl   -0xc(%ebp)
80107f16:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80107f1d:	7e 8f                	jle    80107eae <pci_init+0x10>
      }
      }
    }
  }
}
80107f1f:	90                   	nop
80107f20:	90                   	nop
80107f21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107f24:	c9                   	leave  
80107f25:	c3                   	ret    

80107f26 <pci_write_config>:

void pci_write_config(uint config){
80107f26:	55                   	push   %ebp
80107f27:	89 e5                	mov    %esp,%ebp
  asm("mov $0xCF8,%%edx\n\t"
80107f29:	8b 45 08             	mov    0x8(%ebp),%eax
80107f2c:	ba f8 0c 00 00       	mov    $0xcf8,%edx
80107f31:	89 c0                	mov    %eax,%eax
80107f33:	ef                   	out    %eax,(%dx)
      "mov %0,%%eax\n\t"
      "out %%eax,%%dx\n\t"
      : :"r"(config));
}
80107f34:	90                   	nop
80107f35:	5d                   	pop    %ebp
80107f36:	c3                   	ret    

80107f37 <pci_write_data>:

void pci_write_data(uint config){
80107f37:	55                   	push   %ebp
80107f38:	89 e5                	mov    %esp,%ebp
  asm("mov $0xCFC,%%edx\n\t"
80107f3a:	8b 45 08             	mov    0x8(%ebp),%eax
80107f3d:	ba fc 0c 00 00       	mov    $0xcfc,%edx
80107f42:	89 c0                	mov    %eax,%eax
80107f44:	ef                   	out    %eax,(%dx)
      "mov %0,%%eax\n\t"
      "out %%eax,%%dx\n\t"
      : :"r"(config));
}
80107f45:	90                   	nop
80107f46:	5d                   	pop    %ebp
80107f47:	c3                   	ret    

80107f48 <pci_read_config>:
uint pci_read_config(){
80107f48:	55                   	push   %ebp
80107f49:	89 e5                	mov    %esp,%ebp
80107f4b:	83 ec 18             	sub    $0x18,%esp
  uint data;
  asm("mov $0xCFC,%%edx\n\t"
80107f4e:	ba fc 0c 00 00       	mov    $0xcfc,%edx
80107f53:	ed                   	in     (%dx),%eax
80107f54:	89 45 f4             	mov    %eax,-0xc(%ebp)
      "in %%dx,%%eax\n\t"
      "mov %%eax,%0"
      :"=m"(data):);
  microdelay(200);
80107f57:	83 ec 0c             	sub    $0xc,%esp
80107f5a:	68 c8 00 00 00       	push   $0xc8
80107f5f:	e8 5c ab ff ff       	call   80102ac0 <microdelay>
80107f64:	83 c4 10             	add    $0x10,%esp
  return data;
80107f67:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80107f6a:	c9                   	leave  
80107f6b:	c3                   	ret    

80107f6c <pci_test>:


void pci_test(){
80107f6c:	55                   	push   %ebp
80107f6d:	89 e5                	mov    %esp,%ebp
80107f6f:	83 ec 10             	sub    $0x10,%esp
  uint data = 0x80001804;
80107f72:	c7 45 fc 04 18 00 80 	movl   $0x80001804,-0x4(%ebp)
  pci_write_config(data);
80107f79:	ff 75 fc             	pushl  -0x4(%ebp)
80107f7c:	e8 a5 ff ff ff       	call   80107f26 <pci_write_config>
80107f81:	83 c4 04             	add    $0x4,%esp
}
80107f84:	90                   	nop
80107f85:	c9                   	leave  
80107f86:	c3                   	ret    

80107f87 <pci_access_config>:

void pci_access_config(uint bus_num,uint device_num,uint function_num,uint reg_addr,uint *data){
80107f87:	55                   	push   %ebp
80107f88:	89 e5                	mov    %esp,%ebp
80107f8a:	83 ec 18             	sub    $0x18,%esp
  uint config_addr = ((bus_num & 0xFF)<<16) | ((device_num & 0x1F)<<11) | ((function_num & 0x7)<<8) |
80107f8d:	8b 45 08             	mov    0x8(%ebp),%eax
80107f90:	c1 e0 10             	shl    $0x10,%eax
80107f93:	25 00 00 ff 00       	and    $0xff0000,%eax
80107f98:	89 c2                	mov    %eax,%edx
80107f9a:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f9d:	c1 e0 0b             	shl    $0xb,%eax
80107fa0:	0f b7 c0             	movzwl %ax,%eax
80107fa3:	09 c2                	or     %eax,%edx
80107fa5:	8b 45 10             	mov    0x10(%ebp),%eax
80107fa8:	c1 e0 08             	shl    $0x8,%eax
80107fab:	25 00 07 00 00       	and    $0x700,%eax
80107fb0:	09 c2                	or     %eax,%edx
    (reg_addr & 0xFC) | 0x80000000;
80107fb2:	8b 45 14             	mov    0x14(%ebp),%eax
80107fb5:	25 fc 00 00 00       	and    $0xfc,%eax
  uint config_addr = ((bus_num & 0xFF)<<16) | ((device_num & 0x1F)<<11) | ((function_num & 0x7)<<8) |
80107fba:	09 d0                	or     %edx,%eax
80107fbc:	0d 00 00 00 80       	or     $0x80000000,%eax
80107fc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  pci_write_config(config_addr);
80107fc4:	ff 75 f4             	pushl  -0xc(%ebp)
80107fc7:	e8 5a ff ff ff       	call   80107f26 <pci_write_config>
80107fcc:	83 c4 04             	add    $0x4,%esp
  *data = pci_read_config();
80107fcf:	e8 74 ff ff ff       	call   80107f48 <pci_read_config>
80107fd4:	8b 55 18             	mov    0x18(%ebp),%edx
80107fd7:	89 02                	mov    %eax,(%edx)
}
80107fd9:	90                   	nop
80107fda:	c9                   	leave  
80107fdb:	c3                   	ret    

80107fdc <pci_write_config_register>:

void pci_write_config_register(uint bus_num,uint device_num,uint function_num,uint reg_addr,uint data){
80107fdc:	55                   	push   %ebp
80107fdd:	89 e5                	mov    %esp,%ebp
80107fdf:	83 ec 10             	sub    $0x10,%esp
  uint config_addr = ((bus_num & 0xFF)<<16) | ((device_num & 0x1F)<<11) | ((function_num & 0x7)<<8) |
80107fe2:	8b 45 08             	mov    0x8(%ebp),%eax
80107fe5:	c1 e0 10             	shl    $0x10,%eax
80107fe8:	25 00 00 ff 00       	and    $0xff0000,%eax
80107fed:	89 c2                	mov    %eax,%edx
80107fef:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ff2:	c1 e0 0b             	shl    $0xb,%eax
80107ff5:	0f b7 c0             	movzwl %ax,%eax
80107ff8:	09 c2                	or     %eax,%edx
80107ffa:	8b 45 10             	mov    0x10(%ebp),%eax
80107ffd:	c1 e0 08             	shl    $0x8,%eax
80108000:	25 00 07 00 00       	and    $0x700,%eax
80108005:	09 c2                	or     %eax,%edx
    (reg_addr & 0xFC) | 0x80000000;
80108007:	8b 45 14             	mov    0x14(%ebp),%eax
8010800a:	25 fc 00 00 00       	and    $0xfc,%eax
  uint config_addr = ((bus_num & 0xFF)<<16) | ((device_num & 0x1F)<<11) | ((function_num & 0x7)<<8) |
8010800f:	09 d0                	or     %edx,%eax
80108011:	0d 00 00 00 80       	or     $0x80000000,%eax
80108016:	89 45 fc             	mov    %eax,-0x4(%ebp)
  pci_write_config(config_addr);
80108019:	ff 75 fc             	pushl  -0x4(%ebp)
8010801c:	e8 05 ff ff ff       	call   80107f26 <pci_write_config>
80108021:	83 c4 04             	add    $0x4,%esp
  pci_write_data(data);
80108024:	ff 75 18             	pushl  0x18(%ebp)
80108027:	e8 0b ff ff ff       	call   80107f37 <pci_write_data>
8010802c:	83 c4 04             	add    $0x4,%esp
}
8010802f:	90                   	nop
80108030:	c9                   	leave  
80108031:	c3                   	ret    

80108032 <pci_init_device>:

struct pci_dev dev;
void pci_init_device(uint bus_num,uint device_num,uint function_num){
80108032:	55                   	push   %ebp
80108033:	89 e5                	mov    %esp,%ebp
80108035:	53                   	push   %ebx
80108036:	83 ec 14             	sub    $0x14,%esp
  uint data;
  dev.bus_num = bus_num;
80108039:	8b 45 08             	mov    0x8(%ebp),%eax
8010803c:	a2 64 5c 19 80       	mov    %al,0x80195c64
  dev.device_num = device_num;
80108041:	8b 45 0c             	mov    0xc(%ebp),%eax
80108044:	a2 65 5c 19 80       	mov    %al,0x80195c65
  dev.function_num = function_num;
80108049:	8b 45 10             	mov    0x10(%ebp),%eax
8010804c:	a2 66 5c 19 80       	mov    %al,0x80195c66
  cprintf("PCI Device Found Bus:0x%x Device:0x%x Function:%x\n",bus_num,device_num,function_num);
80108051:	ff 75 10             	pushl  0x10(%ebp)
80108054:	ff 75 0c             	pushl  0xc(%ebp)
80108057:	ff 75 08             	pushl  0x8(%ebp)
8010805a:	68 44 bb 10 80       	push   $0x8010bb44
8010805f:	e8 8d 83 ff ff       	call   801003f1 <cprintf>
80108064:	83 c4 10             	add    $0x10,%esp
  
  pci_access_config(bus_num,device_num,function_num,0,&data);
80108067:	83 ec 0c             	sub    $0xc,%esp
8010806a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010806d:	50                   	push   %eax
8010806e:	6a 00                	push   $0x0
80108070:	ff 75 10             	pushl  0x10(%ebp)
80108073:	ff 75 0c             	pushl  0xc(%ebp)
80108076:	ff 75 08             	pushl  0x8(%ebp)
80108079:	e8 09 ff ff ff       	call   80107f87 <pci_access_config>
8010807e:	83 c4 20             	add    $0x20,%esp
  uint device_id = data>>16;
80108081:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108084:	c1 e8 10             	shr    $0x10,%eax
80108087:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint vendor_id = data&0xFFFF;
8010808a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010808d:	25 ff ff 00 00       	and    $0xffff,%eax
80108092:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dev.device_id = device_id;
80108095:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108098:	a3 68 5c 19 80       	mov    %eax,0x80195c68
  dev.vendor_id = vendor_id;
8010809d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801080a0:	a3 6c 5c 19 80       	mov    %eax,0x80195c6c
  cprintf("  Device ID:0x%x  Vendor ID:0x%x\n",device_id,vendor_id);
801080a5:	83 ec 04             	sub    $0x4,%esp
801080a8:	ff 75 f0             	pushl  -0x10(%ebp)
801080ab:	ff 75 f4             	pushl  -0xc(%ebp)
801080ae:	68 78 bb 10 80       	push   $0x8010bb78
801080b3:	e8 39 83 ff ff       	call   801003f1 <cprintf>
801080b8:	83 c4 10             	add    $0x10,%esp
  
  pci_access_config(bus_num,device_num,function_num,0x8,&data);
801080bb:	83 ec 0c             	sub    $0xc,%esp
801080be:	8d 45 ec             	lea    -0x14(%ebp),%eax
801080c1:	50                   	push   %eax
801080c2:	6a 08                	push   $0x8
801080c4:	ff 75 10             	pushl  0x10(%ebp)
801080c7:	ff 75 0c             	pushl  0xc(%ebp)
801080ca:	ff 75 08             	pushl  0x8(%ebp)
801080cd:	e8 b5 fe ff ff       	call   80107f87 <pci_access_config>
801080d2:	83 c4 20             	add    $0x20,%esp
  cprintf("  Base Class:0x%x  Sub Class:0x%x  Interface:0x%x  Revision ID:0x%x\n",
801080d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080d8:	0f b6 c8             	movzbl %al,%ecx
      data>>24,(data>>16)&0xFF,(data>>8)&0xFF,data&0xFF);
801080db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080de:	c1 e8 08             	shr    $0x8,%eax
  cprintf("  Base Class:0x%x  Sub Class:0x%x  Interface:0x%x  Revision ID:0x%x\n",
801080e1:	0f b6 d0             	movzbl %al,%edx
      data>>24,(data>>16)&0xFF,(data>>8)&0xFF,data&0xFF);
801080e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080e7:	c1 e8 10             	shr    $0x10,%eax
  cprintf("  Base Class:0x%x  Sub Class:0x%x  Interface:0x%x  Revision ID:0x%x\n",
801080ea:	0f b6 c0             	movzbl %al,%eax
801080ed:	8b 5d ec             	mov    -0x14(%ebp),%ebx
801080f0:	c1 eb 18             	shr    $0x18,%ebx
801080f3:	83 ec 0c             	sub    $0xc,%esp
801080f6:	51                   	push   %ecx
801080f7:	52                   	push   %edx
801080f8:	50                   	push   %eax
801080f9:	53                   	push   %ebx
801080fa:	68 9c bb 10 80       	push   $0x8010bb9c
801080ff:	e8 ed 82 ff ff       	call   801003f1 <cprintf>
80108104:	83 c4 20             	add    $0x20,%esp
  dev.base_class = data>>24;
80108107:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010810a:	c1 e8 18             	shr    $0x18,%eax
8010810d:	a2 70 5c 19 80       	mov    %al,0x80195c70
  dev.sub_class = (data>>16)&0xFF;
80108112:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108115:	c1 e8 10             	shr    $0x10,%eax
80108118:	a2 71 5c 19 80       	mov    %al,0x80195c71
  dev.interface = (data>>8)&0xFF;
8010811d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108120:	c1 e8 08             	shr    $0x8,%eax
80108123:	a2 72 5c 19 80       	mov    %al,0x80195c72
  dev.revision_id = data&0xFF;
80108128:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010812b:	a2 73 5c 19 80       	mov    %al,0x80195c73
  
  pci_access_config(bus_num,device_num,function_num,0x10,&data);
80108130:	83 ec 0c             	sub    $0xc,%esp
80108133:	8d 45 ec             	lea    -0x14(%ebp),%eax
80108136:	50                   	push   %eax
80108137:	6a 10                	push   $0x10
80108139:	ff 75 10             	pushl  0x10(%ebp)
8010813c:	ff 75 0c             	pushl  0xc(%ebp)
8010813f:	ff 75 08             	pushl  0x8(%ebp)
80108142:	e8 40 fe ff ff       	call   80107f87 <pci_access_config>
80108147:	83 c4 20             	add    $0x20,%esp
  dev.bar0 = data;
8010814a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010814d:	a3 74 5c 19 80       	mov    %eax,0x80195c74
  pci_access_config(bus_num,device_num,function_num,0x14,&data);
80108152:	83 ec 0c             	sub    $0xc,%esp
80108155:	8d 45 ec             	lea    -0x14(%ebp),%eax
80108158:	50                   	push   %eax
80108159:	6a 14                	push   $0x14
8010815b:	ff 75 10             	pushl  0x10(%ebp)
8010815e:	ff 75 0c             	pushl  0xc(%ebp)
80108161:	ff 75 08             	pushl  0x8(%ebp)
80108164:	e8 1e fe ff ff       	call   80107f87 <pci_access_config>
80108169:	83 c4 20             	add    $0x20,%esp
  dev.bar1 = data;
8010816c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010816f:	a3 78 5c 19 80       	mov    %eax,0x80195c78
  if(device_id == I8254_DEVICE_ID && vendor_id == I8254_VENDOR_ID){
80108174:	81 7d f4 0e 10 00 00 	cmpl   $0x100e,-0xc(%ebp)
8010817b:	75 5a                	jne    801081d7 <pci_init_device+0x1a5>
8010817d:	81 7d f0 86 80 00 00 	cmpl   $0x8086,-0x10(%ebp)
80108184:	75 51                	jne    801081d7 <pci_init_device+0x1a5>
    cprintf("E1000 Ethernet NIC Found\n");
80108186:	83 ec 0c             	sub    $0xc,%esp
80108189:	68 e1 bb 10 80       	push   $0x8010bbe1
8010818e:	e8 5e 82 ff ff       	call   801003f1 <cprintf>
80108193:	83 c4 10             	add    $0x10,%esp
    pci_access_config(bus_num,device_num,function_num,0xF0,&data);
80108196:	83 ec 0c             	sub    $0xc,%esp
80108199:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010819c:	50                   	push   %eax
8010819d:	68 f0 00 00 00       	push   $0xf0
801081a2:	ff 75 10             	pushl  0x10(%ebp)
801081a5:	ff 75 0c             	pushl  0xc(%ebp)
801081a8:	ff 75 08             	pushl  0x8(%ebp)
801081ab:	e8 d7 fd ff ff       	call   80107f87 <pci_access_config>
801081b0:	83 c4 20             	add    $0x20,%esp
    cprintf("Message Control:%x\n",data);
801081b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081b6:	83 ec 08             	sub    $0x8,%esp
801081b9:	50                   	push   %eax
801081ba:	68 fb bb 10 80       	push   $0x8010bbfb
801081bf:	e8 2d 82 ff ff       	call   801003f1 <cprintf>
801081c4:	83 c4 10             	add    $0x10,%esp
    i8254_init(&dev);
801081c7:	83 ec 0c             	sub    $0xc,%esp
801081ca:	68 64 5c 19 80       	push   $0x80195c64
801081cf:	e8 09 00 00 00       	call   801081dd <i8254_init>
801081d4:	83 c4 10             	add    $0x10,%esp
  }
}
801081d7:	90                   	nop
801081d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801081db:	c9                   	leave  
801081dc:	c3                   	ret    

801081dd <i8254_init>:

uint base_addr;
uchar mac_addr[6] = {0};
uchar my_ip[4] = {10,0,1,10}; 
uint *intr_addr;
void i8254_init(struct pci_dev *dev){
801081dd:	55                   	push   %ebp
801081de:	89 e5                	mov    %esp,%ebp
801081e0:	53                   	push   %ebx
801081e1:	83 ec 14             	sub    $0x14,%esp
  uint cmd_reg;
  //Enable Bus Master
  pci_access_config(dev->bus_num,dev->device_num,dev->function_num,0x04,&cmd_reg);
801081e4:	8b 45 08             	mov    0x8(%ebp),%eax
801081e7:	8a 40 02             	mov    0x2(%eax),%al
801081ea:	0f b6 c8             	movzbl %al,%ecx
801081ed:	8b 45 08             	mov    0x8(%ebp),%eax
801081f0:	8a 40 01             	mov    0x1(%eax),%al
801081f3:	0f b6 d0             	movzbl %al,%edx
801081f6:	8b 45 08             	mov    0x8(%ebp),%eax
801081f9:	8a 00                	mov    (%eax),%al
801081fb:	0f b6 c0             	movzbl %al,%eax
801081fe:	83 ec 0c             	sub    $0xc,%esp
80108201:	8d 5d ec             	lea    -0x14(%ebp),%ebx
80108204:	53                   	push   %ebx
80108205:	6a 04                	push   $0x4
80108207:	51                   	push   %ecx
80108208:	52                   	push   %edx
80108209:	50                   	push   %eax
8010820a:	e8 78 fd ff ff       	call   80107f87 <pci_access_config>
8010820f:	83 c4 20             	add    $0x20,%esp
  cmd_reg = cmd_reg | PCI_CMD_BUS_MASTER;
80108212:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108215:	83 c8 04             	or     $0x4,%eax
80108218:	89 45 ec             	mov    %eax,-0x14(%ebp)
  pci_write_config_register(dev->bus_num,dev->device_num,dev->function_num,0x04,cmd_reg);
8010821b:	8b 5d ec             	mov    -0x14(%ebp),%ebx
8010821e:	8b 45 08             	mov    0x8(%ebp),%eax
80108221:	8a 40 02             	mov    0x2(%eax),%al
80108224:	0f b6 c8             	movzbl %al,%ecx
80108227:	8b 45 08             	mov    0x8(%ebp),%eax
8010822a:	8a 40 01             	mov    0x1(%eax),%al
8010822d:	0f b6 d0             	movzbl %al,%edx
80108230:	8b 45 08             	mov    0x8(%ebp),%eax
80108233:	8a 00                	mov    (%eax),%al
80108235:	0f b6 c0             	movzbl %al,%eax
80108238:	83 ec 0c             	sub    $0xc,%esp
8010823b:	53                   	push   %ebx
8010823c:	6a 04                	push   $0x4
8010823e:	51                   	push   %ecx
8010823f:	52                   	push   %edx
80108240:	50                   	push   %eax
80108241:	e8 96 fd ff ff       	call   80107fdc <pci_write_config_register>
80108246:	83 c4 20             	add    $0x20,%esp
  
  base_addr = PCI_P2V(dev->bar0);
80108249:	8b 45 08             	mov    0x8(%ebp),%eax
8010824c:	8b 40 10             	mov    0x10(%eax),%eax
8010824f:	05 00 00 00 40       	add    $0x40000000,%eax
80108254:	a3 7c 5c 19 80       	mov    %eax,0x80195c7c
  uint *ctrl = (uint *)base_addr;
80108259:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
8010825e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  //Disable Interrupts
  uint *imc = (uint *)(base_addr+0xD8);
80108261:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108266:	05 d8 00 00 00       	add    $0xd8,%eax
8010826b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  *imc = 0xFFFFFFFF;
8010826e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108271:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  
  //Reset NIC
  *ctrl = *ctrl | I8254_CTRL_RST;
80108277:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010827a:	8b 00                	mov    (%eax),%eax
8010827c:	0d 00 00 00 04       	or     $0x4000000,%eax
80108281:	89 c2                	mov    %eax,%edx
80108283:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108286:	89 10                	mov    %edx,(%eax)

  //Enable Interrupts
  *imc = 0xFFFFFFFF;
80108288:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010828b:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)

  //Enable Link
  *ctrl |= I8254_CTRL_SLU;
80108291:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108294:	8b 00                	mov    (%eax),%eax
80108296:	83 c8 40             	or     $0x40,%eax
80108299:	89 c2                	mov    %eax,%edx
8010829b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010829e:	89 10                	mov    %edx,(%eax)
  
  //General Configuration
  *ctrl &= (~I8254_CTRL_PHY_RST | ~I8254_CTRL_VME | ~I8254_CTRL_ILOS);
801082a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082a3:	8b 10                	mov    (%eax),%edx
801082a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082a8:	89 10                	mov    %edx,(%eax)
  cprintf("E1000 General Configuration Done\n");
801082aa:	83 ec 0c             	sub    $0xc,%esp
801082ad:	68 10 bc 10 80       	push   $0x8010bc10
801082b2:	e8 3a 81 ff ff       	call   801003f1 <cprintf>
801082b7:	83 c4 10             	add    $0x10,%esp
  intr_addr = (uint *)kalloc();
801082ba:	e8 75 a4 ff ff       	call   80102734 <kalloc>
801082bf:	a3 88 5c 19 80       	mov    %eax,0x80195c88
  *intr_addr = 0;
801082c4:	a1 88 5c 19 80       	mov    0x80195c88,%eax
801082c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  cprintf("INTR_ADDR:%x\n",intr_addr);
801082cf:	a1 88 5c 19 80       	mov    0x80195c88,%eax
801082d4:	83 ec 08             	sub    $0x8,%esp
801082d7:	50                   	push   %eax
801082d8:	68 32 bc 10 80       	push   $0x8010bc32
801082dd:	e8 0f 81 ff ff       	call   801003f1 <cprintf>
801082e2:	83 c4 10             	add    $0x10,%esp
  i8254_init_recv();
801082e5:	e8 48 00 00 00       	call   80108332 <i8254_init_recv>
  i8254_init_send();
801082ea:	e8 50 03 00 00       	call   8010863f <i8254_init_send>
  cprintf("IP Address %d.%d.%d.%d\n",
      my_ip[0],
      my_ip[1],
      my_ip[2],
      my_ip[3]);
801082ef:	a0 e7 e4 10 80       	mov    0x8010e4e7,%al
  cprintf("IP Address %d.%d.%d.%d\n",
801082f4:	0f b6 d8             	movzbl %al,%ebx
      my_ip[2],
801082f7:	a0 e6 e4 10 80       	mov    0x8010e4e6,%al
  cprintf("IP Address %d.%d.%d.%d\n",
801082fc:	0f b6 c8             	movzbl %al,%ecx
      my_ip[1],
801082ff:	a0 e5 e4 10 80       	mov    0x8010e4e5,%al
  cprintf("IP Address %d.%d.%d.%d\n",
80108304:	0f b6 d0             	movzbl %al,%edx
      my_ip[0],
80108307:	a0 e4 e4 10 80       	mov    0x8010e4e4,%al
  cprintf("IP Address %d.%d.%d.%d\n",
8010830c:	0f b6 c0             	movzbl %al,%eax
8010830f:	83 ec 0c             	sub    $0xc,%esp
80108312:	53                   	push   %ebx
80108313:	51                   	push   %ecx
80108314:	52                   	push   %edx
80108315:	50                   	push   %eax
80108316:	68 40 bc 10 80       	push   $0x8010bc40
8010831b:	e8 d1 80 ff ff       	call   801003f1 <cprintf>
80108320:	83 c4 20             	add    $0x20,%esp
  *imc = 0x0;
80108323:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108326:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
8010832c:	90                   	nop
8010832d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108330:	c9                   	leave  
80108331:	c3                   	ret    

80108332 <i8254_init_recv>:

void i8254_init_recv(){
80108332:	55                   	push   %ebp
80108333:	89 e5                	mov    %esp,%ebp
80108335:	57                   	push   %edi
80108336:	56                   	push   %esi
80108337:	53                   	push   %ebx
80108338:	83 ec 6c             	sub    $0x6c,%esp
  
  uint data_l = i8254_read_eeprom(0x0);
8010833b:	83 ec 0c             	sub    $0xc,%esp
8010833e:	6a 00                	push   $0x0
80108340:	e8 d3 04 00 00       	call   80108818 <i8254_read_eeprom>
80108345:	83 c4 10             	add    $0x10,%esp
80108348:	89 45 d8             	mov    %eax,-0x28(%ebp)
  mac_addr[0] = data_l&0xFF;
8010834b:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010834e:	a2 80 5c 19 80       	mov    %al,0x80195c80
  mac_addr[1] = data_l>>8;
80108353:	8b 45 d8             	mov    -0x28(%ebp),%eax
80108356:	c1 e8 08             	shr    $0x8,%eax
80108359:	a2 81 5c 19 80       	mov    %al,0x80195c81
  uint data_m = i8254_read_eeprom(0x1);
8010835e:	83 ec 0c             	sub    $0xc,%esp
80108361:	6a 01                	push   $0x1
80108363:	e8 b0 04 00 00       	call   80108818 <i8254_read_eeprom>
80108368:	83 c4 10             	add    $0x10,%esp
8010836b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  mac_addr[2] = data_m&0xFF;
8010836e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80108371:	a2 82 5c 19 80       	mov    %al,0x80195c82
  mac_addr[3] = data_m>>8;
80108376:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80108379:	c1 e8 08             	shr    $0x8,%eax
8010837c:	a2 83 5c 19 80       	mov    %al,0x80195c83
  uint data_h = i8254_read_eeprom(0x2);
80108381:	83 ec 0c             	sub    $0xc,%esp
80108384:	6a 02                	push   $0x2
80108386:	e8 8d 04 00 00       	call   80108818 <i8254_read_eeprom>
8010838b:	83 c4 10             	add    $0x10,%esp
8010838e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  mac_addr[4] = data_h&0xFF;
80108391:	8b 45 d0             	mov    -0x30(%ebp),%eax
80108394:	a2 84 5c 19 80       	mov    %al,0x80195c84
  mac_addr[5] = data_h>>8;
80108399:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010839c:	c1 e8 08             	shr    $0x8,%eax
8010839f:	a2 85 5c 19 80       	mov    %al,0x80195c85
      mac_addr[0],
      mac_addr[1],
      mac_addr[2],
      mac_addr[3],
      mac_addr[4],
      mac_addr[5]);
801083a4:	a0 85 5c 19 80       	mov    0x80195c85,%al
  cprintf("MAC Address %x:%x:%x:%x:%x:%x\n",
801083a9:	0f b6 f8             	movzbl %al,%edi
      mac_addr[4],
801083ac:	a0 84 5c 19 80       	mov    0x80195c84,%al
  cprintf("MAC Address %x:%x:%x:%x:%x:%x\n",
801083b1:	0f b6 f0             	movzbl %al,%esi
      mac_addr[3],
801083b4:	a0 83 5c 19 80       	mov    0x80195c83,%al
  cprintf("MAC Address %x:%x:%x:%x:%x:%x\n",
801083b9:	0f b6 d8             	movzbl %al,%ebx
      mac_addr[2],
801083bc:	a0 82 5c 19 80       	mov    0x80195c82,%al
  cprintf("MAC Address %x:%x:%x:%x:%x:%x\n",
801083c1:	0f b6 c8             	movzbl %al,%ecx
      mac_addr[1],
801083c4:	a0 81 5c 19 80       	mov    0x80195c81,%al
  cprintf("MAC Address %x:%x:%x:%x:%x:%x\n",
801083c9:	0f b6 d0             	movzbl %al,%edx
      mac_addr[0],
801083cc:	a0 80 5c 19 80       	mov    0x80195c80,%al
  cprintf("MAC Address %x:%x:%x:%x:%x:%x\n",
801083d1:	0f b6 c0             	movzbl %al,%eax
801083d4:	83 ec 04             	sub    $0x4,%esp
801083d7:	57                   	push   %edi
801083d8:	56                   	push   %esi
801083d9:	53                   	push   %ebx
801083da:	51                   	push   %ecx
801083db:	52                   	push   %edx
801083dc:	50                   	push   %eax
801083dd:	68 58 bc 10 80       	push   $0x8010bc58
801083e2:	e8 0a 80 ff ff       	call   801003f1 <cprintf>
801083e7:	83 c4 20             	add    $0x20,%esp

  uint *ral = (uint *)(base_addr + 0x5400);
801083ea:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801083ef:	05 00 54 00 00       	add    $0x5400,%eax
801083f4:	89 45 cc             	mov    %eax,-0x34(%ebp)
  uint *rah = (uint *)(base_addr + 0x5404);
801083f7:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801083fc:	05 04 54 00 00       	add    $0x5404,%eax
80108401:	89 45 c8             	mov    %eax,-0x38(%ebp)

  *ral = (data_l | (data_m << 16));
80108404:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80108407:	c1 e0 10             	shl    $0x10,%eax
8010840a:	0b 45 d8             	or     -0x28(%ebp),%eax
8010840d:	89 c2                	mov    %eax,%edx
8010840f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80108412:	89 10                	mov    %edx,(%eax)
  *rah = (data_h | I8254_RAH_AS_DEST | I8254_RAH_AV);
80108414:	8b 45 d0             	mov    -0x30(%ebp),%eax
80108417:	0d 00 00 00 80       	or     $0x80000000,%eax
8010841c:	89 c2                	mov    %eax,%edx
8010841e:	8b 45 c8             	mov    -0x38(%ebp),%eax
80108421:	89 10                	mov    %edx,(%eax)

  uint *mta = (uint *)(base_addr + 0x5200);
80108423:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108428:	05 00 52 00 00       	add    $0x5200,%eax
8010842d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  for(int i=0;i<128;i++){
80108430:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80108437:	eb 18                	jmp    80108451 <i8254_init_recv+0x11f>
    mta[i] = 0;
80108439:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010843c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108443:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80108446:	01 d0                	add    %edx,%eax
80108448:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(int i=0;i<128;i++){
8010844e:	ff 45 e4             	incl   -0x1c(%ebp)
80108451:	83 7d e4 7f          	cmpl   $0x7f,-0x1c(%ebp)
80108455:	7e e2                	jle    80108439 <i8254_init_recv+0x107>
  }

  uint *ims = (uint *)(base_addr + 0xD0);
80108457:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
8010845c:	05 d0 00 00 00       	add    $0xd0,%eax
80108461:	89 45 c0             	mov    %eax,-0x40(%ebp)
  *ims = (I8254_IMS_RXT0 | I8254_IMS_RXDMT0 | I8254_IMS_RXSEQ | I8254_IMS_LSC | I8254_IMS_RXO);
80108464:	8b 45 c0             	mov    -0x40(%ebp),%eax
80108467:	c7 00 dc 00 00 00    	movl   $0xdc,(%eax)
  uint *ics = (uint *)(base_addr + 0xC8);
8010846d:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108472:	05 c8 00 00 00       	add    $0xc8,%eax
80108477:	89 45 bc             	mov    %eax,-0x44(%ebp)
  *ics = (I8254_IMS_RXT0 | I8254_IMS_RXDMT0 | I8254_IMS_RXSEQ | I8254_IMS_LSC | I8254_IMS_RXO);
8010847a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010847d:	c7 00 dc 00 00 00    	movl   $0xdc,(%eax)



  uint *rxdctl = (uint *)(base_addr + 0x2828);
80108483:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108488:	05 28 28 00 00       	add    $0x2828,%eax
8010848d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  *rxdctl = 0;
80108490:	8b 45 b8             	mov    -0x48(%ebp),%eax
80108493:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  uint *rctl = (uint *)(base_addr + 0x100);
80108499:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
8010849e:	05 00 01 00 00       	add    $0x100,%eax
801084a3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  *rctl = (I8254_RCTL_UPE | I8254_RCTL_MPE | I8254_RCTL_BAM | I8254_RCTL_BSIZE | I8254_RCTL_SECRC);
801084a6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801084a9:	c7 00 18 80 00 04    	movl   $0x4008018,(%eax)

  uint recv_desc_addr = (uint)kalloc();
801084af:	e8 80 a2 ff ff       	call   80102734 <kalloc>
801084b4:	89 45 b0             	mov    %eax,-0x50(%ebp)
  uint *rdbal = (uint *)(base_addr + 0x2800);
801084b7:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801084bc:	05 00 28 00 00       	add    $0x2800,%eax
801084c1:	89 45 ac             	mov    %eax,-0x54(%ebp)
  uint *rdbah = (uint *)(base_addr + 0x2804);
801084c4:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801084c9:	05 04 28 00 00       	add    $0x2804,%eax
801084ce:	89 45 a8             	mov    %eax,-0x58(%ebp)
  uint *rdlen = (uint *)(base_addr + 0x2808);
801084d1:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801084d6:	05 08 28 00 00       	add    $0x2808,%eax
801084db:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  uint *rdh = (uint *)(base_addr + 0x2810);
801084de:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801084e3:	05 10 28 00 00       	add    $0x2810,%eax
801084e8:	89 45 a0             	mov    %eax,-0x60(%ebp)
  uint *rdt = (uint *)(base_addr + 0x2818);
801084eb:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801084f0:	05 18 28 00 00       	add    $0x2818,%eax
801084f5:	89 45 9c             	mov    %eax,-0x64(%ebp)

  *rdbal = V2P(recv_desc_addr);
801084f8:	8b 45 b0             	mov    -0x50(%ebp),%eax
801084fb:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80108501:	8b 45 ac             	mov    -0x54(%ebp),%eax
80108504:	89 10                	mov    %edx,(%eax)
  *rdbah = 0;
80108506:	8b 45 a8             	mov    -0x58(%ebp),%eax
80108509:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  *rdlen = sizeof(struct i8254_recv_desc)*I8254_RECV_DESC_NUM;
8010850f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80108512:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  *rdh = 0;
80108518:	8b 45 a0             	mov    -0x60(%ebp),%eax
8010851b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  *rdt = I8254_RECV_DESC_NUM;
80108521:	8b 45 9c             	mov    -0x64(%ebp),%eax
80108524:	c7 00 00 01 00 00    	movl   $0x100,(%eax)

  struct i8254_recv_desc *recv_desc = (struct i8254_recv_desc *)recv_desc_addr;
8010852a:	8b 45 b0             	mov    -0x50(%ebp),%eax
8010852d:	89 45 98             	mov    %eax,-0x68(%ebp)
  for(int i=0;i<I8254_RECV_DESC_NUM;i++){
80108530:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80108537:	eb 72                	jmp    801085ab <i8254_init_recv+0x279>
    recv_desc[i].padding = 0;
80108539:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010853c:	c1 e0 04             	shl    $0x4,%eax
8010853f:	89 c2                	mov    %eax,%edx
80108541:	8b 45 98             	mov    -0x68(%ebp),%eax
80108544:	01 d0                	add    %edx,%eax
80108546:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    recv_desc[i].len = 0;
8010854d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108550:	c1 e0 04             	shl    $0x4,%eax
80108553:	89 c2                	mov    %eax,%edx
80108555:	8b 45 98             	mov    -0x68(%ebp),%eax
80108558:	01 d0                	add    %edx,%eax
8010855a:	66 c7 40 08 00 00    	movw   $0x0,0x8(%eax)
    recv_desc[i].chk_sum = 0;
80108560:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108563:	c1 e0 04             	shl    $0x4,%eax
80108566:	89 c2                	mov    %eax,%edx
80108568:	8b 45 98             	mov    -0x68(%ebp),%eax
8010856b:	01 d0                	add    %edx,%eax
8010856d:	66 c7 40 0a 00 00    	movw   $0x0,0xa(%eax)
    recv_desc[i].status = 0;
80108573:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108576:	c1 e0 04             	shl    $0x4,%eax
80108579:	89 c2                	mov    %eax,%edx
8010857b:	8b 45 98             	mov    -0x68(%ebp),%eax
8010857e:	01 d0                	add    %edx,%eax
80108580:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
    recv_desc[i].errors = 0;
80108584:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108587:	c1 e0 04             	shl    $0x4,%eax
8010858a:	89 c2                	mov    %eax,%edx
8010858c:	8b 45 98             	mov    -0x68(%ebp),%eax
8010858f:	01 d0                	add    %edx,%eax
80108591:	c6 40 0d 00          	movb   $0x0,0xd(%eax)
    recv_desc[i].special = 0;
80108595:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108598:	c1 e0 04             	shl    $0x4,%eax
8010859b:	89 c2                	mov    %eax,%edx
8010859d:	8b 45 98             	mov    -0x68(%ebp),%eax
801085a0:	01 d0                	add    %edx,%eax
801085a2:	66 c7 40 0e 00 00    	movw   $0x0,0xe(%eax)
  for(int i=0;i<I8254_RECV_DESC_NUM;i++){
801085a8:	ff 45 e0             	incl   -0x20(%ebp)
801085ab:	81 7d e0 ff 00 00 00 	cmpl   $0xff,-0x20(%ebp)
801085b2:	7e 85                	jle    80108539 <i8254_init_recv+0x207>
  }

  for(int i=0;i<(I8254_RECV_DESC_NUM)/2;i++){
801085b4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
801085bb:	eb 54                	jmp    80108611 <i8254_init_recv+0x2df>
    uint buf_addr = (uint)kalloc();
801085bd:	e8 72 a1 ff ff       	call   80102734 <kalloc>
801085c2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    if(buf_addr == 0){
801085c5:	83 7d 94 00          	cmpl   $0x0,-0x6c(%ebp)
801085c9:	75 12                	jne    801085dd <i8254_init_recv+0x2ab>
      cprintf("failed to allocate buffer area\n");
801085cb:	83 ec 0c             	sub    $0xc,%esp
801085ce:	68 78 bc 10 80       	push   $0x8010bc78
801085d3:	e8 19 7e ff ff       	call   801003f1 <cprintf>
801085d8:	83 c4 10             	add    $0x10,%esp
      break;
801085db:	eb 3a                	jmp    80108617 <i8254_init_recv+0x2e5>
    }
    recv_desc[i].buf_addr = V2P(buf_addr);
801085dd:	8b 45 dc             	mov    -0x24(%ebp),%eax
801085e0:	c1 e0 04             	shl    $0x4,%eax
801085e3:	89 c2                	mov    %eax,%edx
801085e5:	8b 45 98             	mov    -0x68(%ebp),%eax
801085e8:	01 d0                	add    %edx,%eax
801085ea:	8b 55 94             	mov    -0x6c(%ebp),%edx
801085ed:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801085f3:	89 10                	mov    %edx,(%eax)
    recv_desc[i+1].buf_addr = V2P(buf_addr + 0x800);
801085f5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801085f8:	40                   	inc    %eax
801085f9:	c1 e0 04             	shl    $0x4,%eax
801085fc:	89 c2                	mov    %eax,%edx
801085fe:	8b 45 98             	mov    -0x68(%ebp),%eax
80108601:	01 d0                	add    %edx,%eax
80108603:	8b 55 94             	mov    -0x6c(%ebp),%edx
80108606:	81 ea 00 f8 ff 7f    	sub    $0x7ffff800,%edx
8010860c:	89 10                	mov    %edx,(%eax)
  for(int i=0;i<(I8254_RECV_DESC_NUM)/2;i++){
8010860e:	ff 45 dc             	incl   -0x24(%ebp)
80108611:	83 7d dc 7f          	cmpl   $0x7f,-0x24(%ebp)
80108615:	7e a6                	jle    801085bd <i8254_init_recv+0x28b>
  }

  *rctl |= I8254_RCTL_EN;
80108617:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010861a:	8b 00                	mov    (%eax),%eax
8010861c:	83 c8 02             	or     $0x2,%eax
8010861f:	89 c2                	mov    %eax,%edx
80108621:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80108624:	89 10                	mov    %edx,(%eax)
  cprintf("E1000 Recieve Initialize Done\n");
80108626:	83 ec 0c             	sub    $0xc,%esp
80108629:	68 98 bc 10 80       	push   $0x8010bc98
8010862e:	e8 be 7d ff ff       	call   801003f1 <cprintf>
80108633:	83 c4 10             	add    $0x10,%esp
}
80108636:	90                   	nop
80108637:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010863a:	5b                   	pop    %ebx
8010863b:	5e                   	pop    %esi
8010863c:	5f                   	pop    %edi
8010863d:	5d                   	pop    %ebp
8010863e:	c3                   	ret    

8010863f <i8254_init_send>:

void i8254_init_send(){
8010863f:	55                   	push   %ebp
80108640:	89 e5                	mov    %esp,%ebp
80108642:	83 ec 48             	sub    $0x48,%esp
  uint *txdctl = (uint *)(base_addr + 0x3828);
80108645:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
8010864a:	05 28 38 00 00       	add    $0x3828,%eax
8010864f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  *txdctl = (I8254_TXDCTL_WTHRESH | I8254_TXDCTL_GRAN_DESC);
80108652:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108655:	c7 00 00 00 01 01    	movl   $0x1010000,(%eax)

  uint tx_desc_addr = (uint)kalloc();
8010865b:	e8 d4 a0 ff ff       	call   80102734 <kalloc>
80108660:	89 45 e8             	mov    %eax,-0x18(%ebp)
  uint *tdbal = (uint *)(base_addr + 0x3800);
80108663:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108668:	05 00 38 00 00       	add    $0x3800,%eax
8010866d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  uint *tdbah = (uint *)(base_addr + 0x3804);
80108670:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108675:	05 04 38 00 00       	add    $0x3804,%eax
8010867a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  uint *tdlen = (uint *)(base_addr + 0x3808);
8010867d:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108682:	05 08 38 00 00       	add    $0x3808,%eax
80108687:	89 45 dc             	mov    %eax,-0x24(%ebp)

  *tdbal = V2P(tx_desc_addr);
8010868a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010868d:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80108693:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108696:	89 10                	mov    %edx,(%eax)
  *tdbah = 0;
80108698:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010869b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  *tdlen = sizeof(struct i8254_send_desc)*I8254_SEND_DESC_NUM;
801086a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801086a4:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  uint *tdh = (uint *)(base_addr + 0x3810);
801086aa:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801086af:	05 10 38 00 00       	add    $0x3810,%eax
801086b4:	89 45 d8             	mov    %eax,-0x28(%ebp)
  uint *tdt = (uint *)(base_addr + 0x3818);
801086b7:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801086bc:	05 18 38 00 00       	add    $0x3818,%eax
801086c1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  
  *tdh = 0;
801086c4:	8b 45 d8             	mov    -0x28(%ebp),%eax
801086c7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  *tdt = 0;
801086cd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801086d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  struct i8254_send_desc *send_desc = (struct i8254_send_desc *)tx_desc_addr;
801086d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
801086d9:	89 45 d0             	mov    %eax,-0x30(%ebp)
  for(int i=0;i<I8254_SEND_DESC_NUM;i++){
801086dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801086e3:	e9 81 00 00 00       	jmp    80108769 <i8254_init_send+0x12a>
    send_desc[i].padding = 0;
801086e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086eb:	c1 e0 04             	shl    $0x4,%eax
801086ee:	89 c2                	mov    %eax,%edx
801086f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
801086f3:	01 d0                	add    %edx,%eax
801086f5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    send_desc[i].len = 0;
801086fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086ff:	c1 e0 04             	shl    $0x4,%eax
80108702:	89 c2                	mov    %eax,%edx
80108704:	8b 45 d0             	mov    -0x30(%ebp),%eax
80108707:	01 d0                	add    %edx,%eax
80108709:	66 c7 40 08 00 00    	movw   $0x0,0x8(%eax)
    send_desc[i].cso = 0;
8010870f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108712:	c1 e0 04             	shl    $0x4,%eax
80108715:	89 c2                	mov    %eax,%edx
80108717:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010871a:	01 d0                	add    %edx,%eax
8010871c:	c6 40 0a 00          	movb   $0x0,0xa(%eax)
    send_desc[i].cmd = 0;
80108720:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108723:	c1 e0 04             	shl    $0x4,%eax
80108726:	89 c2                	mov    %eax,%edx
80108728:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010872b:	01 d0                	add    %edx,%eax
8010872d:	c6 40 0b 00          	movb   $0x0,0xb(%eax)
    send_desc[i].sta = 0;
80108731:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108734:	c1 e0 04             	shl    $0x4,%eax
80108737:	89 c2                	mov    %eax,%edx
80108739:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010873c:	01 d0                	add    %edx,%eax
8010873e:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
    send_desc[i].css = 0;
80108742:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108745:	c1 e0 04             	shl    $0x4,%eax
80108748:	89 c2                	mov    %eax,%edx
8010874a:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010874d:	01 d0                	add    %edx,%eax
8010874f:	c6 40 0d 00          	movb   $0x0,0xd(%eax)
    send_desc[i].special = 0;
80108753:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108756:	c1 e0 04             	shl    $0x4,%eax
80108759:	89 c2                	mov    %eax,%edx
8010875b:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010875e:	01 d0                	add    %edx,%eax
80108760:	66 c7 40 0e 00 00    	movw   $0x0,0xe(%eax)
  for(int i=0;i<I8254_SEND_DESC_NUM;i++){
80108766:	ff 45 f4             	incl   -0xc(%ebp)
80108769:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80108770:	0f 8e 72 ff ff ff    	jle    801086e8 <i8254_init_send+0xa9>
  }

  for(int i=0;i<(I8254_SEND_DESC_NUM)/2;i++){
80108776:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010877d:	eb 54                	jmp    801087d3 <i8254_init_send+0x194>
    uint buf_addr = (uint)kalloc();
8010877f:	e8 b0 9f ff ff       	call   80102734 <kalloc>
80108784:	89 45 cc             	mov    %eax,-0x34(%ebp)
    if(buf_addr == 0){
80108787:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
8010878b:	75 12                	jne    8010879f <i8254_init_send+0x160>
      cprintf("failed to allocate buffer area\n");
8010878d:	83 ec 0c             	sub    $0xc,%esp
80108790:	68 78 bc 10 80       	push   $0x8010bc78
80108795:	e8 57 7c ff ff       	call   801003f1 <cprintf>
8010879a:	83 c4 10             	add    $0x10,%esp
      break;
8010879d:	eb 3a                	jmp    801087d9 <i8254_init_send+0x19a>
    }
    send_desc[i].buf_addr = V2P(buf_addr);
8010879f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801087a2:	c1 e0 04             	shl    $0x4,%eax
801087a5:	89 c2                	mov    %eax,%edx
801087a7:	8b 45 d0             	mov    -0x30(%ebp),%eax
801087aa:	01 d0                	add    %edx,%eax
801087ac:	8b 55 cc             	mov    -0x34(%ebp),%edx
801087af:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801087b5:	89 10                	mov    %edx,(%eax)
    send_desc[i+1].buf_addr = V2P(buf_addr + 0x800);
801087b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801087ba:	40                   	inc    %eax
801087bb:	c1 e0 04             	shl    $0x4,%eax
801087be:	89 c2                	mov    %eax,%edx
801087c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
801087c3:	01 d0                	add    %edx,%eax
801087c5:	8b 55 cc             	mov    -0x34(%ebp),%edx
801087c8:	81 ea 00 f8 ff 7f    	sub    $0x7ffff800,%edx
801087ce:	89 10                	mov    %edx,(%eax)
  for(int i=0;i<(I8254_SEND_DESC_NUM)/2;i++){
801087d0:	ff 45 f0             	incl   -0x10(%ebp)
801087d3:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
801087d7:	7e a6                	jle    8010877f <i8254_init_send+0x140>
  }

  uint *tctl = (uint *)(base_addr + 0x400);
801087d9:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801087de:	05 00 04 00 00       	add    $0x400,%eax
801087e3:	89 45 c8             	mov    %eax,-0x38(%ebp)
  *tctl = (I8254_TCTL_EN | I8254_TCTL_PSP | I8254_TCTL_COLD | I8254_TCTL_CT);
801087e6:	8b 45 c8             	mov    -0x38(%ebp),%eax
801087e9:	c7 00 fa 00 04 00    	movl   $0x400fa,(%eax)

  uint *tipg = (uint *)(base_addr + 0x410);
801087ef:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
801087f4:	05 10 04 00 00       	add    $0x410,%eax
801087f9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  *tipg = (10 | (10<<10) | (10<<20));
801087fc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801087ff:	c7 00 0a 28 a0 00    	movl   $0xa0280a,(%eax)
  cprintf("E1000 Transmit Initialize Done\n");
80108805:	83 ec 0c             	sub    $0xc,%esp
80108808:	68 b8 bc 10 80       	push   $0x8010bcb8
8010880d:	e8 df 7b ff ff       	call   801003f1 <cprintf>
80108812:	83 c4 10             	add    $0x10,%esp

}
80108815:	90                   	nop
80108816:	c9                   	leave  
80108817:	c3                   	ret    

80108818 <i8254_read_eeprom>:
uint i8254_read_eeprom(uint addr){
80108818:	55                   	push   %ebp
80108819:	89 e5                	mov    %esp,%ebp
8010881b:	83 ec 18             	sub    $0x18,%esp
  uint *eerd = (uint *)(base_addr + 0x14);
8010881e:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108823:	83 c0 14             	add    $0x14,%eax
80108826:	89 45 f4             	mov    %eax,-0xc(%ebp)
  *eerd = (((addr & 0xFF) << 8) | 1);
80108829:	8b 45 08             	mov    0x8(%ebp),%eax
8010882c:	c1 e0 08             	shl    $0x8,%eax
8010882f:	0f b7 c0             	movzwl %ax,%eax
80108832:	83 c8 01             	or     $0x1,%eax
80108835:	89 c2                	mov    %eax,%edx
80108837:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010883a:	89 10                	mov    %edx,(%eax)
  while(1){
    cprintf("");
8010883c:	83 ec 0c             	sub    $0xc,%esp
8010883f:	68 d8 bc 10 80       	push   $0x8010bcd8
80108844:	e8 a8 7b ff ff       	call   801003f1 <cprintf>
80108849:	83 c4 10             	add    $0x10,%esp
    volatile uint data = *eerd;
8010884c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010884f:	8b 00                	mov    (%eax),%eax
80108851:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((data & (1<<4)) != 0){
80108854:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108857:	83 e0 10             	and    $0x10,%eax
8010885a:	85 c0                	test   %eax,%eax
8010885c:	75 02                	jne    80108860 <i8254_read_eeprom+0x48>
  while(1){
8010885e:	eb dc                	jmp    8010883c <i8254_read_eeprom+0x24>
      break;
80108860:	90                   	nop
    }
  }

  return (*eerd >> 16) & 0xFFFF;
80108861:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108864:	8b 00                	mov    (%eax),%eax
80108866:	c1 e8 10             	shr    $0x10,%eax
}
80108869:	c9                   	leave  
8010886a:	c3                   	ret    

8010886b <i8254_recv>:
void i8254_recv(){
8010886b:	55                   	push   %ebp
8010886c:	89 e5                	mov    %esp,%ebp
8010886e:	83 ec 28             	sub    $0x28,%esp
  uint *rdh = (uint *)(base_addr + 0x2810);
80108871:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108876:	05 10 28 00 00       	add    $0x2810,%eax
8010887b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint *rdt = (uint *)(base_addr + 0x2818);
8010887e:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108883:	05 18 28 00 00       	add    $0x2818,%eax
80108888:	89 45 f0             	mov    %eax,-0x10(%ebp)
//  uint *torl = (uint *)(base_addr + 0x40C0);
//  uint *tpr = (uint *)(base_addr + 0x40D0);
//  uint *icr = (uint *)(base_addr + 0xC0);
  uint *rdbal = (uint *)(base_addr + 0x2800);
8010888b:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108890:	05 00 28 00 00       	add    $0x2800,%eax
80108895:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct i8254_recv_desc *recv_desc = (struct i8254_recv_desc *)(P2V(*rdbal));
80108898:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010889b:	8b 00                	mov    (%eax),%eax
8010889d:	05 00 00 00 80       	add    $0x80000000,%eax
801088a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  while(1){
    int rx_available = (I8254_RECV_DESC_NUM - *rdt + *rdh)%I8254_RECV_DESC_NUM;
801088a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088a8:	8b 10                	mov    (%eax),%edx
801088aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088ad:	8b 00                	mov    (%eax),%eax
801088af:	29 c2                	sub    %eax,%edx
801088b1:	89 d0                	mov    %edx,%eax
801088b3:	25 ff 00 00 00       	and    $0xff,%eax
801088b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(rx_available > 0){
801088bb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
801088bf:	7e 35                	jle    801088f6 <i8254_recv+0x8b>
      uint buffer_addr = P2V_WO(recv_desc[*rdt].buf_addr);
801088c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088c4:	8b 00                	mov    (%eax),%eax
801088c6:	c1 e0 04             	shl    $0x4,%eax
801088c9:	89 c2                	mov    %eax,%edx
801088cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801088ce:	01 d0                	add    %edx,%eax
801088d0:	8b 00                	mov    (%eax),%eax
801088d2:	05 00 00 00 80       	add    $0x80000000,%eax
801088d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      *rdt = (*rdt + 1)%I8254_RECV_DESC_NUM;
801088da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088dd:	8b 00                	mov    (%eax),%eax
801088df:	40                   	inc    %eax
801088e0:	0f b6 d0             	movzbl %al,%edx
801088e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088e6:	89 10                	mov    %edx,(%eax)
      eth_proc(buffer_addr);
801088e8:	83 ec 0c             	sub    $0xc,%esp
801088eb:	ff 75 e0             	pushl  -0x20(%ebp)
801088ee:	e8 f9 08 00 00       	call   801091ec <eth_proc>
801088f3:	83 c4 10             	add    $0x10,%esp
    }
    if(*rdt == *rdh) {
801088f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088f9:	8b 10                	mov    (%eax),%edx
801088fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088fe:	8b 00                	mov    (%eax),%eax
80108900:	39 c2                	cmp    %eax,%edx
80108902:	75 a1                	jne    801088a5 <i8254_recv+0x3a>
      (*rdt)--;
80108904:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108907:	8b 00                	mov    (%eax),%eax
80108909:	8d 50 ff             	lea    -0x1(%eax),%edx
8010890c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010890f:	89 10                	mov    %edx,(%eax)
  while(1){
80108911:	eb 92                	jmp    801088a5 <i8254_recv+0x3a>

80108913 <i8254_send>:
    }
  }
}

int i8254_send(const uint pkt_addr,uint len){
80108913:	55                   	push   %ebp
80108914:	89 e5                	mov    %esp,%ebp
80108916:	83 ec 28             	sub    $0x28,%esp
  uint *tdh = (uint *)(base_addr + 0x3810);
80108919:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
8010891e:	05 10 38 00 00       	add    $0x3810,%eax
80108923:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint *tdt = (uint *)(base_addr + 0x3818);
80108926:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
8010892b:	05 18 38 00 00       	add    $0x3818,%eax
80108930:	89 45 f0             	mov    %eax,-0x10(%ebp)
  uint *tdbal = (uint *)(base_addr + 0x3800);
80108933:	a1 7c 5c 19 80       	mov    0x80195c7c,%eax
80108938:	05 00 38 00 00       	add    $0x3800,%eax
8010893d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct i8254_send_desc *txdesc = (struct i8254_send_desc *)P2V_WO(*tdbal);
80108940:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108943:	8b 00                	mov    (%eax),%eax
80108945:	05 00 00 00 80       	add    $0x80000000,%eax
8010894a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  int tx_available = I8254_SEND_DESC_NUM - ((I8254_SEND_DESC_NUM - *tdh + *tdt) % I8254_SEND_DESC_NUM);
8010894d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108950:	8b 10                	mov    (%eax),%edx
80108952:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108955:	8b 00                	mov    (%eax),%eax
80108957:	29 c2                	sub    %eax,%edx
80108959:	0f b6 c2             	movzbl %dl,%eax
8010895c:	ba 00 01 00 00       	mov    $0x100,%edx
80108961:	29 c2                	sub    %eax,%edx
80108963:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  uint index = *tdt%I8254_SEND_DESC_NUM;
80108966:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108969:	8b 00                	mov    (%eax),%eax
8010896b:	25 ff 00 00 00       	and    $0xff,%eax
80108970:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(tx_available > 0) {
80108973:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80108977:	0f 8e a6 00 00 00    	jle    80108a23 <i8254_send+0x110>
    memmove(P2V_WO((void *)txdesc[index].buf_addr),(void *)pkt_addr,len);
8010897d:	8b 45 08             	mov    0x8(%ebp),%eax
80108980:	8b 55 e0             	mov    -0x20(%ebp),%edx
80108983:	89 d1                	mov    %edx,%ecx
80108985:	c1 e1 04             	shl    $0x4,%ecx
80108988:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010898b:	01 ca                	add    %ecx,%edx
8010898d:	8b 12                	mov    (%edx),%edx
8010898f:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80108995:	83 ec 04             	sub    $0x4,%esp
80108998:	ff 75 0c             	pushl  0xc(%ebp)
8010899b:	50                   	push   %eax
8010899c:	52                   	push   %edx
8010899d:	e8 1c c0 ff ff       	call   801049be <memmove>
801089a2:	83 c4 10             	add    $0x10,%esp
    txdesc[index].len = len;
801089a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801089a8:	c1 e0 04             	shl    $0x4,%eax
801089ab:	89 c2                	mov    %eax,%edx
801089ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
801089b0:	01 c2                	add    %eax,%edx
801089b2:	8b 45 0c             	mov    0xc(%ebp),%eax
801089b5:	66 89 42 08          	mov    %ax,0x8(%edx)
    txdesc[index].sta = 0;
801089b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801089bc:	c1 e0 04             	shl    $0x4,%eax
801089bf:	89 c2                	mov    %eax,%edx
801089c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801089c4:	01 d0                	add    %edx,%eax
801089c6:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
    txdesc[index].css = 0;
801089ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
801089cd:	c1 e0 04             	shl    $0x4,%eax
801089d0:	89 c2                	mov    %eax,%edx
801089d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
801089d5:	01 d0                	add    %edx,%eax
801089d7:	c6 40 0d 00          	movb   $0x0,0xd(%eax)
    txdesc[index].cmd = 0xb;
801089db:	8b 45 e0             	mov    -0x20(%ebp),%eax
801089de:	c1 e0 04             	shl    $0x4,%eax
801089e1:	89 c2                	mov    %eax,%edx
801089e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801089e6:	01 d0                	add    %edx,%eax
801089e8:	c6 40 0b 0b          	movb   $0xb,0xb(%eax)
    txdesc[index].special = 0;
801089ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
801089ef:	c1 e0 04             	shl    $0x4,%eax
801089f2:	89 c2                	mov    %eax,%edx
801089f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
801089f7:	01 d0                	add    %edx,%eax
801089f9:	66 c7 40 0e 00 00    	movw   $0x0,0xe(%eax)
    txdesc[index].cso = 0;
801089ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108a02:	c1 e0 04             	shl    $0x4,%eax
80108a05:	89 c2                	mov    %eax,%edx
80108a07:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108a0a:	01 d0                	add    %edx,%eax
80108a0c:	c6 40 0a 00          	movb   $0x0,0xa(%eax)
    *tdt = (*tdt + 1)%I8254_SEND_DESC_NUM;
80108a10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108a13:	8b 00                	mov    (%eax),%eax
80108a15:	40                   	inc    %eax
80108a16:	0f b6 d0             	movzbl %al,%edx
80108a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108a1c:	89 10                	mov    %edx,(%eax)
    return len;
80108a1e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108a21:	eb 05                	jmp    80108a28 <i8254_send+0x115>
  }else{
    return -1;
80108a23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80108a28:	c9                   	leave  
80108a29:	c3                   	ret    

80108a2a <i8254_intr>:

void i8254_intr(){
80108a2a:	55                   	push   %ebp
80108a2b:	89 e5                	mov    %esp,%ebp
  *intr_addr = 0xEEEEEE;
80108a2d:	a1 88 5c 19 80       	mov    0x80195c88,%eax
80108a32:	c7 00 ee ee ee 00    	movl   $0xeeeeee,(%eax)
}
80108a38:	90                   	nop
80108a39:	5d                   	pop    %ebp
80108a3a:	c3                   	ret    

80108a3b <arp_proc>:
extern uchar mac_addr[6];
extern uchar my_ip[4];

struct arp_entry arp_table[ARP_TABLE_MAX] = {0};

int arp_proc(uint buffer_addr){
80108a3b:	55                   	push   %ebp
80108a3c:	89 e5                	mov    %esp,%ebp
80108a3e:	83 ec 18             	sub    $0x18,%esp
  struct arp_pkt *arp_p = (struct arp_pkt *)(buffer_addr);
80108a41:	8b 45 08             	mov    0x8(%ebp),%eax
80108a44:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(arp_p->hrd_type != ARP_HARDWARE_TYPE) return -1;
80108a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a4a:	66 8b 00             	mov    (%eax),%ax
80108a4d:	66 3d 00 01          	cmp    $0x100,%ax
80108a51:	74 0a                	je     80108a5d <arp_proc+0x22>
80108a53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108a58:	e9 4d 01 00 00       	jmp    80108baa <arp_proc+0x16f>
  if(arp_p->pro_type != ARP_PROTOCOL_TYPE) return -1;
80108a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a60:	66 8b 40 02          	mov    0x2(%eax),%ax
80108a64:	66 83 f8 08          	cmp    $0x8,%ax
80108a68:	74 0a                	je     80108a74 <arp_proc+0x39>
80108a6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108a6f:	e9 36 01 00 00       	jmp    80108baa <arp_proc+0x16f>
  if(arp_p->hrd_len != 6) return -1;
80108a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a77:	8a 40 04             	mov    0x4(%eax),%al
80108a7a:	3c 06                	cmp    $0x6,%al
80108a7c:	74 0a                	je     80108a88 <arp_proc+0x4d>
80108a7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108a83:	e9 22 01 00 00       	jmp    80108baa <arp_proc+0x16f>
  if(arp_p->pro_len != 4) return -1;
80108a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a8b:	8a 40 05             	mov    0x5(%eax),%al
80108a8e:	3c 04                	cmp    $0x4,%al
80108a90:	74 0a                	je     80108a9c <arp_proc+0x61>
80108a92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108a97:	e9 0e 01 00 00       	jmp    80108baa <arp_proc+0x16f>
  if(memcmp(my_ip,arp_p->dst_ip,4) != 0 && memcmp(my_ip,arp_p->src_ip,4) != 0) return -1;
80108a9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a9f:	83 c0 18             	add    $0x18,%eax
80108aa2:	83 ec 04             	sub    $0x4,%esp
80108aa5:	6a 04                	push   $0x4
80108aa7:	50                   	push   %eax
80108aa8:	68 e4 e4 10 80       	push   $0x8010e4e4
80108aad:	e8 ba be ff ff       	call   8010496c <memcmp>
80108ab2:	83 c4 10             	add    $0x10,%esp
80108ab5:	85 c0                	test   %eax,%eax
80108ab7:	74 27                	je     80108ae0 <arp_proc+0xa5>
80108ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108abc:	83 c0 0e             	add    $0xe,%eax
80108abf:	83 ec 04             	sub    $0x4,%esp
80108ac2:	6a 04                	push   $0x4
80108ac4:	50                   	push   %eax
80108ac5:	68 e4 e4 10 80       	push   $0x8010e4e4
80108aca:	e8 9d be ff ff       	call   8010496c <memcmp>
80108acf:	83 c4 10             	add    $0x10,%esp
80108ad2:	85 c0                	test   %eax,%eax
80108ad4:	74 0a                	je     80108ae0 <arp_proc+0xa5>
80108ad6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108adb:	e9 ca 00 00 00       	jmp    80108baa <arp_proc+0x16f>
  if(arp_p->op == ARP_OPS_REQUEST && memcmp(my_ip,arp_p->dst_ip,4) == 0){
80108ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ae3:	66 8b 40 06          	mov    0x6(%eax),%ax
80108ae7:	66 3d 00 01          	cmp    $0x100,%ax
80108aeb:	75 69                	jne    80108b56 <arp_proc+0x11b>
80108aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108af0:	83 c0 18             	add    $0x18,%eax
80108af3:	83 ec 04             	sub    $0x4,%esp
80108af6:	6a 04                	push   $0x4
80108af8:	50                   	push   %eax
80108af9:	68 e4 e4 10 80       	push   $0x8010e4e4
80108afe:	e8 69 be ff ff       	call   8010496c <memcmp>
80108b03:	83 c4 10             	add    $0x10,%esp
80108b06:	85 c0                	test   %eax,%eax
80108b08:	75 4c                	jne    80108b56 <arp_proc+0x11b>
    uint send = (uint)kalloc();
80108b0a:	e8 25 9c ff ff       	call   80102734 <kalloc>
80108b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    uint send_size=0;
80108b12:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    arp_reply_pkt_create(arp_p,send,&send_size);
80108b19:	83 ec 04             	sub    $0x4,%esp
80108b1c:	8d 45 ec             	lea    -0x14(%ebp),%eax
80108b1f:	50                   	push   %eax
80108b20:	ff 75 f0             	pushl  -0x10(%ebp)
80108b23:	ff 75 f4             	pushl  -0xc(%ebp)
80108b26:	e8 17 04 00 00       	call   80108f42 <arp_reply_pkt_create>
80108b2b:	83 c4 10             	add    $0x10,%esp
    i8254_send(send,send_size);
80108b2e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108b31:	83 ec 08             	sub    $0x8,%esp
80108b34:	50                   	push   %eax
80108b35:	ff 75 f0             	pushl  -0x10(%ebp)
80108b38:	e8 d6 fd ff ff       	call   80108913 <i8254_send>
80108b3d:	83 c4 10             	add    $0x10,%esp
    kfree((char *)send);
80108b40:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108b43:	83 ec 0c             	sub    $0xc,%esp
80108b46:	50                   	push   %eax
80108b47:	e8 4e 9b ff ff       	call   8010269a <kfree>
80108b4c:	83 c4 10             	add    $0x10,%esp
    return ARP_CREATED_REPLY;
80108b4f:	b8 02 00 00 00       	mov    $0x2,%eax
80108b54:	eb 54                	jmp    80108baa <arp_proc+0x16f>
  }else if(arp_p->op == ARP_OPS_REPLY && memcmp(my_ip,arp_p->dst_ip,4) == 0){
80108b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b59:	66 8b 40 06          	mov    0x6(%eax),%ax
80108b5d:	66 3d 00 02          	cmp    $0x200,%ax
80108b61:	75 42                	jne    80108ba5 <arp_proc+0x16a>
80108b63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b66:	83 c0 18             	add    $0x18,%eax
80108b69:	83 ec 04             	sub    $0x4,%esp
80108b6c:	6a 04                	push   $0x4
80108b6e:	50                   	push   %eax
80108b6f:	68 e4 e4 10 80       	push   $0x8010e4e4
80108b74:	e8 f3 bd ff ff       	call   8010496c <memcmp>
80108b79:	83 c4 10             	add    $0x10,%esp
80108b7c:	85 c0                	test   %eax,%eax
80108b7e:	75 25                	jne    80108ba5 <arp_proc+0x16a>
    cprintf("ARP TABLE UPDATED\n");
80108b80:	83 ec 0c             	sub    $0xc,%esp
80108b83:	68 dc bc 10 80       	push   $0x8010bcdc
80108b88:	e8 64 78 ff ff       	call   801003f1 <cprintf>
80108b8d:	83 c4 10             	add    $0x10,%esp
    arp_table_update(arp_p);
80108b90:	83 ec 0c             	sub    $0xc,%esp
80108b93:	ff 75 f4             	pushl  -0xc(%ebp)
80108b96:	e8 ae 01 00 00       	call   80108d49 <arp_table_update>
80108b9b:	83 c4 10             	add    $0x10,%esp
    return ARP_UPDATED_TABLE;
80108b9e:	b8 01 00 00 00       	mov    $0x1,%eax
80108ba3:	eb 05                	jmp    80108baa <arp_proc+0x16f>
  }else{
    return -1;
80108ba5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
}
80108baa:	c9                   	leave  
80108bab:	c3                   	ret    

80108bac <arp_scan>:

void arp_scan(){
80108bac:	55                   	push   %ebp
80108bad:	89 e5                	mov    %esp,%ebp
80108baf:	83 ec 18             	sub    $0x18,%esp
  uint send_size;
  for(int i=0;i<256;i++){
80108bb2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108bb9:	eb 6e                	jmp    80108c29 <arp_scan+0x7d>
    uint send = (uint)kalloc();
80108bbb:	e8 74 9b ff ff       	call   80102734 <kalloc>
80108bc0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    arp_broadcast(send,&send_size,i);
80108bc3:	83 ec 04             	sub    $0x4,%esp
80108bc6:	ff 75 f4             	pushl  -0xc(%ebp)
80108bc9:	8d 45 e8             	lea    -0x18(%ebp),%eax
80108bcc:	50                   	push   %eax
80108bcd:	ff 75 ec             	pushl  -0x14(%ebp)
80108bd0:	e8 61 00 00 00       	call   80108c36 <arp_broadcast>
80108bd5:	83 c4 10             	add    $0x10,%esp
    uint res = i8254_send(send,send_size);
80108bd8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108bdb:	83 ec 08             	sub    $0x8,%esp
80108bde:	50                   	push   %eax
80108bdf:	ff 75 ec             	pushl  -0x14(%ebp)
80108be2:	e8 2c fd ff ff       	call   80108913 <i8254_send>
80108be7:	83 c4 10             	add    $0x10,%esp
80108bea:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while(res == -1){
80108bed:	eb 22                	jmp    80108c11 <arp_scan+0x65>
      microdelay(1);
80108bef:	83 ec 0c             	sub    $0xc,%esp
80108bf2:	6a 01                	push   $0x1
80108bf4:	e8 c7 9e ff ff       	call   80102ac0 <microdelay>
80108bf9:	83 c4 10             	add    $0x10,%esp
      res = i8254_send(send,send_size);
80108bfc:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108bff:	83 ec 08             	sub    $0x8,%esp
80108c02:	50                   	push   %eax
80108c03:	ff 75 ec             	pushl  -0x14(%ebp)
80108c06:	e8 08 fd ff ff       	call   80108913 <i8254_send>
80108c0b:	83 c4 10             	add    $0x10,%esp
80108c0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while(res == -1){
80108c11:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
80108c15:	74 d8                	je     80108bef <arp_scan+0x43>
    }
    kfree((char *)send);
80108c17:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108c1a:	83 ec 0c             	sub    $0xc,%esp
80108c1d:	50                   	push   %eax
80108c1e:	e8 77 9a ff ff       	call   8010269a <kfree>
80108c23:	83 c4 10             	add    $0x10,%esp
  for(int i=0;i<256;i++){
80108c26:	ff 45 f4             	incl   -0xc(%ebp)
80108c29:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80108c30:	7e 89                	jle    80108bbb <arp_scan+0xf>
  }
}
80108c32:	90                   	nop
80108c33:	90                   	nop
80108c34:	c9                   	leave  
80108c35:	c3                   	ret    

80108c36 <arp_broadcast>:

void arp_broadcast(uint send,uint *send_size,uint ip){
80108c36:	55                   	push   %ebp
80108c37:	89 e5                	mov    %esp,%ebp
80108c39:	83 ec 28             	sub    $0x28,%esp
  uchar dst_ip[4] = {10,0,1,ip};
80108c3c:	c6 45 ec 0a          	movb   $0xa,-0x14(%ebp)
80108c40:	c6 45 ed 00          	movb   $0x0,-0x13(%ebp)
80108c44:	c6 45 ee 01          	movb   $0x1,-0x12(%ebp)
80108c48:	8b 45 10             	mov    0x10(%ebp),%eax
80108c4b:	88 45 ef             	mov    %al,-0x11(%ebp)
  uchar dst_mac_eth[6] = {0xff,0xff,0xff,0xff,0xff,0xff};
80108c4e:	c7 45 e6 ff ff ff ff 	movl   $0xffffffff,-0x1a(%ebp)
80108c55:	66 c7 45 ea ff ff    	movw   $0xffff,-0x16(%ebp)
  uchar dst_mac_arp[6] = {0,0,0,0,0,0};
80108c5b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80108c62:	66 c7 45 e4 00 00    	movw   $0x0,-0x1c(%ebp)
  
  *send_size = sizeof(struct eth_pkt) + sizeof(struct arp_pkt);
80108c68:	8b 45 0c             	mov    0xc(%ebp),%eax
80108c6b:	c7 00 2c 00 00 00    	movl   $0x2c,(%eax)

  struct eth_pkt *reply_eth = (struct eth_pkt *)send;
80108c71:	8b 45 08             	mov    0x8(%ebp),%eax
80108c74:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct arp_pkt *reply_arp = (struct arp_pkt *)(send + sizeof(struct eth_pkt));
80108c77:	8b 45 08             	mov    0x8(%ebp),%eax
80108c7a:	83 c0 0e             	add    $0xe,%eax
80108c7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  reply_eth->type[0] = 0x08;
80108c80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c83:	c6 40 0c 08          	movb   $0x8,0xc(%eax)
  reply_eth->type[1] = 0x06;
80108c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c8a:	c6 40 0d 06          	movb   $0x6,0xd(%eax)
  memmove(reply_eth->dst_mac,dst_mac_eth,6);
80108c8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c91:	83 ec 04             	sub    $0x4,%esp
80108c94:	6a 06                	push   $0x6
80108c96:	8d 55 e6             	lea    -0x1a(%ebp),%edx
80108c99:	52                   	push   %edx
80108c9a:	50                   	push   %eax
80108c9b:	e8 1e bd ff ff       	call   801049be <memmove>
80108ca0:	83 c4 10             	add    $0x10,%esp
  memmove(reply_eth->src_mac,mac_addr,6);
80108ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ca6:	83 c0 06             	add    $0x6,%eax
80108ca9:	83 ec 04             	sub    $0x4,%esp
80108cac:	6a 06                	push   $0x6
80108cae:	68 80 5c 19 80       	push   $0x80195c80
80108cb3:	50                   	push   %eax
80108cb4:	e8 05 bd ff ff       	call   801049be <memmove>
80108cb9:	83 c4 10             	add    $0x10,%esp

  reply_arp->hrd_type = ARP_HARDWARE_TYPE;
80108cbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108cbf:	66 c7 00 00 01       	movw   $0x100,(%eax)
  reply_arp->pro_type = ARP_PROTOCOL_TYPE;
80108cc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108cc7:	66 c7 40 02 08 00    	movw   $0x8,0x2(%eax)
  reply_arp->hrd_len = 6;
80108ccd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108cd0:	c6 40 04 06          	movb   $0x6,0x4(%eax)
  reply_arp->pro_len = 4;
80108cd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108cd7:	c6 40 05 04          	movb   $0x4,0x5(%eax)
  reply_arp->op = ARP_OPS_REQUEST;
80108cdb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108cde:	66 c7 40 06 00 01    	movw   $0x100,0x6(%eax)
  memmove(reply_arp->dst_mac,dst_mac_arp,6);
80108ce4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108ce7:	8d 50 12             	lea    0x12(%eax),%edx
80108cea:	83 ec 04             	sub    $0x4,%esp
80108ced:	6a 06                	push   $0x6
80108cef:	8d 45 e0             	lea    -0x20(%ebp),%eax
80108cf2:	50                   	push   %eax
80108cf3:	52                   	push   %edx
80108cf4:	e8 c5 bc ff ff       	call   801049be <memmove>
80108cf9:	83 c4 10             	add    $0x10,%esp
  memmove(reply_arp->dst_ip,dst_ip,4);
80108cfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108cff:	8d 50 18             	lea    0x18(%eax),%edx
80108d02:	83 ec 04             	sub    $0x4,%esp
80108d05:	6a 04                	push   $0x4
80108d07:	8d 45 ec             	lea    -0x14(%ebp),%eax
80108d0a:	50                   	push   %eax
80108d0b:	52                   	push   %edx
80108d0c:	e8 ad bc ff ff       	call   801049be <memmove>
80108d11:	83 c4 10             	add    $0x10,%esp
  memmove(reply_arp->src_mac,mac_addr,6);
80108d14:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108d17:	83 c0 08             	add    $0x8,%eax
80108d1a:	83 ec 04             	sub    $0x4,%esp
80108d1d:	6a 06                	push   $0x6
80108d1f:	68 80 5c 19 80       	push   $0x80195c80
80108d24:	50                   	push   %eax
80108d25:	e8 94 bc ff ff       	call   801049be <memmove>
80108d2a:	83 c4 10             	add    $0x10,%esp
  memmove(reply_arp->src_ip,my_ip,4);
80108d2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108d30:	83 c0 0e             	add    $0xe,%eax
80108d33:	83 ec 04             	sub    $0x4,%esp
80108d36:	6a 04                	push   $0x4
80108d38:	68 e4 e4 10 80       	push   $0x8010e4e4
80108d3d:	50                   	push   %eax
80108d3e:	e8 7b bc ff ff       	call   801049be <memmove>
80108d43:	83 c4 10             	add    $0x10,%esp
}
80108d46:	90                   	nop
80108d47:	c9                   	leave  
80108d48:	c3                   	ret    

80108d49 <arp_table_update>:

void arp_table_update(struct arp_pkt *recv_arp){
80108d49:	55                   	push   %ebp
80108d4a:	89 e5                	mov    %esp,%ebp
80108d4c:	83 ec 18             	sub    $0x18,%esp
  int index = arp_table_search(recv_arp->src_ip);
80108d4f:	8b 45 08             	mov    0x8(%ebp),%eax
80108d52:	83 c0 0e             	add    $0xe,%eax
80108d55:	83 ec 0c             	sub    $0xc,%esp
80108d58:	50                   	push   %eax
80108d59:	e8 bb 00 00 00       	call   80108e19 <arp_table_search>
80108d5e:	83 c4 10             	add    $0x10,%esp
80108d61:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(index > -1){
80108d64:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108d68:	78 2d                	js     80108d97 <arp_table_update+0x4e>
    memmove(arp_table[index].mac,recv_arp->src_mac,6);
80108d6a:	8b 45 08             	mov    0x8(%ebp),%eax
80108d6d:	8d 48 08             	lea    0x8(%eax),%ecx
80108d70:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108d73:	89 d0                	mov    %edx,%eax
80108d75:	c1 e0 02             	shl    $0x2,%eax
80108d78:	01 d0                	add    %edx,%eax
80108d7a:	01 c0                	add    %eax,%eax
80108d7c:	01 d0                	add    %edx,%eax
80108d7e:	05 a0 5c 19 80       	add    $0x80195ca0,%eax
80108d83:	83 c0 04             	add    $0x4,%eax
80108d86:	83 ec 04             	sub    $0x4,%esp
80108d89:	6a 06                	push   $0x6
80108d8b:	51                   	push   %ecx
80108d8c:	50                   	push   %eax
80108d8d:	e8 2c bc ff ff       	call   801049be <memmove>
80108d92:	83 c4 10             	add    $0x10,%esp
80108d95:	eb 6f                	jmp    80108e06 <arp_table_update+0xbd>
  }else{
    index += 1;
80108d97:	ff 45 f4             	incl   -0xc(%ebp)
    index = -index;
80108d9a:	f7 5d f4             	negl   -0xc(%ebp)
    memmove(arp_table[index].mac,recv_arp->src_mac,6);
80108d9d:	8b 45 08             	mov    0x8(%ebp),%eax
80108da0:	8d 48 08             	lea    0x8(%eax),%ecx
80108da3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108da6:	89 d0                	mov    %edx,%eax
80108da8:	c1 e0 02             	shl    $0x2,%eax
80108dab:	01 d0                	add    %edx,%eax
80108dad:	01 c0                	add    %eax,%eax
80108daf:	01 d0                	add    %edx,%eax
80108db1:	05 a0 5c 19 80       	add    $0x80195ca0,%eax
80108db6:	83 c0 04             	add    $0x4,%eax
80108db9:	83 ec 04             	sub    $0x4,%esp
80108dbc:	6a 06                	push   $0x6
80108dbe:	51                   	push   %ecx
80108dbf:	50                   	push   %eax
80108dc0:	e8 f9 bb ff ff       	call   801049be <memmove>
80108dc5:	83 c4 10             	add    $0x10,%esp
    memmove(arp_table[index].ip,recv_arp->src_ip,4);
80108dc8:	8b 45 08             	mov    0x8(%ebp),%eax
80108dcb:	8d 48 0e             	lea    0xe(%eax),%ecx
80108dce:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108dd1:	89 d0                	mov    %edx,%eax
80108dd3:	c1 e0 02             	shl    $0x2,%eax
80108dd6:	01 d0                	add    %edx,%eax
80108dd8:	01 c0                	add    %eax,%eax
80108dda:	01 d0                	add    %edx,%eax
80108ddc:	05 a0 5c 19 80       	add    $0x80195ca0,%eax
80108de1:	83 ec 04             	sub    $0x4,%esp
80108de4:	6a 04                	push   $0x4
80108de6:	51                   	push   %ecx
80108de7:	50                   	push   %eax
80108de8:	e8 d1 bb ff ff       	call   801049be <memmove>
80108ded:	83 c4 10             	add    $0x10,%esp
    arp_table[index].use = 1;
80108df0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108df3:	89 d0                	mov    %edx,%eax
80108df5:	c1 e0 02             	shl    $0x2,%eax
80108df8:	01 d0                	add    %edx,%eax
80108dfa:	01 c0                	add    %eax,%eax
80108dfc:	01 d0                	add    %edx,%eax
80108dfe:	05 aa 5c 19 80       	add    $0x80195caa,%eax
80108e03:	c6 00 01             	movb   $0x1,(%eax)
  }
  print_arp_table(arp_table);
80108e06:	83 ec 0c             	sub    $0xc,%esp
80108e09:	68 a0 5c 19 80       	push   $0x80195ca0
80108e0e:	e8 7f 00 00 00       	call   80108e92 <print_arp_table>
80108e13:	83 c4 10             	add    $0x10,%esp
}
80108e16:	90                   	nop
80108e17:	c9                   	leave  
80108e18:	c3                   	ret    

80108e19 <arp_table_search>:

int arp_table_search(uchar *ip){
80108e19:	55                   	push   %ebp
80108e1a:	89 e5                	mov    %esp,%ebp
80108e1c:	83 ec 18             	sub    $0x18,%esp
  int empty=1;
80108e1f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  for(int i=0;i<ARP_TABLE_MAX;i++){
80108e26:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80108e2d:	eb 57                	jmp    80108e86 <arp_table_search+0x6d>
    if(memcmp(arp_table[i].ip,ip,4) == 0){
80108e2f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80108e32:	89 d0                	mov    %edx,%eax
80108e34:	c1 e0 02             	shl    $0x2,%eax
80108e37:	01 d0                	add    %edx,%eax
80108e39:	01 c0                	add    %eax,%eax
80108e3b:	01 d0                	add    %edx,%eax
80108e3d:	05 a0 5c 19 80       	add    $0x80195ca0,%eax
80108e42:	83 ec 04             	sub    $0x4,%esp
80108e45:	6a 04                	push   $0x4
80108e47:	ff 75 08             	pushl  0x8(%ebp)
80108e4a:	50                   	push   %eax
80108e4b:	e8 1c bb ff ff       	call   8010496c <memcmp>
80108e50:	83 c4 10             	add    $0x10,%esp
80108e53:	85 c0                	test   %eax,%eax
80108e55:	75 05                	jne    80108e5c <arp_table_search+0x43>
      return i;
80108e57:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108e5a:	eb 34                	jmp    80108e90 <arp_table_search+0x77>
    }
    if(arp_table[i].use == 0 && empty == 1){
80108e5c:	8b 55 f0             	mov    -0x10(%ebp),%edx
80108e5f:	89 d0                	mov    %edx,%eax
80108e61:	c1 e0 02             	shl    $0x2,%eax
80108e64:	01 d0                	add    %edx,%eax
80108e66:	01 c0                	add    %eax,%eax
80108e68:	01 d0                	add    %edx,%eax
80108e6a:	05 aa 5c 19 80       	add    $0x80195caa,%eax
80108e6f:	8a 00                	mov    (%eax),%al
80108e71:	84 c0                	test   %al,%al
80108e73:	75 0e                	jne    80108e83 <arp_table_search+0x6a>
80108e75:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80108e79:	75 08                	jne    80108e83 <arp_table_search+0x6a>
      empty = -i;
80108e7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108e7e:	f7 d8                	neg    %eax
80108e80:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(int i=0;i<ARP_TABLE_MAX;i++){
80108e83:	ff 45 f0             	incl   -0x10(%ebp)
80108e86:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
80108e8a:	7e a3                	jle    80108e2f <arp_table_search+0x16>
    }
  }
  return empty-1;
80108e8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108e8f:	48                   	dec    %eax
}
80108e90:	c9                   	leave  
80108e91:	c3                   	ret    

80108e92 <print_arp_table>:

void print_arp_table(){
80108e92:	55                   	push   %ebp
80108e93:	89 e5                	mov    %esp,%ebp
80108e95:	83 ec 18             	sub    $0x18,%esp
  for(int i=0;i < ARP_TABLE_MAX;i++){
80108e98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108e9f:	e9 90 00 00 00       	jmp    80108f34 <print_arp_table+0xa2>
    if(arp_table[i].use != 0){
80108ea4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108ea7:	89 d0                	mov    %edx,%eax
80108ea9:	c1 e0 02             	shl    $0x2,%eax
80108eac:	01 d0                	add    %edx,%eax
80108eae:	01 c0                	add    %eax,%eax
80108eb0:	01 d0                	add    %edx,%eax
80108eb2:	05 aa 5c 19 80       	add    $0x80195caa,%eax
80108eb7:	8a 00                	mov    (%eax),%al
80108eb9:	84 c0                	test   %al,%al
80108ebb:	74 74                	je     80108f31 <print_arp_table+0x9f>
      cprintf("Entry Num: %d ",i);
80108ebd:	83 ec 08             	sub    $0x8,%esp
80108ec0:	ff 75 f4             	pushl  -0xc(%ebp)
80108ec3:	68 ef bc 10 80       	push   $0x8010bcef
80108ec8:	e8 24 75 ff ff       	call   801003f1 <cprintf>
80108ecd:	83 c4 10             	add    $0x10,%esp
      print_ipv4(arp_table[i].ip);
80108ed0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108ed3:	89 d0                	mov    %edx,%eax
80108ed5:	c1 e0 02             	shl    $0x2,%eax
80108ed8:	01 d0                	add    %edx,%eax
80108eda:	01 c0                	add    %eax,%eax
80108edc:	01 d0                	add    %edx,%eax
80108ede:	05 a0 5c 19 80       	add    $0x80195ca0,%eax
80108ee3:	83 ec 0c             	sub    $0xc,%esp
80108ee6:	50                   	push   %eax
80108ee7:	e8 53 02 00 00       	call   8010913f <print_ipv4>
80108eec:	83 c4 10             	add    $0x10,%esp
      cprintf(" ");
80108eef:	83 ec 0c             	sub    $0xc,%esp
80108ef2:	68 fe bc 10 80       	push   $0x8010bcfe
80108ef7:	e8 f5 74 ff ff       	call   801003f1 <cprintf>
80108efc:	83 c4 10             	add    $0x10,%esp
      print_mac(arp_table[i].mac);
80108eff:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108f02:	89 d0                	mov    %edx,%eax
80108f04:	c1 e0 02             	shl    $0x2,%eax
80108f07:	01 d0                	add    %edx,%eax
80108f09:	01 c0                	add    %eax,%eax
80108f0b:	01 d0                	add    %edx,%eax
80108f0d:	05 a0 5c 19 80       	add    $0x80195ca0,%eax
80108f12:	83 c0 04             	add    $0x4,%eax
80108f15:	83 ec 0c             	sub    $0xc,%esp
80108f18:	50                   	push   %eax
80108f19:	e8 69 02 00 00       	call   80109187 <print_mac>
80108f1e:	83 c4 10             	add    $0x10,%esp
      cprintf("\n");
80108f21:	83 ec 0c             	sub    $0xc,%esp
80108f24:	68 00 bd 10 80       	push   $0x8010bd00
80108f29:	e8 c3 74 ff ff       	call   801003f1 <cprintf>
80108f2e:	83 c4 10             	add    $0x10,%esp
  for(int i=0;i < ARP_TABLE_MAX;i++){
80108f31:	ff 45 f4             	incl   -0xc(%ebp)
80108f34:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
80108f38:	0f 8e 66 ff ff ff    	jle    80108ea4 <print_arp_table+0x12>
    }
  }
}
80108f3e:	90                   	nop
80108f3f:	90                   	nop
80108f40:	c9                   	leave  
80108f41:	c3                   	ret    

80108f42 <arp_reply_pkt_create>:


void arp_reply_pkt_create(struct arp_pkt *arp_recv,uint send,uint *send_size){
80108f42:	55                   	push   %ebp
80108f43:	89 e5                	mov    %esp,%ebp
80108f45:	83 ec 18             	sub    $0x18,%esp
  *send_size = sizeof(struct eth_pkt) + sizeof(struct arp_pkt);
80108f48:	8b 45 10             	mov    0x10(%ebp),%eax
80108f4b:	c7 00 2c 00 00 00    	movl   $0x2c,(%eax)
  
  struct eth_pkt *reply_eth = (struct eth_pkt *)send;
80108f51:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f54:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct arp_pkt *reply_arp = (struct arp_pkt *)(send + sizeof(struct eth_pkt));
80108f57:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f5a:	83 c0 0e             	add    $0xe,%eax
80108f5d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  reply_eth->type[0] = 0x08;
80108f60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108f63:	c6 40 0c 08          	movb   $0x8,0xc(%eax)
  reply_eth->type[1] = 0x06;
80108f67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108f6a:	c6 40 0d 06          	movb   $0x6,0xd(%eax)
  memmove(reply_eth->dst_mac,arp_recv->src_mac,6);
80108f6e:	8b 45 08             	mov    0x8(%ebp),%eax
80108f71:	8d 50 08             	lea    0x8(%eax),%edx
80108f74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108f77:	83 ec 04             	sub    $0x4,%esp
80108f7a:	6a 06                	push   $0x6
80108f7c:	52                   	push   %edx
80108f7d:	50                   	push   %eax
80108f7e:	e8 3b ba ff ff       	call   801049be <memmove>
80108f83:	83 c4 10             	add    $0x10,%esp
  memmove(reply_eth->src_mac,mac_addr,6);
80108f86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108f89:	83 c0 06             	add    $0x6,%eax
80108f8c:	83 ec 04             	sub    $0x4,%esp
80108f8f:	6a 06                	push   $0x6
80108f91:	68 80 5c 19 80       	push   $0x80195c80
80108f96:	50                   	push   %eax
80108f97:	e8 22 ba ff ff       	call   801049be <memmove>
80108f9c:	83 c4 10             	add    $0x10,%esp

  reply_arp->hrd_type = ARP_HARDWARE_TYPE;
80108f9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108fa2:	66 c7 00 00 01       	movw   $0x100,(%eax)
  reply_arp->pro_type = ARP_PROTOCOL_TYPE;
80108fa7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108faa:	66 c7 40 02 08 00    	movw   $0x8,0x2(%eax)
  reply_arp->hrd_len = 6;
80108fb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108fb3:	c6 40 04 06          	movb   $0x6,0x4(%eax)
  reply_arp->pro_len = 4;
80108fb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108fba:	c6 40 05 04          	movb   $0x4,0x5(%eax)
  reply_arp->op = ARP_OPS_REPLY;
80108fbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108fc1:	66 c7 40 06 00 02    	movw   $0x200,0x6(%eax)
  memmove(reply_arp->dst_mac,arp_recv->src_mac,6);
80108fc7:	8b 45 08             	mov    0x8(%ebp),%eax
80108fca:	8d 50 08             	lea    0x8(%eax),%edx
80108fcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108fd0:	83 c0 12             	add    $0x12,%eax
80108fd3:	83 ec 04             	sub    $0x4,%esp
80108fd6:	6a 06                	push   $0x6
80108fd8:	52                   	push   %edx
80108fd9:	50                   	push   %eax
80108fda:	e8 df b9 ff ff       	call   801049be <memmove>
80108fdf:	83 c4 10             	add    $0x10,%esp
  memmove(reply_arp->dst_ip,arp_recv->src_ip,4);
80108fe2:	8b 45 08             	mov    0x8(%ebp),%eax
80108fe5:	8d 50 0e             	lea    0xe(%eax),%edx
80108fe8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108feb:	83 c0 18             	add    $0x18,%eax
80108fee:	83 ec 04             	sub    $0x4,%esp
80108ff1:	6a 04                	push   $0x4
80108ff3:	52                   	push   %edx
80108ff4:	50                   	push   %eax
80108ff5:	e8 c4 b9 ff ff       	call   801049be <memmove>
80108ffa:	83 c4 10             	add    $0x10,%esp
  memmove(reply_arp->src_mac,mac_addr,6);
80108ffd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109000:	83 c0 08             	add    $0x8,%eax
80109003:	83 ec 04             	sub    $0x4,%esp
80109006:	6a 06                	push   $0x6
80109008:	68 80 5c 19 80       	push   $0x80195c80
8010900d:	50                   	push   %eax
8010900e:	e8 ab b9 ff ff       	call   801049be <memmove>
80109013:	83 c4 10             	add    $0x10,%esp
  memmove(reply_arp->src_ip,my_ip,4);
80109016:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109019:	83 c0 0e             	add    $0xe,%eax
8010901c:	83 ec 04             	sub    $0x4,%esp
8010901f:	6a 04                	push   $0x4
80109021:	68 e4 e4 10 80       	push   $0x8010e4e4
80109026:	50                   	push   %eax
80109027:	e8 92 b9 ff ff       	call   801049be <memmove>
8010902c:	83 c4 10             	add    $0x10,%esp
}
8010902f:	90                   	nop
80109030:	c9                   	leave  
80109031:	c3                   	ret    

80109032 <print_arp_info>:

void print_arp_info(struct arp_pkt* arp_p){
80109032:	55                   	push   %ebp
80109033:	89 e5                	mov    %esp,%ebp
80109035:	83 ec 08             	sub    $0x8,%esp
  cprintf("--------Source-------\n");
80109038:	83 ec 0c             	sub    $0xc,%esp
8010903b:	68 02 bd 10 80       	push   $0x8010bd02
80109040:	e8 ac 73 ff ff       	call   801003f1 <cprintf>
80109045:	83 c4 10             	add    $0x10,%esp
  print_ipv4(arp_p->src_ip);
80109048:	8b 45 08             	mov    0x8(%ebp),%eax
8010904b:	83 c0 0e             	add    $0xe,%eax
8010904e:	83 ec 0c             	sub    $0xc,%esp
80109051:	50                   	push   %eax
80109052:	e8 e8 00 00 00       	call   8010913f <print_ipv4>
80109057:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
8010905a:	83 ec 0c             	sub    $0xc,%esp
8010905d:	68 00 bd 10 80       	push   $0x8010bd00
80109062:	e8 8a 73 ff ff       	call   801003f1 <cprintf>
80109067:	83 c4 10             	add    $0x10,%esp
  print_mac(arp_p->src_mac);
8010906a:	8b 45 08             	mov    0x8(%ebp),%eax
8010906d:	83 c0 08             	add    $0x8,%eax
80109070:	83 ec 0c             	sub    $0xc,%esp
80109073:	50                   	push   %eax
80109074:	e8 0e 01 00 00       	call   80109187 <print_mac>
80109079:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
8010907c:	83 ec 0c             	sub    $0xc,%esp
8010907f:	68 00 bd 10 80       	push   $0x8010bd00
80109084:	e8 68 73 ff ff       	call   801003f1 <cprintf>
80109089:	83 c4 10             	add    $0x10,%esp
  cprintf("-----Destination-----\n");
8010908c:	83 ec 0c             	sub    $0xc,%esp
8010908f:	68 19 bd 10 80       	push   $0x8010bd19
80109094:	e8 58 73 ff ff       	call   801003f1 <cprintf>
80109099:	83 c4 10             	add    $0x10,%esp
  print_ipv4(arp_p->dst_ip);
8010909c:	8b 45 08             	mov    0x8(%ebp),%eax
8010909f:	83 c0 18             	add    $0x18,%eax
801090a2:	83 ec 0c             	sub    $0xc,%esp
801090a5:	50                   	push   %eax
801090a6:	e8 94 00 00 00       	call   8010913f <print_ipv4>
801090ab:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801090ae:	83 ec 0c             	sub    $0xc,%esp
801090b1:	68 00 bd 10 80       	push   $0x8010bd00
801090b6:	e8 36 73 ff ff       	call   801003f1 <cprintf>
801090bb:	83 c4 10             	add    $0x10,%esp
  print_mac(arp_p->dst_mac);
801090be:	8b 45 08             	mov    0x8(%ebp),%eax
801090c1:	83 c0 12             	add    $0x12,%eax
801090c4:	83 ec 0c             	sub    $0xc,%esp
801090c7:	50                   	push   %eax
801090c8:	e8 ba 00 00 00       	call   80109187 <print_mac>
801090cd:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801090d0:	83 ec 0c             	sub    $0xc,%esp
801090d3:	68 00 bd 10 80       	push   $0x8010bd00
801090d8:	e8 14 73 ff ff       	call   801003f1 <cprintf>
801090dd:	83 c4 10             	add    $0x10,%esp
  cprintf("Operation: ");
801090e0:	83 ec 0c             	sub    $0xc,%esp
801090e3:	68 30 bd 10 80       	push   $0x8010bd30
801090e8:	e8 04 73 ff ff       	call   801003f1 <cprintf>
801090ed:	83 c4 10             	add    $0x10,%esp
  if(arp_p->op == ARP_OPS_REQUEST) cprintf("Request\n");
801090f0:	8b 45 08             	mov    0x8(%ebp),%eax
801090f3:	66 8b 40 06          	mov    0x6(%eax),%ax
801090f7:	66 3d 00 01          	cmp    $0x100,%ax
801090fb:	75 12                	jne    8010910f <print_arp_info+0xdd>
801090fd:	83 ec 0c             	sub    $0xc,%esp
80109100:	68 3c bd 10 80       	push   $0x8010bd3c
80109105:	e8 e7 72 ff ff       	call   801003f1 <cprintf>
8010910a:	83 c4 10             	add    $0x10,%esp
8010910d:	eb 1d                	jmp    8010912c <print_arp_info+0xfa>
  else if(arp_p->op == ARP_OPS_REPLY) {
8010910f:	8b 45 08             	mov    0x8(%ebp),%eax
80109112:	66 8b 40 06          	mov    0x6(%eax),%ax
80109116:	66 3d 00 02          	cmp    $0x200,%ax
8010911a:	75 10                	jne    8010912c <print_arp_info+0xfa>
    cprintf("Reply\n");
8010911c:	83 ec 0c             	sub    $0xc,%esp
8010911f:	68 45 bd 10 80       	push   $0x8010bd45
80109124:	e8 c8 72 ff ff       	call   801003f1 <cprintf>
80109129:	83 c4 10             	add    $0x10,%esp
  }
  cprintf("\n");
8010912c:	83 ec 0c             	sub    $0xc,%esp
8010912f:	68 00 bd 10 80       	push   $0x8010bd00
80109134:	e8 b8 72 ff ff       	call   801003f1 <cprintf>
80109139:	83 c4 10             	add    $0x10,%esp
}
8010913c:	90                   	nop
8010913d:	c9                   	leave  
8010913e:	c3                   	ret    

8010913f <print_ipv4>:

void print_ipv4(uchar *ip){
8010913f:	55                   	push   %ebp
80109140:	89 e5                	mov    %esp,%ebp
80109142:	53                   	push   %ebx
80109143:	83 ec 04             	sub    $0x4,%esp
  cprintf("IP address: %d.%d.%d.%d",ip[0],ip[1],ip[2],ip[3]);
80109146:	8b 45 08             	mov    0x8(%ebp),%eax
80109149:	83 c0 03             	add    $0x3,%eax
8010914c:	8a 00                	mov    (%eax),%al
8010914e:	0f b6 d8             	movzbl %al,%ebx
80109151:	8b 45 08             	mov    0x8(%ebp),%eax
80109154:	83 c0 02             	add    $0x2,%eax
80109157:	8a 00                	mov    (%eax),%al
80109159:	0f b6 c8             	movzbl %al,%ecx
8010915c:	8b 45 08             	mov    0x8(%ebp),%eax
8010915f:	40                   	inc    %eax
80109160:	8a 00                	mov    (%eax),%al
80109162:	0f b6 d0             	movzbl %al,%edx
80109165:	8b 45 08             	mov    0x8(%ebp),%eax
80109168:	8a 00                	mov    (%eax),%al
8010916a:	0f b6 c0             	movzbl %al,%eax
8010916d:	83 ec 0c             	sub    $0xc,%esp
80109170:	53                   	push   %ebx
80109171:	51                   	push   %ecx
80109172:	52                   	push   %edx
80109173:	50                   	push   %eax
80109174:	68 4c bd 10 80       	push   $0x8010bd4c
80109179:	e8 73 72 ff ff       	call   801003f1 <cprintf>
8010917e:	83 c4 20             	add    $0x20,%esp
}
80109181:	90                   	nop
80109182:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109185:	c9                   	leave  
80109186:	c3                   	ret    

80109187 <print_mac>:

void print_mac(uchar *mac){
80109187:	55                   	push   %ebp
80109188:	89 e5                	mov    %esp,%ebp
8010918a:	57                   	push   %edi
8010918b:	56                   	push   %esi
8010918c:	53                   	push   %ebx
8010918d:	83 ec 0c             	sub    $0xc,%esp
  cprintf("MAC address: %x:%x:%x:%x:%x:%x",mac[0],mac[1],mac[2],mac[3],mac[4],mac[5]);
80109190:	8b 45 08             	mov    0x8(%ebp),%eax
80109193:	83 c0 05             	add    $0x5,%eax
80109196:	8a 00                	mov    (%eax),%al
80109198:	0f b6 f8             	movzbl %al,%edi
8010919b:	8b 45 08             	mov    0x8(%ebp),%eax
8010919e:	83 c0 04             	add    $0x4,%eax
801091a1:	8a 00                	mov    (%eax),%al
801091a3:	0f b6 f0             	movzbl %al,%esi
801091a6:	8b 45 08             	mov    0x8(%ebp),%eax
801091a9:	83 c0 03             	add    $0x3,%eax
801091ac:	8a 00                	mov    (%eax),%al
801091ae:	0f b6 d8             	movzbl %al,%ebx
801091b1:	8b 45 08             	mov    0x8(%ebp),%eax
801091b4:	83 c0 02             	add    $0x2,%eax
801091b7:	8a 00                	mov    (%eax),%al
801091b9:	0f b6 c8             	movzbl %al,%ecx
801091bc:	8b 45 08             	mov    0x8(%ebp),%eax
801091bf:	40                   	inc    %eax
801091c0:	8a 00                	mov    (%eax),%al
801091c2:	0f b6 d0             	movzbl %al,%edx
801091c5:	8b 45 08             	mov    0x8(%ebp),%eax
801091c8:	8a 00                	mov    (%eax),%al
801091ca:	0f b6 c0             	movzbl %al,%eax
801091cd:	83 ec 04             	sub    $0x4,%esp
801091d0:	57                   	push   %edi
801091d1:	56                   	push   %esi
801091d2:	53                   	push   %ebx
801091d3:	51                   	push   %ecx
801091d4:	52                   	push   %edx
801091d5:	50                   	push   %eax
801091d6:	68 64 bd 10 80       	push   $0x8010bd64
801091db:	e8 11 72 ff ff       	call   801003f1 <cprintf>
801091e0:	83 c4 20             	add    $0x20,%esp
}
801091e3:	90                   	nop
801091e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801091e7:	5b                   	pop    %ebx
801091e8:	5e                   	pop    %esi
801091e9:	5f                   	pop    %edi
801091ea:	5d                   	pop    %ebp
801091eb:	c3                   	ret    

801091ec <eth_proc>:
#include "arp.h"
#include "types.h"
#include "eth.h"
#include "defs.h"
#include "ipv4.h"
void eth_proc(uint buffer_addr){
801091ec:	55                   	push   %ebp
801091ed:	89 e5                	mov    %esp,%ebp
801091ef:	83 ec 18             	sub    $0x18,%esp
  struct eth_pkt *eth_pkt = (struct eth_pkt *)buffer_addr;
801091f2:	8b 45 08             	mov    0x8(%ebp),%eax
801091f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint pkt_addr = buffer_addr+sizeof(struct eth_pkt);
801091f8:	8b 45 08             	mov    0x8(%ebp),%eax
801091fb:	83 c0 0e             	add    $0xe,%eax
801091fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(eth_pkt->type[0] == 0x08 && eth_pkt->type[1] == 0x06){
80109201:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109204:	8a 40 0c             	mov    0xc(%eax),%al
80109207:	3c 08                	cmp    $0x8,%al
80109209:	75 1a                	jne    80109225 <eth_proc+0x39>
8010920b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010920e:	8a 40 0d             	mov    0xd(%eax),%al
80109211:	3c 06                	cmp    $0x6,%al
80109213:	75 10                	jne    80109225 <eth_proc+0x39>
    arp_proc(pkt_addr);
80109215:	83 ec 0c             	sub    $0xc,%esp
80109218:	ff 75 f0             	pushl  -0x10(%ebp)
8010921b:	e8 1b f8 ff ff       	call   80108a3b <arp_proc>
80109220:	83 c4 10             	add    $0x10,%esp
  }else if(eth_pkt->type[0] == 0x08 && eth_pkt->type[1] == 0x00){
    ipv4_proc(buffer_addr);
  }else{
  }
}
80109223:	eb 22                	jmp    80109247 <eth_proc+0x5b>
  }else if(eth_pkt->type[0] == 0x08 && eth_pkt->type[1] == 0x00){
80109225:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109228:	8a 40 0c             	mov    0xc(%eax),%al
8010922b:	3c 08                	cmp    $0x8,%al
8010922d:	75 18                	jne    80109247 <eth_proc+0x5b>
8010922f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109232:	8a 40 0d             	mov    0xd(%eax),%al
80109235:	84 c0                	test   %al,%al
80109237:	75 0e                	jne    80109247 <eth_proc+0x5b>
    ipv4_proc(buffer_addr);
80109239:	83 ec 0c             	sub    $0xc,%esp
8010923c:	ff 75 08             	pushl  0x8(%ebp)
8010923f:	e8 a1 00 00 00       	call   801092e5 <ipv4_proc>
80109244:	83 c4 10             	add    $0x10,%esp
}
80109247:	90                   	nop
80109248:	c9                   	leave  
80109249:	c3                   	ret    

8010924a <N2H_ushort>:

ushort N2H_ushort(ushort value){
8010924a:	55                   	push   %ebp
8010924b:	89 e5                	mov    %esp,%ebp
8010924d:	83 ec 04             	sub    $0x4,%esp
80109250:	8b 45 08             	mov    0x8(%ebp),%eax
80109253:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  return (((value)&0xFF)<<8)+(value>>8);
80109257:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010925b:	c1 e0 08             	shl    $0x8,%eax
8010925e:	89 c2                	mov    %eax,%edx
80109260:	8b 45 fc             	mov    -0x4(%ebp),%eax
80109263:	66 c1 e8 08          	shr    $0x8,%ax
80109267:	01 d0                	add    %edx,%eax
}
80109269:	c9                   	leave  
8010926a:	c3                   	ret    

8010926b <H2N_ushort>:

ushort H2N_ushort(ushort value){
8010926b:	55                   	push   %ebp
8010926c:	89 e5                	mov    %esp,%ebp
8010926e:	83 ec 04             	sub    $0x4,%esp
80109271:	8b 45 08             	mov    0x8(%ebp),%eax
80109274:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  return (((value)&0xFF)<<8)+(value>>8);
80109278:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010927c:	c1 e0 08             	shl    $0x8,%eax
8010927f:	89 c2                	mov    %eax,%edx
80109281:	8b 45 fc             	mov    -0x4(%ebp),%eax
80109284:	66 c1 e8 08          	shr    $0x8,%ax
80109288:	01 d0                	add    %edx,%eax
}
8010928a:	c9                   	leave  
8010928b:	c3                   	ret    

8010928c <H2N_uint>:

uint H2N_uint(uint value){
8010928c:	55                   	push   %ebp
8010928d:	89 e5                	mov    %esp,%ebp
  return ((value&0xF)<<24)+((value&0xF0)<<8)+((value&0xF00)>>8)+((value&0xF000)>>24);
8010928f:	8b 45 08             	mov    0x8(%ebp),%eax
80109292:	c1 e0 18             	shl    $0x18,%eax
80109295:	25 00 00 00 0f       	and    $0xf000000,%eax
8010929a:	89 c2                	mov    %eax,%edx
8010929c:	8b 45 08             	mov    0x8(%ebp),%eax
8010929f:	c1 e0 08             	shl    $0x8,%eax
801092a2:	25 00 f0 00 00       	and    $0xf000,%eax
801092a7:	09 c2                	or     %eax,%edx
801092a9:	8b 45 08             	mov    0x8(%ebp),%eax
801092ac:	c1 e8 08             	shr    $0x8,%eax
801092af:	83 e0 0f             	and    $0xf,%eax
801092b2:	01 d0                	add    %edx,%eax
}
801092b4:	5d                   	pop    %ebp
801092b5:	c3                   	ret    

801092b6 <N2H_uint>:

uint N2H_uint(uint value){
801092b6:	55                   	push   %ebp
801092b7:	89 e5                	mov    %esp,%ebp
  return ((value&0xFF)<<24)+((value&0xFF00)<<8)+((value&0xFF0000)>>8)+((value&0xFF000000)>>24);
801092b9:	8b 45 08             	mov    0x8(%ebp),%eax
801092bc:	c1 e0 18             	shl    $0x18,%eax
801092bf:	89 c2                	mov    %eax,%edx
801092c1:	8b 45 08             	mov    0x8(%ebp),%eax
801092c4:	c1 e0 08             	shl    $0x8,%eax
801092c7:	25 00 00 ff 00       	and    $0xff0000,%eax
801092cc:	01 c2                	add    %eax,%edx
801092ce:	8b 45 08             	mov    0x8(%ebp),%eax
801092d1:	c1 e8 08             	shr    $0x8,%eax
801092d4:	25 00 ff 00 00       	and    $0xff00,%eax
801092d9:	01 c2                	add    %eax,%edx
801092db:	8b 45 08             	mov    0x8(%ebp),%eax
801092de:	c1 e8 18             	shr    $0x18,%eax
801092e1:	01 d0                	add    %edx,%eax
}
801092e3:	5d                   	pop    %ebp
801092e4:	c3                   	ret    

801092e5 <ipv4_proc>:
extern uchar mac_addr[6];
extern uchar my_ip[4];

int ip_id = -1;
ushort send_id = 0;
void ipv4_proc(uint buffer_addr){
801092e5:	55                   	push   %ebp
801092e6:	89 e5                	mov    %esp,%ebp
801092e8:	83 ec 18             	sub    $0x18,%esp
  struct ipv4_pkt *ipv4_p = (struct ipv4_pkt *)(buffer_addr+14);
801092eb:	8b 45 08             	mov    0x8(%ebp),%eax
801092ee:	83 c0 0e             	add    $0xe,%eax
801092f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(ip_id != ipv4_p->id && memcmp(my_ip,ipv4_p->src_ip,4) != 0){
801092f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092f7:	66 8b 40 04          	mov    0x4(%eax),%ax
801092fb:	0f b7 d0             	movzwl %ax,%edx
801092fe:	a1 e8 e4 10 80       	mov    0x8010e4e8,%eax
80109303:	39 c2                	cmp    %eax,%edx
80109305:	74 5e                	je     80109365 <ipv4_proc+0x80>
80109307:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010930a:	83 c0 0c             	add    $0xc,%eax
8010930d:	83 ec 04             	sub    $0x4,%esp
80109310:	6a 04                	push   $0x4
80109312:	50                   	push   %eax
80109313:	68 e4 e4 10 80       	push   $0x8010e4e4
80109318:	e8 4f b6 ff ff       	call   8010496c <memcmp>
8010931d:	83 c4 10             	add    $0x10,%esp
80109320:	85 c0                	test   %eax,%eax
80109322:	74 41                	je     80109365 <ipv4_proc+0x80>
    ip_id = ipv4_p->id;
80109324:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109327:	66 8b 40 04          	mov    0x4(%eax),%ax
8010932b:	0f b7 c0             	movzwl %ax,%eax
8010932e:	a3 e8 e4 10 80       	mov    %eax,0x8010e4e8
      if(ipv4_p->protocol == IPV4_TYPE_ICMP){
80109333:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109336:	8a 40 09             	mov    0x9(%eax),%al
80109339:	3c 01                	cmp    $0x1,%al
8010933b:	75 10                	jne    8010934d <ipv4_proc+0x68>
        icmp_proc(buffer_addr);
8010933d:	83 ec 0c             	sub    $0xc,%esp
80109340:	ff 75 08             	pushl  0x8(%ebp)
80109343:	e8 9c 00 00 00       	call   801093e4 <icmp_proc>
80109348:	83 c4 10             	add    $0x10,%esp
      }else if(ipv4_p->protocol == IPV4_TYPE_TCP){
        tcp_proc(buffer_addr);
      }
  }
}
8010934b:	eb 18                	jmp    80109365 <ipv4_proc+0x80>
      }else if(ipv4_p->protocol == IPV4_TYPE_TCP){
8010934d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109350:	8a 40 09             	mov    0x9(%eax),%al
80109353:	3c 06                	cmp    $0x6,%al
80109355:	75 0e                	jne    80109365 <ipv4_proc+0x80>
        tcp_proc(buffer_addr);
80109357:	83 ec 0c             	sub    $0xc,%esp
8010935a:	ff 75 08             	pushl  0x8(%ebp)
8010935d:	e8 a0 03 00 00       	call   80109702 <tcp_proc>
80109362:	83 c4 10             	add    $0x10,%esp
}
80109365:	90                   	nop
80109366:	c9                   	leave  
80109367:	c3                   	ret    

80109368 <ipv4_chksum>:

ushort ipv4_chksum(uint ipv4_addr){
80109368:	55                   	push   %ebp
80109369:	89 e5                	mov    %esp,%ebp
8010936b:	83 ec 10             	sub    $0x10,%esp
  uchar* bin = (uchar *)ipv4_addr;
8010936e:	8b 45 08             	mov    0x8(%ebp),%eax
80109371:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uchar len = (bin[0]&0xF)*2;
80109374:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109377:	8a 00                	mov    (%eax),%al
80109379:	83 e0 0f             	and    $0xf,%eax
8010937c:	d1 e0                	shl    %eax
8010937e:	88 45 f3             	mov    %al,-0xd(%ebp)
  uint chk_sum = 0;
80109381:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  for(int i=0;i<len;i++){
80109388:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
8010938f:	eb 43                	jmp    801093d4 <ipv4_chksum+0x6c>
    chk_sum += (bin[i*2]<<8)+bin[i*2+1];
80109391:	8b 45 f8             	mov    -0x8(%ebp),%eax
80109394:	01 c0                	add    %eax,%eax
80109396:	89 c2                	mov    %eax,%edx
80109398:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010939b:	01 d0                	add    %edx,%eax
8010939d:	8a 00                	mov    (%eax),%al
8010939f:	0f b6 c0             	movzbl %al,%eax
801093a2:	c1 e0 08             	shl    $0x8,%eax
801093a5:	89 c2                	mov    %eax,%edx
801093a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
801093aa:	01 c0                	add    %eax,%eax
801093ac:	8d 48 01             	lea    0x1(%eax),%ecx
801093af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093b2:	01 c8                	add    %ecx,%eax
801093b4:	8a 00                	mov    (%eax),%al
801093b6:	0f b6 c0             	movzbl %al,%eax
801093b9:	01 d0                	add    %edx,%eax
801093bb:	01 45 fc             	add    %eax,-0x4(%ebp)
    if(chk_sum > 0xFFFF){
801093be:	81 7d fc ff ff 00 00 	cmpl   $0xffff,-0x4(%ebp)
801093c5:	76 0a                	jbe    801093d1 <ipv4_chksum+0x69>
      chk_sum = (chk_sum&0xFFFF)+1;
801093c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801093ca:	0f b7 c0             	movzwl %ax,%eax
801093cd:	40                   	inc    %eax
801093ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(int i=0;i<len;i++){
801093d1:	ff 45 f8             	incl   -0x8(%ebp)
801093d4:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
801093d8:	39 45 f8             	cmp    %eax,-0x8(%ebp)
801093db:	7c b4                	jl     80109391 <ipv4_chksum+0x29>
    }
  }
  return ~(chk_sum);
801093dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
801093e0:	f7 d0                	not    %eax
}
801093e2:	c9                   	leave  
801093e3:	c3                   	ret    

801093e4 <icmp_proc>:
#include "eth.h"

extern uchar mac_addr[6];
extern uchar my_ip[4];
extern ushort send_id;
void icmp_proc(uint buffer_addr){
801093e4:	55                   	push   %ebp
801093e5:	89 e5                	mov    %esp,%ebp
801093e7:	83 ec 18             	sub    $0x18,%esp
  struct ipv4_pkt *ipv4_p = (struct ipv4_pkt *)(buffer_addr+sizeof(struct eth_pkt));
801093ea:	8b 45 08             	mov    0x8(%ebp),%eax
801093ed:	83 c0 0e             	add    $0xe,%eax
801093f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct icmp_echo_pkt *icmp_p = (struct icmp_echo_pkt *)((uint)ipv4_p + (ipv4_p->ver&0xF)*4);
801093f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093f6:	8a 00                	mov    (%eax),%al
801093f8:	0f b6 c0             	movzbl %al,%eax
801093fb:	83 e0 0f             	and    $0xf,%eax
801093fe:	c1 e0 02             	shl    $0x2,%eax
80109401:	89 c2                	mov    %eax,%edx
80109403:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109406:	01 d0                	add    %edx,%eax
80109408:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(icmp_p->code == 0){
8010940b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010940e:	8a 40 01             	mov    0x1(%eax),%al
80109411:	84 c0                	test   %al,%al
80109413:	75 4e                	jne    80109463 <icmp_proc+0x7f>
    if(icmp_p->type == ICMP_TYPE_ECHO_REQUEST){
80109415:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109418:	8a 00                	mov    (%eax),%al
8010941a:	3c 08                	cmp    $0x8,%al
8010941c:	75 45                	jne    80109463 <icmp_proc+0x7f>
      uint send_addr = (uint)kalloc();
8010941e:	e8 11 93 ff ff       	call   80102734 <kalloc>
80109423:	89 45 ec             	mov    %eax,-0x14(%ebp)
      uint send_size = 0;
80109426:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
      icmp_reply_pkt_create(buffer_addr,send_addr,&send_size);
8010942d:	83 ec 04             	sub    $0x4,%esp
80109430:	8d 45 e8             	lea    -0x18(%ebp),%eax
80109433:	50                   	push   %eax
80109434:	ff 75 ec             	pushl  -0x14(%ebp)
80109437:	ff 75 08             	pushl  0x8(%ebp)
8010943a:	e8 78 00 00 00       	call   801094b7 <icmp_reply_pkt_create>
8010943f:	83 c4 10             	add    $0x10,%esp
      i8254_send(send_addr,send_size);
80109442:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109445:	83 ec 08             	sub    $0x8,%esp
80109448:	50                   	push   %eax
80109449:	ff 75 ec             	pushl  -0x14(%ebp)
8010944c:	e8 c2 f4 ff ff       	call   80108913 <i8254_send>
80109451:	83 c4 10             	add    $0x10,%esp
      kfree((char *)send_addr);
80109454:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109457:	83 ec 0c             	sub    $0xc,%esp
8010945a:	50                   	push   %eax
8010945b:	e8 3a 92 ff ff       	call   8010269a <kfree>
80109460:	83 c4 10             	add    $0x10,%esp
    }
  }
}
80109463:	90                   	nop
80109464:	c9                   	leave  
80109465:	c3                   	ret    

80109466 <icmp_proc_req>:

void icmp_proc_req(struct icmp_echo_pkt * icmp_p){
80109466:	55                   	push   %ebp
80109467:	89 e5                	mov    %esp,%ebp
80109469:	53                   	push   %ebx
8010946a:	83 ec 04             	sub    $0x4,%esp
  cprintf("ICMP ID:0x%x SEQ NUM:0x%x\n",N2H_ushort(icmp_p->id),N2H_ushort(icmp_p->seq_num));
8010946d:	8b 45 08             	mov    0x8(%ebp),%eax
80109470:	66 8b 40 06          	mov    0x6(%eax),%ax
80109474:	0f b7 c0             	movzwl %ax,%eax
80109477:	83 ec 0c             	sub    $0xc,%esp
8010947a:	50                   	push   %eax
8010947b:	e8 ca fd ff ff       	call   8010924a <N2H_ushort>
80109480:	83 c4 10             	add    $0x10,%esp
80109483:	0f b7 d8             	movzwl %ax,%ebx
80109486:	8b 45 08             	mov    0x8(%ebp),%eax
80109489:	66 8b 40 04          	mov    0x4(%eax),%ax
8010948d:	0f b7 c0             	movzwl %ax,%eax
80109490:	83 ec 0c             	sub    $0xc,%esp
80109493:	50                   	push   %eax
80109494:	e8 b1 fd ff ff       	call   8010924a <N2H_ushort>
80109499:	83 c4 10             	add    $0x10,%esp
8010949c:	0f b7 c0             	movzwl %ax,%eax
8010949f:	83 ec 04             	sub    $0x4,%esp
801094a2:	53                   	push   %ebx
801094a3:	50                   	push   %eax
801094a4:	68 83 bd 10 80       	push   $0x8010bd83
801094a9:	e8 43 6f ff ff       	call   801003f1 <cprintf>
801094ae:	83 c4 10             	add    $0x10,%esp
}
801094b1:	90                   	nop
801094b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801094b5:	c9                   	leave  
801094b6:	c3                   	ret    

801094b7 <icmp_reply_pkt_create>:

void icmp_reply_pkt_create(uint recv_addr,uint send_addr,uint *send_size){
801094b7:	55                   	push   %ebp
801094b8:	89 e5                	mov    %esp,%ebp
801094ba:	83 ec 28             	sub    $0x28,%esp
  struct eth_pkt *eth_recv = (struct eth_pkt *)(recv_addr);
801094bd:	8b 45 08             	mov    0x8(%ebp),%eax
801094c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct ipv4_pkt *ipv4_recv = (struct ipv4_pkt *)(recv_addr+sizeof(struct eth_pkt));
801094c3:	8b 45 08             	mov    0x8(%ebp),%eax
801094c6:	83 c0 0e             	add    $0xe,%eax
801094c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct icmp_echo_pkt *icmp_recv = (struct icmp_echo_pkt *)((uint)ipv4_recv+(ipv4_recv->ver&0xF)*4);
801094cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801094cf:	8a 00                	mov    (%eax),%al
801094d1:	0f b6 c0             	movzbl %al,%eax
801094d4:	83 e0 0f             	and    $0xf,%eax
801094d7:	c1 e0 02             	shl    $0x2,%eax
801094da:	89 c2                	mov    %eax,%edx
801094dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801094df:	01 d0                	add    %edx,%eax
801094e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct eth_pkt *eth_send = (struct eth_pkt *)(send_addr);
801094e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801094e7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  struct ipv4_pkt *ipv4_send = (struct ipv4_pkt *)(send_addr+sizeof(struct eth_pkt));
801094ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801094ed:	83 c0 0e             	add    $0xe,%eax
801094f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  struct icmp_echo_pkt *icmp_send = (struct icmp_echo_pkt *)((uint)ipv4_send+sizeof(struct ipv4_pkt));
801094f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801094f6:	83 c0 14             	add    $0x14,%eax
801094f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  
  *send_size = sizeof(struct eth_pkt) + sizeof(struct ipv4_pkt) + sizeof(struct icmp_echo_pkt);
801094fc:	8b 45 10             	mov    0x10(%ebp),%eax
801094ff:	c7 00 62 00 00 00    	movl   $0x62,(%eax)
  memmove(eth_send->dst_mac,eth_recv->src_mac,6);
80109505:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109508:	8d 50 06             	lea    0x6(%eax),%edx
8010950b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010950e:	83 ec 04             	sub    $0x4,%esp
80109511:	6a 06                	push   $0x6
80109513:	52                   	push   %edx
80109514:	50                   	push   %eax
80109515:	e8 a4 b4 ff ff       	call   801049be <memmove>
8010951a:	83 c4 10             	add    $0x10,%esp
  memmove(eth_send->src_mac,mac_addr,6);
8010951d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109520:	83 c0 06             	add    $0x6,%eax
80109523:	83 ec 04             	sub    $0x4,%esp
80109526:	6a 06                	push   $0x6
80109528:	68 80 5c 19 80       	push   $0x80195c80
8010952d:	50                   	push   %eax
8010952e:	e8 8b b4 ff ff       	call   801049be <memmove>
80109533:	83 c4 10             	add    $0x10,%esp
  eth_send->type[0] = 0x08;
80109536:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109539:	c6 40 0c 08          	movb   $0x8,0xc(%eax)
  eth_send->type[1] = 0x00;
8010953d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109540:	c6 40 0d 00          	movb   $0x0,0xd(%eax)

  ipv4_send->ver = ((0x4)<<4)+((sizeof(struct ipv4_pkt)/4)&0xF);
80109544:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109547:	c6 00 45             	movb   $0x45,(%eax)
  ipv4_send->srv_type = 0;
8010954a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010954d:	c6 40 01 00          	movb   $0x0,0x1(%eax)
  ipv4_send->total_len = H2N_ushort(sizeof(struct ipv4_pkt) + sizeof(struct icmp_echo_pkt));
80109551:	83 ec 0c             	sub    $0xc,%esp
80109554:	6a 54                	push   $0x54
80109556:	e8 10 fd ff ff       	call   8010926b <H2N_ushort>
8010955b:	83 c4 10             	add    $0x10,%esp
8010955e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80109561:	66 89 42 02          	mov    %ax,0x2(%edx)
  ipv4_send->id = send_id;
80109565:	66 a1 60 5f 19 80    	mov    0x80195f60,%ax
8010956b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010956e:	66 89 42 04          	mov    %ax,0x4(%edx)
  send_id++;
80109572:	66 a1 60 5f 19 80    	mov    0x80195f60,%ax
80109578:	40                   	inc    %eax
80109579:	66 a3 60 5f 19 80    	mov    %ax,0x80195f60
  ipv4_send->fragment = H2N_ushort(0x4000);
8010957f:	83 ec 0c             	sub    $0xc,%esp
80109582:	68 00 40 00 00       	push   $0x4000
80109587:	e8 df fc ff ff       	call   8010926b <H2N_ushort>
8010958c:	83 c4 10             	add    $0x10,%esp
8010958f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80109592:	66 89 42 06          	mov    %ax,0x6(%edx)
  ipv4_send->ttl = 255;
80109596:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109599:	c6 40 08 ff          	movb   $0xff,0x8(%eax)
  ipv4_send->protocol = 0x1;
8010959d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801095a0:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  memmove(ipv4_send->src_ip,my_ip,4);
801095a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801095a7:	83 c0 0c             	add    $0xc,%eax
801095aa:	83 ec 04             	sub    $0x4,%esp
801095ad:	6a 04                	push   $0x4
801095af:	68 e4 e4 10 80       	push   $0x8010e4e4
801095b4:	50                   	push   %eax
801095b5:	e8 04 b4 ff ff       	call   801049be <memmove>
801095ba:	83 c4 10             	add    $0x10,%esp
  memmove(ipv4_send->dst_ip,ipv4_recv->src_ip,4);
801095bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801095c0:	8d 50 0c             	lea    0xc(%eax),%edx
801095c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801095c6:	83 c0 10             	add    $0x10,%eax
801095c9:	83 ec 04             	sub    $0x4,%esp
801095cc:	6a 04                	push   $0x4
801095ce:	52                   	push   %edx
801095cf:	50                   	push   %eax
801095d0:	e8 e9 b3 ff ff       	call   801049be <memmove>
801095d5:	83 c4 10             	add    $0x10,%esp
  ipv4_send->chk_sum = 0;
801095d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801095db:	66 c7 40 0a 00 00    	movw   $0x0,0xa(%eax)
  ipv4_send->chk_sum = H2N_ushort(ipv4_chksum((uint)ipv4_send));
801095e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801095e4:	83 ec 0c             	sub    $0xc,%esp
801095e7:	50                   	push   %eax
801095e8:	e8 7b fd ff ff       	call   80109368 <ipv4_chksum>
801095ed:	83 c4 10             	add    $0x10,%esp
801095f0:	0f b7 c0             	movzwl %ax,%eax
801095f3:	83 ec 0c             	sub    $0xc,%esp
801095f6:	50                   	push   %eax
801095f7:	e8 6f fc ff ff       	call   8010926b <H2N_ushort>
801095fc:	83 c4 10             	add    $0x10,%esp
801095ff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80109602:	66 89 42 0a          	mov    %ax,0xa(%edx)

  icmp_send->type = ICMP_TYPE_ECHO_REPLY;
80109606:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109609:	c6 00 00             	movb   $0x0,(%eax)
  icmp_send->code = 0;
8010960c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010960f:	c6 40 01 00          	movb   $0x0,0x1(%eax)
  icmp_send->id = icmp_recv->id;
80109613:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109616:	66 8b 40 04          	mov    0x4(%eax),%ax
8010961a:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010961d:	66 89 42 04          	mov    %ax,0x4(%edx)
  icmp_send->seq_num = icmp_recv->seq_num;
80109621:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109624:	66 8b 40 06          	mov    0x6(%eax),%ax
80109628:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010962b:	66 89 42 06          	mov    %ax,0x6(%edx)
  memmove(icmp_send->time_stamp,icmp_recv->time_stamp,8);
8010962f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109632:	8d 50 08             	lea    0x8(%eax),%edx
80109635:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109638:	83 c0 08             	add    $0x8,%eax
8010963b:	83 ec 04             	sub    $0x4,%esp
8010963e:	6a 08                	push   $0x8
80109640:	52                   	push   %edx
80109641:	50                   	push   %eax
80109642:	e8 77 b3 ff ff       	call   801049be <memmove>
80109647:	83 c4 10             	add    $0x10,%esp
  memmove(icmp_send->data,icmp_recv->data,48);
8010964a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010964d:	8d 50 10             	lea    0x10(%eax),%edx
80109650:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109653:	83 c0 10             	add    $0x10,%eax
80109656:	83 ec 04             	sub    $0x4,%esp
80109659:	6a 30                	push   $0x30
8010965b:	52                   	push   %edx
8010965c:	50                   	push   %eax
8010965d:	e8 5c b3 ff ff       	call   801049be <memmove>
80109662:	83 c4 10             	add    $0x10,%esp
  icmp_send->chk_sum = 0;
80109665:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109668:	66 c7 40 02 00 00    	movw   $0x0,0x2(%eax)
  icmp_send->chk_sum = H2N_ushort(icmp_chksum((uint)icmp_send));
8010966e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109671:	83 ec 0c             	sub    $0xc,%esp
80109674:	50                   	push   %eax
80109675:	e8 1c 00 00 00       	call   80109696 <icmp_chksum>
8010967a:	83 c4 10             	add    $0x10,%esp
8010967d:	0f b7 c0             	movzwl %ax,%eax
80109680:	83 ec 0c             	sub    $0xc,%esp
80109683:	50                   	push   %eax
80109684:	e8 e2 fb ff ff       	call   8010926b <H2N_ushort>
80109689:	83 c4 10             	add    $0x10,%esp
8010968c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010968f:	66 89 42 02          	mov    %ax,0x2(%edx)
}
80109693:	90                   	nop
80109694:	c9                   	leave  
80109695:	c3                   	ret    

80109696 <icmp_chksum>:

ushort icmp_chksum(uint icmp_addr){
80109696:	55                   	push   %ebp
80109697:	89 e5                	mov    %esp,%ebp
80109699:	83 ec 10             	sub    $0x10,%esp
  uchar* bin = (uchar *)icmp_addr;
8010969c:	8b 45 08             	mov    0x8(%ebp),%eax
8010969f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint chk_sum = 0;
801096a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  for(int i=0;i<32;i++){
801096a9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801096b0:	eb 43                	jmp    801096f5 <icmp_chksum+0x5f>
    chk_sum += (bin[i*2]<<8)+bin[i*2+1];
801096b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
801096b5:	01 c0                	add    %eax,%eax
801096b7:	89 c2                	mov    %eax,%edx
801096b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801096bc:	01 d0                	add    %edx,%eax
801096be:	8a 00                	mov    (%eax),%al
801096c0:	0f b6 c0             	movzbl %al,%eax
801096c3:	c1 e0 08             	shl    $0x8,%eax
801096c6:	89 c2                	mov    %eax,%edx
801096c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
801096cb:	01 c0                	add    %eax,%eax
801096cd:	8d 48 01             	lea    0x1(%eax),%ecx
801096d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801096d3:	01 c8                	add    %ecx,%eax
801096d5:	8a 00                	mov    (%eax),%al
801096d7:	0f b6 c0             	movzbl %al,%eax
801096da:	01 d0                	add    %edx,%eax
801096dc:	01 45 fc             	add    %eax,-0x4(%ebp)
    if(chk_sum > 0xFFFF){
801096df:	81 7d fc ff ff 00 00 	cmpl   $0xffff,-0x4(%ebp)
801096e6:	76 0a                	jbe    801096f2 <icmp_chksum+0x5c>
      chk_sum = (chk_sum&0xFFFF)+1;
801096e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801096eb:	0f b7 c0             	movzwl %ax,%eax
801096ee:	40                   	inc    %eax
801096ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(int i=0;i<32;i++){
801096f2:	ff 45 f8             	incl   -0x8(%ebp)
801096f5:	83 7d f8 1f          	cmpl   $0x1f,-0x8(%ebp)
801096f9:	7e b7                	jle    801096b2 <icmp_chksum+0x1c>
    }
  }
  return ~(chk_sum);
801096fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801096fe:	f7 d0                	not    %eax
}
80109700:	c9                   	leave  
80109701:	c3                   	ret    

80109702 <tcp_proc>:
extern ushort send_id;
extern uchar mac_addr[6];
extern uchar my_ip[4];
int fin_flag = 0;

void tcp_proc(uint buffer_addr){
80109702:	55                   	push   %ebp
80109703:	89 e5                	mov    %esp,%ebp
80109705:	83 ec 38             	sub    $0x38,%esp
  struct ipv4_pkt *ipv4_p = (struct ipv4_pkt *)(buffer_addr + sizeof(struct eth_pkt));
80109708:	8b 45 08             	mov    0x8(%ebp),%eax
8010970b:	83 c0 0e             	add    $0xe,%eax
8010970e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct tcp_pkt *tcp_p = (struct tcp_pkt *)((uint)ipv4_p + (ipv4_p->ver&0xF)*4);
80109711:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109714:	8a 00                	mov    (%eax),%al
80109716:	0f b6 c0             	movzbl %al,%eax
80109719:	83 e0 0f             	and    $0xf,%eax
8010971c:	c1 e0 02             	shl    $0x2,%eax
8010971f:	89 c2                	mov    %eax,%edx
80109721:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109724:	01 d0                	add    %edx,%eax
80109726:	89 45 f0             	mov    %eax,-0x10(%ebp)
  char *payload = (char *)((uint)tcp_p + 20);
80109729:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010972c:	83 c0 14             	add    $0x14,%eax
8010972f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  uint send_addr = (uint)kalloc();
80109732:	e8 fd 8f ff ff       	call   80102734 <kalloc>
80109737:	89 45 e8             	mov    %eax,-0x18(%ebp)
  uint send_size = 0;
8010973a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  if(tcp_p->code_bits[1]&TCP_CODEBITS_SYN){
80109741:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109744:	8a 40 0d             	mov    0xd(%eax),%al
80109747:	0f b6 c0             	movzbl %al,%eax
8010974a:	83 e0 02             	and    $0x2,%eax
8010974d:	85 c0                	test   %eax,%eax
8010974f:	74 3b                	je     8010978c <tcp_proc+0x8a>
    tcp_pkt_create(buffer_addr,send_addr,&send_size,TCP_CODEBITS_ACK | TCP_CODEBITS_SYN,0);
80109751:	83 ec 0c             	sub    $0xc,%esp
80109754:	6a 00                	push   $0x0
80109756:	6a 12                	push   $0x12
80109758:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010975b:	50                   	push   %eax
8010975c:	ff 75 e8             	pushl  -0x18(%ebp)
8010975f:	ff 75 08             	pushl  0x8(%ebp)
80109762:	e8 9c 01 00 00       	call   80109903 <tcp_pkt_create>
80109767:	83 c4 20             	add    $0x20,%esp
    i8254_send(send_addr,send_size);
8010976a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010976d:	83 ec 08             	sub    $0x8,%esp
80109770:	50                   	push   %eax
80109771:	ff 75 e8             	pushl  -0x18(%ebp)
80109774:	e8 9a f1 ff ff       	call   80108913 <i8254_send>
80109779:	83 c4 10             	add    $0x10,%esp
    seq_num++;
8010977c:	a1 64 5f 19 80       	mov    0x80195f64,%eax
80109781:	40                   	inc    %eax
80109782:	a3 64 5f 19 80       	mov    %eax,0x80195f64
80109787:	e9 65 01 00 00       	jmp    801098f1 <tcp_proc+0x1ef>
  }else if(tcp_p->code_bits[1] == (TCP_CODEBITS_PSH | TCP_CODEBITS_ACK)){
8010978c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010978f:	8a 40 0d             	mov    0xd(%eax),%al
80109792:	3c 18                	cmp    $0x18,%al
80109794:	0f 85 0e 01 00 00    	jne    801098a8 <tcp_proc+0x1a6>
    if(memcmp(payload,"GET",3)){
8010979a:	83 ec 04             	sub    $0x4,%esp
8010979d:	6a 03                	push   $0x3
8010979f:	68 9e bd 10 80       	push   $0x8010bd9e
801097a4:	ff 75 ec             	pushl  -0x14(%ebp)
801097a7:	e8 c0 b1 ff ff       	call   8010496c <memcmp>
801097ac:	83 c4 10             	add    $0x10,%esp
801097af:	85 c0                	test   %eax,%eax
801097b1:	74 74                	je     80109827 <tcp_proc+0x125>
      cprintf("ACK PSH\n");
801097b3:	83 ec 0c             	sub    $0xc,%esp
801097b6:	68 a2 bd 10 80       	push   $0x8010bda2
801097bb:	e8 31 6c ff ff       	call   801003f1 <cprintf>
801097c0:	83 c4 10             	add    $0x10,%esp
      tcp_pkt_create(buffer_addr,send_addr,&send_size,TCP_CODEBITS_ACK,0);
801097c3:	83 ec 0c             	sub    $0xc,%esp
801097c6:	6a 00                	push   $0x0
801097c8:	6a 10                	push   $0x10
801097ca:	8d 45 dc             	lea    -0x24(%ebp),%eax
801097cd:	50                   	push   %eax
801097ce:	ff 75 e8             	pushl  -0x18(%ebp)
801097d1:	ff 75 08             	pushl  0x8(%ebp)
801097d4:	e8 2a 01 00 00       	call   80109903 <tcp_pkt_create>
801097d9:	83 c4 20             	add    $0x20,%esp
      i8254_send(send_addr,send_size);
801097dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801097df:	83 ec 08             	sub    $0x8,%esp
801097e2:	50                   	push   %eax
801097e3:	ff 75 e8             	pushl  -0x18(%ebp)
801097e6:	e8 28 f1 ff ff       	call   80108913 <i8254_send>
801097eb:	83 c4 10             	add    $0x10,%esp
      uint send_payload = (send_addr + sizeof(struct eth_pkt) + sizeof(struct ipv4_pkt) + sizeof(struct tcp_pkt));
801097ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
801097f1:	83 c0 36             	add    $0x36,%eax
801097f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
      uint payload_size;
      http_proc(0,0,send_payload,&payload_size);
801097f7:	8d 45 d8             	lea    -0x28(%ebp),%eax
801097fa:	50                   	push   %eax
801097fb:	ff 75 e0             	pushl  -0x20(%ebp)
801097fe:	6a 00                	push   $0x0
80109800:	6a 00                	push   $0x0
80109802:	e8 4c 04 00 00       	call   80109c53 <http_proc>
80109807:	83 c4 10             	add    $0x10,%esp
      tcp_pkt_create(buffer_addr,send_addr,&send_size,(TCP_CODEBITS_ACK|TCP_CODEBITS_PSH),payload_size);
8010980a:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010980d:	83 ec 0c             	sub    $0xc,%esp
80109810:	50                   	push   %eax
80109811:	6a 18                	push   $0x18
80109813:	8d 45 dc             	lea    -0x24(%ebp),%eax
80109816:	50                   	push   %eax
80109817:	ff 75 e8             	pushl  -0x18(%ebp)
8010981a:	ff 75 08             	pushl  0x8(%ebp)
8010981d:	e8 e1 00 00 00       	call   80109903 <tcp_pkt_create>
80109822:	83 c4 20             	add    $0x20,%esp
80109825:	eb 62                	jmp    80109889 <tcp_proc+0x187>
    }else{
     tcp_pkt_create(buffer_addr,send_addr,&send_size,TCP_CODEBITS_ACK,0);
80109827:	83 ec 0c             	sub    $0xc,%esp
8010982a:	6a 00                	push   $0x0
8010982c:	6a 10                	push   $0x10
8010982e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80109831:	50                   	push   %eax
80109832:	ff 75 e8             	pushl  -0x18(%ebp)
80109835:	ff 75 08             	pushl  0x8(%ebp)
80109838:	e8 c6 00 00 00       	call   80109903 <tcp_pkt_create>
8010983d:	83 c4 20             	add    $0x20,%esp
     i8254_send(send_addr,send_size);
80109840:	8b 45 dc             	mov    -0x24(%ebp),%eax
80109843:	83 ec 08             	sub    $0x8,%esp
80109846:	50                   	push   %eax
80109847:	ff 75 e8             	pushl  -0x18(%ebp)
8010984a:	e8 c4 f0 ff ff       	call   80108913 <i8254_send>
8010984f:	83 c4 10             	add    $0x10,%esp
      uint send_payload = (send_addr + sizeof(struct eth_pkt) + sizeof(struct ipv4_pkt) + sizeof(struct tcp_pkt));
80109852:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109855:	83 c0 36             	add    $0x36,%eax
80109858:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      uint payload_size;
      http_proc(0,0,send_payload,&payload_size);
8010985b:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010985e:	50                   	push   %eax
8010985f:	ff 75 e4             	pushl  -0x1c(%ebp)
80109862:	6a 00                	push   $0x0
80109864:	6a 00                	push   $0x0
80109866:	e8 e8 03 00 00       	call   80109c53 <http_proc>
8010986b:	83 c4 10             	add    $0x10,%esp
      tcp_pkt_create(buffer_addr,send_addr,&send_size,(TCP_CODEBITS_ACK|TCP_CODEBITS_PSH),payload_size);
8010986e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80109871:	83 ec 0c             	sub    $0xc,%esp
80109874:	50                   	push   %eax
80109875:	6a 18                	push   $0x18
80109877:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010987a:	50                   	push   %eax
8010987b:	ff 75 e8             	pushl  -0x18(%ebp)
8010987e:	ff 75 08             	pushl  0x8(%ebp)
80109881:	e8 7d 00 00 00       	call   80109903 <tcp_pkt_create>
80109886:	83 c4 20             	add    $0x20,%esp
    }
    i8254_send(send_addr,send_size);
80109889:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010988c:	83 ec 08             	sub    $0x8,%esp
8010988f:	50                   	push   %eax
80109890:	ff 75 e8             	pushl  -0x18(%ebp)
80109893:	e8 7b f0 ff ff       	call   80108913 <i8254_send>
80109898:	83 c4 10             	add    $0x10,%esp
    seq_num++;
8010989b:	a1 64 5f 19 80       	mov    0x80195f64,%eax
801098a0:	40                   	inc    %eax
801098a1:	a3 64 5f 19 80       	mov    %eax,0x80195f64
801098a6:	eb 49                	jmp    801098f1 <tcp_proc+0x1ef>
  }else if(tcp_p->code_bits[1] == TCP_CODEBITS_ACK){
801098a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801098ab:	8a 40 0d             	mov    0xd(%eax),%al
801098ae:	3c 10                	cmp    $0x10,%al
801098b0:	75 3f                	jne    801098f1 <tcp_proc+0x1ef>
    if(fin_flag == 1){
801098b2:	a1 68 5f 19 80       	mov    0x80195f68,%eax
801098b7:	83 f8 01             	cmp    $0x1,%eax
801098ba:	75 35                	jne    801098f1 <tcp_proc+0x1ef>
      tcp_pkt_create(buffer_addr,send_addr,&send_size,TCP_CODEBITS_FIN,0);
801098bc:	83 ec 0c             	sub    $0xc,%esp
801098bf:	6a 00                	push   $0x0
801098c1:	6a 01                	push   $0x1
801098c3:	8d 45 dc             	lea    -0x24(%ebp),%eax
801098c6:	50                   	push   %eax
801098c7:	ff 75 e8             	pushl  -0x18(%ebp)
801098ca:	ff 75 08             	pushl  0x8(%ebp)
801098cd:	e8 31 00 00 00       	call   80109903 <tcp_pkt_create>
801098d2:	83 c4 20             	add    $0x20,%esp
      i8254_send(send_addr,send_size);
801098d5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801098d8:	83 ec 08             	sub    $0x8,%esp
801098db:	50                   	push   %eax
801098dc:	ff 75 e8             	pushl  -0x18(%ebp)
801098df:	e8 2f f0 ff ff       	call   80108913 <i8254_send>
801098e4:	83 c4 10             	add    $0x10,%esp
      fin_flag = 0;
801098e7:	c7 05 68 5f 19 80 00 	movl   $0x0,0x80195f68
801098ee:	00 00 00 
    }
  }
  kfree((char *)send_addr);
801098f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801098f4:	83 ec 0c             	sub    $0xc,%esp
801098f7:	50                   	push   %eax
801098f8:	e8 9d 8d ff ff       	call   8010269a <kfree>
801098fd:	83 c4 10             	add    $0x10,%esp
}
80109900:	90                   	nop
80109901:	c9                   	leave  
80109902:	c3                   	ret    

80109903 <tcp_pkt_create>:

void tcp_pkt_create(uint recv_addr,uint send_addr,uint *send_size,uint pkt_type,uint payload_size){
80109903:	55                   	push   %ebp
80109904:	89 e5                	mov    %esp,%ebp
80109906:	83 ec 28             	sub    $0x28,%esp
  struct eth_pkt *eth_recv = (struct eth_pkt *)(recv_addr);
80109909:	8b 45 08             	mov    0x8(%ebp),%eax
8010990c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct ipv4_pkt *ipv4_recv = (struct ipv4_pkt *)(recv_addr+sizeof(struct eth_pkt));
8010990f:	8b 45 08             	mov    0x8(%ebp),%eax
80109912:	83 c0 0e             	add    $0xe,%eax
80109915:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct tcp_pkt *tcp_recv = (struct tcp_pkt *)((uint)ipv4_recv + (ipv4_recv->ver&0xF)*4);
80109918:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010991b:	8a 00                	mov    (%eax),%al
8010991d:	0f b6 c0             	movzbl %al,%eax
80109920:	83 e0 0f             	and    $0xf,%eax
80109923:	c1 e0 02             	shl    $0x2,%eax
80109926:	89 c2                	mov    %eax,%edx
80109928:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010992b:	01 d0                	add    %edx,%eax
8010992d:	89 45 ec             	mov    %eax,-0x14(%ebp)

  struct eth_pkt *eth_send = (struct eth_pkt *)(send_addr);
80109930:	8b 45 0c             	mov    0xc(%ebp),%eax
80109933:	89 45 e8             	mov    %eax,-0x18(%ebp)
  struct ipv4_pkt *ipv4_send = (struct ipv4_pkt *)(send_addr + sizeof(struct eth_pkt));
80109936:	8b 45 0c             	mov    0xc(%ebp),%eax
80109939:	83 c0 0e             	add    $0xe,%eax
8010993c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  struct tcp_pkt *tcp_send = (struct tcp_pkt *)((uint)ipv4_send + sizeof(struct ipv4_pkt));
8010993f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109942:	83 c0 14             	add    $0x14,%eax
80109945:	89 45 e0             	mov    %eax,-0x20(%ebp)

  *send_size = sizeof(struct eth_pkt) + sizeof(struct ipv4_pkt) + sizeof(struct tcp_pkt) + payload_size;
80109948:	8b 45 18             	mov    0x18(%ebp),%eax
8010994b:	8d 50 36             	lea    0x36(%eax),%edx
8010994e:	8b 45 10             	mov    0x10(%ebp),%eax
80109951:	89 10                	mov    %edx,(%eax)

  memmove(eth_send->dst_mac,eth_recv->src_mac,6);
80109953:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109956:	8d 50 06             	lea    0x6(%eax),%edx
80109959:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010995c:	83 ec 04             	sub    $0x4,%esp
8010995f:	6a 06                	push   $0x6
80109961:	52                   	push   %edx
80109962:	50                   	push   %eax
80109963:	e8 56 b0 ff ff       	call   801049be <memmove>
80109968:	83 c4 10             	add    $0x10,%esp
  memmove(eth_send->src_mac,mac_addr,6);
8010996b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010996e:	83 c0 06             	add    $0x6,%eax
80109971:	83 ec 04             	sub    $0x4,%esp
80109974:	6a 06                	push   $0x6
80109976:	68 80 5c 19 80       	push   $0x80195c80
8010997b:	50                   	push   %eax
8010997c:	e8 3d b0 ff ff       	call   801049be <memmove>
80109981:	83 c4 10             	add    $0x10,%esp
  eth_send->type[0] = 0x08;
80109984:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109987:	c6 40 0c 08          	movb   $0x8,0xc(%eax)
  eth_send->type[1] = 0x00;
8010998b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010998e:	c6 40 0d 00          	movb   $0x0,0xd(%eax)

  ipv4_send->ver = ((0x4)<<4)+((sizeof(struct ipv4_pkt)/4)&0xF);
80109992:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109995:	c6 00 45             	movb   $0x45,(%eax)
  ipv4_send->srv_type = 0;
80109998:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010999b:	c6 40 01 00          	movb   $0x0,0x1(%eax)
  ipv4_send->total_len = H2N_ushort(sizeof(struct ipv4_pkt) + sizeof(struct tcp_pkt) + payload_size);
8010999f:	8b 45 18             	mov    0x18(%ebp),%eax
801099a2:	83 c0 28             	add    $0x28,%eax
801099a5:	0f b7 c0             	movzwl %ax,%eax
801099a8:	83 ec 0c             	sub    $0xc,%esp
801099ab:	50                   	push   %eax
801099ac:	e8 ba f8 ff ff       	call   8010926b <H2N_ushort>
801099b1:	83 c4 10             	add    $0x10,%esp
801099b4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801099b7:	66 89 42 02          	mov    %ax,0x2(%edx)
  ipv4_send->id = send_id;
801099bb:	66 a1 60 5f 19 80    	mov    0x80195f60,%ax
801099c1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801099c4:	66 89 42 04          	mov    %ax,0x4(%edx)
  send_id++;
801099c8:	66 a1 60 5f 19 80    	mov    0x80195f60,%ax
801099ce:	40                   	inc    %eax
801099cf:	66 a3 60 5f 19 80    	mov    %ax,0x80195f60
  ipv4_send->fragment = H2N_ushort(0x0000);
801099d5:	83 ec 0c             	sub    $0xc,%esp
801099d8:	6a 00                	push   $0x0
801099da:	e8 8c f8 ff ff       	call   8010926b <H2N_ushort>
801099df:	83 c4 10             	add    $0x10,%esp
801099e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801099e5:	66 89 42 06          	mov    %ax,0x6(%edx)
  ipv4_send->ttl = 255;
801099e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801099ec:	c6 40 08 ff          	movb   $0xff,0x8(%eax)
  ipv4_send->protocol = IPV4_TYPE_TCP;
801099f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801099f3:	c6 40 09 06          	movb   $0x6,0x9(%eax)
  memmove(ipv4_send->src_ip,my_ip,4);
801099f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801099fa:	83 c0 0c             	add    $0xc,%eax
801099fd:	83 ec 04             	sub    $0x4,%esp
80109a00:	6a 04                	push   $0x4
80109a02:	68 e4 e4 10 80       	push   $0x8010e4e4
80109a07:	50                   	push   %eax
80109a08:	e8 b1 af ff ff       	call   801049be <memmove>
80109a0d:	83 c4 10             	add    $0x10,%esp
  memmove(ipv4_send->dst_ip,ipv4_recv->src_ip,4);
80109a10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109a13:	8d 50 0c             	lea    0xc(%eax),%edx
80109a16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109a19:	83 c0 10             	add    $0x10,%eax
80109a1c:	83 ec 04             	sub    $0x4,%esp
80109a1f:	6a 04                	push   $0x4
80109a21:	52                   	push   %edx
80109a22:	50                   	push   %eax
80109a23:	e8 96 af ff ff       	call   801049be <memmove>
80109a28:	83 c4 10             	add    $0x10,%esp
  ipv4_send->chk_sum = 0;
80109a2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109a2e:	66 c7 40 0a 00 00    	movw   $0x0,0xa(%eax)
  ipv4_send->chk_sum = H2N_ushort(ipv4_chksum((uint)ipv4_send));
80109a34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109a37:	83 ec 0c             	sub    $0xc,%esp
80109a3a:	50                   	push   %eax
80109a3b:	e8 28 f9 ff ff       	call   80109368 <ipv4_chksum>
80109a40:	83 c4 10             	add    $0x10,%esp
80109a43:	0f b7 c0             	movzwl %ax,%eax
80109a46:	83 ec 0c             	sub    $0xc,%esp
80109a49:	50                   	push   %eax
80109a4a:	e8 1c f8 ff ff       	call   8010926b <H2N_ushort>
80109a4f:	83 c4 10             	add    $0x10,%esp
80109a52:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80109a55:	66 89 42 0a          	mov    %ax,0xa(%edx)
  

  tcp_send->src_port = tcp_recv->dst_port;
80109a59:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109a5c:	66 8b 40 02          	mov    0x2(%eax),%ax
80109a60:	8b 55 e0             	mov    -0x20(%ebp),%edx
80109a63:	66 89 02             	mov    %ax,(%edx)
  tcp_send->dst_port = tcp_recv->src_port;
80109a66:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109a69:	66 8b 00             	mov    (%eax),%ax
80109a6c:	8b 55 e0             	mov    -0x20(%ebp),%edx
80109a6f:	66 89 42 02          	mov    %ax,0x2(%edx)
  tcp_send->seq_num = H2N_uint(seq_num);
80109a73:	a1 64 5f 19 80       	mov    0x80195f64,%eax
80109a78:	83 ec 0c             	sub    $0xc,%esp
80109a7b:	50                   	push   %eax
80109a7c:	e8 0b f8 ff ff       	call   8010928c <H2N_uint>
80109a81:	83 c4 10             	add    $0x10,%esp
80109a84:	8b 55 e0             	mov    -0x20(%ebp),%edx
80109a87:	89 42 04             	mov    %eax,0x4(%edx)
  tcp_send->ack_num = tcp_recv->seq_num + (1<<(8*3));
80109a8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109a8d:	8b 40 04             	mov    0x4(%eax),%eax
80109a90:	8d 90 00 00 00 01    	lea    0x1000000(%eax),%edx
80109a96:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109a99:	89 50 08             	mov    %edx,0x8(%eax)

  tcp_send->code_bits[0] = 0;
80109a9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109a9f:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
  tcp_send->code_bits[1] = 0;
80109aa3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109aa6:	c6 40 0d 00          	movb   $0x0,0xd(%eax)
  tcp_send->code_bits[0] = 5<<4;
80109aaa:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109aad:	c6 40 0c 50          	movb   $0x50,0xc(%eax)
  tcp_send->code_bits[1] = pkt_type;
80109ab1:	8b 45 14             	mov    0x14(%ebp),%eax
80109ab4:	88 c2                	mov    %al,%dl
80109ab6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109ab9:	88 50 0d             	mov    %dl,0xd(%eax)

  tcp_send->window = H2N_ushort(14480);
80109abc:	83 ec 0c             	sub    $0xc,%esp
80109abf:	68 90 38 00 00       	push   $0x3890
80109ac4:	e8 a2 f7 ff ff       	call   8010926b <H2N_ushort>
80109ac9:	83 c4 10             	add    $0x10,%esp
80109acc:	8b 55 e0             	mov    -0x20(%ebp),%edx
80109acf:	66 89 42 0e          	mov    %ax,0xe(%edx)
  tcp_send->urgent_ptr = 0;
80109ad3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109ad6:	66 c7 40 12 00 00    	movw   $0x0,0x12(%eax)
  tcp_send->chk_sum = 0;
80109adc:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109adf:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)

  tcp_send->chk_sum = H2N_ushort(tcp_chksum((uint)(ipv4_send))+8);
80109ae5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109ae8:	83 ec 0c             	sub    $0xc,%esp
80109aeb:	50                   	push   %eax
80109aec:	e8 1f 00 00 00       	call   80109b10 <tcp_chksum>
80109af1:	83 c4 10             	add    $0x10,%esp
80109af4:	83 c0 08             	add    $0x8,%eax
80109af7:	0f b7 c0             	movzwl %ax,%eax
80109afa:	83 ec 0c             	sub    $0xc,%esp
80109afd:	50                   	push   %eax
80109afe:	e8 68 f7 ff ff       	call   8010926b <H2N_ushort>
80109b03:	83 c4 10             	add    $0x10,%esp
80109b06:	8b 55 e0             	mov    -0x20(%ebp),%edx
80109b09:	66 89 42 10          	mov    %ax,0x10(%edx)


}
80109b0d:	90                   	nop
80109b0e:	c9                   	leave  
80109b0f:	c3                   	ret    

80109b10 <tcp_chksum>:

ushort tcp_chksum(uint tcp_addr){
80109b10:	55                   	push   %ebp
80109b11:	89 e5                	mov    %esp,%ebp
80109b13:	83 ec 38             	sub    $0x38,%esp
  struct ipv4_pkt *ipv4_p = (struct ipv4_pkt *)(tcp_addr);
80109b16:	8b 45 08             	mov    0x8(%ebp),%eax
80109b19:	89 45 e8             	mov    %eax,-0x18(%ebp)
  struct tcp_pkt *tcp_p = (struct tcp_pkt *)((uint)ipv4_p + sizeof(struct ipv4_pkt));
80109b1c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109b1f:	83 c0 14             	add    $0x14,%eax
80109b22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  struct tcp_dummy tcp_dummy;
  
  memmove(tcp_dummy.src_ip,my_ip,4);
80109b25:	83 ec 04             	sub    $0x4,%esp
80109b28:	6a 04                	push   $0x4
80109b2a:	68 e4 e4 10 80       	push   $0x8010e4e4
80109b2f:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80109b32:	50                   	push   %eax
80109b33:	e8 86 ae ff ff       	call   801049be <memmove>
80109b38:	83 c4 10             	add    $0x10,%esp
  memmove(tcp_dummy.dst_ip,ipv4_p->src_ip,4);
80109b3b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109b3e:	83 c0 0c             	add    $0xc,%eax
80109b41:	83 ec 04             	sub    $0x4,%esp
80109b44:	6a 04                	push   $0x4
80109b46:	50                   	push   %eax
80109b47:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80109b4a:	83 c0 04             	add    $0x4,%eax
80109b4d:	50                   	push   %eax
80109b4e:	e8 6b ae ff ff       	call   801049be <memmove>
80109b53:	83 c4 10             	add    $0x10,%esp
  tcp_dummy.padding = 0;
80109b56:	c6 45 dc 00          	movb   $0x0,-0x24(%ebp)
  tcp_dummy.protocol = IPV4_TYPE_TCP;
80109b5a:	c6 45 dd 06          	movb   $0x6,-0x23(%ebp)
  tcp_dummy.tcp_len = H2N_ushort(N2H_ushort(ipv4_p->total_len) - sizeof(struct ipv4_pkt));
80109b5e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109b61:	66 8b 40 02          	mov    0x2(%eax),%ax
80109b65:	0f b7 c0             	movzwl %ax,%eax
80109b68:	83 ec 0c             	sub    $0xc,%esp
80109b6b:	50                   	push   %eax
80109b6c:	e8 d9 f6 ff ff       	call   8010924a <N2H_ushort>
80109b71:	83 c4 10             	add    $0x10,%esp
80109b74:	83 e8 14             	sub    $0x14,%eax
80109b77:	0f b7 c0             	movzwl %ax,%eax
80109b7a:	83 ec 0c             	sub    $0xc,%esp
80109b7d:	50                   	push   %eax
80109b7e:	e8 e8 f6 ff ff       	call   8010926b <H2N_ushort>
80109b83:	83 c4 10             	add    $0x10,%esp
80109b86:	66 89 45 de          	mov    %ax,-0x22(%ebp)
  uint chk_sum = 0;
80109b8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  uchar *bin = (uchar *)(&tcp_dummy);
80109b91:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80109b94:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(int i=0;i<6;i++){
80109b97:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80109b9e:	eb 30                	jmp    80109bd0 <tcp_chksum+0xc0>
    chk_sum += (bin[i*2]<<8)+bin[i*2+1];
80109ba0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109ba3:	01 c0                	add    %eax,%eax
80109ba5:	89 c2                	mov    %eax,%edx
80109ba7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109baa:	01 d0                	add    %edx,%eax
80109bac:	8a 00                	mov    (%eax),%al
80109bae:	0f b6 c0             	movzbl %al,%eax
80109bb1:	c1 e0 08             	shl    $0x8,%eax
80109bb4:	89 c2                	mov    %eax,%edx
80109bb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109bb9:	01 c0                	add    %eax,%eax
80109bbb:	8d 48 01             	lea    0x1(%eax),%ecx
80109bbe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109bc1:	01 c8                	add    %ecx,%eax
80109bc3:	8a 00                	mov    (%eax),%al
80109bc5:	0f b6 c0             	movzbl %al,%eax
80109bc8:	01 d0                	add    %edx,%eax
80109bca:	01 45 f4             	add    %eax,-0xc(%ebp)
  for(int i=0;i<6;i++){
80109bcd:	ff 45 f0             	incl   -0x10(%ebp)
80109bd0:	83 7d f0 05          	cmpl   $0x5,-0x10(%ebp)
80109bd4:	7e ca                	jle    80109ba0 <tcp_chksum+0x90>
  }

  bin = (uchar *)(tcp_p);
80109bd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109bd9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(int i=0;i<(N2H_ushort(tcp_dummy.tcp_len)/2);i++){
80109bdc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80109be3:	eb 30                	jmp    80109c15 <tcp_chksum+0x105>
    chk_sum += (bin[i*2]<<8)+bin[i*2+1];
80109be5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109be8:	01 c0                	add    %eax,%eax
80109bea:	89 c2                	mov    %eax,%edx
80109bec:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109bef:	01 d0                	add    %edx,%eax
80109bf1:	8a 00                	mov    (%eax),%al
80109bf3:	0f b6 c0             	movzbl %al,%eax
80109bf6:	c1 e0 08             	shl    $0x8,%eax
80109bf9:	89 c2                	mov    %eax,%edx
80109bfb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109bfe:	01 c0                	add    %eax,%eax
80109c00:	8d 48 01             	lea    0x1(%eax),%ecx
80109c03:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109c06:	01 c8                	add    %ecx,%eax
80109c08:	8a 00                	mov    (%eax),%al
80109c0a:	0f b6 c0             	movzbl %al,%eax
80109c0d:	01 d0                	add    %edx,%eax
80109c0f:	01 45 f4             	add    %eax,-0xc(%ebp)
  for(int i=0;i<(N2H_ushort(tcp_dummy.tcp_len)/2);i++){
80109c12:	ff 45 ec             	incl   -0x14(%ebp)
80109c15:	66 8b 45 de          	mov    -0x22(%ebp),%ax
80109c19:	0f b7 c0             	movzwl %ax,%eax
80109c1c:	83 ec 0c             	sub    $0xc,%esp
80109c1f:	50                   	push   %eax
80109c20:	e8 25 f6 ff ff       	call   8010924a <N2H_ushort>
80109c25:	83 c4 10             	add    $0x10,%esp
80109c28:	66 d1 e8             	shr    %ax
80109c2b:	0f b7 c0             	movzwl %ax,%eax
80109c2e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80109c31:	7c b2                	jl     80109be5 <tcp_chksum+0xd5>
  }
  chk_sum += (chk_sum>>8*2);
80109c33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109c36:	c1 e8 10             	shr    $0x10,%eax
80109c39:	01 45 f4             	add    %eax,-0xc(%ebp)
  return ~(chk_sum);
80109c3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109c3f:	f7 d0                	not    %eax
}
80109c41:	c9                   	leave  
80109c42:	c3                   	ret    

80109c43 <tcp_fin>:

void tcp_fin(){
80109c43:	55                   	push   %ebp
80109c44:	89 e5                	mov    %esp,%ebp
  fin_flag =1;
80109c46:	c7 05 68 5f 19 80 01 	movl   $0x1,0x80195f68
80109c4d:	00 00 00 
}
80109c50:	90                   	nop
80109c51:	5d                   	pop    %ebp
80109c52:	c3                   	ret    

80109c53 <http_proc>:
#include "defs.h"
#include "types.h"
#include "tcp.h"


void http_proc(uint recv, uint recv_size, uint send, uint *send_size){
80109c53:	55                   	push   %ebp
80109c54:	89 e5                	mov    %esp,%ebp
80109c56:	83 ec 18             	sub    $0x18,%esp
  int len;
  len = http_strcpy((char *)send,"HTTP/1.0 200 OK \r\n",0);
80109c59:	8b 45 10             	mov    0x10(%ebp),%eax
80109c5c:	83 ec 04             	sub    $0x4,%esp
80109c5f:	6a 00                	push   $0x0
80109c61:	68 ab bd 10 80       	push   $0x8010bdab
80109c66:	50                   	push   %eax
80109c67:	e8 65 00 00 00       	call   80109cd1 <http_strcpy>
80109c6c:	83 c4 10             	add    $0x10,%esp
80109c6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  len += http_strcpy((char *)send,"Content-Type: text/html \r\n",len);
80109c72:	8b 45 10             	mov    0x10(%ebp),%eax
80109c75:	83 ec 04             	sub    $0x4,%esp
80109c78:	ff 75 f4             	pushl  -0xc(%ebp)
80109c7b:	68 be bd 10 80       	push   $0x8010bdbe
80109c80:	50                   	push   %eax
80109c81:	e8 4b 00 00 00       	call   80109cd1 <http_strcpy>
80109c86:	83 c4 10             	add    $0x10,%esp
80109c89:	01 45 f4             	add    %eax,-0xc(%ebp)
  len += http_strcpy((char *)send,"\r\nHello World!\r\n",len);
80109c8c:	8b 45 10             	mov    0x10(%ebp),%eax
80109c8f:	83 ec 04             	sub    $0x4,%esp
80109c92:	ff 75 f4             	pushl  -0xc(%ebp)
80109c95:	68 d9 bd 10 80       	push   $0x8010bdd9
80109c9a:	50                   	push   %eax
80109c9b:	e8 31 00 00 00       	call   80109cd1 <http_strcpy>
80109ca0:	83 c4 10             	add    $0x10,%esp
80109ca3:	01 45 f4             	add    %eax,-0xc(%ebp)
  if(len%2 != 0){
80109ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109ca9:	83 e0 01             	and    $0x1,%eax
80109cac:	85 c0                	test   %eax,%eax
80109cae:	74 11                	je     80109cc1 <http_proc+0x6e>
    char *payload = (char *)send;
80109cb0:	8b 45 10             	mov    0x10(%ebp),%eax
80109cb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    payload[len] = 0;
80109cb6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109cb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109cbc:	01 d0                	add    %edx,%eax
80109cbe:	c6 00 00             	movb   $0x0,(%eax)
  }
  *send_size = len;
80109cc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109cc4:	8b 45 14             	mov    0x14(%ebp),%eax
80109cc7:	89 10                	mov    %edx,(%eax)
  tcp_fin();
80109cc9:	e8 75 ff ff ff       	call   80109c43 <tcp_fin>
}
80109cce:	90                   	nop
80109ccf:	c9                   	leave  
80109cd0:	c3                   	ret    

80109cd1 <http_strcpy>:

int http_strcpy(char *dst,const char *src,int start_index){
80109cd1:	55                   	push   %ebp
80109cd2:	89 e5                	mov    %esp,%ebp
80109cd4:	83 ec 10             	sub    $0x10,%esp
  int i = 0;
80109cd7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while(src[i]){
80109cde:	eb 1e                	jmp    80109cfe <http_strcpy+0x2d>
    dst[start_index+i] = src[i];
80109ce0:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
80109ce6:	01 d0                	add    %edx,%eax
80109ce8:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109ceb:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109cee:	01 ca                	add    %ecx,%edx
80109cf0:	89 d1                	mov    %edx,%ecx
80109cf2:	8b 55 08             	mov    0x8(%ebp),%edx
80109cf5:	01 ca                	add    %ecx,%edx
80109cf7:	8a 00                	mov    (%eax),%al
80109cf9:	88 02                	mov    %al,(%edx)
    i++;
80109cfb:	ff 45 fc             	incl   -0x4(%ebp)
  while(src[i]){
80109cfe:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109d01:	8b 45 0c             	mov    0xc(%ebp),%eax
80109d04:	01 d0                	add    %edx,%eax
80109d06:	8a 00                	mov    (%eax),%al
80109d08:	84 c0                	test   %al,%al
80109d0a:	75 d4                	jne    80109ce0 <http_strcpy+0xf>
  }
  return i;
80109d0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80109d0f:	c9                   	leave  
80109d10:	c3                   	ret    

80109d11 <ideinit>:
static int disksize;
static uchar *memdisk;

void
ideinit(void)
{
80109d11:	55                   	push   %ebp
80109d12:	89 e5                	mov    %esp,%ebp
  memdisk = _binary_fs_img_start;
80109d14:	c7 05 70 5f 19 80 a2 	movl   $0x8010e5a2,0x80195f70
80109d1b:	e5 10 80 
  disksize = (uint)_binary_fs_img_size/BSIZE;
80109d1e:	b8 00 d0 07 00       	mov    $0x7d000,%eax
80109d23:	c1 e8 09             	shr    $0x9,%eax
80109d26:	a3 6c 5f 19 80       	mov    %eax,0x80195f6c
}
80109d2b:	90                   	nop
80109d2c:	5d                   	pop    %ebp
80109d2d:	c3                   	ret    

80109d2e <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80109d2e:	55                   	push   %ebp
80109d2f:	89 e5                	mov    %esp,%ebp
  // no-op
}
80109d31:	90                   	nop
80109d32:	5d                   	pop    %ebp
80109d33:	c3                   	ret    

80109d34 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80109d34:	55                   	push   %ebp
80109d35:	89 e5                	mov    %esp,%ebp
80109d37:	83 ec 18             	sub    $0x18,%esp
  uchar *p;

  if(!holdingsleep(&b->lock))
80109d3a:	8b 45 08             	mov    0x8(%ebp),%eax
80109d3d:	83 c0 0c             	add    $0xc,%eax
80109d40:	83 ec 0c             	sub    $0xc,%esp
80109d43:	50                   	push   %eax
80109d44:	e8 bb a8 ff ff       	call   80104604 <holdingsleep>
80109d49:	83 c4 10             	add    $0x10,%esp
80109d4c:	85 c0                	test   %eax,%eax
80109d4e:	75 0d                	jne    80109d5d <iderw+0x29>
    panic("iderw: buf not locked");
80109d50:	83 ec 0c             	sub    $0xc,%esp
80109d53:	68 ea bd 10 80       	push   $0x8010bdea
80109d58:	e8 42 68 ff ff       	call   8010059f <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80109d5d:	8b 45 08             	mov    0x8(%ebp),%eax
80109d60:	8b 00                	mov    (%eax),%eax
80109d62:	83 e0 06             	and    $0x6,%eax
80109d65:	83 f8 02             	cmp    $0x2,%eax
80109d68:	75 0d                	jne    80109d77 <iderw+0x43>
    panic("iderw: nothing to do");
80109d6a:	83 ec 0c             	sub    $0xc,%esp
80109d6d:	68 00 be 10 80       	push   $0x8010be00
80109d72:	e8 28 68 ff ff       	call   8010059f <panic>
  if(b->dev != 1)
80109d77:	8b 45 08             	mov    0x8(%ebp),%eax
80109d7a:	8b 40 04             	mov    0x4(%eax),%eax
80109d7d:	83 f8 01             	cmp    $0x1,%eax
80109d80:	74 0d                	je     80109d8f <iderw+0x5b>
    panic("iderw: request not for disk 1");
80109d82:	83 ec 0c             	sub    $0xc,%esp
80109d85:	68 15 be 10 80       	push   $0x8010be15
80109d8a:	e8 10 68 ff ff       	call   8010059f <panic>
  if(b->blockno >= disksize)
80109d8f:	8b 45 08             	mov    0x8(%ebp),%eax
80109d92:	8b 50 08             	mov    0x8(%eax),%edx
80109d95:	a1 6c 5f 19 80       	mov    0x80195f6c,%eax
80109d9a:	39 c2                	cmp    %eax,%edx
80109d9c:	72 0d                	jb     80109dab <iderw+0x77>
    panic("iderw: block out of range");
80109d9e:	83 ec 0c             	sub    $0xc,%esp
80109da1:	68 33 be 10 80       	push   $0x8010be33
80109da6:	e8 f4 67 ff ff       	call   8010059f <panic>

  p = memdisk + b->blockno*BSIZE;
80109dab:	8b 15 70 5f 19 80    	mov    0x80195f70,%edx
80109db1:	8b 45 08             	mov    0x8(%ebp),%eax
80109db4:	8b 40 08             	mov    0x8(%eax),%eax
80109db7:	c1 e0 09             	shl    $0x9,%eax
80109dba:	01 d0                	add    %edx,%eax
80109dbc:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(b->flags & B_DIRTY){
80109dbf:	8b 45 08             	mov    0x8(%ebp),%eax
80109dc2:	8b 00                	mov    (%eax),%eax
80109dc4:	83 e0 04             	and    $0x4,%eax
80109dc7:	85 c0                	test   %eax,%eax
80109dc9:	74 2b                	je     80109df6 <iderw+0xc2>
    b->flags &= ~B_DIRTY;
80109dcb:	8b 45 08             	mov    0x8(%ebp),%eax
80109dce:	8b 00                	mov    (%eax),%eax
80109dd0:	83 e0 fb             	and    $0xfffffffb,%eax
80109dd3:	89 c2                	mov    %eax,%edx
80109dd5:	8b 45 08             	mov    0x8(%ebp),%eax
80109dd8:	89 10                	mov    %edx,(%eax)
    memmove(p, b->data, BSIZE);
80109dda:	8b 45 08             	mov    0x8(%ebp),%eax
80109ddd:	83 c0 5c             	add    $0x5c,%eax
80109de0:	83 ec 04             	sub    $0x4,%esp
80109de3:	68 00 02 00 00       	push   $0x200
80109de8:	50                   	push   %eax
80109de9:	ff 75 f4             	pushl  -0xc(%ebp)
80109dec:	e8 cd ab ff ff       	call   801049be <memmove>
80109df1:	83 c4 10             	add    $0x10,%esp
80109df4:	eb 1a                	jmp    80109e10 <iderw+0xdc>
  } else
    memmove(b->data, p, BSIZE);
80109df6:	8b 45 08             	mov    0x8(%ebp),%eax
80109df9:	83 c0 5c             	add    $0x5c,%eax
80109dfc:	83 ec 04             	sub    $0x4,%esp
80109dff:	68 00 02 00 00       	push   $0x200
80109e04:	ff 75 f4             	pushl  -0xc(%ebp)
80109e07:	50                   	push   %eax
80109e08:	e8 b1 ab ff ff       	call   801049be <memmove>
80109e0d:	83 c4 10             	add    $0x10,%esp
  b->flags |= B_VALID;
80109e10:	8b 45 08             	mov    0x8(%ebp),%eax
80109e13:	8b 00                	mov    (%eax),%eax
80109e15:	83 c8 02             	or     $0x2,%eax
80109e18:	89 c2                	mov    %eax,%edx
80109e1a:	8b 45 08             	mov    0x8(%ebp),%eax
80109e1d:	89 10                	mov    %edx,(%eax)
}
80109e1f:	90                   	nop
80109e20:	c9                   	leave  
80109e21:	c3                   	ret    
