#include "os.h"

MC_thread_t thread1;
MC_thread_t thread2;
MC_thread_t thread3;

MC_sem_t sem;
void thread1_entry()
{
    uint8_t ret;
    printf("test_thread1_start!\r\n");
    while(1)
    {
        ret = MC_sem_take(sem, 100);
        if(ret == 0)
        {
            printf("test_thread1 get sem!\r\n");
        }
        MC_delay(100);
    }
}

void thread2_entry()
{
    printf("test_thread2_start!\r\n");
    while(1)
    {
        MC_sem_release(sem);
        printf("test_thread2_release_sem!\r\n");
        // MC_thread_yield();
        MC_delay(500);
    }
}

void thread3_entry()
{
    uint8_t ret;
    uint32_t time = 0;
    printf("test_thread3_start!\r\n");
    while(1)
    {
        ret = MC_sem_take(sem, 100);
        if(ret == 0)
        {
            printf("test_thread3 get sem!\r\n");
        }
        MC_delay(100);
    }
}

int main()
{
    __ENABLE_INTERRUPT__(); // 开启全局中断

    sem = MC_sem_create("sem_test", 5, MC_IPC_FLAG_FIFO);

    thread1 = MC_thread_create("thread1",
                                    thread1_entry,
                                    512,
                                    63,
                                    100,
                                    MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread1);

    thread2 = MC_thread_create("thread2",
                                    thread2_entry,
                                    512,
                                    63,
                                    100,
                                    MC_TIMER_FLAG_CYCLE_TIMER);
    MC_thread_startup(thread2);

    thread3 = MC_thread_create("thread3",
                                    thread3_entry,
                                    512,
                                    63,
                                    100,
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