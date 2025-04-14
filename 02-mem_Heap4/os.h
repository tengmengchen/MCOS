#ifndef __OS_H__
#define __OS_H__
#include "platform.h"
#include "types.h"
#include <stdarg.h>
#include <stddef.h>
// #include <stdio.h>
#include <string.h>

void USART1_init();
void putc(uint8_t c);
void puts(uint8_t *s);
int printf(const char* s, ...);
//memheap4
void *MC_PageMalloc(size_t MallocSize);
void MC_PageFree(void *FreeAddr);

#endif