MCU_ARCH_FLAGS += -mcpu=cortex-m7 -mfpu=fpv5-d16 -mfloat-abi=hard
MCU_INCLUDES   += lib/cmsis_stm32h7/Include

include src/mcu/stm32/h7/$(PLATFORM_LINE)/mcu.mk
