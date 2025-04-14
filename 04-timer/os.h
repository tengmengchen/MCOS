#ifndef __OS_H__
#define __OS_H__
#include "platform.h"
#include "types.h"
#include "riscv.h"
// #include <stdarg.h>
// #include <stddef.h>
// #include <stdio.h>
// #include <string.h>

//sys
void USART1_init();
void putc(uint8_t c);
void puts(uint8_t *s);
int printf(const char* s, ...);
void MC_memcpy(char *dst, char *src, int len);
size_t MC_strlen(char *src);

/*----------list---------*/
#define MC_container_of(ptr, type, member)\
    ((type *)((uint8_t *)ptr - (uint8_t *)&((type *)0)->member))

struct MC_list{
    struct MC_list* prev;
    struct MC_list* next;
    uint32_t init_tick;
    uint32_t timeout_tick;
};
typedef struct MC_list* MC_list_t;
/*------------------------*/



/*----------memheap4----------*/
void *MC_PageMalloc(size_t MallocSize);
void MC_PageFree(void *FreeAddr);
/*----------------------------*/



/*----------timer----------*/
#define MC_TIMER_FLAG_THREAD_TIMER (1 << 2)
#define MC_TIMER_FLAG_CYCLE_TIMER  (1 << 1)
#define MC_TIMER_FLAG_ACTIVATED    (1 << 0)

typedef void (*MC_timer_func_t)(void *parameter);
struct MC_timer{
    char name[20];
    MC_timer_func_t timeout_func;
    void    *parameter;
    uint8_t flag; // 000 线程定时器/循环使能/激活状态 
    struct MC_list node;
};
typedef struct MC_timer* MC_timer_t;

MC_timer_t MC_timer_create(char *name,
    void (*timeout)(void *parameter),
    void *parameter,
    uint32_t time,
    uint8_t flag);

uint8_t MC_timer_init(MC_timer_t timer,
    char *name,
    void (*timeout)(void *parameter),
    void *parameter,
    uint32_t time,
    uint8_t flag);

void MC_SysTick_init();
void MC_timer_list_insert(MC_list_t node);
uint32_t MC_get_tick();


/*-------------------------*/



/*----------thread----------*/
struct MC_thread{
    /* 链表节点 */
    struct MC_thread *prev;
    struct MC_thread *next;

    /* 线程属性 */
    char name[20];
    void *sp;
    void *entry;
    void *stack_addr;
    size_t stack_size;
    uint8_t priority;
    struct MC_timer timer;
    // uint32_t tick;
};
typedef struct MC_thread* MC_thread_t;

struct MC_thread_list{
    MC_thread_t prev;
    MC_thread_t next;
};
typedef struct MC_thread_list* MC_thread_list_t;

MC_thread_t MC_thread_create(char *name,
    void (*entry)(void),
    size_t stack_size,
    uint8_t priority,
    uint32_t tick,
    uint8_t flag);

uint8_t MC_thread_delete(MC_thread_t thread);
uint8_t MC_thread_startup(MC_thread_t thread);
void MC_thread_yield();
/*----------------------------*/



/*------------sched--------------*/
#define SCHED_STOP    0
#define SCHED_RUNNING 1

extern uint8_t MC_schedule_flag;

struct MC_sched{
    uint8_t sched_state;
    MC_thread_t running_thread;
}MC_sched;

void MC_schedule();
void MC_scheduler_begin();
void MC_scheduler_start();
void MC_scheduler_stop();
/*-------------------------------*/



/*----------trap----------*/
void MC_trap_init();
void __DISENABLE_INTERRUPT__();
void __ENABLE_INTERRUPT__();
/*------------------------*/




/*----------pfic----------*/
extern PFIC_ISR_t  pfic_isr;
extern PFIC_IPR_t  pfic_ipr;
extern PFIC_IENR_t pfic_ienr;
extern PFIC_IRER_t pfic_irer;
extern PFIC_IPSR_t pfic_ipsr;
extern PFIC_IPRIOR_t pfir_iprior;

void MC_pfic_pending_set(uint8_t irqn);
void MC_pfic_pending_clear(uint8_t irqn);
/*------------------------*/
#endif