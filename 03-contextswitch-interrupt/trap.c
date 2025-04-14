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
    w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能

    ptr_t base = (ptr_t)trap_handler_base;
    uint32_t mtvec = 0x00000001;
    mtvec |= (base);
    w_mtvec(mtvec);
}

extern void MC_timer_handler();
void MC_mtip_handler()
{
    MC_timer_handler();
}