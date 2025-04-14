
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
       8:	00002517          	auipc	a0,0x2
       c:	bac50513          	addi	a0,a0,-1108 # 1bb4 <_data_lma>
    la a1, _data_vma
      10:	20000597          	auipc	a1,0x20000
      14:	ff058593          	addi	a1,a1,-16 # 20000000 <_data_vma>
    la a2, _data_end
      18:	20000617          	auipc	a2,0x20000
      1c:	00860613          	addi	a2,a2,8 # 20000020 <_data_end>
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
      38:	fec50513          	addi	a0,a0,-20 # 20000020 <_data_end>
    la a1, _end_bss
      3c:	20001597          	auipc	a1,0x20001
      40:	80858593          	addi	a1,a1,-2040 # 20000844 <_end_bss>
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
      52:	3900006f          	j	3e2 <start_kernel>
	...

00000058 <trap_handler_base>:
.global trap_handler_base
.balign 8

trap_handler_base:
    .balign 4
    j   exception_handler     /*exception entry*/
      58:	a82d                	j	92 <exception_handler>
      5a:	0001                	nop
    .balign 4
    j   irq_default_handler /*1 : Reserved*/
      5c:	aca1                	j	2b4 <irq_default_handler>
      5e:	0001                	nop
    .balign 4
    j   irq_default_handler /*2 : Reserved*/
      60:	ac91                	j	2b4 <irq_default_handler>
      62:	0001                	nop
    .balign 4
    j   irq_default_handler /*3 : Reserved*/
      64:	ac81                	j	2b4 <irq_default_handler>
      66:	0001                	nop
    .balign 4
    j   irq_default_handler /*4 : Reserved*/
      68:	a4b1                	j	2b4 <irq_default_handler>
      6a:	0001                	nop
    .balign 4
    j   irq_default_handler /*5 : Reserved*/
      6c:	a4a1                	j	2b4 <irq_default_handler>
      6e:	0001                	nop
    .balign 4
    j   irq_default_handler /*6 : Reserved*/
      70:	a491                	j	2b4 <irq_default_handler>
      72:	0001                	nop
    .balign 4
    j   irq_default_handler /*7 : Reserved*/
      74:	a481                	j	2b4 <irq_default_handler>
      76:	0001                	nop
    .balign 4
    j   irq_default_handler /*8 : Reserved*/
      78:	ac35                	j	2b4 <irq_default_handler>
      7a:	0001                	nop
    .balign 4
    j   irq_default_handler /*9 : Reserved*/
      7c:	ac25                	j	2b4 <irq_default_handler>
      7e:	0001                	nop
    .balign 4
    j   irq_default_handler /*10 : Reserved*/
      80:	ac15                	j	2b4 <irq_default_handler>
      82:	0001                	nop
    .balign 4
    j   irq_default_handler /*11 : Reserved*/
      84:	ac05                	j	2b4 <irq_default_handler>
      86:	0001                	nop
    .balign 4
    j   pfic_systick_handler /*12 : Machine timer interrupt*/
      88:	a031                	j	94 <pfic_systick_handler>
      8a:	0001                	nop
	.balign 4
    j   pfic_systick_handler /*13 : Reserved*/
      8c:	a021                	j	94 <pfic_systick_handler>
      8e:	0001                	nop
	.balign 4
    j   pfic_software_handler /*14 : Machine software interrupt*/
      90:	aa11                	j	1a4 <pfic_software_handler>

00000092 <exception_handler>:

exception_handler:
    j exception_handler
      92:	a001                	j	92 <exception_handler>

00000094 <pfic_systick_handler>:

pfic_systick_handler:
    csrrw t6, mscratch, t6
      94:	340f9ff3          	csrrw	t6,mscratch,t6
    reg_save t6
      98:	001fa023          	sw	ra,0(t6)
      9c:	002fa223          	sw	sp,4(t6)
      a0:	005fa823          	sw	t0,16(t6)
      a4:	006faa23          	sw	t1,20(t6)
      a8:	007fac23          	sw	t2,24(t6)
      ac:	008fae23          	sw	s0,28(t6)
      b0:	029fa023          	sw	s1,32(t6)
      b4:	02afa223          	sw	a0,36(t6)
      b8:	02bfa423          	sw	a1,40(t6)
      bc:	02cfa623          	sw	a2,44(t6)
      c0:	02dfa823          	sw	a3,48(t6)
      c4:	02efaa23          	sw	a4,52(t6)
      c8:	02ffac23          	sw	a5,56(t6)
      cc:	030fae23          	sw	a6,60(t6)
      d0:	051fa023          	sw	a7,64(t6)
      d4:	052fa223          	sw	s2,68(t6)
      d8:	053fa423          	sw	s3,72(t6)
      dc:	054fa623          	sw	s4,76(t6)
      e0:	055fa823          	sw	s5,80(t6)
      e4:	056faa23          	sw	s6,84(t6)
      e8:	057fac23          	sw	s7,88(t6)
      ec:	058fae23          	sw	s8,92(t6)
      f0:	079fa023          	sw	s9,96(t6)
      f4:	07afa223          	sw	s10,100(t6)
      f8:	07bfa423          	sw	s11,104(t6)
      fc:	07cfa623          	sw	t3,108(t6)
     100:	07dfa823          	sw	t4,112(t6)
     104:	07efaa23          	sw	t5,116(t6)

    mv t5, t6
     108:	8f7e                	mv	t5,t6
    csrr t6, mscratch
     10a:	34002ff3          	csrr	t6,mscratch
    STORE t6, 30 * SIZE_REG(t5)
     10e:	07ff2c23          	sw	t6,120(t5)

	csrr t6, mepc
     112:	34102ff3          	csrr	t6,mepc
	STORE t6, 2 * SIZE_REG(t5)
     116:	01ff2423          	sw	t6,8(t5)
    csrw mscratch, t5
     11a:	340f1073          	csrw	mscratch,t5

    jal MC_mtip_handler
     11e:	352010ef          	jal	ra,1470 <MC_mtip_handler>
	csrr t6, mscratch
     122:	34002ff3          	csrr	t6,mscratch

	LOAD t5, 2 * SIZE_REG(t6)
     126:	008faf03          	lw	t5,8(t6)
	csrw mepc, t5
     12a:	341f1073          	csrw	mepc,t5
    reg_restore t6
     12e:	000fa083          	lw	ra,0(t6)
     132:	004fa103          	lw	sp,4(t6)
     136:	010fa283          	lw	t0,16(t6)
     13a:	014fa303          	lw	t1,20(t6)
     13e:	018fa383          	lw	t2,24(t6)
     142:	01cfa403          	lw	s0,28(t6)
     146:	020fa483          	lw	s1,32(t6)
     14a:	024fa503          	lw	a0,36(t6)
     14e:	028fa583          	lw	a1,40(t6)
     152:	02cfa603          	lw	a2,44(t6)
     156:	030fa683          	lw	a3,48(t6)
     15a:	034fa703          	lw	a4,52(t6)
     15e:	038fa783          	lw	a5,56(t6)
     162:	03cfa803          	lw	a6,60(t6)
     166:	040fa883          	lw	a7,64(t6)
     16a:	044fa903          	lw	s2,68(t6)
     16e:	048fa983          	lw	s3,72(t6)
     172:	04cfaa03          	lw	s4,76(t6)
     176:	050faa83          	lw	s5,80(t6)
     17a:	054fab03          	lw	s6,84(t6)
     17e:	058fab83          	lw	s7,88(t6)
     182:	05cfac03          	lw	s8,92(t6)
     186:	060fac83          	lw	s9,96(t6)
     18a:	064fad03          	lw	s10,100(t6)
     18e:	068fad83          	lw	s11,104(t6)
     192:	06cfae03          	lw	t3,108(t6)
     196:	070fae83          	lw	t4,112(t6)
     19a:	074faf03          	lw	t5,116(t6)
     19e:	078faf83          	lw	t6,120(t6)

    j return_from_interrupt
     1a2:	aa11                	j	2b6 <return_from_interrupt>

000001a4 <pfic_software_handler>:

pfic_software_handler:
	csrrw t6, mscratch, t6
     1a4:	340f9ff3          	csrrw	t6,mscratch,t6
    reg_save t6
     1a8:	001fa023          	sw	ra,0(t6)
     1ac:	002fa223          	sw	sp,4(t6)
     1b0:	005fa823          	sw	t0,16(t6)
     1b4:	006faa23          	sw	t1,20(t6)
     1b8:	007fac23          	sw	t2,24(t6)
     1bc:	008fae23          	sw	s0,28(t6)
     1c0:	029fa023          	sw	s1,32(t6)
     1c4:	02afa223          	sw	a0,36(t6)
     1c8:	02bfa423          	sw	a1,40(t6)
     1cc:	02cfa623          	sw	a2,44(t6)
     1d0:	02dfa823          	sw	a3,48(t6)
     1d4:	02efaa23          	sw	a4,52(t6)
     1d8:	02ffac23          	sw	a5,56(t6)
     1dc:	030fae23          	sw	a6,60(t6)
     1e0:	051fa023          	sw	a7,64(t6)
     1e4:	052fa223          	sw	s2,68(t6)
     1e8:	053fa423          	sw	s3,72(t6)
     1ec:	054fa623          	sw	s4,76(t6)
     1f0:	055fa823          	sw	s5,80(t6)
     1f4:	056faa23          	sw	s6,84(t6)
     1f8:	057fac23          	sw	s7,88(t6)
     1fc:	058fae23          	sw	s8,92(t6)
     200:	079fa023          	sw	s9,96(t6)
     204:	07afa223          	sw	s10,100(t6)
     208:	07bfa423          	sw	s11,104(t6)
     20c:	07cfa623          	sw	t3,108(t6)
     210:	07dfa823          	sw	t4,112(t6)
     214:	07efaa23          	sw	t5,116(t6)

    mv t5, t6
     218:	8f7e                	mv	t5,t6
    csrr t6, mscratch
     21a:	34002ff3          	csrr	t6,mscratch
    STORE t6, 30 * SIZE_REG(t5)
     21e:	07ff2c23          	sw	t6,120(t5)

	csrr t6, mepc
     222:	34102ff3          	csrr	t6,mepc
	STORE t6, 2 * SIZE_REG(t5)
     226:	01ff2423          	sw	t6,8(t5)
    csrw mscratch, t5
     22a:	340f1073          	csrw	mscratch,t5

    jal MC_software_handler
     22e:	256010ef          	jal	ra,1484 <MC_software_handler>
	csrr t6, mscratch
     232:	34002ff3          	csrr	t6,mscratch

	LOAD t5, 2 * SIZE_REG(t6)
     236:	008faf03          	lw	t5,8(t6)
	csrw mepc, t5
     23a:	341f1073          	csrw	mepc,t5
    reg_restore t6
     23e:	000fa083          	lw	ra,0(t6)
     242:	004fa103          	lw	sp,4(t6)
     246:	010fa283          	lw	t0,16(t6)
     24a:	014fa303          	lw	t1,20(t6)
     24e:	018fa383          	lw	t2,24(t6)
     252:	01cfa403          	lw	s0,28(t6)
     256:	020fa483          	lw	s1,32(t6)
     25a:	024fa503          	lw	a0,36(t6)
     25e:	028fa583          	lw	a1,40(t6)
     262:	02cfa603          	lw	a2,44(t6)
     266:	030fa683          	lw	a3,48(t6)
     26a:	034fa703          	lw	a4,52(t6)
     26e:	038fa783          	lw	a5,56(t6)
     272:	03cfa803          	lw	a6,60(t6)
     276:	040fa883          	lw	a7,64(t6)
     27a:	044fa903          	lw	s2,68(t6)
     27e:	048fa983          	lw	s3,72(t6)
     282:	04cfaa03          	lw	s4,76(t6)
     286:	050faa83          	lw	s5,80(t6)
     28a:	054fab03          	lw	s6,84(t6)
     28e:	058fab83          	lw	s7,88(t6)
     292:	05cfac03          	lw	s8,92(t6)
     296:	060fac83          	lw	s9,96(t6)
     29a:	064fad03          	lw	s10,100(t6)
     29e:	068fad83          	lw	s11,104(t6)
     2a2:	06cfae03          	lw	t3,108(t6)
     2a6:	070fae83          	lw	t4,112(t6)
     2aa:	074faf03          	lw	t5,116(t6)
     2ae:	078faf83          	lw	t6,120(t6)
	j return_from_interrupt
     2b2:	a011                	j	2b6 <return_from_interrupt>

000002b4 <irq_default_handler>:

irq_default_handler:
    j irq_default_handler
     2b4:	a001                	j	2b4 <irq_default_handler>

000002b6 <return_from_interrupt>:

return_from_interrupt:
    mret
     2b6:	30200073          	mret
     2ba:	0000                	unimp
     2bc:	0000                	unimp
	...

000002c0 <MC_hw_context_switch>:

.global MC_hw_context_switch
.balign 4

MC_hw_context_switch:
    csrrw t6, mscratch, t6
     2c0:	340f9ff3          	csrrw	t6,mscratch,t6
	j 1f
     2c4:	a041                	j	344 <MC_hw_context_switch+0x84>
    beqz t6, 1f
     2c6:	060f8f63          	beqz	t6,344 <MC_hw_context_switch+0x84>

    reg_save t6
     2ca:	001fa023          	sw	ra,0(t6)
     2ce:	002fa223          	sw	sp,4(t6)
     2d2:	005fa823          	sw	t0,16(t6)
     2d6:	006faa23          	sw	t1,20(t6)
     2da:	007fac23          	sw	t2,24(t6)
     2de:	008fae23          	sw	s0,28(t6)
     2e2:	029fa023          	sw	s1,32(t6)
     2e6:	02afa223          	sw	a0,36(t6)
     2ea:	02bfa423          	sw	a1,40(t6)
     2ee:	02cfa623          	sw	a2,44(t6)
     2f2:	02dfa823          	sw	a3,48(t6)
     2f6:	02efaa23          	sw	a4,52(t6)
     2fa:	02ffac23          	sw	a5,56(t6)
     2fe:	030fae23          	sw	a6,60(t6)
     302:	051fa023          	sw	a7,64(t6)
     306:	052fa223          	sw	s2,68(t6)
     30a:	053fa423          	sw	s3,72(t6)
     30e:	054fa623          	sw	s4,76(t6)
     312:	055fa823          	sw	s5,80(t6)
     316:	056faa23          	sw	s6,84(t6)
     31a:	057fac23          	sw	s7,88(t6)
     31e:	058fae23          	sw	s8,92(t6)
     322:	079fa023          	sw	s9,96(t6)
     326:	07afa223          	sw	s10,100(t6)
     32a:	07bfa423          	sw	s11,104(t6)
     32e:	07cfa623          	sw	t3,108(t6)
     332:	07dfa823          	sw	t4,112(t6)
     336:	07efaa23          	sw	t5,116(t6)
    mv t5, t6
     33a:	8f7e                	mv	t5,t6
    csrr t6, mscratch
     33c:	34002ff3          	csrr	t6,mscratch
    STORE t6, 30*SIZE_REG(t5)
     340:	07ff2c23          	sw	t6,120(t5)

1:
    csrw mscratch, a0
     344:	34051073          	csrw	mscratch,a0
    mv t6, a0
     348:	8faa                	mv	t6,a0
    reg_restore t6
     34a:	000fa083          	lw	ra,0(t6)
     34e:	004fa103          	lw	sp,4(t6)
     352:	010fa283          	lw	t0,16(t6)
     356:	014fa303          	lw	t1,20(t6)
     35a:	018fa383          	lw	t2,24(t6)
     35e:	01cfa403          	lw	s0,28(t6)
     362:	020fa483          	lw	s1,32(t6)
     366:	024fa503          	lw	a0,36(t6)
     36a:	028fa583          	lw	a1,40(t6)
     36e:	02cfa603          	lw	a2,44(t6)
     372:	030fa683          	lw	a3,48(t6)
     376:	034fa703          	lw	a4,52(t6)
     37a:	038fa783          	lw	a5,56(t6)
     37e:	03cfa803          	lw	a6,60(t6)
     382:	040fa883          	lw	a7,64(t6)
     386:	044fa903          	lw	s2,68(t6)
     38a:	048fa983          	lw	s3,72(t6)
     38e:	04cfaa03          	lw	s4,76(t6)
     392:	050faa83          	lw	s5,80(t6)
     396:	054fab03          	lw	s6,84(t6)
     39a:	058fab83          	lw	s7,88(t6)
     39e:	05cfac03          	lw	s8,92(t6)
     3a2:	060fac83          	lw	s9,96(t6)
     3a6:	064fad03          	lw	s10,100(t6)
     3aa:	068fad83          	lw	s11,104(t6)
     3ae:	06cfae03          	lw	t3,108(t6)
     3b2:	070fae83          	lw	t4,112(t6)
     3b6:	074faf03          	lw	t5,116(t6)
     3ba:	078faf83          	lw	t6,120(t6)
	csrw mepc, ra
     3be:	34109073          	csrw	mepc,ra

    mret
     3c2:	30200073          	mret
	...

000003c8 <w_mstatus>:
	asm volatile("csrr %0, mstatus" : "=r" (x) );
	return x;
}

static inline __attribute__((aligned(4))) void w_mstatus(reg_t x)
{
     3c8:	1101                	addi	sp,sp,-32
     3ca:	ce22                	sw	s0,28(sp)
     3cc:	1000                	addi	s0,sp,32
     3ce:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mstatus, %0" : : "r" (x));
     3d2:	fec42783          	lw	a5,-20(s0)
     3d6:	30079073          	csrw	mstatus,a5
}
     3da:	0001                	nop
     3dc:	4472                	lw	s0,28(sp)
     3de:	6105                	addi	sp,sp,32
     3e0:	8082                	ret

000003e2 <start_kernel>:
MC_thread_t os_main;

extern int main();

