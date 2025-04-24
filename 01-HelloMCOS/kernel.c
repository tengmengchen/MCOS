#include "os.h"
void start_kernel()
{
    USART1_init();

    puts((uint8_t *)"Hello MCOS!\r\n");
    while(1){};
}