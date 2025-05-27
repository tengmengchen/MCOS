#include "os.h"

void SystemClock_Init()
{
    RCC_InitTypedef *rcc = RCC_BASE;
    uint32_t tmp = 0;
#ifdef SYSCLK_8MHz
    // 默认8MHz， ADC: 2MHz
#endif

#ifdef SYSCLK_72MHz

    tmp = rcc->CFGR0;

    // 选择系统时钟源
    tmp = (tmp & SW_SYSCLK_MASK) | SW_SYSCLK_PLL;

    // 配置PLL 18倍频输出
    tmp = (tmp & PLLMUL_MASK) | PLLMUL_18x;

    // HB时钟来源预分频控制
    tmp = (tmp & HPRE_SYSCLK_MASK) | HPRE_SYSCLK_NODIV;

    // PB2时钟源为HB 不分频
    tmp = (tmp & PPRE2_HCLK_MASK) | PPRE2_HCLK_NODIV;

    // 设置ADC时钟频率：12MHz
    tmp = (tmp & ADCPRE_PCLK2_MASK) | ADCPRE_PCLK2_DIV6;

    rcc->CFGR0 = tmp;

    // 使能PLL时钟
    rcc->CTLR |= PLLON_ENABLE;

#endif
    return;
}

void Board_init()
{
    SystemClock_Init();
    return;
}