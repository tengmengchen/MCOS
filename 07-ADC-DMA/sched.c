#include "os.h"

extern struct MC_list Ready_threadList_Start[64], Ready_threadList_End[64];
extern void MC_hw_context_switch(void *stack_addr);

uint8_t MC_schedule_flag = 0;
struct MC_sched MC_scheduler;

void MC_schedule()
{
    MC_thread_t from_thread = NULL, to_thread = NULL;
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
        if(Ready_threadList_Start[i].next != &Ready_threadList_End[i])
        {
            to_thread = MC_container_of(Ready_threadList_Start[i].next, struct MC_thread, node);
            Ready_threadList_Start[i].next = to_thread->node.next;
            to_thread->node.next->prev = &Ready_threadList_Start[i];

            // 把要运行的线程插入队尾
            to_thread->node.next = &Ready_threadList_End[i];
            to_thread->node.prev = Ready_threadList_End[i].prev;
            Ready_threadList_End[i].prev = &to_thread->node;
            to_thread->node.prev->next = &to_thread->node;
            
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

        to_thread->timer.timeout_tick = to_thread->timer.init_tick + MC_get_tick();
        MC_timer_list_insert(&to_thread->timer.node);
        //移除from_thread的定时器
        if(from_thread != NULL && from_thread->state == MC_THREAD_STATE_RUNNING)
        {
            MC_timer_list_remove(&from_thread->timer.node);
        }
        
        //避免线程是因为阻塞产生的调度，导致状态出错
        if(from_thread->state != NULL && from_thread->state == MC_THREAD_STATE_RUNNING)
        {
            from_thread->state = MC_THREAD_STATE_READY;
        }
        to_thread->state = MC_THREAD_STATE_RUNNING;

        MC_hw_context_switch(to_thread->stack_addr);
    }
    else
    {
        // 先移除from线程的定时器节点
        MC_timer_list_remove(&from_thread->timer.node);

        // 插入新定时器
        from_thread->timer.timeout_tick = from_thread->timer.init_tick + MC_get_tick();
        MC_timer_list_insert(&from_thread->timer.node);

        MC_hw_context_switch(from_thread->stack_addr);
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

/**
 * 把线程从所在就绪队列中移除
*/
void MC_scheduler_remove_thread(MC_thread_t thread)
{
    // 如果线程不在就绪队列中,则不操作
    if(thread->state != MC_THREAD_STATE_READY && thread->state != MC_THREAD_STATE_RUNNING)
    {
        return;
    }

    thread->node.next->prev = thread->node.prev;
    thread->node.prev->next = thread->node.next;
    thread->node.prev = thread->node.next = NULL;

    thread->state = MC_THREAD_STATE_NULL;
}
