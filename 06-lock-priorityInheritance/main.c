#include "os.h"

MC_thread_t thread1;
MC_thread_t thread2;
MC_thread_t thread3;

MC_spinlock_t lock;
void thread1_entry()
{
    uint8_t ret;
    printf("test_thread1_start!\r\n");
    while(1)
    {
        // printf("test_thread1 try get spinlock and wait!\r\n");
        ret = MC_spinlock_take(lock);
        if(ret == 0)
        {
            printf("H: test_thread1 get spinlock!\r\n");
        }
        MC_delay(1000);
        MC_spinlock_release(lock);
        // printf("test_thread1 release spinlock!\r\n");
        MC_delay(5000);
    }   
}

void thread2_entry()
{
    uint8_t ret;
    printf("test_thread2_start!\r\n");
    while(1)
    {
        // printf("test_thread2 try get spinlock and wait!\r\n");
        ret = MC_spinlock_take(lock);
        if(ret == 0)
        {
            printf("L: test_thread2 get spinlock! now priority: %d\r\n", thread2->inheritPriority);
        }
        MC_delay(5000);
        MC_spinlock_release(lock);
        // printf("test_thread2 release spinlock! now priority: %d\r\n", thread2->inheritPriority);
        MC_delay(10000);
    }
}

void thread3_entry()
{
    while(1)
    {
        printf("M:test_thread3_start!\r\n");
        MC_delay(100);
    }
}


int main()
{
    __ENABLE_INTERRUPT__(); // 开启全局中断

    lock = MC_spinlock_create("lock_test");

    thread1 = MC_thread_create("thread1",
                                    thread1_entry,
                                    512,
                                    63,
                                    5,
                                    MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread1);

    thread2 = MC_thread_create("thread2",
                                    thread2_entry,
                                    512,
                                    50,
                                    5,
                                    MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread2);

    thread3 = MC_thread_create("thread3",
        thread3_entry,
        512,
        60,
        5,
        MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread3);

    MC_scheduler_begin();

    uint32_t tick = 0, tmp;
    while(1){
        // MC_thread_yield();
        tmp = MC_get_tick() / 1000;
        if(tmp != tick)
        {
            tick = tmp;
            printf("main: tick:%d\r\n", tick);
        }
    }
    return 0;
}