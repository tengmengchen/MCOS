#ifndef __PLATFORM_H__
#define __PLATFORM_H__

#include "riscv.h"
#include "config.h"

#ifdef SYSCLK_8MHz
#define SYSCLK  8000000
#endif
#ifdef SYSCLK_72MHz
#define SYSCLK  72000000
#endif
#ifndef SYSCLK
// 系统时钟默认8MHz
#define SYSCLK  8000000 
#endif

/*----------SYS CLK----------*/
#ifndef TARGET_BOARD 
#define TARGET_BOARD ch32v307
#endif
/*---------------------------*/



/*----------USART1----------*/
typedef enum{
    STATR = 0,
    DATAR = 1,
    BRR   = 2,
    CTLR1 = 3,
} _USART1_REG;

#define USART1_BASE 0x40013800
/*-------------------------*/



/*----------RCC----------*/
typedef enum{
    CTLR      = 0,
    APB2PCENR = 6,
}_RCC_REG;

// CTLR
#define PLLON_ENABLE       0x01000000
#define PLLON_DISABLE      0xFEFFFFFF

// CFGR0
#define SW_SYSCLK_MASK     0xFFFFFFFC
#define SW_SYSCLK_HSI      0x00000000
#define SW_SYSCLK_HSE      0x00000001
#define SW_SYSCLK_PLL      0x00000002

#define HPRE_SYSCLK_MASK   0xFFFFFF0F
#define HPRE_SYSCLK_NODIV  0x00000000
#define HPRE_SYSCLK_DIV2   0x00000080
#define HPRE_SYSCLK_DIV4   0x00000090

#define PPRE2_HCLK_MASK    0xFFFF38FF
#define PPRE2_HCLK_NODIV   0x00000000
#define PPRE2_HCLK_DIV2    0x00002000
#define PPRE2_HCLK_DIV4    0x00002800

#define ADCPRE_PCLK2_MASK  0xFFFF3FFF
#define ADCPRE_PCLK2_DIV2  0x00000000
#define ADCPRE_PCLK2_DIV4  0x00004000
#define ADCPRE_PCLK2_DIV6  0x00008000
#define ADCPRE_PCLK2_DIV8  0x0000C000

#define PLLMUL_MASK        0xFFC3FFFF
#define PLLMUL_18x         0x00000000

// APB2PRENR
#define ADC1EN_MASK        0xFFFFFDFF
#define ADC1EN_ON          0x00000200
#define ADC1EN_OFF         0x00000000

typedef struct {
    __IO uint32_t CTLR;
    __IO uint32_t CFGR0;
    __IO uint32_t INTR;
    __IO uint32_t APB2PRSTR;
    __IO uint32_t APB1PRSTR;
    __IO uint32_t AHBPCENR;
    __IO uint32_t ABP2PCENR;
    __IO uint32_t ABP1PCERN;
    __IO uint32_t BDCTLR;
    __IO uint32_t RSTSCKR;
    __IO uint32_t AHBRSTR;
    __IO uint32_t CFGR2;

}RCC_InitTypedef;

#define RCC_BASE 0x40021000
/*-----------------------*/



/*----------GPIOA----------*/
typedef enum{
    CFGLR = 0,
    CFGHR = 1,
    INDR = 2,
    OUTDR = 3,
}_GPIOA_REG;

#define GPIOA_BASE 0x40010800
/*-------------------------*/



/*----------RTK----------*/
#define RTK_TIMEBASE_FREQ ((SYSCLK)/1000) // 1ms
#define RTK_BASE          0xE000F000
struct RTK_Controller{
    uint32_t CTRL;
    uint32_t SR;
    uint32_t CNTL;
    uint32_t CNTH;
    uint32_t CMPLR;
    uint32_t CMPHR;
};
typedef struct RTK_Controller* RTK_Controller_t;
/*-------------------------*/

/*----------PFIL----------*/
#define PFIC_ISR_BASE 0xE000E000
#define PFIC_IPR_BASE 0xE000E020
#define PFIC_IENR_BASE 0xE000E100
#define PFIC_IRER_BASE 0xE000E180
#define PFIC_IPSR_BASE 0xE000E200
#define PFIC_IPRR_BASE 0xE000E280
#define PFIC_IACTR_BASE 0xE000E300
#define PFIC_IPRIOR_BASE 0xE000E400
#define PFIC_CFGR_BASE 0xE000E048
#define PFIC_GISR_BASE  0xE000E04C
#define PFIC_VTFIDR_BASE 0xE000E050
#define PFIC_VTFADDRR_BASE 0XE000E060
#define PFIC_SCTLR_BASE 0xE000ED10


struct PFIC_ISR{
    uint32_t ISRx[8];
};
typedef struct PFIC_ISR* PFIC_ISR_t;

struct PFIC_IPR{
    uint32_t IPRx[8];
};
typedef struct PFIC_IPR* PFIC_IPR_t;

struct PFIC_IENR{
    uint32_t IENRx[8];
};
typedef struct PFIC_IENR* PFIC_IENR_t;

struct PFIC_IRER{
    uint32_t IRERx[8];
};
typedef struct PFIC_IRER* PFIC_IRER_t;

struct PFIC_IPSR{
    uint32_t IPSRx[8];
};
typedef struct PFIC_IPSR* PFIC_IPSR_t;

struct PFIC_IPRR{
    uint32_t IPRRx[8];
};
typedef struct PFIC_IPRR* PFIC_IPRR_t;

struct PFIC_IACTR{
    uint32_t IACTRx[8];
};
typedef struct PFIC_IACTR* PFIC_IACTR_t;

struct PFIC_IPRIOR{
    uint8_t IPRIOR[256];
};
typedef struct PFIC_IPRIOR* PFIC_IPRIOR_t;

struct PFIC_CFGR{
    uint32_t CFGR;
};
typedef struct PFIC_CFGR* PFIC_CFGR_t;

struct PFIC_GISR{
    uint32_t GISR;
};
typedef struct PFIC_GISR* PFIC_GISR_t;

struct PFIC_VTFIDR{
    uint32_t VTFIDR;
};
typedef struct PFIC_VTFIDR* PFIC_VTFIDR_t;

struct PFIC_VTFADDRR{
    uint32_t VTFADDRR[4];
};
typedef struct PFIC_VTFADDRR* PFIC_VTFADDRR_t;

struct PFIC_SCTLR{
    uint32_t SCTLR;
};
typedef struct PFIC_SCTLR* PFIC_SCTLR_t;


#define ECALL_M_IRQ  5
#define SYS_TICK_IRQ 12
#define SOFTWARE_IRQ 14
#define ADC1_2_IRQ   34


/*------------------------*/

#endif