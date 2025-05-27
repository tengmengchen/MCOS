#include "dma.h"

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
    dma_channel->CFGR &= DMA_CFGR_EN_MASE; // 关闭DMA_X
        
    tmp = dma_channel->CFGR;
    // 配置是否为存储器到存储器
    if(dma_initType.MEM2MEM)
    {
        tmp = (tmp & DMA_CFGR_MEM2MEM_MASK) | DMA_CFGR_MEM2MEM_ON;
    }
    else
    {
        tmp = tmp & DMA_CFGR_MEM2MEM_MASK;
    }

    // 配置存储器地址数据宽度
    tmp = (tmp & DMA_CFGR_MSIZE_MASE);
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
    tmp = (tmp & DMA_CFGR_PSIZE_MASE);
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
    if(dma_initType.MINC)
    {
        tmp = (tmp & DMA_CFGR_MINC_MASK) | DMA_CFGR_MINC_ENABLE;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_MINC_MASK) | DMA_CFGR_MINC_DISABLE;
    }

    // 外设地址增量递增模式使能
    if(dma_initType.PINC)
    {
        tmp = (tmp & DMA_CFGR_PINC_MASK) | DMA_CFGR_PINC_ENABLE;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_PINC_MASK) | DMA_CFGR_PINC_DISABLE;
    }

    // 配置DMA循环使能
    if(dma_initType.CIRC)
    {
        tmp = (tmp & DMA_CFGR_CIRC_MASK) | DMA_CFGR_CIRC_ENABLE;
    }
    else
    {
        tmp = tmp & DMA_CFGR_CIRC_MASK;
    }

    // 配置数据传输方向
    if(dma_initType.DIR)
    {
        tmp = (tmp & DMA_CFGR_DIR_MASK) | DMA_CFGR_DIR_MEM;
    }
    else
    {
        tmp = (tmp & DMA_CFGR_DIR_MASK) | DMA_CFGR_DIR_DEVICE;
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

void MC_dma_start(DMA_InitTypedef dma_initTypedef)
{
    uint8_t dma_x = dma_initTypedef.DMA_X;
    MC_dma *dma;
    DMA_Channel_InitTypedef *dma_channel;
    // 选择dma控制器
    if(dma_x == 1)
    {
        dma = (MC_dma *)DMA1_BASE;
    }
    else if(dma_x == 2)
    {
        dma = (MC_dma *)DMA2_BASE;
    }
    dma_channel = dma->dma_channel;
    dma_channel->CFGR |= DMA_CFGR_EN_ON; // 开启DMA_X
    return;
}