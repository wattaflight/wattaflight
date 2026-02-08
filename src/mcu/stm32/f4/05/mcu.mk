MCU_INCLUDES += src/mcu/stm32/f4/05
MCU_SOURCES  += src/mcu/stm32/f4/05/vector.s

include src/mcu/stm32/f4/05/$(PLATFORM_FLASH)/mcu.mk
