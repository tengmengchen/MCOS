#include "os.h"

extern struct MC_thread_list Ready_threadList_Start[64], Ready_threadList_End[64];
extern void MC_hw_context_switch(void *stack_addr);

uint8_t MC_schedule_flag = 0;
struct MC_sched MC_scheduler;

void MC_schedule()
{
    MC_thread_t from_thread, to_thread = NULL;
    if(MC_scheduler.sched_state == SCHED_RUNNING)
    {
        from_thread = MC_scheduler.running_thread;
    }
    else
    {
        MC_scheduler.sched_state = SCHED_RUNNING;
        from_thread = NULL;
        w_mscratch(0);
    }

    for(int i = 63; i >= 0; i--)
    {
        if(Ready_threadList_Start[i].next != (MC_thread_t)&Ready_threadList_End[i])
        {
            to_thread = Ready_threadList_Start[i].next;
            Ready_threadList_Start[i].next = to_thread->next;
            to_thread->next->prev = (MC_thread_t)&Ready_threadList_Start[i];

            to_thread->next = (MC_thread_t)&Ready_threadList_End[i];
            to_thread->prev = Ready_threadList_End[i].prev;
            Ready_threadList_End[i].prev = to_thread;
            to_thread->prev->next = to_thread;

            break;
        }
    }
    
    if(to_thread == NULL)
    {
        return ;
    }

    if(from_thread != to_thread)
    {
        MC_scheduler.running_thread = to_thread;

        to_thread->timer.node.timeout_tick = to_thread->timer.node.init_tick + MC_get_tick();
        MC_timer_list_insert(&to_thread->timer.node);

        MC_hw_context_switch(to_thread->stack_addr);
    }

    return;
}

/**
 * 发起一次调度
 */
void MC_scheduler_begin()
{
    if(MC_scheduler.sched_state == SCHED_STOP)
    {
        MC_scheduler.sched_state = SCHED_RUNNING;
    }
    //在软件中断中调度下一个线程
    MC_schedule_flag = 1;
    MC_pfic_pending_set(SOFTWARE_IRQ);
    return ;
}

/**
 * 开启调度器
 */
void MC_scheduler_start()
{
    if(MC_scheduler.sched_state == SCHED_STOP)
    {
        MC_scheduler.sched_state == SCHED_RUNNING;
    }
    return ;
}

/**
 * 关闭调度器
 */
void MC_scheduler_stop()
{
    if(MC_scheduler.sched_state == SCHED_RUNNING)
    {
        MC_scheduler.sched_state == SCHED_STOP;
    }
    return ;
}
