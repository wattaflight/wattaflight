@
@ Vector table for STM32F405xx
@
    .syntax unified
    .thumb

    .extern reset_handler
    .extern default_handler

    .section .vector_table, "a", %progbits

    .word _estack
    .word reset_handler

    .word exc_nmi
    .word exc_hardfault
    .word exc_memmanage
    .word exc_busfault
    .word exc_usagefault
    .word 0
    .word 0
    .word 0
    .word 0
    .word exc_svc
    .word exc_debug_mon
    .word 0
    .word exc_pendsv
    .word exc_systick

    .word isr_wwdg
    .word isr_pvd
    .word isr_tamp_stamp
    .word isr_rtc_wkup
    .word isr_flash
    .word isr_rcc
    .word isr_exti0
    .word isr_exti1
    .word isr_exti2
    .word isr_exti3
    .word isr_exti4
    .word isr_dma1_stream0
    .word isr_dma1_stream1
    .word isr_dma1_stream2
    .word isr_dma1_stream3
    .word isr_dma1_stream4
    .word isr_dma1_stream5
    .word isr_dma1_stream6
    .word isr_adc
    .word isr_can1_tx
    .word isr_can1_rx0
    .word isr_can1_rx1
    .word isr_can1_sce
    .word isr_exti9_5
    .word isr_tim1_brk_tim9
    .word isr_tim1_up_tim10
    .word isr_tim1_trg_com_tim11
    .word isr_tim1_cc
    .word isr_tim2
    .word isr_tim3
    .word isr_tim4
    .word isr_i2c1_ev
    .word isr_i2c1_er
    .word isr_i2c2_ev
    .word isr_i2c2_er
    .word isr_spi1
    .word isr_spi2
    .word isr_usart1
    .word isr_usart2
    .word isr_usart3
    .word isr_exti15_10
    .word isr_rtc_alarm
    .word isr_otg_fs_wkup
    .word isr_tim8_brk_tim12
    .word isr_tim8_up_tim13
    .word isr_tim8_trg_com_tim14
    .word isr_tim8_cc
    .word isr_dma1_stream7
    .word isr_fsmc
    .word isr_sdio
    .word isr_tim5
    .word isr_spi3
    .word isr_uart4
    .word isr_uart5
    .word isr_tim6_dac
    .word isr_tim7
    .word isr_dma2_stream0
    .word isr_dma2_stream1
    .word isr_dma2_stream2
    .word isr_dma2_stream3
    .word isr_dma2_stream4
    .word 0
    .word 0
    .word isr_can2_tx
    .word isr_can2_rx0
    .word isr_can2_rx1
    .word isr_can2_sce
    .word isr_otg_fs
    .word isr_dma2_stream5
    .word isr_dma2_stream6
    .word isr_dma2_stream7
    .word isr_usart6
    .word isr_i2c3_ev
    .word isr_i2c3_er
    .word isr_otg_hs_ep1_out
    .word isr_otg_hs_ep1_in
    .word isr_otg_hs_wkup
    .word isr_otg_hs
    .word 0
    .word 0
    .word isr_hash_rng
    .word isr_fpu

