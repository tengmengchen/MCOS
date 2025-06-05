#ifndef __USART_H__
#define __USART_H__
#include "platform.h"
#include "os.h"

#define RCC_REG(REG) (volatile uint32_t *)(RCC_BASE+(REG<<2))
#define USART1_REG(REG) (volatile uint32_t *)(USART1_BASE+(REG<<2))
#define GPIOA_REG(REG) (volatile uint32_t *)(GPIOA_BASE+(REG<<2))

#define RCC_REG_W(REG,val) (*(RCC_REG(REG)) = (val))
#define RCC_REG_R(REG) (*(RCC_REG(REG)))

#define USART1_REG_W(REG,val) (*(USART1_REG(REG)) = (val))
#define USART1_REG_R(REG) (*(USART1_REG(REG)))

#define GPIOA_REG_W(REG,val) (*(GPIOA_REG(REG)) = (val))
#define GPIOA_REG_R(REG) (*(GPIOA_REG(REG)))

void USART1_init()
{
    while((RCC_REG_R(CTLR) & (1<<1)) == 0)continue;
    uint32_t  x = (RCC_REG_R(APB2PCENR)) | (1<<14) | (1<<2);
    RCC_REG_W(APB2PCENR,x);

    x = ((GPIOA_REG_R(CFGHR) & ~(0b1111<<4)) | (uint32_t)(0b1011<<4));
    GPIOA_REG_W(CFGHR,x);

#ifdef SYSCLK_72MHz
#ifdef USART1_BAUDRATE_115200
    x = (USART1_REG_R(BRR) | (uint16_t)0b1001110001); // DIV_M = 39  DIV_F = 1
#endif
#ifdef USART1_BAUDRATE_500000
    x = (USART1_REG_R(BRR) | (uint16_t)0b10010000); // DIV_M = 9  DIV_F = 0
#endif
#ifdef USART1_BAUDRATE_720000
    x = (USART1_REG_R(BRR) | (uint16_t)0b1100100); // DIV_M = 6  DIV_F = 4
#endif
#ifdef USART1_BAUDRATE_800000
    x = (USART1_REG_R(BRR) | (uint16_t)0b1011010); // DIV_M = 5  DIV_F = 10
#endif
#ifdef USART1_BAUDRATE_900000
    x = (USART1_REG_R(BRR) | (uint16_t)0b1010000); // DIV_M = 5  DIV_F = 0
#endif
#endif
#ifdef SYSCLK_8MHz
    x = (USART1_REG_R(BRR) | (uint16_t)0b1000101);
#endif 
    USART1_REG_W(BRR,(uint16_t)x);


    x = (USART1_REG_R(CTLR1) | 0X0000200C);
    USART1_REG_W(CTLR1,(uint32_t)x);
}

void putc(uint8_t c)
{
    USART1_REG_W(DATAR,c);
}
void puts(uint8_t *s)
{
    __DISENABLE_INTERRUPT__();
    while(*s)
    {
        
        putc(*s++);
        while((USART1_REG_R(STATR) & (1 << 7)) == 0)continue; // 等待TXE置位
        while((USART1_REG_R(STATR) & (1 << 6)) == 0)continue; // 等待TC置位
       
    }
    __ENABLE_INTERRUPT__();
}

void USART1_Enable_DMAT()
{
    uint32_t x = USART1_REG_R(CTLR3) | (1 << 7);
    USART1_REG_W(CTLR3, x);
}

#endif