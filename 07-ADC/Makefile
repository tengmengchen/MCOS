include ../common.mk

# 源码目录列表（主目录 + BSP子目录）
SRC_DIRS := . ./BSP/wch/ch32v307/drivers
INCLUDE_DIRS := -I. -I./BSP/wch/ch32v307/include/drivers
CFLAGS += $(INCLUDE_DIRS)

SRCS_C := $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.c))
SRCS_S := $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.S))
# $(info SRCS_C = $(SRCS_C))

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
	@${GDB} build/os.elf -q -x ../gdbinit

.PHONY : code
code: all
	@${OBJDUMP} -S os.elf > os.asm

.PHONY : clean
clean:
	rm -rf *.o *.bin *.elf build/*.o build/*.bin build/*.elf