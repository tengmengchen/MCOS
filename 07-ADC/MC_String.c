#include "os.h"

void MC_memcpy(char *dst, char *src, int len)
{
    if(dst == NULL || src == NULL || len <= 0)
        return;

    for(int i = 0; i < len; i++)
    {
        *(dst + i) = *(src + i);
        *(dst + i + 1) = '\0';
    }
}

size_t MC_strlen(char *src)
{
    size_t len = 0;
    while(*src++) len++;
    return len;
}