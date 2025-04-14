#include "os.h"

const size_t extra_size_for_context = 32 * sizeof(size_t);

struct MC_thread_list Ready_threadList_Start[64], Ready_threadList_End[64];

void _thread_init(MC_thread_t thread,
                char *name,
                void (*entry)(void),
                uint8_t *stack_start,
                size_t stack_size,
                uint8_t priority,
                uint32_t tick,
                uint8_t flag)
{
    size_t name_len = MC_strlen(name);
    MC_memcpy(thread->name, name, name_len);
    thread->sp = stack_start + stack_size;
    thread->entry = entry;
    thread->stack_addr = stack_start;
    thread->stack_size = stack_size;
    thread->priority = priority;

    MC_timer_init(&thread->timer,
        name,
        NULL, 
        NULL, 
        tick, 
        MC_TIMER_FLAG_THREAD_TIMER);
}

void MC_threadList_Init()
{
    for(int i = 0; i < 64; i++)
    {
        Ready_threadList_Start[i].prev = NULL;
        Ready_threadList_Start[i].next = (MC_thread_t)&Ready_threadList_End[i];

        Ready_threadList_End[i].prev = (MC_thread_t)&Ready_threadList_Start[i];
        Ready_threadList_End[i].next = NULL;
    }
}

MC_thread_t MC_thread_create(char *name,
                            void (*entry)(void),
                            size_t stack_size,
                            uint8_t priority,
                            uint32_t tick,
                            uint8_t flag)
{
    MC_thread_t thread;
    uint8_t *stack_start;

    if(Ready_threadList_Start[0].next == NULL)
    {
        MC_threadList_Init();
    }

    thread = (MC_thread_t)MC_PageMalloc(sizeof(struct MC_thread));
    if(thread == NULL)
    {
        return NULL;
    }

    stack_size = stack_size + extra_size_for_context;
    stack_start = (uint8_t *)MC_PageMalloc(stack_size);
    if(stack_start == NULL)
    {
        return NULL;
    }

    _thread_init(thread,
                name,
                entry,
                stack_start,
                stack_size,
                priority,
                tick,
                flag);
    
    return thread;
}

uint8_t MC_thread_delete(MC_thread_t thread)
{
    thread->next->prev = thread->prev;
    thread->prev->next = thread->next;

    MC_PageFree(thread);
    MC_PageFree(thread->stack_addr);
    return 0;
}

extern struct MC_sched MC_scheduler;
/**
 * 把任务加入就绪队列
 */
uint8_t MC_thread_startup(MC_thread_t thread)
{
    uint8_t priority = thread->priority;

    *(size_t *)((uint8_t *)(thread->stack_addr) + 0) = (size_t)thread->entry;
    *(size_t *)((uint8_t *)(thread->stack_addr) + 4) = (size_t)thread->sp;
    *(size_t *)((uint8_t *)(thread->stack_addr) + 8) = (size_t)thread->entry;//应对首次调度，mepc值不确定的情况

    thread->prev = (MC_thread_t)&Ready_threadList_Start[priority];
    thread->next = Ready_threadList_Start[priority].next;

    Ready_threadList_Start[priority].next = thread;
    thread->next->prev = thread;
    return 0;
}

/**
 * 线程调度
*/
void MC_thread_yield()
{
    if(MC_scheduler.sched_state == SCHED_RUNNING)
    {
        //在软件中断中调度下一个线程
        MC_schedule_flag = 1;
        MC_pfic_pending_set(SOFTWARE_IRQ);
    }
    return;
}