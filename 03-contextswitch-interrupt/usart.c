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

typedef enum{
    STATR = 0,
    DATAR = 1,
    BRR = 2,
    CTLR1 = 3,
} _USART1_REG;

typedef enum{
    CTLR = 0,
    APB2PCENR=6,
}_RCC_REG;

typedef enum{
    CFGLR = 0,
    CFGHR = 1,
    INDR = 2,
    OUTDR = 3,
}_GPIOA_REG;
void USART1_init()
{
    while((RCC_REG_R(CTLR) & (1<<1)) == 0)continue;
    uint32_t  x = (RCC_REG_R(APB2PCENR)) | (1<<14) | (1<<2);
    RCC_REG_W(APB2PCENR,x);

    x = ((GPIOA_REG_R(CFGHR) & ~(0b1111<<4)) | (uint32_t)(0b1011<<4));
    GPIOA_REG_W(CFGHR,x);

    x = (USART1_REG_R(BRR) | (uint16_t)0b1000101);
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
    while(*s)
    {
        __DISENABLE_INTERRUPT__();
        putc(*s++);
        while((USART1_REG_R(STATR) & (1<<7)) == 0)continue;
        __ENABLE_INTERRUPT__();
    }
}
#endif