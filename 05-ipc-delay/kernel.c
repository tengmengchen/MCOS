#include "os.h"

MC_thread_t os_main;

extern int main();

void start_kernel()
{
    USART1_init();

    //设置osmain的优先级
    os_main = MC_thread_create("os_main",
                            main,
                            512,
                            32,
                            100,
                            MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(os_main);

    MC_trap_init();
    MC_SysTick_init();
    
    w_mstatus(0b11 << 11);//进入main为机器模式

    
    /**
     * 因为此时还没开启中断，所以不通过
     * pendsv的形式进行上下文切换
     */
    MC_schedule(); 
    while(1)
    {
        
    }
}