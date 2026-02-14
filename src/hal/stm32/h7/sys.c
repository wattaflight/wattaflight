/*
 * SPDX-FileCopyrightText:  2026 WattaFlight contributors
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include "hal/base/sys.h"
#include "base/memory.h"
#include "base/panic.h"

#include "mcu.h"
#include "target.h"

#ifdef XTAL_HZ
    #define HSE_HZ XTAL_HZ
#else
    #define HSE_HZ 8'000'000
#endif

typedef struct {
    uint16_t sysclk_mhz, hse_mhz;
    uint16_t m, n, p, q, r;
    uint8_t  rge, ws;
} pll_config_t;

constexpr pll_config_t pll_table[] = {
    {520, 8,  .m = 1, .n = 65, .p = 1, .q = 4, .r = 2, .rge = 3, .ws = 3},
    {520, 16, .m = 2, .n = 65, .p = 1, .q = 4, .r = 2, .rge = 3, .ws = 3},
    {480, 8,  .m = 1, .n = 60, .p = 1, .q = 4, .r = 2, .rge = 3, .ws = 3},
    {480, 16, .m = 2, .n = 60, .p = 1, .q = 4, .r = 2, .rge = 3, .ws = 3},
    {400, 8,  .m = 1, .n = 50, .p = 1, .q = 4, .r = 2, .rge = 3, .ws = 2},
    {400, 16, .m = 2, .n = 50, .p = 1, .q = 4, .r = 2, .rge = 3, .ws = 2},
};

static pll_config_t select_pll_config(uint32_t sysclk_mhz) {
    for (unsigned int i = 0; i < lengthof(pll_table); i++) {
        auto cfg = pll_table[i];
        if (cfg.sysclk_mhz == sysclk_mhz && cfg.hse_mhz * 1000 == HSE_HZ) {
            return cfg;
        }
    }

    unreachable();
}

void sys_init(void) {
    uint32_t sysclk_mhz;
#ifdef STM32H7_LINE_CLASSIC
    uint32_t rev_id = (DBGMCU->IDCODE & DBGMCU_IDCODE_REV_ID) >> DBGMCU_IDCODE_REV_ID_Pos;

    // Lock power supply to LDO (default)
    PWR->CR3 &= ~PWR_CR3_SCUEN;

    // Set VOS1 (up to 400 MHz)
    PWR->D3CR |= PWR_D3CR_VOS_0 | PWR_D3CR_VOS_1;
    while (!(PWR->D3CR & PWR_D3CR_VOSRDY))
        ;
    sysclk_mhz = 400;

    // Engage VOS0 (up to 480 MHz) for all but Rev Y revisions
    if (rev_id != 0x1003) {
        // Enable SYSCFG clock
        RCC->APB4ENR |= RCC_APB4ENR_SYSCFGEN;
        (void)RCC->APB4ENR;

        // Enable overdrive mode
        SYSCFG->PWRCR |= SYSCFG_PWRCR_ODEN;
        while (!(PWR->D3CR & PWR_D3CR_VOSRDY))
            ;
        sysclk_mhz = 480;
    }
#elifdef STM32H7_LINE_FAST
    // For SMPS capable MCUs, assume it's used
    #ifdef SMPS
    // Switch from LDO to SMPS
    PWR->CR3 = (PWR->CR3 & ~PWR_CR3_LDOEN) | PWR_CR3_SMPSEN;
    while (!(PWR->CSR1 & PWR_CSR1_ACTVOSRDY))
        ;
    #endif

    // Set VOS0 (up to 550 MHz)
    // But stick with 520 MHz as going higher requires ECC to be disabled
    PWR->D3CR &= ~(PWR_D3CR_VOS_0 | PWR_D3CR_VOS_1);
    while (!(PWR->D3CR & PWR_D3CR_VOSRDY))
        ;
    sysclk_mhz = 520;
#else
    #error "Unknown MCU"
#endif
    const pll_config_t pll_cfg = select_pll_config(sysclk_mhz);

    // Enable HSE
    RCC->CR |= RCC_CR_HSEON;
    while (!(RCC->CR & RCC_CR_HSERDY))
        ;

    // Set Flash wait states and programming delay
    // These happen to be mapped 1:1
    FLASH->ACR = (FLASH->ACR & ~(FLASH_ACR_LATENCY |       //
                                 FLASH_ACR_WRHIGHFREQ)) |  //
                 (pll_cfg.ws << FLASH_ACR_LATENCY_Pos) |   //
                 (pll_cfg.ws << FLASH_ACR_WRHIGHFREQ_Pos); //
    while ((FLASH->ACR & FLASH_ACR_LATENCY) != pll_cfg.ws) //
        ;

    // Disable PLL
    RCC->CR &= ~RCC_CR_PLL1ON;
    while (RCC->CR & RCC_CR_PLL1RDY)
        ;

    // Configure PLL - PLLCKSELR
    RCC->PLLCKSELR = (RCC->PLLCKSELR & ~(RCC_PLLCKSELR_PLLSRC |    //
                                         RCC_PLLCKSELR_DIVM1)) |   //
                     RCC_PLLCKSELR_PLLSRC_HSE |                    //
                     ((pll_cfg.m - 1) << RCC_PLLCKSELR_DIVM1_Pos); //

    // Configure PLL - PLL1DIVR
    RCC->PLL1DIVR = ((((pll_cfg.n - 1) << RCC_PLL1DIVR_N1_Pos) & RCC_PLL1DIVR_N1) | //
                     (((pll_cfg.p - 1) << RCC_PLL1DIVR_P1_Pos) & RCC_PLL1DIVR_P1) | //
                     (((pll_cfg.q - 1) << RCC_PLL1DIVR_Q1_Pos) & RCC_PLL1DIVR_Q1) | //
                     (((pll_cfg.r - 1) << RCC_PLL1DIVR_R1_Pos) & RCC_PLL1DIVR_R1)); //

    // Configure PLL - Input frequency range
    RCC->PLLCFGR = (RCC->PLLCFGR & ~RCC_PLLCFGR_PLL1RGE) |   //
                   (pll_cfg.rge << RCC_PLLCFGR_PLL1RGE_Pos); //

    // Configure bus dividers - AHB
    RCC->D1CFGR = (RCC->D1CFGR & ~RCC_D1CFGR_HPRE) | RCC_D1CFGR_HPRE_DIV2;

    // Configure bus dividers - APB1, APB2
    RCC->D2CFGR = (RCC->D2CFGR & ~(RCC_D2CFGR_D2PPRE1 |   //
                                   RCC_D2CFGR_D2PPRE2)) | //
                  RCC_D2CFGR_D2PPRE1_DIV2 |               //
                  RCC_D2CFGR_D2PPRE2_DIV2;                //

    // Configure bus dividers - APB4
    RCC->D3CFGR = (RCC->D3CFGR & ~RCC_D3CFGR_D3PPRE) | RCC_D3CFGR_D3PPRE_DIV2;

    // Enable PLL
    RCC->CR |= RCC_CR_PLL1ON;
    while (!(RCC->CR & RCC_CR_PLL1RDY))
        ;

    // Switch to PLL
    RCC->CFGR = (RCC->CFGR & ~RCC_CFGR_SW) | RCC_CFGR_SW_PLL1;
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL1)
        ;

    // Configure SysTick for 1 ms tick
    SysTick_Config(sysclk_mhz * 1'000);

    // Enable I-Cache and D-Cache
    SCB_EnableICache();
    SCB_EnableDCache();
}
