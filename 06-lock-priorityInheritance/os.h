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
};
typedef struct MC_list* MC_list_t;
/*------------------------*/



/*----------memheap4----------*/
void *MC_PageMalloc(size_t MallocSize);
void MC_PageFree(void *FreeAddr);
/*----------------------------*/



/*----------timer----------*/
#define TIMER_INTERVAL RTK_TIMEBASE_FREQ

#define MC_TIMER_CTRL_SET_TIME 0x0

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
    uint32_t init_tick;
    uint32_t timeout_tick;
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
void MC_timer_list_remove(MC_list_t node);
uint32_t MC_get_tick();
uint8_t MC_timer_control(MC_timer_t timer, int cmd, void *arg);
uint8_t MC_timer_start(MC_timer_t timer);

/*-------------------------*/



/*----------thread----------*/
#define MC_THREAD_STATE_RUNNING 0x0
#define MC_THREAD_STATE_READY   (1 << 0)
#define MC_THREAD_STATE_SUSPEND (1 << 1)
#define MC_THREAD_STATE_NULL    (1 << 2)


struct MC_thread{
    /* 线程属性 */
    char name[20];
    void *sp;
    void *entry;
    void *stack_addr;
    size_t stack_size;
    uint8_t priority;
    uint8_t inheritPriority;
    struct MC_timer timer;
    struct MC_list node;
    uint8_t state;
    // uint32_t tick;
};
typedef struct MC_thread* MC_thread_t;

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
MC_thread_t MC_thread_self(void);
uint8_t MC_thread_to_suspend_list(MC_thread_t thread, void *MC_source, uint8_t attribute);
uint8_t MC_thread_to_sem_suspend_list(MC_thread_t thread, MC_list_t suspend_list, uint8_t flag);
uint8_t MC_thread_to_lock_suspend_list(MC_thread_t thread, MC_list_t suspend_list, uint8_t flag);
uint8_t MC_thread_to_ready_list(MC_thread_t thread);
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
void MC_scheduler_remove_thread(MC_thread_t thread);
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



/*----------ipc----------*/
//资源属性
#define MC_IPCATTR_LOCK 1   //锁
#define MC_IPCATTR_SEM  2   //信号量

//阻塞队列线程排列方式
#define MC_IPC_FLAG_PRIO 0  //优先级高的先响应
#define MC_IPC_FLAG_FIFO 1  //先挂起的先响应

#define MC_IPC_SEM_MAXVALUE 65535

struct MC_spinlock{
    char name[20];
    uint8_t lock;

    // 并不是真正把线程阻塞，线程仍位于就绪队列中，仅标记有无自旋线程
    struct MC_list suspend_thread; 
    
    uint8_t attribute;
    MC_thread_t holdThread;
};
typedef struct MC_spinlock* MC_spinlock_t;

struct MC_semaphore{
    char name[20];
    uint8_t flag;
    struct MC_list suspend_thread;
    uint16_t value;
    uint16_t max_value;
    uint8_t attribute;
    // struct MC_spinlock spinlock; 
};
typedef struct MC_semaphore* MC_sem_t;

MC_sem_t MC_sem_create(char *name, uint16_t value,uint8_t flag);
uint8_t MC_sem_take(MC_sem_t sem, uint32_t timeout);
uint8_t MC_sem_release(MC_sem_t sem);
uint8_t MC_suspend_list_enqueue(MC_list_t suspend_list, MC_thread_t thread, uint8_t flag);
uint8_t MC_suspend_list_dequeue(MC_list_t suspend_list);
uint8_t MC_suspendList_isEmpty(MC_list_t suspend_list);
uint8_t MC_suspend_list_dequeue_timeout(MC_thread_t thread);



MC_spinlock_t MC_spinlock_create(char *name);
uint8_t MC_spinlock_delete(MC_spinlock_t spinlock);
uint8_t MC_spinlock_take(MC_spinlock_t spinlock);
uint8_t MC_spinlock_release(MC_spinlock_t spinlock);

/*-----------------------*/



/*----------delay---------*/
void delay_ms(uint32_t nms);
void MC_delay(uint32_t nms);
/*-------------------------*/
#endif