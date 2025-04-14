    .global _start

    .text

_start:
    la      sp, _end_stack  // set stack pointer to the end of SRAM

    // load data section from flash to RAM
    la a0, _data_lma
    la a1, _data_vma
    la a2, _data_end
    bgeu a1,a2, 2f
1:
    lw t0, (a0)
    sw t0, (a1)
    addi a0, a0, 4
    addi a1, a1, 4
    bltu a1, a2, 1b
2:
    // clear bss section
    la a0, _start_bss
    la a1, _end_bss
    bgeu a0, a1, 2f
1:
    sw zero, (a0)
    addi a0, a0, 4
    bltu a0, a1, 1b
2:
    // jump to start_kernel
    j       start_kernel   
    .end