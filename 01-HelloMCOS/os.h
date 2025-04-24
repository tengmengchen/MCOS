#ifndef __OS_H__
#define __OS_H__
#include "platform.h"
#include "types.h"

void USART1_init();
void putc(uint8_t c);
void puts(uint8_t *s);

#endif