MCU_ARCH_FLAGS += -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard
MCU_INCLUDES   += lib/cmsis_stm32f4/Include

include src/mcu/stm32/f4/$(PLATFORM_LINE)/mcu.mk
