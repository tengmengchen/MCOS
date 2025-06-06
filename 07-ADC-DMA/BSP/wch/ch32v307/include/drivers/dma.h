#ifndef _DMA_H_
#define _DMA_H_

#include "os.h"

#define DMA1_CHANNEL_ADC1      1
#define DMA1_CHANNEL_USART1_TX 4
#define DMA1_CHANNEL_USART1_RX 5

#define DMA1_BASE             0x40020000
#define DMA2_BASE             0x40020400


#define DMA_CFGR_MEM2MEM_MASK 0xFFFFBFFF
#define DMA_CFGR_MEM2MEM_ON   0x00004000
#define DMA_CFGR_MEM2MEM_OFF  0x00000000

#define DMA_CFGR_MSIZE_MASK   0xFFFFF3FF
#define DMA_CFGR_MSIZE_8BIT   0x00000000
#define DMA_CFGR_MSIZE_16BIT  0x00000400
#define DMA_CFGR_MSIZE_32BIT  0x00000800

#define DMA_CFGR_PSIZE_MASK   0xFFFFFCFF
#define DMA_CFGR_PSIZE_8BIT   0x00000000
#define DMA_CFGR_PSIZE_16BIT  0x00000100
#define DMA_CFGR_PSIZE_32BIT  0x00000200

#define DMA_CFGR_MINC_MASK    0xFFFFFF7F
#define DMA_CFGR_MINC_ENABLE  0x00000080
#define DMA_CFGR_MINC_DISABLE 0x00000000

#define DMA_CFGR_PINC_MASK    0xFFFFFFB0
#define DMA_CFGR_PINC_ENABLE  0x00000040
#define DMA_CFGR_PINC_DISABLE 0x00000000

#define DMA_CFGR_CIRC_MASK    0xFFFFFFDF
#define DMA_CFGR_CIRC_ENABLE  0x00000020
#define DMA_CFGR_CIRC_DISABLE 0x00000000

#define DMA_CFGR_DIR_MASK     0xFFFFFFEF
#define DMA_CFGR_DIR_DEVICE   0x00000000 // 从外设读
#define DMA_CFGR_DIR_MEM      0x00000010 // 从存储器读

#define DMA_CFGR_TEIE_MASK    0xFFFFFFF7
#define DMA_CFGR_TEIE_ON      0x00000008
#define DMA_CFGR_TEIE_OFF     0x00000000

#define DMA_CFGR_HTIE_MASK    0xFFFFFFFB
#define DMA_CFGR_HTIE_ON      0x00000004
#define DMA_CFGR_HTIE_OFF     0x00000000

#define DMA_CFGR_TCIE_MASK    0xFFFFFFFD
#define DMA_CFGR_TCIE_ON      0x00000002
#define DMA_CFGR_TCIE_OFF     0x00000000

#define DMA_CFGR_EN_MASK      0xFFFFFFFE
#define DMA_CFGR_EN_ON        0x00000001
#define DMA_CFGR_EN_OFF       0x00000000


#define DMA_CHANGE_CONFIG_MADDR 0x0001
#define DMA_CHANGE_CONFIG_CNTR  0x0002

typedef struct {
    __IO uint32_t CFGR;
    __IO uint32_t CNTR;
    __IO uint32_t PADDR;
    __IO uint32_t MADDR;
    uint32_t      RESERVED;
}DMA_Channel_InitTypedef;

typedef struct{
    __IO uint32_t INTFR;
    __IO uint32_t INTFCR;
    DMA_Channel_InitTypedef dma_channel[9];
}MC_dma;
typedef struct MC_dma* MC_dma_t;

typedef struct{
    FunctionalState MEM2MEM; // 存储器到存储器模式使能
    uint8_t PL;              // 通道优先级设置
    uint8_t MSIZE;           // 存储器地址数据宽度 0:8bit, 1:16bit, 2:32bit
    uint8_t PSIZE;           // 外设地址数据宽度
    FunctionalState MINC;    // 存储器地址增量递增模式使能
    FunctionalState PINC;    // 外设地址增量递增模式使能
    FunctionalState CIRC;    // DMA通道循环使能
    FunctionalState DIR;     // 传输方向，0:从外设读, 1:从存储器读
    FunctionalState TEIE;    // 传输错误中断控制使能
    FunctionalState HTIE;    // 传输过半中断控制使能
    FunctionalState TCIE;    // 传输完成中断控制使能
    uint16_t DMA_Channel;    // 选择DMA通道
    uint16_t DMA_X;          // 选择DMA控制器
    uint16_t CNTR;           // 设置DMA传输数目，循环模式自动填充
    uint32_t *PADDR;          // 设置外设地址
    uint32_t *MADDR;          // 设置存储器地址
}DMA_InitTypedef;

uint8_t MC_dma_init(DMA_InitTypedef dma_initType);
void MC_dma_start(DMA_InitTypedef dma_initTypedef);
void MC_dma_start_by_channel(uint8_t dma_x, uint8_t channel);
void MC_dma_change_config_by_channel(uint8_t dma_x, uint8_t channel, uint8_t option, void *arg);
#endif