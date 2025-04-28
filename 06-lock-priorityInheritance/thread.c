#include "os.h"

const size_t extra_size_for_context = 32 * sizeof(size_t);

struct MC_list Ready_threadList_Start[64], Ready_threadList_End[64];
struct MC_list Suspend_threadList;

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
    thread->inheritPriority = priority;

    MC_timer_init(&thread->timer,
        name,
        NULL, 
        NULL, 
        tick, 
        MC_TIMER_FLAG_THREAD_TIMER | flag);
}

void MC_threadList_Init()
{
    for(int i = 0; i < 64; i++)
    {
        Ready_threadList_Start[i].prev = NULL;
        Ready_threadList_Start[i].next = &Ready_threadList_End[i];

        Ready_threadList_End[i].prev = &Ready_threadList_Start[i];
        Ready_threadList_End[i].next = NULL;
    }

    Suspend_threadList.next = Suspend_threadList.prev = NULL;
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
    thread->node.next->prev = thread->node.prev;
    thread->node.prev->next = thread->node.next;

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

    thread->node.prev = &Ready_threadList_Start[priority];
    thread->node.next = Ready_threadList_Start[priority].next;

    Ready_threadList_Start[priority].next = &thread->node;
    thread->node.next->prev = &thread->node;

    thread->state = MC_THREAD_STATE_READY;
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

/**
 * 返回正在执行的线程
*/
MC_thread_t MC_thread_self(void)
{
    return MC_scheduler.running_thread;
}

/**
 * 线程从挂起队列恢复到就绪队列
*/
uint8_t MC_thread_to_ready_list(MC_thread_t thread)
{
    // 线程仍处于其他队列中，则不操作
    if(thread->node.next != NULL || thread->node.prev != NULL)
    {
        return 1;
    }
    uint8_t priority = thread->priority;

    //判断线程有无优先级反转现象
    if(thread->inheritPriority > thread->priority)
    {
        priority = thread->inheritPriority;
    }

    thread->node.prev = &Ready_threadList_Start[priority];
    thread->node.next = Ready_threadList_Start[priority].next;

    Ready_threadList_Start[priority].next = &thread->node;
    thread->node.next->prev = &thread->node;

    thread->state = MC_THREAD_STATE_READY;
    return 0;
}

/**
 * 阻塞入口函数
 * flag指示资源类型是锁还是信号量
*/
uint8_t MC_thread_to_suspend_list(MC_thread_t thread, void *MC_source, uint8_t attribute)
{
    if(attribute == MC_IPCATTR_LOCK)
    {
        MC_spinlock_t MC_Source = (MC_spinlock_t)MC_source;
        MC_thread_to_lock_suspend_list(thread, &MC_Source->suspend_thread, MC_IPC_FLAG_PRIO);
    }
    else if(attribute == MC_IPCATTR_SEM)
    {
        MC_sem_t MC_Source = (MC_sem_t) MC_source;
        MC_thread_to_sem_suspend_list(thread, &MC_Source->suspend_thread, MC_Source->flag);
    }
    else if(attribute == NULL)
    {
        //单纯把线程从就绪队列中移除
        MC_thread_to_sem_suspend_list(thread, NULL, NULL);
    }
    return 0;
}

/**
 * 阻塞线程到锁挂起队列，优先级挂起模式
 * 具备优先级继承机制
*/
uint8_t MC_thread_to_lock_suspend_list(MC_thread_t thread, MC_list_t suspend_list, uint8_t flag)
{
    MC_scheduler_remove_thread(thread);

    if(suspend_list != NULL)
    {
        MC_suspend_list_enqueue(suspend_list, thread, flag); //线程加入挂起队列

        MC_spinlock_t lock;
        lock = (MC_spinlock_t)MC_container_of(suspend_list, struct MC_spinlock, suspend_thread);
        
        //持有锁的线程优先级小于申请线程优先级，发生优先级反转
        if(lock->holdThread->priority < thread->priority)
        {
            //把持锁线程从原来的优先级队列中移除
            MC_thread_to_suspend_list(thread, NULL, NULL);

            //把持锁线程优先级提高
            lock->holdThread->inheritPriority = thread->inheritPriority;

            //把持锁线程插入新优先级就绪队列
            MC_thread_to_ready_list(thread);
        }
    }

    MC_timer_list_remove(&thread->timer.node);
    thread->state = MC_THREAD_STATE_SUSPEND;
    return 0;
}

/**
 * 阻塞线程到信号量挂起队列
 * 如果suspend_list为NULL则直接挂起，不加入队列
*/
uint8_t MC_thread_to_sem_suspend_list(MC_thread_t thread, MC_list_t suspend_list, uint8_t flag)
{
    MC_scheduler_remove_thread(thread);//把线程从就绪队列中移除

    if(suspend_list != NULL)
    {
        MC_suspend_list_enqueue(suspend_list, thread, flag);//线程加入挂起队列
    }
    MC_timer_list_remove(&thread->timer.node);//把线程定时器从定时器链表中移除

    thread->state = MC_THREAD_STATE_SUSPEND;
    return 0;
}