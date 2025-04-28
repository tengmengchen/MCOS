#include "os.h"

/**
 * 空转延时
 * 单位毫秒
*/
void delay_ms(uint32_t nms)
{
    uint32_t time = nms + MC_get_tick();
    while(time > MC_get_tick())
    {
        continue;
    }
    return ;
}

/**
 * 挂起延时
 * 单位毫秒
*/
void MC_delay(uint32_t nms)
{
    MC_thread_t thread = MC_thread_self();
    MC_thread_to_suspend_list(thread, NULL, NULL);

    MC_timer_control(&thread->timer, MC_TIMER_CTRL_SET_TIME, &nms);
    MC_timer_start(&thread->timer);

    MC_scheduler_begin();
}