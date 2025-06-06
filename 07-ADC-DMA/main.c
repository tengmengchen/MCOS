#include "os.h"
#include "adc.h"
#include "dma.h"

MC_thread_t thread1;
MC_thread_t thread2;
MC_thread_t thread3;

MC_sem_t sem1_1, sem1_2;
MC_sem_t sem2_1, sem2_2;

MC_spinlock_t lock;

uint16_t ADC1_Data[10005] = {1};

void DMA1_CH1_HT_Handler();

void thread1_entry()
{
    uint8_t ret;
    // printf("test_thread1_start!\r\n");

    MC_adc_t adc_p = (MC_adc *)ADC1_BASE;
    ADC_InitTypeDef adc_initType = {
        .ADC_ContinuousConvMode = 1,
        .ADC_DataAlign = 0,
        .ADC_DMA = 1
    };
    MC_adc_init(adc_p, adc_initType);
    MC_adc_start(adc_p);

    DMA_InitTypedef dma_initTypedef = {
        .MSIZE = 1,
        .PSIZE = 1,
        .MINC  = 1,
        .PINC  = 0,
        .CIRC  = 0,
        .DIR   = 0,
        .DMA_X = 1,
        .DMA_Channel = DMA1_CHANNEL_ADC1,
        .TCIE  = 1,
        .CNTR  = 5000,
        .PADDR = (uint32_t *)0x4001244C, // ADC1规则数据寄存器地址
        .MADDR = ADC1_Data
    }; 
    MC_dma_init(dma_initTypedef);
    // MC_dma_start(dma_initTypedef);

    USART1_Enable_DMAT();
    DMA_InitTypedef uart_dma_initTypedef = {
        .MSIZE = 0,
        .PSIZE = 0,
        .MINC  = 1,
        .PINC  = 0,
        .CIRC  = 1,
        .DIR   = 1,
        .DMA_X = 1,
        .DMA_Channel = DMA1_CHANNEL_USART1_TX,
        // .HTIE  = 1,
        .TCIE  = 1,
        .CNTR  = 5000 * sizeof(uint16_t),
        .PADDR = (uint32_t *)0x40013804, // USART1数据寄存器
        .MADDR = ADC1_Data
    }; 
    MC_dma_init(uart_dma_initTypedef);
    MC_dma_start(uart_dma_initTypedef);

    uint32_t raw_data;
    uint16_t data;
    uint16_t result;

    while(1)
    {
        // raw_data = MC_adc_readdata(adc_p);
        // data = raw_data & 0x0000FFFF;
        // result = raw_data;
        // printf("read ADC: %d\r\n", result);
        // for(int i = 1; i <= 10; i++)
        // {
        //     printf("%d ", ADC1_Data[i]);
        // }
        // printf("\r\n");
        
        MC_delay(500);
    }   
}

int main()
{
    __ENABLE_INTERRUPT__(); // 开启全局中断

    lock = MC_spinlock_create("lock_test");

    MC_sem_take(sem1_1, MC_SEM_WAIT_FOREVER);
    MC_sem_take(sem2_1, MC_SEM_WAIT_FOREVER);
    MC_sem_take(sem2_2, MC_SEM_WAIT_FOREVER);

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
            // printf("main: tick:%d\r\n", tick);
        }
    }
    return 0;
}

void DMA1_CH1_HT_Handler()
{
    return;
}

void DMA1_CH1_TC_Handler()
{
    return; 
}

void DMA1_CH4_HT_Handler()
{
    return;
}

void DMA1_CH4_TC_Handler()
{
    static uint16_t *MADDR1 = ADC1_Data, *MADDR2 = ADC1_Data + 5000;
    static uint16_t cntr_adc = 5000, cntr_uart = 5000 * sizeof(uint16_t), flag = 0;
    if(flag)
    {
        MC_dma_change_config_by_channel(1, 1, DMA_CHANGE_CONFIG_CNTR, &cntr_adc);
        MC_dma_change_config_by_channel(1, 1, DMA_CHANGE_CONFIG_MADDR, &MADDR1);
        MC_dma_start_by_channel(1, 1);

        MC_dma_change_config_by_channel(1, 4, DMA_CHANGE_CONFIG_CNTR, &cntr_uart);
        MC_dma_change_config_by_channel(1, 4, DMA_CHANGE_CONFIG_MADDR, &MADDR2);
        MC_dma_start_by_channel(1, 4);
    }
    else
    {
        MC_dma_change_config_by_channel(1, 1, DMA_CHANGE_CONFIG_CNTR, &cntr_adc);
        MC_dma_change_config_by_channel(1, 1, DMA_CHANGE_CONFIG_MADDR, &MADDR2);
        MC_dma_start_by_channel(1, 1);

        MC_dma_change_config_by_channel(1, 4, DMA_CHANGE_CONFIG_CNTR, &cntr_uart);
        MC_dma_change_config_by_channel(1, 4, DMA_CHANGE_CONFIG_MADDR, &MADDR1);
        MC_dma_start_by_channel(1, 4);
    }
    flag ^= 1;
    return;
}