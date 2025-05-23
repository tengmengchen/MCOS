#include "adc.h"

#define RCC_REG(REG) (volatile uint32_t *)(RCC_BASE+(REG<<2))
#define RCC_REG_W(REG,val) (*(RCC_REG(REG)) = (val))
#define RCC_REG_R(REG) (*(RCC_REG(REG)))



uint8_t MC_adc_init(MC_adc *adc_addr, ADC_InitTypeDef adc_initType)
{
    uint32_t ctlr2 = adc_addr->CTLR2, tmp = 0;
    
    //配置连续采样
    if(adc_initType.ADC_ContinuousConvMode)
    {
        ctlr2 |= ADC_CONT_MODE_ENABLE;
    }
    else
    {
        ctlr2 &= ADC_CONT_MODE_DISABLE;
    }

    //配置数据对齐方式
    if(adc_initType.ADC_DataAlign)
    {
        ctlr2 |= ADC_DATA_ALIGN_LEFT;
    }
    else
    {
        ctlr2 &= ADC_DATA_ALIGN_RIGHT;
    }
    
    // 设置校准
    // ctlr2 |= ADC_CAL_ON;
    // ctlr2 |= ADC_RSTCAL_ON;

    adc_addr->CTLR2 = ctlr2;
    delay_ms(1);
    // //等待ADC初始化完成
    // tmp = 0;
    // while(tmp < 16 && ((adc_addr->CTLR2 | ADC_CAL_MASK) || (adc_addr->CTLR2 | ADC_RSTCAL_MASK)))
    // {
    //     tmp++;
    // }
    // if(tmp >= 16)
    // {
    //     return 1;
    // }

    //配置采集通道1 （PA1）的数据
    adc_addr->RSQR3 = 1;
    
    return 0;
}

uint8_t MC_adc_start(MC_adc *adc_addr)
{
    uint32_t tmp;
    //开启adc1_2时钟
    tmp = RCC_REG_R(APB2PCENR);
    tmp |= (1<<9) | (1<<10);
    RCC_REG_W(APB2PCENR, tmp);

    adc_addr->CTLR2 |= ADC_ADON;
    return 0;
}

uint32_t MC_adc_readdata(MC_adc *adc_addr)
{
    return adc_addr->RDATAR;
}