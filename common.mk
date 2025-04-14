CROSS_COMPILE := ../../Toolchain_linux/MRS_Toolchain_Linux_x64_V1.92.1/RISC-V_Embedded_GCC/bin/riscv-none-embed-


OPENOCD_DIR = ../../Toolchain_linux/MRS_Toolchain_Linux_x64_V1.92.1/OpenOCD/bin
CFLAGS = -nostdlib -fno-builtin -march=rv32imac -mabi=ilp32 -g -Wall -O0


OPENOCD = ${OPENOCD_DIR}/openocd
CFG = ${OPENOCD_DIR}/wch-riscv.cfg

CC = ${CROSS_COMPILE}gcc
GDB := ${CROSS_COMPILE}gdb
OBJCOPY = ${CROSS_COMPILE}objcopy
OBJDUMP = ${CROSS_COMPILE}objdump