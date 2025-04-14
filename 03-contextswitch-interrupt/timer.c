#include "os.h"

#define TIMER_INTERVAL RTK_TIMEBASE_FREQ

static uint32_t _tick=0;

void MC_timer_load(int interval)
{
    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    uint64_t  mtime;

    mtime = ((uint64_t)(rtk_controller->CNTH) << 32) + rtk_controller->CNTL;
    mtime += interval;
    rtk_controller->CMPHR = (uint32_t)(mtime >> 32);
    rtk_controller->CMPLR = (uint32_t)(mtime & 0xffffffff);

    rtk_controller->CTRL = 0x00000007;
}

void MC_timer_init()
{
    PFIC_IENR_t pfic_ienr = (PFIC_IENR_t)PFIC_IENR_BASE;
    pfic_ienr->IENRx[0] |= 1 << SYS_TICK_IRQ;//使能systick中断

    MC_timer_load(TIMER_INTERVAL);
}

uint32_t MC_get_tick()
{
    return _tick;
}

void MC_timer_handler() 
{
	_tick++;
    // if(_tick % 1000 == 0)
	//     printf("tick: %d\r\n", _tick / 1000);
    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    rtk_controller->SR = 0;
	MC_timer_load(TIMER_INTERVAL);
}