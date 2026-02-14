/*
 * SPDX-FileCopyrightText:  2026 WattaFlight contributors
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

@
@ Vector table for STM32H743xx
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
    .word isr_pvd_avd
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
    .word isr_fdcan1_it0
    .word isr_fdcan2_it0
    .word isr_fdcan1_it1
    .word isr_fdcan2_it1
    .word isr_exti9_5
    .word isr_tim1_brk
    .word isr_tim1_up
    .word isr_tim1_trg_com
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
    .word 0
    .word isr_tim8_brk_tim12
    .word isr_tim8_up_tim13
    .word isr_tim8_trg_com_tim14
    .word isr_tim8_cc
    .word isr_dma1_stream7
    .word isr_fmc
    .word isr_sdmmc1
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
    .word isr_eth
    .word isr_eth_wkup
    .word isr_fdcan_cal
    .word 0
    .word 0
    .word 0
    .word 0
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
    .word isr_dcmi
    .word 0
    .word isr_rng
    .word isr_fpu
    .word isr_uart7
    .word isr_uart8
    .word isr_spi4
    .word isr_spi5
    .word isr_spi6
    .word isr_sai1
    .word isr_ltdc
    .word isr_ltdc_er
    .word isr_dma2d
    .word isr_sai2
    .word isr_quadspi
    .word isr_lptim1
    .word isr_cec
    .word isr_i2c4_ev
    .word isr_i2c4_er
    .word isr_spdif_rx
    .word isr_otg_fs_ep1_out
    .word isr_otg_fs_ep1_in
    .word isr_otg_fs_wkup
    .word isr_otg_fs
    .word isr_dmamux1_ovr
    .word isr_hrtim1_master
    .word isr_hrtim1_tima
    .word isr_hrtim1_timb
    .word isr_hrtim1_timc
    .word isr_hrtim1_timd
    .word isr_hrtim1_time
    .word isr_hrtim1_flt
    .word isr_dfsdm1_flt0
    .word isr_dfsdm1_flt1
    .word isr_dfsdm1_flt2
    .word isr_dfsdm1_flt3
    .word isr_sai3
    .word isr_swpmi1
    .word isr_tim15
    .word isr_tim16
    .word isr_tim17
    .word isr_mdios_wkup
    .word isr_mdios
    .word isr_jpeg
    .word isr_mdma
    .word 0
    .word isr_sdmmc2
    .word isr_hsem1
    .word 0
    .word isr_adc3
    .word isr_dmamux2_ovr
    .word isr_bdma_channel0
    .word isr_bdma_channel1
    .word isr_bdma_channel2
    .word isr_bdma_channel3
    .word isr_bdma_channel4
    .word isr_bdma_channel5
    .word isr_bdma_channel6
    .word isr_bdma_channel7
    .word isr_comp1
    .word isr_lptim2
    .word isr_lptim3
    .word isr_lptim4
    .word isr_lptim5
    .word isr_lpuart1
    .word 0
    .word isr_crs
    .word isr_ecc
    .word isr_sai4
    .word 0
    .word 0
    .word isr_wakeup_pin

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

    .weak      isr_pvd_avd
    .thumb_set isr_pvd_avd, default_handler

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

    .weak      isr_fdcan1_it0
    .thumb_set isr_fdcan1_it0, default_handler

    .weak      isr_fdcan2_it0
    .thumb_set isr_fdcan2_it0, default_handler

    .weak      isr_fdcan1_it1
    .thumb_set isr_fdcan1_it1, default_handler

    .weak      isr_fdcan2_it1
    .thumb_set isr_fdcan2_it1, default_handler

    .weak      isr_exti9_5
    .thumb_set isr_exti9_5, default_handler

    .weak      isr_tim1_brk
    .thumb_set isr_tim1_brk, default_handler

    .weak      isr_tim1_up
    .thumb_set isr_tim1_up, default_handler

    .weak      isr_tim1_trg_com
    .thumb_set isr_tim1_trg_com, default_handler

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

    .weak      isr_fmc
    .thumb_set isr_fmc, default_handler

    .weak      isr_sdmmc1
    .thumb_set isr_sdmmc1, default_handler

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

    .weak      isr_eth
    .thumb_set isr_eth, default_handler

    .weak      isr_eth_wkup
    .thumb_set isr_eth_wkup, default_handler

    .weak      isr_fdcan_cal
    .thumb_set isr_fdcan_cal, default_handler

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

    .weak      isr_dcmi
    .thumb_set isr_dcmi, default_handler

    .weak      isr_rng
    .thumb_set isr_rng, default_handler

    .weak      isr_fpu
    .thumb_set isr_fpu, default_handler

    .weak      isr_uart7
    .thumb_set isr_uart7, default_handler

    .weak      isr_uart8
    .thumb_set isr_uart8, default_handler

    .weak      isr_spi4
    .thumb_set isr_spi4, default_handler

    .weak      isr_spi5
    .thumb_set isr_spi5, default_handler

    .weak      isr_spi6
    .thumb_set isr_spi6, default_handler

    .weak      isr_sai1
    .thumb_set isr_sai1, default_handler

    .weak      isr_ltdc
    .thumb_set isr_ltdc, default_handler

    .weak      isr_ltdc_er
    .thumb_set isr_ltdc_er, default_handler

    .weak      isr_dma2d
    .thumb_set isr_dma2d, default_handler

    .weak      isr_sai2
    .thumb_set isr_sai2, default_handler

    .weak      isr_quadspi
    .thumb_set isr_quadspi, default_handler

    .weak      isr_lptim1
    .thumb_set isr_lptim1, default_handler

    .weak      isr_cec
    .thumb_set isr_cec, default_handler

    .weak      isr_i2c4_ev
    .thumb_set isr_i2c4_ev, default_handler

    .weak      isr_i2c4_er
    .thumb_set isr_i2c4_er, default_handler

    .weak      isr_spdif_rx
    .thumb_set isr_spdif_rx, default_handler

    .weak      isr_otg_fs_ep1_out
    .thumb_set isr_otg_fs_ep1_out, default_handler

    .weak      isr_otg_fs_ep1_in
    .thumb_set isr_otg_fs_ep1_in, default_handler

    .weak      isr_otg_fs_wkup
    .thumb_set isr_otg_fs_wkup, default_handler

    .weak      isr_otg_fs
    .thumb_set isr_otg_fs, default_handler

    .weak      isr_dmamux1_ovr
    .thumb_set isr_dmamux1_ovr, default_handler

    .weak      isr_hrtim1_master
    .thumb_set isr_hrtim1_master, default_handler

    .weak      isr_hrtim1_tima
    .thumb_set isr_hrtim1_tima, default_handler

    .weak      isr_hrtim1_timb
    .thumb_set isr_hrtim1_timb, default_handler

    .weak      isr_hrtim1_timc
    .thumb_set isr_hrtim1_timc, default_handler

    .weak      isr_hrtim1_timd
    .thumb_set isr_hrtim1_timd, default_handler

    .weak      isr_hrtim1_time
    .thumb_set isr_hrtim1_time, default_handler

    .weak      isr_hrtim1_flt
    .thumb_set isr_hrtim1_flt, default_handler

    .weak      isr_dfsdm1_flt0
    .thumb_set isr_dfsdm1_flt0, default_handler

    .weak      isr_dfsdm1_flt1
    .thumb_set isr_dfsdm1_flt1, default_handler

    .weak      isr_dfsdm1_flt2
    .thumb_set isr_dfsdm1_flt2, default_handler

    .weak      isr_dfsdm1_flt3
    .thumb_set isr_dfsdm1_flt3, default_handler

    .weak      isr_sai3
    .thumb_set isr_sai3, default_handler

    .weak      isr_swpmi1
    .thumb_set isr_swpmi1, default_handler

    .weak      isr_tim15
    .thumb_set isr_tim15, default_handler

    .weak      isr_tim16
    .thumb_set isr_tim16, default_handler

    .weak      isr_tim17
    .thumb_set isr_tim17, default_handler

    .weak      isr_mdios_wkup
    .thumb_set isr_mdios_wkup, default_handler

    .weak      isr_mdios
    .thumb_set isr_mdios, default_handler

    .weak      isr_jpeg
    .thumb_set isr_jpeg, default_handler

    .weak      isr_mdma
    .thumb_set isr_mdma, default_handler

    .weak      isr_sdmmc2
    .thumb_set isr_sdmmc2, default_handler

    .weak      isr_hsem1
    .thumb_set isr_hsem1, default_handler

    .weak      isr_adc3
    .thumb_set isr_adc3, default_handler

    .weak      isr_dmamux2_ovr
    .thumb_set isr_dmamux2_ovr, default_handler

    .weak      isr_bdma_channel0
    .thumb_set isr_bdma_channel0, default_handler

    .weak      isr_bdma_channel1
    .thumb_set isr_bdma_channel1, default_handler

    .weak      isr_bdma_channel2
    .thumb_set isr_bdma_channel2, default_handler

    .weak      isr_bdma_channel3
    .thumb_set isr_bdma_channel3, default_handler

    .weak      isr_bdma_channel4
    .thumb_set isr_bdma_channel4, default_handler

    .weak      isr_bdma_channel5
    .thumb_set isr_bdma_channel5, default_handler

    .weak      isr_bdma_channel6
    .thumb_set isr_bdma_channel6, default_handler

    .weak      isr_bdma_channel7
    .thumb_set isr_bdma_channel7, default_handler

    .weak      isr_comp1
    .thumb_set isr_comp1, default_handler

    .weak      isr_lptim2
    .thumb_set isr_lptim2, default_handler

    .weak      isr_lptim3
    .thumb_set isr_lptim3, default_handler

    .weak      isr_lptim4
    .thumb_set isr_lptim4, default_handler

    .weak      isr_lptim5
    .thumb_set isr_lptim5, default_handler

    .weak      isr_lpuart1
    .thumb_set isr_lpuart1, default_handler

    .weak      isr_crs
    .thumb_set isr_crs, default_handler

    .weak      isr_ecc
    .thumb_set isr_ecc, default_handler

    .weak      isr_sai4
    .thumb_set isr_sai4, default_handler

    .weak      isr_wakeup_pin
    .thumb_set isr_wakeup_pin, default_handler

    .end
