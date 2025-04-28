
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
       8:	00003517          	auipc	a0,0x3
       c:	80850513          	addi	a0,a0,-2040 # 2810 <_data_lma>
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
      40:	81c58593          	addi	a1,a1,-2020 # 20000858 <_end_bss>
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
      52:	3940006f          	j	3e6 <start_kernel>
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
    j   irq_default_handler /*13 : Reserved*/
      8c:	a425                	j	2b4 <irq_default_handler>
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
     11e:	6aa010ef          	jal	ra,17c8 <MC_mtip_handler>
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
     22e:	5ae010ef          	jal	ra,17dc <MC_software_handler>
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

	LOAD t5, 2 * SIZE_REG(t6)
     34a:	008faf03          	lw	t5,8(t6)
	csrw mepc, t5
     34e:	341f1073          	csrw	mepc,t5
    reg_restore t6 // 恢复mepc
     352:	000fa083          	lw	ra,0(t6)
     356:	004fa103          	lw	sp,4(t6)
     35a:	010fa283          	lw	t0,16(t6)
     35e:	014fa303          	lw	t1,20(t6)
     362:	018fa383          	lw	t2,24(t6)
     366:	01cfa403          	lw	s0,28(t6)
     36a:	020fa483          	lw	s1,32(t6)
     36e:	024fa503          	lw	a0,36(t6)
     372:	028fa583          	lw	a1,40(t6)
     376:	02cfa603          	lw	a2,44(t6)
     37a:	030fa683          	lw	a3,48(t6)
     37e:	034fa703          	lw	a4,52(t6)
     382:	038fa783          	lw	a5,56(t6)
     386:	03cfa803          	lw	a6,60(t6)
     38a:	040fa883          	lw	a7,64(t6)
     38e:	044fa903          	lw	s2,68(t6)
     392:	048fa983          	lw	s3,72(t6)
     396:	04cfaa03          	lw	s4,76(t6)
     39a:	050faa83          	lw	s5,80(t6)
     39e:	054fab03          	lw	s6,84(t6)
     3a2:	058fab83          	lw	s7,88(t6)
     3a6:	05cfac03          	lw	s8,92(t6)
     3aa:	060fac83          	lw	s9,96(t6)
     3ae:	064fad03          	lw	s10,100(t6)
     3b2:	068fad83          	lw	s11,104(t6)
     3b6:	06cfae03          	lw	t3,108(t6)
     3ba:	070fae83          	lw	t4,112(t6)
     3be:	074faf03          	lw	t5,116(t6)
     3c2:	078faf83          	lw	t6,120(t6)

    mret
     3c6:	30200073          	mret
	...

000003cc <w_mstatus>:
	asm volatile("csrr %0, mstatus" : "=r" (x) );
	return x;
}

static inline __attribute__((aligned(4))) void w_mstatus(reg_t x)
{
     3cc:	1101                	addi	sp,sp,-32
     3ce:	ce22                	sw	s0,28(sp)
     3d0:	1000                	addi	s0,sp,32
     3d2:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mstatus, %0" : : "r" (x));
     3d6:	fec42783          	lw	a5,-20(s0)
     3da:	30079073          	csrw	mstatus,a5
}
     3de:	0001                	nop
     3e0:	4472                	lw	s0,28(sp)
     3e2:	6105                	addi	sp,sp,32
     3e4:	8082                	ret

000003e6 <start_kernel>:
MC_thread_t os_main;

extern int main();

