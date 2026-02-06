/*
 * SPDX-FileCopyrightText:  2026 WattaFlight contributors
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include <string.h>

#include "mcu.h"

extern void main(void);

extern char _sidata, _sdata, _edata, _sbss, _ebss;
extern char _sifastdata, _sfastdata, _efastdata, _sfastbss, _efastbss;

void reset_handler(void)
{
    // Initialize .data and .fastdata sections
    memcpy(&_sdata, &_sidata, &_edata - &_sdata);
    memcpy(&_sfastdata, &_sifastdata, &_efastdata - &_sfastdata);

    // Zero out .bss and .fastbss sections
    memset(&_sbss, 0, &_ebss - &_sbss);
    memset(&_sfastbss, 0, &_efastbss - &_sfastbss);

    if (__FPU_PRESENT)
    {
        // CP10 and CP11 full access
        SCB->CPACR |= ((3UL << 10 * 2) |
                       (3UL << 11 * 2));
        __DSB();
        __ISB();
    }

    main();

    __builtin_trap();
}

void default_handler(void)
{
    while (true)
        ;
}
