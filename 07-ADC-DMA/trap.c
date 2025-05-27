#include "os.h"
extern void trap_handler_base();

void __DISENABLE_INTERRUPT__()
{
    w_mstatus(r_mstatus() & ~(1 << 3)); // 全局中断关闭
}

void __ENABLE_INTERRUPT__()
{
    w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
}

void MC_trap_init()
{
    ptr_t base = (ptr_t)trap_handler_base;
    uint32_t mtvec = 0x00000001;
    mtvec |= (base);
    w_mtvec(mtvec);

    // w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
    // 在main函数再开启全局中断
}

extern void MC_timer_handler();
void MC_mtip_handler()
{
    MC_timer_handler();
}

extern uint8_t MC_schedule_flag;
void MC_software_handler()
{
    if(MC_schedule_flag)
    {
        MC_schedule_flag = 0;
        MC_schedule();
    }

    MC_pfic_pending_clear(SOFTWARE_IRQ);
}