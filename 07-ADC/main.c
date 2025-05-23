#include "os.h"
#include "adc.h"

MC_thread_t thread1;
MC_thread_t thread2;
MC_thread_t thread3;

MC_spinlock_t lock;
void thread1_entry()
{
    uint8_t ret;
    printf("test_thread1_start!\r\n");
    MC_adc_t adc_p = ADC1_BASE;
    ADC_InitTypeDef adc_initType = {
        .ADC_ContinuousConvMode = 1,
        .ADC_DataAlign = 0,
    };
    MC_adc_init(adc_p, adc_initType);
    MC_adc_start(adc_p);

    uint32_t raw_data;
    uint16_t data;
    uint16_t result;
    while(1)
    {
        raw_data = MC_adc_readdata(adc_p);
        data = raw_data & 0x0000FFFF;
        result = raw_data;
        printf("read ADC: %d\r\n", result);
        MC_delay(500);
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