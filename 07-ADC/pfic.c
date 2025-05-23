#include "os.h"

PFIC_ISR_t  pfic_isr  = (PFIC_ISR_t) PFIC_ISR_BASE;
PFIC_IPR_t  pfic_ipr  = (PFIC_IPR_t) PFIC_IPR_BASE;
PFIC_IENR_t pfic_ienr = (PFIC_IENR_t)PFIC_IENR_BASE;
PFIC_IRER_t pfic_irer = (PFIC_IRER_t)PFIC_IRER_BASE;
PFIC_IPSR_t pfic_ipsr = (PFIC_IPSR_t)PFIC_IPSR_BASE;
PFIC_IPRR_t pfic_iprr = (PFIC_IPRR_t)PFIC_IPRR_BASE;
PFIC_IPRIOR_t pfir_iprior = (PFIC_IPRIOR_t)PFIC_IPRIOR_BASE;

/**
 * 中断挂起设置
*/
void MC_pfic_pending_set(uint8_t irqn)
{
    uint8_t idx = irqn / 32;
    unsigned int bit_offset = irqn % 32;
    pfic_ipsr->IPSRx[idx] = 1 << bit_offset;
}

/**
 * 中断挂起清除
*/
void MC_pfic_pending_clear(uint8_t irqn)
{
    uint8_t idx = irqn / 32;
    unsigned int bit_offset = irqn % 32;
    pfic_iprr->IPRRx[idx] = 1 << bit_offset;
}