void start_kernel()
{
     3e6:	1141                	addi	sp,sp,-16
     3e8:	c606                	sw	ra,12(sp)
     3ea:	c422                	sw	s0,8(sp)
     3ec:	0800                	addi	s0,sp,16
    USART1_init();
     3ee:	2889                	jal	440 <USART1_init>

    //设置osmain的优先级
    os_main = MC_thread_create("os_main",
     3f0:	4789                	li	a5,2
     3f2:	06400713          	li	a4,100
     3f6:	02000693          	li	a3,32
     3fa:	20000613          	li	a2,512
     3fe:	000025b7          	lui	a1,0x2
     402:	e8a58593          	addi	a1,a1,-374 # 1e8a <main>
     406:	6509                	lui	a0,0x2
     408:	6c450513          	addi	a0,a0,1732 # 26c4 <STACK_END+0x4>
     40c:	639000ef          	jal	ra,1244 <MC_thread_create>
     410:	872a                	mv	a4,a0
     412:	200007b7          	lui	a5,0x20000
     416:	40e7ae23          	sw	a4,1052(a5) # 2000041c <os_main>
                            main,
                            512,
                            32,
                            100,
                            MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(os_main);
     41a:	200007b7          	lui	a5,0x20000
     41e:	41c7a783          	lw	a5,1052(a5) # 2000041c <os_main>
     422:	853e                	mv	a0,a5
     424:	709000ef          	jal	ra,132c <MC_thread_startup>

    MC_trap_init();
     428:	368010ef          	jal	ra,1790 <MC_trap_init>
    MC_SysTick_init();
     42c:	7a6010ef          	jal	ra,1bd2 <MC_SysTick_init>
    
    w_mstatus(0b11 << 11);//进入main为机器模式
     430:	6789                	lui	a5,0x2
     432:	80078513          	addi	a0,a5,-2048 # 1800 <MC_software_handler+0x24>
     436:	3f59                	jal	3cc <w_mstatus>
    
    /**
     * 因为此时还没开启中断，所以不通过
     * pendsv的形式进行上下文切换
     */
    MC_schedule(); 
     438:	1fb000ef          	jal	ra,e32 <MC_schedule>
    while(1)
     43c:	a001                	j	43c <start_kernel+0x56>
	...

00000440 <USART1_init>:
    CFGHR = 1,
    INDR = 2,
    OUTDR = 3,
}_GPIOA_REG;
void USART1_init()
{
     440:	1101                	addi	sp,sp,-32
     442:	ce22                	sw	s0,28(sp)
     444:	1000                	addi	s0,sp,32
    while((RCC_REG_R(CTLR) & (1<<1)) == 0)continue;
     446:	a011                	j	44a <USART1_init+0xa>
     448:	0001                	nop
     44a:	400217b7          	lui	a5,0x40021
     44e:	439c                	lw	a5,0(a5)
     450:	8b89                	andi	a5,a5,2
     452:	dbfd                	beqz	a5,448 <USART1_init+0x8>
    uint32_t  x = (RCC_REG_R(APB2PCENR)) | (1<<14) | (1<<2);
     454:	400217b7          	lui	a5,0x40021
     458:	07e1                	addi	a5,a5,24
     45a:	4398                	lw	a4,0(a5)
     45c:	6791                	lui	a5,0x4
     45e:	0791                	addi	a5,a5,4
     460:	8fd9                	or	a5,a5,a4
     462:	fef42623          	sw	a5,-20(s0)
    RCC_REG_W(APB2PCENR,x);
     466:	400217b7          	lui	a5,0x40021
     46a:	07e1                	addi	a5,a5,24
     46c:	fec42703          	lw	a4,-20(s0)
     470:	c398                	sw	a4,0(a5)

    x = ((GPIOA_REG_R(CFGHR) & ~(0b1111<<4)) | (uint32_t)(0b1011<<4));
     472:	400117b7          	lui	a5,0x40011
     476:	80478793          	addi	a5,a5,-2044 # 40010804 <_end_stack+0x20000804>
     47a:	439c                	lw	a5,0(a5)
     47c:	f0f7f793          	andi	a5,a5,-241
     480:	0b07e793          	ori	a5,a5,176
     484:	fef42623          	sw	a5,-20(s0)
    GPIOA_REG_W(CFGHR,x);
     488:	400117b7          	lui	a5,0x40011
     48c:	80478793          	addi	a5,a5,-2044 # 40010804 <_end_stack+0x20000804>
     490:	fec42703          	lw	a4,-20(s0)
     494:	c398                	sw	a4,0(a5)

    x = (USART1_REG_R(BRR) | (uint16_t)0b1000101);
     496:	400147b7          	lui	a5,0x40014
     49a:	80878793          	addi	a5,a5,-2040 # 40013808 <_end_stack+0x20003808>
     49e:	439c                	lw	a5,0(a5)
     4a0:	0457e793          	ori	a5,a5,69
     4a4:	fef42623          	sw	a5,-20(s0)
    USART1_REG_W(BRR,(uint16_t)x);
     4a8:	fec42783          	lw	a5,-20(s0)
     4ac:	01079713          	slli	a4,a5,0x10
     4b0:	8341                	srli	a4,a4,0x10
     4b2:	400147b7          	lui	a5,0x40014
     4b6:	80878793          	addi	a5,a5,-2040 # 40013808 <_end_stack+0x20003808>
     4ba:	c398                	sw	a4,0(a5)

    x = (USART1_REG_R(CTLR1) | 0X0000200C);
     4bc:	400147b7          	lui	a5,0x40014
     4c0:	80c78793          	addi	a5,a5,-2036 # 4001380c <_end_stack+0x2000380c>
     4c4:	4398                	lw	a4,0(a5)
     4c6:	6789                	lui	a5,0x2
     4c8:	07b1                	addi	a5,a5,12
     4ca:	8fd9                	or	a5,a5,a4
     4cc:	fef42623          	sw	a5,-20(s0)
    USART1_REG_W(CTLR1,(uint32_t)x);
     4d0:	400147b7          	lui	a5,0x40014
     4d4:	80c78793          	addi	a5,a5,-2036 # 4001380c <_end_stack+0x2000380c>
     4d8:	fec42703          	lw	a4,-20(s0)
     4dc:	c398                	sw	a4,0(a5)
}
     4de:	0001                	nop
     4e0:	4472                	lw	s0,28(sp)
     4e2:	6105                	addi	sp,sp,32
     4e4:	8082                	ret

000004e6 <putc>:

void putc(uint8_t c)
{
     4e6:	1101                	addi	sp,sp,-32
     4e8:	ce22                	sw	s0,28(sp)
     4ea:	1000                	addi	s0,sp,32
     4ec:	87aa                	mv	a5,a0
     4ee:	fef407a3          	sb	a5,-17(s0)
    USART1_REG_W(DATAR,c);
     4f2:	400147b7          	lui	a5,0x40014
     4f6:	80478793          	addi	a5,a5,-2044 # 40013804 <_end_stack+0x20003804>
     4fa:	fef44703          	lbu	a4,-17(s0)
     4fe:	c398                	sw	a4,0(a5)
}
     500:	0001                	nop
     502:	4472                	lw	s0,28(sp)
     504:	6105                	addi	sp,sp,32
     506:	8082                	ret

00000508 <puts>:
void puts(uint8_t *s)
{
     508:	1101                	addi	sp,sp,-32
     50a:	ce06                	sw	ra,28(sp)
     50c:	cc22                	sw	s0,24(sp)
     50e:	1000                	addi	s0,sp,32
     510:	fea42623          	sw	a0,-20(s0)
    __DISENABLE_INTERRUPT__();
     514:	242010ef          	jal	ra,1756 <__DISENABLE_INTERRUPT__>
    while(*s)
     518:	a02d                	j	542 <puts+0x3a>
    {
        
        putc(*s++);
     51a:	fec42783          	lw	a5,-20(s0)
     51e:	00178713          	addi	a4,a5,1
     522:	fee42623          	sw	a4,-20(s0)
     526:	0007c783          	lbu	a5,0(a5)
     52a:	853e                	mv	a0,a5
     52c:	3f6d                	jal	4e6 <putc>
        while((USART1_REG_R(STATR) & (1<<7)) == 0)continue;
     52e:	a011                	j	532 <puts+0x2a>
     530:	0001                	nop
     532:	400147b7          	lui	a5,0x40014
     536:	80078793          	addi	a5,a5,-2048 # 40013800 <_end_stack+0x20003800>
     53a:	439c                	lw	a5,0(a5)
     53c:	0807f793          	andi	a5,a5,128
     540:	dbe5                	beqz	a5,530 <puts+0x28>
    while(*s)
     542:	fec42783          	lw	a5,-20(s0)
     546:	0007c783          	lbu	a5,0(a5)
     54a:	fbe1                	bnez	a5,51a <puts+0x12>
       
    }
    __ENABLE_INTERRUPT__();
     54c:	226010ef          	jal	ra,1772 <__ENABLE_INTERRUPT__>
}
     550:	0001                	nop
     552:	40f2                	lw	ra,28(sp)
     554:	4462                	lw	s0,24(sp)
     556:	6105                	addi	sp,sp,32
     558:	8082                	ret

0000055a <MC_InsertFreeBlock>:
#define HEAP_MINMUM_SIZE ((size_t) (Block_Size << 1))

void MC_PageInit(void);

static void MC_InsertFreeBlock(BlockLink_t *New_Block)
{
     55a:	7179                	addi	sp,sp,-48
     55c:	d622                	sw	s0,44(sp)
     55e:	1800                	addi	s0,sp,48
     560:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *BlockIterator;
    uint8_t *BlockOperator;
    for(BlockIterator = &Block_Start; BlockIterator->MC_NextFreeBlock < New_Block; BlockIterator = BlockIterator->MC_NextFreeBlock)
     564:	200007b7          	lui	a5,0x20000
     568:	42878793          	addi	a5,a5,1064 # 20000428 <Block_Start>
     56c:	fef42623          	sw	a5,-20(s0)
     570:	a031                	j	57c <MC_InsertFreeBlock+0x22>
     572:	fec42783          	lw	a5,-20(s0)
     576:	439c                	lw	a5,0(a5)
     578:	fef42623          	sw	a5,-20(s0)
     57c:	fec42783          	lw	a5,-20(s0)
     580:	439c                	lw	a5,0(a5)
     582:	fdc42703          	lw	a4,-36(s0)
     586:	fee7e6e3          	bltu	a5,a4,572 <MC_InsertFreeBlock+0x18>
    {}
    
    BlockOperator = BlockIterator;
     58a:	fec42783          	lw	a5,-20(s0)
     58e:	fef42423          	sw	a5,-24(s0)

    if(BlockOperator + BlockIterator->MC_BlockSize == (uint8_t *)New_Block)
     592:	fec42783          	lw	a5,-20(s0)
     596:	43dc                	lw	a5,4(a5)
     598:	fe842703          	lw	a4,-24(s0)
     59c:	97ba                	add	a5,a5,a4
     59e:	fdc42703          	lw	a4,-36(s0)
     5a2:	02f71063          	bne	a4,a5,5c2 <MC_InsertFreeBlock+0x68>
    {
        BlockIterator->MC_BlockSize += New_Block->MC_BlockSize;
     5a6:	fec42783          	lw	a5,-20(s0)
     5aa:	43d8                	lw	a4,4(a5)
     5ac:	fdc42783          	lw	a5,-36(s0)
     5b0:	43dc                	lw	a5,4(a5)
     5b2:	973e                	add	a4,a4,a5
     5b4:	fec42783          	lw	a5,-20(s0)
     5b8:	c3d8                	sw	a4,4(a5)
        New_Block = BlockIterator;
     5ba:	fec42783          	lw	a5,-20(s0)
     5be:	fcf42e23          	sw	a5,-36(s0)
    }else{}

    BlockOperator = (uint8_t *)New_Block;
     5c2:	fdc42783          	lw	a5,-36(s0)
     5c6:	fef42423          	sw	a5,-24(s0)
    if(BlockOperator + New_Block->MC_BlockSize == (uint8_t *)BlockIterator->MC_NextFreeBlock)
     5ca:	fdc42783          	lw	a5,-36(s0)
     5ce:	43dc                	lw	a5,4(a5)
     5d0:	fe842703          	lw	a4,-24(s0)
     5d4:	973e                	add	a4,a4,a5
     5d6:	fec42783          	lw	a5,-20(s0)
     5da:	439c                	lw	a5,0(a5)
     5dc:	04f71663          	bne	a4,a5,628 <MC_InsertFreeBlock+0xce>
    {
        if(BlockIterator->MC_NextFreeBlock != Block_End)
     5e0:	fec42783          	lw	a5,-20(s0)
     5e4:	4398                	lw	a4,0(a5)
     5e6:	200007b7          	lui	a5,0x20000
     5ea:	4307a783          	lw	a5,1072(a5) # 20000430 <Block_End>
     5ee:	02f70563          	beq	a4,a5,618 <MC_InsertFreeBlock+0xbe>
        {
            New_Block->MC_BlockSize += BlockIterator->MC_NextFreeBlock->MC_BlockSize;
     5f2:	fdc42783          	lw	a5,-36(s0)
     5f6:	43d8                	lw	a4,4(a5)
     5f8:	fec42783          	lw	a5,-20(s0)
     5fc:	439c                	lw	a5,0(a5)
     5fe:	43dc                	lw	a5,4(a5)
     600:	973e                	add	a4,a4,a5
     602:	fdc42783          	lw	a5,-36(s0)
     606:	c3d8                	sw	a4,4(a5)
            New_Block->MC_NextFreeBlock = BlockIterator->MC_NextFreeBlock->MC_NextFreeBlock;
     608:	fec42783          	lw	a5,-20(s0)
     60c:	439c                	lw	a5,0(a5)
     60e:	4398                	lw	a4,0(a5)
     610:	fdc42783          	lw	a5,-36(s0)
     614:	c398                	sw	a4,0(a5)
     616:	a839                	j	634 <MC_InsertFreeBlock+0xda>
        }
        else
        {
            New_Block->MC_NextFreeBlock = Block_End;
     618:	200007b7          	lui	a5,0x20000
     61c:	4307a703          	lw	a4,1072(a5) # 20000430 <Block_End>
     620:	fdc42783          	lw	a5,-36(s0)
     624:	c398                	sw	a4,0(a5)
     626:	a039                	j	634 <MC_InsertFreeBlock+0xda>
        }
    }
    else
    {
        New_Block->MC_NextFreeBlock = BlockIterator->MC_NextFreeBlock;
     628:	fec42783          	lw	a5,-20(s0)
     62c:	4398                	lw	a4,0(a5)
     62e:	fdc42783          	lw	a5,-36(s0)
     632:	c398                	sw	a4,0(a5)
    }

    if(BlockIterator != New_Block)
     634:	fec42703          	lw	a4,-20(s0)
     638:	fdc42783          	lw	a5,-36(s0)
     63c:	00f70763          	beq	a4,a5,64a <MC_InsertFreeBlock+0xf0>
    {
        BlockIterator->MC_NextFreeBlock = New_Block;
     640:	fec42783          	lw	a5,-20(s0)
     644:	fdc42703          	lw	a4,-36(s0)
     648:	c398                	sw	a4,0(a5)
    }else{}

}
     64a:	0001                	nop
     64c:	5432                	lw	s0,44(sp)
     64e:	6145                	addi	sp,sp,48
     650:	8082                	ret

00000652 <MC_PageMalloc>:

void *MC_PageMalloc(size_t MallocSize)
{
     652:	7179                	addi	sp,sp,-48
     654:	d606                	sw	ra,44(sp)
     656:	d422                	sw	s0,40(sp)
     658:	1800                	addi	s0,sp,48
     65a:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *Prev_Block = NULL, *Block = NULL, *New_Block = NULL;
     65e:	fe042623          	sw	zero,-20(s0)
     662:	fe042423          	sw	zero,-24(s0)
     666:	fe042023          	sw	zero,-32(s0)
    void *ReturnAddr = NULL;
     66a:	fe042223          	sw	zero,-28(s0)
    /* 应当挂起所有任务 */
    MC_scheduler_stop();
     66e:	1e1000ef          	jal	ra,104e <MC_scheduler_stop>
    /*----------------*/
    if(Block_End == NULL)
     672:	200007b7          	lui	a5,0x20000
     676:	4307a783          	lw	a5,1072(a5) # 20000430 <Block_End>
     67a:	e391                	bnez	a5,67e <MC_PageMalloc+0x2c>
    {
        MC_PageInit();
     67c:	2a89                	jal	7ce <MC_PageInit>
    }
    else{}

    if((MallocSize & BlockAllocatiedBit) == 0)
     67e:	200007b7          	lui	a5,0x20000
     682:	0207a703          	lw	a4,32(a5) # 20000020 <_data_end>
     686:	fdc42783          	lw	a5,-36(s0)
     68a:	8ff9                	and	a5,a5,a4
     68c:	12079863          	bnez	a5,7bc <MC_PageMalloc+0x16a>
    {
        if(MallocSize > 0)
     690:	fdc42783          	lw	a5,-36(s0)
     694:	12078463          	beqz	a5,7bc <MC_PageMalloc+0x16a>
        {
            MallocSize += Block_Size;
     698:	200007b7          	lui	a5,0x20000
     69c:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     6a0:	fdc42703          	lw	a4,-36(s0)
     6a4:	97ba                	add	a5,a5,a4
     6a6:	fcf42e23          	sw	a5,-36(s0)
            if(MallocSize & HEAP_ADDRESS_MASK)
     6aa:	fdc42783          	lw	a5,-36(s0)
     6ae:	8b9d                	andi	a5,a5,7
     6b0:	c799                	beqz	a5,6be <MC_PageMalloc+0x6c>
            {
                MallocSize = (MallocSize + HEAP_ADDRESS_MASK) & (~HEAP_ADDRESS_MASK);
     6b2:	fdc42783          	lw	a5,-36(s0)
     6b6:	079d                	addi	a5,a5,7
     6b8:	9be1                	andi	a5,a5,-8
     6ba:	fcf42e23          	sw	a5,-36(s0)
            }
            
            if(MallocSize <= HeapSizeRemaing)
     6be:	200007b7          	lui	a5,0x20000
     6c2:	0247a783          	lw	a5,36(a5) # 20000024 <HeapSizeRemaing>
     6c6:	fdc42703          	lw	a4,-36(s0)
     6ca:	0ee7e963          	bltu	a5,a4,7bc <MC_PageMalloc+0x16a>
            {
                Prev_Block = &Block_Start;
     6ce:	200007b7          	lui	a5,0x20000
     6d2:	42878793          	addi	a5,a5,1064 # 20000428 <Block_Start>
     6d6:	fef42623          	sw	a5,-20(s0)
                Block = Prev_Block->MC_NextFreeBlock;
     6da:	fec42783          	lw	a5,-20(s0)
     6de:	439c                	lw	a5,0(a5)
     6e0:	fef42423          	sw	a5,-24(s0)
                while(Block->MC_BlockSize < MallocSize && Block->MC_NextFreeBlock != NULL)
     6e4:	a811                	j	6f8 <MC_PageMalloc+0xa6>
                {
                    Prev_Block = Block;
     6e6:	fe842783          	lw	a5,-24(s0)
     6ea:	fef42623          	sw	a5,-20(s0)
                    Block = Block->MC_NextFreeBlock;
     6ee:	fe842783          	lw	a5,-24(s0)
     6f2:	439c                	lw	a5,0(a5)
     6f4:	fef42423          	sw	a5,-24(s0)
                while(Block->MC_BlockSize < MallocSize && Block->MC_NextFreeBlock != NULL)
     6f8:	fe842783          	lw	a5,-24(s0)
     6fc:	43dc                	lw	a5,4(a5)
     6fe:	fdc42703          	lw	a4,-36(s0)
     702:	00e7f663          	bgeu	a5,a4,70e <MC_PageMalloc+0xbc>
     706:	fe842783          	lw	a5,-24(s0)
     70a:	439c                	lw	a5,0(a5)
     70c:	ffe9                	bnez	a5,6e6 <MC_PageMalloc+0x94>
                }

                if(Block != Block_End)
     70e:	200007b7          	lui	a5,0x20000
     712:	4307a783          	lw	a5,1072(a5) # 20000430 <Block_End>
     716:	fe842703          	lw	a4,-24(s0)
     71a:	0af70163          	beq	a4,a5,7bc <MC_PageMalloc+0x16a>
                {
                    ReturnAddr = (void *)((uint8_t *)Block + Block_Size);
     71e:	200007b7          	lui	a5,0x20000
     722:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     726:	fe842703          	lw	a4,-24(s0)
     72a:	97ba                	add	a5,a5,a4
     72c:	fef42223          	sw	a5,-28(s0)

                    Prev_Block->MC_NextFreeBlock = Block->MC_NextFreeBlock;
     730:	fe842783          	lw	a5,-24(s0)
     734:	4398                	lw	a4,0(a5)
     736:	fec42783          	lw	a5,-20(s0)
     73a:	c398                	sw	a4,0(a5)

                    if(Block->MC_BlockSize - MallocSize > HEAP_MINMUM_SIZE)
     73c:	fe842783          	lw	a5,-24(s0)
     740:	43d8                	lw	a4,4(a5)
     742:	fdc42783          	lw	a5,-36(s0)
     746:	8f1d                	sub	a4,a4,a5
     748:	200007b7          	lui	a5,0x20000
     74c:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     750:	0786                	slli	a5,a5,0x1
     752:	02e7fa63          	bgeu	a5,a4,786 <MC_PageMalloc+0x134>
                    {
                        New_Block = (BlockLink_t *)((uint8_t *)Block + MallocSize);
     756:	fe842703          	lw	a4,-24(s0)
     75a:	fdc42783          	lw	a5,-36(s0)
     75e:	97ba                	add	a5,a5,a4
     760:	fef42023          	sw	a5,-32(s0)

                        New_Block->MC_BlockSize = Block->MC_BlockSize - MallocSize;
     764:	fe842783          	lw	a5,-24(s0)
     768:	43d8                	lw	a4,4(a5)
     76a:	fdc42783          	lw	a5,-36(s0)
     76e:	8f1d                	sub	a4,a4,a5
     770:	fe042783          	lw	a5,-32(s0)
     774:	c3d8                	sw	a4,4(a5)
                        Block->MC_BlockSize = MallocSize;
     776:	fe842783          	lw	a5,-24(s0)
     77a:	fdc42703          	lw	a4,-36(s0)
     77e:	c3d8                	sw	a4,4(a5)
                        MC_InsertFreeBlock(New_Block);
     780:	fe042503          	lw	a0,-32(s0)
     784:	3bd9                	jal	55a <MC_InsertFreeBlock>
                    }else{}
                    HeapSizeRemaing -= Block->MC_BlockSize;
     786:	200007b7          	lui	a5,0x20000
     78a:	0247a703          	lw	a4,36(a5) # 20000024 <HeapSizeRemaing>
     78e:	fe842783          	lw	a5,-24(s0)
     792:	43dc                	lw	a5,4(a5)
     794:	8f1d                	sub	a4,a4,a5
     796:	200007b7          	lui	a5,0x20000
     79a:	02e7a223          	sw	a4,36(a5) # 20000024 <HeapSizeRemaing>

                    Block->MC_BlockSize |= BlockAllocatiedBit;
     79e:	fe842783          	lw	a5,-24(s0)
     7a2:	43d8                	lw	a4,4(a5)
     7a4:	200007b7          	lui	a5,0x20000
     7a8:	0207a783          	lw	a5,32(a5) # 20000020 <_data_end>
     7ac:	8f5d                	or	a4,a4,a5
     7ae:	fe842783          	lw	a5,-24(s0)
     7b2:	c3d8                	sw	a4,4(a5)
                    Block->MC_NextFreeBlock = NULL;
     7b4:	fe842783          	lw	a5,-24(s0)
     7b8:	0007a023          	sw	zero,0(a5)
            }else{}
        }else{}
    }else{}

    /* 应当恢复任务调度 */
    MC_scheduler_start();
     7bc:	079000ef          	jal	ra,1034 <MC_scheduler_start>
    /*----------------*/


    return ReturnAddr;
     7c0:	fe442783          	lw	a5,-28(s0)
}
     7c4:	853e                	mv	a0,a5
     7c6:	50b2                	lw	ra,44(sp)
     7c8:	5422                	lw	s0,40(sp)
     7ca:	6145                	addi	sp,sp,48
     7cc:	8082                	ret

000007ce <MC_PageInit>:

void MC_PageInit(void)
{
     7ce:	1101                	addi	sp,sp,-32
     7d0:	ce22                	sw	s0,28(sp)
     7d2:	1000                	addi	s0,sp,32
    BlockLink_t *FirstFreeBlock;

    size_t TotalHeapSize = HEAP_SIZE;
     7d4:	6789                	lui	a5,0x2
     7d6:	6b87a783          	lw	a5,1720(a5) # 26b8 <HEAP_SIZE>
     7da:	fef42623          	sw	a5,-20(s0)
    size_t HeapStart_Address = HEAP_START, HeapEnd_Address;
     7de:	6789                	lui	a5,0x2
     7e0:	6b47a783          	lw	a5,1716(a5) # 26b4 <HEAP_START>
     7e4:	fef42423          	sw	a5,-24(s0)

    if(HeapStart_Address & (HEAP_ADDRESS_MASK))
     7e8:	fe842783          	lw	a5,-24(s0)
     7ec:	8b9d                	andi	a5,a5,7
     7ee:	c39d                	beqz	a5,814 <MC_PageInit+0x46>
    {
        HeapStart_Address = (HeapStart_Address + HEAP_ADDRESS_MASK) & (~(HEAP_ADDRESS_MASK));
     7f0:	fe842783          	lw	a5,-24(s0)
     7f4:	079d                	addi	a5,a5,7
     7f6:	9be1                	andi	a5,a5,-8
     7f8:	fef42423          	sw	a5,-24(s0)
        TotalHeapSize -= HeapStart_Address - HEAP_START;
     7fc:	6789                	lui	a5,0x2
     7fe:	6b47a703          	lw	a4,1716(a5) # 26b4 <HEAP_START>
     802:	fe842783          	lw	a5,-24(s0)
     806:	40f707b3          	sub	a5,a4,a5
     80a:	fec42703          	lw	a4,-20(s0)
     80e:	97ba                	add	a5,a5,a4
     810:	fef42623          	sw	a5,-20(s0)
    }

    HeapEnd_Address = HeapStart_Address + TotalHeapSize;
     814:	fe842703          	lw	a4,-24(s0)
     818:	fec42783          	lw	a5,-20(s0)
     81c:	97ba                	add	a5,a5,a4
     81e:	fef42223          	sw	a5,-28(s0)
    HeapEnd_Address -= Block_Size;
     822:	200007b7          	lui	a5,0x20000
     826:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     82a:	fe442703          	lw	a4,-28(s0)
     82e:	40f707b3          	sub	a5,a4,a5
     832:	fef42223          	sw	a5,-28(s0)
    
    Block_End = (BlockLink_t *)HeapEnd_Address;
     836:	fe442703          	lw	a4,-28(s0)
     83a:	200007b7          	lui	a5,0x20000
     83e:	42e7a823          	sw	a4,1072(a5) # 20000430 <Block_End>
    Block_End -> MC_BlockSize = 0;
     842:	200007b7          	lui	a5,0x20000
     846:	4307a783          	lw	a5,1072(a5) # 20000430 <Block_End>
     84a:	0007a223          	sw	zero,4(a5)
    Block_End -> MC_NextFreeBlock = NULL;
     84e:	200007b7          	lui	a5,0x20000
     852:	4307a783          	lw	a5,1072(a5) # 20000430 <Block_End>
     856:	0007a023          	sw	zero,0(a5)
    
    Block_Start.MC_BlockSize = 0;
     85a:	200007b7          	lui	a5,0x20000
     85e:	42878793          	addi	a5,a5,1064 # 20000428 <Block_Start>
     862:	0007a223          	sw	zero,4(a5)
    Block_Start.MC_NextFreeBlock = (BlockLink_t *)HeapStart_Address;
     866:	fe842703          	lw	a4,-24(s0)
     86a:	200007b7          	lui	a5,0x20000
     86e:	42e7a423          	sw	a4,1064(a5) # 20000428 <Block_Start>

    FirstFreeBlock = (BlockLink_t *)HeapStart_Address;
     872:	fe842783          	lw	a5,-24(s0)
     876:	fef42023          	sw	a5,-32(s0)
    FirstFreeBlock -> MC_BlockSize = HeapEnd_Address - HeapStart_Address;
     87a:	fe442703          	lw	a4,-28(s0)
     87e:	fe842783          	lw	a5,-24(s0)
     882:	8f1d                	sub	a4,a4,a5
     884:	fe042783          	lw	a5,-32(s0)
     888:	c3d8                	sw	a4,4(a5)
    FirstFreeBlock -> MC_NextFreeBlock = Block_End;
     88a:	200007b7          	lui	a5,0x20000
     88e:	4307a703          	lw	a4,1072(a5) # 20000430 <Block_End>
     892:	fe042783          	lw	a5,-32(s0)
     896:	c398                	sw	a4,0(a5)

    HeapSizeRemaing = FirstFreeBlock -> MC_BlockSize;
     898:	fe042783          	lw	a5,-32(s0)
     89c:	43d8                	lw	a4,4(a5)
     89e:	200007b7          	lui	a5,0x20000
     8a2:	02e7a223          	sw	a4,36(a5) # 20000024 <HeapSizeRemaing>
    BlockAllocatiedBit = (((size_t) 1) << (sizeof(size_t) * heapBITS_PER_BYTE - 1));
     8a6:	200007b7          	lui	a5,0x20000
     8aa:	80000737          	lui	a4,0x80000
     8ae:	02e7a023          	sw	a4,32(a5) # 20000020 <_data_end>
}
     8b2:	0001                	nop
     8b4:	4472                	lw	s0,28(sp)
     8b6:	6105                	addi	sp,sp,32
     8b8:	8082                	ret

000008ba <MC_PageFree>:

void MC_PageFree(void *FreeAddr)
{
     8ba:	7179                	addi	sp,sp,-48
     8bc:	d606                	sw	ra,44(sp)
     8be:	d422                	sw	s0,40(sp)
     8c0:	1800                	addi	s0,sp,48
     8c2:	fca42e23          	sw	a0,-36(s0)
    BlockLink_t *BlockIterator;
    uint8_t *BlockOperator;
    if(FreeAddr != NULL)
     8c6:	fdc42783          	lw	a5,-36(s0)
     8ca:	cbbd                	beqz	a5,940 <MC_PageFree+0x86>
    {
        BlockOperator = (uint8_t *)FreeAddr - Block_Size;
     8cc:	200007b7          	lui	a5,0x20000
     8d0:	0007a783          	lw	a5,0(a5) # 20000000 <_data_vma>
     8d4:	40f007b3          	neg	a5,a5
     8d8:	fdc42703          	lw	a4,-36(s0)
     8dc:	97ba                	add	a5,a5,a4
     8de:	fef42623          	sw	a5,-20(s0)
        BlockIterator = BlockOperator;
     8e2:	fec42783          	lw	a5,-20(s0)
     8e6:	fef42423          	sw	a5,-24(s0)

        if((BlockIterator->MC_BlockSize & BlockAllocatiedBit) != 0 && BlockIterator->MC_NextFreeBlock == NULL)
     8ea:	fe842783          	lw	a5,-24(s0)
     8ee:	43d8                	lw	a4,4(a5)
     8f0:	200007b7          	lui	a5,0x20000
     8f4:	0207a783          	lw	a5,32(a5) # 20000020 <_data_end>
     8f8:	8ff9                	and	a5,a5,a4
     8fa:	c3b9                	beqz	a5,940 <MC_PageFree+0x86>
     8fc:	fe842783          	lw	a5,-24(s0)
     900:	439c                	lw	a5,0(a5)
     902:	ef9d                	bnez	a5,940 <MC_PageFree+0x86>
        {
            /*此处应该挂起所有任务*/
            MC_scheduler_stop();
     904:	27a9                	jal	104e <MC_scheduler_stop>
            /*------------------*/
            BlockIterator->MC_BlockSize &= ~BlockAllocatiedBit;
     906:	fe842783          	lw	a5,-24(s0)
     90a:	43d8                	lw	a4,4(a5)
     90c:	200007b7          	lui	a5,0x20000
     910:	0207a783          	lw	a5,32(a5) # 20000020 <_data_end>
     914:	fff7c793          	not	a5,a5
     918:	8f7d                	and	a4,a4,a5
     91a:	fe842783          	lw	a5,-24(s0)
     91e:	c3d8                	sw	a4,4(a5)
            {
                HeapSizeRemaing += BlockIterator->MC_BlockSize;
     920:	fe842783          	lw	a5,-24(s0)
     924:	43d8                	lw	a4,4(a5)
     926:	200007b7          	lui	a5,0x20000
     92a:	0247a783          	lw	a5,36(a5) # 20000024 <HeapSizeRemaing>
     92e:	973e                	add	a4,a4,a5
     930:	200007b7          	lui	a5,0x20000
     934:	02e7a223          	sw	a4,36(a5) # 20000024 <HeapSizeRemaing>
                MC_InsertFreeBlock(BlockIterator);
     938:	fe842503          	lw	a0,-24(s0)
     93c:	3939                	jal	55a <MC_InsertFreeBlock>
            }
            /*此处应该取消所有被挂任务*/
            MC_scheduler_start();
     93e:	2ddd                	jal	1034 <MC_scheduler_start>
            /*----------------------*/
        }else{}
    }else{}
     940:	0001                	nop
     942:	50b2                	lw	ra,44(sp)
     944:	5422                	lw	s0,40(sp)
     946:	6145                	addi	sp,sp,48
     948:	8082                	ret

0000094a <_vsnprintf>:
/*
 * ref: https://github.com/cccriscv/mini-riscv-os/blob/master/05-Preemptive/lib.c
 */

static int _vsnprintf(char * out, size_t n, const char* s, va_list vl)
{
     94a:	715d                	addi	sp,sp,-80
     94c:	c6a2                	sw	s0,76(sp)
     94e:	0880                	addi	s0,sp,80
     950:	faa42e23          	sw	a0,-68(s0)
     954:	fab42c23          	sw	a1,-72(s0)
     958:	fac42a23          	sw	a2,-76(s0)
     95c:	fad42823          	sw	a3,-80(s0)
	int format = 0;
     960:	fe042623          	sw	zero,-20(s0)
	int longarg = 0;
     964:	fe042423          	sw	zero,-24(s0)
	size_t pos = 0;
     968:	fe042223          	sw	zero,-28(s0)
	for (; *s; s++) {
     96c:	ae95                	j	ce0 <_vsnprintf+0x396>
		if (format) {
     96e:	fec42783          	lw	a5,-20(s0)
     972:	30078b63          	beqz	a5,c88 <_vsnprintf+0x33e>
			switch(*s) {
     976:	fb442783          	lw	a5,-76(s0)
     97a:	0007c783          	lbu	a5,0(a5)
     97e:	f9d78793          	addi	a5,a5,-99
     982:	4755                	li	a4,21
     984:	34f76863          	bltu	a4,a5,cd4 <_vsnprintf+0x38a>
     988:	00279713          	slli	a4,a5,0x2
     98c:	6789                	lui	a5,0x2
     98e:	6cc78793          	addi	a5,a5,1740 # 26cc <STACK_END+0xc>
     992:	97ba                	add	a5,a5,a4
     994:	439c                	lw	a5,0(a5)
     996:	8782                	jr	a5
			case 'l': {
				longarg = 1;
     998:	4785                	li	a5,1
     99a:	fef42423          	sw	a5,-24(s0)
				break;
     99e:	ae25                	j	cd6 <_vsnprintf+0x38c>
			}
			case 'p': {
				longarg = 1;
     9a0:	4785                	li	a5,1
     9a2:	fef42423          	sw	a5,-24(s0)
				if (out && pos < n) {
     9a6:	fbc42783          	lw	a5,-68(s0)
     9aa:	c385                	beqz	a5,9ca <_vsnprintf+0x80>
     9ac:	fe442703          	lw	a4,-28(s0)
     9b0:	fb842783          	lw	a5,-72(s0)
     9b4:	00f77b63          	bgeu	a4,a5,9ca <_vsnprintf+0x80>
					out[pos] = '0';
     9b8:	fbc42703          	lw	a4,-68(s0)
     9bc:	fe442783          	lw	a5,-28(s0)
     9c0:	97ba                	add	a5,a5,a4
     9c2:	03000713          	li	a4,48
     9c6:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     9ca:	fe442783          	lw	a5,-28(s0)
     9ce:	0785                	addi	a5,a5,1
     9d0:	fef42223          	sw	a5,-28(s0)
				if (out && pos < n) {
     9d4:	fbc42783          	lw	a5,-68(s0)
     9d8:	c385                	beqz	a5,9f8 <_vsnprintf+0xae>
     9da:	fe442703          	lw	a4,-28(s0)
     9de:	fb842783          	lw	a5,-72(s0)
     9e2:	00f77b63          	bgeu	a4,a5,9f8 <_vsnprintf+0xae>
					out[pos] = 'x';
     9e6:	fbc42703          	lw	a4,-68(s0)
     9ea:	fe442783          	lw	a5,-28(s0)
     9ee:	97ba                	add	a5,a5,a4
     9f0:	07800713          	li	a4,120
     9f4:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     9f8:	fe442783          	lw	a5,-28(s0)
     9fc:	0785                	addi	a5,a5,1
     9fe:	fef42223          	sw	a5,-28(s0)
			}
			case 'x': {
				long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
     a02:	fe842783          	lw	a5,-24(s0)
     a06:	cb89                	beqz	a5,a18 <_vsnprintf+0xce>
     a08:	fb042783          	lw	a5,-80(s0)
     a0c:	00478713          	addi	a4,a5,4
     a10:	fae42823          	sw	a4,-80(s0)
     a14:	439c                	lw	a5,0(a5)
     a16:	a801                	j	a26 <_vsnprintf+0xdc>
     a18:	fb042783          	lw	a5,-80(s0)
     a1c:	00478713          	addi	a4,a5,4
     a20:	fae42823          	sw	a4,-80(s0)
     a24:	439c                	lw	a5,0(a5)
     a26:	fcf42423          	sw	a5,-56(s0)
				int hexdigits = 2*(longarg ? sizeof(long) : sizeof(int))-1;
     a2a:	479d                	li	a5,7
     a2c:	fcf42223          	sw	a5,-60(s0)
				for(int i = hexdigits; i >= 0; i--) {
     a30:	fc442783          	lw	a5,-60(s0)
     a34:	fef42023          	sw	a5,-32(s0)
     a38:	a89d                	j	aae <_vsnprintf+0x164>
					int d = (num >> (4*i)) & 0xF;
     a3a:	fe042783          	lw	a5,-32(s0)
     a3e:	078a                	slli	a5,a5,0x2
     a40:	fc842703          	lw	a4,-56(s0)
     a44:	40f757b3          	sra	a5,a4,a5
     a48:	8bbd                	andi	a5,a5,15
     a4a:	fcf42023          	sw	a5,-64(s0)
					if (out && pos < n) {
     a4e:	fbc42783          	lw	a5,-68(s0)
     a52:	c7a1                	beqz	a5,a9a <_vsnprintf+0x150>
     a54:	fe442703          	lw	a4,-28(s0)
     a58:	fb842783          	lw	a5,-72(s0)
     a5c:	02f77f63          	bgeu	a4,a5,a9a <_vsnprintf+0x150>
						out[pos] = (d < 10 ? '0'+d : 'a'+d-10);
     a60:	fc042703          	lw	a4,-64(s0)
     a64:	47a5                	li	a5,9
     a66:	00e7cb63          	blt	a5,a4,a7c <_vsnprintf+0x132>
     a6a:	fc042783          	lw	a5,-64(s0)
     a6e:	0ff7f793          	andi	a5,a5,255
     a72:	03078793          	addi	a5,a5,48
     a76:	0ff7f793          	andi	a5,a5,255
     a7a:	a809                	j	a8c <_vsnprintf+0x142>
     a7c:	fc042783          	lw	a5,-64(s0)
     a80:	0ff7f793          	andi	a5,a5,255
     a84:	05778793          	addi	a5,a5,87
     a88:	0ff7f793          	andi	a5,a5,255
     a8c:	fbc42683          	lw	a3,-68(s0)
     a90:	fe442703          	lw	a4,-28(s0)
     a94:	9736                	add	a4,a4,a3
     a96:	00f70023          	sb	a5,0(a4) # 80000000 <_end_stack+0x5fff0000>
					}
					pos++;
     a9a:	fe442783          	lw	a5,-28(s0)
     a9e:	0785                	addi	a5,a5,1
     aa0:	fef42223          	sw	a5,-28(s0)
				for(int i = hexdigits; i >= 0; i--) {
     aa4:	fe042783          	lw	a5,-32(s0)
     aa8:	17fd                	addi	a5,a5,-1
     aaa:	fef42023          	sw	a5,-32(s0)
     aae:	fe042783          	lw	a5,-32(s0)
     ab2:	f807d4e3          	bgez	a5,a3a <_vsnprintf+0xf0>
				}
				longarg = 0;
     ab6:	fe042423          	sw	zero,-24(s0)
				format = 0;
     aba:	fe042623          	sw	zero,-20(s0)
				break;
     abe:	ac21                	j	cd6 <_vsnprintf+0x38c>
			}
			case 'd': {
				long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
     ac0:	fe842783          	lw	a5,-24(s0)
     ac4:	cb89                	beqz	a5,ad6 <_vsnprintf+0x18c>
     ac6:	fb042783          	lw	a5,-80(s0)
     aca:	00478713          	addi	a4,a5,4
     ace:	fae42823          	sw	a4,-80(s0)
     ad2:	439c                	lw	a5,0(a5)
     ad4:	a801                	j	ae4 <_vsnprintf+0x19a>
     ad6:	fb042783          	lw	a5,-80(s0)
     ada:	00478713          	addi	a4,a5,4
     ade:	fae42823          	sw	a4,-80(s0)
     ae2:	439c                	lw	a5,0(a5)
     ae4:	fcf42e23          	sw	a5,-36(s0)
				if (num < 0) {
     ae8:	fdc42783          	lw	a5,-36(s0)
     aec:	0207df63          	bgez	a5,b2a <_vsnprintf+0x1e0>
					num = -num;
     af0:	fdc42783          	lw	a5,-36(s0)
     af4:	40f007b3          	neg	a5,a5
     af8:	fcf42e23          	sw	a5,-36(s0)
					if (out && pos < n) {
     afc:	fbc42783          	lw	a5,-68(s0)
     b00:	c385                	beqz	a5,b20 <_vsnprintf+0x1d6>
     b02:	fe442703          	lw	a4,-28(s0)
     b06:	fb842783          	lw	a5,-72(s0)
     b0a:	00f77b63          	bgeu	a4,a5,b20 <_vsnprintf+0x1d6>
						out[pos] = '-';
     b0e:	fbc42703          	lw	a4,-68(s0)
     b12:	fe442783          	lw	a5,-28(s0)
     b16:	97ba                	add	a5,a5,a4
     b18:	02d00713          	li	a4,45
     b1c:	00e78023          	sb	a4,0(a5)
					}
					pos++;
     b20:	fe442783          	lw	a5,-28(s0)
     b24:	0785                	addi	a5,a5,1
     b26:	fef42223          	sw	a5,-28(s0)
				}
				long digits = 1;
     b2a:	4785                	li	a5,1
     b2c:	fcf42c23          	sw	a5,-40(s0)
				for (long nn = num; nn /= 10; digits++);
     b30:	fdc42783          	lw	a5,-36(s0)
     b34:	fcf42a23          	sw	a5,-44(s0)
     b38:	a031                	j	b44 <_vsnprintf+0x1fa>
     b3a:	fd842783          	lw	a5,-40(s0)
     b3e:	0785                	addi	a5,a5,1
     b40:	fcf42c23          	sw	a5,-40(s0)
     b44:	fd442703          	lw	a4,-44(s0)
     b48:	47a9                	li	a5,10
     b4a:	02f747b3          	div	a5,a4,a5
     b4e:	fcf42a23          	sw	a5,-44(s0)
     b52:	fd442783          	lw	a5,-44(s0)
     b56:	f3f5                	bnez	a5,b3a <_vsnprintf+0x1f0>
				for (int i = digits-1; i >= 0; i--) {
     b58:	fd842783          	lw	a5,-40(s0)
     b5c:	17fd                	addi	a5,a5,-1
     b5e:	fcf42823          	sw	a5,-48(s0)
     b62:	a8b1                	j	bbe <_vsnprintf+0x274>
					if (out && pos + i < n) {
     b64:	fbc42783          	lw	a5,-68(s0)
     b68:	cf9d                	beqz	a5,ba6 <_vsnprintf+0x25c>
     b6a:	fd042703          	lw	a4,-48(s0)
     b6e:	fe442783          	lw	a5,-28(s0)
     b72:	97ba                	add	a5,a5,a4
     b74:	fb842703          	lw	a4,-72(s0)
     b78:	02e7f763          	bgeu	a5,a4,ba6 <_vsnprintf+0x25c>
						out[pos + i] = '0' + (num % 10);
     b7c:	fdc42703          	lw	a4,-36(s0)
     b80:	47a9                	li	a5,10
     b82:	02f767b3          	rem	a5,a4,a5
     b86:	0ff7f713          	andi	a4,a5,255
     b8a:	fd042683          	lw	a3,-48(s0)
     b8e:	fe442783          	lw	a5,-28(s0)
     b92:	97b6                	add	a5,a5,a3
     b94:	fbc42683          	lw	a3,-68(s0)
     b98:	97b6                	add	a5,a5,a3
     b9a:	03070713          	addi	a4,a4,48
     b9e:	0ff77713          	andi	a4,a4,255
     ba2:	00e78023          	sb	a4,0(a5)
					}
					num /= 10;
     ba6:	fdc42703          	lw	a4,-36(s0)
     baa:	47a9                	li	a5,10
     bac:	02f747b3          	div	a5,a4,a5
     bb0:	fcf42e23          	sw	a5,-36(s0)
				for (int i = digits-1; i >= 0; i--) {
     bb4:	fd042783          	lw	a5,-48(s0)
     bb8:	17fd                	addi	a5,a5,-1
     bba:	fcf42823          	sw	a5,-48(s0)
     bbe:	fd042783          	lw	a5,-48(s0)
     bc2:	fa07d1e3          	bgez	a5,b64 <_vsnprintf+0x21a>
				}
				pos += digits;
     bc6:	fd842783          	lw	a5,-40(s0)
     bca:	fe442703          	lw	a4,-28(s0)
     bce:	97ba                	add	a5,a5,a4
     bd0:	fef42223          	sw	a5,-28(s0)
				longarg = 0;
     bd4:	fe042423          	sw	zero,-24(s0)
				format = 0;
     bd8:	fe042623          	sw	zero,-20(s0)
				break;
     bdc:	a8ed                	j	cd6 <_vsnprintf+0x38c>
			}
			case 's': {
				const char* s2 = va_arg(vl, const char*);
     bde:	fb042783          	lw	a5,-80(s0)
     be2:	00478713          	addi	a4,a5,4
     be6:	fae42823          	sw	a4,-80(s0)
     bea:	439c                	lw	a5,0(a5)
     bec:	fcf42623          	sw	a5,-52(s0)
				while (*s2) {
     bf0:	a83d                	j	c2e <_vsnprintf+0x2e4>
					if (out && pos < n) {
     bf2:	fbc42783          	lw	a5,-68(s0)
     bf6:	c395                	beqz	a5,c1a <_vsnprintf+0x2d0>
     bf8:	fe442703          	lw	a4,-28(s0)
     bfc:	fb842783          	lw	a5,-72(s0)
     c00:	00f77d63          	bgeu	a4,a5,c1a <_vsnprintf+0x2d0>
						out[pos] = *s2;
     c04:	fbc42703          	lw	a4,-68(s0)
     c08:	fe442783          	lw	a5,-28(s0)
     c0c:	97ba                	add	a5,a5,a4
     c0e:	fcc42703          	lw	a4,-52(s0)
     c12:	00074703          	lbu	a4,0(a4)
     c16:	00e78023          	sb	a4,0(a5)
					}
					pos++;
     c1a:	fe442783          	lw	a5,-28(s0)
     c1e:	0785                	addi	a5,a5,1
     c20:	fef42223          	sw	a5,-28(s0)
					s2++;
     c24:	fcc42783          	lw	a5,-52(s0)
     c28:	0785                	addi	a5,a5,1
     c2a:	fcf42623          	sw	a5,-52(s0)
				while (*s2) {
     c2e:	fcc42783          	lw	a5,-52(s0)
     c32:	0007c783          	lbu	a5,0(a5)
     c36:	ffd5                	bnez	a5,bf2 <_vsnprintf+0x2a8>
				}
				longarg = 0;
     c38:	fe042423          	sw	zero,-24(s0)
				format = 0;
     c3c:	fe042623          	sw	zero,-20(s0)
				break;
     c40:	a859                	j	cd6 <_vsnprintf+0x38c>
			}
			case 'c': {
				if (out && pos < n) {
     c42:	fbc42783          	lw	a5,-68(s0)
     c46:	c79d                	beqz	a5,c74 <_vsnprintf+0x32a>
     c48:	fe442703          	lw	a4,-28(s0)
     c4c:	fb842783          	lw	a5,-72(s0)
     c50:	02f77263          	bgeu	a4,a5,c74 <_vsnprintf+0x32a>
					out[pos] = (char)va_arg(vl,int);
     c54:	fb042783          	lw	a5,-80(s0)
     c58:	00478713          	addi	a4,a5,4
     c5c:	fae42823          	sw	a4,-80(s0)
     c60:	4394                	lw	a3,0(a5)
     c62:	fbc42703          	lw	a4,-68(s0)
     c66:	fe442783          	lw	a5,-28(s0)
     c6a:	97ba                	add	a5,a5,a4
     c6c:	0ff6f713          	andi	a4,a3,255
     c70:	00e78023          	sb	a4,0(a5)
				}
				pos++;
     c74:	fe442783          	lw	a5,-28(s0)
     c78:	0785                	addi	a5,a5,1
     c7a:	fef42223          	sw	a5,-28(s0)
				longarg = 0;
     c7e:	fe042423          	sw	zero,-24(s0)
				format = 0;
     c82:	fe042623          	sw	zero,-20(s0)
				break;
     c86:	a881                	j	cd6 <_vsnprintf+0x38c>
			}
			default:
				break;
			}
		} else if (*s == '%') {
     c88:	fb442783          	lw	a5,-76(s0)
     c8c:	0007c703          	lbu	a4,0(a5)
     c90:	02500793          	li	a5,37
     c94:	00f71663          	bne	a4,a5,ca0 <_vsnprintf+0x356>
			format = 1;
     c98:	4785                	li	a5,1
     c9a:	fef42623          	sw	a5,-20(s0)
     c9e:	a825                	j	cd6 <_vsnprintf+0x38c>
		} else {
			if (out && pos < n) {
     ca0:	fbc42783          	lw	a5,-68(s0)
     ca4:	c395                	beqz	a5,cc8 <_vsnprintf+0x37e>
     ca6:	fe442703          	lw	a4,-28(s0)
     caa:	fb842783          	lw	a5,-72(s0)
     cae:	00f77d63          	bgeu	a4,a5,cc8 <_vsnprintf+0x37e>
				out[pos] = *s;
     cb2:	fbc42703          	lw	a4,-68(s0)
     cb6:	fe442783          	lw	a5,-28(s0)
     cba:	97ba                	add	a5,a5,a4
     cbc:	fb442703          	lw	a4,-76(s0)
     cc0:	00074703          	lbu	a4,0(a4)
     cc4:	00e78023          	sb	a4,0(a5)
			}
			pos++;
     cc8:	fe442783          	lw	a5,-28(s0)
     ccc:	0785                	addi	a5,a5,1
     cce:	fef42223          	sw	a5,-28(s0)
     cd2:	a011                	j	cd6 <_vsnprintf+0x38c>
				break;
     cd4:	0001                	nop
	for (; *s; s++) {
     cd6:	fb442783          	lw	a5,-76(s0)
     cda:	0785                	addi	a5,a5,1
     cdc:	faf42a23          	sw	a5,-76(s0)
     ce0:	fb442783          	lw	a5,-76(s0)
     ce4:	0007c783          	lbu	a5,0(a5)
     ce8:	c80793e3          	bnez	a5,96e <_vsnprintf+0x24>
		}
    	}
	if (out && pos < n) {
     cec:	fbc42783          	lw	a5,-68(s0)
     cf0:	cf99                	beqz	a5,d0e <_vsnprintf+0x3c4>
     cf2:	fe442703          	lw	a4,-28(s0)
     cf6:	fb842783          	lw	a5,-72(s0)
     cfa:	00f77a63          	bgeu	a4,a5,d0e <_vsnprintf+0x3c4>
		out[pos] = 0;
     cfe:	fbc42703          	lw	a4,-68(s0)
     d02:	fe442783          	lw	a5,-28(s0)
     d06:	97ba                	add	a5,a5,a4
     d08:	00078023          	sb	zero,0(a5)
     d0c:	a839                	j	d2a <_vsnprintf+0x3e0>
	} else if (out && n) {
     d0e:	fbc42783          	lw	a5,-68(s0)
     d12:	cf81                	beqz	a5,d2a <_vsnprintf+0x3e0>
     d14:	fb842783          	lw	a5,-72(s0)
     d18:	cb89                	beqz	a5,d2a <_vsnprintf+0x3e0>
		out[n-1] = 0;
     d1a:	fb842783          	lw	a5,-72(s0)
     d1e:	17fd                	addi	a5,a5,-1
     d20:	fbc42703          	lw	a4,-68(s0)
     d24:	97ba                	add	a5,a5,a4
     d26:	00078023          	sb	zero,0(a5)
	}
	return pos;
     d2a:	fe442783          	lw	a5,-28(s0)
}
     d2e:	853e                	mv	a0,a5
     d30:	4436                	lw	s0,76(sp)
     d32:	6161                	addi	sp,sp,80
     d34:	8082                	ret

00000d36 <_vprintf>:

static char out_buf[1000]; // buffer for _vprintf()

static int _vprintf(const char* s, va_list vl)
{
     d36:	7179                	addi	sp,sp,-48
     d38:	d606                	sw	ra,44(sp)
     d3a:	d422                	sw	s0,40(sp)
     d3c:	1800                	addi	s0,sp,48
     d3e:	fca42e23          	sw	a0,-36(s0)
     d42:	fcb42c23          	sw	a1,-40(s0)
	int res = _vsnprintf(NULL, -1, s, vl);
     d46:	fd842683          	lw	a3,-40(s0)
     d4a:	fdc42603          	lw	a2,-36(s0)
     d4e:	55fd                	li	a1,-1
     d50:	4501                	li	a0,0
     d52:	3ee5                	jal	94a <_vsnprintf>
     d54:	fea42623          	sw	a0,-20(s0)
	if (res+1 >= sizeof(out_buf)) {
     d58:	fec42783          	lw	a5,-20(s0)
     d5c:	0785                	addi	a5,a5,1
     d5e:	873e                	mv	a4,a5
     d60:	3e700793          	li	a5,999
     d64:	00e7f863          	bgeu	a5,a4,d74 <_vprintf+0x3e>
		puts("error: output string size overflow\n");
     d68:	6789                	lui	a5,0x2
     d6a:	72478513          	addi	a0,a5,1828 # 2724 <STACK_END+0x64>
     d6e:	f9aff0ef          	jal	ra,508 <puts>
		while(1) {}
     d72:	a001                	j	d72 <_vprintf+0x3c>
	}
	_vsnprintf(out_buf, res + 1, s, vl);
     d74:	fec42783          	lw	a5,-20(s0)
     d78:	0785                	addi	a5,a5,1
     d7a:	fd842683          	lw	a3,-40(s0)
     d7e:	fdc42603          	lw	a2,-36(s0)
     d82:	85be                	mv	a1,a5
     d84:	200007b7          	lui	a5,0x20000
     d88:	02878513          	addi	a0,a5,40 # 20000028 <out_buf>
     d8c:	3e7d                	jal	94a <_vsnprintf>
	puts(out_buf);
     d8e:	200007b7          	lui	a5,0x20000
     d92:	02878513          	addi	a0,a5,40 # 20000028 <out_buf>
     d96:	f72ff0ef          	jal	ra,508 <puts>
	return res;
     d9a:	fec42783          	lw	a5,-20(s0)
}
     d9e:	853e                	mv	a0,a5
     da0:	50b2                	lw	ra,44(sp)
     da2:	5422                	lw	s0,40(sp)
     da4:	6145                	addi	sp,sp,48
     da6:	8082                	ret

00000da8 <printf>:

int printf(const char* s, ...)
{
     da8:	715d                	addi	sp,sp,-80
     daa:	d606                	sw	ra,44(sp)
     dac:	d422                	sw	s0,40(sp)
     dae:	1800                	addi	s0,sp,48
     db0:	fca42e23          	sw	a0,-36(s0)
     db4:	c04c                	sw	a1,4(s0)
     db6:	c410                	sw	a2,8(s0)
     db8:	c454                	sw	a3,12(s0)
     dba:	c818                	sw	a4,16(s0)
     dbc:	c85c                	sw	a5,20(s0)
     dbe:	01042c23          	sw	a6,24(s0)
     dc2:	01142e23          	sw	a7,28(s0)
	int res = 0;
     dc6:	fe042623          	sw	zero,-20(s0)
	va_list vl;
	va_start(vl, s);
     dca:	02040793          	addi	a5,s0,32
     dce:	1791                	addi	a5,a5,-28
     dd0:	fef42423          	sw	a5,-24(s0)
	res = _vprintf(s, vl);
     dd4:	fe842783          	lw	a5,-24(s0)
     dd8:	85be                	mv	a1,a5
     dda:	fdc42503          	lw	a0,-36(s0)
     dde:	3fa1                	jal	d36 <_vprintf>
     de0:	fea42623          	sw	a0,-20(s0)
	va_end(vl);
	return res;
     de4:	fec42783          	lw	a5,-20(s0)
}
     de8:	853e                	mv	a0,a5
     dea:	50b2                	lw	ra,44(sp)
     dec:	5422                	lw	s0,40(sp)
     dee:	6161                	addi	sp,sp,80
     df0:	8082                	ret

00000df2 <panic>:

void panic(char *s)
{
     df2:	1101                	addi	sp,sp,-32
     df4:	ce06                	sw	ra,28(sp)
     df6:	cc22                	sw	s0,24(sp)
     df8:	1000                	addi	s0,sp,32
     dfa:	fea42623          	sw	a0,-20(s0)
	printf("panic: ");
     dfe:	6789                	lui	a5,0x2
     e00:	74878513          	addi	a0,a5,1864 # 2748 <STACK_END+0x88>
     e04:	3755                	jal	da8 <printf>
	printf(s);
     e06:	fec42503          	lw	a0,-20(s0)
     e0a:	3f79                	jal	da8 <printf>
	printf("\n");
     e0c:	6789                	lui	a5,0x2
     e0e:	75078513          	addi	a0,a5,1872 # 2750 <STACK_END+0x90>
     e12:	3f59                	jal	da8 <printf>
	while(1){};
     e14:	a001                	j	e14 <panic+0x22>
	...

00000e18 <w_mscratch>:
	return x;
}

/* Machine Scratch register, for early trap handler */
static inline __attribute__((aligned(4))) void w_mscratch(reg_t x)
{
     e18:	1101                	addi	sp,sp,-32
     e1a:	ce22                	sw	s0,28(sp)
     e1c:	1000                	addi	s0,sp,32
     e1e:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mscratch, %0" : : "r" (x));
     e22:	fec42783          	lw	a5,-20(s0)
     e26:	34079073          	csrw	mscratch,a5
}
     e2a:	0001                	nop
     e2c:	4472                	lw	s0,28(sp)
     e2e:	6105                	addi	sp,sp,32
     e30:	8082                	ret

00000e32 <MC_schedule>:

uint8_t MC_schedule_flag = 0;
struct MC_sched MC_scheduler;

void MC_schedule()
{
     e32:	1101                	addi	sp,sp,-32
     e34:	ce06                	sw	ra,28(sp)
     e36:	cc22                	sw	s0,24(sp)
     e38:	ca26                	sw	s1,20(sp)
     e3a:	1000                	addi	s0,sp,32
    MC_thread_t from_thread = NULL, to_thread = NULL;
     e3c:	fe042623          	sw	zero,-20(s0)
     e40:	fe042423          	sw	zero,-24(s0)
    if(MC_scheduler.sched_state == SCHED_RUNNING)
     e44:	200007b7          	lui	a5,0x20000
     e48:	4347c703          	lbu	a4,1076(a5) # 20000434 <MC_scheduler>
     e4c:	4785                	li	a5,1
     e4e:	00f71a63          	bne	a4,a5,e62 <MC_schedule+0x30>
    {
        from_thread = MC_scheduler.running_thread;
     e52:	200007b7          	lui	a5,0x20000
     e56:	43478793          	addi	a5,a5,1076 # 20000434 <MC_scheduler>
     e5a:	43dc                	lw	a5,4(a5)
     e5c:	fef42623          	sw	a5,-20(s0)
     e60:	a811                	j	e74 <MC_schedule+0x42>
    }
    else
    {
        MC_scheduler.sched_state = SCHED_RUNNING;
     e62:	200007b7          	lui	a5,0x20000
     e66:	4705                	li	a4,1
     e68:	42e78a23          	sb	a4,1076(a5) # 20000434 <MC_scheduler>
        from_thread = NULL;
     e6c:	fe042623          	sw	zero,-20(s0)
        w_mscratch(0);
     e70:	4501                	li	a0,0
     e72:	375d                	jal	e18 <w_mscratch>
    }

    for(int i = 63; i >= 0; i--)
     e74:	03f00793          	li	a5,63
     e78:	fef42223          	sw	a5,-28(s0)
     e7c:	a8f1                	j	f58 <MC_schedule+0x126>
    {
        if(Ready_threadList_Start[i].next != &Ready_threadList_End[i])
     e7e:	20000737          	lui	a4,0x20000
     e82:	fe442783          	lw	a5,-28(s0)
     e86:	44470713          	addi	a4,a4,1092 # 20000444 <Ready_threadList_Start>
     e8a:	078e                	slli	a5,a5,0x3
     e8c:	97ba                	add	a5,a5,a4
     e8e:	43d8                	lw	a4,4(a5)
     e90:	fe442783          	lw	a5,-28(s0)
     e94:	00379693          	slli	a3,a5,0x3
     e98:	200007b7          	lui	a5,0x20000
     e9c:	64478793          	addi	a5,a5,1604 # 20000644 <Ready_threadList_End>
     ea0:	97b6                	add	a5,a5,a3
     ea2:	0af70663          	beq	a4,a5,f4e <MC_schedule+0x11c>
        {
            to_thread = MC_container_of(Ready_threadList_Start[i].next, struct MC_thread, node);
     ea6:	20000737          	lui	a4,0x20000
     eaa:	fe442783          	lw	a5,-28(s0)
     eae:	44470713          	addi	a4,a4,1092 # 20000444 <Ready_threadList_Start>
     eb2:	078e                	slli	a5,a5,0x3
     eb4:	97ba                	add	a5,a5,a4
     eb6:	43dc                	lw	a5,4(a5)
     eb8:	fa878793          	addi	a5,a5,-88
     ebc:	fef42423          	sw	a5,-24(s0)
            Ready_threadList_Start[i].next = to_thread->node.next;
     ec0:	fe842783          	lw	a5,-24(s0)
     ec4:	4ff8                	lw	a4,92(a5)
     ec6:	200006b7          	lui	a3,0x20000
     eca:	fe442783          	lw	a5,-28(s0)
     ece:	44468693          	addi	a3,a3,1092 # 20000444 <Ready_threadList_Start>
     ed2:	078e                	slli	a5,a5,0x3
     ed4:	97b6                	add	a5,a5,a3
     ed6:	c3d8                	sw	a4,4(a5)
            to_thread->node.next->prev = &Ready_threadList_Start[i];
     ed8:	fe842783          	lw	a5,-24(s0)
     edc:	4ffc                	lw	a5,92(a5)
     ede:	fe442703          	lw	a4,-28(s0)
     ee2:	00371693          	slli	a3,a4,0x3
     ee6:	20000737          	lui	a4,0x20000
     eea:	44470713          	addi	a4,a4,1092 # 20000444 <Ready_threadList_Start>
     eee:	9736                	add	a4,a4,a3
     ef0:	c398                	sw	a4,0(a5)

            // 把要运行的线程插入队尾
            to_thread->node.next = &Ready_threadList_End[i];
     ef2:	fe442783          	lw	a5,-28(s0)
     ef6:	00379713          	slli	a4,a5,0x3
     efa:	200007b7          	lui	a5,0x20000
     efe:	64478793          	addi	a5,a5,1604 # 20000644 <Ready_threadList_End>
     f02:	973e                	add	a4,a4,a5
     f04:	fe842783          	lw	a5,-24(s0)
     f08:	cff8                	sw	a4,92(a5)
            to_thread->node.prev = Ready_threadList_End[i].prev;
     f0a:	200007b7          	lui	a5,0x20000
     f0e:	fe442703          	lw	a4,-28(s0)
     f12:	070e                	slli	a4,a4,0x3
     f14:	64478793          	addi	a5,a5,1604 # 20000644 <Ready_threadList_End>
     f18:	97ba                	add	a5,a5,a4
     f1a:	4398                	lw	a4,0(a5)
     f1c:	fe842783          	lw	a5,-24(s0)
     f20:	cfb8                	sw	a4,88(a5)
            Ready_threadList_End[i].prev = &to_thread->node;
     f22:	fe842783          	lw	a5,-24(s0)
     f26:	05878713          	addi	a4,a5,88
     f2a:	200007b7          	lui	a5,0x20000
     f2e:	fe442683          	lw	a3,-28(s0)
     f32:	068e                	slli	a3,a3,0x3
     f34:	64478793          	addi	a5,a5,1604 # 20000644 <Ready_threadList_End>
     f38:	97b6                	add	a5,a5,a3
     f3a:	c398                	sw	a4,0(a5)
            to_thread->node.prev->next = &to_thread->node;
     f3c:	fe842783          	lw	a5,-24(s0)
     f40:	4fbc                	lw	a5,88(a5)
     f42:	fe842703          	lw	a4,-24(s0)
     f46:	05870713          	addi	a4,a4,88
     f4a:	c3d8                	sw	a4,4(a5)
            
            break;
     f4c:	a811                	j	f60 <MC_schedule+0x12e>
    for(int i = 63; i >= 0; i--)
     f4e:	fe442783          	lw	a5,-28(s0)
     f52:	17fd                	addi	a5,a5,-1
     f54:	fef42223          	sw	a5,-28(s0)
     f58:	fe442783          	lw	a5,-28(s0)
     f5c:	f207d1e3          	bgez	a5,e7e <MC_schedule+0x4c>
        }
    }
    
    if(to_thread == NULL)
     f60:	fe842783          	lw	a5,-24(s0)
     f64:	c7c9                	beqz	a5,fee <MC_schedule+0x1bc>
    {
        return ;
    }

    if(from_thread != to_thread)
     f66:	fec42703          	lw	a4,-20(s0)
     f6a:	fe842783          	lw	a5,-24(s0)
     f6e:	08f70263          	beq	a4,a5,ff2 <MC_schedule+0x1c0>
    {
        MC_scheduler.running_thread = to_thread;
     f72:	200007b7          	lui	a5,0x20000
     f76:	43478793          	addi	a5,a5,1076 # 20000434 <MC_scheduler>
     f7a:	fe842703          	lw	a4,-24(s0)
     f7e:	c3d8                	sw	a4,4(a5)

        to_thread->timer.timeout_tick = to_thread->timer.init_tick + MC_get_tick();
     f80:	fe842783          	lw	a5,-24(s0)
     f84:	4ba4                	lw	s1,80(a5)
     f86:	493000ef          	jal	ra,1c18 <MC_get_tick>
     f8a:	87aa                	mv	a5,a0
     f8c:	00f48733          	add	a4,s1,a5
     f90:	fe842783          	lw	a5,-24(s0)
     f94:	cbf8                	sw	a4,84(a5)
        MC_timer_list_insert(&to_thread->timer.node);
     f96:	fe842783          	lw	a5,-24(s0)
     f9a:	04878793          	addi	a5,a5,72
     f9e:	853e                	mv	a0,a5
     fa0:	06b000ef          	jal	ra,180a <MC_timer_list_insert>
        //移除from_thread的定时器
        if(from_thread != NULL && from_thread->state == MC_THREAD_STATE_RUNNING)
     fa4:	fec42783          	lw	a5,-20(s0)
     fa8:	cf89                	beqz	a5,fc2 <MC_schedule+0x190>
     faa:	fec42783          	lw	a5,-20(s0)
     fae:	0607c783          	lbu	a5,96(a5)
     fb2:	eb81                	bnez	a5,fc2 <MC_schedule+0x190>
        {
            MC_timer_list_remove(&from_thread->timer.node);
     fb4:	fec42783          	lw	a5,-20(s0)
     fb8:	04878793          	addi	a5,a5,72
     fbc:	853e                	mv	a0,a5
     fbe:	0fb000ef          	jal	ra,18b8 <MC_timer_list_remove>
        }
        
        //避免线程是因为阻塞产生的调度，导致状态出错
        if(from_thread->state == MC_THREAD_STATE_RUNNING)
     fc2:	fec42783          	lw	a5,-20(s0)
     fc6:	0607c783          	lbu	a5,96(a5)
     fca:	e791                	bnez	a5,fd6 <MC_schedule+0x1a4>
        {
            from_thread->state = MC_THREAD_STATE_READY;
     fcc:	fec42783          	lw	a5,-20(s0)
     fd0:	4705                	li	a4,1
     fd2:	06e78023          	sb	a4,96(a5)
        }
        to_thread->state = MC_THREAD_STATE_RUNNING;
     fd6:	fe842783          	lw	a5,-24(s0)
     fda:	06078023          	sb	zero,96(a5)

        MC_hw_context_switch(to_thread->stack_addr);
     fde:	fe842783          	lw	a5,-24(s0)
     fe2:	4fdc                	lw	a5,28(a5)
     fe4:	853e                	mv	a0,a5
     fe6:	adaff0ef          	jal	ra,2c0 <MC_hw_context_switch>
    }

    return;
     fea:	0001                	nop
     fec:	a019                	j	ff2 <MC_schedule+0x1c0>
        return ;
     fee:	0001                	nop
     ff0:	a011                	j	ff4 <MC_schedule+0x1c2>
    return;
     ff2:	0001                	nop
}
     ff4:	40f2                	lw	ra,28(sp)
     ff6:	4462                	lw	s0,24(sp)
     ff8:	44d2                	lw	s1,20(sp)
     ffa:	6105                	addi	sp,sp,32
     ffc:	8082                	ret

00000ffe <MC_scheduler_begin>:

/**
 * 发起一次调度
 */
void MC_scheduler_begin()
{
     ffe:	1141                	addi	sp,sp,-16
    1000:	c606                	sw	ra,12(sp)
    1002:	c422                	sw	s0,8(sp)
    1004:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_STOP)
    1006:	200007b7          	lui	a5,0x20000
    100a:	4347c783          	lbu	a5,1076(a5) # 20000434 <MC_scheduler>
    100e:	e791                	bnez	a5,101a <__stack_size+0x1a>
    {
        MC_scheduler.sched_state = SCHED_RUNNING;
    1010:	200007b7          	lui	a5,0x20000
    1014:	4705                	li	a4,1
    1016:	42e78a23          	sb	a4,1076(a5) # 20000434 <MC_scheduler>
    }
    //在软件中断中调度下一个线程
    MC_schedule_flag = 1;
    101a:	200007b7          	lui	a5,0x20000
    101e:	4705                	li	a4,1
    1020:	40e78823          	sb	a4,1040(a5) # 20000410 <MC_schedule_flag>
    MC_pfic_pending_set(SOFTWARE_IRQ);
    1024:	4539                	li	a0,14
    1026:	72b000ef          	jal	ra,1f50 <MC_pfic_pending_set>
    return ;
    102a:	0001                	nop
}
    102c:	40b2                	lw	ra,12(sp)
    102e:	4422                	lw	s0,8(sp)
    1030:	0141                	addi	sp,sp,16
    1032:	8082                	ret

00001034 <MC_scheduler_start>:

/**
 * 开启调度器
 */
void MC_scheduler_start()
{
    1034:	1141                	addi	sp,sp,-16
    1036:	c622                	sw	s0,12(sp)
    1038:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_STOP)
    103a:	200007b7          	lui	a5,0x20000
    103e:	4347c783          	lbu	a5,1076(a5) # 20000434 <MC_scheduler>
    1042:	e391                	bnez	a5,1046 <MC_scheduler_start+0x12>
    {
        MC_scheduler.sched_state == SCHED_RUNNING;
    }
    return ;
    1044:	0001                	nop
    1046:	0001                	nop
}
    1048:	4432                	lw	s0,12(sp)
    104a:	0141                	addi	sp,sp,16
    104c:	8082                	ret

0000104e <MC_scheduler_stop>:

/**
 * 关闭调度器
 */
void MC_scheduler_stop()
{
    104e:	1141                	addi	sp,sp,-16
    1050:	c622                	sw	s0,12(sp)
    1052:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_RUNNING)
    1054:	200007b7          	lui	a5,0x20000
    1058:	4347c703          	lbu	a4,1076(a5) # 20000434 <MC_scheduler>
    105c:	4785                	li	a5,1
    105e:	00f71363          	bne	a4,a5,1064 <MC_scheduler_stop+0x16>
    {
        MC_scheduler.sched_state == SCHED_STOP;
    }
    return ;
    1062:	0001                	nop
    1064:	0001                	nop
}
    1066:	4432                	lw	s0,12(sp)
    1068:	0141                	addi	sp,sp,16
    106a:	8082                	ret

0000106c <MC_scheduler_remove_thread>:

/**
 * 把线程从所在就绪队列中移除
*/
void MC_scheduler_remove_thread(MC_thread_t thread)
{
    106c:	1101                	addi	sp,sp,-32
    106e:	ce22                	sw	s0,28(sp)
    1070:	1000                	addi	s0,sp,32
    1072:	fea42623          	sw	a0,-20(s0)
    // 如果线程不在就绪队列中,则不操作
    if(thread->state != MC_THREAD_STATE_READY && thread->state != MC_THREAD_STATE_RUNNING)
    1076:	fec42783          	lw	a5,-20(s0)
    107a:	0607c703          	lbu	a4,96(a5)
    107e:	4785                	li	a5,1
    1080:	00f70763          	beq	a4,a5,108e <MC_scheduler_remove_thread+0x22>
    1084:	fec42783          	lw	a5,-20(s0)
    1088:	0607c783          	lbu	a5,96(a5)
    108c:	ef9d                	bnez	a5,10ca <MC_scheduler_remove_thread+0x5e>
    {
        return;
    }

    thread->node.next->prev = thread->node.prev;
    108e:	fec42783          	lw	a5,-20(s0)
    1092:	4ffc                	lw	a5,92(a5)
    1094:	fec42703          	lw	a4,-20(s0)
    1098:	4f38                	lw	a4,88(a4)
    109a:	c398                	sw	a4,0(a5)
    thread->node.prev->next = thread->node.next;
    109c:	fec42783          	lw	a5,-20(s0)
    10a0:	4fbc                	lw	a5,88(a5)
    10a2:	fec42703          	lw	a4,-20(s0)
    10a6:	4f78                	lw	a4,92(a4)
    10a8:	c3d8                	sw	a4,4(a5)
    thread->node.prev = thread->node.next = NULL;
    10aa:	fec42783          	lw	a5,-20(s0)
    10ae:	0407ae23          	sw	zero,92(a5)
    10b2:	fec42783          	lw	a5,-20(s0)
    10b6:	4ff8                	lw	a4,92(a5)
    10b8:	fec42783          	lw	a5,-20(s0)
    10bc:	cfb8                	sw	a4,88(a5)

    thread->state = MC_THREAD_STATE_NULL;
    10be:	fec42783          	lw	a5,-20(s0)
    10c2:	4711                	li	a4,4
    10c4:	06e78023          	sb	a4,96(a5)
    10c8:	a011                	j	10cc <MC_scheduler_remove_thread+0x60>
        return;
    10ca:	0001                	nop
}
    10cc:	4472                	lw	s0,28(sp)
    10ce:	6105                	addi	sp,sp,32
    10d0:	8082                	ret
	...

000010d4 <_thread_init>:
                uint8_t *stack_start,
                size_t stack_size,
                uint8_t priority,
                uint32_t tick,
                uint8_t flag)
{
    10d4:	7139                	addi	sp,sp,-64
    10d6:	de06                	sw	ra,60(sp)
    10d8:	dc22                	sw	s0,56(sp)
    10da:	0080                	addi	s0,sp,64
    10dc:	fca42e23          	sw	a0,-36(s0)
    10e0:	fcb42c23          	sw	a1,-40(s0)
    10e4:	fcc42a23          	sw	a2,-44(s0)
    10e8:	fcd42823          	sw	a3,-48(s0)
    10ec:	fce42623          	sw	a4,-52(s0)
    10f0:	fd042223          	sw	a6,-60(s0)
    10f4:	8746                	mv	a4,a7
    10f6:	fcf405a3          	sb	a5,-53(s0)
    10fa:	87ba                	mv	a5,a4
    10fc:	fcf40523          	sb	a5,-54(s0)
    size_t name_len = MC_strlen(name);
    1100:	fd842503          	lw	a0,-40(s0)
    1104:	23d9                	jal	16ca <MC_strlen>
    1106:	fea42623          	sw	a0,-20(s0)
    MC_memcpy(thread->name, name, name_len);
    110a:	fdc42783          	lw	a5,-36(s0)
    110e:	fec42703          	lw	a4,-20(s0)
    1112:	863a                	mv	a2,a4
    1114:	fd842583          	lw	a1,-40(s0)
    1118:	853e                	mv	a0,a5
    111a:	2b25                	jal	1652 <MC_memcpy>
    thread->sp = stack_start + stack_size;
    111c:	fd042703          	lw	a4,-48(s0)
    1120:	fcc42783          	lw	a5,-52(s0)
    1124:	973e                	add	a4,a4,a5
    1126:	fdc42783          	lw	a5,-36(s0)
    112a:	cbd8                	sw	a4,20(a5)
    thread->entry = entry;
    112c:	fdc42783          	lw	a5,-36(s0)
    1130:	fd442703          	lw	a4,-44(s0)
    1134:	cf98                	sw	a4,24(a5)
    thread->stack_addr = stack_start;
    1136:	fdc42783          	lw	a5,-36(s0)
    113a:	fd042703          	lw	a4,-48(s0)
    113e:	cfd8                	sw	a4,28(a5)
    thread->stack_size = stack_size;
    1140:	fdc42783          	lw	a5,-36(s0)
    1144:	fcc42703          	lw	a4,-52(s0)
    1148:	d398                	sw	a4,32(a5)
    thread->priority = priority;
    114a:	fdc42783          	lw	a5,-36(s0)
    114e:	fcb44703          	lbu	a4,-53(s0)
    1152:	02e78223          	sb	a4,36(a5)
    thread->inheritPriority = priority;
    1156:	fdc42783          	lw	a5,-36(s0)
    115a:	fcb44703          	lbu	a4,-53(s0)
    115e:	02e782a3          	sb	a4,37(a5)

    MC_timer_init(&thread->timer,
    1162:	fdc42783          	lw	a5,-36(s0)
    1166:	02878513          	addi	a0,a5,40
    116a:	fca44783          	lbu	a5,-54(s0)
    116e:	0047e793          	ori	a5,a5,4
    1172:	0ff7f793          	andi	a5,a5,255
    1176:	fc442703          	lw	a4,-60(s0)
    117a:	4681                	li	a3,0
    117c:	4601                	li	a2,0
    117e:	fd842583          	lw	a1,-40(s0)
    1182:	103000ef          	jal	ra,1a84 <MC_timer_init>
        name,
        NULL, 
        NULL, 
        tick, 
        MC_TIMER_FLAG_THREAD_TIMER | flag);
}
    1186:	0001                	nop
    1188:	50f2                	lw	ra,60(sp)
    118a:	5462                	lw	s0,56(sp)
    118c:	6121                	addi	sp,sp,64
    118e:	8082                	ret

00001190 <MC_threadList_Init>:

void MC_threadList_Init()
{
    1190:	1101                	addi	sp,sp,-32
    1192:	ce22                	sw	s0,28(sp)
    1194:	1000                	addi	s0,sp,32
    for(int i = 0; i < 64; i++)
    1196:	fe042623          	sw	zero,-20(s0)
    119a:	a8b5                	j	1216 <MC_threadList_Init+0x86>
    {
        Ready_threadList_Start[i].prev = NULL;
    119c:	200007b7          	lui	a5,0x20000
    11a0:	fec42703          	lw	a4,-20(s0)
    11a4:	070e                	slli	a4,a4,0x3
    11a6:	44478793          	addi	a5,a5,1092 # 20000444 <Ready_threadList_Start>
    11aa:	97ba                	add	a5,a5,a4
    11ac:	0007a023          	sw	zero,0(a5)
        Ready_threadList_Start[i].next = &Ready_threadList_End[i];
    11b0:	fec42783          	lw	a5,-20(s0)
    11b4:	00379713          	slli	a4,a5,0x3
    11b8:	200007b7          	lui	a5,0x20000
    11bc:	64478793          	addi	a5,a5,1604 # 20000644 <Ready_threadList_End>
    11c0:	973e                	add	a4,a4,a5
    11c2:	200006b7          	lui	a3,0x20000
    11c6:	fec42783          	lw	a5,-20(s0)
    11ca:	44468693          	addi	a3,a3,1092 # 20000444 <Ready_threadList_Start>
    11ce:	078e                	slli	a5,a5,0x3
    11d0:	97b6                	add	a5,a5,a3
    11d2:	c3d8                	sw	a4,4(a5)

        Ready_threadList_End[i].prev = &Ready_threadList_Start[i];
    11d4:	fec42783          	lw	a5,-20(s0)
    11d8:	00379713          	slli	a4,a5,0x3
    11dc:	200007b7          	lui	a5,0x20000
    11e0:	44478793          	addi	a5,a5,1092 # 20000444 <Ready_threadList_Start>
    11e4:	973e                	add	a4,a4,a5
    11e6:	200007b7          	lui	a5,0x20000
    11ea:	fec42683          	lw	a3,-20(s0)
    11ee:	068e                	slli	a3,a3,0x3
    11f0:	64478793          	addi	a5,a5,1604 # 20000644 <Ready_threadList_End>
    11f4:	97b6                	add	a5,a5,a3
    11f6:	c398                	sw	a4,0(a5)
        Ready_threadList_End[i].next = NULL;
    11f8:	20000737          	lui	a4,0x20000
    11fc:	fec42783          	lw	a5,-20(s0)
    1200:	64470713          	addi	a4,a4,1604 # 20000644 <Ready_threadList_End>
    1204:	078e                	slli	a5,a5,0x3
    1206:	97ba                	add	a5,a5,a4
    1208:	0007a223          	sw	zero,4(a5)
    for(int i = 0; i < 64; i++)
    120c:	fec42783          	lw	a5,-20(s0)
    1210:	0785                	addi	a5,a5,1
    1212:	fef42623          	sw	a5,-20(s0)
    1216:	fec42703          	lw	a4,-20(s0)
    121a:	03f00793          	li	a5,63
    121e:	f6e7dfe3          	bge	a5,a4,119c <MC_threadList_Init+0xc>
    }

    Suspend_threadList.next = Suspend_threadList.prev = NULL;
    1222:	200007b7          	lui	a5,0x20000
    1226:	4207ae23          	sw	zero,1084(a5) # 2000043c <Suspend_threadList>
    122a:	200007b7          	lui	a5,0x20000
    122e:	43c7a703          	lw	a4,1084(a5) # 2000043c <Suspend_threadList>
    1232:	200007b7          	lui	a5,0x20000
    1236:	43c78793          	addi	a5,a5,1084 # 2000043c <Suspend_threadList>
    123a:	c3d8                	sw	a4,4(a5)
}
    123c:	0001                	nop
    123e:	4472                	lw	s0,28(sp)
    1240:	6105                	addi	sp,sp,32
    1242:	8082                	ret

00001244 <MC_thread_create>:
                            void (*entry)(void),
                            size_t stack_size,
                            uint8_t priority,
                            uint32_t tick,
                            uint8_t flag)
{
    1244:	7139                	addi	sp,sp,-64
    1246:	de06                	sw	ra,60(sp)
    1248:	dc22                	sw	s0,56(sp)
    124a:	0080                	addi	s0,sp,64
    124c:	fca42e23          	sw	a0,-36(s0)
    1250:	fcb42c23          	sw	a1,-40(s0)
    1254:	fcc42a23          	sw	a2,-44(s0)
    1258:	fce42623          	sw	a4,-52(s0)
    125c:	873e                	mv	a4,a5
    125e:	87b6                	mv	a5,a3
    1260:	fcf409a3          	sb	a5,-45(s0)
    1264:	87ba                	mv	a5,a4
    1266:	fcf40923          	sb	a5,-46(s0)
    MC_thread_t thread;
    uint8_t *stack_start;

    if(Ready_threadList_Start[0].next == NULL)
    126a:	200007b7          	lui	a5,0x20000
    126e:	44478793          	addi	a5,a5,1092 # 20000444 <Ready_threadList_Start>
    1272:	43dc                	lw	a5,4(a5)
    1274:	e391                	bnez	a5,1278 <MC_thread_create+0x34>
    {
        MC_threadList_Init();
    1276:	3f29                	jal	1190 <MC_threadList_Init>
    }

    thread = (MC_thread_t)MC_PageMalloc(sizeof(struct MC_thread));
    1278:	06400513          	li	a0,100
    127c:	bd6ff0ef          	jal	ra,652 <MC_PageMalloc>
    1280:	fea42623          	sw	a0,-20(s0)
    if(thread == NULL)
    1284:	fec42783          	lw	a5,-20(s0)
    1288:	e399                	bnez	a5,128e <MC_thread_create+0x4a>
    {
        return NULL;
    128a:	4781                	li	a5,0
    128c:	a0b9                	j	12da <MC_thread_create+0x96>
    }

    stack_size = stack_size + extra_size_for_context;
    128e:	08000793          	li	a5,128
    1292:	fd442703          	lw	a4,-44(s0)
    1296:	97ba                	add	a5,a5,a4
    1298:	fcf42a23          	sw	a5,-44(s0)
    stack_start = (uint8_t *)MC_PageMalloc(stack_size);
    129c:	fd442503          	lw	a0,-44(s0)
    12a0:	bb2ff0ef          	jal	ra,652 <MC_PageMalloc>
    12a4:	fea42423          	sw	a0,-24(s0)
    if(stack_start == NULL)
    12a8:	fe842783          	lw	a5,-24(s0)
    12ac:	e399                	bnez	a5,12b2 <MC_thread_create+0x6e>
    {
        return NULL;
    12ae:	4781                	li	a5,0
    12b0:	a02d                	j	12da <MC_thread_create+0x96>
    }

    _thread_init(thread,
    12b2:	fd244703          	lbu	a4,-46(s0)
    12b6:	fd344783          	lbu	a5,-45(s0)
    12ba:	88ba                	mv	a7,a4
    12bc:	fcc42803          	lw	a6,-52(s0)
    12c0:	fd442703          	lw	a4,-44(s0)
    12c4:	fe842683          	lw	a3,-24(s0)
    12c8:	fd842603          	lw	a2,-40(s0)
    12cc:	fdc42583          	lw	a1,-36(s0)
    12d0:	fec42503          	lw	a0,-20(s0)
    12d4:	3501                	jal	10d4 <_thread_init>
                stack_size,
                priority,
                tick,
                flag);
    
    return thread;
    12d6:	fec42783          	lw	a5,-20(s0)
}
    12da:	853e                	mv	a0,a5
    12dc:	50f2                	lw	ra,60(sp)
    12de:	5462                	lw	s0,56(sp)
    12e0:	6121                	addi	sp,sp,64
    12e2:	8082                	ret

000012e4 <MC_thread_delete>:

uint8_t MC_thread_delete(MC_thread_t thread)
{
    12e4:	1101                	addi	sp,sp,-32
    12e6:	ce06                	sw	ra,28(sp)
    12e8:	cc22                	sw	s0,24(sp)
    12ea:	1000                	addi	s0,sp,32
    12ec:	fea42623          	sw	a0,-20(s0)
    thread->node.next->prev = thread->node.prev;
    12f0:	fec42783          	lw	a5,-20(s0)
    12f4:	4ffc                	lw	a5,92(a5)
    12f6:	fec42703          	lw	a4,-20(s0)
    12fa:	4f38                	lw	a4,88(a4)
    12fc:	c398                	sw	a4,0(a5)
    thread->node.prev->next = thread->node.next;
    12fe:	fec42783          	lw	a5,-20(s0)
    1302:	4fbc                	lw	a5,88(a5)
    1304:	fec42703          	lw	a4,-20(s0)
    1308:	4f78                	lw	a4,92(a4)
    130a:	c3d8                	sw	a4,4(a5)

    MC_PageFree(thread);
    130c:	fec42503          	lw	a0,-20(s0)
    1310:	daaff0ef          	jal	ra,8ba <MC_PageFree>
    MC_PageFree(thread->stack_addr);
    1314:	fec42783          	lw	a5,-20(s0)
    1318:	4fdc                	lw	a5,28(a5)
    131a:	853e                	mv	a0,a5
    131c:	d9eff0ef          	jal	ra,8ba <MC_PageFree>
    return 0;
    1320:	4781                	li	a5,0
}
    1322:	853e                	mv	a0,a5
    1324:	40f2                	lw	ra,28(sp)
    1326:	4462                	lw	s0,24(sp)
    1328:	6105                	addi	sp,sp,32
    132a:	8082                	ret

0000132c <MC_thread_startup>:
extern struct MC_sched MC_scheduler;
/**
 * 把任务加入就绪队列
 */
uint8_t MC_thread_startup(MC_thread_t thread)
{
    132c:	7179                	addi	sp,sp,-48
    132e:	d622                	sw	s0,44(sp)
    1330:	1800                	addi	s0,sp,48
    1332:	fca42e23          	sw	a0,-36(s0)
    uint8_t priority = thread->priority;
    1336:	fdc42783          	lw	a5,-36(s0)
    133a:	0247c783          	lbu	a5,36(a5)
    133e:	fef407a3          	sb	a5,-17(s0)

    *(size_t *)((uint8_t *)(thread->stack_addr) + 0) = (size_t)thread->entry;
    1342:	fdc42783          	lw	a5,-36(s0)
    1346:	4f98                	lw	a4,24(a5)
    1348:	fdc42783          	lw	a5,-36(s0)
    134c:	4fdc                	lw	a5,28(a5)
    134e:	c398                	sw	a4,0(a5)
    *(size_t *)((uint8_t *)(thread->stack_addr) + 4) = (size_t)thread->sp;
    1350:	fdc42783          	lw	a5,-36(s0)
    1354:	4bd8                	lw	a4,20(a5)
    1356:	fdc42783          	lw	a5,-36(s0)
    135a:	4fdc                	lw	a5,28(a5)
    135c:	0791                	addi	a5,a5,4
    135e:	c398                	sw	a4,0(a5)
    *(size_t *)((uint8_t *)(thread->stack_addr) + 8) = (size_t)thread->entry;//应对首次调度，mepc值不确定的情况
    1360:	fdc42783          	lw	a5,-36(s0)
    1364:	4f98                	lw	a4,24(a5)
    1366:	fdc42783          	lw	a5,-36(s0)
    136a:	4fdc                	lw	a5,28(a5)
    136c:	07a1                	addi	a5,a5,8
    136e:	c398                	sw	a4,0(a5)

    thread->node.prev = &Ready_threadList_Start[priority];
    1370:	fef44783          	lbu	a5,-17(s0)
    1374:	00379713          	slli	a4,a5,0x3
    1378:	200007b7          	lui	a5,0x20000
    137c:	44478793          	addi	a5,a5,1092 # 20000444 <Ready_threadList_Start>
    1380:	973e                	add	a4,a4,a5
    1382:	fdc42783          	lw	a5,-36(s0)
    1386:	cfb8                	sw	a4,88(a5)
    thread->node.next = Ready_threadList_Start[priority].next;
    1388:	fef44783          	lbu	a5,-17(s0)
    138c:	20000737          	lui	a4,0x20000
    1390:	44470713          	addi	a4,a4,1092 # 20000444 <Ready_threadList_Start>
    1394:	078e                	slli	a5,a5,0x3
    1396:	97ba                	add	a5,a5,a4
    1398:	43d8                	lw	a4,4(a5)
    139a:	fdc42783          	lw	a5,-36(s0)
    139e:	cff8                	sw	a4,92(a5)

    Ready_threadList_Start[priority].next = &thread->node;
    13a0:	fef44783          	lbu	a5,-17(s0)
    13a4:	fdc42703          	lw	a4,-36(s0)
    13a8:	05870713          	addi	a4,a4,88
    13ac:	200006b7          	lui	a3,0x20000
    13b0:	44468693          	addi	a3,a3,1092 # 20000444 <Ready_threadList_Start>
    13b4:	078e                	slli	a5,a5,0x3
    13b6:	97b6                	add	a5,a5,a3
    13b8:	c3d8                	sw	a4,4(a5)
    thread->node.next->prev = &thread->node;
    13ba:	fdc42783          	lw	a5,-36(s0)
    13be:	4ffc                	lw	a5,92(a5)
    13c0:	fdc42703          	lw	a4,-36(s0)
    13c4:	05870713          	addi	a4,a4,88
    13c8:	c398                	sw	a4,0(a5)

    thread->state = MC_THREAD_STATE_READY;
    13ca:	fdc42783          	lw	a5,-36(s0)
    13ce:	4705                	li	a4,1
    13d0:	06e78023          	sb	a4,96(a5)
    return 0;
    13d4:	4781                	li	a5,0
}
    13d6:	853e                	mv	a0,a5
    13d8:	5432                	lw	s0,44(sp)
    13da:	6145                	addi	sp,sp,48
    13dc:	8082                	ret

000013de <MC_thread_yield>:

/**
 * 线程调度
*/
void MC_thread_yield()
{
    13de:	1141                	addi	sp,sp,-16
    13e0:	c606                	sw	ra,12(sp)
    13e2:	c422                	sw	s0,8(sp)
    13e4:	0800                	addi	s0,sp,16
    if(MC_scheduler.sched_state == SCHED_RUNNING)
    13e6:	200007b7          	lui	a5,0x20000
    13ea:	4347c703          	lbu	a4,1076(a5) # 20000434 <MC_scheduler>
    13ee:	4785                	li	a5,1
    13f0:	00f71b63          	bne	a4,a5,1406 <MC_thread_yield+0x28>
    {
        //在软件中断中调度下一个线程
        MC_schedule_flag = 1;
    13f4:	200007b7          	lui	a5,0x20000
    13f8:	4705                	li	a4,1
    13fa:	40e78823          	sb	a4,1040(a5) # 20000410 <MC_schedule_flag>
        MC_pfic_pending_set(SOFTWARE_IRQ);
    13fe:	4539                	li	a0,14
    1400:	351000ef          	jal	ra,1f50 <MC_pfic_pending_set>
    }
    return;
    1404:	0001                	nop
    1406:	0001                	nop
}
    1408:	40b2                	lw	ra,12(sp)
    140a:	4422                	lw	s0,8(sp)
    140c:	0141                	addi	sp,sp,16
    140e:	8082                	ret

00001410 <MC_thread_self>:

/**
 * 返回正在执行的线程
*/
MC_thread_t MC_thread_self(void)
{
    1410:	1141                	addi	sp,sp,-16
    1412:	c622                	sw	s0,12(sp)
    1414:	0800                	addi	s0,sp,16
    return MC_scheduler.running_thread;
    1416:	200007b7          	lui	a5,0x20000
    141a:	43478793          	addi	a5,a5,1076 # 20000434 <MC_scheduler>
    141e:	43dc                	lw	a5,4(a5)
}
    1420:	853e                	mv	a0,a5
    1422:	4432                	lw	s0,12(sp)
    1424:	0141                	addi	sp,sp,16
    1426:	8082                	ret

00001428 <MC_thread_to_ready_list>:

/**
 * 线程从挂起队列恢复到就绪队列
*/
uint8_t MC_thread_to_ready_list(MC_thread_t thread)
{
    1428:	7179                	addi	sp,sp,-48
    142a:	d622                	sw	s0,44(sp)
    142c:	1800                	addi	s0,sp,48
    142e:	fca42e23          	sw	a0,-36(s0)
    // 线程仍处于其他队列中，则不操作
    if(thread->node.next != NULL || thread->node.prev != NULL)
    1432:	fdc42783          	lw	a5,-36(s0)
    1436:	4ffc                	lw	a5,92(a5)
    1438:	e789                	bnez	a5,1442 <MC_thread_to_ready_list+0x1a>
    143a:	fdc42783          	lw	a5,-36(s0)
    143e:	4fbc                	lw	a5,88(a5)
    1440:	c399                	beqz	a5,1446 <MC_thread_to_ready_list+0x1e>
    {
        return 1;
    1442:	4785                	li	a5,1
    1444:	a851                	j	14d8 <MC_thread_to_ready_list+0xb0>
    }
    uint8_t priority = thread->priority;
    1446:	fdc42783          	lw	a5,-36(s0)
    144a:	0247c783          	lbu	a5,36(a5)
    144e:	fef407a3          	sb	a5,-17(s0)

    //判断线程有无优先级反转现象
    if(thread->inheritPriority > thread->priority)
    1452:	fdc42783          	lw	a5,-36(s0)
    1456:	0257c703          	lbu	a4,37(a5)
    145a:	fdc42783          	lw	a5,-36(s0)
    145e:	0247c783          	lbu	a5,36(a5)
    1462:	00e7f863          	bgeu	a5,a4,1472 <MC_thread_to_ready_list+0x4a>
    {
        priority = thread->inheritPriority;
    1466:	fdc42783          	lw	a5,-36(s0)
    146a:	0257c783          	lbu	a5,37(a5)
    146e:	fef407a3          	sb	a5,-17(s0)
    }

    thread->node.prev = &Ready_threadList_Start[priority];
    1472:	fef44783          	lbu	a5,-17(s0)
    1476:	00379713          	slli	a4,a5,0x3
    147a:	200007b7          	lui	a5,0x20000
    147e:	44478793          	addi	a5,a5,1092 # 20000444 <Ready_threadList_Start>
    1482:	973e                	add	a4,a4,a5
    1484:	fdc42783          	lw	a5,-36(s0)
    1488:	cfb8                	sw	a4,88(a5)
    thread->node.next = Ready_threadList_Start[priority].next;
    148a:	fef44783          	lbu	a5,-17(s0)
    148e:	20000737          	lui	a4,0x20000
    1492:	44470713          	addi	a4,a4,1092 # 20000444 <Ready_threadList_Start>
    1496:	078e                	slli	a5,a5,0x3
    1498:	97ba                	add	a5,a5,a4
    149a:	43d8                	lw	a4,4(a5)
    149c:	fdc42783          	lw	a5,-36(s0)
    14a0:	cff8                	sw	a4,92(a5)

    Ready_threadList_Start[priority].next = &thread->node;
    14a2:	fef44783          	lbu	a5,-17(s0)
    14a6:	fdc42703          	lw	a4,-36(s0)
    14aa:	05870713          	addi	a4,a4,88
    14ae:	200006b7          	lui	a3,0x20000
    14b2:	44468693          	addi	a3,a3,1092 # 20000444 <Ready_threadList_Start>
    14b6:	078e                	slli	a5,a5,0x3
    14b8:	97b6                	add	a5,a5,a3
    14ba:	c3d8                	sw	a4,4(a5)
    thread->node.next->prev = &thread->node;
    14bc:	fdc42783          	lw	a5,-36(s0)
    14c0:	4ffc                	lw	a5,92(a5)
    14c2:	fdc42703          	lw	a4,-36(s0)
    14c6:	05870713          	addi	a4,a4,88
    14ca:	c398                	sw	a4,0(a5)

    thread->state = MC_THREAD_STATE_READY;
    14cc:	fdc42783          	lw	a5,-36(s0)
    14d0:	4705                	li	a4,1
    14d2:	06e78023          	sb	a4,96(a5)
    return 0;
    14d6:	4781                	li	a5,0
}
    14d8:	853e                	mv	a0,a5
    14da:	5432                	lw	s0,44(sp)
    14dc:	6145                	addi	sp,sp,48
    14de:	8082                	ret

000014e0 <MC_thread_to_suspend_list>:
/**
 * 阻塞入口函数
 * flag指示资源类型是锁还是信号量
*/
uint8_t MC_thread_to_suspend_list(MC_thread_t thread, void *MC_source, uint8_t attribute)
{
    14e0:	7179                	addi	sp,sp,-48
    14e2:	d606                	sw	ra,44(sp)
    14e4:	d422                	sw	s0,40(sp)
    14e6:	1800                	addi	s0,sp,48
    14e8:	fca42e23          	sw	a0,-36(s0)
    14ec:	fcb42c23          	sw	a1,-40(s0)
    14f0:	87b2                	mv	a5,a2
    14f2:	fcf40ba3          	sb	a5,-41(s0)
    if(attribute == MC_IPCATTR_LOCK)
    14f6:	fd744703          	lbu	a4,-41(s0)
    14fa:	4785                	li	a5,1
    14fc:	00f71f63          	bne	a4,a5,151a <MC_thread_to_suspend_list+0x3a>
    {
        MC_spinlock_t MC_Source = (MC_spinlock_t)MC_source;
    1500:	fd842783          	lw	a5,-40(s0)
    1504:	fef42623          	sw	a5,-20(s0)
        MC_thread_to_lock_suspend_list(thread, &MC_Source->suspend_thread, MC_IPC_FLAG_PRIO);
    1508:	fec42783          	lw	a5,-20(s0)
    150c:	07e1                	addi	a5,a5,24
    150e:	4601                	li	a2,0
    1510:	85be                	mv	a1,a5
    1512:	fdc42503          	lw	a0,-36(s0)
    1516:	20b9                	jal	1564 <MC_thread_to_lock_suspend_list>
    1518:	a081                	j	1558 <MC_thread_to_suspend_list+0x78>
    }
    else if(attribute == MC_IPCATTR_SEM)
    151a:	fd744703          	lbu	a4,-41(s0)
    151e:	4789                	li	a5,2
    1520:	02f71463          	bne	a4,a5,1548 <MC_thread_to_suspend_list+0x68>
    {
        MC_sem_t MC_Source = (MC_sem_t) MC_source;
    1524:	fd842783          	lw	a5,-40(s0)
    1528:	fef42423          	sw	a5,-24(s0)
        MC_thread_to_sem_suspend_list(thread, &MC_Source->suspend_thread, MC_Source->flag);
    152c:	fe842783          	lw	a5,-24(s0)
    1530:	01878713          	addi	a4,a5,24
    1534:	fe842783          	lw	a5,-24(s0)
    1538:	0147c783          	lbu	a5,20(a5)
    153c:	863e                	mv	a2,a5
    153e:	85ba                	mv	a1,a4
    1540:	fdc42503          	lw	a0,-36(s0)
    1544:	2865                	jal	15fc <MC_thread_to_sem_suspend_list>
    1546:	a809                	j	1558 <MC_thread_to_suspend_list+0x78>
    }
    else if(attribute == NULL)
    1548:	fd744783          	lbu	a5,-41(s0)
    154c:	e791                	bnez	a5,1558 <MC_thread_to_suspend_list+0x78>
    {
        //单纯把线程从就绪队列中移除
        MC_thread_to_sem_suspend_list(thread, NULL, NULL);
    154e:	4601                	li	a2,0
    1550:	4581                	li	a1,0
    1552:	fdc42503          	lw	a0,-36(s0)
    1556:	205d                	jal	15fc <MC_thread_to_sem_suspend_list>
    }
    return 0;
    1558:	4781                	li	a5,0
}
    155a:	853e                	mv	a0,a5
    155c:	50b2                	lw	ra,44(sp)
    155e:	5422                	lw	s0,40(sp)
    1560:	6145                	addi	sp,sp,48
    1562:	8082                	ret

00001564 <MC_thread_to_lock_suspend_list>:
/**
 * 阻塞线程到锁挂起队列，优先级挂起模式
 * 具备优先级继承机制
*/
uint8_t MC_thread_to_lock_suspend_list(MC_thread_t thread, MC_list_t suspend_list, uint8_t flag)
{
    1564:	7179                	addi	sp,sp,-48
    1566:	d606                	sw	ra,44(sp)
    1568:	d422                	sw	s0,40(sp)
    156a:	1800                	addi	s0,sp,48
    156c:	fca42e23          	sw	a0,-36(s0)
    1570:	fcb42c23          	sw	a1,-40(s0)
    1574:	87b2                	mv	a5,a2
    1576:	fcf40ba3          	sb	a5,-41(s0)
    MC_scheduler_remove_thread(thread);
    157a:	fdc42503          	lw	a0,-36(s0)
    157e:	34fd                	jal	106c <MC_scheduler_remove_thread>

    if(suspend_list != NULL)
    1580:	fd842783          	lw	a5,-40(s0)
    1584:	cbb9                	beqz	a5,15da <MC_thread_to_lock_suspend_list+0x76>
    {
        MC_suspend_list_enqueue(suspend_list, thread, flag); //线程加入挂起队列
    1586:	fd744783          	lbu	a5,-41(s0)
    158a:	863e                	mv	a2,a5
    158c:	fdc42583          	lw	a1,-36(s0)
    1590:	fd842503          	lw	a0,-40(s0)
    1594:	47f000ef          	jal	ra,2212 <MC_suspend_list_enqueue>

        MC_spinlock_t lock;
        lock = (MC_spinlock_t)MC_container_of(suspend_list, struct MC_spinlock, suspend_thread);
    1598:	fd842783          	lw	a5,-40(s0)
    159c:	17a1                	addi	a5,a5,-24
    159e:	fef42623          	sw	a5,-20(s0)
        
        //持有锁的线程优先级小于申请线程优先级，发生优先级反转
        if(lock->holdThread->priority < thread->priority)
    15a2:	fec42783          	lw	a5,-20(s0)
    15a6:	53dc                	lw	a5,36(a5)
    15a8:	0247c703          	lbu	a4,36(a5)
    15ac:	fdc42783          	lw	a5,-36(s0)
    15b0:	0247c783          	lbu	a5,36(a5)
    15b4:	02f77363          	bgeu	a4,a5,15da <MC_thread_to_lock_suspend_list+0x76>
        {
            //把持锁线程从原来的优先级队列中移除
            MC_thread_to_suspend_list(thread, NULL, NULL);
    15b8:	4601                	li	a2,0
    15ba:	4581                	li	a1,0
    15bc:	fdc42503          	lw	a0,-36(s0)
    15c0:	3705                	jal	14e0 <MC_thread_to_suspend_list>

            //把持锁线程优先级提高
            lock->holdThread->inheritPriority = thread->inheritPriority;
    15c2:	fec42783          	lw	a5,-20(s0)
    15c6:	53dc                	lw	a5,36(a5)
    15c8:	fdc42703          	lw	a4,-36(s0)
    15cc:	02574703          	lbu	a4,37(a4)
    15d0:	02e782a3          	sb	a4,37(a5)

            //把持锁线程插入新优先级就绪队列
            MC_thread_to_ready_list(thread);
    15d4:	fdc42503          	lw	a0,-36(s0)
    15d8:	3d81                	jal	1428 <MC_thread_to_ready_list>
        }
    }

    MC_timer_list_remove(&thread->timer.node);
    15da:	fdc42783          	lw	a5,-36(s0)
    15de:	04878793          	addi	a5,a5,72
    15e2:	853e                	mv	a0,a5
    15e4:	2cd1                	jal	18b8 <MC_timer_list_remove>
    thread->state = MC_THREAD_STATE_SUSPEND;
    15e6:	fdc42783          	lw	a5,-36(s0)
    15ea:	4709                	li	a4,2
    15ec:	06e78023          	sb	a4,96(a5)
    return 0;
    15f0:	4781                	li	a5,0
}
    15f2:	853e                	mv	a0,a5
    15f4:	50b2                	lw	ra,44(sp)
    15f6:	5422                	lw	s0,40(sp)
    15f8:	6145                	addi	sp,sp,48
    15fa:	8082                	ret

000015fc <MC_thread_to_sem_suspend_list>:
/**
 * 阻塞线程到信号量挂起队列
 * 如果suspend_list为NULL则直接挂起，不加入队列
*/
uint8_t MC_thread_to_sem_suspend_list(MC_thread_t thread, MC_list_t suspend_list, uint8_t flag)
{
    15fc:	1101                	addi	sp,sp,-32
    15fe:	ce06                	sw	ra,28(sp)
    1600:	cc22                	sw	s0,24(sp)
    1602:	1000                	addi	s0,sp,32
    1604:	fea42623          	sw	a0,-20(s0)
    1608:	feb42423          	sw	a1,-24(s0)
    160c:	87b2                	mv	a5,a2
    160e:	fef403a3          	sb	a5,-25(s0)
    MC_scheduler_remove_thread(thread);//把线程从就绪队列中移除
    1612:	fec42503          	lw	a0,-20(s0)
    1616:	3c99                	jal	106c <MC_scheduler_remove_thread>

    if(suspend_list != NULL)
    1618:	fe842783          	lw	a5,-24(s0)
    161c:	cb91                	beqz	a5,1630 <MC_thread_to_sem_suspend_list+0x34>
    {
        MC_suspend_list_enqueue(suspend_list, thread, flag);//线程加入挂起队列
    161e:	fe744783          	lbu	a5,-25(s0)
    1622:	863e                	mv	a2,a5
    1624:	fec42583          	lw	a1,-20(s0)
    1628:	fe842503          	lw	a0,-24(s0)
    162c:	3e7000ef          	jal	ra,2212 <MC_suspend_list_enqueue>
    }
    MC_timer_list_remove(&thread->timer.node);//把线程定时器从定时器链表中移除
    1630:	fec42783          	lw	a5,-20(s0)
    1634:	04878793          	addi	a5,a5,72
    1638:	853e                	mv	a0,a5
    163a:	2cbd                	jal	18b8 <MC_timer_list_remove>

    thread->state = MC_THREAD_STATE_SUSPEND;
    163c:	fec42783          	lw	a5,-20(s0)
    1640:	4709                	li	a4,2
    1642:	06e78023          	sb	a4,96(a5)
    return 0;
    1646:	4781                	li	a5,0
    1648:	853e                	mv	a0,a5
    164a:	40f2                	lw	ra,28(sp)
    164c:	4462                	lw	s0,24(sp)
    164e:	6105                	addi	sp,sp,32
    1650:	8082                	ret

00001652 <MC_memcpy>:
#include "os.h"

void MC_memcpy(char *dst, char *src, int len)
{
    1652:	7179                	addi	sp,sp,-48
    1654:	d622                	sw	s0,44(sp)
    1656:	1800                	addi	s0,sp,48
    1658:	fca42e23          	sw	a0,-36(s0)
    165c:	fcb42c23          	sw	a1,-40(s0)
    1660:	fcc42a23          	sw	a2,-44(s0)
    if(dst == NULL || src == NULL || len <= 0)
    1664:	fdc42783          	lw	a5,-36(s0)
    1668:	cfa9                	beqz	a5,16c2 <MC_memcpy+0x70>
    166a:	fd842783          	lw	a5,-40(s0)
    166e:	cbb1                	beqz	a5,16c2 <MC_memcpy+0x70>
    1670:	fd442783          	lw	a5,-44(s0)
    1674:	04f05763          	blez	a5,16c2 <MC_memcpy+0x70>
        return;

    for(int i = 0; i < len; i++)
    1678:	fe042623          	sw	zero,-20(s0)
    167c:	a825                	j	16b4 <MC_memcpy+0x62>
    {
        *(dst + i) = *(src + i);
    167e:	fec42783          	lw	a5,-20(s0)
    1682:	fd842703          	lw	a4,-40(s0)
    1686:	973e                	add	a4,a4,a5
    1688:	fec42783          	lw	a5,-20(s0)
    168c:	fdc42683          	lw	a3,-36(s0)
    1690:	97b6                	add	a5,a5,a3
    1692:	00074703          	lbu	a4,0(a4)
    1696:	00e78023          	sb	a4,0(a5)
        *(dst + i + 1) = '\0';
    169a:	fec42783          	lw	a5,-20(s0)
    169e:	0785                	addi	a5,a5,1
    16a0:	fdc42703          	lw	a4,-36(s0)
    16a4:	97ba                	add	a5,a5,a4
    16a6:	00078023          	sb	zero,0(a5)
    for(int i = 0; i < len; i++)
    16aa:	fec42783          	lw	a5,-20(s0)
    16ae:	0785                	addi	a5,a5,1
    16b0:	fef42623          	sw	a5,-20(s0)
    16b4:	fec42703          	lw	a4,-20(s0)
    16b8:	fd442783          	lw	a5,-44(s0)
    16bc:	fcf741e3          	blt	a4,a5,167e <MC_memcpy+0x2c>
    16c0:	a011                	j	16c4 <MC_memcpy+0x72>
        return;
    16c2:	0001                	nop
    }
}
    16c4:	5432                	lw	s0,44(sp)
    16c6:	6145                	addi	sp,sp,48
    16c8:	8082                	ret

000016ca <MC_strlen>:

size_t MC_strlen(char *src)
{
    16ca:	7179                	addi	sp,sp,-48
    16cc:	d622                	sw	s0,44(sp)
    16ce:	1800                	addi	s0,sp,48
    16d0:	fca42e23          	sw	a0,-36(s0)
    size_t len = 0;
    16d4:	fe042623          	sw	zero,-20(s0)
    while(*src++) len++;
    16d8:	a031                	j	16e4 <MC_strlen+0x1a>
    16da:	fec42783          	lw	a5,-20(s0)
    16de:	0785                	addi	a5,a5,1
    16e0:	fef42623          	sw	a5,-20(s0)
    16e4:	fdc42783          	lw	a5,-36(s0)
    16e8:	00178713          	addi	a4,a5,1
    16ec:	fce42e23          	sw	a4,-36(s0)
    16f0:	0007c783          	lbu	a5,0(a5)
    16f4:	f3fd                	bnez	a5,16da <MC_strlen+0x10>
    return len;
    16f6:	fec42783          	lw	a5,-20(s0)
    16fa:	853e                	mv	a0,a5
    16fc:	5432                	lw	s0,44(sp)
    16fe:	6145                	addi	sp,sp,48
    1700:	8082                	ret
	...

00001704 <r_mstatus>:
{
    1704:	1101                	addi	sp,sp,-32
    1706:	ce22                	sw	s0,28(sp)
    1708:	1000                	addi	s0,sp,32
	asm volatile("csrr %0, mstatus" : "=r" (x) );
    170a:	300027f3          	csrr	a5,mstatus
    170e:	fef42623          	sw	a5,-20(s0)
	return x;
    1712:	fec42783          	lw	a5,-20(s0)
}
    1716:	853e                	mv	a0,a5
    1718:	4472                	lw	s0,28(sp)
    171a:	6105                	addi	sp,sp,32
    171c:	8082                	ret
    171e:	0001                	nop

00001720 <w_mstatus>:
{
    1720:	1101                	addi	sp,sp,-32
    1722:	ce22                	sw	s0,28(sp)
    1724:	1000                	addi	s0,sp,32
    1726:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mstatus, %0" : : "r" (x));
    172a:	fec42783          	lw	a5,-20(s0)
    172e:	30079073          	csrw	mstatus,a5
}
    1732:	0001                	nop
    1734:	4472                	lw	s0,28(sp)
    1736:	6105                	addi	sp,sp,32
    1738:	8082                	ret
    173a:	0001                	nop

0000173c <w_mtvec>:

/* Machine-mode trap vector */
static inline __attribute__((aligned(4))) void w_mtvec(reg_t x)
{
    173c:	1101                	addi	sp,sp,-32
    173e:	ce22                	sw	s0,28(sp)
    1740:	1000                	addi	s0,sp,32
    1742:	fea42623          	sw	a0,-20(s0)
	asm volatile("csrw mtvec, %0" : : "r" (x));
    1746:	fec42783          	lw	a5,-20(s0)
    174a:	30579073          	csrw	mtvec,a5
}
    174e:	0001                	nop
    1750:	4472                	lw	s0,28(sp)
    1752:	6105                	addi	sp,sp,32
    1754:	8082                	ret

00001756 <__DISENABLE_INTERRUPT__>:
#include "os.h"
extern void trap_handler_base();

void __DISENABLE_INTERRUPT__()
{
    1756:	1141                	addi	sp,sp,-16
    1758:	c606                	sw	ra,12(sp)
    175a:	c422                	sw	s0,8(sp)
    175c:	0800                	addi	s0,sp,16
    w_mstatus(r_mstatus() & ~(1 << 3)); // 全局中断关闭
    175e:	375d                	jal	1704 <r_mstatus>
    1760:	87aa                	mv	a5,a0
    1762:	9bdd                	andi	a5,a5,-9
    1764:	853e                	mv	a0,a5
    1766:	3f6d                	jal	1720 <w_mstatus>
}
    1768:	0001                	nop
    176a:	40b2                	lw	ra,12(sp)
    176c:	4422                	lw	s0,8(sp)
    176e:	0141                	addi	sp,sp,16
    1770:	8082                	ret

00001772 <__ENABLE_INTERRUPT__>:

void __ENABLE_INTERRUPT__()
{
    1772:	1141                	addi	sp,sp,-16
    1774:	c606                	sw	ra,12(sp)
    1776:	c422                	sw	s0,8(sp)
    1778:	0800                	addi	s0,sp,16
    w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
    177a:	3769                	jal	1704 <r_mstatus>
    177c:	87aa                	mv	a5,a0
    177e:	0087e793          	ori	a5,a5,8
    1782:	853e                	mv	a0,a5
    1784:	3f71                	jal	1720 <w_mstatus>
}
    1786:	0001                	nop
    1788:	40b2                	lw	ra,12(sp)
    178a:	4422                	lw	s0,8(sp)
    178c:	0141                	addi	sp,sp,16
    178e:	8082                	ret

00001790 <MC_trap_init>:

void MC_trap_init()
{
    1790:	1101                	addi	sp,sp,-32
    1792:	ce06                	sw	ra,28(sp)
    1794:	cc22                	sw	s0,24(sp)
    1796:	1000                	addi	s0,sp,32
    ptr_t base = (ptr_t)trap_handler_base;
    1798:	000007b7          	lui	a5,0x0
    179c:	05878793          	addi	a5,a5,88 # 58 <trap_handler_base>
    17a0:	fef42623          	sw	a5,-20(s0)
    uint32_t mtvec = 0x00000001;
    17a4:	4785                	li	a5,1
    17a6:	fef42423          	sw	a5,-24(s0)
    mtvec |= (base);
    17aa:	fe842703          	lw	a4,-24(s0)
    17ae:	fec42783          	lw	a5,-20(s0)
    17b2:	8fd9                	or	a5,a5,a4
    17b4:	fef42423          	sw	a5,-24(s0)
    w_mtvec(mtvec);
    17b8:	fe842503          	lw	a0,-24(s0)
    17bc:	3741                	jal	173c <w_mtvec>

    // w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
    // 在main函数再开启全局中断
}
    17be:	0001                	nop
    17c0:	40f2                	lw	ra,28(sp)
    17c2:	4462                	lw	s0,24(sp)
    17c4:	6105                	addi	sp,sp,32
    17c6:	8082                	ret

000017c8 <MC_mtip_handler>:

extern void MC_timer_handler();
void MC_mtip_handler()
{
    17c8:	1141                	addi	sp,sp,-16
    17ca:	c606                	sw	ra,12(sp)
    17cc:	c422                	sw	s0,8(sp)
    17ce:	0800                	addi	s0,sp,16
    MC_timer_handler();
    17d0:	237d                	jal	1d7e <MC_timer_handler>
}
    17d2:	0001                	nop
    17d4:	40b2                	lw	ra,12(sp)
    17d6:	4422                	lw	s0,8(sp)
    17d8:	0141                	addi	sp,sp,16
    17da:	8082                	ret

000017dc <MC_software_handler>:

extern uint8_t MC_schedule_flag;
void MC_software_handler()
{
    17dc:	1141                	addi	sp,sp,-16
    17de:	c606                	sw	ra,12(sp)
    17e0:	c422                	sw	s0,8(sp)
    17e2:	0800                	addi	s0,sp,16
    if(MC_schedule_flag)
    17e4:	200007b7          	lui	a5,0x20000
    17e8:	4107c783          	lbu	a5,1040(a5) # 20000410 <MC_schedule_flag>
    17ec:	c799                	beqz	a5,17fa <MC_software_handler+0x1e>
    {
        MC_schedule_flag = 0;
    17ee:	200007b7          	lui	a5,0x20000
    17f2:	40078823          	sb	zero,1040(a5) # 20000410 <MC_schedule_flag>
        MC_schedule();
    17f6:	e3cff0ef          	jal	ra,e32 <MC_schedule>
    }

    MC_pfic_pending_clear(SOFTWARE_IRQ);
    17fa:	4539                	li	a0,14
    17fc:	78e000ef          	jal	ra,1f8a <MC_pfic_pending_clear>
    1800:	0001                	nop
    1802:	40b2                	lw	ra,12(sp)
    1804:	4422                	lw	s0,8(sp)
    1806:	0141                	addi	sp,sp,16
    1808:	8082                	ret

0000180a <MC_timer_list_insert>:

/**
 * 定时器插入链表
*/
void MC_timer_list_insert(MC_list_t node)
{
    180a:	7179                	addi	sp,sp,-48
    180c:	d622                	sw	s0,44(sp)
    180e:	1800                	addi	s0,sp,48
    1810:	fca42e23          	sw	a0,-36(s0)
    MC_list_t timerListOperator = timer_list;
    1814:	200017b7          	lui	a5,0x20001
    1818:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    181c:	fef42623          	sw	a5,-20(s0)
    MC_timer_t timer, timerOperator;
    timer = MC_container_of(node, struct MC_timer, node);
    1820:	fdc42783          	lw	a5,-36(s0)
    1824:	1781                	addi	a5,a5,-32
    1826:	fef42423          	sw	a5,-24(s0)
    while(timerListOperator->next != NULL)
    182a:	a025                	j	1852 <MC_timer_list_insert+0x48>
    {
        timerOperator = MC_container_of(timerListOperator->next, struct MC_timer, node);
    182c:	fec42783          	lw	a5,-20(s0)
    1830:	43dc                	lw	a5,4(a5)
    1832:	1781                	addi	a5,a5,-32
    1834:	fef42223          	sw	a5,-28(s0)
        if(timerOperator->timeout_tick > timer->timeout_tick)
    1838:	fe442783          	lw	a5,-28(s0)
    183c:	57d8                	lw	a4,44(a5)
    183e:	fe842783          	lw	a5,-24(s0)
    1842:	57dc                	lw	a5,44(a5)
    1844:	00e7ec63          	bltu	a5,a4,185c <MC_timer_list_insert+0x52>
        {
            break;
        }
        timerListOperator = timerListOperator->next;
    1848:	fec42783          	lw	a5,-20(s0)
    184c:	43dc                	lw	a5,4(a5)
    184e:	fef42623          	sw	a5,-20(s0)
    while(timerListOperator->next != NULL)
    1852:	fec42783          	lw	a5,-20(s0)
    1856:	43dc                	lw	a5,4(a5)
    1858:	fbf1                	bnez	a5,182c <MC_timer_list_insert+0x22>
    185a:	a011                	j	185e <MC_timer_list_insert+0x54>
            break;
    185c:	0001                	nop
    }   
    
    if(timerListOperator->next == NULL)
    185e:	fec42783          	lw	a5,-20(s0)
    1862:	43dc                	lw	a5,4(a5)
    1864:	e385                	bnez	a5,1884 <MC_timer_list_insert+0x7a>
    {
        timerListOperator->next = node;
    1866:	fec42783          	lw	a5,-20(s0)
    186a:	fdc42703          	lw	a4,-36(s0)
    186e:	c3d8                	sw	a4,4(a5)
        node->prev = timerListOperator;
    1870:	fdc42783          	lw	a5,-36(s0)
    1874:	fec42703          	lw	a4,-20(s0)
    1878:	c398                	sw	a4,0(a5)
        node->next = NULL;
    187a:	fdc42783          	lw	a5,-36(s0)
    187e:	0007a223          	sw	zero,4(a5)
        node->prev = timerListOperator;
        node->next = timerListOperator->next;
        timerListOperator->next = node;
        node->next->prev = node;
    }
}
    1882:	a03d                	j	18b0 <MC_timer_list_insert+0xa6>
        node->prev = timerListOperator;
    1884:	fdc42783          	lw	a5,-36(s0)
    1888:	fec42703          	lw	a4,-20(s0)
    188c:	c398                	sw	a4,0(a5)
        node->next = timerListOperator->next;
    188e:	fec42783          	lw	a5,-20(s0)
    1892:	43d8                	lw	a4,4(a5)
    1894:	fdc42783          	lw	a5,-36(s0)
    1898:	c3d8                	sw	a4,4(a5)
        timerListOperator->next = node;
    189a:	fec42783          	lw	a5,-20(s0)
    189e:	fdc42703          	lw	a4,-36(s0)
    18a2:	c3d8                	sw	a4,4(a5)
        node->next->prev = node;
    18a4:	fdc42783          	lw	a5,-36(s0)
    18a8:	43dc                	lw	a5,4(a5)
    18aa:	fdc42703          	lw	a4,-36(s0)
    18ae:	c398                	sw	a4,0(a5)
}
    18b0:	0001                	nop
    18b2:	5432                	lw	s0,44(sp)
    18b4:	6145                	addi	sp,sp,48
    18b6:	8082                	ret

000018b8 <MC_timer_list_remove>:

/**
 * 从定时器链表中移除指定定时器
*/
void MC_timer_list_remove(MC_list_t node)
{
    18b8:	1101                	addi	sp,sp,-32
    18ba:	ce22                	sw	s0,28(sp)
    18bc:	1000                	addi	s0,sp,32
    18be:	fea42623          	sw	a0,-20(s0)
    //定时器已经移除,避免重复操作
    if(node->prev == NULL)
    18c2:	fec42783          	lw	a5,-20(s0)
    18c6:	439c                	lw	a5,0(a5)
    18c8:	cf95                	beqz	a5,1904 <MC_timer_list_remove+0x4c>
    {
        return ;
    }

    node->prev->next = node->next;
    18ca:	fec42783          	lw	a5,-20(s0)
    18ce:	439c                	lw	a5,0(a5)
    18d0:	fec42703          	lw	a4,-20(s0)
    18d4:	4358                	lw	a4,4(a4)
    18d6:	c3d8                	sw	a4,4(a5)
    if(node->next != NULL)
    18d8:	fec42783          	lw	a5,-20(s0)
    18dc:	43dc                	lw	a5,4(a5)
    18de:	cb81                	beqz	a5,18ee <MC_timer_list_remove+0x36>
    {
        node->next->prev = node->prev;
    18e0:	fec42783          	lw	a5,-20(s0)
    18e4:	43dc                	lw	a5,4(a5)
    18e6:	fec42703          	lw	a4,-20(s0)
    18ea:	4318                	lw	a4,0(a4)
    18ec:	c398                	sw	a4,0(a5)
    }
    node->next = node->prev = NULL;
    18ee:	fec42783          	lw	a5,-20(s0)
    18f2:	0007a023          	sw	zero,0(a5)
    18f6:	fec42783          	lw	a5,-20(s0)
    18fa:	4398                	lw	a4,0(a5)
    18fc:	fec42783          	lw	a5,-20(s0)
    1900:	c3d8                	sw	a4,4(a5)
    1902:	a011                	j	1906 <MC_timer_list_remove+0x4e>
        return ;
    1904:	0001                	nop
}
    1906:	4472                	lw	s0,28(sp)
    1908:	6105                	addi	sp,sp,32
    190a:	8082                	ret

0000190c <MC_timer_control>:
/**
 * 设置定时器属性
 * 注意设置的时候会把定时器从定时器队列中移除
*/
uint8_t MC_timer_control(MC_timer_t timer, int cmd, void *arg)
{
    190c:	1101                	addi	sp,sp,-32
    190e:	ce06                	sw	ra,28(sp)
    1910:	cc22                	sw	s0,24(sp)
    1912:	ca26                	sw	s1,20(sp)
    1914:	1000                	addi	s0,sp,32
    1916:	fea42623          	sw	a0,-20(s0)
    191a:	feb42423          	sw	a1,-24(s0)
    191e:	fec42223          	sw	a2,-28(s0)
    switch(cmd)
    1922:	fe842783          	lw	a5,-24(s0)
    1926:	e3b9                	bnez	a5,196c <MC_timer_control+0x60>
    {
        case MC_TIMER_CTRL_SET_TIME:
            if(timer->flag & MC_TIMER_FLAG_ACTIVATED) //
    1928:	fec42783          	lw	a5,-20(s0)
    192c:	01c7c783          	lbu	a5,28(a5)
    1930:	8b85                	andi	a5,a5,1
    1932:	c395                	beqz	a5,1956 <MC_timer_control+0x4a>
            {
                MC_timer_list_remove(&timer->node);//移除定时器
    1934:	fec42783          	lw	a5,-20(s0)
    1938:	02078793          	addi	a5,a5,32
    193c:	853e                	mv	a0,a5
    193e:	3fad                	jal	18b8 <MC_timer_list_remove>
                timer->flag &= ~MC_TIMER_FLAG_ACTIVATED;
    1940:	fec42783          	lw	a5,-20(s0)
    1944:	01c7c783          	lbu	a5,28(a5)
    1948:	9bf9                	andi	a5,a5,-2
    194a:	0ff7f713          	andi	a4,a5,255
    194e:	fec42783          	lw	a5,-20(s0)
    1952:	00e78e23          	sb	a4,28(a5)
            }
            timer->timeout_tick = *(uint32_t *)arg + MC_get_tick();
    1956:	fe442783          	lw	a5,-28(s0)
    195a:	4384                	lw	s1,0(a5)
    195c:	2c75                	jal	1c18 <MC_get_tick>
    195e:	87aa                	mv	a5,a0
    1960:	00f48733          	add	a4,s1,a5
    1964:	fec42783          	lw	a5,-20(s0)
    1968:	d7d8                	sw	a4,44(a5)
            break;
    196a:	0001                	nop
    }
    return 0;
    196c:	4781                	li	a5,0
}
    196e:	853e                	mv	a0,a5
    1970:	40f2                	lw	ra,28(sp)
    1972:	4462                	lw	s0,24(sp)
    1974:	44d2                	lw	s1,20(sp)
    1976:	6105                	addi	sp,sp,32
    1978:	8082                	ret

0000197a <MC_timer_start>:

/**
 * 启动定时器
*/
uint8_t MC_timer_start(MC_timer_t timer)
{
    197a:	1101                	addi	sp,sp,-32
    197c:	ce06                	sw	ra,28(sp)
    197e:	cc22                	sw	s0,24(sp)
    1980:	1000                	addi	s0,sp,32
    1982:	fea42623          	sw	a0,-20(s0)
    MC_timer_list_insert(&timer->node);
    1986:	fec42783          	lw	a5,-20(s0)
    198a:	02078793          	addi	a5,a5,32
    198e:	853e                	mv	a0,a5
    1990:	3dad                	jal	180a <MC_timer_list_insert>
    return 0;
    1992:	4781                	li	a5,0
}
    1994:	853e                	mv	a0,a5
    1996:	40f2                	lw	ra,28(sp)
    1998:	4462                	lw	s0,24(sp)
    199a:	6105                	addi	sp,sp,32
    199c:	8082                	ret

0000199e <_timer_init>:
                char *name,
                void (*timeout)(void *parameter),
                void *parameter,
                uint32_t time,
                uint8_t flag)
{
    199e:	7139                	addi	sp,sp,-64
    19a0:	de06                	sw	ra,60(sp)
    19a2:	dc22                	sw	s0,56(sp)
    19a4:	0080                	addi	s0,sp,64
    19a6:	fca42e23          	sw	a0,-36(s0)
    19aa:	fcb42c23          	sw	a1,-40(s0)
    19ae:	fcc42a23          	sw	a2,-44(s0)
    19b2:	fcd42823          	sw	a3,-48(s0)
    19b6:	fce42623          	sw	a4,-52(s0)
    19ba:	fcf405a3          	sb	a5,-53(s0)
    if(timer_list == NULL)
    19be:	200017b7          	lui	a5,0x20001
    19c2:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    19c6:	eb95                	bnez	a5,19fa <_timer_init+0x5c>
    {
        timer_list = (MC_list_t)MC_PageMalloc(sizeof(struct MC_list));
    19c8:	4521                	li	a0,8
    19ca:	c89fe0ef          	jal	ra,652 <MC_PageMalloc>
    19ce:	872a                	mv	a4,a0
    19d0:	200017b7          	lui	a5,0x20001
    19d4:	84e7a223          	sw	a4,-1980(a5) # 20000844 <timer_list>
        if(timer_list == NULL)
    19d8:	200017b7          	lui	a5,0x20001
    19dc:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    19e0:	cfc9                	beqz	a5,1a7a <_timer_init+0xdc>
        {
            return ;
        }
        timer_list->prev = NULL;
    19e2:	200017b7          	lui	a5,0x20001
    19e6:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    19ea:	0007a023          	sw	zero,0(a5)
        timer_list->next = NULL;
    19ee:	200017b7          	lui	a5,0x20001
    19f2:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    19f6:	0007a223          	sw	zero,4(a5)
    }

    int len = MC_strlen(name);
    19fa:	fd842503          	lw	a0,-40(s0)
    19fe:	31f1                	jal	16ca <MC_strlen>
    1a00:	87aa                	mv	a5,a0
    1a02:	fef42623          	sw	a5,-20(s0)
    MC_memcpy(timer->name, name, len);
    1a06:	fdc42783          	lw	a5,-36(s0)
    1a0a:	fec42603          	lw	a2,-20(s0)
    1a0e:	fd842583          	lw	a1,-40(s0)
    1a12:	853e                	mv	a0,a5
    1a14:	393d                	jal	1652 <MC_memcpy>

    timer->flag = flag;
    1a16:	fdc42783          	lw	a5,-36(s0)
    1a1a:	fcb44703          	lbu	a4,-53(s0)
    1a1e:	00e78e23          	sb	a4,28(a5)

    /*设置挂起*/
    timer->flag |= 1;
    1a22:	fdc42783          	lw	a5,-36(s0)
    1a26:	01c7c783          	lbu	a5,28(a5)
    1a2a:	0017e793          	ori	a5,a5,1
    1a2e:	0ff7f713          	andi	a4,a5,255
    1a32:	fdc42783          	lw	a5,-36(s0)
    1a36:	00e78e23          	sb	a4,28(a5)

    timer->timeout_func = timeout;
    1a3a:	fdc42783          	lw	a5,-36(s0)
    1a3e:	fd442703          	lw	a4,-44(s0)
    1a42:	cbd8                	sw	a4,20(a5)
    timer->parameter = parameter;
    1a44:	fdc42783          	lw	a5,-36(s0)
    1a48:	fd042703          	lw	a4,-48(s0)
    1a4c:	cf98                	sw	a4,24(a5)

    timer->init_tick = time;
    1a4e:	fdc42783          	lw	a5,-36(s0)
    1a52:	fcc42703          	lw	a4,-52(s0)
    1a56:	d798                	sw	a4,40(a5)
    timer->timeout_tick = time + MC_get_tick();
    1a58:	22c1                	jal	1c18 <MC_get_tick>
    1a5a:	872a                	mv	a4,a0
    1a5c:	fcc42783          	lw	a5,-52(s0)
    1a60:	973e                	add	a4,a4,a5
    1a62:	fdc42783          	lw	a5,-36(s0)
    1a66:	d7d8                	sw	a4,44(a5)
    timer->node.prev = NULL;
    1a68:	fdc42783          	lw	a5,-36(s0)
    1a6c:	0207a023          	sw	zero,32(a5)
    timer->node.next = NULL;
    1a70:	fdc42783          	lw	a5,-36(s0)
    1a74:	0207a223          	sw	zero,36(a5)
    1a78:	a011                	j	1a7c <_timer_init+0xde>
            return ;
    1a7a:	0001                	nop

    // MC_timer_list_insert(&timer->node);
}
    1a7c:	50f2                	lw	ra,60(sp)
    1a7e:	5462                	lw	s0,56(sp)
    1a80:	6121                	addi	sp,sp,64
    1a82:	8082                	ret

00001a84 <MC_timer_init>:
                    char *name,
                    void (*timeout)(void *parameter),
                    void *parameter,
                    uint32_t time,
                    uint8_t flag)
{
    1a84:	7179                	addi	sp,sp,-48
    1a86:	d606                	sw	ra,44(sp)
    1a88:	d422                	sw	s0,40(sp)
    1a8a:	1800                	addi	s0,sp,48
    1a8c:	fea42623          	sw	a0,-20(s0)
    1a90:	feb42423          	sw	a1,-24(s0)
    1a94:	fec42223          	sw	a2,-28(s0)
    1a98:	fed42023          	sw	a3,-32(s0)
    1a9c:	fce42e23          	sw	a4,-36(s0)
    1aa0:	fcf40da3          	sb	a5,-37(s0)
    if(timer == NULL)
    1aa4:	fec42783          	lw	a5,-20(s0)
    1aa8:	e399                	bnez	a5,1aae <MC_timer_init+0x2a>
    {
        return 1;
    1aaa:	4785                	li	a5,1
    1aac:	a839                	j	1aca <MC_timer_init+0x46>
    }

    _timer_init(timer, name, timeout, parameter, time, flag);
    1aae:	fdb44783          	lbu	a5,-37(s0)
    1ab2:	fdc42703          	lw	a4,-36(s0)
    1ab6:	fe042683          	lw	a3,-32(s0)
    1aba:	fe442603          	lw	a2,-28(s0)
    1abe:	fe842583          	lw	a1,-24(s0)
    1ac2:	fec42503          	lw	a0,-20(s0)
    1ac6:	3de1                	jal	199e <_timer_init>

    return 0;
    1ac8:	4781                	li	a5,0
}
    1aca:	853e                	mv	a0,a5
    1acc:	50b2                	lw	ra,44(sp)
    1ace:	5422                	lw	s0,40(sp)
    1ad0:	6145                	addi	sp,sp,48
    1ad2:	8082                	ret

00001ad4 <MC_timer_create>:
MC_timer_t MC_timer_create(char *name,
                     void (*timeout)(void *parameter),
                     void *parameter,
                     uint32_t time,
                     uint8_t flag)
{
    1ad4:	7139                	addi	sp,sp,-64
    1ad6:	de06                	sw	ra,60(sp)
    1ad8:	dc22                	sw	s0,56(sp)
    1ada:	0080                	addi	s0,sp,64
    1adc:	fca42e23          	sw	a0,-36(s0)
    1ae0:	fcb42c23          	sw	a1,-40(s0)
    1ae4:	fcc42a23          	sw	a2,-44(s0)
    1ae8:	fcd42823          	sw	a3,-48(s0)
    1aec:	87ba                	mv	a5,a4
    1aee:	fcf407a3          	sb	a5,-49(s0)
    MC_timer_t timer;

    timer = (struct MC_timer*)MC_PageMalloc(sizeof(struct MC_timer));
    1af2:	03000513          	li	a0,48
    1af6:	b5dfe0ef          	jal	ra,652 <MC_PageMalloc>
    1afa:	fea42623          	sw	a0,-20(s0)
    if(timer == NULL)
    1afe:	fec42783          	lw	a5,-20(s0)
    1b02:	e399                	bnez	a5,1b08 <MC_timer_create+0x34>
    {
        return NULL;
    1b04:	4781                	li	a5,0
    1b06:	a005                	j	1b26 <MC_timer_create+0x52>
    }
    
    _timer_init(timer, name, timeout, parameter, time, flag);
    1b08:	fcf44783          	lbu	a5,-49(s0)
    1b0c:	fd042703          	lw	a4,-48(s0)
    1b10:	fd442683          	lw	a3,-44(s0)
    1b14:	fd842603          	lw	a2,-40(s0)
    1b18:	fdc42583          	lw	a1,-36(s0)
    1b1c:	fec42503          	lw	a0,-20(s0)
    1b20:	3dbd                	jal	199e <_timer_init>
    return timer;
    1b22:	fec42783          	lw	a5,-20(s0)
}
    1b26:	853e                	mv	a0,a5
    1b28:	50f2                	lw	ra,60(sp)
    1b2a:	5462                	lw	s0,56(sp)
    1b2c:	6121                	addi	sp,sp,64
    1b2e:	8082                	ret

00001b30 <MC_timer_load>:

/**
 * systick周期设置
*/
void MC_timer_load(int interval)
{
    1b30:	7179                	addi	sp,sp,-48
    1b32:	d622                	sw	s0,44(sp)
    1b34:	1800                	addi	s0,sp,48
    1b36:	fca42e23          	sw	a0,-36(s0)
    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    1b3a:	e000f537          	lui	a0,0xe000f
    1b3e:	fea42623          	sw	a0,-20(s0)
    uint64_t  mtime;

    mtime = ((uint64_t)(rtk_controller->CNTH) << 32) + rtk_controller->CNTL;
    1b42:	fec42503          	lw	a0,-20(s0)
    1b46:	4548                	lw	a0,12(a0)
    1b48:	87aa                	mv	a5,a0
    1b4a:	4801                	li	a6,0
    1b4c:	00079713          	slli	a4,a5,0x0
    1b50:	4681                	li	a3,0
    1b52:	fec42783          	lw	a5,-20(s0)
    1b56:	479c                	lw	a5,8(a5)
    1b58:	833e                	mv	t1,a5
    1b5a:	4381                	li	t2,0
    1b5c:	006687b3          	add	a5,a3,t1
    1b60:	853e                	mv	a0,a5
    1b62:	00d53533          	sltu	a0,a0,a3
    1b66:	00770833          	add	a6,a4,t2
    1b6a:	01050733          	add	a4,a0,a6
    1b6e:	883a                	mv	a6,a4
    1b70:	fef42023          	sw	a5,-32(s0)
    1b74:	ff042223          	sw	a6,-28(s0)
    mtime += interval;
    1b78:	fdc42783          	lw	a5,-36(s0)
    1b7c:	85be                	mv	a1,a5
    1b7e:	87fd                	srai	a5,a5,0x1f
    1b80:	863e                	mv	a2,a5
    1b82:	fe042683          	lw	a3,-32(s0)
    1b86:	fe442703          	lw	a4,-28(s0)
    1b8a:	00b687b3          	add	a5,a3,a1
    1b8e:	853e                	mv	a0,a5
    1b90:	00d53533          	sltu	a0,a0,a3
    1b94:	00c70833          	add	a6,a4,a2
    1b98:	01050733          	add	a4,a0,a6
    1b9c:	883a                	mv	a6,a4
    1b9e:	fef42023          	sw	a5,-32(s0)
    1ba2:	ff042223          	sw	a6,-28(s0)
    rtk_controller->CMPHR = (uint32_t)(mtime >> 32);
    1ba6:	fe442783          	lw	a5,-28(s0)
    1baa:	0007de13          	srli	t3,a5,0x0
    1bae:	4e81                	li	t4,0
    1bb0:	8772                	mv	a4,t3
    1bb2:	fec42783          	lw	a5,-20(s0)
    1bb6:	cbd8                	sw	a4,20(a5)
    rtk_controller->CMPLR = (uint32_t)(mtime & 0xffffffff);
    1bb8:	fe042703          	lw	a4,-32(s0)
    1bbc:	fec42783          	lw	a5,-20(s0)
    1bc0:	cb98                	sw	a4,16(a5)

    rtk_controller->CTRL = 0x00000007;
    1bc2:	fec42783          	lw	a5,-20(s0)
    1bc6:	471d                	li	a4,7
    1bc8:	c398                	sw	a4,0(a5)
}
    1bca:	0001                	nop
    1bcc:	5432                	lw	s0,44(sp)
    1bce:	6145                	addi	sp,sp,48
    1bd0:	8082                	ret

00001bd2 <MC_SysTick_init>:

/**
 * systick init
*/
void MC_SysTick_init()
{
    1bd2:	1101                	addi	sp,sp,-32
    1bd4:	ce06                	sw	ra,28(sp)
    1bd6:	cc22                	sw	s0,24(sp)
    1bd8:	1000                	addi	s0,sp,32
    PFIC_IENR_t pfic_ienr = (PFIC_IENR_t)PFIC_IENR_BASE;
    1bda:	e000e7b7          	lui	a5,0xe000e
    1bde:	10078793          	addi	a5,a5,256 # e000e100 <_end_stack+0xbfffe100>
    1be2:	fef42623          	sw	a5,-20(s0)
    pfic_ienr->IENRx[0] |= 1 << SYS_TICK_IRQ;//使能systick中断
    1be6:	fec42783          	lw	a5,-20(s0)
    1bea:	4398                	lw	a4,0(a5)
    1bec:	6785                	lui	a5,0x1
    1bee:	8f5d                	or	a4,a4,a5
    1bf0:	fec42783          	lw	a5,-20(s0)
    1bf4:	c398                	sw	a4,0(a5)
    pfic_ienr->IENRx[0] |= 1 << SOFTWARE_IRQ; //使能软件中断
    1bf6:	fec42783          	lw	a5,-20(s0)
    1bfa:	4398                	lw	a4,0(a5)
    1bfc:	6791                	lui	a5,0x4
    1bfe:	8f5d                	or	a4,a4,a5
    1c00:	fec42783          	lw	a5,-20(s0)
    1c04:	c398                	sw	a4,0(a5)

    MC_timer_load(TIMER_INTERVAL);
    1c06:	6789                	lui	a5,0x2
    1c08:	f4078513          	addi	a0,a5,-192 # 1f40 <main+0xb6>
    1c0c:	3715                	jal	1b30 <MC_timer_load>
}
    1c0e:	0001                	nop
    1c10:	40f2                	lw	ra,28(sp)
    1c12:	4462                	lw	s0,24(sp)
    1c14:	6105                	addi	sp,sp,32
    1c16:	8082                	ret

00001c18 <MC_get_tick>:

uint32_t MC_get_tick()
{
    1c18:	1141                	addi	sp,sp,-16
    1c1a:	c622                	sw	s0,12(sp)
    1c1c:	0800                	addi	s0,sp,16
    return _tick;
    1c1e:	200007b7          	lui	a5,0x20000
    1c22:	4147a783          	lw	a5,1044(a5) # 20000414 <_tick>
}
    1c26:	853e                	mv	a0,a5
    1c28:	4432                	lw	s0,12(sp)
    1c2a:	0141                	addi	sp,sp,16
    1c2c:	8082                	ret

00001c2e <MC_timer_realse>:
/**
 * 执行定时器回调，并设置定时器
*/

void MC_timer_realse(MC_list_t node)
{
    1c2e:	7179                	addi	sp,sp,-48
    1c30:	d606                	sw	ra,44(sp)
    1c32:	d422                	sw	s0,40(sp)
    1c34:	d226                	sw	s1,36(sp)
    1c36:	1800                	addi	s0,sp,48
    1c38:	fca42e23          	sw	a0,-36(s0)
    MC_thread_t thread = NULL;
    1c3c:	fe042623          	sw	zero,-20(s0)
    MC_timer_t timer = NULL;
    1c40:	fe042423          	sw	zero,-24(s0)

    timer = MC_container_of(node, struct MC_timer, node);
    1c44:	fdc42783          	lw	a5,-36(s0)
    1c48:	1781                	addi	a5,a5,-32
    1c4a:	fef42423          	sw	a5,-24(s0)

    

    if(node->next != NULL)
    1c4e:	fdc42783          	lw	a5,-36(s0)
    1c52:	43dc                	lw	a5,4(a5)
    1c54:	c395                	beqz	a5,1c78 <MC_timer_realse+0x4a>
    {
        timer_list->next = node->next;
    1c56:	200017b7          	lui	a5,0x20001
    1c5a:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    1c5e:	fdc42703          	lw	a4,-36(s0)
    1c62:	4358                	lw	a4,4(a4)
    1c64:	c3d8                	sw	a4,4(a5)
        node->next->prev = timer_list;
    1c66:	fdc42783          	lw	a5,-36(s0)
    1c6a:	43dc                	lw	a5,4(a5)
    1c6c:	20001737          	lui	a4,0x20001
    1c70:	84472703          	lw	a4,-1980(a4) # 20000844 <timer_list>
    1c74:	c398                	sw	a4,0(a5)
    1c76:	a039                	j	1c84 <MC_timer_realse+0x56>
    }
    else
    {
        timer_list->next = NULL;
    1c78:	200017b7          	lui	a5,0x20001
    1c7c:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    1c80:	0007a223          	sw	zero,4(a5)
    }

    if(timer->timeout_func != NULL)
    1c84:	fe842783          	lw	a5,-24(s0)
    1c88:	4bdc                	lw	a5,20(a5)
    1c8a:	cb89                	beqz	a5,1c9c <MC_timer_realse+0x6e>
    {
        timer->timeout_func(timer->parameter);
    1c8c:	fe842783          	lw	a5,-24(s0)
    1c90:	4bd8                	lw	a4,20(a5)
    1c92:	fe842783          	lw	a5,-24(s0)
    1c96:	4f9c                	lw	a5,24(a5)
    1c98:	853e                	mv	a0,a5
    1c9a:	9702                	jalr	a4
    }
    
    // 如果不是线程定时器
    if(! (timer->flag & MC_TIMER_FLAG_THREAD_TIMER) )
    1c9c:	fe842783          	lw	a5,-24(s0)
    1ca0:	01c7c783          	lbu	a5,28(a5)
    1ca4:	8b91                	andi	a5,a5,4
    1ca6:	e3a1                	bnez	a5,1ce6 <MC_timer_realse+0xb8>
    {
        if(timer->flag & MC_TIMER_FLAG_CYCLE_TIMER)
    1ca8:	fe842783          	lw	a5,-24(s0)
    1cac:	01c7c783          	lbu	a5,28(a5)
    1cb0:	8b89                	andi	a5,a5,2
    1cb2:	cf99                	beqz	a5,1cd0 <MC_timer_realse+0xa2>
        {
            timer->timeout_tick = timer->init_tick + MC_get_tick();
    1cb4:	fe842783          	lw	a5,-24(s0)
    1cb8:	5784                	lw	s1,40(a5)
    1cba:	3fb9                	jal	1c18 <MC_get_tick>
    1cbc:	87aa                	mv	a5,a0
    1cbe:	00f48733          	add	a4,s1,a5
    1cc2:	fe842783          	lw	a5,-24(s0)
    1cc6:	d7d8                	sw	a4,44(a5)

            //再次插入定时器节点
            MC_timer_list_insert(node);
    1cc8:	fdc42503          	lw	a0,-36(s0)
    1ccc:	3e3d                	jal	180a <MC_timer_list_insert>
    1cce:	a821                	j	1ce6 <MC_timer_realse+0xb8>
        }
        else
        {  
            timer->flag &= ~MC_TIMER_FLAG_ACTIVATED;
    1cd0:	fe842783          	lw	a5,-24(s0)
    1cd4:	01c7c783          	lbu	a5,28(a5)
    1cd8:	9bf9                	andi	a5,a5,-2
    1cda:	0ff7f713          	andi	a4,a5,255
    1cde:	fe842783          	lw	a5,-24(s0)
    1ce2:	00e78e23          	sb	a4,28(a5)
        }
    }
    

    //如果是线程定时器
    if(timer->flag & MC_TIMER_FLAG_THREAD_TIMER)
    1ce6:	fe842783          	lw	a5,-24(s0)
    1cea:	01c7c783          	lbu	a5,28(a5)
    1cee:	8b91                	andi	a5,a5,4
    1cf0:	cb85                	beqz	a5,1d20 <MC_timer_realse+0xf2>
    {   
        thread = MC_container_of(timer, struct MC_thread, timer);
    1cf2:	fe842783          	lw	a5,-24(s0)
    1cf6:	fd878793          	addi	a5,a5,-40
    1cfa:	fef42623          	sw	a5,-20(s0)

        //如果当前线程在运行中，则调度
        if(thread->state == MC_THREAD_STATE_RUNNING)
    1cfe:	fec42783          	lw	a5,-20(s0)
    1d02:	0607c783          	lbu	a5,96(a5)
    1d06:	e399                	bnez	a5,1d0c <MC_timer_realse+0xde>
        {
            MC_scheduler_begin();
    1d08:	af6ff0ef          	jal	ra,ffe <MC_scheduler_begin>
        }

        //如果当前线程被挂起，则恢复就绪态
        if(thread->state == MC_THREAD_STATE_SUSPEND)
    1d0c:	fec42783          	lw	a5,-20(s0)
    1d10:	0607c703          	lbu	a4,96(a5)
    1d14:	4789                	li	a5,2
    1d16:	00f71563          	bne	a4,a5,1d20 <MC_timer_realse+0xf2>
        {
            MC_suspend_list_dequeue_timeout(thread);
    1d1a:	fec42503          	lw	a0,-20(s0)
    1d1e:	2531                	jal	232a <MC_suspend_list_dequeue_timeout>
        }
        
    }
    
}   
    1d20:	0001                	nop
    1d22:	50b2                	lw	ra,44(sp)
    1d24:	5422                	lw	s0,40(sp)
    1d26:	5492                	lw	s1,36(sp)
    1d28:	6145                	addi	sp,sp,48
    1d2a:	8082                	ret

00001d2c <MC_timer_check>:

/**
 *  检查定时器超时情况
 */
void MC_timer_check()
{
    1d2c:	1101                	addi	sp,sp,-32
    1d2e:	ce06                	sw	ra,28(sp)
    1d30:	cc22                	sw	s0,24(sp)
    1d32:	1000                	addi	s0,sp,32
    uint32_t next_timeout;
    
    if(timer_list->next != NULL)
    1d34:	200017b7          	lui	a5,0x20001
    1d38:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    1d3c:	43dc                	lw	a5,4(a5)
    1d3e:	cb9d                	beqz	a5,1d74 <MC_timer_check+0x48>
    {
        MC_timer_t timer = MC_container_of(timer_list->next, struct MC_timer, node);
    1d40:	200017b7          	lui	a5,0x20001
    1d44:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    1d48:	43dc                	lw	a5,4(a5)
    1d4a:	1781                	addi	a5,a5,-32
    1d4c:	fef42623          	sw	a5,-20(s0)
        next_timeout = timer->timeout_tick;
    1d50:	fec42783          	lw	a5,-20(s0)
    1d54:	57dc                	lw	a5,44(a5)
    1d56:	fef42423          	sw	a5,-24(s0)
        if(next_timeout <= MC_get_tick())
    1d5a:	3d7d                	jal	1c18 <MC_get_tick>
    1d5c:	872a                	mv	a4,a0
    1d5e:	fe842783          	lw	a5,-24(s0)
    1d62:	00f76963          	bltu	a4,a5,1d74 <MC_timer_check+0x48>
        {
            MC_timer_realse(timer_list->next);
    1d66:	200017b7          	lui	a5,0x20001
    1d6a:	8447a783          	lw	a5,-1980(a5) # 20000844 <timer_list>
    1d6e:	43dc                	lw	a5,4(a5)
    1d70:	853e                	mv	a0,a5
    1d72:	3d75                	jal	1c2e <MC_timer_realse>
        }
    }
}
    1d74:	0001                	nop
    1d76:	40f2                	lw	ra,28(sp)
    1d78:	4462                	lw	s0,24(sp)
    1d7a:	6105                	addi	sp,sp,32
    1d7c:	8082                	ret

00001d7e <MC_timer_handler>:

void MC_timer_handler() 
{
    1d7e:	1101                	addi	sp,sp,-32
    1d80:	ce06                	sw	ra,28(sp)
    1d82:	cc22                	sw	s0,24(sp)
    1d84:	1000                	addi	s0,sp,32
	_tick++;
    1d86:	200007b7          	lui	a5,0x20000
    1d8a:	4147a783          	lw	a5,1044(a5) # 20000414 <_tick>
    1d8e:	00178713          	addi	a4,a5,1
    1d92:	200007b7          	lui	a5,0x20000
    1d96:	40e7aa23          	sw	a4,1044(a5) # 20000414 <_tick>
    // if(_tick % 1000 == 0)
	//     printf("tick: %d\r\n", _tick / 1000);

    MC_timer_check();
    1d9a:	3f49                	jal	1d2c <MC_timer_check>

    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    1d9c:	e000f7b7          	lui	a5,0xe000f
    1da0:	fef42623          	sw	a5,-20(s0)
    rtk_controller->SR = 0;
    1da4:	fec42783          	lw	a5,-20(s0)
    1da8:	0007a223          	sw	zero,4(a5) # e000f004 <_end_stack+0xbffff004>
	MC_timer_load(TIMER_INTERVAL);
    1dac:	6789                	lui	a5,0x2
    1dae:	f4078513          	addi	a0,a5,-192 # 1f40 <main+0xb6>
    1db2:	3bbd                	jal	1b30 <MC_timer_load>

    1db4:	0001                	nop
    1db6:	40f2                	lw	ra,28(sp)
    1db8:	4462                	lw	s0,24(sp)
    1dba:	6105                	addi	sp,sp,32
    1dbc:	8082                	ret

00001dbe <thread1_entry>:
//         MC_delay(10000);
//     }
// }
int sum = 0;
void thread1_entry()
{
    1dbe:	1101                	addi	sp,sp,-32
    1dc0:	ce06                	sw	ra,28(sp)
    1dc2:	cc22                	sw	s0,24(sp)
    1dc4:	1000                	addi	s0,sp,32
    printf("test_thread1_start!\r\n");
    1dc6:	6789                	lui	a5,0x2
    1dc8:	75478513          	addi	a0,a5,1876 # 2754 <STACK_END+0x94>
    1dcc:	fddfe0ef          	jal	ra,da8 <printf>
    for(int i = 1; i <= 1000000; i++)
    1dd0:	4785                	li	a5,1
    1dd2:	fef42623          	sw	a5,-20(s0)
    1dd6:	a005                	j	1df6 <thread1_entry+0x38>
    {
        sum++;
    1dd8:	200007b7          	lui	a5,0x20000
    1ddc:	4187a783          	lw	a5,1048(a5) # 20000418 <sum>
    1de0:	00178713          	addi	a4,a5,1
    1de4:	200007b7          	lui	a5,0x20000
    1de8:	40e7ac23          	sw	a4,1048(a5) # 20000418 <sum>
    for(int i = 1; i <= 1000000; i++)
    1dec:	fec42783          	lw	a5,-20(s0)
    1df0:	0785                	addi	a5,a5,1
    1df2:	fef42623          	sw	a5,-20(s0)
    1df6:	fec42703          	lw	a4,-20(s0)
    1dfa:	000f47b7          	lui	a5,0xf4
    1dfe:	24078793          	addi	a5,a5,576 # f4240 <_heap_size+0xe5a98>
    1e02:	fce7dbe3          	bge	a5,a4,1dd8 <thread1_entry+0x1a>
    }
    printf("test_thread1_end! sum: %d\r\n", sum);
    1e06:	200007b7          	lui	a5,0x20000
    1e0a:	4187a783          	lw	a5,1048(a5) # 20000418 <sum>
    1e0e:	85be                	mv	a1,a5
    1e10:	6789                	lui	a5,0x2
    1e12:	76c78513          	addi	a0,a5,1900 # 276c <STACK_END+0xac>
    1e16:	f93fe0ef          	jal	ra,da8 <printf>
    while(1)
    {
        MC_delay(10000);
    1e1a:	6789                	lui	a5,0x2
    1e1c:	71078513          	addi	a0,a5,1808 # 2710 <STACK_END+0x50>
    1e20:	2d11                	jal	2434 <MC_delay>
    1e22:	bfe5                	j	1e1a <thread1_entry+0x5c>

00001e24 <thread2_entry>:
    }   
}

void thread2_entry()
{
    1e24:	1101                	addi	sp,sp,-32
    1e26:	ce06                	sw	ra,28(sp)
    1e28:	cc22                	sw	s0,24(sp)
    1e2a:	1000                	addi	s0,sp,32
    printf("test_thread2_start!\r\n");
    1e2c:	6789                	lui	a5,0x2
    1e2e:	78878513          	addi	a0,a5,1928 # 2788 <STACK_END+0xc8>
    1e32:	f77fe0ef          	jal	ra,da8 <printf>
    for(int i = 1; i <= 1000000; i++)
    1e36:	4785                	li	a5,1
    1e38:	fef42623          	sw	a5,-20(s0)
    1e3c:	a005                	j	1e5c <thread2_entry+0x38>
    {
        sum++;
    1e3e:	200007b7          	lui	a5,0x20000
    1e42:	4187a783          	lw	a5,1048(a5) # 20000418 <sum>
    1e46:	00178713          	addi	a4,a5,1
    1e4a:	200007b7          	lui	a5,0x20000
    1e4e:	40e7ac23          	sw	a4,1048(a5) # 20000418 <sum>
    for(int i = 1; i <= 1000000; i++)
    1e52:	fec42783          	lw	a5,-20(s0)
    1e56:	0785                	addi	a5,a5,1
    1e58:	fef42623          	sw	a5,-20(s0)
    1e5c:	fec42703          	lw	a4,-20(s0)
    1e60:	000f47b7          	lui	a5,0xf4
    1e64:	24078793          	addi	a5,a5,576 # f4240 <_heap_size+0xe5a98>
    1e68:	fce7dbe3          	bge	a5,a4,1e3e <thread2_entry+0x1a>
    }
    printf("test_thread2_end! sum: %d\r\n", sum);
    1e6c:	200007b7          	lui	a5,0x20000
    1e70:	4187a783          	lw	a5,1048(a5) # 20000418 <sum>
    1e74:	85be                	mv	a1,a5
    1e76:	6789                	lui	a5,0x2
    1e78:	7a078513          	addi	a0,a5,1952 # 27a0 <STACK_END+0xe0>
    1e7c:	f2dfe0ef          	jal	ra,da8 <printf>
    while(1)
    {
        MC_delay(10000);
    1e80:	6789                	lui	a5,0x2
    1e82:	71078513          	addi	a0,a5,1808 # 2710 <STACK_END+0x50>
    1e86:	237d                	jal	2434 <MC_delay>
    1e88:	bfe5                	j	1e80 <thread2_entry+0x5c>

00001e8a <main>:
    }   
}

int main()
{
    1e8a:	1101                	addi	sp,sp,-32
    1e8c:	ce06                	sw	ra,28(sp)
    1e8e:	cc22                	sw	s0,24(sp)
    1e90:	1000                	addi	s0,sp,32
    __ENABLE_INTERRUPT__(); // 开启全局中断
    1e92:	8e1ff0ef          	jal	ra,1772 <__ENABLE_INTERRUPT__>

    lock = MC_spinlock_create("lock_test");
    1e96:	6789                	lui	a5,0x2
    1e98:	7bc78513          	addi	a0,a5,1980 # 27bc <STACK_END+0xfc>
    1e9c:	25b9                	jal	24ea <MC_spinlock_create>
    1e9e:	872a                	mv	a4,a0
    1ea0:	200017b7          	lui	a5,0x20001
    1ea4:	84e7a423          	sw	a4,-1976(a5) # 20000848 <lock>

    thread1 = MC_thread_create("thread1",
    1ea8:	4789                	li	a5,2
    1eaa:	4715                	li	a4,5
    1eac:	03f00693          	li	a3,63
    1eb0:	20000613          	li	a2,512
    1eb4:	000025b7          	lui	a1,0x2
    1eb8:	dbe58593          	addi	a1,a1,-578 # 1dbe <thread1_entry>
    1ebc:	6509                	lui	a0,0x2
    1ebe:	7c850513          	addi	a0,a0,1992 # 27c8 <STACK_END+0x108>
    1ec2:	b82ff0ef          	jal	ra,1244 <MC_thread_create>
    1ec6:	872a                	mv	a4,a0
    1ec8:	200017b7          	lui	a5,0x20001
    1ecc:	84e7aa23          	sw	a4,-1964(a5) # 20000854 <thread1>
                                    thread1_entry,
                                    512,
                                    63,
                                    5,
                                    MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread1);
    1ed0:	200017b7          	lui	a5,0x20001
    1ed4:	8547a783          	lw	a5,-1964(a5) # 20000854 <thread1>
    1ed8:	853e                	mv	a0,a5
    1eda:	c52ff0ef          	jal	ra,132c <MC_thread_startup>

    thread2 = MC_thread_create("thread2",
    1ede:	4789                	li	a5,2
    1ee0:	4715                	li	a4,5
    1ee2:	03f00693          	li	a3,63
    1ee6:	20000613          	li	a2,512
    1eea:	000025b7          	lui	a1,0x2
    1eee:	e2458593          	addi	a1,a1,-476 # 1e24 <thread2_entry>
    1ef2:	6509                	lui	a0,0x2
    1ef4:	7d050513          	addi	a0,a0,2000 # 27d0 <STACK_END+0x110>
    1ef8:	b4cff0ef          	jal	ra,1244 <MC_thread_create>
    1efc:	872a                	mv	a4,a0
    1efe:	200017b7          	lui	a5,0x20001
    1f02:	84e7a623          	sw	a4,-1972(a5) # 2000084c <thread2>
                                    thread2_entry,
                                    512,
                                    63,
                                    5,
                                    MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread2);
    1f06:	200017b7          	lui	a5,0x20001
    1f0a:	84c7a783          	lw	a5,-1972(a5) # 2000084c <thread2>
    1f0e:	853e                	mv	a0,a5
    1f10:	c1cff0ef          	jal	ra,132c <MC_thread_startup>

    MC_scheduler_begin();
    1f14:	8eaff0ef          	jal	ra,ffe <MC_scheduler_begin>

    uint32_t tick = 0, tmp;
    1f18:	fe042623          	sw	zero,-20(s0)
    while(1){
        // MC_thread_yield();
        tmp = MC_get_tick() / 1000;
    1f1c:	39f5                	jal	1c18 <MC_get_tick>
    1f1e:	872a                	mv	a4,a0
    1f20:	3e800793          	li	a5,1000
    1f24:	02f757b3          	divu	a5,a4,a5
    1f28:	fef42423          	sw	a5,-24(s0)
        if(tmp != tick)
    1f2c:	fe842703          	lw	a4,-24(s0)
    1f30:	fec42783          	lw	a5,-20(s0)
    1f34:	fef704e3          	beq	a4,a5,1f1c <main+0x92>
        {
            tick = tmp;
    1f38:	fe842783          	lw	a5,-24(s0)
    1f3c:	fef42623          	sw	a5,-20(s0)
            printf("main: tick:%d\r\n", tick);
    1f40:	fec42583          	lw	a1,-20(s0)
    1f44:	6789                	lui	a5,0x2
    1f46:	7d878513          	addi	a0,a5,2008 # 27d8 <STACK_END+0x118>
    1f4a:	e5ffe0ef          	jal	ra,da8 <printf>
        tmp = MC_get_tick() / 1000;
    1f4e:	b7f9                	j	1f1c <main+0x92>

00001f50 <MC_pfic_pending_set>:

/**
 * 中断挂起设置
*/
void MC_pfic_pending_set(uint8_t irqn)
{
    1f50:	7179                	addi	sp,sp,-48
    1f52:	d622                	sw	s0,44(sp)
    1f54:	1800                	addi	s0,sp,48
    1f56:	87aa                	mv	a5,a0
    1f58:	fcf40fa3          	sb	a5,-33(s0)
    uint8_t idx = irqn / 32;
    1f5c:	fdf44783          	lbu	a5,-33(s0)
    1f60:	8395                	srli	a5,a5,0x5
    1f62:	fef407a3          	sb	a5,-17(s0)
    pfic_ipsr->IPSRx[idx] = 1 << irqn;
    1f66:	fdf44783          	lbu	a5,-33(s0)
    1f6a:	4705                	li	a4,1
    1f6c:	00f716b3          	sll	a3,a4,a5
    1f70:	200007b7          	lui	a5,0x20000
    1f74:	0147a703          	lw	a4,20(a5) # 20000014 <pfic_ipsr>
    1f78:	fef44783          	lbu	a5,-17(s0)
    1f7c:	078a                	slli	a5,a5,0x2
    1f7e:	97ba                	add	a5,a5,a4
    1f80:	c394                	sw	a3,0(a5)
}
    1f82:	0001                	nop
    1f84:	5432                	lw	s0,44(sp)
    1f86:	6145                	addi	sp,sp,48
    1f88:	8082                	ret

00001f8a <MC_pfic_pending_clear>:

/**
 * 中断挂起清除
*/
void MC_pfic_pending_clear(uint8_t irqn)
{
    1f8a:	7179                	addi	sp,sp,-48
    1f8c:	d622                	sw	s0,44(sp)
    1f8e:	1800                	addi	s0,sp,48
    1f90:	87aa                	mv	a5,a0
    1f92:	fcf40fa3          	sb	a5,-33(s0)
    uint8_t idx = irqn / 32;
    1f96:	fdf44783          	lbu	a5,-33(s0)
    1f9a:	8395                	srli	a5,a5,0x5
    1f9c:	fef407a3          	sb	a5,-17(s0)
    pfic_iprr->IPRRx[idx] = 1 << irqn;
    1fa0:	fdf44783          	lbu	a5,-33(s0)
    1fa4:	4705                	li	a4,1
    1fa6:	00f716b3          	sll	a3,a4,a5
    1faa:	200007b7          	lui	a5,0x20000
    1fae:	0187a703          	lw	a4,24(a5) # 20000018 <pfic_iprr>
    1fb2:	fef44783          	lbu	a5,-17(s0)
    1fb6:	078a                	slli	a5,a5,0x2
    1fb8:	97ba                	add	a5,a5,a4
    1fba:	c394                	sw	a3,0(a5)
    1fbc:	0001                	nop
    1fbe:	5432                	lw	s0,44(sp)
    1fc0:	6145                	addi	sp,sp,48
    1fc2:	8082                	ret

00001fc4 <_sem_init>:
#include "os.h"


void _sem_init(MC_sem_t sem, char *name, uint16_t value, uint8_t flag, uint16_t max_value)
{
    1fc4:	7179                	addi	sp,sp,-48
    1fc6:	d606                	sw	ra,44(sp)
    1fc8:	d422                	sw	s0,40(sp)
    1fca:	1800                	addi	s0,sp,48
    1fcc:	fca42e23          	sw	a0,-36(s0)
    1fd0:	fcb42c23          	sw	a1,-40(s0)
    1fd4:	87b2                	mv	a5,a2
    1fd6:	fcf41b23          	sh	a5,-42(s0)
    1fda:	87b6                	mv	a5,a3
    1fdc:	fcf40aa3          	sb	a5,-43(s0)
    1fe0:	87ba                	mv	a5,a4
    1fe2:	fcf41923          	sh	a5,-46(s0)
    int len = MC_strlen(name);
    1fe6:	fd842503          	lw	a0,-40(s0)
    1fea:	ee0ff0ef          	jal	ra,16ca <MC_strlen>
    1fee:	87aa                	mv	a5,a0
    1ff0:	fef42623          	sw	a5,-20(s0)
    MC_memcpy(sem->name, name, len);
    1ff4:	fdc42783          	lw	a5,-36(s0)
    1ff8:	fec42603          	lw	a2,-20(s0)
    1ffc:	fd842583          	lw	a1,-40(s0)
    2000:	853e                	mv	a0,a5
    2002:	e50ff0ef          	jal	ra,1652 <MC_memcpy>

    sem->suspend_thread.next = NULL;
    2006:	fdc42783          	lw	a5,-36(s0)
    200a:	0007ae23          	sw	zero,28(a5)
    sem->suspend_thread.prev = NULL;
    200e:	fdc42783          	lw	a5,-36(s0)
    2012:	0007ac23          	sw	zero,24(a5)

    sem->max_value = max_value;
    2016:	fdc42783          	lw	a5,-36(s0)
    201a:	fd245703          	lhu	a4,-46(s0)
    201e:	02e79123          	sh	a4,34(a5)
    sem->value = value;
    2022:	fdc42783          	lw	a5,-36(s0)
    2026:	fd645703          	lhu	a4,-42(s0)
    202a:	02e79023          	sh	a4,32(a5)
    sem->flag = flag;
    202e:	fdc42783          	lw	a5,-36(s0)
    2032:	fd544703          	lbu	a4,-43(s0)
    2036:	00e78a23          	sb	a4,20(a5)
    sem->attribute = MC_IPCATTR_SEM;
    203a:	fdc42783          	lw	a5,-36(s0)
    203e:	4709                	li	a4,2
    2040:	02e78223          	sb	a4,36(a5)

    // sem->spinlock.lock = 1; //对于单核多线程不需要加锁，因为这里对于临界区访问直接关闭了调度器。
}
    2044:	0001                	nop
    2046:	50b2                	lw	ra,44(sp)
    2048:	5422                	lw	s0,40(sp)
    204a:	6145                	addi	sp,sp,48
    204c:	8082                	ret

0000204e <MC_sem_create>:
 * flag 指示线程挂起队列的排序方式
 * MC_IPC_FLAG_PRIO 按照优先级由高到低排列
 * MC_IPC_FLAG_FIFO 按照先进先出排列
*/
MC_sem_t MC_sem_create(char *name, uint16_t value,uint8_t flag)
{
    204e:	7179                	addi	sp,sp,-48
    2050:	d606                	sw	ra,44(sp)
    2052:	d422                	sw	s0,40(sp)
    2054:	1800                	addi	s0,sp,48
    2056:	fca42e23          	sw	a0,-36(s0)
    205a:	87ae                	mv	a5,a1
    205c:	8732                	mv	a4,a2
    205e:	fcf41d23          	sh	a5,-38(s0)
    2062:	87ba                	mv	a5,a4
    2064:	fcf40ca3          	sb	a5,-39(s0)
    MC_sem_t sem;

    sem = MC_PageMalloc(sizeof(struct MC_semaphore));
    2068:	02800513          	li	a0,40
    206c:	de6fe0ef          	jal	ra,652 <MC_PageMalloc>
    2070:	fea42623          	sw	a0,-20(s0)
    if(sem == NULL)
    2074:	fec42783          	lw	a5,-20(s0)
    2078:	e399                	bnez	a5,207e <MC_sem_create+0x30>
    {
        return NULL;
    207a:	4781                	li	a5,0
    207c:	a839                	j	209a <MC_sem_create+0x4c>
    }

    _sem_init(sem, name, value, flag, MC_IPC_SEM_MAXVALUE);
    207e:	fd944683          	lbu	a3,-39(s0)
    2082:	fda45603          	lhu	a2,-38(s0)
    2086:	67c1                	lui	a5,0x10
    2088:	fff78713          	addi	a4,a5,-1 # ffff <_heap_size+0x1857>
    208c:	fdc42583          	lw	a1,-36(s0)
    2090:	fec42503          	lw	a0,-20(s0)
    2094:	3f05                	jal	1fc4 <_sem_init>

    return sem;
    2096:	fec42783          	lw	a5,-20(s0)
}
    209a:	853e                	mv	a0,a5
    209c:	50b2                	lw	ra,44(sp)
    209e:	5422                	lw	s0,40(sp)
    20a0:	6145                	addi	sp,sp,48
    20a2:	8082                	ret

000020a4 <MC_sem_delete>:

/**
 * 信号量删除
*/
uint8_t MC_sem_delete(MC_sem_t sem)
{
    20a4:	1101                	addi	sp,sp,-32
    20a6:	ce22                	sw	s0,28(sp)
    20a8:	1000                	addi	s0,sp,32
    20aa:	fea42623          	sw	a0,-20(s0)

    return 0;
    20ae:	4781                	li	a5,0
}
    20b0:	853e                	mv	a0,a5
    20b2:	4472                	lw	s0,28(sp)
    20b4:	6105                	addi	sp,sp,32
    20b6:	8082                	ret

000020b8 <_MC_sem_take>:

/**
 * 申请信号量
 */
static uint8_t _MC_sem_take(MC_sem_t sem, uint32_t timeout)
{
    20b8:	7179                	addi	sp,sp,-48
    20ba:	d606                	sw	ra,44(sp)
    20bc:	d422                	sw	s0,40(sp)
    20be:	1800                	addi	s0,sp,48
    20c0:	fca42e23          	sw	a0,-36(s0)
    20c4:	fcb42c23          	sw	a1,-40(s0)
    MC_thread_t thread;

START:
    MC_scheduler_stop(); //关闭调度器,保证临界区的原子性
    20c8:	f87fe0ef          	jal	ra,104e <MC_scheduler_stop>
                        //单核，不设置加锁机制

    if(sem->value > 0)
    20cc:	fdc42783          	lw	a5,-36(s0)
    20d0:	0207d783          	lhu	a5,32(a5)
    20d4:	cf91                	beqz	a5,20f0 <_MC_sem_take+0x38>
    {
        sem->value --;
    20d6:	fdc42783          	lw	a5,-36(s0)
    20da:	0207d703          	lhu	a4,32(a5)
    20de:	177d                	addi	a4,a4,-1
    20e0:	0742                	slli	a4,a4,0x10
    20e2:	8341                	srli	a4,a4,0x10
    20e4:	02e79023          	sh	a4,32(a5)
        MC_scheduler_start();
    20e8:	f4dfe0ef          	jal	ra,1034 <MC_scheduler_start>
        }
        MC_scheduler_begin();
        //定时器结束后返回至此，要重新判断资源情况。
        goto START;
    }
    return 0;
    20ec:	4781                	li	a5,0
    20ee:	a085                	j	214e <_MC_sem_take+0x96>
        if(timeout == 0)
    20f0:	fd842783          	lw	a5,-40(s0)
    20f4:	e789                	bnez	a5,20fe <_MC_sem_take+0x46>
            MC_scheduler_start();
    20f6:	f3ffe0ef          	jal	ra,1034 <MC_scheduler_start>
            return 1;
    20fa:	4785                	li	a5,1
    20fc:	a889                	j	214e <_MC_sem_take+0x96>
            thread = MC_thread_self();
    20fe:	b12ff0ef          	jal	ra,1410 <MC_thread_self>
    2102:	fea42623          	sw	a0,-20(s0)
            MC_thread_to_suspend_list(thread, &sem, sem->attribute);
    2106:	fdc42783          	lw	a5,-36(s0)
    210a:	0247c703          	lbu	a4,36(a5)
    210e:	fdc40793          	addi	a5,s0,-36
    2112:	863a                	mv	a2,a4
    2114:	85be                	mv	a1,a5
    2116:	fec42503          	lw	a0,-20(s0)
    211a:	bc6ff0ef          	jal	ra,14e0 <MC_thread_to_suspend_list>
            if(timeout > 0)
    211e:	fd842783          	lw	a5,-40(s0)
    2122:	c39d                	beqz	a5,2148 <_MC_sem_take+0x90>
                MC_timer_control(&thread->timer, MC_TIMER_CTRL_SET_TIME, &timeout);
    2124:	fec42783          	lw	a5,-20(s0)
    2128:	02878793          	addi	a5,a5,40
    212c:	fd840713          	addi	a4,s0,-40
    2130:	863a                	mv	a2,a4
    2132:	4581                	li	a1,0
    2134:	853e                	mv	a0,a5
    2136:	fd6ff0ef          	jal	ra,190c <MC_timer_control>
                MC_timer_start(&thread->timer);
    213a:	fec42783          	lw	a5,-20(s0)
    213e:	02878793          	addi	a5,a5,40
    2142:	853e                	mv	a0,a5
    2144:	837ff0ef          	jal	ra,197a <MC_timer_start>
        MC_scheduler_begin();
    2148:	eb7fe0ef          	jal	ra,ffe <MC_scheduler_begin>
        goto START;
    214c:	bfb5                	j	20c8 <_MC_sem_take+0x10>
}
    214e:	853e                	mv	a0,a5
    2150:	50b2                	lw	ra,44(sp)
    2152:	5422                	lw	s0,40(sp)
    2154:	6145                	addi	sp,sp,48
    2156:	8082                	ret

00002158 <MC_sem_take>:

/**
 * 获取信号量
*/
uint8_t MC_sem_take(MC_sem_t sem, uint32_t timeout)
{
    2158:	1101                	addi	sp,sp,-32
    215a:	ce06                	sw	ra,28(sp)
    215c:	cc22                	sw	s0,24(sp)
    215e:	1000                	addi	s0,sp,32
    2160:	fea42623          	sw	a0,-20(s0)
    2164:	feb42423          	sw	a1,-24(s0)
    return _MC_sem_take(sem, timeout);
    2168:	fe842583          	lw	a1,-24(s0)
    216c:	fec42503          	lw	a0,-20(s0)
    2170:	37a1                	jal	20b8 <_MC_sem_take>
    2172:	87aa                	mv	a5,a0
}
    2174:	853e                	mv	a0,a5
    2176:	40f2                	lw	ra,28(sp)
    2178:	4462                	lw	s0,24(sp)
    217a:	6105                	addi	sp,sp,32
    217c:	8082                	ret

0000217e <MC_sem_release>:

/**
 * 释放信号量，并判断有无线程挂起
*/
uint8_t MC_sem_release(MC_sem_t sem)
{
    217e:	7179                	addi	sp,sp,-48
    2180:	d606                	sw	ra,44(sp)
    2182:	d422                	sw	s0,40(sp)
    2184:	1800                	addi	s0,sp,48
    2186:	fca42e23          	sw	a0,-36(s0)
    uint8_t need_schedule = 0;
    218a:	fe0407a3          	sb	zero,-17(s0)
    if(!MC_suspendList_isEmpty(&sem->suspend_thread))
    218e:	fdc42783          	lw	a5,-36(s0)
    2192:	07e1                	addi	a5,a5,24
    2194:	853e                	mv	a0,a5
    2196:	2499                	jal	23dc <MC_suspendList_isEmpty>
    2198:	87aa                	mv	a5,a0
    219a:	e795                	bnez	a5,21c6 <MC_sem_release+0x48>
    {
        sem->value ++;
    219c:	fdc42783          	lw	a5,-36(s0)
    21a0:	0207d783          	lhu	a5,32(a5)
    21a4:	0785                	addi	a5,a5,1
    21a6:	01079713          	slli	a4,a5,0x10
    21aa:	8341                	srli	a4,a4,0x10
    21ac:	fdc42783          	lw	a5,-36(s0)
    21b0:	02e79023          	sh	a4,32(a5)
        MC_suspend_list_dequeue(&sem->suspend_thread);
    21b4:	fdc42783          	lw	a5,-36(s0)
    21b8:	07e1                	addi	a5,a5,24
    21ba:	853e                	mv	a0,a5
    21bc:	22e9                	jal	2386 <MC_suspend_list_dequeue>
        need_schedule = 1;
    21be:	4785                	li	a5,1
    21c0:	fef407a3          	sb	a5,-17(s0)
    21c4:	a815                	j	21f8 <MC_sem_release+0x7a>
    }
    else
    {
        if(sem->value < sem->max_value)
    21c6:	fdc42783          	lw	a5,-36(s0)
    21ca:	0207d703          	lhu	a4,32(a5)
    21ce:	fdc42783          	lw	a5,-36(s0)
    21d2:	0227d783          	lhu	a5,34(a5)
    21d6:	00f77f63          	bgeu	a4,a5,21f4 <MC_sem_release+0x76>
        {
            sem->value ++;
    21da:	fdc42783          	lw	a5,-36(s0)
    21de:	0207d783          	lhu	a5,32(a5)
    21e2:	0785                	addi	a5,a5,1
    21e4:	01079713          	slli	a4,a5,0x10
    21e8:	8341                	srli	a4,a4,0x10
    21ea:	fdc42783          	lw	a5,-36(s0)
    21ee:	02e79023          	sh	a4,32(a5)
    21f2:	a019                	j	21f8 <MC_sem_release+0x7a>
        }
        else
        {
            return 1;
    21f4:	4785                	li	a5,1
    21f6:	a809                	j	2208 <MC_sem_release+0x8a>
        }
    }

    if(need_schedule == 1)
    21f8:	fef44703          	lbu	a4,-17(s0)
    21fc:	4785                	li	a5,1
    21fe:	00f71463          	bne	a4,a5,2206 <MC_sem_release+0x88>
    {
        MC_scheduler_begin();
    2202:	dfdfe0ef          	jal	ra,ffe <MC_scheduler_begin>
    }

    return 0;
    2206:	4781                	li	a5,0
}
    2208:	853e                	mv	a0,a5
    220a:	50b2                	lw	ra,44(sp)
    220c:	5422                	lw	s0,40(sp)
    220e:	6145                	addi	sp,sp,48
    2210:	8082                	ret

00002212 <MC_suspend_list_enqueue>:

/**
 * 线程加入挂起队列
*/
uint8_t MC_suspend_list_enqueue(MC_list_t suspend_list, MC_thread_t thread, uint8_t flag)
{
    2212:	7179                	addi	sp,sp,-48
    2214:	d622                	sw	s0,44(sp)
    2216:	1800                	addi	s0,sp,48
    2218:	fca42e23          	sw	a0,-36(s0)
    221c:	fcb42c23          	sw	a1,-40(s0)
    2220:	87b2                	mv	a5,a2
    2222:	fcf40ba3          	sb	a5,-41(s0)
    MC_list_t listIterator = suspend_list;
    2226:	fdc42783          	lw	a5,-36(s0)
    222a:	fef42623          	sw	a5,-20(s0)
    MC_list_t listOperator;
    if(flag == MC_IPC_FLAG_FIFO)
    222e:	fd744703          	lbu	a4,-41(s0)
    2232:	4785                	li	a5,1
    2234:	02f71d63          	bne	a4,a5,226e <MC_suspend_list_enqueue+0x5c>
    {
        while(listIterator->next != NULL)
    2238:	a031                	j	2244 <MC_suspend_list_enqueue+0x32>
        {
            listIterator = listIterator->next;
    223a:	fec42783          	lw	a5,-20(s0)
    223e:	43dc                	lw	a5,4(a5)
    2240:	fef42623          	sw	a5,-20(s0)
        while(listIterator->next != NULL)
    2244:	fec42783          	lw	a5,-20(s0)
    2248:	43dc                	lw	a5,4(a5)
    224a:	fbe5                	bnez	a5,223a <MC_suspend_list_enqueue+0x28>
        }
        listIterator->next = &thread->node;
    224c:	fd842783          	lw	a5,-40(s0)
    2250:	05878713          	addi	a4,a5,88
    2254:	fec42783          	lw	a5,-20(s0)
    2258:	c3d8                	sw	a4,4(a5)
        thread->node.prev = listIterator;
    225a:	fd842783          	lw	a5,-40(s0)
    225e:	fec42703          	lw	a4,-20(s0)
    2262:	cfb8                	sw	a4,88(a5)
        thread->node.next = NULL;   
    2264:	fd842783          	lw	a5,-40(s0)
    2268:	0407ae23          	sw	zero,92(a5)
    226c:	a855                	j	2320 <MC_suspend_list_enqueue+0x10e>
    }
    else if(flag == MC_IPC_FLAG_PRIO)
    226e:	fd744783          	lbu	a5,-41(s0)
    2272:	e7dd                	bnez	a5,2320 <MC_suspend_list_enqueue+0x10e>
    {
        MC_thread_t now_thread;
        while(listIterator->next != NULL)
    2274:	a815                	j	22a8 <MC_suspend_list_enqueue+0x96>
        {
            listIterator = listIterator->next;
    2276:	fec42783          	lw	a5,-20(s0)
    227a:	43dc                	lw	a5,4(a5)
    227c:	fef42623          	sw	a5,-20(s0)

            listOperator = listIterator;
    2280:	fec42783          	lw	a5,-20(s0)
    2284:	fef42423          	sw	a5,-24(s0)
            now_thread = MC_container_of(listOperator, struct MC_thread, node);
    2288:	fe842783          	lw	a5,-24(s0)
    228c:	fa878793          	addi	a5,a5,-88
    2290:	fef42223          	sw	a5,-28(s0)
            if(now_thread->priority < thread->priority)
    2294:	fe442783          	lw	a5,-28(s0)
    2298:	0247c703          	lbu	a4,36(a5)
    229c:	fd842783          	lw	a5,-40(s0)
    22a0:	0247c783          	lbu	a5,36(a5)
    22a4:	00f76763          	bltu	a4,a5,22b2 <MC_suspend_list_enqueue+0xa0>
        while(listIterator->next != NULL)
    22a8:	fec42783          	lw	a5,-20(s0)
    22ac:	43dc                	lw	a5,4(a5)
    22ae:	f7e1                	bnez	a5,2276 <MC_suspend_list_enqueue+0x64>
    22b0:	a011                	j	22b4 <MC_suspend_list_enqueue+0xa2>
            {
                break;
    22b2:	0001                	nop
            }
        }

        if(listIterator == suspend_list)
    22b4:	fec42703          	lw	a4,-20(s0)
    22b8:	fdc42783          	lw	a5,-36(s0)
    22bc:	02f71463          	bne	a4,a5,22e4 <MC_suspend_list_enqueue+0xd2>
        {
            listIterator->next = &thread->node;
    22c0:	fd842783          	lw	a5,-40(s0)
    22c4:	05878713          	addi	a4,a5,88
    22c8:	fec42783          	lw	a5,-20(s0)
    22cc:	c3d8                	sw	a4,4(a5)
            thread->node.prev = listIterator;
    22ce:	fd842783          	lw	a5,-40(s0)
    22d2:	fec42703          	lw	a4,-20(s0)
    22d6:	cfb8                	sw	a4,88(a5)
            thread->node.next = NULL;  
    22d8:	fd842783          	lw	a5,-40(s0)
    22dc:	0407ae23          	sw	zero,92(a5)
            return 0;
    22e0:	4781                	li	a5,0
    22e2:	a081                	j	2322 <MC_suspend_list_enqueue+0x110>
        }

        listOperator = listIterator->prev;
    22e4:	fec42783          	lw	a5,-20(s0)
    22e8:	439c                	lw	a5,0(a5)
    22ea:	fef42423          	sw	a5,-24(s0)
        thread->node.prev = listOperator;
    22ee:	fd842783          	lw	a5,-40(s0)
    22f2:	fe842703          	lw	a4,-24(s0)
    22f6:	cfb8                	sw	a4,88(a5)
        thread->node.next = listIterator;
    22f8:	fd842783          	lw	a5,-40(s0)
    22fc:	fec42703          	lw	a4,-20(s0)
    2300:	cff8                	sw	a4,92(a5)
        listOperator->next = &thread->node;
    2302:	fd842783          	lw	a5,-40(s0)
    2306:	05878713          	addi	a4,a5,88
    230a:	fe842783          	lw	a5,-24(s0)
    230e:	c3d8                	sw	a4,4(a5)
        thread->node.next->prev = &thread->node;
    2310:	fd842783          	lw	a5,-40(s0)
    2314:	4ffc                	lw	a5,92(a5)
    2316:	fd842703          	lw	a4,-40(s0)
    231a:	05870713          	addi	a4,a4,88
    231e:	c398                	sw	a4,0(a5)
    }
    return 0;
    2320:	4781                	li	a5,0
}
    2322:	853e                	mv	a0,a5
    2324:	5432                	lw	s0,44(sp)
    2326:	6145                	addi	sp,sp,48
    2328:	8082                	ret

0000232a <MC_suspend_list_dequeue_timeout>:
/**
 * 当等待时间结束，把线程从挂起队列中移除，加入就绪队列
 * 并发起一次调度
*/
uint8_t MC_suspend_list_dequeue_timeout(MC_thread_t thread)
{
    232a:	7179                	addi	sp,sp,-48
    232c:	d606                	sw	ra,44(sp)
    232e:	d422                	sw	s0,40(sp)
    2330:	1800                	addi	s0,sp,48
    2332:	fca42e23          	sw	a0,-36(s0)
    MC_list_t node = &thread->node;
    2336:	fdc42783          	lw	a5,-36(s0)
    233a:	05878793          	addi	a5,a5,88
    233e:	fef42623          	sw	a5,-20(s0)

    //node在某个挂起队列里则执行移除操作
    if(node->prev != NULL)
    2342:	fec42783          	lw	a5,-20(s0)
    2346:	439c                	lw	a5,0(a5)
    2348:	c39d                	beqz	a5,236e <MC_suspend_list_dequeue_timeout+0x44>
    {
        node->prev->next = node->next;
    234a:	fec42783          	lw	a5,-20(s0)
    234e:	439c                	lw	a5,0(a5)
    2350:	fec42703          	lw	a4,-20(s0)
    2354:	4358                	lw	a4,4(a4)
    2356:	c3d8                	sw	a4,4(a5)
        if(node->next != NULL)
    2358:	fec42783          	lw	a5,-20(s0)
    235c:	43dc                	lw	a5,4(a5)
    235e:	cb81                	beqz	a5,236e <MC_suspend_list_dequeue_timeout+0x44>
        {
            node->next->prev = node->prev;
    2360:	fec42783          	lw	a5,-20(s0)
    2364:	43dc                	lw	a5,4(a5)
    2366:	fec42703          	lw	a4,-20(s0)
    236a:	4318                	lw	a4,0(a4)
    236c:	c398                	sw	a4,0(a5)
        }
    }
    
    MC_thread_to_ready_list(thread);
    236e:	fdc42503          	lw	a0,-36(s0)
    2372:	8b6ff0ef          	jal	ra,1428 <MC_thread_to_ready_list>
    MC_scheduler_begin();
    2376:	c89fe0ef          	jal	ra,ffe <MC_scheduler_begin>
    return 0;
    237a:	4781                	li	a5,0
}
    237c:	853e                	mv	a0,a5
    237e:	50b2                	lw	ra,44(sp)
    2380:	5422                	lw	s0,40(sp)
    2382:	6145                	addi	sp,sp,48
    2384:	8082                	ret

00002386 <MC_suspend_list_dequeue>:

/**
 * 把挂起队列中的第一个线程移动到就绪队列中
 */
uint8_t MC_suspend_list_dequeue(MC_list_t suspend_list)
{
    2386:	7179                	addi	sp,sp,-48
    2388:	d606                	sw	ra,44(sp)
    238a:	d422                	sw	s0,40(sp)
    238c:	1800                	addi	s0,sp,48
    238e:	fca42e23          	sw	a0,-36(s0)
    MC_list_t node = suspend_list->next;
    2392:	fdc42783          	lw	a5,-36(s0)
    2396:	43dc                	lw	a5,4(a5)
    2398:	fef42623          	sw	a5,-20(s0)
    MC_thread_t thread;

    thread = MC_container_of(node, struct MC_thread, node);
    239c:	fec42783          	lw	a5,-20(s0)
    23a0:	fa878793          	addi	a5,a5,-88
    23a4:	fef42423          	sw	a5,-24(s0)
    
    suspend_list->next = node->next;
    23a8:	fec42783          	lw	a5,-20(s0)
    23ac:	43d8                	lw	a4,4(a5)
    23ae:	fdc42783          	lw	a5,-36(s0)
    23b2:	c3d8                	sw	a4,4(a5)
    if(node->next != NULL)
    23b4:	fec42783          	lw	a5,-20(s0)
    23b8:	43dc                	lw	a5,4(a5)
    23ba:	c799                	beqz	a5,23c8 <MC_suspend_list_dequeue+0x42>
    {
        node->next->prev = suspend_list;
    23bc:	fec42783          	lw	a5,-20(s0)
    23c0:	43dc                	lw	a5,4(a5)
    23c2:	fdc42703          	lw	a4,-36(s0)
    23c6:	c398                	sw	a4,0(a5)
    }

    MC_thread_to_ready_list(thread);
    23c8:	fe842503          	lw	a0,-24(s0)
    23cc:	85cff0ef          	jal	ra,1428 <MC_thread_to_ready_list>
    return 0;
    23d0:	4781                	li	a5,0
}
    23d2:	853e                	mv	a0,a5
    23d4:	50b2                	lw	ra,44(sp)
    23d6:	5422                	lw	s0,40(sp)
    23d8:	6145                	addi	sp,sp,48
    23da:	8082                	ret

000023dc <MC_suspendList_isEmpty>:

/**
 * 判断挂起队列是否为空
*/
uint8_t MC_suspendList_isEmpty(MC_list_t suspend_list)
{
    23dc:	1101                	addi	sp,sp,-32
    23de:	ce22                	sw	s0,28(sp)
    23e0:	1000                	addi	s0,sp,32
    23e2:	fea42623          	sw	a0,-20(s0)
    if(suspend_list->next == NULL)
    23e6:	fec42783          	lw	a5,-20(s0)
    23ea:	43dc                	lw	a5,4(a5)
    23ec:	e399                	bnez	a5,23f2 <MC_suspendList_isEmpty+0x16>
    {
        return 1;
    23ee:	4785                	li	a5,1
    23f0:	a011                	j	23f4 <MC_suspendList_isEmpty+0x18>
    }
    return 0;
    23f2:	4781                	li	a5,0
}
    23f4:	853e                	mv	a0,a5
    23f6:	4472                	lw	s0,28(sp)
    23f8:	6105                	addi	sp,sp,32
    23fa:	8082                	ret

000023fc <delay_ms>:
/**
 * 空转延时
 * 单位毫秒
*/
void delay_ms(uint32_t nms)
{
    23fc:	7179                	addi	sp,sp,-48
    23fe:	d606                	sw	ra,44(sp)
    2400:	d422                	sw	s0,40(sp)
    2402:	1800                	addi	s0,sp,48
    2404:	fca42e23          	sw	a0,-36(s0)
    uint32_t time = nms + MC_get_tick();
    2408:	811ff0ef          	jal	ra,1c18 <MC_get_tick>
    240c:	872a                	mv	a4,a0
    240e:	fdc42783          	lw	a5,-36(s0)
    2412:	97ba                	add	a5,a5,a4
    2414:	fef42623          	sw	a5,-20(s0)
    while(time > MC_get_tick())
    2418:	a011                	j	241c <delay_ms+0x20>
    {
        continue;
    241a:	0001                	nop
    while(time > MC_get_tick())
    241c:	ffcff0ef          	jal	ra,1c18 <MC_get_tick>
    2420:	872a                	mv	a4,a0
    2422:	fec42783          	lw	a5,-20(s0)
    2426:	fef76ae3          	bltu	a4,a5,241a <delay_ms+0x1e>
    }
    return ;
    242a:	0001                	nop
}
    242c:	50b2                	lw	ra,44(sp)
    242e:	5422                	lw	s0,40(sp)
    2430:	6145                	addi	sp,sp,48
    2432:	8082                	ret

00002434 <MC_delay>:
/**
 * 挂起延时
 * 单位毫秒
*/
void MC_delay(uint32_t nms)
{
    2434:	7179                	addi	sp,sp,-48
    2436:	d606                	sw	ra,44(sp)
    2438:	d422                	sw	s0,40(sp)
    243a:	1800                	addi	s0,sp,48
    243c:	fca42e23          	sw	a0,-36(s0)
    MC_thread_t thread = MC_thread_self();
    2440:	fd1fe0ef          	jal	ra,1410 <MC_thread_self>
    2444:	fea42623          	sw	a0,-20(s0)
    MC_thread_to_suspend_list(thread, NULL, NULL);
    2448:	4601                	li	a2,0
    244a:	4581                	li	a1,0
    244c:	fec42503          	lw	a0,-20(s0)
    2450:	890ff0ef          	jal	ra,14e0 <MC_thread_to_suspend_list>

    MC_timer_control(&thread->timer, MC_TIMER_CTRL_SET_TIME, &nms);
    2454:	fec42783          	lw	a5,-20(s0)
    2458:	02878793          	addi	a5,a5,40
    245c:	fdc40713          	addi	a4,s0,-36
    2460:	863a                	mv	a2,a4
    2462:	4581                	li	a1,0
    2464:	853e                	mv	a0,a5
    2466:	ca6ff0ef          	jal	ra,190c <MC_timer_control>
    MC_timer_start(&thread->timer);
    246a:	fec42783          	lw	a5,-20(s0)
    246e:	02878793          	addi	a5,a5,40
    2472:	853e                	mv	a0,a5
    2474:	d06ff0ef          	jal	ra,197a <MC_timer_start>

    MC_scheduler_begin();
    2478:	b87fe0ef          	jal	ra,ffe <MC_scheduler_begin>
    247c:	0001                	nop
    247e:	50b2                	lw	ra,44(sp)
    2480:	5422                	lw	s0,40(sp)
    2482:	6145                	addi	sp,sp,48
    2484:	8082                	ret

00002486 <_spinlock_init>:
#include "os.h"
#include <stdatomic.h>

void _spinlock_init(MC_spinlock_t spinlock, char *name)
{
    2486:	7179                	addi	sp,sp,-48
    2488:	d606                	sw	ra,44(sp)
    248a:	d422                	sw	s0,40(sp)
    248c:	1800                	addi	s0,sp,48
    248e:	fca42e23          	sw	a0,-36(s0)
    2492:	fcb42c23          	sw	a1,-40(s0)
    int len = MC_strlen(name);
    2496:	fd842503          	lw	a0,-40(s0)
    249a:	a30ff0ef          	jal	ra,16ca <MC_strlen>
    249e:	87aa                	mv	a5,a0
    24a0:	fef42623          	sw	a5,-20(s0)
    MC_memcpy(spinlock->name, name, len);
    24a4:	fdc42783          	lw	a5,-36(s0)
    24a8:	fec42603          	lw	a2,-20(s0)
    24ac:	fd842583          	lw	a1,-40(s0)
    24b0:	853e                	mv	a0,a5
    24b2:	9a0ff0ef          	jal	ra,1652 <MC_memcpy>

    spinlock->attribute = MC_IPCATTR_LOCK;
    24b6:	fdc42783          	lw	a5,-36(s0)
    24ba:	4705                	li	a4,1
    24bc:	02e78023          	sb	a4,32(a5)
    spinlock->holdThread = NULL;
    24c0:	fdc42783          	lw	a5,-36(s0)
    24c4:	0207a223          	sw	zero,36(a5)

    // 使用atomic_flag_test_and_set原子操作，值为0表示锁空闲
    spinlock->lock = 0;
    24c8:	fdc42783          	lw	a5,-36(s0)
    24cc:	00078a23          	sb	zero,20(a5)
    spinlock->suspend_thread.next = NULL;
    24d0:	fdc42783          	lw	a5,-36(s0)
    24d4:	0007ae23          	sw	zero,28(a5)
    spinlock->suspend_thread.prev = NULL;
    24d8:	fdc42783          	lw	a5,-36(s0)
    24dc:	0007ac23          	sw	zero,24(a5)

    return;
    24e0:	0001                	nop
}
    24e2:	50b2                	lw	ra,44(sp)
    24e4:	5422                	lw	s0,40(sp)
    24e6:	6145                	addi	sp,sp,48
    24e8:	8082                	ret

000024ea <MC_spinlock_create>:

MC_spinlock_t MC_spinlock_create(char *name)
{
    24ea:	7179                	addi	sp,sp,-48
    24ec:	d606                	sw	ra,44(sp)
    24ee:	d422                	sw	s0,40(sp)
    24f0:	1800                	addi	s0,sp,48
    24f2:	fca42e23          	sw	a0,-36(s0)
    MC_spinlock_t spinlock;

    spinlock = MC_PageMalloc(sizeof(struct MC_spinlock));
    24f6:	02800513          	li	a0,40
    24fa:	958fe0ef          	jal	ra,652 <MC_PageMalloc>
    24fe:	fea42623          	sw	a0,-20(s0)
    
    if(spinlock == NULL)
    2502:	fec42783          	lw	a5,-20(s0)
    2506:	e399                	bnez	a5,250c <MC_spinlock_create+0x22>
    {
        return NULL;
    2508:	4781                	li	a5,0
    250a:	a801                	j	251a <MC_spinlock_create+0x30>
    }

    _spinlock_init(spinlock, name);
    250c:	fdc42583          	lw	a1,-36(s0)
    2510:	fec42503          	lw	a0,-20(s0)
    2514:	3f8d                	jal	2486 <_spinlock_init>
    return spinlock;
    2516:	fec42783          	lw	a5,-20(s0)
}
    251a:	853e                	mv	a0,a5
    251c:	50b2                	lw	ra,44(sp)
    251e:	5422                	lw	s0,40(sp)
    2520:	6145                	addi	sp,sp,48
    2522:	8082                	ret

00002524 <MC_spinlock_delete>:

uint8_t MC_spinlock_delete(MC_spinlock_t spinlock)
{
    2524:	1101                	addi	sp,sp,-32
    2526:	ce06                	sw	ra,28(sp)
    2528:	cc22                	sw	s0,24(sp)
    252a:	1000                	addi	s0,sp,32
    252c:	fea42623          	sw	a0,-20(s0)
    if(spinlock->lock == 1)
    2530:	fec42783          	lw	a5,-20(s0)
    2534:	0147c703          	lbu	a4,20(a5)
    2538:	4785                	li	a5,1
    253a:	00f71463          	bne	a4,a5,2542 <MC_spinlock_delete+0x1e>
    {
        // 有线程持有锁,不能释放
        return 1;
    253e:	4785                	li	a5,1
    2540:	a031                	j	254c <MC_spinlock_delete+0x28>
    }

    MC_PageFree(spinlock);
    2542:	fec42503          	lw	a0,-20(s0)
    2546:	b74fe0ef          	jal	ra,8ba <MC_PageFree>

    return 0;
    254a:	4781                	li	a5,0
}
    254c:	853e                	mv	a0,a5
    254e:	40f2                	lw	ra,28(sp)
    2550:	4462                	lw	s0,24(sp)
    2552:	6105                	addi	sp,sp,32
    2554:	8082                	ret

00002556 <MC_spinlock_take>:

// 自旋锁，直接把线程挂起
uint8_t MC_spinlock_take(MC_spinlock_t spinlock)
{
    2556:	7179                	addi	sp,sp,-48
    2558:	d606                	sw	ra,44(sp)
    255a:	d422                	sw	s0,40(sp)
    255c:	1800                	addi	s0,sp,48
    255e:	fca42e23          	sw	a0,-36(s0)
    MC_thread_t nowThread = MC_thread_self();
    2562:	eaffe0ef          	jal	ra,1410 <MC_thread_self>
    2566:	fea42423          	sw	a0,-24(s0)
    MC_thread_t holdThread = spinlock->holdThread;
    256a:	fdc42783          	lw	a5,-36(s0)
    256e:	53dc                	lw	a5,36(a5)
    2570:	fef42223          	sw	a5,-28(s0)
    uint8_t flag = 0;
    2574:	fe0407a3          	sb	zero,-17(s0)
    // 如果读时值为1，表示锁被其他线程持有
    while(atomic_flag_test_and_set(&spinlock->lock))
    2578:	a0bd                	j	25e6 <MC_spinlock_take+0x90>
    {
        if(flag == 0)
    257a:	fef44783          	lbu	a5,-17(s0)
    257e:	e7a5                	bnez	a5,25e6 <MC_spinlock_take+0x90>
        {
            flag = 1;
    2580:	4785                	li	a5,1
    2582:	fef407a3          	sb	a5,-17(s0)
            if(holdThread->inheritPriority < nowThread->inheritPriority)
    2586:	fe442783          	lw	a5,-28(s0)
    258a:	0257c703          	lbu	a4,37(a5)
    258e:	fe842783          	lw	a5,-24(s0)
    2592:	0257c783          	lbu	a5,37(a5)
    2596:	04f77863          	bgeu	a4,a5,25e6 <MC_spinlock_take+0x90>
            {
                // 关中断,保护临界区
                __DISENABLE_INTERRUPT__();
    259a:	9bcff0ef          	jal	ra,1756 <__DISENABLE_INTERRUPT__>
                holdThread->inheritPriority = nowThread->inheritPriority;
    259e:	fe842783          	lw	a5,-24(s0)
    25a2:	0257c703          	lbu	a4,37(a5)
    25a6:	fe442783          	lw	a5,-28(s0)
    25aa:	02e782a3          	sb	a4,37(a5)
                // 把线程从原始优先级队列中移除
                MC_scheduler_remove_thread(holdThread);
    25ae:	fe442503          	lw	a0,-28(s0)
    25b2:	abbfe0ef          	jal	ra,106c <MC_scheduler_remove_thread>
                // 把线程加入继承优先级就绪队列
                MC_thread_to_ready_list(holdThread);
    25b6:	fe442503          	lw	a0,-28(s0)
    25ba:	e6ffe0ef          	jal	ra,1428 <MC_thread_to_ready_list>
                printf("thread:%s priority from %d to %d!\r\n", holdThread->name, holdThread->priority, holdThread->inheritPriority);
    25be:	fe442703          	lw	a4,-28(s0)
    25c2:	fe442783          	lw	a5,-28(s0)
    25c6:	0247c783          	lbu	a5,36(a5)
    25ca:	863e                	mv	a2,a5
    25cc:	fe442783          	lw	a5,-28(s0)
    25d0:	0257c783          	lbu	a5,37(a5)
    25d4:	86be                	mv	a3,a5
    25d6:	85ba                	mv	a1,a4
    25d8:	6789                	lui	a5,0x2
    25da:	7e878513          	addi	a0,a5,2024 # 27e8 <STACK_END+0x128>
    25de:	fcafe0ef          	jal	ra,da8 <printf>
                // 开中断
                __ENABLE_INTERRUPT__();
    25e2:	990ff0ef          	jal	ra,1772 <__ENABLE_INTERRUPT__>
    while(atomic_flag_test_and_set(&spinlock->lock))
    25e6:	fdc42783          	lw	a5,-36(s0)
    25ea:	07d1                	addi	a5,a5,20
    25ec:	ffc7f713          	andi	a4,a5,-4
    25f0:	8b8d                	andi	a5,a5,3
    25f2:	4685                	li	a3,1
    25f4:	078e                	slli	a5,a5,0x3
    25f6:	00f69633          	sll	a2,a3,a5
    25fa:	0f50000f          	fence	iorw,ow
    25fe:	44c726af          	amoor.w.aq	a3,a2,(a4)
    2602:	00f6d7b3          	srl	a5,a3,a5
    2606:	0ff7f793          	andi	a5,a5,255
    260a:	fba5                	bnez	a5,257a <MC_spinlock_take+0x24>
            }
            
        }
    }
    spinlock->holdThread = nowThread;
    260c:	fdc42783          	lw	a5,-36(s0)
    2610:	fe842703          	lw	a4,-24(s0)
    2614:	d3d8                	sw	a4,36(a5)
    return 0;
    2616:	4781                	li	a5,0
}
    2618:	853e                	mv	a0,a5
    261a:	50b2                	lw	ra,44(sp)
    261c:	5422                	lw	s0,40(sp)
    261e:	6145                	addi	sp,sp,48
    2620:	8082                	ret

00002622 <MC_spinlock_release>:

//释放自旋锁
uint8_t MC_spinlock_release(MC_spinlock_t spinlock)
{
    2622:	7179                	addi	sp,sp,-48
    2624:	d606                	sw	ra,44(sp)
    2626:	d422                	sw	s0,40(sp)
    2628:	1800                	addi	s0,sp,48
    262a:	fca42e23          	sw	a0,-36(s0)
    MC_thread_t holdThread = spinlock->holdThread;
    262e:	fdc42783          	lw	a5,-36(s0)
    2632:	53dc                	lw	a5,36(a5)
    2634:	fef42623          	sw	a5,-20(s0)
    atomic_flag_clear(&spinlock->lock);
    2638:	fdc42783          	lw	a5,-36(s0)
    263c:	07d1                	addi	a5,a5,20
    263e:	0ff0000f          	fence
    2642:	00078023          	sb	zero,0(a5)
    2646:	0ff0000f          	fence

    // 恢复持锁线程原始优先级
    if(holdThread->inheritPriority != holdThread->priority)
    264a:	fec42783          	lw	a5,-20(s0)
    264e:	0257c703          	lbu	a4,37(a5)
    2652:	fec42783          	lw	a5,-20(s0)
    2656:	0247c783          	lbu	a5,36(a5)
    265a:	02f70663          	beq	a4,a5,2686 <MC_spinlock_release+0x64>
    {
        // 关中断,保护临界区
        __DISENABLE_INTERRUPT__();
    265e:	8f8ff0ef          	jal	ra,1756 <__DISENABLE_INTERRUPT__>
        holdThread->inheritPriority = holdThread->priority;
    2662:	fec42783          	lw	a5,-20(s0)
    2666:	0247c703          	lbu	a4,36(a5)
    266a:	fec42783          	lw	a5,-20(s0)
    266e:	02e782a3          	sb	a4,37(a5)
        // 把线程从继承优先级队列中移除
        MC_scheduler_remove_thread(holdThread);
    2672:	fec42503          	lw	a0,-20(s0)
    2676:	9f7fe0ef          	jal	ra,106c <MC_scheduler_remove_thread>
        // 把线程加入原始优先级就绪队列
        MC_thread_to_ready_list(holdThread);
    267a:	fec42503          	lw	a0,-20(s0)
    267e:	dabfe0ef          	jal	ra,1428 <MC_thread_to_ready_list>
        // 开中断
        __ENABLE_INTERRUPT__();
    2682:	8f0ff0ef          	jal	ra,1772 <__ENABLE_INTERRUPT__>
    }
    return 0;
    2686:	4781                	li	a5,0
    2688:	853e                	mv	a0,a5
    268a:	50b2                	lw	ra,44(sp)
    268c:	5422                	lw	s0,40(sp)
    268e:	6145                	addi	sp,sp,48
    2690:	8082                	ret
