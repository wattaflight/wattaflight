MCU_INCLUDES += src/mcu/stm32/f4/x5
MCU_SOURCES  += src/mcu/stm32/f4/x5/vector.s

include src/mcu/stm32/f4/x5/$(PLATFORM_FLASH)/mcu.mk
