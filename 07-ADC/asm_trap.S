#define LOAD lw
#define STORE sw
#define SIZE_REG 4

.macro reg_save base
	# STORE ra,   0*SIZE_REG(\base) # 在最开始保存ra，避免重复保存
	STORE sp,   1*SIZE_REG(\base)
	STORE t0,   4*SIZE_REG(\base)
	STORE t1,   5*SIZE_REG(\base)
	STORE t2,   6*SIZE_REG(\base)
	STORE s0,   7*SIZE_REG(\base)
	STORE s1,   8*SIZE_REG(\base)
	STORE a0,   9*SIZE_REG(\base)
	STORE a1,  10*SIZE_REG(\base)
	STORE a2,  11*SIZE_REG(\base)
	STORE a3,  12*SIZE_REG(\base)
	STORE a4,  13*SIZE_REG(\base)
	STORE a5,  14*SIZE_REG(\base)
	STORE a6,  15*SIZE_REG(\base)
	STORE a7,  16*SIZE_REG(\base)
	STORE s2,  17*SIZE_REG(\base)
	STORE s3,  18*SIZE_REG(\base)
	STORE s4,  19*SIZE_REG(\base)
	STORE s5,  20*SIZE_REG(\base)
	STORE s6,  21*SIZE_REG(\base)
	STORE s7,  22*SIZE_REG(\base)
	STORE s8,  23*SIZE_REG(\base)
	STORE s9,  24*SIZE_REG(\base)
	STORE s10, 25*SIZE_REG(\base)
	STORE s11, 26*SIZE_REG(\base)
	STORE t3,  27*SIZE_REG(\base)
	STORE t4,  28*SIZE_REG(\base)
	STORE t5,  29*SIZE_REG(\base)
	# we don't save t6 here, due to we have used
	# it as base, we have to save t6 in an extra step
	# outside of reg_save
.endm


.macro reg_restore base
	LOAD ra,   0*SIZE_REG(\base)
	LOAD sp,   1*SIZE_REG(\base)
	LOAD t0,   4*SIZE_REG(\base)
	LOAD t1,   5*SIZE_REG(\base)
	LOAD t2,   6*SIZE_REG(\base)
	LOAD s0,   7*SIZE_REG(\base)
	LOAD s1,   8*SIZE_REG(\base)
	LOAD a0,   9*SIZE_REG(\base)
	LOAD a1,  10*SIZE_REG(\base)
	LOAD a2,  11*SIZE_REG(\base)
	LOAD a3,  12*SIZE_REG(\base)
	LOAD a4,  13*SIZE_REG(\base)
	LOAD a5,  14*SIZE_REG(\base)
	LOAD a6,  15*SIZE_REG(\base)
	LOAD a7,  16*SIZE_REG(\base)
	LOAD s2,  17*SIZE_REG(\base)
	LOAD s3,  18*SIZE_REG(\base)
	LOAD s4,  19*SIZE_REG(\base)
	LOAD s5,  20*SIZE_REG(\base)
	LOAD s6,  21*SIZE_REG(\base)
	LOAD s7,  22*SIZE_REG(\base)
	LOAD s8,  23*SIZE_REG(\base)
	LOAD s9,  24*SIZE_REG(\base)
	LOAD s10, 25*SIZE_REG(\base)
	LOAD s11, 26*SIZE_REG(\base)
	LOAD t3,  27*SIZE_REG(\base)
	LOAD t4,  28*SIZE_REG(\base)
	LOAD t5,  29*SIZE_REG(\base)
	LOAD t6,  30*SIZE_REG(\base)
.endm

.text
.global trap_handler_base
.balign 8

trap_handler_base:
    .balign 4
    j   exception_handler     /*exception entry*/
    .balign 4
    j   irq_default_handler /*1 : Reserved*/
    .balign 4
    j   irq_default_handler /*2 : Reserved*/
    .balign 4
    j   irq_default_handler /*3 : Reserved*/
    .balign 4
    j   irq_default_handler /*4 : Reserved*/
    .balign 4
    j   irq_default_handler /*5 : Reserved*/
    .balign 4
    j   irq_default_handler /*6 : Reserved*/
    .balign 4
    j   irq_default_handler /*7 : Reserved*/
    .balign 4
    j   irq_default_handler /*8 : Reserved*/
    .balign 4
    j   irq_default_handler /*9 : Reserved*/
    .balign 4
    j   irq_default_handler /*10 : Reserved*/
    .balign 4
    j   irq_default_handler /*11 : Reserved*/
    .balign 4
    j   pfic_systick_handler /*12 : Machine timer interrupt*/
	.balign 4
    j   irq_default_handler /*13 : Reserved*/
	.balign 4
    j   pfic_software_handler /*14 : Machine software interrupt*/

	/* 占位代码：跳过 19 个中断入口，每个4字节，共76字节 */
	.space 76, 0x00

    j   pfic_adc1_2_handler /*34 : ADC1_2 interrupt*/

exception_handler:
    j exception_handler

pfic_systick_handler:
    csrrw t6, mscratch, t6
	STORE ra, 0 * SIZE_REG(t6)

	jal pfic_reg_save
    jal MC_mtip_handler

    j return_from_interrupt

pfic_software_handler:
	csrrw t6, mscratch, t6
	STORE ra, 0 * SIZE_REG(t6)

	jal pfic_reg_save
    jal MC_software_handler
	
	j return_from_interrupt

pfic_adc1_2_handler:
	j irq_default_handler

irq_default_handler:
    j irq_default_handler

return_from_interrupt:
	csrr t6, mscratch

	LOAD t5, 2 * SIZE_REG(t6)
	csrw mepc, t5
    reg_restore t6
	
    mret

pfic_reg_save:
	reg_save t6

    mv t5, t6
    csrr t6, mscratch
    STORE t6, 30 * SIZE_REG(t5)

	csrr t6, mepc
	STORE t6, 2 * SIZE_REG(t5)
    csrw mscratch, t5
	ret
