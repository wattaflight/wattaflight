MCU_ARCH_FLAGS := -mthumb
MCU_INCLUDES   := lib/cmsis/Include
MCU_SOURCES    := src/mcu/stm32/startup.c

include src/mcu/stm32/$(PLATFORM_FAMILY)/mcu.mk
