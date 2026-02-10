#include "hal/base/sys.h"

#include "mcu.h"
#include "target.h"

#ifdef XTAL_HZ
#define HSE_HZ XTAL_HZ
#else
#define HSE_HZ 8'000'000
#endif

void sys_init(void) {
    constexpr uint32_t VCO_HZ = 2'000'000;
    constexpr uint32_t PLLM   = HSE_HZ / VCO_HZ;
    constexpr uint32_t PLLN   = 168;
    constexpr uint32_t PLLP   = 2;
    constexpr uint32_t PLLQ   = 7;

    static_assert(HSE_HZ % VCO_HZ == 0, "HSE must be divisible by VCO");
    static_assert(PLLN * VCO_HZ / PLLP == SYSCLK_HZ, "SYSCLK must be 168 MHz");
    static_assert(PLLN * VCO_HZ / PLLQ == USBCLK_HZ, "USB clock must be 48 MHz");

    // Enable HSE
    RCC->CR |= RCC_CR_HSEON;
    while (!(RCC->CR & RCC_CR_HSERDY))
        ;

    // Enable Power interface clock
    RCC->APB1ENR |= RCC_APB1ENR_PWREN;
    // Ensure PWR is available
    (void)RCC->APB1ENR;

    // Set voltage regulator scale 1 (high performance)
    PWR->CR |= PWR_CR_VOS;
    while (!(PWR->CSR & PWR_CSR_VOSRDY))
        ;

    // Configure bus prescalers
    RCC->CFGR = (RCC->CFGR & ~(RCC_CFGR_HPRE |    //
                               RCC_CFGR_PPRE1 |   //
                               RCC_CFGR_PPRE2)) | //
                RCC_CFGR_HPRE_DIV1 |              // AHB  = SYSCLK / 1 = 168 MHz
                RCC_CFGR_PPRE1_DIV4 |             // APB1 = SYSCLK / 4 = 42 MHz  (max 42 MHz)
                RCC_CFGR_PPRE2_DIV2;              // APB2 = SYSCLK / 2 = 84 MHz  (max 84 MHz)

    // Disable PLL
    RCC->CR &= ~RCC_CR_PLLON;
    while (RCC->CR & RCC_CR_PLLRDY)
        ;

    // Configure PLL
    RCC->PLLCFGR = (RCC->PLLCFGR & ~(RCC_PLLCFGR_PLLSRC |       //
                                     RCC_PLLCFGR_PLLM |         //
                                     RCC_PLLCFGR_PLLN |         //
                                     RCC_PLLCFGR_PLLP |         //
                                     RCC_PLLCFGR_PLLQ)) |       //
                   RCC_PLLCFGR_PLLSRC_HSE |                     //
                   (PLLM << RCC_PLLCFGR_PLLM_Pos) |             //
                   (PLLN << RCC_PLLCFGR_PLLN_Pos) |             //
                   (((PLLP / 2) - 1) << RCC_PLLCFGR_PLLP_Pos) | //
                   (PLLQ << RCC_PLLCFGR_PLLQ_Pos);              //

    // Enable PLL
    RCC->CR |= RCC_CR_PLLON;
    while (!(RCC->CR & RCC_CR_PLLRDY))
        ;

    // Enable Flash prefetch, instruction cache, and data cache
    FLASH->ACR |= FLASH_ACR_PRFTEN | FLASH_ACR_ICEN | FLASH_ACR_DCEN;
    // Set Flash wait states to 5 (required for 168 MHz @ 3.3V)
    FLASH->ACR = (FLASH->ACR & ~FLASH_ACR_LATENCY) | FLASH_ACR_LATENCY_5WS;
    while ((FLASH->ACR & FLASH_ACR_LATENCY) != FLASH_ACR_LATENCY_5WS)
        ;

    // Switch to PLL
    RCC->CFGR = (RCC->CFGR & ~RCC_CFGR_SW) | RCC_CFGR_SW_PLL;
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL)
        ;

    // Configure SysTick for 1 ms tick
    SysTick_Config(SYSCLK_HZ / 1'000);
}
