# SPDX-FileCopyrightText:  2026 WattaFlight contributors
# SPDX-License-Identifier: GPL-3.0-or-later

# --- Parameters ---

TARGET ?= SPEEDYBEEF405WING
DEBUG  ?=

# --- Toolchain ---

CC      := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy

# --- Project settings ---

FIRMWARE_NAME := fusionflight
BUILD_DIR     := build

# --- Target platform ---

AVAILABLE_TARGETS := $(sort $(notdir $(wildcard src/target/*)))

ifndef TARGET
    $(error No TARGET specified. Run 'make list-targets' for available targets)
endif

ifeq ($(filter $(TARGET),$(AVAILABLE_TARGETS)),)
    $(error TARGET='$(TARGET)' not found. Run 'make list-targets' for available targets)
endif

include src/target/$(TARGET)/target.mk
include src/mcu/$(PLATFORM_VENDOR)/mcu.mk
include src/hal/$(PLATFORM_VENDOR)/hal.mk

# --- Source files ---

SOURCES   := $(MCU_SOURCES) src/main.c
INCLUDES  := $(MCU_INCLUDES) src
LDSCRIPTS := $(MCU_LDSCRIPTS)

# --- Build artifacts ---

FIRMWARE_BASE := $(BUILD_DIR)/$(FIRMWARE_NAME)
FIRMWARE_ELF  := $(FIRMWARE_BASE).elf
FIRMWARE_BIN  := $(FIRMWARE_BASE).bin
FIRMWARE_MAP  := $(FIRMWARE_BASE).map
OBJECTS       := $(addprefix $(BUILD_DIR)/,$(addsuffix .o,$(basename $(SOURCES))))

# --- Compiler flags ---

ifeq ($(DEBUG),1)
OPT_FLAGS := -Og -g3 -DDEBUG
LTO_FLAGS :=
else
OPT_FLAGS := -Os
LTO_FLAGS := -flto=auto -fuse-linker-plugin
endif

CFLAGS := $(MCU_ARCH_FLAGS)
CFLAGS += -std=c23 -pedantic
CFLAGS += -ffreestanding
CFLAGS += $(OPT_FLAGS) $(LTO_FLAGS)
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += -Wall -Wextra -Werror -Wdouble-promotion
CFLAGS += $(addprefix -I,$(INCLUDES))
CFLAGS += -MMD -MP

ASFLAGS := $(MCU_ARCH_FLAGS)

LDFLAGS := $(MCU_ARCH_FLAGS)
LDFLAGS += -nostartfiles
LDFLAGS += --specs=nano.specs --specs=nosys.specs
LDFLAGS += $(LTO_FLAGS)
LDFLAGS += $(addprefix -T,$(LDSCRIPTS))
LDFLAGS += -Wl,--gc-sections
LDFLAGS += -Wl,-Map,$(FIRMWARE_MAP)
LDFLAGS += -Wl,--print-memory-usage

# --- Rules ---

.PHONY: all clean list-targets help

all: $(FIRMWARE_BIN)

$(FIRMWARE_BIN): $(FIRMWARE_ELF)
	$(OBJCOPY) -O binary -S $< $@

$(FIRMWARE_ELF): $(OBJECTS) $(LDSCRIPTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

$(BUILD_DIR)/%.o: %.c $(MAKEFILE_LIST)
	@mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/%.o: %.s $(MAKEFILE_LIST)
	@mkdir -p $(dir $@)
	$(CC) -c $(ASFLAGS) $< -o $@

-include $(OBJECTS:.o=.d)

clean:
	rm -rf $(BUILD_DIR)

list-targets:
	@echo "Available targets:"
	@for target in $(AVAILABLE_TARGETS); do echo "  $$target"; done

help:
	@echo "Usage: make [TARGET=<name>] [DEBUG=1]"
	@echo ""
	@echo "Commands:"
	@echo "  all           Build firmware (default)"
	@echo "  clean         Remove build artifacts"
	@echo "  list-targets  Show available hardware targets"
	@echo "  help          Show this help message"
	@echo ""
	@echo "Parameters:"
	@echo "  TARGET=<name> Hardware target (default: SPEEDYBEEF405WING)"
	@echo "  DEBUG=1       Build with debug symbols and optimizations disabled"
