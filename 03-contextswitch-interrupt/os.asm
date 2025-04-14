
os.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
    .global _start

    .text

_start:
    la      sp, _end_stack  // set stack pointer to the end of SRAM
       0:	20010117          	auipc	sp,0x20010
       4:	00010113          	mv	sp,sp

    // load data section from flash to RAM
    la a0, _data_lma
       8:	00001517          	auipc	a0,0x1
       c:	55c50513          	addi	a0,a0,1372 # 1564 <_data_lma>
    la a1, _data_vma
      10:	20000597          	auipc	a1,0x20000
      14:	ff058593          	addi	a1,a1,-16 # 20000000 <_data_vma>
    la a2, _data_end
      18:	20000617          	auipc	a2,0x20000
      1c:	fec60613          	addi	a2,a2,-20 # 20000004 <_data_end>
    bgeu a1,a2, 2f
      20:	00c5fa63          	bgeu	a1,a2,34 <_start+0x34>
1:
    lw t0, (a0)
      24:	00052283          	lw	t0,0(a0)
    sw t0, (a1)
      28:	0055a023          	sw	t0,0(a1)
    addi a0, a0, 4
      2c:	0511                	addi	a0,a0,4
    addi a1, a1, 4
      2e:	0591                	addi	a1,a1,4
    bltu a1, a2, 1b
      30:	fec5eae3          	bltu	a1,a2,24 <_start+0x24>
2:
    // clear bss section
    la a0, _start_bss
      34:	20000517          	auipc	a0,0x20000
      38:	fd050513          	addi	a0,a0,-48 # 20000004 <_data_end>
    la a1, _end_bss
      3c:	20000597          	auipc	a1,0x20000
      40:	7e058593          	addi	a1,a1,2016 # 2000081c <_end_bss>
    bgeu a0, a1, 2f
      44:	00b57763          	bgeu	a0,a1,52 <_start+0x52>
1:
    sw zero, (a0)
      48:	00052023          	sw	zero,0(a0)
    addi a0, a0, 4
      4c:	0511                	addi	a0,a0,4
    bltu a0, a1, 1b
      4e:	feb56de3          	bltu	a0,a1,48 <_start+0x48>
2:
    // jump to start_kernel
    j       start_kernel    
      52:	2be0006f          	j	310 <start_kernel>
	...

00000058 <trap_handler_base>:
.global trap_handler_base
.balign 8

trap_handler_base:
    .balign 4
    j   exception_handler     /*exception entry*/
      58:	a80d                	j	8a <exception_handler>
      5a:	0001                	nop
    .balign 4
    j   irq_default_handler /*1 : Reserved*/
      5c:	aa05                	j	18c <irq_default_handler>
      5e:	0001                	nop
    .balign 4
    j   irq_default_handler /*2 : Reserved*/
      60:	a235                	j	18c <irq_default_handler>
      62:	0001                	nop
    .balign 4
    j   irq_default_handler /*3 : Machine software interrupt*/
      64:	a225                	j	18c <irq_default_handler>
      66:	0001                	nop
    .balign 4
    j   irq_default_handler /*4 : Reserved*/
      68:	a215                	j	18c <irq_default_handler>
      6a:	0001                	nop
    .balign 4
    j   irq_default_handler /*5 : Reserved*/
      6c:	a205                	j	18c <irq_default_handler>
      6e:	0001                	nop
    .balign 4
    j   irq_default_handler /*6 : Reserved*/
      70:	aa31                	j	18c <irq_default_handler>
      72:	0001                	nop
    .balign 4
    j   irq_default_handler /*7 : Machine timer interrupt*/
      74:	aa21                	j	18c <irq_default_handler>
      76:	0001                	nop
    .balign 4
    j   irq_default_handler /*8 : Machine timer interrupt*/
      78:	aa11                	j	18c <irq_default_handler>
      7a:	0001                	nop
    .balign 4
    j   irq_default_handler /*9 : Machine timer interrupt*/
      7c:	aa01                	j	18c <irq_default_handler>
      7e:	0001                	nop
    .balign 4
    j   irq_default_handler /*10 : Machine timer interrupt*/
      80:	a231                	j	18c <irq_default_handler>
      82:	0001                	nop
    .balign 4
    j   irq_default_handler /*11 : Machine timer interrupt*/
      84:	a221                	j	18c <irq_default_handler>
      86:	0001                	nop
    .balign 4
    j   pfic_systick_handler /*12 : Machine timer interrupt*/
      88:	a011                	j	8c <pfic_systick_handler>

0000008a <exception_handler>:

exception_handler:
    j exception_handler
      8a:	a001                	j	8a <exception_handler>

0000008c <pfic_systick_handler>:

pfic_systick_handler:
    csrrw t6, mscratch, t6
      8c:	340f9ff3          	csrrw	t6,mscratch,t6
    reg_save t6
      90:	001fa023          	sw	ra,0(t6)
      94:	002fa223          	sw	sp,4(t6)
      98:	005fa823          	sw	t0,16(t6)
      9c:	006faa23          	sw	t1,20(t6)
      a0:	007fac23          	sw	t2,24(t6)
      a4:	008fae23          	sw	s0,28(t6)
      a8:	029fa023          	sw	s1,32(t6)
      ac:	02afa223          	sw	a0,36(t6)
      b0:	02bfa423          	sw	a1,40(t6)
      b4:	02cfa623          	sw	a2,44(t6)
      b8:	02dfa823          	sw	a3,48(t6)
      bc:	02efaa23          	sw	a4,52(t6)
      c0:	02ffac23          	sw	a5,56(t6)
      c4:	030fae23          	sw	a6,60(t6)
      c8:	051fa023          	sw	a7,64(t6)
      cc:	052fa223          	sw	s2,68(t6)
      d0:	053fa423          	sw	s3,72(t6)
      d4:	054fa623          	sw	s4,76(t6)
      d8:	055fa823          	sw	s5,80(t6)
      dc:	056faa23          	sw	s6,84(t6)
      e0:	057fac23          	sw	s7,88(t6)
      e4:	058fae23          	sw	s8,92(t6)
      e8:	079fa023          	sw	s9,96(t6)
      ec:	07afa223          	sw	s10,100(t6)
      f0:	07bfa423          	sw	s11,104(t6)
      f4:	07cfa623          	sw	t3,108(t6)
      f8:	07dfa823          	sw	t4,112(t6)
      fc:	07efaa23          	sw	t5,116(t6)

    mv t5, t6
     100:	8f7e                	mv	t5,t6
    csrr t6, mscratch
     102:	34002ff3          	csrr	t6,mscratch
    STORE t6, 30 * SIZE_REG(t5)
     106:	07ff2c23          	sw	t6,120(t5)
    csrw mscratch, t5
     10a:	340f1073          	csrw	mscratch,t5

    jal MC_mtip_handler
     10e:	222010ef          	jal	ra,1330 <MC_mtip_handler>

    csrr t6, mscratch
     112:	34002ff3          	csrr	t6,mscratch
    reg_restore t6
     116:	000fa083          	lw	ra,0(t6)
     11a:	004fa103          	lw	sp,4(t6)
     11e:	010fa283          	lw	t0,16(t6)
     122:	014fa303          	lw	t1,20(t6)
     126:	018fa383          	lw	t2,24(t6)
     12a:	01cfa403          	lw	s0,28(t6)
     12e:	020fa483          	lw	s1,32(t6)
     132:	024fa503          	lw	a0,36(t6)
     136:	028fa583          	lw	a1,40(t6)
     13a:	02cfa603          	lw	a2,44(t6)
     13e:	030fa683          	lw	a3,48(t6)
     142:	034fa703          	lw	a4,52(t6)
     146:	038fa783          	lw	a5,56(t6)
     14a:	03cfa803          	lw	a6,60(t6)
     14e:	040fa883          	lw	a7,64(t6)
     152:	044fa903          	lw	s2,68(t6)
     156:	048fa983          	lw	s3,72(t6)
     15a:	04cfaa03          	lw	s4,76(t6)
     15e:	050faa83          	lw	s5,80(t6)
     162:	054fab03          	lw	s6,84(t6)
     166:	058fab83          	lw	s7,88(t6)
     16a:	05cfac03          	lw	s8,92(t6)
     16e:	060fac83          	lw	s9,96(t6)
     172:	064fad03          	lw	s10,100(t6)
     176:	068fad83          	lw	s11,104(t6)
     17a:	06cfae03          	lw	t3,108(t6)
     17e:	070fae83          	lw	t4,112(t6)
     182:	074faf03          	lw	t5,116(t6)
     186:	078faf83          	lw	t6,120(t6)

    j return_from_interrupt
     18a:	a011                	j	18e <return_from_interrupt>

0000018c <irq_default_handler>:

irq_default_handler:
    j irq_default_handler
     18c:	a001                	j	18c <irq_default_handler>

0000018e <return_from_interrupt>:

return_from_interrupt:
    mret
     18e:	30200073          	mret
     192:	0000                	unimp
     194:	0000                	unimp
	...

00000198 <MC_hw_context_switch>:

.global MC_hw_context_switch
.balign 4

MC_hw_context_switch:
    csrrw t6, mscratch, t6
     198:	340f9ff3          	csrrw	t6,mscratch,t6
    beqz t6, 1f
     19c:	080f8063          	beqz	t6,21c <MC_hw_context_switch+0x84>

    reg_save t6
     1a0:	001fa023          	sw	ra,0(t6)
     1a4:	002fa223          	sw	sp,4(t6)
     1a8:	005fa823          	sw	t0,16(t6)
     1ac:	006faa23          	sw	t1,20(t6)
     1b0:	007fac23          	sw	t2,24(t6)
     1b4:	008fae23          	sw	s0,28(t6)
     1b8:	029fa023          	sw	s1,32(t6)
     1bc:	02afa223          	sw	a0,36(t6)
     1c0:	02bfa423          	sw	a1,40(t6)
     1c4:	02cfa623          	sw	a2,44(t6)
     1c8:	02dfa823          	sw	a3,48(t6)
     1cc:	02efaa23          	sw	a4,52(t6)
     1d0:	02ffac23          	sw	a5,56(t6)
     1d4:	030fae23          	sw	a6,60(t6)
     1d8:	051fa023          	sw	a7,64(t6)
     1dc:	052fa223          	sw	s2,68(t6)
     1e0:	053fa423          	sw	s3,72(t6)
     1e4:	054fa623          	sw	s4,76(t6)
     1e8:	055fa823          	sw	s5,80(t6)
     1ec:	056faa23          	sw	s6,84(t6)
     1f0:	057fac23          	sw	s7,88(t6)
     1f4:	058fae23          	sw	s8,92(t6)
     1f8:	079fa023          	sw	s9,96(t6)
     1fc:	07afa223          	sw	s10,100(t6)
     200:	07bfa423          	sw	s11,104(t6)
     204:	07cfa623          	sw	t3,108(t6)
     208:	07dfa823          	sw	t4,112(t6)
     20c:	07efaa23          	sw	t5,116(t6)
    mv t5, t6
     210:	8f7e                	mv	t5,t6
    csrr t6, mscratch
     212:	34002ff3          	csrr	t6,mscratch
     216:	0001                	nop
	.balign 4
    STORE t6, 30*SIZE_REG(t5)
     218:	07ff2c23          	sw	t6,120(t5)
1:
    csrw mscratch, a0
     21c:	34051073          	csrw	mscratch,a0
    mv t6, a0
     220:	8faa                	mv	t6,a0
     222:	0001                	nop
	.balign 4
    reg_restore t6
     224:	000fa083          	lw	ra,0(t6)
     228:	004fa103          	lw	sp,4(t6)
     22c:	010fa283          	lw	t0,16(t6)
     230:	014fa303          	lw	t1,20(t6)
     234:	018fa383          	lw	t2,24(t6)
     238:	01cfa403          	lw	s0,28(t6)
     23c:	020fa483          	lw	s1,32(t6)
     240:	024fa503          	lw	a0,36(t6)
     244:	028fa583          	lw	a1,40(t6)
     248:	02cfa603          	lw	a2,44(t6)
     24c:	030fa683          	lw	a3,48(t6)
     250:	034fa703          	lw	a4,52(t6)
     254:	038fa783          	lw	a5,56(t6)
     258:	03cfa803          	lw	a6,60(t6)
     25c:	040fa883          	lw	a7,64(t6)
     260:	044fa903          	lw	s2,68(t6)
     264:	048fa983          	lw	s3,72(t6)
     268:	04cfaa03          	lw	s4,76(t6)
     26c:	050faa83          	lw	s5,80(t6)
     270:	054fab03          	lw	s6,84(t6)
     274:	058fab83          	lw	s7,88(t6)
     278:	05cfac03          	lw	s8,92(t6)
     27c:	060fac83          	lw	s9,96(t6)
     280:	064fad03          	lw	s10,100(t6)
     284:	068fad83          	lw	s11,104(t6)
     288:	06cfae03          	lw	t3,108(t6)
     28c:	070fae83          	lw	t4,112(t6)
     290:	074faf03          	lw	t5,116(t6)
     294:	078faf83          	lw	t6,120(t6)
    ret
     298:	8082                	ret

0000029a <thread1_entry>:
#include "os.h"
MC_thread_t thread1;
MC_thread_t thread2;

