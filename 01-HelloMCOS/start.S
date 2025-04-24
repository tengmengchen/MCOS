    .global _start
    .text
_start:
    la      sp, 0x20005000  # set stack pointer to the end of SRAM

    j start_kernel
.end