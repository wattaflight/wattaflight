MCU_ARCH_FLAGS := -mthumb
MCU_INCLUDES   := lib/cmsis/Include
MCU_SOURCES    := src/mcu/stm32/startup.c
MCU_LDSCRIPTS  := src/mcu/stm32/layout.ld

include src/mcu/stm32/$(PLATFORM_FAMILY)/mcu.mk