void thread1_entry()
{
     29a:	1101                	addi	sp,sp,-32
     29c:	ce06                	sw	ra,28(sp)
     29e:	cc22                	sw	s0,24(sp)
     2a0:	1000                	addi	s0,sp,32
    
    while(1)
    {
        printf("test_thread1_start!\r\n");
     2a2:	6785                	lui	a5,0x1
     2a4:	4a478513          	addi	a0,a5,1188 # 14a4 <STACK_END+0x4>
     2a8:	249000ef          	jal	ra,cf0 <printf>
        int i = 1000;
     2ac:	3e800793          	li	a5,1000
     2b0:	fef42623          	sw	a5,-20(s0)
        while(i--);
     2b4:	0001                	nop
     2b6:	fec42783          	lw	a5,-20(s0)
     2ba:	fff78713          	addi	a4,a5,-1
     2be:	fee42623          	sw	a4,-20(s0)
     2c2:	fbf5                	bnez	a5,2b6 <thread1_entry+0x1c>
        MC_thread_yield();
     2c4:	6c7000ef          	jal	ra,118a <MC_thread_yield>
    {
     2c8:	bfe9                	j	2a2 <thread1_entry+0x8>

000002ca <thread2_entry>:
    }
}

void thread2_entry()
{
     2ca:	1101                	addi	sp,sp,-32
     2cc:	ce06                	sw	ra,28(sp)
     2ce:	cc22                	sw	s0,24(sp)
     2d0:	1000                	addi	s0,sp,32
    uint32_t tick = 0, tmp;
     2d2:	fe042623          	sw	zero,-20(s0)
    while(1)
    {
        tmp = MC_get_tick() / 1000;
     2d6:	148010ef          	jal	ra,141e <MC_get_tick>
     2da:	872a                	mv	a4,a0
     2dc:	3e800793          	li	a5,1000
     2e0:	02f757b3          	divu	a5,a4,a5
     2e4:	fef42423          	sw	a5,-24(s0)
        if(tmp != tick)
     2e8:	fe842703          	lw	a4,-24(s0)
     2ec:	fec42783          	lw	a5,-20(s0)
     2f0:	00f70d63          	beq	a4,a5,30a <thread2_entry+0x40>
        {
            tick = tmp;
     2f4:	fe842783          	lw	a5,-24(s0)
     2f8:	fef42623          	sw	a5,-20(s0)
            printf("tick:%d\r\n", tick);
     2fc:	fec42583          	lw	a1,-20(s0)
     300:	6785                	lui	a5,0x1
     302:	4bc78513          	addi	a0,a5,1212 # 14bc <STACK_END+0x1c>
     306:	1eb000ef          	jal	ra,cf0 <printf>
        }
        MC_thread_yield();
     30a:	681000ef          	jal	ra,118a <MC_thread_yield>
        tmp = MC_get_tick() / 1000;
     30e:	b7e1                	j	2d6 <thread2_entry+0xc>

00000310 <start_kernel>:
    }
}

void start_kernel()
{
     310:	1141                	addi	sp,sp,-16
     312:	c606                	sw	ra,12(sp)
     314:	c422                	sw	s0,8(sp)
     316:	0800                	addi	s0,sp,16
    USART1_init();
     318:	28b5                	jal	394 <USART1_init>

    MC_trap_init();
     31a:	7d3000ef          	jal	ra,12ec <MC_trap_init>

    MC_timer_init();
     31e:	0ca010ef          	jal	ra,13e8 <MC_timer_init>

    thread1 = MC_thread_create("thread1",
     322:	06400713          	li	a4,100
     326:	03f00693          	li	a3,63
     32a:	10000613          	li	a2,256
     32e:	000007b7          	lui	a5,0x0
     332:	29a78593          	addi	a1,a5,666 # 29a <thread1_entry>
     336:	6785                	lui	a5,0x1
     338:	4c878513          	addi	a0,a5,1224 # 14c8 <STACK_END+0x28>
     33c:	4e5000ef          	jal	ra,1020 <MC_thread_create>
     340:	872a                	mv	a4,a0
     342:	200007b7          	lui	a5,0x20000
     346:	40e7a223          	sw	a4,1028(a5) # 20000404 <thread1>
                                    thread1_entry,
                                    256,
                                    63,
                                    100);
    MC_thread_startup(thread1);
     34a:	200007b7          	lui	a5,0x20000
     34e:	4047a783          	lw	a5,1028(a5) # 20000404 <thread1>
     352:	853e                	mv	a0,a5
     354:	5a7000ef          	jal	ra,10fa <MC_thread_startup>

    thread2 = MC_thread_create("thread2",
     358:	06400713          	li	a4,100
     35c:	03f00693          	li	a3,63
     360:	10000613          	li	a2,256
     364:	000007b7          	lui	a5,0x0
     368:	2ca78593          	addi	a1,a5,714 # 2ca <thread2_entry>
     36c:	6785                	lui	a5,0x1
     36e:	4d078513          	addi	a0,a5,1232 # 14d0 <STACK_END+0x30>
     372:	4af000ef          	jal	ra,1020 <MC_thread_create>
     376:	872a                	mv	a4,a0
     378:	200007b7          	lui	a5,0x20000
     37c:	3ee7ac23          	sw	a4,1016(a5) # 200003f8 <thread2>
                                    thread2_entry,
                                    256,
                                    63,
                                    100);
    MC_thread_startup(thread2);
     380:	200007b7          	lui	a5,0x20000
     384:	3f87a783          	lw	a5,1016(a5) # 200003f8 <thread2>
     388:	853e                	mv	a0,a5
     38a:	571000ef          	jal	ra,10fa <MC_thread_startup>

    MC_scheduler_start();
     38e:	347000ef          	jal	ra,ed4 <MC_scheduler_start>
    while(1)
     392:	a001                	j	392 <start_kernel+0x82>

00000394 <USART1_init>:
    CFGHR = 1,
    INDR = 2,
    OUTDR = 3,
}_GPIOA_REG;
void USART1_init()
{
     394:	1101                	addi	sp,sp,-32
     396:	ce22                	sw	s0,28(sp)
     398:	1000                	addi	s0,sp,32
    while((RCC_REG_R(CTLR) & (1<<1)) == 0)continue;
     39a:	a011                	j	39e <USART1_init+0xa>
     39c:	0001                	nop
     39e:	400217b7          	lui	a5,0x40021
     3a2:	439c                	lw	a5,0(a5)
     3a4:	8b89                	andi	a5,a5,2
     3a6:	dbfd                	beqz	a5,39c <USART1_init+0x8>
    uint32_t  x = (RCC_REG_R(APB2PCENR)) | (1<<14) | (1<<2);
     3a8:	400217b7          	lui	a5,0x40021
     3ac:	07e1                	addi	a5,a5,24
     3ae:	4398                	lw	a4,0(a5)
     3b0:	6791                	lui	a5,0x4
     3b2:	0791                	addi	a5,a5,4
     3b4:	8fd9                	or	a5,a5,a4
     3b6:	fef42623          	sw	a5,-20(s0)
    RCC_REG_W(APB2PCENR,x);
     3ba:	400217b7          	lui	a5,0x40021
     3be:	07e1                	addi	a5,a5,24
     3c0:	fec42703          	lw	a4,-20(s0)
     3c4:	c398                	sw	a4,0(a5)

    x = ((GPIOA_REG_R(CFGHR) & ~(0b1111<<4)) | (uint32_t)(0b1011<<4));
     3c6:	400117b7          	lui	a5,0x40011
     3ca:	80478793          	addi	a5,a5,-2044 # 40010804 <_end_stack+0x20000804>
     3ce:	439c                	lw	a5,0(a5)
     3d0:	f0f7f793          	andi	a5,a5,-241
     3d4:	0b07e793          	ori	a5,a5,176
     3d8:	fef42623          	sw	a5,-20(s0)
    GPIOA_REG_W(CFGHR,x);
     3dc:	400117b7          	lui	a5,0x40011
     3e0:	80478793          	addi	a5,a5,-2044 # 40010804 <_end_stack+0x20000804>
     3e4:	fec42703          	lw	a4,-20(s0)
     3e8:	c398                	sw	a4,0(a5)

    x = (USART1_REG_R(BRR) | (uint16_t)0b1000101);
     3ea:	400147b7          	lui	a5,0x40014
     3ee:	80878793          	addi	a5,a5,-2040 # 40013808 <_end_stack+0x20003808>
     3f2:	439c                	lw	a5,0(a5)
     3f4:	0457e793          	ori	a5,a5,69
     3f8:	fef42623          	sw	a5,-20(s0)
    USART1_REG_W(BRR,(uint16_t)x);
     3fc:	fec42783          	lw	a5,-20(s0)
     400:	01079713          	slli	a4,a5,0x10
     404:	8341                	srli	a4,a4,0x10
     406:	400147b7          	lui	a5,0x40014
     40a:	80878793          	addi	a5,a5,-2040 # 40013808 <_end_stack+0x20003808>
     40e:	c398                	sw	a4,0(a5)

    x = (USART1_REG_R(CTLR1) | 0X0000200C);
     410:	400147b7          	lui	a5,0x40014
     414:	80c78793          	addi	a5,a5,-2036 # 4001380c <_end_stack+0x2000380c>
     418:	4398                	lw	a4,0(a5)
     41a:	6789                	lui	a5,0x2
     41c:	07b1                	addi	a5,a5,12
     41e:	8fd9                	or	a5,a5,a4
     420:	fef42623          	sw	a5,-20(s0)
    USART1_REG_W(CTLR1,(uint32_t)x);
     424:	400147b7          	lui	a5,0x40014
     428:	80c78793          	addi	a5,a5,-2036 # 4001380c <_end_stack+0x2000380c>
     42c:	fec42703          	lw	a4,-20(s0)
     430:	c398                	sw	a4,0(a5)
}
     432:	0001                	nop
     434:	4472                	lw	s0,28(sp)
     436:	6105                	addi	sp,sp,32
     438:	8082                	ret

0000043a <putc>:

void putc(uint8_t c)
{
     43a:	1101                	addi	sp,sp,-32
     43c:	ce22                	sw	s0,28(sp)
     43e:	1000                	addi	s0,sp,32
     440:	87aa                	mv	a5,a0
     442:	fef407a3          	sb	a5,-17(s0)
    USART1_REG_W(DATAR,c);
     446:	400147b7          	lui	a5,0x40014
     44a:	80478793          	addi	a5,a5,-2044 # 40013804 <_end_stack+0x20003804>
     44e:	fef44703          	lbu	a4,-17(s0)
     452:	c398                	sw	a4,0(a5)
}
     454:	0001                	nop
     456:	4472                	lw	s0,28(sp)
     458:	6105                	addi	sp,sp,32
     45a:	8082                	ret

0000045c <puts>:
void puts(uint8_t *s)
{
     45c:	1101                	addi	sp,sp,-32
     45e:	ce06                	sw	ra,28(sp)
     460:	cc22                	sw	s0,24(sp)
     462:	1000                	addi	s0,sp,32
     464:	fea42623          	sw	a0,-20(s0)
    while(*s)
     468:	a80d                	j	49a <puts+0x3e>
    {
        __DISENABLE_INTERRUPT__();
     46a:	649000ef          	jal	ra,12b2 <__DISENABLE_INTERRUPT__>
        putc(*s++);
     46e:	fec42783          	lw	a5,-20(s0)
     472:	00178713          	addi	a4,a5,1
     476:	fee42623          	sw	a4,-20(s0)
     47a:	0007c783          	lbu	a5,0(a5)
     47e:	853e                	mv	a0,a5
     480:	3f6d                	jal	43a <putc>
        while((USART1_REG_R(STATR) & (1<<7)) == 0)continue;
     482:	a011                	j	486 <puts+0x2a>
     484:	0001                	nop
     486:	400147b7          	lui	a5,0x40014
     48a:	80078793          	addi	a5,a5,-2048 # 40013800 <_end_stack+0x20003800>
     48e:	439c                	lw	a5,0(a5)
     490:	0807f793          	andi	a5,a5,128
     494:	dbe5                	beqz	a5,484 <puts+0x28>
        __ENABLE_INTERRUPT__();
     496:	639000ef          	jal	ra,12ce <__ENABLE_INTERRUPT__>
    while(*s)
     49a:	fec42783          	lw	a5,-20(s0)
     49e:	0007c783          	lbu	a5,0(a5)
     4a2:	f7e1                	bnez	a5,46a <puts+0xe>
    }
}
     4a4:	0001                	nop
     4a6:	40f2                	lw	ra,28(sp)
     4a8:	4462                	lw	s0,24(sp)
     4aa:	6105                	addi	sp,sp,32
     4ac:	8082                	ret

000004ae <MC_InsertFreeBlock>:
#define HEAP_MINMUM_SIZE ((size_t) (Block_Size << 1))

void MC_PageInit(void);

static void MC_InsertFreeBlock(BlockLink_t *New_Block)
{
     4ae:	7179                	addi	sp,sp,-48
     4b0:	d622                	sw	s0,44(sp)
     4b2:	1800                	addi	s0,sp,48
     4b4:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *BlockIterator;
    uint8_t *BlockOperator;
    for(BlockIterator = &Block_Start; BlockIterator->MC_NextFreeBlock < New_Block; BlockIterator = BlockIterator->MC_NextFreeBlock)
     4b8:	200007b7          	lui	a5,0x20000
     4bc:	40878793          	addi	a5,a5,1032 # 20000408 <Block_Start>
     4c0:	fef42623          	sw	a5,-20(s0)
     4c4:	a031                	j	4d0 <MC_InsertFreeBlock+0x22>
     4c6:	fec42783          	lw	a5,-20(s0)
     4ca:	439c                	lw	a5,0(a5)
     4cc:	fef42623          	sw	a5,-20(s0)
     4d0:	fec42783          	lw	a5,-20(s0)
     4d4:	439c                	lw	a5,0(a5)
     4d6:	fdc42703          	lw	a4,-36(s0)
     4da:	fee7e6e3          	bltu	a5,a4,4c6 <MC_InsertFreeBlock+0x18>
    {}
    
    BlockOperator = BlockIterator;
     4de:	fec42783          	lw	a5,-20(s0)
     4e2:	fef42423          	sw	a5,-24(s0)

    if(BlockOperator + BlockIterator->MC_BlockSize == (uint8_t *)New_Block)
     4e6:	fec42783          	lw	a5,-20(s0)
     4ea:	43dc                	lw	a5,4(a5)
     4ec:	fe842703          	lw	a4,-24(s0)
     4f0:	97ba                	add	a5,a5,a4
     4f2:	fdc42703          	lw	a4,-36(s0)
     4f6:	02f71063          	bne	a4,a5,516 <MC_InsertFreeBlock+0x68>
    {
        BlockIterator->MC_BlockSize += New_Block->MC_BlockSize;
     4fa:	fec42783          	lw	a5,-20(s0)
     4fe:	43d8                	lw	a4,4(a5)
     500:	fdc42783          	lw	a5,-36(s0)
     504:	43dc                	lw	a5,4(a5)
     506:	973e                	add	a4,a4,a5
     508:	fec42783          	lw	a5,-20(s0)
     50c:	c3d8                	sw	a4,4(a5)
        New_Block = BlockIterator;
     50e:	fec42783          	lw	a5,-20(s0)
     512:	fcf42e23          	sw	a5,-36(s0)
    }else{}

    BlockOperator = (uint8_t *)New_Block;
     516:	fdc42783          	lw	a5,-36(s0)
     51a:	fef42423          	sw	a5,-24(s0)
    if(BlockOperator + New_Block->MC_BlockSize == (uint8_t *)BlockIterator->MC_NextFreeBlock)
     51e:	fdc42783          	lw	a5,-36(s0)
     522:	43dc                	lw	a5,4(a5)
     524:	fe842703          	lw	a4,-24(s0)
     528:	973e                	add	a4,a4,a5
     52a:	fec42783          	lw	a5,-20(s0)
     52e:	439c                	lw	a5,0(a5)
     530:	04f71663          	bne	a4,a5,57c <MC_InsertFreeBlock+0xce>
    {
        if(BlockIterator->MC_NextFreeBlock != Block_End)
     534:	fec42783          	lw	a5,-20(s0)
     538:	4398                	lw	a4,0(a5)
     53a:	200007b7          	lui	a5,0x20000
     53e:	4107a783          	lw	a5,1040(a5) # 20000410 <Block_End>
     542:	02f70563          	beq	a4,a5,56c <MC_InsertFreeBlock+0xbe>
        {
            New_Block->MC_BlockSize += BlockIterator->MC_NextFreeBlock->MC_BlockSize;
     546:	fdc42783          	lw	a5,-36(s0)
     54a:	43d8                	lw	a4,4(a5)
     54c:	fec42783          	lw	a5,-20(s0)
     550:	439c                	lw	a5,0(a5)
     552:	43dc                	lw	a5,4(a5)
     554:	973e                	add	a4,a4,a5
     556:	fdc42783          	lw	a5,-36(s0)
     55a:	c3d8                	sw	a4,4(a5)
            New_Block->MC_NextFreeBlock = BlockIterator->MC_NextFreeBlock->MC_NextFreeBlock;
     55c:	fec42783          	lw	a5,-20(s0)
     560:	439c                	lw	a5,0(a5)
     562:	4398                	lw	a4,0(a5)
     564:	fdc42783          	lw	a5,-36(s0)
     568:	c398                	sw	a4,0(a5)
     56a:	a839                	j	588 <MC_InsertFreeBlock+0xda>
        }
        else
        {
            New_Block->MC_NextFreeBlock = Block_End;
     56c:	200007b7          	lui	a5,0x20000
     570:	4107a703          	lw	a4,1040(a5) # 20000410 <Block_End>
     574:	fdc42783          	lw	a5,-36(s0)
     578:	c398                	sw	a4,0(a5)
     57a:	a039                	j	588 <MC_InsertFreeBlock+0xda>
        }
    }
    else
    {
        New_Block->MC_NextFreeBlock = BlockIterator->MC_NextFreeBlock;
     57c:	fec42783          	lw	a5,-20(s0)
     580:	4398                	lw	a4,0(a5)
     582:	fdc42783          	lw	a5,-36(s0)
     586:	c398                	sw	a4,0(a5)
    }

    if(BlockIterator != New_Block)
     588:	fec42703          	lw	a4,-20(s0)
     58c:	fdc42783          	lw	a5,-36(s0)
     590:	00f70763          	beq	a4,a5,59e <MC_InsertFreeBlock+0xf0>
    {
        BlockIterator->MC_NextFreeBlock = New_Block;
     594:	fec42783          	lw	a5,-20(s0)
     598:	fdc42703          	lw	a4,-36(s0)
     59c:	c398                	sw	a4,0(a5)
    }else{}

}
     59e:	0001                	nop
     5a0:	5432                	lw	s0,44(sp)
     5a2:	6145                	addi	sp,sp,48
     5a4:	8082                	ret

000005a6 <MC_PageMalloc>:

void *MC_PageMalloc(size_t MallocSize)
{
     5a6:	7179                	addi	sp,sp,-48
     5a8:	d606                	sw	ra,44(sp)
     5aa:	d422                	sw	s0,40(sp)
     5ac:	1800                	addi	s0,sp,48
     5ae:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *Prev_Block = NULL, *Block = NULL, *New_Block = NULL;
     5b2:	fe042623          	sw	zero,-20(s0)
     5b6:	fe042423          	sw	zero,-24(s0)
     5ba:	fe042023          	sw	zero,-32(s0)
    void *ReturnAddr = NULL;
     5be:	fe042223          	sw	zero,-28(s0)
    /* 应当挂起所有任务 */
    /*----------------*/
    if(Block_End == NULL)
     5c2:	200007b7          	lui	a5,0x20000
     5c6:	4107a783          	lw	a5,1040(a5) # 20000410 <Block_End>
     5ca:	e391                	bnez	a5,5ce <MC_PageMalloc+0x28>
    {
        MC_PageInit();
     5cc:	22b9                	jal	71a <MC_PageInit>
    }
    else{}

    if((MallocSize & BlockAllocatiedBit) == 0)
     5ce:	200007b7          	lui	a5,0x20000
     5d2:	0047a703          	lw	a4,4(a5) # 20000004 <_data_end>
     5d6:	fdc42783          	lw	a5,-36(s0)
     5da:	8ff9                	and	a5,a5,a4
     5dc:	12079863          	bnez	a5,70c <MC_PageMalloc+0x166>
    {
        if(MallocSize > 0)
     5e0:	fdc42783          	lw	a5,-36(s0)
     5e4:	12078463          	beqz	a5,70c <MC_PageMalloc+0x166>
        {
            MallocSize += Block_Size;
     5e8:	200007b7          	lui	a5,0x20000
     5ec:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     5f0:	fdc42703          	lw	a4,-36(s0)
     5f4:	97ba                	add	a5,a5,a4
     5f6:	fcf42e23          	sw	a5,-36(s0)
            if(MallocSize & HEAP_ADDRESS_MASK)
     5fa:	fdc42783          	lw	a5,-36(s0)
     5fe:	8b9d                	andi	a5,a5,7
     600:	c799                	beqz	a5,60e <MC_PageMalloc+0x68>
            {
                MallocSize = (MallocSize + HEAP_ADDRESS_MASK) & (~HEAP_ADDRESS_MASK);
     602:	fdc42783          	lw	a5,-36(s0)
     606:	079d                	addi	a5,a5,7
     608:	9be1                	andi	a5,a5,-8
     60a:	fcf42e23          	sw	a5,-36(s0)
            }
            
            if(MallocSize <= HeapSizeRemaing)
     60e:	200007b7          	lui	a5,0x20000
     612:	0087a783          	lw	a5,8(a5) # 20000008 <HeapSizeRemaing>
     616:	fdc42703          	lw	a4,-36(s0)
     61a:	0ee7e963          	bltu	a5,a4,70c <MC_PageMalloc+0x166>
            {
                Prev_Block = &Block_Start;
     61e:	200007b7          	lui	a5,0x20000
     622:	40878793          	addi	a5,a5,1032 # 20000408 <Block_Start>
     626:	fef42623          	sw	a5,-20(s0)
                Block = Prev_Block->MC_NextFreeBlock;
     62a:	fec42783          	lw	a5,-20(s0)
     62e:	439c                	lw	a5,0(a5)
     630:	fef42423          	sw	a5,-24(s0)
                while(Block->MC_BlockSize < MallocSize && Block->MC_NextFreeBlock != NULL)
     634:	a811                	j	648 <MC_PageMalloc+0xa2>
                {
                    Prev_Block = Block;
     636:	fe842783          	lw	a5,-24(s0)
     63a:	fef42623          	sw	a5,-20(s0)
                    Block = Block->MC_NextFreeBlock;
     63e:	fe842783          	lw	a5,-24(s0)
     642:	439c                	lw	a5,0(a5)
     644:	fef42423          	sw	a5,-24(s0)
                while(Block->MC_BlockSize < MallocSize && Block->MC_NextFreeBlock != NULL)
     648:	fe842783          	lw	a5,-24(s0)
     64c:	43dc                	lw	a5,4(a5)
     64e:	fdc42703          	lw	a4,-36(s0)
     652:	00e7f663          	bgeu	a5,a4,65e <MC_PageMalloc+0xb8>
     656:	fe842783          	lw	a5,-24(s0)
     65a:	439c                	lw	a5,0(a5)
     65c:	ffe9                	bnez	a5,636 <MC_PageMalloc+0x90>
                }

                if(Block != Block_End)
     65e:	200007b7          	lui	a5,0x20000
     662:	4107a783          	lw	a5,1040(a5) # 20000410 <Block_End>
     666:	fe842703          	lw	a4,-24(s0)
     66a:	0af70163          	beq	a4,a5,70c <MC_PageMalloc+0x166>
                {
                    ReturnAddr = (void *)((uint8_t *)Block + Block_Size);
     66e:	200007b7          	lui	a5,0x20000
     672:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     676:	fe842703          	lw	a4,-24(s0)
     67a:	97ba                	add	a5,a5,a4
     67c:	fef42223          	sw	a5,-28(s0)

                    Prev_Block->MC_NextFreeBlock = Block->MC_NextFreeBlock;
     680:	fe842783          	lw	a5,-24(s0)
     684:	4398                	lw	a4,0(a5)
     686:	fec42783          	lw	a5,-20(s0)
     68a:	c398                	sw	a4,0(a5)

                    if(Block->MC_BlockSize - MallocSize > HEAP_MINMUM_SIZE)
     68c:	fe842783          	lw	a5,-24(s0)
     690:	43d8                	lw	a4,4(a5)
     692:	fdc42783          	lw	a5,-36(s0)
     696:	8f1d                	sub	a4,a4,a5
     698:	200007b7          	lui	a5,0x20000
     69c:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     6a0:	0786                	slli	a5,a5,0x1
     6a2:	02e7fa63          	bgeu	a5,a4,6d6 <MC_PageMalloc+0x130>
                    {
                        New_Block = (BlockLink_t *)((uint8_t *)Block + MallocSize);
     6a6:	fe842703          	lw	a4,-24(s0)
     6aa:	fdc42783          	lw	a5,-36(s0)
     6ae:	97ba                	add	a5,a5,a4
     6b0:	fef42023          	sw	a5,-32(s0)

                        New_Block->MC_BlockSize = Block->MC_BlockSize - MallocSize;
     6b4:	fe842783          	lw	a5,-24(s0)
     6b8:	43d8                	lw	a4,4(a5)
     6ba:	fdc42783          	lw	a5,-36(s0)
     6be:	8f1d                	sub	a4,a4,a5
     6c0:	fe042783          	lw	a5,-32(s0)
     6c4:	c3d8                	sw	a4,4(a5)
                        Block->MC_BlockSize = MallocSize;
     6c6:	fe842783          	lw	a5,-24(s0)
     6ca:	fdc42703          	lw	a4,-36(s0)
     6ce:	c3d8                	sw	a4,4(a5)
                        MC_InsertFreeBlock(New_Block);
     6d0:	fe042503          	lw	a0,-32(s0)
     6d4:	3be9                	jal	4ae <MC_InsertFreeBlock>
                    }else{}
                    HeapSizeRemaing -= Block->MC_BlockSize;
     6d6:	200007b7          	lui	a5,0x20000
     6da:	0087a703          	lw	a4,8(a5) # 20000008 <HeapSizeRemaing>
     6de:	fe842783          	lw	a5,-24(s0)
     6e2:	43dc                	lw	a5,4(a5)
     6e4:	8f1d                	sub	a4,a4,a5
     6e6:	200007b7          	lui	a5,0x20000
     6ea:	00e7a423          	sw	a4,8(a5) # 20000008 <HeapSizeRemaing>

                    Block->MC_BlockSize |= BlockAllocatiedBit;
     6ee:	fe842783          	lw	a5,-24(s0)
     6f2:	43d8                	lw	a4,4(a5)
     6f4:	200007b7          	lui	a5,0x20000
     6f8:	0047a783          	lw	a5,4(a5) # 20000004 <_data_end>
     6fc:	8f5d                	or	a4,a4,a5
     6fe:	fe842783          	lw	a5,-24(s0)
     702:	c3d8                	sw	a4,4(a5)
                    Block->MC_NextFreeBlock = NULL;
     704:	fe842783          	lw	a5,-24(s0)
     708:	0007a023          	sw	zero,0(a5)

    /* 应当恢复任务调度 */
    /*----------------*/


    return ReturnAddr;
     70c:	fe442783          	lw	a5,-28(s0)
}
     710:	853e                	mv	a0,a5
     712:	50b2                	lw	ra,44(sp)
     714:	5422                	lw	s0,40(sp)
     716:	6145                	addi	sp,sp,48
     718:	8082                	ret

0000071a <MC_PageInit>:

void MC_PageInit(void)
{
     71a:	1101                	addi	sp,sp,-32
     71c:	ce22                	sw	s0,28(sp)
     71e:	1000                	addi	s0,sp,32
    BlockLink_t *FirstFreeBlock;

    size_t TotalHeapSize = HEAP_SIZE;
     720:	6785                	lui	a5,0x1
     722:	4987a783          	lw	a5,1176(a5) # 1498 <HEAP_SIZE>
     726:	fef42623          	sw	a5,-20(s0)
    size_t HeapStart_Address = HEAP_START, HeapEnd_Address;
     72a:	6785                	lui	a5,0x1
     72c:	4947a783          	lw	a5,1172(a5) # 1494 <HEAP_START>
     730:	fef42423          	sw	a5,-24(s0)

    if(HeapStart_Address & (HEAP_ADDRESS_MASK))
     734:	fe842783          	lw	a5,-24(s0)
     738:	8b9d                	andi	a5,a5,7
     73a:	c39d                	beqz	a5,760 <MC_PageInit+0x46>
    {
        HeapStart_Address = (HeapStart_Address + HEAP_ADDRESS_MASK) & (~(HEAP_ADDRESS_MASK));
     73c:	fe842783          	lw	a5,-24(s0)
     740:	079d                	addi	a5,a5,7
     742:	9be1                	andi	a5,a5,-8
     744:	fef42423          	sw	a5,-24(s0)
        TotalHeapSize -= HeapStart_Address - HEAP_START;
     748:	6785                	lui	a5,0x1
     74a:	4947a703          	lw	a4,1172(a5) # 1494 <HEAP_START>
     74e:	fe842783          	lw	a5,-24(s0)
     752:	40f707b3          	sub	a5,a4,a5
     756:	fec42703          	lw	a4,-20(s0)
     75a:	97ba                	add	a5,a5,a4
     75c:	fef42623          	sw	a5,-20(s0)
    }

    HeapEnd_Address = HeapStart_Address + TotalHeapSize;
     760:	fe842703          	lw	a4,-24(s0)
     764:	fec42783          	lw	a5,-20(s0)
     768:	97ba                	add	a5,a5,a4
     76a:	fef42223          	sw	a5,-28(s0)
    HeapEnd_Address -= Block_Size;
     76e:	200007b7          	lui	a5,0x20000
     772:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     776:	fe442703          	lw	a4,-28(s0)
     77a:	40f707b3          	sub	a5,a4,a5
     77e:	fef42223          	sw	a5,-28(s0)
    
    Block_End = (BlockLink_t *)HeapEnd_Address;
     782:	fe442703          	lw	a4,-28(s0)
     786:	200007b7          	lui	a5,0x20000
     78a:	40e7a823          	sw	a4,1040(a5) # 20000410 <Block_End>
    Block_End -> MC_BlockSize = 0;
     78e:	200007b7          	lui	a5,0x20000
     792:	4107a783          	lw	a5,1040(a5) # 20000410 <Block_End>
     796:	0007a223          	sw	zero,4(a5)
    Block_End -> MC_NextFreeBlock = NULL;
     79a:	200007b7          	lui	a5,0x20000
     79e:	4107a783          	lw	a5,1040(a5) # 20000410 <Block_End>
     7a2:	0007a023          	sw	zero,0(a5)
    
    Block_Start.MC_BlockSize = 0;
     7a6:	200007b7          	lui	a5,0x20000
     7aa:	40878793          	addi	a5,a5,1032 # 20000408 <Block_Start>
     7ae:	0007a223          	sw	zero,4(a5)
    Block_Start.MC_NextFreeBlock = (BlockLink_t *)HeapStart_Address;
     7b2:	fe842703          	lw	a4,-24(s0)
     7b6:	200007b7          	lui	a5,0x20000
     7ba:	40e7a423          	sw	a4,1032(a5) # 20000408 <Block_Start>

    FirstFreeBlock = (BlockLink_t *)HeapStart_Address;
     7be:	fe842783          	lw	a5,-24(s0)
     7c2:	fef42023          	sw	a5,-32(s0)
    FirstFreeBlock -> MC_BlockSize = HeapEnd_Address - HeapStart_Address;
     7c6:	fe442703          	lw	a4,-28(s0)
     7ca:	fe842783          	lw	a5,-24(s0)
     7ce:	8f1d                	sub	a4,a4,a5
     7d0:	fe042783          	lw	a5,-32(s0)
     7d4:	c3d8                	sw	a4,4(a5)
    FirstFreeBlock -> MC_NextFreeBlock = Block_End;
     7d6:	200007b7          	lui	a5,0x20000
     7da:	4107a703          	lw	a4,1040(a5) # 20000410 <Block_End>
     7de:	fe042783          	lw	a5,-32(s0)
     7e2:	c398                	sw	a4,0(a5)

    HeapSizeRemaing = FirstFreeBlock -> MC_BlockSize;
     7e4:	fe042783          	lw	a5,-32(s0)
     7e8:	43d8                	lw	a4,4(a5)
     7ea:	200007b7          	lui	a5,0x20000
     7ee:	00e7a423          	sw	a4,8(a5) # 20000008 <HeapSizeRemaing>
    BlockAllocatiedBit = (((size_t) 1) << (sizeof(size_t) * heapBITS_PER_BYTE - 1));
     7f2:	200007b7          	lui	a5,0x20000
     7f6:	80000737          	lui	a4,0x80000
     7fa:	00e7a223          	sw	a4,4(a5) # 20000004 <_data_end>
}
     7fe:	0001                	nop
     800:	4472                	lw	s0,28(sp)
     802:	6105                	addi	sp,sp,32
     804:	8082                	ret

00000806 <MC_PageFree>:

void MC_PageFree(void *FreeAddr)
{
     806:	7179                	addi	sp,sp,-48
     808:	d606                	sw	ra,44(sp)
     80a:	d422                	sw	s0,40(sp)
     80c:	1800                	addi	s0,sp,48
     80e:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *BlockIterator;
    uint8_t *BlockOperator;
    if(FreeAddr != NULL)
     812:	fdc42783          	lw	a5,-36(s0)
     816:	cbad                	beqz	a5,888 <MC_PageFree+0x82>
    {
        BlockOperator = (uint8_t *)FreeAddr - Block_Size;
     818:	200007b7          	lui	a5,0x20000
     81c:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     820:	40f007b3          	neg	a5,a5
     824:	fdc42703          	lw	a4,-36(s0)
     828:	97ba                	add	a5,a5,a4
     82a:	fef42623          	sw	a5,-20(s0)
        BlockIterator = BlockOperator;
     82e:	fec42783          	lw	a5,-20(s0)
     832:	fef42423          	sw	a5,-24(s0)

        if((BlockIterator->MC_BlockSize & BlockAllocatiedBit) != 0 && BlockIterator->MC_NextFreeBlock == NULL)
     836:	fe842783          	lw	a5,-24(s0)
     83a:	43d8                	lw	a4,4(a5)
     83c:	200007b7          	lui	a5,0x20000
     840:	0047a783          	lw	a5,4(a5) # 20000004 <_data_end>
     844:	8ff9                	and	a5,a5,a4
     846:	c3a9                	beqz	a5,888 <MC_PageFree+0x82>
     848:	fe842783          	lw	a5,-24(s0)
     84c:	439c                	lw	a5,0(a5)
     84e:	ef8d                	bnez	a5,888 <MC_PageFree+0x82>
        {
            BlockIterator->MC_BlockSize &= ~BlockAllocatiedBit;
     850:	fe842783          	lw	a5,-24(s0)
     854:	43d8                	lw	a4,4(a5)
     856:	200007b7          	lui	a5,0x20000
     85a:	0047a783          	lw	a5,4(a5) # 20000004 <_data_end>
     85e:	fff7c793          	not	a5,a5
     862:	8f7d                	and	a4,a4,a5
     864:	fe842783          	lw	a5,-24(s0)
     868:	c3d8                	sw	a4,4(a5)

            /*此处应该挂起所有任务*/
            /*------------------*/
            {
                HeapSizeRemaing += BlockIterator->MC_BlockSize;
     86a:	fe842783          	lw	a5,-24(s0)
     86e:	43d8                	lw	a4,4(a5)
     870:	200007b7          	lui	a5,0x20000
     874:	0087a783          	lw	a5,8(a5) # 20000008 <HeapSizeRemaing>
     878:	973e                	add	a4,a4,a5
     87a:	200007b7          	lui	a5,0x20000
     87e:	00e7a423          	sw	a4,8(a5) # 20000008 <HeapSizeRemaing>
                MC_InsertFreeBlock(BlockIterator);
     882:	fe842503          	lw	a0,-24(s0)
     886:	3125                	jal	4ae <MC_InsertFreeBlock>
            }
            /*此处应该取消所有被挂任务*/
            /*----------------------*/
        }else{}
    }else{}
     888:	0001                	nop
     88a:	50b2                	lw	ra,44(sp)
     88c:	5422                	lw	s0,40(sp)
     88e:	6145                	addi	sp,sp,48
     890:	8082                	ret

00000892 <_vsnprintf>:
/*
 * ref: https://github.com/cccriscv/mini-riscv-os/blob/master/05-Preemptive/lib.c
 */

static int _vsnprintf(char * out, size_t n, const char* s, va_list vl)
{
     892:	715d                	addi	sp,sp,-80
     894:	c6a2                	sw	s0,76(sp)
     896:	0880                	addi	s0,sp,80
     898:	faa42e23          	sw	a0,-68(s0)
     89c:	fab42c23          	sw	a1,-72(s0)
     8a0:	fac42a23          	sw	a2,-76(s0)
     8a4:	fad42823          	sw	a3,-80(s0)
	int format = 0;
     8a8:	fe042623          	sw	zero,-20(s0)
	int longarg = 0;
     8ac:	fe042423          	sw	zero,-24(s0)
	size_t pos = 0;
     8b0:	fe042223          	sw	zero,-28(s0)
	for (; *s; s++) {
     8b4:	ae95                	j	c28 <_vsnprintf+0x396>
		if (format) {
     8b6:	fec42783          	lw	a5,-20(s0)
     8ba:	30078b63          	beqz	a5,bd0 <_vsnprintf+0x33e>
			switch(*s) {
     8be:	fb442783          	lw	a5,-76(s0)
     8c2:	0007c783          	lbu	a5,0(a5)
     8c6:	f9d78793          	addi	a5,a5,-99
     8ca:	4755                	li	a4,21
     8cc:	34f76863          	bltu	a4,a5,c1c <_vsnprintf+0x38a>
     8d0:	00279713          	slli	a4,a5,0x2
     8d4:	6785                	lui	a5,0x1
     8d6:	4d878793          	addi	a5,a5,1240 # 14d8 <STACK_END+0x38>
     8da:	97ba                	add	a5,a5,a4
     8dc:	439c                	lw	a5,0(a5)
     8de:	8782                	jr	a5
			case 'l': {
				longarg = 1;
     8e0:	4785                	li	a5,1
     8e2:	fef42423          	sw	a5,-24(s0)
				break;
     8e6:	ae25                	j	c1e <_vsnprintf+0x38c>
			}
			case 'p': {
				longarg = 1;
     8e8:	4785                	li	a5,1
     8ea:	fef42423          	sw	a5,-24(s0)
				if (out && pos < n) {
     8ee:	fbc42783          	lw	a5,-68(s0)
     8f2:	c385                	beqz	a5,912 <_vsnprintf+0x80>
     8f4:	fe442703          	lw	a4,-28(s0)
     8f8:	fb842783          	lw	a5,-72(s0)
     8fc:	00f77b63          	bgeu	a4,a5,912 <_vsnprintf+0x80>
					out[pos] = '0';
     900:	fbc42703          	lw	a4,-68(s0)
     904:	fe442783          	lw	a5,-28(s0)
     908:	97ba                	add	a5,a5,a4
     90a:	03000713          	li	a4,48
     90e:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     912:	fe442783          	lw	a5,-28(s0)
     916:	0785                	addi	a5,a5,1
     918:	fef42223          	sw	a5,-28(s0)
				if (out && pos < n) {
     91c:	fbc42783          	lw	a5,-68(s0)
     920:	c385                	beqz	a5,940 <_vsnprintf+0xae>
     922:	fe442703          	lw	a4,-28(s0)
     926:	fb842783          	lw	a5,-72(s0)
     92a:	00f77b63          	bgeu	a4,a5,940 <_vsnprintf+0xae>
					out[pos] = 'x';
     92e:	fbc42703          	lw	a4,-68(s0)
     932:	fe442783          	lw	a5,-28(s0)
     936:	97ba                	add	a5,a5,a4
     938:	07800713          	li	a4,120
     93c:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     940:	fe442783          	lw	a5,-28(s0)
     944:	0785                	addi	a5,a5,1
     946:	fef42223          	sw	a5,-28(s0)
			}
			case 'x': {
				long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
     94a:	fe842783          	lw	a5,-24(s0)
     94e:	cb89                	beqz	a5,960 <_vsnprintf+0xce>
     950:	fb042783          	lw	a5,-80(s0)
     954:	00478713          	addi	a4,a5,4
     958:	fae42823          	sw	a4,-80(s0)
     95c:	439c                	lw	a5,0(a5)
     95e:	a801                	j	96e <_vsnprintf+0xdc>
     960:	fb042783          	lw	a5,-80(s0)
     964:	00478713          	addi	a4,a5,4
     968:	fae42823          	sw	a4,-80(s0)
     96c:	439c                	lw	a5,0(a5)
     96e:	fcf42423          	sw	a5,-56(s0)
				int hexdigits = 2*(longarg ? sizeof(long) : sizeof(int))-1;
     972:	479d                	li	a5,7
     974:	fcf42223          	sw	a5,-60(s0)
				for(int i = hexdigits; i >= 0; i--) {
     978:	fc442783          	lw	a5,-60(s0)
     97c:	fef42023          	sw	a5,-32(s0)
     980:	a89d                	j	9f6 <_vsnprintf+0x164>
					int d = (num >> (4*i)) & 0xF;
     982:	fe042783          	lw	a5,-32(s0)
     986:	078a                	slli	a5,a5,0x2
     988:	fc842703          	lw	a4,-56(s0)
     98c:	40f757b3          	sra	a5,a4,a5
     990:	8bbd                	andi	a5,a5,15
     992:	fcf42023          	sw	a5,-64(s0)
					if (out && pos < n) {
     996:	fbc42783          	lw	a5,-68(s0)
     99a:	c7a1                	beqz	a5,9e2 <_vsnprintf+0x150>
     99c:	fe442703          	lw	a4,-28(s0)
     9a0:	fb842783          	lw	a5,-72(s0)
     9a4:	02f77f63          	bgeu	a4,a5,9e2 <_vsnprintf+0x150>
						out[pos] = (d < 10 ? '0'+d : 'a'+d-10);
     9a8:	fc042703          	lw	a4,-64(s0)
     9ac:	47a5                	li	a5,9
     9ae:	00e7cb63          	blt	a5,a4,9c4 <_vsnprintf+0x132>
     9b2:	fc042783          	lw	a5,-64(s0)
     9b6:	0ff7f793          	andi	a5,a5,255
     9ba:	03078793          	addi	a5,a5,48
     9be:	0ff7f793          	andi	a5,a5,255
     9c2:	a809                	j	9d4 <_vsnprintf+0x142>
     9c4:	fc042783          	lw	a5,-64(s0)
     9c8:	0ff7f793          	andi	a5,a5,255
     9cc:	05778793          	addi	a5,a5,87
     9d0:	0ff7f793          	andi	a5,a5,255
     9d4:	fbc42683          	lw	a3,-68(s0)
     9d8:	fe442703          	lw	a4,-28(s0)
     9dc:	9736                	add	a4,a4,a3
     9de:	00f70023          	sb	a5,0(a4) # 80000000 <_end_stack+0x5fff0000>
					}
					pos++;
     9e2:	fe442783          	lw	a5,-28(s0)
     9e6:	0785                	addi	a5,a5,1
     9e8:	fef42223          	sw	a5,-28(s0)
				for(int i = hexdigits; i >= 0; i--) {
     9ec:	fe042783          	lw	a5,-32(s0)
     9f0:	17fd                	addi	a5,a5,-1
     9f2:	fef42023          	sw	a5,-32(s0)
     9f6:	fe042783          	lw	a5,-32(s0)
     9fa:	f807d4e3          	bgez	a5,982 <_vsnprintf+0xf0>
				}
				longarg = 0;
     9fe:	fe042423          	sw	zero,-24(s0)
				format = 0;
     a02:	fe042623          	sw	zero,-20(s0)
				break;
     a06:	ac21                	j	c1e <_vsnprintf+0x38c>
			}
			case 'd': {
				long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
     a08:	fe842783          	lw	a5,-24(s0)
     a0c:	cb89                	beqz	a5,a1e <_vsnprintf+0x18c>
     a0e:	fb042783          	lw	a5,-80(s0)
     a12:	00478713          	addi	a4,a5,4
     a16:	fae42823          	sw	a4,-80(s0)
     a1a:	439c                	lw	a5,0(a5)
     a1c:	a801                	j	a2c <_vsnprintf+0x19a>
     a1e:	fb042783          	lw	a5,-80(s0)
     a22:	00478713          	addi	a4,a5,4
     a26:	fae42823          	sw	a4,-80(s0)
     a2a:	439c                	lw	a5,0(a5)
     a2c:	fcf42e23          	sw	a5,-36(s0)
				if (num < 0) {
     a30:	fdc42783          	lw	a5,-36(s0)
     a34:	0207df63          	bgez	a5,a72 <_vsnprintf+0x1e0>
					num = -num;
     a38:	fdc42783          	lw	a5,-36(s0)
     a3c:	40f007b3          	neg	a5,a5
     a40:	fcf42e23          	sw	a5,-36(s0)
					if (out && pos < n) {
     a44:	fbc42783          	lw	a5,-68(s0)
     a48:	c385                	beqz	a5,a68 <_vsnprintf+0x1d6>
     a4a:	fe442703          	lw	a4,-28(s0)
     a4e:	fb842783          	lw	a5,-72(s0)
     a52:	00f77b63          	bgeu	a4,a5,a68 <_vsnprintf+0x1d6>
						out[pos] = '-';
     a56:	fbc42703          	lw	a4,-68(s0)
     a5a:	fe442783          	lw	a5,-28(s0)
     a5e:	97ba                	add	a5,a5,a4
     a60:	02d00713          	li	a4,45
     a64:	00e78023          	sb	a4,0(a5)
					}
					pos++;
     a68:	fe442783          	lw	a5,-28(s0)
     a6c:	0785                	addi	a5,a5,1
     a6e:	fef42223          	sw	a5,-28(s0)
				}
				long digits = 1;
     a72:	4785                	li	a5,1
     a74:	fcf42c23          	sw	a5,-40(s0)
				for (long nn = num; nn /= 10; digits++);
     a78:	fdc42783          	lw	a5,-36(s0)
     a7c:	fcf42a23          	sw	a5,-44(s0)
     a80:	a031                	j	a8c <_vsnprintf+0x1fa>
     a82:	fd842783          	lw	a5,-40(s0)
     a86:	0785                	addi	a5,a5,1
     a88:	fcf42c23          	sw	a5,-40(s0)
     a8c:	fd442703          	lw	a4,-44(s0)
     a90:	47a9                	li	a5,10
     a92:	02f747b3          	div	a5,a4,a5
     a96:	fcf42a23          	sw	a5,-44(s0)
     a9a:	fd442783          	lw	a5,-44(s0)
     a9e:	f3f5                	bnez	a5,a82 <_vsnprintf+0x1f0>
				for (int i = digits-1; i >= 0; i--) {
     aa0:	fd842783          	lw	a5,-40(s0)
     aa4:	17fd                	addi	a5,a5,-1
     aa6:	fcf42823          	sw	a5,-48(s0)
     aaa:	a8b1                	j	b06 <_vsnprintf+0x274>
					if (out && pos + i < n) {
     aac:	fbc42783          	lw	a5,-68(s0)
     ab0:	cf9d                	beqz	a5,aee <_vsnprintf+0x25c>
     ab2:	fd042703          	lw	a4,-48(s0)
     ab6:	fe442783          	lw	a5,-28(s0)
     aba:	97ba                	add	a5,a5,a4
     abc:	fb842703          	lw	a4,-72(s0)
     ac0:	02e7f763          	bgeu	a5,a4,aee <_vsnprintf+0x25c>
						out[pos + i] = '0' + (num % 10);
     ac4:	fdc42703          	lw	a4,-36(s0)
     ac8:	47a9                	li	a5,10
     aca:	02f767b3          	rem	a5,a4,a5
     ace:	0ff7f713          	andi	a4,a5,255
     ad2:	fd042683          	lw	a3,-48(s0)
     ad6:	fe442783          	lw	a5,-28(s0)
     ada:	97b6                	add	a5,a5,a3
     adc:	fbc42683          	lw	a3,-68(s0)
     ae0:	97b6                	add	a5,a5,a3
     ae2:	03070713          	addi	a4,a4,48
     ae6:	0ff77713          	andi	a4,a4,255
     aea:	00e78023          	sb	a4,0(a5)
					}
					num /= 10;
     aee:	fdc42703          	lw	a4,-36(s0)
     af2:	47a9                	li	a5,10
     af4:	02f747b3          	div	a5,a4,a5
     af8:	fcf42e23          	sw	a5,-36(s0)
				for (int i = digits-1; i >= 0; i--) {
     afc:	fd042783          	lw	a5,-48(s0)
     b00:	17fd                	addi	a5,a5,-1
     b02:	fcf42823          	sw	a5,-48(s0)
     b06:	fd042783          	lw	a5,-48(s0)
     b0a:	fa07d1e3          	bgez	a5,aac <_vsnprintf+0x21a>
				}
				pos += digits;
     b0e:	fd842783          	lw	a5,-40(s0)
     b12:	fe442703          	lw	a4,-28(s0)
     b16:	97ba                	add	a5,a5,a4
     b18:	fef42223          	sw	a5,-28(s0)
				longarg = 0;
     b1c:	fe042423          	sw	zero,-24(s0)
				format = 0;
     b20:	fe042623          	sw	zero,-20(s0)
				break;
     b24:	a8ed                	j	c1e <_vsnprintf+0x38c>
			}
			case 's': {
				const char* s2 = va_arg(vl, const char*);
     b26:	fb042783          	lw	a5,-80(s0)
     b2a:	00478713          	addi	a4,a5,4
     b2e:	fae42823          	sw	a4,-80(s0)
     b32:	439c                	lw	a5,0(a5)
     b34:	fcf42623          	sw	a5,-52(s0)
				while (*s2) {
     b38:	a83d                	j	b76 <_vsnprintf+0x2e4>
					if (out && pos < n) {
     b3a:	fbc42783          	lw	a5,-68(s0)
     b3e:	c395                	beqz	a5,b62 <_vsnprintf+0x2d0>
     b40:	fe442703          	lw	a4,-28(s0)
     b44:	fb842783          	lw	a5,-72(s0)
     b48:	00f77d63          	bgeu	a4,a5,b62 <_vsnprintf+0x2d0>
						out[pos] = *s2;
     b4c:	fbc42703          	lw	a4,-68(s0)
     b50:	fe442783          	lw	a5,-28(s0)
     b54:	97ba                	add	a5,a5,a4
     b56:	fcc42703          	lw	a4,-52(s0)
     b5a:	00074703          	lbu	a4,0(a4)
     b5e:	00e78023          	sb	a4,0(a5)
					}
					pos++;
     b62:	fe442783          	lw	a5,-28(s0)
     b66:	0785                	addi	a5,a5,1
     b68:	fef42223          	sw	a5,-28(s0)
					s2++;
     b6c:	fcc42783          	lw	a5,-52(s0)
     b70:	0785                	addi	a5,a5,1
     b72:	fcf42623          	sw	a5,-52(s0)
				while (*s2) {
     b76:	fcc42783          	lw	a5,-52(s0)
     b7a:	0007c783          	lbu	a5,0(a5)
     b7e:	ffd5                	bnez	a5,b3a <_vsnprintf+0x2a8>
				}
				longarg = 0;
     b80:	fe042423          	sw	zero,-24(s0)
				format = 0;
     b84:	fe042623          	sw	zero,-20(s0)
				break;
     b88:	a859                	j	c1e <_vsnprintf+0x38c>
			}
			case 'c': {
				if (out && pos < n) {
     b8a:	fbc42783          	lw	a5,-68(s0)
     b8e:	c79d                	beqz	a5,bbc <_vsnprintf+0x32a>
     b90:	fe442703          	lw	a4,-28(s0)
     b94:	fb842783          	lw	a5,-72(s0)
     b98:	02f77263          	bgeu	a4,a5,bbc <_vsnprintf+0x32a>
					out[pos] = (char)va_arg(vl,int);
     b9c:	fb042783          	lw	a5,-80(s0)
     ba0:	00478713          	addi	a4,a5,4
     ba4:	fae42823          	sw	a4,-80(s0)
     ba8:	4394                	lw	a3,0(a5)
     baa:	fbc42703          	lw	a4,-68(s0)
     bae:	fe442783          	lw	a5,-28(s0)
     bb2:	97ba                	add	a5,a5,a4
     bb4:	0ff6f713          	andi	a4,a3,255
     bb8:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     bbc:	fe442783          	lw	a5,-28(s0)
     bc0:	0785                	addi	a5,a5,1
     bc2:	fef42223          	sw	a5,-28(s0)
				longarg = 0;
     bc6:	fe042423          	sw	zero,-24(s0)
				format = 0;
     bca:	fe042623          	sw	zero,-20(s0)
				break;
     bce:	a881                	j	c1e <_vsnprintf+0x38c>
			}
			default:
				break;
			}
		} else if (*s == '%') {
     bd0:	fb442783          	lw	a5,-76(s0)
     bd4:	0007c703          	lbu	a4,0(a5)
     bd8:	02500793          	li	a5,37
     bdc:	00f71663          	bne	a4,a5,be8 <_vsnprintf+0x356>
			format = 1;
     be0:	4785                	li	a5,1
     be2:	fef42623          	sw	a5,-20(s0)
     be6:	a825                	j	c1e <_vsnprintf+0x38c>
		} else {
			if (out && pos < n) {
     be8:	fbc42783          	lw	a5,-68(s0)
     bec:	c395                	beqz	a5,c10 <_vsnprintf+0x37e>
     bee:	fe442703          	lw	a4,-28(s0)
     bf2:	fb842783          	lw	a5,-72(s0)
     bf6:	00f77d63          	bgeu	a4,a5,c10 <_vsnprintf+0x37e>
				out[pos] = *s;
     bfa:	fbc42703          	lw	a4,-68(s0)
     bfe:	fe442783          	lw	a5,-28(s0)
     c02:	97ba                	add	a5,a5,a4
     c04:	fb442703          	lw	a4,-76(s0)
     c08:	00074703          	lbu	a4,0(a4)
     c0c:	00e78023          	sb	a4,0(a5)
			}
			pos++;
     c10:	fe442783          	lw	a5,-28(s0)
     c14:	0785                	addi	a5,a5,1
     c16:	fef42223          	sw	a5,-28(s0)
     c1a:	a011                	j	c1e <_vsnprintf+0x38c>
				break;
     c1c:	0001                	nop
	for (; *s; s++) {
     c1e:	fb442783          	lw	a5,-76(s0)
     c22:	0785                	addi	a5,a5,1
     c24:	faf42a23          	sw	a5,-76(s0)
     c28:	fb442783          	lw	a5,-76(s0)
     c2c:	0007c783          	lbu	a5,0(a5)
     c30:	c80793e3          	bnez	a5,8b6 <_vsnprintf+0x24>
		}
    	}
	if (out && pos < n) {
     c34:	fbc42783          	lw	a5,-68(s0)
     c38:	cf99                	beqz	a5,c56 <_vsnprintf+0x3c4>
     c3a:	fe442703          	lw	a4,-28(s0)
     c3e:	fb842783          	lw	a5,-72(s0)
     c42:	00f77a63          	bgeu	a4,a5,c56 <_vsnprintf+0x3c4>
		out[pos] = 0;
     c46:	fbc42703          	lw	a4,-68(s0)
     c4a:	fe442783          	lw	a5,-28(s0)
     c4e:	97ba                	add	a5,a5,a4
     c50:	00078023          	sb	zero,0(a5)
     c54:	a839                	j	c72 <_vsnprintf+0x3e0>
	} else if (out && n) {
     c56:	fbc42783          	lw	a5,-68(s0)
     c5a:	cf81                	beqz	a5,c72 <_vsnprintf+0x3e0>
     c5c:	fb842783          	lw	a5,-72(s0)
     c60:	cb89                	beqz	a5,c72 <_vsnprintf+0x3e0>
		out[n-1] = 0;
     c62:	fb842783          	lw	a5,-72(s0)
     c66:	17fd                	addi	a5,a5,-1
     c68:	fbc42703          	lw	a4,-68(s0)
     c6c:	97ba                	add	a5,a5,a4
     c6e:	00078023          	sb	zero,0(a5)
	}
	return pos;
     c72:	fe442783          	lw	a5,-28(s0)
}
     c76:	853e                	mv	a0,a5
     c78:	4436                	lw	s0,76(sp)
     c7a:	6161                	addi	sp,sp,80
     c7c:	8082                	ret

00000c7e <_vprintf>:

static char out_buf[1000]; // buffer for _vprintf()

static int _vprintf(const char* s, va_list vl)
{
     c7e:	7179                	addi	sp,sp,-48
     c80:	d606                	sw	ra,44(sp)
     c82:	d422                	sw	s0,40(sp)
     c84:	1800                	addi	s0,sp,48
     c86:	fca42e23          	sw	a0,-36(s0)
     c8a:	fcb42c23          	sw	a1,-40(s0)
	int res = _vsnprintf(NULL, -1, s, vl);
     c8e:	fd842683          	lw	a3,-40(s0)
     c92:	fdc42603          	lw	a2,-36(s0)
     c96:	55fd                	li	a1,-1
     c98:	4501                	li	a0,0
     c9a:	3ee5                	jal	892 <_vsnprintf>
     c9c:	fea42623          	sw	a0,-20(s0)
	if (res+1 >= sizeof(out_buf)) {
     ca0:	fec42783          	lw	a5,-20(s0)
     ca4:	0785                	addi	a5,a5,1
     ca6:	873e                	mv	a4,a5
     ca8:	3e700793          	li	a5,999
     cac:	00e7f863          	bgeu	a5,a4,cbc <_vprintf+0x3e>
		puts("error: output string size overflow\n");
     cb0:	6785                	lui	a5,0x1
     cb2:	53078513          	addi	a0,a5,1328 # 1530 <STACK_END+0x90>
     cb6:	fa6ff0ef          	jal	ra,45c <puts>
		while(1) {}
     cba:	a001                	j	cba <_vprintf+0x3c>
	}
	_vsnprintf(out_buf, res + 1, s, vl);
     cbc:	fec42783          	lw	a5,-20(s0)
     cc0:	0785                	addi	a5,a5,1
     cc2:	fd842683          	lw	a3,-40(s0)
     cc6:	fdc42603          	lw	a2,-36(s0)
     cca:	85be                	mv	a1,a5
     ccc:	200007b7          	lui	a5,0x20000
     cd0:	00c78513          	addi	a0,a5,12 # 2000000c <out_buf>
     cd4:	3e7d                	jal	892 <_vsnprintf>
	puts(out_buf);
     cd6:	200007b7          	lui	a5,0x20000
     cda:	00c78513          	addi	a0,a5,12 # 2000000c <out_buf>
     cde:	f7eff0ef          	jal	ra,45c <puts>
	return res;
     ce2:	fec42783          	lw	a5,-20(s0)
}
     ce6:	853e                	mv	a0,a5
     ce8:	50b2                	lw	ra,44(sp)
     cea:	5422                	lw	s0,40(sp)
     cec:	6145                	addi	sp,sp,48
     cee:	8082                	ret

00000cf0 <printf>:

int printf(const char* s, ...)
{
     cf0:	715d                	addi	sp,sp,-80
     cf2:	d606                	sw	ra,44(sp)
     cf4:	d422                	sw	s0,40(sp)
     cf6:	1800                	addi	s0,sp,48
     cf8:	fca42e23          	sw	a0,-36(s0)
     cfc:	c04c                	sw	a1,4(s0)
     cfe:	c410                	sw	a2,8(s0)
     d00:	c454                	sw	a3,12(s0)
     d02:	c818                	sw	a4,16(s0)
     d04:	c85c                	sw	a5,20(s0)
     d06:	01042c23          	sw	a6,24(s0)
     d0a:	01142e23          	sw	a7,28(s0)
	int res = 0;
     d0e:	fe042623          	sw	zero,-20(s0)
	va_list vl;
	va_start(vl, s);
     d12:	02040793          	addi	a5,s0,32
     d16:	1791                	addi	a5,a5,-28
     d18:	fef42423          	sw	a5,-24(s0)
	res = _vprintf(s, vl);
     d1c:	fe842783          	lw	a5,-24(s0)
     d20:	85be                	mv	a1,a5
     d22:	fdc42503          	lw	a0,-36(s0)
     d26:	3fa1                	jal	c7e <_vprintf>
     d28:	fea42623          	sw	a0,-20(s0)
	va_end(vl);
	return res;
     d2c:	fec42783          	lw	a5,-20(s0)
}
     d30:	853e                	mv	a0,a5
     d32:	50b2                	lw	ra,44(sp)
     d34:	5422                	lw	s0,40(sp)
     d36:	6161                	addi	sp,sp,80
     d38:	8082                	ret

00000d3a <panic>:

void panic(char *s)
{
     d3a:	1101                	addi	sp,sp,-32
     d3c:	ce06                	sw	ra,28(sp)
     d3e:	cc22                	sw	s0,24(sp)
     d40:	1000                	addi	s0,sp,32
     d42:	fea42623          	sw	a0,-20(s0)
	printf("panic: ");
     d46:	6785                	lui	a5,0x1
     d48:	55478513          	addi	a0,a5,1364 # 1554 <STACK_END+0xb4>
     d4c:	3755                	jal	cf0 <printf>
	printf(s);
     d4e:	fec42503          	lw	a0,-20(s0)
     d52:	3f79                	jal	cf0 <printf>
	printf("\n");
     d54:	6785                	lui	a5,0x1
     d56:	55c78513          	addi	a0,a5,1372 # 155c <STACK_END+0xbc>
     d5a:	3f59                	jal	cf0 <printf>
	while(1){};
     d5c:	a001                	j	d5c <panic+0x22>
	...

00000d60 <w_mscratch>:
	return x;
}

/* Machine Scratch register, for early trap handler */
static inline __attribute__((aligned(4))) void w_mscratch(reg_t x)
{
     d60:	1101                	addi	sp,sp,-32
     d62:	ce22                	sw	s0,28(sp)
     d64:	1000                	addi	s0,sp,32
     d66:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mscratch, %0" : : "r" (x));
     d6a:	fec42783          	lw	a5,-20(s0)
     d6e:	34079073          	csrw	mscratch,a5
}
     d72:	0001                	nop
     d74:	4472                	lw	s0,28(sp)
     d76:	6105                	addi	sp,sp,32
     d78:	8082                	ret

00000d7a <MC_schedule>:
extern void MC_hw_context_switch(void *stack_addr);

struct MC_sched MC_scheduler;

void MC_schedule()
{
     d7a:	1101                	addi	sp,sp,-32
     d7c:	ce06                	sw	ra,28(sp)
     d7e:	cc22                	sw	s0,24(sp)
     d80:	1000                	addi	s0,sp,32
    MC_thread_t from_thread, to_thread = NULL;
     d82:	fe042423          	sw	zero,-24(s0)
    if(MC_scheduler.sched_state == SCHED_RUNNING)
     d86:	200007b7          	lui	a5,0x20000
     d8a:	4147c703          	lbu	a4,1044(a5) # 20000414 <MC_scheduler>
     d8e:	4785                	li	a5,1
     d90:	00f71a63          	bne	a4,a5,da4 <MC_schedule+0x2a>
    {
        from_thread = MC_scheduler.running_thread;
     d94:	200007b7          	lui	a5,0x20000
     d98:	41478793          	addi	a5,a5,1044 # 20000414 <MC_scheduler>
     d9c:	43dc                	lw	a5,4(a5)
     d9e:	fef42623          	sw	a5,-20(s0)
     da2:	a811                	j	db6 <MC_schedule+0x3c>
    }
    else
    {
        MC_scheduler.sched_state = SCHED_RUNNING;
     da4:	200007b7          	lui	a5,0x20000
     da8:	4705                	li	a4,1
     daa:	40e78a23          	sb	a4,1044(a5) # 20000414 <MC_scheduler>
        from_thread = NULL;
     dae:	fe042623          	sw	zero,-20(s0)
        w_mscratch(0);
     db2:	4501                	li	a0,0
     db4:	3775                	jal	d60 <w_mscratch>
    }

    for(int i = 63; i >= 0; i--)
     db6:	03f00793          	li	a5,63
     dba:	fef42223          	sw	a5,-28(s0)
     dbe:	a8c1                	j	e8e <MC_schedule+0x114>
    {
        if(Ready_threadList_Start[i].next != (MC_thread_t)&Ready_threadList_End[i])
     dc0:	20000737          	lui	a4,0x20000
     dc4:	fe442783          	lw	a5,-28(s0)
     dc8:	41c70713          	addi	a4,a4,1052 # 2000041c <Ready_threadList_Start>
     dcc:	078e                	slli	a5,a5,0x3
     dce:	97ba                	add	a5,a5,a4
     dd0:	43d8                	lw	a4,4(a5)
     dd2:	fe442783          	lw	a5,-28(s0)
     dd6:	00379693          	slli	a3,a5,0x3
     dda:	200007b7          	lui	a5,0x20000
     dde:	61c78793          	addi	a5,a5,1564 # 2000061c <Ready_threadList_End>
     de2:	97b6                	add	a5,a5,a3
     de4:	0af70063          	beq	a4,a5,e84 <MC_schedule+0x10a>
        {
            to_thread = Ready_threadList_Start[i].next;
     de8:	20000737          	lui	a4,0x20000
     dec:	fe442783          	lw	a5,-28(s0)
     df0:	41c70713          	addi	a4,a4,1052 # 2000041c <Ready_threadList_Start>
     df4:	078e                	slli	a5,a5,0x3
     df6:	97ba                	add	a5,a5,a4
     df8:	43dc                	lw	a5,4(a5)
     dfa:	fef42423          	sw	a5,-24(s0)
            Ready_threadList_Start[i].next = to_thread->next;
     dfe:	fe842783          	lw	a5,-24(s0)
     e02:	43d8                	lw	a4,4(a5)
     e04:	200006b7          	lui	a3,0x20000
     e08:	fe442783          	lw	a5,-28(s0)
     e0c:	41c68693          	addi	a3,a3,1052 # 2000041c <Ready_threadList_Start>
     e10:	078e                	slli	a5,a5,0x3
     e12:	97b6                	add	a5,a5,a3
     e14:	c3d8                	sw	a4,4(a5)
            to_thread->next->prev = (MC_thread_t)&Ready_threadList_Start[i];
     e16:	fe842783          	lw	a5,-24(s0)
     e1a:	43dc                	lw	a5,4(a5)
     e1c:	fe442703          	lw	a4,-28(s0)
     e20:	00371693          	slli	a3,a4,0x3
     e24:	20000737          	lui	a4,0x20000
     e28:	41c70713          	addi	a4,a4,1052 # 2000041c <Ready_threadList_Start>
     e2c:	9736                	add	a4,a4,a3
     e2e:	c398                	sw	a4,0(a5)

            to_thread->next = (MC_thread_t)&Ready_threadList_End[i];
     e30:	fe442783          	lw	a5,-28(s0)
     e34:	00379713          	slli	a4,a5,0x3
     e38:	200007b7          	lui	a5,0x20000
     e3c:	61c78793          	addi	a5,a5,1564 # 2000061c <Ready_threadList_End>
     e40:	973e                	add	a4,a4,a5
     e42:	fe842783          	lw	a5,-24(s0)
     e46:	c3d8                	sw	a4,4(a5)
            to_thread->prev = Ready_threadList_End[i].prev;
     e48:	200007b7          	lui	a5,0x20000
     e4c:	fe442703          	lw	a4,-28(s0)
     e50:	070e                	slli	a4,a4,0x3
     e52:	61c78793          	addi	a5,a5,1564 # 2000061c <Ready_threadList_End>
     e56:	97ba                	add	a5,a5,a4
     e58:	4398                	lw	a4,0(a5)
     e5a:	fe842783          	lw	a5,-24(s0)
     e5e:	c398                	sw	a4,0(a5)
            Ready_threadList_End[i].prev = to_thread;
     e60:	200007b7          	lui	a5,0x20000
     e64:	fe442703          	lw	a4,-28(s0)
     e68:	070e                	slli	a4,a4,0x3
     e6a:	61c78793          	addi	a5,a5,1564 # 2000061c <Ready_threadList_End>
     e6e:	97ba                	add	a5,a5,a4
     e70:	fe842703          	lw	a4,-24(s0)
     e74:	c398                	sw	a4,0(a5)
            to_thread->prev->next = to_thread;
     e76:	fe842783          	lw	a5,-24(s0)
     e7a:	439c                	lw	a5,0(a5)
     e7c:	fe842703          	lw	a4,-24(s0)
     e80:	c3d8                	sw	a4,4(a5)

            break;
     e82:	a811                	j	e96 <MC_schedule+0x11c>
    for(int i = 63; i >= 0; i--)
     e84:	fe442783          	lw	a5,-28(s0)
     e88:	17fd                	addi	a5,a5,-1
     e8a:	fef42223          	sw	a5,-28(s0)
     e8e:	fe442783          	lw	a5,-28(s0)
     e92:	f207d7e3          	bgez	a5,dc0 <MC_schedule+0x46>
        }
    }
    
    if(to_thread == NULL)
     e96:	fe842783          	lw	a5,-24(s0)
     e9a:	c795                	beqz	a5,ec6 <MC_schedule+0x14c>
    {
        return ;
    }

    if(from_thread != to_thread)
     e9c:	fec42703          	lw	a4,-20(s0)
     ea0:	fe842783          	lw	a5,-24(s0)
     ea4:	02f70363          	beq	a4,a5,eca <MC_schedule+0x150>
    {
        MC_scheduler.running_thread = to_thread;
     ea8:	200007b7          	lui	a5,0x20000
     eac:	41478793          	addi	a5,a5,1044 # 20000414 <MC_scheduler>
     eb0:	fe842703          	lw	a4,-24(s0)
     eb4:	c3d8                	sw	a4,4(a5)
        MC_hw_context_switch(to_thread->stack_addr);
     eb6:	fe842783          	lw	a5,-24(s0)
     eba:	53dc                	lw	a5,36(a5)
     ebc:	853e                	mv	a0,a5
     ebe:	adaff0ef          	jal	ra,198 <MC_hw_context_switch>
    }

    return;
     ec2:	0001                	nop
     ec4:	a019                	j	eca <MC_schedule+0x150>
        return ;
     ec6:	0001                	nop
     ec8:	a011                	j	ecc <MC_schedule+0x152>
    return;
     eca:	0001                	nop
}
     ecc:	40f2                	lw	ra,28(sp)
     ece:	4462                	lw	s0,24(sp)
     ed0:	6105                	addi	sp,sp,32
     ed2:	8082                	ret

00000ed4 <MC_scheduler_start>:

/**
 * 启用调度器
 */
void MC_scheduler_start()
{
     ed4:	1141                	addi	sp,sp,-16
     ed6:	c606                	sw	ra,12(sp)
     ed8:	c422                	sw	s0,8(sp)
     eda:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_STOP)
     edc:	200007b7          	lui	a5,0x20000
     ee0:	4147c783          	lbu	a5,1044(a5) # 20000414 <MC_scheduler>
     ee4:	e399                	bnez	a5,eea <MC_scheduler_start+0x16>
    {
        MC_schedule();
     ee6:	3d51                	jal	d7a <MC_schedule>
    }
    return ;
     ee8:	0001                	nop
     eea:	0001                	nop
}
     eec:	40b2                	lw	ra,12(sp)
     eee:	4422                	lw	s0,8(sp)
     ef0:	0141                	addi	sp,sp,16
     ef2:	8082                	ret
	...

00000ef6 <_thread_init>:
                void (*entry)(void),
                uint8_t *stack_start,
                size_t stack_size,
                uint8_t priority,
                uint32_t tick)
{
     ef6:	7139                	addi	sp,sp,-64
     ef8:	de06                	sw	ra,60(sp)
     efa:	dc22                	sw	s0,56(sp)
     efc:	0080                	addi	s0,sp,64
     efe:	fca42e23          	sw	a0,-36(s0)
     f02:	fcb42c23          	sw	a1,-40(s0)
     f06:	fcc42a23          	sw	a2,-44(s0)
     f0a:	fcd42823          	sw	a3,-48(s0)
     f0e:	fce42623          	sw	a4,-52(s0)
     f12:	fd042223          	sw	a6,-60(s0)
     f16:	fcf405a3          	sb	a5,-53(s0)
    size_t name_len = MC_strlen(name);
     f1a:	fd842503          	lw	a0,-40(s0)
     f1e:	2621                	jal	1226 <MC_strlen>
     f20:	fea42623          	sw	a0,-20(s0)
    MC_memcpy(thread->name, name, name_len);
     f24:	fdc42783          	lw	a5,-36(s0)
     f28:	07a1                	addi	a5,a5,8
     f2a:	fec42703          	lw	a4,-20(s0)
     f2e:	863a                	mv	a2,a4
     f30:	fd842583          	lw	a1,-40(s0)
     f34:	853e                	mv	a0,a5
     f36:	2ca5                	jal	11ae <MC_memcpy>
    thread->sp = stack_start + stack_size;
     f38:	fd042703          	lw	a4,-48(s0)
     f3c:	fcc42783          	lw	a5,-52(s0)
     f40:	973e                	add	a4,a4,a5
     f42:	fdc42783          	lw	a5,-36(s0)
     f46:	cfd8                	sw	a4,28(a5)
    thread->entry = entry;
     f48:	fdc42783          	lw	a5,-36(s0)
     f4c:	fd442703          	lw	a4,-44(s0)
     f50:	d398                	sw	a4,32(a5)
    thread->stack_addr = stack_start;
     f52:	fdc42783          	lw	a5,-36(s0)
     f56:	fd042703          	lw	a4,-48(s0)
     f5a:	d3d8                	sw	a4,36(a5)
    thread->stack_size = stack_size;
     f5c:	fdc42783          	lw	a5,-36(s0)
     f60:	fcc42703          	lw	a4,-52(s0)
     f64:	d798                	sw	a4,40(a5)
    thread->priority = priority;
     f66:	fdc42783          	lw	a5,-36(s0)
     f6a:	fcb44703          	lbu	a4,-53(s0)
     f6e:	02e78623          	sb	a4,44(a5)
    thread->tick = tick;
     f72:	fdc42783          	lw	a5,-36(s0)
     f76:	fc442703          	lw	a4,-60(s0)
     f7a:	db98                	sw	a4,48(a5)
}
     f7c:	0001                	nop
     f7e:	50f2                	lw	ra,60(sp)
     f80:	5462                	lw	s0,56(sp)
     f82:	6121                	addi	sp,sp,64
     f84:	8082                	ret

00000f86 <MC_threadList_Init>:

void MC_threadList_Init()
{
     f86:	1101                	addi	sp,sp,-32
     f88:	ce22                	sw	s0,28(sp)
     f8a:	1000                	addi	s0,sp,32
    for(int i = 0; i < 64; i++)
     f8c:	fe042623          	sw	zero,-20(s0)
     f90:	a8b5                	j	100c <MC_threadList_Init+0x86>
    {
        Ready_threadList_Start[i].prev = NULL;
     f92:	200007b7          	lui	a5,0x20000
     f96:	fec42703          	lw	a4,-20(s0)
     f9a:	070e                	slli	a4,a4,0x3
     f9c:	41c78793          	addi	a5,a5,1052 # 2000041c <Ready_threadList_Start>
     fa0:	97ba                	add	a5,a5,a4
     fa2:	0007a023          	sw	zero,0(a5)
        Ready_threadList_Start[i].next = (MC_thread_t)&Ready_threadList_End[i];
     fa6:	fec42783          	lw	a5,-20(s0)
     faa:	00379713          	slli	a4,a5,0x3
     fae:	200007b7          	lui	a5,0x20000
     fb2:	61c78793          	addi	a5,a5,1564 # 2000061c <Ready_threadList_End>
     fb6:	973e                	add	a4,a4,a5
     fb8:	200006b7          	lui	a3,0x20000
     fbc:	fec42783          	lw	a5,-20(s0)
     fc0:	41c68693          	addi	a3,a3,1052 # 2000041c <Ready_threadList_Start>
     fc4:	078e                	slli	a5,a5,0x3
     fc6:	97b6                	add	a5,a5,a3
     fc8:	c3d8                	sw	a4,4(a5)

        Ready_threadList_End[i].prev = (MC_thread_t)&Ready_threadList_Start[i];
     fca:	fec42783          	lw	a5,-20(s0)
     fce:	00379713          	slli	a4,a5,0x3
     fd2:	200007b7          	lui	a5,0x20000
     fd6:	41c78793          	addi	a5,a5,1052 # 2000041c <Ready_threadList_Start>
     fda:	973e                	add	a4,a4,a5
     fdc:	200007b7          	lui	a5,0x20000
     fe0:	fec42683          	lw	a3,-20(s0)
     fe4:	068e                	slli	a3,a3,0x3
     fe6:	61c78793          	addi	a5,a5,1564 # 2000061c <Ready_threadList_End>
     fea:	97b6                	add	a5,a5,a3
     fec:	c398                	sw	a4,0(a5)
        Ready_threadList_End[i].next = NULL;
     fee:	20000737          	lui	a4,0x20000
     ff2:	fec42783          	lw	a5,-20(s0)
     ff6:	61c70713          	addi	a4,a4,1564 # 2000061c <Ready_threadList_End>
     ffa:	078e                	slli	a5,a5,0x3
     ffc:	97ba                	add	a5,a5,a4
     ffe:	0007a223          	sw	zero,4(a5)
    for(int i = 0; i < 64; i++)
    1002:	fec42783          	lw	a5,-20(s0)
    1006:	0785                	addi	a5,a5,1
    1008:	fef42623          	sw	a5,-20(s0)
    100c:	fec42703          	lw	a4,-20(s0)
    1010:	03f00793          	li	a5,63
    1014:	f6e7dfe3          	bge	a5,a4,f92 <MC_threadList_Init+0xc>
    }
}
    1018:	0001                	nop
    101a:	4472                	lw	s0,28(sp)
    101c:	6105                	addi	sp,sp,32
    101e:	8082                	ret

00001020 <MC_thread_create>:
MC_thread_t MC_thread_create(char *name,
                            void (*entry)(void),
                            size_t stack_size,
                            uint8_t priority,
                            uint32_t tick)
{
    1020:	7139                	addi	sp,sp,-64
    1022:	de06                	sw	ra,60(sp)
    1024:	dc22                	sw	s0,56(sp)
    1026:	0080                	addi	s0,sp,64
    1028:	fca42e23          	sw	a0,-36(s0)
    102c:	fcb42c23          	sw	a1,-40(s0)
    1030:	fcc42a23          	sw	a2,-44(s0)
    1034:	87b6                	mv	a5,a3
    1036:	fce42623          	sw	a4,-52(s0)
    103a:	fcf409a3          	sb	a5,-45(s0)
    MC_thread_t thread;
    uint8_t *stack_start;

    if(Ready_threadList_Start[0].next == NULL)
    103e:	200007b7          	lui	a5,0x20000
    1042:	41c78793          	addi	a5,a5,1052 # 2000041c <Ready_threadList_Start>
    1046:	43dc                	lw	a5,4(a5)
    1048:	e391                	bnez	a5,104c <MC_thread_create+0x2c>
    {
        MC_threadList_Init();
    104a:	3f35                	jal	f86 <MC_threadList_Init>
    }

    thread = (MC_thread_t)MC_PageMalloc(sizeof(struct MC_thread));
    104c:	03400513          	li	a0,52
    1050:	d56ff0ef          	jal	ra,5a6 <MC_PageMalloc>
    1054:	fea42623          	sw	a0,-20(s0)
    if(thread == NULL)
    1058:	fec42783          	lw	a5,-20(s0)
    105c:	e399                	bnez	a5,1062 <MC_thread_create+0x42>
    {
        return NULL;
    105e:	4781                	li	a5,0
    1060:	a0a1                	j	10a8 <MC_thread_create+0x88>
    }

    stack_size = stack_size + extra_size_for_context;
    1062:	08000793          	li	a5,128
    1066:	fd442703          	lw	a4,-44(s0)
    106a:	97ba                	add	a5,a5,a4
    106c:	fcf42a23          	sw	a5,-44(s0)
    stack_start = (uint8_t *)MC_PageMalloc(stack_size);
    1070:	fd442503          	lw	a0,-44(s0)
    1074:	d32ff0ef          	jal	ra,5a6 <MC_PageMalloc>
    1078:	fea42423          	sw	a0,-24(s0)
    if(stack_start == NULL)
    107c:	fe842783          	lw	a5,-24(s0)
    1080:	e399                	bnez	a5,1086 <MC_thread_create+0x66>
    {
        return NULL;
    1082:	4781                	li	a5,0
    1084:	a015                	j	10a8 <MC_thread_create+0x88>
    }

    _thread_init(thread,
    1086:	fd344783          	lbu	a5,-45(s0)
    108a:	fcc42803          	lw	a6,-52(s0)
    108e:	fd442703          	lw	a4,-44(s0)
    1092:	fe842683          	lw	a3,-24(s0)
    1096:	fd842603          	lw	a2,-40(s0)
    109a:	fdc42583          	lw	a1,-36(s0)
    109e:	fec42503          	lw	a0,-20(s0)
    10a2:	3d91                	jal	ef6 <_thread_init>
                stack_start,
                stack_size,
                priority,
                tick);
    
    return thread;
    10a4:	fec42783          	lw	a5,-20(s0)
}
    10a8:	853e                	mv	a0,a5
    10aa:	50f2                	lw	ra,60(sp)
    10ac:	5462                	lw	s0,56(sp)
    10ae:	6121                	addi	sp,sp,64
    10b0:	8082                	ret

000010b2 <MC_thread_delete>:

uint8_t MC_thread_delete(MC_thread_t thread)
{
    10b2:	1101                	addi	sp,sp,-32
    10b4:	ce06                	sw	ra,28(sp)
    10b6:	cc22                	sw	s0,24(sp)
    10b8:	1000                	addi	s0,sp,32
    10ba:	fea42623          	sw	a0,-20(s0)
    thread->next->prev = thread->prev;
    10be:	fec42783          	lw	a5,-20(s0)
    10c2:	43dc                	lw	a5,4(a5)
    10c4:	fec42703          	lw	a4,-20(s0)
    10c8:	4318                	lw	a4,0(a4)
    10ca:	c398                	sw	a4,0(a5)
    thread->prev->next = thread->next;
    10cc:	fec42783          	lw	a5,-20(s0)
    10d0:	439c                	lw	a5,0(a5)
    10d2:	fec42703          	lw	a4,-20(s0)
    10d6:	4358                	lw	a4,4(a4)
    10d8:	c3d8                	sw	a4,4(a5)

    MC_PageFree(thread);
    10da:	fec42503          	lw	a0,-20(s0)
    10de:	f28ff0ef          	jal	ra,806 <MC_PageFree>
    MC_PageFree(thread->stack_addr);
    10e2:	fec42783          	lw	a5,-20(s0)
    10e6:	53dc                	lw	a5,36(a5)
    10e8:	853e                	mv	a0,a5
    10ea:	f1cff0ef          	jal	ra,806 <MC_PageFree>
    return 0;
    10ee:	4781                	li	a5,0
}
    10f0:	853e                	mv	a0,a5
    10f2:	40f2                	lw	ra,28(sp)
    10f4:	4462                	lw	s0,24(sp)
    10f6:	6105                	addi	sp,sp,32
    10f8:	8082                	ret

000010fa <MC_thread_startup>:
/**
 * 如果还没有任务调度则开启调度器并运行
 * 否则只把任务加入就绪队列
 */
uint8_t MC_thread_startup(MC_thread_t thread)
{
    10fa:	7179                	addi	sp,sp,-48
    10fc:	d622                	sw	s0,44(sp)
    10fe:	1800                	addi	s0,sp,48
    1100:	fca42e23          	sw	a0,-36(s0)
    uint8_t priority = thread->priority;
    1104:	fdc42783          	lw	a5,-36(s0)
    1108:	02c7c783          	lbu	a5,44(a5)
    110c:	fef407a3          	sb	a5,-17(s0)

    *(size_t *)((uint8_t *)(thread->stack_addr) + 0) = (size_t)thread->entry;
    1110:	fdc42783          	lw	a5,-36(s0)
    1114:	5398                	lw	a4,32(a5)
    1116:	fdc42783          	lw	a5,-36(s0)
    111a:	53dc                	lw	a5,36(a5)
    111c:	c398                	sw	a4,0(a5)
    *(size_t *)((uint8_t *)(thread->stack_addr) + 4) = (size_t)thread->sp;
    111e:	fdc42783          	lw	a5,-36(s0)
    1122:	4fd8                	lw	a4,28(a5)
    1124:	fdc42783          	lw	a5,-36(s0)
    1128:	53dc                	lw	a5,36(a5)
    112a:	0791                	addi	a5,a5,4
    112c:	c398                	sw	a4,0(a5)

    thread->prev = (MC_thread_t)&Ready_threadList_Start[priority];
    112e:	fef44783          	lbu	a5,-17(s0)
    1132:	00379713          	slli	a4,a5,0x3
    1136:	200007b7          	lui	a5,0x20000
    113a:	41c78793          	addi	a5,a5,1052 # 2000041c <Ready_threadList_Start>
    113e:	973e                	add	a4,a4,a5
    1140:	fdc42783          	lw	a5,-36(s0)
    1144:	c398                	sw	a4,0(a5)
    thread->next = Ready_threadList_Start[priority].next;
    1146:	fef44783          	lbu	a5,-17(s0)
    114a:	20000737          	lui	a4,0x20000
    114e:	41c70713          	addi	a4,a4,1052 # 2000041c <Ready_threadList_Start>
    1152:	078e                	slli	a5,a5,0x3
    1154:	97ba                	add	a5,a5,a4
    1156:	43d8                	lw	a4,4(a5)
    1158:	fdc42783          	lw	a5,-36(s0)
    115c:	c3d8                	sw	a4,4(a5)

    Ready_threadList_Start[priority].next = thread;
    115e:	fef44783          	lbu	a5,-17(s0)
    1162:	20000737          	lui	a4,0x20000
    1166:	41c70713          	addi	a4,a4,1052 # 2000041c <Ready_threadList_Start>
    116a:	078e                	slli	a5,a5,0x3
    116c:	97ba                	add	a5,a5,a4
    116e:	fdc42703          	lw	a4,-36(s0)
    1172:	c3d8                	sw	a4,4(a5)
    thread->next->prev = thread;
    1174:	fdc42783          	lw	a5,-36(s0)
    1178:	43dc                	lw	a5,4(a5)
    117a:	fdc42703          	lw	a4,-36(s0)
    117e:	c398                	sw	a4,0(a5)
    return 0;
    1180:	4781                	li	a5,0
}
    1182:	853e                	mv	a0,a5
    1184:	5432                	lw	s0,44(sp)
    1186:	6145                	addi	sp,sp,48
    1188:	8082                	ret

0000118a <MC_thread_yield>:

/**
 * 线程调度
*/
void MC_thread_yield()
{
    118a:	1141                	addi	sp,sp,-16
    118c:	c606                	sw	ra,12(sp)
    118e:	c422                	sw	s0,8(sp)
    1190:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_RUNNING)
    1192:	200007b7          	lui	a5,0x20000
    1196:	4147c703          	lbu	a4,1044(a5) # 20000414 <MC_scheduler>
    119a:	4785                	li	a5,1
    119c:	00f71463          	bne	a4,a5,11a4 <MC_thread_yield+0x1a>
    {
        MC_schedule();
    11a0:	3ee9                	jal	d7a <MC_schedule>
    }
    return;
    11a2:	0001                	nop
    11a4:	0001                	nop
    11a6:	40b2                	lw	ra,12(sp)
    11a8:	4422                	lw	s0,8(sp)
    11aa:	0141                	addi	sp,sp,16
    11ac:	8082                	ret

000011ae <MC_memcpy>:
#include "os.h"

void MC_memcpy(char *dst, char *src, int len)
{
    11ae:	7179                	addi	sp,sp,-48
    11b0:	d622                	sw	s0,44(sp)
    11b2:	1800                	addi	s0,sp,48
    11b4:	fca42e23          	sw	a0,-36(s0)
    11b8:	fcb42c23          	sw	a1,-40(s0)
    11bc:	fcc42a23          	sw	a2,-44(s0)
    if(dst == NULL || src == NULL || len <= 0)
    11c0:	fdc42783          	lw	a5,-36(s0)
    11c4:	cfa9                	beqz	a5,121e <MC_memcpy+0x70>
    11c6:	fd842783          	lw	a5,-40(s0)
    11ca:	cbb1                	beqz	a5,121e <MC_memcpy+0x70>
    11cc:	fd442783          	lw	a5,-44(s0)
    11d0:	04f05763          	blez	a5,121e <MC_memcpy+0x70>
        return;

    for(int i = 0; i < len; i++)
    11d4:	fe042623          	sw	zero,-20(s0)
    11d8:	a825                	j	1210 <MC_memcpy+0x62>
    {
        *(dst + i) = *(src + i);
    11da:	fec42783          	lw	a5,-20(s0)
    11de:	fd842703          	lw	a4,-40(s0)
    11e2:	973e                	add	a4,a4,a5
    11e4:	fec42783          	lw	a5,-20(s0)
    11e8:	fdc42683          	lw	a3,-36(s0)
    11ec:	97b6                	add	a5,a5,a3
    11ee:	00074703          	lbu	a4,0(a4)
    11f2:	00e78023          	sb	a4,0(a5)
        *(dst + i + 1) = '\0';
    11f6:	fec42783          	lw	a5,-20(s0)
    11fa:	0785                	addi	a5,a5,1
    11fc:	fdc42703          	lw	a4,-36(s0)
    1200:	97ba                	add	a5,a5,a4
    1202:	00078023          	sb	zero,0(a5)
    for(int i = 0; i < len; i++)
    1206:	fec42783          	lw	a5,-20(s0)
    120a:	0785                	addi	a5,a5,1
    120c:	fef42623          	sw	a5,-20(s0)
    1210:	fec42703          	lw	a4,-20(s0)
    1214:	fd442783          	lw	a5,-44(s0)
    1218:	fcf741e3          	blt	a4,a5,11da <MC_memcpy+0x2c>
    121c:	a011                	j	1220 <MC_memcpy+0x72>
        return;
    121e:	0001                	nop
    }
}
    1220:	5432                	lw	s0,44(sp)
    1222:	6145                	addi	sp,sp,48
    1224:	8082                	ret

00001226 <MC_strlen>:

size_t MC_strlen(char *src)
{
    1226:	7179                	addi	sp,sp,-48
    1228:	d622                	sw	s0,44(sp)
    122a:	1800                	addi	s0,sp,48
    122c:	fca42e23          	sw	a0,-36(s0)
    size_t len = 0;
    1230:	fe042623          	sw	zero,-20(s0)
    while(*src++) len++;
    1234:	a031                	j	1240 <MC_strlen+0x1a>
    1236:	fec42783          	lw	a5,-20(s0)
    123a:	0785                	addi	a5,a5,1
    123c:	fef42623          	sw	a5,-20(s0)
    1240:	fdc42783          	lw	a5,-36(s0)
    1244:	00178713          	addi	a4,a5,1
    1248:	fce42e23          	sw	a4,-36(s0)
    124c:	0007c783          	lbu	a5,0(a5)
    1250:	f3fd                	bnez	a5,1236 <MC_strlen+0x10>
    return len;
    1252:	fec42783          	lw	a5,-20(s0)
    1256:	853e                	mv	a0,a5
    1258:	5432                	lw	s0,44(sp)
    125a:	6145                	addi	sp,sp,48
    125c:	8082                	ret
	...

00001260 <r_mstatus>:
{
    1260:	1101                	addi	sp,sp,-32
    1262:	ce22                	sw	s0,28(sp)
    1264:	1000                	addi	s0,sp,32
	asm volatile("csrr %0, mstatus" : "=r" (x) );
    1266:	300027f3          	csrr	a5,mstatus
    126a:	fef42623          	sw	a5,-20(s0)
	return x;
    126e:	fec42783          	lw	a5,-20(s0)
}
    1272:	853e                	mv	a0,a5
    1274:	4472                	lw	s0,28(sp)
    1276:	6105                	addi	sp,sp,32
    1278:	8082                	ret
    127a:	0001                	nop

0000127c <w_mstatus>:
{
    127c:	1101                	addi	sp,sp,-32
    127e:	ce22                	sw	s0,28(sp)
    1280:	1000                	addi	s0,sp,32
    1282:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mstatus, %0" : : "r" (x));
    1286:	fec42783          	lw	a5,-20(s0)
    128a:	30079073          	csrw	mstatus,a5
}
    128e:	0001                	nop
    1290:	4472                	lw	s0,28(sp)
    1292:	6105                	addi	sp,sp,32
    1294:	8082                	ret
    1296:	0001                	nop

00001298 <w_mtvec>:

/* Machine-mode trap vector */
static inline __attribute__((aligned(4))) void w_mtvec(reg_t x)
{
    1298:	1101                	addi	sp,sp,-32
    129a:	ce22                	sw	s0,28(sp)
    129c:	1000                	addi	s0,sp,32
    129e:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mtvec, %0" : : "r" (x));
    12a2:	fec42783          	lw	a5,-20(s0)
    12a6:	30579073          	csrw	mtvec,a5
}
    12aa:	0001                	nop
    12ac:	4472                	lw	s0,28(sp)
    12ae:	6105                	addi	sp,sp,32
    12b0:	8082                	ret

000012b2 <__DISENABLE_INTERRUPT__>:
#include "os.h"
extern void trap_handler_base();

void __DISENABLE_INTERRUPT__()
{
    12b2:	1141                	addi	sp,sp,-16
    12b4:	c606                	sw	ra,12(sp)
    12b6:	c422                	sw	s0,8(sp)
    12b8:	0800                	addi	s0,sp,16
    w_mstatus(r_mstatus() & ~(1 << 3)); // 全局中断关闭
    12ba:	375d                	jal	1260 <r_mstatus>
    12bc:	87aa                	mv	a5,a0
    12be:	9bdd                	andi	a5,a5,-9
    12c0:	853e                	mv	a0,a5
    12c2:	3f6d                	jal	127c <w_mstatus>
}
    12c4:	0001                	nop
    12c6:	40b2                	lw	ra,12(sp)
    12c8:	4422                	lw	s0,8(sp)
    12ca:	0141                	addi	sp,sp,16
    12cc:	8082                	ret

000012ce <__ENABLE_INTERRUPT__>:

void __ENABLE_INTERRUPT__()
{
    12ce:	1141                	addi	sp,sp,-16
    12d0:	c606                	sw	ra,12(sp)
    12d2:	c422                	sw	s0,8(sp)
    12d4:	0800                	addi	s0,sp,16
    w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
    12d6:	3769                	jal	1260 <r_mstatus>
    12d8:	87aa                	mv	a5,a0
    12da:	0087e793          	ori	a5,a5,8
    12de:	853e                	mv	a0,a5
    12e0:	3f71                	jal	127c <w_mstatus>
}
    12e2:	0001                	nop
    12e4:	40b2                	lw	ra,12(sp)
    12e6:	4422                	lw	s0,8(sp)
    12e8:	0141                	addi	sp,sp,16
    12ea:	8082                	ret

000012ec <MC_trap_init>:

void MC_trap_init()
{
    12ec:	1101                	addi	sp,sp,-32
    12ee:	ce06                	sw	ra,28(sp)
    12f0:	cc22                	sw	s0,24(sp)
    12f2:	1000                	addi	s0,sp,32
    w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
    12f4:	37b5                	jal	1260 <r_mstatus>
    12f6:	87aa                	mv	a5,a0
    12f8:	0087e793          	ori	a5,a5,8
    12fc:	853e                	mv	a0,a5
    12fe:	3fbd                	jal	127c <w_mstatus>

    ptr_t base = (ptr_t)trap_handler_base;
    1300:	000007b7          	lui	a5,0x0
    1304:	05878793          	addi	a5,a5,88 # 58 <trap_handler_base>
    1308:	fef42623          	sw	a5,-20(s0)
    uint32_t mtvec = 0x00000001;
    130c:	4785                	li	a5,1
    130e:	fef42423          	sw	a5,-24(s0)
    mtvec |= (base);
    1312:	fe842703          	lw	a4,-24(s0)
    1316:	fec42783          	lw	a5,-20(s0)
    131a:	8fd9                	or	a5,a5,a4
    131c:	fef42423          	sw	a5,-24(s0)
    w_mtvec(mtvec);
    1320:	fe842503          	lw	a0,-24(s0)
    1324:	3f95                	jal	1298 <w_mtvec>
}
    1326:	0001                	nop
    1328:	40f2                	lw	ra,28(sp)
    132a:	4462                	lw	s0,24(sp)
    132c:	6105                	addi	sp,sp,32
    132e:	8082                	ret

00001330 <MC_mtip_handler>:

extern void MC_timer_handler();
void MC_mtip_handler()
{
    1330:	1141                	addi	sp,sp,-16
    1332:	c606                	sw	ra,12(sp)
    1334:	c422                	sw	s0,8(sp)
    1336:	0800                	addi	s0,sp,16
    MC_timer_handler();
    1338:	28f5                	jal	1434 <MC_timer_handler>
    133a:	0001                	nop
    133c:	40b2                	lw	ra,12(sp)
    133e:	4422                	lw	s0,8(sp)
    1340:	0141                	addi	sp,sp,16
    1342:	8082                	ret
	...

00001346 <MC_timer_load>:
#define TIMER_INTERVAL RTK_TIMEBASE_FREQ

static uint32_t _tick=0;

void MC_timer_load(int interval)
{
    1346:	7179                	addi	sp,sp,-48
    1348:	d622                	sw	s0,44(sp)
    134a:	1800                	addi	s0,sp,48
    134c:	fca42e23          	sw	a0,-36(s0)
    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    1350:	e000f537          	lui	a0,0xe000f
    1354:	fea42623          	sw	a0,-20(s0)
    uint64_t  mtime;

    mtime = ((uint64_t)(rtk_controller->CNTH) << 32) + rtk_controller->CNTL;
    1358:	fec42503          	lw	a0,-20(s0)
    135c:	4548                	lw	a0,12(a0)
    135e:	87aa                	mv	a5,a0
    1360:	4801                	li	a6,0
    1362:	00079713          	slli	a4,a5,0x0
    1366:	4681                	li	a3,0
    1368:	fec42783          	lw	a5,-20(s0)
    136c:	479c                	lw	a5,8(a5)
    136e:	833e                	mv	t1,a5
    1370:	4381                	li	t2,0
    1372:	006687b3          	add	a5,a3,t1
    1376:	853e                	mv	a0,a5
    1378:	00d53533          	sltu	a0,a0,a3
    137c:	00770833          	add	a6,a4,t2
    1380:	01050733          	add	a4,a0,a6
    1384:	883a                	mv	a6,a4
    1386:	fef42023          	sw	a5,-32(s0)
    138a:	ff042223          	sw	a6,-28(s0)
    mtime += interval;
    138e:	fdc42783          	lw	a5,-36(s0)
    1392:	85be                	mv	a1,a5
    1394:	87fd                	srai	a5,a5,0x1f
    1396:	863e                	mv	a2,a5
    1398:	fe042683          	lw	a3,-32(s0)
    139c:	fe442703          	lw	a4,-28(s0)
    13a0:	00b687b3          	add	a5,a3,a1
    13a4:	853e                	mv	a0,a5
    13a6:	00d53533          	sltu	a0,a0,a3
    13aa:	00c70833          	add	a6,a4,a2
    13ae:	01050733          	add	a4,a0,a6
    13b2:	883a                	mv	a6,a4
    13b4:	fef42023          	sw	a5,-32(s0)
    13b8:	ff042223          	sw	a6,-28(s0)
    rtk_controller->CMPHR = (uint32_t)(mtime >> 32);
    13bc:	fe442783          	lw	a5,-28(s0)
    13c0:	0007de13          	srli	t3,a5,0x0
    13c4:	4e81                	li	t4,0
    13c6:	8772                	mv	a4,t3
    13c8:	fec42783          	lw	a5,-20(s0)
    13cc:	cbd8                	sw	a4,20(a5)
    rtk_controller->CMPLR = (uint32_t)(mtime & 0xffffffff);
    13ce:	fe042703          	lw	a4,-32(s0)
    13d2:	fec42783          	lw	a5,-20(s0)
    13d6:	cb98                	sw	a4,16(a5)

    rtk_controller->CTRL = 0x00000007;
    13d8:	fec42783          	lw	a5,-20(s0)
    13dc:	471d                	li	a4,7
    13de:	c398                	sw	a4,0(a5)
}
    13e0:	0001                	nop
    13e2:	5432                	lw	s0,44(sp)
    13e4:	6145                	addi	sp,sp,48
    13e6:	8082                	ret

000013e8 <MC_timer_init>:

void MC_timer_init()
{
    13e8:	1101                	addi	sp,sp,-32
    13ea:	ce06                	sw	ra,28(sp)
    13ec:	cc22                	sw	s0,24(sp)
    13ee:	1000                	addi	s0,sp,32
    PFIC_IENR_t pfic_ienr = (PFIC_IENR_t)PFIC_IENR_BASE;
    13f0:	e000e7b7          	lui	a5,0xe000e
    13f4:	10078793          	addi	a5,a5,256 # e000e100 <_end_stack+0xbfffe100>
    13f8:	fef42623          	sw	a5,-20(s0)
    pfic_ienr->IENRx[0] |= 1 << SYS_TICK_IRQ;//使能systick中断
    13fc:	fec42783          	lw	a5,-20(s0)
    1400:	4398                	lw	a4,0(a5)
    1402:	6785                	lui	a5,0x1
    1404:	8f5d                	or	a4,a4,a5
    1406:	fec42783          	lw	a5,-20(s0)
    140a:	c398                	sw	a4,0(a5)

    MC_timer_load(TIMER_INTERVAL);
    140c:	6789                	lui	a5,0x2
    140e:	f4078513          	addi	a0,a5,-192 # 1f40 <_data_lma+0x9dc>
    1412:	3f15                	jal	1346 <MC_timer_load>
}
    1414:	0001                	nop
    1416:	40f2                	lw	ra,28(sp)
    1418:	4462                	lw	s0,24(sp)
    141a:	6105                	addi	sp,sp,32
    141c:	8082                	ret

0000141e <MC_get_tick>:

uint32_t MC_get_tick()
{
    141e:	1141                	addi	sp,sp,-16
    1420:	c622                	sw	s0,12(sp)
    1422:	0800                	addi	s0,sp,16
    return _tick;
    1424:	200007b7          	lui	a5,0x20000
    1428:	3f47a783          	lw	a5,1012(a5) # 200003f4 <_tick>
}
    142c:	853e                	mv	a0,a5
    142e:	4432                	lw	s0,12(sp)
    1430:	0141                	addi	sp,sp,16
    1432:	8082                	ret

00001434 <MC_timer_handler>:

void MC_timer_handler() 
{
    1434:	1101                	addi	sp,sp,-32
    1436:	ce06                	sw	ra,28(sp)
    1438:	cc22                	sw	s0,24(sp)
    143a:	1000                	addi	s0,sp,32
	_tick++;
    143c:	200007b7          	lui	a5,0x20000
    1440:	3f47a783          	lw	a5,1012(a5) # 200003f4 <_tick>
    1444:	00178713          	addi	a4,a5,1
    1448:	200007b7          	lui	a5,0x20000
    144c:	3ee7aa23          	sw	a4,1012(a5) # 200003f4 <_tick>
    // if(_tick % 1000 == 0)
	//     printf("tick: %d\r\n", _tick / 1000);
    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    1450:	e000f7b7          	lui	a5,0xe000f
    1454:	fef42623          	sw	a5,-20(s0)
    rtk_controller->SR = 0;
    1458:	fec42783          	lw	a5,-20(s0)
    145c:	0007a223          	sw	zero,4(a5) # e000f004 <_end_stack+0xbffff004>
	MC_timer_load(TIMER_INTERVAL);
    1460:	6789                	lui	a5,0x2
    1462:	f4078513          	addi	a0,a5,-192 # 1f40 <_data_lma+0x9dc>
    1466:	35c5                	jal	1346 <MC_timer_load>
    1468:	0001                	nop
    146a:	40f2                	lw	ra,28(sp)
    146c:	4462                	lw	s0,24(sp)
    146e:	6105                	addi	sp,sp,32
    1470:	8082                	ret
