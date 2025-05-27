#include "os.h"

void *memcpy(void *dest, const void *src, size_t n) {
    unsigned char *d = dest;
    const unsigned char *s = src;
    while (n--) {
        *d++ = *s++;
    }
    return dest;
}

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