void start_kernel()
{
     3e2:	1141                	addi	sp,sp,-16
     3e4:	c606                	sw	ra,12(sp)
     3e6:	c422                	sw	s0,8(sp)
     3e8:	0800                	addi	s0,sp,16
    USART1_init();
     3ea:	2889                	jal	43c <USART1_init>

    os_main = MC_thread_create("os_main",
     3ec:	4789                	li	a5,2
     3ee:	06400713          	li	a4,100
     3f2:	03f00693          	li	a3,63
     3f6:	20000613          	li	a2,512
     3fa:	000025b7          	lui	a1,0x2
     3fe:	96a58593          	addi	a1,a1,-1686 # 196a <main>
     402:	6509                	lui	a0,0x2
     404:	ac450513          	addi	a0,a0,-1340 # 1ac4 <STACK_END+0x4>
     408:	53b000ef          	jal	ra,1142 <MC_thread_create>
     40c:	872a                	mv	a4,a0
     40e:	200007b7          	lui	a5,0x20000
     412:	40e7ac23          	sw	a4,1048(a5) # 20000418 <os_main>
                            main,
                            512,
                            63,
                            100,
                            MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(os_main);
     416:	200007b7          	lui	a5,0x20000
     41a:	4187a783          	lw	a5,1048(a5) # 20000418 <os_main>
     41e:	853e                	mv	a0,a5
     420:	60b000ef          	jal	ra,122a <MC_thread_startup>

    MC_trap_init();
     424:	014010ef          	jal	ra,1438 <MC_trap_init>
    MC_SysTick_init();
     428:	352010ef          	jal	ra,177a <MC_SysTick_init>
    
    w_mstatus(0b11 << 11);//进入main为机器模式
     42c:	6789                	lui	a5,0x2
     42e:	80078513          	addi	a0,a5,-2048 # 1800 <MC_timer_realse+0x2a>
     432:	3f59                	jal	3c8 <w_mstatus>
    
    /**
     * 因为此时还没开启中断，所以不通过
     * pendsv的形式进行上下文切换
     */
    MC_schedule(); 
     434:	1fb000ef          	jal	ra,e2e <MC_schedule>
    while(1)
     438:	a001                	j	438 <start_kernel+0x56>
	...

0000043c <USART1_init>:
    CFGHR = 1,
    INDR = 2,
    OUTDR = 3,
}_GPIOA_REG;
void USART1_init()
{
     43c:	1101                	addi	sp,sp,-32
     43e:	ce22                	sw	s0,28(sp)
     440:	1000                	addi	s0,sp,32
    while((RCC_REG_R(CTLR) & (1<<1)) == 0)continue;
     442:	a011                	j	446 <USART1_init+0xa>
     444:	0001                	nop
     446:	400217b7          	lui	a5,0x40021
     44a:	439c                	lw	a5,0(a5)
     44c:	8b89                	andi	a5,a5,2
     44e:	dbfd                	beqz	a5,444 <USART1_init+0x8>
    uint32_t  x = (RCC_REG_R(APB2PCENR)) | (1<<14) | (1<<2);
     450:	400217b7          	lui	a5,0x40021
     454:	07e1                	addi	a5,a5,24
     456:	4398                	lw	a4,0(a5)
     458:	6791                	lui	a5,0x4
     45a:	0791                	addi	a5,a5,4
     45c:	8fd9                	or	a5,a5,a4
     45e:	fef42623          	sw	a5,-20(s0)
    RCC_REG_W(APB2PCENR,x);
     462:	400217b7          	lui	a5,0x40021
     466:	07e1                	addi	a5,a5,24
     468:	fec42703          	lw	a4,-20(s0)
     46c:	c398                	sw	a4,0(a5)

    x = ((GPIOA_REG_R(CFGHR) & ~(0b1111<<4)) | (uint32_t)(0b1011<<4));
     46e:	400117b7          	lui	a5,0x40011
     472:	80478793          	addi	a5,a5,-2044 # 40010804 <_end_stack+0x20000804>
     476:	439c                	lw	a5,0(a5)
     478:	f0f7f793          	andi	a5,a5,-241
     47c:	0b07e793          	ori	a5,a5,176
     480:	fef42623          	sw	a5,-20(s0)
    GPIOA_REG_W(CFGHR,x);
     484:	400117b7          	lui	a5,0x40011
     488:	80478793          	addi	a5,a5,-2044 # 40010804 <_end_stack+0x20000804>
     48c:	fec42703          	lw	a4,-20(s0)
     490:	c398                	sw	a4,0(a5)

    x = (USART1_REG_R(BRR) | (uint16_t)0b1000101);
     492:	400147b7          	lui	a5,0x40014
     496:	80878793          	addi	a5,a5,-2040 # 40013808 <_end_stack+0x20003808>
     49a:	439c                	lw	a5,0(a5)
     49c:	0457e793          	ori	a5,a5,69
     4a0:	fef42623          	sw	a5,-20(s0)
    USART1_REG_W(BRR,(uint16_t)x);
     4a4:	fec42783          	lw	a5,-20(s0)
     4a8:	01079713          	slli	a4,a5,0x10
     4ac:	8341                	srli	a4,a4,0x10
     4ae:	400147b7          	lui	a5,0x40014
     4b2:	80878793          	addi	a5,a5,-2040 # 40013808 <_end_stack+0x20003808>
     4b6:	c398                	sw	a4,0(a5)

    x = (USART1_REG_R(CTLR1) | 0X0000200C);
     4b8:	400147b7          	lui	a5,0x40014
     4bc:	80c78793          	addi	a5,a5,-2036 # 4001380c <_end_stack+0x2000380c>
     4c0:	4398                	lw	a4,0(a5)
     4c2:	6789                	lui	a5,0x2
     4c4:	07b1                	addi	a5,a5,12
     4c6:	8fd9                	or	a5,a5,a4
     4c8:	fef42623          	sw	a5,-20(s0)
    USART1_REG_W(CTLR1,(uint32_t)x);
     4cc:	400147b7          	lui	a5,0x40014
     4d0:	80c78793          	addi	a5,a5,-2036 # 4001380c <_end_stack+0x2000380c>
     4d4:	fec42703          	lw	a4,-20(s0)
     4d8:	c398                	sw	a4,0(a5)
}
     4da:	0001                	nop
     4dc:	4472                	lw	s0,28(sp)
     4de:	6105                	addi	sp,sp,32
     4e0:	8082                	ret

000004e2 <putc>:

void putc(uint8_t c)
{
     4e2:	1101                	addi	sp,sp,-32
     4e4:	ce22                	sw	s0,28(sp)
     4e6:	1000                	addi	s0,sp,32
     4e8:	87aa                	mv	a5,a0
     4ea:	fef407a3          	sb	a5,-17(s0)
    USART1_REG_W(DATAR,c);
     4ee:	400147b7          	lui	a5,0x40014
     4f2:	80478793          	addi	a5,a5,-2044 # 40013804 <_end_stack+0x20003804>
     4f6:	fef44703          	lbu	a4,-17(s0)
     4fa:	c398                	sw	a4,0(a5)
}
     4fc:	0001                	nop
     4fe:	4472                	lw	s0,28(sp)
     500:	6105                	addi	sp,sp,32
     502:	8082                	ret

00000504 <puts>:
void puts(uint8_t *s)
{
     504:	1101                	addi	sp,sp,-32
     506:	ce06                	sw	ra,28(sp)
     508:	cc22                	sw	s0,24(sp)
     50a:	1000                	addi	s0,sp,32
     50c:	fea42623          	sw	a0,-20(s0)
    __DISENABLE_INTERRUPT__();
     510:	6ef000ef          	jal	ra,13fe <__DISENABLE_INTERRUPT__>
    while(*s)
     514:	a02d                	j	53e <puts+0x3a>
    {
        
        putc(*s++);
     516:	fec42783          	lw	a5,-20(s0)
     51a:	00178713          	addi	a4,a5,1
     51e:	fee42623          	sw	a4,-20(s0)
     522:	0007c783          	lbu	a5,0(a5)
     526:	853e                	mv	a0,a5
     528:	3f6d                	jal	4e2 <putc>
        while((USART1_REG_R(STATR) & (1<<7)) == 0)continue;
     52a:	a011                	j	52e <puts+0x2a>
     52c:	0001                	nop
     52e:	400147b7          	lui	a5,0x40014
     532:	80078793          	addi	a5,a5,-2048 # 40013800 <_end_stack+0x20003800>
     536:	439c                	lw	a5,0(a5)
     538:	0807f793          	andi	a5,a5,128
     53c:	dbe5                	beqz	a5,52c <puts+0x28>
    while(*s)
     53e:	fec42783          	lw	a5,-20(s0)
     542:	0007c783          	lbu	a5,0(a5)
     546:	fbe1                	bnez	a5,516 <puts+0x12>
       
    }
    __ENABLE_INTERRUPT__();
     548:	6d3000ef          	jal	ra,141a <__ENABLE_INTERRUPT__>
}
     54c:	0001                	nop
     54e:	40f2                	lw	ra,28(sp)
     550:	4462                	lw	s0,24(sp)
     552:	6105                	addi	sp,sp,32
     554:	8082                	ret

00000556 <MC_InsertFreeBlock>:
#define HEAP_MINMUM_SIZE ((size_t) (Block_Size << 1))

void MC_PageInit(void);

static void MC_InsertFreeBlock(BlockLink_t *New_Block)
{
     556:	7179                	addi	sp,sp,-48
     558:	d622                	sw	s0,44(sp)
     55a:	1800                	addi	s0,sp,48
     55c:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *BlockIterator;
    uint8_t *BlockOperator;
    for(BlockIterator = &Block_Start; BlockIterator->MC_NextFreeBlock < New_Block; BlockIterator = BlockIterator->MC_NextFreeBlock)
     560:	200007b7          	lui	a5,0x20000
     564:	42478793          	addi	a5,a5,1060 # 20000424 <Block_Start>
     568:	fef42623          	sw	a5,-20(s0)
     56c:	a031                	j	578 <MC_InsertFreeBlock+0x22>
     56e:	fec42783          	lw	a5,-20(s0)
     572:	439c                	lw	a5,0(a5)
     574:	fef42623          	sw	a5,-20(s0)
     578:	fec42783          	lw	a5,-20(s0)
     57c:	439c                	lw	a5,0(a5)
     57e:	fdc42703          	lw	a4,-36(s0)
     582:	fee7e6e3          	bltu	a5,a4,56e <MC_InsertFreeBlock+0x18>
    {}
    
    BlockOperator = BlockIterator;
     586:	fec42783          	lw	a5,-20(s0)
     58a:	fef42423          	sw	a5,-24(s0)

    if(BlockOperator + BlockIterator->MC_BlockSize == (uint8_t *)New_Block)
     58e:	fec42783          	lw	a5,-20(s0)
     592:	43dc                	lw	a5,4(a5)
     594:	fe842703          	lw	a4,-24(s0)
     598:	97ba                	add	a5,a5,a4
     59a:	fdc42703          	lw	a4,-36(s0)
     59e:	02f71063          	bne	a4,a5,5be <MC_InsertFreeBlock+0x68>
    {
        BlockIterator->MC_BlockSize += New_Block->MC_BlockSize;
     5a2:	fec42783          	lw	a5,-20(s0)
     5a6:	43d8                	lw	a4,4(a5)
     5a8:	fdc42783          	lw	a5,-36(s0)
     5ac:	43dc                	lw	a5,4(a5)
     5ae:	973e                	add	a4,a4,a5
     5b0:	fec42783          	lw	a5,-20(s0)
     5b4:	c3d8                	sw	a4,4(a5)
        New_Block = BlockIterator;
     5b6:	fec42783          	lw	a5,-20(s0)
     5ba:	fcf42e23          	sw	a5,-36(s0)
    }else{}

    BlockOperator = (uint8_t *)New_Block;
     5be:	fdc42783          	lw	a5,-36(s0)
     5c2:	fef42423          	sw	a5,-24(s0)
    if(BlockOperator + New_Block->MC_BlockSize == (uint8_t *)BlockIterator->MC_NextFreeBlock)
     5c6:	fdc42783          	lw	a5,-36(s0)
     5ca:	43dc                	lw	a5,4(a5)
     5cc:	fe842703          	lw	a4,-24(s0)
     5d0:	973e                	add	a4,a4,a5
     5d2:	fec42783          	lw	a5,-20(s0)
     5d6:	439c                	lw	a5,0(a5)
     5d8:	04f71663          	bne	a4,a5,624 <MC_InsertFreeBlock+0xce>
    {
        if(BlockIterator->MC_NextFreeBlock != Block_End)
     5dc:	fec42783          	lw	a5,-20(s0)
     5e0:	4398                	lw	a4,0(a5)
     5e2:	200007b7          	lui	a5,0x20000
     5e6:	42c7a783          	lw	a5,1068(a5) # 2000042c <Block_End>
     5ea:	02f70563          	beq	a4,a5,614 <MC_InsertFreeBlock+0xbe>
        {
            New_Block->MC_BlockSize += BlockIterator->MC_NextFreeBlock->MC_BlockSize;
     5ee:	fdc42783          	lw	a5,-36(s0)
     5f2:	43d8                	lw	a4,4(a5)
     5f4:	fec42783          	lw	a5,-20(s0)
     5f8:	439c                	lw	a5,0(a5)
     5fa:	43dc                	lw	a5,4(a5)
     5fc:	973e                	add	a4,a4,a5
     5fe:	fdc42783          	lw	a5,-36(s0)
     602:	c3d8                	sw	a4,4(a5)
            New_Block->MC_NextFreeBlock = BlockIterator->MC_NextFreeBlock->MC_NextFreeBlock;
     604:	fec42783          	lw	a5,-20(s0)
     608:	439c                	lw	a5,0(a5)
     60a:	4398                	lw	a4,0(a5)
     60c:	fdc42783          	lw	a5,-36(s0)
     610:	c398                	sw	a4,0(a5)
     612:	a839                	j	630 <MC_InsertFreeBlock+0xda>
        }
        else
        {
            New_Block->MC_NextFreeBlock = Block_End;
     614:	200007b7          	lui	a5,0x20000
     618:	42c7a703          	lw	a4,1068(a5) # 2000042c <Block_End>
     61c:	fdc42783          	lw	a5,-36(s0)
     620:	c398                	sw	a4,0(a5)
     622:	a039                	j	630 <MC_InsertFreeBlock+0xda>
        }
    }
    else
    {
        New_Block->MC_NextFreeBlock = BlockIterator->MC_NextFreeBlock;
     624:	fec42783          	lw	a5,-20(s0)
     628:	4398                	lw	a4,0(a5)
     62a:	fdc42783          	lw	a5,-36(s0)
     62e:	c398                	sw	a4,0(a5)
    }

    if(BlockIterator != New_Block)
     630:	fec42703          	lw	a4,-20(s0)
     634:	fdc42783          	lw	a5,-36(s0)
     638:	00f70763          	beq	a4,a5,646 <MC_InsertFreeBlock+0xf0>
    {
        BlockIterator->MC_NextFreeBlock = New_Block;
     63c:	fec42783          	lw	a5,-20(s0)
     640:	fdc42703          	lw	a4,-36(s0)
     644:	c398                	sw	a4,0(a5)
    }else{}

}
     646:	0001                	nop
     648:	5432                	lw	s0,44(sp)
     64a:	6145                	addi	sp,sp,48
     64c:	8082                	ret

0000064e <MC_PageMalloc>:

void *MC_PageMalloc(size_t MallocSize)
{
     64e:	7179                	addi	sp,sp,-48
     650:	d606                	sw	ra,44(sp)
     652:	d422                	sw	s0,40(sp)
     654:	1800                	addi	s0,sp,48
     656:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *Prev_Block = NULL, *Block = NULL, *New_Block = NULL;
     65a:	fe042623          	sw	zero,-20(s0)
     65e:	fe042423          	sw	zero,-24(s0)
     662:	fe042023          	sw	zero,-32(s0)
    void *ReturnAddr = NULL;
     666:	fe042223          	sw	zero,-28(s0)
    /* 应当挂起所有任务 */
    MC_scheduler_stop();
     66a:	17b000ef          	jal	ra,fe4 <MC_scheduler_stop>
    /*----------------*/
    if(Block_End == NULL)
     66e:	200007b7          	lui	a5,0x20000
     672:	42c7a783          	lw	a5,1068(a5) # 2000042c <Block_End>
     676:	e391                	bnez	a5,67a <MC_PageMalloc+0x2c>
    {
        MC_PageInit();
     678:	2a89                	jal	7ca <MC_PageInit>
    }
    else{}

    if((MallocSize & BlockAllocatiedBit) == 0)
     67a:	200007b7          	lui	a5,0x20000
     67e:	0207a703          	lw	a4,32(a5) # 20000020 <_data_end>
     682:	fdc42783          	lw	a5,-36(s0)
     686:	8ff9                	and	a5,a5,a4
     688:	12079863          	bnez	a5,7b8 <MC_PageMalloc+0x16a>
    {
        if(MallocSize > 0)
     68c:	fdc42783          	lw	a5,-36(s0)
     690:	12078463          	beqz	a5,7b8 <MC_PageMalloc+0x16a>
        {
            MallocSize += Block_Size;
     694:	200007b7          	lui	a5,0x20000
     698:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     69c:	fdc42703          	lw	a4,-36(s0)
     6a0:	97ba                	add	a5,a5,a4
     6a2:	fcf42e23          	sw	a5,-36(s0)
            if(MallocSize & HEAP_ADDRESS_MASK)
     6a6:	fdc42783          	lw	a5,-36(s0)
     6aa:	8b9d                	andi	a5,a5,7
     6ac:	c799                	beqz	a5,6ba <MC_PageMalloc+0x6c>
            {
                MallocSize = (MallocSize + HEAP_ADDRESS_MASK) & (~HEAP_ADDRESS_MASK);
     6ae:	fdc42783          	lw	a5,-36(s0)
     6b2:	079d                	addi	a5,a5,7
     6b4:	9be1                	andi	a5,a5,-8
     6b6:	fcf42e23          	sw	a5,-36(s0)
            }
            
            if(MallocSize <= HeapSizeRemaing)
     6ba:	200007b7          	lui	a5,0x20000
     6be:	0247a783          	lw	a5,36(a5) # 20000024 <HeapSizeRemaing>
     6c2:	fdc42703          	lw	a4,-36(s0)
     6c6:	0ee7e963          	bltu	a5,a4,7b8 <MC_PageMalloc+0x16a>
            {
                Prev_Block = &Block_Start;
     6ca:	200007b7          	lui	a5,0x20000
     6ce:	42478793          	addi	a5,a5,1060 # 20000424 <Block_Start>
     6d2:	fef42623          	sw	a5,-20(s0)
                Block = Prev_Block->MC_NextFreeBlock;
     6d6:	fec42783          	lw	a5,-20(s0)
     6da:	439c                	lw	a5,0(a5)
     6dc:	fef42423          	sw	a5,-24(s0)
                while(Block->MC_BlockSize < MallocSize && Block->MC_NextFreeBlock != NULL)
     6e0:	a811                	j	6f4 <MC_PageMalloc+0xa6>
                {
                    Prev_Block = Block;
     6e2:	fe842783          	lw	a5,-24(s0)
     6e6:	fef42623          	sw	a5,-20(s0)
                    Block = Block->MC_NextFreeBlock;
     6ea:	fe842783          	lw	a5,-24(s0)
     6ee:	439c                	lw	a5,0(a5)
     6f0:	fef42423          	sw	a5,-24(s0)
                while(Block->MC_BlockSize < MallocSize && Block->MC_NextFreeBlock != NULL)
     6f4:	fe842783          	lw	a5,-24(s0)
     6f8:	43dc                	lw	a5,4(a5)
     6fa:	fdc42703          	lw	a4,-36(s0)
     6fe:	00e7f663          	bgeu	a5,a4,70a <MC_PageMalloc+0xbc>
     702:	fe842783          	lw	a5,-24(s0)
     706:	439c                	lw	a5,0(a5)
     708:	ffe9                	bnez	a5,6e2 <MC_PageMalloc+0x94>
                }

                if(Block != Block_End)
     70a:	200007b7          	lui	a5,0x20000
     70e:	42c7a783          	lw	a5,1068(a5) # 2000042c <Block_End>
     712:	fe842703          	lw	a4,-24(s0)
     716:	0af70163          	beq	a4,a5,7b8 <MC_PageMalloc+0x16a>
                {
                    ReturnAddr = (void *)((uint8_t *)Block + Block_Size);
     71a:	200007b7          	lui	a5,0x20000
     71e:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     722:	fe842703          	lw	a4,-24(s0)
     726:	97ba                	add	a5,a5,a4
     728:	fef42223          	sw	a5,-28(s0)

                    Prev_Block->MC_NextFreeBlock = Block->MC_NextFreeBlock;
     72c:	fe842783          	lw	a5,-24(s0)
     730:	4398                	lw	a4,0(a5)
     732:	fec42783          	lw	a5,-20(s0)
     736:	c398                	sw	a4,0(a5)

                    if(Block->MC_BlockSize - MallocSize > HEAP_MINMUM_SIZE)
     738:	fe842783          	lw	a5,-24(s0)
     73c:	43d8                	lw	a4,4(a5)
     73e:	fdc42783          	lw	a5,-36(s0)
     742:	8f1d                	sub	a4,a4,a5
     744:	200007b7          	lui	a5,0x20000
     748:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     74c:	0786                	slli	a5,a5,0x1
     74e:	02e7fa63          	bgeu	a5,a4,782 <MC_PageMalloc+0x134>
                    {
                        New_Block = (BlockLink_t *)((uint8_t *)Block + MallocSize);
     752:	fe842703          	lw	a4,-24(s0)
     756:	fdc42783          	lw	a5,-36(s0)
     75a:	97ba                	add	a5,a5,a4
     75c:	fef42023          	sw	a5,-32(s0)

                        New_Block->MC_BlockSize = Block->MC_BlockSize - MallocSize;
     760:	fe842783          	lw	a5,-24(s0)
     764:	43d8                	lw	a4,4(a5)
     766:	fdc42783          	lw	a5,-36(s0)
     76a:	8f1d                	sub	a4,a4,a5
     76c:	fe042783          	lw	a5,-32(s0)
     770:	c3d8                	sw	a4,4(a5)
                        Block->MC_BlockSize = MallocSize;
     772:	fe842783          	lw	a5,-24(s0)
     776:	fdc42703          	lw	a4,-36(s0)
     77a:	c3d8                	sw	a4,4(a5)
                        MC_InsertFreeBlock(New_Block);
     77c:	fe042503          	lw	a0,-32(s0)
     780:	3bd9                	jal	556 <MC_InsertFreeBlock>
                    }else{}
                    HeapSizeRemaing -= Block->MC_BlockSize;
     782:	200007b7          	lui	a5,0x20000
     786:	0247a703          	lw	a4,36(a5) # 20000024 <HeapSizeRemaing>
     78a:	fe842783          	lw	a5,-24(s0)
     78e:	43dc                	lw	a5,4(a5)
     790:	8f1d                	sub	a4,a4,a5
     792:	200007b7          	lui	a5,0x20000
     796:	02e7a223          	sw	a4,36(a5) # 20000024 <HeapSizeRemaing>

                    Block->MC_BlockSize |= BlockAllocatiedBit;
     79a:	fe842783          	lw	a5,-24(s0)
     79e:	43d8                	lw	a4,4(a5)
     7a0:	200007b7          	lui	a5,0x20000
     7a4:	0207a783          	lw	a5,32(a5) # 20000020 <_data_end>
     7a8:	8f5d                	or	a4,a4,a5
     7aa:	fe842783          	lw	a5,-24(s0)
     7ae:	c3d8                	sw	a4,4(a5)
                    Block->MC_NextFreeBlock = NULL;
     7b0:	fe842783          	lw	a5,-24(s0)
     7b4:	0007a023          	sw	zero,0(a5)
            }else{}
        }else{}
    }else{}

    /* 应当恢复任务调度 */
    MC_scheduler_start();
     7b8:	013000ef          	jal	ra,fca <MC_scheduler_start>
    /*----------------*/


    return ReturnAddr;
     7bc:	fe442783          	lw	a5,-28(s0)
}
     7c0:	853e                	mv	a0,a5
     7c2:	50b2                	lw	ra,44(sp)
     7c4:	5422                	lw	s0,40(sp)
     7c6:	6145                	addi	sp,sp,48
     7c8:	8082                	ret

000007ca <MC_PageInit>:

void MC_PageInit(void)
{
     7ca:	1101                	addi	sp,sp,-32
     7cc:	ce22                	sw	s0,28(sp)
     7ce:	1000                	addi	s0,sp,32
    BlockLink_t *FirstFreeBlock;

    size_t TotalHeapSize = HEAP_SIZE;
     7d0:	6789                	lui	a5,0x2
     7d2:	ab87a783          	lw	a5,-1352(a5) # 1ab8 <HEAP_SIZE>
     7d6:	fef42623          	sw	a5,-20(s0)
    size_t HeapStart_Address = HEAP_START, HeapEnd_Address;
     7da:	6789                	lui	a5,0x2
     7dc:	ab47a783          	lw	a5,-1356(a5) # 1ab4 <HEAP_START>
     7e0:	fef42423          	sw	a5,-24(s0)

    if(HeapStart_Address & (HEAP_ADDRESS_MASK))
     7e4:	fe842783          	lw	a5,-24(s0)
     7e8:	8b9d                	andi	a5,a5,7
     7ea:	c39d                	beqz	a5,810 <MC_PageInit+0x46>
    {
        HeapStart_Address = (HeapStart_Address + HEAP_ADDRESS_MASK) & (~(HEAP_ADDRESS_MASK));
     7ec:	fe842783          	lw	a5,-24(s0)
     7f0:	079d                	addi	a5,a5,7
     7f2:	9be1                	andi	a5,a5,-8
     7f4:	fef42423          	sw	a5,-24(s0)
        TotalHeapSize -= HeapStart_Address - HEAP_START;
     7f8:	6789                	lui	a5,0x2
     7fa:	ab47a703          	lw	a4,-1356(a5) # 1ab4 <HEAP_START>
     7fe:	fe842783          	lw	a5,-24(s0)
     802:	40f707b3          	sub	a5,a4,a5
     806:	fec42703          	lw	a4,-20(s0)
     80a:	97ba                	add	a5,a5,a4
     80c:	fef42623          	sw	a5,-20(s0)
    }

    HeapEnd_Address = HeapStart_Address + TotalHeapSize;
     810:	fe842703          	lw	a4,-24(s0)
     814:	fec42783          	lw	a5,-20(s0)
     818:	97ba                	add	a5,a5,a4
     81a:	fef42223          	sw	a5,-28(s0)
    HeapEnd_Address -= Block_Size;
     81e:	200007b7          	lui	a5,0x20000
     822:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     826:	fe442703          	lw	a4,-28(s0)
     82a:	40f707b3          	sub	a5,a4,a5
     82e:	fef42223          	sw	a5,-28(s0)
    
    Block_End = (BlockLink_t *)HeapEnd_Address;
     832:	fe442703          	lw	a4,-28(s0)
     836:	200007b7          	lui	a5,0x20000
     83a:	42e7a623          	sw	a4,1068(a5) # 2000042c <Block_End>
    Block_End -> MC_BlockSize = 0;
     83e:	200007b7          	lui	a5,0x20000
     842:	42c7a783          	lw	a5,1068(a5) # 2000042c <Block_End>
     846:	0007a223          	sw	zero,4(a5)
    Block_End -> MC_NextFreeBlock = NULL;
     84a:	200007b7          	lui	a5,0x20000
     84e:	42c7a783          	lw	a5,1068(a5) # 2000042c <Block_End>
     852:	0007a023          	sw	zero,0(a5)
    
    Block_Start.MC_BlockSize = 0;
     856:	200007b7          	lui	a5,0x20000
     85a:	42478793          	addi	a5,a5,1060 # 20000424 <Block_Start>
     85e:	0007a223          	sw	zero,4(a5)
    Block_Start.MC_NextFreeBlock = (BlockLink_t *)HeapStart_Address;
     862:	fe842703          	lw	a4,-24(s0)
     866:	200007b7          	lui	a5,0x20000
     86a:	42e7a223          	sw	a4,1060(a5) # 20000424 <Block_Start>

    FirstFreeBlock = (BlockLink_t *)HeapStart_Address;
     86e:	fe842783          	lw	a5,-24(s0)
     872:	fef42023          	sw	a5,-32(s0)
    FirstFreeBlock -> MC_BlockSize = HeapEnd_Address - HeapStart_Address;
     876:	fe442703          	lw	a4,-28(s0)
     87a:	fe842783          	lw	a5,-24(s0)
     87e:	8f1d                	sub	a4,a4,a5
     880:	fe042783          	lw	a5,-32(s0)
     884:	c3d8                	sw	a4,4(a5)
    FirstFreeBlock -> MC_NextFreeBlock = Block_End;
     886:	200007b7          	lui	a5,0x20000
     88a:	42c7a703          	lw	a4,1068(a5) # 2000042c <Block_End>
     88e:	fe042783          	lw	a5,-32(s0)
     892:	c398                	sw	a4,0(a5)

    HeapSizeRemaing = FirstFreeBlock -> MC_BlockSize;
     894:	fe042783          	lw	a5,-32(s0)
     898:	43d8                	lw	a4,4(a5)
     89a:	200007b7          	lui	a5,0x20000
     89e:	02e7a223          	sw	a4,36(a5) # 20000024 <HeapSizeRemaing>
    BlockAllocatiedBit = (((size_t) 1) << (sizeof(size_t) * heapBITS_PER_BYTE - 1));
     8a2:	200007b7          	lui	a5,0x20000
     8a6:	80000737          	lui	a4,0x80000
     8aa:	02e7a023          	sw	a4,32(a5) # 20000020 <_data_end>
}
     8ae:	0001                	nop
     8b0:	4472                	lw	s0,28(sp)
     8b2:	6105                	addi	sp,sp,32
     8b4:	8082                	ret

000008b6 <MC_PageFree>:

void MC_PageFree(void *FreeAddr)
{
     8b6:	7179                	addi	sp,sp,-48
     8b8:	d606                	sw	ra,44(sp)
     8ba:	d422                	sw	s0,40(sp)
     8bc:	1800                	addi	s0,sp,48
     8be:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *BlockIterator;
    uint8_t *BlockOperator;
    if(FreeAddr != NULL)
     8c2:	fdc42783          	lw	a5,-36(s0)
     8c6:	cbbd                	beqz	a5,93c <MC_PageFree+0x86>
    {
        BlockOperator = (uint8_t *)FreeAddr - Block_Size;
     8c8:	200007b7          	lui	a5,0x20000
     8cc:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     8d0:	40f007b3          	neg	a5,a5
     8d4:	fdc42703          	lw	a4,-36(s0)
     8d8:	97ba                	add	a5,a5,a4
     8da:	fef42623          	sw	a5,-20(s0)
        BlockIterator = BlockOperator;
     8de:	fec42783          	lw	a5,-20(s0)
     8e2:	fef42423          	sw	a5,-24(s0)

        if((BlockIterator->MC_BlockSize & BlockAllocatiedBit) != 0 && BlockIterator->MC_NextFreeBlock == NULL)
     8e6:	fe842783          	lw	a5,-24(s0)
     8ea:	43d8                	lw	a4,4(a5)
     8ec:	200007b7          	lui	a5,0x20000
     8f0:	0207a783          	lw	a5,32(a5) # 20000020 <_data_end>
     8f4:	8ff9                	and	a5,a5,a4
     8f6:	c3b9                	beqz	a5,93c <MC_PageFree+0x86>
     8f8:	fe842783          	lw	a5,-24(s0)
     8fc:	439c                	lw	a5,0(a5)
     8fe:	ef9d                	bnez	a5,93c <MC_PageFree+0x86>
        {
            /*此处应该挂起所有任务*/
            MC_scheduler_stop();
     900:	25d5                	jal	fe4 <MC_scheduler_stop>
            /*------------------*/
            BlockIterator->MC_BlockSize &= ~BlockAllocatiedBit;
     902:	fe842783          	lw	a5,-24(s0)
     906:	43d8                	lw	a4,4(a5)
     908:	200007b7          	lui	a5,0x20000
     90c:	0207a783          	lw	a5,32(a5) # 20000020 <_data_end>
     910:	fff7c793          	not	a5,a5
     914:	8f7d                	and	a4,a4,a5
     916:	fe842783          	lw	a5,-24(s0)
     91a:	c3d8                	sw	a4,4(a5)
            {
                HeapSizeRemaing += BlockIterator->MC_BlockSize;
     91c:	fe842783          	lw	a5,-24(s0)
     920:	43d8                	lw	a4,4(a5)
     922:	200007b7          	lui	a5,0x20000
     926:	0247a783          	lw	a5,36(a5) # 20000024 <HeapSizeRemaing>
     92a:	973e                	add	a4,a4,a5
     92c:	200007b7          	lui	a5,0x20000
     930:	02e7a223          	sw	a4,36(a5) # 20000024 <HeapSizeRemaing>
                MC_InsertFreeBlock(BlockIterator);
     934:	fe842503          	lw	a0,-24(s0)
     938:	3939                	jal	556 <MC_InsertFreeBlock>
            }
            /*此处应该取消所有被挂任务*/
            MC_scheduler_start();
     93a:	2d41                	jal	fca <MC_scheduler_start>
            /*----------------------*/
        }else{}
    }else{}
     93c:	0001                	nop
     93e:	50b2                	lw	ra,44(sp)
     940:	5422                	lw	s0,40(sp)
     942:	6145                	addi	sp,sp,48
     944:	8082                	ret

00000946 <_vsnprintf>:
/*
 * ref: https://github.com/cccriscv/mini-riscv-os/blob/master/05-Preemptive/lib.c
 */

static int _vsnprintf(char * out, size_t n, const char* s, va_list vl)
{
     946:	715d                	addi	sp,sp,-80
     948:	c6a2                	sw	s0,76(sp)
     94a:	0880                	addi	s0,sp,80
     94c:	faa42e23          	sw	a0,-68(s0)
     950:	fab42c23          	sw	a1,-72(s0)
     954:	fac42a23          	sw	a2,-76(s0)
     958:	fad42823          	sw	a3,-80(s0)
	int format = 0;
     95c:	fe042623          	sw	zero,-20(s0)
	int longarg = 0;
     960:	fe042423          	sw	zero,-24(s0)
	size_t pos = 0;
     964:	fe042223          	sw	zero,-28(s0)
	for (; *s; s++) {
     968:	ae95                	j	cdc <_vsnprintf+0x396>
		if (format) {
     96a:	fec42783          	lw	a5,-20(s0)
     96e:	30078b63          	beqz	a5,c84 <_vsnprintf+0x33e>
			switch(*s) {
     972:	fb442783          	lw	a5,-76(s0)
     976:	0007c783          	lbu	a5,0(a5)
     97a:	f9d78793          	addi	a5,a5,-99
     97e:	4755                	li	a4,21
     980:	34f76863          	bltu	a4,a5,cd0 <_vsnprintf+0x38a>
     984:	00279713          	slli	a4,a5,0x2
     988:	6789                	lui	a5,0x2
     98a:	acc78793          	addi	a5,a5,-1332 # 1acc <STACK_END+0xc>
     98e:	97ba                	add	a5,a5,a4
     990:	439c                	lw	a5,0(a5)
     992:	8782                	jr	a5
			case 'l': {
				longarg = 1;
     994:	4785                	li	a5,1
     996:	fef42423          	sw	a5,-24(s0)
				break;
     99a:	ae25                	j	cd2 <_vsnprintf+0x38c>
			}
			case 'p': {
				longarg = 1;
     99c:	4785                	li	a5,1
     99e:	fef42423          	sw	a5,-24(s0)
				if (out && pos < n) {
     9a2:	fbc42783          	lw	a5,-68(s0)
     9a6:	c385                	beqz	a5,9c6 <_vsnprintf+0x80>
     9a8:	fe442703          	lw	a4,-28(s0)
     9ac:	fb842783          	lw	a5,-72(s0)
     9b0:	00f77b63          	bgeu	a4,a5,9c6 <_vsnprintf+0x80>
					out[pos] = '0';
     9b4:	fbc42703          	lw	a4,-68(s0)
     9b8:	fe442783          	lw	a5,-28(s0)
     9bc:	97ba                	add	a5,a5,a4
     9be:	03000713          	li	a4,48
     9c2:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     9c6:	fe442783          	lw	a5,-28(s0)
     9ca:	0785                	addi	a5,a5,1
     9cc:	fef42223          	sw	a5,-28(s0)
				if (out && pos < n) {
     9d0:	fbc42783          	lw	a5,-68(s0)
     9d4:	c385                	beqz	a5,9f4 <_vsnprintf+0xae>
     9d6:	fe442703          	lw	a4,-28(s0)
     9da:	fb842783          	lw	a5,-72(s0)
     9de:	00f77b63          	bgeu	a4,a5,9f4 <_vsnprintf+0xae>
					out[pos] = 'x';
     9e2:	fbc42703          	lw	a4,-68(s0)
     9e6:	fe442783          	lw	a5,-28(s0)
     9ea:	97ba                	add	a5,a5,a4
     9ec:	07800713          	li	a4,120
     9f0:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     9f4:	fe442783          	lw	a5,-28(s0)
     9f8:	0785                	addi	a5,a5,1
     9fa:	fef42223          	sw	a5,-28(s0)
			}
			case 'x': {
				long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
     9fe:	fe842783          	lw	a5,-24(s0)
     a02:	cb89                	beqz	a5,a14 <_vsnprintf+0xce>
     a04:	fb042783          	lw	a5,-80(s0)
     a08:	00478713          	addi	a4,a5,4
     a0c:	fae42823          	sw	a4,-80(s0)
     a10:	439c                	lw	a5,0(a5)
     a12:	a801                	j	a22 <_vsnprintf+0xdc>
     a14:	fb042783          	lw	a5,-80(s0)
     a18:	00478713          	addi	a4,a5,4
     a1c:	fae42823          	sw	a4,-80(s0)
     a20:	439c                	lw	a5,0(a5)
     a22:	fcf42423          	sw	a5,-56(s0)
				int hexdigits = 2*(longarg ? sizeof(long) : sizeof(int))-1;
     a26:	479d                	li	a5,7
     a28:	fcf42223          	sw	a5,-60(s0)
				for(int i = hexdigits; i >= 0; i--) {
     a2c:	fc442783          	lw	a5,-60(s0)
     a30:	fef42023          	sw	a5,-32(s0)
     a34:	a89d                	j	aaa <_vsnprintf+0x164>
					int d = (num >> (4*i)) & 0xF;
     a36:	fe042783          	lw	a5,-32(s0)
     a3a:	078a                	slli	a5,a5,0x2
     a3c:	fc842703          	lw	a4,-56(s0)
     a40:	40f757b3          	sra	a5,a4,a5
     a44:	8bbd                	andi	a5,a5,15
     a46:	fcf42023          	sw	a5,-64(s0)
					if (out && pos < n) {
     a4a:	fbc42783          	lw	a5,-68(s0)
     a4e:	c7a1                	beqz	a5,a96 <_vsnprintf+0x150>
     a50:	fe442703          	lw	a4,-28(s0)
     a54:	fb842783          	lw	a5,-72(s0)
     a58:	02f77f63          	bgeu	a4,a5,a96 <_vsnprintf+0x150>
						out[pos] = (d < 10 ? '0'+d : 'a'+d-10);
     a5c:	fc042703          	lw	a4,-64(s0)
     a60:	47a5                	li	a5,9
     a62:	00e7cb63          	blt	a5,a4,a78 <_vsnprintf+0x132>
     a66:	fc042783          	lw	a5,-64(s0)
     a6a:	0ff7f793          	andi	a5,a5,255
     a6e:	03078793          	addi	a5,a5,48
     a72:	0ff7f793          	andi	a5,a5,255
     a76:	a809                	j	a88 <_vsnprintf+0x142>
     a78:	fc042783          	lw	a5,-64(s0)
     a7c:	0ff7f793          	andi	a5,a5,255
     a80:	05778793          	addi	a5,a5,87
     a84:	0ff7f793          	andi	a5,a5,255
     a88:	fbc42683          	lw	a3,-68(s0)
     a8c:	fe442703          	lw	a4,-28(s0)
     a90:	9736                	add	a4,a4,a3
     a92:	00f70023          	sb	a5,0(a4) # 80000000 <_end_stack+0x5fff0000>
					}
					pos++;
     a96:	fe442783          	lw	a5,-28(s0)
     a9a:	0785                	addi	a5,a5,1
     a9c:	fef42223          	sw	a5,-28(s0)
				for(int i = hexdigits; i >= 0; i--) {
     aa0:	fe042783          	lw	a5,-32(s0)
     aa4:	17fd                	addi	a5,a5,-1
     aa6:	fef42023          	sw	a5,-32(s0)
     aaa:	fe042783          	lw	a5,-32(s0)
     aae:	f807d4e3          	bgez	a5,a36 <_vsnprintf+0xf0>
				}
				longarg = 0;
     ab2:	fe042423          	sw	zero,-24(s0)
				format = 0;
     ab6:	fe042623          	sw	zero,-20(s0)
				break;
     aba:	ac21                	j	cd2 <_vsnprintf+0x38c>
			}
			case 'd': {
				long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
     abc:	fe842783          	lw	a5,-24(s0)
     ac0:	cb89                	beqz	a5,ad2 <_vsnprintf+0x18c>
     ac2:	fb042783          	lw	a5,-80(s0)
     ac6:	00478713          	addi	a4,a5,4
     aca:	fae42823          	sw	a4,-80(s0)
     ace:	439c                	lw	a5,0(a5)
     ad0:	a801                	j	ae0 <_vsnprintf+0x19a>
     ad2:	fb042783          	lw	a5,-80(s0)
     ad6:	00478713          	addi	a4,a5,4
     ada:	fae42823          	sw	a4,-80(s0)
     ade:	439c                	lw	a5,0(a5)
     ae0:	fcf42e23          	sw	a5,-36(s0)
				if (num < 0) {
     ae4:	fdc42783          	lw	a5,-36(s0)
     ae8:	0207df63          	bgez	a5,b26 <_vsnprintf+0x1e0>
					num = -num;
     aec:	fdc42783          	lw	a5,-36(s0)
     af0:	40f007b3          	neg	a5,a5
     af4:	fcf42e23          	sw	a5,-36(s0)
					if (out && pos < n) {
     af8:	fbc42783          	lw	a5,-68(s0)
     afc:	c385                	beqz	a5,b1c <_vsnprintf+0x1d6>
     afe:	fe442703          	lw	a4,-28(s0)
     b02:	fb842783          	lw	a5,-72(s0)
     b06:	00f77b63          	bgeu	a4,a5,b1c <_vsnprintf+0x1d6>
						out[pos] = '-';
     b0a:	fbc42703          	lw	a4,-68(s0)
     b0e:	fe442783          	lw	a5,-28(s0)
     b12:	97ba                	add	a5,a5,a4
     b14:	02d00713          	li	a4,45
     b18:	00e78023          	sb	a4,0(a5)
					}
					pos++;
     b1c:	fe442783          	lw	a5,-28(s0)
     b20:	0785                	addi	a5,a5,1
     b22:	fef42223          	sw	a5,-28(s0)
				}
				long digits = 1;
     b26:	4785                	li	a5,1
     b28:	fcf42c23          	sw	a5,-40(s0)
				for (long nn = num; nn /= 10; digits++);
     b2c:	fdc42783          	lw	a5,-36(s0)
     b30:	fcf42a23          	sw	a5,-44(s0)
     b34:	a031                	j	b40 <_vsnprintf+0x1fa>
     b36:	fd842783          	lw	a5,-40(s0)
     b3a:	0785                	addi	a5,a5,1
     b3c:	fcf42c23          	sw	a5,-40(s0)
     b40:	fd442703          	lw	a4,-44(s0)
     b44:	47a9                	li	a5,10
     b46:	02f747b3          	div	a5,a4,a5
     b4a:	fcf42a23          	sw	a5,-44(s0)
     b4e:	fd442783          	lw	a5,-44(s0)
     b52:	f3f5                	bnez	a5,b36 <_vsnprintf+0x1f0>
				for (int i = digits-1; i >= 0; i--) {
     b54:	fd842783          	lw	a5,-40(s0)
     b58:	17fd                	addi	a5,a5,-1
     b5a:	fcf42823          	sw	a5,-48(s0)
     b5e:	a8b1                	j	bba <_vsnprintf+0x274>
					if (out && pos + i < n) {
     b60:	fbc42783          	lw	a5,-68(s0)
     b64:	cf9d                	beqz	a5,ba2 <_vsnprintf+0x25c>
     b66:	fd042703          	lw	a4,-48(s0)
     b6a:	fe442783          	lw	a5,-28(s0)
     b6e:	97ba                	add	a5,a5,a4
     b70:	fb842703          	lw	a4,-72(s0)
     b74:	02e7f763          	bgeu	a5,a4,ba2 <_vsnprintf+0x25c>
						out[pos + i] = '0' + (num % 10);
     b78:	fdc42703          	lw	a4,-36(s0)
     b7c:	47a9                	li	a5,10
     b7e:	02f767b3          	rem	a5,a4,a5
     b82:	0ff7f713          	andi	a4,a5,255
     b86:	fd042683          	lw	a3,-48(s0)
     b8a:	fe442783          	lw	a5,-28(s0)
     b8e:	97b6                	add	a5,a5,a3
     b90:	fbc42683          	lw	a3,-68(s0)
     b94:	97b6                	add	a5,a5,a3
     b96:	03070713          	addi	a4,a4,48
     b9a:	0ff77713          	andi	a4,a4,255
     b9e:	00e78023          	sb	a4,0(a5)
					}
					num /= 10;
     ba2:	fdc42703          	lw	a4,-36(s0)
     ba6:	47a9                	li	a5,10
     ba8:	02f747b3          	div	a5,a4,a5
     bac:	fcf42e23          	sw	a5,-36(s0)
				for (int i = digits-1; i >= 0; i--) {
     bb0:	fd042783          	lw	a5,-48(s0)
     bb4:	17fd                	addi	a5,a5,-1
     bb6:	fcf42823          	sw	a5,-48(s0)
     bba:	fd042783          	lw	a5,-48(s0)
     bbe:	fa07d1e3          	bgez	a5,b60 <_vsnprintf+0x21a>
				}
				pos += digits;
     bc2:	fd842783          	lw	a5,-40(s0)
     bc6:	fe442703          	lw	a4,-28(s0)
     bca:	97ba                	add	a5,a5,a4
     bcc:	fef42223          	sw	a5,-28(s0)
				longarg = 0;
     bd0:	fe042423          	sw	zero,-24(s0)
				format = 0;
     bd4:	fe042623          	sw	zero,-20(s0)
				break;
     bd8:	a8ed                	j	cd2 <_vsnprintf+0x38c>
			}
			case 's': {
				const char* s2 = va_arg(vl, const char*);
     bda:	fb042783          	lw	a5,-80(s0)
     bde:	00478713          	addi	a4,a5,4
     be2:	fae42823          	sw	a4,-80(s0)
     be6:	439c                	lw	a5,0(a5)
     be8:	fcf42623          	sw	a5,-52(s0)
				while (*s2) {
     bec:	a83d                	j	c2a <_vsnprintf+0x2e4>
					if (out && pos < n) {
     bee:	fbc42783          	lw	a5,-68(s0)
     bf2:	c395                	beqz	a5,c16 <_vsnprintf+0x2d0>
     bf4:	fe442703          	lw	a4,-28(s0)
     bf8:	fb842783          	lw	a5,-72(s0)
     bfc:	00f77d63          	bgeu	a4,a5,c16 <_vsnprintf+0x2d0>
						out[pos] = *s2;
     c00:	fbc42703          	lw	a4,-68(s0)
     c04:	fe442783          	lw	a5,-28(s0)
     c08:	97ba                	add	a5,a5,a4
     c0a:	fcc42703          	lw	a4,-52(s0)
     c0e:	00074703          	lbu	a4,0(a4)
     c12:	00e78023          	sb	a4,0(a5)
					}
					pos++;
     c16:	fe442783          	lw	a5,-28(s0)
     c1a:	0785                	addi	a5,a5,1
     c1c:	fef42223          	sw	a5,-28(s0)
					s2++;
     c20:	fcc42783          	lw	a5,-52(s0)
     c24:	0785                	addi	a5,a5,1
     c26:	fcf42623          	sw	a5,-52(s0)
				while (*s2) {
     c2a:	fcc42783          	lw	a5,-52(s0)
     c2e:	0007c783          	lbu	a5,0(a5)
     c32:	ffd5                	bnez	a5,bee <_vsnprintf+0x2a8>
				}
				longarg = 0;
     c34:	fe042423          	sw	zero,-24(s0)
				format = 0;
     c38:	fe042623          	sw	zero,-20(s0)
				break;
     c3c:	a859                	j	cd2 <_vsnprintf+0x38c>
			}
			case 'c': {
				if (out && pos < n) {
     c3e:	fbc42783          	lw	a5,-68(s0)
     c42:	c79d                	beqz	a5,c70 <_vsnprintf+0x32a>
     c44:	fe442703          	lw	a4,-28(s0)
     c48:	fb842783          	lw	a5,-72(s0)
     c4c:	02f77263          	bgeu	a4,a5,c70 <_vsnprintf+0x32a>
					out[pos] = (char)va_arg(vl,int);
     c50:	fb042783          	lw	a5,-80(s0)
     c54:	00478713          	addi	a4,a5,4
     c58:	fae42823          	sw	a4,-80(s0)
     c5c:	4394                	lw	a3,0(a5)
     c5e:	fbc42703          	lw	a4,-68(s0)
     c62:	fe442783          	lw	a5,-28(s0)
     c66:	97ba                	add	a5,a5,a4
     c68:	0ff6f713          	andi	a4,a3,255
     c6c:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     c70:	fe442783          	lw	a5,-28(s0)
     c74:	0785                	addi	a5,a5,1
     c76:	fef42223          	sw	a5,-28(s0)
				longarg = 0;
     c7a:	fe042423          	sw	zero,-24(s0)
				format = 0;
     c7e:	fe042623          	sw	zero,-20(s0)
				break;
     c82:	a881                	j	cd2 <_vsnprintf+0x38c>
			}
			default:
				break;
			}
		} else if (*s == '%') {
     c84:	fb442783          	lw	a5,-76(s0)
     c88:	0007c703          	lbu	a4,0(a5)
     c8c:	02500793          	li	a5,37
     c90:	00f71663          	bne	a4,a5,c9c <_vsnprintf+0x356>
			format = 1;
     c94:	4785                	li	a5,1
     c96:	fef42623          	sw	a5,-20(s0)
     c9a:	a825                	j	cd2 <_vsnprintf+0x38c>
		} else {
			if (out && pos < n) {
     c9c:	fbc42783          	lw	a5,-68(s0)
     ca0:	c395                	beqz	a5,cc4 <_vsnprintf+0x37e>
     ca2:	fe442703          	lw	a4,-28(s0)
     ca6:	fb842783          	lw	a5,-72(s0)
     caa:	00f77d63          	bgeu	a4,a5,cc4 <_vsnprintf+0x37e>
				out[pos] = *s;
     cae:	fbc42703          	lw	a4,-68(s0)
     cb2:	fe442783          	lw	a5,-28(s0)
     cb6:	97ba                	add	a5,a5,a4
     cb8:	fb442703          	lw	a4,-76(s0)
     cbc:	00074703          	lbu	a4,0(a4)
     cc0:	00e78023          	sb	a4,0(a5)
			}
			pos++;
     cc4:	fe442783          	lw	a5,-28(s0)
     cc8:	0785                	addi	a5,a5,1
     cca:	fef42223          	sw	a5,-28(s0)
     cce:	a011                	j	cd2 <_vsnprintf+0x38c>
				break;
     cd0:	0001                	nop
	for (; *s; s++) {
     cd2:	fb442783          	lw	a5,-76(s0)
     cd6:	0785                	addi	a5,a5,1
     cd8:	faf42a23          	sw	a5,-76(s0)
     cdc:	fb442783          	lw	a5,-76(s0)
     ce0:	0007c783          	lbu	a5,0(a5)
     ce4:	c80793e3          	bnez	a5,96a <_vsnprintf+0x24>
		}
    	}
	if (out && pos < n) {
     ce8:	fbc42783          	lw	a5,-68(s0)
     cec:	cf99                	beqz	a5,d0a <_vsnprintf+0x3c4>
     cee:	fe442703          	lw	a4,-28(s0)
     cf2:	fb842783          	lw	a5,-72(s0)
     cf6:	00f77a63          	bgeu	a4,a5,d0a <_vsnprintf+0x3c4>
		out[pos] = 0;
     cfa:	fbc42703          	lw	a4,-68(s0)
     cfe:	fe442783          	lw	a5,-28(s0)
     d02:	97ba                	add	a5,a5,a4
     d04:	00078023          	sb	zero,0(a5)
     d08:	a839                	j	d26 <_vsnprintf+0x3e0>
	} else if (out && n) {
     d0a:	fbc42783          	lw	a5,-68(s0)
     d0e:	cf81                	beqz	a5,d26 <_vsnprintf+0x3e0>
     d10:	fb842783          	lw	a5,-72(s0)
     d14:	cb89                	beqz	a5,d26 <_vsnprintf+0x3e0>
		out[n-1] = 0;
     d16:	fb842783          	lw	a5,-72(s0)
     d1a:	17fd                	addi	a5,a5,-1
     d1c:	fbc42703          	lw	a4,-68(s0)
     d20:	97ba                	add	a5,a5,a4
     d22:	00078023          	sb	zero,0(a5)
	}
	return pos;
     d26:	fe442783          	lw	a5,-28(s0)
}
     d2a:	853e                	mv	a0,a5
     d2c:	4436                	lw	s0,76(sp)
     d2e:	6161                	addi	sp,sp,80
     d30:	8082                	ret

00000d32 <_vprintf>:

static char out_buf[1000]; // buffer for _vprintf()

static int _vprintf(const char* s, va_list vl)
{
     d32:	7179                	addi	sp,sp,-48
     d34:	d606                	sw	ra,44(sp)
     d36:	d422                	sw	s0,40(sp)
     d38:	1800                	addi	s0,sp,48
     d3a:	fca42e23          	sw	a0,-36(s0)
     d3e:	fcb42c23          	sw	a1,-40(s0)
	int res = _vsnprintf(NULL, -1, s, vl);
     d42:	fd842683          	lw	a3,-40(s0)
     d46:	fdc42603          	lw	a2,-36(s0)
     d4a:	55fd                	li	a1,-1
     d4c:	4501                	li	a0,0
     d4e:	3ee5                	jal	946 <_vsnprintf>
     d50:	fea42623          	sw	a0,-20(s0)
	if (res+1 >= sizeof(out_buf)) {
     d54:	fec42783          	lw	a5,-20(s0)
     d58:	0785                	addi	a5,a5,1
     d5a:	873e                	mv	a4,a5
     d5c:	3e700793          	li	a5,999
     d60:	00e7f863          	bgeu	a5,a4,d70 <_vprintf+0x3e>
		puts("error: output string size overflow\n");
     d64:	6789                	lui	a5,0x2
     d66:	b2478513          	addi	a0,a5,-1244 # 1b24 <STACK_END+0x64>
     d6a:	f9aff0ef          	jal	ra,504 <puts>
		while(1) {}
     d6e:	a001                	j	d6e <_vprintf+0x3c>
	}
	_vsnprintf(out_buf, res + 1, s, vl);
     d70:	fec42783          	lw	a5,-20(s0)
     d74:	0785                	addi	a5,a5,1
     d76:	fd842683          	lw	a3,-40(s0)
     d7a:	fdc42603          	lw	a2,-36(s0)
     d7e:	85be                	mv	a1,a5
     d80:	200007b7          	lui	a5,0x20000
     d84:	02878513          	addi	a0,a5,40 # 20000028 <out_buf>
     d88:	3e7d                	jal	946 <_vsnprintf>
	puts(out_buf);
     d8a:	200007b7          	lui	a5,0x20000
     d8e:	02878513          	addi	a0,a5,40 # 20000028 <out_buf>
     d92:	f72ff0ef          	jal	ra,504 <puts>
	return res;
     d96:	fec42783          	lw	a5,-20(s0)
}
     d9a:	853e                	mv	a0,a5
     d9c:	50b2                	lw	ra,44(sp)
     d9e:	5422                	lw	s0,40(sp)
     da0:	6145                	addi	sp,sp,48
     da2:	8082                	ret

00000da4 <printf>:

int printf(const char* s, ...)
{
     da4:	715d                	addi	sp,sp,-80
     da6:	d606                	sw	ra,44(sp)
     da8:	d422                	sw	s0,40(sp)
     daa:	1800                	addi	s0,sp,48
     dac:	fca42e23          	sw	a0,-36(s0)
     db0:	c04c                	sw	a1,4(s0)
     db2:	c410                	sw	a2,8(s0)
     db4:	c454                	sw	a3,12(s0)
     db6:	c818                	sw	a4,16(s0)
     db8:	c85c                	sw	a5,20(s0)
     dba:	01042c23          	sw	a6,24(s0)
     dbe:	01142e23          	sw	a7,28(s0)
	int res = 0;
     dc2:	fe042623          	sw	zero,-20(s0)
	va_list vl;
	va_start(vl, s);
     dc6:	02040793          	addi	a5,s0,32
     dca:	1791                	addi	a5,a5,-28
     dcc:	fef42423          	sw	a5,-24(s0)
	res = _vprintf(s, vl);
     dd0:	fe842783          	lw	a5,-24(s0)
     dd4:	85be                	mv	a1,a5
     dd6:	fdc42503          	lw	a0,-36(s0)
     dda:	3fa1                	jal	d32 <_vprintf>
     ddc:	fea42623          	sw	a0,-20(s0)
	va_end(vl);
	return res;
     de0:	fec42783          	lw	a5,-20(s0)
}
     de4:	853e                	mv	a0,a5
     de6:	50b2                	lw	ra,44(sp)
     de8:	5422                	lw	s0,40(sp)
     dea:	6161                	addi	sp,sp,80
     dec:	8082                	ret

00000dee <panic>:

void panic(char *s)
{
     dee:	1101                	addi	sp,sp,-32
     df0:	ce06                	sw	ra,28(sp)
     df2:	cc22                	sw	s0,24(sp)
     df4:	1000                	addi	s0,sp,32
     df6:	fea42623          	sw	a0,-20(s0)
	printf("panic: ");
     dfa:	6789                	lui	a5,0x2
     dfc:	b4878513          	addi	a0,a5,-1208 # 1b48 <STACK_END+0x88>
     e00:	3755                	jal	da4 <printf>
	printf(s);
     e02:	fec42503          	lw	a0,-20(s0)
     e06:	3f79                	jal	da4 <printf>
	printf("\n");
     e08:	6789                	lui	a5,0x2
     e0a:	b5078513          	addi	a0,a5,-1200 # 1b50 <STACK_END+0x90>
     e0e:	3f59                	jal	da4 <printf>
	while(1){};
     e10:	a001                	j	e10 <panic+0x22>
	...

00000e14 <w_mscratch>:
	return x;
}

/* Machine Scratch register, for early trap handler */
static inline __attribute__((aligned(4))) void w_mscratch(reg_t x)
{
     e14:	1101                	addi	sp,sp,-32
     e16:	ce22                	sw	s0,28(sp)
     e18:	1000                	addi	s0,sp,32
     e1a:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mscratch, %0" : : "r" (x));
     e1e:	fec42783          	lw	a5,-20(s0)
     e22:	34079073          	csrw	mscratch,a5
}
     e26:	0001                	nop
     e28:	4472                	lw	s0,28(sp)
     e2a:	6105                	addi	sp,sp,32
     e2c:	8082                	ret

00000e2e <MC_schedule>:

uint8_t MC_schedule_flag = 0;
struct MC_sched MC_scheduler;

void MC_schedule()
{
     e2e:	1101                	addi	sp,sp,-32
     e30:	ce06                	sw	ra,28(sp)
     e32:	cc22                	sw	s0,24(sp)
     e34:	1000                	addi	s0,sp,32
    MC_thread_t from_thread, to_thread = NULL;
     e36:	fe042423          	sw	zero,-24(s0)
    if(MC_scheduler.sched_state == SCHED_RUNNING)
     e3a:	200007b7          	lui	a5,0x20000
     e3e:	4307c703          	lbu	a4,1072(a5) # 20000430 <MC_scheduler>
     e42:	4785                	li	a5,1
     e44:	00f71a63          	bne	a4,a5,e58 <MC_schedule+0x2a>
    {
        from_thread = MC_scheduler.running_thread;
     e48:	200007b7          	lui	a5,0x20000
     e4c:	43078793          	addi	a5,a5,1072 # 20000430 <MC_scheduler>
     e50:	43dc                	lw	a5,4(a5)
     e52:	fef42623          	sw	a5,-20(s0)
     e56:	a811                	j	e6a <MC_schedule+0x3c>
    }
    else
    {
        MC_scheduler.sched_state = SCHED_RUNNING;
     e58:	200007b7          	lui	a5,0x20000
     e5c:	4705                	li	a4,1
     e5e:	42e78823          	sb	a4,1072(a5) # 20000430 <MC_scheduler>
        from_thread = NULL;
     e62:	fe042623          	sw	zero,-20(s0)
        w_mscratch(0);
     e66:	4501                	li	a0,0
     e68:	3775                	jal	e14 <w_mscratch>
    }

    for(int i = 63; i >= 0; i--)
     e6a:	03f00793          	li	a5,63
     e6e:	fef42223          	sw	a5,-28(s0)
     e72:	a8c1                	j	f42 <MC_schedule+0x114>
    {
        if(Ready_threadList_Start[i].next != (MC_thread_t)&Ready_threadList_End[i])
     e74:	20000737          	lui	a4,0x20000
     e78:	fe442783          	lw	a5,-28(s0)
     e7c:	43870713          	addi	a4,a4,1080 # 20000438 <Ready_threadList_Start>
     e80:	078e                	slli	a5,a5,0x3
     e82:	97ba                	add	a5,a5,a4
     e84:	43d8                	lw	a4,4(a5)
     e86:	fe442783          	lw	a5,-28(s0)
     e8a:	00379693          	slli	a3,a5,0x3
     e8e:	200007b7          	lui	a5,0x20000
     e92:	63878793          	addi	a5,a5,1592 # 20000638 <Ready_threadList_End>
     e96:	97b6                	add	a5,a5,a3
     e98:	0af70063          	beq	a4,a5,f38 <MC_schedule+0x10a>
        {
            to_thread = Ready_threadList_Start[i].next;
     e9c:	20000737          	lui	a4,0x20000
     ea0:	fe442783          	lw	a5,-28(s0)
     ea4:	43870713          	addi	a4,a4,1080 # 20000438 <Ready_threadList_Start>
     ea8:	078e                	slli	a5,a5,0x3
     eaa:	97ba                	add	a5,a5,a4
     eac:	43dc                	lw	a5,4(a5)
     eae:	fef42423          	sw	a5,-24(s0)
            Ready_threadList_Start[i].next = to_thread->next;
     eb2:	fe842783          	lw	a5,-24(s0)
     eb6:	43d8                	lw	a4,4(a5)
     eb8:	200006b7          	lui	a3,0x20000
     ebc:	fe442783          	lw	a5,-28(s0)
     ec0:	43868693          	addi	a3,a3,1080 # 20000438 <Ready_threadList_Start>
     ec4:	078e                	slli	a5,a5,0x3
     ec6:	97b6                	add	a5,a5,a3
     ec8:	c3d8                	sw	a4,4(a5)
            to_thread->next->prev = (MC_thread_t)&Ready_threadList_Start[i];
     eca:	fe842783          	lw	a5,-24(s0)
     ece:	43dc                	lw	a5,4(a5)
     ed0:	fe442703          	lw	a4,-28(s0)
     ed4:	00371693          	slli	a3,a4,0x3
     ed8:	20000737          	lui	a4,0x20000
     edc:	43870713          	addi	a4,a4,1080 # 20000438 <Ready_threadList_Start>
     ee0:	9736                	add	a4,a4,a3
     ee2:	c398                	sw	a4,0(a5)

            to_thread->next = (MC_thread_t)&Ready_threadList_End[i];
     ee4:	fe442783          	lw	a5,-28(s0)
     ee8:	00379713          	slli	a4,a5,0x3
     eec:	200007b7          	lui	a5,0x20000
     ef0:	63878793          	addi	a5,a5,1592 # 20000638 <Ready_threadList_End>
     ef4:	973e                	add	a4,a4,a5
     ef6:	fe842783          	lw	a5,-24(s0)
     efa:	c3d8                	sw	a4,4(a5)
            to_thread->prev = Ready_threadList_End[i].prev;
     efc:	200007b7          	lui	a5,0x20000
     f00:	fe442703          	lw	a4,-28(s0)
     f04:	070e                	slli	a4,a4,0x3
     f06:	63878793          	addi	a5,a5,1592 # 20000638 <Ready_threadList_End>
     f0a:	97ba                	add	a5,a5,a4
     f0c:	4398                	lw	a4,0(a5)
     f0e:	fe842783          	lw	a5,-24(s0)
     f12:	c398                	sw	a4,0(a5)
            Ready_threadList_End[i].prev = to_thread;
     f14:	200007b7          	lui	a5,0x20000
     f18:	fe442703          	lw	a4,-28(s0)
     f1c:	070e                	slli	a4,a4,0x3
     f1e:	63878793          	addi	a5,a5,1592 # 20000638 <Ready_threadList_End>
     f22:	97ba                	add	a5,a5,a4
     f24:	fe842703          	lw	a4,-24(s0)
     f28:	c398                	sw	a4,0(a5)
            to_thread->prev->next = to_thread;
     f2a:	fe842783          	lw	a5,-24(s0)
     f2e:	439c                	lw	a5,0(a5)
     f30:	fe842703          	lw	a4,-24(s0)
     f34:	c3d8                	sw	a4,4(a5)

            break;
     f36:	a811                	j	f4a <MC_schedule+0x11c>
    for(int i = 63; i >= 0; i--)
     f38:	fe442783          	lw	a5,-28(s0)
     f3c:	17fd                	addi	a5,a5,-1
     f3e:	fef42223          	sw	a5,-28(s0)
     f42:	fe442783          	lw	a5,-28(s0)
     f46:	f207d7e3          	bgez	a5,e74 <MC_schedule+0x46>
        }
    }
    
    if(to_thread == NULL)
     f4a:	fe842783          	lw	a5,-24(s0)
     f4e:	cf85                	beqz	a5,f86 <MC_schedule+0x158>
    {
        return ;
    }

    if(from_thread != to_thread)
     f50:	fec42703          	lw	a4,-20(s0)
     f54:	fe842783          	lw	a5,-24(s0)
     f58:	02f70963          	beq	a4,a5,f8a <MC_schedule+0x15c>
    {
        MC_scheduler.running_thread = to_thread;
     f5c:	200007b7          	lui	a5,0x20000
     f60:	43078793          	addi	a5,a5,1072 # 20000430 <MC_scheduler>
     f64:	fe842703          	lw	a4,-24(s0)
     f68:	c3d8                	sw	a4,4(a5)
        MC_timer_list_insert(&to_thread->timer.node);
     f6a:	fe842783          	lw	a5,-24(s0)
     f6e:	05078793          	addi	a5,a5,80
     f72:	853e                	mv	a0,a5
     f74:	2b2d                	jal	14ae <MC_timer_list_insert>

        MC_hw_context_switch(to_thread->stack_addr);
     f76:	fe842783          	lw	a5,-24(s0)
     f7a:	53dc                	lw	a5,36(a5)
     f7c:	853e                	mv	a0,a5
     f7e:	b42ff0ef          	jal	ra,2c0 <MC_hw_context_switch>
    }

    return;
     f82:	0001                	nop
     f84:	a019                	j	f8a <MC_schedule+0x15c>
        return ;
     f86:	0001                	nop
     f88:	a011                	j	f8c <MC_schedule+0x15e>
    return;
     f8a:	0001                	nop
}
     f8c:	40f2                	lw	ra,28(sp)
     f8e:	4462                	lw	s0,24(sp)
     f90:	6105                	addi	sp,sp,32
     f92:	8082                	ret

00000f94 <MC_scheduler_begin>:

/**
 * 发起一次调度
 */
void MC_scheduler_begin()
{
     f94:	1141                	addi	sp,sp,-16
     f96:	c606                	sw	ra,12(sp)
     f98:	c422                	sw	s0,8(sp)
     f9a:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_STOP)
     f9c:	200007b7          	lui	a5,0x20000
     fa0:	4307c783          	lbu	a5,1072(a5) # 20000430 <MC_scheduler>
     fa4:	e791                	bnez	a5,fb0 <MC_scheduler_begin+0x1c>
    {
        MC_scheduler.sched_state = SCHED_RUNNING;
     fa6:	200007b7          	lui	a5,0x20000
     faa:	4705                	li	a4,1
     fac:	42e78823          	sb	a4,1072(a5) # 20000430 <MC_scheduler>
    }
    //在软件中断中调度下一个线程
    MC_schedule_flag = 1;
     fb0:	200007b7          	lui	a5,0x20000
     fb4:	4705                	li	a4,1
     fb6:	40e78823          	sb	a4,1040(a5) # 20000410 <MC_schedule_flag>
    MC_pfic_pending_set(SOFTWARE_IRQ);
     fba:	4539                	li	a0,14
     fbc:	265000ef          	jal	ra,1a20 <MC_pfic_pending_set>
    return ;
     fc0:	0001                	nop
}
     fc2:	40b2                	lw	ra,12(sp)
     fc4:	4422                	lw	s0,8(sp)
     fc6:	0141                	addi	sp,sp,16
     fc8:	8082                	ret

00000fca <MC_scheduler_start>:

/**
 * 开启调度器
 */
void MC_scheduler_start()
{
     fca:	1141                	addi	sp,sp,-16
     fcc:	c622                	sw	s0,12(sp)
     fce:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_STOP)
     fd0:	200007b7          	lui	a5,0x20000
     fd4:	4307c783          	lbu	a5,1072(a5) # 20000430 <MC_scheduler>
     fd8:	e391                	bnez	a5,fdc <MC_scheduler_start+0x12>
    {
        MC_scheduler.sched_state == SCHED_RUNNING;
    }
    return ;
     fda:	0001                	nop
     fdc:	0001                	nop
}
     fde:	4432                	lw	s0,12(sp)
     fe0:	0141                	addi	sp,sp,16
     fe2:	8082                	ret

00000fe4 <MC_scheduler_stop>:

/**
 * 关闭调度器
 */
void MC_scheduler_stop()
{
     fe4:	1141                	addi	sp,sp,-16
     fe6:	c622                	sw	s0,12(sp)
     fe8:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_RUNNING)
     fea:	200007b7          	lui	a5,0x20000
     fee:	4307c703          	lbu	a4,1072(a5) # 20000430 <MC_scheduler>
     ff2:	4785                	li	a5,1
     ff4:	00f71363          	bne	a4,a5,ffa <MC_scheduler_stop+0x16>
    {
        MC_scheduler.sched_state == SCHED_STOP;
    }
    return ;
     ff8:	0001                	nop
     ffa:	0001                	nop
}
     ffc:	4432                	lw	s0,12(sp)
     ffe:	0141                	addi	sp,sp,16
    1000:	8082                	ret

00001002 <_thread_init>:
                uint8_t *stack_start,
                size_t stack_size,
                uint8_t priority,
                uint32_t tick,
                uint8_t flag)
{
    1002:	7139                	addi	sp,sp,-64
    1004:	de06                	sw	ra,60(sp)
    1006:	dc22                	sw	s0,56(sp)
    1008:	0080                	addi	s0,sp,64
    100a:	fca42e23          	sw	a0,-36(s0)
    100e:	fcb42c23          	sw	a1,-40(s0)
    1012:	fcc42a23          	sw	a2,-44(s0)
    1016:	fcd42823          	sw	a3,-48(s0)
    101a:	fce42623          	sw	a4,-52(s0)
    101e:	fd042223          	sw	a6,-60(s0)
    1022:	8746                	mv	a4,a7
    1024:	fcf405a3          	sb	a5,-53(s0)
    1028:	87ba                	mv	a5,a4
    102a:	fcf40523          	sb	a5,-54(s0)
    size_t name_len = MC_strlen(name);
    102e:	fd842503          	lw	a0,-40(s0)
    1032:	2689                	jal	1374 <MC_strlen>
    1034:	fea42623          	sw	a0,-20(s0)
    MC_memcpy(thread->name, name, name_len);
    1038:	fdc42783          	lw	a5,-36(s0)
    103c:	07a1                	addi	a5,a5,8
    103e:	fec42703          	lw	a4,-20(s0)
    1042:	863a                	mv	a2,a4
    1044:	fd842583          	lw	a1,-40(s0)
    1048:	853e                	mv	a0,a5
    104a:	2c4d                	jal	12fc <MC_memcpy>
    thread->sp = stack_start + stack_size;
    104c:	fd042703          	lw	a4,-48(s0)
    1050:	fcc42783          	lw	a5,-52(s0)
    1054:	973e                	add	a4,a4,a5
    1056:	fdc42783          	lw	a5,-36(s0)
    105a:	cfd8                	sw	a4,28(a5)
    thread->entry = entry;
    105c:	fdc42783          	lw	a5,-36(s0)
    1060:	fd442703          	lw	a4,-44(s0)
    1064:	d398                	sw	a4,32(a5)
    thread->stack_addr = stack_start;
    1066:	fdc42783          	lw	a5,-36(s0)
    106a:	fd042703          	lw	a4,-48(s0)
    106e:	d3d8                	sw	a4,36(a5)
    thread->stack_size = stack_size;
    1070:	fdc42783          	lw	a5,-36(s0)
    1074:	fcc42703          	lw	a4,-52(s0)
    1078:	d798                	sw	a4,40(a5)
    thread->priority = priority;
    107a:	fdc42783          	lw	a5,-36(s0)
    107e:	fcb44703          	lbu	a4,-53(s0)
    1082:	02e78623          	sb	a4,44(a5)

    MC_timer_init(&thread->timer,
    1086:	fdc42783          	lw	a5,-36(s0)
    108a:	03078513          	addi	a0,a5,48
    108e:	4791                	li	a5,4
    1090:	fc442703          	lw	a4,-60(s0)
    1094:	4681                	li	a3,0
    1096:	4601                	li	a2,0
    1098:	fd842583          	lw	a1,-40(s0)
    109c:	2b41                	jal	162c <MC_timer_init>
        name,
        NULL, 
        NULL, 
        tick, 
        MC_TIMER_FLAG_THREAD_TIMER);
}
    109e:	0001                	nop
    10a0:	50f2                	lw	ra,60(sp)
    10a2:	5462                	lw	s0,56(sp)
    10a4:	6121                	addi	sp,sp,64
    10a6:	8082                	ret

000010a8 <MC_threadList_Init>:

void MC_threadList_Init()
{
    10a8:	1101                	addi	sp,sp,-32
    10aa:	ce22                	sw	s0,28(sp)
    10ac:	1000                	addi	s0,sp,32
    for(int i = 0; i < 64; i++)
    10ae:	fe042623          	sw	zero,-20(s0)
    10b2:	a8b5                	j	112e <MC_threadList_Init+0x86>
    {
        Ready_threadList_Start[i].prev = NULL;
    10b4:	200007b7          	lui	a5,0x20000
    10b8:	fec42703          	lw	a4,-20(s0)
    10bc:	070e                	slli	a4,a4,0x3
    10be:	43878793          	addi	a5,a5,1080 # 20000438 <Ready_threadList_Start>
    10c2:	97ba                	add	a5,a5,a4
    10c4:	0007a023          	sw	zero,0(a5)
        Ready_threadList_Start[i].next = (MC_thread_t)&Ready_threadList_End[i];
    10c8:	fec42783          	lw	a5,-20(s0)
    10cc:	00379713          	slli	a4,a5,0x3
    10d0:	200007b7          	lui	a5,0x20000
    10d4:	63878793          	addi	a5,a5,1592 # 20000638 <Ready_threadList_End>
    10d8:	973e                	add	a4,a4,a5
    10da:	200006b7          	lui	a3,0x20000
    10de:	fec42783          	lw	a5,-20(s0)
    10e2:	43868693          	addi	a3,a3,1080 # 20000438 <Ready_threadList_Start>
    10e6:	078e                	slli	a5,a5,0x3
    10e8:	97b6                	add	a5,a5,a3
    10ea:	c3d8                	sw	a4,4(a5)

        Ready_threadList_End[i].prev = (MC_thread_t)&Ready_threadList_Start[i];
    10ec:	fec42783          	lw	a5,-20(s0)
    10f0:	00379713          	slli	a4,a5,0x3
    10f4:	200007b7          	lui	a5,0x20000
    10f8:	43878793          	addi	a5,a5,1080 # 20000438 <Ready_threadList_Start>
    10fc:	973e                	add	a4,a4,a5
    10fe:	200007b7          	lui	a5,0x20000
    1102:	fec42683          	lw	a3,-20(s0)
    1106:	068e                	slli	a3,a3,0x3
    1108:	63878793          	addi	a5,a5,1592 # 20000638 <Ready_threadList_End>
    110c:	97b6                	add	a5,a5,a3
    110e:	c398                	sw	a4,0(a5)
        Ready_threadList_End[i].next = NULL;
    1110:	20000737          	lui	a4,0x20000
    1114:	fec42783          	lw	a5,-20(s0)
    1118:	63870713          	addi	a4,a4,1592 # 20000638 <Ready_threadList_End>
    111c:	078e                	slli	a5,a5,0x3
    111e:	97ba                	add	a5,a5,a4
    1120:	0007a223          	sw	zero,4(a5)
    for(int i = 0; i < 64; i++)
    1124:	fec42783          	lw	a5,-20(s0)
    1128:	0785                	addi	a5,a5,1
    112a:	fef42623          	sw	a5,-20(s0)
    112e:	fec42703          	lw	a4,-20(s0)
    1132:	03f00793          	li	a5,63
    1136:	f6e7dfe3          	bge	a5,a4,10b4 <MC_threadList_Init+0xc>
    }
}
    113a:	0001                	nop
    113c:	4472                	lw	s0,28(sp)
    113e:	6105                	addi	sp,sp,32
    1140:	8082                	ret

00001142 <MC_thread_create>:
                            void (*entry)(void),
                            size_t stack_size,
                            uint8_t priority,
                            uint32_t tick,
                            uint8_t flag)
{
    1142:	7139                	addi	sp,sp,-64
    1144:	de06                	sw	ra,60(sp)
    1146:	dc22                	sw	s0,56(sp)
    1148:	0080                	addi	s0,sp,64
    114a:	fca42e23          	sw	a0,-36(s0)
    114e:	fcb42c23          	sw	a1,-40(s0)
    1152:	fcc42a23          	sw	a2,-44(s0)
    1156:	fce42623          	sw	a4,-52(s0)
    115a:	873e                	mv	a4,a5
    115c:	87b6                	mv	a5,a3
    115e:	fcf409a3          	sb	a5,-45(s0)
    1162:	87ba                	mv	a5,a4
    1164:	fcf40923          	sb	a5,-46(s0)
    MC_thread_t thread;
    uint8_t *stack_start;

    if(Ready_threadList_Start[0].next == NULL)
    1168:	200007b7          	lui	a5,0x20000
    116c:	43878793          	addi	a5,a5,1080 # 20000438 <Ready_threadList_Start>
    1170:	43dc                	lw	a5,4(a5)
    1172:	e391                	bnez	a5,1176 <MC_thread_create+0x34>
    {
        MC_threadList_Init();
    1174:	3f15                	jal	10a8 <MC_threadList_Init>
    }

    thread = (MC_thread_t)MC_PageMalloc(sizeof(struct MC_thread));
    1176:	06000513          	li	a0,96
    117a:	cd4ff0ef          	jal	ra,64e <MC_PageMalloc>
    117e:	fea42623          	sw	a0,-20(s0)
    if(thread == NULL)
    1182:	fec42783          	lw	a5,-20(s0)
    1186:	e399                	bnez	a5,118c <MC_thread_create+0x4a>
    {
        return NULL;
    1188:	4781                	li	a5,0
    118a:	a0b9                	j	11d8 <MC_thread_create+0x96>
    }

    stack_size = stack_size + extra_size_for_context;
    118c:	08000793          	li	a5,128
    1190:	fd442703          	lw	a4,-44(s0)
    1194:	97ba                	add	a5,a5,a4
    1196:	fcf42a23          	sw	a5,-44(s0)
    stack_start = (uint8_t *)MC_PageMalloc(stack_size);
    119a:	fd442503          	lw	a0,-44(s0)
    119e:	cb0ff0ef          	jal	ra,64e <MC_PageMalloc>
    11a2:	fea42423          	sw	a0,-24(s0)
    if(stack_start == NULL)
    11a6:	fe842783          	lw	a5,-24(s0)
    11aa:	e399                	bnez	a5,11b0 <MC_thread_create+0x6e>
    {
        return NULL;
    11ac:	4781                	li	a5,0
    11ae:	a02d                	j	11d8 <MC_thread_create+0x96>
    }

    _thread_init(thread,
    11b0:	fd244703          	lbu	a4,-46(s0)
    11b4:	fd344783          	lbu	a5,-45(s0)
    11b8:	88ba                	mv	a7,a4
    11ba:	fcc42803          	lw	a6,-52(s0)
    11be:	fd442703          	lw	a4,-44(s0)
    11c2:	fe842683          	lw	a3,-24(s0)
    11c6:	fd842603          	lw	a2,-40(s0)
    11ca:	fdc42583          	lw	a1,-36(s0)
    11ce:	fec42503          	lw	a0,-20(s0)
    11d2:	3d05                	jal	1002 <_thread_init>
                stack_size,
                priority,
                tick,
                flag);
    
    return thread;
    11d4:	fec42783          	lw	a5,-20(s0)
}
    11d8:	853e                	mv	a0,a5
    11da:	50f2                	lw	ra,60(sp)
    11dc:	5462                	lw	s0,56(sp)
    11de:	6121                	addi	sp,sp,64
    11e0:	8082                	ret

000011e2 <MC_thread_delete>:

uint8_t MC_thread_delete(MC_thread_t thread)
{
    11e2:	1101                	addi	sp,sp,-32
    11e4:	ce06                	sw	ra,28(sp)
    11e6:	cc22                	sw	s0,24(sp)
    11e8:	1000                	addi	s0,sp,32
    11ea:	fea42623          	sw	a0,-20(s0)
    thread->next->prev = thread->prev;
    11ee:	fec42783          	lw	a5,-20(s0)
    11f2:	43dc                	lw	a5,4(a5)
    11f4:	fec42703          	lw	a4,-20(s0)
    11f8:	4318                	lw	a4,0(a4)
    11fa:	c398                	sw	a4,0(a5)
    thread->prev->next = thread->next;
    11fc:	fec42783          	lw	a5,-20(s0)
    1200:	439c                	lw	a5,0(a5)
    1202:	fec42703          	lw	a4,-20(s0)
    1206:	4358                	lw	a4,4(a4)
    1208:	c3d8                	sw	a4,4(a5)

    MC_PageFree(thread);
    120a:	fec42503          	lw	a0,-20(s0)
    120e:	ea8ff0ef          	jal	ra,8b6 <MC_PageFree>
    MC_PageFree(thread->stack_addr);
    1212:	fec42783          	lw	a5,-20(s0)
    1216:	53dc                	lw	a5,36(a5)
    1218:	853e                	mv	a0,a5
    121a:	e9cff0ef          	jal	ra,8b6 <MC_PageFree>
    return 0;
    121e:	4781                	li	a5,0
}
    1220:	853e                	mv	a0,a5
    1222:	40f2                	lw	ra,28(sp)
    1224:	4462                	lw	s0,24(sp)
    1226:	6105                	addi	sp,sp,32
    1228:	8082                	ret

0000122a <MC_thread_startup>:
extern struct MC_sched MC_scheduler;
/**
 * 把任务加入就绪队列
 */
uint8_t MC_thread_startup(MC_thread_t thread)
{
    122a:	7179                	addi	sp,sp,-48
    122c:	d622                	sw	s0,44(sp)
    122e:	1800                	addi	s0,sp,48
    1230:	fca42e23          	sw	a0,-36(s0)
    uint8_t priority = thread->priority;
    1234:	fdc42783          	lw	a5,-36(s0)
    1238:	02c7c783          	lbu	a5,44(a5)
    123c:	fef407a3          	sb	a5,-17(s0)

    *(size_t *)((uint8_t *)(thread->stack_addr) + 0) = (size_t)thread->entry;
    1240:	fdc42783          	lw	a5,-36(s0)
    1244:	5398                	lw	a4,32(a5)
    1246:	fdc42783          	lw	a5,-36(s0)
    124a:	53dc                	lw	a5,36(a5)
    124c:	c398                	sw	a4,0(a5)
    *(size_t *)((uint8_t *)(thread->stack_addr) + 4) = (size_t)thread->sp;
    124e:	fdc42783          	lw	a5,-36(s0)
    1252:	4fd8                	lw	a4,28(a5)
    1254:	fdc42783          	lw	a5,-36(s0)
    1258:	53dc                	lw	a5,36(a5)
    125a:	0791                	addi	a5,a5,4
    125c:	c398                	sw	a4,0(a5)
    *(size_t *)((uint8_t *)(thread->stack_addr) + 8) = (size_t)thread->entry;//应对首次调度，mepc值不确定的情况
    125e:	fdc42783          	lw	a5,-36(s0)
    1262:	5398                	lw	a4,32(a5)
    1264:	fdc42783          	lw	a5,-36(s0)
    1268:	53dc                	lw	a5,36(a5)
    126a:	07a1                	addi	a5,a5,8
    126c:	c398                	sw	a4,0(a5)

    thread->prev = (MC_thread_t)&Ready_threadList_Start[priority];
    126e:	fef44783          	lbu	a5,-17(s0)
    1272:	00379713          	slli	a4,a5,0x3
    1276:	200007b7          	lui	a5,0x20000
    127a:	43878793          	addi	a5,a5,1080 # 20000438 <Ready_threadList_Start>
    127e:	973e                	add	a4,a4,a5
    1280:	fdc42783          	lw	a5,-36(s0)
    1284:	c398                	sw	a4,0(a5)
    thread->next = Ready_threadList_Start[priority].next;
    1286:	fef44783          	lbu	a5,-17(s0)
    128a:	20000737          	lui	a4,0x20000
    128e:	43870713          	addi	a4,a4,1080 # 20000438 <Ready_threadList_Start>
    1292:	078e                	slli	a5,a5,0x3
    1294:	97ba                	add	a5,a5,a4
    1296:	43d8                	lw	a4,4(a5)
    1298:	fdc42783          	lw	a5,-36(s0)
    129c:	c3d8                	sw	a4,4(a5)

    Ready_threadList_Start[priority].next = thread;
    129e:	fef44783          	lbu	a5,-17(s0)
    12a2:	20000737          	lui	a4,0x20000
    12a6:	43870713          	addi	a4,a4,1080 # 20000438 <Ready_threadList_Start>
    12aa:	078e                	slli	a5,a5,0x3
    12ac:	97ba                	add	a5,a5,a4
    12ae:	fdc42703          	lw	a4,-36(s0)
    12b2:	c3d8                	sw	a4,4(a5)
    thread->next->prev = thread;
    12b4:	fdc42783          	lw	a5,-36(s0)
    12b8:	43dc                	lw	a5,4(a5)
    12ba:	fdc42703          	lw	a4,-36(s0)
    12be:	c398                	sw	a4,0(a5)
    return 0;
    12c0:	4781                	li	a5,0
}
    12c2:	853e                	mv	a0,a5
    12c4:	5432                	lw	s0,44(sp)
    12c6:	6145                	addi	sp,sp,48
    12c8:	8082                	ret

000012ca <MC_thread_yield>:

/**
 * 线程调度
*/
void MC_thread_yield()
{
    12ca:	1141                	addi	sp,sp,-16
    12cc:	c606                	sw	ra,12(sp)
    12ce:	c422                	sw	s0,8(sp)
    12d0:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_RUNNING)
    12d2:	200007b7          	lui	a5,0x20000
    12d6:	4307c703          	lbu	a4,1072(a5) # 20000430 <MC_scheduler>
    12da:	4785                	li	a5,1
    12dc:	00f71b63          	bne	a4,a5,12f2 <MC_thread_yield+0x28>
    {
        //在软件中断中调度下一个线程
        MC_schedule_flag = 1;
    12e0:	200007b7          	lui	a5,0x20000
    12e4:	4705                	li	a4,1
    12e6:	40e78823          	sb	a4,1040(a5) # 20000410 <MC_schedule_flag>
        MC_pfic_pending_set(SOFTWARE_IRQ);
    12ea:	4539                	li	a0,14
    12ec:	734000ef          	jal	ra,1a20 <MC_pfic_pending_set>
    }
    return;
    12f0:	0001                	nop
    12f2:	0001                	nop
    12f4:	40b2                	lw	ra,12(sp)
    12f6:	4422                	lw	s0,8(sp)
    12f8:	0141                	addi	sp,sp,16
    12fa:	8082                	ret

000012fc <MC_memcpy>:
#include "os.h"

void MC_memcpy(char *dst, char *src, int len)
{
    12fc:	7179                	addi	sp,sp,-48
    12fe:	d622                	sw	s0,44(sp)
    1300:	1800                	addi	s0,sp,48
    1302:	fca42e23          	sw	a0,-36(s0)
    1306:	fcb42c23          	sw	a1,-40(s0)
    130a:	fcc42a23          	sw	a2,-44(s0)
    if(dst == NULL || src == NULL || len <= 0)
    130e:	fdc42783          	lw	a5,-36(s0)
    1312:	cfa9                	beqz	a5,136c <MC_memcpy+0x70>
    1314:	fd842783          	lw	a5,-40(s0)
    1318:	cbb1                	beqz	a5,136c <MC_memcpy+0x70>
    131a:	fd442783          	lw	a5,-44(s0)
    131e:	04f05763          	blez	a5,136c <MC_memcpy+0x70>
        return;

    for(int i = 0; i < len; i++)
    1322:	fe042623          	sw	zero,-20(s0)
    1326:	a825                	j	135e <MC_memcpy+0x62>
    {
        *(dst + i) = *(src + i);
    1328:	fec42783          	lw	a5,-20(s0)
    132c:	fd842703          	lw	a4,-40(s0)
    1330:	973e                	add	a4,a4,a5
    1332:	fec42783          	lw	a5,-20(s0)
    1336:	fdc42683          	lw	a3,-36(s0)
    133a:	97b6                	add	a5,a5,a3
    133c:	00074703          	lbu	a4,0(a4)
    1340:	00e78023          	sb	a4,0(a5)
        *(dst + i + 1) = '\0';
    1344:	fec42783          	lw	a5,-20(s0)
    1348:	0785                	addi	a5,a5,1
    134a:	fdc42703          	lw	a4,-36(s0)
    134e:	97ba                	add	a5,a5,a4
    1350:	00078023          	sb	zero,0(a5)
    for(int i = 0; i < len; i++)
    1354:	fec42783          	lw	a5,-20(s0)
    1358:	0785                	addi	a5,a5,1
    135a:	fef42623          	sw	a5,-20(s0)
    135e:	fec42703          	lw	a4,-20(s0)
    1362:	fd442783          	lw	a5,-44(s0)
    1366:	fcf741e3          	blt	a4,a5,1328 <MC_memcpy+0x2c>
    136a:	a011                	j	136e <MC_memcpy+0x72>
        return;
    136c:	0001                	nop
    }
}
    136e:	5432                	lw	s0,44(sp)
    1370:	6145                	addi	sp,sp,48
    1372:	8082                	ret

00001374 <MC_strlen>:

size_t MC_strlen(char *src)
{
    1374:	7179                	addi	sp,sp,-48
    1376:	d622                	sw	s0,44(sp)
    1378:	1800                	addi	s0,sp,48
    137a:	fca42e23          	sw	a0,-36(s0)
    size_t len = 0;
    137e:	fe042623          	sw	zero,-20(s0)
    while(*src++) len++;
    1382:	a031                	j	138e <MC_strlen+0x1a>
    1384:	fec42783          	lw	a5,-20(s0)
    1388:	0785                	addi	a5,a5,1
    138a:	fef42623          	sw	a5,-20(s0)
    138e:	fdc42783          	lw	a5,-36(s0)
    1392:	00178713          	addi	a4,a5,1
    1396:	fce42e23          	sw	a4,-36(s0)
    139a:	0007c783          	lbu	a5,0(a5)
    139e:	f3fd                	bnez	a5,1384 <MC_strlen+0x10>
    return len;
    13a0:	fec42783          	lw	a5,-20(s0)
    13a4:	853e                	mv	a0,a5
    13a6:	5432                	lw	s0,44(sp)
    13a8:	6145                	addi	sp,sp,48
    13aa:	8082                	ret

000013ac <r_mstatus>:
{
    13ac:	1101                	addi	sp,sp,-32
    13ae:	ce22                	sw	s0,28(sp)
    13b0:	1000                	addi	s0,sp,32
	asm volatile("csrr %0, mstatus" : "=r" (x) );
    13b2:	300027f3          	csrr	a5,mstatus
    13b6:	fef42623          	sw	a5,-20(s0)
	return x;
    13ba:	fec42783          	lw	a5,-20(s0)
}
    13be:	853e                	mv	a0,a5
    13c0:	4472                	lw	s0,28(sp)
    13c2:	6105                	addi	sp,sp,32
    13c4:	8082                	ret
    13c6:	0001                	nop

000013c8 <w_mstatus>:
{
    13c8:	1101                	addi	sp,sp,-32
    13ca:	ce22                	sw	s0,28(sp)
    13cc:	1000                	addi	s0,sp,32
    13ce:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mstatus, %0" : : "r" (x));
    13d2:	fec42783          	lw	a5,-20(s0)
    13d6:	30079073          	csrw	mstatus,a5
}
    13da:	0001                	nop
    13dc:	4472                	lw	s0,28(sp)
    13de:	6105                	addi	sp,sp,32
    13e0:	8082                	ret
    13e2:	0001                	nop

000013e4 <w_mtvec>:

/* Machine-mode trap vector */
static inline __attribute__((aligned(4))) void w_mtvec(reg_t x)
{
    13e4:	1101                	addi	sp,sp,-32
    13e6:	ce22                	sw	s0,28(sp)
    13e8:	1000                	addi	s0,sp,32
    13ea:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mtvec, %0" : : "r" (x));
    13ee:	fec42783          	lw	a5,-20(s0)
    13f2:	30579073          	csrw	mtvec,a5
}
    13f6:	0001                	nop
    13f8:	4472                	lw	s0,28(sp)
    13fa:	6105                	addi	sp,sp,32
    13fc:	8082                	ret

000013fe <__DISENABLE_INTERRUPT__>:
#include "os.h"
extern void trap_handler_base();

void __DISENABLE_INTERRUPT__()
{
    13fe:	1141                	addi	sp,sp,-16
    1400:	c606                	sw	ra,12(sp)
    1402:	c422                	sw	s0,8(sp)
    1404:	0800                	addi	s0,sp,16
    w_mstatus(r_mstatus() & ~(1 << 3)); // 全局中断关闭
    1406:	375d                	jal	13ac <r_mstatus>
    1408:	87aa                	mv	a5,a0
    140a:	9bdd                	andi	a5,a5,-9
    140c:	853e                	mv	a0,a5
    140e:	3f6d                	jal	13c8 <w_mstatus>
}
    1410:	0001                	nop
    1412:	40b2                	lw	ra,12(sp)
    1414:	4422                	lw	s0,8(sp)
    1416:	0141                	addi	sp,sp,16
    1418:	8082                	ret

0000141a <__ENABLE_INTERRUPT__>:

void __ENABLE_INTERRUPT__()
{
    141a:	1141                	addi	sp,sp,-16
    141c:	c606                	sw	ra,12(sp)
    141e:	c422                	sw	s0,8(sp)
    1420:	0800                	addi	s0,sp,16
    w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
    1422:	3769                	jal	13ac <r_mstatus>
    1424:	87aa                	mv	a5,a0
    1426:	0087e793          	ori	a5,a5,8
    142a:	853e                	mv	a0,a5
    142c:	3f71                	jal	13c8 <w_mstatus>
}
    142e:	0001                	nop
    1430:	40b2                	lw	ra,12(sp)
    1432:	4422                	lw	s0,8(sp)
    1434:	0141                	addi	sp,sp,16
    1436:	8082                	ret

00001438 <MC_trap_init>:

void MC_trap_init()
{
    1438:	1101                	addi	sp,sp,-32
    143a:	ce06                	sw	ra,28(sp)
    143c:	cc22                	sw	s0,24(sp)
    143e:	1000                	addi	s0,sp,32
    ptr_t base = (ptr_t)trap_handler_base;
    1440:	000007b7          	lui	a5,0x0
    1444:	05878793          	addi	a5,a5,88 # 58 <trap_handler_base>
    1448:	fef42623          	sw	a5,-20(s0)
    uint32_t mtvec = 0x00000001;
    144c:	4785                	li	a5,1
    144e:	fef42423          	sw	a5,-24(s0)
    mtvec |= (base);
    1452:	fe842703          	lw	a4,-24(s0)
    1456:	fec42783          	lw	a5,-20(s0)
    145a:	8fd9                	or	a5,a5,a4
    145c:	fef42423          	sw	a5,-24(s0)
    w_mtvec(mtvec);
    1460:	fe842503          	lw	a0,-24(s0)
    1464:	3741                	jal	13e4 <w_mtvec>

    // w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
    // 在main函数再开启全局中断
}
    1466:	0001                	nop
    1468:	40f2                	lw	ra,28(sp)
    146a:	4462                	lw	s0,24(sp)
    146c:	6105                	addi	sp,sp,32
    146e:	8082                	ret

00001470 <MC_mtip_handler>:

extern void MC_timer_handler();
void MC_mtip_handler()
{
    1470:	1141                	addi	sp,sp,-16
    1472:	c606                	sw	ra,12(sp)
    1474:	c422                	sw	s0,8(sp)
    1476:	0800                	addi	s0,sp,16
    MC_timer_handler();
    1478:	2935                	jal	18b4 <MC_timer_handler>
}
    147a:	0001                	nop
    147c:	40b2                	lw	ra,12(sp)
    147e:	4422                	lw	s0,8(sp)
    1480:	0141                	addi	sp,sp,16
    1482:	8082                	ret

00001484 <MC_software_handler>:

extern uint8_t MC_schedule_flag;
void MC_software_handler()
{
    1484:	1141                	addi	sp,sp,-16
    1486:	c606                	sw	ra,12(sp)
    1488:	c422                	sw	s0,8(sp)
    148a:	0800                	addi	s0,sp,16
    if(MC_schedule_flag)
    148c:	200007b7          	lui	a5,0x20000
    1490:	4107c783          	lbu	a5,1040(a5) # 20000410 <MC_schedule_flag>
    1494:	c791                	beqz	a5,14a0 <MC_software_handler+0x1c>
    {
        MC_schedule_flag = 0;
    1496:	200007b7          	lui	a5,0x20000
    149a:	40078823          	sb	zero,1040(a5) # 20000410 <MC_schedule_flag>
        MC_schedule();
    149e:	3a41                	jal	e2e <MC_schedule>
    }

    MC_pfic_pending_clear(SOFTWARE_IRQ);
    14a0:	4539                	li	a0,14
    14a2:	2b65                	jal	1a5a <MC_pfic_pending_clear>
    14a4:	0001                	nop
    14a6:	40b2                	lw	ra,12(sp)
    14a8:	4422                	lw	s0,8(sp)
    14aa:	0141                	addi	sp,sp,16
    14ac:	8082                	ret

000014ae <MC_timer_list_insert>:

/**
 * 定时器插入链表
*/
void MC_timer_list_insert(MC_list_t node)
{
    14ae:	7179                	addi	sp,sp,-48
    14b0:	d622                	sw	s0,44(sp)
    14b2:	1800                	addi	s0,sp,48
    14b4:	fca42e23          	sw	a0,-36(s0)
    MC_list_t timerListOperator = timer_list;
    14b8:	200017b7          	lui	a5,0x20001
    14bc:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    14c0:	fef42623          	sw	a5,-20(s0)
    while(timerListOperator->next != NULL)
    14c4:	a839                	j	14e2 <MC_timer_list_insert+0x34>
    {
        if(timerListOperator->next->timeout_tick > node->timeout_tick)
    14c6:	fec42783          	lw	a5,-20(s0)
    14ca:	43dc                	lw	a5,4(a5)
    14cc:	47d8                	lw	a4,12(a5)
    14ce:	fdc42783          	lw	a5,-36(s0)
    14d2:	47dc                	lw	a5,12(a5)
    14d4:	00e7ec63          	bltu	a5,a4,14ec <MC_timer_list_insert+0x3e>
        {
            break;
        }
        timerListOperator = timerListOperator->next;
    14d8:	fec42783          	lw	a5,-20(s0)
    14dc:	43dc                	lw	a5,4(a5)
    14de:	fef42623          	sw	a5,-20(s0)
    while(timerListOperator->next != NULL)
    14e2:	fec42783          	lw	a5,-20(s0)
    14e6:	43dc                	lw	a5,4(a5)
    14e8:	fff9                	bnez	a5,14c6 <MC_timer_list_insert+0x18>
    14ea:	a011                	j	14ee <MC_timer_list_insert+0x40>
            break;
    14ec:	0001                	nop
    }   
    
    if(timerListOperator->next == NULL)
    14ee:	fec42783          	lw	a5,-20(s0)
    14f2:	43dc                	lw	a5,4(a5)
    14f4:	e385                	bnez	a5,1514 <MC_timer_list_insert+0x66>
    {
        timerListOperator->next = node;
    14f6:	fec42783          	lw	a5,-20(s0)
    14fa:	fdc42703          	lw	a4,-36(s0)
    14fe:	c3d8                	sw	a4,4(a5)
        node->prev = timerListOperator;
    1500:	fdc42783          	lw	a5,-36(s0)
    1504:	fec42703          	lw	a4,-20(s0)
    1508:	c398                	sw	a4,0(a5)
        node->next = NULL;
    150a:	fdc42783          	lw	a5,-36(s0)
    150e:	0007a223          	sw	zero,4(a5)
        node->prev = timerListOperator;
        node->next = timerListOperator->next;
        timerListOperator->next = node;
        node->next->prev = node;
    }
}
    1512:	a03d                	j	1540 <MC_timer_list_insert+0x92>
        node->prev = timerListOperator;
    1514:	fdc42783          	lw	a5,-36(s0)
    1518:	fec42703          	lw	a4,-20(s0)
    151c:	c398                	sw	a4,0(a5)
        node->next = timerListOperator->next;
    151e:	fec42783          	lw	a5,-20(s0)
    1522:	43d8                	lw	a4,4(a5)
    1524:	fdc42783          	lw	a5,-36(s0)
    1528:	c3d8                	sw	a4,4(a5)
        timerListOperator->next = node;
    152a:	fec42783          	lw	a5,-20(s0)
    152e:	fdc42703          	lw	a4,-36(s0)
    1532:	c3d8                	sw	a4,4(a5)
        node->next->prev = node;
    1534:	fdc42783          	lw	a5,-36(s0)
    1538:	43dc                	lw	a5,4(a5)
    153a:	fdc42703          	lw	a4,-36(s0)
    153e:	c398                	sw	a4,0(a5)
}
    1540:	0001                	nop
    1542:	5432                	lw	s0,44(sp)
    1544:	6145                	addi	sp,sp,48
    1546:	8082                	ret

00001548 <_timer_init>:
                char *name,
                void (*timeout)(void *parameter),
                void *parameter,
                uint32_t time,
                uint8_t flag)
{
    1548:	7139                	addi	sp,sp,-64
    154a:	de06                	sw	ra,60(sp)
    154c:	dc22                	sw	s0,56(sp)
    154e:	0080                	addi	s0,sp,64
    1550:	fca42e23          	sw	a0,-36(s0)
    1554:	fcb42c23          	sw	a1,-40(s0)
    1558:	fcc42a23          	sw	a2,-44(s0)
    155c:	fcd42823          	sw	a3,-48(s0)
    1560:	fce42623          	sw	a4,-52(s0)
    1564:	fcf405a3          	sb	a5,-53(s0)
    if(timer_list == NULL)
    1568:	200017b7          	lui	a5,0x20001
    156c:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    1570:	eb95                	bnez	a5,15a4 <_timer_init+0x5c>
    {
        timer_list = (MC_list_t)MC_PageMalloc(sizeof(struct MC_list));
    1572:	4541                	li	a0,16
    1574:	8daff0ef          	jal	ra,64e <MC_PageMalloc>
    1578:	872a                	mv	a4,a0
    157a:	200017b7          	lui	a5,0x20001
    157e:	82e7ac23          	sw	a4,-1992(a5) # 20000838 <timer_list>
        if(timer_list == NULL)
    1582:	200017b7          	lui	a5,0x20001
    1586:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    158a:	cfc1                	beqz	a5,1622 <_timer_init+0xda>
        {
            return ;
        }
        timer_list->prev = NULL;
    158c:	200017b7          	lui	a5,0x20001
    1590:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    1594:	0007a023          	sw	zero,0(a5)
        timer_list->next = NULL;
    1598:	200017b7          	lui	a5,0x20001
    159c:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    15a0:	0007a223          	sw	zero,4(a5)
    }

    int len = MC_strlen(name);
    15a4:	fd842503          	lw	a0,-40(s0)
    15a8:	33f1                	jal	1374 <MC_strlen>
    15aa:	87aa                	mv	a5,a0
    15ac:	fef42623          	sw	a5,-20(s0)
    MC_memcpy(timer->name, name, len);
    15b0:	fdc42783          	lw	a5,-36(s0)
    15b4:	fec42603          	lw	a2,-20(s0)
    15b8:	fd842583          	lw	a1,-40(s0)
    15bc:	853e                	mv	a0,a5
    15be:	3b3d                	jal	12fc <MC_memcpy>

    timer->flag = flag;
    15c0:	fdc42783          	lw	a5,-36(s0)
    15c4:	fcb44703          	lbu	a4,-53(s0)
    15c8:	00e78e23          	sb	a4,28(a5)

    /*设置挂起*/
    timer->flag &= 1;
    15cc:	fdc42783          	lw	a5,-36(s0)
    15d0:	01c7c783          	lbu	a5,28(a5)
    15d4:	8b85                	andi	a5,a5,1
    15d6:	0ff7f713          	andi	a4,a5,255
    15da:	fdc42783          	lw	a5,-36(s0)
    15de:	00e78e23          	sb	a4,28(a5)

    timer->timeout_func = timeout;
    15e2:	fdc42783          	lw	a5,-36(s0)
    15e6:	fd442703          	lw	a4,-44(s0)
    15ea:	cbd8                	sw	a4,20(a5)
    timer->parameter = parameter;
    15ec:	fdc42783          	lw	a5,-36(s0)
    15f0:	fd042703          	lw	a4,-48(s0)
    15f4:	cf98                	sw	a4,24(a5)

    timer->node.init_tick = time;
    15f6:	fdc42783          	lw	a5,-36(s0)
    15fa:	fcc42703          	lw	a4,-52(s0)
    15fe:	d798                	sw	a4,40(a5)
    timer->node.timeout_tick = time + MC_get_tick();
    1600:	22c1                	jal	17c0 <MC_get_tick>
    1602:	872a                	mv	a4,a0
    1604:	fcc42783          	lw	a5,-52(s0)
    1608:	973e                	add	a4,a4,a5
    160a:	fdc42783          	lw	a5,-36(s0)
    160e:	d7d8                	sw	a4,44(a5)
    timer->node.prev = NULL;
    1610:	fdc42783          	lw	a5,-36(s0)
    1614:	0207a023          	sw	zero,32(a5)
    timer->node.next = NULL;
    1618:	fdc42783          	lw	a5,-36(s0)
    161c:	0207a223          	sw	zero,36(a5)
    1620:	a011                	j	1624 <_timer_init+0xdc>
            return ;
    1622:	0001                	nop

    // MC_timer_list_insert(&timer->node);
}
    1624:	50f2                	lw	ra,60(sp)
    1626:	5462                	lw	s0,56(sp)
    1628:	6121                	addi	sp,sp,64
    162a:	8082                	ret

0000162c <MC_timer_init>:
                    char *name,
                    void (*timeout)(void *parameter),
                    void *parameter,
                    uint32_t time,
                    uint8_t flag)
{
    162c:	7179                	addi	sp,sp,-48
    162e:	d606                	sw	ra,44(sp)
    1630:	d422                	sw	s0,40(sp)
    1632:	1800                	addi	s0,sp,48
    1634:	fea42623          	sw	a0,-20(s0)
    1638:	feb42423          	sw	a1,-24(s0)
    163c:	fec42223          	sw	a2,-28(s0)
    1640:	fed42023          	sw	a3,-32(s0)
    1644:	fce42e23          	sw	a4,-36(s0)
    1648:	fcf40da3          	sb	a5,-37(s0)
    if(timer == NULL)
    164c:	fec42783          	lw	a5,-20(s0)
    1650:	e399                	bnez	a5,1656 <MC_timer_init+0x2a>
    {
        return 1;
    1652:	4785                	li	a5,1
    1654:	a839                	j	1672 <MC_timer_init+0x46>
    }

    _timer_init(timer, name, timeout, parameter, time, flag);
    1656:	fdb44783          	lbu	a5,-37(s0)
    165a:	fdc42703          	lw	a4,-36(s0)
    165e:	fe042683          	lw	a3,-32(s0)
    1662:	fe442603          	lw	a2,-28(s0)
    1666:	fe842583          	lw	a1,-24(s0)
    166a:	fec42503          	lw	a0,-20(s0)
    166e:	3de9                	jal	1548 <_timer_init>

    return 0;
    1670:	4781                	li	a5,0
}
    1672:	853e                	mv	a0,a5
    1674:	50b2                	lw	ra,44(sp)
    1676:	5422                	lw	s0,40(sp)
    1678:	6145                	addi	sp,sp,48
    167a:	8082                	ret

0000167c <MC_timer_create>:
MC_timer_t MC_timer_create(char *name,
                     void (*timeout)(void *parameter),
                     void *parameter,
                     uint32_t time,
                     uint8_t flag)
{
    167c:	7139                	addi	sp,sp,-64
    167e:	de06                	sw	ra,60(sp)
    1680:	dc22                	sw	s0,56(sp)
    1682:	0080                	addi	s0,sp,64
    1684:	fca42e23          	sw	a0,-36(s0)
    1688:	fcb42c23          	sw	a1,-40(s0)
    168c:	fcc42a23          	sw	a2,-44(s0)
    1690:	fcd42823          	sw	a3,-48(s0)
    1694:	87ba                	mv	a5,a4
    1696:	fcf407a3          	sb	a5,-49(s0)
    MC_timer_t timer;

    timer = (struct MC_timer*)MC_PageMalloc(sizeof(struct MC_timer));
    169a:	03000513          	li	a0,48
    169e:	fb1fe0ef          	jal	ra,64e <MC_PageMalloc>
    16a2:	fea42623          	sw	a0,-20(s0)
    if(timer == NULL)
    16a6:	fec42783          	lw	a5,-20(s0)
    16aa:	e399                	bnez	a5,16b0 <MC_timer_create+0x34>
    {
        return NULL;
    16ac:	4781                	li	a5,0
    16ae:	a005                	j	16ce <MC_timer_create+0x52>
    }
    
    _timer_init(timer, name, timeout, parameter, time, flag);
    16b0:	fcf44783          	lbu	a5,-49(s0)
    16b4:	fd042703          	lw	a4,-48(s0)
    16b8:	fd442683          	lw	a3,-44(s0)
    16bc:	fd842603          	lw	a2,-40(s0)
    16c0:	fdc42583          	lw	a1,-36(s0)
    16c4:	fec42503          	lw	a0,-20(s0)
    16c8:	3541                	jal	1548 <_timer_init>
    return timer;
    16ca:	fec42783          	lw	a5,-20(s0)
}
    16ce:	853e                	mv	a0,a5
    16d0:	50f2                	lw	ra,60(sp)
    16d2:	5462                	lw	s0,56(sp)
    16d4:	6121                	addi	sp,sp,64
    16d6:	8082                	ret

000016d8 <MC_timer_load>:


uint32_t _tick=0;

void MC_timer_load(int interval)
{
    16d8:	7179                	addi	sp,sp,-48
    16da:	d622                	sw	s0,44(sp)
    16dc:	1800                	addi	s0,sp,48
    16de:	fca42e23          	sw	a0,-36(s0)
    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    16e2:	e000f537          	lui	a0,0xe000f
    16e6:	fea42623          	sw	a0,-20(s0)
    uint64_t  mtime;

    mtime = ((uint64_t)(rtk_controller->CNTH) << 32) + rtk_controller->CNTL;
    16ea:	fec42503          	lw	a0,-20(s0)
    16ee:	4548                	lw	a0,12(a0)
    16f0:	87aa                	mv	a5,a0
    16f2:	4801                	li	a6,0
    16f4:	00079713          	slli	a4,a5,0x0
    16f8:	4681                	li	a3,0
    16fa:	fec42783          	lw	a5,-20(s0)
    16fe:	479c                	lw	a5,8(a5)
    1700:	833e                	mv	t1,a5
    1702:	4381                	li	t2,0
    1704:	006687b3          	add	a5,a3,t1
    1708:	853e                	mv	a0,a5
    170a:	00d53533          	sltu	a0,a0,a3
    170e:	00770833          	add	a6,a4,t2
    1712:	01050733          	add	a4,a0,a6
    1716:	883a                	mv	a6,a4
    1718:	fef42023          	sw	a5,-32(s0)
    171c:	ff042223          	sw	a6,-28(s0)
    mtime += interval;
    1720:	fdc42783          	lw	a5,-36(s0)
    1724:	85be                	mv	a1,a5
    1726:	87fd                	srai	a5,a5,0x1f
    1728:	863e                	mv	a2,a5
    172a:	fe042683          	lw	a3,-32(s0)
    172e:	fe442703          	lw	a4,-28(s0)
    1732:	00b687b3          	add	a5,a3,a1
    1736:	853e                	mv	a0,a5
    1738:	00d53533          	sltu	a0,a0,a3
    173c:	00c70833          	add	a6,a4,a2
    1740:	01050733          	add	a4,a0,a6
    1744:	883a                	mv	a6,a4
    1746:	fef42023          	sw	a5,-32(s0)
    174a:	ff042223          	sw	a6,-28(s0)
    rtk_controller->CMPHR = (uint32_t)(mtime >> 32);
    174e:	fe442783          	lw	a5,-28(s0)
    1752:	0007de13          	srli	t3,a5,0x0
    1756:	4e81                	li	t4,0
    1758:	8772                	mv	a4,t3
    175a:	fec42783          	lw	a5,-20(s0)
    175e:	cbd8                	sw	a4,20(a5)
    rtk_controller->CMPLR = (uint32_t)(mtime & 0xffffffff);
    1760:	fe042703          	lw	a4,-32(s0)
    1764:	fec42783          	lw	a5,-20(s0)
    1768:	cb98                	sw	a4,16(a5)

    rtk_controller->CTRL = 0x00000007;
    176a:	fec42783          	lw	a5,-20(s0)
    176e:	471d                	li	a4,7
    1770:	c398                	sw	a4,0(a5)
}
    1772:	0001                	nop
    1774:	5432                	lw	s0,44(sp)
    1776:	6145                	addi	sp,sp,48
    1778:	8082                	ret

0000177a <MC_SysTick_init>:

/**
 * systick init
*/
void MC_SysTick_init()
{
    177a:	1101                	addi	sp,sp,-32
    177c:	ce06                	sw	ra,28(sp)
    177e:	cc22                	sw	s0,24(sp)
    1780:	1000                	addi	s0,sp,32
    PFIC_IENR_t pfic_ienr = (PFIC_IENR_t)PFIC_IENR_BASE;
    1782:	e000e7b7          	lui	a5,0xe000e
    1786:	10078793          	addi	a5,a5,256 # e000e100 <_end_stack+0xbfffe100>
    178a:	fef42623          	sw	a5,-20(s0)
    pfic_ienr->IENRx[0] |= 1 << SYS_TICK_IRQ;//使能systick中断
    178e:	fec42783          	lw	a5,-20(s0)
    1792:	4398                	lw	a4,0(a5)
    1794:	6785                	lui	a5,0x1
    1796:	8f5d                	or	a4,a4,a5
    1798:	fec42783          	lw	a5,-20(s0)
    179c:	c398                	sw	a4,0(a5)
    pfic_ienr->IENRx[0] |= 1 << SOFTWARE_IRQ; //使能软件中断
    179e:	fec42783          	lw	a5,-20(s0)
    17a2:	4398                	lw	a4,0(a5)
    17a4:	6791                	lui	a5,0x4
    17a6:	8f5d                	or	a4,a4,a5
    17a8:	fec42783          	lw	a5,-20(s0)
    17ac:	c398                	sw	a4,0(a5)

    MC_timer_load(TIMER_INTERVAL);
    17ae:	6789                	lui	a5,0x2
    17b0:	f4078513          	addi	a0,a5,-192 # 1f40 <_data_lma+0x38c>
    17b4:	3715                	jal	16d8 <MC_timer_load>
}
    17b6:	0001                	nop
    17b8:	40f2                	lw	ra,28(sp)
    17ba:	4462                	lw	s0,24(sp)
    17bc:	6105                	addi	sp,sp,32
    17be:	8082                	ret

000017c0 <MC_get_tick>:

uint32_t MC_get_tick()
{
    17c0:	1141                	addi	sp,sp,-16
    17c2:	c622                	sw	s0,12(sp)
    17c4:	0800                	addi	s0,sp,16
    return _tick;
    17c6:	200007b7          	lui	a5,0x20000
    17ca:	4147a783          	lw	a5,1044(a5) # 20000414 <_tick>
}
    17ce:	853e                	mv	a0,a5
    17d0:	4432                	lw	s0,12(sp)
    17d2:	0141                	addi	sp,sp,16
    17d4:	8082                	ret

000017d6 <MC_timer_realse>:

/**
 * 执行定时器回调，并设置定时器
*/
void MC_timer_realse(MC_list_t node)
{
    17d6:	7179                	addi	sp,sp,-48
    17d8:	d606                	sw	ra,44(sp)
    17da:	d422                	sw	s0,40(sp)
    17dc:	d226                	sw	s1,36(sp)
    17de:	1800                	addi	s0,sp,48
    17e0:	fca42e23          	sw	a0,-36(s0)
    MC_thread_t thread;
    MC_timer_t timer;

    timer = MC_container_of(node, struct MC_timer, node);
    17e4:	fdc42783          	lw	a5,-36(s0)
    17e8:	1781                	addi	a5,a5,-32
    17ea:	fef42623          	sw	a5,-20(s0)

    thread = MC_container_of(timer, struct MC_thread, timer);
    17ee:	fec42783          	lw	a5,-20(s0)
    17f2:	fd078793          	addi	a5,a5,-48
    17f6:	fef42423          	sw	a5,-24(s0)

    if(node->next != NULL)
    17fa:	fdc42783          	lw	a5,-36(s0)
    17fe:	43dc                	lw	a5,4(a5)
    1800:	c395                	beqz	a5,1824 <MC_timer_realse+0x4e>
    {
        timer_list->next = node->next;
    1802:	200017b7          	lui	a5,0x20001
    1806:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    180a:	fdc42703          	lw	a4,-36(s0)
    180e:	4358                	lw	a4,4(a4)
    1810:	c3d8                	sw	a4,4(a5)
        node->next->prev = timer_list;
    1812:	fdc42783          	lw	a5,-36(s0)
    1816:	43dc                	lw	a5,4(a5)
    1818:	20001737          	lui	a4,0x20001
    181c:	83872703          	lw	a4,-1992(a4) # 20000838 <timer_list>
    1820:	c398                	sw	a4,0(a5)
    1822:	a039                	j	1830 <MC_timer_realse+0x5a>
    }
    else
    {
        timer_list->next = NULL;
    1824:	200017b7          	lui	a5,0x20001
    1828:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    182c:	0007a223          	sw	zero,4(a5)
    }

    if(thread->timer.timeout_func != NULL)
    1830:	fe842783          	lw	a5,-24(s0)
    1834:	43fc                	lw	a5,68(a5)
    1836:	cb89                	beqz	a5,1848 <MC_timer_realse+0x72>
    {
        thread->timer.timeout_func(thread->timer.parameter);
    1838:	fe842783          	lw	a5,-24(s0)
    183c:	43f8                	lw	a4,68(a5)
    183e:	fe842783          	lw	a5,-24(s0)
    1842:	47bc                	lw	a5,72(a5)
    1844:	853e                	mv	a0,a5
    1846:	9702                	jalr	a4
    }
    
    if(thread->timer.flag | MC_TIMER_FLAG_CYCLE_TIMER)
    {
        thread->timer.node.timeout_tick = thread->timer.node.init_tick + MC_get_tick();
    1848:	fe842783          	lw	a5,-24(s0)
    184c:	4fa4                	lw	s1,88(a5)
    184e:	3f8d                	jal	17c0 <MC_get_tick>
    1850:	87aa                	mv	a5,a0
    1852:	00f48733          	add	a4,s1,a5
    1856:	fe842783          	lw	a5,-24(s0)
    185a:	cff8                	sw	a4,92(a5)
    else
    {  
        thread->timer.flag &= ~MC_TIMER_FLAG_ACTIVATED;
    }

    MC_scheduler_begin();
    185c:	f38ff0ef          	jal	ra,f94 <MC_scheduler_begin>
}   
    1860:	0001                	nop
    1862:	50b2                	lw	ra,44(sp)
    1864:	5422                	lw	s0,40(sp)
    1866:	5492                	lw	s1,36(sp)
    1868:	6145                	addi	sp,sp,48
    186a:	8082                	ret

0000186c <MC_timer_check>:

/**
 *  检查定时器超时情况
 */
void MC_timer_check()
{
    186c:	1101                	addi	sp,sp,-32
    186e:	ce06                	sw	ra,28(sp)
    1870:	cc22                	sw	s0,24(sp)
    1872:	1000                	addi	s0,sp,32
    uint32_t next_timeout;
    
    if(timer_list->next != NULL)
    1874:	200017b7          	lui	a5,0x20001
    1878:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    187c:	43dc                	lw	a5,4(a5)
    187e:	c795                	beqz	a5,18aa <MC_timer_check+0x3e>
    {
        next_timeout = timer_list->next->timeout_tick;
    1880:	200017b7          	lui	a5,0x20001
    1884:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    1888:	43dc                	lw	a5,4(a5)
    188a:	47dc                	lw	a5,12(a5)
    188c:	fef42623          	sw	a5,-20(s0)
        if(next_timeout <= MC_get_tick())
    1890:	3f05                	jal	17c0 <MC_get_tick>
    1892:	872a                	mv	a4,a0
    1894:	fec42783          	lw	a5,-20(s0)
    1898:	00f76963          	bltu	a4,a5,18aa <MC_timer_check+0x3e>
        {
            MC_timer_realse(timer_list->next);
    189c:	200017b7          	lui	a5,0x20001
    18a0:	8387a783          	lw	a5,-1992(a5) # 20000838 <timer_list>
    18a4:	43dc                	lw	a5,4(a5)
    18a6:	853e                	mv	a0,a5
    18a8:	373d                	jal	17d6 <MC_timer_realse>
        }
    }
}
    18aa:	0001                	nop
    18ac:	40f2                	lw	ra,28(sp)
    18ae:	4462                	lw	s0,24(sp)
    18b0:	6105                	addi	sp,sp,32
    18b2:	8082                	ret

000018b4 <MC_timer_handler>:

void MC_timer_handler() 
{
    18b4:	1101                	addi	sp,sp,-32
    18b6:	ce06                	sw	ra,28(sp)
    18b8:	cc22                	sw	s0,24(sp)
    18ba:	1000                	addi	s0,sp,32
	_tick++;
    18bc:	200007b7          	lui	a5,0x20000
    18c0:	4147a783          	lw	a5,1044(a5) # 20000414 <_tick>
    18c4:	00178713          	addi	a4,a5,1
    18c8:	200007b7          	lui	a5,0x20000
    18cc:	40e7aa23          	sw	a4,1044(a5) # 20000414 <_tick>
    // if(_tick % 1000 == 0)
	//     printf("tick: %d\r\n", _tick / 1000);

    MC_timer_check();
    18d0:	3f71                	jal	186c <MC_timer_check>

    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    18d2:	e000f7b7          	lui	a5,0xe000f
    18d6:	fef42623          	sw	a5,-20(s0)
    rtk_controller->SR = 0;
    18da:	fec42783          	lw	a5,-20(s0)
    18de:	0007a223          	sw	zero,4(a5) # e000f004 <_end_stack+0xbffff004>
	MC_timer_load(TIMER_INTERVAL);
    18e2:	6789                	lui	a5,0x2
    18e4:	f4078513          	addi	a0,a5,-192 # 1f40 <_data_lma+0x38c>
    18e8:	3bc5                	jal	16d8 <MC_timer_load>

    18ea:	0001                	nop
    18ec:	40f2                	lw	ra,28(sp)
    18ee:	4462                	lw	s0,24(sp)
    18f0:	6105                	addi	sp,sp,32
    18f2:	8082                	ret

000018f4 <thread1_entry>:

MC_thread_t thread1;
MC_thread_t thread2;

void thread1_entry()
{
    18f4:	1101                	addi	sp,sp,-32
    18f6:	ce06                	sw	ra,28(sp)
    18f8:	cc22                	sw	s0,24(sp)
    18fa:	1000                	addi	s0,sp,32
    char *s;
    while(1)
    {
        int i = 1000;
    18fc:	3e800793          	li	a5,1000
    1900:	fef42623          	sw	a5,-20(s0)
        while(i--);
    1904:	0001                	nop
    1906:	fec42783          	lw	a5,-20(s0)
    190a:	fff78713          	addi	a4,a5,-1
    190e:	fee42623          	sw	a4,-20(s0)
    1912:	fbf5                	bnez	a5,1906 <thread1_entry+0x12>
        printf("test_thread1_start!\r\n");
    1914:	6789                	lui	a5,0x2
    1916:	b5478513          	addi	a0,a5,-1196 # 1b54 <STACK_END+0x94>
    191a:	c8aff0ef          	jal	ra,da4 <printf>
    {
    191e:	bff9                	j	18fc <thread1_entry+0x8>

00001920 <thread2_entry>:
        // MC_thread_yield();
    }
}

void thread2_entry()
{
    1920:	1101                	addi	sp,sp,-32
    1922:	ce06                	sw	ra,28(sp)
    1924:	cc22                	sw	s0,24(sp)
    1926:	1000                	addi	s0,sp,32
    uint32_t tick = 0, tmp;
    1928:	fe042623          	sw	zero,-20(s0)
    printf("test_thread2_start!\r\n");
    192c:	6789                	lui	a5,0x2
    192e:	b6c78513          	addi	a0,a5,-1172 # 1b6c <STACK_END+0xac>
    1932:	c72ff0ef          	jal	ra,da4 <printf>
    while(1)
    {
        tmp = MC_get_tick() / 1000;
    1936:	3569                	jal	17c0 <MC_get_tick>
    1938:	872a                	mv	a4,a0
    193a:	3e800793          	li	a5,1000
    193e:	02f757b3          	divu	a5,a4,a5
    1942:	fef42423          	sw	a5,-24(s0)
        if(tmp != tick)
    1946:	fe842703          	lw	a4,-24(s0)
    194a:	fec42783          	lw	a5,-20(s0)
    194e:	fef704e3          	beq	a4,a5,1936 <thread2_entry+0x16>
        {
            tick = tmp;
    1952:	fe842783          	lw	a5,-24(s0)
    1956:	fef42623          	sw	a5,-20(s0)
            printf("tick:%d\r\n", tick);
    195a:	fec42583          	lw	a1,-20(s0)
    195e:	6789                	lui	a5,0x2
    1960:	b8478513          	addi	a0,a5,-1148 # 1b84 <STACK_END+0xc4>
    1964:	c40ff0ef          	jal	ra,da4 <printf>
        tmp = MC_get_tick() / 1000;
    1968:	b7f9                	j	1936 <thread2_entry+0x16>

0000196a <main>:
        // MC_thread_yield();
    }
}

int main()
{
    196a:	1101                	addi	sp,sp,-32
    196c:	ce06                	sw	ra,28(sp)
    196e:	cc22                	sw	s0,24(sp)
    1970:	1000                	addi	s0,sp,32
    __ENABLE_INTERRUPT__(); // 开启全局中断
    1972:	3465                	jal	141a <__ENABLE_INTERRUPT__>

    thread1 = MC_thread_create("thread1",
    1974:	4789                	li	a5,2
    1976:	06400713          	li	a4,100
    197a:	03f00693          	li	a3,63
    197e:	20000613          	li	a2,512
    1982:	000025b7          	lui	a1,0x2
    1986:	8f458593          	addi	a1,a1,-1804 # 18f4 <thread1_entry>
    198a:	6509                	lui	a0,0x2
    198c:	b9050513          	addi	a0,a0,-1136 # 1b90 <STACK_END+0xd0>
    1990:	fb2ff0ef          	jal	ra,1142 <MC_thread_create>
    1994:	872a                	mv	a4,a0
    1996:	200017b7          	lui	a5,0x20001
    199a:	84e7a023          	sw	a4,-1984(a5) # 20000840 <thread1>
                                    thread1_entry,
                                    512,
                                    63,
                                    100,
                                    MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread1);
    199e:	200017b7          	lui	a5,0x20001
    19a2:	8407a783          	lw	a5,-1984(a5) # 20000840 <thread1>
    19a6:	853e                	mv	a0,a5
    19a8:	883ff0ef          	jal	ra,122a <MC_thread_startup>

    thread2 = MC_thread_create("thread2",
    19ac:	4789                	li	a5,2
    19ae:	06400713          	li	a4,100
    19b2:	03f00693          	li	a3,63
    19b6:	20000613          	li	a2,512
    19ba:	000025b7          	lui	a1,0x2
    19be:	92058593          	addi	a1,a1,-1760 # 1920 <thread2_entry>
    19c2:	6509                	lui	a0,0x2
    19c4:	b9850513          	addi	a0,a0,-1128 # 1b98 <STACK_END+0xd8>
    19c8:	f7aff0ef          	jal	ra,1142 <MC_thread_create>
    19cc:	872a                	mv	a4,a0
    19ce:	200017b7          	lui	a5,0x20001
    19d2:	82e7ae23          	sw	a4,-1988(a5) # 2000083c <thread2>
                                    thread2_entry,
                                    512,
                                    63,
                                    100,
                                    MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread2);
    19d6:	200017b7          	lui	a5,0x20001
    19da:	83c7a783          	lw	a5,-1988(a5) # 2000083c <thread2>
    19de:	853e                	mv	a0,a5
    19e0:	84bff0ef          	jal	ra,122a <MC_thread_startup>

    MC_scheduler_begin();
    19e4:	db0ff0ef          	jal	ra,f94 <MC_scheduler_begin>

    uint32_t tick = 0, tmp;
    19e8:	fe042623          	sw	zero,-20(s0)
    while(1){
        // MC_thread_yield();
        tmp = MC_get_tick() / 1000;
    19ec:	3bd1                	jal	17c0 <MC_get_tick>
    19ee:	872a                	mv	a4,a0
    19f0:	3e800793          	li	a5,1000
    19f4:	02f757b3          	divu	a5,a4,a5
    19f8:	fef42423          	sw	a5,-24(s0)
        if(tmp != tick)
    19fc:	fe842703          	lw	a4,-24(s0)
    1a00:	fec42783          	lw	a5,-20(s0)
    1a04:	fef704e3          	beq	a4,a5,19ec <main+0x82>
        {
            tick = tmp;
    1a08:	fe842783          	lw	a5,-24(s0)
    1a0c:	fef42623          	sw	a5,-20(s0)
            printf("main: tick:%d\r\n", tick);
    1a10:	fec42583          	lw	a1,-20(s0)
    1a14:	6789                	lui	a5,0x2
    1a16:	ba078513          	addi	a0,a5,-1120 # 1ba0 <STACK_END+0xe0>
    1a1a:	b8aff0ef          	jal	ra,da4 <printf>
        tmp = MC_get_tick() / 1000;
    1a1e:	b7f9                	j	19ec <main+0x82>

00001a20 <MC_pfic_pending_set>:

/**
 * 中断挂起设置
*/
void MC_pfic_pending_set(uint8_t irqn)
{
    1a20:	7179                	addi	sp,sp,-48
    1a22:	d622                	sw	s0,44(sp)
    1a24:	1800                	addi	s0,sp,48
    1a26:	87aa                	mv	a5,a0
    1a28:	fcf40fa3          	sb	a5,-33(s0)
    uint8_t idx = irqn / 32;
    1a2c:	fdf44783          	lbu	a5,-33(s0)
    1a30:	8395                	srli	a5,a5,0x5
    1a32:	fef407a3          	sb	a5,-17(s0)
    pfic_ipsr->IPSRx[idx] = 1 << irqn;
    1a36:	fdf44783          	lbu	a5,-33(s0)
    1a3a:	4705                	li	a4,1
    1a3c:	00f716b3          	sll	a3,a4,a5
    1a40:	200007b7          	lui	a5,0x20000
    1a44:	0147a703          	lw	a4,20(a5) # 20000014 <pfic_ipsr>
    1a48:	fef44783          	lbu	a5,-17(s0)
    1a4c:	078a                	slli	a5,a5,0x2
    1a4e:	97ba                	add	a5,a5,a4
    1a50:	c394                	sw	a3,0(a5)
}
    1a52:	0001                	nop
    1a54:	5432                	lw	s0,44(sp)
    1a56:	6145                	addi	sp,sp,48
    1a58:	8082                	ret

00001a5a <MC_pfic_pending_clear>:

/**
 * 中断挂起清除
*/
void MC_pfic_pending_clear(uint8_t irqn)
{
    1a5a:	7179                	addi	sp,sp,-48
    1a5c:	d622                	sw	s0,44(sp)
    1a5e:	1800                	addi	s0,sp,48
    1a60:	87aa                	mv	a5,a0
    1a62:	fcf40fa3          	sb	a5,-33(s0)
    uint8_t idx = irqn / 32;
    1a66:	fdf44783          	lbu	a5,-33(s0)
    1a6a:	8395                	srli	a5,a5,0x5
    1a6c:	fef407a3          	sb	a5,-17(s0)
    pfic_iprr->IPRRx[idx] = 1 << irqn;
    1a70:	fdf44783          	lbu	a5,-33(s0)
    1a74:	4705                	li	a4,1
    1a76:	00f716b3          	sll	a3,a4,a5
    1a7a:	200007b7          	lui	a5,0x20000
    1a7e:	0187a703          	lw	a4,24(a5) # 20000018 <pfic_iprr>
    1a82:	fef44783          	lbu	a5,-17(s0)
    1a86:	078a                	slli	a5,a5,0x2
    1a88:	97ba                	add	a5,a5,a4
    1a8a:	c394                	sw	a3,0(a5)
    1a8c:	0001                	nop
    1a8e:	5432                	lw	s0,44(sp)
    1a90:	6145                	addi	sp,sp,48
    1a92:	8082                	ret
