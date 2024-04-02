ARCH=/opt/homebrew/Cellar/riscv-gnu-toolchain/main/bin/riscv64-unknown-elf
SRCMAIN = main.c
CC = $(ARCH)-gcc
CXX = $(ARCH)-g++
LD = $(ARCH)-gcc
TARGET_NAME=main

INCLUDES=
FLAGS=-march=rv32imac -mabi=ilp32 -mcmodel=medany -ffunction-sections -fdata-sections -Wall -Wl,-Map="$(TARGET_NAME).map"

#optimize
#CFLAG_OPT=-O4
#CFLAG_OPT=-O0
CFLAG_OPT=-Os -ffreestanding
CFLAG_STD=gnu11
#CFLAG_STD=gnu99

#custom
CFLAG_CUSTOM=

CFLAGS = $(FLAGS) ${CFLAG_OPT} -std=$(CFLAG_STD) $(CFLAG_CUSTOM)
CXXFLAGS = $(FLAGS) ${CFLAG_OPT} -std=c++2a

LDFLAGS = $(FLAGS) -Tc4ij.ld -Wl,--gc-section -nostartfiles -Wmain
TARGET = $(TARGET_NAME).elf

CSRCS=$(SRCMAIN)
#CXXSRCS = $(wildcard src/*.cpp)
ASMSRCS = $(wildcard $(SRCPATH)/*.s)
OBJS = $(addprefix ,$(notdir $(CXXSRCS:.cpp=.o) $(CSRCS:.c=.o) $(ASMSRCS:.s=.o)))

all: $(TARGET) dump15
	$(ARCH)-size $(TARGET)
	#deno run --allow-read https://code4fukui.github.io/dump/dump15.js $(TARGET_NAME).bin
	./dump15 $(TARGET_NAME).bin

dump15: dump15
	gcc dump15.c -o dump15

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^
	$(ARCH)-objdump -D $(TARGET_NAME).elf > $(TARGET_NAME).dmp
	$(ARCH)-objcopy -O binary $(TARGET) $(TARGET:.elf=.bin)

#obj/%.o: ../src/%.cpp
#	$(CXX) $(CXXFLAGS) $(addprefix -I,$(INCLUDES)) -c -o $@ $^

%.o: $(SRCPATH)/%.c
	$(CC) $(CFLAGS) $(addprefix -I,$(INCLUDES)) -c -o $@ $^
main.o: $(SRCMAIN)
	$(CC) $(CFLAGS) $(addprefix -I,$(INCLUDES)) -c -o $@ $^

%.o: $(SRCPATH)/%.s
	$(CC) -x assembler-with-cpp $(addprefix -I,$(INCLUDES)) $(CFLAGS) -c -o $@ $^

clean:
	$(RM) $(TARGET) $(TARGET:.elf=.bin) *.o *.dmp *.map dump15
