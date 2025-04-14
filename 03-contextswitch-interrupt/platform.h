#ifndef __PLATFORM_H__
#define __PLATFORM_H__

#include "types.h"

#define SYSCLK 8000000

#define USART1_BASE 0x40013800

#define RCC_BASE 0x40021000

#define GPIOA_BASE 0x40010800

/*----------RTK----------*/
#define RTK_TIMEBASE_FREQ 8000
#define RTK_BASE 0xE000F000
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
typedef struct PFIC_IPRR* PFIC_IPRR;

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


#define SYS_TICK_IRQ 12

/*------------------------*/

#endif