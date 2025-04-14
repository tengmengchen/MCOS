#include "os.h"

MC_thread_t thread1;
MC_thread_t thread2;

void thread1_entry()
{
    char *s;
    while(1)
    {
        printf("test_thread1_start!\r\n");
        // MC_thread_yield();
    }
}

void thread2_entry()
{
    uint32_t tick = 0, tmp;
    
    while(1)
    {
        printf("test_thread2_start!\r\n");
        // MC_thread_yield();
    }
}

int main()
{
    __ENABLE_INTERRUPT__(); // 开启全局中断

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