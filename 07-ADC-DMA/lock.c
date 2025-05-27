#include "os.h"
#include <stdatomic.h>

void _spinlock_init(MC_spinlock_t spinlock, char *name)
{
    int len = MC_strlen(name);
    MC_memcpy(spinlock->name, name, len);

    spinlock->attribute = MC_IPCATTR_LOCK;
    spinlock->holdThread = NULL;

    // 使用atomic_flag_test_and_set原子操作，值为0表示锁空闲
    spinlock->lock = 0;
    spinlock->suspend_thread.next = NULL;
    spinlock->suspend_thread.prev = NULL;

    return;
}

MC_spinlock_t MC_spinlock_create(char *name)
{
    MC_spinlock_t spinlock;

    spinlock = MC_PageMalloc(sizeof(struct MC_spinlock));
    
    if(spinlock == NULL)
    {
        return NULL;
    }

    _spinlock_init(spinlock, name);
    return spinlock;
}

uint8_t MC_spinlock_delete(MC_spinlock_t spinlock)
{
    if(spinlock->lock == 1)
    {
        // 有线程持有锁,不能释放
        return 1;
    }

    MC_PageFree(spinlock);

    return 0;
}

// 自旋锁，直接把线程挂起
uint8_t MC_spinlock_take(MC_spinlock_t spinlock)
{
    MC_thread_t nowThread = MC_thread_self();
    MC_thread_t holdThread = spinlock->holdThread;
    uint8_t flag = 0;
    // 如果读时值为1，表示锁被其他线程持有
    while(atomic_flag_test_and_set(&spinlock->lock))
    {
        if(flag == 0)
        {
            flag = 1;
            if(holdThread->inheritPriority < nowThread->inheritPriority)
            {
                // 关中断,保护临界区
                __DISENABLE_INTERRUPT__();
                holdThread->inheritPriority = nowThread->inheritPriority;
                // 把线程从原始优先级队列中移除
                MC_scheduler_remove_thread(holdThread);
                // 把线程加入继承优先级就绪队列
                MC_thread_to_ready_list(holdThread);
                printf("thread:%s priority from %d to %d!\r\n", holdThread->name, holdThread->priority, holdThread->inheritPriority);
                // 开中断
                __ENABLE_INTERRUPT__();
            }
            
        }
    }
    spinlock->holdThread = nowThread;
    return 0;
}

//释放自旋锁
uint8_t MC_spinlock_release(MC_spinlock_t spinlock)
{
    MC_thread_t holdThread = spinlock->holdThread;
    atomic_flag_clear(&spinlock->lock);

    // 恢复持锁线程原始优先级
    if(holdThread->inheritPriority != holdThread->priority)
    {
        // 关中断,保护临界区
        __DISENABLE_INTERRUPT__();
        holdThread->inheritPriority = holdThread->priority;
        // 把线程从继承优先级队列中移除
        MC_scheduler_remove_thread(holdThread);
        // 把线程加入原始优先级就绪队列
        MC_thread_to_ready_list(holdThread);
        // 开中断
        __ENABLE_INTERRUPT__();
    }
    return 0;
}