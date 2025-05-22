include ../common.mk

SRCS_C := $(wildcard *.c)
SRCS_S := $(wildcard *.S)

OBJS = $(SRCS_S:.S=.o)
OBJS += $(SRCS_C:.c=.o)

.DEFAULT_GOAL := all
all: os.elf
os.elf: ${OBJS}
	${CC} ${CFLAGS} -T os.ld -o os.elf $^
	${OBJCOPY} -O binary os.elf os.bin
	mv *.o *.elf *.bin ./build

%.o : %.c
	${CC} ${CFLAGS} -c -o $@ $<

%.o : %.S
	${CC} ${CFLAGS} -c -o $@ $<

.PHONY : flash
flash: all
	@echo "------------------------"
	@echo "Flashing os.bin to board"
	@echo "------------------------"
	@${OPENOCD} -f ${CFG}  -c init -c halt  -c "program build/os.bin"  -c exit

.PHONY : debug
debug: all
	@echo "-----------------------------------------------"
	@echo "Please manually kill the openocd after gbd quit"
	@echo "-----------------------------------------------"
	@${OPENOCD} -f ${CFG} &
	@${GDB} os.elf -q -x ../gdbinit -x watch_mscratch.gdb

.PHONY : code
code: all
	@${OBJDUMP} -S os.elf > os.asm

.PHONY : clean
clean:
	rm -rf *.o *.bin *.elf build/*.o build/*.bin build/*.elf