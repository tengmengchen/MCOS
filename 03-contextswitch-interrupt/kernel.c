#include "os.h"
MC_thread_t thread1;
MC_thread_t thread2;

void thread1_entry()
{
    char *s;
    printf("test_thread1_start!\r\n");
    while(1)
    {
        int i = 1000;
        while(i--);

        MC_thread_yield();
    }
}

void thread2_entry()
{
    uint32_t tick = 0, tmp;
    while(1)
    {
        tmp = MC_get_tick() / 1000;
        if(tmp != tick)
        {
            tick = tmp;
            printf("tick:%d\r\n", tick);
        }
        MC_thread_yield();
    }
}

void start_kernel()
{
    USART1_init();

    MC_trap_init();

    MC_timer_init();

    thread1 = MC_thread_create("thread1",
                                    thread1_entry,
                                    256,
                                    63,
                                    100);
    MC_thread_startup(thread1);

    thread2 = MC_thread_create("thread2",
                                    thread2_entry,
                                    256,
                                    63,
                                    100);
    MC_thread_startup(thread2);

    MC_scheduler_begin();
    while(1)
    {
        
    }
}