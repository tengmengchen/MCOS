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

/*----------memheap4----------*/
void *MC_PageMalloc(size_t MallocSize);
void MC_PageFree(void *FreeAddr);
/*----------------------------*/

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
    uint32_t tick;
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
    uint32_t tick);

uint8_t MC_thread_delete(MC_thread_t thread);
uint8_t MC_thread_startup(MC_thread_t thread);
void MC_thread_yield();
/*----------------------------*/

/*------------sched--------------*/
#define SCHED_STOP    0
#define SCHED_RUNNING 1

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



/*----------timer----------*/
void MC_timer_init();
uint32_t MC_get_tick();
/*-------------------------*/

#endif