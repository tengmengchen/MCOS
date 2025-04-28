OUTPUT_ARCH( "riscv" )

ENTRY( _start )
__stack_size = 0x1000;
PROVIDE( _stack_size = __stack_size );

MEMORY{
    RAM (xrw) : ORIGIN = 0x20000000, LENGTH = 64K
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 256K
}

SECTIONS {

    .text : {
        PROVIDE(_text_start = .);
        *(.text .text.*)
        PROVIDE(_text_end = .);
    } >FLASH AT>FLASH

    .rodata : {
        PROVIDE(_rodata_start = .);
        *(.rodata .rodata.*)
        PROVIDE(_rodata_end = .);
    } >FLASH AT>FLASH

    .dalign : {
        . = ALIGN(4);
        PROVIDE(_data_vma = .);
    } >RAM AT>FLASH
    .dlalign : {
        . = ALIGN(4);
        PROVIDE(_data_lma = .);
    } >FLASH AT>FLASH

    .data : {
        PROVIDE(_data_start = .);
        *(.data .data.*)
        *(.sdata .sdata.*)
        . = ALIGN(4);
        PROVIDE(_data_end = .);
    } >RAM AT>FLASH

    .bss : {
        . = ALIGN(4);
        PROVIDE(_start_bss = .);
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        *(COMMON)
        . = ALIGN(4);
        PROVIDE(_end_bss = .);
    } >RAM 

    .stack ORIGIN(RAM) + LENGTH(RAM) - __stack_size : {
        PROVIDE( _heap_end = . );
        . = ALIGN(4);
        PROVIDE(_start_stack = .);
        . = . + __stack_size;
        PROVIDE(_end_stack = .);
    } >RAM

    PROVIDE(_memory_start = ORIGIN(RAM));
    PROVIDE(_memory_end = ORIGIN(RAM) + LENGTH(RAM));

    PROVIDE(_heap_start = _end_bss);
    PROVIDE(_heap_size = _start_stack - _heap_start);
}
