#include "os.h"

void start_kernel()
{
    USART1_init();

    puts((uint8_t *)"22131");  

    char *s;
    s = (char *)MC_PageMalloc(20);
    s[0] = 't';
    s[1] = 'e';
    s[2] = 's';
    s[3] = 't';
    s[4] = '\0';
    MC_PageFree(s);
    // memcpy(s, "test\r\n", sizeof("test\r\n"));
    char ss[10] = "1234";
    puts((uint8_t *)s);
    while(1)
    {
        s = (char *)MC_PageMalloc(20);
        printf("%x\r\n", s);
        MC_PageFree(s);
    }
}