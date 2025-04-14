#include "os.h"


void _sem_init(MC_sem_t sem, char *name, uint16_t value, uint8_t flag, uint16_t max_value)
{
    int len = MC_strlen(name);
    MC_memcpy(sem->name, name, len);

    sem->suspend_thread.next = NULL;
    sem->suspend_thread.prev = NULL;

    sem->max_value = max_value;
    sem->value = value;
    sem->flag = flag;

    // sem->spinlock.lock = 1; //锁用于多核、多进程间的互斥访问临界区，对于单核多线程不需要加锁
}

/**
 * 创建一个信号量
 * 
 * flag 指示线程挂起队列的排序方式
 * MC_IPC_FLAG_PRIO 按照优先级由高到低排列
 * MC_IPC_FLAG_FIFO 按照先进先出排列
*/
MC_sem_t MC_sem_create(char *name, uint16_t value,uint8_t flag)
{
    MC_sem_t sem;

    sem = MC_PageMalloc(sizeof(struct MC_semaphore));
    if(sem == NULL)
    {
        return NULL;
    }

    _sem_init(sem, name, value, flag, MC_IPC_SEM_MAXVALUE);

    return sem;
}

/**
 * 信号量删除
*/
uint8_t MC_sem_delete(MC_sem_t sem)
{

    return 0;
}

/**
 * 申请信号量
 */
static uint8_t _MC_sem_take(MC_sem_t sem, uint32_t timeout)
{
    MC_thread_t thread;

START:
    MC_scheduler_stop(); //关闭调度器,保证临界区的原子性
                        //单核，不设置加锁机制

    if(sem->value > 0)
    {
        sem->value --;
        MC_scheduler_start();
    }
    else
    {
        if(timeout == 0)
        {
            MC_scheduler_start();
            return 1;
        }
        else
        {
            thread = MC_thread_self();

            MC_thread_to_suspend_list(thread, &sem->suspend_thread, sem->flag);

            if(timeout > 0)
            {
                //重新设置定时器的值
                MC_timer_control(&thread->timer, MC_TIMER_CTRL_SET_TIME, &timeout);

                //启动定时器
                MC_timer_start(&thread->timer);
            }
        }
        MC_scheduler_begin();
        goto START;
    }
    return 0;
}

/**
 * 获取信号量
*/
uint8_t MC_sem_take(MC_sem_t sem, uint32_t timeout)
{
    return _MC_sem_take(sem, timeout);
}

/**
 * 释放信号量，并判断有无线程挂起
*/
uint8_t MC_sem_release(MC_sem_t sem)
{
    uint8_t need_schedule = 0;
    if(!MC_suspendList_isEmpty(&sem->suspend_thread))
    {
        sem->value ++;
        MC_suspend_list_dequeue(&sem->suspend_thread);
        need_schedule = 1;
    }
    else
    {
        if(sem->value < sem->max_value)
        {
            sem->value ++;
        }
        else
        {
            return 1;
        }
    }

    if(need_schedule == 1)
    {
        MC_scheduler_begin();
    }

    return 0;
}

/**
 * 线程加入挂起队列
*/
uint8_t MC_suspend_list_enqueue(MC_list_t suspend_list, MC_thread_t thread, uint8_t flag)
{
    MC_list_t listIterator = suspend_list;
    MC_list_t listOperator;
    if(flag == MC_IPC_FLAG_FIFO)
    {
        while(listIterator->next != NULL)
        {
            listIterator = listIterator->next;
        }
        listIterator->next = &thread->node;
        thread->node.prev = listIterator;
        thread->node.next = NULL;   
    }
    else if(flag == MC_IPC_FLAG_PRIO)
    {
        MC_thread_t now_thread;
        while(listIterator->next != NULL)
        {
            listIterator = listIterator->next;

            listOperator = listIterator;
            now_thread = MC_container_of(listOperator, struct MC_thread, node);
            if(now_thread->priority < thread->priority)
            {
                break;
            }
        }

        if(listIterator == suspend_list)
        {
            listIterator->next = &thread->node;
            thread->node.prev = listIterator;
            thread->node.next = NULL;  
            return 0;
        }

        listOperator = listIterator->prev;
        thread->node.prev = listOperator;
        thread->node.next = listIterator;
        listOperator->next = &thread->node;
        thread->node.next->prev = &thread->node;
    }
    return 0;
}

/**
 * 当等待时间结束，把线程从挂起队列中移除，加入就绪队列
*/
uint8_t MC_suspend_list_dequeue_timeout(MC_thread_t thread)
{
    MC_list_t node = &thread->node;

    //node在某个挂起队列里则执行移除操作
    if(node->prev != NULL)
    {
        node->prev->next = node->next;
        if(node->next != NULL)
        {
            node->next->prev = node->prev;
        }
    }
    
    MC_thread_to_ready_list(thread);
    return 0;
}

/**
 * 把挂起队列中的第一个线程移动到就绪队列中
 */
uint8_t MC_suspend_list_dequeue(MC_list_t suspend_list)
{
    MC_list_t node = suspend_list->next;
    MC_thread_t thread;

    thread = MC_container_of(node, struct MC_thread, node);
    
    suspend_list->next = node->next;
    if(node->next != NULL)
    {
        node->next->prev = suspend_list;
    }

    MC_thread_to_ready_list(thread);
    return 0;
}

/**
 * 判断挂起队列是否为空
*/
uint8_t MC_suspendList_isEmpty(MC_list_t suspend_list)
{
    if(suspend_list->next == NULL)
    {
        return 1;
    }
    return 0;
}

