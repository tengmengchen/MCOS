#include "os.h"
#include "dma.h"

extern void trap_handler_base();
extern void DMA1_CH1_HT_Handler();
extern void DMA1_CH1_TC_Handler();
extern void DMA1_CH4_HT_Handler();
extern void DMA1_CH4_TC_Handler();


void __DISENABLE_INTERRUPT__()
{
    w_mstatus(r_mstatus() & ~(1 << 3)); // 全局中断关闭
}

void __ENABLE_INTERRUPT__()
{
    w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
}

void MC_trap_init()
{
    ptr_t base = (ptr_t)trap_handler_base;
    uint32_t mtvec = 0x00000001;
    mtvec |= (base);
    w_mtvec(mtvec);

    // w_mstatus(r_mstatus() | (1 << 3)); // 全局中断使能
    // 在main函数再开启全局中断
}

extern void MC_timer_handler();
void MC_mtip_handler()
{
    MC_timer_handler();
}

extern uint8_t MC_schedule_flag;
void MC_software_handler()
{
    // 上下文切换入口
    if(MC_schedule_flag)
    {
        MC_schedule_flag = 0;
        MC_schedule();
    }

    MC_pfic_pending_clear(SOFTWARE_IRQ);
}

void MC_dma1ch1_handler()
{
    uint32_t *tmp_intfr, *tmp_intfcr, tmp_cfgr;
    MC_dma *dma = (MC_dma *)DMA1_BASE;
    DMA_Channel_InitTypedef *dma_channel = &dma->dma_channel[0];
    tmp_cfgr = dma_channel->CFGR;
    tmp_intfr = &dma->INTFR;
    tmp_intfcr = &dma->INTFCR;
    if((*tmp_intfr & (1 << 3)) && (tmp_cfgr & DMA_CFGR_TEIE_ON)) // 传输错误
    {
        *tmp_intfcr |= (1 << 3);
    }
    if((*tmp_intfr & (1 << 2)) && (tmp_cfgr & DMA_CFGR_HTIE_ON)) // 传输过半
    {
        *tmp_intfcr |= (1 << 2);
        DMA1_CH1_HT_Handler();
    }
    if((*tmp_intfr & (1 << 1)) && (tmp_cfgr & DMA_CFGR_TCIE_ON)) // 传输完成
    {
        *tmp_intfcr |= (1 << 1);
        DMA1_CH1_TC_Handler();
    }

    // 清除全局中断标志
    *tmp_intfcr |= (1 << 0);
    
}

void MC_dma1ch4_handler()
{
    uint32_t *tmp_intfr, *tmp_intfcr, tmp_cfgr;
    MC_dma *dma = (MC_dma *)DMA1_BASE;
    DMA_Channel_InitTypedef *dma_channel = &dma->dma_channel[3];
    tmp_cfgr = dma_channel->CFGR;
    tmp_intfr = &dma->INTFR;
    tmp_intfcr = &dma->INTFCR;
    if((*tmp_intfr & (1 << 15)) && (tmp_cfgr & DMA_CFGR_TEIE_ON)) // 传输错误
    {
        *tmp_intfcr |= (1 << 15);
    }
    if((*tmp_intfr & (1 << 14)) && (tmp_cfgr & DMA_CFGR_HTIE_ON)) // 传输过半
    {
        *tmp_intfcr |= (1 << 14);
        DMA1_CH4_HT_Handler();
    }
    if((*tmp_intfr & (1 << 13)) && (tmp_cfgr & DMA_CFGR_TCIE_ON)) // 传输完成
    {
        *tmp_intfcr |= (1 << 13);
        DMA1_CH4_TC_Handler();
    }

    // 清除全局中断标志
    *tmp_intfcr |= (1 << 12);
    
}