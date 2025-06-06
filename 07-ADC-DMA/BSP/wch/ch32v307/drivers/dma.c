#include "dma.h"

uint32_t dma_ch_irq[8] = {
    DMA1_CH1_IRQ,
    DMA1_CH2_IRQ,
    DMA1_CH3_IRQ,
    DMA1_CH4_IRQ,
};

void MC_dma_interrupt_enable(uint32_t dma_x, uint32_t channel)
{
    if(dma_x == 1)
    {
        MC_pfic_interupt_enable(dma_ch_irq[channel]);
    }
    else if(dma_x == 2)
    {

    }
}

uint8_t MC_dma_init(DMA_InitTypedef dma_initType)
{
    uint32_t channel = dma_initType.DMA_Channel - 1, dma_x = dma_initType.DMA_X, tmp;
    MC_dma *dma;
    DMA_Channel_InitTypedef *dma_channel;

    RCC_InitTypedef *rcc = RCC_BASE;

    // 选择dma控制器
    if(dma_x == 1)
    {
        dma = (MC_dma *)DMA1_BASE;

        // 开启DMA1时钟
        rcc->AHBPCENR |= 0x00000001;
    }
    else if(dma_x == 2)
    {
        dma = (MC_dma *)DMA2_BASE;

        // 开启DMA2时钟
        rcc->AHBPCENR |= 0x00000002;
    }

    // 选择DMA通道
    dma_channel = &dma->dma_channel[channel];
    dma_channel->CFGR &= DMA_CFGR_EN_MASK; // 关闭DMA_X 关闭后才可以配置相关寄存器
        
    tmp = dma_channel->CFGR;
    // 配置是否为存储器到存储器
    if(dma_initType.MEM2MEM == ENABLE)
    {
        tmp = (tmp & DMA_CFGR_MEM2MEM_MASK) | DMA_CFGR_MEM2MEM_ON;
    }
    else
    {
        tmp = tmp & DMA_CFGR_MEM2MEM_MASK;
    }

    // 配置存储器地址数据宽度
    tmp = (tmp & DMA_CFGR_MSIZE_MASK);
    switch (dma_initType.MSIZE)
    {
    case 0:
        tmp |= DMA_CFGR_MSIZE_8BIT;
        break;
    
    case 1:
        tmp |= DMA_CFGR_MSIZE_16BIT;
        break;

    case 2:
        tmp |= DMA_CFGR_MSIZE_32BIT;
        break;

    default:
        break;
    }

    // 配置外设地址数据宽度
    tmp = (tmp & DMA_CFGR_PSIZE_MASK);
    switch (dma_initType.PSIZE)
    {
    case 0:
        tmp |= DMA_CFGR_PSIZE_8BIT;
        break;
    
    case 1:
        tmp |= DMA_CFGR_PSIZE_16BIT;
        break;

    case 2:
        tmp |= DMA_CFGR_PSIZE_32BIT;
        break;

    default:
        break;
    }

    // 存储器地址增量递增模式使能
    if(dma_initType.MINC == ENABLE)
    {
        tmp = (tmp & DMA_CFGR_MINC_MASK) | DMA_CFGR_MINC_ENABLE;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_MINC_MASK) | DMA_CFGR_MINC_DISABLE;
    }

    // 外设地址增量递增模式使能
    if(dma_initType.PINC == ENABLE)
    {
        tmp = (tmp & DMA_CFGR_PINC_MASK) | DMA_CFGR_PINC_ENABLE;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_PINC_MASK) | DMA_CFGR_PINC_DISABLE;
    }

    // 配置DMA循环使能
    if(dma_initType.CIRC == ENABLE)
    {
        tmp = (tmp & DMA_CFGR_CIRC_MASK) | DMA_CFGR_CIRC_ENABLE;
    }
    else
    {
        tmp = tmp & DMA_CFGR_CIRC_MASK;
    }

    // 配置数据传输方向
    if(dma_initType.DIR == ENABLE)
    {
        tmp = (tmp & DMA_CFGR_DIR_MASK) | DMA_CFGR_DIR_MEM;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_DIR_MASK) | DMA_CFGR_DIR_DEVICE;
    }

    // 配置传输过半中断使能
    if(dma_initType.HTIE == ENABLE)
    {
        MC_dma_interrupt_enable(dma_x, channel);
        tmp = (tmp & DMA_CFGR_HTIE_MASK) | DMA_CFGR_HTIE_ON;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_HTIE_MASK) | DMA_CFGR_HTIE_OFF;
    }

    // 配置传输完成中断使能
    if(dma_initType.TCIE == ENABLE)
    {
        MC_dma_interrupt_enable(dma_x, channel);
        tmp = (tmp & DMA_CFGR_TCIE_MASK) | DMA_CFGR_TCIE_ON;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_TCIE_MASK) | DMA_CFGR_TCIE_OFF;
    }

    // 配置传输错误中断使能
    if(dma_initType.TEIE == ENABLE)
    {
        MC_dma_interrupt_enable(dma_x, channel);
        tmp = (tmp & DMA_CFGR_TEIE_MASK) | DMA_CFGR_TEIE_ON;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_TEIE_MASK) | DMA_CFGR_TEIE_OFF;
    }

    dma_channel->CFGR = tmp;

    //设置传输数目
    dma_channel->CNTR = dma_initType.CNTR; 
    
    // 设置存储器地址
    dma_channel->MADDR = dma_initType.MADDR; 
  
    // 设置外设地址
    dma_channel->PADDR = dma_initType.PADDR; 
    
    return 0;
}

