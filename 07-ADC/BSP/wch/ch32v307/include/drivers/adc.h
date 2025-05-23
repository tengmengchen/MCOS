#ifndef _ADC_H_
#define _ADC_H_

#include "os.h"



//CTLR2
#define ADC_DATA_ALIGN_LEFT   0x00000800
#define ADC_DATA_ALIGN_RIGHT  0xFFFFF7FF

#define ADC_DMA_ENABLE        0x00000100
#define ADC_RSTCAL_ON         0x00000004
#define ADC_RSTCAL_MASK       0x00000004
#define ADC_CAL_ON            0x00000008
#define ADC_CAL_MASK          0x00000008

#define ADC_CONT_MODE_ENABLE  0x00000002
#define ADC_CONT_MODE_DISABLE 0xFFFFFFFD

#define ADC_ADON              0x00000001
#define ADC_ADOFF             0xFFFFFFFE




/* ADC数模转换模块 */
typedef struct
{
  __IO uint32_t STATR;
  __IO uint32_t CTLR1;
  __IO uint32_t CTLR2;
  __IO uint32_t SAMPTR1;
  __IO uint32_t SAMPTR2;
  __IO uint32_t IOFR1;
  __IO uint32_t IOFR2;
  __IO uint32_t IOFR3;
  __IO uint32_t IOFR4;
  __IO uint32_t WDHTR;
  __IO uint32_t WDLTR;
  __IO uint32_t RSQR1;
  __IO uint32_t RSQR2;
  __IO uint32_t RSQR3;
  __IO uint32_t ISQR;
  __IO uint32_t IDATAR1;
  __IO uint32_t IDATAR2;
  __IO uint32_t IDATAR3;
  __IO uint32_t IDATAR4;
  __IO uint32_t RDATAR;
} MC_adc;
typedef struct MC_adc* MC_adc_t;

/* ADC 初始化结构体定义 */
typedef struct
{
  uint32_t ADC_Mode;                      /* 定义是独立模式还是双ADC采样 */
  FunctionalState ADC_ScanConvMode;       /* 定义采样是扫描模式还是单通道模式 */
  FunctionalState ADC_ContinuousConvMode; /* 定义是单次采样还是连续采样 */
  uint32_t ADC_ExternalTrigConv;          /* 定义ADC采样的外部触发源 */
  uint32_t ADC_DataAlign;                 /* 定义数据对齐方式（左端、右端两种对齐方式） */
  uint8_t ADC_NbrOfChannel;               /* 表明规则通道转换序列中需要转换的通道数目：1~16 */
  // uint32_t  ADC_OutputBuffer;             /* Specifies whether the ADC channel output buffer is enabled or disabled.
  //                                              This parameter can be a value of @ref ADC_OutputBuffer */
  uint32_t ADC_Pga;                       /* 指定PGA增益倍数 */
}ADC_InitTypeDef;


uint8_t MC_adc_init(MC_adc *adc_addr, ADC_InitTypeDef adc_initType);
uint8_t MC_adc_start(MC_adc *adc_addr);
uint32_t MC_adc_readdata(MC_adc *adc_addr);

#endif