@
@ Weak aliases
@
    .weak      exc_nmi
    .thumb_set exc_nmi, default_handler

    .weak      exc_hardfault
    .thumb_set exc_hardfault, default_handler

    .weak      exc_memmanage
    .thumb_set exc_memmanage, default_handler

    .weak      exc_busfault
    .thumb_set exc_busfault, default_handler

    .weak      exc_usagefault
    .thumb_set exc_usagefault, default_handler

    .weak      exc_svc
    .thumb_set exc_svc, default_handler

    .weak      exc_debug_mon
    .thumb_set exc_debug_mon, default_handler

    .weak      exc_pendsv
    .thumb_set exc_pendsv, default_handler

    .weak      exc_systick
    .thumb_set exc_systick, default_handler

    .weak      isr_wwdg
    .thumb_set isr_wwdg, default_handler

    .weak      isr_pvd
    .thumb_set isr_pvd, default_handler

    .weak      isr_tamp_stamp
    .thumb_set isr_tamp_stamp, default_handler

    .weak      isr_rtc_wkup
    .thumb_set isr_rtc_wkup, default_handler

    .weak      isr_flash
    .thumb_set isr_flash, default_handler

    .weak      isr_rcc
    .thumb_set isr_rcc, default_handler

    .weak      isr_exti0
    .thumb_set isr_exti0, default_handler

    .weak      isr_exti1
    .thumb_set isr_exti1, default_handler

    .weak      isr_exti2
    .thumb_set isr_exti2, default_handler

    .weak      isr_exti3
    .thumb_set isr_exti3, default_handler

    .weak      isr_exti4
    .thumb_set isr_exti4, default_handler

    .weak      isr_dma1_stream0
    .thumb_set isr_dma1_stream0, default_handler

    .weak      isr_dma1_stream1
    .thumb_set isr_dma1_stream1, default_handler

    .weak      isr_dma1_stream2
    .thumb_set isr_dma1_stream2, default_handler

    .weak      isr_dma1_stream3
    .thumb_set isr_dma1_stream3, default_handler

    .weak      isr_dma1_stream4
    .thumb_set isr_dma1_stream4, default_handler

    .weak      isr_dma1_stream5
    .thumb_set isr_dma1_stream5, default_handler

    .weak      isr_dma1_stream6
    .thumb_set isr_dma1_stream6, default_handler

    .weak      isr_adc
    .thumb_set isr_adc, default_handler

    .weak      isr_can1_tx
    .thumb_set isr_can1_tx, default_handler

    .weak      isr_can1_rx0
    .thumb_set isr_can1_rx0, default_handler

    .weak      isr_can1_rx1
    .thumb_set isr_can1_rx1, default_handler

    .weak      isr_can1_sce
    .thumb_set isr_can1_sce, default_handler

    .weak      isr_exti9_5
    .thumb_set isr_exti9_5, default_handler

    .weak      isr_tim1_brk_tim9
    .thumb_set isr_tim1_brk_tim9, default_handler

    .weak      isr_tim1_up_tim10
    .thumb_set isr_tim1_up_tim10, default_handler

    .weak      isr_tim1_trg_com_tim11
    .thumb_set isr_tim1_trg_com_tim11, default_handler

    .weak      isr_tim1_cc
    .thumb_set isr_tim1_cc, default_handler

    .weak      isr_tim2
    .thumb_set isr_tim2, default_handler

    .weak      isr_tim3
    .thumb_set isr_tim3, default_handler

    .weak      isr_tim4
    .thumb_set isr_tim4, default_handler

    .weak      isr_i2c1_ev
    .thumb_set isr_i2c1_ev, default_handler

    .weak      isr_i2c1_er
    .thumb_set isr_i2c1_er, default_handler

    .weak      isr_i2c2_ev
    .thumb_set isr_i2c2_ev, default_handler

    .weak      isr_i2c2_er
    .thumb_set isr_i2c2_er, default_handler

    .weak      isr_spi1
    .thumb_set isr_spi1, default_handler

    .weak      isr_spi2
    .thumb_set isr_spi2, default_handler

    .weak      isr_usart1
    .thumb_set isr_usart1, default_handler

    .weak      isr_usart2
    .thumb_set isr_usart2, default_handler

    .weak      isr_usart3
    .thumb_set isr_usart3, default_handler

    .weak      isr_exti15_10
    .thumb_set isr_exti15_10, default_handler

    .weak      isr_rtc_alarm
    .thumb_set isr_rtc_alarm, default_handler

    .weak      isr_otg_fs_wkup
    .thumb_set isr_otg_fs_wkup, default_handler

    .weak      isr_tim8_brk_tim12
    .thumb_set isr_tim8_brk_tim12, default_handler

    .weak      isr_tim8_up_tim13
    .thumb_set isr_tim8_up_tim13, default_handler

    .weak      isr_tim8_trg_com_tim14
    .thumb_set isr_tim8_trg_com_tim14, default_handler

    .weak      isr_tim8_cc
    .thumb_set isr_tim8_cc, default_handler

    .weak      isr_dma1_stream7
    .thumb_set isr_dma1_stream7, default_handler

    .weak      isr_fsmc
    .thumb_set isr_fsmc, default_handler

    .weak      isr_sdio
    .thumb_set isr_sdio, default_handler

    .weak      isr_tim5
    .thumb_set isr_tim5, default_handler

    .weak      isr_spi3
    .thumb_set isr_spi3, default_handler

    .weak      isr_uart4
    .thumb_set isr_uart4, default_handler

    .weak      isr_uart5
    .thumb_set isr_uart5, default_handler

    .weak      isr_tim6_dac
    .thumb_set isr_tim6_dac, default_handler

    .weak      isr_tim7
    .thumb_set isr_tim7, default_handler

    .weak      isr_dma2_stream0
    .thumb_set isr_dma2_stream0, default_handler

    .weak      isr_dma2_stream1
    .thumb_set isr_dma2_stream1, default_handler

    .weak      isr_dma2_stream2
    .thumb_set isr_dma2_stream2, default_handler

    .weak      isr_dma2_stream3
    .thumb_set isr_dma2_stream3, default_handler

    .weak      isr_dma2_stream4
    .thumb_set isr_dma2_stream4, default_handler

    .weak      isr_can2_tx
    .thumb_set isr_can2_tx, default_handler

    .weak      isr_can2_rx0
    .thumb_set isr_can2_rx0, default_handler

    .weak      isr_can2_rx1
    .thumb_set isr_can2_rx1, default_handler

    .weak      isr_can2_sce
    .thumb_set isr_can2_sce, default_handler

    .weak      isr_otg_fs
    .thumb_set isr_otg_fs, default_handler

    .weak      isr_dma2_stream5
    .thumb_set isr_dma2_stream5, default_handler

    .weak      isr_dma2_stream6
    .thumb_set isr_dma2_stream6, default_handler

    .weak      isr_dma2_stream7
    .thumb_set isr_dma2_stream7, default_handler

    .weak      isr_usart6
    .thumb_set isr_usart6, default_handler

    .weak      isr_i2c3_ev
    .thumb_set isr_i2c3_ev, default_handler

    .weak      isr_i2c3_er
    .thumb_set isr_i2c3_er, default_handler

    .weak      isr_otg_hs_ep1_out
    .thumb_set isr_otg_hs_ep1_out, default_handler

    .weak      isr_otg_hs_ep1_in
    .thumb_set isr_otg_hs_ep1_in, default_handler

    .weak      isr_otg_hs_wkup
    .thumb_set isr_otg_hs_wkup, default_handler

    .weak      isr_otg_hs
    .thumb_set isr_otg_hs, default_handler

    .weak      isr_hash_rng
    .thumb_set isr_hash_rng, default_handler

    .weak      isr_fpu
    .thumb_set isr_fpu, default_handler

    .end