void MC_dma_start(DMA_InitTypedef dma_initType)
{
    uint8_t dma_x = dma_initType.DMA_X;
    // MC_dma *dma;
    // DMA_Channel_InitTypedef *dma_channel;
    uint32_t channel = dma_initType.DMA_Channel;
    MC_dma_start_by_channel(dma_x, channel);
    // // 选择dma控制器
    // if(dma_x == 1)
    // {
    //     dma = (MC_dma *)DMA1_BASE;
    // }
    // else if(dma_x == 2)
    // {
    //     dma = (MC_dma *)DMA2_BASE;
    // }
    // dma_channel = &dma->dma_channel[channel];
    // dma_channel->CFGR |= DMA_CFGR_EN_ON; // 开启DMA_X
    return;
}

void MC_dma_start_by_channel(uint8_t dma_x, uint8_t channel)
{
    MC_dma *dma;
    DMA_Channel_InitTypedef *dma_channel;
    channel --;
    if(dma_x == 1)
    {
        dma = (MC_dma *)DMA1_BASE;
    }
    else if(dma_x == 2)
    {
        dma = (MC_dma *)DMA2_BASE;
    }
    dma_channel = &dma->dma_channel[channel];

    dma_channel->CFGR |= DMA_CFGR_EN_ON;
}

void MC_dma_change_config_by_channel(uint8_t dma_x, uint8_t channel, uint8_t option, void *arg)
{
    MC_dma *dma;
    DMA_Channel_InitTypedef *dma_channel;
    channel --;
    if(dma_x == 1)
    {
        dma = (MC_dma *)DMA1_BASE;
    }
    else if(dma_x == 2)
    {
        dma = (MC_dma *)DMA2_BASE;
    }
    dma_channel = &dma->dma_channel[channel];

    switch (option)
    {
    case DMA_CHANGE_CONFIG_MADDR:
        /* code */
        dma_channel->MADDR = *(uint32_t *)arg; 
        break;
    case DMA_CHANGE_CONFIG_CNTR:
        dma_channel->CNTR  = *(uint32_t *)arg;
        break;
    default:
        break;
    }
}

uint32_t MC_dma_get_MADDR_by_channel(uint8_t dma_x, uint8_t channel)
{
    MC_dma *dma;
    DMA_Channel_InitTypedef *dma_channel;
    channel --;
    if(dma_x == 1)
    {
        dma = (MC_dma *)DMA1_BASE;
    }
    else if(dma_x == 2)
    {
        dma = (MC_dma *)DMA2_BASE;
    }
    dma_channel = &dma->dma_channel[channel];

    return dma_channel->MADDR;
}

// DMA1 CH1 传输过半中断处理程序
__attribute__((weak)) void DMA1_CH1_HT_Handler()
{
    return;
}

// DMA1 CH1 传输完成中断处理程序
__attribute__((weak)) void DMA1_CH1_TC_Handler()
{
    return;
}

// DMA1 CH4 传输过半中断处理程序
__attribute__((weak)) void DMA1_CH4_HT_Handler()
{
    return;
}

// DMA1 CH4 传输完成中断处理程序
__attribute__((weak)) void DMA1_CH4_TC_Handler()
{
    return;
}