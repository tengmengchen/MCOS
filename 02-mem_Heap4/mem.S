.section .rodata

.global TEXT_START
TEXT_START: .word _text_start

.global TEXT_END
TEXT_END: .word _text_end

.global DATA_START
DATA_START: .word _data_start

.globaL DATA_END
DATA_END: .word _data_end

.global RODATA_START
RODATA_START: .word _rodata_start

.global RODATA_END
RODATA_END: .word _rodata_end

.global BSS_START
BSS_START: .word _start_bss

.global BSS_END
BSS_END: .word _end_bss

.global HEAP_START
HEAP_START: .word _heap_start

.global HEAP_SIZE
HEAP_SIZE: .word _heap_size

.global STACK_START
STACK_START: .word _start_stack

.global STACK_END
STACK_END: .word _end_stack

