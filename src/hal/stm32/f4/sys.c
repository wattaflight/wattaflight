#include "hal/base/sys.h"
#include "base/panic.h"

#include "mcu.h"
#include "target.h"

#ifdef XTAL_MHZ
    #define HSE_MHZ XTAL_MHZ
#else
    #define HSE_MHZ 8
#endif

typedef struct {
    uint16_t m, n, p, q;
    uint8_t  ws;
} pll_config_t;

static pll_config_t select_pll_config(uint16_t sysclk_mhz) {
    constexpr uint8_t mmul = HSE_MHZ / 8;

    switch (sysclk_mhz) {
    case 168: return (pll_config_t){.m = 4 * mmul, .n = 168, .p = 2, .q = 7, .ws = 5};
    }

    unreachable();
}

void sys_init(void) {
    constexpr uint16_t sysclk_mhz = RCC_MAX_FREQUENCY / 1'000'000;
    const pll_config_t pll_cfg    = select_pll_config(sysclk_mhz);

    // Switch to HSI
    RCC->CFGR = (RCC->CFGR & ~RCC_CFGR_SW) | RCC_CFGR_SW_HSI;
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_HSI)
        ;

    // Enable Flash prefetch, instruction cache, and data cache
    FLASH->ACR |= FLASH_ACR_PRFTEN | FLASH_ACR_ICEN | FLASH_ACR_DCEN;
    // Set Flash wait states
    FLASH->ACR = (FLASH->ACR & ~FLASH_ACR_LATENCY) | pll_cfg.ws;
    while ((FLASH->ACR & FLASH_ACR_LATENCY) != pll_cfg.ws)
        ;

    // Enable HSE
    RCC->CR |= RCC_CR_HSEON;
    while (!(RCC->CR & RCC_CR_HSERDY))
        ;

    // Disable PLL
    RCC->CR &= ~RCC_CR_PLLON;
    while (RCC->CR & RCC_CR_PLLRDY)
        ;

    // Configure PLL
    RCC->PLLCFGR = (RCC->PLLCFGR & ~(RCC_PLLCFGR_PLLSRC |            //
                                     RCC_PLLCFGR_PLLM |              //
                                     RCC_PLLCFGR_PLLN |              //
                                     RCC_PLLCFGR_PLLP |              //
                                     RCC_PLLCFGR_PLLQ)) |            //
                   RCC_PLLCFGR_PLLSRC_HSE |                          //
                   (pll_cfg.m << RCC_PLLCFGR_PLLM_Pos) |             //
                   (pll_cfg.n << RCC_PLLCFGR_PLLN_Pos) |             //
                   (((pll_cfg.p / 2) - 1) << RCC_PLLCFGR_PLLP_Pos) | //
                   (pll_cfg.q << RCC_PLLCFGR_PLLQ_Pos);              //

    // Configure bus dividers
    RCC->CFGR = (RCC->CFGR & ~(RCC_CFGR_HPRE |    //
                               RCC_CFGR_PPRE1 |   //
                               RCC_CFGR_PPRE2)) | //
                RCC_CFGR_HPRE_DIV1 |              // AHB  = SYSCLK / 1
                RCC_CFGR_PPRE1_DIV4 |             // APB1 = SYSCLK / 4
                RCC_CFGR_PPRE2_DIV2;              // APB2 = SYSCLK / 2

    // Enable PLL
    RCC->CR |= RCC_CR_PLLON;
    while (!(RCC->CR & RCC_CR_PLLRDY))
        ;

    // Switch to PLL
    RCC->CFGR = (RCC->CFGR & ~RCC_CFGR_SW) | RCC_CFGR_SW_PLL;
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL)
        ;

    // Configure SysTick for 1 ms tick
    SysTick_Config(sysclk_mhz * 1'000);
}
