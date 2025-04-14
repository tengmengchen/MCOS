#include "os.h"
void start_kernel()
{
    USART1_init();

    puts((uint8_t *)"22131");
    while(1){};
}